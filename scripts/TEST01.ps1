
param (
    [string]$portName = "COM3",  # Default COM3 se non specificato
    [int]$baudRate = 9600        # Default 9600 baud
)
# $portName = "COM5"
# $baudRate = 9600

function Open-Port {
    try {
        $global:port = New-Object System.IO.Ports.SerialPort $portName, $baudRate, None, 8, 1
        $global:port.Open()
        Write-Host "✅ Porta $portName aperta con baud rate $baudRate"
    } catch {
        Write-Host "❌ Errore: impossibile aprire la porta $portName. Riprovo tra 3 secondi..."
        Start-Sleep -Seconds 3
    }
}

Open-Port  # Apre la porta all'inizio

while ($true) {
     try {
        $chars = -join ((32..126) | Get-Random -Count 1024 | ForEach-Object {[char]$_})
        $global:port.Write($chars)    
        Write-Host "Inviati: $chars"
    } catch { 
        Open-Port 
    }
    Start-Sleep -Milliseconds 5
}

$global:port.Close()
