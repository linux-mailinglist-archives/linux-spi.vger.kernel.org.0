Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F771EC8FE
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jun 2020 07:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgFCFyO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 01:54:14 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35165 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgFCFyO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jun 2020 01:54:14 -0400
X-Originating-IP: 157.36.79.87
Received: from localhost (unknown [157.36.79.87])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 23E36C0005;
        Wed,  3 Jun 2020 05:54:03 +0000 (UTC)
Date:   Wed, 3 Jun 2020 11:23:59 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@collabora.com, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, miquel.raynal@bootlin.com, p.yadav@ti.com,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D
 supports for Macronix mx25uw51245g
Message-ID: <20200603055359.y35dwznglc7tlewq@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw>
 <20200529094202.7vjs7clhykncivux@yadavpratyush.com>
 <OF577383DB.7BF12AA3-ON4825857B.002468AB-4825857B.00250F16@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF577383DB.7BF12AA3-ON4825857B.002468AB-4825857B.00250F16@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02/06/20 02:44PM, masonccyang@mxic.com.tw wrote:
> 
> Hi Pratyush,
> 
>  
> > Subject
> > 
> > Re: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports 
> for 
> > Macronix mx25uw51245g
> > 
> > On 29/05/20 03:36PM, Mason Yang wrote:
> > > Macronix mx25uw51245g is a SPI NOR that supports 1-1-1/8-8-8 mode.
> > > 
> > > Correct the dummy cycles to device for various frequencies
> > > after xSPI profile 1.0 table parsed.
> > > 
> > > Enable mx25uw51245g to Octal DTR mode by executing the command 
> sequences
> > > to change to octal DTR mode.
> > > 
> > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > > ---
> > >  drivers/mtd/spi-nor/macronix.c | 55 
> ++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 55 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/spi-nor/macronix.c 
> b/drivers/mtd/spi-nor/macronix.c
> > > index 96735d8..6c9a24c 100644
> > > --- a/drivers/mtd/spi-nor/macronix.c
> > > +++ b/drivers/mtd/spi-nor/macronix.c
> > > @@ -8,6 +8,57 @@
> > > 
> > >  #include "core.h"
> > > 
> > > +#define MXIC_CR2_DUMMY_SET_ADDR 0x300
> > > +
> > > +/* Fixup the dummy cycles to device and setup octa_dtr_enable() */
> > > +static void mx25uw51245g_post_sfdp_fixups(struct spi_nor *nor)
> > > +{
> > > +   struct spi_nor_flash_parameter *params = nor->params;
> > > +   int ret;
> > > +   u8 rdc, wdc;
> > > +
> > > +   ret = spi_nor_read_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &rdc);
> > > +   if (ret)
> > > +      return;
> > > +
> > > +   /* Refer to dummy cycle and frequency table(MHz) */
> > > +   switch (params->dummy_cycles) {
> > > +   case 10:   /* 10 dummy cycles for 104 MHz */
> > > +      wdc = 5;
> > > +      break;
> > > +   case 12:   /* 12 dummy cycles for 133 MHz */
> > > +      wdc = 4;
> > > +      break;
> > > +   case 16:   /* 16 dummy cycles for 166 MHz */
> > > +      wdc = 2;
> > > +      break;
> > > +   case 18:   /* 18 dummy cycles for 173 MHz */
> > > +      wdc = 1;
> > > +      break;
> > > +   case 20:   /* 20 dummy cycles for 200 MHz */
> > > +   default:
> > > +      wdc = 0;
> > > +   }
> > 
> > I don't get the point of this. You already know the fastest the 
> > mx25uw51245g flash can run at. Why not just use the maximum dummy 
> > cycles? SPI NOR doesn't know the speed the controller is running at so 
> > the best it can do is use the maximum dummy cycles possible so it never 
> > falls short. Sure, it will be _slightly_ less performance, but we will 
> > be sure to read the correct data, which is much much more important.
> 
> In general, 200MHz needs 20 dummy cycles but some powerful device may only 
> 
> needs 18 dummy cycles or less.

Yes, but do different mx25uw51245g chips have different dummy cycle 
requirements? Shouldn't all the chips with the same ID have same 
performance?

This is a fixup hook for mx25uw51245g, so you should already know how 
many cycles are needed for this specific device. Is there any need for 
generic code here?
 
> Set a proper dummy cycles for a better performance.
> 
> > 
> > Is it possible to have two chips which have _exactly_ the same ID but 
> > one supports say 200MHz frequency but the other doesn't? Without that, 
> > we can just enable the maximum and move on.
> > 
> 

-- 
Regards,
Pratyush Yadav
