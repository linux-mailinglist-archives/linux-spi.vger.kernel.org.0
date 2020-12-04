Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFEC2CF705
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 23:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgLDWnZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 17:43:25 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11579 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLDWnY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 17:43:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcabb640000>; Fri, 04 Dec 2020 14:42:44 -0800
Received: from [10.2.90.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Dec
 2020 22:42:43 +0000
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <X8onZQRMLxV5spo+@ulmo>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <518435aa-1d7d-2966-66d2-a3647d40154f@nvidia.com>
Date:   Fri, 4 Dec 2020 14:42:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X8onZQRMLxV5spo+@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607121764; bh=V8cYIAA4Ng+Uoj3vjqaaj2WjEEbtvT4ANSvB1SJyvdY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=mL+CBdp+YnUJM4pVIRfHveiEryVQee2vEBQ760zHl0LIpM+vIrhRGNBZdFBeUZ1Ru
         aJ76NdIVi7TRmGOKDb/DlNHV7+wvl9lP4e1RjAIJ78NslsiiAvS6mKqdX9JBKXwihP
         O8/ey1Zra1saBL6IDs4dWzkmDaDTFE+V3Pa5BPu/5fDsz+tYXffVo9bGjIaV86msk4
         T3ojFq5Fmt+NLmxat2LMosqOHNNI7VduxcNxhOttHpt37zHUo5XBpQPE5UQ+uAATMB
         KrVyBNSbgrsXe60ygqZ6jT/NYEU9uY+y/T7uRc90cbIPjbIBERvevdHhyT1EGZTLcO
         qi4ZySA0obgGg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Thanks Thierry. Will address below suggestions in v2.

Some inline comments below regarding client data part of controller driver.

Regards,

Sowjanya

On 12/4/20 4:11 AM, Thierry Reding wrote:
> On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
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
> You already discussed this with Mark, but perhaps a better name would be
> SPI_TEGRA210_QUAD or something. SPI_TEGRA210 is too generic because
> there is a regular SPI controller on Tegra210 as well.
>
> SPI_TEGRA210_QUAD is in line with the likes of SPI_TEGRA20_SFLASH and
> SPI_TEGRA20_SLINK.
>
>> +	tristate "Nvidia Tegra QSPI Controller"
> NVIDIA
>
>> +	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
> I don't think we need the ARCH_TEGRA part there because TEGRA20_APB_DMA
> already depends on that. Also, there's not strictly a dependency on
> TEGRA20_APB_DMA specifically, but rather a dependency on DMA_ENGINE,
> right? The DMA channels could be coming from some other driver on some
> other SoC generation, such as the Tegra186 and later GPCDMA.
>
>> +	depends on RESET_CONTROLLER
>> +	help
>> +	  QSPI driver for Nvidia Tegra QSPI Controller interface. This
> NVIDIA
>
>> +	  controller is different from the spi controller and is available
> SPI
>
>> +	  on Tegra SoCs starting from Tegra210.
>> +
>>   config SPI_TEGRA114
>>   	tristate "NVIDIA Tegra114 SPI Controller"
>>   	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
> [...]
>> diff --git a/drivers/spi/qspi-tegra.c b/drivers/spi/qspi-tegra.c
> [...]
>> +struct tegra_qspi_client_data {
>> +	int tx_clk_tap_delay;
>> +	int rx_clk_tap_delay;
>> +};
> If this is client data, why are we dealing with this in the controller
> driver? Is this perhaps something that could be added to struct
> spi_device?

tx/rx clock tap delays are based on platform design and values may vary 
depending on trace lengths to corresponding spi device.

These tap delays are programmed in Tegra QSPI controller.

>
>> +
>> +struct tegra_qspi_data {
> That _data just seems to be 5 extra characters that don't add any value.
>
>> +	struct device				*dev;
>> +	struct spi_master			*master;
>> +	/* Lock to protect data accessed by irq */
>> +	spinlock_t				lock;
>> +
>> +	struct clk				*clk;
>> +	struct reset_control			*rst;
>> +	void __iomem				*base;
>> +	phys_addr_t				phys;
>> +	unsigned int				irq;
>> +
>> +	u32					cur_speed;
>> +	unsigned int				cur_pos;
>> +	unsigned int				words_per_32bit;
>> +	unsigned int				bytes_per_word;
>> +	unsigned int				curr_dma_words;
>> +	unsigned int				cur_direction;
>> +
>> +	unsigned int				cur_rx_pos;
>> +	unsigned int				cur_tx_pos;
>> +
>> +	unsigned int				dma_buf_size;
>> +	unsigned int				max_buf_size;
>> +	bool					is_curr_dma_xfer;
>> +
>> +	struct completion			rx_dma_complete;
>> +	struct completion			tx_dma_complete;
>> +
>> +	u32					tx_status;
>> +	u32					rx_status;
>> +	u32					status_reg;
>> +	bool					is_packed;
>> +	bool					use_dma;
>> +
>> +	u32					command1_reg;
>> +	u32					dma_control_reg;
>> +	u32					def_command1_reg;
>> +	u32					def_command2_reg;
>> +	u32					spi_cs_timing1;
>> +	u32					spi_cs_timing2;
>> +	u8					dummy_cycles;
>> +
>> +	struct completion			xfer_completion;
>> +	struct spi_transfer			*curr_xfer;
>> +
>> +	struct dma_chan				*rx_dma_chan;
>> +	u32					*rx_dma_buf;
>> +	dma_addr_t				rx_dma_phys;
>> +	struct dma_async_tx_descriptor		*rx_dma_desc;
>> +
>> +	struct dma_chan				*tx_dma_chan;
>> +	u32					*tx_dma_buf;
>> +	dma_addr_t				tx_dma_phys;
>> +	struct dma_async_tx_descriptor		*tx_dma_desc;
>> +};
>> +
>> +static int tegra_qspi_runtime_suspend(struct device *dev);
>> +static int tegra_qspi_runtime_resume(struct device *dev);
> Can't we just reorder the code so that these don't have to be forward-
> declared?
>
>> +
>> +static inline u32 tegra_qspi_readl(struct tegra_qspi_data *tqspi,
>> +				   unsigned long reg)
> Nit: I prefer "offset" over "reg" because I think it's slightly more
> accurate.
>
>> +{
>> +	return readl(tqspi->base + reg);
>> +}
>> +
>> +static inline void tegra_qspi_writel(struct tegra_qspi_data *tqspi,
>> +				     u32 val, unsigned long reg)
> I also prefer "value" over "val" because "val" could also be short for
> "valid". Anyway, I am pedantic that way, so feel free to ignore that.
>
> [...]
>> +static unsigned int
>> +tegra_qspi_calculate_curr_xfer_param(struct tegra_qspi_data *tqspi,
>> +				     struct spi_transfer *t)
>> +{
>> +	unsigned int remain_len = t->len - tqspi->cur_pos;
>> +	unsigned int max_word;
>> +	unsigned int bits_per_word = t->bits_per_word;
>> +	unsigned int max_len;
>> +	unsigned int total_fifo_words;
> You could list some of these on the same line to make this a bit more
> compact. Something I've often seen done that makes this really clean is
> to have uninitialized variables on one line and then assignments on
> separate lines, then sort lines by length:
>
> 	unsigned int max_word, max_len, total_fifo_words;
> 	unsigned int remain_len = t->len - tqspi->cur_pos;
> 	unsigned int bits_per_word = t->bits_per_word;
>
> This also applies to some other functions further down.
>
> [...]
>> +static void
>> +tegra_qspi_copy_client_txbuf_to_qspi_txbuf(struct tegra_qspi_data *tqspi,
>> +					   struct spi_transfer *t)
>> +{
>> +	/* Make the dma buffer to read by cpu */
> This comment seems a bit redundant. dma_sync_single_for_cpu() is a well-
> documented function that doesn't need explanation.
>
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
>> +	} else {
>> +		u8 *tx_buf = (u8 *)t->tx_buf + tqspi->cur_tx_pos;
>> +		unsigned int i;
>> +		unsigned int count;
>> +		unsigned int consume;
>> +		unsigned int write_bytes;
>> +
>> +		consume = tqspi->curr_dma_words * tqspi->bytes_per_word;
>> +		if (consume > t->len - tqspi->cur_pos)
>> +			consume = t->len - tqspi->cur_pos;
>> +		write_bytes = consume;
>> +		for (count = 0; count < tqspi->curr_dma_words; count++) {
>> +			u32 x = 0;
>> +
>> +			for (i = 0; consume && (i < tqspi->bytes_per_word);
>> +							i++, consume--)
>> +				x |= (u32)(*tx_buf++) << (i * 8);
>> +			tqspi->tx_dma_buf[count] = x;
>> +		}
>> +
>> +		tqspi->cur_tx_pos += write_bytes;
>> +	}
>> +
>> +	/* Make the dma buffer to read by dma */
> Same here.
>
>> +	dma_sync_single_for_device(tqspi->dev, tqspi->tx_dma_phys,
>> +				   tqspi->dma_buf_size, DMA_TO_DEVICE);
>> +}
>> +
>> +static void
>> +tegra_qspi_copy_qspi_rxbuf_to_client_rxbuf(struct tegra_qspi_data *tqspi,
>> +					   struct spi_transfer *t)
>> +{
>> +	/* Make the dma buffer to read by cpu */
> And here.
>
>> +	dma_sync_single_for_cpu(tqspi->dev, tqspi->rx_dma_phys,
>> +				tqspi->dma_buf_size, DMA_FROM_DEVICE);
>> +
>> +	if (tqspi->is_packed) {
>> +		unsigned int len = tqspi->curr_dma_words *
>> +				   tqspi->bytes_per_word;
>> +
>> +		memcpy(t->rx_buf + tqspi->cur_rx_pos, tqspi->rx_dma_buf, len);
>> +		tqspi->cur_rx_pos += tqspi->curr_dma_words *
>> +				     tqspi->bytes_per_word;
>> +	} else {
>> +		unsigned char *rx_buf = t->rx_buf + tqspi->cur_rx_pos;
>> +		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
>> +		unsigned int i;
>> +		unsigned int count;
>> +		unsigned int consume;
>> +		unsigned int read_bytes;
>> +
>> +		consume = tqspi->curr_dma_words * tqspi->bytes_per_word;
>> +		if (consume > t->len - tqspi->cur_pos)
>> +			consume = t->len - tqspi->cur_pos;
>> +		read_bytes = consume;
>> +		for (count = 0; count < tqspi->curr_dma_words; count++) {
>> +			u32 x = tqspi->rx_dma_buf[count] & rx_mask;
>> +
>> +			for (i = 0; consume && (i < tqspi->bytes_per_word);
>> +							i++, consume--)
>> +				*rx_buf++ = (x >> (i * 8)) & 0xFF;
>> +		}
>> +
>> +		tqspi->cur_rx_pos += read_bytes;
>> +	}
>> +
>> +	/* Make the dma buffer to read by dma */
> And here.
>
>> +	dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
>> +				   tqspi->dma_buf_size, DMA_FROM_DEVICE);
>> +}
>> +
>> +static void tegra_qspi_dma_complete(void *args)
>> +{
>> +	struct completion *dma_complete = args;
>> +
>> +	complete(dma_complete);
>> +}
>> +
>> +static int tegra_qspi_start_tx_dma(struct tegra_qspi_data *tqspi, int len)
>> +{
>> +	reinit_completion(&tqspi->tx_dma_complete);
>> +	tqspi->tx_dma_desc = dmaengine_prep_slave_single(tqspi->tx_dma_chan,
>> +				tqspi->tx_dma_phys, len, DMA_MEM_TO_DEV,
>> +				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
> Looks like most of this driver is wrapped at 80 columns. That rule was
> relaxed a bit a while ago and checkpatch now only warns if you exceed
> 100 columns. There are various places in this driver that could benefit
> from longer lines, such as the above.
>
>> +	if (!tqspi->tx_dma_desc) {
>> +		dev_err(tqspi->dev, "Not able to get desc for Tx\n");
> Perhaps: "Unable to get TX descriptor\n"?
>
>> +		return -EIO;
>> +	}
>> +
>> +	tqspi->tx_dma_desc->callback = tegra_qspi_dma_complete;
>> +	tqspi->tx_dma_desc->callback_param = &tqspi->tx_dma_complete;
>> +
>> +	dmaengine_submit(tqspi->tx_dma_desc);
>> +	dma_async_issue_pending(tqspi->tx_dma_chan);
>> +	return 0;
>> +}
>> +
>> +static int tegra_qspi_start_rx_dma(struct tegra_qspi_data *tqspi, int len)
>> +{
>> +	reinit_completion(&tqspi->rx_dma_complete);
>> +	tqspi->rx_dma_desc = dmaengine_prep_slave_single(tqspi->rx_dma_chan,
>> +				tqspi->rx_dma_phys, len, DMA_DEV_TO_MEM,
>> +				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
>> +	if (!tqspi->rx_dma_desc) {
>> +		dev_err(tqspi->dev, "Not able to get desc for Rx\n");
> Same here.
>
>> +		return -EIO;
>> +	}
>> +
>> +	tqspi->rx_dma_desc->callback = tegra_qspi_dma_complete;
>> +	tqspi->rx_dma_desc->callback_param = &tqspi->rx_dma_complete;
>> +
>> +	dmaengine_submit(tqspi->rx_dma_desc);
>> +	dma_async_issue_pending(tqspi->rx_dma_chan);
>> +	return 0;
>> +}
>> +
>> +static int tegra_qspi_flush_fifos(struct tegra_qspi_data *tqspi)
>> +{
>> +	unsigned long timeout = jiffies + HZ;
>> +	u32 status;
>> +
>> +	status = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
>> +	if ((status & QSPI_FIFO_EMPTY) == QSPI_FIFO_EMPTY)
>> +		return 0;
>> +
>> +	status |= QSPI_RX_FIFO_FLUSH | QSPI_TX_FIFO_FLUSH;
>> +	tegra_qspi_writel(tqspi, status, QSPI_FIFO_STATUS);
>> +	while ((status & QSPI_FIFO_EMPTY) != QSPI_FIFO_EMPTY) {
>> +		status = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
>> +		if (time_after(jiffies, timeout)) {
>> +			dev_err(tqspi->dev,
>> +				"timeout waiting for fifo flush\n");
> FIFO is an abbreviation, so it should be all uppercase in text.
>
>> +			return -EIO;
>> +		}
>> +
>> +		udelay(1);
> It looks like this function can be called from both interrupt and
> process contexts, where the latter is the more common case and it is
> only ever used in interrupt context to clean up on error.
>
> I wonder if it's worth adding an "atomic" parameter to the function and
> make this a sleeping loop whenever possible. Also, can this not use one
> of the helpers from linux/iopoll.h?
>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void tegra_qspi_unmask_irq(struct tegra_qspi_data *tqspi)
>> +{
>> +	u32 intr_mask;
>> +
>> +	intr_mask = tegra_qspi_readl(tqspi, QSPI_INTR_MASK);
>> +	intr_mask &= ~(QSPI_INTR_RDY_MASK | QSPI_INTR_RX_TX_FIFO_ERR);
>> +	tegra_qspi_writel(tqspi, intr_mask, QSPI_INTR_MASK);
>> +}
>> +
>> +static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi_data *tqspi,
>> +					       struct spi_transfer *t)
>> +{
>> +	u32 val;
>> +	unsigned int len;
>> +	int ret = 0;
>> +	u8 dma_burst;
>> +	struct dma_slave_config dma_sconfig = {0};
> I think checkpatch wants spaces after { and before }.
>
>> +
>> +	val = QSPI_DMA_BLK_SET(tqspi->curr_dma_words - 1);
>> +	tegra_qspi_writel(tqspi, val, QSPI_DMA_BLK);
>> +
>> +	tegra_qspi_unmask_irq(tqspi);
>> +
>> +	if (tqspi->is_packed)
>> +		len = DIV_ROUND_UP(tqspi->curr_dma_words *
>> +				   tqspi->bytes_per_word, 4) * 4;
>> +	else
>> +		len = tqspi->curr_dma_words * 4;
>> +
>> +	/* Set attention level based on length of transfer */
>> +	val = 0;
>> +	if (len & 0xF) {
> Nit: hexadecimal literals are usually lowercase.
>
>> +		val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
>> +		dma_burst = 1;
>> +	} else if (((len) >> 4) & 0x1) {
>> +		val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
>> +		dma_burst = 4;
>> +	} else {
>> +		val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
>> +		dma_burst = 8;
>> +	}
>> +
>> +	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
>> +	tqspi->dma_control_reg = val;
>> +
>> +	dma_sconfig.device_fc = true;
>> +	if (tqspi->cur_direction & DATA_DIR_TX) {
>> +		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
>> +		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +		dma_sconfig.dst_maxburst = dma_burst;
>> +		ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
>> +		if (ret < 0) {
>> +			dev_err(tqspi->dev,
>> +				"DMA slave config failed: %d\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
>> +		ret = tegra_qspi_start_tx_dma(tqspi, len);
>> +		if (ret < 0) {
>> +			dev_err(tqspi->dev,
>> +				"Starting tx dma failed: %d\n", ret);
> "TX" and "DMA"
>
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (tqspi->cur_direction & DATA_DIR_RX) {
>> +		dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
>> +		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +		dma_sconfig.src_maxburst = dma_burst;
>> +		ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
>> +		if (ret < 0) {
>> +			dev_err(tqspi->dev,
>> +				"DMA slave config failed: %d\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		/* Make the dma buffer to read by dma */
> Again, not a useful comment.
>
>> +		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
>> +					   tqspi->dma_buf_size,
>> +					   DMA_FROM_DEVICE);
>> +
>> +		ret = tegra_qspi_start_rx_dma(tqspi, len);
>> +		if (ret < 0) {
>> +			dev_err(tqspi->dev,
>> +				"Starting rx dma failed: %d\n", ret);
> "RX" and "DMA"
>
> [...]
>> +static int tegra_qspi_init_dma_param(struct tegra_qspi_data *tqspi,
>> +				     bool dma_to_memory)
>> +{
>> +	struct dma_chan *dma_chan;
>> +	u32 *dma_buf;
>> +	dma_addr_t dma_phys;
>> +
>> +	if (!device_property_present(tqspi->dev, "dmas"))
>> +		return 0;
> If DMA support is optional, then we definitely don't want to depend on
> TEGRA20_APB_DMA (or any other specific driver).
>
>> +
>> +	dma_chan = dma_request_chan(tqspi->dev, dma_to_memory ? "rx" : "tx");
> Does this return some specific value when there's no channel for this?
> I.e. what happens if the "dmas" property exists in device tree but we
> don't have a driver for the provider enabled? Since we have code to use
> as fallback, we may want to special case that here and allow the driver
> to continue.

In current Tegra194 device tree, I don't see dma properties populated 
and we don't have GPCDMA upstream yet.

So kind of thought we will add dma properties to device tree only when 
we have corresponding dma driver support.

Yeah understood there's nothing restricting to follow this. Will fix in 
v2 to switch PIO mode even for the case when dma properties are present 
but dma request fails.

>
>> +	if (IS_ERR(dma_chan))
>> +		return dev_err_probe(tqspi->dev, PTR_ERR(dma_chan),
>> +				     "Dma channel is not available\n");
> "DMA"
>
> [...]
>> +static int tegra_qspi_start_transfer_one(struct spi_device *spi,
>> +					 struct spi_transfer *t, u32 command1)
>> +{
> [...]
>> +	command1 &= ~QSPI_INTERFACE_WIDTH_MASK;
>> +	if (bus_width == SPI_NBITS_QUAD)
>> +		command1 |= QSPI_INTERFACE_WIDTH_QUAD;
>> +	else if (bus_width == SPI_NBITS_DUAL)
>> +		command1 |= QSPI_INTERFACE_WIDTH_DUAL;
>> +	else
>> +		command1 |= QSPI_INTERFACE_WIDTH_SINGLE;
>> +	tqspi->command1_reg = command1;
> This (and in some other places in the driver) could use a couple of
> blank lines to make this less cluttered.
>
> [...]
>> +static void tegra_qspi_cleanup(struct spi_device *spi)
>> +{
>> +	struct tegra_qspi_client_data *cdata = spi->controller_data;
>> +
>> +	spi->controller_data = NULL;
>> +	if (spi->dev.of_node)
> Can this ever fail? Do we support SPI device instantiation from
> somewhere else than DT?
>
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
> Oh... I see that this is actually parsed from the SPI device node, so
> perhaps this is okay to do.
yeah. ok
>
> [...]
>> +static int tegra_qspi_transfer_one_message(struct spi_master *master,
>> +					   struct spi_message *msg)
>> +{
> [...]
>> +		is_first_msg = false;
>> +		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
>> +						  QSPI_DMA_TIMEOUT);
>> +		if (WARN_ON(ret == 0)) {
>> +			dev_err(tqspi->dev,
>> +				"qspi transfer timeout: %d\n", ret);
> "QSPI", or alternatively leave this out completely because it should be
> obvious that the transfer that failed is a QSPI transfer just from the
> device name.
>
>> +			if (tqspi->is_curr_dma_xfer &&
>> +			    (tqspi->cur_direction & DATA_DIR_TX))
>> +				dmaengine_terminate_all(tqspi->tx_dma_chan);
>> +			if (tqspi->is_curr_dma_xfer &&
>> +			    (tqspi->cur_direction & DATA_DIR_RX))
>> +				dmaengine_terminate_all(tqspi->rx_dma_chan);
>> +			ret = -EIO;
>> +			tegra_qspi_dump_regs(tqspi);
>> +			tegra_qspi_flush_fifos(tqspi);
>> +			reset_control_assert(tqspi->rst);
>> +			udelay(2);
>> +			reset_control_deassert(tqspi->rst);
>> +			goto exit;
>> +		}
>> +
>> +		if (tqspi->tx_status ||  tqspi->rx_status) {
>> +			ret = -EIO;
>> +			dev_err(tqspi->dev, "error in transfer: %d\n", ret);
> Would it make sense to output tx_status and/or rx_status in this message
> rather than -EIO unconditionally?

>
> [...]
>> +static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi_data *tqspi)
>> +{
>> +	struct spi_transfer *t = tqspi->curr_xfer;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&tqspi->lock, flags);
>> +	if (tqspi->tx_status ||  tqspi->rx_status) {
>> +		dev_err(tqspi->dev, "CpuXfer ERROR bit set 0x%x\n",
>> +			tqspi->status_reg);
>> +		dev_err(tqspi->dev, "CpuXfer 0x%08x:0x%08x\n",
>> +			tqspi->command1_reg, tqspi->dma_control_reg);
>> +		tegra_qspi_dump_regs(tqspi);
>> +		tegra_qspi_flush_fifos(tqspi);
>> +		complete(&tqspi->xfer_completion);
>> +		spin_unlock_irqrestore(&tqspi->lock, flags);
>> +		reset_control_assert(tqspi->rst);
>> +		udelay(2);
>> +		reset_control_deassert(tqspi->rst);
>> +		return IRQ_HANDLED;
>> +	}
> Can this error handling be somehow unified with the DMA error handling?
> Having markers such as "CpuXfer" in error messages is not really helpful
> to users. Maybe have the driver output an INFO message or so during
> probe when it falls back to PIO mode, that would be a good enough
> indicator to someone debugging some issue that PIO mode is being used.
> And then you can just treat transfer failures more uniformly.
>
> Thierry
