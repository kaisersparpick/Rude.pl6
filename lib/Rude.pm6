class Rude is export {
    has $!scope;
    has %!rules;
    has @!path;

    submethod BUILD(:$!scope) {}

    sub method-name($rule) {
        $rule[0].key ~'.'~ $rule[0].value.^find_method($rule[1]).name
            orelse die "Unknown method $_";
    }

    method new($scope) { return self.bless(:$scope) }

    method add($condition, $yes?, $no?) {
        my $rule-name = do given $condition {
            when Array { method-name($condition) }
            when Str   { $!scope.^name ~'::'~ $condition }
            default    { $condition.name }
        }

        %!rules.push: ($rule-name => (
            condition => $condition, yes => $yes, no => $no
        ));
    }

    method check($entry-point) {
        my $condition = $entry-point;
        my %rule is default(Nil);
        my $rule-name;
        my $result;
        my $obj;
        my $method;

        @!path = [];

        loop {
            given $condition {
                when Array {
                    $rule-name = method-name($condition);
                    %rule = %!rules<<"$rule-name">> if :exists orelse die 'ERROR: Undefined rule';

                    $obj = %rule<condition>[0].value;
                    $method = %rule<condition>[1];
                    die 'ERROR: Unknown method' unless $obj.can($method);

                    $result = $obj.^find_method($method)($obj);
                }
                when Sub {
                    $rule-name = $condition.name;
                    %rule = %!rules<<"$rule-name">>;
                    die 'ERROR: Unknown subroutine' unless %rule<condition>.defined;

                    $result = %rule<condition>();
                }
                default { last }
            }

            @!path.push: [$rule-name, $result];

            given $result {
                when :so   { $condition = %rule<yes> }
                when :not  { $condition = %rule<no> }
                default    { last }
            }
        }
    };

    method path() {
        my $path = '';

        for @!path -> $p {
            $path ~= '!'   if ($p[1].defined && $p[1] == False);
            $path ~= $p[0];
            $path ~= ' > ' if $p[1].defined;
        }

        return $path;
    }
}
