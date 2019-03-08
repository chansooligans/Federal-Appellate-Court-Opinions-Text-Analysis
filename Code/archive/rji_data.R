# Read JRI Appellate Court Data

rm(list=ls())

require(readstata13)
require(rjson)

df = read.dta13('/Volumes/RESEARCH/EDSP/data/jri/cta96_stata.dta')

head(df)
df$casenum

list.files('/Volumes/RESEARCH/EDSP/data/ca1/')
result = fromJSON(file='/Volumes/RESEARCH/EDSP/data/ca1/1.json')
result
