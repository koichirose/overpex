defmodule Overpex.ParserTest do
  use ExUnit.Case
  import Mock

  test "parser/1 XML" do
    with_mock Overpex.Parser.XML, [parse: fn(_response) -> {:ok, %Overpex.Response{}} end] do
      assert {:ok, %Overpex.Response{}} = Overpex.Parser.parse({:ok, {:xml, ""}})
      assert called Overpex.Parser.XML.parse("")
    end
  end

  test "parser/1 JSON" do
    with_mock Overpex.Parser.JSON, [parse: fn(_response) -> {:ok, %Overpex.Response{}} end] do
      assert {:ok, %Overpex.Response{}} = Overpex.Parser.parse({:ok, {:json, ""}})
      assert called Overpex.Parser.JSON.parse("")
    end
  end

  test "parser/1 Overpex.Error" do
    assert {:error, %Overpex.Error{}} = Overpex.Parser.parse({:error, %Overpex.Error{}})
  end

  test "parser/1 error string" do
    assert {:error, %Overpex.Error{reason: "Error"}} = Overpex.Parser.parse({:error, "Error"})
  end
end
