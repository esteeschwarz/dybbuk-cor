# 14315.TEI.preprocessing
#### methods
base: transkribus .txt export   
goal: ezdrama ready markup

##### 1. speaker declaration
- paste # at beginning of lines containing `:`
- the results were not displayed correctly in R-Studio editor nor OXYGEN nor VSC, only in gedit editor

##### 2. edit pagenumbers
- ezdrama demands `xxx:` as pagenumber/break markup
- manually in .txt

##### 3. remove niqqud in speaker declaration

##### 4. remove linebreaks
- the TEI text elements `<p>` should contain the whole speech act