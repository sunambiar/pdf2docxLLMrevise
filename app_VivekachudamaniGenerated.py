
import os
from flask import Flask, render_template, request, send_file
from docx import Document
from language_tool_python import LanguageTool
import pdfplumber
from viveka_grammar_correction import extract_paragraphs_with_sanskrit, correct_non_sanskrit_paragraphs, save_to_word, vivekachudamani_correct

app = Flask(__name__)
pdf_folder = os.getenv("PDF_FOLDER", "uploads")
docx_folder = os.getenv("DOCX_FOLDER", "docs")

# ... (rest of the code remains unchanged)


#from flask import Flask, render_template, request, send_file
#import os
#import subprocess
#import pdfplumber
#from docx import Document
#from language_tool_python import LanguageTool
#import re
#from viveka_grammar_correction import extract_paragraphs_with_sanskrit, correct_non_sanskrit_paragraphs, save_to_word

app = Flask(__name__)
pdf_folder = "uploads"
docx_folder = "docs"

if not os.path.exists(pdf_folder):
    os.makedirs(pdf_upload)
if not os.path.exists(docx_folder):
    os.makedirs(docx_folder)

def process_pdfs():
    pdfs = [f for f in os.listdir(pdf_folder) if os.path.isfile(os.path.join(pdf_folder, f))]

    for pdf in pdfs:
        with pdfplumber.open(os.path.join(pdf_folder, pdf)) as pdf_file:
            paragraphs = extract_paragraphs_with_sanskrit(os.path.join(pdf_folder, pdf))

            corrected_paragraphs = correct_non_sanskrit_paragraphs(paragraphs)
            docx_output_path = os.path.join(docx_folder, f"{os.path.splitext(pdf)[0]}.docx")
            save_to_word(corrected_paragraphs, docx_output_path)

            print(f"Processed {pdf} and saved as {docx_output_path}")

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        if "files" not in request.files:
            return render_template("index.html", error="No files part")

        uploaded_files = request.files["files"]

        for file in uploaded_files:
            filename = file.filename
            filepath = os.path.join(pdf_folder, filename)

            file.save(filepath)

    process_pdfs()

    return render_template("index.html", files=[f for f in os.listdir(pdf_folder)])

@app.route("/generate_docx/<string:filename>")
def generate_docx(filename):
    docx_path = os.path.join(docx_folder, filename)

    if not os.path.exists(docx_path):
        return render_template("404.html")

    return send_file(docx_path, as_attachment=True, attachment_filename=f"Processed_{os.path.splitext(filename)[0]}.docx")

if __name__ == "__main__":
    app.run(debug=True)



