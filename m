Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93B81EA06C
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgFAI7n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 04:59:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35432 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgFAI7n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 04:59:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0518wsLQ099629;
        Mon, 1 Jun 2020 03:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591001934;
        bh=lGlyZcBPTfIHV1CPcNrc05ZOhHwMY7+8yiwU4k+Xhg0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=m5Qq5qb7OFtWluux14ydZvYIB+t2mYHHOthas1jkOapNLeJlaFRvONQYEkz26llr9
         EFGeFBlqJEAHl4OeX/VV2UTqZi5O9lrZ5mjMMnXcpcxzL+ItRg7yv/dVP7HVzsLlgO
         BOIF2Pr24g5StH8GbC7rs1773ZevkHhWdx8O9Zzw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0518wsv0092753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jun 2020 03:58:54 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Jun
 2020 03:58:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Jun 2020 03:58:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0518wqOG104672;
        Mon, 1 Jun 2020 03:58:53 -0500
Date:   Mon, 1 Jun 2020 14:28:52 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <matthias.bgg@gmail.com>, <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <nsekhar@ti.com>,
        <boris.brezillon@collabora.com>, <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v9 13/19] mtd: spi-nor: sfdp: do not make invalid quad
 enable fatal
Message-ID: <20200601085850.um32giucfcvh5oke@ti.com>
References: <20200525091544.17270-1-p.yadav@ti.com>
 <20200525091544.17270-14-p.yadav@ti.com>
 <2267830.vuSd8QnXzO@192.168.0.120>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2267830.vuSd8QnXzO@192.168.0.120>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tudor,

On 30/05/20 06:42PM, Tudor.Ambarus@microchip.com wrote:
> On Monday, May 25, 2020 12:15:38 PM EEST Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > The Micron MT35XU512ABA flash does not support the quad enable bit. But
> > instead of programming the Quad Enable Require field to 000b ("Device
> > does not have a QE bit"), it is programmed to 111b ("Reserved").
> > 
> > While this is technically incorrect, it is not reason enough to abort
> > BFPT parsing. Instead, continue BFPT parsing assuming there is no quad
> > enable bit present.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/sfdp.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> > index 052cabb52df9..9fd3d8d9a127 100644
> > --- a/drivers/mtd/spi-nor/sfdp.c
> > +++ b/drivers/mtd/spi-nor/sfdp.c
> > @@ -576,10 +576,6 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
> > 
> >         /* Quad Enable Requirements. */
> >         switch (bfpt.dwords[BFPT_DWORD(15)] & BFPT_DWORD15_QER_MASK) {
> > -       case BFPT_DWORD15_QER_NONE:
> > -               params->quad_enable = NULL;
> > -               break;
> > -
> >         case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
> >                 /*
> >                  * Writing only one byte to the Status Register has the
> > @@ -616,8 +612,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
> >                 params->quad_enable = spi_nor_sr2_bit1_quad_enable;
> >                 break;
> > 
> > +       case BFPT_DWORD15_QER_NONE:
> >         default:
> > -               return -EINVAL;
> > +               params->quad_enable = NULL;
> > +               break;
> 
> I would just add a dev_dbg message and break the switch.
> 	dev_dbg(nor->dev, "BFPT QER reserved value used.\n");
> 	break;
> 
> You will then have to set params->quad_enable = NULL; in a post_bfpt hook.

Ok. Will re-roll.

BTW, are you planning to pick up the xSPI/8D support for 5.8? It has 
been outstanding for quite some time now and it would be great if it can 
make it through this merge window.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
