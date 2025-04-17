; MBM Bootloader
[BITS 16]              ; 16-bit modda çalýþacaðýz
[ORG 0x7C00]           ; Bootloader, 0x7C00 adresinden çalýþacak

start:
    ; MBM Bootloader yazdýrma
    mov ah, 0x0E       ; Teletype Output fonksiyonu (ekran yazdýrma)
    mov al, 'M'        ; 'M' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'B'        ; 'B' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'M'        ; 'M' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, ' '        ; Boþluk karakteri
    int 0x10           ; BIOS interrupt
    mov al, 'B'        ; 'B' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'o'        ; 'o' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'o'        ; 'o' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 't'        ; 't' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'l'        ; 'l' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'o'        ; 'o' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'a'        ; 'a' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'd'        ; 'd' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'e'        ; 'e' harfini yazdýr
    int 0x10           ; BIOS interrupt
    mov al, 'r'        ; 'r' harfini yazdýr
    int 0x10           ; BIOS interrupt

    ; Stage2 dosyasýný kontrol et
    ; Burada, stage2.asm dosyasýnýn yüklü olduðu diske göre kontrol yapýlabilir
    ; Disk okuma iþlemi baþlatýlacak (BIOS interrupt kullanarak)

    ; Diskten Stage 2'yi okuma iþlemi
    mov ah, 0x02       ; Disk okuma fonksiyonu (BIOS interrupt)
    mov al, 1          ; 1 sektör oku (512 bayt)
    mov ch, 0          ; Silindir numarasý (diskin baþý)
    mov cl, 2          ; Stage 2'nin baþladýðý sektör (örneðin 2. sektör)
    mov dh, 0          ; Okuma baþlatma kafasý
    mov dl, 0x80       ; 0x80, ilk sabit disk (ilk harddisk)
    mov es, 0x2000     ; Belleðe Stage 2'yi yükleyeceðimiz adres (0x2000)
    mov bx, 0x0000     ; Kendi segmanýmýza baþla
    int 0x13           ; BIOS interrupt çaðrýsý (diskten okuma)

    ; Eðer okuma hatalýysa error etiketi üzerine atla
    jc error           ; Eðer okuma hatalýysa error etiketine atla

    ; Stage 2 baþarýyla yüklendiyse "Booting the kernel" yazdýr
    mov ah, 0x0E       ; Teletype Output fonksiyonu
    mov al, 'B'        ; 'B' harfini yazdýr
    int 0x10
    mov al, 'o'        ; 'o' harfini yazdýr
    int 0x10
    mov al, 'o'        ; 'o' harfini yazdýr
    int 0x10
    mov al, 't'        ; 't' harfini yazdýr
    int 0x10
    mov al, 'i'        ; 'i' harfini yazdýr
    int 0x10
    mov al, 'n'        ; 'n' harfini yazdýr
    int 0x10
    mov al, 'g'        ; 'g' harfini yazdýr
    int 0x10
    mov al, ' '        ; Boþluk karakteri
    int 0x10
    mov al, 't'        ; 't' harfini yazdýr
    int 0x10
    mov al, 'h'        ; 'h' harfini yazdýr
    int 0x10
    mov al, 'e'        ; 'e' harfini yazdýr
    int 0x10
    mov al, ' '        ; Boþluk karakteri
    int 0x10
    mov al, 'k'        ; 'k' harfini yazdýr
    int 0x10
    mov al, 'e'        ; 'e' harfini yazdýr
    int 0x10
    mov al, 'r'        ; 'r' harfini yazdýr
    int 0x10
    mov al, 'n'        ; 'n' harfini yazdýr
    int 0x10
    mov al, 'e'        ; 'e' harfini yazdýr
    int 0x10
    mov al, 'l'        ; 'l' harfini yazdýr
    int 0x10

    ; Sonsuz döngüye gir (Kernel çalýþmaya baþladýktan sonra burada durabilir)
    jmp $

error:
    ; Hata durumunda "Error!" mesajý yazdýr
    mov ah, 0x0E       ; BIOS ekran fonksiyonu
    mov al, 'E'        ; 'E' harfi
    int 0x10           ; Ekrana yazdýr
    mov al, 'r'        ; 'r' harfi
    int 0x10           ; Ekrana yazdýr
    mov al, 'r'        ; 'r' harfi
    int 0x10           ; Ekrana yazdýr
    mov al, 'o'        ; 'o' harfi
    int 0x10           ; Ekrana yazdýr
    mov al, 'r'        ; 'r' harfi
    int 0x10           ; Ekrana yazdýr
    mov al, '!'        ; '!' iþareti
    int 0x10           ; Ekrana yazdýr

    ; 20 saniye geri sayým
    mov cx, 20         ; 20 saniye sayacý
backward_countdown:
    mov ah, 0x0E       ; BIOS ekran fonksiyonu
    mov al, '0'        ; Geri sayýmýn sayýsýný yazdýr
    int 0x10           ; Ekrana yazdýr
    ; Geri sayýmý yap
    loop backward_countdown

    ; Hata durumunda sonsuz döngüye gir
    jmp $

times 510 - ($ - $$) db 0   ; 510 byte boþluk býrak
dw 0xAA55                    ; Boot sektörü iþaretçisi
