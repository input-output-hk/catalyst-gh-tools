#!/bin/sh -l
pwd
ls -al
echo /bin/mdbook $@
/bin/mdbook $@
ls -al book
ls -al book/html
ls -al book/linkcheck