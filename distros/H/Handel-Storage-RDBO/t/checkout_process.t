#!perl -wT
# $Id$
use strict;
use warnings;

BEGIN {
    use lib 't/lib';
    use Handel::Test;

    eval 'require DBD::SQLite';
    if($@) {
        plan skip_all => 'DBD::SQLite not installed';
    } else {
        plan tests => 69;
    };

    use_ok('Handel::Test::RDBO::Checkout');
    use_ok('Handel::Test::RDBO::Cart');
    use_ok('Handel::Test::RDBO::Order');
    use_ok('Handel::Constants', qw(:checkout :order));
    use_ok('Handel::Exception', ':try');
};


## This is a hack, but it works. :-)
my $schema = Handel::Test->init_schema(no_populate => 1);

&run('Handel::Test::RDBO::Checkout', 1);

sub run {
    my ($subclass, $dbsuffix) = @_;

    Handel::Test->populate_schema($schema, clear => 1);
    local $ENV{'HandelDBIDSN'} = $schema->dsn;


    ## test for Handel::Exception::Checkout where no order is loaded
    {
        try {
            local $ENV{'LANG'} = 'en';
            my $checkout = $subclass->new;

            $checkout->process;

            fail('no exception thrown');
        } catch Handel::Exception::Checkout with {
            pass('caught checkout exception');
            like(shift, qr/no order/i, 'no order found in message');
        } otherwise {
            fail('other exception caught');
        };
    };


    ## test for Handel::Exception::Argument when phases is not array reference
    ## or string
    {
        try {
            local $ENV{'LANG'} = 'en';
            my $checkout = $subclass->new;
            $checkout->process({'1234' => 1});

            fail('no exception thrown');
        } catch Handel::Exception::Argument with {
            pass('caught argument exception');
            like(shift, qr/not an array/i, 'not an array ref in message');
        } otherwise {
            fail('other exception caught');
        };
    };


    ## load test plugins and checkout setup/teardown
    {
        my $checkout = $subclass->new({
            order => '11111111-1111-1111-1111-111111111111',
            pluginpaths => 'Handel::TestPlugins, Handel::OtherTestPlugins',
            phases => [CHECKOUT_PHASE_INITIALIZE]
        });

        is($checkout->process, CHECKOUT_STATUS_OK, 'processed OK');

        foreach ($checkout->plugins) {
            ok($_->{'setup_called'}, 'setup was called');
            ok($_->{'handler_called'}, 'handler was called');
            ok($_->{'teardown_called'}, 'teardown was called');
        };
    };


    ## load test plugins and checkout setup/teardown using string phases
    {
        my $checkout = $subclass->new({
            order => '11111111-1111-1111-1111-111111111111',
            pluginpaths => 'Handel::TestPlugins, Handel::OtherTestPlugins'
        });

        is($checkout->process('CHECKOUT_PHASE_INITIALIZE'), CHECKOUT_STATUS_OK, 'processed OK');

        foreach ($checkout->plugins) {
            ok($_->{'setup_called'}, 'setup was called');
            ok($_->{'handler_called'}, 'handler was called');
            ok($_->{'teardown_called'}, 'teardown was called');
        };
    };


    ## load test plugins and checkout setup/teardown using array phases
    {
        my $checkout = $subclass->new({
            order => '11111111-1111-1111-1111-111111111111',
            pluginpaths => 'Handel::TestPlugins, Handel::OtherTestPlugins'
        });

        is($checkout->process([CHECKOUT_PHASE_INITIALIZE]), CHECKOUT_STATUS_OK, 'processed OK');

        foreach ($checkout->plugins) {
            ok($_->{'setup_called'}, 'setup was called');
            ok($_->{'handler_called'}, 'handler was called');
            ok($_->{'teardown_called'}, 'teardown was called');
        };
    };


    ## load test plugins and checkout but usin a bogus phase
    {
        my $checkout = $subclass->new({
            order => '11111111-1111-1111-1111-111111111111',
            pluginpaths => 'Handel::TestPlugins, Handel::OtherTestPlugins'
        });

        is($checkout->process([0]), CHECKOUT_STATUS_OK, 'processed OK');

        foreach ($checkout->plugins) {
            ok($_->{'setup_called'}, 'setup was called');
            ok(!$_->{'handler_called'}, 'handler was called');
            ok($_->{'teardown_called'}, 'teardown was called');;
        };
    };


    ## Run a successful test pipeline
    {
        my $order = $subclass->order_class->create({
            shopper => '00000000-0000-0000-0000-000000000000'
        });
            $order->add({
                sku      => 'SKU1',
                quantity => 1,
                price    => 1.11
            });
            my $item = $order->add({
                sku      => 'SKU2',
                quantity => 2,
                price    => 2.22
            });

        my $checkout = $subclass->new({
            pluginpaths => 'Handel::TestPipeline',
            loadplugins => 'Handel::TestPipeline::InitializeTotals',
            phases      => CHECKOUT_ALL_PHASES,
            order       => $order
        });

        is($checkout->process, CHECKOUT_STATUS_OK, 'processed OK');

        my $items = $order->items;
        cmp_currency($order->subtotal+0, 5.55, 'subtotal is 5.55');
        cmp_currency($items->first->total+0, 1.11, 'total is 1.11');
        $items->next;
        cmp_currency($items->next->total+0, 4.44, 'total is 4.44');

        my @messages = $checkout->messages;
        is(scalar @messages, 0, 'has no messages');
    };


    ## Run a successful test pipeline usin default phases
    {
        my $order = $subclass->order_class->create({
            shopper => '00000000-0000-0000-0000-000000000000'
        });
            $order->add({
                sku      => 'SKU1',
                quantity => 1,
                price    => 1.11
            });
            $order->add({
                sku      => 'SKU2',
                quantity => 2,
                price    => 2.22
            });

        my $checkout = $subclass->new({
            pluginpaths => 'Handel::TestPipeline',
            loadplugins => 'Handel::TestPipeline::InitializeTotals',
            order       => $order
        });
        is($checkout->process, CHECKOUT_STATUS_OK, 'processed OK');

        my $items = $order->items;
        cmp_currency($order->subtotal+0, 0, 'subtotal is 0');
        cmp_currency($items->first->total+0, 0, 'total is 0');
        $items->next;
        cmp_currency($items->next->total+0, 0, 'total is 0');

        my @messages = $checkout->messages;
        is(scalar @messages, 0, 'has no messages');
    };


    ## Run a successful test pipeline using the stock plugins
    {
        my $order = $subclass->order_class->create({
            shopper => '00000000-0000-0000-0000-000000000000'
        });
            $order->add({
                sku      => 'SKU1',
                quantity => 1,
                price    => 1.11
            });
            $order->add({
                sku      => 'SKU2',
                quantity => 2,
                price    => 2.22
            });

        is($order->type, ORDER_TYPE_TEMP, 'order is temp');
        is($order->number, undef, 'number is not set');

        my $checkout = $subclass->new({
            phases      => CHECKOUT_ALL_PHASES,
            order       => $order,
            loadplugins => 'Handel::Checkout::Plugin::AssignOrderNumber, Handel::Checkout::Plugin::MarkOrderSaved'
        });

        is($checkout->process, CHECKOUT_STATUS_OK, 'processed OK');

        is($checkout->order->type, ORDER_TYPE_SAVED, 'order was marked saved');
        ok($checkout->order->number, 'number was set');

        my @messages = $checkout->messages;
        is(scalar @messages, 0, 'no error messages');
    };


    ## Run a failing test pipeline
    {
        $subclass->order_class->_set_storage(undef);
        my $order = $subclass->order_class->create({
            shopper => '00000000-0000-0000-0000-000000000000',
            billtofirstname => 'BillToFirstName',
            billtolastname  => 'BillToLastName'
        });
            $order->add({
                sku      => 'SKU1',
                quantity => 1,
                price    => 1.11
            });
            $order->add({
                sku      => 'SKU2',
                quantity => 2,
                price    => 2.22
            });

        my $checkout = $subclass->new({
            pluginpaths => 'Handel::TestPipeline',
            loadplugins => ['Handel::TestPipeline::InitializeTotals',
                            'Handel::TestPipeline::ValidateError'
                           ],
            phases      => CHECKOUT_ALL_PHASES,
            order       => $order
        });

        is($checkout->process, CHECKOUT_STATUS_ERROR, 'processed ERROR');

        is($checkout->order->billtofirstname, 'BillToFirstName', 'first name unchanged');
        is($checkout->order->billtolastname, 'BillToLastName', 'last name unchanged');

        my $items = $order->items;
        cmp_currency($order->subtotal+0, 0, 'subtotal is 0');
        is($items->first->sku, 'SKU1', 'sku1 is unchanged');
        $items->next;
        is($items->next->sku, 'SKU2', 'sku2 is unchanged');

        my @messages = $checkout->messages;
        is(scalar @messages, 1, 'has 1 message');
        ok($messages[0] =~ /ValidateError/, 'message is validate error');
    };


    ## Check stash writes and lifetime
    {
        my $order = $subclass->order_class->create({
            shopper => '00000000-0000-0000-0000-000000000000'
        });
            $order->add({
                sku      => 'SKU1',
                quantity => 1,
                price    => 1.11
            });
            $order->add({
                sku      => 'SKU2',
                quantity => 2,
                price    => 2.22
            });

        my $checkout = $subclass->new({
            pluginpaths => 'Handel::TestPipeline',
            loadplugins => ['Handel::TestPipeline::WriteToStash',
                            'Handel::TestPipeline::ReadFromStash'],
            phases      => CHECKOUT_ALL_PHASES,
            order       => $order
        });

        is($checkout->process, CHECKOUT_STATUS_OK, 'processed OK');
        is($checkout->stash->{'WriteToStash'}, 'WrittenToStash', 'stash variable set');

        my %plugins = map { ref $_ => $_ } $checkout->plugins;
        is(scalar keys %plugins, 2, 'has 2 plugins');
        ok(exists $plugins{'Handel::TestPipeline::ReadFromStash'}, 'stash plugin loaded');
        is($plugins{'Handel::TestPipeline::ReadFromStash'}->{'ReadFromStash'}, 'WrittenToStash', 'stash written to');

        my @messages = $checkout->messages;
        is(scalar @messages, 0, 'has no messages');
    };
};


