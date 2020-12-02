Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4492CC66B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 20:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgLBTR7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 14:17:59 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13074 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbgLBTR7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Dec 2020 14:17:59 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc7e83e0002>; Wed, 02 Dec 2020 11:17:18 -0800
Received: from [10.2.49.229] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 19:17:15 +0000
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
To:     Mark Brown <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201202172721.GL5560@sirena.org.uk>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
Date:   Wed, 2 Dec 2020 11:17:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202172721.GL5560@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606936638; bh=WxjuF6/0q6bMF0ahkwQtf8yN1d+vSadpAXD3GqI7mCQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=ZTLq8A0hyE6SJJKwNDLRvstQX9AamUhnqvvZOIWxdzH8s68Yh+x7dKVaILd5DuuqC
         QcTYtZbYRiSRYwUKrRdsuEswc2j02dLGnGjO6fVcKf87T5gJK+SNdqHsJSs9EHokH3
         PqZhzHEkTyac25O1OdVz6YMnZcxHyvq1ZJvjwnEspg5ZvTsu5DcHA+hgnzveTlYyDh
         XRFMfbB+Xgxw59GtvmaQbzjMXadIdkHyAQSS98gAfieDOj2oOfIjSsuQOigGt8eknZ
         cYSWym2HlP6tcO28DYNtM1HJtWkq9N1lT3NcUuPVs9/RAdSWa/Enx3wnFNMNDej5KL
         oS9jSWBY1keqA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/2/20 9:27 AM, Mark Brown wrote:
> On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
>> Tegra SoC has a Quad SPI controller starting from Tegra210.
>>
>> This patch adds support for Tegra210 QSPI controller.
> This looks pretty clean but I've got a few questions below about how
> this integrates with the frameworks as well as some more minor issues.
>
>> +config QSPI_TEGRA
>> +	tristate "Nvidia Tegra QSPI Controller"
> Everything else in this file is SPI_, even the qspi controllers.
Will rename in v2
>> +++ b/drivers/spi/qspi-tegra.c
>> @@ -0,0 +1,1418 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2020 NVIDIA CORPORATION.  All rights reserved.
>> + */
> Please make the entire comment a C++ one.  It also appears that the "All
> rights reserved" here conflicts with the GPL-2.0-only SPDX statement...
Will fix in v2
>
>> +static void
>> +tegra_qspi_copy_client_txbuf_to_qspi_txbuf(struct tegra_qspi_data *tqspi,
>> +					   struct spi_transfer *t)
>> +{
>> +	/* Make the dma buffer to read by cpu */
>> +	dma_sync_single_for_cpu(tqspi->dev, tqspi->tx_dma_phys,
>> +				tqspi->dma_buf_size, DMA_TO_DEVICE);
>> +
>> +	if (tqspi->is_packed) {
>> +		unsigned int len = tqspi->curr_dma_words *
>> +				   tqspi->bytes_per_word;
>> +
>> +		memcpy(tqspi->tx_dma_buf, t->tx_buf + tqspi->cur_pos, len);
>> +		tqspi->cur_tx_pos += tqspi->curr_dma_words *
>> +				     tqspi->bytes_per_word;
> It seems weird that this device needs us to do a memcpy() to do DMA,
> most devices are able to DMA directly from the buffers provided by the
> SPI API (and let the SPI core sync things).  What is going on here?

For transfers of size more than max DMA transfer limit, data transfer 
happens in multiple iterations with each iteration transferring up to 
max DMA transfer limit.

So using separate dma buffers and on every iteration copying them to SPI 
core provided tx/rx buffers.

Transferring data logic in this driver is similar as Tegra SPI driver 
except register changes and some QSPI specific register programming.

>
>> +	tegra_qspi_writel(tqspi, status, QSPI_FIFO_STATUS);
>> +	while ((status & QSPI_FIFO_EMPTY) != QSPI_FIFO_EMPTY) {
>> +		status = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
>> +		if (time_after(jiffies, timeout)) {
>> +			dev_err(tqspi->dev,
>> +				"timeout waiting for fifo flush\n");
>> +			return -EIO;
>> +		}
>> +
>> +		udelay(1);
>> +	}
> It'd be good to put a cpu_relax() in the busy loop.
Will update in v2.
>
>> +static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi,
>> +					 struct spi_transfer *t,
>> +					 bool is_first_of_msg)
>> +{
>> +		/* toggle cs to active state */
>> +		if (spi->mode & SPI_CS_HIGH)
>> +			command1 |= QSPI_CS_SW_VAL;
>> +		else
>> +			command1 &= ~QSPI_CS_SW_VAL;
>> +		tegra_qspi_writel(tqspi, command1, QSPI_COMMAND1);
> This is worrying, the client device might be confused if /CS is doing
> things outside of the standard handling.

Do you mean to honor spi_transfer cs_change flag?

Tegra QSPI is master and is used only with QSPI flash devices. Looking 
at SPI NOR driver, I see QSPI Flash commands are executed with one flash 
command per spi_message and I dont see cs_change flag usage w.r.t QSPI 
flash. So, using SW based CS control for QSPI.

Please correct me if I miss something to understand here.

Also Tegra186 and later QSPI controller supports combined sequence mode 
where command, address, data phases can be combined in a single GO.

This saves some cycles in transfer and for this we need to use SW based 
CS control only.


>> +	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
>> +			     &cdata->tx_clk_tap_delay);
>> +	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
>> +			     &cdata->rx_clk_tap_delay);
> These properties are not mentioned in the binding document.
Thanks Mark. Missed them. Will add in v2.
>
>> +static int tegra_qspi_setup(struct spi_device *spi)
>> +{
>> +	if (cdata && cdata->tx_clk_tap_delay)
>> +		tx_tap = cdata->tx_clk_tap_delay;
>> +	if (cdata && cdata->rx_clk_tap_delay)
>> +		rx_tap = cdata->rx_clk_tap_delay;
>> +	tqspi->def_command2_reg = QSPI_TX_TAP_DELAY(tx_tap) |
>> +				  QSPI_RX_TAP_DELAY(rx_tap);
>> +	tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMAND2);
> The setup for one device shouldn't be able to affect the operation of
> another, already running, device so either these need to be configured
> as part of the controller probe or these configurations need to be
> deferred until we're actually doing a transfer.
We will only have 1 device on QSPI as we only support single chip select.
>
>> +	/*
>> +	 * Tegra QSPI hardware support dummy bytes transfer based on the
>> +	 * programmed dummy clock cyles in QSPI register.
>> +	 * So, get the total dummy bytes from the dummy bytes transfer in
>> +	 * spi_messages and convert to dummy clock cyles.
>> +	 */
>> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>> +		if (ntransfers == DUMMY_BYTES_XFER &&
>> +		    !(list_is_last(&xfer->transfer_list, &msg->transfers)))
>> +			dummy_cycles = xfer->len * 8 / xfer->tx_nbits;
>> +		ntransfers++;
>> +	}
> This seems weird, there's some hard coded assumption about particular
> patterns that the client device is going to send.  What's going on here?
> I don't really understand what this is trying to do.

