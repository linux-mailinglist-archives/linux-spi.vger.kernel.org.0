Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D832B35FA
	for <lists+linux-spi@lfdr.de>; Sun, 15 Nov 2020 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgKOQBw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Nov 2020 11:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgKOQBw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Nov 2020 11:01:52 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA7C0613D1
        for <linux-spi@vger.kernel.org>; Sun, 15 Nov 2020 08:01:51 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so21253592lfe.12
        for <linux-spi@vger.kernel.org>; Sun, 15 Nov 2020 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z/o5dHQdupSX0LEpFJUfukdhv88jcnp6r8cNQQCHst4=;
        b=qTDbJKqporXAV7pI8syzKGLsGqEV6rOprWwaKQBz6n/nOoWeURU+hOyyOhVUHjktCR
         4MSaFijqG7s6V5amzrZH/HasaHIUw7fy67VScu6d+FHsVDXzkk/Kpb62fhgVj6K4D49q
         /Z4Jt14wxJXcggRcemd3o/eYKvXp2m/xqs0RJErcVvvIA7SxEA6QJiM3Wxb9Tk0KUibF
         CauFSkp78slSsNr76DHnyy97PsjDZL4g9ErCjWEvAuruQXC9eLl4r1I5R9UhB0A3hQP5
         W577j5NOpeDCg2N2ka/o1bIPSp0rADllV0cnqBFdu13PkxJMfILiIB1nrwLbxxdZDQ7A
         WONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z/o5dHQdupSX0LEpFJUfukdhv88jcnp6r8cNQQCHst4=;
        b=V+c+G4lMECSdtO7J13GO4soz9vgn0w1lxhxTBCsmLbvSxT9c+qH2Uxl6e1cPXQSKEX
         8sGUzxnfLrvtz8eBnJnGsX4dyi66GgozFiJa9v4LPEvLrCcpP+R5CkmkM2yiTTdFp4FX
         AMIL5xh6A0D/j9r44ZqsbjMEz7sZRiiX7g7hG9EpqtlIvGsbe95VCRxq+K590xkOYAcU
         qufXlGSzx/ZSexha1MpZdWDmyUZTnZ+yivpz3PeiDuVzT6wVy/1G2lZhCY8cfVtp2Xvw
         s2bKR7I/6FFc7Ce+mhM1oRH2haeDgslCx8B945mph4fM+8IoUV23EsWw4Sp7CZNqZZWg
         Wcqw==
X-Gm-Message-State: AOAM5301jtn/DZAbxwPpPKgrL2YAvQRHH6xafinI4tCe4L+NVnyC49ro
        RgAHgfjYJT9IzrHLXEd1z0o=
X-Google-Smtp-Source: ABdhPJwGzRPIrF+sBIOG5+BoQZRv3Bz6c14nq7V/gFYoEqGUPcozBm13x+jsjMQqI/lQzXoTRIaKvw==
X-Received: by 2002:ac2:5195:: with SMTP id u21mr4260598lfi.393.1605456109201;
        Sun, 15 Nov 2020 08:01:49 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id b19sm2354172lfp.254.2020.11.15.08.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 08:01:48 -0800 (PST)
Date:   Sun, 15 Nov 2020 19:01:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "seanga2@gmail.com" <seanga2@gmail.com>
Subject: Re: [PATCH 04/32] spi: dw: Introduce polling device tree property
Message-ID: <20201115160146.efxcdjhm7f2nmivo@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-5-damien.lemoal@wdc.com>
 <20201109195913.itgfj2ga5y7sr6zx@mobilestation>
 <58943f7988706497040cac6f6108336286e9d15f.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58943f7988706497040cac6f6108336286e9d15f.camel@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 13, 2020 at 09:22:54AM +0000, Damien Le Moal wrote:
