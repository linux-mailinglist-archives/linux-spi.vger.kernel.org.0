Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A13E2F9B
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhHFTCF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 15:02:05 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:56483 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhHFTCF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 15:02:05 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6F22E40008;
        Fri,  6 Aug 2021 19:01:47 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:01:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 08/13] mtd: spinand: Reject 8D-8D-8D op_templates if
 octal_dtr_enale() is missing in manufacturer_op
Message-ID: <20210806210146.3358a85b@xps13>
In-Reply-To: <20210713130538.646-9-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-9-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:33
+0000:

> The SPI NAND core doesn't know how to switch the flash to Octal DTR
> mode (i.e. which operations to perform). If the manufacturer hasn't
> implemented the octal_dtr_enable() manufacturer_op, the SPI NAND core
> wouldn't be able to switch to 8D-8D-8D mode and will also not be able
> to run in 1S-1S-1S mode due to already selected 8D-8D-8D read/write
> cache op_templates.
> 
> So, avoid choosing a Octal DTR SPI op_template for read_cache,
> write_cache and update_cache operations, if the manufacturer_op
> octal_dtr_enable() is missing.

After looking at your previous commit I don't see why this patch would
be needed. octal_dtr_enable() only updates the mode when it succeeds so
I don't think this patch is really needed.

> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 19d8affac058..8711e887b795 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1028,6 +1028,8 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
>  		if (id[0] != manufacturer->id)
>  			continue;
>  
> +		spinand->manufacturer = manufacturer;
> +
>  		ret = spinand_match_and_init(spinand,
>  					     manufacturer->chips,
>  					     manufacturer->nchips,
> @@ -1035,7 +1037,6 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
>  		if (ret < 0)
>  			continue;
>  
> -		spinand->manufacturer = manufacturer;
>  		return 0;
>  	}
>  	return -ENOTSUPP;
> @@ -1097,6 +1098,10 @@ spinand_select_op_variant(struct spinand_device *spinand,
>  		unsigned int nbytes;
>  		int ret;
>  
> +		if (spinand_op_is_octal_dtr(&op) &&
> +		    !spinand->manufacturer->ops->octal_dtr_enable)
> +			continue;
> +
>  		nbytes = nanddev_per_page_oobsize(nand) +
>  			 nanddev_page_size(nand);
>  

Thanks,
Miquèl
