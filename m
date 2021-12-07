Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09346B992
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 11:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhLGK5H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 7 Dec 2021 05:57:07 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54257 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhLGK5G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 05:57:06 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id F1644FF807;
        Tue,  7 Dec 2021 10:53:32 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:53:32 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v3 17/22] mtd: spinand: Create direct mapping
 descriptors for ECC operations
Message-ID: <20211207115332.09cab65f@xps13>
In-Reply-To: <20211207104627.7bbad94d@collabora.com>
References: <20211207093422.166934-1-miquel.raynal@bootlin.com>
        <20211207093422.166934-18-miquel.raynal@bootlin.com>
        <20211207104627.7bbad94d@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

boris.brezillon@collabora.com wrote on Tue, 7 Dec 2021 10:46:27 +0100:

> On Tue,  7 Dec 2021 10:34:17 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> >  /**
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index 85e2ff7b840d..3be594be24c0 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> > @@ -94,6 +94,7 @@ enum spi_mem_data_dir {
> >   *		 operation does not involve transferring data
> >   * @data.buf.in: input buffer (must be DMA-able)
> >   * @data.buf.out: output buffer (must be DMA-able)
> > + * @ecc_en: error correction is required
> >   */
> >  struct spi_mem_op {
> >  	struct {
> > @@ -126,6 +127,8 @@ struct spi_mem_op {
> >  			const void *out;
> >  		} buf;
> >  	} data;
> > +
> > +	bool ecc_en;
> >  };  
> 
> I really think this should be in it's own commit.

Oh crap, I forgot about that.

> And you need to make
> sure all existing drivers reject operation that have ecc_en set to
> true (that shouldn't be too complicated since most of them use generic
> helpers to do the check).

Yes, I can add this check as well.

I will propose a first patch creating a spi-mem helper to do generic
checks, given a number of additional parameters (dtr, ecc). The current
helpers will call this generic function depending on what they check
(support for dtr or not). Then I will export this generic helper and
let the drivers use it directly if needed, in order to avoid the
explosion of helpers in the core to check all the possible combinations.

I'll certainly propose a v4 just with these patches and then apply them
within the v3 if everyone agrees with the rest.

Thanks,
Miquèl
