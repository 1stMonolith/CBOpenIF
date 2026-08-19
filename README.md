# CBOpenIF

CBOpenIF is an Odin library that wraps ABB’s Control Builder Open Interface.

The library wraps the COM interface so the user can call the Open Interface with ordinary Odin procedures instead of raw COM plumbing.

In order to run the examples the following is required:

Register CBOpenIFHelper.dll 32-bit regsvr32:
c:\Windows\SysWOW64\regsvr32.exe C:\Windows\SysWOW64\CBOpenIFHelper.dll

Configure CBOpenIFHelper.dll as a com surrogate in the registery:
[HKEY_CLASSES_ROOT\Wow6432Node\CLSID{3CEFCA96-1892-4539-8747-292BB8AE1D4B}]
"AppID"="{3CEFCA96-1892-4539-8747-292BB8AE1D4B}"

[HKEY_CLASSES_ROOT\Wow6432Node\AppID{3CEFCA96-1892-4539-8747-292BB8AE1D4B}]
"DllSurrogate"=""
