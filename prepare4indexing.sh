# A shell script used to prepare the corpus files for indexing.
# Generates word lists, annotates them, runs a convertor and puts
# the resulting JSON files to the appropriate folder.
START_TIME="$(date -u +%s)"
cd src_convertors/corpus/standard_dargwa/txt
python concordancer.py
echo "Word list generated."
cd ..

# Udmurt morphology
# rm -rf uniparser-grammar-udm
# git clone https://github.com/timarkh/uniparser-grammar-udm.git
# cd uniparser-grammar-udm
# echo "Grammar repository cloned."
# cp udmurt_disambiguation.cg3 ..
mv txt/wordlist.csv wordlist.csv
# cp ../analyze_udmurt_wordlist.py .
echo "Source files moved."
python analyze_dargwa_wordlist.py
# mv analyzed.txt ../dar_wordlist.csv-parsed.txt
# mv unanalyzed.txt ../dar_wordlist.csv-unparsed.txt
echo "Dargwa word list analyzed."
cd ..
# rm -rf uniparser-grammar-udm
cd ..

# Conversion to Tsakorpus JSON
python txt2json.py
echo "Source conversion ready."
# rm corpus/udm_wordlist.csv-parsed.txt
# rm corpus/udmurt_disambiguation.cg3
rm -rf ../corpus/standard_dargwa
mkdir -p ../corpus/standard_dargwa
mv corpus/standard_dargwa/json ../corpus/standard_dargwa
# rm -rf corpus/cg
# rm -rf corpus/cg_disamb
# rm -rf corpus/json
END_TIME="$(date -u +%s)"
ELAPSED_TIME="$(($END_TIME-$START_TIME))"
echo "Corpus files prepared in $ELAPSED_TIME seconds, finishing now."