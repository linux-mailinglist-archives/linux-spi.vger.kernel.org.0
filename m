Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39D2A9E74
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 21:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgKFUL5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 15:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFUL5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Nov 2020 15:11:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B6C0613CF
        for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2020 12:11:56 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 23so2696366ljv.7
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2020 12:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hRONIS8TkG7r0XXlasa1NbHUOv649A+SSBDIrePZGCY=;
        b=WHNvUXrsobv+yvNRW/eMfdcz6ksrx4H54MB0Vwt2up7tNQg0bw7EJQXtP0enLyUEs9
         091TFNQ7LWHH2XeBsoQWRKOrzVyDeezZgECrpG14pbdi6/iUVnxUfYrnDoz0gd59eXhP
         BLhKJlwhvPLS5nVugTgjDyPs8tpNBNHmOPxAX9BpFW+0+b3Wfq4s+Fn/wDUNDJoJbvMC
         HyLuJ0EWV/6yZGX304kt3tPV91JoJ4MYbGhviH9e3p8qa0YfFoFZdEkL9OsitLCgme/x
         3/NGK7I5gsT9/RGeUXGGUZx3sROCV5+gl33qO8M7i9z4R/EMHbA75ISlpTRFWLt8PRha
         Y32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hRONIS8TkG7r0XXlasa1NbHUOv649A+SSBDIrePZGCY=;
        b=p7VALtpcuBGCDMpQEaaleH1xzD1c/pn0wd0ZDM5NnlJzfmeSNcGITCgNxMunHdJFA4
         KXOXa2rPB6YzXil486Rd2KG/XC0BhuFMYNN26si3pxCplgRDHdw3BkwEk8OCHOAe0LGW
         flDeEgWCOdfP0aa0YN8eGGZ/znEDMhkEhKmzPHYNHoX7CJ82DUB/3kY8lhz3IGVI43Lj
         doLS/A0FVeEouSD0yPaeoF/VOc84sX06VFJeM/0rE7V5iTAVpUZH5D8VKiPwUC1ysx5W
         JcfsJSkv0JBOMBBCqrZqJhAOuw2ll8YixQ9+cswFLneOyle6hBTDx8xrfoAJn2DbgPxT
         wl1g==
X-Gm-Message-State: AOAM531jKqLuxGaF+0+BYxcg66LDGZSCQZGpd80oYEa2Adbj/Ds+JDTJ
        tpqHBX1HTApXa2zsiUH2yKcSiB4F8Lrp/lTFMjmJocfHQ/ukNeRB
X-Google-Smtp-Source: ABdhPJzbbJO6GvLiu3caaZnCPCGy7l13AZDYkjjj/NRQpOV2nW7NcGVr0el1gUrftci5wExG0bJQLbuIr9Y95xP9xY4=
X-Received: by 2002:a2e:8808:: with SMTP id x8mr1314977ljh.384.1604693514928;
 Fri, 06 Nov 2020 12:11:54 -0800 (PST)
MIME-Version: 1.0
From:   Glenn Schmottlach <gschmottlach@gmail.com>
Date:   Fri, 6 Nov 2020 15:11:43 -0500
Message-ID: <CAMS2kBHyempbPTT5dnJ8Vb+FMop4-BjyKa4A=tB+U-cS4h7aDw@mail.gmail.com>
Subject: Linux SPI Slave fails to respond under high load on BeagleBone Black
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I have encountered a problem utilizing the Linux SPI slave capability
between two BeagleBone Blacks (BBBs) where one is SPI master and the
other is configured as the SPI slave. The two devices are directly
wired together with short leads (2-3 inches long).

Both boards are using the same linux-ti-staging kernel:

Linux beaglebone 5.4.74-g227e67c99f #1 PREEMPT Fri Nov 6 14:47:05 UTC
2020 armv7l armv7l armv7l GNU/Linux

I believe the real issue exists in the McSPI driver
(spi-omap2-mcspi.c) and its implementation of SPI slave support. Let
me explain what I am seeing.

One the SPI master I run the following command:

spi-pipe -d /dev/spidev0.0 -s 1000000 -b 32 -n -1 < /dev/random | hexdump -vC

On the BBB configured as the SPI slave I run the same:

spi-pipe -d /dev/spidev0.0 -s 1000000 -b 32 -n -1 < /dev/random | hexdump -vC

I would expect 32 bytes of random data to be passed back and forth
between the two devices continuously. Please note, I do *not* expect
the SPI master to receive consecutive 32 byte blocks of purely random
data since there will be a "gap" in time when the SPI slave sends a 32
byte chunk/message and reloads the driver with the next chunk to send.
So the expectation is that the SPI slave will clock out 32 chunks of
random data followed by some zeros while the SPI master continues to
clock data and the next chunk is loaded on the SPI slave.

This does work briefly (2-3 transfers) until the SPI slave stops
clocking out random data and seems to get stuck waiting for the clock
(and receive data) from the SPI master. I can run the same experiment
using single invocations of the transfers indefinitely,

E.g. On each device running the same command...

spi-pipe -d /dev/spidev0.0 -s 1000000 -b 32 -n 1 < /dev/random | hexdump -vC

Where "-n 1" says to send one chunk then exit the program. The problem
occurs when I allow both to run indefinitely. I have verified with a
logic analyzer that the SPI master is properly clocking out the random
data with clocks and chip selects toggling. I do not believe this is
an issue with the SPI master.

I modified the 'spi-pipe' program so that it will *only* transmit data
(e.g. set the rx_buf for the SPI transfer structure is set to NULL) in
the ioctl(fd, SPI_IOC_MESSAGE(1), &transfer) call. When configured, I
would expect the spi-pipe program would block until I invoked spi-pipe
on the SPI master since it provides the chip select and clocks for the
bi-directional data flow. Unfortunately, the spi-pipe program on the
slave device immediately returns. I instrumented the kernel driver and
see the following sequence:

