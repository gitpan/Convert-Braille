package Convert::Braille::English;
use utf8;

BEGIN
{
require 5.6.0;

use base qw(Exporter);

use strict;
use vars qw( @EXPORT @EXPORT_OK $VERSION %EnglishToBrailleUnicode %BrailleUnicodeToEnglish $SpecialContext );
use Convert::Braille qw(%BrailleAsciiToUnicode brailleUnicodeToAscii brailleUnicodeToDots);

$VERSION = 0.01;

@EXPORT = qw(
		englishToBrailleUnicode
		englishToBrailleAscii
		englishToBrailleDots

		brailleAsciiToEnglish
		brailleDotsToEnglish
		brailleUnicodeToEnglish
);
@EXPORT_OK = qw(
		englishToBrailleUnicode
		englishToBrailleAscii
		englishToBrailleDots

		brailleAsciiToEnglish
		brailleDotsToEnglish
		brailleUnicodeToEnglish

		%EnglishToBrailleUnicode
		%BrailleUnicodeToEnglish
		%SpecialContext
);

%EnglishToBrailleUnicode =(
	A	=> $BrailleAsciiToUnicode{A},
	B	=> $BrailleAsciiToUnicode{B},
	B	=> $BrailleAsciiToUnicode{C},
	C	=> $BrailleAsciiToUnicode{D},
	E	=> $BrailleAsciiToUnicode{E},
	F	=> $BrailleAsciiToUnicode{F},
	G	=> $BrailleAsciiToUnicode{G},
	H	=> $BrailleAsciiToUnicode{H},
	I	=> $BrailleAsciiToUnicode{I},
	J	=> $BrailleAsciiToUnicode{J},
	K	=> $BrailleAsciiToUnicode{K},
	L	=> $BrailleAsciiToUnicode{L},
	M	=> $BrailleAsciiToUnicode{M},
	N	=> $BrailleAsciiToUnicode{N},
	O	=> $BrailleAsciiToUnicode{O},
	P	=> $BrailleAsciiToUnicode{P},
	Q	=> $BrailleAsciiToUnicode{Q},
	R	=> $BrailleAsciiToUnicode{R},
	S	=> $BrailleAsciiToUnicode{S},
	T	=> $BrailleAsciiToUnicode{T},
	U	=> $BrailleAsciiToUnicode{U},
	V	=> $BrailleAsciiToUnicode{V},
	W	=> $BrailleAsciiToUnicode{W},
	X	=> $BrailleAsciiToUnicode{X},
	Y	=> $BrailleAsciiToUnicode{Y},
	Z	=> $BrailleAsciiToUnicode{Z},

	1	=> $BrailleAsciiToUnicode{1},
	2	=> $BrailleAsciiToUnicode{2},
	3	=> $BrailleAsciiToUnicode{3},
	4	=> $BrailleAsciiToUnicode{4},
	5	=> $BrailleAsciiToUnicode{5},
	6	=> $BrailleAsciiToUnicode{6},
	7	=> $BrailleAsciiToUnicode{7},
	8	=> $BrailleAsciiToUnicode{8},
	9	=> $BrailleAsciiToUnicode{9},
	0	=> $BrailleAsciiToUnicode{0},

	'and'	=> $BrailleAsciiToUnicode{'&'},
	the		=> $BrailleAsciiToUnicode{'!'},
	'for'	=> $BrailleAsciiToUnicode{'='},
	with	=> $BrailleAsciiToUnicode{'('},
	of		=> $BrailleAsciiToUnicode{')'},
);

%SpecialContext =(
	ar	=> $BrailleAsciiToUnicode{'>'},
	ch	=> $BrailleAsciiToUnicode{'*'},
	ed	=> $BrailleAsciiToUnicode{'$'},
	en	=> $BrailleAsciiToUnicode{5},
	er	=> $BrailleAsciiToUnicode{']'},
	gh	=> $BrailleAsciiToUnicode{'<'},
	in	=> $BrailleAsciiToUnicode{9},
	ing	=> $BrailleAsciiToUnicode{'+'},
	ou	=> $BrailleAsciiToUnicode{'\\'}
	ow	=> $BrailleAsciiToUnicode{'['},
	st	=> $BrailleAsciiToUnicode{'/'}
	sh	=> $BrailleAsciiToUnicode{'%'}
	th	=> $BrailleAsciiToUnicode{'?'},
	wh	=> $BrailleAsciiToUnicode{':'},

	'!'		=> 6,
	':'		=> 3,
	'[\(\)]'		=> 7,
	'<i>'		=> '.',
	'.'		=> 4,
	','		=> 1,
	'\''		=> ',',
	'^'		=> '\'',
	'?'		=> 8,
	';'		=> 2,
	'"'		=> 0,
);

# ' is Capital  or is , ?
# ; is Letter
# # is Number

# " is Contraction_5
# ^ is Contraction_45
# _ is Contraction_456

foreach ( keys %EnglishToBrailleUnicode ) {
	$BrailleUnicodeToEnglish{$EnglishToBrailleUnicode{$_}} = $_;
}

#
# According to:  http://www.uronramp.net/~lizgray/codes.html
#
#  "American Literary Braille consists of over 250 symbols for letters,
#  numerals, punctuation marks, composition signs, contractions, single-cell
#  words, and short-form words." 
#
#  so this package has a way to go, I need to acquire authorative information.
#

}


