Return-Path: <linux-spi+bounces-12476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E8BD391C3
	for <lists+linux-spi@lfdr.de>; Sun, 18 Jan 2026 00:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FFD730049C0
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A30129DB6C;
	Sat, 17 Jan 2026 23:49:31 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA91197A7D;
	Sat, 17 Jan 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768693770; cv=none; b=IgF/0L4bo9rElw/g7GVAvHnem6gNUlPKKqq+apDiPwz6Mky9L7cvxvqr9/a7FOkDA0eJwm8ppCLa8kRPemOWWSMuSi1OEQaygxTG/NWJN8fx6rVMIZqMh9scSOCzfVjV6NGNlSbU3LHPDsGlXLDFHy19qKUsq+esb66IC2Uj6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768693770; c=relaxed/simple;
	bh=0Z7wiX3R+xK4oDhhpobpaaCvU7KgWb8HkcyhE5A2nRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FYnM8eyiCfF4ymMhIBxcdo7mIGzN7oBBkD1h9GKO4rOP5GTYK3NeDbFEDdUu+W1ho0vUVNquFhLGptMlT8CjgpUtd7HPS5LLSgmrD3Kz+c9npsJ0QRMyqki2whDtRyKN5F0FDUu3kvAdZie6w27oZD8jd6g701fpolDGlj+D8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.57.151] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 508CD4C4430071;
	Sun, 18 Jan 2026 00:48:40 +0100 (CET)
Message-ID: <3153512e-8325-4d0b-a869-a2a5062abefd@molgen.mpg.de>
Date: Sun, 18 Jan 2026 00:48:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: aspeed: Add support for non-spi-mem devices
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
References: <20260117134216.595436-1-chin-ting_kuo@aspeedtech.com>
 <20260117134216.595436-3-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: clg@kaod.org, broonie@kernel.org, boris.brezillon@bootlin.com,
 joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com
In-Reply-To: <20260117134216.595436-3-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chin-Ting,


Thank you for your patch.

Am 17.01.26 um 14:42 schrieb Chin-Ting Kuo:
> The ASPEED FMC/SPI controller may be shared by spi-mem devices and
> other SPI peripherals that do not use the spi-mem framework.
> 
> The driver currently assumes spi-mem semantics for all devices,
> while the controller also supports direct user mode access commonly
> used by non-spi-mem devices. This mismatch can result in incorrect
> behavior when different types of devices share the same controller.
> 
> Update the driver to properly handle non-spi-mem devices, allowing
> them to operate correctly in pure user mode alongside spi-mem
> devices on a shared SPI controller.

It’d be great if you added a paragraph on how the driver ist updated.

Also, documented on how to test your change, would be great.

> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>   drivers/spi/spi-aspeed-smc.c | 134 +++++++++++++++++++++++++++++++++--
>   1 file changed, 128 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index db3e096f2eb0..3949f94b6667 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -48,6 +48,8 @@
>   /* CEx Address Decoding Range Register */
>   #define CE0_SEGMENT_ADDR_REG		0x30
>   
> +#define FULL_DUPLEX_RX_DATA		0x1e4
> +
>   /* CEx Read timing compensation register */
>   #define CE0_TIMING_COMPENSATION_REG	0x94
>   
> @@ -81,6 +83,7 @@ struct aspeed_spi_data {
>   	u32	hclk_mask;
>   	u32	hdiv_max;
>   	u32	min_window_size;
> +	bool	full_duplex;
>   
>   	phys_addr_t (*segment_start)(struct aspeed_spi *aspi, u32 reg);
>   	phys_addr_t (*segment_end)(struct aspeed_spi *aspi, u32 reg);
> @@ -105,6 +108,7 @@ struct aspeed_spi {
>   
>   	struct clk		*clk;
>   	u32			 clk_freq;
> +	u8			 cs_change;
>   
>   	struct aspeed_spi_chip	 chips[ASPEED_SPI_MAX_NUM_CS];
>   };
> @@ -280,7 +284,8 @@ static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
>   }
>   
>   /* support for 1-1-1, 1-1-2 or 1-1-4 */
> -static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +static bool aspeed_spi_supports_mem_op(struct spi_mem *mem,
> +				       const struct spi_mem_op *op)
>   {
>   	if (op->cmd.buswidth > 1)
>   		return false;
> @@ -305,7 +310,8 @@ static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op
>   
>   static const struct aspeed_spi_data ast2400_spi_data;
>   
> -static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +static int do_aspeed_spi_exec_mem_op(struct spi_mem *mem,
> +				     const struct spi_mem_op *op)
>   {
>   	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->controller);
>   	struct aspeed_spi_chip *chip = &aspi->chips[spi_get_chipselect(mem->spi, 0)];
> @@ -367,11 +373,12 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
>   	return ret;
>   }
>   
> -static int aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +static int aspeed_spi_exec_mem_op(struct spi_mem *mem,
> +				  const struct spi_mem_op *op)
>   {
>   	int ret;
>   
> -	ret = do_aspeed_spi_exec_op(mem, op);
> +	ret = do_aspeed_spi_exec_mem_op(mem, op);
>   	if (ret)
>   		dev_err(&mem->spi->dev, "operation failed: %d\n", ret);
>   	return ret;
> @@ -773,8 +780,8 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
>   }
>   
>   static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
> -	.supports_op = aspeed_spi_supports_op,
> -	.exec_op = aspeed_spi_exec_op,
> +	.supports_op = aspeed_spi_supports_mem_op,
> +	.exec_op = aspeed_spi_exec_mem_op,
>   	.get_name = aspeed_spi_get_name,
>   	.dirmap_create = aspeed_spi_dirmap_create,
>   	.dirmap_read = aspeed_spi_dirmap_read,
> @@ -843,6 +850,110 @@ static void aspeed_spi_enable(struct aspeed_spi *aspi, bool enable)
>   		aspeed_spi_chip_enable(aspi, cs, enable);
>   }
>   
> +static int aspeed_spi_user_prepare_msg(struct spi_controller *ctlr,
> +				       struct spi_message *msg)
> +{
> +	struct aspeed_spi *aspi =
> +		(struct aspeed_spi *)spi_controller_get_devdata(ctlr);
> +	const struct aspeed_spi_data *data = aspi->data;
> +	struct spi_device *spi = msg->spi;
> +	u32 cs = spi_get_chipselect(spi, 0);
> +	struct aspeed_spi_chip *chip = &aspi->chips[cs];
> +	u32 ctrl_val;
> +	u32 clk_div = data->get_clk_div(chip, spi->max_speed_hz);
> +
> +	ctrl_val = chip->ctl_val[ASPEED_SPI_BASE];
> +	ctrl_val &= ~CTRL_IO_MODE_MASK & data->hclk_mask;
> +	ctrl_val |= clk_div;
> +	chip->ctl_val[ASPEED_SPI_BASE] = ctrl_val;
> +
> +	if (aspi->cs_change == 0)
> +		aspeed_spi_start_user(chip);
> +
> +	return 0;
> +}
> +
> +static int aspeed_spi_user_unprepare_msg(struct spi_controller *ctlr,
> +					 struct spi_message *msg)
> +{
> +	struct aspeed_spi *aspi =
> +		(struct aspeed_spi *)spi_controller_get_devdata(ctlr);
> +	struct spi_device *spi = msg->spi;
> +	u32 cs = spi_get_chipselect(spi, 0);
> +	struct aspeed_spi_chip *chip = &aspi->chips[cs];
> +
> +	if (aspi->cs_change == 0)
> +		aspeed_spi_stop_user(chip);
> +
> +	return 0;
> +}
> +
> +static void aspeed_spi_user_transfer_tx(struct aspeed_spi *aspi,
> +					struct spi_device *spi,
> +					const u8 *tx_buf, u8 *rx_buf,
> +					void *dst, u32 len)
> +{
> +	const struct aspeed_spi_data *data = aspi->data;
> +	bool full_duplex_transfer = data->full_duplex && tx_buf == rx_buf;
> +	u32 i;
> +
> +	if (full_duplex_transfer &&
> +	    !!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD |
> +			    SPI_RX_DUAL | SPI_RX_QUAD))) {
> +		dev_err(aspi->dev,
> +			"full duplex is only supported for single IO mode\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		writeb(tx_buf[i], dst);
> +		if (full_duplex_transfer)
> +			rx_buf[i] = readb(aspi->regs + FULL_DUPLEX_RX_DATA);
> +	}
> +}
> +
> +static int aspeed_spi_user_transfer(struct spi_controller *ctlr,
> +				    struct spi_device *spi,
> +				    struct spi_transfer *xfer)
> +{
> +	struct aspeed_spi *aspi =
> +		(struct aspeed_spi *)spi_controller_get_devdata(ctlr);
> +	u32 cs = spi_get_chipselect(spi, 0);
> +	struct aspeed_spi_chip *chip = &aspi->chips[cs];
> +	void __iomem *ahb_base = aspi->chips[cs].ahb_base;
> +	const u8 *tx_buf = xfer->tx_buf;
> +	u8 *rx_buf = xfer->rx_buf;
> +
> +	dev_dbg(aspi->dev,
> +		"[cs%d] xfer: width %d, len %u, tx %p, rx %p\n",
> +		cs, xfer->bits_per_word, xfer->len,
> +		tx_buf, rx_buf);
> +
> +	if (tx_buf) {
> +		if (spi->mode & SPI_TX_DUAL)
> +			aspeed_spi_set_io_mode(chip, CTRL_IO_DUAL_DATA);
> +		else if (spi->mode & SPI_TX_QUAD)
> +			aspeed_spi_set_io_mode(chip, CTRL_IO_QUAD_DATA);
> +
> +		aspeed_spi_user_transfer_tx(aspi, spi, tx_buf, rx_buf,
> +					    (void *)ahb_base, xfer->len);
> +	}
> +
> +	if (rx_buf && rx_buf != tx_buf) {
> +		if (spi->mode & SPI_RX_DUAL)
> +			aspeed_spi_set_io_mode(chip, CTRL_IO_DUAL_DATA);
> +		else if (spi->mode & SPI_RX_QUAD)
> +			aspeed_spi_set_io_mode(chip, CTRL_IO_QUAD_DATA);

Should other modes be handled?

> +
> +		ioread8_rep(ahb_base, rx_buf, xfer->len);
> +	}
> +
> +	xfer->error = 0;
> +	aspi->cs_change = xfer->cs_change;
> +
> +	return 0;
> +}
> +
>   static int aspeed_spi_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -899,6 +1010,9 @@ static int aspeed_spi_probe(struct platform_device *pdev)
>   	ctlr->cleanup = aspeed_spi_cleanup;
>   	ctlr->num_chipselect = of_get_available_child_count(dev->of_node);
>   	ctlr->dev.of_node = dev->of_node;
> +	ctlr->prepare_message = aspeed_spi_user_prepare_msg;
> +	ctlr->unprepare_message = aspeed_spi_user_unprepare_msg;
> +	ctlr->transfer_one = aspeed_spi_user_transfer;
>   
>   	aspi->num_cs = ctlr->num_chipselect;
>   
> @@ -1455,6 +1569,7 @@ static const struct aspeed_spi_data ast2400_fmc_data = {
>   	.hclk_mask     = 0xfffff0ff,
>   	.hdiv_max      = 1,
>   	.min_window_size = 0x800000,
> +	.full_duplex   = false,
>   	.calibrate     = aspeed_spi_calibrate,
>   	.get_clk_div   = aspeed_get_clk_div_ast2400,
>   	.segment_start = aspeed_spi_segment_start,
> @@ -1471,6 +1586,7 @@ static const struct aspeed_spi_data ast2400_spi_data = {
>   	.timing	       = 0x14,
>   	.hclk_mask     = 0xfffff0ff,
>   	.hdiv_max      = 1,
> +	.full_duplex   = false,
>   	.get_clk_div   = aspeed_get_clk_div_ast2400,
>   	.calibrate     = aspeed_spi_calibrate,
>   	/* No segment registers */
> @@ -1485,6 +1601,7 @@ static const struct aspeed_spi_data ast2500_fmc_data = {
>   	.hclk_mask     = 0xffffd0ff,
>   	.hdiv_max      = 1,
>   	.min_window_size = 0x800000,
> +	.full_duplex   = false,
>   	.get_clk_div   = aspeed_get_clk_div_ast2500,
>   	.calibrate     = aspeed_spi_calibrate,
>   	.segment_start = aspeed_spi_segment_start,
> @@ -1502,6 +1619,7 @@ static const struct aspeed_spi_data ast2500_spi_data = {
>   	.hclk_mask     = 0xffffd0ff,
>   	.hdiv_max      = 1,
>   	.min_window_size = 0x800000,
> +	.full_duplex   = false,
>   	.get_clk_div   = aspeed_get_clk_div_ast2500,
>   	.calibrate     = aspeed_spi_calibrate,
>   	.segment_start = aspeed_spi_segment_start,
> @@ -1520,6 +1638,7 @@ static const struct aspeed_spi_data ast2600_fmc_data = {
>   	.hclk_mask     = 0xf0fff0ff,
>   	.hdiv_max      = 2,
>   	.min_window_size = 0x200000,
> +	.full_duplex   = false,
>   	.get_clk_div   = aspeed_get_clk_div_ast2600,
>   	.calibrate     = aspeed_spi_ast2600_calibrate,
>   	.segment_start = aspeed_spi_segment_ast2600_start,
> @@ -1538,6 +1657,7 @@ static const struct aspeed_spi_data ast2600_spi_data = {
>   	.hclk_mask     = 0xf0fff0ff,
>   	.hdiv_max      = 2,
>   	.min_window_size = 0x200000,
> +	.full_duplex   = false,
>   	.get_clk_div   = aspeed_get_clk_div_ast2600,
>   	.calibrate     = aspeed_spi_ast2600_calibrate,
>   	.segment_start = aspeed_spi_segment_ast2600_start,
> @@ -1556,6 +1676,7 @@ static const struct aspeed_spi_data ast2700_fmc_data = {
>   	.hclk_mask     = 0xf0fff0ff,
>   	.hdiv_max      = 2,
>   	.min_window_size = 0x10000,
> +	.full_duplex   = true,
>   	.get_clk_div   = aspeed_get_clk_div_ast2600,
>   	.calibrate     = aspeed_spi_ast2600_calibrate,
>   	.segment_start = aspeed_spi_segment_ast2700_start,
> @@ -1573,6 +1694,7 @@ static const struct aspeed_spi_data ast2700_spi_data = {
>   	.hclk_mask     = 0xf0fff0ff,
>   	.hdiv_max      = 2,
>   	.min_window_size = 0x10000,
> +	.full_duplex   = true,
>   	.get_clk_div   = aspeed_get_clk_div_ast2600,
>   	.calibrate     = aspeed_spi_ast2600_calibrate,
>   	.segment_start = aspeed_spi_segment_ast2700_start,


Kind regards,

Paul

