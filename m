Return-Path: <linux-spi+bounces-11262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3FAC65903
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 18:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 569343560A0
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456632C08AC;
	Mon, 17 Nov 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4SpzHry"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132731DF27D;
	Mon, 17 Nov 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400362; cv=none; b=jska19r/48zEFrKmaXyq0PoicpVCgsaZqG0nswAUjy/knayP86vc8o3e6IN98S8K/JV8hBctJAnoNMWYEDlRlwTYQ+7bsmLUgZKxYQLRyXFC14Bi1QVhEmnW4Z75jthGaqmC4Yu7I8MiqZXdtjjVOJd5KI3GI9X8NljEnhlTz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400362; c=relaxed/simple;
	bh=yKuOcA1E6JYLWEtbHHE6NrpR/zqdElFzEm6ItyaPGGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeojmJN6wCTHZ1LpbJgHTHzuQwRopDs/9qU8T1lnDrEy8cXIGqsKv1v6zw427ga0bqfIkCio4Cg0smOH6N9GRO7HAx0p4JOCeQz6T9whPmrVkZGSxf7RQ0CvRvSGh81fOKXTPtyPdMSds2+1IHfAYSHiVFC8txmcc0L1y65UKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4SpzHry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07559C2BCB3;
	Mon, 17 Nov 2025 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763400359;
	bh=yKuOcA1E6JYLWEtbHHE6NrpR/zqdElFzEm6ItyaPGGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4SpzHryZiMx3688QfU+siCjFVkFAEXdYqon6LXmIkdT3zsRi0txqCbzoQeYsN16D
	 C0kUZ1Ixmb/l85+Zz6Y/vUs8QSuwog9vbMMPPBesMuIbvthyTIBbtQpkyJORRsF+lb
	 VPKc26BqXvzieshaQ0HlGMW76CIBF4HLMqSYF3icQHmD/9QmeWFpfUfliYCigVCeku
	 zUgOkga2daiCwo42Sq4JpE/HrrnIS22zqOXUzYRZcEOjctdoasyjI2fTyxMxUp5M/x
	 aMtCjW4rLte0x5aq24yGkgnj0go4mmNx2ccqeV/tn1VX3QbntUi5LKSWzo1nU12lXV
	 mRmxo8hh7Thgg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 5CDA01ACCCAA; Mon, 17 Nov 2025 17:25:55 +0000 (GMT)
Date: Mon, 17 Nov 2025 17:25:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] spi: add driver for NXP XSPI controller
Message-ID: <aRtao9FoPug78T93@sirena.co.uk>
References: <20251117-xspi-v2-0-e651323993fe@nxp.com>
 <20251117-xspi-v2-2-e651323993fe@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwvwRa94OgcAe6fn"
Content-Disposition: inline
In-Reply-To: <20251117-xspi-v2-2-e651323993fe@nxp.com>
X-Cookie: marriage, n.:


--rwvwRa94OgcAe6fn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 07:04:25PM +0800, Haibo Chen wrote:

> Add driver support for NXP XSPI controller.
>=20
> XSPI is a flexsible SPI host controller which supports up to
> 2 external devices (2 CS). It support Single/Dual/Quad/Octal
> mode data transfer.

This looks pretty good, a couple of small points:

> +static irqreturn_t nxp_xspi_irq_handler(int irq, void *dev_id)
> +{
> +	struct nxp_xspi *xspi =3D dev_id;
> +	u32 reg;
> +
> +	/* Clear interrupt */
> +	reg =3D readl(xspi->iobase + XSPI_FR);
> +	writel(XSPI_FR_TFF, xspi->iobase + XSPI_FR);
> +
> +	if (reg & XSPI_FR_TFF)
> +		complete(&xspi->c);
> +
> +	return IRQ_HANDLED;
> +}

This just unconditionally acks interrupts without checking if there was
actually anything there - that means that if some design shares the
interrupt or it spuriously fires then the interrupt core won't handle
things properly.  The driver should really return IRQ_NONE if there is
no interrupt pending.

> +		WARN_ON(!(reg & XSPI_FR_TBFF));
> +		if (i =3D=3D ALIGN_DOWN(op->data.nbytes, 4)) {
> +			/* Use 0xFF for extra bytes */
> +			left =3D 0xFFFFFFFF;
> +			/* The last 1 to 3 bytes */
> +			memcpy((u8 *)&left, buf + i, op->data.nbytes - i);
> +			writel(left, base + XSPI_TBDR);
> +		} else
> +			writel(*(u32 *)(buf + i), base + XSPI_TBDR);

If one side of the if has { } they both should.

--rwvwRa94OgcAe6fn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkbWqIACgkQJNaLcl1U
h9Cj1Qf/R8qxjz0qsI4C3BoN6FDOe28ICoQTHqVmPLMIpfom3TcZClQiO7IVXRUk
W8dFn7GPJqSo5ZhFrPceTTFMUVUXqXu+/QQwChY52k+7kIGfnVIUDBDZH0nQ+P7n
W1LRdzEW0cVyHFWE7M2KZXLV4Ff3b3DugtyEklo1sWSCB9VHzqJMU+gInqxQPkBX
6LWXKffPhTbOiXK2zbIr2GIECTRj16EI9K8OxKVI1Nn7t9rMHX4bxAu/D3CJ4CcS
LAjvJFFnFvOFrG4OcXhK5ed2EV1bTilll1Wzbg+H11QmcfFeVmkz6EmDAvaskaYH
q841AnbKzH5h/s6mjO7Ts88s1OYEWg==
=7syi
-----END PGP SIGNATURE-----

--rwvwRa94OgcAe6fn--

