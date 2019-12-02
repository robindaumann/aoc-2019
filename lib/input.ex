defmodule Input do
  defmacro path do
    quote do
      Path.join([File.cwd!, "input", Path.basename(__ENV__.file, "_test.exs") <> ".txt"])
    end
  end
end
