Return-Path: <linux-spi+bounces-11512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF91C84ECE
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 13:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8443B0A92
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7F318136;
	Tue, 25 Nov 2025 12:10:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035331A7FE
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072637; cv=none; b=us+1IAreIqb2XxohNf67irLtrl6+K5+Zgyvv6QC8MgRXk/OSeN48KO7iVgYcuDhgfyrCKI5PB1ZjOsGlaGCgGsD0LeiDIdV7SOQux9XoJ3lv6yNM/oefZ+swkxIb5Ws8ofVpyKunT695E5BvZN+9oHRA3AThYyao3DVPbPQ/jA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072637; c=relaxed/simple;
	bh=ip8I9LiS6LjAw6dVfnVxH8n3EMZbEWKLrq6Z1jdbaBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1UGCX+lud02tmd5U3svOiqe9PStKwKcjNfRcm6GvD+uA6tvekNE+WkI2iJmQ2nwLBCwr7dyGkA48zErCZq3KEeZIQwr7ahPipyQ58+irHFhMkfzfR4q1hR+As51oOSCwn3fIqmZVGGecNlRkRYkgwXrVhDQajjd5EqFPRyN9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vNrsD-0004XI-Bw; Tue, 25 Nov 2025 13:10:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vNrsD-002ORc-03;
	Tue, 25 Nov 2025 13:10:21 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9FF1C4A7DA1;
	Tue, 25 Nov 2025 12:10:20 +0000 (UTC)
Date: Tue, 25 Nov 2025 13:10:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, frank.li@nxp.com, hawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Message-ID: <20251125-impartial-porcupine-of-courtesy-841990-mkl@pengutronix.de>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q4l3xer6hebjjxfu"
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-6-carlos.song@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--q4l3xer6hebjjxfu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
MIME-Version: 1.0

