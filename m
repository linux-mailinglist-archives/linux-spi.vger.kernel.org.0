Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC835450E8
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jun 2022 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiFIPe3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jun 2022 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237688AbiFIPe1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 11:34:27 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641E1F77F1
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=qdu4XM0nz3ow8T9J21jsRD7dha7OFcnJOpY87IHpafc=;
        b=Wc9b5RD4cb1IUxsLG2xz437F0++5zwHfYC+Z8uawMCnaiNyivaSrdJhzKogEhGT8u5DJrtJ3HIl1J
         rfKJrieWuxEuo7xVuLnS/WU44hofFsjdNwSgbwPeOolT4ebad2j1yG0N2M06gl6pDBNNncoiB/WRD3
         qsPElN9APzIkOXHLcE3Kgk+ClGR2R52CxZlGnepoWF3JshGCEI9QkBU/EDIUOc2NNRyIPteqjK3dav
         +79Vsyia/grJz1N78RYotCZvneJp5UzRLlXMJyI8ia/xzoeUz6ERLjk3ZmVw9rerGut5wVbSQvqYUE
         UntTE5/XWiHPokmIbRJzmyz6iXjb+ZA==
X-MSG-ID: a2732132-e809-11ec-9896-0050569d2c73
Date:   Thu, 9 Jun 2022 17:34:21 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <20220609173421.437fe1c4@erd992>
In-Reply-To: <YqCIDNHjFP4p9xxs@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
        <20220525142928.2335378-4-david@protonic.nl>
        <20220525164603.57c98a0a@erd992>
        <Yp+ZX4XITW7bQtjn@sirena.org.uk>
        <20220608095409.2d8c46fb@erd992>
        <YqCIDNHjFP4p9xxs@sirena.org.uk>
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

On Wed, 8 Jun 2022 12:29:16 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jun 08, 2022 at 09:54:09AM +0200, David Jander wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> 
> > > Moving idling (and all the was_busy stuff) within the io_mutex would
> > > definitely resolve the issue, the async submission context is the only one
> > > that really needs the spinlock and it doesn't care about idling.  I can't
> > > think what you could do with the io_mutex when idling so it seems to
> > > fit.  
> 
> > Ok, so we could agree on a way to fix this particular issue: put the idling
> > transition into the io_mutex. Thanks.  
> 
> > Looking forward to read comments on the rest of the code, and the general idea
> > of what I am trying to accomplish.  
> 
> I think the rest of it is fine or at least I'm finding it difficult to
> see anything beyond the concurrency issues.  I think we need to do an
> audit to find any users that are doing a spi_sync() to complete a
> sequence of spi_async() operations but I'm not aware of any and if it
> delivers the performance benefits it's probably worth changing that
> aspect of the driver API.

I just discovered a different issue (hit upon by Oleksij Rempel while
assisting with testing):

Apparently some drivers tend to rely on the fact that master->cur_msg is not
NULL and always points to the message being transferred.
This could be a show-stopper to this patch set, if it cannot be solved.
I am currently analyzing the different cases, to see if and how they could
eventually get fixed. The crux of the issue is the fact that there are two
different API's towards the driver:

 1. transfer_one(): This call does not provide a reference to the message that
 contains the transfers. So all information stored only in the underlying
 spi_message are not accessible to the driver. Apparently some work around
 this by accessing master->cur_msg.

 2. transfer_one_message(): I suspect this is a newer API. It takes the
 spi_message as argument, thus giving the driver access to all information it
 needs (like return status, and the complete list of transfers).

One driver in particular spi-atmel.c, still used the deprecated
master->cur_msg->is_dma_mapped flag. This is trivially fixed by replacing this
with master->cur_msg_mapped, which is still available even in the sync path. It
is still kinda ugly though, since it is a rather indirect way of obtaining
information about the current transfer buffers it is handling.

Some drivers look at master->cur_msg in interrupt mode if there was an error
interrupt, to decide whether there is an ongoing transfer and sometimes also
to store the error code in master->cur_msg->status. This could be solved by
storing a reference to the current message in the private struct, but like in
the other cases, there is no way to obtain that spi_message pointer from the
transfer_one() call.

In other words, there seem to be both a spi_transfer based API and a
spi_message based API, but problems occur when the spi_transfer based calls
need to know things about the underlying spi_message, which is sometimes
artificially generated in functions like spi_sync_transfer(), so it always
exists.

Any suggestion which is the most desirable course of action?
Try to fix the API inconsistency of wanting to access spi_message when all you
asked for is a spi_transfer, try to work around it or just toss this patch,
give up and call it a failed attempt because the impact is too big?

Best regards,

-- 
David Jander
