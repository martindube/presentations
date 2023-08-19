#include <windows.h>
#include <stdio.h>
#include <tlhelp32.h>

// Source: https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messagebox
int insert_user_interaction() {
	int msgboxID = MessageBox(
		NULL,
		(LPCWSTR)L"Resource not available\nDo you want to try again?",
		(LPCWSTR)L"Account Details",
		MB_ICONWARNING | MB_CANCELTRYCONTINUE | MB_DEFBUTTON2
	);

	switch (msgboxID)
	{
	case IDCANCEL:
		// TODO: add code
		exit(1);
		break;
	case IDTRYAGAIN:
		// TODO: add code
		exit(1);
		break;
	case IDCONTINUE:
		// TODO: add code
		return 1;			//<-- this will run shellcode
		break;
	}

	return 0;
}


// Source: https://stackoverflow.com/questions/865152/how-can-i-get-a-process-handle-by-its-name-in-c

DWORD FindProcessId(wchar_t* processName)
{
	PROCESSENTRY32 processInfo;
	processInfo.dwSize = sizeof(processInfo);

	HANDLE processesSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	if (processesSnapshot == INVALID_HANDLE_VALUE) {
		return 0;
	}

	Process32First(processesSnapshot, &processInfo);
	if (wcscmp(processInfo.szExeFile, processName) == 0)
	{
		CloseHandle(processesSnapshot);
		return processInfo.th32ProcessID;
	}

	while (Process32Next(processesSnapshot, &processInfo))
	{
		if (wcscmp(processInfo.szExeFile, processName) == 0)
		{
			CloseHandle(processesSnapshot);
			return processInfo.th32ProcessID;
		}
	}

	CloseHandle(processesSnapshot);
	return 0;
}