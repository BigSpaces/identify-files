defmodule IdentifyFiles.Utilities do
  @doc """

  Retrieves the files and directories for the directory that is passed as an argument
  Splits the contents of that directory by type {dirs, files}
  Goes through each sub-directory, adding the list of files found in each sub-directory

  """
  def init() do
    IO.gets("Directory to explore?\n") |> String.trim() |> get_files()
  end

  def init2() do
    dir = IO.gets("Directory to explore?\n")
    get_files2([String.trim(dir)],[])
  end

  def add_directory(directory) do
    fn file -> Path.join(directory, file) end
  end

  def get_files(directory) do

    files_and_dirs =
      directory
      |> File.ls!()
      |> Enum.map(add_directory(directory))



    {dirs, files} = Enum.split_with(files_and_dirs, &File.dir?/1)

    files ++ Enum.map(dirs, &get_files(&1))
  end

  def get_files2([], acc_files), do: List.flatten(acc_files)

  def get_files2([dir | remaining_dirs], acc_files) do

    files_and_dirs =
      dir
      |> File.ls!()
      |> Enum.map(add_directory(dir))

    {dirs, files} = Enum.split_with(files_and_dirs, &File.dir?/1)

    get_files2(dirs ++ remaining_dirs, acc_files ++ files)
  end
end
