# Simple program that exits and returns a status code
# back to the Linux kernel

# Input none

# Output returns a status code. View by typing echo $?

# Variables %eax holds the system call number
#	    %ebx hold the return status

.section .data

.section .text

.globl _start

_start:
	movl $1, %eax	# The Linux kernel command number
			# (system call) for exiting a program

	movl $0, %ebx	# The status number returned to
			# the OS

	int $0x80	# Wakes up the kernel to run the
			# exit system call
