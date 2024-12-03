import Data.List (sort)
import System.IO (readFile)

-- Function to calculate the total distance between two lists
calculateTotalDistance :: [Int] -> [Int] -> Int
calculateTotalDistance left right = sum $ zipWith (\x y -> abs (x - y)) (sort left) (sort right)

-- Main function to read input and compute the distance
main :: IO ()
main = do
    -- Read the input file
    content <- readFile "input.txt"
    
    -- Parse the input into two lists
    let linesOfInput = lines content
        (leftList, rightList) = foldl parseLines ([], []) linesOfInput
    
    -- Calculate the total distance
    let totalDistance = calculateTotalDistance leftList rightList
    
    -- Print the result
    putStrLn $ "Total distance: " ++ show totalDistance

-- Helper function to parse lines into two lists
parseLines :: ([Int], [Int]) -> String -> ([Int], [Int])
parseLines (left, right) line =
    let [l, r] = map read (words line) :: [Int]
    in (l:left, r:right)