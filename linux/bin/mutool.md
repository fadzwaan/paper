need mutpdf

extract text from pdf file. 
`mutool draw -F txt -o output.txt input.pdf`

extract images from pdf file
`mutool extract input.pdf`

convert pdf to images
`mutool draw -F png -o page%d.png input.pdf`

conver images to PDF
`convert image1.jpg image2.png output.pdf` need `sudo apt install imagemagick`
convert multiple images into one pdf.
`convert image1.jpg image2.png image3.bmp output.pdf`

conver multiple images into one page of one pdf.
`convert *.jpg output.pdf`

merge pdf files
`mutool merge -o output.pdf file1.pdf file2.pdf`

inspect pdf infomation
`mutool info input.pdf`

compress pdf
`mutool clean input.pdf output.pdf`

create pdf from text file
`enscript input.txt -o - | ps2pdf - output.pdf` need to install `sudo apt install enscript ghostscript`

convert markdown to pdf
`pandoc input.md -o output.pdf` , need to install `pandoc texlive-xetex`


convert html to pdf
`pandoc input.html -o output.pdf`

merge pdf
`pdfunite page1.pdf page2.pdf final.pdf`

