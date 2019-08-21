## Useage and Evaluation of Tools for Text Extraction from PDF ##


### Purpose

The purpose of this project was to make PDF extraction tools available for batch use on patas, the server of the department of Linguistics at University of Washington.  A secondary goal was to evaluate these tools in order to be able to advise on usage.  Future goals include evaluation of these tools on multilingual documents (this was the original project idea).

This project is based on the 2017 work by Hannah Bast and Claudius Korzen and their paper "A Benchmark and Evaluation for Text Extraction from PDF."  It is their code that is called in the shell scripts, and they collected the benchmark data.  I was able to replicate their results when running the tools on patas, and so I am confident that the tools are working as intended.


### About

The script run_extr.sh is a helper script for extractor.py (in evaluation/bin), which in turn can use a multitude of tools (13 in total) to extract text from PDFs.  The extractor was originally meant to take large batches of PDFs and extract text using multiple different tools; each tool would then have its own output folder full of plain text files. The intent was then to compare and evaluate the results from these different tools by comparing them against a benchmark.

run_extr.sh can be used in the same way, but the standard use would be to select a text extraction tool to run on a batch of PDFs.  (This batch can be as large as you want, but you'll need to use some sort of computer cluster if you want to run it on more than 100 or so files, especially if you're using multiple tools.) You can select multiple tools if you are unsure which will provide you with the output that you want.  You can find examples of what the output from various tools looks like under evaluation/output/data/[tool name].

### Useage

The script is called as follows:

run_extr.sh path/to/pdfs path/to/output tool

The available options for tools are: pdftotext pdftohtml pdftoxml pdfbox pdf2xml parscit lapdftext pdfminer pdfXtk pdfextract PDFExtract grobid icecite.  See next section for more details. You can also type run_extr.sh -h for this list of tools (and the spelling/capitalization used for each). 

You can utilize multiple tools at once.  Make sure you add them as a string, with the names of tools separated by spaces, as such:

run_extr.sh path/to/pdfs path/to/output "tool1 tool2 tool3"

The input will need to be a folder of folders of PDFs.

After running the script, in your output folder you will find a folder for each tool you selected.  In this folder you will find at least one plain text file for each PDF in your input folder, ending in .final.txt.  Some tools may create additional files, such as .raw.txt files.  The .final.txt files are the ones you want to use.

### Tools

There are 13 tools, available individually from the following sources:

+ pdftotext
    https://www.xpdfreader.com/ (pdftotext is one of many command line tools included in the Xpdf toolkit)
+ pdftohtml
    https://sourceforge.net/projects/pdftohtml/
+ pdftoxml (aka pdf2xml, Xerox)
    https://sourceforge.net/projects/pdf2xml
+ pdf2xml (Tiedemann)
    https://bitbucket.org/tiedemann/pdf2xml/
+ PdfBox
    https://pdfbox.apache.org/
+ ParsCit
    http://parscit.comp.nus.edu.sg/, https://github.com/knmnyn/ParsCit
+ LA-PdfText
    https://github.com/GullyAPCBurns/lapdftext
+ PdfMiner
    https://github.com/euske/pdfminer
+ pdfXtk
    https://github.com/tamirhassan/pdfxtk
+ pdf-extract
    https://github.com/CrossRef/pdfextract/
+ PDFExtract
    https://github.com/elacin/PDFExtract
+ Grobid
    https://github.com/kermitt2/grobid
+ Icecite
    https://github.com/ckorzen/icecite

There is also one bonus tool that Bast and Korzen examined; they got the code from the author but the tool is primarily intended to be used online.

+ pdfx
    http://pdfx.cs.man.ac.uk/

As of June 2019 the following tools do not work on patas (department server): pdftoxml, pdf2xml, LA-PdfText, pdf-extract, grobid.

The following of those tools worked on a clean Linux install: LA-pdftext, pdf-extract, grobid, pdftoxml.

The following tools I was unable to get working properly in any environment: ParsCit, pdf2xml.  The error message is as follows: Can't locate XML/Writer.pm in @INC (you may need to install the XML::Writer module) This seems to be a missing perl module, and any further work done would start with supplying this module.

