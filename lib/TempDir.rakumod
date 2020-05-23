
unit package TempDir:auth<littlebenlittle>:ver<0.0.0>;

use UUID;
use Log;

my $log = Log::new($?PACKAGE.gist);
$log.subscribe: {
    $log.INFO:  "[" ~ .timestamp.DateTime ~ "]"
         ~ " "  ~ .source
         ~ " "  ~ .level
         ~ ": " ~ .message;
};


class temp-dir is IO::Path {
    method rmdir {
        $log.INFO: "rmdir called on $.path";
        rmdir-recursive $.path;
    }
}

sub rmdir-recursive(IO() $path -->Nil) {
    $log.INFO: "rmdir-recursive called on $path";
    fail "not a directory: $path" unless $path.d;
    for $path.dir -> $subpath {
        if $subpath.d {
            $log.INFO: "$path is a directory";
            rmdir-recursive $subpath;
        } else {
            $log.INFO: "$subpath is not a directory";
            unlink $subpath or fail "Could not unlink $subpath";
        }
    }
    rmdir $path;
}

our sub new(-->temp-dir) {
    my $path = $*TMPDIR.IO.add: UUID::rand;
    my $dir  = temp-dir.new($path);
    die "path already exists: $path" if $path.IO.e;
    $path.IO.mkdir;
    return $dir;
}

