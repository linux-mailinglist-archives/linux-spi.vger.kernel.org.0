Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD3228124
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgGUNjt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 09:39:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40623 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgGUNjt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 09:39:49 -0400
X-Originating-IP: 90.30.52.66
Received: from windsurf.home (lfbn-bay-1-589-66.w90-30.abo.wanadoo.fr [90.30.52.66])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3CB8240004;
        Tue, 21 Jul 2020 13:39:46 +0000 (UTC)
Date:   Tue, 21 Jul 2020 15:39:44 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        nicolas.ferre@microchip.com
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Message-ID: <20200721153944.3c331415@windsurf.home>
In-Reply-To: <20200520112659.GB4823@sirena.org.uk>
References: <20200519163353.20c03286@windsurf.home>
        <20200519152449.GM4611@sirena.org.uk>
        <20200520121819.0f816ec0@windsurf.home>
        <20200520112659.GB4823@sirena.org.uk>
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

Sorry for the very long delay in getting back to you on this. I'm
finally back on this topic.

On Wed, 20 May 2020 12:26:59 +0100
Mark Brown <broonie@kernel.org> wrote:

> Right.  You'd need to rearrange it to go through the entire message
> setting up DMA mappings that will be needed then had everything off to
> interrupt context or have extra complexity and optionally go back up to
> task context if there's anything complicated to handle.

This overall requires some fairly significant surgery in the spi-atmel
driver, which has code paths for PIO, peripheral DMA and dmaengine DMA,
all of which need to be adjusted.

> > I'm not sure what you mean by "it might want to consider error
> > checking". Could you explain?  
> 
> It wasn't checking the return values of SPI API calls.

Right, but this is unlikely to be the source of the CPU consumption
issue we're seeing.

> > Mark: in this situation where a threaded interrupt handler in max310x
> > is doing SPI transfers, are those SPI transfers then offloaded to the
> > SPI workqueue, causing another context switch, or are they done
> > directly within the context of the interrupt thread ? I see
> > __spi_sync() has some logic to push out the messages from the calling
> > context, I guess as opposed to offloading them to the SPI workqueue ?  
> 
> It should be doing transfers in calling context if the controller is
> idle, the SPI thread should only be used when the controller is already
> busy or to clean up when the controller goes idle (which will
> unfortunately happen rather a lot in your use case).
> 
> Actually looking at the code in __spi_pump_messages() again I think that
> in the case where we don't have any cleanup to do we should be able to
> avoid kicking the thread for that which should help a bit for spi-atmel.
> Can you give the patch below a go (compile tested only, not even tried
> to boot)?

I gave it a try, and unfortunately there is no difference. But it is
not too surprising, as top shows something like this:

   80     2 root     SW       0   0%  24% [irq/50-spi1.3]
   57     2 root     IW       0   0%   2% [kworker/0:1-eve]

So it's not the kthread of the SPI subsystem that is consuming most of
the CPU time, but really the threaded handler of the MAX14830 driver.
What your patch does is avoid offloading to the SPI subsystem kthread
some cleanup work when it can be done in the current context, if I
understand correctly.

> You can generally get a good idea of what's going on with regard to
> context switching at the SPI level from the SPI tracepoints, and about
> any latencies in there too.

I'll have a look there, but I don't really have any latency issue,
rather a CPU consumption issue, which is quite different.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
