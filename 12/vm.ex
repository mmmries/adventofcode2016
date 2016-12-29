defmodule Vm do
  def run(instruction_str) do
    Vm.execute(Vm.init(), Vm.parse(instruction_str))
  end

  def init, do: %{a: 0, b: 0, c: 0, d: 0, ins: 0}

  def execute(state=%{ins: ins}, instructions) do
    instruction = Enum.at(instructions, ins)
    execute(state, instructions, instruction)
  end

  def execute(state, _instructions, nil), do: state
  def execute(state, instructions, {:cpy, int, addr}) when is_integer(int) do
    state = Map.put(state, addr, int)
    state = Map.put(state, :ins, state.ins + 1)
    execute(state, instructions)
  end
  def execute(state, instructions, {:cpy, source, dest}) do
    state = Map.put(state, dest, Map.get(state, source))
    state = Map.put(state, :ins, state.ins + 1)
    execute(state, instructions)
  end
  def execute(state, instructions, {:inc, addr}) do
    state = Map.put(state, addr, Map.get(state, addr) + 1)
    state = Map.put(state, :ins, state.ins + 1)
    execute(state, instructions)
  end
  def execute(state, instructions, {:dec, addr}) do
    state = Map.put(state, addr, Map.get(state, addr) - 1)
    state = Map.put(state, :ins, state.ins + 1)
    execute(state, instructions)
  end
  def execute(state, instructions, {:jnz, 0, _diff}) do
    state = Map.put(state, :ins, state.ins + 1)
    execute(state, instructions)
  end
  def execute(state, instructions, {:jnz, int, diff}) when is_integer(int) do
    state = Map.put(state, :ins, state.ins + diff)
    execute(state, instructions)
  end
  def execute(state, instructions, {:jnz, addr, diff}) do
    case Map.get(state, addr) do
      0 ->
        state = Map.put(state, :ins, state.ins + 1)
        execute(state, instructions)
      _ ->
        state = Map.put(state, :ins, state.ins + diff)
        execute(state, instructions)
    end
  end

  def parse(str) do
    str
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction("inc "<>reg), do: {:inc, register(reg)}
  defp parse_instruction("dec "<>reg), do: {:dec, register(reg)}
  defp parse_instruction("cpy "<>args) do
    [arg1, arg2] = String.split(args)
    {:cpy, register_or_integer(arg1), register(arg2)}
  end
  defp parse_instruction("jnz "<>args) do
    [arg1, arg2] = String.split(args)
    {:jnz, register_or_integer(arg1), String.to_integer(arg2)}
  end

  defp register_or_integer("a"), do: :a
  defp register_or_integer("b"), do: :b
  defp register_or_integer("c"), do: :c
  defp register_or_integer("d"), do: :d
  defp register_or_integer(str), do: String.to_integer(str)

  defp register("a"), do: :a
  defp register("b"), do: :b
  defp register("c"), do: :c
  defp register("d"), do: :d
end
