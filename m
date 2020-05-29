Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071291E794B
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgE2JYG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 05:24:06 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40081 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2JYF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 05:24:05 -0400
X-Originating-IP: 42.109.222.225
Received: from localhost (unknown [42.109.222.225])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 86FD1240004;
        Fri, 29 May 2020 09:24:00 +0000 (UTC)
Date:   Fri, 29 May 2020 14:53:53 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com
Subject: Re: [PATCH v4 1/7] mtd: spi-nor: sfdp: get octal mode maximum speed
 from BFPT
Message-ID: <20200529092353.56nfczya6ygfbki2@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-2-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590737775-4798-2-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/05/20 03:36PM, Mason Yang wrote:
> Get maximum operation speed of device in octal mode from
> BFPT 20th DWORD.

I don't like the idea of getting the maximum operation speed from BFPT 
when the Profile 1.0 table already tells us that. For example, the 
200MHz operation dummy cycles field in the 4th DWORD says that a value 
of 0 means the frequency is not supported. So the Profile 1.0 table 
already tells us what frequencies the flash can run at in xSPI Profile 
1.0 mode.

So IMO we should use the Profile 1.0 table for this instead because
it will be a localized change which is easier to maintain. I also get 
the feeling it will be less prone to mis-interpretations.
 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/core.h |  2 ++
>  drivers/mtd/spi-nor/sfdp.c | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/sfdp.h |  4 ++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 6f2f6b2..7a36b22 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -190,6 +190,7 @@ struct spi_nor_locking_ops {
>   *
>   * @size:		the flash memory density in bytes.
>   * @page_size:		the page size of the SPI NOR flash memory.
> + * @octal_max_speed:	maximum operation speed of device in octal mode.
>   * @hwcaps:		describes the read and page program hardware
>   *			capabilities.
>   * @reads:		read capabilities ordered by priority: the higher index
> @@ -212,6 +213,7 @@ struct spi_nor_locking_ops {
>  struct spi_nor_flash_parameter {
>  	u64				size;
>  	u32				page_size;
> +	u16				octal_max_speed;
>  
>  	struct spi_nor_hwcaps		hwcaps;
>  	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index f6038d3..4d13f66 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2014, Freescale Semiconductor, Inc.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
>  #include <linux/mtd/spi-nor.h>
> @@ -26,6 +27,12 @@
>  #define SFDP_JESD216A_MINOR	5
>  #define SFDP_JESD216B_MINOR	6
>  
> +/* Basic Flash Parameter Table 20th DWORD, Max operation speed of device */
> +struct octal_max_speed {
> +	u8 idx; /* Bits value */
> +	u16 hz; /* MHz */
> +};
> +
>  struct sfdp_header {
>  	u32		signature; /* Ox50444653U <=> "SFDP" */
>  	u8		minor;
> @@ -440,6 +447,22 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  	u32 addr;
>  	u16 half;
>  	u8 erase_mask;
> +	static const struct octal_max_speed max_hz[] = {
> +		/* Bits value, MHz */
> +		{ 0x0c, 400 },
> +		{ 0x0b, 333 },
> +		{ 0x0a, 266 },
> +		{ 0x09, 250 },
> +		{ 0x08, 200 },
> +		{ 0x07, 166 },
> +		{ 0x06, 133 },
> +		{ 0x05, 100 },
> +		{ 0x04,  80 },
> +		{ 0x03,  66 },
> +		{ 0x02,  50 },
> +		{ 0x01,  33 },
> +	};
> +	u8 idx;
>  
>  	/* JESD216 Basic Flash Parameter Table length is at least 9 DWORDs. */
>  	if (bfpt_header->length < BFPT_DWORD_MAX_JESD216)
> @@ -604,6 +627,19 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		return -EINVAL;
>  	}
>  
> +	/* Octal mode max speed */
> +	idx = max(FIELD_GET(BFPT_DWORD20_OCTAL_DTR_MAX_SPEED,
> +			    bfpt.dwords[BFPT_DWORD(20)]),
> +		  FIELD_GET(BFPT_DWORD20_OCTAL_STR_MAX_SPEED,
> +			    bfpt.dwords[BFPT_DWORD(20)]));
> +
> +	for (i = 0; i < ARRAY_SIZE(max_hz); i++) {
> +		if (max_hz[i].idx == idx) {
> +			params->octal_max_speed = max_hz[i].hz;
> +			break;
> +		}
> +	}
> +
>  	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, params);
>  }
>  
> diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> index e0a8ded..8ae6d9a 100644
> --- a/drivers/mtd/spi-nor/sfdp.h
> +++ b/drivers/mtd/spi-nor/sfdp.h
> @@ -83,6 +83,10 @@ struct sfdp_bfpt {
>  #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
>  #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
>  
> +#define BFPT_DWORD20_OCTAL_MAX_SPEED_MASK       GENMASK(31, 16)
> +#define BFPT_DWORD20_OCTAL_DTR_MAX_SPEED        GENMASK(31, 28)
> +#define BFPT_DWORD20_OCTAL_STR_MAX_SPEED        GENMASK(19, 16)
> +
>  struct sfdp_parameter_header {
>  	u8		id_lsb;
>  	u8		minor;

-- 
Regards,
Pratyush Yadav
