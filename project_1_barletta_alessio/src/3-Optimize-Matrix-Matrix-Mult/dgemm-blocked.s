	.file	"dgemm-blocked.c"
	.text
	.p2align 4
	.globl	square_dgemm
	.type	square_dgemm, @function
square_dgemm:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, %ebx
	andq	$-32, %rsp
	subq	$224, %rsp
	movl	%edi, 176(%rsp)
	movl	$32, %edi
	movq	%rsi, 32(%rsp)
	movl	$10368, %esi
	movq	%rdx, 56(%rsp)
	movq	%rcx, 48(%rsp)
	call	aligned_alloc
	movl	$10368, %esi
	movl	$32, %edi
	movq	%rax, %r15
	call	aligned_alloc
	movl	$10368, %esi
	movl	$32, %edi
	movq	%rax, 144(%rsp)
	call	aligned_alloc
	movq	%rax, %r13
	testl	%ebx, %ebx
	jle	.L41
	movl	176(%rsp), %edi
	movq	%r13, %r8
	movq	$0, 120(%rsp)
	leal	(%rdi,%rdi,8), %eax
	sall	$2, %eax
	movl	%eax, 72(%rsp)
	movslq	%edi, %rax
	salq	$3, %rax
	movq	%rax, 152(%rsp)
.L40:
	movq	120(%rsp), %rcx
	movl	176(%rsp), %ebx
	movl	$0, 116(%rsp)
	movq	%r8, %r9
	movl	%ecx, %eax
	movl	%ecx, 80(%rsp)
	addl	$36, %eax
	cmpl	%ebx, %eax
	movl	%eax, %edi
	cmovg	%ebx, %edi
	xorl	%esi, %esi
	movq	%rsi, %rbx
	movl	%edi, 100(%rsp)
	subl	%ecx, %edi
	leal	-1(%rdi), %eax
	movl	%edi, 204(%rsp)
	movl	%eax, 212(%rsp)
	leaq	8(,%rax,8), %rax
	movq	%rax, 88(%rsp)
	movl	%edi, %eax
	shrl	$2, %eax
	salq	$5, %rax
	movq	%rax, %r14
	movl	%edi, %eax
	andl	$-4, %edi
	movl	%edi, 200(%rsp)
	movl	%eax, %edi
	movq	%r14, %r8
	movq	%r15, %r14
	andl	$3, %edi
	movl	%edi, 208(%rsp)
.L39:
	movl	176(%rsp), %edi
	leal	36(%rbx), %eax
	movl	%ebx, 84(%rsp)
	movl	%ebx, %edx
	cmpl	%edi, %eax
	cmovg	%edi, %eax
	movl	%eax, 112(%rsp)
	cmpl	%ebx, %eax
	jle	.L124
	movl	80(%rsp), %edi
	cmpl	%edi, 100(%rsp)
	jle	.L124
	movslq	116(%rsp), %r12
	movq	120(%rsp), %rax
	movq	%rbx, 216(%rsp)
	movq	%r9, %rcx
	movq	48(%rsp), %rdi
	movl	%edx, 192(%rsp)
	addq	%r12, %rax
	movq	%r12, 184(%rsp)
	movq	%r9, %r12
	leaq	(%rdi,%rax,8), %r13
	movl	112(%rsp), %eax
	subl	%ebx, %eax
	movq	%r8, %rbx
	leaq	(%rax,%rax,8), %rax
	salq	$5, %rax
	leaq	(%rax,%r9), %r15
	vzeroupper
.L5:
	movq	88(%rsp), %rdx
	movq	%r13, %rsi
	movq	%rcx, %rdi
	call	memcpy
	movq	%rax, %rcx
	movq	152(%rsp), %rax
	addq	$288, %rcx
	addq	%rax, %r13
	cmpq	%rcx, %r15
	jne	.L5
	movq	%rbx, %r8
	movq	%r12, %r9
	movq	216(%rsp), %rbx
	movl	192(%rsp), %edx
	movq	184(%rsp), %r12
