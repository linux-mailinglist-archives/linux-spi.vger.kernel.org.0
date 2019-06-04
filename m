Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62B33C95
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 02:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFDAxc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 20:53:32 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:23797 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfFDAxc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jun 2019 20:53:32 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x540qiIv045850;
        Tue, 4 Jun 2019 08:52:44 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 6E1518B48C5379D5623A;
        Tue,  4 Jun 2019 08:52:44 +0800 (CST)
In-Reply-To: <20190603130235.GW4797@dell>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw> <1558423174-10748-2-git-send-email-masonccyang@mxic.com.tw> <20190603130235.GW4797@dell>
To:     "Lee Jones" <lee.jones@linaro.org>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, miquel.raynal@bootlin.com,
        robh+dt@kernel.org, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v13 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD driver
MIME-Version: 1.0
X-KeepSent: 6FE801F4:46B471FF-4825840F:0003D358;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF6FE801F4.46B471FF-ON4825840F.0003D358-4825840F.0004D419@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 4 Jun 2019 08:52:44 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/06/04 AM 08:52:44,
        Serialize complete at 2019/06/04 AM 08:52:44
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x540qiIv045850
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Jones,

> > +static int rpc_mfd_probe(struct platform_device *pdev)
> 
> Remove the "mfd" from the nomenclature.

okay, will fix.

> 
> > +   struct device_node *flash;
> > +   const struct mfd_cell *cell;
> > +   struct resource *res;
> > +   struct rpc_mfd *rpc;
> > +   void __iomem *base;
> > +
> > +   flash = of_get_next_child(pdev->dev.of_node, NULL);
> > +   if (!flash) {
> > +      dev_warn(&pdev->dev, "no flash node found\n");
> > +      return -ENODEV;
> > +   }
> > +
> > +   if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> > +      cell = &rpc_spi_ctlr;
> > +   } else if (of_device_is_compatible(flash, "cfi-flash")) {
> > +      cell = &rpc_hf_ctlr;
> > +   } else {
> > +      dev_warn(&pdev->dev, "unknown flash type\n");
> > +      return -ENODEV;
> > +   }
> 
> Are there going to be more children coming?

No, just spi-nor or cfi-flash.

The operation mode is decided at booting time by HW pin configuration.
Can't change spi-nor or cfi-flash mode at run-time.

> 
> If not, I'd argue that this is not an MFD.
> 

umm, agreed.

thanks & best regards,
Mason

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

