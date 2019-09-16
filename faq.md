## Frequently (Anticipated) Questions ##

#Which tool is the best?#

That depends on what your criteria for "best" are!  Luckily, Bast and Korzen came up with a whole set of criteria to judge and compare extraction tools.  You can find their results in their 2017 paper, "A Benchmark and Evaluation for Text Extraction from PDF."  You can find a replication of their results made from these tools on patas, as well as additional background in my writeup, "Usage and Evaluation of PDF Text Extraction Methods."  Both are available under /docs.

#Can I process just one file?#

While the intention of this tool is to process PDFs in larger quantities, you can of course always point the script to a folder with only one item.

#It says there's 0 PDFs when there *are* PDFs!#

It's looking for folders full of PDFs, so you will need to point it one directory up (that is, to the folder that holds your folder(s) of PDFs).  

To clarify:

PDF_DIR (first argument) is full of pdf files - BAD.
PDF_DIR is full of folders full of pdf files - GOOD.

Don't worry if there's other stuff in there, it'll only look at files that end in .pdf! 

#It worked once, why doesn't it work again? I swear I didn't change anything.#

If your target output folder is already full of identically-named output files from a previous run, the tools will not overwrite them-- they won't do anything at all, actually.  You'll get an error code of -1.

#There's two pdf2xmls!#

There were two separate projects developed in 2016 for converting pdfs to xml; both were given the incredibly creative name of "pdf2xml." Xerox's tool is referred to here as pdftoxml in order to lessen confusion and to echo its similarly Xpdf-derived relatives, pdftotext and pdftohtml.

#Are pdfextract and PDFExtract the same thing?#

No.  See the README or the full writeup (/docs/Text-extract-usage-eval.pdf) for more details on each.

#Are pdfextract and pdf-extract the same thing?#

Yes.

#I used the tool \[pdftoxml, pdf2xml, LA-pdftext, pdf-extract, grobid\] and it didn't work!#

Correct, those tools do not work on patas currently.

#But I reeeeeeeeally want to use one of the tools that doesn't work!#

I was able to get pdf-extract, grobid, pdftoxml, and LA-pdftext to run on a different environment (standard Ubuntu 16.04 fresh install + miniconda3 4.6), so you could theoretically download any of those from source (see README), clone the original project at https://github.com/ckorzen/pdf-text-extraction-benchmark or my version (which has the shell script) at https://github.com/e-sim/pdf-text-extraction-benchmark and see if they work for you!

#What about pdftoxml and pdf2xml?#

They require an XML writer; I could not find where the tools are looking for it to be.  You're welcome to try to get them working yourself!

#I got grobid working but it takes forever!#

Yes, yes it does.

#You said ParsCit worked, but I get errors and have blank output .final.txt files (that are possibly saved in a weird nest of evaluation/output folders)!#

That's true, but the .pre.txt files are made (mostly) correctly and can be used as a final product.  In order to use them in evaluations,  you will need to change the ending to .final.txt.  However, the resulting output files are about the same as what you'd get from pdftotext, as ParsCit uses that under the hood (in the setup found here).  The extra processing that ParsCit does fails due to a missing XML writer, same as pdftoxml and pdf2xml.

#I'm copying some of my output data to my Windows machine for whatever reason, and it asks me if I want to replace files there that already exist even though there shouldn't be any!#

If you're using both PDFExtract and pdf-extract, you will have to rename one of the output folders [PDFExtract, pdfextract] before moving them to Windows.

#I'm getting errors but I only see the first 40 characters of the error message! How can I see more?#

You'll have to make a copy of evaluation/bin/extractor.py to edit a touch.  On line 411 of the code it specifies that [0:40] of the error message should be printed.  Change this to however long you would like (I generally use ~300 for troubleshooting). Make the call to this edited version (or copy the run_extr.sh script and change where it is pointing to).  DO NOT run this longer error message version on large batches; you will regret it.  I would recommend running it on a small batch of 1-5 documents, and redirecting the output to a text file.  

#I'm getting error messages but it's exiting with error code 0!#

Those are likely warnings, probably about character encodings.  Sometimes 

If you are getting an error code of 0, it is usually not worth doing the above to get the full message.

#I want to mess around with settings and filters and stuff!#

Point to Makefile (should I have stuff about it under README?)

ES 2019