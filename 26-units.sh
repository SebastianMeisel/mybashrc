function KiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^10" | bc)
}
function MiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^20" | bc)
}
function GiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^30" | bc)
}
function TiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^40" | bc)
}
function PiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^50" | bc)
}
