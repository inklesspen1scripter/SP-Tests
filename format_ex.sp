public void OnPluginStart()
{
	RegServerCmd("sm_inttostring_low_test", CMD)
}

public Action CMD(int args)
{
	char sBuffer1[64]
	char sBuffer2[64]
	char sBuffer3[64]
	sBuffer1 = "buffer1"
	sBuffer2 = "string2"
	sBuffer3 = "line3"
	Format(sBuffer3, sizeof sBuffer3, "%s %s %s", sBuffer1, sBuffer3, sBuffer2)
	PrintToServer(sBuffer3)
	sBuffer3 = "line3"
	FormatEx(sBuffer3, sizeof sBuffer3, "%s %s %s", sBuffer1, sBuffer3, sBuffer2)
	PrintToServer(sBuffer3)
	sBuffer3 = "line3"
	Format(sBuffer3, sizeof sBuffer3, "%s %s", sBuffer1, sBuffer2)
	PrintToServer(sBuffer3)
	sBuffer3 = "line3"
	FormatEx(sBuffer3, sizeof sBuffer3, "%s %s", sBuffer1, sBuffer2)
	PrintToServer(sBuffer3)
	return Plugin_Handled
}