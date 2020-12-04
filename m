Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D052CEDCA
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 13:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgLDMMJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 07:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgLDMMI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 07:12:08 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B8C0613D1;
        Fri,  4 Dec 2020 04:11:22 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id x16so8337869ejj.7;
        Fri, 04 Dec 2020 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rxzClRfWrigViB5AicI/pk+858BbyfX+mBRJSVCNBN8=;
        b=WeMtNcA/Jx4532/m8f+R0gk48oRFHYuUeWdWOUBCqjoHnf9e/88B96ETMquvC3qTpr
         RRS8DPbfnP5yX33jplE1iL/0Mkzv48ylJLif4W5gkiED5eWr6615QqxPPkcXMERrLeze
         jF6VdXBo2mROj2yriZ+bRo0NV22/2TpysZAY3wZrbhB3X+vYC3jyaZBxONwRx+FvI7kM
         vh73B4lmOPyJm0UVZoWAidiGwxeMw5UkHL34Ehn7cEkod4Wy0TC+4BTGe7dA01j6a+mQ
         LUHGM2rkyMEL54p9y26eZ/JyV/Nx/a3gIOpKAmbFRnZwl/Xr4pizIP63WO3HZBbEhrhl
         K9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rxzClRfWrigViB5AicI/pk+858BbyfX+mBRJSVCNBN8=;
        b=NbApQmGH3R7O4OiL+w1OT8C8OM1X6aN70fePgDCSUpoHIWI4ryx5FYP/aWo+SulPac
         jqsUXby9LaoGi1vd80DEKsk6dmSAy18uBgcMyLyMEBmfa0EXR9KXxKU1GP3rYelW7hXB
         MN9j0pmsV4sAlQbQH9mQhu17VX9/oUQPEGckD4kZEa6+rHhWrAvDEGZb6D0tn7uJwvSu
         RxKM/mgjOceZdGsx6ujGZTQbky6M1kTmX2CIkGMHwJuRcq9rBakwT6mqesqsETpD7Hww
         Px14ZBaYekrvS1mrs1EDlAmkGd/XwqFs+bdgfgX8VSAKiHfdq3aEsPeaF+ZOx3q23d9F
         IveA==
X-Gm-Message-State: AOAM532IXYXTqXwePwR6cVSNC15IQ//xFxzevtDGAayYoUun5VlA7T9U
        vpX+7KYZQMrV20L5PCg7sRE=
X-Google-Smtp-Source: ABdhPJw0yfKhLLUyHmicKUedkLlSTPnpQzo5k22WucB81l1agWa64SKawAvUT+WdS3Pi80F25IrZvg==
X-Received: by 2002:a17:906:b217:: with SMTP id p23mr6871865ejz.461.1607083881023;
        Fri, 04 Dec 2020 04:11:21 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o11sm2929679ejh.55.2020.12.04.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:11:19 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:11:17 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <X8onZQRMLxV5spo+@ulmo>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TECbwuUcC4y1JUON"
Content-Disposition: inline
In-Reply-To: <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TECbwuUcC4y1JUON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
> Tegra SoC has a Quad SPI controller starting from Tegra210.
>=20
> This patch adds support for Tegra210 QSPI controller.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/spi/Kconfig      |    9 +
>  drivers/spi/Makefile     |    1 +
>  drivers/spi/qspi-tegra.c | 1418 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 1428 insertions(+)
>  create mode 100644 drivers/spi/qspi-tegra.c
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3fd16b7..1a021e8 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -844,6 +844,15 @@ config SPI_MXS
>  	help
>  	  SPI driver for Freescale MXS devices.
> =20
> +config QSPI_TEGRA

You already discussed this with Mark, but perhaps a better name would be
SPI_TEGRA210_QUAD or something. SPI_TEGRA210 is too generic because
there is a regular SPI controller on Tegra210 as well.

SPI_TEGRA210_QUAD is in line with the likes of SPI_TEGRA20_SFLASH and
SPI_TEGRA20_SLINK.

> +	tristate "Nvidia Tegra QSPI Controller"

