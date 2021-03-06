#!/usr/bin/perl
use strict;
use warnings;


# The special-ist tag in the world.
package WWW::Shopify::Liquid::Tag::For;
use base 'WWW::Shopify::Liquid::Tag::Enclosing';

sub min_arguments { return 1; }
sub max_arguments { return 1; }

sub verify {
	my ($self) = @_;
	die new WWW::Shopify::Liquid::Exception::Parser::Arguments($self, "Requires in operator to be part of loop.") unless
		$self->{arguments}->[0]->isa('WWW::Shopify::Liquid::Operator::In');
	die new WWW::Shopify::Liquid::Exception::Parser::Arguments($self, "Requires the opening variable of a loop to be a simple variable.") unless
		$self->{arguments}->[0]->{operands}->[0] && $self->{arguments}->[0]->{operands}->[0]->isa('WWW::Shopify::Liquid::Token::Variable') &&
		int(@{$self->{arguments}->[0]->{operands}->[0]->{core}}) == 1 && $self->{arguments}->[0]->{operands}->[0]->{core}->[0]->isa('WWW::Shopify::Liquid::Token::String');
}
sub inner_tags { return qw(else) }

use List::Util qw(min);
use Scalar::Util qw(looks_like_number blessed reftype);
use Clone qw(clone);



sub new { 
	my $package = shift;
	my $self = bless {
		line => shift,
		core => shift,
		arguments => shift,
		contents => undef,
		false_path => undef
	}, $package;
	$self->interpret_inner_tokens(@{$_[0]});
	return $self;
}

sub interpret_inner_tokens {
	my ($self, @tokens) = @_;
	# Comes in [for_path], [tag, other_path]...
	my $token = shift(@tokens);
	return undef unless $token;
	$self->{contents} = $token->[0];
	if (int(@tokens) > 0) {
		die new WWW::Shopify::Liquid::Exception::Parser($self, "else cannot be anywhere, except the end tag of the for statement.") if int(@tokens) > 1 || $tokens[0]->[0]->tag ne "else";
		$self->{false_path} = $tokens[0]->[1];
	}
}