> On Mon, 2020-11-09 at 22:59 +0300, Serge Semin wrote:
> > On Sat, Nov 07, 2020 at 05:13:52PM +0900, Damien Le Moal wrote:
> > > With boards that have slow interrupts context switch, and a fast device
> > > connected to a spi master, e.g. an SD card through mmc-spi,
> > 
> > > using
> > > dw_spi_poll_transfer() intead of the regular interrupt based
> > > dw_spi_transfer_handler() function is more efficient and
> > 
> > I can believe in that. But the next part seems questionable:
> > 
> > > can avoid a lot
> > > of RX FIFO overflow errors while keeping the device SPI frequency
> > > reasonnably high (for speed).
> > 
> > No matter whether it's an IRQ-based or poll-based transfer, as long as a
> > client SPI-device is connected with a GPIO-based chip-select (or the
> > DW APB SSI-controller feature of the automatic chip-select toggling is
> > fixed), the Rx FIFO should never overrun. It's ensured by the transfer
> > algorithm design by calculating the rxtx_gap in the dw_writer()
> > method. If the error still happens then there must be some bug in
> > the code.
> > 
> > It's also strange to hear that the polling-based transfer helps
> > to avoid the Rx FIFO overflow errors, while the IRQ-based transfer
> > causes them. Both of those methods are based on the same dw_writer()
> > and dw_reader() methods. So basically they both should either work
> > well or cause the errors at same time.
> > 
> > So to speak could you more through debug your case?
> 
> I did. And I have much better results now. Let me explain:

> 1) The device tree was setting up the SPI controller using the controller
> internal chip select, not a GPIO-based chip select. Until now, I could never
> get the GPIO-based chip select to work. I finally found out why: I simply
> needed to add the "spi-cs-high" property to the mmc-slot node. With that, the
> CS gpio is correctly driven active-high instead of the default active-low and
> the SD card works.

Yeap, that's the main problem of the standard DW APB SSI controller
released by Synopsys. Currently SPI-flash'es are the only SPI
peripheral devices which are capable to work with native DW APB SSI
chip-selects. I've fixed that for flashes recently by atomizing the
SPI memory operations (executing them with the local IRQs disabled)
and performing them on the poll-based basis. Alas the normal
SPI-transfers still can't be properly executed with native
chip-selects.

> 2) With this change using the GPIO-based CS, the patch "spi: dw: Fix driving
> MOSI low while receiving" became completely unnecessary. The SD card works
> without it.

Hm, that's weird. MOSI level has nothing todo with the chip-selects.
Are you sure the original problem has been connected with the Tx lane
level? On the other hand are you sure the problem has gone away after
all?

Moreover I've just taken alook at the MMC SPI driver. Turns out it
has already been fixed to send ones to the MMC port when it's
required. So If you still experience the MOSI-level problem
then that fix might have been done incorrect at some extent...

> 
> Now for testing, I also removed this polling change. Results are these:
> 1) With the same SPI frequency as before (4MHz), I can run the SD card at about
> 300 KB/s (read) but I am still seeing some RX FIFO overflow errors. Not a lot,
> but enough to be annoying, especially on boot as the partition scan sometimes
> fails because of these errors. In most cases, the block layer retry of failed
> read/writes cover and no bad errors happen, but the RX FIFO overflow error
> messages still pop up.
> 2) Looking into the code further, I realized that RXFLTR is set to half the
> fifo size minus 1. That sound reasonable, but as that delays interrupt
> generation until the RX fifo is almost full, I decided to try a value of 0 to
> get the interrupt as soon as data is available rather than waiting for a chunk.
> With that, all RX FIFO overflow errors go away, and I could even double the SPI
> frequency to 8MHz, getting a solid 650KB/s from the SD card without any error
> at all.
> 

Please, see my last comment...

> My take:
> * This controller internal CS seems to be totally broken.

Native CS aren't broken, they just have been designed so it isn't that
easy to use them in the linux kernel. Linux kernel SPI-core expects
the chip-select being driven the way it needs at the certain moments,
while DW APB SSI toggles them automatically at the moment of the data
pushing/popping to/from the SPI bus. Some hardware vendors that bought
the DW APB SSI IP-core have fixed that by providing a way of direct
CS lane control (see spi-dw-mmio.c: Microsemi, Sparx5, Alpine
platforms).

