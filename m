Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DAE36BD7E
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 04:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhD0CsG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 22:48:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45020 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhD0CsF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Apr 2021 22:48:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13R2lC2T064028;
        Mon, 26 Apr 2021 21:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619491632;
        bh=zYzZyo7eAVF1bh/U1LMs6n33b5wq+o4sS4l16pnva1g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=o+RKoL6HcAtOPmwAXgxRSL31U9mfSrF8JSdbWSUeQEdMUwDxmoYMAR4URG9IWdcRV
         pVjyqfPUkvC6nzHJ46wyb00ti8bTgObqxDLxpEo98COvKgRJg7lzkeoFj97LiVCnCA
         MJOiHrzDt3wnCBSLBOfseic6BFDQ+dTn5H0midQQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13R2lBZb062601
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Apr 2021 21:47:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 21:47:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Apr 2021 21:47:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13R2lADE078979;
        Mon, 26 Apr 2021 21:47:11 -0500
Date:   Tue, 27 Apr 2021 08:17:10 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <broonie@kernel.org>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: macronix: add support for Macronix
 octaflash series
Message-ID: <20210427024707.hrr5r74apwghwsaj@ti.com>
References: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw>
 <1618900179-14546-3-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1618900179-14546-3-git-send-email-zhengxunli@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 20/04/21 02:29PM, Zhengxun Li wrote:
> Add 1.8V and 3V Octal NOR Flash IDs.
> MX25 series : Serial NOR Flash.
> MX66 series : Serial NOR Flash with stacked die.

I only looked briefly at the datasheet, but I don't see any mention of 
stacked dies. I assume the stacked die part is transparent from software 
point of view, and is only a hardware implementation detail. Correct?

> LM/UM series : Up to 250MHz clock frequency with both DTR/STR operation.
> LW/UW series : Support simultaneous Read-while-Write operation in multiple
> 	       bank architecture. Read-while-write feature which means read
> 	       data one bank while another bank is programing or erasing.

AFAIK, this feature is not currently supported in SPI NOR.

> 
> MX25LM : 3.0V Octal I/O
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7841/MX25LM51245G,%203V,%20512Mb,%20v1.1.pdf
> 
> MX25UM : 1.8V Octal I/O
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7525/MX25UM51245G%20Extreme%20Speed,%201.8V,%20512Mb,%20v1.0.pdf
> 
> MX66LM : 3.0V Octal I/O with stacked die
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7929/MX66LM1G45G,%203V,%201Gb,%20v1.1.pdf
> 
> MX66UM : 1.8V Octal I/O with stacked die
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7721/MX66UM1G45G,%201.8V,%201Gb,%20v1.1.pdf
> 
> MX25LW : 3.0V Octal I/O with Read-while-Write
> MX25UW : 1.8V Octal I/O with Read-while-Write
> MX66LW : 3.0V Octal I/O with Read-while-Write and stack die
> MX66UW : 1.8V Octal I/O with Read-while-Write and stack die
> 
> About LW/UW series, please contact us freely if you have any
> questions. For adding Octal NOR Flash IDs, we have validated
> each Flash on plateform zynq-picozed.
> 
> Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 100 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 881eaf8..8c1cf1b 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -203,6 +203,106 @@ static void octaflash_post_sfdp_fixup(struct spi_nor *nor)
>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "mx66lm2g45g", INFO(0xc2853c, 0, 64 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66lm1g45g", INFO(0xc2853b, 0, 32 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66lw1g45g", INFO(0xc2863b, 0, 32 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25lm51245g", INFO(0xc2853a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25lw51245g", INFO(0xc2863a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25lm25645g", INFO(0xc28539, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25lw25645g", INFO(0xc28639, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66um2g45g", INFO(0xc2803c, 0, 64 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66uw2g345g", INFO(0xc2843c, 0, 64 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66uw2g345gx0", INFO(0xc2943c, 0, 64 * 1024, 4096,
> +				 SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +				 SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66um1g45g", INFO(0xc2803b, 0, 32 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66um1g45g40", INFO(0xc2808b, 0, 32 * 1024, 4096,
> +				SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +				SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66uw1g45g", INFO(0xc2813b, 0, 32 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25um51245g", INFO(0xc2803a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw51245g", INFO(0xc2813a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw51345g", INFO(0xc2843a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25um25645g", INFO(0xc28039, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw25645g", INFO(0xc28139, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25um25345g", INFO(0xc28339, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw25345g", INFO(0xc28439, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw12845g", INFO(0xc28138, 0, 4 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw12a45g", INFO(0xc28938, 0, 4 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw12345g", INFO(0xc28438, 0, 4 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw6445g", INFO(0xc28137, 0, 2 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw6345g", INFO(0xc28437, 0, 2 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },

Reminder to self: Check if there are any ID collisions here. I have seen 
a couple of them show up recently on Macronix flashes.

Anyway, not much to see here. I suggest you merge this with patch 1.

>  };
>  
>  static void macronix_default_init(struct spi_nor *nor)

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
