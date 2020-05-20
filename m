Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80F1DAFEF
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgETKSZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 06:18:25 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40161 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKSZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 May 2020 06:18:25 -0400
X-Originating-IP: 86.210.146.109
Received: from windsurf.home (lfbn-tou-1-915-109.w86-210.abo.wanadoo.fr [86.210.146.109])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8BA1920012;
        Wed, 20 May 2020 10:18:20 +0000 (UTC)
Date:   Wed, 20 May 2020 12:18:19 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        nicolas.ferre@microchip.com
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Message-ID: <20200520121819.0f816ec0@windsurf.home>
In-Reply-To: <20200519152449.GM4611@sirena.org.uk>
References: <20200519163353.20c03286@windsurf.home>
        <20200519152449.GM4611@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Mark,

Thanks a lot for your fast answer, and feedback!

On Tue, 19 May 2020 16:24:49 +0100
Mark Brown <broonie@kernel.org> wrote:

> > Does the very high CPU time spent in finish_task_switch() simply means
> > that we're scheduling too much ?  
> 
> > Any hints on how to improve this situation ?  
> 
> Not thinking about this too deeply...
> 
> The copybreak for DMA in spi-ateml is 16 bytes so at 20 byte reads
> (assuming that's what actually ends up as a SPI transfer) it might be
> worth looking at tuning that and seeing if PIO helps, though I'm not
> seeing any DMA stuff showing up there.

I've already tried disabling DMA entirely by dropping the 'dmas'
property from the DT, and it didn't change anything, even though some
transfers where larger than 16 bytes: in practice with how the UART SPI
controller works, whenever I'm receiving 20 bytes, I'm typically seeing
one transfer of 17 or 18 bytes, and then another one or two transfers
of 1-2 bytes each.

> The other thing that jumps out looking at the code is that in the
> interrupts to complete transfers the driver will just complete() and
> wake the main transfer thread up, for the reads where we always have two
> transfers per message this will cause an extra context switch.  If the
> driver were able to initiate the next transfer directly from interrupt
> context then it should schedule less (and generally reduce latency too).

Indeed, I see. The spi-atmel driver is however really structured around
synchronously handling each xfer of the spi_message. I guess what we
would want to see is atmel_spi_transfer_one_message() start the first
transfer, and then wait on a completion that indicates the completion
of *all* xfers. And then, it's the interrupt handler that dequeues the
next xfer from the spi_message and submits them, so that we don't go
back to the calling thread for each xfer.

> I can't really see much obvious in the serial driver - it might want to
> consider error checking

I'm not sure what you mean by "it might want to consider error
checking". Could you explain?

>, or if it doesn't care if transfers complete it might want to switch
>to async SPI calls, but nothing that looks like
> there's anything obvious for SPI related that you could do here.

I'm not sure how it can use async transfers. Most of the transfers are
initiated using regmap_read(), which inherently is synchronous: we need
the value of the register being read to decide if we received some
data, how much data we've received, etc. The only thing that could be
asynchronous I guess is retrieving the data from the UART RX FIFO: the
completion callback could push this data up to the TTY layer rather.

On the MAX14830 driver side, I've however noticed that the tx_work
workqueue is woken up everytime the TXEMPTY interrupt fires, and this
happens even in my RX-only workload. I've disabled it entirely, it
saves a few % of CPU time, but really not much.

Mark: in this situation where a threaded interrupt handler in max310x
is doing SPI transfers, are those SPI transfers then offloaded to the
SPI workqueue, causing another context switch, or are they done
directly within the context of the interrupt thread ? I see
__spi_sync() has some logic to push out the messages from the calling
context, I guess as opposed to offloading them to the SPI workqueue ?

Overall, do we consider it "normal" to have a ~30% CPU load for what
looks like a very light workload ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
