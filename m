Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683A042EDD6
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhJOJjy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 15 Oct 2021 05:39:54 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47639 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbhJOJjy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Oct 2021 05:39:54 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 01C5D20007;
        Fri, 15 Oct 2021 09:37:42 +0000 (UTC)
Date:   Fri, 15 Oct 2021 11:37:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "xiangsheng.hou" <xiangsheng.hou@mediatek.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Boris Brezillon" <bbrezillon@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jaimeliao@mxic.com.tw>,
        <juliensu@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [RFC PATCH 06/10] mtd: nand: mxic-ecc: Add Macronix external
 ECC engine support
Message-ID: <20211015113741.30712544@xps13>
In-Reply-To: <872348abea7317c6b3d2ed53c8139e0927bb991f.camel@mediatek.com>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
        <20211008162228.1753083-7-miquel.raynal@bootlin.com>
        <872348abea7317c6b3d2ed53c8139e0927bb991f.camel@mediatek.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi xiangsheng.hou,

xiangsheng.hou@mediatek.com wrote on Wed, 13 Oct 2021 17:15:49 +0800:

> Hi,
> 
> On Fri, 2021-10-08 at 18:22 +0200, Miquel Raynal wrote:
> > 
> > +static int mxic_ecc_count_biterrs(struct mxic_ecc_engine *eng,
> > struct mtd_info *mtd)
> > +{
> > +	struct device *dev = eng->dev;
> > +	unsigned int max_bf = 0;
> > +	int step;
> > +
> > +	for (step = 0; step < eng->steps; step++) {
> > +		u8 stat = eng->status[step];
> > +
> > +		if (stat == NO_ERR) {
> > +			dev_dbg(dev, "ECC step %d: no error\n", step);
> > +		} else if (stat == ERASED_CHUNK) {
> > +			dev_dbg(dev, "ECC step %d: erased\n", step);
> > +		} else if (stat == UNCORR_ERR || stat > MAX_CORR_ERR) {
> > +			dev_dbg(dev, "ECC step %d: uncorrectable\n",
> > step);
> > +			mtd->ecc_stats.failed++;
> > +		} else {
> > +			dev_dbg(dev, "ECC step %d: %d bits
> > corrected\n",
> > +				step, stat);
> > +			max_bf = max_t(unsigned int, max_bf, stat);
> > +			mtd->ecc_stats.corrected += stat;
> > +		}
> > +	}
> > +
> > +	return max_bf;
> > +}  
> 
> In spinand_mtd_read() function, rely on the return value -EBADMSG to
> check whether ecc failed. Therefore, maybe there also need return this
> value in mxic_ecc_count_biterrs() function when uncorrectable ecc
> error?

True, I'll fix this.

Thanks,
Miquèl
