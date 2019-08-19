function mdsplit {
    [cmdletbinding()]
    param(
        [string]$Path = ".\testsplit.md",
        [string]$OutPath = "."
    )

    $data = gc .\testsplit.md

    $counter = 0
    Write-Verbose "`$counter set to $counter"
    Write-Verbose "Lines in File: $($data.Length)"

    $linecount = 0
    while ($lineCount -lt $data.Length)
    {
        ForEach ($line in $data)
        {
            $lineCount ++

            if (($line[0] -eq "#") -and ($line[1] -eq "#"))
            {
                if ($tempvar)
                {
                    Write-Output $tempvar
                    if ($curFile)
                    {
                        Set-Content $curFile -Value $tempvar
                    }
                }

                $counter ++

                $tempvar = @()

                Write-Verbose "Header Line [$($line.substring(3))]"
                $fileName = $line.substring(3) +".md"
                $curFile = New-Item -Path $OutPath -Name $fileName -force

                $tempvar += $line.ToString()
                #$tempvar += "`n"
            }
            else
            {
                $tempvar += $line.ToString()
                #$tempvar += "`n"
            }
    
        }


    }

    if ($tempvar)
    {
        Write-Output $tempvar
        if ($curFile)
        {
            Set-Content $curFile -Value $tempvar
        }
    }
}

mdsplit -verbose