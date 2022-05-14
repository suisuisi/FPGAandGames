/************************************************************************
Lab 9 Nios Software

Dong Kai Wang, Fall 2017
Christine Chen, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "aes.h"

// Pointer to base address of AES module, make sure it matches Qsys
volatile unsigned int * AES_PTR = (unsigned int *) 0x00000100;

// Execution mode: 0 for testing, 1 for benchmarking
int run_mode = 0;

/** charToHex
 *  Convert a single character to the 4-bit value it represents.
 *
 *  Input: a character c (e.g. 'A')
 *  Output: converted 4-bit value (e.g. 0xA)
 */
char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <= 'F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <= 'f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

/** charsToHex
 *  Convert two characters to byte value it represents.
 *  Inputs must be 0-9, A-F, or a-f.
 *  
 *  Input: two characters c1 and c2 (e.g. 'A' and '7')
 *  Output: converted byte value (e.g. 0xA7)
 */
char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}


void SubBytes(unsigned char* state)
{
	for (int i=0; i<16;i++){
		state[i] = aes_sbox[state[i]];
	}
}

void Subword(unsigned char* word)
{
	for (int i=0; i<4;i++){
		word[i] = aes_sbox[word[i]];
	}
	// return *word;
}

void AddRoundKey(unsigned char* state, unsigned char* Round_key, int n)
{
	int i,j;
	for (i = 0; i< 4; i++){
		for (j = 0; j< 4; j++){
			state[4*i+j] = state[4*i+j] ^ Round_key[16*n+4*i+j]; //nth round key
		}
	}

}

void ShiftRows(unsigned char* state)
{
	// for (int i=1;i<4;i++){
	// 	unsigned char temp;
	// 	temp = State[i];
	// 	for (int j=0;j<3;j++){
	// 		int index = (i+j) % 4;
	// 		State[4*i+j] = State[4*i + index];
	// 	}
	// 	State[4*i+3] = temp;
	// }
	int line = 4;
	for (int i = 1;i< line;i++)
	{
		for (int j =0; j< i; j++)
		{
			unsigned char temp = state[i];
			state[i] = state[i+4];
			state[i+4] = state[i+8];
			state[i+8] = state[i+12];
			state[i+12] = temp;
		}
	}
}

void RotWord(unsigned char* word)
{
	unsigned char temp = word[0];
	word[0] = word[1];
	word[1] = word[2];
	word[2] = word[3];
	word[3] = temp;
	// return *word;
}

unsigned char multi(unsigned char element)
{
	if (element & 0x80)
	{
		return (element<<1) ^ 0x1b;
	}
	else
	{
		return element<<1;
	}

}

void MixColumns(unsigned char* state)
{
	unsigned char b[16];
	for (int i=0;i<4;i++)
	{
		b[4*i] = multi(state[4*i]) ^ (multi(state[4*i+1])^state[4*i+1]) ^ state[4*i+2] ^ state[4*i+3];
		b[4*i+1] = state[4*i] ^ multi(state[4*i+1]) ^ (multi(state[4*i+2])^state[4*i+2]) ^ state[4*i+3];
		b[4*i+2] = state[4*i] ^ state[4*i+1] ^ multi(state[4*i+2]) ^ (multi(state[4*i+3]) ^ state[4*i+3]);
		b[4*i+3] = (multi(state[4*i])^state[4*i]) ^ state[4*i+1] ^ state[4*i+2] ^ multi(state[4*i+3]);
	}
	for (int n=0; n<16; n++)
	{
		state[n] = b[n];
	}
}

void KeyExpansion(unsigned char* key, unsigned char* keyschedule, int nk)
{
	unsigned char temp[4]; 				//????????????
	int i = 0;
	while (i< 4*nk)
	{
		keyschedule[i] = key[i];
		i++;
	}
	i = 4*nk;
	while (i < 4 * 4 * 11)
	{

		for (int j=0; j<4;j++)
		{
			temp[j] = keyschedule[i+j-4];
		}
		if ( i % (4*nk) ==0)
		{
			RotWord(temp);
			Subword(temp);
			temp[0] ^= Rcon[(i/(4*nk))] >> 24;
		}
		for(int j = 0; j < 4; j++){
			keyschedule[i] = keyschedule[i - 4*nk] ^ temp[j];
			i++;													// i  increment
		}
	}

}


/** encrypt
 *  Perform AES encryption in software.
 *
 *  Input: msg_ascii - Pointer to 32x 8-bit char array that contains the input message in ASCII format
 *         key_ascii - Pointer to 32x 8-bit char array that contains the input key in ASCII format
 *  Output:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *               key - Pointer to 4x 32-bit int array that contains the input key
 */
