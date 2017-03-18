defmodule Overpex.HTTP do
  def post(query, options \\ %{}) do
    options = Map.merge(Overpex.Config.default, options)

    apply(options[:adapter], :post, [options[:url], query])
  end
end
