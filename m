Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A746B412BAE
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 04:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348624AbhIUCYG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 22:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbhIUBvb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 21:51:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E882C0617A6
        for <linux-spi@vger.kernel.org>; Mon, 20 Sep 2021 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TxZ+p8dDMCIXX4/MPBAkMyFUf/CibyaKNW8qQSHI3m0=; b=EJ1SQMzJE7KAgmIo8sUiK/9JlL
        si7z/s1hsk6bhWbCBAPn8ADSeb//tztEzDCgU9BZOexxXFe2vfJAOgMuXOPeqE6YVXs9QGzatbOwf
        xfLE9b8gX9Ah7MZbGIdyIA1Y3Xm61DHFAfg71C+GdQwv8UQn6+WB+xgjmgIBpx3bdWv/5Oq8KNo9h
        vBKcWrjc7bYryUmrrfqqPr8NkGRLS7MWVnxx2W8igOASPLnZaT1eocbPdJJK37Sfp5k6hoIx54rDd
        a18RqfYDr928jdu2GGI+cRJ+U1rUqFSCt+VVASsKKYLg7UbMkBIdwhyaZY7HhxR6MSLbKYofh+Qb0
        tzWXlUdQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54688)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mSS07-00025m-JK; Mon, 20 Sep 2021 23:43:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mSS06-0002f1-KV; Mon, 20 Sep 2021 23:43:02 +0100
Date:   Mon, 20 Sep 2021 23:43:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, broonie@kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <YUkOdoqccsbEh08C@shell.armlinux.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
 <871r5j6nlw.fsf@igel.home>
 <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
 <87wnna6hdc.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnna6hdc.fsf@igel.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 11:56:31PM +0200, Andreas Schwab wrote:
> On Sep 20 2021, Russell King (Oracle) wrote:
> 
> > On Mon, Sep 20, 2021 at 09:41:47PM +0200, Andreas Schwab wrote:
> >> On Sep 20 2021, Russell King (Oracle) wrote:
> >> 
> >> > Therefore, this change breaks module autoloading.
> >> 
> >> Reverting this change breaks module autoloading.
> >
> > No.
> >
> > Module autoloading worked before.
> 
> Nope.

Sorry, but you are wrong. Let me take a random built kernel I have
laying around. 5.4.0+:

-rw-r--r-- 1 rmk rmk 17164877 Jan 26  2020 /home/rmk/systems/juno-host-5.4.0+.tar.bz2

and throw it onto the Macchiatobin:

[  OK  ] Finished Suspend/Resume Running libvirt Guests.
[  OK  ] Started LSB: exim Mail Transport Agent.
[  OK  ] Started Samba SMB Daemon.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Finished Update UTMP about System Runlevel Changes.

Debian GNU/Linux 11 mcbin-ss ttyS2

mcbin-ss login: root
Password:
Linux mcbin-ss 5.4.0+ #608 SMP PREEMPT Sun Jan 26 15:44:51 GMT 2020 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Mon Sep 20 22:17:58 BST 2021 on ttyS2
root@mcbin-ss:~# lsmod
Module                  Size  Used by
nfnetlink              16384  0
8021q                  36864  0
garp                   16384  1 8021q
mrp                    20480  1 8021q
crct10dif_ce           16384  1
spi_nor                49152  0
armada_thermal         16384  0
sbsa_gwdt              16384  0
ip_tables              32768  0
x_tables               45056  1 ip_tables
root@mcbin-ss:~#

That's strange, spi_nor has been _autoloaded_ under 5.4.0+. If I boot
exactly the same userspace with 5.13.0+, it gets _autoloaded_:

[  OK  ] Finished Suspend/Resume Running libvirt Guests.
[  OK  ] Started Samba SMB Daemon.P■ower device driver controller.
[  OK  ] Started LSB: exim Mail Transport Agent.tails.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.ring sensors.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Finished Update UTMP about System Runlevel Changes.rvice.
[  OK  ] Started LSB: rng-tools (Debian variant).

Debian GNU/Linux 11 mcbin-ss ttyS2

mcbin-ss login: root
Password:
Linux mcbin-ss 5.13.0+ #958 SMP PREEMPT Tue Sep 14 16:17:44 BST 2021 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Mon Sep 20 23:19:05 BST 2021 on ttyS2
root@mcbin-ss:~# lsmod
Module                  Size  Used by
nfnetlink              20480  0
8021q                  36864  0
garp                   16384  1 8021q
mrp                    20480  1 8021q
crct10dif_ce           20480  1
spi_nor                73728  0
leds_gpio              16384  0
pwm_fan                20480  0
armada_thermal         16384  0
sbsa_gwdt              20480  0
ip_tables              32768  0
x_tables               45056  1 ip_tables

I'll prove it by moving the modules so they can't be loaded by the
normal system boot, and then trigger udev:

root@mcbin-ss:~# uname -a
Linux mcbin-ss 5.13.0+ #958 SMP PREEMPT Tue Sep 14 16:17:44 BST 2021 aarch64 GNU/Linux
root@mcbin-ss:~# lsmod
Module                  Size  Used by
root@mcbin-ss:~# mv 5.13.0+ /lib/modules
root@mcbin-ss:~# udevadm trigger --action=add
root@mcbin-ss:~# sbsa-gwdt f0610000.watchdog: Initialized with 10s timeout @ 25000000 Hz, action=0.
spi-nor spi4.0: w25q32 (4096 Kbytes)
lsmod
Module                  Size  Used by
crct10dif_ce           20480  1
pwm_fan                20480  0
spi_nor                73728  0
leds_gpio              16384  0
armada_thermal         16384  0
sbsa_gwdt              20480  0

Why does this happen?

root@mcbin-ss:~# cat /sys/bus/spi/devices/spi4.0/modalias
spi:w25q32
root@mcbin-ss:~# cat /sys/bus/spi/devices/spi4.0/uevent
DRIVER=spi-nor
OF_NAME=spi-flash
OF_FULLNAME=/cp1/config-space@f4000000/spi@700680/spi-flash@0
OF_COMPATIBLE_0=st,w25q32
OF_COMPATIBLE_N=1
MODALIAS=spi:w25q32
root@mcbin-ss:~# modinfo spi-nor
filename:       /lib/modules/5.13.0+/kernel/drivers/mtd/spi-nor/spi-nor.ko
description:    framework for SPI NOR
author:         Mike Lavender
author:         Huang Shijie <shijie8@gmail.com>
license:        GPL v2
alias:          of:N*T*Cjedec,spi-norC*
alias:          of:N*T*Cjedec,spi-nor
alias:          spi:mr25h40
...
alias:          spi:w25q32		<=======================
...
alias:          spi:spi-nor
depends:
intree:         Y
name:           spi_nor
vermagic:       5.13.0+ SMP preempt mod_unload aarch64

If I boot the exact same userspace with 5.14.0+, it does _not_ get
autoloaded, because the modinfo and uevent files contain different
contents that the spi-nor module does not have an alias for.

Yet you say without your change module autoloading doesn't work - that
may be true for you, but the point here is that:

   Your change plus another during the 5.14 cycle broke previously
   working module autoloading. It broke a previously working setup.
   This is a _regression_.

Maybe you could explain why you think otherwise - and possibly accept
that it _did_ used to work for others.

Yes, I get it that _your_ patch (which is the later one of the two
that I mentioned) was merely bringing the modalias file into line with
the uevent file - but that doesn't change the fact that 5.13 and
earlier kernels worked, 5.14 does not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
