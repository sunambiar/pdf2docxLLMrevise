
docker build -t vivekachudamani .

docker run -it --rm -v $(pwd):/app vivekachudamani

exit 

docker run -it --rm \
  -v $(pwd):/app \
  -p 5800:5800 \
  -e PDF_FOLDER=uploads \
  -e DOCX_FOLDER=docs \
  vivekachudamani

exit




b. Build the Docker image:
docker build -t viveka_grammar_correction .


c. Run the Docker container:
docker run -it --rm -v $(pwd):/app viveka_grammar_correction
This will process the provided PDF, preserve Sanskrit verses, correct grammar in non-Sanskrit paragraphs, and save the result as a Word document named corrected_output.docx within the current directory. The Docker image can be reused for similar tasks by mounting the input PDF and specifying the output Word file path when running the container.



pip install pdfplumber docx language-tool-python


