### **Why did I abandon trying to measure judges' ideology using text of their decisions**:
- Personally, I was thinking of this project as an opportunity to do cool things with text as opposed to deeply understanding a question with the aid of data. I decided that I'm not married to text analysis and I can return to it another time. I could have applied text analysis to Congress floor speeches, but I'd rather stick with learning about federal judges. 
- Challenge: Text analysis of judge decisions may be able to identify differences in style, but differences in ideology are much too subtle. Suppose I have vector representations of appellate judges. Ash and Chen show that even after mean-centering for year, topic, and circuit, there are no discernible differences between the vector representations of democratic vs republican judges. Why? One reason may be that  legal language is jargony and typically avoids coloquialisms (e.g. in Congress, members use colloquial speech in floor speeches such as "death tax", "estate tax", "fake news", "alternative facts", "pro-life", "anti-choice"), as discussed in [538 article](https://fivethirtyeight.com/features/how-conservative-is-brett-kavanaugh/). 
- I still think it's possible -- but this is more like a 10-year problem than a semeseter problem. But just to elaborate a little... consider Snyder vs. Phelps (2011):
- Quick facts: Westboro church members picketed with egregious homophobic signs at the funeral service of Marine Lance Corporal Matthew Snyder
- Briefly, Roberts states there are "special protections" for first amendment for speech regarding public issues that takes place on public land. Here's a passage I annotated:

![Roberts](notes/pics/roberts.png)

- Alito dissents that free speech is not a license to inflict harm. Here's a passage:

![Alito](notes/pics/alito.png)

This is just one example... but it feels that with enough passages like this, it should be possible to compute judge profiles using text data. But these passages are few and far between. Even if one can methodically remove the fact pattern from opinions... that step alone may be helpful in isolating the more ideology-revealing text.

Another complication with Appellate courts is that there are even fewer "ideology-revealing" moments in the lower courts comapred to Supreme Court. 




