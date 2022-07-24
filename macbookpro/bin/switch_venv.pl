#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use POSIX qw(getcwd);

my $new = "@ARGV";

my $SV_HOME = $ENV{SV_HOME};
die "VEnv directory not set (env var SV_HOME).\n" if !defined $SV_HOME;
-d $SV_HOME || (qx{mkdir -p $SV_HOME} && die "$@ $! cannot create $SV_HOME");

die "Home directory not set (env var HOME).\n" if !defined $ENV{HOME};
die "$ENV{HOME} is not a directory.\n" if !-d $ENV{HOME};
my $dir = "$ENV{HOME}/.sv";
-d $dir || mkdir $dir || die "mkdir $dir failed: $!\n";

# If we are in a venv, find out if in $SV_HOME.
my $curr_venv_path = ($ENV{VIRTUAL_ENV} || "");
my $curr_venv = $curr_venv_path;
#print "In virtual env: $curr_venv_path\n";
if (substr($curr_venv_path, 0, length $SV_HOME) eq $SV_HOME) {
    # Venv is in standard location.
    $curr_venv = substr($curr_venv_path, length $SV_HOME);
    $curr_venv =~ s#^/*##;  # remove any leading slashes
}
elsif (length $curr_venv) {
    # Venv is not in a standard location.  Use full path.
    #print "Using non-standard venv location: $curr_venv\n";
}

my $max  = 20;
my $curr = "$dir/curr";
my $venvs = "$dir/venv_hist";

unless (open SV, $venvs) {
    open SV, ">>$venvs" or die "$!\n";
    open SV, $venvs or die "$!\n";
}
chomp ( my @venvs = <SV> );

if (!length $new) {

    # No comand line argument.  Select from previous venv.
    my @display = map { substr($_, 0, length $SV_HOME) eq $SV_HOME ? substr($_, length $SV_HOME+1) : $_ } @venvs;
    my $idx=0;
    print map { "  (@{[$idx++]}) $_\n" } @display;
    $|=1;
    print " venv? ";
    chomp ( $new = <STDIN> );
}
$new = $venvs[$new]   if $new =~ m#^\d+$#;
exit unless length $new;

#my $new_path = substr($new, 0, 1) eq "/" ? $new : "$SV_HOME/$new";
my $new_path = $new;
#print "Using venv path: $new_path\n";
if ($new =~ m/-c (\S*)$/) {
    # Create the new venv.
    $new = $1;
    my $new_path = substr($new, 0, 1) eq "/" ? $new : "$SV_HOME/$new";
    die "Venv \"$new\" already exists.\n"   if -e "$new_path";
    print "Creating venv $new";
    system "python3 -m venv $new_path";
} else {
    # validate existence of new venv
    die "Cannot sv \"$new\" -- $!\n" if !-e "$new_path/bin/activate";
}

# update file status.
@venvs = map { exists $_{$_} ? () : ($_{$_}=$_) } ($new, $curr_venv, @venvs);
open SV, ">$venvs" or die "$!\n";
print SV map {"$_\n"} splice @venvs, 0, $max;
open SV, ">$curr" or die "$!\n";
print SV "$new\n";
