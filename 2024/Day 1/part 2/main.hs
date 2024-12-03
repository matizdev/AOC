import Data.List (foldl', group, sort)
import qualified Data.Map as Map
import System.IO (readFile)

-- Function to calculate the similarity score
calculateSimilarityScore :: [Int] -> [Int] -> Int
calculateSimilarityScore left right = sum [ x * (Map.findWithDefault 0 x rightCountMap) | x <- left ]
  where
    rightCountMap = Map.fromListWith (+) [(x, 1) | x <- right]

-- Main function to read input and compute the similarity score
main :: IO ()
main = do
    -- Read the input file
    content <- readFile "input.txt"
    
    -- Parse the input into two lists
    let linesOfInput = lines content
        (leftList, rightList) = foldl' parseLines ([], []) linesOfInput
    
    -- Calculate the similarity score
    let similarityScore = calculateSimilarityScore leftList rightList
    
    -- Print the result
    putStrLn $ "Total similarity score: " ++ show similarityScore

-- Helper function to parse lines into two lists
parseLines :: ([Int], [Int]) -> String -> ([Int], [Int])
parseLines (left, right) line =
    let [l, r] = map read (words line) :: [Int]
    in (l:left, r:right)