require "gettc/download"
include Gettc

require_relative "helper"

def filename(dir_name, prob_name)
  File.join(File.dirname(__FILE__), "../../data/#{dir_name}/#{prob_name}.htm")
end

def download_all(id, name, detail_url = nil, solution_url = nil)
  benchmark("Downloading #{name}") do
    write_unless_exists(filename("download_problem_statement", name)) do |file|
      file.write($robot.download_problem(id))
    end

    unless detail_url.nil?
      write_unless_exists(filename("download_problem_detail", name)) do |file|
        file.write($robot.download(detail_url))
      end
    end

    unless solution_url.nil?
      write_unless_exists(filename("download_problem_solution", name)) do |file|
        file.write($robot.download(solution_url))
      end
    end
  end
end

def main
  $robot = Downloader.new(Account.new("gettc", "algorithm"))

  download_all(10297, "CirclesCountry",
               "/tc?module=problemdetail&rd=13751&pm=10297",
               "/stat?c=problem_solution&cr=22504795&rd=13751&pm=10297")

  download_all(10329, "PageNumbers",
              "/tc?module=ProblemDetail&rd=13757&pm=10329",
              "/stat?c=problem_solution&cr=16063200&rd=13757&pm=10329")

  download_all(10685, "TheTournamentDivOne",
               "/tc?module=ProblemDetail&rd=13907&pm=10685")

  download_all(11120, "FunnyGames",
              "/tc?module=ProblemDetail&rd=14285&pm=11120")

  download_all(10737, "BuildingRoads",
               "/tc?module=ProblemDetail&rd=14153&pm=10737")

  download_all(4589, "Acronyms",
               "/tc?module=ProblemDetail&rd=7225&pm=4589")

  download_all(6620, "BackyardTrees",
               "/tc?module=ProblemDetail&rd=10008&pm=6620")

  download_all(520, "Bits",
               "/tc?module=ProblemDetail&rd=5852&pm=520")

  download_all(2412, "CircularSequence")
  download_all(10380, "PalindromeFactory")
  download_all(10638, "TwistedMatrix")
  download_all(358, "Checker")
end

$robot = Downloader.new(Account.new("gettc", "algorithm"))
response = $robot.download("https://community.topcoder.com/stat?c=problem_solution&cr=22504795&rd=13751&pm=10297")
File.open("solution.html", "w") { |file| file.write(response) }
