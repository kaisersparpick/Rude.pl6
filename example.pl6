use v6;
use lib 'lib';

use CharacterIdentifier;
use Rude;

sub found { return Nil }

my $ci = CharacterIdentifier.new;
my $rude = Rude.new($ci);

$rude.add([:$ci, 'is-rebel'], [:$ci, 'is-prisoner'], &found);
$rude.add([:$ci, 'is-prisoner'], [:$ci, 'leia'], [:$ci, 'is-pilot']);
$rude.add([:$ci, 'is-pilot'], [:$ci, 'is-hairy'], [:$ci, 'is-from-tatooine']);
$rude.add([:$ci, 'is-hairy'], &found, &found);
$rude.add([:$ci, 'is-from-tatooine'], [:$ci, 'is-old'], &found);
$rude.add([:$ci, 'is-old']);
$rude.add([:$ci, 'leia']);
$rude.add(&found);

say 'Generating random results...';
say '======================================';

for 1..5 {
    say "--- #$_ ----------";
    $rude.check([:$ci, 'is-rebel']);
    say 'The result is: ' ~ $ci.result;
    say 'And the path was: ' ~ $rude.path;
}

say '======================================';
say 'Finished';
