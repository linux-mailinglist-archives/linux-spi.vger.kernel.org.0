Return-Path: <linux-spi+bounces-6964-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA748A47BC4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110BC3B7031
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D622D7A8;
	Thu, 27 Feb 2025 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzCLin69"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79F229B00;
	Thu, 27 Feb 2025 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654848; cv=none; b=gWvZy+P5ldDK7vkdolPUsIgfpT/bkB0UdIoUlLD1MUAGJXjJsYHUBK2Uy+eEz6B5bs9MbV05rRXydh6Yxj0T9gQ9rTdoZ7dzekWIu0qxOX4TUPUFsEDU6gP94u42EtfFkiTnM4pdOMgbsU1VtjshSsIXMSVhfaM4OYVCZ7VE0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654848; c=relaxed/simple;
	bh=Ekrnx5fbIpl0evUleL8BujHd2tTUSGRRgb4QY4ju9NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Akxgtwu7TLOQPP0GsmQGb9Uk0qjRlj0f8s3Scw3MAWix8g0Pi4d69jlnRggXC9GCZu1Xr5TGOci+IPWnfPQLuDbPZTMjIv+sD+SGvo2Qtnmkl6eDGKD9Yo6i3doih2STkTqjg9yPcZnckcPhcyrMsx75HAT4FfKcjGf+mSIZirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzCLin69; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390df0138beso425443f8f.0;
        Thu, 27 Feb 2025 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740654844; x=1741259644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CRVw0gIn4OpQ8HbKnPwBb25g7TBKWI8sSY5Cw3k1mU=;
        b=PzCLin69k5GWvh87r4zMMlpwAAaq12mQ/E+EYadQm5u7X3MY/m6Pnm1PKC5KzU5ZNN
         pn9guAMs8N1ztTwGxl5LuElmUoheNYlO/psXDRv9etGN//+NegIljtm07ydz6EERkL2/
         M8OpjdvXb5RDNvx9pLwPCZ8n7pnA+E3BzIRwR3gTo9ZTnPpEOKMnBUOE6XratnqXCm6n
         Q2OcIgOkUOIrXLYKne3Fw0B3WfzmviGSEprLsF/U5cZAcl3bgX+N6gFsdbWGkK4M9cDz
         pblNagcsDrJ9sctFkfa/yOa7RhhZT2XNWgqhEj6TEsgPHBOFwCnUu91U+DXrCbly896d
         14Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740654844; x=1741259644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CRVw0gIn4OpQ8HbKnPwBb25g7TBKWI8sSY5Cw3k1mU=;
        b=ajPdRLLYAwGrpvtNT6B6per/eM/qJxoeDqwMGdXNvzUkze+8gJtiu04bu/wbCkt9iF
         z8yFRo+K5oMNoVB2rZwZLIfzYwSKoIME0kXuBen5I7j995cTgn2fl76MmINcyhNsmGP5
         vmiCbJCl7Y3rTS6gfDLer8I9ap5DE0JvJA4djHPcet/2tv6rlj0qXyxwZITdLJwEpw0k
         EGcgSr0TZEckyLJ82XjyYJOo8dKSUPc222DWWPDSCrVL9/BQpnNqjU1gg65xeJaLf+vd
         VxcHvVzbTCRGKTKW1DAJD6g6dlJY8zb4rDCtCNp93WDpL4QdSXOt8UE5pg/lAXoTbNK8
         qvXA==
X-Forwarded-Encrypted: i=1; AJvYcCVkRgdeC/sZtCVLsPWkVv53jkS34L5SVAZMBEbklDGqjq1NU8dtxH9vM/QurdlwOG0p6MVoM/U4byNEH5s=@vger.kernel.org, AJvYcCXheYEzHX8hmKipkKgVrl6VmbBGCtv1hAuaMNbTE3K/8J6qZztCVKxTGZh96gJLV4atm1CkKYcwPGrm@vger.kernel.org, AJvYcCXnC1Lw/RjHVe7QVyKx2z8dy5g+m7KuSXT1irxGoF06xJEzUoBCkwssUJY2cuqK3jnoL3Zrl0tX99tADzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQVCu02CoVqYDAGLWA3xhReN0yCi0FwSJ0AOMM58X3GDXgh5W
	A2UMmppSgK0/n7BlDR36CVCprG9JBelOl8lFzHIBd8BHu+XLiH1k
