Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A7E2EBE12
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbhAFM4k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 07:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbhAFM4j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Jan 2021 07:56:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3DC06134C
        for <linux-spi@vger.kernel.org>; Wed,  6 Jan 2021 04:55:58 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h22so6347098lfu.2
        for <linux-spi@vger.kernel.org>; Wed, 06 Jan 2021 04:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=t18sJ68ztdlNBv4KljCq4bnntFbZu0uob1caaCViAmg=;
        b=YbhxcRnD+Zf1a4zzW0XR2+uUArWGI19/Ywn4cJImbpVMbzUds57rKXtgaTsALi6t77
         lh8cJ3j/OUQnEXdJxVYfGI6/K82GOzAEotbSc2xzcKcPcbgrUTBx7pT9rBk+QbZUX2/H
         Niok8orYhWzCnJ8XFBhHkbo2Kofl5vZynwo6qgEdjtdUEaEDPi8myUNXM5g8r3tiJE1p
         GmREedzBaQZ4WoXKJAO2RKbzKpBl416+MLDMzxyXVmgDEJXub65YTuB36Dy6s1pOEgd7
         qdrwASCYUfSmpwQvOyb02rAflsIMG9IbJ23cQkHPSwEXQ0ucKKrR0BsXsakXsXnVBNtb
         g1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t18sJ68ztdlNBv4KljCq4bnntFbZu0uob1caaCViAmg=;
        b=dP5M9pMY7Kl9esUAiLgwoq/Ly/IpjydOwj4ctQx7JkckOnCHcaYXulJAp3tZ36VlYr
         t5pJ9zbXnA03R1dFJa+KhgLR/OwBD472/pDC4o7YZkwT1W4PybS3xJyIvZ4zWC4WAl1B
         yR/wYAFAzeMVpQGVPdNpwJtebEn2e3TH1AxegsbqRjMYFLsMxQ1B4b40jmWmlJcS03uh
         A9fLC6vCUmJE6l54aIeJjNMVtRr1LUPMVqqgx3lZ7wvggKRx/NLQc/SyGlcH0b2yDWF3
         uqLA1Kl776YSMXgzRfGLmvvsbxDSmnd5q1D1xn769jzFCdr4VKkztXQO0GfmrzPe4ZeO
         ElDw==
X-Gm-Message-State: AOAM533I8jzkp0fnebUQ2ixeWagmShujTEwaskKPjvs9DNHPcJujzqSL
        CkI180MdFO6SSJedWjAUlOkMwIAUoNpQtldEKhZLIc6vCxLzMA==
X-Google-Smtp-Source: ABdhPJwDRtR5eEy9jBDQDcgooYdKptp380UGNHtJ7pm/m2owujdrp1QBA8yJkH2L3RxZxmACLg7VrB4PGTD3iNSusKY=
X-Received: by 2002:a05:651c:48b:: with SMTP id s11mr1962066ljc.28.1609937756910;
 Wed, 06 Jan 2021 04:55:56 -0800 (PST)
MIME-Version: 1.0
From:   Vincent Pelletier <plr.vincent@gmail.com>
Date:   Wed, 6 Jan 2021 21:55:45 +0900
Message-ID: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
Subject: 5.11.0-rc1+: "Division by zero in kernel." when writing to spidev
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I am somehow triggering a division by zero when writing to spidev
(a pair of traces at the end of this email).

This kernel was built from Linus's tree as of:
commit 139711f033f636cc78b6aaf7363252241b9698ef
Merge: dea8dcf2a9fa 1f3147b49d75
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Dec 29 15:45:49 2020 -0800

   Merge branch 'akpm' (patches from Andrew)

targeting a raspberry pi zero w (armv6l), with the device tree rebuilt
with dtc's "-@" option and the overlay pasted below applied on top of the
vanilla device tree by the bootloader, precisely to enable the spi bus
and declare one SPI device (with a dirty hack to get spidev to handle
the device without having to patch the kernel...).

I am not a devicetree expert, so I may be doing something dumb
(besides twisting spidev's arm to get it to do what I want).
I cannot at a glance map the div-by-zero traceback to the source
code: I do not see a division in the mentioned functions at all,
so I could not debug this further on my own so far.

This code is working with 5.9.11 (as of Debian sid from a few days ago).

I picked an rc kernel to test an unrelated patch (one-liner in
drivers/usb/dwc2/gadget.c provided by its maintainer).

At a glance I do not find a related fix in linus's tree (I do see a
div-by-zero fix, but in networking).

The code triggering the issue is a simple open-devfile-then-write
implemented in python, without any SPI-specific ioctl to configure
the device beyond what devicetree is already setting up. I know
python does one ioctl on every opened file, although I do not remember
which one (I remember it being about detecting whether the file is a
terminal).

