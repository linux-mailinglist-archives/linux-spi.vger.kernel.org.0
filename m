Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4552A2BD
	for <lists+linux-spi@lfdr.de>; Tue, 17 May 2022 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346243AbiEQNJO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 May 2022 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiEQNJN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 May 2022 09:09:13 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5CB35267
        for <linux-spi@vger.kernel.org>; Tue, 17 May 2022 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=Xw3aFIo+cwT9D9vr0fZxk2o7vMX09g2lWIwWcXgUkv4=;
        b=hYY27fya96oZ/moF3890fhmStySiB1p6ax5h1hN++R6AR5SfTZs/ykOxZNvt4yjv0n6AkCYk2tZ6W
         jQQzrUq0l2KkWsnuYaVlCbsLRPRhLhUlcZ69Rg/lKTaFIV/XYRpOnj01GqdVh+U5PvwVF5pQNAvCB5
         oSphOMflIgbc548ffH6+R/aCS48dQ8qTwQZgiUqmG5tmoyNZykr0gC68yXdfl2VsGqhhNnahQFexGl
         2SyLLDc42x1GFLmnUdVjdWt5XkdDoiRk3PDBD+qSv1y0uR68LPk8V8VrHyQm+xsP/fjEbuMNp8Xo6X
         /JA6/iBczF8aEULggDhb4CiLfZuxirQ==
X-MSG-ID: 88ab6c0f-d5e2-11ec-9896-0050569d2c73
Date:   Tue, 17 May 2022 15:09:06 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220517150906.09a16a47@erd992>
In-Reply-To: <YoONngxX/jdTjSOH@sirena.org.uk>
References: <20220512163445.6dcca126@erd992>
        <Yn1wE4TLyXCIm9GF@sirena.org.uk>
        <20220513144645.2d16475c@erd992>
        <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
        <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
        <YoKN/lqrgKJbVBVq@sirena.org.uk>
        <20220517122439.744cf30c@erd992>
        <YoONngxX/jdTjSOH@sirena.org.uk>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 17 May 2022 12:57:18 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, May 17, 2022 at 12:24:39PM +0200, David Jander wrote:
> 
> > (mainly in spi.c for now). Time interrupt line stays low:  
> 
> >  1. Kernel 5.18-rc1 with only polling patches from spi-next: 135us  
> 
> >  2. #if 0 around all stats and accounting calls: 100us  
> 
> >  3. The _fast API of my original RFC: 55us  
> 
> > This shows that the accounting code is a bit less than half of the dispensable
> > overhead for my use-case. Indeed an easy target.  
> 
> Good.
> 
> > on, so I wonder whether there is something to gain if one could just call
> > spi_bus_lock() at the start of several such small sync transfers and use
> > non-locking calls (skip the queue lock and io_mutex)? Not sure that would have
> > a meaningful impact, but to get an idea, I replaced the bus_lock_spinlock and
> > queue_lock in __spi_sync() and __spi_queued_transfer() with the bare code in
> > __spi_queued_transfer(), since it won't submit work to the queue in this case
> > anyway. The resulting interrupt-active time decreased by another 4us, which is
> > approximately 5% of the dispensable overhead. For the record, that's 2us per
> > spinlock lock/unlock pair.  
> 
> I do worry about how this might perform under different loads where
> there are things coming in from more than one thread.

I understand your concern. The biggest issue is probably the fact that client
drivers can claim exclusive access to the bus this way, and who knows if they
take care to not claim it for too long?
In the end, if multiple latency-sensitive client drivers share the same SPI
bus, besides this being a questionable HW design, this will be asking for
trouble. But I agree that usage of spi_bus_lock() by client drivers is
probably not a good idea.

> > > One thing that might be useful would be if we could start the initial
> > > status read message from within the hard interrupt handler of the client
> > > driver with the goal that by the time it's threaded interrupt handler
> > > runs we might have the data available.  That could go wrong on a lightly
> > > loaded system where we might end up running the threaded handler while
> > > the transfer is still running, OTOH if it's lightly loaded that might
> > > not matter.  Or perhaps just use a completion from the SPI operation and
> > > not bother with the threaded handler at all.  
> 
> > You mean ("ctx" == context switch):  
> 
> >  1. hard-IRQ, queue msg --ctx--> SPI worker, call msg->complete() which does
> >  thread IRQ work (but can only do additional sync xfers from this context).  
> 
> > vs.  
> 
> >  2. hard-IRQ, queue msg --ctx--> SPI worker, call completion --ctx--> IRQ
> >  thread wait for completion and does more xfers...  
> 
> > vs (and this was my idea).  
> 
> >  3. hard-IRQ, pump FIFO (if available) --ctx--> IRQ thread, poll FIFO, do more
> >  sync xfers...  
> 
> Roughly 1, but with a lot of overlap with option 3.  I'm unclear what
> you mean by "queue message" here.

In the above, I meant:

 "queue message": 
	list_add_tail(&msg->queue, &ctlr->queue);
	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);

 "pump FIFO":
	A special function in the spi driver that fills the TX FIFO so that a
	transfer starts and returns immediately.

 "poll FIFO": 
	Busy-loop wait until TX-FIFO is empty and RX-FIFO has the
	complete RX message.

> > Option 3 would require a separation of spi_sync_transfer into two halves. One
> > half just activates CS (non-sleep GPIO api!) and fills the FIFO. The second
> > half polls the FIFO for transfer completion. This path could only be chosen if
> > the SPI controller has a FIFO that can hold the whole message. In other words a
> > lot of spacial case handling for what it is worth probably... but still
> > interesting.  
> 
> Yes, that's the whole point.  This also flows nicely when you've got a
> queue since you can restart the hardware from the interrupt context
> without waiting to complete the transfer that just finished.

Ack. Only caveat I see is the requirement for CS to be settable in a
non-sleepable context. Not all GPIO pins have gpiod_set_value(). Some might
only have gpiod_set_value_cansleep(). Although the latter case is not a good
choice for a CS signal, so I doubt it can be found in the wild.
Example: I2C GPIO expanders. In such a (very unlikely) case, the spi subsystem
would need to fall back to the worker-queue, so probably not a big deal.

> > Option 2 is probably not that bad if the SPI worker can run on another core?  
> 
> Pretty much anything benefits with another core.

Ack. But there are still quite a few single-core SoCs out there, and for
those, Option 2 is the worst.

Best regards,

-- 
David Jander
