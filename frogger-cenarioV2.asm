# Teste 2 de criacao de cenario

.text
main:	lui $5,0x1001


#================Funcoes_Cenario=========================	
	jal defFundo
	jal defSapo
	jal defCarros
	jal desenharTroncos
	jal desenharCirculos



#========================================================


	addi $2,$0,10   
	syscall



#=====================DEFFUNDO===========================
defFundo:
	add $8,$0,$5 # lui vem pra ca
	add $9,$0,0 # Indice(I)

	add $10, $0, 7296 # Tamanho da tela
	add $25,$0, 4736 # Pouco mais da metade do cenario
	
	#Ocupacao dos Atributos
	# Altere para reduzir/aumentar as bordas laterais
	add $11, $0, 10	 #come√ßo do rio na linha
	add $12, $0, 118 #fim do rio na linha
	
Laco_BG: # for (i=0;i<$10;) 
	beq $10,$9,Fim_BG
	
	 
	# a partir da metade do cenario, printa rua invez de agua
	
	sge $13, $9, $11 # if ($9 >= $11) $13 = 1.
	sle $14, $9, $12 # if ($9 <= $12) $14 = 1.
	and $15, $13, $14 # $15 = and($13, $14)
	bne $15, 1, bordas # se $15 = 1 vai pintar as bordas
 	ble $25,$9,ruas

agua:	
	add $4,$0,0x00187 # Agua(Azul)
	sw $4,0($8) # Valor[i]
	add $9,$9,1 # i++
	add $8,$8,4 # Proximo valor
	beq $9,$12,Quebrar_Linha	# Quebra a linha caso $9 =111(tamanho max)
	j Laco_BG

bordas:	
	add $4,$0, 0x507C38 # Bordas(verde)
	sw $4,0($8) # Valor[i]
	add $9,$9,1 # i++
	add $8,$8,4 # Proximo_valor[i}
	j Laco_BG

ruas:	
	bge $9,5248,estrada # Linhas pra calcada
	# a pista tem 12"pixels" entao teria espa√ßo para 3 carros
	#tamanho das calcadas = 4 para caber o sapo
calcada:		
    	add $4,$0,0xF0EA48 # Cor da calcada(Amarelo)
	sw $4,0($8) # Valor[i]
	add $9,$9,1 # i++
	add $8,$8,4 # Proximo valor
	beq $9,$12,Quebrar_Linha	# Quebra a linha caso $9 =111(tamanho max)
	j Laco_BG
     
estrada:
	# INTERLIGA rua com calcada para fazer a calcada de baixo
	bge $9,6784,calcada 
	#---------------
    	addi $4,$0,0x000000 # Cor da estrada
	sw $4,0($8) # Valor[i]
	addi $9,$9,1 # i++
	addi $8,$8,4 # Proximo valor
	beq $9,$12,Quebrar_Linha	# Quebra a linha caso $9 =111(tamanho max)
	
	j Laco_BG

Quebrar_Linha:
	addi $11,$11,128
	addi $12,$12,128
	j Laco_BG    
	
Fim_BG:
#=====================Linhas_Nos_Extremos===========================

LinhasExtremos:
	add $8,$0,$5 # lui vem pra ca
	addi $9,$0,0 # Indice(I)
	addi $4,$0,0x507C38 # Verde

	addi $10,$0,8192 # Tamanho da tela
	addi $11,$0, 384 # (128*Qtd linhas)
	addi $12,$0, 7296 # Come√ßo da borda de baixo

Laco_LinhasExtremos_Topo:

	beq $9,$11, LinhasExtremos_Fundo
	
	sw $4,0($8) # Valor[i]
	addi $9,$9, 1 # i++
	addi $8,$8, 4 # Proximo valor
	
	j Laco_LinhasExtremos_Topo
	
LinhasExtremos_Fundo:
	mul $13, $12, 4    # Calculo em bytes(4b = 1GU) 
	add $8, $5, $13
	add $9,$9, 6912
Laco_LinhasExtremos_Fundo:
	beq $9,$10,Fim_LE
	sw $4,0($8) # Valor[i]
	addi $9,$9, 1 # i++
	addi $8,$8, 4 # Proximo valor
	
	j Laco_LinhasExtremos_Fundo
Fim_LE:	
	jr $31


#=============================Sapo=================================
defSapo: add $8,$0,$5
	add $4,$0,0x2A9F00 # cor temp do sapo
	add $9, $0, 64
	mul $10,$9,428 # e 428
	
	add $8,$8,$10

	
	sw $4,0($8) # PIXEIS PRIMEIROS
	addi $8,$8,8
	sw $4,0($8)
	addi $8,$8,8
	sw $4,0($8)
	
	addi $8,$8,500 # Qubra de linha
	
	sw $4,0($8) # PIXEIS SEGUNDOS
	add $8,$8,4
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	
	addi $8,$8,500 # Quebra de linha
	
	sw $4,0($8) # PIXEIS TERCEIROS
	add $8,$8,8
	sw $4,0($8)
	add $8,$8,8
	sw $4,0($8)

	addi $8,$8,496 # Quebra de linha
	
	sw $4,0($8)
	addi $8,$8,16
	sw $4,0($8)
	
	jr $31
	

#=============================Carros vermelhos=================================
defCarros: add $8,$0,$5
	add $4,$0,0xFF0000 # cor temp do sapo
	add $9, $0, 56
	mul $10,$9,456 # e 428
	
	add $8,$8,$10

	
	sw $4,0($8) # PIXEIS PRIMEIROS
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,8
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	
	addi $8,$8,492 # Qubra de linha
	
	sw $4,0($8) # PIXEIS SEGUNDOS
	add $8,$8,4
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	
	addi $8,$8,488 # Quebra de linha
	
	sw $4,0($8) # PIXEIS TERCEIROS
	add $8,$8,4
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)
	add $8,$8,4 
	sw $4,0($8)

	addi $8,$8,492 # Quebra de linha
	
	sw $4,0($8) # PIXEIS ULTIMOS
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,8
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)

