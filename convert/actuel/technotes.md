# 14317.coding.info
#### TODO
- [x] pagebreak tagging
- [x] castlist speaker:role & castgroups
- [x] stage directions remove `().`
- [x] speaker remove `:`
- [x] tag editorial notes
- [ ] front: title page, frontispiz, STmarkup in .txt and convert
- [ ] code verse passages in txt
- [ ] validate .xml
- [ ] add play meta information
- [ ] transliterate author/ play name
- [ ] assign sex to personlist items


#### python for local ezdrama
`pip install html5lib`
`pip install lxml` for M2 xml tree building (bs4)
`pip install bs4`
`pip install transliterate`
`pip install yiddish`

#### xmlformat for prettify .xml
`brew install xmlformat` (Mac)

#### validation
- scheme: <https://dracor.org/schema.rng>

issues:
- <comment> > <note>
- xml:id = "jr kham" > remove spaces in xml:ids
- <note type = "editorial"> : [type] not recognized; is recommended in dracor TEI documentation
- <note resp = "xxx"> : dito
- <sp who = "#khr">, line xml1293: empty line, not <p>, chk in transcript