.L3:
	movl	112(%rsp), %eax
	movl	$0, 76(%rsp)
	movq	%r8, %r15
	movq	$0, 104(%rsp)
	subl	%edx, %eax
	movq	%r9, 40(%rsp)
	movl	%eax, 96(%rsp)
	movq	56(%rsp), %rax
	movq	%rbx, 24(%rsp)
	leaq	(%rax,%r12,8), %rax
	movq	%r12, 16(%rsp)
	movq	%rax, 64(%rsp)
.L35:
	movq	104(%rsp), %rcx
	movl	176(%rsp), %edi
	movl	%ecx, %eax
	movl	%ecx, 160(%rsp)
	movl	%ecx, %edx
	addl	$36, %eax
	cmpl	%edi, %eax
	cmovg	%edi, %eax
	movl	%eax, 136(%rsp)
	movl	%eax, %edi
	cmpl	%ecx, %eax
	jle	.L6
	movl	80(%rsp), %ecx
	cmpl	%ecx, 100(%rsp)
	jle	.L7
	movq	120(%rsp), %rbx
	movslq	76(%rsp), %rax
	movq	%r14, %rcx
	movq	%r14, 216(%rsp)
	movl	%edx, 192(%rsp)
	movq	152(%rsp), %r13
	addq	%rbx, %rax
	movq	32(%rsp), %rbx
	leaq	(%rbx,%rax,8), %rbx
	movl	%edi, %eax
	subl	%edx, %eax
	leaq	(%rax,%rax,8), %rax
	salq	$5, %rax
	leaq	(%rax,%r14), %r12
	movq	%rbx, %r14
	movq	88(%rsp), %rbx
	vzeroupper
	.p2align 4,,10
	.p2align 3
.L8:
	movq	%r14, %rsi
	movq	%rcx, %rdi
	movq	%rbx, %rdx
	addq	%r13, %r14
	call	memcpy
	movq	%rax, %rcx
	addq	$288, %rcx
	cmpq	%rcx, %r12
	jne	.L8
	movq	216(%rsp), %r14
	movl	192(%rsp), %edx
.L7:
	movl	84(%rsp), %edi
	cmpl	%edi, 112(%rsp)
	jle	.L10
	movl	136(%rsp), %esi
	movl	96(%rsp), %eax
	movq	%r14, 8(%rsp)
	movq	64(%rsp), %r9
	movl	116(%rsp), %r8d
	movq	%r15, 128(%rsp)
	movl	%esi, %ecx
	movq	%rax, 216(%rsp)
	movq	56(%rsp), %r14
	movl	%esi, %r15d
	subl	%edx, %ecx
	movq	144(%rsp), %r11
	movl	%ecx, %eax
	leal	-1(%rcx), %edi
	shrl	$2, %eax
	movl	%edi, 192(%rsp)
	salq	$5, %rax
	movq	%rax, 184(%rsp)
	movl	%ecx, %eax
	andl	$-4, %eax
	addl	%edx, %eax
	cmpl	$2, %edi
	cmovbe	160(%rsp), %eax
	andl	$3, %ecx
	xorl	%edi, %edi
	movl	%ecx, %r12d
	movl	%eax, %r13d
	subl	%edx, %eax
	leal	(%rax,%rax,8), %eax
	leal	1(%r13), %r10d
	sall	$2, %eax
	leal	2(%r13), %ebx
	movl	%eax, 180(%rsp)
	movl	%r10d, %eax
	subl	%edx, %eax
	leal	(%rax,%rax,8), %eax
	sall	$2, %eax
	movl	%eax, 168(%rsp)
	movl	%ebx, %eax
	subl	%edx, %eax
	leal	(%rax,%rax,8), %eax
	sall	$2, %eax
	movl	%eax, 164(%rsp)
	.p2align 4,,10
	.p2align 3
