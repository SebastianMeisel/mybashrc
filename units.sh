function KiB() {
	bytes=$1
	echo "$1 * 2^10" | bc
}
function MiB() {
	bytes=$1
	echo "$1 * 2^20" | bc
}
function GiB() {
	bytes=$1
	echo "$1 * 2^30" | bc
}
