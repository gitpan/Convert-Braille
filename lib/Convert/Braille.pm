package Convert::Braille;
use utf8;

BEGIN
{
require 5.6.0;

use base qw(Exporter);

use strict;
use vars qw( @EXPORT @EXPORT_OK %BrailleAsciiToUnicode %BrailleUnicodeToAscii $VERSION );

$VERSION = 0.02;

@EXPORT = qw(
		brailleDotsToUnicode
		brailleUnicodeToDots
		brailleUnicodeToAscii
		brailleAsciiToUnicode

		brailleAsciiToDots
		brailleDotsToAscii
);
@EXPORT_OK = qw(
		brailleDotsToUnicode
		brailleUnicodeToDots
		brailleUnicodeToAscii
		brailleAsciiToUnicode

		brailleAsciiToDots
		brailleDotsToAscii

		%BrailleAsciiToUnicode
		%UnicodeToBrailleAscii
);

%BrailleAsciiToUnicode =(
	A	=> chr(0x2801),  # chr creates a valid utf8 sequence
	B	=> chr(0x2803),
	C	=> chr(0x2809),
	D	=> chr(0x2819),
	E	=> chr(0x2811),
	F	=> chr(0x280b),
	G	=> chr(0x281b),
	H	=> chr(0x2813),
	I	=> chr(0x280a),
	J	=> chr(0x281a),
	K	=> chr(0x2805),
	L	=> chr(0x2807),
	M	=> chr(0x280d),
	N	=> chr(0x281d),
	O	=> chr(0x2815),
	P	=> chr(0x280f),
	Q	=> chr(0x281f),
	R	=> chr(0x2817),
	S	=> chr(0x280e),
	T	=> chr(0x281e),
	U	=> chr(0x2825),
	V	=> chr(0x2827),
	W	=> chr(0x283a),
	X	=> chr(0x282d),
	Y	=> chr(0x283d),
	Z	=> chr(0x2835),

	1	=> chr(0x2802),
	2	=> chr(0x2806),
	3	=> chr(0x2812),
	4	=> chr(0x2832),
	5	=> chr(0x2822),
	6	=> chr(0x2816),
	7	=> chr(0x2836),
	8	=> chr(0x2826),
	9	=> chr(0x2814),
	0	=> chr(0x2834),

	','	=> chr(0x2804),
	'@'	=> chr(0x2808),
	'/'	=> chr(0x280c),
	'"'	=> chr(0x2810),
	'^'	=> chr(0x2818),
	'>'	=> chr(0x281c),
	'\''=> chr(0x2820),
	'*'	=> chr(0x2821),
	'<'	=> chr(0x2823),
	'-'	=> chr(0x2824),
	'.'	=> chr(0x2828),
	'%'	=> chr(0x2829),
	'['	=> chr(0x282a),
	'$'	=> chr(0x282b),
	'+'	=> chr(0x282c),
	'!'	=> chr(0x282e),
	'&'	=> chr(0x282f),
	';'	=> chr(0x2830),
	':'	=> chr(0x2831),
	'\\'=> chr(0x2833),
	'('	=> chr(0x2837),
	'_'	=> chr(0x2838),
	'?'	=> chr(0x2839),
	']'	=> chr(0x283b),
	'#'	=> chr(0x283c),
	')'	=> chr(0x283e),
	'='	=> chr(0x283f)
);


foreach ( keys %BrailleAsciiToUnicode ) {
	$BrailleUnicodeToAscii{$BrailleAsciiToUnicode{$_}} = $_;
}

}

sub _convert
{
	return unless ( $_[0] );

	my ( $token, $hash ) = @_;

	( exists($hash->{$token}) ) ? $hash->{$token} : $token ;
}


sub brailleAsciiToUnicode
{

	return unless ( $_[0] );

	my $ascii = $_[0];
	$ascii =~ s/(.)/_convert ( $1, \%BrailleAsciiToUnicode )/ge;
	$ascii;
}


sub brailleUnicodeToAscii
{

	return unless ( $_[0] );

	my $unicode = $_[0];

	#
	#  first strip off dots 7 and 8:
	#
	if ( $unicode =~ /⡀-⣿/ ) {
		$unicode =~ tr/⢀-⣿/⠀-⡿/;  # fold upper half
		$unicode =~ tr/⡀-⡿/⠀-⠿/;  # fold upper quarter
	}
	$unicode =~ s/(.)/_convert ( $1, \%BrailleUnicodeToAscii )/ge;
	$unicode;
}


sub brailleUnicodeToDots
{

	my $string = shift; # no || "" because fail for '0'
	return "" if !defined $string || $string eq ""; 

	my @chars  = split ( //, $string );

	my $trans;

	foreach  ( @chars ) {
		if ( /[⠀-⣿]/ ) {  # assume UTF8
			my $char = ord ( $_ ) - 0x2800;
			my $new;
			$new  = "1" if ( $char & 0x1  );
			$new .= "2" if ( $char & 0x2  );
			$new .= "3" if ( $char & 0x4  );
			$new .= "4" if ( $char & 0x8  );
			$new .= "5" if ( $char & 0x10 );
			$new .= "6" if ( $char & 0x20 );
			$new .= "7" if ( $char & 0x40 );
			$new .= "8" if ( $char & 0x80 );
			$trans .= $new;
		}
		else {
			$trans .= $_;
		}
	}

	$trans;
}


sub brailleDotsToUnicode
{

	my $string = shift;
	return "" if !defined $string || $string eq ""; 

	my @bits  = split ( //, $string );

	my ($char, $lastBit, $trans) = (0,0,"");

	foreach ( @bits ) {
		my $bit = $_;
		if ( $bit =~ /[1-8]/ ) {
			if ( $bit > $lastBit ) {
				# bit continues sequence
				$char += 2**($bit-1);
			}
			else {
				# bit starts new sequence
				$trans  .= chr ( 0x2800+$char ) if ( $char );  # first time problem
				$lastBit = $char = 0;
				$char    = 2**($bit-1);
			}
			$lastBit = $bit;
		}
		else {  # end of sequence
			$trans  .= chr ( 0x2800+$char ) if ( $char );  # first time problem
			$trans  .= $bit;
			$lastBit = $char = 0;
		}
	}
	$trans  .= chr ( 0x2800+$char ) if ( $char );  # last time problem
  
  $trans;
}


sub brailleAsciiToDots
{
	brailleUnicodeToDots ( brailleAsciiToUnicode ( @_ ) );
}


sub	brailleDotsToAscii
{
	brailleUnicodeToAscii ( brailleDotsToUnicode ( @_ ) );
}

1;
__END__


=head1 NAME

 Convert::Braille - Package to convert between Braille encodings.

=head1 SYNOPSIS

 use Convert::Braille;

 print brailleAsciiToUnicode ( "HELLO" ), "\n";
 print brailleDotsToAscii    ( "12515123123135" ), "\n";


=head1 REQUIRES

perl5.6.0 (or later), Exporter

=head1 EXPORTS

 brailleDotsToUnicode
 brailleUnicodeToDots
 brailleUnicodeToAscii
 brailleAsciiToUnicode
 brailleAsciiToDots
 brailleDotsToAscii

=head1 BUGS

 None known yet.

=head1 AUTHOR

 Daniel Yacob,  Yacob@EthiopiaOnline.Net

=cut
