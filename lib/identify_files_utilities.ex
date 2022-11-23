defmodule IdentifyFiles.Utilities do
  def get_files(directory) do
File.ls(directory)
  end
end
