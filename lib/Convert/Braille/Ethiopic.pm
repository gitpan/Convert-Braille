package Convert::Braille::Ethiopic;
use utf8;

BEGIN
{
require 5.6.0;

use base qw(Exporter);

use strict;
use vars qw( @EXPORT @EXPORT_OK $VERSION
			 %EthiopicToBrailleUnicode %BrailleUnicodeToEthiopic
			 %EthiopicNumeralsToBrailleUnicode %BrailleUnicodeToEthiopicNumerals
			 %EthiopicPunctuationToBrailleUnicode %BrailleUnicodeToEthiopicPunctuation
			 @EthiopicForms %EthiopicForms
	 		);
use Convert::Braille qw(%BrailleAsciiToUnicode brailleUnicodeToAscii brailleUnicodeToDots);

$VERSION = 0.02;

@EXPORT = qw(
		ethiopicToBrailleUnicode
		ethiopicToBrailleAscii
		ethiopicToBrailleDots

		brailleAsciiToEthiopic
		brailleDotsToEthiopic
		brailleUnicodeToEthiopic
);
@EXPORT_OK = qw(
		ethiopicToBrailleUnicode
		ethiopicToBrailleAscii
		ethiopicToBrailleDots

		brailleAsciiToEthiopic
		brailleDotsToEthiopic
		brailleUnicodeToEthiopic

		%EthiopicToBrailleUnicode %BrailleUnicodeToEthiopic
		%EthiopicNumeralsToBrailleUnicode %BrailleUnicodeToEthiopicNumerals
		%EthiopicPunctuationToBrailleUnicode %BrailleUnicodeToEthiopicPunctuation
		@EthiopicForms
);

%EthiopicToBrailleUnicode =(
	ህ	=> $BrailleAsciiToUnicode{H},
	ል	=> $BrailleAsciiToUnicode{L},
	ሕ	=> $BrailleAsciiToUnicode{H},
	ም	=> $BrailleAsciiToUnicode{M},
	ሥ	=> $BrailleAsciiToUnicode{S},
	ር	=> $BrailleAsciiToUnicode{R},
	ስ	=> $BrailleAsciiToUnicode{S},
	ሽ	=> $BrailleAsciiToUnicode{'%'},
	ቅ	=> $BrailleAsciiToUnicode{Q},
	ቍ	=> "$BrailleAsciiToUnicode{Q}$BrailleAsciiToUnicode{W}",
	ቕ	=> $BrailleAsciiToUnicode{Q},
	ቝ	=> "$BrailleAsciiToUnicode{Q}$BrailleAsciiToUnicode{W}",
	ብ	=> $BrailleAsciiToUnicode{B},
	ቭ	=> $BrailleAsciiToUnicode{V},
	ት	=> $BrailleAsciiToUnicode{T},
	ች	=> $BrailleAsciiToUnicode{'*'},
	ኅ	=> $BrailleAsciiToUnicode{H},
	ኍ	=> "$BrailleAsciiToUnicode{H}$BrailleAsciiToUnicode{W}",
	ን	=> $BrailleAsciiToUnicode{N},
	ኝ	=> $BrailleAsciiToUnicode{'+'},
	እ	=> $BrailleAsciiToUnicode{'('},
	ክ	=> $BrailleAsciiToUnicode{K},
	ኵ	=> "$BrailleAsciiToUnicode{K}$BrailleAsciiToUnicode{W}",
	ኽ	=> $BrailleAsciiToUnicode{8},
	ዅ	=> "$BrailleAsciiToUnicode{8}$BrailleAsciiToUnicode{W}",
	ው	=> $BrailleAsciiToUnicode{W},
	ዕ	=> $BrailleAsciiToUnicode{'('},
	ዝ	=> $BrailleAsciiToUnicode{Z},
	ዥ	=> $BrailleAsciiToUnicode{0},
	ይ	=> $BrailleAsciiToUnicode{Y},
	ድ	=> $BrailleAsciiToUnicode{D},
	ዽ	=> $BrailleAsciiToUnicode{D},
	ጅ	=> $BrailleAsciiToUnicode{J},
	ግ	=> $BrailleAsciiToUnicode{G},
	ጕ	=> "$BrailleAsciiToUnicode{G}$BrailleAsciiToUnicode{W}",
	ጝ	=> $BrailleAsciiToUnicode{G},
	ጥ	=> $BrailleAsciiToUnicode{')'},
	ጭ	=> $BrailleAsciiToUnicode{C},
	ጵ	=> $BrailleAsciiToUnicode{6},
	ጽ	=> $BrailleAsciiToUnicode{'&'},
	ፅ	=> $BrailleAsciiToUnicode{'&'},
	ፍ	=> $BrailleAsciiToUnicode{F},
	ፕ	=> $BrailleAsciiToUnicode{P},
	ፘ	=> "$BrailleAsciiToUnicode{R}$BrailleAsciiToUnicode{Y}$BrailleAsciiToUnicode{A}",
	ፙ	=> "$BrailleAsciiToUnicode{M}$BrailleAsciiToUnicode{Y}$BrailleAsciiToUnicode{A}",
	ፚ	=> "$BrailleAsciiToUnicode{F}$BrailleAsciiToUnicode{Y}$BrailleAsciiToUnicode{A}"
);


foreach ( sort keys %EthiopicToBrailleUnicode ) {
	next if ( exists($BrailleUnicodeToEthiopic{$EthiopicToBrailleUnicode{$_}}) );
	$BrailleUnicodeToEthiopic{$EthiopicToBrailleUnicode{$_}} = $_;
}


@EthiopicForms = ( 
	$BrailleAsciiToUnicode{5},
	$BrailleAsciiToUnicode{U},
	$BrailleAsciiToUnicode{I},
	$BrailleAsciiToUnicode{A},
	$BrailleAsciiToUnicode{E},
	"",
	$BrailleAsciiToUnicode{O},
);
%EthiopicForms = ( 
	$BrailleAsciiToUnicode{5} => -5,
	$BrailleAsciiToUnicode{U} => -4,
	$BrailleAsciiToUnicode{I} => -3,
	$BrailleAsciiToUnicode{A} => -2,
	$BrailleAsciiToUnicode{E} => -1,
	$BrailleAsciiToUnicode{O} => 1
);

%EthiopicNumeralsToBrailleUnicode = (
	'፩'	=> $BrailleAsciiToUnicode{1},
	'፪'	=> $BrailleAsciiToUnicode{2},
	'፫'	=> $BrailleAsciiToUnicode{3},
	'፬'	=> $BrailleAsciiToUnicode{4},
	'፭'	=> $BrailleAsciiToUnicode{5},
	'፮'	=> $BrailleAsciiToUnicode{6},
	'፯'	=> $BrailleAsciiToUnicode{7},
	'፰'	=> $BrailleAsciiToUnicode{8},
	'፱'	=> $BrailleAsciiToUnicode{9},
	'፲'	=> "$BrailleAsciiToUnicode{1}$BrailleAsciiToUnicode{0}",
	'፳'	=> "$BrailleAsciiToUnicode{2}$BrailleAsciiToUnicode{0}",
	'፴'	=> "$BrailleAsciiToUnicode{3}$BrailleAsciiToUnicode{0}",
	'፵'	=> "$BrailleAsciiToUnicode{4}$BrailleAsciiToUnicode{0}",
	'፶'	=> "$BrailleAsciiToUnicode{5}$BrailleAsciiToUnicode{0}",
	'፷'	=> "$BrailleAsciiToUnicode{6}$BrailleAsciiToUnicode{0}",
	'፸'	=> "$BrailleAsciiToUnicode{7}$BrailleAsciiToUnicode{0}",
	'፹'	=> "$BrailleAsciiToUnicode{8}$BrailleAsciiToUnicode{0}",
	'፺'	=> "$BrailleAsciiToUnicode{9}$BrailleAsciiToUnicode{0}",
	'፻'	=> "$BrailleAsciiToUnicode{1}$BrailleAsciiToUnicode{0}$BrailleAsciiToUnicode{0}",
	'፼'	=> "$BrailleAsciiToUnicode{1}$BrailleAsciiToUnicode{0}$BrailleAsciiToUnicode{0}$BrailleAsciiToUnicode{0}$BrailleAsciiToUnicode{0}"
);


foreach ( keys %EthiopicNumeralsToBrailleUnicode ) {
	$BrailleUnicodeToEthiopicNumerals{$EthiopicNumeralsToBrailleUnicode{$_}} = $_;
}


%EthiopicPunctuationToBrailleUnicode = (
	'፡'	=> $BrailleAsciiToUnicode{2},
	'።'	=> $BrailleAsciiToUnicode{4},
	'፣'	=> $BrailleAsciiToUnicode{1},
	'፤'	=> $BrailleAsciiToUnicode{1},  # undefined in ethiopic
	'፥'	=> $BrailleAsciiToUnicode{1},  # undefined in ethiopic
	'፦'	=> $BrailleAsciiToUnicode{1},  # undefined in ethiopic
	'፧'	=> $BrailleAsciiToUnicode{8},  # undefined in ethiopic
	'፩'	=> " ",
);


foreach ( keys %EthiopicPunctuationToBrailleUnicode ) {
	next if ( exists($BrailleUnicodeToEthiopicPunctuation{$EthiopicPunctuationToBrailleUnicode{$_}}) );
	$BrailleUnicodeToEthiopicPunctuation{$EthiopicPunctuationToBrailleUnicode{$_}} = $_;
}


}


