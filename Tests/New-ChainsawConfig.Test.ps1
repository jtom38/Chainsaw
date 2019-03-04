Describe "New-ChainsawConfig" {
    It "New-ChainsawConfig -Console" {
        $config = New-ChainsawConfig -Console

        [System.String]::IsNullOrEmpty($config.ToString()) | Should -Be $false
    }

    It "New-ChainsawConfig -CSV" {

    }
}