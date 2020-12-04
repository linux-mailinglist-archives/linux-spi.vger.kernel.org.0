Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35882CF6CC
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 23:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgLDWew (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 17:34:52 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5205 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLDWew (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 17:34:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcab9630001>; Fri, 04 Dec 2020 14:34:11 -0800
Received: from [10.2.90.244] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Dec
 2020 22:34:10 +0000
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
To:     Jon Hunter <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <1696afb0-3e44-8a68-caea-22fefd837ad8@nvidia.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <4057ced0-8602-4b8a-c3c5-0f7f57dc82fb@nvidia.com>
Date:   Fri, 4 Dec 2020 14:34:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1696afb0-3e44-8a68-caea-22fefd837ad8@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607121251; bh=POythEEO/a+pcRAb/JjnuVvr1gHeKFR0jb8uK82UrTg=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=lO8LTFKJtLNh6eoRGMNzePARLYVYo5JklPhJFL9C4Jw1AnvMTeGagegVk4lpWk3fa
         HFrAnZs+nKkSiMZcfYGkXDSFEumvYwOVMJKiiv67IHL+DLu6RU2G8T5t6JaW2jf0k7
         zf7LdfAv7kIq6r0t7JSOhQ0iUNvN+8rvVMnzk22vNQ4Z7gq7DBne4e+25exk5weUuC
         FliKRqzONwmyTAUF1hLp3OXSGiSGtm0FCnaoWKo8bizQUec0Ruj6v+uvIdeinidyxX
         MJlzWrRcii5ciOEDjHkoctdqWmUT0f/dN/kx8WhcFF9y8IbnP4JRTluHrIQJPZdqRh
         uPG5RMmLkEqJA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Thanks Jon. Will address below suggestions in v2.

Regards,

Sowjanya

On 12/4/20 6:41 AM, Jon Hunter wrote:
> On 01/12/2020 21:12, Sowjanya Komatineni wrote:
>> Tegra SoC has a Quad SPI controller starting from Tegra210.
>>
>> This patch adds support for Tegra210 QSPI controller.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/spi/Kconfig      |    9 +
>>   drivers/spi/Makefile     |    1 +
>>   drivers/spi/qspi-tegra.c | 1418 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1428 insertions(+)
>>   create mode 100644 drivers/spi/qspi-tegra.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 3fd16b7..1a021e8 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -844,6 +844,15 @@ config SPI_MXS
>>   	help
>>   	  SPI driver for Freescale MXS devices.
>>   
>> +config QSPI_TEGRA
>> +	tristate "Nvidia Tegra QSPI Controller"
>> +	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
> I assume that the dependency on the APBDMA is for Tegra210. Does it work
> on Tegra210 without the DMA? I am wondering if this is a dependency?
>
>> +static void tegra_qspi_deinit_dma_param(struct tegra_qspi_data *tqspi,
>> +					bool dma_to_memory)
>> +{
>> +	u32 *dma_buf;
>> +	dma_addr_t dma_phys;
>> +	struct dma_chan *dma_chan;
>> +
>> +	if (dma_to_memory) {
>> +		dma_buf = tqspi->rx_dma_buf;
>> +		dma_chan = tqspi->rx_dma_chan;
>> +		dma_phys = tqspi->rx_dma_phys;
>> +		tqspi->rx_dma_chan = NULL;
>> +		tqspi->rx_dma_buf = NULL;
>> +	} else {
>> +		dma_buf = tqspi->tx_dma_buf;
>> +		dma_chan = tqspi->tx_dma_chan;
>> +		dma_phys = tqspi->tx_dma_phys;
>> +		tqspi->tx_dma_buf = NULL;
>> +		tqspi->tx_dma_chan = NULL;
>> +	}
>> +	if (!dma_chan)
>> +		return;
> The above seemed odd to me at first, but I guess if a device does not
> support DMA yet, then this will be NULL. However, would it be clearer to
> just ...
>
>          if (!tqspi->use_dma)
> 		return;
>
> You could also do this right at the beginning of the function.
>
>> +static struct tegra_qspi_client_data
>> +	*tegra_qspi_parse_cdata_dt(struct spi_device *spi)
>> +{
>> +	struct tegra_qspi_client_data *cdata;
>> +	struct device_node *slave_np;
>> +
>> +	slave_np = spi->dev.of_node;
>> +	if (!slave_np) {
> This test should not be necessary as we only support device-tree.
>
>> +		dev_dbg(&spi->dev, "device node not found\n");
>> +		return NULL;
>> +	}
>> +
>> +	cdata = kzalloc(sizeof(*cdata), GFP_KERNEL);
>> +	if (!cdata)
>> +		return NULL;
>> +
>> +	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
>> +			     &cdata->tx_clk_tap_delay);
>> +	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
>> +			     &cdata->rx_clk_tap_delay);
>> +	return cdata;
>> +}
>> +
>> +static void tegra_qspi_cleanup(struct spi_device *spi)
>> +{
>> +	struct tegra_qspi_client_data *cdata = spi->controller_data;
>> +
>> +	spi->controller_data = NULL;
>> +	if (spi->dev.of_node)
>> +		kfree(cdata);
>> +}
>> +
>> +static int tegra_qspi_setup(struct spi_device *spi)
>> +{
>> +	struct tegra_qspi_data *tqspi = spi_master_get_devdata(spi->master);
>> +	struct tegra_qspi_client_data *cdata = spi->controller_data;
>> +	u32 tx_tap = 0, rx_tap = 0;
>> +	u32 val;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	dev_dbg(&spi->dev, "setup %d bpw, %scpol, %scpha, %dHz\n",
>> +		spi->bits_per_word,
>> +		spi->mode & SPI_CPOL ? "" : "~",
>> +		spi->mode & SPI_CPHA ? "" : "~",
>> +		spi->max_speed_hz);
>> +
>> +	if (!cdata) {
>> +		cdata = tegra_qspi_parse_cdata_dt(spi);
>> +		spi->controller_data = cdata;
>> +	}
>> +
>> +	ret = pm_runtime_get_sync(tqspi->dev);
>> +	if (ret < 0) {
>> +		dev_err(tqspi->dev, "runtime resume failed: %d\n", ret);
>> +		if (cdata)
>> +			tegra_qspi_cleanup(spi);
>> +		return ret;
>> +	}
> Does it simplify the code to do the pm_runtime_get_sync() before the
> parsing of the cdata?
>
>> +static int tegra_qspi_probe(struct platform_device *pdev)
>> +{
>> +	struct spi_master	*master;
>> +	struct tegra_qspi_data	*tqspi;
>> +	struct resource		*r;
>> +	int ret, qspi_irq;
>> +	int bus_num;
>> +
>> +	master = spi_alloc_master(&pdev->dev, sizeof(*tqspi));
>> +	if (!master) {
>> +		dev_err(&pdev->dev, "master allocation failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, master);
>> +	tqspi = spi_master_get_devdata(master);
>> +
>> +	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
>> +				 &master->max_speed_hz))
>> +		master->max_speed_hz = QSPI_MAX_SPEED;
>> +
>> +	/* the spi->mode bits understood by this driver: */
>> +	master->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_CS_HIGH |
>> +			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD |
>> +			    SPI_RX_QUAD;
>> +	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
>> +				     SPI_BPW_MASK(8);
>> +	master->setup = tegra_qspi_setup;
>> +	master->cleanup = tegra_qspi_cleanup;
>> +	master->transfer_one_message = tegra_qspi_transfer_one_message;
>> +	master->num_chipselect = 1;
>> +	master->auto_runtime_pm = true;
>> +	bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
>> +	if (bus_num >= 0)
>> +		master->bus_num = bus_num;
>> +
>> +	tqspi->master = master;
>> +	tqspi->dev = &pdev->dev;
>> +	spin_lock_init(&tqspi->lock);
>> +
>> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	tqspi->base = devm_ioremap_resource(&pdev->dev, r);
>> +	if (IS_ERR(tqspi->base)) {
>> +		ret = PTR_ERR(tqspi->base);
>> +		goto exit_free_master;
>> +	}
>> +
>> +	tqspi->phys = r->start;
>> +	qspi_irq = platform_get_irq(pdev, 0);
>> +	tqspi->irq = qspi_irq;
>> +
>> +	tqspi->clk = devm_clk_get(&pdev->dev, "qspi");
>> +	if (IS_ERR(tqspi->clk)) {
>> +		ret = PTR_ERR(tqspi->clk);
>> +		dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
>> +		goto exit_free_master;
>> +	}
>> +
>> +	tqspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "qspi");
>> +	if (IS_ERR(tqspi->rst)) {
>> +		ret = PTR_ERR(tqspi->rst);
>> +		dev_err(&pdev->dev, "failed to get reset control: %d\n", ret);
>> +		goto exit_free_master;
>> +	}
>> +
>> +	tqspi->max_buf_size = QSPI_FIFO_DEPTH << 2;
>> +	tqspi->dma_buf_size = DEFAULT_QSPI_DMA_BUF_LEN;
>> +
>> +	ret = tegra_qspi_init_dma_param(tqspi, true);
>> +	if (ret < 0)
>> +		goto exit_free_master;
>> +	ret = tegra_qspi_init_dma_param(tqspi, false);
>> +	if (ret < 0)
>> +		goto exit_rx_dma_free;
> I would be tempted to combine the init for the TX and RX into a single
> function. Then we can have a single function to deinit.
>
>> +
>> +	if (tqspi->use_dma)
>> +		tqspi->max_buf_size = tqspi->dma_buf_size;
>> +
>> +	init_completion(&tqspi->tx_dma_complete);
>> +	init_completion(&tqspi->rx_dma_complete);
>> +
> Unnecessary blank line.
>
>> +	init_completion(&tqspi->xfer_completion);
>> +
>> +	pm_runtime_enable(&pdev->dev);
>> +	if (!pm_runtime_enabled(&pdev->dev)) {
> RPM is always enabled for Tegra and so if this fails we should just fail.
>
>> +		ret = tegra_qspi_runtime_resume(&pdev->dev);
>> +		if (ret)
>> +			goto exit_pm_disable;
>> +	}
>> +
>> +	ret = pm_runtime_get_sync(&pdev->dev);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "runtime resume failed: %d\n", ret);
>> +		pm_runtime_put_noidle(&pdev->dev)
> You can use pm_runtime_resume_and_get() now and then you don't need to
> call pm_runtime_put_noidle() on failure.
>
>> +		goto exit_pm_disable;
>> +	}
>> +
>> +	reset_control_assert(tqspi->rst);
>> +	udelay(2);
>> +	reset_control_deassert(tqspi->rst);
>> +	tqspi->def_command1_reg = QSPI_M_S | QSPI_CS_SW_HW |  QSPI_CS_SW_VAL;
>> +	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
>> +	tqspi->spi_cs_timing1 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING1);
>> +	tqspi->spi_cs_timing2 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING2);
>> +	tqspi->def_command2_reg = tegra_qspi_readl(tqspi, QSPI_COMMAND2);
>> +
>> +	pm_runtime_put(&pdev->dev);
>> +
>> +	ret = request_threaded_irq(tqspi->irq, tegra_qspi_isr,
>> +				   tegra_qspi_isr_thread, IRQF_ONESHOT,
>> +				   dev_name(&pdev->dev), tqspi);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"failed to request IRQ#%u: %d\n", tqspi->irq, ret);
>> +		goto exit_pm_disable;
>> +	}
>> +
>> +	master->dev.of_node = pdev->dev.of_node;
>> +	ret = devm_spi_register_master(&pdev->dev, master);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to register master: %d\n", ret);
>> +		goto exit_free_irq;
>> +	}
>> +	return ret;
> return 0
>
>> +static int tegra_qspi_runtime_resume(struct device *dev)
>> +{
>> +	struct spi_master *master = dev_get_drvdata(dev);
>> +	struct tegra_qspi_data *tqspi = spi_master_get_devdata(master);
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(tqspi->clk);
>> +	if (ret < 0) {
>> +		dev_err(tqspi->dev, "clk_prepare failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +	return 0;
> Always just 'return ret' here.
>
> Cheers
> Jon
>
