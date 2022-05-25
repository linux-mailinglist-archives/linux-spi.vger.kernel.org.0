Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7C533F5A
	for <lists+linux-spi@lfdr.de>; Wed, 25 May 2022 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbiEYOkA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 May 2022 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241767AbiEYOjv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 May 2022 10:39:51 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761B3326E5
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=XXJv+c9L9ZrWjDecyFJDkH68Y0PpMQijJjT3GEYOC44=;
        b=cgXQOqVYsHUynAppUNjd3hO+kA9B66Ov+8jzP7dt2vG9lIpBQzNxDsE4sZKiS6kjx3cv3e3T+LzWM
         0esa6N5kW9Ypu2iTHBJoIadKxNWUuVKuxVJ4zhHX3otDzKwY/PpZxz2uTv0CGDb6Vg3Mv3qtvGK+AX
         QMGlruOx5mviLYIORQnCrBVvn1J72touEWoVXamIC6n7PUsZSv+Qgb2WnunlVsvCyHfbfTtlbbWF49
         W68UZA1U3CgH8HLVodq8QSt7z2aN+8aFnNwjtvgClwHd3njFzzoyQS9bjSO3JWXV47bC36ib84nM14
         sYaQvVN4gs7rKpx6BaCWhzCA5hPzaUA==
X-MSG-ID: 8604c176-dc38-11ec-b450-0050569d3a82
Date:   Wed, 25 May 2022 16:39:46 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220525163946.48ea40c9@erd992>
In-Reply-To: <Yo02CLxDoCPYYZD5@sirena.org.uk>
References: <YoONngxX/jdTjSOH@sirena.org.uk>
        <20220517150906.09a16a47@erd992>
        <YoOmn1k6yEtJofe5@sirena.org.uk>
        <20220517171626.51d50e74@erd992>
        <YoPm0qDaMEogH8n2@sirena.org.uk>
        <20220519101238.516c5f9e@erd992>
        <YoeyIG+RGpRBm9Cc@sirena.org.uk>
        <20220523164832.4d9a0bb8@erd992>
        <20220523145935.eve4kzthaquecxnm@pengutronix.de>
        <20220524133048.62053868@erd992>
        <Yo02CLxDoCPYYZD5@sirena.org.uk>
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

On Tue, 24 May 2022 20:46:16 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, May 24, 2022 at 01:30:48PM +0200, David Jander wrote:
> 
> > > But that turned out be not working properly:
> > >
> > > | https://lore.kernel.org/all/f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com/  
> 
> > Ah, thanks for sharing. Added Martin to CC here.  
> 
> > I have been struggling with this too. There are definitely dragons somewhere.
> > I have tried to do tear-down in the same context if possible, similar to this:  
> 
> There's a potential issue there with ending up spending noticable extra
> time turning the controller on and off, how costly that is might be
> variable.
> 
> > I have not yet discovered exactly why. In the occasions the code didn't hit
> > the race, it seemed to have a notable performance impact though, so removing
> > this context switch may be worth the effort.  
> 
> Or come up with a mechanism for ensuring we only switch to do the
> cleanup when we're not otherwise busy.

I think the PM part might benefit from some optimizations too...

> > From what I understand of this, bus_lock_mutex is used to serialize spi_sync
> > calls for this bus, so there cannot be any concurrency from different threads
> > doing spi_sync() calls to the same bus. This means, that if spi_sync was the
> > only path in existence, bus_lock_mutex would suffice, and all the other  
> 
> The bus lock is there because some devices have an unfortunate need to
> do multiple SPI transfers with no other devices able to generate any
> traffic on the bus in between.  It seems that even more sadly some of
> the users are using it to protect against multiple calls into
> themselves so we can't just do the simple thing and turn the bus locks
> into noops if there's only one client on the bus.  However it *is* quite
> rarely used so I'm thinking that what we could do is default to not
> having it and then arrange to create it on first use, or just update
> the clients to do something during initialisation to cause it to be
> created.  That way only controllers with an affected client would pay
> the cost.
> 
> I don't *think* it's otherwise needed but would need to go through and
> verify that.
> 
> > spinlocks and mutexes could go. Big win. But the async path is what
> > complicates everything. So I have been thinking... what if we could make the
> > sync and the async case two separate paths, with two separate message queues?
> > In fact the sync path doesn't even need a queue really, since it will just
> > handle one message beginning to end, and not return until the message is done.
> > It doesn't need the worker thread either AFAICS. Or am I missing something?
> > In the end, both paths would converge at the io_mutex. I am tempted to try
> > this route. Any thoughts?  
> 
> The sync path like you say doesn't exactly need a queue itself, it's
> partly looking at the queue so it can fall back to pushing work through
> the thread in the case that the controller is busy (hopefully opening up
> opportunities for us to minimise the latency between completing whatever
> is going on already and starting the next message) and partly about
> pushing the work idling the hardware into the thread so that it's
> deferred a bit and we're less likely to end up spending time bouncing
> the controller on and off if there's a sequence of synchronous
> operations going on.  That second bit doesn't need us to actually look
> at the queue though, we just need to kick the thread so it gets run at
> some point and sees that the queue is empty.
> 
> Again I need to think this through properly but we can probably arrange
> things so that 
> 
> >         --> __spi_sync()
> >             --> bus_lock_spinlock
> >                 --> queue_lock
> >                     --> list_add_tail()
> >             --> __spi_pump_messages() (also entered here from WQ)
> >                 --> queue_lock
> >                     --> list_first_entry()  
> 
> the work we do under the first queue_lock here gets shuffled into
> __spin_pump_messages() (possibly replace in_kthread with passing in a
> message?  Would need comments.).  That'd mean we'd at least only be
> taking the queue lock once.
> 
> The other potential issue with eliminating the queue entirely would be
> if there's clients which are mixing async and sync operations but
> expecting them to complete in order (eg, start a bunch of async stuff
> then do a sync operation at the end rather than have a custom
> wait/completion).

I thought it would be easier to look at some code at this point, so I just
sent out an RFC patch series for the discussion. As for the ordering problem
you mention, I think I have solved for that. See here:

https://marc.info/?l=linux-spi&m=165348892007041&w=2

I can understand if you ultimately reject this series though, since I could
not avoid making a small change to the client driver API. I just can't figure
out how to do it without that change. The problem is that
spi_finalize_current_message() relies on ctlr->cur_msg, and we cannot touch
that if we skip the queue. Sorry for that.

Best regards,

-- 
David Jander