sub render_loop {
	my ($self, $renderer, $hash, $op1, $op2, $start, $end, $arrayRef) = @_;
	
	my @array = @$arrayRef;
	my @texts = ();
	my $all_processed = 1;
	my $var = $op1->{core}->[0]->{core};
	my $content;
	
	if ($renderer->state && exists $renderer->state->{values}->{$self . "-1"}) {
		$start = $renderer->state->{values}->{$self . "-1"}->{index};
		@texts = @{$renderer->state->{values}->{$self . "-1"}->{texts}};
		delete $renderer->state->{values}->{$self . "-1"};

	}
	for ($start..$end) {
		$hash->{$var} = $array[$_];
		$hash->{forloop} = { 
			index => ($_+1), index0 => $_, first => $_ == 0, last => $_ == $#array,
			length => int(@array), rindex0 => (($#array - $_)), rindex => (($#array - $_) + 1),
		};
		eval {
			$content = $self->is_processed($self->{contents}) ? $self->{contents} : $self->{contents}->render($renderer, $hash);
		};
		if (my $exp = $@) {
			if (defined $exp && blessed($exp) && $exp->isa('WWW::Shopify::Liquid::Exception::Control')) {
				if ($exp->isa('WWW::Shopify::Liquid::Exception::Control::Pause')) {
					$exp->register_value($self . "-1", {
						index => $_,
						texts => \@texts
					});
					die $exp;
				} else {
					push(@texts, @{$exp->initial_render}) if $exp->initial_render && int(@{$exp->initial_render}) > 0;
					if ($exp->isa('WWW::Shopify::Liquid::Exception::Control::Break')) {
						last;
					} elsif ($exp->isa('WWW::Shopify::Liquid::Exception::Control::Continue')) {
						next;
					}
				}
			} else {
				die $exp;
			}
		}
		$all_processed = 0 if !$self->is_processed($content);
		push(@texts, $content);
	}
	
	return join('', grep { defined $_ } @texts) if $all_processed;
	return $self;
}

sub expand_concatenations {
	my ($self, $result) = @_;
	return blessed($result) && $result->isa('WWW::Shopify::Liquid::Operator::Concatenate') ? (map { $self->expand_concatenations($_) } @{$result->{operands}}) : ($result);
}

sub optimize_loop {
	my ($self, $optimizer, $hash, $op1, $op2, $start, $end, $arrayRef) = @_;
	
	my @array = @$arrayRef;
	
	# First step, we replace everything by a big concatenate.
	my @texts = ();
	
	my $var = $op1->{core}->[0]->{core};
	return '' if $start > $end;
	
	my @parts = map { 
		$hash->{$var} = $array[$_];
		$hash->{forloop} = { 
			index => ($_+1), index0 => $_, first => $_ == 0, last => $_ == $#array,
			length => int(@array), rindex0 => (($#array - $_) + 1),	rindex => (($#array - $_)),
		};
		my $result;
		eval {
			$result = $self->is_processed($self->{contents}) ? $self->{contents} : clone($self->{contents})->optimize($optimizer, $hash);
		};
		if (my $exp = $@) {
			if (defined $exp && blessed($exp) && $exp->isa('WWW::Shopify::Liquid::Exception::Control')) {
				push(@texts, @{$exp->initial_render}) if $exp->initial_render && int(@{$exp->initial_render}) > 0;
				if ($exp->isa('WWW::Shopify::Liquid::Exception::Control::Break')) {
					last;
				} elsif ($exp->isa('WWW::Shopify::Liquid::Exception::Control::Continue')) {
					next;
				}
			} else {
				die $exp;
			}
		}
		
		$self->expand_concatenations($result);				
	} ($start..$end);
	
	return $parts[0] if int(@parts) == 1;
	return $optimizer->optimize($hash, WWW::Shopify::Liquid::Operator::Concatenate->new($self->{line}, "", @parts));
}

# Called to expand the second operand in "in" argument list.
sub apply {
	my ($self, $hash, $operand) = @_;
	return [keys(%$operand)] if ref($operand) eq 'HASH';
	return $operand;
}

# Should eventually support loop unrolling.
sub process {
	my ($self, $hash, $action, $pipeline) = @_;
	my @args = @{$self->{arguments}};
	
	my ($op1, $op2) = @{$args[0]->{operands}};
	$op2 = $op2->$action($pipeline, $hash) if !$self->is_processed($op2);
	
	$self->{arguments}->[0]->{operands}->[1] = $op2 if $self->is_processed($op2) && $action eq 'optimize';
	if ($action eq "optimize" && !$self->is_processed($self->{contents})) {
		# Ensure that the loop variable is unset for at least the duration of the loop while we do an initial optimization.
		my $var = $op1->{core}->[0]->{core};
		delete $hash->{$var};
		# And, in fact, make sure that ALL variables that get set in the loop get unset here.
		for (grep { ref($_) eq 'WWW::Shopify::Liquid::Tag::Assign' } $self->{contents}->tokens) {
			next if int(@{$_->{arguments}->[0]->{operands}->[0]->{core}}) == 1 &&
				blessed($_->{arguments}->[0]->{operands}->[0]->{core}->[0]->{core}) &&
				$_->{arguments}->[0]->{operands}->[0]->{core}->[0]->{core}->isa('WWW::Shopify::Liquid::Token::String');
			delete $hash->{$_->{arguments}->[0]->{operands}->[0]->{core}->[0]->{core}};
		}
		$pipeline->push_conditional_state;
		$self->{contents} = $self->{contents}->optimize($pipeline, $hash);
		$pipeline->pop_conditional_state;
	}
	$op2 = $self->apply($hash, $op2);
	return $self if (!$self->is_processed($op2) && $action eq "optimize");
	return '' if (!$self->is_processed($op2) && $action eq "render");	
	return (defined $self->{false_path} ? $self->{false_path}->$action($pipeline, $hash) : '') if ref($op2) ne "ARRAY" || int(@$op2) == 0;
	die new WWW::Shopify::Liquid::Exception::Renderer::Arguments($self, "Requires an array in for loop.") unless ref($op2) eq "ARRAY";
	
	my @array = @$op2;
	my $limit = int(@array);
	my $offset = 0;
	
	
	my ($limit_arg) = grep { $_->isa('WWW::Shopify::Liquid::Token::Variable::Named') && $_->{name} eq "limit" } @args;
	my $limit_result = $limit_arg->$action($pipeline, $hash) if $limit_arg;
	return $self if !$self->is_processed($limit_result);
	$limit = $limit_result->{limit} if $limit_result && ref($limit_result) && ref($limit_result) eq 'HASH' && looks_like_number($limit_result->{limit});
	
	
	my ($offset_arg) = grep { $_->isa('WWW::Shopify::Liquid::Token::Variable::Named') && $_->{name} eq "offset" } @args;
	my $offset_result = $offset_arg->$action($pipeline, $hash) if $offset_arg;
	$offset = $offset_result->{offset} if $offset_result && ref($offset_result) && ref($offset_result) eq 'HASH' && looks_like_number($offset_result->{offset});
	
	my $dispatch = $action . "_loop";
	
	return $self->$dispatch($pipeline, $hash, $op1, $op2, $offset, min($#array, $limit+$offset-1), \@array);
}



1;