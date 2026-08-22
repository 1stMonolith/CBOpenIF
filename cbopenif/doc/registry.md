Register CBOpenIFHelper.dll 32-bit regsvr32:
c:\Windows\SysWOW64\regsvr32.exe C:\Windows\SysWOW64\CBOpenIFHelper.dll

Configure CBOpenIFHelper.dll as a com surrogate in the registery:
[HKEY_CLASSES_ROOT\Wow6432Node\CLSID{3CEFCA96-1892-4539-8747-292BB8AE1D4B}]
"AppID"="{3CEFCA96-1892-4539-8747-292BB8AE1D4B}"

[HKEY_CLASSES_ROOT\Wow6432Node\AppID{3CEFCA96-1892-4539-8747-292BB8AE1D4B}]
"DllSurrogate"=""
