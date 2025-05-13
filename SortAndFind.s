		AREA SortAndFind,CODE,READONLY
			ENTRY
			EXPORT main
			
main PROC
    LDR R1, =dizi				; R1 = dizi adresi
    LDR R2, =2					; R2 = 1 || 2

    CMP R2, #1					; R2 ? 1 = Bul			
    BEQ bul_test

    CMP R2, #2					; R2 ? 2 = Sirala	
    BEQ sirala_test			

    B .							; Sonsuz Döngü (Program Burada Biter) 

bul_test
    MOV R0, #7         			; Aranacak deger: 7
    BL bul						; bul fonksiyonuna dallanma
    B .							; Döndükten sonra programi durdurma

sirala_test
    MOV R0, R1					; R0 = dizi adresi
    BL sirala					; sirala fonksiyonuna dallan
    B .							; Döndükten sonra programi durdur



bul
    PUSH {R2-R5, LR}			; R2-R5 arasini ve LR'yi yigina kaydet
    MOV R2, R0      			; Aranan degeri R2'ye al (3)
    LDR R3, [R1]    			; R3 = Dizi uzunlugu
    ADD R4, R1, #4  			; R4 = Dizi ilk eleman adresi
    MOV R5, #0					; R5 = index (i = 0)

dongu_bul
    CMP R5, R3					; i >= uzunluk ?
    BGE bulunamadi				; Evetse arama basarisiz
    LDR R0, [R4, R5, LSL #2]	; R0 ? dizi[i]
    CMP R0, R2					; dizi[i] == aranacak ?
    BEQ bulundu					; Evetse bulundu
    ADD R5, R5, #1				; index arttirma (i++)
    B dongu_bul					; döngüye devam

bulundu
    MOV R0, #1					; R0 = 1 (bulundu)
    ADD R1, R4, R5, LSL #2		; R1 = bulunan elemanin adresi
    POP {R2-R5, LR}				; Kaydedilenleri geri yükle (Stack i Serbest Birakma) 
    BX LR						; Geri dön

bulunamadi
    MOV R0, #0					; R0 = 0 (bulunamadi)
    POP {R2-R5, LR}				; Kaydedilenleri geri yükle
    BX LR						; Geri dön



sirala
    PUSH {R4-R12, LR}			; R4-R12 arasi ve LR'yi yigina kaydet

    LDR R1, [R0]            	; R1 = dizi uzunlugu
    MOV R2, #0					; R2 = 0 (bos)
    MOV R3, #1              	; R3 = i = 1 (ilk veri)

	; max degeri bulmak için döngü
    MOV R4, #0              	; R4 ? max = 0
max
    CMP R3, R1                  ; i > uzunluk?
    BGT count_yer_ayir          ; Evetse bitir
    LDR R5, [R0, R3, LSL #2]    ; R5 = dizi[i]
    CMP R5, R4                  ; dizi[i] > max?
    BLS buyuk_degilse_atla      ; Hayirsa atla
    MOV R4, R5                  ; max = dizi[i]
buyuk_degilse_atla
    ADD R3, R3, #1              ; i++
    B max                       ; döngüye devam et
	
    ; Count dizisi için yer ayirma
count_yer_ayir
    ADD R4, R4, #1              ; max + 1 (count dizisi boyutu için)
    LSL R4, R4, #2              ; byte cinsinden çarp (max+1)*4
    SUB SP, SP, R4              ; Stack'te yer ayir
    MOV R6, SP                  ; R6 ? count dizisi adresi

    ; count dizisini sifirla
    MOV R7, #0
count_sifirla
    CMP R7, R4                  ; i >= count boyutu?
    BGE count_sayma             ; Evetse devam et
    STR R7, [R6, R7]            ; Alternatif yazim (bos)
    MOV R5, #0                  ; Sifirla
    STR R5, [R6, R7]            ; count[i] = 0
    ADD R7, R7, #4              ; i++
    B count_sifirla                    ; döngüye devam

count_sayma
    MOV R8, #1                  ; i = 1
    LDR R9, [R0]                ; R9 ? dizi uzunlugu

; count[i]++
count_dongu
    CMP R8, R9                  ; i > uzunluk?
    BGT siraliD_yer_ayir                ; Evetse geç
    LDR R10, [R0, R8, LSL #2]   ; dizi[i]
    LSL R11, R10, #2            ; index * 4
    LDR R12, [R6, R11]          ; count[dizi[i]]
    ADD R12, R12, #1            ; count++
    STR R12, [R6, R11]          ; yaz geri
    ADD R8, R8, #1              ; i++
    B count_dongu 
	
; Sirali dizi için yer ayirma
siraliD_yer_ayir
    LDR R5, [R0]                ; R5 ? dizi uzunlugu
    LSL R5, R5, #2              ; byte olarak uzunluk
    SUB SP, SP, R5              ; stack'te yer aç
    MOV R7, SP                  ; R7 ? sirali dizi adresi

    ; count dizisinden sirali diziyi olustur
    MOV R8, #0              ; i = 0
    MOV R9, #0              ; index = 0
	
; Sirali diziyi count dizisinden olusturma
sirala_dongu
    LSL R10, R8, #2         ; i*4
    LDR R11, [R6, R10]      ; count[i]
    CMP R11, #0
    BEQ sayma_dongu_devam               ; sifirsa atla

    ; count[i] adet kadar i’yi sirali diziye koy
kopyala_dongu
    CMP R11, #0
    BEQ sayma_dongu_devam
    STR R8, [R7, R9, LSL #2]; sirali[index] = i
    ADD R9, R9, #1          ; index++
    SUB R11, R11, #1        ; count--
    B kopyala_dongu
	
; Sayma döngüsüne devam noktasi
sayma_dongu_devam
    ADD R8, R8, #1          ; i++
    CMP R8, R4, LSR #2      ; i < max+1 ?
    BLT sirala_dongu        ; döngüye devam

    ; sirali diziyi orijinal dizinin yerine yaz
    MOV R8, #1
    LDR R9, [R0]            ; uzunluk
	
; Sirali diziyi orijinalin üzerine yazma
kopyala2
    CMP R8, R9
    BGT bitir
    LDR R10, [R7, R8, LSL #2]; sirali[i]
    STR R10, [R0, R8, LSL #2]; orijinale yaz
    ADD R8, R8, #1
    B kopyala2
	
bitir
    MOV R0, R7              ; R0 ? sirali dizi adresi
    ADD SP, SP, R4          ; count dizisi alanini geri al
    ADD SP, SP, R5          ; sirali dizi alanini geri al

    POP {R4-R12, LR}        ; kayitlari geri yükle
    BX LR                   ; geri dön
        ENDP

;-----------------------------------------------------------
dizi    DCD 12,2,0,2,3,3,0,1,0,0,4,2,1  ; Dizi: Ilk eleman boyut (12), devami elemanlar

        AREA MyData, DATA, READWRITE  
        

        END                           
