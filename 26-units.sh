# IEC binary unit converters - convert from KiB/MiB/GiB/TiB/PiB to bytes
# These use binary multiples (powers of 2) as per IEC standard
# Usage: KiB 5 -> outputs "5120 B"

# Convert Kibibytes to bytes (2^10 = 1024)
function KiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^10" | bc)
}

# Convert Mebibytes to bytes (2^20 = 1,048,576)
function MiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^20" | bc)
}

# Convert Gibibytes to bytes (2^30)
function GiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^30" | bc)
}

# Convert Tebibytes to bytes (2^40)
function TiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^40" | bc)
}

# Convert Pebibytes to bytes (2^50)
function PiB() {
	bytes=$1
	printf "%s B\n" $(echo "$1 * 2^50" | bc)
}
