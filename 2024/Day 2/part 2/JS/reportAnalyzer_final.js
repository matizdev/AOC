function isSafe(levels) {
    const diffs = levels.slice(1).map((level, index) => level - levels[index]);
    const isIncreasing = diffs.every(diff => diff > 0);
    const isDecreasing = diffs.every(diff => diff < 0);
    const validDiffs = diffs.every(diff => Math.abs(diff) >= 1 && Math.abs(diff) <= 3);

    return (isIncreasing || isDecreasing) && validDiffs;
}

// Function to check if removing one level makes the report safe
function canBeMadeSafe(levels) {
    for (let i = 0; i < levels.length; i++) {
        const modifiedLevels = levels.slice(0, i).concat(levels.slice(i + 1));
        if (isSafe(modifiedLevels)) {
            return true;
        }
    }
    return false;
}

// Function to count safe reports considering the Problem Dampener
function countSafeReports(reports) {
    return reports.filter(report => isSafe(report) || canBeMadeSafe(report)).length;
}

// Function to handle file input and analyze reports
document.getElementById('analyzeButton').addEventListener('click', () => {
    console.log('Analyze Reports button clicked'); // Log button click
    const fileInput = document.getElementById('fileInput');
    const file = fileInput.files[0];

    if (file) {
        const reader = new FileReader();
        reader.onload = function(event) {
            const data = event.target.result;
            const reports = data.split('\n').map(line => line.split(' ').map(Number));
            const safeCount = countSafeReports(reports);
            document.getElementById('result').innerText = 'Number of safe reports: ' + safeCount;
        };
        reader.onerror = function() {
            console.error('Error reading file:', reader.error);
            alert('Error reading file. Please try again.');
        };
        reader.readAsText(file);
    } else {
        alert('Please upload a file.');
    }
});
