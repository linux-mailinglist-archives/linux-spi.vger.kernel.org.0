Return-Path: <linux-spi+bounces-4903-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6588797D706
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DF81C216B1
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165617BB32;
	Fri, 20 Sep 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5ALdZMB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A717A924
	for <linux-spi@vger.kernel.org>; Fri, 20 Sep 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843347; cv=none; b=gG0yDJ1CKlKgz48vVNucVZ944RL0oCiZunfzdIInTLoMGwP4L4e0f4slSIpitG0ZaU1w578WPpXjq6M57nGW+24YLEPzelDCXilPNeYDEEAU+PBhKjd25mWMTRagAGStNs6DLg3rLZg4WmQXR07/J2tiiPbfARFf+niDkiUubgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843347; c=relaxed/simple;
	bh=Byzt261dQ/GR0ge5mgHVVMKv2pKoBD8K6PZ6vkTEjpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmffIcD3o7RymgLDd2QFGrSG3SNLhbN37w+bVHFkh/hijjcqPW3cTGjw7YUZ8a5fRD6ND/2CExf2KqMqGafR27OCRiGy+WoShSCWBEW1kFtATH1ZVedCZLKvr7zkHXTJE84mqSoXU7ABzYA1gGYMUevJVcwqGKlF71Loh0IyO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5ALdZMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F817C4CEC3;
	Fri, 20 Sep 2024 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726843347;
	bh=Byzt261dQ/GR0ge5mgHVVMKv2pKoBD8K6PZ6vkTEjpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5ALdZMB9sxFhfVJojkkcFCVh1m+QyOaHtb3W8QWp8mYqWSqkmnbCkt2fVHeCY1Sd
	 plMzzveNUf1StABzr6xfiIz1yXkfWMpZjWXb41q+A91+qU8VXrgBdkUVjZEfUvSXxd
	 5aXRPmzD1fM58mcPgYeoGochH0vcRJtzEkCx1CO+7eg5LMF0tlIGz5hM54y2615spK
	 MpoeadzQA5BZGjK5nd7GdDeACnQmn4HxqTXAEYSO62Z609l7JDHGN6jRDBHnRvk6Sw
	 B47Lf0V6VyGRCIWvotBqegFWbMNb1lwoc6ARh8DD4+xZMYjV5vLYzPnTEb6od6EEcq
	 E5MvYsYewZV2w==
Date: Fri, 20 Sep 2024 16:42:24 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v2 2/2] spi: airoha: do not keep {tx,rx} dma buffer
 always mapped
Message-ID: <Zu2J0CtZh0K0xrDJ@lore-desk>
References: <20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org>
 <20240919-airoha-spi-fixes-v2-2-cb0f0ed9920a@kernel.org>
 <Zu2D6sS52DjVhWBq@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjTKbbGz/7+vpOLe"
Content-Disposition: inline
In-Reply-To: <Zu2D6sS52DjVhWBq@smile.fi.intel.com>


--pjTKbbGz/7+vpOLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 20, Andy Shevchenko wrote:
> On Thu, Sep 19, 2024 at 06:57:17PM +0200, Lorenzo Bianconi wrote:
> > DMA map txrx_buf on demand in airoha_snand_dirmap_read and
> > airoha_snand_dirmap_write routines and do not keep it always mapped.
> > This patch is not fixing any bug or introducing any functional change
> > to the driver, it just simplifies the code and improve code readability
> > without introducing any performance degradation according to the results
> > obtained from the mtd_speedtest kernel module test.
>=20
> ...
>=20
> > +	dma_addr =3D dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SI=
ZE,
> > +				  DMA_FROM_DEVICE);
> > +	if (dma_mapping_error(as_ctrl->dev, dma_addr))
> > +		return -ENOMEM;
>=20
> Shouldn't this be
>=20
> 	err =3D dma_mapping_error(as_ctrl->dev, dma_addr);
> 	if (err)
> 		return err;
>=20
> ?
>=20
> ...
>=20
> > +	dma_addr =3D dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SI=
ZE,
> > +				  DMA_TO_DEVICE);
> > +	if (dma_mapping_error(as_ctrl->dev, dma_addr))
> > +		return -ENOMEM;
>=20
> Ditto.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

ack, I will fix it in v3.

Rergards,
Lorenzo

--pjTKbbGz/7+vpOLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZu2JzwAKCRA6cBh0uS2t
rMDqAP9vNRdg/h86aMIz+MIO0oeMbw/00o1VpEWcFMIdRv+4IgD/atNg1EU3qL5d
jC/aN8OCB4xEhNztf9ICc7I6pw7Yjwg=
=/xyN
-----END PGP SIGNATURE-----

--pjTKbbGz/7+vpOLe--

