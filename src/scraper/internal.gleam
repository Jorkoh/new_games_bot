import gleam/list
import gleam/string

pub fn parse_links(raw: String) -> List(String) {
  parse_links_impl(raw, [], 0)
}

fn parse_links_impl(
  remaining: String,
  acc: List(String),
  count: Int,
) -> List(String) {
  // Skip into next link
  case remaining |> string.crop("class=store") {
    "class=store" <> remaining -> {
      let remaining = remaining |> string.crop("https:")
      let new_link = take_until(remaining, "?")
      let remaining = string.drop_left(remaining, string.length(new_link))
      parse_links_impl(remaining, [new_link, ..acc], count + 1)
    }
    // Didn't find a next link
    _ -> acc |> list.reverse
  }
}

/// Returns a subsequence of [string] from start until [limit] grapheme (not included)
fn take_until(string: String, limit: String) -> String {
  let assert 1 = string.length(limit)
  take_until_impl(string, limit, "")
}

fn take_until_impl(remaining: String, limit: String, acc: String) -> String {
  case remaining |> string.pop_grapheme {
    Error(_) -> acc
    Ok(#(g, _)) if g == limit -> acc
    Ok(#(g, rest)) -> take_until_impl(rest, limit, acc <> g)
  }
}
