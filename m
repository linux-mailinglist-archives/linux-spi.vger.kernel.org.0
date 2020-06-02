Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9AE1EB5EE
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 08:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgFBGp0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 02:45:26 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:60845 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgFBGp0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 02:45:26 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 0526ikvx091380;
        Tue, 2 Jun 2020 14:44:46 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id C04D74D93DF9337284FF;
        Tue,  2 Jun 2020 14:44:46 +0800 (CST)
In-Reply-To: <20200529094202.7vjs7clhykncivux@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw> <1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw> <20200529094202.7vjs7clhykncivux@yadavpratyush.com>
To:     "Pratyush Yadav" <me@yadavpratyush.com>
Cc:     boris.brezillon@collabora.com, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, miquel.raynal@bootlin.com, p.yadav@ti.com,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports for
 Macronix mx25uw51245g
MIME-Version: 1.0
X-KeepSent: 577383DB:7BF12AA3-4825857B:002468AB;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF577383DB.7BF12AA3-ON4825857B.002468AB-4825857B.00250F16@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 2 Jun 2020 14:44:47 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/06/02 PM 02:44:46,
        Serialize complete at 2020/06/02 PM 02:44:46
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 0526ikvx091380
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Pratyush,

 
> Subject
> 
> Re: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports 
for 
> Macronix mx25uw51245g
> 
> On 29/05/20 03:36PM, Mason Yang wrote:
> > Macronix mx25uw51245g is a SPI NOR that supports 1-1-1/8-8-8 mode.
> > 
> > Correct the dummy cycles to device for various frequencies
> > after xSPI profile 1.0 table parsed.
> > 
> > Enable mx25uw51245g to Octal DTR mode by executing the command 
sequences
> > to change to octal DTR mode.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  drivers/mtd/spi-nor/macronix.c | 55 
++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/macronix.c 
b/drivers/mtd/spi-nor/macronix.c
> > index 96735d8..6c9a24c 100644
> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -8,6 +8,57 @@
> > 
> >  #include "core.h"
> > 
> > +#define MXIC_CR2_DUMMY_SET_ADDR 0x300
> > +
> > +/* Fixup the dummy cycles to device and setup octa_dtr_enable() */
> > +static void mx25uw51245g_post_sfdp_fixups(struct spi_nor *nor)
> > +{
> > +   struct spi_nor_flash_parameter *params = nor->params;
> > +   int ret;
> > +   u8 rdc, wdc;
> > +
> > +   ret = spi_nor_read_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &rdc);
> > +   if (ret)
> > +      return;
> > +
> > +   /* Refer to dummy cycle and frequency table(MHz) */
> > +   switch (params->dummy_cycles) {
> > +   case 10:   /* 10 dummy cycles for 104 MHz */
> > +      wdc = 5;
> > +      break;
> > +   case 12:   /* 12 dummy cycles for 133 MHz */
> > +      wdc = 4;
> > +      break;
> > +   case 16:   /* 16 dummy cycles for 166 MHz */
> > +      wdc = 2;
> > +      break;
> > +   case 18:   /* 18 dummy cycles for 173 MHz */
> > +      wdc = 1;
> > +      break;
> > +   case 20:   /* 20 dummy cycles for 200 MHz */
> > +   default:
> > +      wdc = 0;
> > +   }
> 
> I don't get the point of this. You already know the fastest the 
> mx25uw51245g flash can run at. Why not just use the maximum dummy 
> cycles? SPI NOR doesn't know the speed the controller is running at so 
> the best it can do is use the maximum dummy cycles possible so it never 
> falls short. Sure, it will be _slightly_ less performance, but we will 
> be sure to read the correct data, which is much much more important.

In general, 200MHz needs 20 dummy cycles but some powerful device may only 

needs 18 dummy cycles or less.

Set a proper dummy cycles for a better performance.

> 
> Is it possible to have two chips which have _exactly_ the same ID but 
> one supports say 200MHz frequency but the other doesn't? Without that, 
> we can just enable the maximum and move on.
> 

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

