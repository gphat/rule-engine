use strict;
use Test::More;

use Rule::Engine::Filter;
use Rule::Engine::Rule;
use Rule::Engine::RuleSet;
use Rule::Engine::Session;

use Tribble;

my $sess = Rule::Engine::Session->new;
$sess->set_environment('temperature', 65);

my $rs = Rule::Engine::RuleSet->new(
    name => 'find-happy-tribbles',
    filter => Rule::Engine::Filter->new(
        condition => sub {
            shift->happy ? 1 : 0
        }
    )
);

my $rule = Rule::Engine::Rule->new(
    name => 'temperature',
    action => sub {
        my ($env, $foo) = @_;
        $foo->happy(1);
    },
    condition => sub {
        my ($env, $foo) = @_;
        return $foo->favorite_temp == $sess->get_environment('temperature');
    }
);

$rs->add_rule($rule);

$sess->add_ruleset($rs->name, $rs);

cmp_ok($sess->ruleset_count, '==', 1, 'ruleset_count');

my $tribble = Tribble->new;
my $foo = $sess->execute('find-happy-tribbles', [ $tribble ]);

cmp_ok(scalar(@{ $foo }), '==', 1, 'got 1 happy tribble');

done_testing;