void encrypt(unsigned char * msg_ascii, unsigned char * key_ascii, unsigned int * msg_enc, unsigned int * key)
{
	// Implement this function
	int Nr = 10;
	unsigned char msg[16];
	unsigned char mykey[16];
	unsigned char keyschedule[4*4*(Nr+1)];
	for (int i=0; i< 16; i++)
	{
		msg[i] = charsToHex(msg_ascii[2*i], msg_ascii[2*i+1]);
		mykey[i] = charsToHex(key_ascii[2*i], key_ascii[2*i+1]);
	}
	KeyExpansion(mykey, keyschedule, 4);
	AddRoundKey(msg,keyschedule,0);
	int round;
	for (round = 0; round< Nr-1; round++)
	{
		SubBytes(msg);
		ShiftRows(msg);
		MixColumns(msg);
		AddRoundKey(msg,keyschedule,round+1);

	}

	SubBytes(msg);
	ShiftRows(msg);
	AddRoundKey(msg,keyschedule,Nr);

	for(int i = 0; i < 4; i++){
		msg_enc[i] = (msg[4*i] << 24) + (msg[4*i + 1] << 16) + (msg[4*i + 2] << 8) + (msg[4*i + 3]);
		key[i] = (mykey[4*i] << 24) + (mykey[4*i + 1] << 16) + (mykey[4*i + 2] << 8) + (mykey[4*i + 3]);
	}


}

/** decrypt
 *  Perform AES decryption in hardware.
 *
 *  Input:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *              key - Pointer to 4x 32-bit int array that contains the input key
 *  Output: msg_dec - Pointer to 4x 32-bit int array that contains the decrypted message
 */
void decrypt(unsigned int * msg_enc, unsigned int * msg_dec, unsigned int * key)
{
	// Implement this function

		AES_PTR[14] = 0;
		AES_PTR[15] = 0;

		AES_PTR[0] = key[3];
		AES_PTR[1] = key[2];
		AES_PTR[2] = key[1];
		AES_PTR[3] = key[0];

		AES_PTR[4] = msg_enc[3];
		AES_PTR[5] = msg_enc[2];
		AES_PTR[6] = msg_enc[1];
		AES_PTR[7] = msg_enc[0];


		// set the AES_START to 1
		AES_PTR[14] = 1;


		while (AES_PTR[15] == 0){
		}

		msg_dec[3] = AES_PTR[8];
		msg_dec[2] = AES_PTR[9];
		msg_dec[1] = AES_PTR[10];
		msg_dec[0] = AES_PTR[11];


		AES_PTR[14] = 0;
		AES_PTR[15] = 0;
}

/** main
 *  Allows the user to enter the message, key, and select execution mode
 *
 */
int main()
{
	// Input Message and Key as 32x 8-bit ASCII Characters ([33] is for NULL terminator)
	unsigned char msg_ascii[33];
	unsigned char key_ascii[33];
	// Key, Encrypted Message, and Decrypted Message in 4x 32-bit Format to facilitate Read/Write to Hardware
	unsigned int key[4];
	unsigned int msg_enc[4];
	unsigned int msg_dec[4];




	printf("Select execution mode: 0 for testing, 1 for benchmarking: ");
	scanf("%d", &run_mode);

	if (run_mode == 0) {
		// Continuously Perform Encryption and Decryption
		while (1) {
			int i = 0;
			printf("\nEnter Message:\n");
			scanf("%s", msg_ascii);
			printf("\n");
			printf("\nEnter Key:\n");
			scanf("%s", key_ascii);
			printf("\n");
			encrypt(msg_ascii, key_ascii, msg_enc, key);
			printf("\nEncrpted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_enc[i]);
			}
			printf("\n");
			decrypt(msg_enc, msg_dec, key);
			printf("\nDecrypted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_dec[i]);
			}
			printf("\n");
		}
	}
	else {
		// Run the Benchmark
		int i = 0;
		int size_KB = 2;
		// Choose a random Plaintext and Key
		for (i = 0; i < 32; i++) {
			msg_ascii[i] = 'a';
			key_ascii[i] = 'b';
		}
		// Run Encryption
		clock_t begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			encrypt(msg_ascii, key_ascii, msg_enc, key);
		clock_t end = clock();
		double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		double speed = size_KB / time_spent;
		printf("Software Encryption Speed: %f KB/s \n", speed);
		// Run Decryption
		begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			decrypt(msg_enc, msg_dec, key);
		end = clock();
		time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		speed = size_KB / time_spent;
		printf("Hardware Encryption Speed: %f KB/s \n", speed);
	}
	return 0;
}
