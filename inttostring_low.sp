#include <profiler>

public void OnPluginStart()
{
	RegServerCmd("sm_inttostring_low_test", CMD)
}

public Action CMD(int args)
{
	char sBuffer[64]
	int count = 1000
	int value = 1
	if(args >= 1)
	{
		GetCmdArg(1, sBuffer, sizeof sBuffer)
		count = StringToInt(sBuffer)
	}
	if(args >= 2)
	{
		GetCmdArg(2, sBuffer, sizeof sBuffer)
		value = StringToInt(sBuffer)
	}
	PrintToServer("Count - %i", count)
	PrintToServer("Value- %i", value)
	Profiler prof = new Profiler()
	prof.Start()
	for(int i = 0;i!=count;i++)
		Format(sBuffer, sizeof sBuffer, "%i", i)
	prof.Stop()
	PrintToServer("Format - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		FormatEx(sBuffer, sizeof sBuffer, "%i", i)
	prof.Stop()
	PrintToServer("FormatEx - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		IntToString(i, sBuffer, sizeof sBuffer)
	prof.Stop()
	PrintToServer("IntToString - %f", prof.Time)
	prof.Close()
	return Plugin_Handled
}