# Day 2

## Understanding the Application Binary Interface

An interface is roughly speaking, a point where two systems meet. For example, when presenting a computer to a user who is <br> interested in buying, the interface is it's appearance and functionality.

This rough definition also holds true in hardware.

If you want an application to run on some hardware, there are multiple layers present in between. Each
level interfaces and interacts with the layer adjacent to it.

 - The application is built by implementing functionality through standard libraries.
   - These libraries are written in any language, C, Java, Python etc.

 - The standard libraries interact with the main OS. We will talk about this in a bit.

 - The OS builds assembly code in the target arch (x86, arm, riscv) ISA, the interface between OS and machine language.

 - The target Instruction Set Architecture is implemented into hardware using the RTL interface. 
    - This interface implements all the specifications needed by the architecture.
    - The ISA is accessible both to user(programmer) as well as the system.

        - User ISA
        - System ISA

It is a way for an application to access hardware resources directly, also called "System calls".

A programmer can access registers through system calls, and they do that through the ABI.




Communications between layers

  - <i>Application Program</i> | through System calls/ABI interacts with -> | <i>Standard Libraries</i>

  - <i>Standard Libraries</i> |  through ISA interface interact with | <i>OS</i>  

  - <i>OS</i> |  User mode & System Mode | <i>ISA</i> 

  - <i>ISA</i> | Through the RTL interface | <i>Hardware</i> 


## Registers

RISC V has 32 registers. XLEN defines the width of the individual registers, and is as follows:

 - XLEN 32 for RV32
 - XLEN 64 for RV64
 
It has 32 registers regardless of whether it is RV32 or RV64.

Instruction size is also 32-bit, for both RV32 and RV64.


### Question 1: Why are there 32 registers in RISC-V?

### Answer


If you wish to load a number into a register:

 - You can load to memory and from memory to register or;
 - Load directly to the register.

There are different ways to load from memory.

#### Little Endian vs Big Endian
Each memory address addresses a single byte.

A 64 bit number gets loaded into 8 memory spaces; the lowest 8 bits get loaded to the bottom of the 8 addresses, <br>and the next 8 bits on the one above it etc.

<b>It is called "little endian" memory addressing system and RISC V uses this.</b>

Big endian loads numbers around the other way.


#### Example: <br>

The 64 bit number  00000000 10101010 01010101 00001111 11110000 11000011 00001100 01111110



Memory is loaded in the fashion shown below:

m[7] is loaded with 00000000 <br>
m[6] is loaded with 10101010 <br>
m[5] is loaded with 01010101 <br>
m[4] is loaded with 00001111 <br>
m[3] is loaded with 11110000 <br>
m[2] is loaded with 11000011 <br>
m[1] is loaded with 00001100 <br>
m[0] is loaded with 01111110 <br>



#### Commands


<b>ld</b> : means "load doubleword"


Example: ld x8, 16(x23) 

This is using indirect addressing cause it uses an offset.
 - x23 holds the base address e.g 0.
 - 16 is the offset, the ending address.
 -So load the data from that range of addresses.

 

<b>add</b>: Integer Addition

Example: add x8, x24, x8

The first argument is the destination register, and the other two are the source <br>
registers whose contents will be added together.


<b>sd</b> : means "store doubleword"


Example: sd x8, 8(x23)

The first argument is the destination register, and the second one is again an
offset.




 - x23 holds the base address e.g 0
 - 8 is the offset, the ending address
 - So save the data to that range of addresses



#### Instruction Types

 - Instructions like add only operate on registers, called R type instructions

 - Instructions like load operate on registers and immediates, called I type instructions

 - Instructions like store operate on source registers and immediates, called S type instructions


There exist more types within the specification.

------------

Why 32 registers?


All registered regs in the above instructions are 5 bit.

 - So 2^5=32 registers.

 - Naming Convention: x0 to x31 (0 to (2^5) - 1).

 - Each register has a name and a usage.


![alt text](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_jun21-VictorySpecificationII/blob/master/Day2/reg%20types.PNG?raw=true)

 ------------------------------------------------------------



 ## Lab - Re Write C program using Assembly

We are writing a program to calculate the sum of numbers within a given range.

 General Idea: 
  - Main program that calls ASM routine done in C, ASM routine performs the calculation
  - Arguments for calculation passed through registers a0 and a1, and a0 returns the result.

![alt text](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_jun21-VictorySpecificationII/blob/master/Day2/Lab%20rewrite%20c%20prog%20using%20asm.PNG?raw=true)

Writing the C and ASM programs, and assembling;

![alt text](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_jun21-VictorySpecificationII/blob/master/Day2/1%20-%20c%20program%20asm%20program%20and%20compilation.JPG?raw=true)


 To assemble using the RISC-V compiler:
     riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o 1to9_custom.o 1to9_custom.c load.s

Dumping the object code
![alt text](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_jun21-VictorySpecificationII/blob/master/Day2/2%20-%20simulation.JPG?raw=true)

Viewing object code
![alt text](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_jun21-VictorySpecificationII/blob/master/Day2/3%20-%20riscv%20dump.JPG?raw=true)

In order to carry out the labs, we need to clone this repository:

![alt text](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_jun21-VictorySpecificationII/blob/master/Day2/4%20-%20cloning%20riscv%20labs.JPG?raw=true)

Within the repo we just cloned, there exists a script called rv32im.sh. What the script does, is compile the code. It also creates the hex file to be used with iverilog, the simulator used to verify correctness. Below, we have ran the program twice, changing the upper bound value from two to three the second time.

![alt text](https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_jun21-VictorySpecificationII/blob/master/Day2/5%20-%20rv32im%20script%20to%20compile%20and%20run%20riscv%20then%20changing%20value%20in%20c%20program%20and%20seeing%20output.JPG?raw=true)
