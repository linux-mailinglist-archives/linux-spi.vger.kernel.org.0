Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D4B5314C2
	for <lists+linux-spi@lfdr.de>; Mon, 23 May 2022 18:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiEWOsl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 May 2022 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiEWOsk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 May 2022 10:48:40 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B7559B91
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=/4/ZtsFyCVHAEiGHtqbXYaL3+CVzhDSTN1EycY2J0b4=;
        b=mCz9bpiMyBOdnZOlwjXXbG+iw8TmJKHCvTnot7Y+5uIOICf8cGoM1B2JG2KI+xRkOQznQZeKjlKaC
         VTXKVOghuOzF9xzZeT3EuHAEtjcJH7vJ3BgppLih0QMUEzIc/HQJ6PrWqy9KdfNzvneXfvwV7EMjJm
         l4ZtPsi06LodRbYoavLwvjauqMjMbOKW8iS1hjg+PZCQcybCeXIm+HcMPGq+Jro5GnFPrqBrdScrVN
         +1zA7IRX//JnI9p9hGPoNBp0NyQ6nMgapla2X6Ey8zKDWkgMbgdqE0Yq+00m48ne6jbav7cCrEYMJ4
         lHqkY3GAEjApnV7Xv3TkO8zb/5rZwTA==
X-MSG-ID: 6ac6f383-daa7-11ec-9896-0050569d2c73
Date:   Mon, 23 May 2022 16:48:32 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220523164832.4d9a0bb8@erd992>
In-Reply-To: <YoeyIG+RGpRBm9Cc@sirena.org.uk>
References: <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
        <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
        <YoKN/lqrgKJbVBVq@sirena.org.uk>
        <20220517122439.744cf30c@erd992>
        <YoONngxX/jdTjSOH@sirena.org.uk>
        <20220517150906.09a16a47@erd992>
        <YoOmn1k6yEtJofe5@sirena.org.uk>
        <20220517171626.51d50e74@erd992>
        <YoPm0qDaMEogH8n2@sirena.org.uk>
        <20220519101238.516c5f9e@erd992>
        <YoeyIG+RGpRBm9Cc@sirena.org.uk>
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

On Fri, 20 May 2022 16:22:08 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, May 19, 2022 at 10:12:38AM +0200, David Jander wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> > > On Tue, May 17, 2022 at 05:16:26PM +0200, David Jander wrote:  
> > > > Mark Brown <broonie@kernel.org> wrote:    
> 
> > > > Nice! I like that idea. Do you want to somehow extend spi_async() to do this
> > > > transparently? So we just need to introduce a second function
> > > > ("spi_async_await()" ?) which would wait for completion and collect the RX
> > > > buffer?    
> 
> > > We shouldn't need a new API to wait for the async operation to complete,
> > > hopefully the existing one is fine.  
> 
> > Maybe there is something I am not seeing then. The client needs to make two
> > function calls. One to fill the FIFO and start the transfer, and a second one
> > to poll the FIFO and read out the RX data. With the existing API, I can only
> > think of these options:  
> 
> The client just submits a message using spi_async() and can use the
> complete() callback like spi_sync() does to find out when the transfer
> is done.  The core is responsible for actually interacting with the
> device.

Having someone call the complete() callback would imply a context switch which
we are trying to avoid. To summarize the context switches involved in my
example:

 Your proposal:

 HardIRQ: calls spi_async() --ctx--> SPI worker: calls complete() --ctx--> IRQ
 thread: checks completion.

 My proposal:

 HardIRQ: calls spi_async() --ctx--> IRQ thread: calls spi_async_await()

The SPI worker (or whoever else) preempting the IRQ thread forcibly would kill
latency, and the result would be even worse as if HardIRQ did nothing and
instead the IRQ thread just called spi_sync() as is now the case.

> >  2. Use a completion or callback. But I don't see how that will work without a
> >  context switch to some code that completes the completion or calls the
> >  callback, which is what we are trying to avoid having in the first place.  
> 
> If the core doesn't need to context switch then the core should just be
> able to complete without context switching hopefully.  At most we'd need
> a mechanism to say that the completion is OK to call from atomic
> context.

Btw, I just discovered that there was indeed another often unnecessary context
switch happening in spi_sync(). When spi_finalize_current_message() is called,
it will always queue work, even if we just managed to do everything in the
calling context:

https://elixir.bootlin.com/linux/v5.18-rc7/source/drivers/spi/spi.c#L1909

This is needed to have the SPI worker thread unprepare transfer hardware and
free the dummy buffers if required. My question is why this needs to be done
from the thread. Putting the relevant code after the call to
ctlr->transfer_one_message() in __spi_pump_messages(), saves this extra bounce
to the worker thread if no more messages are queued, saving ca 10-12us extra
time between consecutive spi_sync messages.

> > > Or otherwise make it unobtrusive (eg, with similar techniques to those
> > > used by the networking API).  
> 
> > I just tried this out by re-writing the statistics code using u64_stats_sync
> > and per-cpu statistics, which get totaled on sysfs read access as Andrew Lunn
> > suggested.
> > The results are truly amazing!  
> 
> > The overhead caused by statistics in my test dropped from 43us to just 1-2us.  
> 
> Ah, cool.  I look forward to the patches.

See here:

https://marc.info/?l=linux-spi&m=165331560907187&w=2

> > This was tested on a 64-bit machine though, so I don't know how it will affect
> > 32-bit systems. Nor do I have an easy means of testing this. Any ideas?  
> 
> Hopefully someone with a 32 bit system who's concerned about performance
> can test.

I will try to do some testing soon. I need to tear down my current debug setup
and swap the i.MX8M board for a i.MX6 board to do this. Will take a while.

> > Also, I have converted all the struct spi_statistics members to u64_stats_t.
> > It was easier to test this way. Some of the original types were unsigned long,
> > which can have different sizes on 64bit or 32bit systems... is that
> > intentional?  
> 
> I don't think so.

Ok, great. I just changed everything to u64_stats_t to keep it uniform across
platforms.

Best regards,

-- 
David Jander
