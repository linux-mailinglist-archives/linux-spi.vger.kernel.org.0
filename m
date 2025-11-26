Return-Path: <linux-spi+bounces-11570-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D3C88A70
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BEAE4E70B1
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9DF29C339;
	Wed, 26 Nov 2025 08:31:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E482253E4
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145889; cv=none; b=YFcdRoCmQTRUuIL19MvOd+O+dm/SxIaRfzheYt1L1euN0Q0WmHv48CcY/jcP1intoWKy3bTy+AP7PWIGJE9QEqIB/3/pEQGxelEMZHBnWoKr67adJEcb7rXJXsNuNEGc0fwIQ351Vb0AmWKz6oNM+KuROWOUjH1kuJbjTnPHQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145889; c=relaxed/simple;
	bh=zcppcshWo0vaFb5TzTeiTMM3mtIPu4qQVxJXTxE4fq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4qO9KW/+YXlw/nFNHafGktxgTAggvjnchpvzU2DAislsCaq1REtSzCeL0qHyZnX6399mUUs/5X4UKn8Bwyi/oqdF48OinJ/6x3V6kTMMxntJJtcg/uwyN2lnl7faJr7u2lIjkLXFA+1+jRYoKYupJkwLnxq3yrMRHoblqcgPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOAvl-0004iV-Ll; Wed, 26 Nov 2025 09:31:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOAvl-002ZO1-16;
	Wed, 26 Nov 2025 09:31:17 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F26594A877F;
	Wed, 26 Nov 2025 08:31:16 +0000 (UTC)
Date: Wed, 26 Nov 2025 09:31:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Carlos Song <carlos.song@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"hawnguo@kernel.org" <hawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Message-ID: <20251126-colorful-finch-of-joviality-aee641-mkl@pengutronix.de>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251125-impartial-porcupine-of-courtesy-841990-mkl@pengutronix.de>
 <VI2PR04MB11147F814915ECCB6AE36F0F9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bczuxvqz7finyyoa"
Content-Disposition: inline
In-Reply-To: <VI2PR04MB11147F814915ECCB6AE36F0F9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--bczuxvqz7finyyoa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
MIME-Version: 1.0

On 26.11.2025 07:42:36, Carlos Song wrote:

[...]

> > > +			if (bytes_per_word =3D=3D 1)
> > > +				swab32s(temp + i);
> > > +			else if (bytes_per_word =3D=3D 2)
> > > +				swahw32s(temp + i);
> >
> > Why do you do first a swap in place and then a memcpy()
> >
> When dynamic burst enabled, DMA copy data always using buswidth=3D4 bytes.
> CPU is little endian so bytes order actually little endian in dma_buf.
> But for bytes_per_word=3D1, every bytes should be the same order with mem=
 order, it should be big endian so swap every bytes.
> In the same reason, bytes per word =3D 2, swap half word.
> Bytes per word =3D 4 don't need do any thing.
> (SPI is not ruled bytes order, so SPI bytes order always follow CPU bytes=
 order, here still follow)

Thanks for the explanation. I think my question was not completely
clear. I want to know why you touch every byte twice, first you do the
swap on the existing buffer, then you do a memcpy(). You might do both
operations in one go, i.e. read the bytes from the original buffer and
write them swapped to the bounce buffer.

> > > +		}
> > > +	}
> > > +#endif
> > > +
> > > +	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
> >
> > I think this deserves a comment, why you do a re-alignment of the data =
here.
> >
> Yes. I can add one comment here.
>
> In fact it is not re-alignment, it is trim data.
> When dynamic burst enabled, DMA copy data always using bus width=3D4 byte=
s.
> So DMA always get 4 bytes data from RXFIFO. But if data lens is not 4-byt=
e alignment,
> the data in the DMA bounce buffer contains extra garbage bytes, so it nee=
ds to be trimmed before memcopy to xfer buffer.
>
> Why is the first word?
> It is from HW behavior. When dynamic burst enabled, BURST_LENGTH will be =
set same with actual data len,
> It helps maintain correct bit count.
>
> As RM shows:
> "
> In master mode, it controls the number of bits per SPI burst. Since the s=
hift register always loads 32-bit
> data from transmit FIFO, only the n least-significant (n =3D BURST LENGTH=
 + 1) will be shifted out. The
