Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3317E632
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 18:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgCIR7J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 13:59:09 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58955 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgCIR7J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 13:59:09 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4FA4B23EB3;
        Mon,  9 Mar 2020 18:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583776745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZ28TfUvwJ1itgNfROyuxzqF3oOBSx8iDyoQZE1QoIU=;
        b=sdce2DA9ReD8BSZfA8tQOnNqs8NpxR82clomsNdrrGSyLM+J9c7vox5+Y3zOxTeSYK+vLe
        QNrz6YmI35AUyqaUnhp/VMPC0K7WVmAczW0nSkVV3uY2/EIGNDM2C62FIHG4BRVq4eJvGn
        YQbl38FmlejEQ6G/cZYSFrL5tQYmPKI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 18:59:04 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, peng.ma@nxp.com
Subject: Re: [PATCH 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR
 CMD and TXDATA
In-Reply-To: <20200309145624.10026-3-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-3-olteanv@gmail.com>
Message-ID: <d8e39e402328b962cdbc25316a27eac8@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 4FA4B23EB3
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.386];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> In XSPI mode, the 32-bit PUSHR register can be written to separately:
> the higher 16 bits are for commands and the lower 16 bits are for data.
> 
> This has nicely been hacked around, by defining a second regmap with a
> width of 16 bits, and effectively splitting a 32-bit register into 2
> 16-bit ones, from the perspective of this regmap_pushr.
> 
> The problem is the assumption about the controller's endianness. If the
> controller is little endian (such as anything post-LS1046A), then the
> first 2 bytes, in the order imposed by memory layout, will actually 
> hold
> the TXDATA, and the last 2 bytes will hold the CMD.
> 
> So take the controller's endianness into account when performing split
> writes to PUSHR. The obvious and simple solution would have been to 
> call
> regmap_get_val_endian(), but that is an internal regmap function and we
> don't want to change regmap just for this. Therefore, we define the
> offsets per-instantiation, in the devtype_data structure. This means
> that we have to know from the driver which controllers are big- and
> which are little-endian (which is fine, we do, but it makes the device
> tree binding itself a little redundant except for regmap_config).
> 
> This patch does not apply cleanly to stable trees, and a punctual fix 
> to
> the commit cannot be provided given this constraint of lack of access 
> to
> regmap_get_val_endian(). The per-SoC devtype_data structures (and
> therefore the premises to fix this bug) have been introduced only a few
> commits ago, in commit d35054010b57 ("spi: spi-fsl-dspi: Use specific
> compatible strings for all SoC instantiations")
> 
> Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode 
> registers")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 0ce26c1cbf62..a8e56abe20ac 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -103,10 +103,6 @@
>  #define SPI_FRAME_BITS(bits)		SPI_CTAR_FMSZ((bits) - 1)
>  #define SPI_FRAME_EBITS(bits)		SPI_CTARE_FMSZE(((bits) - 1) >> 4)
> 
> -/* Register offsets for regmap_pushr */
> -#define PUSHR_CMD			0x0
> -#define PUSHR_TX			0x2
> -
>  #define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
> 
>  struct chip_data {
> @@ -124,6 +120,12 @@ struct fsl_dspi_devtype_data {
>  	u8			max_clock_factor;
>  	int			fifo_size;
>  	int			dma_bufsize;
> +	/*
> +	 * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
> +	 * individually (in XSPI mode)
> +	 */
> +	int			pushr_cmd;
> +	int			pushr_tx;
>  };

Shouldn't this just read the "little-endian" property of the
device tree node? Like it worked before with regmap, which takes
the little-endian/big-endian property into account.

If I understand this correctly, this solution would mix the methods
how the IP endianess is determined. Eg. regmap_xx uses the
little-endian property and this driver then also uses the compatible
string to also distinguish between the endianess.

-michael

>  enum {
> @@ -150,42 +152,56 @@ static const struct fsl_dspi_devtype_data
> devtype_data[] = {
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.pushr_cmd		= 0,
> +		.pushr_tx		= 2,
>  	},
>  	[LS1012A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.pushr_cmd		= 0,
> +		.pushr_tx		= 2,
>  	},
>  	[LS1043A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.pushr_cmd		= 0,
> +		.pushr_tx		= 2,
>  	},
>  	[LS1046A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.pushr_cmd		= 0,
> +		.pushr_tx		= 2,
>  	},
>  	[LS2080A] = {
>  		.trans_mode		= DSPI_DMA_MODE,
>  		.dma_bufsize		= 8,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.pushr_cmd		= 2,
> +		.pushr_tx		= 0,
>  	},
>  	[LS2085A] = {
>  		.trans_mode		= DSPI_DMA_MODE,
>  		.dma_bufsize		= 8,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.pushr_cmd		= 2,
> +		.pushr_tx		= 0,
>  	},
>  	[LX2160A] = {
>  		.trans_mode		= DSPI_DMA_MODE,
>  		.dma_bufsize		= 8,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.pushr_cmd		= 2,
> +		.pushr_tx		= 0,
>  	},
>  	[MCF5441X] = {
>  		.trans_mode		= DSPI_EOQ_MODE,
> @@ -670,12 +686,12 @@ static void dspi_pushr_cmd_write(struct fsl_dspi
> *dspi, u16 cmd)
>  	 */
>  	if (dspi->len > dspi->oper_word_size)
>  		cmd |= SPI_PUSHR_CMD_CONT;
> -	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
> +	regmap_write(dspi->regmap_pushr, dspi->devtype_data->pushr_cmd, cmd);
>  }
> 
>  static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
>  {
> -	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
> +	regmap_write(dspi->regmap_pushr, dspi->devtype_data->pushr_tx, 
> txdata);
>  }
> 
>  static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
