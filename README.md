# 🔧 ARM Assembly Project: Search & Sort Operations

##  Overview (English)

This project implements two fundamental operations—**searching** and **sorting**—using the ARM Assembly language. It is designed and tested in the **KEIL uVision** simulator as part of the *Computer Organization and Architecture* course.

The main goal is to demonstrate how low-level programming can be used to manipulate arrays directly via registers and stack memory, simulating how processors manage data internally.

###  Features

* **Search Function (`bul`)**
  Uses a linear search algorithm to find a given value in an array.

  * If the value exists, the function returns `R0 = 1` and the address in `R1`.
  * If not found, it returns `R0 = 0`.

* **Sort Function (`sirala`)**
  Implements **Counting Sort**, an efficient algorithm for sorting small-range integer arrays.

  * Finds the max value in the array.
  * Uses stack memory to dynamically allocate a count array.
  * Rewrites the sorted array in place.

* **Test Scenarios**

  * Search for existing and non-existing values (e.g., 4 and 7).
  * Sort a sample array and verify the results.

* **Stack-Based Memory Management**
  All temporary arrays and intermediate data are handled using stack operations, mimicking memory allocation at the hardware level.

### 🧪 Example Array

Input:
`[2, 0, 2, 3, 3, 0, 1, 0, 0, 4, 2, 1]`

Sorted Output:
`[0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 4]`

---

#  Genel Bakış 

Bu proje, **ARM Assembly dili** kullanılarak geliştirilmiş iki temel işlemi içermektedir: **arama** ve **sıralama**. Proje, *Bilgisayar Organizasyonu ve Mimarisi* dersi kapsamında hazırlanmış ve **KEIL uVision** simülatöründe test edilmiştir.

Amaç, düşük seviyeli programlama ile diziler üzerinde doğrudan işlem yapmayı ve bu işlemler sırasında yığın (stack) kullanarak bellek yönetimini taklit etmektir.

## 🧠 Özellikler

* **Arama Fonksiyonu (`bul`)**
  Lineer arama algoritması kullanarak, girilen değerin dizide olup olmadığını kontrol eder.

  * Değer bulunursa `R0 = 1`, adresi `R1` register'ında döner.
  * Bulunmazsa `R0 = 0`.

* **Sıralama Fonksiyonu (`sirala`)**
  **Counting Sort** algoritması kullanılarak diziyi sıralar.

  * En büyük değeri bulur.
  * Stack üzerinde `count` dizisi oluşturur.
  * Sıralanmış diziyi oluşturur ve orijinal dizinin üzerine yazar.

* **Test Senaryoları**

  * Var olan ve olmayan elemanlar için arama testleri (örneğin 4 ve 7).
  * Örnek dizi sıralanarak doğruluk kontrolü yapılır.

* **Stack Tabanlı Bellek Yönetimi**
  Tüm geçici diziler ve hesaplamalar yığın üzerinden yapılır; bu da donanım düzeyinde bellek yönetimini simüle eder.

###  Örnek Dizi

Giriş Dizisi:
`[2, 0, 2, 3, 3, 0, 1, 0, 0, 4, 2, 1]`

Sıralı Çıktı:
`[0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 4]`

---
