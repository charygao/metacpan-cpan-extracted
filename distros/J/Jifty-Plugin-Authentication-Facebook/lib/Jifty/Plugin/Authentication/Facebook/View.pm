use warnings;
use strict;
package Jifty::Plugin::Authentication::Facebook::View;

use Jifty::View::Declare -base;

=head1 NAME

Jifty::Plugin::Authentication::Facebook::View - Facebook login fragment

=head1 DESCRIPTION

Provides the Facebook login fragment for L<Jifty::Plugin::Authentication::Facebook>

=head2 /facebook/login

This fragment shows the standard Facebook button used for web login.

=cut

template '/facebook/login' => sub {
    my ($plugin) = Jifty->find_plugin('Jifty::Plugin::Authentication::Facebook');
    div {{ id is 'facebook_login' };
        span { _("Login to Facebook now to get started!") };
        a {{ href is $plugin->get_login_url };
            img {{ src is 'http://static.ak.facebook.com/images/devsite/facebook_login.gif', border is '0' }};
        };
    };
};

=head2 /facebook/link

This fragment shows the standard Facebook login button, prompting the user to
link his account.

=cut

template '/facebook/link' => sub {
    my ($plugin) = Jifty->find_plugin('Jifty::Plugin::Authentication::Facebook');
    div {{ id is 'facebook_link' };
        span { _("Login to Facebook now to link it with your current account!") };
        a {{ href is $plugin->get_link_url };
            img {{ src is 'http://static.ak.facebook.com/images/devsite/facebook_login.gif', border is '0' }};
        };
    };
};


1;
