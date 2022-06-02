# before you're able to run powershell scripts, may need to change execution policy:
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.2

# specify fully qualified filepath to directory containing .docx files to be converted.
$documents_path = 'C:\Users\JPeterson\OneDrive - Excel Engineering, Inc\documents\repos\pdf_converter\files_to_convert'

$word_app = New-Object -ComObject Word.Application

# This filter will find .doc as well as .docx documents
Get-ChildItem -Path $documents_path -Filter *.doc? | ForEach-Object {

    $document = $word_app.Documents.Open($_.FullName)

    $pdf_filename = "$($_.DirectoryName)\$($_.BaseName).pdf"

    $document.SaveAs([ref] $pdf_filename, [ref] 17)

    $document.Close()
}

$word_app.Quit()