## Data Inventory

### Background:
- There were 49,363 federal appellate court cases filed last year
- The data contains 10000s of documents for each court (bc it includes errata sheets, )
- Starts in year 1992
- Downloaded in bulk which is equivalent to API
- Each court case is in a json file and contains some metadata but it is not reliable. They contain:
	- URL slugs
	- Whether Opinion was Per Curiam or not (Not reliable)
	- The Authors (Not reliable)
	- Several different versions of the opinion: plain_text, html, html_with_citations, html_lawbook, html_columbia
	- Generally, plain_text is non-empty but html_with_citations is a good second bet.
- Each of these text files may contain more than one opinion (e.g. if there is a concurring opinion or a dissent)

### To-Do:
- Get the Judge names
- Concurrences, Per Curiam, Dissents
	- Identify these
	- Either remove them from sample entirely
	- Or split string and separate into two opinions
	- Notes:
		- Splitting can be confusing when dissents/concurrences have multiple authors
		- Need to be careful how I identify the splits. Sometimes the word "dissenting" is used in someone's opinion.
		- More formally, there is some indicator that separates the dissent. But I don't know if this is 100% reliable.

### Judge Identification
Look for:
1. "\n\f (.*?) Chief[ \t]+Judge[.]"
2. "\n\f (.*?) Circuit[ \t]+Judge[.]"
3. 
4. "<p>(.*?) Chief[ \t]+Judge[.]"
5. "<p>(.*?) Circuit[ \t]+Judge[.]"
6. Example, ca1, id=152: https://www.courtlistener.com/opinion/1192077/guillemard-ginorio-v-contreras-gomez/
	- Alternatively, ca1, id=18061: https://www.courtlistener.com/opinion/2965234/massachusetts-school-v-american-bar/
7. "<p class=\"indent\">(?!.*and)(.*?) Chief[ \t]+Judge[.]"
8. "<p class=\"indent\">(?!.*and)(.*?) Circuit[ \t]+Judge[.]"
9. Example, ca1, id=26867: https://www.courtlistener.com/opinion/482471/united-states-v-hector-acevedo-ramos/

### Judge Metadata

After obtaining judges from court documents, I need to get judge metadata

### First Curcuit
- 33732 non-missing documents
- 1992-2018
- 27414 do not have unique author??

- Why do so many cases have non-unique or misc author?
	- Some are written by district court judges


