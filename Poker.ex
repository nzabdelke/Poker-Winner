defmodule Poker do
  def poker_hand_category(both_hands) do
    both_hands |> Enum.max_by(&elem(&1, 1)) |> elem(1)
  end

  def card_num_parse(card) do
    card
    |> case do
      card when rem(card, 13) == 1 -> 14
      card when rem(card, 13) == 2 -> 2
      card when rem(card, 13) == 3 -> 3
      card when rem(card, 13) == 4 -> 4
      card when rem(card, 13) == 5 -> 5
      card when rem(card, 13) == 6 -> 6
      card when rem(card, 13) == 7 -> 7
      card when rem(card, 13) == 8 -> 8
      card when rem(card, 13) == 9 -> 9
      card when rem(card, 13) == 10 -> 10
      card when rem(card, 13) == 11 -> 11
      card when rem(card, 13) == 12 -> 12
      card when rem(card, 13) == 0 -> 13
    end
  end

  def card_num_parse2(card) do
    card
    |> case do
      card when rem(card, 13) == 1 -> 1
      card when rem(card, 13) == 2 -> 2
      card when rem(card, 13) == 3 -> 3
      card when rem(card, 13) == 4 -> 4
      card when rem(card, 13) == 5 -> 5
      card when rem(card, 13) == 6 -> 6
      card when rem(card, 13) == 7 -> 7
      card when rem(card, 13) == 8 -> 8
      card when rem(card, 13) == 9 -> 9
      card when rem(card, 13) == 10 -> 10
      card when rem(card, 13) == 11 -> 11
      card when rem(card, 13) == 12 -> 12
      card when rem(card, 13) == 0 -> 13
    end
  end

  def suit_classify(card) do
    card
    |> case do
      card when card in 1..13 -> "C"
      card when card in 14..26 -> "D"
      card when card in 27..39 -> "H"
      card when card in 40..52 -> "S"
    end
  end

  def hand_straight?([card1, card2, card3, card4, card5])
      when card1 == card2 - 1 and card1 == card3 - 2 and card1 == card4 - 3 and card1 == card5 - 4 do
    true
  end

  def hand_straight?([2, 3, 4, 5, 14]), do: true
  def hand_straight?(_), do: false

  def hand_flush?(player_hand) do
    [c1, c2, c3, c4, c5] = player_hand
    determine_suit = &suit_classify/1

    [c1_suit, c2_suit, c3_suit, c4_suit, c5_suit] = [
      determine_suit.(c1),
      determine_suit.(c2),
      determine_suit.(c3),
      determine_suit.(c4),
      determine_suit.(c5)
    ]

    case [c1_suit, c2_suit, c3_suit, c4_suit, c5_suit] do
      [suit, suit, suit, suit, suit] -> true
      _ -> false
    end
  end

  def hand_pair?(player_hand) do
    player_hand
    |> Enum.group_by(& &1)
    |> Map.values()
    |> Enum.map(fn x -> length(x) end)
    |> Enum.sort(&>/2)
  end

  def pow(x, y), do: pow(x, y, 1)
  def pow(_, 0, z), do: z
  def pow(x, y, z), do: pow(x, y - 1, x * z)

  def hand_rating([card1, card2, card3, card3, card4], 2) do
    card3 * pow(11, 5) + card4 * pow(11, 4) + card2 * pow(11, 3) + card1
  end

  def hand_rating([card1, card2, card2, card3, card4], 2) do
    card2 * pow(11, 5) + card4 * pow(11, 4) + card3 * pow(11, 3) + card1
  end

  def hand_rating([card1, card1, card2, card3, card4], 2) do
    card1 * pow(11, 5) + card4 * pow(11, 4) + card3 * pow(11, 3) + card2
  end

  def hand_rating([card1, card2, card3, card4, card4], 2) do
    card4 * pow(11, 5) + card3 * pow(11, 4) + card2 * pow(11, 3) + card1
  end

  def hand_rating([card1, card2, card2, card3, card3], 3) do
    card3 * pow(11, 4) + card2 * pow(11, 3) + card1
  end

  def hand_rating([card1, card1, card2, card3, card3], 3) do
    card3 * pow(11, 4) + card1 * pow(11, 3) + card2
  end

  def hand_rating([card1, card1, card2, card2, card3], 3) do
    card2 * pow(11, 4) + card1 * pow(11, 3) + card3
  end

  def hand_rating([card1, card2, card3, card3, card3], 4) do
    card3 * pow(11, 4) + card2 * pow(11, 3) + card1
  end

  def hand_rating([card1, card2, card2, card2, card3], 4) do
    card2 * pow(11, 4) + card3 * pow(11, 3) + card1
  end

  def hand_rating([card1, card1, card1, card2, card3], 4) do
    card1 * pow(11, 4) + card3 * pow(11, 3) + card2
  end

  def hand_rating([2, 3, 4, 5, 14], _) do
    5
  end

  def hand_rating([_, _, _, _, card5], category) when category in [9, 5] do
    card5
  end

  def hand_rating([card1, card1, card2, card2, card2], 7) do
    card2 * pow(11, 3) + card1
  end

  def hand_rating([card1, card1, card1, card2, card2], 7) do
    card1 * pow(11, 3) + card2
  end

  def hand_rating([card1, card2, card2, card2, card2], 8) do
    card2 * pow(11, 3) + card1
  end

  def hand_rating([card1, card1, card1, card1, card2], 8) do
    card1 * pow(11, 3) + card2
  end

  def hand_description(player_hand) do
    hand_destructured = player_hand |> Enum.map(&card_num_parse/1) |> Enum.sort()
    [card1, card2, card3, card4, card5] = hand_destructured

    cond do
      hand_flush?(player_hand) and hand_straight?(hand_destructured) and
          rem(Enum.reduce(hand_destructured, &(&1 + &2)), 13) == 8 ->
        {player_hand, 10, 1}

      hand_flush?(player_hand) and hand_straight?(hand_destructured) ->
        {player_hand, 9, hand_rating(hand_destructured, 9)}

      hand_pair?(hand_destructured) == [4, 1] ->
        {player_hand, 8, hand_rating(hand_destructured, 8)}

      hand_pair?(hand_destructured) == [3, 2] ->
        {player_hand, 7, hand_rating(hand_destructured, 7)}

      hand_flush?(player_hand) ->
        {player_hand, 6,
         card5 * pow(11, 6) + card4 * pow(11, 5) + card3 * pow(11, 4) + card2 * pow(11, 3) + card1}

      hand_straight?(hand_destructured) ->
        {player_hand, 5, hand_rating(hand_destructured, 5)}

      hand_pair?(hand_destructured) == [3, 1, 1] ->
        {player_hand, 4, hand_rating(hand_destructured, 4)}

      hand_pair?(hand_destructured) == [2, 2, 1] ->
        {player_hand, 3, hand_rating(hand_destructured, 3)}

      hand_pair?(hand_destructured) == [2, 1, 1, 1] ->
        {player_hand, 2, hand_rating(hand_destructured, 2)}

      true ->
        {player_hand, 1,
         card5 * pow(11, 6) + card4 * pow(11, 5) + card3 * pow(11, 4) + card2 * pow(11, 3) + card1}
    end
  end

  def score_winning(both_hands), do: both_hands |> Enum.max_by(&elem(&1, 2)) |> elem(2)

  def deal(both_hands) do
    determine_suit = &suit_classify/1
    determine_rank = &card_num_parse2/1

    hand2 = Enum.drop_every(both_hands, 2)
    hand1 = both_hands -- hand2
    both_hands = [hand1, hand2]
    hands_description_all = Enum.map(both_hands, &hand_description/1)
    poker_hand_category = poker_hand_category(hands_description_all)

    hand_winning =
      Enum.filter(hands_description_all, fn {_, x, _} -> x == poker_hand_category end)

    score_winning = score_winning(hand_winning)

    if length(hand_winning) == 2 and
         hand_winning |> Enum.at(0) |> elem(2) == hand_winning |> Enum.at(1) |> elem(2) do
      type = hand_winning |> Enum.at(0) |> elem(1)
      h1 = hand_winning |> Enum.at(0) |> elem(0)
      h1 = Enum.sort(h1, &(&1 > &2))
      h2 = hand_winning |> Enum.at(1) |> elem(0)
      h2 = Enum.sort(h2, &(&1 > &2))

      if type not in [4, 8, 7] and hd(h1) > hd(h2) do
        final_list =
          Enum.map(h1, fn x -> Integer.to_string(determine_rank.(x)) <> determine_suit.(x) end)

        Enum.sort_by(final_list, &{byte_size(&1), &1})
      else
        final_list =
          Enum.map(h2, fn x -> Integer.to_string(determine_rank.(x)) <> determine_suit.(x) end)

        Enum.sort_by(final_list, &{byte_size(&1), &1})
      end
    else
      [[c1, c2, c3, c4, c5]] =
        hand_winning
        |> Enum.filter(fn {_, _, x} -> x == score_winning end)
        |> Enum.map(fn {y, _, _} -> y end)

      list = [c1, c2, c3, c4, c5]

      final_list =
        Enum.map(list, fn x -> Integer.to_string(determine_rank.(x)) <> determine_suit.(x) end)

      Enum.sort_by(final_list, &{byte_size(&1), &1})
    end
  end
end
