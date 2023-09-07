import RPi.GPIO as GPIO
import time
from threading import Thread

GPIO.setwarnings(False)

# Atur mode pin GPIO
GPIO.setmode(GPIO.BCM)

# Tentukan pin yang akan digunakan
b = 13
lg = 12
lr = 6
vb = 1

#Atur waktu belajar
detik = 0 #int(input("Atur waktu belajar anda (Menit): "))
waktu_belajar_menit = detik * 60

def start(duration):
  detik = duration
  waktu_belajar_menit = detik * 60

  start_beeping()
  #t = Thread(target=start_beeping)
  #t.start()


# Konfigurasi pin sebagai OUTPUT (untuk LED dan Buzzer) dan INPUT (untuk tombol)
GPIO.setup(lg, GPIO.OUT)
GPIO.setup(lr, GPIO.OUT)
GPIO.setup(vb, GPIO.OUT)
GPIO.setup(b, GPIO.IN, pull_up_down=GPIO.PUD_UP)  # Pull-up resistor

def selesai_belajar():
  GPIO.output(lg, GPIO.LOW)

# Fungsi untuk menghasilkan nada VB
def beep(f, duration):
    # Hitung periode dari frekuensi
    period = 1.0 / f
    #Hitung jumlah siklus
    cycles = int(duration * f)
    
    for _ in range(cycles):
        GPIO.output(vb, GPIO.HIGH)
        time.sleep(period / 2)
        GPIO.output(vb, GPIO.LOW)
        time.sleep(period / 2)
        
#Fungsi untuk menyalakan LG
def turn_on_lg():
    GPIO.output(lg, GPIO.HIGH)
    time.sleep(waktu_belajar_menit)
    
# Fungsi untuk menghidupkan LR
def turn_on_led():
    GPIO.output(lr, GPIO.HIGH)
    GPIO.output(lg, GPIO.LOW)
    GPIO.output(vb, GPIO.HIGH)
    beep(1000, 0.08)
# Fungsi untuk mematikan LR
def turn_off_led():
    GPIO.output(lr, GPIO.LOW)
    turn_on_lg()
    GPIO.output(vb, GPIO.LOW)

def start_beeping():
  try:
    kondisi = True
    while kondisi:
        # Periksa status tombol (ditekan atau tidak)
        if GPIO.input(b) == GPIO.LOW:  # Tombol ditekan
            turn_off_led()
            kondisi = False
        else:
            turn_on_led()
        time.sleep(0.1)  # Tunggu sebentar sebelum membaca tombol lagi
  except KeyboardInterrupt:
    GPIO.cleanup()  # Ber1 sihkan konfigurasi GPIO saat program dihentikan
     
