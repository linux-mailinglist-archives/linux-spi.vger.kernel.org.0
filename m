Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD74545D60
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 09:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbiFJH2E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343902AbiFJH2D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 03:28:03 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF4C3669A
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=Ablhtd/H3mbMh2/nLPtjUF6myRO3X5LxkQs75FcSoPs=;
        b=u7yiciBucZ9AlkdUn8APfYol6gNbrIA504NgtYIxYMOlYhw9OuVhzHaNmLKAKxKFF+4IdhnvhW4vT
         SOzK+C7zu6DpgLvBL/RsiaOQNZHOzqgHUbP/MpcD/Dszia5yKv3f3yYZ/Hk77d9LBxzwqQ6eZCH13c
         +YddY6W47peOVr/QOF41u8EVc04TggyvZUfIcKHOqFP4UEukD2vnMX9w/RvK9gWevXlkJcfyhGCZ2r
         Cq2q8/At+9skL9yxnUA2Jk4MFpKl3jO/7kc0bMIxcH2GxsGeo1Q0k+e40nbZV6Ar7wrymJpierU5cu
         SQj7TBkuSOlew0aZlc9RQJDIEhhocpQ==
X-MSG-ID: d735f1aa-e88e-11ec-b450-0050569d3a82
Date:   Fri, 10 Jun 2022 09:27:53 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <20220610092753.6e6c9e59@erd992>
In-Reply-To: <YqIgXDZAHPAQ1Y4O@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
        <20220525142928.2335378-4-david@protonic.nl>
        <20220525164603.57c98a0a@erd992>
        <Yp+ZX4XITW7bQtjn@sirena.org.uk>
        <20220608095409.2d8c46fb@erd992>
        <YqCIDNHjFP4p9xxs@sirena.org.uk>
        <20220609173421.437fe1c4@erd992>
        <YqIgXDZAHPAQ1Y4O@sirena.org.uk>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 9 Jun 2022 17:31:24 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jun 09, 2022 at 05:34:21PM +0200, David Jander wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> > > On Wed, Jun 08, 2022 at 09:54:09AM +0200, David Jander wrote:  
> > > > Mark Brown <broonie@kernel.org> wrote:    
> 
> > > I think the rest of it is fine or at least I'm finding it difficult to
> > > see anything beyond the concurrency issues.  I think we need to do an
> > > audit to find any users that are doing a spi_sync() to complete a
> > > sequence of spi_async() operations but I'm not aware of any and if it
> > > delivers the performance benefits it's probably worth changing that
> > > aspect of the driver API.  
> 
> > I just discovered a different issue (hit upon by Oleksij Rempel while
> > assisting with testing):  
> 
> > Apparently some drivers tend to rely on the fact that master->cur_msg is not
> > NULL and always points to the message being transferred.
> > This could be a show-stopper to this patch set, if it cannot be solved.
> > I am currently analyzing the different cases, to see if and how they could
> > eventually get fixed. The crux of the issue is the fact that there are two
> > different API's towards the driver:  
> 
> That seems resolvable?  If we have two things actually handling a
> message at once then we're in for a bad time so we should be able to
> arrange for cur_msg to be set in the sync path - the usage in the
> message pump between popping off the queue and getting to actually
> starting the transfer could be a local variable with the changes to the
> sync path I think?

Ok, I first thought that this wouldn't be possible without taking the
necessary spinlock, but looking a little closer, I think I understand now.
One question to confirm I understand the code correctly:
An SPI driver that implements its own transfer_one_message() is required to
_always_ call spi_finalize_current_message() _before_ returning, right?
If this is a guarantee and we take the io_mutex at the beginning of
__spi_pump_messages(), then ctlr->cur_msg is only manipulated with the
io_mutex held, and that would make it safe to be used in the sync path, which
is also behind the io_mutex.
Would appreciate if you could confirm this, just to be sure I understand the
code correctly.
The fact that spi_finalize_current_message() is a separate API function, and
not called directly from __spi_pump_messages() had me confused that it might
be called in a different context (from IRQ thread or something like that)
possibly after __spi_pump_messages() had already returned. But that doesn't
make much sense... right?

> >  1. transfer_one(): This call does not provide a reference to the message that
> >  contains the transfers. So all information stored only in the underlying
> >  spi_message are not accessible to the driver. Apparently some work around
> >  this by accessing master->cur_msg.
> 
> >  2. transfer_one_message(): I suspect this is a newer API. It takes the
> >  spi_message as argument, thus giving the driver access to all information it
> >  needs (like return status, and the complete list of transfers).
> 
> It's the other way around - transfer_one() is the result of providing a
> transfer_one_message() which factors out more of the code given that a
> huge proportion of drivers are for hardware which works at the transfer
> level and doesn't understand messages, just as transfer_one_message()
> and the message queue are factoring out code which was originally open
> coded in drivers.

Ah, thanks for the context. This makes sense or course.

Best regards,

-- 
David Jander