QSPI flash needs dummy cycles for data read operation which is actually 
the initial read latency and no. of dummy cycles required are vendor 
specific.

SPI NOR driver gets required dummy cycles based on mode clock cycles and 
wait state clock cycles.

During read operations, spi_nor_spimem_read_data() converts dummy cycles 
to number of dummy bytes.

Tegra QSPI controller supports dummy clock cycles register and when 
programmed QSPI controller sends dummy bytes rather than SW handling 
extra cycles for transferring dummy bytes.

Above equation converts this dummy bytes back to dummy clock cycles to 
program into QSPI register and avoid manual SW transfer of dummy bytes.

>
>> +static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
>> +{
>> +	struct tegra_qspi_data *tqspi = context_data;
>> +
>> +	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
>> +	if (tqspi->cur_direction & DATA_DIR_TX)
>> +		tqspi->tx_status = tqspi->status_reg &
>> +				   (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
>> +
>> +	if (tqspi->cur_direction & DATA_DIR_RX)
>> +		tqspi->rx_status = tqspi->status_reg &
>> +				   (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
>> +	tegra_qspi_mask_clear_irq(tqspi);
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
> It's a bit unclear to me the value we gain from having this handler - if
> we don't specify a handler genirq will already mask the interrupt until
> we get to the thread anyway and we could just read the status in the
> threaded handler.  OTOH it doesn't do any harm, just struck me as a bit
> odd.

I started QSPI driver by taking SPI driver as data transfer and 
interrupt handling are similar.

So kept this handler for clearing status registers and masking 
interrupts as I did not see anything wrong with this.

>
>> +	master = spi_alloc_master(&pdev->dev, sizeof(*tqspi));
>> +	if (!master) {
>> +		dev_err(&pdev->dev, "master allocation failed\n");
>> +		return -ENOMEM;
>> +	}
> Please switch to using the devm_ version of the API to allocate
> controller, it makes things much more robust.
Will update in v2
>
>> +	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
>> +				 &master->max_speed_hz))
>> +		master->max_speed_hz = QSPI_MAX_SPEED;
> The core will do this for you.

Will remove this in v2.

Thanks

Sowjanya

