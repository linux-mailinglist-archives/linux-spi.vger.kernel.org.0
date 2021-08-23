Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8803F4639
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 09:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhHWH60 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Aug 2021 03:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhHWH6Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Aug 2021 03:58:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82EAC061575;
        Mon, 23 Aug 2021 00:57:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CAB921F424B6;
        Mon, 23 Aug 2021 08:57:41 +0100 (BST)
Date:   Mon, 23 Aug 2021 09:57:38 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 01/13] spi: spi-mem: Add DTR templates for cmd, address,
 dummy and data phase
Message-ID: <20210823095738.297d33e9@collabora.com>
In-Reply-To: <20210713130538.646-2-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-2-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 13 Jul 2021 13:05:26 +0000
Apurva Nandan <a-nandan@ti.com> wrote:

> Setting dtr field of spi_mem_op is useful when creating templates
> for DTR ops in spinand.h. Also, 2 bytes cmd phases are required when
> operating in Octal DTR SPI mode.
> 
> Create new templates for dtr mode cmd, address, dummy and data phase
> in spi_mem_op, which set the dtr field to 1 and also allow passing
> the nbytes for the cmd phase.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  include/linux/spi/spi-mem.h | 87 ++++++++++++++++++++++++++-----------
>  1 file changed, 61 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 85e2ff7b840d..73e52a3ecf66 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -13,46 +13,81 @@
>  
>  #include <linux/spi/spi.h>
>  
> -#define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
> -	{							\
> -		.buswidth = __buswidth,				\
> -		.opcode = __opcode,				\
> -		.nbytes = 1,					\
> +#define SPI_MEM_OP_CMD_ALL_ARGS(__nbytes, __opcode, __buswidth, __dtr)	\
> +	{								\
> +		.buswidth = __buswidth,					\
> +		.opcode = __opcode,					\
> +		.nbytes = __nbytes,					\
> +		.dtr = __dtr,						\
>  	}
>  
> -#define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
> -	{							\
> -		.nbytes = __nbytes,				\
> -		.val = __val,					\
> -		.buswidth = __buswidth,				\
> +#define SPI_MEM_OP_CMD(__opcode, __buswidth)				\
> +	SPI_MEM_OP_CMD_ALL_ARGS(1, __opcode, __buswidth, 0)
> +
> +#define SPI_MEM_OP_CMD_DTR(__nbytes, __opcode, __buswidth)		\
> +	SPI_MEM_OP_CMD_ALL_ARGS(__nbytes, __opcode, __buswidth, 1)

I don't see the benefit of those ALL_ARGS() macros compared to the
definition of the _DTR() variants using raw struct initializers, but if
you think we will add more optional args and really care about saving a
few lines of code, maybe it'd be better to have something like:

#define SPI_MEM_OP_DTR .dtr = true
#define SPI_MEM_OP_CMD_BYTES(val) .nbytes = val

#define SPI_MEM_OP_EXT_CMD(__opcode, __buswidth, ...) \
	{ \
		.buswidth = __buswidth, \
		.opcode = __opcode, \
		__VA_ARGS__, \
	}

#define SPI_MEM_OP_CMD(__opcode, __buswidth) \
	SPI_MEM_OP_EXT_CMD(__opcode, __buswidth, \
			   SPI_MEM_OP_CMD_BYTES(1))

#define SPI_MEM_OP_CMD_DTR(__nbytes, __opcode, __buswidth) \
	SPI_MEM_OP_EXT_CMD(__opcode, __buswidth, \
			   SPI_MEM_OP_CMD_BYTES(__nbytes), \
			   SPI_MEM_OP_DTR)

so you don't have to patch all users every time you add an argument.
