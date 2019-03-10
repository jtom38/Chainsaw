
Describe "New-ChainsawConfig" {
    It "New-ChainsawConfig -Console" {
        $config = New-ChainsawConfig -Console
        $res = [System.String]::IsNullOrEmpty($config.MessageTemplate) 
        $res | Should -Be $false
    }
}