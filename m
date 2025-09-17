Return-Path: <linux-spi+bounces-10072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF58BB814E0
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC0E3BD38E
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565A2FE05C;
	Wed, 17 Sep 2025 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uavdsPqC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6734BA42;
	Wed, 17 Sep 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132600; cv=none; b=i2gxSroYM7lhvbuuT2dZdlaDo2yAD4l3l8FuhArqMiNVnyqJOQgWM/t+F81g9Z2rXejiexd8ttYKAjjfdKD8JFqWV+6JDtRNFAl59IkXcD4yHefwiLjGw/T6RB/bxS6NcSJ+aTeWai6W45hP/PROvY1d6J9hPyp+zSspNbmglzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132600; c=relaxed/simple;
	bh=F9+3GVUhzFcwpqijgKs+YwigkMGUZiAao3Wxu3NDEuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeEFUiThJ82NTPv2h/TDoW0wwMa8oRJGQeCsFTg1dE/nEUBQCbB5NpqG641w/ArvA73wyGkxrgD5Cuxjl6n5yz4ExY13iN1O6OXEtHPtVInGsyq7qYZ5ORj4SDr4JABWfvR+Zg0NKY2S+Cy6ISx8bp8ODwY4zmRdKC4GQam/Fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uavdsPqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9F1C4CEE7;
	Wed, 17 Sep 2025 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758132599;
	bh=F9+3GVUhzFcwpqijgKs+YwigkMGUZiAao3Wxu3NDEuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uavdsPqCGhpVWfaAkCxr/8YoAtx9F/c7I4V4GyF/E2j3QYOPirel2fDnBaKJcbP1F
	 D3TkPQ+mvKJCFLbzg/P1kyQfjeWVw1lsvme32pF8eWqVQjMs0R4rD1sloG2CeJwANN
	 PmgvMOFoKMRV7RGILfudouxhnAlgQafvgj7qpW4e9bT8jCGS4xCWeAqclRwrcgdPyi
	 V3/7Lx1tsJ5QSBe7yGIBzchrCekujbLNDCPRWuB/3IClOnjcSzW1fJ5yJNhmEZIk5g
	 ZV3mck5XCt9FjDa8CzbxqNAvMztT24Ddsw7BBz07d0u54vCVWF4vea6SRJy+DaAh08
	 3kpfHXqhGeTsw==
Date: Wed, 17 Sep 2025 19:09:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] spi: spi-nxp-fspi: Add OCT-DTR mode support
Message-ID: <f927f641-4af5-41ab-b48e-4a03dd46ac43@sirena.org.uk>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
 <20250917-flexspi-ddr-v2-5-bb9fe2a01889@nxp.com>
 <aMriG3Sp4Ns93Mxd@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FWM1IKwhAJNrjOSI"
Content-Disposition: inline
In-Reply-To: <aMriG3Sp4Ns93Mxd@lizhi-Precision-Tower-5810>
X-Cookie: Lake Erie died for your sins.


--FWM1IKwhAJNrjOSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:30:19PM -0400, Frank Li wrote:
> On Wed, Sep 17, 2025 at 03:27:10PM +0800, Haibo Chen wrote:
> > Add OCT-DTR mode support in default, since flexspi do not supports
> > swapping bytes on a 16 bit boundary in OCT-DTR mode, so mark swap16
> > as false.
> >
> > lx2160a do not support DQS, so add a quirk to disable DTR mode for this
>=20
> does?

Yes, that's more correct (though the above is perfectly comprehensible).

--FWM1IKwhAJNrjOSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjK+XIACgkQJNaLcl1U
h9CZfwf/UGHK0wCfWbCBim9KZPj2c4M6pKLuG/HZW0r6MAscgje8PfrmUrv5MGjU
iWYxmnEL+wZKOgvBLhuv7LkK06qXVQ/8QcihQi5Om16xX+OGvCFNao7EQS1eZdTV
5BNseKvWrhzYng6pJpXD3eNyV5uEphyyFa5HhaT8SZJN+Imdc+AuIpMjvN3I/8mS
oS7m2MhXKa8hnRAQJJoyX2VDfRGq3Vys/Yft++GlySqm+qsHpEOu+v69T2cI1YkY
AK/V8YjXtHi5xRd5JuVuaENeDfSazIjS0R0FyPMRn1iOPu5kY5EZXRE/0kdUKwUX
5BjDArmbQHjsG7SbUuKcGrw7bNhFeQ==
=1zzy
-----END PGP SIGNATURE-----

--FWM1IKwhAJNrjOSI--

