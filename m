Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78411EF265
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 09:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFEHrX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 03:47:23 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55601 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgFEHrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Jun 2020 03:47:23 -0400
X-Originating-IP: 157.36.131.136
Received: from localhost (unknown [157.36.131.136])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 54D2E1C0002;
        Fri,  5 Jun 2020 07:47:15 +0000 (UTC)
Date:   Fri, 5 Jun 2020 13:17:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@collabora.com, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, miquel.raynal@bootlin.com, p.yadav@ti.com,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D
 supports for Macronix mx25uw51245g
Message-ID: <20200605074711.zxxajsfgzopnjecw@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw>
 <20200529094202.7vjs7clhykncivux@yadavpratyush.com>
 <OF577383DB.7BF12AA3-ON4825857B.002468AB-4825857B.00250F16@mxic.com.tw>
 <20200603055359.y35dwznglc7tlewq@yadavpratyush.com>
 <OF72696CF7.123ABE04-ON4825857E.000F9054-4825857E.000FEC12@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF72696CF7.123ABE04-ON4825857E.000F9054-4825857E.000FEC12@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/06/20 10:53AM, masonccyang@mxic.com.tw wrote:
> 
> > > > > 
> > > > > +#define MXIC_CR2_DUMMY_SET_ADDR 0x300
> > > > > +
> > > > > +/* Fixup the dummy cycles to device and setup octa_dtr_enable() 
> */
> > > > > +static void mx25uw51245g_post_sfdp_fixups(struct spi_nor *nor)
> > > > > +{
> > > > > +   struct spi_nor_flash_parameter *params = nor->params;
> > > > > +   int ret;
> > > > > +   u8 rdc, wdc;
> > > > > +
> > > > > +   ret = spi_nor_read_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &rdc);
> > > > > +   if (ret)
> > > > > +      return;
> > > > > +
> > > > > +   /* Refer to dummy cycle and frequency table(MHz) */
> > > > > +   switch (params->dummy_cycles) {
> > > > > +   case 10:   /* 10 dummy cycles for 104 MHz */
> > > > > +      wdc = 5;
> > > > > +      break;
> > > > > +   case 12:   /* 12 dummy cycles for 133 MHz */
> > > > > +      wdc = 4;
> > > > > +      break;
> > > > > +   case 16:   /* 16 dummy cycles for 166 MHz */
> > > > > +      wdc = 2;
> > > > > +      break;
> > > > > +   case 18:   /* 18 dummy cycles for 173 MHz */
> > > > > +      wdc = 1;
> > > > > +      break;
> > > > > +   case 20:   /* 20 dummy cycles for 200 MHz */
> > > > > +   default:
> > > > > +      wdc = 0;
> > > > > +   }
> > > > 
> > > > I don't get the point of this. You already know the fastest the 
> > > > mx25uw51245g flash can run at. Why not just use the maximum dummy 
> > > > cycles? SPI NOR doesn't know the speed the controller is running at 
> so 
> > > > the best it can do is use the maximum dummy cycles possible so it 
> never 
> > > > falls short. Sure, it will be _slightly_ less performance, but we 
> will 
> > > > be sure to read the correct data, which is much much more important.
> > > 
> > > In general, 200MHz needs 20 dummy cycles but some powerful device may 
> only 
> > > 
> > > needs 18 dummy cycles or less.
> > 
> > Yes, but do different mx25uw51245g chips have different dummy cycle 
> > requirements? Shouldn't all the chips with the same ID have same 
> > performance?
> > 
> 
> Same chip ID but different grade,
> i.e., commercial or industrial grade. 

Ok. In that case it makes sense.

-- 
Regards,
Pratyush Yadav
