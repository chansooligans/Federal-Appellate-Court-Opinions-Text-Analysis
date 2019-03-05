## Amazon s3 -- Download Instructions for Appellate Court Opinions

Data Source: http://webpolicy.org/2013/05/03/advancing-empirical-legal-scholarship-federal-appellate-opinions-and-rules/
s3cmd Set-up instructions: https://qiita.com/osk_kamui/items/63094cf21a8c560a17bc
reddit tip: https://www.reddit.com/r/aws/comments/1vqcjr/cannot_download_data_from_a_requester_pays_bucket/


1. brew install s3cmd
2. use command: "s3cmd get --add-header="x-amz-request-payer:requester" s3://legaldata/federal/opinions/united_states_court_of_appeals_for_the_first_circuit.zip" (update folder name)


## Alternatively, use court-listener

https://www.courtlistener.com/api/bulk-data/opinions/ca1.tar.gz

Tips:
https://github.com/brianwc/bulk_scotus
