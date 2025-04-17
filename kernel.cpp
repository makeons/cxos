// Kernel başlangıç dosyası (kernel.cpp)
#include <stddef.h>
#include <stdint.h>

// Ekrana yazı yazmak için temel bir fonksiyon
void print(const char* str)
{
    uint16_t* video_memory = (uint16_t*)0xB8000; // Video bellek adresi
    while (*str)
    {
        *video_memory = (uint16_t)(*str | 0x0F00); // Yazıyı ekrana yaz (0x0F00: beyaz metin, siyah zemin)
        ++str;
        ++video_memory;
    }
}

// Kernel ana fonksiyonu
extern "C" void kernel_main()
{
    print("Hello OS");

    // Burada başka işlemler yapılabilir, örneğin işlem yöneticisi veya bellek yöneticisi başlatılabilir.
    while (1)
    {
        // Sonsuz döngü, çekirdek çalışmaya devam eder
    }
}
