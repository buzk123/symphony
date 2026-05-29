defmodule SymphonyElixir.LocalShell do
  @moduledoc false

  @spec find(String.t()) :: String.t() | nil
  def find("bash") do
    [windows_git_executable("bash.exe"), System.find_executable("bash")]
    |> Enum.find(&valid_executable?/1)
  end

  def find("sh") do
    [System.find_executable("sh"), windows_git_executable("sh.exe")]
    |> Enum.find(&valid_executable?/1)
  end

  def find(executable) when is_binary(executable) do
    System.find_executable(executable)
  end

  defp windows_git_executable(executable) do
    if windows?() do
      ["C:/Program Files/Git/usr/bin", "C:/Program Files/Git/bin"]
      |> Enum.map(&Path.join(&1, executable))
      |> Enum.find(&File.regular?/1)
    end
  end

  defp valid_executable?(path) when is_binary(path), do: File.regular?(path)
  defp valid_executable?(_path), do: false

  defp windows? do
    match?({:win32, _}, :os.type())
  end
end
