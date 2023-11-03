using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace SysWatch.Models;

public partial class SysWatchContext : DbContext
{
    //private readonly IConfiguration _configuration;
    public SysWatchContext(/*IConfiguration configuration*/)
    {
        //_configuration = configuration;
    }

    public SysWatchContext(DbContextOptions<SysWatchContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Device> Devices { get; set; }

    //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    //    => optionsBuilder.UseSqlServer(_configuration.GetConnectionString("SysWatch"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Device>(entity =>
        {
            entity.ToTable("Device");

            entity.Property(e => e.Cpu).HasMaxLength(100);
            entity.Property(e => e.DateTime).HasMaxLength(50);
            entity.Property(e => e.DiskUsage).HasMaxLength(50);
            entity.Property(e => e.UserName).HasMaxLength(200);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
