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
			 @EthiopicForms
	 		);
use Convert::Braille qw(%BrailleAsciiToUnicode brailleUnicodeToAscii brailleUnicodeToDots);

$VERSION = 0.01;

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
	chr(0x1205)	=> $BrailleAsciiToUnicode{H}, 
	chr(0x120d)	=> $BrailleAsciiToUnicode{L},
	chr(0x1215)	=> $BrailleAsciiToUnicode{H},
	chr(0x121d)	=> $BrailleAsciiToUnicode{M},
	chr(0x1225)	=> $BrailleAsciiToUnicode{S},
	chr(0x122d)	=> $BrailleAsciiToUnicode{R},
	chr(0x1235)	=> $BrailleAsciiToUnicode{S},
	chr(0x123d)	=> $BrailleAsciiToUnicode{'%'},
	chr(0x1245)	=> $BrailleAsciiToUnicode{Q},
	chr(0x124d)	=> "$BrailleAsciiToUnicode{Q}$BrailleAsciiToUnicode{W}",
	chr(0x1255)	=> $BrailleAsciiToUnicode{Q},
	chr(0x125d)	=> "$BrailleAsciiToUnicode{Q}$BrailleAsciiToUnicode{W}",
	chr(0x1265)	=> $BrailleAsciiToUnicode{B},
	chr(0x126d)	=> $BrailleAsciiToUnicode{V},
	chr(0x1275)	=> $BrailleAsciiToUnicode{T},
	chr(0x127d)	=> $BrailleAsciiToUnicode{'*'},
	chr(0x1285)	=> $BrailleAsciiToUnicode{H},
	chr(0x128d)	=> "$BrailleAsciiToUnicode{H}$BrailleAsciiToUnicode{W}",
	chr(0x1295)	=> $BrailleAsciiToUnicode{N},
	chr(0x129d)	=> $BrailleAsciiToUnicode{'+'},
	chr(0x12a5)	=> $BrailleAsciiToUnicode{'('},
	chr(0x12ad)	=> $BrailleAsciiToUnicode{K},
	chr(0x12b5)	=> "$BrailleAsciiToUnicode{K}$BrailleAsciiToUnicode{W}",
	chr(0x12bd)	=> $BrailleAsciiToUnicode{8},
	chr(0x12c5)	=> "$BrailleAsciiToUnicode{8}$BrailleAsciiToUnicode{W}",
	chr(0x12cd)	=> $BrailleAsciiToUnicode{W},
	chr(0x12d5)	=> $BrailleAsciiToUnicode{'('},
	chr(0x12dd)	=> $BrailleAsciiToUnicode{Z},
	chr(0x12e5)	=> $BrailleAsciiToUnicode{0},
	chr(0x12ed)	=> $BrailleAsciiToUnicode{Y},
	chr(0x12f5)	=> $BrailleAsciiToUnicode{D},
	chr(0x12fd)	=> $BrailleAsciiToUnicode{D},
	chr(0x1305)	=> $BrailleAsciiToUnicode{J},
	chr(0x130d)	=> $BrailleAsciiToUnicode{G},
	chr(0x1315)	=> "$BrailleAsciiToUnicode{G}$BrailleAsciiToUnicode{W}",
	chr(0x131d)	=> $BrailleAsciiToUnicode{G},
	chr(0x1325)	=> $BrailleAsciiToUnicode{')'},
	chr(0x132d)	=> $BrailleAsciiToUnicode{C},
	chr(0x1335)	=> $BrailleAsciiToUnicode{6},
	chr(0x133d)	=> $BrailleAsciiToUnicode{'&'},
	chr(0x1345)	=> $BrailleAsciiToUnicode{'&'},
	chr(0x134d)	=> $BrailleAsciiToUnicode{F},
	chr(0x1355)	=> $BrailleAsciiToUnicode{P},
	chr(0x1358)	=> "$BrailleAsciiToUnicode{R}$BrailleAsciiToUnicode{Y}$BrailleAsciiToUnicode{A}",
	chr(0x1359)	=> "$BrailleAsciiToUnicode{M}$BrailleAsciiToUnicode{Y}$BrailleAsciiToUnicode{A}",
	chr(0x135a)	=> "$BrailleAsciiToUnicode{F}$BrailleAsciiToUnicode{Y}$BrailleAsciiToUnicode{A}"
);


