
import-module Pester
Describe "Import-Module Chainsaw"{
    it "Should Generate new hashtable"{
        Import-Module Chainsaw
        [hashtable] $hash = $Global:Chainsaw
        $result = [string]::IsNullOrEmpty($hash)
        $result | Should -Be $false
    }

    it 'Contains Console endpoint settings'{

    }

    it 'Contains CSV endpoint settings'{
        [hashtable] $hash = $Global:Chainsaw.CSV
        $result = [string]::IsNullOrEmpty($hash)
        $result | Should -Be $false
    }

    it 'Contains CSV endpoint settings'{
        [hashtable] $hash = $Global:Chainsaw.CSV
        $result = [string]::IsNullOrEmpty($hash)
        $result | Should -Be $false
    }
}