### About the tools

**Pdftotext** is one of the most common tools on the Internet used to extract text from PDFs, likely because it hasbeen around since 1996. It is one of many tools that are included with the Xpdf toolkit. It works quickly but does not attempt to identify paragraph boundaries, separate main text, etc. Additionally, it extracts characters with diacritics as two separate characters and doesn’t merge hyphenated words.

**Pdftohtml** converts the PDF to HTML (or XML) by breaking it down into lines.  It is also based on the Xpdf package and so carries the same drawbacks as pdftotext.

**Pdftoxml** is a tool created by Xerox, also using the Xpdf libraries. Confusingly, it is often styled as pdf2xml, which is identical to another tool listed below.

**PdfBox** is a PDF library from Apache, and gives plain text output.  It can handle ligatures and characters with diacritics, but not hyphenation. It does not attempt to identify section or paragraph boundaries.

**pdf2xml** uses Apache Tika (which in turn uses PdfBox) and pdftotext. It combines the results of both tools to "improve the detection of word boundaries using on-the-fly language models and efficient re-segmentation procedures." Amazingly, it also utilizes (optional) language detection, by paragraph. 

**ParsCit** uses third party tools and then processes the results to extract text and parse reference strings. Here, itutilizes pdftotext. Its output is in XML format.

**LA-PdfText** utilizes user-defined rules (created for different layouts) to find LTBs and extract text. The default rulesonly are used here. As such, it can only handle ligatures and not hyphenation or characters with diacritics.

**PdfMiner** analyzes the structure of the document and can convert it to XML or HTML as well as plain text. It doesnot handle ligatures or diacritics well.

**pdfXtk** uses PdfBox under the hood and converts the PDF into XML or HTML. It extracts text (as well as graphical content) and converts it to "objects" which are grouped into higher-level structures. It does not merge hyphenated words,and it converts diacritics into a separate character.

**pdf-extract** converts PDF documents to XML. It does not identify paragraphs or sections at all. It does not handle diacritics or hyphenation, but it does correctly parse ligatures.

**PDFExtract** converts PDFs to XML. It uses geometric layout analysis and logical layout analysis algorithms originally designed for OCR to segment pages into sections, such as the title, abstract, and headings. The only thing itreally struggles to handle are tables and formulae.

**Grobid** was created to extract bibliographic information from scholarly articles (its name comes from GeneRation Of BIbliographic Data). It uses Conditional Random Fields to break down a document into various logical text blocks (or LTBs) for XML output. It also handles ligatures, diacritics, and hyphenated words. It is incredibly powerful, but also very slow.

**Icecite** is Bast and Korzen’s research paper management system, which includes PDF text extraction. It can have plain text, XML, or JSON output. As expected, it meets all of Bast and Korzen’s judgment criteria, including handling diacritics and hyphenation.


### Settings used

There are several flags used on the extractor.py call that are pre-set by run_extr.sh.  One is pointing to the directory where the tools live.  Several are filters: a prefix filter (which is set to nothing), a suffix filter (set to ".pdf"), and a month and year filter (the original data used was articles sorted by year and month; these are kept blank).  There's also a num_threads value, which has been set to "-1" as Bast and Korzen had it.  Timeout is set to 300 (or five minutes) so that it doesn't get hung up on processing any given file.  Force and mute flags are set to False.  Here are the parameters used in the shell script:

--tools_dir "./evaluation/tools/data" --prefix_filter "" --suffix_filter ".pdf" --yy_filter "" --mm_filter "" --num_threads "-1" --timeout "300" --force "False" --mute "False" 

### More information

The files README-korzen-bast-orig.md and README-patas.md are the original README by Korzen and Bast, and the README for use on patas, respectively.  (The latter is mostly the same as this, with more usage notes specific to that environment.)  There is also a more in-depth version of this information, as well as some background on PDFs and text extraction, in my Usage and Evaluation paper.

ES 2019