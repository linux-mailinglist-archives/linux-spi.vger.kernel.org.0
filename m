Return-Path: <linux-spi+bounces-11569-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0F3C88A19
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D187D3A4D60
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEFC3164AD;
	Wed, 26 Nov 2025 08:28:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B0313542
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145702; cv=none; b=Akwu+A1VP0q8YODBu3DvwwSP+LEqa1VS5hHcBY1N/10Yvsjrzq3sa6AeC9LDr9In8tgbsdTLE4ELhcrRZZYv9oY9VR9lQpu9P3fx7ilZjnTA0yuSd5ldXkXoGABpTPiXDoo2lEk1nmntTTxM0LSrkaupYBFycBT3Dt+VK+yZs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145702; c=relaxed/simple;
	bh=QfaziTIYwkrdA6YGurnd9flIV+dKxeTnNUsuIR64KcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiNR7sE0cy25/YSheP78YggBPsPKq+z5inPWN2BeJxjcSNGtC7UrZO1SxTZ/AtUjNiAUnxdPMJommQiBXkiKangu9sRViOMS+dwWWpAu3JGpHn9ALGNn791HYBPwDcla5z6pNa9bw3CQvI7/Wjc9ZPso1xvRyqc2jAB4n19RAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOAsY-0004Qm-Nb; Wed, 26 Nov 2025 09:27:58 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOAsY-002ZNZ-1D;
	Wed, 26 Nov 2025 09:27:58 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0AA654A8777;
	Wed, 26 Nov 2025 08:27:58 +0000 (UTC)
Date: Wed, 26 Nov 2025 09:27:57 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, frank.li@nxp.com, hawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Message-ID: <20251126-mahogany-skunk-of-drama-db31a4-mkl@pengutronix.de>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4hjbx2irqvvat5x"
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-6-carlos.song@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--g4hjbx2irqvvat5x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
MIME-Version: 1.0

On 25.11.2025 18:06:17, Carlos Song wrote:
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

What mathematical operation do you want to do? Why do you use a 64 bit
div? What about round_down()?

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

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g4hjbx2irqvvat5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkmugoACgkQDHRl3/mQ
kZyWNAf+K5eKOV4TqXkru0o/0ioKcGiOyHCNG4orbrveC7s91tpLwqmZ5BnxW6zh
CU3PCB1xfFfOOBBkhMtmLKJrjDGMEEPAv8ZYZySKH8PrSV04czTCaCHmFrsi1+9j
EKEJc/0EvPKALotAz9k8PrfUtOxZQtt+ozejifnoK/eMEnh9NB1iY+khzy0uAQ9i
DqiYGQMu0Px+LRbkEv/GbRaanHuOD70wg5SoS59K8hSelfysL2a+lEuUoH0gfA7x
qti/ubvPD6gRj7bv4+cWn2927Y7QwG/Ng2pmZkoagzS6b7g4mWcJP/AJnEzdFQrj
6BbqfQrjlFqilnlbZCDeoJH/IujI2w==
=DTVR
-----END PGP SIGNATURE-----

--g4hjbx2irqvvat5x--

