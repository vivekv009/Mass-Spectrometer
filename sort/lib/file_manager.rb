require 'tmpdir'
require 'zip/zipfilesystem'

module FileManager

  LOW_SPACE = 1024 * 2 #mb

  def unzip(zip_file)

    files = []
    Zip::ZipFile.open(zip_file.path) do |contents|
      contents.each do |entry|
        if entry.directory?
          next
        end

        destination = Dir.mktmpdir('')
        entry_path = File.join(destination, entry.name)

        if (not File.exists?(entry_path))
          contents.extract(entry, entry_path)
        end

        files << File.new(entry_path, "r")

      end
    end
    files
  end

  def merge_files(file_list)
    all_content = []
    file_list.each do |file|
      all_content << file.read()
    end
    temp = Tempfile.new(['merged','.mgf'])
    temp << all_content.join("\n")
    temp.rewind
    return temp
  end

  #def mergeFiles(file_list, merged_file)
  #
  #
  #  File::open(merged_file, 'w') do |fout|
  #    file_list.each do |path|
  #      File::open(path, 'r') do |f|
  #        f.each_line do |line|
  #          fout.puts line
  #        end
  #      end
  #    end
  #  end
  #
  #  merged_file
  #
  #end

  def space_available_mb
    require 'sys/filesystem'

    stat = Sys::Filesystem.stat("/")
    mb_available = stat.block_size * stat.blocks_available / 1024 / 1024
  end

  def low_space?

   space = space_available_mb
   space < LOW_SPACE

  end

end
