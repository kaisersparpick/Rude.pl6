# Rude.pl6
Rude.pl6 is a Perl6 implementation of the *rule-based control-flow pattern* [Rude](https://github.com/kaisersparpick/Rude).

## Usage

#### Creating an instance
```perl6
use Rude;
my $rude = Rude.new;
```

#### Adding a rule

```perl6
$rude.add(&subroutine1, &subroutine2, &subroutine3);
```
`add` accepts three arguments: the condition to check, the function to call when the result is true, and the function to call when it is false. Each argument can be a subroutine reference, a `rule array` or left empty.

A `rule array` takes the form of `[:$object, 'instance_method']` and Rude takes care of binding them together. Using rule arrays also makes it easy to load rules dynamically from a datasource or generating them on the fly.

A complex example:
```perl6
$rude.add(&mysub, [:$myobj, 'mymethod']);
```

The return value of conditions must be `True` to proceed with the yes callback and `False` with the no branch. When a condition returns `Nil`, Rude exits the condition chain. In this case, the yes and no callbacks are not necessary, therefore they can be left empty. These conditions are usually exit points.

#### Checking conditions

Checking conditions based on the applied rules is triggered by calling `rude.check()`.

```perl6
# with a subroutine reference
rude.check(&mysub);
# with a rule array
rude.check([:$myobj, 'mymethod']);
```

This specifies the entry point in the condition chain and can be set to any valid rule condition.

See the **example** for more details.

## Benefits

  - Rude allows for an on-demand execution of a chain of `dynamic if-then-else` statements - hereinafter referred to as `rules`.
  - The control flow is easy to manage and the logic can be modified by simply changing the callbacks in the `rules`.
  - The chain of condition checking can be exited or paused at any given point.
  - The position in the `rule` hierarchy can be stored and the execution resumed at a later stage by setting the `entry point`. 
  - Each `rule` is seen as a separate and *independent logical unit*.
  - Individual `rules` and groups of rules can be easily moved around.
  - `Rules` can be generated dynamically or loaded from a datasource. 
  - The dispatcher makes it possible to ditch the rigid static conditional model in favour of a considerably more flexible one.
