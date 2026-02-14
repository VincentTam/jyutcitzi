#import "../lib.typ": jyutcitzi, combine-3parts, initials-dict, finals-dict

#set page(width: auto, height: auto, margin: 10pt)
#set text(font: "Noto Sans CJK TC")

= Jyutcitzi Smoke Test

== Basic Jyutping Tests

- syllabic nasal sound: #jyutcitzi("ng")
- horizontal combine: #jyutcitzi("pin")
- vertical combine: #jyutcitzi("di") 
- null initial: #jyutcitzi("aa")
- null final: #jyutcitzi("s")
- Jyutping with tone: #jyutcitzi("seng2")
- multi-syllable: #jyutcitzi("gwong dung waa")

== Compound Initials (CCV)

- example 1: #jyutcitzi("spot1")
- example 2: #jyutcitzi("pjoi")
- with Jyutcit: #jyutcitzi("厶臼千1")
- mixed: #jyutcitzi("比臼頁1 gwong")

== Initial & Final Consonants (CVC)

- usual example: #jyutcitzi("des1")
- no inital consonant: #jyutcitzi("aamp")
- Jyutcit input: #jyutcitzi("厶乍大1")
- mixed input: #jyutcitzi("比乂并2 cat6")

== Merge Nasals Parameter

- default (no merge): #jyutcitzi("m1 ng3 乂 太4 犬6")
- with merge: #jyutcitzi(merge-nasals: true)[m1 ng3]
- merged in mixed input:
  #jyutcitzi(merge-nasals: true)[m1 ng3 gaa fot 亾乂6]

== Mixed Jyutping & Jyutcit Alphabets

- simple mixed: #jyutcitzi("禾乍1 pin gaa")
- CCV mixed: #jyutcitzi("厶臼千1 gwong kwaa1")
- CVC mixed: #jyutcitzi("厶乍大1 fap depp")
- complex: #jyutcitzi("比乍 z si2 sing1 dyun2")

== Multi-line Input

#jyutcitzi[
混合 jyut ping zung6 央久5\
cit zi 輸入，丩今 止久 sing4 dyun6 。
]
