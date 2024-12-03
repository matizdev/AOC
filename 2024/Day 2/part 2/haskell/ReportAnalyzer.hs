import System.IO

-- Function to check if a list of levels is safe
isSafe :: [Int] -> Bool
isSafe levels = isIncreasing || isDecreasing
  where
    diffs = zipWith (-) (tail levels) levels
    isIncreasing = all (> 0) diffs && all (\d -> abs d >= 1 && abs d <= 3) diffs
    isDecreasing = all (< 0) diffs && all (\d -> abs d >= 1 && abs d <= 3) diffs

-- Function to check if removing one level makes the report safe
canBeMadeSafe :: [Int] -> Bool
canBeMadeSafe levels = any isSafe modifiedLevels
  where
    modifiedLevels = [take i levels ++ drop (i + 1) levels | i <- [0 .. length levels - 1]]

-- Function to count safe reports considering the Problem Dampener
countSafeReports :: [[Int]] -> Int
countSafeReports reports = length $ filter (\report -> isSafe report || canBeMadeSafe report) reports

-- Main function to read the input file and analyze reports
main :: IO ()
main = do
    contents <- readFile "input.txt"
    let reports = map (map read . words) (lines contents)
    let safeCount = countSafeReports reports
    putStrLn $ "Number of safe reports: " ++ show safeCount