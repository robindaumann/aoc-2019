defmodule Day04Test do
  use ExUnit.Case

  test "input part1" do
    assert Day04.part1("183564-657474") == 1610
  end

  test "input part2" do
    assert Day04.part2("183564-657474") == 1104
  end

  test "pw criteria?" do
    assert Day04.pw_criteria?("123445")
  end

  test "pw criteria? 2" do
    assert Day04.pw_criteria?("1223445")
  end

  test "pw criteria? bad" do
    assert Day04.pw_criteria?("123443") == false
  end

  test "repitition?" do
    assert Day04.repitition?("aa")
  end

  test "repitition? two doubles" do
    assert Day04.repitition?("aabcdefgg")
  end

  test "repitition? no double" do
    assert Day04.repitition?("123456789") == false
  end

  test "repitition? empty" do
    assert Day04.repitition?("") == false
  end

  test "repitition? one" do
    assert Day04.repitition?("1") == false
  end

  test "repitition? middle tripple" do
    assert Day04.repitition?("12345666789") == true
  end

  test "increases empty" do
    assert Day04.increases?("")
  end

  test "increases" do
    assert Day04.increases?("123")
  end

  test "increases with steady" do
    assert Day04.increases?("1223")
  end

  test "decreases" do
    assert Day04.increases?("987") == false
  end

  test "decrease after increase" do
    assert Day04.increases?("1234501") == false
  end

  test "double?" do
    assert Day04.double?("aa", 0, 0)
  end

  test "double? tripple" do
    assert Day04.double?("123444", 0, 0) == false
  end

  test "double? multiple" do
    assert Day04.double?("112233", 0, 0)
  end

  test "double? double and tripple" do
    assert Day04.double?("111122", 0, 0)
  end

  test "double? empty" do
    assert Day04.double?("", 0, 0) == false
  end
end
