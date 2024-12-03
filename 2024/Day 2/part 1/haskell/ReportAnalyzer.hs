import System.IO
import Data.List

-- Function to check if a list of levels is safe
isSafe :: [Int] -> Bool
isSafe levels = (isIncreasing levels || isDecreasing levels) && validDiffs
  where
    diffs = zipWith (-) (tail levels) levels
    validDiffs = all (\d -> d >= 1 && d <= 3) (map abs diffs)

    isIncreasing xs = all (>= 0) (zipWith (-) (tail xs) xs)
    isDecreasing xs = all (<= 0) (zipWith (-) (tail xs) xs)

-- Function to count safe reports
countSafeReports :: [[Int]] -> Int
countSafeReports reports = length $ filter isSafe reports

-- Main function to read input file and analyze reports
main :: IO ()
main = do
    contents <- readFile "input.txt"
    let reports = map (map read . words) (lines contents) :: [[Int]]
    let safeCount = countSafeReports reports
    putStrLn $ "Number of safe reports: " ++ show safeCount