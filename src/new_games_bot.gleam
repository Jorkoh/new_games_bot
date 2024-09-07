import gleam/int
import gleam/io
import gleam/list
import gleam/result
import scraper/scraper

pub fn main() {
  let games = scraper.scrape_games() |> result.unwrap([])
  io.println("FOUND " <> { games |> list.length |> int.to_string } <> ":")
  list.each(games, io.println)
}
