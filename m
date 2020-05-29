Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147D01E799F
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgE2JmP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 05:42:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45873 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2JmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 05:42:14 -0400
X-Originating-IP: 42.109.222.225
Received: from localhost (unknown [42.109.222.225])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A530DC0007;
        Fri, 29 May 2020 09:42:07 +0000 (UTC)
Date:   Fri, 29 May 2020 15:12:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com
Subject: Re: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D
 supports for Macronix mx25uw51245g
Message-ID: <20200529094202.7vjs7clhykncivux@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/05/20 03:36PM, Mason Yang wrote:
> Macronix mx25uw51245g is a SPI NOR that supports 1-1-1/8-8-8 mode.
> 
> Correct the dummy cycles to device for various frequencies
> after xSPI profile 1.0 table parsed.
> 
> Enable mx25uw51245g to Octal DTR mode by executing the command sequences
> to change to octal DTR mode.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 55 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 96735d8..6c9a24c 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -8,6 +8,57 @@
>  
>  #include "core.h"
>  
> +#define MXIC_CR2_DUMMY_SET_ADDR 0x300
> +
> +/* Fixup the dummy cycles to device and setup octa_dtr_enable() */
> +static void mx25uw51245g_post_sfdp_fixups(struct spi_nor *nor)
> +{
> +	struct spi_nor_flash_parameter *params = nor->params;
> +	int ret;
> +	u8 rdc, wdc;
> +
> +	ret = spi_nor_read_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &rdc);
> +	if (ret)
> +		return;
> +
> +	/* Refer to dummy cycle and frequency table(MHz) */
> +	switch (params->dummy_cycles) {
> +	case 10:	/* 10 dummy cycles for 104 MHz */
> +		wdc = 5;
> +		break;
> +	case 12:	/* 12 dummy cycles for 133 MHz */
> +		wdc = 4;
> +		break;
> +	case 16:	/* 16 dummy cycles for 166 MHz */
> +		wdc = 2;
> +		break;
> +	case 18:	/* 18 dummy cycles for 173 MHz */
> +		wdc = 1;
> +		break;
> +	case 20:	/* 20 dummy cycles for 200 MHz */
> +	default:
> +		wdc = 0;
> +	}

I don't get the point of this. You already know the fastest the 
mx25uw51245g flash can run at. Why not just use the maximum dummy 
cycles? SPI NOR doesn't know the speed the controller is running at so 
the best it can do is use the maximum dummy cycles possible so it never 
falls short. Sure, it will be _slightly_ less performance, but we will 
be sure to read the correct data, which is much much more important.

Is it possible to have two chips which have _exactly_ the same ID but 
one supports say 200MHz frequency but the other doesn't? Without that, 
we can just enable the maximum and move on.

> +
> +	if (rdc != wdc)
> +		spi_nor_write_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &wdc);
> +
> +	if (params->cmd_seq[0].len) {
> +		params->octal_dtr_enable = spi_nor_cmd_seq_octal_dtr;
> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
> +		params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;

Same comment as above. We are in the mx25uw51245g fixup hook. We already 
know if the flash supports 8D mode or not from the datasheet. What is 
the need to discover it from SFDP?

> +
> +	} else {
> +		params->octal_dtr_enable = NULL;
> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_8_8_8_DTR;
> +		params->hwcaps.mask &= ~SNOR_HWCAPS_PP_8_8_8_DTR;
> +	}
> +}
> +
> +static struct spi_nor_fixups mx25uw51245g_fixups = {
> +	.post_sfdp = mx25uw51245g_post_sfdp_fixups,
> +};
> +
>  static int
>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>  			    const struct sfdp_parameter_header *bfpt_header,
> @@ -84,6 +135,10 @@
>  			      SPI_NOR_QUAD_READ) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
>  			      SPI_NOR_QUAD_READ) },
> +	{ "mx25uw51245g", INFO(0xc2813a, 0, 64 * 1024, 1024,
> +			      SECT_4K | SPI_NOR_4B_OPCODES |
> +			      SPI_NOR_OCTAL_DTR_READ)
> +			      .fixups = &mx25uw51245g_fixups },
>  };
>  
>  static void macronix_default_init(struct spi_nor *nor)

-- 
Regards,
Pratyush Yadav
