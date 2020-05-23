
use Test;
use TempDir;

plan 5;

my $dir-A;
my $dir-B;

do {
    ENTER $dir-A = TempDir::new;
    LEAVE $dir-A.rmdir;
    ENTER $dir-B = TempDir::new;
    LEAVE $dir-B.rmdir;
    isnt $dir-A.Str, $dir-B.Str, 'different invocations of TempDir::new yield different directories';
    ok $dir-A.d, "the first directory exists before block exit";
    ok $dir-B.d, "the second directory exists before block exit";
    note "writing to " ~ $dir-A.add('myfile.txt');
    $dir-A.add('myfile.txt').spurt: "my text!";
}
nok $dir-A.d, "the first directory does not exist after block exit";
nok $dir-B.d, "the second directory does not exist after block exit";

done-testing;

