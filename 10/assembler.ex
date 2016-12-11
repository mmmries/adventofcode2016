defmodule Assembler do
  def run(str) do
    state = %{bots: %{}, outputs: %{}, comparisons: [], instructions: %{}, chip_queue: []}
    instructions = str |> parse_instructions |> Enum.group_by(&( elem(&1, 0) ))
    state = Enum.reduce(instructions[:compare_instruction], state, &run_instruction/2)
    Enum.reduce(instructions[:value_goes_to], state, &run_instruction/2)
  end

  def contents_of_bin(%{outputs: bins}, id), do: Map.get(bins, id)

  def who_compared(%{comparisons: comparisons}, {min,max}) do
    {bot_id, _, _} = Enum.find(comparisons, &( elem(&1,1) == min && elem(&1,2) == max ))
    bot_id
  end

  def parse_address("output "<>id), do: {:output, id}
  def parse_address("bot "<>id), do: {:bot, id}

  defp parse_instructions(str) do
    str
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction("value "<>str) do
    [_, value, bot_id] = Regex.run(~r{(\d+) goes to bot (\d+)\Z}, str)
    {:value_goes_to, String.to_integer(value), bot_id}
  end
  defp parse_instruction("bot "<>str) do
    [_, bot_id, low_address, high_address] = Regex.run(~r{(\d+) gives low to (.+) and high to (.+)\Z}, str)
    {:compare_instruction, bot_id, parse_address(low_address), parse_address(high_address)}
  end

  defp run_instruction({:value_goes_to, chip, bot_id}, %{bots: bots}=state) do
    chips = Map.get(bots, bot_id, [])
    chips = [chip | chips]
    handle_chips(state, bot_id, chips)
  end
  defp run_instruction({:compare_instruction, bot_id, low_address, high_address}, state) do
    instructions = Map.put(state.instructions, bot_id, {low_address, high_address})
    Map.put(state, :instructions, instructions)
  end

  defp handle_chips(state, bot_id, [chip]) do
    bots = Map.get(state, :bots)
    bots = Map.put(bots, bot_id, [chip])
    Map.put(state, :bots, bots)
  end
  defp handle_chips(state, bot_id, [a, b]) do
    [min, max] = Enum.sort([a,b])
    state = Map.put(state, :comparisons, [{bot_id, min, max} | state.comparisons])
    {low_address, high_address} = get_in(state, [:instructions, bot_id])
    state
    |> distribute(min, low_address)
    |> distribute(max, high_address)
    |> put_in([:bots, bot_id], [])
  end

  defp distribute(state, chip, {:output, id}), do: put_in(state, [:outputs, id], chip)
  defp distribute(state, chip, {:bot, id}), do: run_instruction({:value_goes_to, chip, id}, state)
end
