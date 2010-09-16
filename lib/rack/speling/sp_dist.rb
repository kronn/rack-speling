module Rack
  module Speling
    class SpDist
      def lookup(url)
        check_speling(url)
      end

      # taken from apaches mod_speling
      #
      # we only want to worry about GET
      # We've already got a file of some kind or another
      def check_speling
        raise NotImplentedError, "TODO: Complete port of apaches mod_speling into #{__FILE__}"
      end

      # return values of spdist(s,t)
      SP_IDENTICAL = 0
      SP_MISCAPITALIZED = 1
      SP_TRANSPOSITION = 2
      SP_MISSINGCHAR = 3
      SP_EXTRACHAR = 4
      SP_SIMPLETYPO = 5
      SP_VERYDIFFERENT = 6

      # spdist() is taken from Kernighan & Pike,
      #  _The_UNIX_Programming_Environment_
      # and adapted somewhat to correspond better to psychological reality.
      # (Note the changes to the return values)
      #
      # According to Pollock and Zamora, CACM April 1984 (V. 27, No. 4),
      # page 363, the correct order for this is:
      # OMISSION = TRANSPOSITION > INSERTION > SUBSTITUTION
      # thus, it was exactly backwards in the old version. -- PWP
      #
      # This routine was taken out of tcsh's spelling correction code
      # (tcsh-6.07.04) and re-converted to apache data types ("char" type
      # instead of tcsh's NLS'ed "Char"). Plus it now ignores the case
      # during comparisons, so is a "approximate strcasecmp()".
      # NOTE that is still allows only _one_ real "typo",
      # it does NOT try to correct multiple errors.
      #
      # This version is taken from mod_speling.c, httpd-2.2.16 and
      # adapted to ruby
      # /Users/matthias/Projects/httpd-2.2.16/modules/mappers/mod_speling.c
      # FIXME This won't work, yet
      def spdist(s, t)
        # exact match (sans case)
        if s.downcase == t.downcase
          return SP_MISCAPITALIZED
        end

        unless s.nil?
          unless t.nil?
            # transposition
            if s[1] && t[1] && s.downcase == t[1].downcase && t.downcase == s[1].downcase && (s + 2).casecmp(t + 2) == 0
              return SP_TRANSPOSITION
            end

            # char mismatch
            if (s + 1).casecmp(t + 1) == 0
              return SP_SIMPLETYPO
            end
          end

          # extra character
          if (s + 1).casecmp(t) == 0
            return SP_EXTRACHAR
          end
        end

        # missing character
        if !t.nil? && s.casecmp(t+1) == 0
          return SP_MISSINGCHAR
        end

        # distance too large to fix
        return SP_VERYDIFFERENT
      end
    end
  end
end