> remaining bits will be ignored.
>
> Number of Valid Bits in a SPI burst.
>
> 0x000 A SPI burst contains the 1 LSB in a word.
> 0x001 A SPI burst contains the 2 LSB in a word.
> 0x002 A SPI burst contains the 3 LSB in a word.
> ...
> 0x01F A SPI burst contains all 32 bits in a word.
> 0x020 A SPI burst contains the 1 LSB in first word and all 32 bits in sec=
ond word.
> 0x021 A SPI burst contains the 2 LSB in first word and all 32 bits in sec=
ond word.
> "
> When data len is not 4 bytes-align, so the first word is always include s=
ome garbage bytes(if transfer 7 bytes. first word include one garbage byte =
and 3 valid bytes, four bytes in second word).
>
> > > +		unaligned =3D dma_data->data_len % BYTES_PER_32BITS_WORD;
> > > +		copy_ptr =3D (u8 *)dma_data->dma_rx_buf +
> > BYTES_PER_32BITS_WORD - unaligned;
> > > +	} else {
> > > +		copy_ptr =3D dma_data->dma_rx_buf;
> >
> > Why do you use the bounce buffer if the data is aligned correct?
> >
> Whatever data is 4 bytes align, when CPU is little endian, bytes swap sho=
uld be done additionally according to different bytes per word setting.

But for 32 bits per word or word delay you do a not needed bounce
buffers and memcpy()?

We still need the bounce buffer for length not multiple of 4, because a
direct DMA write would overflow the destination buffer, right? And of
course bounce buffers for LE 8 and 16 bit per word for the byte
swapping.

> Summary whole solution about dynamic burst for DMA mode:
> 1. Always read/write SPI FIFO with DMA buswidth =3D 4, so DMA bounce buff=
er always 4-bytes alignment:
>   swap bytes/half word according to bytes per word=3D8/16 when in CPU lit=
tle endian.
> 2. BURST_LENGTH setting is important, it helps maintain correct bit count=
(HW trim: don't shift out bits to TXFIFO also don't shift in bits in RXFIFO=
):
>   * TX: Although DMA put 4 byte-alignment data to FIFO, but in bounce buf=
fer we put valid data in valid LSB of first word, it can make sure ECSPI on=
ly shift out valid data in bonus buffer.
>   * RX: Although DMA get 4bytes- alignment data from RXFIFO to bounce buf=
fer, but trim it with valid LSB according actual xfer->len, it can make rx_=
buf is right data.
>
> > > +	}
> > > +
> > > +	memcpy(rx_buf, copy_ptr, dma_data->data_len); }
> > > +
> > > +static int spi_imx_dma_map(struct spi_imx_data *spi_imx,
> > > +			   struct dma_data_package *dma_data) {
> > > +	struct spi_controller *controller =3D spi_imx->controller;
> > > +	struct device *tx_dev =3D controller->dma_tx->device->dev;
> > > +	struct device *rx_dev =3D controller->dma_rx->device->dev;
> > > +
> > > +	dma_data->dma_tx_addr =3D dma_map_single(tx_dev,
> > dma_data->dma_tx_buf,
> > > +
> > DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> > > +					       DMA_TO_DEVICE);
> > > +	if (dma_mapping_error(tx_dev, dma_data->dma_tx_addr)) {
> > > +		dev_err(spi_imx->dev, "DMA TX map failed\n");
> > > +		return -EINVAL;
> >
> > please propagate the error value of dma_mapping_error()
> >
>
> Will do this in V2
> > > +	}
> > > +
> > > +	dma_data->dma_rx_addr =3D dma_map_single(rx_dev,
> > dma_data->dma_rx_buf,
> > > +
> > DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> > > +					       DMA_FROM_DEVICE);
> > > +	if (dma_mapping_error(rx_dev, dma_data->dma_rx_addr)) {
> > > +		dev_err(spi_imx->dev, "DMA RX map failed\n");
> > > +		goto rx_map_err;
> >
> > there's only one user of the dma_unmap_single(), so no need for the got=
o.
> >
> This goto is to unmap previous TX, not this RX. TX has been mapped then s=
tart to map RX, now RX mapping error, Do we really don't need to
> rollback for TX?

Sorry there was a misunderstanding, I mean you should directly call
dma_unmap_single() and remove the goto.

>
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +rx_map_err:
> > > +	dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
> > > +			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
> > > +			 DMA_TO_DEVICE);
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static int spi_imx_dma_tx_data_handle(struct spi_imx_data *spi_imx,
> > > +				      struct dma_data_package *dma_data,
> > > +				      const void *tx_buf,
> > > +				      bool word_delay)
> > > +{
> > > +#ifdef __LITTLE_ENDIAN
> > > +	unsigned int bytes_per_word =3D
> > spi_imx_bytes_per_word(spi_imx->bits_per_word);
> > > +	u32 *temp;
> > > +#endif
> >
> > move into scope of if()
> >
> Will do this in V2.
> > > +	void *copy_ptr;
> > > +	int unaligned;
> > > +
> > > +	if (word_delay) {
> > > +		dma_data->dma_len =3D dma_data->data_len;
> > > +	} else {
> > > +		/*
> > > +		 * As per the reference manual, when burst length =3D 32*n + m bit=
s,
> > ECSPI
> > > +		 * sends m LSB bits in the first word, followed by n full 32-bit w=
ords.
> > > +		 * Since actual data may not be 4-byte aligned, allocate DMA TX/RX
> > buffers
> > > +		 * to ensure alignment. For TX, DMA pushes 4-byte aligned words to
> > TXFIFO,
> > > +		 * while ECSPI uses BURST_LENGTH settings to maintain correct bit
> > count.
> > > +		 * For RX, DMA receives 32-bit words from RXFIFO; after transfer
> > completes,
> > > +		 * trim the DMA RX buffer and copy the actual data to rx_buf.
> > > +		 */
> >
> > Ahh, please add the corresponding description for rx.
> >
> Will do this in V2.
> > > +		dma_data->dma_len =3D ALIGN(dma_data->data_len,
> > BYTES_PER_32BITS_WORD);
> > > +	}
> > > +
> > > +	dma_data->dma_tx_buf =3D kmalloc(dma_data->dma_len, GFP_KERNEL |
> > > +__GFP_ZERO);
> >
> > kzalloc()?
> >
> Yes. Will do this in V2
> > > +	if (!dma_data->dma_tx_buf)
> > > +		return -ENOMEM;
> > > +
> > > +	dma_data->dma_rx_buf =3D kmalloc(dma_data->dma_len, GFP_KERNEL |
> > __GFP_ZERO);
> > > +	if (!dma_data->dma_rx_buf) {
> > > +		kfree(dma_data->dma_tx_buf);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
> > > +		unaligned =3D dma_data->data_len % BYTES_PER_32BITS_WORD;
> > > +		copy_ptr =3D (u8 *)dma_data->dma_tx_buf +
> > BYTES_PER_32BITS_WORD - unaligned;
> > > +	} else {
> > > +		copy_ptr =3D dma_data->dma_tx_buf;
> > > +	}
> > > +
> > > +	memcpy(copy_ptr, tx_buf, dma_data->data_len);
> > > +
> > > +	/*
> > > +	 * When word_delay is enabled, DMA transfers an entire word in one
> > minor loop.
> > > +	 * In this case, no data requires additional handling.
> > > +	 */
> > > +	if (word_delay)
> > > +		return 0;
> > > +
> > > +#ifdef __LITTLE_ENDIAN
> > > +	/*
> > > +	 * On little-endian CPUs, adjust byte order:
> > > +	 * - Swap bytes when bpw =3D 8
> > > +	 * - Swap half-words when bpw =3D 16
> > > +	 * This ensures correct data ordering for DMA transfers.
> > > +	 */
> > > +	temp =3D dma_data->dma_tx_buf;
> > > +	for (int i =3D 0; i < DIV_ROUND_UP(dma_data->dma_len,
> > BYTES_PER_32BITS_WORD); i++) {
> > > +		if (bytes_per_word =3D=3D 1)
> > > +			swab32s(temp + i);
> > > +		else if (bytes_per_word =3D=3D 2)
> > > +			swahw32s(temp + i);
> > > +	}
> > > +#endif
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int spi_imx_dma_data_prepare(struct spi_imx_data *spi_imx,
> > > +				    struct spi_transfer *transfer,
> > > +				    bool word_delay)
> > > +{
> > > +	u32 pre_bl, tail_bl;
> > > +	u32 ctrl;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * ECSPI supports a maximum burst of 512 bytes. When xfer->len exce=
eds
> > 512
> > > +	 * and is not a multiple of 512, a tail transfer is required. In th=
is case,
> > > +	 * an extra DMA request is issued for the remaining data.
> >
> > Why do you need an extra transfer in this case?
> >
>
> BURST_LEGTH is used for SPI HW to maintain correct bit count. So BURST_LE=
NGTH should update with
> data length. After DMA request submit, SPI can not update the BURST_LENGT=
H, when needed, we must
> split two package, update the register then setup second DMA transfer.
>
> ECSPI HW can update BURST_LENGTH auto, but it always update this using pr=
evious value.
> When len > 512 but len is not 512-unaligned, we need two packages, second=
 for tail data.
> For example len is 512 *3 + 511. So first transfer using BURST_LENGTH =3D=
 512 bytes(auto update 3 times), DMA transfer len =3D 512 *3,
> second package BURST_LENGTH =3D 511 bytes, DMA transfer len =3D 511.(If h=
ere we use 512 bytes as BURST_LENGTH,
> SPI will shift out/in extra bits, it previous isn't acceptable!)

What happens if you keep the Burst Length at 512 and only transfer 511
bytes with the DMA engine?

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bczuxvqz7finyyoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkmutEACgkQDHRl3/mQ
kZygLQgAmgHEVjlvhBDRYgFFC/TYfC2hzTHaBDDAjwn7eq1tbsOnw03qsh44n053
Pc+u9D5vZ54008638fjUOekzalGLjWeyswd1I+fkhhr4ueHRBsBCjw7hRG66pxfg
bHTmFhtgifQAGae0b+uKLR80Ncm/2wkYSSOsvk4TtgJjpvsL74ZxXyMNYwLpbgCM
goP762gj7DVt7aI69zoL4OAn9JCeKBxBRFWAgC/x+cwwsLRSwX6iiMIcJKC71nOB
Sizr1jaTBioketyU1FR2PYfiZFiaynQ1GKzgtA+oajH2+Hdio49wpH7spokScdc4
dDKgd33WgbMP0vtl6J3VS1X3dja3ZA==
=HJy4
-----END PGP SIGNATURE-----

--bczuxvqz7finyyoa--

