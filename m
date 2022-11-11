Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B56625ACA
	for <lists+linux-spi@lfdr.de>; Fri, 11 Nov 2022 13:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiKKM71 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Nov 2022 07:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiKKM71 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Nov 2022 07:59:27 -0500
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1732E9FC
        for <linux-spi@vger.kernel.org>; Fri, 11 Nov 2022 04:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=k8YZ4k6aAARNenSwsSNaX6Jik6AgQEjho07NRaD3K1o=;
        b=PBtk1ItbBZaIUWrE0E5Ea47FulRRS9nvhvu4sA1NxoRJuO4QXvb+R1LOq1wFdayVZpQWov+MS9Dm4
         kmypFrQI5dOEEqcVUyyX7/JlGQywo9zCsy4XEVCrzFJoyUcrVDDupROrlQPjO0Aw4bko8HAA2TGwaU
         Dwd8U10T/Baq5ZObfKyZWL1uUP6DO5IJJtkS9p1dE8mldq4RVAMsuk4fyrGkbNOuxYs6tyEJ+jx7f1
         kDhlz2C8D5JR7ZISAk25YPIfY9mdnyQTbYmp+vWvS+dxJcdSNbJRTE9AARbZtkPdunBtY1vp4p9Wpk
         wqhbTKzok17eWx+Oj0xprB1iUz900Tw==
X-MSG-ID: a829c255-61c0-11ed-94b5-0050569d11ae
Date:   Fri, 11 Nov 2022 13:59:19 +0100
From:   David Jander <david@protonic.nl>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     frieder.schrempf@kontron.de, broonie@kernel.org,
        mkl@pengutronix.de, linux-spi@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Message-ID: <20221111135919.63daed2d@erd992>
In-Reply-To: <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
References: <20221111003032.82371-1-festevam@gmail.com>
        <20221111105028.7d605632@erd992>
        <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Dear Fabio,

On Fri, 11 Nov 2022 08:33:03 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi David,
> 
> On Fri, Nov 11, 2022 at 6:50 AM David Jander <david@protonic.nl> wrote:
> 
> > The effect of this patch is that it will cause short SPI transfers to have a
> > lot less latency than without this patch, so could it be that we are looking
> > at a timing related bug in the MTD driver, or some other timing issue?
> > Your SPI clock is 80MHz, but the datasheet of the MACRONIX MX25R1635F
> > specifies a maximum clock of 33MHz. Is your NOR flash chip capable of this
> > clock-rate?  
> 
> Thanks for your suggestions.
> 
> I have tried passing spi-max-frequency = <33000000>, and I don't see
> the failure anymore.
> 
> Looking at the MX25R1635F datasheet the maximum SPI frequency is:
> 
> 80MHz: when L/H bit is 1 - High Performance mode.
> 33MHz: when L/H bit is 0 - Ultra Low Power mode.
> 
> "L/H switch bit The Low Power / High Performance bit is a volatile bit.
> User can change the value of L/H switch bit to keep Ultra Low Power
> mode or High Performance mode.
> Please check Ordering Information for the L/H Switch default support"

Oh, my bad, sorry. I didn't read far enough into the DS. I just wanted to point
out that AFAIK, if you use a clock higher than 33MHz, you probably also need
"m25p,fast-read" in the DT:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mtd/spi-nor/core.c#n2550

Not sure if that can cause the issues you are seeing though.

Best regards,

-- 
David Jander
Protonic Holland.
