#import "../utils.typ": split-jyutping

// Test standard cases
#assert(split-jyutping("waa") == ("w", "aa"))
#assert(split-jyutping("sing") == ("s", "ing"))

// Test edge cases
#assert(split-jyutping("a") == (none, "a"))      // No initial
#assert(split-jyutping("ng") == ("ng", none))   // Initial only
#assert(split-jyutping("m") == ("m", none))     // Syllabic nasal
