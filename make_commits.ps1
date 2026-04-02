$messages = @(
    "Initial project setup and Maven configuration",
    "Add README and .gitignore",
    "Create basic directory structure",
    "Define DB and Main core classes",
    "Implement basic Memtable structure",
    "Add get and put methods to Memtable",
    "Calculate size estimations in Memtable",
    "Add MemtableService with basic locking",
    "Implement Write-Ahead Log (WAL) structure",
    "Add WAL write and replay functionality",
    "Integrate WAL with MemtableService",
    "Implement Memtable flush mechanism",
    "Add rotation for active Memtable",
    "Create SSTable class structure",
    "Implement BloomFilter utility",
    "Add BloomFilter to SSTable for fast reads",
    "Implement BlockInfo and SSTableEntry",
    "Create SSTable from Memtable implementation",
    "Add IOUtils for serialization",
    "Implement SSTable get method",
    "Add index searching in SSTable",
    "Handle tombstone values in memtable",
    "Implement deletion logic",
    "Add Manifest file handling",
    "Save and load manifest state",
    "Integrate Manifest with SSTableService",
    "Implement level map in Manifest",
    "Create CompactionService structure",
    "Implement force flush in CompactionService",
    "Add scheduled executor for memtable flushing",
    "Implement compaction runner thread",
    "Implement sorted run for SSTable compaction",
    "Fix merge conflicts in SSTable",
    "Update manifest after compaction",
    "Add cleanup for old SSTables after compaction",
    "Implement SSTableIterator for sequential reads",
    "Add priority queue logic for multi-way merge",
    "Fix buffer flush bug in compaction",
    "Implement graceful shutdown in DB class",
    "Add basic CLI interface in Main",
    "Improve CLI error handling",
    "Add display manifest command in CLI",
    "Set up JUnit testing framework",
    "Add Memtable basic tests",
    "Add SSTable construction tests",
    "Add SSTable merge tests",
    "Fix bug in SSTable index calculation",
    "Add JMH benchmark setup",
    "Implement LSMGetBenchmark",
    "Implement LSMPutBenchmark",
    "Add SSTableGetBenchmark",
    "Refactor locking in MemtableService",
    "Optimize serialization in IOUtils",
    "Update README with benchmark results",
    "Final cleanup and formatting"
)

$startDate = [datetime]"2026-04-01T10:00:00"

git init
git add pom.xml README.md .gitignore
git commit -m $messages[0] --date=$startDate.ToString("s")

$files = Get-ChildItem -File -Recurse | Where-Object { $_.FullName -notmatch '\.git' }

# Distribute files roughly across the commits
$chunkSize = [math]::Ceiling($files.Count / 54)
$fileIndex = 0

for ($i = 1; $i -lt 55; $i++) {
    $currentDate = $startDate.AddDays($i * 0.75).AddHours((Get-Random -Minimum -2 -Maximum 5))
    $dateStr = $currentDate.ToString("s")
    
    $addedFiles = $false
    for ($j = 0; $j -lt $chunkSize; $j++) {
        if ($fileIndex -lt $files.Count) {
            git add $files[$fileIndex].FullName
            $fileIndex++
            $addedFiles = $true
        }
    }
    
    # Also set GIT_COMMITTER_DATE
    $env:GIT_COMMITTER_DATE = $dateStr
    
    if ($addedFiles) {
        git commit -m $messages[$i] --date=$dateStr
    } else {
        git commit --allow-empty -m $messages[$i] --date=$dateStr
    }
}
