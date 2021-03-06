package Bencher::ScenarioR::RandomLineModules;

our $VERSION = 0.05; # VERSION

our $results = [
  [
    200,
    "OK",
    [
      {
        dataset     => "10k_line",
        errors      => 4.6e-06,
        participant => "File::Random::Pick::random_line",
        rate        => 500,
        samples     => 21,
        time        => 2,
        vs_slowest  => 1,
      },
      {
        dataset     => "1k_line",
        errors      => 2.1e-07,
        participant => "File::Random::Pick::random_line",
        rate        => 4800,
        samples     => 20,
        time        => 0.21,
        vs_slowest  => 9.6,
      },
      {
        dataset     => "10k_line",
        errors      => 2.7e-08,
        participant => "File::RandomLine",
        rate        => 61000,
        samples     => 20,
        time        => 0.016,
        vs_slowest  => 120,
      },
      {
        dataset     => "1k_line",
        errors      => 2.3e-08,
        participant => "File::RandomLine",
        rate        => 62000,
        samples     => 27,
        time        => 0.016,
        vs_slowest  => 120,
      },
    ],
    {
      "func.bencher_args"              => {
                                            action => "bench",
                                            note => "Run by Pod::Weaver::Plugin::Bencher::Scenario",
                                            scenario_module => "RandomLineModules",
                                          },
      "func.bencher_version"           => undef,
      "func.cpu_info"                  => [
                                            {
                                              address_width                => 64,
                                              architecture                 => "AMD-64",
                                              bus_speed                    => undef,
                                              data_width                   => 64,
                                              family                       => 6,
                                              flags                        => [
                                                                                "fpu",
                                                                                "vme",
                                                                                "de",
                                                                                "pse",
                                                                                "tsc",
                                                                                "msr",
                                                                                "pae",
                                                                                "mce",
                                                                                "cx8",
                                                                                "apic",
                                                                                "sep",
                                                                                "mtrr",
                                                                                "pge",
                                                                                "mca",
                                                                                "cmov",
                                                                                "pat",
                                                                                "pse36",
                                                                                "clflush",
                                                                                "dts",
                                                                                "acpi",
                                                                                "mmx",
                                                                                "fxsr",
                                                                                "sse",
                                                                                "sse2",
                                                                                "ss",
                                                                                "ht",
                                                                                "tm",
                                                                                "pbe",
                                                                                "syscall",
                                                                                "nx",
                                                                                "rdtscp",
                                                                                "lm",
                                                                                "constant_tsc",
                                                                                "arch_perfmon",
                                                                                "pebs",
                                                                                "bts",
                                                                                "rep_good",
                                                                                "nopl",
                                                                                "xtopology",
                                                                                "nonstop_tsc",
                                                                                "aperfmperf",
                                                                                "eagerfpu",
                                                                                "pni",
                                                                                "pclmulqdq",
                                                                                "dtes64",
                                                                                "monitor",
                                                                                "ds_cpl",
                                                                                "vmx",
                                                                                "smx",
                                                                                "est",
                                                                                "tm2",
                                                                                "ssse3",
                                                                                "cx16",
                                                                                "xtpr",
                                                                                "pdcm",
                                                                                "pcid",
                                                                                "sse4_1",
                                                                                "sse4_2",
                                                                                "x2apic",
                                                                                "popcnt",
                                                                                "tsc_deadline_timer",
                                                                                "aes",
                                                                                "xsave",
                                                                                "avx",
                                                                                "lahf_lm",
                                                                                "ida",
                                                                                "arat",
                                                                                "epb",
                                                                                "xsaveopt",
                                                                                "pln",
                                                                                "pts",
                                                                                "dtherm",
                                                                                "tpr_shadow",
                                                                                "vnmi",
                                                                                "flexpriority",
                                                                                "ept",
                                                                                "vpid",
                                                                              ],
                                              L2_cache                     => { max_cache_size => "6144 KB" },
                                              manufacturer                 => "GenuineIntel",
                                              model                        => 42,
                                              name                         => "Intel(R) Core(TM) i5-2400 CPU \@ 3.10GHz",
                                              number_of_cores              => 4,
                                              number_of_logical_processors => 4,
                                              processor_id                 => 0,
                                              speed                        => 3254.757,
                                              stepping                     => 7,
                                            },
                                            {
                                              address_width                => 64,
                                              architecture                 => "AMD-64",
                                              bus_speed                    => undef,
                                              data_width                   => 64,
                                              family                       => 6,
                                              flags                        => [
                                                                                "fpu",
                                                                                "vme",
                                                                                "de",
                                                                                "pse",
                                                                                "tsc",
                                                                                "msr",
                                                                                "pae",
                                                                                "mce",
                                                                                "cx8",
                                                                                "apic",
                                                                                "sep",
                                                                                "mtrr",
                                                                                "pge",
                                                                                "mca",
                                                                                "cmov",
                                                                                "pat",
                                                                                "pse36",
                                                                                "clflush",
                                                                                "dts",
                                                                                "acpi",
                                                                                "mmx",
                                                                                "fxsr",
                                                                                "sse",
                                                                                "sse2",
                                                                                "ss",
                                                                                "ht",
                                                                                "tm",
                                                                                "pbe",
                                                                                "syscall",
                                                                                "nx",
                                                                                "rdtscp",
                                                                                "lm",
                                                                                "constant_tsc",
                                                                                "arch_perfmon",
                                                                                "pebs",
                                                                                "bts",
                                                                                "rep_good",
                                                                                "nopl",
                                                                                "xtopology",
                                                                                "nonstop_tsc",
                                                                                "aperfmperf",
                                                                                "eagerfpu",
                                                                                "pni",
                                                                                "pclmulqdq",
                                                                                "dtes64",
                                                                                "monitor",
                                                                                "ds_cpl",
                                                                                "vmx",
                                                                                "smx",
                                                                                "est",
                                                                                "tm2",
                                                                                "ssse3",
                                                                                "cx16",
                                                                                "xtpr",
                                                                                "pdcm",
                                                                                "pcid",
                                                                                "sse4_1",
                                                                                "sse4_2",
                                                                                "x2apic",
                                                                                "popcnt",
                                                                                "tsc_deadline_timer",
                                                                                "aes",
                                                                                "xsave",
                                                                                "avx",
                                                                                "lahf_lm",
                                                                                "ida",
                                                                                "arat",
                                                                                "epb",
                                                                                "xsaveopt",
                                                                                "pln",
                                                                                "pts",
                                                                                "dtherm",
                                                                                "tpr_shadow",
                                                                                "vnmi",
                                                                                "flexpriority",
                                                                                "ept",
                                                                                "vpid",
                                                                              ],
                                              L2_cache                     => { max_cache_size => "6144 KB" },
                                              manufacturer                 => "GenuineIntel",
                                              model                        => 42,
                                              name                         => "Intel(R) Core(TM) i5-2400 CPU \@ 3.10GHz",
                                              number_of_cores              => 4,
                                              number_of_logical_processors => 4,
                                              processor_id                 => 1,
                                              speed                        => 3254.031,
                                              stepping                     => 7,
                                            },
                                            {
                                              address_width                => 64,
                                              architecture                 => "AMD-64",
                                              bus_speed                    => undef,
                                              data_width                   => 64,
                                              family                       => 6,
                                              flags                        => [
                                                                                "fpu",
                                                                                "vme",
                                                                                "de",
                                                                                "pse",
                                                                                "tsc",
                                                                                "msr",
                                                                                "pae",
                                                                                "mce",
                                                                                "cx8",
                                                                                "apic",
                                                                                "sep",
                                                                                "mtrr",
                                                                                "pge",
                                                                                "mca",
                                                                                "cmov",
                                                                                "pat",
                                                                                "pse36",
                                                                                "clflush",
                                                                                "dts",
                                                                                "acpi",
                                                                                "mmx",
                                                                                "fxsr",
                                                                                "sse",
                                                                                "sse2",
                                                                                "ss",
                                                                                "ht",
                                                                                "tm",
                                                                                "pbe",
                                                                                "syscall",
                                                                                "nx",
                                                                                "rdtscp",
                                                                                "lm",
                                                                                "constant_tsc",
                                                                                "arch_perfmon",
                                                                                "pebs",
                                                                                "bts",
                                                                                "rep_good",
                                                                                "nopl",
                                                                                "xtopology",
                                                                                "nonstop_tsc",
                                                                                "aperfmperf",
                                                                                "eagerfpu",
                                                                                "pni",
                                                                                "pclmulqdq",
                                                                                "dtes64",
                                                                                "monitor",
                                                                                "ds_cpl",
                                                                                "vmx",
                                                                                "smx",
                                                                                "est",
                                                                                "tm2",
                                                                                "ssse3",
                                                                                "cx16",
                                                                                "xtpr",
                                                                                "pdcm",
                                                                                "pcid",
                                                                                "sse4_1",
                                                                                "sse4_2",
                                                                                "x2apic",
                                                                                "popcnt",
                                                                                "tsc_deadline_timer",
                                                                                "aes",
                                                                                "xsave",
                                                                                "avx",
                                                                                "lahf_lm",
                                                                                "ida",
                                                                                "arat",
                                                                                "epb",
                                                                                "xsaveopt",
                                                                                "pln",
                                                                                "pts",
                                                                                "dtherm",
                                                                                "tpr_shadow",
                                                                                "vnmi",
                                                                                "flexpriority",
                                                                                "ept",
                                                                                "vpid",
                                                                              ],
                                              L2_cache                     => { max_cache_size => "6144 KB" },
                                              manufacturer                 => "GenuineIntel",
                                              model                        => 42,
                                              name                         => "Intel(R) Core(TM) i5-2400 CPU \@ 3.10GHz",
                                              number_of_cores              => 4,
                                              number_of_logical_processors => 4,
                                              processor_id                 => 2,
                                              speed                        => 3222.062,
                                              stepping                     => 7,
                                            },
                                            {
                                              address_width                => 64,
                                              architecture                 => "AMD-64",
                                              bus_speed                    => undef,
                                              data_width                   => 64,
                                              family                       => 6,
                                              flags                        => [
                                                                                "fpu",
                                                                                "vme",
                                                                                "de",
                                                                                "pse",
                                                                                "tsc",
                                                                                "msr",
                                                                                "pae",
                                                                                "mce",
                                                                                "cx8",
                                                                                "apic",
                                                                                "sep",
                                                                                "mtrr",
                                                                                "pge",
                                                                                "mca",
                                                                                "cmov",
                                                                                "pat",
                                                                                "pse36",
                                                                                "clflush",
                                                                                "dts",
                                                                                "acpi",
                                                                                "mmx",
                                                                                "fxsr",
                                                                                "sse",
                                                                                "sse2",
                                                                                "ss",
                                                                                "ht",
                                                                                "tm",
                                                                                "pbe",
                                                                                "syscall",
                                                                                "nx",
                                                                                "rdtscp",
                                                                                "lm",
                                                                                "constant_tsc",
                                                                                "arch_perfmon",
                                                                                "pebs",
                                                                                "bts",
                                                                                "rep_good",
                                                                                "nopl",
                                                                                "xtopology",
                                                                                "nonstop_tsc",
                                                                                "aperfmperf",
                                                                                "eagerfpu",
                                                                                "pni",
                                                                                "pclmulqdq",
                                                                                "dtes64",
                                                                                "monitor",
                                                                                "ds_cpl",
                                                                                "vmx",
                                                                                "smx",
                                                                                "est",
                                                                                "tm2",
                                                                                "ssse3",
                                                                                "cx16",
                                                                                "xtpr",
                                                                                "pdcm",
                                                                                "pcid",
                                                                                "sse4_1",
                                                                                "sse4_2",
                                                                                "x2apic",
                                                                                "popcnt",
                                                                                "tsc_deadline_timer",
                                                                                "aes",
                                                                                "xsave",
                                                                                "avx",
                                                                                "lahf_lm",
                                                                                "ida",
                                                                                "arat",
                                                                                "epb",
                                                                                "xsaveopt",
                                                                                "pln",
                                                                                "pts",
                                                                                "dtherm",
                                                                                "tpr_shadow",
                                                                                "vnmi",
                                                                                "flexpriority",
                                                                                "ept",
                                                                                "vpid",
                                                                              ],
                                              L2_cache                     => { max_cache_size => "6144 KB" },
                                              manufacturer                 => "GenuineIntel",
                                              model                        => 42,
                                              name                         => "Intel(R) Core(TM) i5-2400 CPU \@ 3.10GHz",
                                              number_of_cores              => 4,
                                              number_of_logical_processors => 4,
                                              processor_id                 => 3,
                                              speed                        => 3251.246,
                                              stepping                     => 7,
                                            },
                                          ],
      "func.elapsed_time"              => 0.162800073623657,
      "func.module_startup"            => undef,
      "func.module_versions"           => {
                                            "__PACKAGE__" => 1.039,
                                            "Bencher::Scenario::RandomLineModules" => undef,
                                            "Benchmark::Dumb" => 0.111,
                                            "Devel::Platform::Info" => 0.16,
                                            "File::Random::Pick" => 0.02,
                                            "File::RandomLine" => "0.20",
                                            "perl" => "v5.26.0",
                                            "Sys::Info" => 0.78,
                                          },
      "func.note"                      => "Run by Pod::Weaver::Plugin::Bencher::Scenario",
      "func.permute"                   => ["perl", ["perl"], "participant", [0, 1], "dataset", [0, 1]],
      "func.platform_info"             => {
                                            archname => "x86_64",
                                            codename => "jessie",
                                            is32bit  => 0,
                                            is64bit  => 1,
                                            kernel   => "linux-3.16.0-4-amd64",
                                            kname    => "Linux",
                                            kvers    => "3.16.0-4-amd64",
                                            osflag   => "linux",
                                            oslabel  => "Debian",
                                            osname   => "GNU/Linux",
                                            osvers   => "8.0",
                                            source   => {
                                                          "cat /etc/.issue" => "",
                                                          "cat /etc/issue"  => "Debian GNU/Linux 8 \\n \\l",
                                                          "lsb_release -a"  => "Distributor ID:\tDebian\nDescription:\tDebian GNU/Linux 8.0 (jessie)\nRelease:\t8.0\nCodename:\tjessie",
                                                          "uname -a"        => "Linux builder 3.16.0-4-amd64 #1 SMP Debian 3.16.36-1+deb8u2 (2016-10-19) x86_64 GNU/Linux",
                                                          "uname -m"        => "x86_64",
                                                          "uname -o"        => "GNU/Linux",
                                                          "uname -r"        => "3.16.0-4-amd64",
                                                          "uname -s"        => "Linux",
                                                        },
                                          },
      "func.precision"                 => 0,
      "func.scenario_module"           => "Bencher::Scenario::RandomLineModules",
      "func.scenario_module_md5sum"    => "b968790b18f92682d6f4984c5387611e",
      "func.scenario_module_mtime"     => 1499687152,
      "func.scenario_module_sha1sum"   => "86a678ac80d70a3fc4229c9ba666133f288e67e3",
      "func.scenario_module_sha256sum" => "cfda55063fb97c12ff28363d2333bff57182d1738508b96343924c3984a15c2d",
      "func.time_end"                  => 1499687170.04751,
      "func.time_factor"               => 1000,
      "func.time_start"                => 1499687169.88471,
      "table.field_aligns"             => ["left", "left", "number", "number", "number", "number", "number"],
      "table.field_units"              => [undef, undef, "/s", "ms"],
      "table.fields"                   => [
                                            "participant",
                                            "dataset",
                                            "rate",
                                            "time",
                                            "vs_slowest",
                                            "errors",
                                            "samples",
                                          ],
    },
  ],
];

1;
# ABSTRACT: Benchmark modules which pick random line(s) from a file

=head1 DESCRIPTION

This module is automatically generated by Pod::Weaver::Plugin::Bencher::Scenario during distribution build.

A Bencher::ScenarioR::* module contains the raw result of sample benchmark and might be useful for some stuffs later.