.L11:
	cmpl	$2, 192(%rsp)
	movl	%edi, %esi
	jbe	.L15
	movq	184(%rsp), %rax
	leaq	(%r11,%rdi,8), %rdx
	leaq	(%rax,%r9), %rcx
	movq	%r9, %rax
	.p2align 4,,10
	.p2align 3
.L12:
	vmovsd	24(%rax), %xmm0
	vmovsd	16(%rax), %xmm1
	addq	$32, %rax
	addq	$1152, %rdx
	vmovsd	-24(%rax), %xmm2
	vmovsd	-32(%rax), %xmm3
	vmovsd	%xmm1, -576(%rdx)
	vmovsd	%xmm3, -1152(%rdx)
	vmovsd	%xmm2, -864(%rdx)
	vmovsd	%xmm0, -288(%rdx)
	cmpq	%rax, %rcx
	jne	.L12
	testl	%r12d, %r12d
	je	.L13
.L15:
	movl	180(%rsp), %eax
	leal	(%r8,%r13), %edx
	movslq	%edx, %rdx
	vmovsd	(%r14,%rdx,8), %xmm0
	addl	%esi, %eax
	cltq
	vmovsd	%xmm0, (%r11,%rax,8)
	cmpl	%r10d, %r15d
	jle	.L13
	movl	168(%rsp), %eax
	leal	(%r8,%r10), %edx
	movslq	%edx, %rdx
	vmovsd	(%r14,%rdx,8), %xmm0
	addl	%esi, %eax
	cltq
	vmovsd	%xmm0, (%r11,%rax,8)
	cmpl	%r15d, %ebx
	jge	.L13
	movl	164(%rsp), %eax
	leal	(%r8,%rbx), %edx
	movslq	%edx, %rdx
	vmovsd	(%r14,%rdx,8), %xmm0
	addl	%esi, %eax
	cltq
	vmovsd	%xmm0, (%r11,%rax,8)
.L13:
	movl	176(%rsp), %eax
	incq	%rdi
	addl	%eax, %r8d
	movq	152(%rsp), %rax
	addq	%rax, %r9
	movq	216(%rsp), %rax
	cmpq	%rax, %rdi
	jne	.L11
	movq	128(%rsp), %r15
	movq	8(%rsp), %r14
.L14:
	movl	96(%rsp), %eax
	testl	%eax, %eax
	jle	.L10
	movl	136(%rsp), %ecx
	movl	160(%rsp), %edi
	subl	%edi, %ecx
	movl	%ecx, 216(%rsp)
	testl	%ecx, %ecx
	jle	.L10
	movl	204(%rsp), %edi
	testl	%edi, %edi
	jle	.L10
	leal	-3(%rcx), %edx
	xorl	%edi, %edi
	movq	144(%rsp), %r10
	movq	40(%rsp), %r11
	movl	%edx, %ebx
	movq	%rax, 136(%rsp)
	movq	%rdi, %r8
	xorl	%eax, %eax
	andl	$-2, %ebx
	movl	%ebx, 160(%rsp)
	.p2align 4,,10
	.p2align 3
.L18:
	xorl	%ecx, %ecx
	cmpl	$2, 216(%rsp)
	movslq	%eax, %rdi
	jle	.L34
	leal	36(%r8), %edi
	xorl	%esi, %esi
	movl	$0, 192(%rsp)
	leaq	288(%r14), %r9
	movl	%edi, 180(%rsp)
	movl	160(%rsp), %edi
	movl	$36, %ebx
	movq	%r8, 128(%rsp)
	leal	2(%rdi), %ecx
	movq	%r10, 168(%rsp)
	movslq	%eax, %rdi
	movq	144(%rsp), %r10
	movl	%ecx, 164(%rsp)
	movq	%r15, 184(%rsp)
	movq	%rsi, %r15