spi-pipe -d /dev/spidev0.0 -s 1000000 -b 32 -n 1 -i 2 < /dev/random
[  593.951328] omap2_mcspi_setup_transfer(931): enter
[  593.956168] omap2_mcspi_setup_transfer(1012): exit
[  593.965574] omap2_mcspi_transfer_one(1186): enter
[  593.972971] omap2_mcspi_setup_transfer(931): enter
[  593.979186] omap2_mcspi_setup_transfer(1012): exit
[  593.984008] omap2_mcspi_txrx_dma(620): enter
[  593.989569] omap2_mcspi_tx_dma(420): enter
[  593.993709] omap2_mcspi_set_dma_req(204): enter
[  594.000076] omap2_mcspi_set_dma_req(220): exit
[  594.000103] omap2_mcspi_tx_callback(405): enter
[  594.009181] omap2_mcspi_set_dma_req(204): enter
[  594.013727] omap2_mcspi_set_dma_req(220): exit
[  594.018208] omap2_mcspi_tx_callback(410): exit
[  594.026941] omap2_mcspi_tx_dma(443): exit
[  594.032559] omap2_mcspi_txrx_dma(667): start wait for dma tx completion
[  594.040999] mcspi_wait_for_completion(371): enter
[  594.045742] omap2_mcspi_set_dma_req(204): enter
[  594.052341] omap2_mcspi_set_dma_req(220): exit
[  594.056814] omap2_mcspi_setup_transfer(931): enter
[  594.063635] omap2_mcspi_setup_transfer(1012): exit
[  594.069399] omap2_mcspi_transfer_one(1299): exit
[  594.074665] omap2_mcspi_setup_transfer(931): enter
[  594.080932] omap2_mcspi_setup_transfer(1012): exit

It's clear that the driver (or ioctl() call) isn't blocking but seems
to just queue up the data and exits. I believe this might be a symptom
of a larger problem with the SPI slave implementation. Below is the
sequence I see from the SPI slave when both sides (master/slave) are
run indefinitely and the SPI slave stops responding.

[ 2383.618465] omap2_mcspi_rx_dma(541): start wait for RX completion
[ 2383.625394] mcspi_wait_for_completion(371): enter
[ 2396.370655] omap2_mcspi_irq_handler(1141): irqstat = 0x30001
[ 2396.376506] omap2_mcspi_rx_callback(391): enter
[ 2396.381069] omap2_mcspi_set_dma_req(204): enter
[ 2396.385678] omap2_mcspi_set_dma_req(220): exit
[ 2396.390160] omap2_mcspi_rx_callback(396): exit
[ 2396.403603] omap2_mcspi_set_dma_req(204): enter
[ 2396.408194] omap2_mcspi_set_dma_req(220): exit
[ 2396.412670] omap2_mcspi_txrx_dma(667): start wait for dma tx completion
[ 2396.424886] mcspi_wait_for_completion(371): enter
[ 2396.429628] omap2_mcspi_set_dma_req(204): enter
[ 2396.435543] omap2_mcspi_set_dma_req(220): exit
[ 2396.440015] omap2_mcspi_setup_transfer(931): enter
[ 2396.446107] omap2_mcspi_setup_transfer(1012): exit
[ 2396.450925] omap2_mcspi_transfer_one(1299): exit
[ 2396.457608] omap2_mcspi_transfer_one(1186): enter
00000000  52 aa d3 90 95 23 c0 aa  8f 49 e3 0b 86 a1 95 de  |R....#...I......|
00000010  85 3f 32 b4 c9 fd 57 c7  31 7d ea c6 05 bd cd 18  |.?2...W.1}......|
[ 2396.468439] omap2_mcspi_setup_transfer(931): enter
[ 2396.478826] omap2_mcspi_setup_transfer(1012): exit
[ 2396.486384] omap2_mcspi_txrx_dma(620): enter
[ 2396.490687] omap2_mcspi_irq_handler(1141): irqstat = 0x3000F
[ 2396.497536] omap2_mcspi_tx_dma(420): enter
[ 2396.501679] omap2_mcspi_set_dma_req(204): enter
[ 2396.507560] omap2_mcspi_set_dma_req(220): exit
[ 2396.512029] omap2_mcspi_tx_dma(443): exit
[ 2396.517290] omap2_mcspi_rx_dma(464): enter
[ 2396.521432] omap2_mcspi_set_dma_req(204): enter
[ 2396.527294] omap2_mcspi_set_dma_req(220): exit
[ 2396.527322] omap2_mcspi_rx_callback(391): enter
[ 2396.536380] omap2_mcspi_set_dma_req(204): enter
[ 2396.540933] omap2_mcspi_set_dma_req(220): exit
[ 2396.545405] omap2_mcspi_rx_callback(396): exit
[ 2396.552488] omap2_mcspi_rx_dma(541): start wait for RX completion
[ 2396.559512] mcspi_wait_for_completion(371): enter
[ 2396.565084] omap2_mcspi_set_dma_req(204): enter
[ 2396.569639] omap2_mcspi_set_dma_req(220): exit
[ 2396.575395] omap2_mcspi_txrx_dma(667): start wait for dma tx completion
[ 2396.582045] mcspi_wait_for_completion(371): enter

At this point spi-pipe on the slave no longer responds to the master
device and I have to ctrl-c to exit it.

I am hoping someone can explain what is going on or confirm that there
is indeed a bug in the slave implementation of spi-omap2-mcspi.c. I
hope someone might be able to suggest a fix for this issue that I
could try out. I am open to testing any suggestions.

Thanks . . .
