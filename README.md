# PDF-FDF

PDF-FDF is a Ruby library and command line tool (`pdffdf`) to help
generate the FDF files necessary to fill out forms present in PDFs.

It's especially useful in conjunction with the [pdftk] tool.

[pdftk]: http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/

## Typical Workflow

In the following examples the file `input.pdf` is the original PDF
with form fields, `output.pdf` will be the generated PDF with form
fields filled out.

  1. Create a YAML file that contains all the form fields:

        pdftk input.pdf dump_data_fields | pdffdf -ln > fields.yml

     This will generate a YAML file that contains all the form fields.
     Additionally each field will be given a unique value starting
     with 0 so that you can visually identify the form fields in a
     test PDF.

  2. Generate a test PDF so you can figure out which form fields have
     which names:

        pdffdf -g fields.yml > test.fdf
        pdftk input.pdf fill_form test.fdf output output.pdf flatten

  3. Open the `test.pdf` file and the `fields.yml` file.  Using the
     `test.pdf` file as a guide give a meaningful name in the `alias`
     field for each of the form fields you care about.

  4. Remove the generated form field values:

        grep -v ' value:' fields.yml > master.yml

  5. Fill out values for the form fields.  You can set the values
     directly in the `master.yml` file however I recommend that you
     create a new YAML file that only contains the fields you are
     interested in filling out.  PDF-FDF can merge an unlimited number
     of YAML files into a single form field set.  For this example
     we'll say that you created a new file called `myfields.yml` that
     is based on the `master.yml` file.  Also note that in your
     `myfields.yml` file you only need to specify two keys for each
     form field: `alias` and `value`.  The other values will be found
     while merging with `master.yml`.

  6. Create your filled out PDF:

        pdffdf -g master.yml myfields.yml > form.fdf
        pdftk input.pdf fill_form form.fdf output output.pdf flatten
