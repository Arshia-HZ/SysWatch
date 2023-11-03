using System;
using System.Collections.Generic;

namespace SysWatch.Models;

public partial class Device
{
    public int Id { get; set; }

    public string? UserName { get; set; }

    public string? Password { get; set; }

    public string? LinuxDistro { get; set; }

    public string? Cpu { get; set; }

    public string? DateTime { get; set; }

    public string? DiskUsage { get; set; }
}