X-Gm-Gg: ASbGnctza+/45WhuhohGq+WsmhNO0XhWZl3+K9qWs+JAukOrXNiLFIXB4kmSSHQm97q
	gRw3egwKVoo+1njvJKgASY+e6xVOu+j3PhKBOwYryVyPxgiYu//svxrfSKbfMJZPp9Vhzf3hjoI
	+WYB+qEgB/Nx58bf7pqIGH4q/1H2GqcwToaI0zzuQMPjRTWsqJTtUAXH27c4usUMeuFG9R5SMOy
	20AG3ZCgvH06U3M61AZTDoFvqEV1oIpObiZJ0od0KGr8JI2VSlSeOeWO/kNT7eMCYdut8VOhdO/
	1uozocWAWHtPOaMwkYSD3z/urRBbF3qXm3Wk4Ej7+CoGHv82mFETWjdu+r2lwx8hLSeFxSeQfgA
	pQ/aZ3QvNWXJ3
X-Google-Smtp-Source: AGHT+IFOozNqVH1mjaB/9H/uwXVkMvb/m0pFAWS7y+nBf0yJGFDvEk4zb/b/Mq7IEEzzvmA3QAPEcg==
X-Received: by 2002:a5d:47c4:0:b0:390:e311:a8b9 with SMTP id ffacd0b85a97d-390e311ab0fmr1647800f8f.1.1740654844087;
        Thu, 27 Feb 2025 03:14:04 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6f22sm1672281f8f.47.2025.02.27.03.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:14:02 -0800 (PST)
Date: Thu, 27 Feb 2025 12:14:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com, 
	broonie@kernel.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH v2 6/6] spi: tegra210-quad: Introduce native DMA support
Message-ID: <dnl7ybsecsff3pv5g4kzhyvhj4yoj6nxhvc6ugmv2pw4btdg6t@dglr2hitc2nv>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
 <20250212144651.2433086-7-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvts44ydtpoohulv"
Content-Disposition: inline
In-Reply-To: <20250212144651.2433086-7-va@nvidia.com>


--uvts44ydtpoohulv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/6] spi: tegra210-quad: Introduce native DMA support
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 02:46:51PM +0000, Vishwaroop A wrote:
> Previous generations of Tegra supported DMA operations by an external
> DMA controller, but the QSPI on Tegra234 devices now have an internal
> DMA controller.
>=20
> Internal DMA: Uses the QSPI controller's built-in DMA engine, which is
> limited in capabilities and tied directly to the QSPI module.
>=20
> External DMA: Utilizes a separate, GPCDMA DMA controller that can
> transfer data between QSPI and any memory location.
>=20
> Native DMA Initialization: Introduce routines to initialize and
> configure native DMA channels for both transmit and receive paths.
> Set up DMA mapping functions to manage buffer addresses effectively.
>=20
> Enhance Transfer Logic: Implement logic to choose between CPU-based
> and DMA-based transfers based on data size.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 218 ++++++++++++++++++--------------
>  1 file changed, 126 insertions(+), 92 deletions(-)
>=20
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-q=
uad.c
> index 04f41e92c1e2..7463b00b1ffb 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -111,6 +111,9 @@
>  #define QSPI_DMA_BLK				0x024
>  #define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
> =20
> +#define QSPI_DMA_MEM_ADDRESS_REG		0x028
> +#define QSPI_DMA_HI_ADDRESS_REG			0x02c

I'd drop the _REG suffix since we don't use it on any of the other
register definitions.

> +
>  #define QSPI_TX_FIFO				0x108
>  #define QSPI_RX_FIFO				0x188
> =20
> @@ -167,9 +170,9 @@ enum tegra_qspi_transfer_type {
>  };
> =20
>  struct tegra_qspi_soc_data {
> -	bool has_dma;
>  	bool cmb_xfer_capable;
>  	bool supports_tpm;
> +	bool has_ext_dma;
>  	unsigned int cs_count;
>  };
> =20
> @@ -605,17 +608,21 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_=
qspi *tqspi, struct spi_trans
> =20
>  	len =3D DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) =
* 4;
> =20
> -	dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
> -	dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
> +	if (t->tx_buf)
> +		dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
> +	if (t->rx_buf)
> +		dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
>  }
> =20
>  static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi,=
 struct spi_transfer *t)
