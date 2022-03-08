use v6;

use Test;
use Pod::To::PDF::API6;
use PDF::Tags;
use PDF::API6;

plan 1;

my $xml = q{<Document>
  <Sect>
    <H>
      Class Magician
    </H>
    <P>
      Base class for magicians
    </P>
    <P>
      <Code>class Magician</Code>
    </P>
  </Sect>
  <Sect>
    <H>
      Sub duel
    </H>
    <P>
      Fight mechanics
    </P>
    <P>
      <Code>sub duel(
    Magician $a,
    Magician $b,
)</Code>
    </P>
    <P>
      Magicians only, no mortals.
    </P>
  </Sect>
</Document>
};

my Pod::To::PDF::API6 $doc .= new: :$=pod;
my PDF::API6 $pdf = $doc.pdf;
$pdf.id = $*PROGRAM-NAME.fmt('%-16.16s');
$pdf.save-as: "t/declarator.pdf", :!info;
my PDF::Tags $tags = $doc.tags;

is $tags[0].Str, $xml,
   'Declarators convert correctly.';

=comment Example taken from docs.raku.org/language/pod#Declarator_blocks

#| Base class for magicians 
class Magician {
  has Int $.level;
  has Str @.spells;
}
 
#| Fight mechanics 
sub duel(Magician $a, Magician $b) {
}
#= Magicians only, no mortals. 

