use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Convert::Braille',
    'VERSION_FROM'	=> 'lib/Convert/Braille.pm', # finds $VERSION
	'AUTHOR'	=> "Daniel Yacob <Yaocb\@EthiopiaOnline.Net>",
	'ABSTRACT'	=> "Conversion between Braille encodings.",
);
