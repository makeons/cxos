; stage2.asm - İkinci aşama bootloader

[BITS 16]
[ORG 0x2000]          ; Stage 2'nin yüklenmeye başlayacağı bellek adresi

start_stage2:
    ; Kernel'i yükleme işlemleri
    mov ax, 0x3000     ; Kernel'in hedef yeri (örneğin 0x3000)
    mov ds, ax         ; Data segmenti
    mov es, ax         ; Extra segmenti

    ; Kernel'i yükle
    mov bx, 0x4000     ; Kernel'in yeri (0x4000'de)
    call load_kernel   ; Kernel'i yüklemek için fonksiyon çağrısı

    ; Kernel yüklendikten sonra, 32-bit moda geçiş yapılabilir
    ; Burada 32-bit mod geçişi için gerekli talimatları eklemeniz gerekebilir
    jmp $               ; Sonsuz döngü (Kernel çalışmaya başladıktan sonra burada durabilir)

; Kernel'i diskteki 0x4000 adresinden okuyacağız
load_kernel:
    mov ah, 0x02       ; Disk okuma fonksiyonu (BIOS interrupt)
    mov al, 1          ; 1 sektör oku (512 bayt)
    mov ch, 0          ; Silindir numarası (diskin başı)
    mov cl, 4          ; Kernel'in başladığı sektör (örneğin 4. sektör)
    mov dh, 0          ; Okuma başlatma kafası
    mov dl, 0x80       ; 0x80, ilk sabit disk (ilk harddisk)
    mov es, 0x3000     ; Kernel'i bellek adresine yükleyeceğimiz adres (0x3000)
    mov bx, 0x0000     ; Kendi segmanımıza başla
    int 0x13           ; BIOS interrupt çağrısı (diskten okuma)

    ; Eğer okuma hatalıysa error etiketi üzerine atla
    jc error           ; Eğer okuma hatalıysa error etiketine atla
    ret

error:
    ; Hata durumunda "Hata!" mesajı yazdır
    mov ah, 0x0E       ; BIOS ekran fonksiyonu
    mov al, 'H'        ; 'H' harfi
    int 0x10           ; Ekrana yazdır
    mov al, 'a'        ; 'a' harfi
    int 0x10           ; Ekrana yazdır
    mov al, 't'        ; 't' harfi
    int 0x10           ; Ekrana yazdır
    mov al, 'a'        ; 'a' harfi
    int 0x10           ; Ekrana yazdır
    mov al, '!'        ; '!' işareti
    int 0x10           ; Ekrana yazdır

    ; Hata durumunda sonsuz döngüye gir
    jmp $              ; Sonsuz döngüye gir

times 510 - ($ - $$) db 0   ; 510 byte boşluk bırak
dw 0xAA55                    ; Boot signature (MBR işaretçisi)
