Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96252CE00
	for <lists+linux-spi@lfdr.de>; Thu, 19 May 2022 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiESIMq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 May 2022 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiESIMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 May 2022 04:12:45 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F05F252
        for <linux-spi@vger.kernel.org>; Thu, 19 May 2022 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=1MAGDqHOk0gqgdQD0CjwvDYm9UTfk0sUvYtyxlHROvk=;
        b=VK+X0N/7Qq6BkGxREHNKcdxLbOJzHXDKJepHGIhS5BThTrRDHEDgNcMtiVup/CIfmCKn+An79JXIR
         xXpj8EvyEoFCLupoEx/bXkRMEdTDzjl36ddiFZz5CXThWK2NT6+vG7kW+/aQHfqEevEg9m2EIZvhD0
         0SJDxSrvGH2GxUHYL+exy+uT+mkOL31gyPFXhqB3BXIIscESaPesgiZuEkV4+ytBjBiXL0ZbYf2dGs
         QjY5r9DvEZqQIjCTCGMfUd3eaNunmO+KBwqrSeJK0HLi+DNDV5i5H88p0rsvg0pcwMTb6ecnPKYlBF
         bd6XHwP8l28iIMe8HmrdRIKRpICYRVw==
X-MSG-ID: 72cffd79-d74b-11ec-9896-0050569d2c73
Date:   Thu, 19 May 2022 10:12:38 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220519101238.516c5f9e@erd992>
In-Reply-To: <YoPm0qDaMEogH8n2@sirena.org.uk>
References: <Yn1wE4TLyXCIm9GF@sirena.org.uk>
        <20220513144645.2d16475c@erd992>
        <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
        <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
        <YoKN/lqrgKJbVBVq@sirena.org.uk>
        <20220517122439.744cf30c@erd992>
        <YoONngxX/jdTjSOH@sirena.org.uk>
        <20220517150906.09a16a47@erd992>
        <YoOmn1k6yEtJofe5@sirena.org.uk>
        <20220517171626.51d50e74@erd992>
        <YoPm0qDaMEogH8n2@sirena.org.uk>
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

On Tue, 17 May 2022 19:17:54 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, May 17, 2022 at 05:16:26PM +0200, David Jander wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> [...]
> > > OK, no - I'm proposing actually putting the message onto the hardware
> > > from interrupt context.  
> 
> > Nice! I like that idea. Do you want to somehow extend spi_async() to do this
> > transparently? So we just need to introduce a second function
> > ("spi_async_await()" ?) which would wait for completion and collect the RX
> > buffer?  
> 
> We shouldn't need a new API to wait for the async operation to complete,
> hopefully the existing one is fine.

Maybe there is something I am not seeing then. The client needs to make two
function calls. One to fill the FIFO and start the transfer, and a second one
to poll the FIFO and read out the RX data. With the existing API, I can only
think of these options:

 1. Call spi_async() twice for just one transfer. While that might work, IMHO
 it is confusing and would require to store the state of the transfer (i.e.
 "need_finishing=true") in the spi_message. But wouldn't that potentially
 break existing code that (for some reason) calls spi_async() twice on the
 same spi_message?

 2. Use a completion or callback. But I don't see how that will work without a
 context switch to some code that completes the completion or calls the
 callback, which is what we are trying to avoid having in the first place.

If you know something I am ignoring here, please advice.

> > To sum up all possible patches you would accept if I understood correctly:  
> 
> >  1. Make the stats/accounting code be NOP with a sysfs or similar toggle.  
> 
> Or otherwise make it unobtrusive (eg, with similar techniques to those
> used by the networking API).

I just tried this out by re-writing the statistics code using u64_stats_sync
and per-cpu statistics, which get totaled on sysfs read access as Andrew Lunn
suggested.
The results are truly amazing!

The overhead caused by statistics in my test dropped from 43us to just 1-2us.

This was tested on a 64-bit machine though, so I don't know how it will affect
32-bit systems. Nor do I have an easy means of testing this. Any ideas?

Also, I have converted all the struct spi_statistics members to u64_stats_t.
It was easier to test this way. Some of the original types were unsigned long,
which can have different sizes on 64bit or 32bit systems... is that
intentional?

> >  2. Enable the re-use of messages with once in lifetime prepare/map/validate.
> > 
> >  3. Introduce spi_async_await() (or similar), to wait for completion of an
> >  async message.
> > 
> >  4. Enable SPI drivers to tell the core (spi.c) under which conditions it can
> >  fire a message asynchronously without the need for the worker queue and
> >  implement support for those cases. Conditions involve max. transfer size, CS
> >  non-sleep access, etc... but it should probably be up to the SPI driver to
> >  decide I guess (ctlr->can_send_uninterruptible(msg)).
> > 
> > Do I miss something?  
> 
> That's roughly it, plus a general push to optimise the hot path.

Perfect.

> > Minor concern about 4. above: Hopefully the decision can be made very quickly
> > (i.e. without trying and failing). Maybe this decision result can be cached in
> > the struct spi_message, so it can be re-used (see point 2)? Maybe as part of
> > prepare or validate?  
> 
> Yes, we need to do this at validation time to play with the reuse I
> think.
> 
> > I feel confident that these 4 modifications will have enough of a performance
> > impact if fully exploited by the MCP2518FD driver, that overhead will no
> > longer be a concern.  
> 
> Just the small matter of implementing them then :/

Well, at least we can agree on a plan. I can't promise anything, but I will
try to continue working on this. Thanks again for the discussion.

Best regards,

-- 
David Jander
