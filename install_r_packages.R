options(unzip = 'internal') # not sure it is necessary, put it here after looking at https://github.com/r-lib/devtools/issues/1722#issuecomment-370019534
options(install.packages.compile.from.source = 'always')
update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')

install.packages('psych',repos = 'http://cran.us.r-project.org')
install.packages('sp',repos = 'http://cran.us.r-project.org')