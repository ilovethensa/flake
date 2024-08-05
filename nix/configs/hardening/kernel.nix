{
  lib,
  config,
  ...
}: {
  # Prevent replacing the running kernel w/o reboot
  security.protectKernelImage = true;
  boot = {
    kernel.sysctl = {
      # The Magic SysRq key is a key combo that allows users connected to the
      # system console of a Linux kernel to perform some low-level commands.
      # Disable it, since we don't need it, and is a potential security concern.
      "kernel.sysrq" = 0;

      ## TCP hardening
      # Prevent bogus ICMP errors from filling up logs.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      # Reverse path filtering causes the kernel to do source validation of
      # packets received from all interfaces. This can mitigate IP spoofing.
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      # Do not accept IP source route packets (we're not a router)
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      # Don't send ICMP redirects (again, we're on a router)
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      # Refuse ICMP redirects (MITM mitigations)
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      # Protects against SYN flood attacks
      "net.ipv4.tcp_syncookies" = 1;
      # Incomplete protection again TIME-WAIT assassination
      "net.ipv4.tcp_rfc1337" = 1;

      ## TCP optimization
      # TCP Fast Open is a TCP extension that reduces network latency by packing
      # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
      # both incoming and outgoing connections:
      #"net.ipv4.tcp_fastopen" = 3;
      # Bufferbloat mitigations + slight improvement in throughput & latency

      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;
      "kernel.printk" = "3 3 3 3";
      "kernel.unprivileged_bpf_disabled" = 1;
      "net.core.bpf_jit_harden" = 2;
      "dev.tty.ldisc_autoload" = 0;
      "vm.unprivileged_userfaultfd" = 0;
      "kernel.kexec_load_disabled" = 1;
      "kernel.unprivileged_userns_clone" = 0;
      "kernel.perf_event_paranoid" = 3;
      "net.ipv6.conf.all.accept_ra" = 0;
      "net.ipv6.conf.default.accept_ra" = 0;
      "net.ipv4.tcp_sack" = 0;
      "net.ipv4.tcp_dsack" = 0;
      "net.ipv4.tcp_fack" = 0;
      "kernel.yama.ptrace_scope" = 2;
      "vm.mmap_rnd_bits" = 32;
      "vm.mmap_rnd_compat_bits" = 16;
      "fs.protected_symlinks" = 1;
      "fs.protected_hardlinks" = 1;
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;
      "ipv6.disable" = 1;
      "net.ipv4.tcp_timestamps" = 0;
    };
    kernelParams = [
      # Arguments
      #"slab_nomerge"
      "init_on_alloc=1"
      "init_on_free=1"
      "page_alloc.shuffle=1"
      "pti=on"
      "randomize_kstack_offset=on"
      "vsyscall=none"
      "debugfs=off"
      "oops=panic"
      "module.sig_enforce=1"
      "lockdown=confidentiality"
      "mce=0"
      "quiet"
      "loglevel=0"
    ];
    blacklistedKernelModules = [
      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"
      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "befs"
      "bfs"
      "btusb"
      "cifs"
      "cramfs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "f2fs"
      "freevxfs"
      "freevxfs"
      "gfs2"
      "hfs"
      "hfsplus"
      "hpfs"
      "jffs2"
      "jfs"
      "ksmbd"
      "minix"
      "nfs"
      "nfsv3"
      "nfsv4"
      "nilfs2"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "udf"
      "vivid"
    ];
    tmp = {
      # tmpfs = /tmp is mounted in ram. Doing so makes temp file management speedy
      # on ssd systems, and volatile! Because it's wiped on reboot.
      useTmpfs = lib.mkDefault true;
      # If not using tmpfs, which is naturally purged on reboot, we must clean it
      # /tmp ourselves. /tmp should be volatile storage!
      cleanOnBoot = lib.mkDefault (!config.boot.tmp.useTmpfs);
    };
  };
}
