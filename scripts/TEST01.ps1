param (
    [string]$portName = "COM3",  # Default COM3 se non specificato
    [int]$baudRate = 9600,        # Default 9600 baud
    [int]$byteCount = 1024       # Numero bytes inviati
)

function Open-Port {
    try {
        if ($global:port -and $global:port.IsOpen) {
            $global:port.Close()
        }
        
        $global:port = New-Object System.IO.Ports.SerialPort $portName, $baudRate, None, 8, 1
        $global:port.Open()
        Write-Host "✅ Porta $portName aperta con baud rate $baudRate, byte count $byteCount"
    } catch {
        Write-Host "❌ Errore: impossibile aprire la porta $portName. Riprovo tra 3 secondi..."
        Start-Sleep -Seconds 3
    }
}

Open-Port  # Apre la porta all'inizio

while ($true) {
    try {
        # Scrive dati casuali sulla porta seriale
        $chars = -join ((32..126) | Get-Random -Count $byteCount | ForEach-Object {[char]$_})
        $global:port.WriteLine($chars)    
        Write-Host "Inviati: $chars"
        
        # Legge i dati se disponibili
        if ($global:port.BytesToRead -gt 0) {
            $receivedData = $global:port.ReadExisting()
            Write-Host "Ricevuti: $receivedData"
        }
    } catch { 
        Open-Port 
    }
    
    Start-Sleep -Seconds 1
}

$global:port.Close()
