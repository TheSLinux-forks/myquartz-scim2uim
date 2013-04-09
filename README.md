## Description

This package originally comes from the project `scim-tables-vietnamese-ext`
which provides a comprehensive table for Vietnamese words to use in `Scim`.
The project's author  is **Thach-Anh Tran** (aka myquartz at gmail dot com).

I did ask the author to support this table in `uim`; however he seems to
switch to use `Ibus` and the project is quite inactive. Because the table
is quite useful I decide to convert and maintain it to use in `UIM`.

The main script is `bin/scim2uim.rb` which is very simple. The command

````
./bin/scim2uim.rb < ./src/Telex.txt.in > ./src/xtelex.scm
````

will generate the file `xtelex.scm` which is ready to be used in `uim`.
However, `uim` need some patches to use that module. Please check example
in the package `uim-vi` from `TheSLinux`.

## Original source

The information comes from the output of the command `git svn info`.

* URL: http://scim-tables-vietnamese-ext.googlecode.com/svn/trunk
* Repository Root: http://scim-tables-vietnamese-ext.googlecode.com/svn
* Repository UUID: b66c17aa-bc50-0410-a4c1-9f63618b1265
* Revision: 24
* Last Changed Author: myquartz
* Last Changed Rev: 24
* Last Changed Date: 2010-04-12 07:41:54 +0000 (Mon, 12 Apr 2010)