> * This SoC has really slow interrupts, so generating these earlier rather than
> later gives time to the IRQ handler to kick in before the FIFO overflows.

I am pretty sure that's not the reason. See my next comment.

> 
> In the V2 series for SPI DW, I added a DW_SPI_CAP_RXFLTR_CLEAR capability flag
> to set RXFLTR to 0, always. That works well, but this is may be still similar
> to the "polling" hack in the sense that it is tuning for this SoC rather than a
> property of the controller. But I do not see any other simple way of removing
> these annoying RX FIFO overflow errors.

Alas no, RX-FIFO level value shouldn't affect the SPI-transfers
execution results. I'll try to explain it one more time. DW APB SSI
provides three modes of transfers (TMOD-es, see the chip manual for
details). One of them is TMOD=0x0 - Transmit and Receive. Simply
speaking the mode essence is if you push a byte of data to the Tx
FIFO you'll synchronously get a byte of data back in the Rx FIFO a bit
later from the internal shift register. The IRQ-based transfers have
been developed full based on that mode. So it's absolutely possible to
implement a stable algorithm, which would work without a risk of
getting the Rx FIFO overflow or the Tx FIFO overrun. Such algorithm
should just preserve a balance of sent data so the received data
wouldn't cause the Rx FIFO overrun. As you understand such algorithm
doesn't depend on the IRQes performance. No matter how slow the IRQs
handler is execute, as long as it's executed, the SPI transfers
procedure shall go on with no errors including the Rx FIFO overflows.
At least that's what the original DW APB SSI driver developer
implied when created the code and what I was trying to preserve in my
patches. If you still get the errors (you sure it's Rx FIFO overflows,
aren't you?), then something went wrong and either me or the original
author or someone else has broken the code.

What we currently need is to carefully analyze at what moment you get
the overflows, what really caused them and fix the problem in the
code. The capabilities flag isn't an option in this case. I've tried
to reproduce the errors by slowing the system down, executing the
SPI-transfers of various length, but with no lick. So it's only you
for now who observes and can try to debug the problem.

Anyway after we get to fix it, you'll be able to run the MMC port with
speed as fast as it's possible.

---
One more thing about MMC SPI. Please note, that using MMC SPI and
DMA-based DW APB SSI transfers might not work well. The thing is that
the DMA-part of the MMC SPI driver relies on the legacy
spi_message->is_dma_mapped interface. It performs some specific
DEV-to-MEM and MEM-to-DEV DMA-buffers splitting and synchronizations.
In its turn the DMA-part of the DW APB SSI driver uses the generic
SPI-core and the DMA-engine interface to execute the SPI-transfers.
Since the SPI-core performs the DMA buffers synchronizations
internally at the moment of the buffers mapping, in case if the DMA
accesses aren't coherent on your platform, the data buffers might get
synchronized/flushed with/by caches incorrectly corrupting a part of
actual data. At least that's what we observed in kernel 4.9... So for
now I'd suggest to use either the poll- or the IRQ-based DW APB SSI
transfers.

-Sergey

> 
> > On the other hand the errors (but not the Rx FIFO overflow) might be
> > caused by the DW APB SSI nasty feature of the native chip-select
> > automatic assertion/de-assertion. So if your MMC-spi port is handled
> > by the native DW APB SSI CS lane, then it won't work well for sure.
> > No matter whether you use the poll- or IRQ-based transfers.
> 
> Indeed. The GPIO-based CS does behave much more nicely, and it does not require
> that "drive MOSI line high" hack. But for reasons that I still do not clearly
> understand, occasional RX FIFO overflow errors still show up.
> 
> 
> Thanks for all the useful comments !
> 
> -- 
> Damien Le Moal
> Western Digital
