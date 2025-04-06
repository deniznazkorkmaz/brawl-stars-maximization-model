/*********************************************
 * OPL 22.1.2.0 Model
 * Author: deniz
 * Creation Date: 4 Nis 2025 at 14:56:08
 *********************************************/
{int} setofI=...; // Tur kümesi
{string} setofJ = ...; // Oyuncu kümesi
{string} setofK = ...; // Harita kümesi
{string} setofSK = ...; // Savaş kazanma görevleri
{string} setofHV =...; // Hasar verme görevleri
{string} setofDY =...; // Düşman yok etme görevleri
{string} setofL =setofSK union setofHV union setofDY; // Tüm görevler


// karar değişkenleri
dvar boolean xijk[setofI][setofJ][setofK]; // Tur, oyuncu, harita ataması
dvar boolean yl[setofL]; // Görev tamamlanma durumu

// parametreler
int P =...; // görev tamamlama ödülü
int M = ...;
int Rjk[setofJ][setofK] = ...; // oyuncu-harita performansı
int Akl[setofK][setofL] = ...; // harita-görev uyumluluğu
int Bjl[setofJ][setofL]=...; // oyuncu-görev uyumluluğu
float Kjkl[setofJ][setofK][setofL] = ...; // oyuncu-harita-kategori performansı
int Cl[setofL] = ...; // görev tamamlamak için gereken değer

// amaç fonksiyonu
maximize sum(l in setofL) P * yl[l];

// kısıtlar
subject to {
// oynanan tur sayısı 20 olmalı
    sum(i in setofI, j in setofJ, k in setofK) xijk[i][j][k] ==25;
     
    //her turda oynanmalı
   forall(i in setofI) {
              sum(k in setofK, j in setofJ) xijk[i][j][k] == 1;
     }        
    // harita-görev, oyuncu-görev uyumluluğunun olduğu yerler için Cl tamamlanmışsa yl=1, değilse yl=0      
    forall(l in setofL, j in setofJ, k in setofK : Akl[k][l] == 1 && Bjl[j][l] == 1) {
              sum(i in setofI) xijk[i][j][k] * Kjkl[j][k][l] * Rjk[j][k] >= Cl[l] - M * (1 - yl[l]);
     }        
}
