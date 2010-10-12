use Test::More;

use Rule::Engine::Filter;
use Rule::Engine::Rule;
use Rule::Engine::Session;

use Tribble;

my $sess = Rule::Engine::Session->new(
    filter => Rule::Engine::Filter->new(
        condition => sub {
            shift->happy ? 1 : 0
        }
    )
);
$sess->set_environment('temperature', 65);

my $rule = Rule::Engine::Rule->new(
    name => 'temperature',
    condition => sub {
        my ($env, $foo) = @_;
        $foo->happy(1) if $foo->favorite_temp == $sess->get_environment('temperature');
        return 0;
    }
);

$sess->add_rule($rule);

my $tribble = Tribble->new;

my $foo = $sess->execute([ $tribble ]);

cmp_ok(scalar(@{ $foo }), '==', 1, 'got 1');

done_testing;