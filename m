Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F3B2AD03A
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 08:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgKJHGJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 02:06:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41824 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKJHGI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Nov 2020 02:06:08 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AA762Pa030851;
        Tue, 10 Nov 2020 01:06:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604991962;
        bh=Y+jIwZ+P6LPRaDoCZvUogM6zFzDU7raBl10FQtpTEiY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XNbxyW3hIFwZEJP3dxOE9eLQlN9NMdNaf2BRXjX/dUwN2tBIfGueW7IQbwVdYMVFN
         fpehY7k/xLZSVvEyFOaorpQ8McjTa68BDufwshGIwrOE5ugjcKMZKy0uaTAH1EJ17o
         TAQuha6EHHtTBbsOOCOdDko2uT2dyv/B/CdWHAHU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AA761fX126589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 01:06:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 10
 Nov 2020 01:06:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 10 Nov 2020 01:06:01 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AA75x1D002923;
        Tue, 10 Nov 2020 01:06:00 -0600
Subject: Re: Linux SPI Slave fails to respond under high load on BeagleBone
 Black
To:     Glenn Schmottlach <gschmottlach@gmail.com>,
        <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>
References: <CAMS2kBHyempbPTT5dnJ8Vb+FMop4-BjyKa4A=tB+U-cS4h7aDw@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1ef36838-81f1-5b64-bcf5-69c1bb1ff082@ti.com>
Date:   Tue, 10 Nov 2020 12:35:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMS2kBHyempbPTT5dnJ8Vb+FMop4-BjyKa4A=tB+U-cS4h7aDw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 11/7/20 1:41 AM, Glenn Schmottlach wrote:
> I have encountered a problem utilizing the Linux SPI slave capability
> between two BeagleBone Blacks (BBBs) where one is SPI master and the
> other is configured as the SPI slave. The two devices are directly
> wired together with short leads (2-3 inches long).
> 
> Both boards are using the same linux-ti-staging kernel:
> 
> Linux beaglebone 5.4.74-g227e67c99f #1 PREEMPT Fri Nov 6 14:47:05 UTC
> 2020 armv7l armv7l armv7l GNU/Linux
> 
> I believe the real issue exists in the McSPI driver
> (spi-omap2-mcspi.c) and its implementation of SPI slave support. Let
> me explain what I am seeing.
> 
> One the SPI master I run the following command:
> 
> spi-pipe -d /dev/spidev0.0 -s 1000000 -b 32 -n -1 < /dev/random | hexdump -vC
> 
> On the BBB configured as the SPI slave I run the same:
> 
> spi-pipe -d /dev/spidev0.0 -s 1000000 -b 32 -n -1 < /dev/random | hexdump -vC
> 
> I would expect 32 bytes of random data to be passed back and forth
> between the two devices continuously. Please note, I do *not* expect
> the SPI master to receive consecutive 32 byte blocks of purely random
> data since there will be a "gap" in time when the SPI slave sends a 32
> byte chunk/message and reloads the driver with the next chunk to send.
> So the expectation is that the SPI slave will clock out 32 chunks of
> random data followed by some zeros while the SPI master continues to
> clock data and the next chunk is loaded on the SPI slave.
> 

This would mean Slave TX FIFO underflows. I am not sure if McSPI IP is
robust enough to handle this case. TRM isn't particularly clear.


> This does work briefly (2-3 transfers) until the SPI slave stops
> clocking out random data and seems to get stuck waiting for the clock
> (and receive data) from the SPI master. I can run the same experiment
> using single invocations of the transfers indefinitely,
> 
> E.g. On each device running the same command...
> 
> spi-pipe -d /dev/spidev0.0 -s 1000000 -b 32 -n 1 < /dev/random | hexdump -vC
> 
> Where "-n 1" says to send one chunk then exit the program. The problem
> occurs when I allow both to run indefinitely. I have verified with a
> logic analyzer that the SPI master is properly clocking out the random
> data with clocks and chip selects toggling. I do not believe this is
> an issue with the SPI master.
> 
> I modified the 'spi-pipe' program so that it will *only* transmit data
> (e.g. set the rx_buf for the SPI transfer structure is set to NULL) in
> the ioctl(fd, SPI_IOC_MESSAGE(1), &transfer) call. When configured, I
> would expect the spi-pipe program would block until I invoked spi-pipe
> on the SPI master since it provides the chip select and clocks for the
> bi-directional data flow. Unfortunately, the spi-pipe program on the
> slave device immediately returns. I instrumented the kernel driver and
> see the following sequence:
> 
> spi-pipe -d /dev/spidev0.0 -s 1000000 -b 32 -n 1 -i 2 < /dev/random
> [  593.951328] omap2_mcspi_setup_transfer(931): enter
> [  593.956168] omap2_mcspi_setup_transfer(1012): exit
> [  593.965574] omap2_mcspi_transfer_one(1186): enter
> [  593.972971] omap2_mcspi_setup_transfer(931): enter
> [  593.979186] omap2_mcspi_setup_transfer(1012): exit
> [  593.984008] omap2_mcspi_txrx_dma(620): enter
> [  593.989569] omap2_mcspi_tx_dma(420): enter
> [  593.993709] omap2_mcspi_set_dma_req(204): enter
> [  594.000076] omap2_mcspi_set_dma_req(220): exit
> [  594.000103] omap2_mcspi_tx_callback(405): enter
> [  594.009181] omap2_mcspi_set_dma_req(204): enter
> [  594.013727] omap2_mcspi_set_dma_req(220): exit
> [  594.018208] omap2_mcspi_tx_callback(410): exit
> [  594.026941] omap2_mcspi_tx_dma(443): exit
> [  594.032559] omap2_mcspi_txrx_dma(667): start wait for dma tx completion
> [  594.040999] mcspi_wait_for_completion(371): enter
> [  594.045742] omap2_mcspi_set_dma_req(204): enter
> [  594.052341] omap2_mcspi_set_dma_req(220): exit
> [  594.056814] omap2_mcspi_setup_transfer(931): enter
> [  594.063635] omap2_mcspi_setup_transfer(1012): exit
> [  594.069399] omap2_mcspi_transfer_one(1299): exit
> [  594.074665] omap2_mcspi_setup_transfer(931): enter
> [  594.080932] omap2_mcspi_setup_transfer(1012): exit
> 

