Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9B11A133
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 03:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfLKCPy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 21:15:54 -0500
Received: from twhmllg4.macronix.com ([211.75.127.132]:18186 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfLKCPx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 21:15:53 -0500
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id xBB2EbJC009562;
        Wed, 11 Dec 2019 10:14:37 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id EE442EC2E2E051ECB764;
        Wed, 11 Dec 2019 10:14:37 +0800 (CST)
In-Reply-To: <8f2908ec-6e17-dad1-7f2a-ec22647caecb@microchip.com>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw> <8f2908ec-6e17-dad1-7f2a-ec22647caecb@microchip.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH 0/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
MIME-Version: 1.0
X-KeepSent: B2FEF12D:A2B77CBE-482584CD:000C20E3;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFB2FEF12D.A2B77CBE-ON482584CD.000C20E3-482584CD.000C5393@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 11 Dec 2019 10:14:38 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/12/11 AM 10:14:37,
        Serialize complete at 2019/12/11 AM 10:14:37
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com xBB2EbJC009562
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Tudor,

> 
> Re: [PATCH 0/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
> 
> Hi, Mason,
> 
> From the discussion you had with Vignesh, I understand that a v2 will 
follow. A
> nit below.
> 
> On 11/15/19 10:58 AM, Mason Yang wrote:
> > Hello,
> > 
> > This is repost of patchset from Boris Brezillon's
> > [RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1].
> > 
> 
> [cut]
> 
> > Mason Yang (4):
> 
> Did you intentionally overwrite Boris's authorship? If yes, would you 
please
> describe what changed from Boris's patch set?

okay, sure.
I will describe it in v2 patch set.

> 
> Cheers,
> ta

thanks for your time & comments.
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

