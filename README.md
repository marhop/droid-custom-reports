Custom template and stylesheet for [DROID] reports. Useful for me, but your
mileage may vary.

# Report template

The template `report_template.xml` is based on the 'File count and sizes by
file format PUID' report shipped with DROID but displays not only the PUIDs
but also their respective file format names.

# Report stylesheet

The stylesheet `stylesheet.html.xsl` can be used to export a report to HTML
similar to the 'Web page' stylesheet shipped with DROID but tries to be more
readable by presenting a little less detail and using a different structure
than the default 'Web page':

  * The report structure is based on profiles rather than report items. Where
    the default stylesheet has a table for each report item and in this table
    an entry for each profile, this custom stylesheet has a section for each
    profile and in this section a table for each report item. It's more or
    less the default stylesheet vice versa. This structure looks a little
    cleaner to my eyes, particularly if only one profile (like the default
    'Untitled-1') is used.
  * Only average file size is displayed, no sum, max or min values.
  * No filter definitions are displayed.

# Installation

DROID looks for templates and stylesheets in the `.droid6/report_definitions/`
directory right inside the user home directory, which is `~` on Linux and
something like `C:\Users\USERNAME\\` on Windows.

So copy and rename the files to something you recognize. For example:

 1. Rename the `report_template.xml` file to `File formats by PUID and format
    name.xml` and put it into a new directory called
    `~/.droid6/report_definitions/File formats by PUID and format name/`.
 2. Rename the `stylesheet.html.xsl` file to `Web page 2.html.xsl` and put it
    directly into `~/.droid6/report_definitions/`.

(Did I indicate that I don't like spaces in file names? But that's the way the
report definitions are organized by DROID. So when in Rome, visit the
Colosseum or whatever.)

[DROID]: https://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/