sub brailleUnicodeToEthiopic
{

	return unless ( $_[0] );
	my @chars  = split ( //, $_[0] );

	my $trans;

	my $base;
	foreach  ( @chars ) {

		if ( exists($BrailleUnicodeToEthiopic{$_}) ) {
			$base = $BrailleUnicodeToEthiopic{$_};
		}
		elsif ( exists($EthiopicForms{$_}) ) {
			$trans .= chr(ord($base)+$EthiopicForms{$_});
			$base = undef;
		}
		else {
			if ( $base ) {
				$trans .= $base;
				$base = undef;
			}
			if ( exists($BrailleUnicodeToEthiopicNumerals{$_}) ) {
				$trans .= $base.$BrailleUnicodeToEthiopicNumerals{$_};
			}
			elsif ( exists($BrailleUnicodeToEthiopicPunctuation{$_}) ) {
				$trans .= $base.$BrailleUnicodeToEthiopicPunctuation{$_};
			}
		}
	}

	$trans .= $base if ( $base );
	$trans;
}


sub ethiopicToBrailleUnicode
{

	return unless ( $_[0] );

	my @chars  = split ( //, $_[0] );

	my $trans;

	foreach  ( @chars ) {

		if ( exists($EthiopicToBrailleUnicode{$_}) ) {
			$trans .= $EthiopicToBrailleUnicode{$_};
		}
		elsif ( /[ሀ-ፗ]/ ) {
			my $uni  = $_;
			my $addr = ord($uni);

			my $form  = ord($uni)%8;
			my $sadis = chr( ord($uni)-$form+5 );
			$trans .= $EthiopicToBrailleUnicode{$sadis}.$EthiopicForms[$form];
		}
		elsif ( /[፡-፨]/ ) {
			$trans .= "$EthiopicPunctuationToBrailleUnicode{$_}";
		}
		elsif ( /[፩-፼]/ ) {
			#
			# this is a cheesy hack for now, proper numeral system conversion
			# will be added in the next version
			#
			$trans .= "$BrailleAsciiToUnicode{'#'}$EthiopicNumeralsToBrailleUnicode{$_}";
		}
		else {
			#	
			#  anything else should convert as per english rules (including
			#  guillemts => " ), do so when english module is ready	
			#	
			$trans .= $_;
		}
	}

	$trans;
}


sub	ethiopicToBrailleAscii
{
	brailleUnicodeToAscii ( ethiopicToBrailleUnicode ( @_ ) );
}


sub	ethiopicToBrailleDots
{
	brailleUnicodeToDots ( ethiopicToBrailleUnicode ( @_ ) );
}


sub brailleAsciiToEthiopic
{
	brailleUnicodeToEthiopic ( brailleAsciiToUnicode ( @_ ) );
}


sub	brailleDotsToEthiopic
{
	brailleUnicodeToEthiopic ( brailleDotsToUnicode ( @_ ) );
}


1;
__END__
