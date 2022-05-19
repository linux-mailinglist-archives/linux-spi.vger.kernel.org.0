Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDFB52D624
	for <lists+linux-spi@lfdr.de>; Thu, 19 May 2022 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiESOdi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 May 2022 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbiESOdf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 May 2022 10:33:35 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F62715817
        for <linux-spi@vger.kernel.org>; Thu, 19 May 2022 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=dbYTbBAtDfHzAyRkTbtpfxhkHy9dlL7lrR+FKs6tuRs=;
        b=RY++hJksOe3nOE8UYkMds+/kZNE5F7CKHeEr04Axs11D3bEKyfgAI8tQt7zvK6kKAexNkUcv59N/x
         q8KTkw5ikkA2gG5bWMgOSVSBKSlSFeqRxyv7/un1YPixcwXRVnKH0cVEnvbrYmhOTRDecBJ0bp/Uy3
         LiSWX8yxQk87FtwpV3aHZmfezjHBIBQQCTOlCZKkvK7ip+DaqGhmTtT34V4eT5PxZFDG8sf/pTS9ol
         KXQuTnWfeWREgtkrMcxHeZ3aDcWumuFXUGT+bRvyJyW271LX8x5BICOQhozaMBRyO8xXjNmfj82pDs
         RHZuL7AelR7HWXD5+HhBTeCFUD8vJng==
X-MSG-ID: a6056181-d780-11ec-9896-0050569d2c73
Date:   Thu, 19 May 2022 16:33:27 +0200
From:   David Jander <david@protonic.nl>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Mark Brown <broonie@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-spi@vger.kernel.org, Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220519163327.606295d2@erd992>
In-Reply-To: <YoY0mMOfXyf35Y3o@lunn.ch>
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
        <YoY0mMOfXyf35Y3o@lunn.ch>
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

On Thu, 19 May 2022 14:14:16 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > > Or otherwise make it unobtrusive (eg, with similar techniques to those
> > > used by the networking API).  
> > 
> > I just tried this out by re-writing the statistics code using u64_stats_sync
> > and per-cpu statistics, which get totaled on sysfs read access as Andrew Lunn
> > suggested.
> > The results are truly amazing!
> > 
> > The overhead caused by statistics in my test dropped from 43us to just 1-2us.  
> 
> When you are potentially dealing with 10 million packets a second, you
> cannot spend long on each individual packet incrementing a counter...

I guess that is a different category of hardware you are talking about
there... ;-)

> > This was tested on a 64-bit machine though, so I don't know how it will affect
> > 32-bit systems. Nor do I have an easy means of testing this. Any ideas?  
> 
> It does make a difference. On a 64 system, you can increment a counter
> in a single instruction so you either see the old value, or the new
> value. With 32 bit systems, which needs multiple instructions to
> increment the counter, so the code takes are you cannot see anything
> odd when it needs to overflow from the lower 32bits into the upper 32
> bits. So 32bit systems will be a little bit more expensive. However,
> not by a lot.

Ok, good to know.

> > Also, I have converted all the struct spi_statistics members to u64_stats_t.
> > It was easier to test this way. Some of the original types were unsigned long,
> > which can have different sizes on 64bit or 32bit systems... is that
> > intentional?  
> 
> You can keep with uint32, if you want to, and keep with the sequence
> counter style locking. For networking, 32bit counters can wrap around
> pretty fast, so the main counters are 64 bit. But the concept works
> O.K. for smaller types.

Since I am already moving the stats to per-cpu structs, wouldn't atomic_inc()
be sufficient and even faster for uint32 stats on 32bit systems?
I still would like to hear Mark's idea on the exact types. All bytes stats
were ULL and transfer counter values were UL. Possibly the reason behind this
was to make the transfer counters as efficient to increment as possible for
the given platform, as should be the case for "unsigned long".
If we move to per-cpu and seqcount, the kernel APIs (u64_stats_t) make us chose
explicitly u64 or u32 though. On most 64bit platforms, all those stats are
64bit anyway, while on most 32bit platforms the UL stats will likely be 32bit
while the ULL are 64bit. I am inclined to make them all u64, but might decide
otherwise if I can detect a performance difference on 32bit systems.
What types should I chose?

Best regards,

-- 
David Jander