.L23:
	movq	168(%rsp), %rsi
	cmpl	$2, 212(%rsp)
	movl	%r15d, %ecx
	vmovsd	(%rsi,%r15,8), %xmm0
	jbe	.L126
	movq	%rsi, %r8
	leaq	-288(%r9), %r12
	leaq	(%r11,%rdi,8), %rsi
	xorl	%edx, %edx
	vbroadcastsd	288(%r8,%r15,8), %ymm2
	vbroadcastsd	%xmm0, %ymm3
	movq	184(%rsp), %r8
	subq	$32, %r8
	shrq	$5, %r8
	incq	%r8
	andl	$3, %r8d
	je	.L19
	cmpq	$1, %r8
	je	.L90
	cmpq	$2, %r8
	je	.L91
	vmovapd	(%r12), %ymm1
	vfmadd213pd	(%rsi), %ymm3, %ymm1
	movl	$32, %edx
	vfmadd231pd	(%r9), %ymm2, %ymm1
	vmovupd	%ymm1, (%rsi)
.L91:
	vmovapd	(%r12,%rdx), %ymm1
	vfmadd213pd	(%rsi,%rdx), %ymm3, %ymm1
	vfmadd231pd	(%r9,%rdx), %ymm2, %ymm1
	vmovupd	%ymm1, (%rsi,%rdx)
	addq	$32, %rdx
