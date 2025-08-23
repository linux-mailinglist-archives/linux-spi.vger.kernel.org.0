Return-Path: <linux-spi+bounces-9629-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E329B3279F
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 10:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FDB582787
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 08:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3D21D3C0;
	Sat, 23 Aug 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6DfwwQE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AB2045B6;
	Sat, 23 Aug 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755937771; cv=none; b=OzDakydqN8gSm2sf21m0Jutr9aZ9he19TFMLW01mZV8sDUKLu0eoFiknZ3cGJx1VapZwXngwKbyWU5S3qIaInLFNPRglhRdzDHETDFMT3PmhB2wj434o3/Uweq5zq6N7HsHVXADxEit3oimGsBBlITim87ePsj8158hj7ZmlZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755937771; c=relaxed/simple;
	bh=3V+aClYI3aaQ5gU13ezDYqzZA3Gf8IZDs3ACDxjVH54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/PoDN12037VtEjmtE5Go6SeX5LsVISTg5L8hZ6lUN3B0ATnUpM3ZoriOG9PHCrdEYoeJO0ICIbyv78a+kt+nAo/dEbwGV5FAOGxwB1KGJsXIthYPI8mbvNmtHGB219sy6890zpjrxqHWXsnavPHPkSHVI4d3SBtcp7gbgRrd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6DfwwQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B16C4CEE7;
	Sat, 23 Aug 2025 08:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755937770;
	bh=3V+aClYI3aaQ5gU13ezDYqzZA3Gf8IZDs3ACDxjVH54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6DfwwQEuXHptokfcHZgzpy1FPB8Lw5RAhifx7kjkok4nGqqWegfLoZfun7QAebkA
	 GAaRqU42NU7euJbXTV4l9IMSukcUTIGtxFng0dMnQep22C4rqbUwrDbBL2JnyBX7XH
	 bLjkVLqrtfWVjC2+00I0t9Crgs05tRTWr8/ZGo0NaeqEHLwxKqU0owqkHt5PcnzvA5
	 1agzOoiefZdz6m1ZTEqpBNXJCtC90Zz+47il2570TKzlrkn6XR5LKnl6yHuZQROuA/
	 fi/9X0XXUnGJC4JzRVvWRQPtrtMUYQP7fZ3dBdgharG7Z8ITCInR3yiVk3I2Z41+dg
	 FLPQM/0JXtKuQ==
Date: Sat, 23 Aug 2025 10:29:26 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/13] spi: airoha: remove unnecessary switch to
 non-dma mode
Message-ID: <aKl75s_6ueJ3Wulc@lore-rh-laptop>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823001626.3641935-5-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhtF45ahqs6p77op"
Content-Disposition: inline
In-Reply-To: <20250823001626.3641935-5-mikhail.kshevetskiy@iopsys.eu>


--AhtF45ahqs6p77op
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The code switches to dma at the start of dirmap operation and returns
> to non-dma at the end of dirmap operation, so an additional switch to
> non-dma at the start of dirmap write is not required.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/spi/spi-airoha-snfi.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> index d64a687c07de..1ebf7def7ba7 100644
> --- a/drivers/spi/spi-airoha-snfi.c
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -812,9 +812,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_m=
em_dirmap_desc *desc,
>  	int err;
> =20
>  	as_ctrl =3D spi_controller_get_devdata(spi->controller);
> -	err =3D airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
> -	if (err < 0)
> -		return err;
> =20
>  	memcpy(txrx_buf + offs, buf, len);
>  	dma_addr =3D dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
> --=20
> 2.50.1
>=20

--AhtF45ahqs6p77op
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKl75AAKCRA6cBh0uS2t
rAr3AP9T2QJKhkVGX6NfCc6oaN5Oe1P5X3lrZiNltQ+HB+JXXAEA5nwNp4mEd3JS
TXd4xaqIwU7iCVKk9KDIHkZzPeKrJwc=
=Q08H
-----END PGP SIGNATURE-----

--AhtF45ahqs6p77op--

