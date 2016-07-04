sub what () {
	my @brain = "brain.txt".IO.lines;
	say "================TODO=================";
	for @brain {say $_ ;};
}

sub what-else ($todo) {
	my $brain = slurp("brain.txt");
	my $new-brain = $brain ~ $todo ~ "\n";
	spurt("brain.csv", $new-brain);
}

sub job-done ($todo) {
	my $i = 0;
	my @brain = "brain.txt".IO.lines;
	for @brain {
	    if $_ ~~ $todo {
		 say @brain[$i];
                 @brain[$i] = "--"~@brain[$i]~"--";
            }
         $i++;
        }
	@brain .= join("\n");
	spurt("brain.txt", @brain);
	what();
} 

sub clear {
	spurt("brain.txt", "");
}

multi sub MAIN () { 
	what();
}

multi sub MAIN ($arg where { $_ ~~ "done" }, $todo) {
	job-done($todo);
}

multi sub MAIN ($arg where { $_ ~~ "clear" }) {
	clear();
}

multi sub MAIN (*@todo) {
	what-else(@todo);
}
