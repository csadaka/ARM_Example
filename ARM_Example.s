.data

outformat:     .asciz "%c"
flush:          .asciz "\n"
stringread:     .asciz "%s"
lengthread:     .asciz "%d"
newline:        .asciz "\n"
readformat:     .asciz "%d"
first_string:   .asciz "Enter Two Integers"
string_specifier:       .asciz "%s"
string_input_buffer:    .space 256
lenbufferM: .space 8
lenbufferN: .space 8

solution_specifier:    .asciz "%d"

.text
.global main

main:
  //print prompt for input
  ldr x0,= first_string
  bl printf
  ldr x0, = newline
  bl printf


  //get first number and store in x20(n)
    ldr x0, =lengthread
    ldr x1, =lenbufferN
    bl scanf
    ldr x0, =lenbufferN
    ldrsw x0, [x0, #0]
    mov x20, x0

  //get second number and store it in X21(m)
  ldr x0, =lengthread
   ldr x1, =lenbufferM
   bl scanf
   ldr x0, =lenbufferM
   ldrsw x0, [x0, #0]
   mov x21, x0

   cmp x20, #0
   B.LT negateN
   cmp x21, #0
   B.LT negateM

   sub sp, sp, #32
   str x20, [sp, #0]
   str x21, [sp, #8]
  b GCD

negateN:
    neg x20, X20
    cmp x21, #0
    sub sp, sp, #32
    str x20, [sp, #0]
    str x21, [sp, #8]
    B.LT negateM
    b GCD

negateM:
    neg x21, x21
    sub sp, sp, #32
    str x20, [sp, #0]
    str x21, [sp, #8]
    b GCD

GCD:
  ldr x20, [sp, #0]
  ldr x21, [sp, #8]
  add sp, sp, #32
  // check if either are 0
  CBZ X20, ansM
  CBZ X21, ansN

  //if m<n if x10-x11 !=0
  cmp x21, x20
  B.LT switch

  //if n is a divisor of M
  sdiv w22, w21, w20
  mul w3, w22, w20
  sub w2, w21, w3
  CBZ w2, ansN
  //if it isnt ) find the gcd if the mod number and M
  mov w21, w2
  sub sp, sp, #32
  str w20, [sp, #0]
  str w21, [sp, #8]
  b GCD

  // how to do mod? division multiplication, substraction

switch://swap m and n
  mov x4, X21
  mov x21, x20
  mov x20, x4
  str w20, [sp, #0]
  str w21, [sp, #8]
  b GCD




ansM:
      mov x22, x21
      bl printTime

ansN:
      mov x22, x20
      bl printTime



printTime:
  //solution in x22
      ldr x0, =solution_specifier
      mov x1, x22
      bl printf
      ldr x0, =newline
      bl printf
      b exit