This is expected as McSPI has FIFO of 64 bytes and 32 bytes would easily
fit into it and DMA transfer would be complete but bytes would still be
in FIFO and not actually sent out.

You would see that this thread would block if you choose a transfer size
of say 128 bytes as there isn't enough room in FIFO.

> It's clear that the driver (or ioctl() call) isn't blocking but seems
> to just queue up the data and exits. I believe this might be a symptom
> of a larger problem with the SPI slave implementation. Below is the
> sequence I see from the SPI slave when both sides (master/slave) are
> run indefinitely and the SPI slave stops responding.
> 
> [ 2383.618465] omap2_mcspi_rx_dma(541): start wait for RX completion
> [ 2383.625394] mcspi_wait_for_completion(371): enter
> [ 2396.370655] omap2_mcspi_irq_handler(1141): irqstat = 0x30001
> [ 2396.376506] omap2_mcspi_rx_callback(391): enter
> [ 2396.381069] omap2_mcspi_set_dma_req(204): enter
> [ 2396.385678] omap2_mcspi_set_dma_req(220): exit
> [ 2396.390160] omap2_mcspi_rx_callback(396): exit
> [ 2396.403603] omap2_mcspi_set_dma_req(204): enter
> [ 2396.408194] omap2_mcspi_set_dma_req(220): exit
> [ 2396.412670] omap2_mcspi_txrx_dma(667): start wait for dma tx completion
> [ 2396.424886] mcspi_wait_for_completion(371): enter
> [ 2396.429628] omap2_mcspi_set_dma_req(204): enter
> [ 2396.435543] omap2_mcspi_set_dma_req(220): exit
> [ 2396.440015] omap2_mcspi_setup_transfer(931): enter
> [ 2396.446107] omap2_mcspi_setup_transfer(1012): exit
> [ 2396.450925] omap2_mcspi_transfer_one(1299): exit
> [ 2396.457608] omap2_mcspi_transfer_one(1186): enter
> 00000000  52 aa d3 90 95 23 c0 aa  8f 49 e3 0b 86 a1 95 de  |R....#...I......|
> 00000010  85 3f 32 b4 c9 fd 57 c7  31 7d ea c6 05 bd cd 18  |.?2...W.1}......|
> [ 2396.468439] omap2_mcspi_setup_transfer(931): enter
> [ 2396.478826] omap2_mcspi_setup_transfer(1012): exit
> [ 2396.486384] omap2_mcspi_txrx_dma(620): enter
> [ 2396.490687] omap2_mcspi_irq_handler(1141): irqstat = 0x3000F
> [ 2396.497536] omap2_mcspi_tx_dma(420): enter
> [ 2396.501679] omap2_mcspi_set_dma_req(204): enter
> [ 2396.507560] omap2_mcspi_set_dma_req(220): exit
> [ 2396.512029] omap2_mcspi_tx_dma(443): exit
> [ 2396.517290] omap2_mcspi_rx_dma(464): enter
> [ 2396.521432] omap2_mcspi_set_dma_req(204): enter
> [ 2396.527294] omap2_mcspi_set_dma_req(220): exit
> [ 2396.527322] omap2_mcspi_rx_callback(391): enter
> [ 2396.536380] omap2_mcspi_set_dma_req(204): enter
> [ 2396.540933] omap2_mcspi_set_dma_req(220): exit
> [ 2396.545405] omap2_mcspi_rx_callback(396): exit
> [ 2396.552488] omap2_mcspi_rx_dma(541): start wait for RX completion
> [ 2396.559512] mcspi_wait_for_completion(371): enter
> [ 2396.565084] omap2_mcspi_set_dma_req(204): enter
> [ 2396.569639] omap2_mcspi_set_dma_req(220): exit
> [ 2396.575395] omap2_mcspi_txrx_dma(667): start wait for dma tx completion
> [ 2396.582045] mcspi_wait_for_completion(371): enter
> 

At this point it looks TX DMA on slave side is still in progress and
probably is waiting for data from slave FIFO to be sent out to master.

Could you trace how much of data is left in TX FIFO using MCSPI_CHSTAT_0
and MCSPI_XFERLEVEL registers?

One possible reason may be that driver sets up  MCSPI_XFERLEVEL WCNT and
enables channel before setting up TX DMA. So if there a master that is
continuously requesting data, then there is a possibility that WCNT goes
down to 0 (due to shifting of 0s) before DMA had chance to put actual
the data into the FIFO.

Does it help if you move the programming of WCNT field to
omap2_mcspi_tx_dma()?

> At this point spi-pipe on the slave no longer responds to the master
> device and I have to ctrl-c to exit it.
> 
> I am hoping someone can explain what is going on or confirm that there
> is indeed a bug in the slave implementation of spi-omap2-mcspi.c. I
> hope someone might be able to suggest a fix for this issue that I
> could try out. I am open to testing any suggestions.
> 

Main intention of adding SPI slave support was to support limited
usecase where master and slave exchange very small known messages of
predetermined length such as to support at sparse interval (such as dead
man's switch). So tests like above would probably need more work to
McSPI driver and maybe to the core as well.

Regards
Vignesh