On 25.11.2025 18:06:17, Carlos Song wrote:
> ECSPI transfers only one word per frame in DMA mode, causing SCLK stalls
> between words due to BURST_LENGTH updates, which significantly impacts
> performance.
>
> To improve throughput, configure BURST_LENGTH as large as possible (up to
> 512 bytes per frame) instead of word length. This avoids delays between
> words. When transfer length is not 4-byte aligned, use bounce buffers to
> align data for DMA. TX uses aligned words for TXFIFO, while RX trims DMA
> buffer data after transfer completion.
>
> Introduce a new dma_package structure to store:
>   1. BURST_LENGTH values for each DMA request
>   2. Variables for DMA submission
>   3. DMA transmission length and actual data length
>
> Handle three cases:
>   - len <=3D 512 bytes: one package, BURST_LENGTH =3D len * 8 - 1
>   - len > 512 and aligned: one package, BURST_LENGTH =3D max (512 bytes)
>   - len > 512 and unaligned: two packages, second for tail data
>
> Performance test (spidev_test @10MHz, 4KB):
>   Before: tx/rx ~6651.9 kbps
>   After:  tx/rx ~9922.2 kbps (~50% improvement)
>
> For compatibility with slow SPI devices, add configurable word delay in
> DMA mode. When word delay is set, dynamic burst is disabled and
> BURST_LENGTH equals word length.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 409 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 373 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 42f64d9535c9..f02a47fbba8a 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -60,6 +60,7 @@ MODULE_PARM_DESC(polling_limit_us,
>  #define MX51_ECSPI_CTRL_MAX_BURST	512
>  /* The maximum bytes that IMX53_ECSPI can transfer in target mode.*/
>  #define MX53_MAX_TRANSFER_BYTES		512
> +#define BYTES_PER_32BITS_WORD		4
>
>  enum spi_imx_devtype {
>  	IMX1_CSPI,
> @@ -95,6 +96,16 @@ struct spi_imx_devtype_data {
>  	enum spi_imx_devtype devtype;
>  };
>
> +struct dma_data_package {
> +	u32 cmd_word;
> +	void *dma_rx_buf;
> +	void *dma_tx_buf;
> +	dma_addr_t	dma_tx_addr;
> +	dma_addr_t	dma_rx_addr;

Better use uniform indention: here one space, not one tab.

> +	int dma_len;
> +	int data_len;
> +};
> +
>  struct spi_imx_data {
>  	struct spi_controller *controller;
>  	struct device *dev;
> @@ -130,6 +141,9 @@ struct spi_imx_data {
>  	u32 wml;
>  	struct completion dma_rx_completion;
>  	struct completion dma_tx_completion;
> +	struct dma_data_package *dma_data;

please add __counted_by(dma_package_num)

> +	int dma_package_num;
> +	int rx_offset;
>
>  	const struct spi_imx_devtype_data *devtype_data;
>  };
> @@ -189,6 +203,9 @@ MXC_SPI_BUF_TX(u16)
>  MXC_SPI_BUF_RX(u32)
>  MXC_SPI_BUF_TX(u32)
>
> +/* Align to cache line to avoid swiotlo bounce */
> +#define DMA_CACHE_ALIGNED_LEN(x) ALIGN((x), dma_get_cache_alignment())
> +
>  /* First entry is reserved, second entry is valid only if SDHC_SPIEN is =
set
>   * (which is currently not the case in this driver)
>   */
> @@ -253,6 +270,14 @@ static bool spi_imx_can_dma(struct spi_controller *c=
ontroller, struct spi_device
>  	if (transfer->len < spi_imx->devtype_data->fifo_size)
>  		return false;
>
> +	/* DMA only can transmit data in bytes */
> +	if (spi_imx->bits_per_word !=3D 8 && spi_imx->bits_per_word !=3D 16 &&
> +	    spi_imx->bits_per_word !=3D 32)
> +		return false;
> +
> +	if (transfer->len >=3D MAX_SDMA_BD_BYTES)
> +		return false;
> +
>  	spi_imx->dynamic_burst =3D 0;
>
>  	return true;
> @@ -1398,8 +1423,6 @@ static int spi_imx_sdma_init(struct device *dev, st=
ruct spi_imx_data *spi_imx,
>
>  	init_completion(&spi_imx->dma_rx_completion);
>  	init_completion(&spi_imx->dma_tx_completion);
> -	controller->can_dma =3D spi_imx_can_dma;
> -	controller->max_dma_len =3D MAX_SDMA_BD_BYTES;
>  	spi_imx->controller->flags =3D SPI_CONTROLLER_MUST_RX |
>  					 SPI_CONTROLLER_MUST_TX;
>
> @@ -1437,10 +1460,252 @@ static int spi_imx_calculate_timeout(struct spi_=
imx_data *spi_imx, int size)
>  	return secs_to_jiffies(2 * timeout);
>  }
>
> +static void spi_imx_dma_unmap(struct spi_imx_data *spi_imx,
> +			      struct dma_data_package *dma_data)
> +{
> +	struct device *tx_dev =3D spi_imx->controller->dma_tx->device->dev;
> +	struct device *rx_dev =3D spi_imx->controller->dma_rx->device->dev;
> +
> +	dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
> +			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +			 DMA_TO_DEVICE);
> +	dma_unmap_single(rx_dev, dma_data->dma_rx_addr,
> +			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +			 DMA_FROM_DEVICE);
> +}
> +
> +static void spi_imx_dma_rx_data_handle(struct spi_imx_data *spi_imx,
> +				       struct dma_data_package *dma_data, void *rx_buf,
> +				       bool word_delay)
> +{
> +#ifdef __LITTLE_ENDIAN
> +	unsigned int bytes_per_word =3D spi_imx_bytes_per_word(spi_imx->bits_pe=
r_word);
> +	u32 *temp =3D dma_data->dma_rx_buf;

can you move this into the scope of the if() below?
> +#endif
> +	void *copy_ptr;
> +	int unaligned;
> +
> +#ifdef __LITTLE_ENDIAN
> +	/*
> +	 * On little-endian CPUs, adjust byte order:
> +	 * - Swap bytes when bpw =3D 8
> +	 * - Swap half-words when bpw =3D 16
> +	 * This ensures correct data ordering for DMA transfers.
> +	 */
> +	if (!word_delay) {
> +		for (int i =3D 0; i < DIV_ROUND_UP(dma_data->dma_len, BYTES_PER_32BITS=
_WORD); i++) {

sizeof(*temp) instead of BYTES_PER_32BITS_WORD?

> +			if (bytes_per_word =3D=3D 1)
> +				swab32s(temp + i);
> +			else if (bytes_per_word =3D=3D 2)
> +				swahw32s(temp + i);

Why do you do first a swap in place and then a memcpy()

> +		}
> +	}
> +#endif
> +
> +	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {

I think this deserves a comment, why you do a re-alignment of the data here.

> +		unaligned =3D dma_data->data_len % BYTES_PER_32BITS_WORD;
> +		copy_ptr =3D (u8 *)dma_data->dma_rx_buf + BYTES_PER_32BITS_WORD - unal=
igned;
> +	} else {
> +		copy_ptr =3D dma_data->dma_rx_buf;

Why do you use the bounce buffer if the data is aligned correct?

> +	}
> +
> +	memcpy(rx_buf, copy_ptr, dma_data->data_len);
> +}
> +
> +static int spi_imx_dma_map(struct spi_imx_data *spi_imx,
> +			   struct dma_data_package *dma_data)
> +{
> +	struct spi_controller *controller =3D spi_imx->controller;
> +	struct device *tx_dev =3D controller->dma_tx->device->dev;
> +	struct device *rx_dev =3D controller->dma_rx->device->dev;
> +
> +	dma_data->dma_tx_addr =3D dma_map_single(tx_dev, dma_data->dma_tx_buf,
> +					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +					       DMA_TO_DEVICE);
> +	if (dma_mapping_error(tx_dev, dma_data->dma_tx_addr)) {
> +		dev_err(spi_imx->dev, "DMA TX map failed\n");
> +		return -EINVAL;

please propagate the error value of dma_mapping_error()

> +	}
> +
> +	dma_data->dma_rx_addr =3D dma_map_single(rx_dev, dma_data->dma_rx_buf,
> +					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +					       DMA_FROM_DEVICE);
> +	if (dma_mapping_error(rx_dev, dma_data->dma_rx_addr)) {
> +		dev_err(spi_imx->dev, "DMA RX map failed\n");
> +		goto rx_map_err;

there's only one user of the dma_unmap_single(), so no need for the
goto.

> +	}
> +
> +	return 0;
> +
> +rx_map_err:
> +	dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
> +			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> +			 DMA_TO_DEVICE);
> +	return -EINVAL;
> +}
> +
> +static int spi_imx_dma_tx_data_handle(struct spi_imx_data *spi_imx,
> +				      struct dma_data_package *dma_data,
> +				      const void *tx_buf,
> +				      bool word_delay)
> +{
> +#ifdef __LITTLE_ENDIAN
> +	unsigned int bytes_per_word =3D spi_imx_bytes_per_word(spi_imx->bits_pe=
r_word);
> +	u32 *temp;
> +#endif

move into scope of if()

> +	void *copy_ptr;
> +	int unaligned;
> +
> +	if (word_delay) {
> +		dma_data->dma_len =3D dma_data->data_len;
> +	} else {
> +		/*
> +		 * As per the reference manual, when burst length =3D 32*n + m bits, E=
CSPI
> +		 * sends m LSB bits in the first word, followed by n full 32-bit words.
> +		 * Since actual data may not be 4-byte aligned, allocate DMA TX/RX buf=
fers
> +		 * to ensure alignment. For TX, DMA pushes 4-byte aligned words to TXF=
IFO,
> +		 * while ECSPI uses BURST_LENGTH settings to maintain correct bit coun=
t.
> +		 * For RX, DMA receives 32-bit words from RXFIFO; after transfer compl=
etes,
> +		 * trim the DMA RX buffer and copy the actual data to rx_buf.
> +		 */

Ahh, please add the corresponding description for rx.

> +		dma_data->dma_len =3D ALIGN(dma_data->data_len, BYTES_PER_32BITS_WORD);
> +	}
> +
> +	dma_data->dma_tx_buf =3D kmalloc(dma_data->dma_len, GFP_KERNEL | __GFP_=
ZERO);

kzalloc()?

> +	if (!dma_data->dma_tx_buf)
> +		return -ENOMEM;
> +
> +	dma_data->dma_rx_buf =3D kmalloc(dma_data->dma_len, GFP_KERNEL | __GFP_=
ZERO);
> +	if (!dma_data->dma_rx_buf) {
> +		kfree(dma_data->dma_tx_buf);
> +		return -ENOMEM;
> +	}
> +
> +	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
> +		unaligned =3D dma_data->data_len % BYTES_PER_32BITS_WORD;
> +		copy_ptr =3D (u8 *)dma_data->dma_tx_buf + BYTES_PER_32BITS_WORD - unal=
igned;
> +	} else {
> +		copy_ptr =3D dma_data->dma_tx_buf;
> +	}
> +
> +	memcpy(copy_ptr, tx_buf, dma_data->data_len);
> +
> +	/*
> +	 * When word_delay is enabled, DMA transfers an entire word in one mino=
r loop.
> +	 * In this case, no data requires additional handling.
> +	 */
> +	if (word_delay)
> +		return 0;
> +
> +#ifdef __LITTLE_ENDIAN
> +	/*
> +	 * On little-endian CPUs, adjust byte order:
> +	 * - Swap bytes when bpw =3D 8
> +	 * - Swap half-words when bpw =3D 16
> +	 * This ensures correct data ordering for DMA transfers.
> +	 */
> +	temp =3D dma_data->dma_tx_buf;
> +	for (int i =3D 0; i < DIV_ROUND_UP(dma_data->dma_len, BYTES_PER_32BITS_=
WORD); i++) {
> +		if (bytes_per_word =3D=3D 1)
> +			swab32s(temp + i);
> +		else if (bytes_per_word =3D=3D 2)
> +			swahw32s(temp + i);
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +static int spi_imx_dma_data_prepare(struct spi_imx_data *spi_imx,
> +				    struct spi_transfer *transfer,
> +				    bool word_delay)
> +{
> +	u32 pre_bl, tail_bl;
> +	u32 ctrl;
> +	int ret;
> +
> +	/*
> +	 * ECSPI supports a maximum burst of 512 bytes. When xfer->len exceeds =
512
> +	 * and is not a multiple of 512, a tail transfer is required. In this c=
ase,
> +	 * an extra DMA request is issued for the remaining data.

Why do you need an extra transfer in this case?

> +	 */
> +	ctrl =3D readl(spi_imx->base + MX51_ECSPI_CTRL);
> +	if (word_delay) {
> +		/*
> +		 * When SPI IMX need to support word delay, according to "Sample Perio=
d Control
> +		 * Register" shows, The Sample Period Control Register (ECSPI_PERIODRE=
G)
> +		 * provides software a way to insert delays (wait states) between cons=
ecutive
> +		 * SPI transfers. As a result, ECSPI can only transfer one word per fr=
ame, and
> +		 * the delay occurs between frames.
> +		 */
> +		spi_imx->dma_package_num =3D 1;
> +		pre_bl =3D spi_imx->bits_per_word - 1;
> +	} else if (transfer->len <=3D MX51_ECSPI_CTRL_MAX_BURST) {
> +		spi_imx->dma_package_num =3D 1;
> +		pre_bl =3D transfer->len * BITS_PER_BYTE - 1;
> +	} else if (!(transfer->len % MX51_ECSPI_CTRL_MAX_BURST)) {
> +		spi_imx->dma_package_num =3D 1;
> +		pre_bl =3D MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1;
> +	} else {
> +		spi_imx->dma_package_num =3D 2;
> +		pre_bl =3D MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1;
> +		tail_bl =3D (transfer->len % MX51_ECSPI_CTRL_MAX_BURST) * BITS_PER_BYT=
E - 1;
> +	}
> +
> +	spi_imx->dma_data =3D kmalloc_array(spi_imx->dma_package_num,
> +					  sizeof(struct dma_data_package),
> +					  GFP_KERNEL | __GFP_ZERO);
> +	if (!spi_imx->dma_data) {
> +		dev_err(spi_imx->dev, "Failed to allocate DMA package buffer!\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (spi_imx->dma_package_num =3D=3D 1) {
> +		ctrl &=3D ~MX51_ECSPI_CTRL_BL_MASK;
> +		ctrl |=3D pre_bl << MX51_ECSPI_CTRL_BL_OFFSET;
> +		spi_imx->dma_data[0].cmd_word =3D ctrl;
> +		spi_imx->dma_data[0].data_len =3D transfer->len;
> +		ret =3D spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[0], tra=
nsfer->tx_buf,
> +						 word_delay);
> +		if (ret) {
> +			kfree(spi_imx->dma_data);
> +			return ret;
> +		}
> +	} else {
> +		ctrl &=3D ~MX51_ECSPI_CTRL_BL_MASK;
> +		ctrl |=3D pre_bl << MX51_ECSPI_CTRL_BL_OFFSET;
> +		spi_imx->dma_data[0].cmd_word =3D ctrl;
> +		spi_imx->dma_data[0].data_len =3D DIV_ROUND_DOWN_ULL(transfer->len,
> +								   MX51_ECSPI_CTRL_MAX_BURST)
> +								   * MX51_ECSPI_CTRL_MAX_BURST;
> +		ret =3D spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[0], tra=
nsfer->tx_buf,
> +						 false);
> +		if (ret) {
> +			kfree(spi_imx->dma_data);
> +			return ret;
> +		}
> +
> +		ctrl &=3D ~MX51_ECSPI_CTRL_BL_MASK;
> +		ctrl |=3D tail_bl << MX51_ECSPI_CTRL_BL_OFFSET;
> +		spi_imx->dma_data[1].cmd_word =3D ctrl;
> +		spi_imx->dma_data[1].data_len =3D transfer->len % MX51_ECSPI_CTRL_MAX_=
BURST;
> +		ret =3D spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[1],
> +						 transfer->tx_buf + spi_imx->dma_data[0].data_len,
> +						 false);
> +		if (ret) {
> +			kfree(spi_imx->dma_data[0].dma_tx_buf);
> +			kfree(spi_imx->dma_data[0].dma_rx_buf);
> +			kfree(spi_imx->dma_data);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
> +			      struct dma_data_package *dma_data,
>  			      struct spi_transfer *transfer)
>  {
> -	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
>  	struct spi_controller *controller =3D spi_imx->controller;
>  	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
>  	unsigned long transfer_timeout;
> @@ -1451,9 +1716,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *=
spi_imx,
>  	 * The TX DMA setup starts the transfer, so make sure RX is configured
>  	 * before TX.
>  	 */
> -	desc_rx =3D dmaengine_prep_slave_sg(controller->dma_rx,
> -					  rx->sgl, rx->nents, DMA_DEV_TO_MEM,
> -					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	desc_rx =3D dmaengine_prep_slave_single(controller->dma_rx, dma_data->d=
ma_rx_addr,
> +					      dma_data->dma_len, DMA_DEV_TO_MEM,
> +					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc_rx) {
>  		transfer->error |=3D SPI_TRANS_FAIL_NO_START;
>  		return -EINVAL;
> @@ -1471,9 +1736,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *=
spi_imx,
>  	reinit_completion(&spi_imx->dma_rx_completion);
>  	dma_async_issue_pending(controller->dma_rx);
>
> -	desc_tx =3D dmaengine_prep_slave_sg(controller->dma_tx,
> -					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
> -					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	desc_tx =3D dmaengine_prep_slave_single(controller->dma_tx, dma_data->d=
ma_tx_addr,
> +					      dma_data->dma_len, DMA_MEM_TO_DEV,
> +					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc_tx)
>  		goto dmaengine_terminate_rx;
>
> @@ -1521,16 +1786,16 @@ static int spi_imx_dma_submit(struct spi_imx_data=
 *spi_imx,
>  }
>
>  static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
> -				     struct spi_transfer *transfer)
> +				     struct dma_data_package *dma_data,
> +				     bool word_delay)
>  {
> -	struct sg_table *rx =3D &transfer->rx_sg;
> -	struct scatterlist *last_sg =3D sg_last(rx->sgl, rx->nents);
> -	unsigned int bytes_per_word, i;
> +	unsigned int bytes_per_word =3D word_delay ?
> +				      spi_imx_bytes_per_word(spi_imx->bits_per_word) :
> +				      BYTES_PER_32BITS_WORD;
> +	unsigned int i;
>
> -	/* Get the right burst length from the last sg to ensure no tail data */
> -	bytes_per_word =3D spi_imx_bytes_per_word(transfer->bits_per_word);
>  	for (i =3D spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
> -		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
> +		if (!dma_data->dma_len % (i * bytes_per_word))
>  			break;
>  	}
>  	/* Use 1 as wml in case no available burst length got */
> @@ -1540,25 +1805,29 @@ static void spi_imx_dma_max_wml_find(struct spi_i=
mx_data *spi_imx,
>  	spi_imx->wml =3D i;
>  }
>
> -static int spi_imx_dma_configure(struct spi_controller *controller)
> +static int spi_imx_dma_configure(struct spi_controller *controller, bool=
 word_delay)
>  {
>  	int ret;
>  	enum dma_slave_buswidth buswidth;
>  	struct dma_slave_config rx =3D {}, tx =3D {};
>  	struct spi_imx_data *spi_imx =3D spi_controller_get_devdata(controller);
>
> -	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
> -	case 4:
> +	if (word_delay) {
> +		switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
> +		case 4:
> +			buswidth =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			break;
> +		case 2:
> +			buswidth =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> +			break;
> +		case 1:
> +			buswidth =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
>  		buswidth =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		break;
> -	case 2:
> -		buswidth =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> -		break;
> -	case 1:
> -		buswidth =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> -		break;
> -	default:
> -		return -EINVAL;
>  	}
>
>  	tx.direction =3D DMA_MEM_TO_DEV;
> @@ -1584,15 +1853,17 @@ static int spi_imx_dma_configure(struct spi_contr=
oller *controller)
>  	return 0;
>  }
>
> -static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
> -				struct spi_transfer *transfer)
> +static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
> +					struct dma_data_package *dma_data,
> +					struct spi_transfer *transfer,
> +					bool word_delay)
>  {
>  	struct spi_controller *controller =3D spi_imx->controller;
>  	int ret;
>
> -	spi_imx_dma_max_wml_find(spi_imx, transfer);
> +	spi_imx_dma_max_wml_find(spi_imx, dma_data, word_delay);
>
> -	ret =3D spi_imx_dma_configure(controller);
> +	ret =3D spi_imx_dma_configure(controller, word_delay);
>  	if (ret)
>  		goto dma_failure_no_start;
>
> @@ -1603,10 +1874,17 @@ static int spi_imx_dma_transfer(struct spi_imx_da=
ta *spi_imx,
>  	}
>  	spi_imx->devtype_data->setup_wml(spi_imx);
>
> -	ret =3D spi_imx_dma_submit(spi_imx, transfer);
> +	ret =3D spi_imx_dma_submit(spi_imx, dma_data, transfer);
>  	if (ret)
>  		return ret;
>
> +	/* Trim the DMA RX buffer and copy the actual data to rx_buf */
> +	dma_sync_single_for_cpu(controller->dma_rx->device->dev, dma_data->dma_=
rx_addr,
> +				dma_data->dma_len, DMA_FROM_DEVICE);
> +	spi_imx_dma_rx_data_handle(spi_imx, dma_data, transfer->rx_buf + spi_im=
x->rx_offset,
> +				   word_delay);
> +	spi_imx->rx_offset +=3D dma_data->data_len;
> +
>  	return 0;
>  /* fallback to pio */
>  dma_failure_no_start:
> @@ -1614,6 +1892,60 @@ static int spi_imx_dma_transfer(struct spi_imx_dat=
a *spi_imx,
>  	return ret;
>  }
>
> +static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
> +				struct spi_transfer *transfer)
> +{
> +	bool word_delay =3D transfer->word_delay.value !=3D 0;
> +	int ret;
> +	int i;
> +
> +	ret =3D spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
> +	if (ret < 0) {
> +		transfer->error |=3D SPI_TRANS_FAIL_NO_START;
> +		dev_err(spi_imx->dev, "DMA data prepare fail\n");
> +		goto fallback_pio;
> +	}
> +
> +	spi_imx->rx_offset =3D 0;
> +
> +	/* Each dma_package performs a separate DMA transfer once */
> +	for (i =3D 0; i < spi_imx->dma_package_num; i++) {
> +		ret =3D spi_imx_dma_map(spi_imx, &spi_imx->dma_data[i]);
> +		if (ret < 0) {
> +			transfer->error |=3D SPI_TRANS_FAIL_NO_START;
> +			dev_err(spi_imx->dev, "DMA map fail\n");
> +			break;
> +		}
> +
> +		/* Update the CTRL register BL field */
> +		writel(spi_imx->dma_data[i].cmd_word, spi_imx->base + MX51_ECSPI_CTRL);
> +
> +		ret =3D spi_imx_dma_package_transfer(spi_imx, &spi_imx->dma_data[i],
> +						   transfer, word_delay);
> +
> +		/* Whether the dma transmission is successful or not, dma unmap is nec=
essary */
> +		spi_imx_dma_unmap(spi_imx, &spi_imx->dma_data[i]);
> +
> +		if (ret < 0) {
> +			dev_dbg(spi_imx->dev, "DMA %d transfer not really finish\n", i);
> +			break;
> +		}
> +	}
> +
> +	for (int j =3D 0; j < spi_imx->dma_package_num; j++) {
> +		kfree(spi_imx->dma_data[j].dma_tx_buf);
> +		kfree(spi_imx->dma_data[j].dma_rx_buf);
> +	}
> +	kfree(spi_imx->dma_data);
> +
> +fallback_pio:
> +	/* If no any dma package data is transferred, fallback to PIO mode tran=
sfer */
> +	if ((transfer->error & SPI_TRANS_FAIL_NO_START) && i !=3D 0)
> +		transfer->error &=3D !SPI_TRANS_FAIL_NO_START;
> +
> +	return ret;
> +}
> +
>  static int spi_imx_pio_transfer(struct spi_device *spi,
>  				struct spi_transfer *transfer)
>  {
> @@ -1780,9 +2112,14 @@ static int spi_imx_transfer_one(struct spi_control=
ler *controller,
>  	 * transfer, the SPI transfer has already been mapped, so we
>  	 * have to do the DMA transfer here.
>  	 */
> -	if (spi_imx->usedma)
> -		return spi_imx_dma_transfer(spi_imx, transfer);
> -
> +	if (spi_imx->usedma) {
> +		ret =3D spi_imx_dma_transfer(spi_imx, transfer);
> +		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
> +			spi_imx->usedma =3D false;
> +			return spi_imx_pio_transfer(spi, transfer);
> +		}
> +		return ret;
> +	}
>  	/* run in polling mode for short transfers */
>  	if (transfer->len =3D=3D 1 || (polling_limit_us &&
>  				   spi_imx_transfer_estimate_time_us(transfer) < polling_limit_us))
> --
> 2.34.1
>
>
>

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--q4l3xer6hebjjxfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmklnKcACgkQDHRl3/mQ
kZz/JQf+JXu6rz8547a+09a4/r+2bzHTsaEdTgmiUrVmD0Y6iYQGV00SPX9uFOLs
0+jXCQ+SlKbaVBRp3/15cB2yM2C+bj1nasQHAQJDsqqRrLlDUggAS+GdJMSaTqC7
O6zYNC4M7oHug+xShqVdoP0RYy57JH17YCn8W/Hg9xJDinZr+hlWryPq1WOycE/p
DAVkJ3LkByVYOXLzuctHEXuIprWnHVd1QB9X8zh1mSnJBqzo1ckZQr/r+WRPCeVe
OP1GLlw50Ov7RBJNIq2ZX3Nysfkw/YLTIw7hl50Vntg+huiyxMdgMZJFwhDBqlKj
iiBMrQqNUuA4BcsQENs7L3G6pU8ySQ==
=JfAc
-----END PGP SIGNATURE-----

--q4l3xer6hebjjxfu--

