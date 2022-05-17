Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5FA52A5D5
	for <lists+linux-spi@lfdr.de>; Tue, 17 May 2022 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347421AbiEQPQd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 May 2022 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349778AbiEQPQd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 May 2022 11:16:33 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0796286E1
        for <linux-spi@vger.kernel.org>; Tue, 17 May 2022 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=DOHZP3xFQlwGO0r1k5smbJPmS5BHAPeINOdKrMPgQu4=;
        b=F6sz635P4GhpRfeua4nWoD+9+FZeHe3woVekNAwtkypbAFsoZLZEdK8C6533+UoLql6OZlb28Oex4
         9AmfH1gT9LbCtOpv+FCxAhxXcwo+Mp4Rxg35FNGXkX07GIKLjCwc1BYJs8MrwUe5tkhYnujIAEQMYA
         4vZ09R0aQ8tBY70F0qKEaL1OGOxrIoIV49QfE53b+kDdEus5gxK516aGOPjAKVq/RAbHExRPJ/4b1a
         dy36r+sT1VZWrmURFdP5Mzyjh0wqmXk8WNYWt2R+/g4uPps/9FbvgFT8eEmyD2cCFxkhZ9zbBdHjXW
         l53j8RDWfN/vUnKZD90W6ok81m1ILoA==
X-MSG-ID: 51e98710-d5f4-11ec-b450-0050569d3a82
Date:   Tue, 17 May 2022 17:16:26 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220517171626.51d50e74@erd992>
In-Reply-To: <YoOmn1k6yEtJofe5@sirena.org.uk>
References: <20220512163445.6dcca126@erd992>
        <Yn1wE4TLyXCIm9GF@sirena.org.uk>
        <20220513144645.2d16475c@erd992>
        <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
        <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
        <YoKN/lqrgKJbVBVq@sirena.org.uk>
        <20220517122439.744cf30c@erd992>
        <YoONngxX/jdTjSOH@sirena.org.uk>
        <20220517150906.09a16a47@erd992>
        <YoOmn1k6yEtJofe5@sirena.org.uk>
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

On Tue, 17 May 2022 14:43:59 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, May 17, 2022 at 03:09:06PM +0200, David Jander wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> > > On Tue, May 17, 2022 at 12:24:39PM +0200, David Jander wrote:  
> 
> > > > on, so I wonder whether there is something to gain if one could just call
> > > > spi_bus_lock() at the start of several such small sync transfers and use
> > > > non-locking calls (skip the queue lock and io_mutex)? Not sure that would have  
> 
> > > I do worry about how this might perform under different loads where
> > > there are things coming in from more than one thread.  
> 
> > I understand your concern. The biggest issue is probably the fact that client
> > drivers can claim exclusive access to the bus this way, and who knows if they
> > take care to not claim it for too long?  
> 
> Yes, claiming the bus for a long time.
> 
> > In the end, if multiple latency-sensitive client drivers share the same SPI
> > bus, besides this being a questionable HW design, this will be asking for
> > trouble. But I agree that usage of spi_bus_lock() by client drivers is
> > probably not a good idea.  
> 
> I think the worst case would be mixing latency sensitive and throughput
> sensitive devices, or possibly tasks on a device.  As you say there's an
> element of system design here.

Sure. I have combined NOR-flash chips on the same SPI bus with an MCP2515 CAN
controller in the past. But I knew that the NOR-flash chip would only ever be
accessed during a firmware update or from the bootloader. Never together with
CAN communication. If I did, I would have lost CAN messages guaranteed. So
you can have compromises. I (as HW designer) in this case would never expect
the kernel to try to make this work concurrently, and IMHO we (as
kernel developers) shouldn't try in such extreme cases either.

> > > >  1. hard-IRQ, queue msg --ctx--> SPI worker, call msg->complete() which does
> > > >  thread IRQ work (but can only do additional sync xfers from this context).    
> > >   
> > > > vs.    
> > >   
> > > >  2. hard-IRQ, queue msg --ctx--> SPI worker, call completion --ctx--> IRQ
> > > >  thread wait for completion and does more xfers...    
> > >   
> > > > vs (and this was my idea).    
> > >   
> > > >  3. hard-IRQ, pump FIFO (if available) --ctx--> IRQ thread, poll FIFO, do more
> > > >  sync xfers...    
> > > 
> > > Roughly 1, but with a lot of overlap with option 3.  I'm unclear what
> > > you mean by "queue message" here.  
> > 
> > In the above, I meant:  
> 
> >  "queue message": 
> > 	list_add_tail(&msg->queue, &ctlr->queue);
> > 	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);  
> 
> OK, no - I'm proposing actually putting the message onto the hardware
> from interrupt context.

Nice! I like that idea. Do you want to somehow extend spi_async() to do this
transparently? So we just need to introduce a second function
("spi_async_await()" ?) which would wait for completion and collect the RX
buffer?

> > > Yes, that's the whole point.  This also flows nicely when you've got a
> > > queue since you can restart the hardware from the interrupt context
> > > without waiting to complete the transfer that just finished.  
> 
> > Ack. Only caveat I see is the requirement for CS to be settable in a
> > non-sleepable context. Not all GPIO pins have gpiod_set_value(). Some might
> > only have gpiod_set_value_cansleep(). Although the latter case is not a good
> > choice for a CS signal, so I doubt it can be found in the wild.
> > Example: I2C GPIO expanders. In such a (very unlikely) case, the spi subsystem
> > would need to fall back to the worker-queue, so probably not a big deal.  
> 
> Yes, there's a bunch of things where we have to fall back on a queue.
> There's fully bitbanged controllers, excessively large messages or delay
> requirements, clock reprogramming and other things.

I like it. Thanks for the discussions so far.

To sum up all possible patches you would accept if I understood correctly:

 1. Make the stats/accounting code be NOP with a sysfs or similar toggle.

 2. Enable the re-use of messages with once in lifetime prepare/map/validate.

 3. Introduce spi_async_await() (or similar), to wait for completion of an
 async message.

 4. Enable SPI drivers to tell the core (spi.c) under which conditions it can
 fire a message asynchronously without the need for the worker queue and
 implement support for those cases. Conditions involve max. transfer size, CS
 non-sleep access, etc... but it should probably be up to the SPI driver to
 decide I guess (ctlr->can_send_uninterruptible(msg)).

Do I miss something?

Minor concern about 4. above: Hopefully the decision can be made very quickly
(i.e. without trying and failing). Maybe this decision result can be cached in
the struct spi_message, so it can be re-used (see point 2)? Maybe as part of
prepare or validate?

I feel confident that these 4 modifications will have enough of a performance
impact if fully exploited by the MCP2518FD driver, that overhead will no
longer be a concern.

Best regards,

-- 
David Jander

