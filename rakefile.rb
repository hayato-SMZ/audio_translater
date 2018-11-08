#! ruby
# coding: utf-8

task :default

def file_convert basefile, destFile, option=""
  sh "sox #{basefile} #{option} #{destFile}"
end

def make_mono basefile, destFile
  sh "sox #{basefile} #{destFile} remix 1,2"
end

def auto_sprit basefile, destFile
  sh "sox #{basefile} #{destFile} silence 1 0.1 0.01% 1 0.5 0.03%: newfile : restart"
end

def vol_setting target_file, dest_file option="1"
  sh "sox -v #{option} #{target_file} #{dest_file}"
end



Dir.glob("./target/**/**.wav").each do |targetFile|
  destFile = targetFile.gsub(/target/,"response")
  FileUtils.mkdir_p(File.expand_path(File.dirname(destFile)))
  task :file2mp3 do
    # puts destFile.gsub(/#{File.exname(targetFile)}/,".mp3")
    file_convert targetFile, destFile.gsub(/#{File.extname(targetFile)}/,".mp3")
  end
  
  task :makemonomp3 do
    tmpfile = targetFile.gsub(/(#{File.extname(targetFile)})/,'_\1')
    make_mono targetFile, tmpfile
    file_convert tmpfile, destFile.gsub(/#{File.extname(targetFile)}/,".mp3"), "-C 128.2"
    File.delete(tmpfile)
  end
  
  task :splitFile do
    auto_sprit targetFile, destFile
  end
  
  task :set_volandmono do
    tmpfile = targetFile.gsub(/(#{File.extname(targetFile)})/,'_\1')
    vol_setting targetFile, tmpfile, ARGV.last
    make_mono tmpfile, destFile
    File.delete(tmpfile)
  end

end

task :mp3 => :file2mp3

task :monomp3 => :makemonomp3

task :split =>:splitFile
