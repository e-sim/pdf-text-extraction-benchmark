#!/bin/bash

# auth Erica Sim, 2019 
# this script is to assist in running the extractor 
# the extractor is for running text extraction on a batch of pdfs
# this needs to be run from /projects/pdf_eval/code/pdf-text-extraction-benchmark
# (or wherever the main pdf-extraction folder is)
# expected input: folder full of .pdfs
# expected output: folder full of .txts with extracted plain text
# useage:


# my orig call: python3 ./bin/extractor.py pdftotext --tools_dir "./tools/data" --output_dir "./output/test-data" --pdf_dir "../benchmark/pdf/test-data/"

# TODO: make normal call, allow it to run more than one! add possibility of other flags, make help message list of tools

# for consideration: The variable $# reports the number of command line arguments passed to the shell script program.

python3 ./evaluation/bin/extractor.py --tools_dir "/projects/pdf_eval/code/pdf-text-extraction-benchmark/evaluation/tools/" --pdf_dir $1 --output_dir $2 $3

# to possibly add: --suffix_filter ".pdf" --num_threads "-1" [quotes needed???] --timeout "300" 

# empty ones (don't know if i need to add): --prefix_filter, --yy_filter, --mm_filter, --force --mute

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
