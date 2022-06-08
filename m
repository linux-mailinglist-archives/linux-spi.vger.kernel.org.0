Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB20542980
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jun 2022 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiFHIe2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jun 2022 04:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiFHIdj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jun 2022 04:33:39 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3821D4212
        for <linux-spi@vger.kernel.org>; Wed,  8 Jun 2022 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=GFg8a8+PE2JXQf+k0Lr4vhUL4bzq17cjgsh0Jjr1I8s=;
        b=okoIWawoVDgmU+pTjaRcOdKIItSU2XeLkGWvGb4vjSp8+XUHszUkWvnk5q72eMxjDbckjBmF/YxdE
         hPNumJrX5lQXImywiyZmya6M7WcBoZ8zG6GbjkvdKV2b0cE0wrRBUpLM4eJdvh7H9D+WXkdjC4SNmA
         8q2bMfIo42NwE2Ff4IS2pZ0FkWQoW9w1SXzcwMSmjHpV/NOxjNXpqWg4lrKgDs0vUjQGdxJ3Fv9B9F
         8n117iMNuMTA+G+NJUl1yilNUkQ/ArmYFm5ooFkeiwzDJfEbjhgLuK+gbfYzSVIE6ZOaytfrR5Iz9E
         FXNOVtZtSxoh2mYgFvWVgHrG9ZbGm9A==
X-MSG-ID: 2da5bd9e-e700-11ec-a2aa-0050569d11ae
Date:   Wed, 8 Jun 2022 09:54:09 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <20220608095409.2d8c46fb@erd992>
In-Reply-To: <Yp+ZX4XITW7bQtjn@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
        <20220525142928.2335378-4-david@protonic.nl>
        <20220525164603.57c98a0a@erd992>
        <Yp+ZX4XITW7bQtjn@sirena.org.uk>
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

On Tue, 7 Jun 2022 19:30:55 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, May 25, 2022 at 04:46:03PM +0200, David Jander wrote:
> > David Jander <david@protonic.nl> wrote:  
> 
> > > +static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct spi_message *msg)
> > > +{
> > > +	bool was_busy;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&ctlr->io_mutex);
> > > +
> > > +	/* If another context is idling the device then wait */
> > > +	while (ctlr->idling) {
> > > +		printk(KERN_INFO "spi sync message processing: controller is idling!\n");
> > > +		usleep_range(10000, 11000);
> > > +	}  
> 
> > This is dead ugly of course, and it needs to be removed. Not yet sure how,
> > hence the RFC. Maybe the idle -> not busy transition can be included inside
> > the io_mutex? That way this while will never be hit and can be removed...  
> 
> I'm not sure it's even quite right from a safety point of view - idling
> is protected by queue_lock but this now only takes io_mutex.  

True. This is broken.

> Moving idling (and all the was_busy stuff) within the io_mutex would
> definitely resolve the issue, the async submission context is the only one
> that really needs the spinlock and it doesn't care about idling.  I can't
> think what you could do with the io_mutex when idling so it seems to
> fit.

Ok, so we could agree on a way to fix this particular issue: put the idling
transition into the io_mutex. Thanks.

Looking forward to read comments on the rest of the code, and the general idea
of what I am trying to accomplish.

Best regards,

-- 
David Jander
