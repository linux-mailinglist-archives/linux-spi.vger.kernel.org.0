Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617BC3877A4
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbhERLaQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 07:30:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38570 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbhERLaP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 07:30:15 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 801F61F42F40;
        Tue, 18 May 2021 12:28:55 +0100 (BST)
Date:   Tue, 18 May 2021 13:28:50 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <patrice.chotard@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: [PATCH v3 2/3] mtd: spinand: use the spi-mem poll status APIs
Message-ID: <20210518132850.1558e46b@collabora.com>
In-Reply-To: <20210518093951.23136-3-patrice.chotard@foss.st.com>
References: <20210518093951.23136-1-patrice.chotard@foss.st.com>
        <20210518093951.23136-3-patrice.chotard@foss.st.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 May 2021 11:39:50 +0200
<patrice.chotard@foss.st.com> wrote:

> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Make use of spi-mem poll status APIs to let advanced controllers
> optimize wait operations.

This should also fix the high CPU usage you were reporting for those
that don't have a dedicated STATUS poll block logic, which is great!

> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
> Changes in v3:
>   - Add initial_delay_us and polling_delay_us parameters to spinand_wait()
>   - Add SPINAND_READ/WRITE/ERASE/RESET_INITIAL_DELAY_US and
>     SPINAND_READ/WRITE/ERASE/RESET_POLL_DELAY_US defines.
> 
> Changes in v2:
>   - non-offload case is now managed by spi_mem_poll_status()
> 
>  drivers/mtd/nand/spi/core.c | 45 ++++++++++++++++++++++++++-----------
>  include/linux/mtd/spinand.h | 11 ++++++++-
>  2 files changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 17f63f95f4a2..ef2a692ab5b6 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -473,20 +473,26 @@ static int spinand_erase_op(struct spinand_device *spinand,
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
>  
> -static int spinand_wait(struct spinand_device *spinand, u8 *s)
> +static int spinand_wait(struct spinand_device *spinand,
> +			unsigned long initial_delay_us,
> +			unsigned long poll_delay_us,
> +			u8 *s)
>  {
> -	unsigned long timeo =  jiffies + msecs_to_jiffies(400);
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(REG_STATUS,
> +						      spinand->scratchbuf);
>  	u8 status;
>  	int ret;
>  
> -	do {
> -		ret = spinand_read_status(spinand, &status);
> -		if (ret)
> -			return ret;
> +	ret = spi_mem_poll_status(spinand->spimem, &op, STATUS_BUSY, 0,
> +				  initial_delay_us,
> +				  poll_delay_us,
> +				  SPINAND_STATUS_TIMEOUT_MS);
> +	if (ret)
> +		return ret;
>  
> -		if (!(status & STATUS_BUSY))
> -			goto out;
> -	} while (time_before(jiffies, timeo));
> +	status = *spinand->scratchbuf;
> +	if (!(status & STATUS_BUSY))
> +		goto out;
>  
>  	/*
>  	 * Extra read, just in case the STATUS_READY bit has changed
> @@ -526,7 +532,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
>  	if (ret)
>  		return ret;
>  
> -	return spinand_wait(spinand, NULL);
> +	return spinand_wait(spinand,
> +			    SPINAND_RESET_INITIAL_DELAY_US,
> +			    SPINAND_RESET_POLL_DELAY_US,
> +			    NULL);
>  }
>  
>  static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
> @@ -549,7 +558,10 @@ static int spinand_read_page(struct spinand_device *spinand,
>  	if (ret)
>  		return ret;
>  
> -	ret = spinand_wait(spinand, &status);
> +	ret = spinand_wait(spinand,
> +			   SPINAND_READ_INITIAL_DELAY_US,
> +			   SPINAND_READ_POLL_DELAY_US,
> +			   &status);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -585,7 +597,10 @@ static int spinand_write_page(struct spinand_device *spinand,
>  	if (ret)
>  		return ret;
>  
> -	ret = spinand_wait(spinand, &status);
> +	ret = spinand_wait(spinand,
> +			   SPINAND_WRITE_INITIAL_DELAY_US,
> +			   SPINAND_WRITE_POLL_DELAY_US,
> +			   &status);
>  	if (!ret && (status & STATUS_PROG_FAILED))
>  		return -EIO;
>  
> @@ -768,7 +783,11 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
>  	if (ret)
>  		return ret;
>  
> -	ret = spinand_wait(spinand, &status);
> +	ret = spinand_wait(spinand,
> +			   SPINAND_ERASE_INITIAL_DELAY_US,
> +			   SPINAND_ERASE_POLL_DELAY_US,
> +			   &status);
> +
>  	if (!ret && (status & STATUS_ERASE_FAILED))
>  		ret = -EIO;
>  
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6bb92f26833e..180c1fa64e62 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -169,7 +169,16 @@
>  struct spinand_op;
>  struct spinand_device;
>  
> -#define SPINAND_MAX_ID_LEN	4
> +#define SPINAND_MAX_ID_LEN		4
> +#define SPINAND_READ_INITIAL_DELAY_US	6
> +#define SPINAND_READ_POLL_DELAY_US	5
> +#define SPINAND_RESET_INITIAL_DELAY_US	5
> +#define SPINAND_RESET_POLL_DELAY_US	5
> +#define SPINAND_WRITE_INITIAL_DELAY_US	75
> +#define SPINAND_WRITE_POLL_DELAY_US	15
> +#define SPINAND_ERASE_INITIAL_DELAY_US	250
> +#define SPINAND_ERASE_POLL_DELAY_US	50

Could you add a comment explaining where those numbers come from?

> +#define SPINAND_STATUS_TIMEOUT_MS	400

I would name that one SPINAND_WAITRDY_TIMEOUT_MS.

>  
>  /**
>   * struct spinand_id - SPI NAND id structure

