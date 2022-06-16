Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1231654E31F
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jun 2022 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377608AbiFPONt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jun 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiFPON3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jun 2022 10:13:29 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62290205EE
        for <linux-spi@vger.kernel.org>; Thu, 16 Jun 2022 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=wlADeOgPO9uCtfZwX2dg0VzQPm5r77R5zflvAS6rIMs=;
        b=hsqLY2p7mlbU23VWxsZrUeyb0pAE1Zj6mEWHQDiq+X1AdLVGEAxm+0EB4VtatpSTOyUzlovsWjV55
         1xM5sUBvQE5vbi/DIiN+OOHyVTgaIb951+IGZN6MZqeTkSqOaIgwrhIheiG0a/qWKBnZYe/9sUJf07
         wrHtnHAh3QiLMImzFz9bxOHRHbJ7BIXwv8Cik7rRpKBLGYOEhhLxJPMIrK5Y16DdAMhB7SawkDJWeG
         6QvIAWA11xaay01AznwX5uYlhJWP0TNDVatpMDWaIfjw6UEt+XbBn/hLq+sM+xvePVBB4lvCmpBwlz
         vezho4ibs43Xki+UHlbtXz4mzzuiu7A==
X-MSG-ID: 7bee9b8b-ed7e-11ec-9051-0050569d2c73
Date:   Thu, 16 Jun 2022 16:13:23 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <20220616161323.7f1b9e84@erd992>
In-Reply-To: <YqsuhfN1I54J+1gw@sirena.org.uk>
References: <20220615124634.3302867-1-david@protonic.nl>
        <YqsuhfN1I54J+1gw@sirena.org.uk>
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

On Thu, 16 Jun 2022 14:22:13 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jun 15, 2022 at 02:46:23PM +0200, David Jander wrote:
> > These patches optimize the spi_sync call for the common case that the
> > worker thread is idle and the queue is empty. It also opens the
> > possibility to potentially further optimize the async path also, since
> > it doesn't need to take into account the direct sync path anymore.  
> 
> I've given this a first pass and it looks sensible so far - I'll need to
> give it a more thorough look but I'd expect it should be fine.  The
> numbers certainly look good.

Thanks!
The current patch set probably needs to get partly squashed, since there are a
few patches that undo changes from a previous patch. I left them like this in
order to hopefully make the step by step mutation more clear for review.

I had some doubts about patch 11, since it introduces 2 new members to struct
spi_controller. I was trying to keep the pollution down, but I couldn't find a
better way to do this optimization. Any suggestions? Maybe a better name/place
for these flags?

Ideally this would get as much different hardware testing as possible before
going further upstream. Do you have access to some platforms suitable for
stressing SPI with multiple clients simultaneously? Known "problematic"
controllers maybe?

Looking forward to your comments.

Best regards,

-- 
David Jander