>  {
>  	struct dma_slave_config dma_sconfig =3D { 0 };
> +	dma_addr_t rx_dma_phys, tx_dma_phys;
>  	unsigned int len;
>  	u8 dma_burst;
>  	int ret =3D 0;
>  	u32 val;
> +	bool has_ext_dma =3D tqspi->soc_data->has_ext_dma;
> =20
>  	if (tqspi->is_packed) {
>  		ret =3D tegra_qspi_dma_map_xfer(tqspi, t);
> @@ -634,60 +641,85 @@ static int tegra_qspi_start_dma_based_transfer(stru=
ct tegra_qspi *tqspi, struct
>  		len =3D tqspi->curr_dma_words * 4;
> =20
>  	/* set attention level based on length of transfer */
> -	val =3D 0;
> -	if (len & 0xf) {
> -		val |=3D QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> -		dma_burst =3D 1;
> -	} else if (((len) >> 4) & 0x1) {
> -		val |=3D QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> -		dma_burst =3D 4;
> -	} else {
> -		val |=3D QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> -		dma_burst =3D 8;
> +	if (has_ext_dma) {
> +		val =3D 0;
> +		if (len & 0xf) {
> +			val |=3D QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> +			dma_burst =3D 1;
> +		} else if (((len) >> 4) & 0x1) {
> +			val |=3D QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> +			dma_burst =3D 4;
> +		} else {
> +			val |=3D QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> +			dma_burst =3D 8;
> +		}
> +
> +		tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
>  	}
> =20
> -	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
>  	tqspi->dma_control_reg =3D val;
> =20
>  	dma_sconfig.device_fc =3D true;
> -	if (tqspi->cur_direction & DATA_DIR_TX) {
> -		dma_sconfig.dst_addr =3D tqspi->phys + QSPI_TX_FIFO;
> -		dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		dma_sconfig.dst_maxburst =3D dma_burst;
> -		ret =3D dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> -			return ret;
> -		}
> =20
> -		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> -		ret =3D tegra_qspi_start_tx_dma(tqspi, t, len);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
> -			return ret;
> +	if ((tqspi->cur_direction & DATA_DIR_TX)) {
> +		if (has_ext_dma) {
> +			dma_sconfig.dst_addr =3D tqspi->phys + QSPI_TX_FIFO;
> +			dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dma_sconfig.dst_maxburst =3D dma_burst;
> +			ret =3D dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> +				return ret;
> +			}
> +
> +			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> +			ret =3D tegra_qspi_start_tx_dma(tqspi, t, len);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
> +				return ret;
> +			}
> +		} else {
> +			if (tqspi->is_packed)
> +				tx_dma_phys =3D t->tx_dma;
> +			else
> +				tx_dma_phys =3D tqspi->tx_dma_phys;
> +			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> +			tegra_qspi_writel(tqspi, lower_32_bits(tx_dma_phys),
> +					  QSPI_DMA_MEM_ADDRESS_REG);
> +			tegra_qspi_writel(tqspi, (upper_32_bits(tx_dma_phys) & 0xff),
> +					  QSPI_DMA_HI_ADDRESS_REG);
>  		}
>  	}
> =20
>  	if (tqspi->cur_direction & DATA_DIR_RX) {
> -		dma_sconfig.src_addr =3D tqspi->phys + QSPI_RX_FIFO;
> -		dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		dma_sconfig.src_maxburst =3D dma_burst;
> -		ret =3D dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> -			return ret;
> -		}
> -
> -		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
> -					   tqspi->dma_buf_size,
> -					   DMA_FROM_DEVICE);
> -
> -		ret =3D tegra_qspi_start_rx_dma(tqspi, t, len);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
> -			if (tqspi->cur_direction & DATA_DIR_TX)
> -				dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			return ret;
> +		if (has_ext_dma) {
> +			dma_sconfig.src_addr =3D tqspi->phys + QSPI_RX_FIFO;
> +			dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dma_sconfig.src_maxburst =3D dma_burst;
> +			ret =3D dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> +				return ret;
> +			}
> +			dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
> +						   tqspi->dma_buf_size, DMA_FROM_DEVICE);
> +			ret =3D tegra_qspi_start_rx_dma(tqspi, t, len);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
> +				if (tqspi->cur_direction & DATA_DIR_TX)
> +					dmaengine_terminate_all(tqspi->tx_dma_chan);
> +				return ret;
> +			}

Please keep the whitespace that was there before (maybe even add a few
blank lines) to make this less cluttered.

