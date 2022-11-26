defmodule IdentifyFiles.Performance do
  def performance_test do
    Benchee.run(%{
      "recursive" => fn -> IdentifyFiles.Utilities.get_files(".") end,
      "tail recursive" => fn -> IdentifyFiles.Utilities.get_files2(["."], []) end
    })
  end
end