## Run a failing test pipeline with a rollback failure
{
    Handel::Test->populate_schema($schema, clear => 1);
    local $ENV{'HandelDBIDSN'} = $schema->dsn;

    my $order = Handel::Test::RDBO::Order->create({
        shopper => '00000000-0000-0000-0000-000000000000',
        billtofirstname => 'BillToFirstName',
        billtolastname  => 'BillToLastName'
    });
        $order->add({
            sku      => 'SKU1',
            quantity => 1,
            price    => 1.11
        });
        $order->add({
            sku      => 'SKU2',
            quantity => 2,
            price    => 2.22
        });

    my $checkout = Handel::Test::RDBO::Checkout->new({
        pluginpaths => 'Handel::TestPipeline',
        loadplugins => ['Handel::TestPipeline::InitializeTotals',
                        'Handel::TestPipeline::ValidateError'
                       ],
        phases      => CHECKOUT_ALL_PHASES,
        order       => $order
    });

    no warnings qw/once redefine/;
    local *Handel::Storage::RDBO::Result::txn_rollback = sub {
        die 'boom!';
    };


    try {
        local $ENV{'LANG'} = 'en';
        $checkout->process;

        fail('no exception thrown');
    } catch Handel::Exception::Checkout with {
        pass('Handel::Exception::Checkout caught');
        like(shift, qr/rollback/i, 'rollback in message');
    } otherwise {
        fail('other exception caught');
    };
};
