class CharacterIdentifier {
    has Str $.result is rw = '';

    method is-rebel {
        my $return-val = Bool.pick;
        $.result = 'Darth Vader' unless $return-val;
        return $return-val;
    }
    method is-prisoner {
        Bool.pick;
    }
    method is-pilot {
        Bool.pick;
    }
    method is-hairy {
        my $return-val = Bool.pick;
        $.result = $return-val ?? 'Chewbacca' !! 'Han Solo';
        return $return-val;
    }
    method is-from-tatooine {
        my $return-val = Bool.pick;
        if (!$return-val) {
            $.result = 'R2D2';
        }
        return $return-val;
    }
    method is-old {
        $.result = Bool.pick ?? 'Obi-Wan Kenobi' !! 'Luke Skywalker';
        return Nil;
    }
    method leia {
        $.result = 'Princess Leia Organa';
        return Nil;
    }
}
