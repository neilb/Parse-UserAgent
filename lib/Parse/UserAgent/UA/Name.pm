package Parse::UserAgent::UA::Name;

use Moo;
use overload '""' => sub { $_[0]->cooked(); };

has raw    => ( is => 'ro');
has cooked => ( is => 'ro');


1;
