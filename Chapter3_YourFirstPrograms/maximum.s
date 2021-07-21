# Variables

# %edi - Holds the index of the data item being examined
# %ebx - The largest data item found
# %eax - The current data item

# The following memory locations are being used:
# data_items: Contains the item data. A 0 is used to
#		terminate the data

.section .data

data_items:	# These are the data items
	.long 3, 67, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 0

.section .text

.globl _start
_start:
	movl $0, %edi	# Move the value of 0 into
			# the index register
	movl data_items(, %edi, 4), %eax	# Load the first byte of data
	movl %eax, %ebx	# The first item is always more than zero	
start_loop:
	cmpl $0, %eax	# Check for a zero to terminate
	je loop_exit	# If it is zero, then exit
	incl %edi	# Increment the data_items index

	movl data_items(, %edi, 4), %eax	# Move the next number into edi
	cmp %eax, %ebx				# Compare the number with the 
						# last maximum
	jg start_loop				# If it is smaller, continue to loop
	movl %eax, %ebx				# Otherwise, replace the old maximum 
						# with the new maximum
	jmp start_loop
loop_exit:
	# %ebx is the satus code for the exit system call
	# It was the register being loaded with the maximum
	movl $1, %eax	# 1 is the exit system call
	int $0x80	# Interrupt for kernel control
