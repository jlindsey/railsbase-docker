#!/usr/bin/env ruby
require 'fileutils'

Dir[File.join(ENV['APP_PRE_START_SCRIPTS_LOCATION'], '*.sh')].each do |script_file|
  dest = File.join('', 'etc', 'my_init.d', "99_#{File.basename(script_file)}")
  puts "Copying #{script_file} -> #{dest}"
  FileUtils.cp script_file, dest
end