foreach ( keys %EthiopicToBrailleUnicode ) {
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

%EthiopicNumeralsToBrailleUnicode = (
	chr(0x1369)	=> $BrailleAsciiToUnicode{1},
	chr(0x136a)	=> $BrailleAsciiToUnicode{2},
	chr(0x136b)	=> $BrailleAsciiToUnicode{3},
	chr(0x136c)	=> $BrailleAsciiToUnicode{4},
	chr(0x136d)	=> $BrailleAsciiToUnicode{5},
	chr(0x136e)	=> $BrailleAsciiToUnicode{6},
	chr(0x136f)	=> $BrailleAsciiToUnicode{7},
	chr(0x1370)	=> $BrailleAsciiToUnicode{8},
	chr(0x1371)	=> $BrailleAsciiToUnicode{9},
	chr(0x1372)	=> "$BrailleAsciiToUnicode{1}$BrailleAsciiToUnicode{0}",
	chr(0x1373)	=> "$BrailleAsciiToUnicode{2}$BrailleAsciiToUnicode{0}",
	chr(0x1374)	=> "$BrailleAsciiToUnicode{3}$BrailleAsciiToUnicode{0}",
	chr(0x1375)	=> "$BrailleAsciiToUnicode{4}$BrailleAsciiToUnicode{0}",
	chr(0x1376)	=> "$BrailleAsciiToUnicode{5}$BrailleAsciiToUnicode{0}",
	chr(0x1377)	=> "$BrailleAsciiToUnicode{6}$BrailleAsciiToUnicode{0}",
	chr(0x1378)	=> "$BrailleAsciiToUnicode{7}$BrailleAsciiToUnicode{0}",
	chr(0x1379)	=> "$BrailleAsciiToUnicode{8}$BrailleAsciiToUnicode{0}",
	chr(0x137a)	=> "$BrailleAsciiToUnicode{9}$BrailleAsciiToUnicode{0}",
	chr(0x137b)	=> "$BrailleAsciiToUnicode{1}$BrailleAsciiToUnicode{0}$BrailleAsciiToUnicode{0}",
	chr(0x137c)	=> "$BrailleAsciiToUnicode{1}$BrailleAsciiToUnicode{0}$BrailleAsciiToUnicode{0}$BrailleAsciiToUnicode{0}$BrailleAsciiToUnicode{0}"
);


foreach ( keys %EthiopicNumeralsToBrailleUnicode ) {
	$BrailleUnicodeToEthiopicNumerals{$EthiopicNumeralsToBrailleUnicode{$_}} = $_;
}


%EthiopicPunctuationToBrailleUnicode = (
	chr(0x1361)	=> $BrailleAsciiToUnicode{2},
	chr(0x1362)	=> $BrailleAsciiToUnicode{4},
	chr(0x1363)	=> $BrailleAsciiToUnicode{1},
	chr(0x1364)	=> $BrailleAsciiToUnicode{1},  # undefined in ethiopic
	chr(0x1365)	=> $BrailleAsciiToUnicode{1},  # undefined in ethiopic
	chr(0x1366)	=> $BrailleAsciiToUnicode{1},  # undefined in ethiopic
	chr(0x1367)	=> $BrailleAsciiToUnicode{8},  # undefined in ethiopic
	chr(0x1369)	=> " ",
);


foreach ( keys %EthiopicPunctuationToBrailleUnicode ) {
	$BrailleUnicodeToEthiopicPunctuation{$EthiopicPunctuationToBrailleUnicode{$_}} = $_;
}


}


sub brailleUnicodeToEthiopic
{
#
#  this sub is not tested
#
	return unless ( $_[0] );
	my @chars  = split ( //, $_[0] );

	my $trans;

	my $base;
	foreach  ( @chars ) {

		if ( exists($BrailleUnicodeToEthiopic{$_}) ) {
			$base = $UnicodeBrailleToEthiopic{$_};
		}
		elsif ( exists($BrailleUnicodeToEthiopicForms{$_}) ) {
			$trans = $base.$BrailleUnicodeToEthiopicForms{$_};
			$base = undef;
		}
		else {
			if ( $base ) {
				$trans .= $base;
				$base = undef;
			}
			if ( exists($BrailleUnicodeToEthiopicNumerals{$_}) ) {
				$trans = $base.$BrailleUnicodeToEthiopicNumerals{$_};
			}
			elsif ( exists($BrailleUnicodeToEthiopicPunctuation{$_}) ) {
				$trans = $base.$BrailleUnicodeToEthiopicPunctuation{$_};
			}
		}
	}

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
