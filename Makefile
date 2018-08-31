# if -march=native does not work on your platform, you could try
# -msse
# -msse2
# -mavx
# or
# -mavx2

CC     = gcc

CFLAGS = -std=gnu99 -O3 -march=native

all: solve_bs solve_piwi_bs solve_piwi libnfc_crypto1_crack

CRAPTEV1 = craptev1-v1.1/craptev1.c -I craptev1-v1.1/
CRAPTO1 = crapto1-v3.3/crapto1.c crapto1-v3.3/crypto1.c -I crapto1-v3.3/ 
CRYPTO1_BS = crypto1_bs.c crypto1_bs_crack.c 

solve_bs:
	$(CC) $(CFLAGS) $@.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -o $@ -lpthread -lm

solve_piwi_bs:
	$(CC) $(CFLAGS) $@.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -o $@ -lpthread -lm

solve_piwi:
	$(CC) $(CFLAGS) $@.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -o $@ -lpthread

libnfc_crypto1_crack:
	$(CC) $(CFLAGS) $@.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -o $@ -lpthread -lnfc -lm

clean:
	rm -f solve.so solve_bs solve_piwi_bs solve_piwi libnfc_crypto1_crack

get_craptev1:
	wget https://ucdd60992e1585e21b0472c258e5.dl.dropboxusercontent.com/cd/0/get/APXsQXev89JmkuTccw7HpgTn0Fd_6lJYgsqfT4OOB92mdADm67aecLV-fwDct2bPwwHwbauyFZrQnqwhdGmBvSaLj8vpW4SBh91Irc1KaxG8jjiUOngw-hBEetOQ8Xxouc9OClKO-tnPVd8vvO5enFQD5IwzP4cd4PBJlaEHabJPXVfwyEUzfj6GB1s3YgIHfJQ/file?_download_id=3552358793112151421847892703509197120013386877683377850662551804106&_notify_domain=www.dropbox.com&dl=1
	tar Jxvf craptev1-v1.1.tar.xz

get_crapto1:
	wget https://ucf98cfb4cc586001f3b04140d75.dl.dropboxusercontent.com/cd/0/get/APV2dO0hIshwShij2usAynmuuz8zod8lEMl3b2KNLlmEC4RQHbT2BxZ5z9ooJ-I9JrhZX9XdJNYBCWAjeYQiP0pP2JfFa2OHva1nvkPWmDwtuKv0fPILdeWi--FHKPT2DbJvPHXc-F2xKnwD3WNcvRB0CQmrTfI7Ef0s6rUrbaREtFUXmSJA6pVVKkN_xrZxDW0/file?_download_id=4617751596485617592586780604915773144236120782114462585954007834&_notify_domain=www.dropbox.com&dl=1
	mkdir crapto1-v3.3
	tar Jxvf crapto1-v3.3.tar.xz -C crapto1-v3.3

# Windows cross compilation
MINGW32 = i686-w64-mingw32-gcc
MINGW64 = x86_64-w64-mingw32-gcc
# solve.c code cannot be compiled on windows without patching the includes

WIN32EXES = solve_piwi_bs32.exe solve_piwi32.exe libnfc_crypto1_crack32.exe
win32: $(WIN32EXES)
win32_clean:
	rm -f $(WIN32EXES)

WIN64EXES = solve_piwi_bs64.exe solve_piwi64.exe libnfc_crypto1_crack64.exe
win64: $(WIN64EXES)
win64_clean:
	rm -f $(WIN64EXES)

solve_piwi_bs32.exe:
	$(MINGW32) $(CFLAGS) solve_piwi_bs.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -static -m32 -o $@ -lpthread

solve_piwi_bs64.exe:
	$(MINGW64) $(CFLAGS) solve_piwi_bs.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -static -o $@ -lpthread

solve_piwi32.exe:
	$(MINGW32) $(CFLAGS) solve_piwi.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -static -m32 -o $@ -lpthread

solve_piwi64.exe:
	$(MINGW64) $(CFLAGS) solve_piwi.c $(CRYPTO1_BS) $(CRAPTO1) ${CRAPTEV1} -static -o $@ -lpthread