NVIDIA

> +	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST

I don't think we need the ARCH_TEGRA part there because TEGRA20_APB_DMA
already depends on that. Also, there's not strictly a dependency on
TEGRA20_APB_DMA specifically, but rather a dependency on DMA_ENGINE,
right? The DMA channels could be coming from some other driver on some
other SoC generation, such as the Tegra186 and later GPCDMA.

> +	depends on RESET_CONTROLLER
> +	help
> +	  QSPI driver for Nvidia Tegra QSPI Controller interface. This

NVIDIA

> +	  controller is different from the spi controller and is available

SPI

> +	  on Tegra SoCs starting from Tegra210.
> +
>  config SPI_TEGRA114
>  	tristate "NVIDIA Tegra114 SPI Controller"
>  	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
[...]
> diff --git a/drivers/spi/qspi-tegra.c b/drivers/spi/qspi-tegra.c
[...]
> +struct tegra_qspi_client_data {
> +	int tx_clk_tap_delay;
> +	int rx_clk_tap_delay;
> +};

If this is client data, why are we dealing with this in the controller
driver? Is this perhaps something that could be added to struct
spi_device?

> +
> +struct tegra_qspi_data {

That _data just seems to be 5 extra characters that don't add any value.

> +	struct device				*dev;
> +	struct spi_master			*master;
> +	/* Lock to protect data accessed by irq */
> +	spinlock_t				lock;
> +
> +	struct clk				*clk;
> +	struct reset_control			*rst;
> +	void __iomem				*base;
> +	phys_addr_t				phys;
> +	unsigned int				irq;
> +
> +	u32					cur_speed;
> +	unsigned int				cur_pos;
> +	unsigned int				words_per_32bit;
> +	unsigned int				bytes_per_word;
> +	unsigned int				curr_dma_words;
> +	unsigned int				cur_direction;
> +
> +	unsigned int				cur_rx_pos;
> +	unsigned int				cur_tx_pos;
> +
> +	unsigned int				dma_buf_size;
> +	unsigned int				max_buf_size;
> +	bool					is_curr_dma_xfer;
> +
> +	struct completion			rx_dma_complete;
> +	struct completion			tx_dma_complete;
> +
> +	u32					tx_status;
> +	u32					rx_status;
> +	u32					status_reg;
> +	bool					is_packed;
> +	bool					use_dma;
> +
> +	u32					command1_reg;
> +	u32					dma_control_reg;
> +	u32					def_command1_reg;
> +	u32					def_command2_reg;
> +	u32					spi_cs_timing1;
> +	u32					spi_cs_timing2;
> +	u8					dummy_cycles;
> +
> +	struct completion			xfer_completion;
> +	struct spi_transfer			*curr_xfer;
> +
> +	struct dma_chan				*rx_dma_chan;
> +	u32					*rx_dma_buf;
> +	dma_addr_t				rx_dma_phys;
> +	struct dma_async_tx_descriptor		*rx_dma_desc;
> +
> +	struct dma_chan				*tx_dma_chan;
> +	u32					*tx_dma_buf;
> +	dma_addr_t				tx_dma_phys;
> +	struct dma_async_tx_descriptor		*tx_dma_desc;
> +};
> +
> +static int tegra_qspi_runtime_suspend(struct device *dev);
> +static int tegra_qspi_runtime_resume(struct device *dev);

Can't we just reorder the code so that these don't have to be forward-
declared?

> +
> +static inline u32 tegra_qspi_readl(struct tegra_qspi_data *tqspi,
> +				   unsigned long reg)

Nit: I prefer "offset" over "reg" because I think it's slightly more
accurate.

> +{
> +	return readl(tqspi->base + reg);
> +}
> +
> +static inline void tegra_qspi_writel(struct tegra_qspi_data *tqspi,
> +				     u32 val, unsigned long reg)

I also prefer "value" over "val" because "val" could also be short for
"valid". Anyway, I am pedantic that way, so feel free to ignore that.

