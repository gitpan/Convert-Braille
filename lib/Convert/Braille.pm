package Convert::Braille;
use utf8;

BEGIN
{
require 5.006;

use base qw(Exporter);

use strict;
use vars qw( @EXPORT @EXPORT_OK $VERSION %BrailleAsciiToUnicode %BrailleUnicodeToAscii $dot_separator );

$VERSION = 0.04;

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
	A	=> '⠁',
	B	=> '⠃',
	C	=> '⠉',
	D	=> '⠙',
	E	=> '⠑',
	F	=> '⠋',
	G	=> '⠛',
	H	=> '⠓',
	I	=> '⠊',
	J	=> '⠚',
	K	=> '⠅',
	L	=> '⠇',
	M	=> '⠍',
	N	=> '⠝',
	O	=> '⠕',
	P	=> '⠏',
	Q	=> '⠟',
	R	=> '⠗',
	S	=> '⠎',
	T	=> '⠞',
	U	=> '⠥',
	V	=> '⠧',
	W	=> '⠺',
	X	=> '⠭',
	Y	=> '⠽',
	Z	=> '⠵',

	1	=> '⠂',
	2	=> '⠆',
	3	=> '⠒',
	4	=> '⠲',
	5	=> '⠢',
	6	=> '⠖',
	7	=> '⠶',
	8	=> '⠦',
	9	=> '⠔',
	0	=> '⠴',

	','	=> '⠄',
	'@'	=> '⠈',
	'/'	=> '⠌',
	'"'	=> '⠐',
	'^'	=> '⠘',
	'>'	=> '⠜',
	'\''	=> '⠠',
	'*'	=> '⠡',
	'<'	=> '⠣',
	'-'	=> '⠤',
	'.'	=> '⠨',
	'%'	=> '⠩',
	'['	=> '⠪',
	'$'	=> '⠫',
	'+'	=> '⠬',
	'!'	=> '⠮',
	'&'	=> '⠯',
	';'	=> '⠰',
	':'	=> '⠱',
	'\\'	=> '⠳',
	'('	=> '⠷',
	'_'	=> '⠸',
	'?'	=> '⠹',
	']'	=> '⠻',
	'#'	=> '⠼',
	')'	=> '⠾',
	'='	=> '⠿'
);


foreach ( keys %BrailleAsciiToUnicode ) {
	$BrailleUnicodeToAscii{$BrailleAsciiToUnicode{$_}} = $_;
}

$dot_separator = "";

}

sub _convert
{
	return unless ( defined($_[0]) );

	my ( $token, $hash ) = @_;

	( exists($hash->{$token}) ) ? $hash->{$token} : $token ;
}


sub brailleAsciiToUnicode
{

	return unless ( defined($_[0]) );

	my $ascii = $_[0];
	$ascii =~ s/(.)/_convert ( $1, \%BrailleAsciiToUnicode )/ge;
	$ascii;
}


sub brailleUnicodeToAscii
{

	return unless ( defined($_[0]) );

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

	my ($trans, $dots);

	foreach  ( @chars ) {
		if ( /[⠀-⣿]/ ) {  # assume UTF8
			my $char = ord ( $_ ) - 0x2800;
			$trans .= $dot_separator if ( $dots );
			$dots  = undef;
			$dots  = "1" if ( $char & 0x1  );
			$dots .= "2" if ( $char & 0x2  );
			$dots .= "3" if ( $char & 0x4  );
			$dots .= "4" if ( $char & 0x8  );
			$dots .= "5" if ( $char & 0x10 );
			$dots .= "6" if ( $char & 0x20 );
			$dots .= "7" if ( $char & 0x40 );
			$dots .= "8" if ( $char & 0x80 );
			$trans .= $dots;
		}
		else {
			$trans .= $_;
			$dots = undef;
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
