defmodule Intcode.EngineTest do
  use ExUnit.Case, async: true
  alias Intcode.Engine

  test "load params" do
    params = [{7,1,:in}, {0,0,:in}]
    assert Engine.load_params(params, %{0 => 99}) == [7, 99]
  end
end
