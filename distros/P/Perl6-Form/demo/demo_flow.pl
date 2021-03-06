use Perl6::Form;

$text = <<EOSOL;
Now is the winter of our discontent / Made glorious summer by this sun of York; / And all the clouds that lour'd upon our house / In the deep bosom of the ocean buried. / Now are our brows bound with victorious wreaths; / Our bruised arms hung up for monuments; / Our stern alarums changed to merry meetings, / Our dreadful marches to delightful measures. Grim-visaged war hath smooth'd his wrinkled front; / And now, instead of mounting barded steeds / To fright the souls of fearful adversaries, / He capers nimbly in a lady's chamber.
EOSOL


print "\nAcross:\n";
print form
	{page=>{width=>72, length=>5, footer=>"====================\n"},
      layout=>'across',
	},
   	 "{:[{*}]}   {:[{*}]}   {:[{*}]}",
	  $text,     $text,     $text,
	 "{II{*}II}",
	 "The End\nis nigh\nunto\nthis line\nright here"
	 ;
               
pos $text = 0;
               
print "\nBalanced (default):\n";
print form
	{page=>{width=>72, length=>5, footer=>"====================\n"}},
   	 "{:[{*}]}   {:[{*}]}   {:[{*}]}",
	  $text,      $text,      $text,
	 "{II{*}II}",
	 "The End\nis nigh\nunto\nthis line\nright here"
	 ;

pos $text = 0;

print "\nDown:\n";
print form
	{page=>{width=>72, length=>5, footer=>"====================\n"},
      layout=>'down',
	 },
   	 "{:[{*}]}   {:[{*}]}   {:[{*}]}",
	  $text,      $text,      $text,
	 "{II{*}II}",
	 "The End\nis nigh\nunto\nthis line\nright here"
	 ;