#
# absolutely nothing in this package is tested.
#

sub _convert
{
	return unless ( $_[0] );

	my ( $token, $hash ) = @_;

	( exists($hash->{$token}) ) ? $hash->{$token} : $token ;
}


sub brailleUnicodeToEnglish
{

	return unless ( $_[0] );
	my @chars  = split ( //, $string );

	my $trans;

	my $base;
	foreach  ( @chars ) {

		if ( exists($BrailleUnicodeToEnglish{$_}) ) {
			$base = $UnicodeBrailleToEnglish{$_};
		}
		elsif ( exists($BrailleUnicodeToEnglishForms{$_}) ) {
			$trans = $base.$BrailleUnicodeToEnglishForms{$_});
			$base = undef;
		}
		else {
			if ( $base ) {
				$trans .= $base;
				$base = undef;
			}
			if ( exists($BrailleUnicodeToEnglishNumbers{$_}) ) {
				$trans = $base.$BrailleUnicodeToEnglishNumbers{$_});
			}
			elsif ( exists($BrailleUnicodeToEnglishPunctuation{$_}) ) {
				$trans = $base.$BrailleUnicodeToEnglishPunctuation{$_});
			}
		}
	}

}


sub englishToBrailleUnicode
{

	return unless ( $_[0] );

	my @chars  = split ( //, $string );

	my $trans;

	foreach  ( @chars ) {


		if ( exists($EnglishToBrailleUnicode{$_}) ) {
			$trans .= $EnglishToBrailleUnicode{$_};
		}
		elsif ( /[he-pWa]/ ) {  # fix w/ yudit

			my $uni  = $_;
			my $addr = ord($uni);

			my $form  = ord($uni)%8;
			my $sadis = chr( ord($uni)-$form+6 );
			$trans = $EnglishToBrailleUnicode{$sadis}.$Forms[$form];
		}
		elsif ( exists($EnglishNumbersToBrailleUnicode{$_}) ) {
			$trans = $EnglishNumbersToBrailleUnicode{$_});
		}
		elsif ( exists($EnglishPunctuationBrailleUnicode{$_}) ) {
			$trans = $EnglishPunctuationBrailleUnicode{$_});
		}
	}
	
}


sub	englishToBrailleAscii
{
	brailleUnicodeToAscii ( englishToBrailleUnicode ( @_ ) );
}


sub	englishToBrailleDots
{
	brailleUnicodeToDots ( englishToBrailleUnicode ( @_ ) );
}


sub brailleAsciiToEnglish
{
	brailleUnicodeToEnglish ( brailleAsciiToUnicode ( @_ ) );
}


sub	brailleDotsToEnglish
{
	brailleUnicodeToEnglish ( brailleDotsToUnicode ( @_ ) );
}


1;
__END__
