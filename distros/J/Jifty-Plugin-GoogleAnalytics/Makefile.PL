use inc::Module::Install;
name('Jifty-Plugin-GoogleAnalytics');
license('perl');
version_from('lib/Jifty/Plugin/GoogleAnalytics.pm');
requires('Jifty');
requires('Text::OutputFilter');
build_requires('Test::More');
auto_install();
#install_share;
WriteAll;