> +		} else {
> +			if (tqspi->is_packed)
> +				rx_dma_phys =3D t->rx_dma;
> +			else
> +				rx_dma_phys =3D tqspi->rx_dma_phys;
> +
> +			tegra_qspi_writel(tqspi, lower_32_bits(rx_dma_phys),
> +					  QSPI_DMA_MEM_ADDRESS_REG);
> +			tegra_qspi_writel(tqspi, (upper_32_bits(rx_dma_phys) & 0xff),
> +					  QSPI_DMA_HI_ADDRESS_REG);
>  		}

This doesn't look right. You're passing a memory buffer to hardware
here, so this needs DMA sync operations, too.

[...]
> @@ -1388,30 +1420,32 @@ static irqreturn_t handle_dma_based_xfer(struct t=
egra_qspi *tqspi)
> =20
>  	if (tqspi->cur_direction & DATA_DIR_TX) {
>  		if (tqspi->tx_status) {
> -			dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			err +=3D 1;
> -		} else {
> +			if (tqspi->tx_dma_chan)
> +				dmaengine_terminate_all(tqspi->tx_dma_chan);
> +			err++;
> +		} else if (tqspi->tx_dma_chan) {
>  			wait_status =3D wait_for_completion_interruptible_timeout(
>  				&tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
>  			if (wait_status <=3D 0) {
>  				dmaengine_terminate_all(tqspi->tx_dma_chan);
>  				dev_err(tqspi->dev, "failed TX DMA transfer\n");
> -				err +=3D 1;
> +				err++;
>  			}
>  		}
>  	}
> =20
>  	if (tqspi->cur_direction & DATA_DIR_RX) {
>  		if (tqspi->rx_status) {
> -			dmaengine_terminate_all(tqspi->rx_dma_chan);
> -			err +=3D 2;
> -		} else {
> +			if (tqspi->rx_dma_chan)
> +				dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			err++;
> +		} else if (tqspi->rx_dma_chan) {
>  			wait_status =3D wait_for_completion_interruptible_timeout(
>  				&tqspi->rx_dma_complete, QSPI_DMA_TIMEOUT);
>  			if (wait_status <=3D 0) {
>  				dmaengine_terminate_all(tqspi->rx_dma_chan);
>  				dev_err(tqspi->dev, "failed RX DMA transfer\n");
> -				err +=3D 2;
> +				err++;

Maybe we should change the "err" variable to something like "errors" or
"num_errors" to make it clear what this does. As it is, it's easily
mistaken to be a negative error code, in which case ++ wouldn't make
sense.

Thierry

--uvts44ydtpoohulv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfASPUACgkQ3SOs138+
s6E0RQ//cuWwRuiCTkAb5/B2eZCC/KjjvkHW9dO/wUUVi8mCrsQuWhzrtuAFQTER
ltITJeBg0B9L23WFeE0d5DPXWb7xx01fqML+OFJJvY3TQryora6ZBXSef4q8JbT8
GKbOdlZYI0VgWN0EComl3MeS3zgW8e7ImB+egiJsItATIUm2pqKxOJ0Q88b2WUem
25nDg62RQNHdVB8P6oogmNMVwbTTokkQkddUcIfe4EbyA6XjEBKMnKhjdaijzvHg
JcIoi6EUrwOYcpiXBxcPVo7hzi+ZA2n8auQdADM8X/ovmAd7/+CND+MbPSjGFp+9
BXhQ+0Q/Eud3HPvusgoRDXnMJ9OvcjqzEtXbFjYRowmLgDsal+5iZJmtq9EV5l7N
pcox2wsQE1ufEmC1C50DecY2APHZjSyE4Xa0dKjxXluibxbj39LSGE5qI243jOKL
XedmdnNAPnpsO35tF06aa3CiC7hVImMZj/Q3KalqLjDUBpC4koBRPKqvsrJCSKGU
Nod+2RxKzIZ5edv0i5+IJs7LR5sbQZ7Cn+Fj6XdY/Mm4sw6qZojf/wSFCGNmY0vt
iCJCPq9G4dxkuHQwI/EaoDUsjIfAABDPUEhuk8jKjlOb8V/jYNEJJMxGpW1F4koJ
qaYqUAOytJqudW++qRU7OuFHP3RIzyuVhgIQ+d41hhuxKGUkLJE=
=yq7d
-----END PGP SIGNATURE-----

--uvts44ydtpoohulv--

