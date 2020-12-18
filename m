Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E762DE0E3
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 11:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgLRKVX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 05:21:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36940 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLRKVW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Dec 2020 05:21:22 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4BC251F46188;
        Fri, 18 Dec 2020 10:20:40 +0000 (GMT)
Date:   Fri, 18 Dec 2020 11:20:37 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>,
        <bbrezillon@kernel.org>, <p.yadav@ti.com>,
        <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 6/9] spi: tegra210-quad: Add support for hardware
 dummy cycles transfer
Message-ID: <20201218112037.4465598a@collabora.com>
In-Reply-To: <1608236927-28701-7-git-send-email-skomatineni@nvidia.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
        <1608236927-28701-7-git-send-email-skomatineni@nvidia.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 17 Dec 2020 12:28:44 -0800
Sowjanya Komatineni <skomatineni@nvidia.com> wrote:

> Tegra Quad SPI controller hardware supports sending dummy bytes based
> on programmed dummy clock cycles after the actual transfer bytes.
> 
> This patch adds this support of hardware dummy bytes transfer and
> skips transfer of dummy bytes from the software.
> 
> For dummy cycles more than Tegra Quad SPI hardware maximum dummy
> cycles limit, driver transfers dummy bytes from the software.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index e7bee8d..695a296 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -117,6 +117,7 @@
>  
>  #define QSPI_MISC_REG                           0x194
>  #define QSPI_NUM_DUMMY_CYCLE(x)			(((x) & 0xff) << 0)
> +#define QSPI_DUMMY_CYCLES_MAX			0xff
>  
>  #define DATA_DIR_TX				BIT(0)
>  #define DATA_DIR_RX				BIT(1)
> @@ -170,6 +171,7 @@ struct tegra_qspi {
>  	u32					def_command2_reg;
>  	u32					spi_cs_timing1;
>  	u32					spi_cs_timing2;
> +	u8					dummy_cycles;
>  
>  	struct completion			xfer_completion;
>  	struct spi_transfer			*curr_xfer;
> @@ -856,6 +858,8 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
>  
>  	tqspi->command1_reg = command1;
>  
> +	tegra_qspi_writel(tqspi, QSPI_NUM_DUMMY_CYCLE(tqspi->dummy_cycles), QSPI_MISC_REG);
> +
>  	ret = tegra_qspi_flush_fifos(tqspi, false);
>  	if (ret < 0)
>  		return ret;
> @@ -974,7 +978,8 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
>  {
>  	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
>  	struct spi_device *spi = msg->spi;
> -	struct spi_transfer *xfer;
> +	struct spi_transfer *xfer, *next_xfer;

next_after should be declared where it's actually used.

> +	bool use_hw_dummy_cycles = false;

I don't think you need this variable (see below).

>  	bool is_first_msg = true;
>  	int ret;
>  
> @@ -984,8 +989,42 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
>  	tqspi->rx_status = 0;
>  
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		u8 dummy_cycles = 0;

Should be declared where it's actually used, and you don't want it to be a u8
since you're checking that the result does not exceed 255 which will always
be true with a u8.

>  		u32 cmd1;
>  
> +		/*
> +		 * Skip dummy bytes transfer if they are transferred by the hardware along
> +		 * with previous transfer.
> +		 */
> +		if (xfer->dummy_data && use_hw_dummy_cycles) {
> +			msg->actual_length += xfer->len;
> +			continue;
> +		}
> +
> +		/*
> +		 * Tegra QSPI hardware supports dummy bytes transfer after actual transfer
> +		 * bytes based on programmed dummy clock cycles in the QSPI_MISC register.
> +		 * So, check if the next transfer is dummy data transfer and program dummy
> +		 * clock cycles along with the current transfer.
> +		 */
> +		if (!list_is_last(&xfer->transfer_list, &msg->transfers)) {
> +			next_xfer = list_next_entry(xfer, transfer_list);
> +			if (next_xfer && next_xfer->dummy_data) {
> +				dummy_cycles = next_xfer->len * 8 / next_xfer->tx_nbits;
> +				use_hw_dummy_cycles = true;
> +				/*
> +				 * Use software dummy bytes transfer if dummy cycles exceeds
> +				 * Tegra QSPI hardware maximum dummy cycles limit.
> +				 */
> +				if (dummy_cycles > QSPI_DUMMY_CYCLES_MAX) {
> +					use_hw_dummy_cycles = false;
> +					dummy_cycles = 0;
> +				}
> +			}
> +		}
> +
> +		tqspi->dummy_cycles = dummy_cycles;
> +

This can be simplified:

		/*
		 * Skip dummy bytes transfer if they were issued with the
		 * previous transfer.
		 */
		if (tqspi->dummy_cycles) {
			WARN_ON(!xfer->dummy_data);
			tqspi->dummy_cycles = 0;
		}

		/*
		 * Tegra QSPI hardware supports dummy bytes transfer after actual
		 * transfer bytes based on programmed dummy clock cycles in the
		 * QSPI_MISC register. So, check if the next transfer is dummy
		 * data transfer and program dummy clock cycles along with the
		 * current transfer.
		 */
		if (!list_is_last(&xfer->transfer_list, &msg->transfers)) {
			struct spi_transfer *next_xfer;

			next_xfer = list_next_entry(xfer, transfer_list);
			if (next_xfer->dummy_data) {
				u32 dummy_cycles = next_xfer->len * 8 /
						   next_xfer->tx_nbits;
				if (dummy_cycles <= QSPI_DUMMY_CYCLES_MAX)
					tqspi->dummy_cycles = dummy_cycles;
			}
		}


>  		reinit_completion(&tqspi->xfer_completion);
>  
>  		cmd1 = tegra_qspi_setup_transfer_one(spi, xfer, is_first_msg);