.L90:
	vmovapd	(%r12,%rdx), %ymm1
	vfmadd213pd	(%rsi,%rdx), %ymm3, %ymm1
	vfmadd231pd	(%r9,%rdx), %ymm2, %ymm1
	vmovupd	%ymm1, (%rsi,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, 184(%rsp)
	je	.L115
.L19:
	vmovapd	(%r12,%rdx), %ymm1
	vfmadd213pd	(%rsi,%rdx), %ymm3, %ymm1
	leaq	32(%rdx), %r8
	vfmadd231pd	(%r9,%rdx), %ymm2, %ymm1
	vmovupd	%ymm1, (%rsi,%rdx)
	vmovapd	32(%r12,%rdx), %ymm1
	vfmadd213pd	32(%rsi,%rdx), %ymm3, %ymm1
	vfmadd231pd	32(%rdx,%r9), %ymm2, %ymm1
	vmovupd	%ymm1, 32(%rsi,%rdx)
	vmovapd	64(%r12,%rdx), %ymm1
	vfmadd213pd	64(%rsi,%rdx), %ymm3, %ymm1
	vfmadd231pd	64(%rdx,%r9), %ymm2, %ymm1
	vmovupd	%ymm1, 64(%rsi,%rdx)
	vmovapd	64(%r12,%r8), %ymm1
	leaq	96(%r8), %rdx
	vfmadd213pd	64(%rsi,%r8), %ymm3, %ymm1
	vfmadd231pd	64(%r9,%r8), %ymm2, %ymm1
	vmovupd	%ymm1, 64(%rsi,%r8)
	cmpq	%rdx, 184(%rsp)
	jne	.L19
.L115:
	movl	208(%rsp), %esi
	testl	%esi, %esi
	je	.L20
	movl	200(%rsp), %edx
	movl	%edx, %esi
.L31:
	movl	204(%rsp), %r12d
	subl	%esi, %r12d
	cmpl	$1, %r12d
	je	.L127
	leaq	(%rdi,%rsi), %r8
	addq	%r15, %rsi
	vmovddup	%xmm0, %xmm2
	leaq	(%r11,%r8,8), %r13
	movslq	180(%rsp), %r8
	vmovapd	0(%r13), %xmm6
	vfmadd132pd	(%r14,%rsi,8), %xmm6, %xmm2
	vmovddup	(%r10,%r8,8), %xmm1
	vfmadd132pd	288(%r14,%rsi,8), %xmm2, %xmm1
	vmovapd	%xmm1, 0(%r13)
	testb	$1, %r12b
	je	.L20
	andl	$-2, %r12d
	addl	%r12d, %edx
.L21:
	leal	(%rax,%rdx), %esi
	addl	%edx, %ecx
	addl	%ebx, %edx
	vmovsd	(%r10,%r8,8), %xmm7
	movslq	%esi, %rsi
	movslq	%ecx, %rcx
	movslq	%edx, %rdx
	leaq	(%r11,%rsi,8), %rsi
	vmovsd	(%rsi), %xmm6
	vfmadd132sd	(%r14,%rcx,8), %xmm6, %xmm0
	vfmadd231sd	(%r14,%rdx,8), %xmm7, %xmm0
	vmovsd	%xmm0, (%rsi)
.L20:
	addl	$2, 192(%rsp)
	addq	$576, %r9
	addl	$72, %ebx
	movl	192(%rsp), %ecx
	addl	$72, 180(%rsp)
	addq	$72, %r15
	cmpl	%ecx, 164(%rsp)
	jne	.L23
	movq	184(%rsp), %r15
	movl	164(%rsp), %ecx
	movq	128(%rsp), %r8
	movq	168(%rsp), %r10
.L34:
	movslq	%ecx, %rdx
	movq	%r8, 192(%rsp)
	leaq	(%r11,%rdi,8), %rsi
	leaq	(%rdx,%rdx,8), %r9
	salq	$2, %r9
	.p2align 4,,10
	.p2align 3
.L29:
	cmpl	$2, 212(%rsp)
	vmovsd	(%r10,%r9,8), %xmm0
	movl	%r9d, %ebx
	jbe	.L42
	leaq	-32(%r15), %r8
	leaq	(%r14,%r9,8), %r12
	vbroadcastsd	%xmm0, %ymm2
	xorl	%edx, %edx
	shrq	$5, %r8
	incq	%r8
	andl	$3, %r8d
	je	.L25
	cmpq	$1, %r8
	je	.L92
	cmpq	$2, %r8
	je	.L93
	vmovapd	(%r12), %ymm1
	vfmadd213pd	(%rsi), %ymm2, %ymm1
	movl	$32, %edx
	vmovupd	%ymm1, (%rsi)
.L93:
	vmovapd	(%r12,%rdx), %ymm1
	vfmadd213pd	(%rsi,%rdx), %ymm2, %ymm1
	vmovupd	%ymm1, (%rsi,%rdx)
	addq	$32, %rdx
.L92:
	vmovapd	(%r12,%rdx), %ymm1
	vfmadd213pd	(%rsi,%rdx), %ymm2, %ymm1
	vmovupd	%ymm1, (%rsi,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %r15
	je	.L114
.L25:
	vmovapd	(%r12,%rdx), %ymm1
	vfmadd213pd	(%rsi,%rdx), %ymm2, %ymm1
	leaq	32(%rdx), %r8
	vmovupd	%ymm1, (%rsi,%rdx)
	vmovapd	32(%r12,%rdx), %ymm1
	vfmadd213pd	32(%rsi,%rdx), %ymm2, %ymm1
	vmovupd	%ymm1, 32(%rsi,%rdx)
	vmovapd	64(%r12,%rdx), %ymm1
	vfmadd213pd	64(%rsi,%rdx), %ymm2, %ymm1
	vmovupd	%ymm1, 64(%rsi,%rdx)
	vmovapd	64(%r12,%r8), %ymm1
	leaq	96(%r8), %rdx
	vfmadd213pd	64(%rsi,%r8), %ymm2, %ymm1
	vmovupd	%ymm1, 64(%rsi,%r8)
	cmpq	%rdx, %r15
	jne	.L25
.L114:
	movl	208(%rsp), %edx
	testl	%edx, %edx
	je	.L26
	movl	200(%rsp), %edx
	movl	%edx, %r8d
.L24:
	movl	204(%rsp), %r12d
	subl	%r8d, %r12d
	cmpl	$1, %r12d
	je	.L27
	leaq	(%r8,%rdi), %r13
	addq	%r9, %r8
	vmovddup	%xmm0, %xmm1
	leaq	(%r11,%r13,8), %r13
	vmovapd	0(%r13), %xmm5
	vfmadd132pd	(%r14,%r8,8), %xmm5, %xmm1
	vmovapd	%xmm1, 0(%r13)
	testb	$1, %r12b
	je	.L26
	andl	$-2, %r12d
	addl	%r12d, %edx
.L27:
	leal	(%rax,%rdx), %r8d
	addl	%ebx, %edx
	movslq	%r8d, %r8
	movslq	%edx, %rdx
	leaq	(%r11,%r8,8), %r8
	vmovsd	(%r8), %xmm4
	vfmadd132sd	(%r14,%rdx,8), %xmm4, %xmm0
	vmovsd	%xmm0, (%r8)
.L26:
	incl	%ecx
	addq	$36, %r9
	cmpl	%ecx, 216(%rsp)
	jg	.L29
	movq	192(%rsp), %r8
	movq	136(%rsp), %rdi
	addl	$36, %eax
	addq	$8, %r10
	incq	%r8
	cmpq	%rdi, %r8
	jne	.L18
.L10:
	addq	$36, 104(%rsp)
	movl	72(%rsp), %ecx
	addq	$288, 64(%rsp)
	movq	104(%rsp), %rax
	addl	%ecx, 76(%rsp)
	cmpl	%eax, 176(%rsp)
	jg	.L35
	movq	40(%rsp), %r9
	movq	24(%rsp), %rbx
	movq	%r15, %r8
	movq	16(%rsp), %r12
	movl	84(%rsp), %edi
	cmpl	%edi, 112(%rsp)
	jle	.L36
	movl	80(%rsp), %edi
	cmpl	%edi, 100(%rsp)
	jle	.L36
	movq	120(%rsp), %rax
	movq	%rbx, 216(%rsp)
	movq	%r9, %rbx
	addq	%rax, %r12
	movq	48(%rsp), %rax
	leaq	(%rax,%r12,8), %rcx
	movl	96(%rsp), %eax
	movq	%r9, %r12
	leaq	(%rax,%rax,8), %rax
	salq	$5, %rax
	leaq	(%rax,%r9), %r13
	vzeroupper
.L38:
	movq	88(%rsp), %rdx
	movq	%r12, %rsi
	movq	%rcx, %rdi
	addq	$288, %r12
	call	memcpy
	movq	%rax, %rcx
	movq	152(%rsp), %rax
	addq	%rax, %rcx
	cmpq	%r12, %r13
	jne	.L38
	movq	%rbx, %r9
	movq	216(%rsp), %rbx
	movq	%r15, %r8
.L36:
	movl	72(%rsp), %edi
	addq	$36, %rbx
	addl	%edi, 116(%rsp)
	cmpl	%ebx, 176(%rsp)
	jg	.L39
	addq	$36, 120(%rsp)
	movq	%r14, %r15
	movq	120(%rsp), %rax
	movq	%r9, %r8
	cmpl	%eax, 176(%rsp)
	jg	.L40
	movq	%r9, %r13
	vzeroupper
.L41:
	movq	%r15, %rdi
	call	free
	movq	144(%rsp), %rdi
	call	free
	leaq	-40(%rbp), %rsp
	movq	%r13, %rdi
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	free
.L42:
	.cfi_restore_state
	xorl	%r8d, %r8d
	xorl	%edx, %edx
	jmp	.L24
.L126:
	xorl	%esi, %esi
	xorl	%edx, %edx
	jmp	.L31
.L127:
	movslq	180(%rsp), %r8
	jmp	.L21
.L6:
	movl	84(%rsp), %edi
	cmpl	%edi, 112(%rsp)
	jg	.L14
	jmp	.L10
.L124:
	movslq	116(%rsp), %r12
	jmp	.L3
	.cfi_endproc
.LFE20:
	.size	square_dgemm, .-square_dgemm
	.globl	dgemm_desc
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Blocked dgemm."
	.data
	.align 8
	.type	dgemm_desc, @object
	.size	dgemm_desc, 8
dgemm_desc:
	.quad	.LC0
	.ident	"GCC: (Spack GCC) 13.2.0"
	.section	.note.GNU-stack,"",@progbits
