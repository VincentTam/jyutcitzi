#import "../lib.typ": jyutcitzi, combine-parts, initials-dict, finals-dict

#set page(width: auto, height: auto, margin: 10pt)
#set text(font: "Noto Sans CJK TC")

= Jyutcitzi Smoke Test

// Test various split modes
- Syllabic nasal sound: #jyutcitzi("m")
- Horizontal: #jyutcitzi("pin")
- Vertical: #jyutcitzi("di") 
- Null Initial: #jyutcitzi("aa")
- Null Final: #jyutcitzi("s")
- Compound Initial:
  #combine-parts(
    combine-parts(initials-dict.s.at(0), initials-dict.k.at(0), "-"),
    "頁",
    "|"
  )

// Test a multi-line string containing jyutping
#jyutcitzi("jyut\tping\nfaat cit zi")