[...]
> +static unsigned int
> +tegra_qspi_calculate_curr_xfer_param(struct tegra_qspi_data *tqspi,
> +				     struct spi_transfer *t)
> +{
> +	unsigned int remain_len =3D t->len - tqspi->cur_pos;
> +	unsigned int max_word;
> +	unsigned int bits_per_word =3D t->bits_per_word;
> +	unsigned int max_len;
> +	unsigned int total_fifo_words;

You could list some of these on the same line to make this a bit more
compact. Something I've often seen done that makes this really clean is
to have uninitialized variables on one line and then assignments on
separate lines, then sort lines by length:

	unsigned int max_word, max_len, total_fifo_words;
	unsigned int remain_len =3D t->len - tqspi->cur_pos;
	unsigned int bits_per_word =3D t->bits_per_word;

This also applies to some other functions further down.

[...]
> +static void
> +tegra_qspi_copy_client_txbuf_to_qspi_txbuf(struct tegra_qspi_data *tqspi,
> +					   struct spi_transfer *t)
> +{
> +	/* Make the dma buffer to read by cpu */

This comment seems a bit redundant. dma_sync_single_for_cpu() is a well-
documented function that doesn't need explanation.

> +	dma_sync_single_for_cpu(tqspi->dev, tqspi->tx_dma_phys,
> +				tqspi->dma_buf_size, DMA_TO_DEVICE);
> +
> +	if (tqspi->is_packed) {
> +		unsigned int len =3D tqspi->curr_dma_words *
> +				   tqspi->bytes_per_word;
> +
> +		memcpy(tqspi->tx_dma_buf, t->tx_buf + tqspi->cur_pos, len);
> +		tqspi->cur_tx_pos +=3D tqspi->curr_dma_words *
> +				     tqspi->bytes_per_word;
> +	} else {
> +		u8 *tx_buf =3D (u8 *)t->tx_buf + tqspi->cur_tx_pos;
> +		unsigned int i;
> +		unsigned int count;
> +		unsigned int consume;
> +		unsigned int write_bytes;
> +
> +		consume =3D tqspi->curr_dma_words * tqspi->bytes_per_word;
> +		if (consume > t->len - tqspi->cur_pos)
> +			consume =3D t->len - tqspi->cur_pos;
> +		write_bytes =3D consume;
> +		for (count =3D 0; count < tqspi->curr_dma_words; count++) {
> +			u32 x =3D 0;
> +
> +			for (i =3D 0; consume && (i < tqspi->bytes_per_word);
> +							i++, consume--)
> +				x |=3D (u32)(*tx_buf++) << (i * 8);
> +			tqspi->tx_dma_buf[count] =3D x;
> +		}
> +
> +		tqspi->cur_tx_pos +=3D write_bytes;
> +	}
> +
> +	/* Make the dma buffer to read by dma */

Same here.

> +	dma_sync_single_for_device(tqspi->dev, tqspi->tx_dma_phys,
> +				   tqspi->dma_buf_size, DMA_TO_DEVICE);
> +}
> +
> +static void
> +tegra_qspi_copy_qspi_rxbuf_to_client_rxbuf(struct tegra_qspi_data *tqspi,
> +					   struct spi_transfer *t)
> +{
> +	/* Make the dma buffer to read by cpu */

And here.

> +	dma_sync_single_for_cpu(tqspi->dev, tqspi->rx_dma_phys,
> +				tqspi->dma_buf_size, DMA_FROM_DEVICE);
> +
> +	if (tqspi->is_packed) {
> +		unsigned int len =3D tqspi->curr_dma_words *
> +				   tqspi->bytes_per_word;
> +
> +		memcpy(t->rx_buf + tqspi->cur_rx_pos, tqspi->rx_dma_buf, len);
> +		tqspi->cur_rx_pos +=3D tqspi->curr_dma_words *
> +				     tqspi->bytes_per_word;
> +	} else {
> +		unsigned char *rx_buf =3D t->rx_buf + tqspi->cur_rx_pos;
> +		u32 rx_mask =3D ((u32)1 << t->bits_per_word) - 1;
> +		unsigned int i;
> +		unsigned int count;
> +		unsigned int consume;
> +		unsigned int read_bytes;
> +
> +		consume =3D tqspi->curr_dma_words * tqspi->bytes_per_word;
> +		if (consume > t->len - tqspi->cur_pos)
> +			consume =3D t->len - tqspi->cur_pos;
> +		read_bytes =3D consume;
> +		for (count =3D 0; count < tqspi->curr_dma_words; count++) {
> +			u32 x =3D tqspi->rx_dma_buf[count] & rx_mask;
> +
> +			for (i =3D 0; consume && (i < tqspi->bytes_per_word);
> +							i++, consume--)
> +				*rx_buf++ =3D (x >> (i * 8)) & 0xFF;
> +		}
> +
> +		tqspi->cur_rx_pos +=3D read_bytes;
> +	}
> +
> +	/* Make the dma buffer to read by dma */

And here.

> +	dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
> +				   tqspi->dma_buf_size, DMA_FROM_DEVICE);
> +}
> +
> +static void tegra_qspi_dma_complete(void *args)
> +{
> +	struct completion *dma_complete =3D args;
> +
> +	complete(dma_complete);
> +}
> +
> +static int tegra_qspi_start_tx_dma(struct tegra_qspi_data *tqspi, int le=
n)
> +{
> +	reinit_completion(&tqspi->tx_dma_complete);
> +	tqspi->tx_dma_desc =3D dmaengine_prep_slave_single(tqspi->tx_dma_chan,
> +				tqspi->tx_dma_phys, len, DMA_MEM_TO_DEV,
> +				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);

Looks like most of this driver is wrapped at 80 columns. That rule was
relaxed a bit a while ago and checkpatch now only warns if you exceed
100 columns. There are various places in this driver that could benefit
=66rom longer lines, such as the above.

> +	if (!tqspi->tx_dma_desc) {
> +		dev_err(tqspi->dev, "Not able to get desc for Tx\n");

Perhaps: "Unable to get TX descriptor\n"?

> +		return -EIO;
> +	}
> +
> +	tqspi->tx_dma_desc->callback =3D tegra_qspi_dma_complete;
> +	tqspi->tx_dma_desc->callback_param =3D &tqspi->tx_dma_complete;
> +
> +	dmaengine_submit(tqspi->tx_dma_desc);
> +	dma_async_issue_pending(tqspi->tx_dma_chan);
> +	return 0;
> +}
> +
> +static int tegra_qspi_start_rx_dma(struct tegra_qspi_data *tqspi, int le=
n)
> +{
> +	reinit_completion(&tqspi->rx_dma_complete);
> +	tqspi->rx_dma_desc =3D dmaengine_prep_slave_single(tqspi->rx_dma_chan,
> +				tqspi->rx_dma_phys, len, DMA_DEV_TO_MEM,
> +				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
> +	if (!tqspi->rx_dma_desc) {
> +		dev_err(tqspi->dev, "Not able to get desc for Rx\n");

Same here.

> +		return -EIO;
> +	}
> +
> +	tqspi->rx_dma_desc->callback =3D tegra_qspi_dma_complete;
> +	tqspi->rx_dma_desc->callback_param =3D &tqspi->rx_dma_complete;
> +
> +	dmaengine_submit(tqspi->rx_dma_desc);
> +	dma_async_issue_pending(tqspi->rx_dma_chan);
> +	return 0;
> +}
> +
> +static int tegra_qspi_flush_fifos(struct tegra_qspi_data *tqspi)
> +{
> +	unsigned long timeout =3D jiffies + HZ;
> +	u32 status;
> +
> +	status =3D tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
> +	if ((status & QSPI_FIFO_EMPTY) =3D=3D QSPI_FIFO_EMPTY)
> +		return 0;
> +
> +	status |=3D QSPI_RX_FIFO_FLUSH | QSPI_TX_FIFO_FLUSH;
> +	tegra_qspi_writel(tqspi, status, QSPI_FIFO_STATUS);
> +	while ((status & QSPI_FIFO_EMPTY) !=3D QSPI_FIFO_EMPTY) {
> +		status =3D tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(tqspi->dev,
> +				"timeout waiting for fifo flush\n");

FIFO is an abbreviation, so it should be all uppercase in text.

> +			return -EIO;
> +		}
> +
> +		udelay(1);

It looks like this function can be called from both interrupt and
process contexts, where the latter is the more common case and it is
only ever used in interrupt context to clean up on error.

I wonder if it's worth adding an "atomic" parameter to the function and
make this a sleeping loop whenever possible. Also, can this not use one
of the helpers from linux/iopoll.h?

> +	}
> +
> +	return 0;
> +}
> +
> +static void tegra_qspi_unmask_irq(struct tegra_qspi_data *tqspi)
> +{
> +	u32 intr_mask;
> +
> +	intr_mask =3D tegra_qspi_readl(tqspi, QSPI_INTR_MASK);
> +	intr_mask &=3D ~(QSPI_INTR_RDY_MASK | QSPI_INTR_RX_TX_FIFO_ERR);
> +	tegra_qspi_writel(tqspi, intr_mask, QSPI_INTR_MASK);
> +}
> +
> +static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi_data *t=
qspi,
> +					       struct spi_transfer *t)
> +{
> +	u32 val;
> +	unsigned int len;
> +	int ret =3D 0;
> +	u8 dma_burst;
> +	struct dma_slave_config dma_sconfig =3D {0};

I think checkpatch wants spaces after { and before }.

> +
> +	val =3D QSPI_DMA_BLK_SET(tqspi->curr_dma_words - 1);
> +	tegra_qspi_writel(tqspi, val, QSPI_DMA_BLK);
> +
> +	tegra_qspi_unmask_irq(tqspi);
> +
> +	if (tqspi->is_packed)
> +		len =3D DIV_ROUND_UP(tqspi->curr_dma_words *
> +				   tqspi->bytes_per_word, 4) * 4;
> +	else
> +		len =3D tqspi->curr_dma_words * 4;
> +
> +	/* Set attention level based on length of transfer */
> +	val =3D 0;
> +	if (len & 0xF) {

Nit: hexadecimal literals are usually lowercase.

> +		val |=3D QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> +		dma_burst =3D 1;
> +	} else if (((len) >> 4) & 0x1) {
> +		val |=3D QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> +		dma_burst =3D 4;
> +	} else {
> +		val |=3D QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> +		dma_burst =3D 8;
> +	}
> +
> +	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
> +	tqspi->dma_control_reg =3D val;
> +
> +	dma_sconfig.device_fc =3D true;
> +	if (tqspi->cur_direction & DATA_DIR_TX) {
> +		dma_sconfig.dst_addr =3D tqspi->phys + QSPI_TX_FIFO;
> +		dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dma_sconfig.dst_maxburst =3D dma_burst;
> +		ret =3D dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> +		if (ret < 0) {
> +			dev_err(tqspi->dev,
> +				"DMA slave config failed: %d\n", ret);
> +			return ret;
> +		}
> +
> +		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> +		ret =3D tegra_qspi_start_tx_dma(tqspi, len);
> +		if (ret < 0) {
> +			dev_err(tqspi->dev,
> +				"Starting tx dma failed: %d\n", ret);

"TX" and "DMA"

> +			return ret;
> +		}
> +	}
> +
> +	if (tqspi->cur_direction & DATA_DIR_RX) {
> +		dma_sconfig.src_addr =3D tqspi->phys + QSPI_RX_FIFO;
> +		dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dma_sconfig.src_maxburst =3D dma_burst;
> +		ret =3D dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
> +		if (ret < 0) {
> +			dev_err(tqspi->dev,
> +				"DMA slave config failed: %d\n", ret);
> +			return ret;
> +		}
> +
> +		/* Make the dma buffer to read by dma */

Again, not a useful comment.

> +		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
> +					   tqspi->dma_buf_size,
> +					   DMA_FROM_DEVICE);
> +
> +		ret =3D tegra_qspi_start_rx_dma(tqspi, len);
> +		if (ret < 0) {
> +			dev_err(tqspi->dev,
> +				"Starting rx dma failed: %d\n", ret);

"RX" and "DMA"

[...]
> +static int tegra_qspi_init_dma_param(struct tegra_qspi_data *tqspi,
> +				     bool dma_to_memory)
> +{
> +	struct dma_chan *dma_chan;
> +	u32 *dma_buf;
> +	dma_addr_t dma_phys;
> +
> +	if (!device_property_present(tqspi->dev, "dmas"))
> +		return 0;

If DMA support is optional, then we definitely don't want to depend on
TEGRA20_APB_DMA (or any other specific driver).

> +
> +	dma_chan =3D dma_request_chan(tqspi->dev, dma_to_memory ? "rx" : "tx");

Does this return some specific value when there's no channel for this?
I.e. what happens if the "dmas" property exists in device tree but we
don't have a driver for the provider enabled? Since we have code to use
as fallback, we may want to special case that here and allow the driver
to continue.

> +	if (IS_ERR(dma_chan))
> +		return dev_err_probe(tqspi->dev, PTR_ERR(dma_chan),
> +				     "Dma channel is not available\n");

"DMA"

[...]
> +static int tegra_qspi_start_transfer_one(struct spi_device *spi,
> +					 struct spi_transfer *t, u32 command1)
> +{
[...]
> +	command1 &=3D ~QSPI_INTERFACE_WIDTH_MASK;
> +	if (bus_width =3D=3D SPI_NBITS_QUAD)
> +		command1 |=3D QSPI_INTERFACE_WIDTH_QUAD;
> +	else if (bus_width =3D=3D SPI_NBITS_DUAL)
> +		command1 |=3D QSPI_INTERFACE_WIDTH_DUAL;
> +	else
> +		command1 |=3D QSPI_INTERFACE_WIDTH_SINGLE;
> +	tqspi->command1_reg =3D command1;

This (and in some other places in the driver) could use a couple of
blank lines to make this less cluttered.

[...]
> +static void tegra_qspi_cleanup(struct spi_device *spi)
> +{
> +	struct tegra_qspi_client_data *cdata =3D spi->controller_data;
> +
> +	spi->controller_data =3D NULL;
> +	if (spi->dev.of_node)

Can this ever fail? Do we support SPI device instantiation from
somewhere else than DT?

> +		kfree(cdata);
> +}
> +
> +static int tegra_qspi_setup(struct spi_device *spi)
> +{
> +	struct tegra_qspi_data *tqspi =3D spi_master_get_devdata(spi->master);
> +	struct tegra_qspi_client_data *cdata =3D spi->controller_data;
> +	u32 tx_tap =3D 0, rx_tap =3D 0;
> +	u32 val;
> +	unsigned long flags;
> +	int ret;
> +
> +	dev_dbg(&spi->dev, "setup %d bpw, %scpol, %scpha, %dHz\n",
> +		spi->bits_per_word,
> +		spi->mode & SPI_CPOL ? "" : "~",
> +		spi->mode & SPI_CPHA ? "" : "~",
> +		spi->max_speed_hz);
> +
> +	if (!cdata) {
> +		cdata =3D tegra_qspi_parse_cdata_dt(spi);

Oh... I see that this is actually parsed from the SPI device node, so
perhaps this is okay to do.

[...]
> +static int tegra_qspi_transfer_one_message(struct spi_master *master,
> +					   struct spi_message *msg)
> +{
[...]
> +		is_first_msg =3D false;
> +		ret =3D wait_for_completion_timeout(&tqspi->xfer_completion,
> +						  QSPI_DMA_TIMEOUT);
> +		if (WARN_ON(ret =3D=3D 0)) {
> +			dev_err(tqspi->dev,
> +				"qspi transfer timeout: %d\n", ret);

"QSPI", or alternatively leave this out completely because it should be
obvious that the transfer that failed is a QSPI transfer just from the
device name.

> +			if (tqspi->is_curr_dma_xfer &&
> +			    (tqspi->cur_direction & DATA_DIR_TX))
> +				dmaengine_terminate_all(tqspi->tx_dma_chan);
> +			if (tqspi->is_curr_dma_xfer &&
> +			    (tqspi->cur_direction & DATA_DIR_RX))
> +				dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			ret =3D -EIO;
> +			tegra_qspi_dump_regs(tqspi);
> +			tegra_qspi_flush_fifos(tqspi);
> +			reset_control_assert(tqspi->rst);
> +			udelay(2);
> +			reset_control_deassert(tqspi->rst);
> +			goto exit;
> +		}
> +
> +		if (tqspi->tx_status ||  tqspi->rx_status) {
> +			ret =3D -EIO;
> +			dev_err(tqspi->dev, "error in transfer: %d\n", ret);

Would it make sense to output tx_status and/or rx_status in this message
rather than -EIO unconditionally?

[...]
> +static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi_data *tqspi)
> +{
> +	struct spi_transfer *t =3D tqspi->curr_xfer;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tqspi->lock, flags);
> +	if (tqspi->tx_status ||  tqspi->rx_status) {
> +		dev_err(tqspi->dev, "CpuXfer ERROR bit set 0x%x\n",
> +			tqspi->status_reg);
> +		dev_err(tqspi->dev, "CpuXfer 0x%08x:0x%08x\n",
> +			tqspi->command1_reg, tqspi->dma_control_reg);
> +		tegra_qspi_dump_regs(tqspi);
> +		tegra_qspi_flush_fifos(tqspi);
> +		complete(&tqspi->xfer_completion);
> +		spin_unlock_irqrestore(&tqspi->lock, flags);
> +		reset_control_assert(tqspi->rst);
> +		udelay(2);
> +		reset_control_deassert(tqspi->rst);
> +		return IRQ_HANDLED;
> +	}

Can this error handling be somehow unified with the DMA error handling?
Having markers such as "CpuXfer" in error messages is not really helpful
to users. Maybe have the driver output an INFO message or so during
probe when it falls back to PIO mode, that would be a good enough
indicator to someone debugging some issue that PIO mode is being used.
And then you can just treat transfer failures more uniformly.

Thierry

--TECbwuUcC4y1JUON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KJ10ACgkQ3SOs138+
s6ELAxAAhsSBbtG4BQPdZln9PRwuDv+Jyu6IY4GLbQgJ0QFSqHu9IXSmx1ENuInx
+16g8LlX6Tf6S2UA+qvg/VJeeWEYRuNQCbTJHWZf+ZBJEK2S+/k6BApd42AYyixD
I1bd6q93k7ibLtaAZzPIMQQEhzBvF/0mW0JzIQ7ixiSg2WIYnXWHoOtEmiM0LJZS
LDSspIm1kuR5b60psDDB9+zeiA86cJfaUt07htH5j7fc8d3qprWUv36ygbOiOLTN
smpYBzcJO00bf2ZBnr8CHHup20JXzrqKuHN5SISa8YFjXAKqb7jfZbx/Qh5DERSd
qxDEz+L3h3/o3e/T73SZAc6eViDGpI+F5H2DvCo5WNlLcJKlmxJXp05tkMbBDUsu
ATQs7Ds6qA5Gl4ZDcVbbxE2OiwfLzhPdnM1hhNbS0wNezoqWuh6BNXeHAn5qCIAO
nsJfuhXUcui1l21oFDQIHavdqXSdvxOf/6o5Xyk6OzD1HOvXDf49vTlsOVkmUBOv
F40jCdT802494sOzj+K0kHXrcJ+oQKmDC5LZ2FeBBEV6l9WAXwE9ulxXa3ubtS8W
MD6cH+aw7lnhrxKT4WALhnwZXE5wiebeGRac89woSSciI/gXPMxOIX4fsqHpTHyD
M7ZP9QoZbioodrVBd7U0Ysrl3AKppc5qp54lOWfqjfBeu+l4Zc0=
=OZBk
-----END PGP SIGNATURE-----

--TECbwuUcC4y1JUON--
