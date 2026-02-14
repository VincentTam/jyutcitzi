#import "../utils.typ": split-jyutping, split-jyutcit, reverse-init-dict-lookup, reverse-final-dict-lookup, get-jc-from-jp-init, get-jc-from-jp-final

// Test split-jyutping with "simple" mode (default)
#assert(split-jyutping("waa2") == ("w", "aa", "2"))
#assert(split-jyutping("sing1") == ("s", "ing", "1"))
#assert(split-jyutping("aa") == (none, "aa", none))
#assert(split-jyutping("ng") == (none, "ng", none))
#assert(split-jyutping("soeng") == ("s", "oeng", none))
#assert(split-jyutping("oi3") == (none, "oi", "3"))
#assert(split-jyutping("m4") == (none, "m", "4"))
#assert(split-jyutping("cat6") == ("c", "at", "6"))
#assert(split-jyutping("hm1") == ("h", "m", "1"))
#assert(split-jyutping("ngong") == ("ng", "ong", none))

// Test split-jyutping with "CCV" mode
#assert(split-jyutping("spot1", split-mode: "CCV") == ("s", "p", "ot", "1"))
#assert(split-jyutping("pjoi", split-mode: "CCV") == ("p", "j", "oi", none))

// Test split-jyutping with "CVC" mode
#assert(split-jyutping("aamp", split-mode: "CVC") == (none, "aam", "p", none))
#assert(split-jyutping("saap3", split-mode: "CVC") == ("s", "aa", "p", "3"))

// Test split-jyutcit function
#assert(split-jyutcit("禾乍1") == ("simple", ("禾", "乍", "1")))
#assert(split-jyutcit("比乍") == ("simple", ("比", "乍", none)))
#assert(split-jyutcit("臼") == ("C", ("臼", none, none)))
#assert(split-jyutcit("比臼頁1") == ("CCV", ("比", "臼", "頁", "1")))
#assert(split-jyutcit("天禾乍") == ("CCV", ("天", "禾", "乍", none)))
#assert(split-jyutcit("厶乍大1") == ("CVC", ("厶", "乍", "大", "1")))
#assert(split-jyutcit("比乂并2") == ("CVC", ("比", "乂", "并", "2")))

// Test reverse lookup functions
#assert(reverse-init-dict-lookup("比") == "b")
#assert(reverse-init-dict-lookup("并") == "p")
#assert(reverse-final-dict-lookup("叐") == "et")
#assert(reverse-final-dict-lookup("曷") == "ot")

// Test Jyutping to Jyutcitzi conversion functions
#assert(get-jc-from-jp-init("w") == "禾")
#assert(get-jc-from-jp-init("s") == "厶")
#assert(get-jc-from-jp-init("ng") == "爻")
#assert(get-jc-from-jp-final("aa") == "乍")
#assert(get-jc-from-jp-final("ing") == "丁")
#assert(get-jc-from-jp-final("m") == "太")
#assert(get-jc-from-jp-final("ng") == "犬")