Segundo:	add $8,$0,$5
	add $4,$0,0xFFFFFFF
	add $9, $0, 56
	mul $10,$9,417 # e 428
	
	add $8,$8,$10

	
	sw $4,0($8) # PIXEIS PRIMEIROS
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,8
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
		
	addi $8,$8,476
	
	sw $4,0($8) # PIXEIS SEGUNDO
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	
	addi $8,$8,476
	
	sw $4,0($8) # PIXEIS TERCEIRO
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	
	addi $8,$8,480
	
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,8
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)

Terceiro:
	add $8,$0,$5
	add $4,$0,0xc059b1 # cor temp do sapo
	add $9, $0, 56
	mul $10,$9,378 # e 428
	
	add $8,$8,$10

	sw $4,0($8) # PIXEIS PRIMEIROS
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,8
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	
	addi $8,$8,480
	
	
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	
	addi $8,$8,480
	
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	
	add $8,$8,484
	
	sw $4,0($8) # PIXEIS FINAIS
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,8
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	sw $4,0($8)
	addi $8,$8,4
	
	
	
	jr $31
#=========================TRONCOS===========================
desenharTroncos:
	add $4, $0, 0x8B4513  # Cor marrom
	add $6, $0, $5        # Base do display

	# Tronco 1 (linha 6, col 20)
	li $9, 10
	li $10, 20
	jal desenhaTronco

	# Tronco 2 (linha 9, col 40)
	li $9, 13
	li $10, 40
	jal desenhaTronco

	# Tronco 3 (linha 12, col 70)
	li $9, 15
	li $10, 70
	jal desenhaTronco

	# Tronco 4 (linha 15, col 90)
	li $9, 17
	li $10, 90
	jal desenhaTronco
	
	jal desenharCirculos
	jr $31

#=======SUBFUNCAO desenhaTronco==========
# Espera em $9 = linha, $10 = coluna
# Usa $4 como cor, $6 como base da tela

desenhaTronco:
	# Salva linha original
	add $14, $9, $0     # $14 = linha original

	# Primeira linha do tronco
	mul $11, $14, 128
	add $11, $11, $10
	mul $11, $11, 4
	add $8, $6, $11

	li $12, 0
tronco_linha1:
	beq $12, 15, prox_linha_tronco
	beq $12, 4, tronco_skip1
	beq $12, 8, tronco_skip1
	sw $4, 0($8)
tronco_skip1:
	addi $8, $8, 4
	addi $12, $12, 1
	j tronco_linha1

prox_linha_tronco:
	# Usa $14 + 1 para a linha seguinte, mas $9 nao muda
	addi $15, $14, 1
	mul $11, $15, 128
	add $11, $11, $10
	mul $11, $11, 4
	add $8, $6, $11

	li $12, 0
tronco_linha2:
	beq $12, 15, tronco_fim
	beq $12, 3, tronco_skip2
	beq $12, 10, tronco_skip2
	sw $4, 0($8)
tronco_skip2:
	addi $8, $8, 4
	addi $12, $12, 1
	j tronco_linha2

tronco_fim:
	jr $31



#====================CIRCULOS NA AGUA====================
desenharCirculos:
    add $6, $0, $5

    # grupo azul claro
    li $4, 0x87CEFA
    li $9, 32
    li $10, 20
    jal desenhaGrupoCirculos

    # grupo marrom
    li $4, 0x8B4513
    li $9, 32
    li $10, 86
    jal desenhaGrupoCirculos

    jr $31


#=========SUBFUN«AO desenhaGrupoCirculos==========
desenhaGrupoCirculos:
    li $12, 0  # contador de cÔrculos

circular_loop:
    beq $12, 3, fim_circulos

    # linha 0
    li $13, 0
linha0:
    beq $13, 5, proxima_linha1
    beq $13, 0, skip0
    beq $13, 4, skip0
    mul $14, $9, 128
    add $14, $14, $10
    add $14, $14, $13
    mul $14, $14, 4
    add $8, $6, $14
    sw $4, 0($8)
skip0:
    addi $13, $13, 1
    j linha0

proxima_linha1:
    addi $9, $9, 1
    li $13, 0
linha1:
    beq $13, 5, proxima_linha2
    mul $14, $9, 128
    add $14, $14, $10
    add $14, $14, $13
    mul $14, $14, 4
    add $8, $6, $14
    sw $4, 0($8)
    addi $13, $13, 1
    j linha1

proxima_linha2:
    addi $9, $9, 1
    li $13, 0
linha2:
    beq $13, 5, proxima_linha3
    mul $14, $9, 128
    add $14, $14, $10
    add $14, $14, $13
    mul $14, $14, 4
    add $8, $6, $14
    sw $4, 0($8)
    addi $13, $13, 1
    j linha2

proxima_linha3:
    addi $9, $9, 1
    li $13, 0
linha3:
    beq $13, 5, avanca_circulo
    beq $13, 0, skip3
    beq $13, 4, skip3
    mul $14, $9, 128
    add $14, $14, $10
    add $14, $14, $13
    mul $14, $14, 4
    add $8, $6, $14
    sw $4, 0($8)
skip3:
    addi $13, $13, 1
    j linha3

avanca_circulo:
    addi $9, $9, -3     # volta para linha original
    addi $10, $10, 8    # espaÁo entre circulos
    addi $12, $12, 1
    j circular_loop

fim_circulos:
    jr $31
