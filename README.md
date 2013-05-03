## Description

This project provides two big tables of predefined combinations for
Vietnamese Telex/VNI users. It also focus on `UIM` support.

## Tables

Originally there are two tables `Telex.txt.in` and `VNI.txt.in`. We now
have a script `telex2vni` to generate the `VNI` table so you can only
see one table `Telex.txt.in` in the source tree.

To modifty the table, please refer to `./src/README.md`.

## Usage

See an example in `src/Makefile`.

The main script is `bin/scim2uim.rb` which converts the tables to `UIM`
support. The commands

````
$ cat ./src/Telex.txt.in \
  | ./bin/upcase.awk \
  | sort -u \
  | ./bin/sort.rb \
  | ./bin/scim2uim.rb --telex

$ cat ./src/Telex.txt.in \
  | ./bin/telex2vni.rb \
  | ./bin/upcase.awk \
  | sort -u \
  | ./bin/sort.rb \
  | ./bin/scim2uim.rb --vni
````

will generate the file `xtelex.scm` and `xvni.scm` that can be used in `uim`.
Because the current version of `uim` doesn't load them dynamically, you
need to edit the files `loaded.scm` and `installed-modules.scm` in your
`uim` distribution to add new tables.

## Important notes

The old tables contain all available combinations and this requires a lot
of time to maintain the table. Since the version `v1.0.0` the tables only
contain the lowercase combinations. These tables are still working with
the old script `scim2uim`, however you need to run the script `upcase`
to get all kind of combinations (`lowercase`, `Uppercase` and `UPPERCASE`.)

## Authors

* **Huy Ngo** from `TheSLinux`
* **Ky-Anh Huynh** from `TheSLinux`
* **Thach-Anh Tran** (aka myquartz at gmail dot com) _(the original author)_

## License

GPL version 2

## History

The tables originally comes from the project `scim-tables-vietnamese-ext`,
which only provide supports for `Scim`. They can be found on the branch
`scim` of this project. They are not actively maintained.

See also below.

## Original source

The information comes from the output of the command `git svn info`.

* URL: http://scim-tables-vietnamese-ext.googlecode.com/svn/trunk
* Repository Root: http://scim-tables-vietnamese-ext.googlecode.com/svn
* Repository UUID: b66c17aa-bc50-0410-a4c1-9f63618b1265
* Revision: 24
* Last Changed Author: myquartz
* Last Changed Rev: 24
* Last Changed Date: 2010-04-12 07:41:54 +0000 (Mon, 12 Apr 2010)
