import gleam/hackney
import gleam/http/request
import gleam/result.{try}
import scraper/internal

const top_url = "https://steam250.com/7day"

pub fn scrape_games() -> Result(List(String), hackney.Error) {
  let assert Ok(request) = request.to(top_url)
  use response <- try(request |> hackney.send)
  let assert 200 = response.status
  response.body |> internal.parse_links |> Ok
}