/dts-v1/;
/plugin/;

/ {
 compatible = "brcm,bcm2835";
};

&gpio {
 alt0 {
   brcm,pins = <4 5>; // removed 7, 8, 9, 10, 11
 };
 spi0_cs_pins: spi0_cs_pins {
   brcm,function = <1>; // out
   brcm,pins = <7 8>;
 };
 spi0_pins: spi0_pins {
   brcm,function = <4>; // alt0
   brcm,pins = <9 10 11>;
 };
};

&spi {
 cs-gpios = <&gpio 8 0x01>, <&gpio 7 0x01>; // CE0 is gpio 8, CE1 is
gpio 7, both active low
 status = "okay";
 pinctrl-0 = <&spi0_cs_pins &spi0_pins>;
 pinctrl-names = "default";
 #address-cells = <1>;
 #size-cells = <0>;
 spidev@0 {
   // "waveshare,epaper-display-v1": because that's what it really is.
   // "rohm,dh2228fv": because this triggers spidev to handle this device.
   compatible = "waveshare,epaper-display-v1", "rohm,dh2228fv";
   reg = <0>; // uses CS0
   #address-cells = <1>;
   #size-cells = <0>;
   spi-max-frequency = <4000000>; // 4MHz: tcycle >= 250ns
 };
};

