Describe "New-ChainsawConfig" {
    It "New-ChainsawConfig -Console" {
        $config = New-ChainsawConfig -Console
        $res = [System.String]::IsNullOrEmpty($config.MessageTemplate) 
        $res | Should -Be $false
    }

    It "New-ChainsawConfig -Console -Empty"{
        $config = New-ChainsawConfig -Console -Empty        
        $res = [System.String]::IsNullOrEmpty($config.MessageTemplate) 
        $res | Should -Be $true
    }

    It "New-ChainsawConfig -CSV" {
        $config = New-ChainsawConfig -CSV
        $res = [System.String]::IsNullOrEmpty($config.ToString()) 
        $res | Should -Be $false
    }

    It "New-ChainsawConfig -CSV -Empty" {
        $config = New-ChainsawConfig -CSV -Empty
        $res = [System.String]::IsNullOrEmpty($config.MessageTemplate) 
        $res | Should -Be $true
    }
}