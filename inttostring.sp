#include <profiler>

public void OnPluginStart()
{
	RegServerCmd("sm_inttostring_test", CMD)
}

public Action CMD(int args)
{
	Profiler prof = new Profiler()
	prof.Start()
	char sBuffer[64]
	int count = 1000
	if(args >= 1)
	{
		GetCmdArg(1, sBuffer, sizeof sBuffer)
		count = StringToInt(sBuffer)
	}
	prof.Start()
	for(int i = 0;i!=count;i++)
		FormatEx(sBuffer, sizeof sBuffer, "teststring%i", i)
	prof.Stop()
	PrintToServer("Step 1 - %f", prof.Time)
	prof.Start()
	for(int i = 0;i!=count;i++)
	{
		sBuffer = "teststring"
		int len = strlen(sBuffer)
		IntToString(i, sBuffer[len], sizeof sBuffer - len)
	}
	prof.Stop()
	PrintToServer("Step 2 - %f", prof.Time)
	prof.Start()
	sBuffer = "teststring"
	int len = strlen(sBuffer)
	for(int i = 0;i!=count;i++)
		IntToString(i, sBuffer[len], sizeof sBuffer - len)
	prof.Stop()
	PrintToServer("Step 3 - %f", prof.Time)
	prof.Start()
	for(int i = 0;i!=count;i++)
	{
		sBuffer = "teststring"
		int len2 = strlen(sBuffer)
		FormatEx(sBuffer[len2], sizeof sBuffer - len2, "%i", i)
	}
	prof.Stop()
	PrintToServer("Step 4 - %f", prof.Time)
	prof.Start()
	sBuffer = "teststring"
	int len2 = strlen(sBuffer)
	for(int i = 0;i!=count;i++)
		FormatEx(sBuffer[len2], sizeof sBuffer - len2, "%i", i)
	prof.Stop()
	PrintToServer("Step 5 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
	{
		sBuffer = "teststring"
		int len3 = strlen(sBuffer)
		Format(sBuffer[len3], sizeof sBuffer - len3, "%i", i)
	}
	prof.Stop()
	PrintToServer("Step 6 - %f", prof.Time)
	prof.Start()
	sBuffer = "teststring"
	int len3 = strlen(sBuffer)
	for(int i = 0;i!=count;i++)
		Format(sBuffer[len3], sizeof sBuffer - len3, "%i", i)
	prof.Stop()
	PrintToServer("Step 7 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		Format(sBuffer, sizeof sBuffer, "teststring%i", i)
	prof.Stop()
	PrintToServer("Step 8 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		Format(sBuffer, sizeof sBuffer, "%i", i)
	prof.Stop()
	PrintToServer("Step 9 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		FormatEx(sBuffer, sizeof sBuffer, "%i", i)
	prof.Stop()
	PrintToServer("Step 10 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		IntToString(i, sBuffer, sizeof sBuffer)
	prof.Stop()
	PrintToServer("Step 11 - %f", prof.Time)
	prof.Close()
	return Plugin_Handled
}