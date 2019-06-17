# Sequences that have been featured on Numberphile, but are not
# in the core sequences list.

use Math::Sequences::Integer :support, :DEFAULT;

# https://www.youtube.com/watch?v=OeGSQggDkxI

# A249572 - Least positive integer whose decimal digits divide the plane
# into n+1 regions. Otherwise read as the smallest positive integer that
# has n typographical holes in its digits.
# @ordering should contain the minimum, non-zero digit for each number of
# holes in its representation.
# $radix should contain the base to work in.
sub topologically-ordered-numbers(:@ordering=[<1 4 8>], :$radix=10) is export(:support) {
	lazy gather for 𝕀 -> $n {
		my $sum = 0;
		my $number = [~] reverse gather loop {
			my $order = min(@ordering.elems-1, $n-$sum);
			take @ordering[$order];
			$sum += $order;
			last if $sum == $n;
		};
		take parse-base($number, $radix);
	}
}

our @A249572 is export = topologically-ordered-numbers();

# A087409 - Multiples of 6 with digits grouped in pairs and leading
# zeros omitted.
sub digit-grouped-multiples(:$of, :$group=2) is export(:support) {
	lazy gather for ℕ.map({$^n * $of}) -> $multiple {
		state $accum = '';
		$accum ~= $multiple;
		if $accum.chars >= $group {
			take +$accum.substr(0,$group);
			$accum = $accum.substr($group);
		}
	}
}

our @A087409 is export = digit-grouped-multiples(:of(6), :group(2));