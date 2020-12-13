Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E222D8CA0
	for <lists+linux-spi@lfdr.de>; Sun, 13 Dec 2020 11:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393178AbgLMKPx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Dec 2020 05:15:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55460 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394256AbgLMKPr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Dec 2020 05:15:47 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 530CA1F44A61;
        Sun, 13 Dec 2020 10:15:00 +0000 (GMT)
Date:   Sun, 13 Dec 2020 11:14:56 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>,
        <bbrezillon@kernel.org>, <p.yadav@ti.com>,
        <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] spi: tegra210-quad: Add support for hardware
 dummy cycles
Message-ID: <20201213111456.4485a0b6@collabora.com>
In-Reply-To: <1607721363-8879-7-git-send-email-skomatineni@nvidia.com>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
        <1607721363-8879-7-git-send-email-skomatineni@nvidia.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 11 Dec 2020 13:16:00 -0800
Sowjanya Komatineni <skomatineni@nvidia.com> wrote:

> Tegra Quad SPI controller hardware supports sending dummy cycles
> after address bytes.
> 
> This patch adds this support.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index 624f395..1d1b125 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -124,6 +124,13 @@
>  #define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
>  #define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
>  
> +enum transfer_phase {
> +	CMD_BYTE_XFER = 0,
> +	ADDR_BYTES_XFER,
> +	DATA_BYTES_XFER,
> +	MAX_XFERS,
> +};
> +
>  struct tegra_qspi_client_data {
>  	int tx_clk_tap_delay;
>  	int rx_clk_tap_delay;
> @@ -857,6 +864,8 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
>  
>  	tqspi->command1_reg = command1;
>  
> +	tegra_qspi_writel(tqspi, QSPI_NUM_DUMMY_CYCLE(tqspi->dummy_cycles), QSPI_MISC_REG);
> +
>  	ret = tegra_qspi_flush_fifos(tqspi, false);
>  	if (ret < 0)
>  		return ret;
> @@ -977,7 +986,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
>  	struct spi_device *spi = msg->spi;
>  	struct spi_transfer *xfer;
>  	bool is_first_msg = true;
> -	int ret;
> +	int ret, xfer_phase = 0;
>  
>  	msg->status = 0;
>  	msg->actual_length = 0;
> @@ -987,6 +996,15 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>  		u32 cmd1;
>  
> +		/*
> +		 * Program dummy clock cycles in Tegra QSPI register only
> +		 * during address transfer phase.
> +		 */
> +		if (xfer_phase == ADDR_BYTES_XFER)
> +			tqspi->dummy_cycles = msg->dummy_cycles;
> +		else
> +			tqspi->dummy_cycles = 0;

That's fragile. You're trying to guess the phase (which is clearly a
spi-mem concept) from the position of the transfer in the list. What
happens if a spi-mem operation has no address bytes but requires dummy
cycles after the command? What happens if we patch spi_mem_exec_op() to
merge the cmd and address bytes in a single transfer (that's an option
I considered at some point when designing the framework before deciding
it was not worth the extra complexity)?

Besides, I keep thinking the regular transfer path should not assume
it's being passed spi-mem operations, if it is, that means you should
overload the default exec_op(). The more I look at it the less I like
this idea of adding a dummy_cycles field to spi_message. I'm pretty
sure we can find other ways to avoid code duplication if that's your
main concern.

> +
>  		reinit_completion(&tqspi->xfer_completion);
>  
>  		cmd1 = tegra_qspi_setup_transfer_one(spi, xfer, is_first_msg);
> @@ -1018,6 +1036,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
>  		}
>  
>  		msg->actual_length += xfer->len;
> +		xfer_phase++;
>  
>  complete_xfer:
>  		if (ret < 0) {
> @@ -1203,6 +1222,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
>  	master->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_CS_HIGH |
>  			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
>  	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
> +	master->flags = SPI_MASTER_USES_HW_DUMMY_CYCLES;
>  	master->setup = tegra_qspi_setup;
>  	master->cleanup = tegra_qspi_cleanup;
>  	master->transfer_one_message = tegra_qspi_transfer_one_message;

