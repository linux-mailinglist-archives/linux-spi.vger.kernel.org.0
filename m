Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE13E2F7F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhHFSyn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 14:54:43 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:37163 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhHFSyn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 14:54:43 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 33ABB100004;
        Fri,  6 Aug 2021 18:54:24 +0000 (UTC)
Date:   Fri, 6 Aug 2021 20:54:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 06/13] mtd: spinand: Add macros for Octal DTR page read
 and write operations
Message-ID: <20210806205424.51511388@xps13>
In-Reply-To: <20210713130538.646-7-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-7-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:31
+0000:

> Define new PAGE_READ_FROM_CACHE and PROG_LOAD op templates for Octal
> DTR SPI mode. These templates would used in op_variants and

                                will be

> op_templates for defining Octal DTR read from cache and write to
> cache operations.
> 
> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  include/linux/mtd/spinand.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index ebb19b2cec84..35816b8cfe81 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -122,6 +122,12 @@
>  		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
>  		   SPI_MEM_OP_DATA_IN(len, buf, 4))
>  
> +#define SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(addr, ndummy, buf, len) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x9d9d, 8),			\
> +		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
> +		   SPI_MEM_OP_DUMMY_DTR(ndummy, 8),			\
> +		   SPI_MEM_OP_DATA_IN_DTR(len, buf, 8))
> +
>  #define SPINAND_PROG_EXEC_OP(addr)					\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x10, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
> @@ -140,6 +146,12 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
>  
> +#define SPINAND_PROG_LOAD_OCTALIO_DTR(reset, addr, buf, len)		\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, reset ? 0x0202 : 0x8484, 8),	\
> +		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT_DTR(len, buf, 8))
> +
>  #define SPINAND_PROTO_BUSWIDTH_MASK	GENMASK(6, 0)
>  #define SPINAND_PROTO_DTR_BIT		BIT(7)
>  

Thanks,
Miquèl
