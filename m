Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65D755D116
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245550AbiF1Gc0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 02:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbiF1GcV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 02:32:21 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D22654D
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=RC0dY5L9XAcoIfZpib9R8/Dug9940SnIQoL7Lw1IR6o=;
        b=sz+xVbds6vckjtdcoQEUAP69lh4ZEEiW+/G9QrUv7COUHZO2dlfG48J8Tc2Eoe7WdxRPdnmtpOWNl
         9FoOiT9zC2GVTOEwHLh04VBAxIGiqCx2JdLcYxScNGnmnkZuNwPh75GU5Zc4p5BphE4laxCe7XBKng
         M4i5VvUzgbjVtfGphKcVC+Pxw7SX4HfS9znOlruCpO+PSJOIIgHO5/ekbtT++MIkhieJOx2BzLRmYn
         RwixNeA7GLNCYcLkNRXinGZajNyBB9wymgKoJYfBKHlmLNrcgQk2kAoX9tV+G/sOU6VrwH+fLhyRyq
         q0m8bbFf/a9gl82KMJARETcWQfxHMiQ==
X-MSG-ID: 0c926d8f-f6ac-11ec-ba03-0050569d3a82
Date:   Tue, 28 Jun 2022 08:32:14 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 00/11] Optimize spi_sync path
Message-ID: <20220628083214.566e76da@erd992>
In-Reply-To: <YrYfFiiYuvazKBtu@sirena.org.uk>
References: <20220621061234.3626638-1-david@protonic.nl>
        <YrYfFiiYuvazKBtu@sirena.org.uk>
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

On Fri, 24 Jun 2022 21:31:18 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Jun 21, 2022 at 08:12:23AM +0200, David Jander wrote:
> > These patches optimize the spi_sync call for the common case that the
> > worker thread is idle and the queue is empty. It also opens the
> > possibility to potentially further optimize the async path also, since
> > it doesn't need to take into account the direct sync path anymore.
> > 
> > As an example for the performance gain, on an i.MX8MM SoC with a SPI CAN
> > controller attached (MCP2518FD), the time the interrupt line stays
> > active (which corresponds roughly with the time it takes to send 3
> > relatively short consecutive spi_sync messages) is reduced from 98us to
> > only 72us by this patch.  
> 
> This seems to be testing fine so far so I'm thinking it's probably a
> good idea to get it into -next which will hopefully trigger wider
> testing, unless someone shouts I'll look into that early next week.  The
> only feedback I've seen was Andy's review which is broadly stylistic so
> can safely be addressed incrementally (like the improvement in patch 4
> already does for example), I didn't see any comments there which went to
> correctness.

Great. So I will wait for this series to hit -next and then send incremental
patches to address Andy's feedback, or do you prefer I re-submit a v4 with
Andy's comments addressed right away?

Best regards,

-- 
David Jander
