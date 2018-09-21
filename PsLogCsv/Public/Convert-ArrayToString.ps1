
function Convert-ArrayToString {
    param (
        [string[]] $Array,
        [string] $AppendValue
    )
    
    Process {

        $s = ""
        foreach ( $i in $Array) {
            $s += "$i $AppendValue"
        }

        return $s
    }
}