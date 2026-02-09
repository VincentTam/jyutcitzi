#import "../lib.typ": jyutcitzi, combine-parts, beginnings-dict, endings-dict

#set page(width: auto, height: auto, margin: 10pt)
#set text(font: "Noto Sans CJK TC")

= Jyutcitzi Smoke Test

// Test various split modes
- Syllabic nasal sound: #jyutcitzi("m")
- Horizontal: #jyutcitzi("pin")
- Vertical: #jyutcitzi("di") 
- Null Initial: #jyutcitzi("aa")
- Null Final: #jyutcitzi("s")
- Compound Initial: #combine-parts(combine-parts(beginnings-dict.s.at(0), beginnings-dict.k.at(0), "-"), "頁", "|")

// Test a grid of common characters
#grid(
  columns: 5,
  gutter: 10pt,
  ..("jyut", "ping", "faat", "cit", "zi").map(jyutcitzi)
)
