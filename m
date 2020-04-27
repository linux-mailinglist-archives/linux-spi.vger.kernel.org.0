Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B621BAB26
	for <lists+linux-spi@lfdr.de>; Mon, 27 Apr 2020 19:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgD0R01 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Apr 2020 13:26:27 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56411 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgD0R01 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Apr 2020 13:26:27 -0400
Received: from localhost (unknown [42.111.30.142])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 984AF240006;
        Mon, 27 Apr 2020 17:26:18 +0000 (UTC)
Date:   Mon, 27 Apr 2020 22:53:36 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 05/16] mtd: spi-nor: default to address width of 3 for
 configurable widths
Message-ID: <20200427172336.ihezwq3wn75m7k3l@yadavpratyush.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <20200424184410.8578-6-p.yadav@ti.com>
 <6b6384ad-d37a-eea6-af29-322e83924912@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6384ad-d37a-eea6-af29-322e83924912@hisilicon.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yicong,

On 26/04/20 11:53AM, Yicong Yang wrote:
> On 2020/4/25 2:43, Pratyush Yadav wrote:
> > JESD216D.01 says that when the address width can be 3 or 4, it defaults
> > to 3 and enters 4-byte mode when given the appropriate command. So, when
> > we see a configurable width, default to 3 and let flash that default to
> > 4 change it in a post-bfpt fixup.
> >
> > This fixes SMPT parsing for flashes with configurable address width. If
> > the SMPT descriptor advertises variable address width, we use
> > nor->addr_width as the address width. But since it was not set to any
> > value from the SFDP table, the read command uses an address width of 0,
> > resulting in an incorrect read being issued.
> >
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/sfdp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> > index f917631c8110..5cecc4ba2141 100644
> > --- a/drivers/mtd/spi-nor/sfdp.c
> > +++ b/drivers/mtd/spi-nor/sfdp.c
> > @@ -460,6 +460,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
> >  	/* Number of address bytes. */
> >  	switch (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) {
> >  	case BFPT_DWORD1_ADDRESS_BYTES_3_ONLY:
> > +	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
> >  		nor->addr_width = 3;
> >  		break;
> 
> Should we also assign address width to 3 in default condition. At least we should not
> leave it uninitialized here.

The default condition would be taken when this field is 3. The value 3 
is reserved, and so no current device should use this value. That said, 
I don't see any downsides of doing so. If the value 3 means something 
else in later revisions of the standard, this code would need to change 
anyway. If not, we would use a relatively sane default for devices with 
a faulty BFPT.

I haven't received any comments on my series so far. If end up having to
re-roll it, I will add this change. Otherwise, I'm not sure if it is a 
good idea to re-roll a 16-patch series for a one liner that isn't fixing 
some major bug. In that case, maybe you can send an independent patch 
that does this after mine is merged?

-- 
Regards,
Pratyush Yadav
