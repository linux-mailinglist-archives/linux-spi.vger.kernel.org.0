Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE5D54E610
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jun 2022 17:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiFPPaJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jun 2022 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiFPPaI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jun 2022 11:30:08 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472912DAAE
        for <linux-spi@vger.kernel.org>; Thu, 16 Jun 2022 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=M8cwt95/16+C08lklXx/RzuG5ugKSdoUn/bTjMAeUpw=;
        b=eMMuoujX2jIpMfk5QUlyQKwtCP8a198Um2P9CWAQhlxAPweh/4weMu5R9l7kezxGLgbSiXUkUWMcE
         A3uV5MEjziyvDfpBJLWElroi8IdVtVcqiOl+notrFipOVcpPIRteULHubS1kuWr7qohNGIqn/P4qS3
         x3NW5HUpqsqOkO28VQN0EuU3af1Dr+gVU6F3cBF95pNEPr6XXGLuiUmcBwCZqAYixLlHg6csR554Gz
         mlGWgnyR2wzFAJBCzKYkVhJcUIzibM7fqUb4TqsvQ/T/PsQv2sfQ+cRONsfvfyrBArFqyXu46U7GmU
         jgKtYDxOHqwwmFcUr10T+bE+4lqhYGA==
X-MSG-ID: 318a9c96-ed89-11ec-ba03-0050569d3a82
Date:   Thu, 16 Jun 2022 17:30:03 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <20220616173003.7202d19a@erd992>
In-Reply-To: <YqtEYTgL+wJXp9QU@sirena.org.uk>
References: <20220615124634.3302867-1-david@protonic.nl>
        <YqsuhfN1I54J+1gw@sirena.org.uk>
        <20220616161323.7f1b9e84@erd992>
        <YqtEYTgL+wJXp9QU@sirena.org.uk>
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

On Thu, 16 Jun 2022 15:55:29 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jun 16, 2022 at 04:13:23PM +0200, David Jander wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> > > On Wed, Jun 15, 2022 at 02:46:23PM +0200, David Jander wrote:  
> 
> > > I've given this a first pass and it looks sensible so far - I'll need to
> > > give it a more thorough look but I'd expect it should be fine.  The
> > > numbers certainly look good.  
> 
> > The current patch set probably needs to get partly squashed, since there are a
> > few patches that undo changes from a previous patch. I left them like this in
> > order to hopefully make the step by step mutation more clear for review.  
> 
> Yes, there's a bit of stuff.  I think it's based off your previous
> proposed patch too?

Yes, in big part. I removed the API change, and all further optimizations and
improvements are done step by step on top, like your suggestion to introduce
the completion in __pump_messages and after that optimizing it further. Ideally
I should maybe have tried to split up patch 2 a bit more.

> > I had some doubts about patch 11, since it introduces 2 new members to struct
> > spi_controller. I was trying to keep the pollution down, but I couldn't find a
> > better way to do this optimization. Any suggestions? Maybe a better name/place
> > for these flags?  
> 
> Not really - I'm not too concerned about individual flags since we don't
> have so many SPI controllers in a system, it's not like it's a per task
> overhead or similar.

Ok, then we leave it as is. I was looking for a place that grouped "private"
or "internal" struct members, but couldn't fine one really. SPI drivers
looking at these wouldn't make sense I guess.

> > Ideally this would get as much different hardware testing as possible before
> > going further upstream. Do you have access to some platforms suitable for
> > stressing SPI with multiple clients simultaneously? Known "problematic"
> > controllers maybe?  
> 
> Well, the fastest way to get it into a wide range of CI is for me to
> apply it so people who test -next will start covering it...  I was going
> to kick it into my test branch KernelCI once I've got it reviewed
> properly which will get at least some boot testing on a bunch of
> platforms.

Ah, great. I will see if I can get it tested on some more other platforms from
our side.

> For testing the main thing that'd be nice for testing would probably be
> coverage of controllers that don't block in transfer_one_message() and
> those that complete in interrupt context while blocking in there.

Ah, yes, that would be ideal. spi-pl022.c and spi-axi-spi-engine.c do this
AFAIK.
Also, if someone could make some independent performance comparisons of
before/after this series and the per-cpu stats patch, that would be very
interesting. I don't like people having to trust me on my word about the
gains ;-)

Best regards,

-- 
David Jander

