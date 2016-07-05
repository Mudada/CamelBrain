sub what () {
	my @brain = "brain.txt".IO.lines;
	say "================TODO=================";
	for @brain { .say ;};
}

sub what-else ($todo) {
	my $brain = slurp("brain.txt");
	my $new-brain = $brain ~ $todo ~ "\n";
	spurt("brain.txt", $new-brain);
}

sub job-done ($todo) {
	my @brain = "brain.txt".IO.lines;
	for @brain {
	    if $_ eq $todo { 
		$_ = "--{$_}--";
	    }
	}
	@brain .= join("\n");
	spurt("brain.txt", @brain);
} 

sub clear {
	spurt("brain.txt", "");
	say "Brain cleared.\n";
}

multi sub MAIN () { 
	what;
}

multi sub MAIN ("done", $todo) {
	job-done($todo);
	what;
}

multi sub MAIN ("clear") {
	clear();
}

multi sub MAIN (*@todo) {
	what-else(@todo);
	what;	
}
