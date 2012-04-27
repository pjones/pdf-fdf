################################################################################
$:.unshift(File.expand_path('lib', File.dirname(__FILE__)))
require('pdf/fdf/version')

################################################################################
Gem::Specification.new do |gem|
  gem.name         = 'pdf-fdf'
  gem.version      = PDF::FDF::VERSION
  gem.platform     = Gem::Platform::RUBY
  gem.authors      = ['Peter Jones']
  gem.email        = ['pjones@pmade.com']
  gem.homepage     = 'http://github.com/pjones/pdf-fdf'
  gem.summary      = 'Library and command line tool for generating FDFs.'
  gem.description  = File.read('README.md')
  gem.files        = Dir.glob('{bin,lib}/**/*') + %w(README.md LICENSE.md)
  gem.executables  = ['pdffdf']
  gem.require_path = 'lib'
end
