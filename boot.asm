; MBM Bootloader
[BITS 16]              ; 16-bit modda �al��aca��z
[ORG 0x7C00]           ; Bootloader, 0x7C00 adresinden �al��acak

start:
    ; MBM Bootloader yazd�rma
    mov ah, 0x0E       ; Teletype Output fonksiyonu (ekran yazd�rma)
    mov al, 'M'        ; 'M' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'B'        ; 'B' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'M'        ; 'M' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, ' '        ; Bo�luk karakteri
    int 0x10           ; BIOS interrupt
    mov al, 'B'        ; 'B' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'o'        ; 'o' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'o'        ; 'o' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 't'        ; 't' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'l'        ; 'l' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'o'        ; 'o' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'a'        ; 'a' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'd'        ; 'd' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'e'        ; 'e' harfini yazd�r
    int 0x10           ; BIOS interrupt
    mov al, 'r'        ; 'r' harfini yazd�r
    int 0x10           ; BIOS interrupt

    ; Stage2 dosyas�n� kontrol et
    ; Burada, stage2.asm dosyas�n�n y�kl� oldu�u diske g�re kontrol yap�labilir
    ; Disk okuma i�lemi ba�lat�lacak (BIOS interrupt kullanarak)

    ; Diskten Stage 2'yi okuma i�lemi
    mov ah, 0x02       ; Disk okuma fonksiyonu (BIOS interrupt)
    mov al, 1          ; 1 sekt�r oku (512 bayt)
    mov ch, 0          ; Silindir numaras� (diskin ba��)
    mov cl, 2          ; Stage 2'nin ba�lad��� sekt�r (�rne�in 2. sekt�r)
    mov dh, 0          ; Okuma ba�latma kafas�
    mov dl, 0x80       ; 0x80, ilk sabit disk (ilk harddisk)
    mov es, 0x2000     ; Belle�e Stage 2'yi y�kleyece�imiz adres (0x2000)
    mov bx, 0x0000     ; Kendi segman�m�za ba�la
    int 0x13           ; BIOS interrupt �a�r�s� (diskten okuma)

    ; E�er okuma hatal�ysa error etiketi �zerine atla
    jc error           ; E�er okuma hatal�ysa error etiketine atla

    ; Stage 2 ba�ar�yla y�klendiyse "Booting the kernel" yazd�r
    mov ah, 0x0E       ; Teletype Output fonksiyonu
    mov al, 'B'        ; 'B' harfini yazd�r
    int 0x10
    mov al, 'o'        ; 'o' harfini yazd�r
    int 0x10
    mov al, 'o'        ; 'o' harfini yazd�r
    int 0x10
    mov al, 't'        ; 't' harfini yazd�r
    int 0x10
    mov al, 'i'        ; 'i' harfini yazd�r
    int 0x10
    mov al, 'n'        ; 'n' harfini yazd�r
    int 0x10
    mov al, 'g'        ; 'g' harfini yazd�r
    int 0x10
    mov al, ' '        ; Bo�luk karakteri
    int 0x10
    mov al, 't'        ; 't' harfini yazd�r
    int 0x10
    mov al, 'h'        ; 'h' harfini yazd�r
    int 0x10
    mov al, 'e'        ; 'e' harfini yazd�r
    int 0x10
    mov al, ' '        ; Bo�luk karakteri
    int 0x10
    mov al, 'k'        ; 'k' harfini yazd�r
    int 0x10
    mov al, 'e'        ; 'e' harfini yazd�r
    int 0x10
    mov al, 'r'        ; 'r' harfini yazd�r
    int 0x10
    mov al, 'n'        ; 'n' harfini yazd�r
    int 0x10
    mov al, 'e'        ; 'e' harfini yazd�r
    int 0x10
    mov al, 'l'        ; 'l' harfini yazd�r
    int 0x10

    ; Sonsuz d�ng�ye gir (Kernel �al��maya ba�lad�ktan sonra burada durabilir)
    jmp $

error:
    ; Hata durumunda "Error!" mesaj� yazd�r
    mov ah, 0x0E       ; BIOS ekran fonksiyonu
    mov al, 'E'        ; 'E' harfi
    int 0x10           ; Ekrana yazd�r
    mov al, 'r'        ; 'r' harfi
    int 0x10           ; Ekrana yazd�r
    mov al, 'r'        ; 'r' harfi
    int 0x10           ; Ekrana yazd�r
    mov al, 'o'        ; 'o' harfi
    int 0x10           ; Ekrana yazd�r
    mov al, 'r'        ; 'r' harfi
    int 0x10           ; Ekrana yazd�r
    mov al, '!'        ; '!' i�areti
    int 0x10           ; Ekrana yazd�r

    ; 20 saniye geri say�m
    mov cx, 20         ; 20 saniye sayac�
backward_countdown:
    mov ah, 0x0E       ; BIOS ekran fonksiyonu
    mov al, '0'        ; Geri say�m�n say�s�n� yazd�r
    int 0x10           ; Ekrana yazd�r
    ; Geri say�m� yap
    loop backward_countdown

    ; Hata durumunda sonsuz d�ng�ye gir
    jmp $

times 510 - ($ - $$) db 0   ; 510 byte bo�luk b�rak
dw 0xAA55                    ; Boot sekt�r� i�aret�isi
