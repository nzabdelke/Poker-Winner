ExUnit.start()

defmodule Poker_Tests do
  use ExUnit.Case

  test "test1" do
    assert Poker.deal([28, 3, 15, 16, 4, 42, 17, 48, 43, 22]) == ["2D", "2H", "4C", "4D", "4S"]
  end

  test "test2" do
    assert Poker.deal([31, 2, 5, 42, 45, 47, 46, 21, 26, 23]) == ["2C", "3S", "8D", "8S", "10D"]
  end

  test "test3" do
    assert Poker.deal([18, 2, 8, 5, 48, 20, 50, 47, 1, 38]) == ["1C", "5D", "8C", "9S", "11S"]
  end

  test "test4" do
    assert Poker.deal([15, 16, 9, 19, 40, 20, 27, 23, 1, 25]) == ["3D", "6D", "7D", "10D", "12D"]
  end

  test "test5" do
    assert Poker.deal([17, 16, 45, 19, 35, 33, 38, 25, 12, 51]) == ["4D", "6S", "9H", "12C", "12H"]
  end

  test "test6" do
    assert Poker.deal([8, 20, 49, 41, 13, 18, 35, 42, 43, 1]) == ["1C", "2S", "3S", "5D", "7D"]
  end

  test "test7" do
    assert Poker.deal([5, 7, 14, 31, 18, 21, 1, 23, 9, 52]) == ["1C", "1D", "5C", "5D", "9C"]
  end

  test "test8" do
    assert Poker.deal([29, 38, 33, 23, 45, 11, 13, 15, 50, 47]) == ["3H", "6S", "7H", "11S", "13C"]
  end
end
