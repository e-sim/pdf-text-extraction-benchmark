#!/bin/bash

# auth Erica Sim, 2019 
# this script is to assist in running the extractor 
# the extractor is for running text extraction on a batch of pdfs
# this needs to be run from /projects/pdf_eval/code/pdf-text-extraction-benchmark
# (or wherever the main pdf-extraction folder is)
# expected input: folder full of .pdfs
# expected output: folder full of .txts with extracted plain text

# useage: ./run_extr.sh path/to/pdfs path/to/output "[list of tools]"

# let's give the people some help!
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
  echo "Usage: `basename $0` path/to/pdfs path/to/output \'[list of tools]\'
  You can list multiple tools as a string at the end.
  Available tools:
  pdftotext             pdftohtml
  pdfbox                pdf2xml
  parscit               lapdftext
  pdfminer              pdfXtk
  pdfextract            PDFExtract
  grobid                icecite
  Not all of these tools may work.  See /docs for more information."
  exit 0
fi


python3 ./evaluation/bin/extractor.py $3 --tools_dir "./evaluation/tools/data" --pdf_dir "$1" --output_dir "$2" --prefix_filter "" --suffix_filter ".pdf" --yy_filter "" --mm_filter "" --num_threads "-1" --timeout "300" --force "False" --mute "False" 


# orig call by Bast and Korzen:
#$(PYTHON) $(EXTRACTOR_SRC) \

#		$(TOOLS) \
#		--tools_dir "$(TOOLS_DIR)" \
#		--pdf_dir "$(PDF_DIR)" \
#		--output_dir "$(OUTPUT_DIR)" \
#		--prefix_filter "$(PREFIX)" \
#		--suffix_filter "$(PDF_EXT)" \
#		--yy_filter "$(YY)" \
#		--mm_filter "$(MM)" \
#		--num_threads "$(NUM_THREADS)" \
#		--timeout "$(TIMEOUT)" \
#		--force "$(FORCE)" \
#		--mute "$(MUTE)"
