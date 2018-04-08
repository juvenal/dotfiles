# Configure brew perl5 CPAN local library

PATH="${HOME}/.cpan_perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="${HOME}/.cpan_perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="${HOME}/.cpan_perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"${HOME}/.cpan_perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=${HOME}/.cpan_perl5"; export PERL_MM_OPT;
