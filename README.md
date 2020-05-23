
# TempDir

## Use

```raku
use TempDir;

my $dir;
do {
    ENTER $dir = TempDir::new;
    LEAVE $dir.rmdir;
    say so $dir.d; # ｢ True ｣
}
say so $dir.d; # ｢ False ｣
```