[  +2.762703] Division by zero in kernel.
[  +0.004106] CPU: 0 PID: 262 Comm: smartcard-openp Tainted: G
C  E     5.11.0-rc1+ #16
[  +0.008861] Hardware name: BCM2835
[  +0.003520] Backtrace:
[  +0.002574] [<c0883d1c>] (dump_backtrace) from [<c08840c4>]
(show_stack+0x20/0x24)
[  +0.007892]  r7:c1fd1df4 r6:c1fd1e2c r5:c372cc00 r4:c0a43d94
[  +0.005866] [<c08840a4>] (show_stack) from [<c08875c8>] (dump_stack+0x28/0x30)
[  +0.007495] [<c08875a0>] (dump_stack) from [<c0883e9c>] (__div0+0x20/0x28)
[  +0.007158]  r5:c372cc00 r4:00000000
[  +0.003728] [<c0883e7c>] (__div0) from [<c04ae4cc>] (Ldiv0+0x8/0x10)
[  +0.006618] [<c05e34a4>] (spi_transfer_one_message) from
[<c05e540c>] (__spi_pump_messages+0x45c/0x6e8)
[  +0.009811]  r10:c1192e10 r9:c1192e10 r8:c1fd1e18 r7:c1fd1df4
r6:c05e9228 r5:c1fd1da0
[  +0.008114]  r4:c372cc00
[  +0.002659] [<c05e4fb0>] (__spi_pump_messages) from [<c05e58d0>]
(__spi_sync+0x214/0x23c)
[  +0.008509]  r10:c1fd1e18 r9:60000013 r8:c372cc00 r7:c05e1e60
r6:c372cc00 r5:c372c000
[  +0.008095]  r4:c1fd1df4
[  +0.002658] [<c05e56bc>] (__spi_sync) from [<c05e592c>] (spi_sync+0x34/0x4c)
[  +0.007345]  r10:00000051 r9:c2724000 r8:c1167550 r7:c1167540
r6:00000001 r5:c1fd1df4
[  +0.008093]  r4:c372c000
[  +0.002620] [<c05e58f8>] (spi_sync) from [<c05e73d0>]
(spidev_sync_write+0xb8/0xf8)
[  +0.007948]  r5:c1167540 r4:c1fd1df4
[  +0.005745] [<c05e7318>] (spidev_sync_write) from [<c05e74d0>]
(spidev_write+0xc0/0x138)
[  +0.012392]  r6:b5b3d0d8 r5:00000000 r4:00000001
[  +0.006846] [<c05e7410>] (spidev_write) from [<c0310e90>]
(vfs_write+0xf4/0x418)
[  +0.009722]  r10:00000000 r9:c05e7410 r8:00000000 r7:b5b3d0d8
r6:00000001 r5:c2829b40
[  +0.010160]  r4:00000000 r3:00000000
[  +0.005781] [<c0310d9c>] (vfs_write) from [<c0311390>] (ksys_write+0xc4/0xfc)
[  +0.009493]  r9:c1fd0000 r8:c0100244 r7:b5b3d0d8 r6:00000001
r5:c2829b40 r4:c2829b40
[  +0.010065] [<c03112cc>] (ksys_write) from [<c03113e0>] (sys_write+0x18/0x1c)
[  +0.009534]  r7:00000004 r6:b6fee7e0 r5:b6fee7d0 r4:00000003
[  +0.007999] [<c03113c8>] (sys_write) from [<c0100060>]
(ret_fast_syscall+0x0/0x58)
[  +0.009984] Exception stack(0xc1fd1fa8 to 0xc1fd1ff0)
[  +0.007393] 1fa0:                   00000003 b6fee7d0 00000003
b5b3d0d8 00000001 00000000
[  +0.012702] 1fc0: 00000003 b6fee7d0 b6fee7e0 00000004 00000003
0099bfd8 00000000 00490f20
[  +0.012833] 1fe0: b6fae328 beed3460 b6fae334 b6fae350
[  +0.043666] Division by zero in kernel.
[  +0.006298] CPU: 0 PID: 262 Comm: smartcard-openp Tainted: G
C  E     5.11.0-rc1+ #16
[  +0.013146] Hardware name: BCM2835
[  +0.005666] Backtrace:
[  +0.004655] [<c0883d1c>] (dump_backtrace) from [<c08840c4>]
(show_stack+0x20/0x24)
[  +0.009977]  r7:c1fd1df4 r6:c1fd1e2c r5:c372cc00 r4:c0a43d94
[  +0.007930] [<c08840a4>] (show_stack) from [<c08875c8>] (dump_stack+0x28/0x30)
[  +0.009568] [<c08875a0>] (dump_stack) from [<c0883e9c>] (__div0+0x20/0x28)
[  +0.009236]  r5:c372cc00 r4:00000000
[  +0.005772] [<c0883e7c>] (__div0) from [<c04ae4cc>] (Ldiv0+0x8/0x10)
[  +0.008670] [<c05e34a4>] (spi_transfer_one_message) from
[<c05e540c>] (__spi_pump_messages+0x45c/0x6e8)
[  +0.013782]  r10:c1192e10 r9:c1192e10 r8:c1fd1e18 r7:c1fd1df4
r6:c05e9228 r5:c1fd1da0
[  +0.010143]  r4:c372cc00
[  +0.004686] [<c05e4fb0>] (__spi_pump_messages) from [<c05e58d0>]
(__spi_sync+0x214/0x23c)
[  +0.012613]  r10:c1fd1e18 r9:60000013 r8:c372cc00 r7:c05e1e60
r6:c372cc00 r5:c372c000
[  +0.010171]  r4:c1fd1df4
[  +0.004735] [<c05e56bc>] (__spi_sync) from [<c05e592c>] (spi_sync+0x34/0x4c)
[  +0.009421]  r10:00000051 r9:c2724000 r8:c1167550 r7:c1167540
r6:00000002 r5:c1fd1df4
[  +0.010200]  r4:c372c000
[  +0.004730] [<c05e58f8>] (spi_sync) from [<c05e73d0>]
(spidev_sync_write+0xb8/0xf8)
[  +0.010053]  r5:c1167540 r4:c1fd1df4
[  +0.005796] [<c05e7318>] (spidev_sync_write) from [<c05e74d0>]
(spidev_write+0xc0/0x138)
[  +0.012553]  r6:b5b60348 r5:00000000 r4:00000002
[  +0.006847] [<c05e7410>] (spidev_write) from [<c0310e90>]
(vfs_write+0xf4/0x418)
[  +0.009740]  r10:00000000 r9:c05e7410 r8:00000000 r7:b5b60348
r6:00000002 r5:c2829b40
[  +0.010147]  r4:00000000 r3:00000000
[  +0.005819] [<c0310d9c>] (vfs_write) from [<c0311390>] (ksys_write+0xc4/0xfc)
[  +0.009508]  r9:c1fd0000 r8:c0100244 r7:b5b60348 r6:00000002
r5:c2829b40 r4:c2829b40
[  +0.010048] [<c03112cc>] (ksys_write) from [<c03113e0>] (sys_write+0x18/0x1c)
[  +0.009516]  r7:00000004 r6:b6fee7e0 r5:b6fee7d0 r4:00000003
[  +0.007967] [<c03113c8>] (sys_write) from [<c0100060>]
(ret_fast_syscall+0x0/0x58)
[  +0.009975] Exception stack(0xc1fd1fa8 to 0xc1fd1ff0)
[  +0.007392] 1fa0:                   00000003 b6fee7d0 00000003
b5b60348 00000002 00000000
[  +0.012755] 1fc0: 00000003 b6fee7d0 b6fee7e0 00000004 00000003
0099bfd8 00000000 00490f20
[  +0.012845] 1fe0: 0048026c beed3460 b6fae334 b6fae350

Regards,
-- 
Vincent Pelletier
