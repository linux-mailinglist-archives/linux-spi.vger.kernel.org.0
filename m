Return-Path: <linux-spi+bounces-4942-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567829844EF
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 13:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAABB20D8C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9AE17ADE9;
	Tue, 24 Sep 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX/WtRo3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691D1A4F3A;
	Tue, 24 Sep 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177863; cv=none; b=cdOq3BVGEAI9TUVLNPa0ODA4Av04mJx8CwEt5OHkz53ThY87jjbZGDJi7yVnu/jXgKCmt0aPvyKOclyIpdkdwyRwif/Ii53/JltIO9r7J3t4mcBIhw1TyIXoGfSrYBuq0yC6iEek/+r4S1yGOf0oBuWqcJhEhgVCdEPZW2mlfMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177863; c=relaxed/simple;
	bh=KwPn7H71G2ESFvjUpQBXWz48W7zBVrAEDy6LelZAxM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENyS8tr+Sf1LXZy889LZhP88ejDSbhlfY1T23LYDdTGZTxkfTPJiTJvn8hS1QehWl15rKy+a+0xwXzp8FZN7CDvUeb9OZUrmnaqBzI97z4jnzr3jcL3LMQrypseT0V7ltJWnBuxT5xq5qPch7SQB9GaLSE2fWKFYx2LKBwtNzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX/WtRo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C50C4CEC7;
	Tue, 24 Sep 2024 11:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727177863;
	bh=KwPn7H71G2ESFvjUpQBXWz48W7zBVrAEDy6LelZAxM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iX/WtRo3FMDNEvHlQDBrAbSKLj8hZfWERieHkqN7WacQeBjjZNcb+llrZ25r7UOLC
	 ACZSjG3XV43H1aUkM88v//mhKAYm1Qlkij6/N/j32EG0xgoWMnjNxX7Nqh1lGPbKvg
	 /jcpX99zzVRCzTzPnA/2gJ9CfmmlQ1RqqRntpPn4YqLZ9VqHNR/Y6Mm38HdLxQrUzx
	 TqdiaEpCihv3i7ZMNQGTZ4zNwdk4wYZd8uLyWRXy+4zdoAnfHflns2LM8bmvPK1Qa6
	 hx/50HH71ygdxcdOeKgjNYA4W/khhLshCr5Spe5KarqXx0oQO2nNtcfgx7SsjuGMa6
	 0FSHpHv1inyTA==
Date: Tue, 24 Sep 2024 13:37:40 +0200
From: Mark Brown <broonie@kernel.org>
To: AlvinZhou <alvinzhou.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org,
	pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw, AlvinZhou <alvinzhou@mxic.com.tw>,
	JaimeLiao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v9 2/6] spi: spi-mem: Allow specifying the byte order in
 Octal DTR mode
Message-ID: <ZvKkhPf3gCYpqQF2@finisterre.sirena.org.uk>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-3-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rkJTPNj4LORPrGCV"
Content-Disposition: inline
In-Reply-To: <20240718034614.484018-3-alvinzhou.tw@gmail.com>
X-Cookie: Editing is a rewording activity.


--rkJTPNj4LORPrGCV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:46:10AM +0800, AlvinZhou wrote:
> From: AlvinZhou <alvinzhou@mxic.com.tw>
>=20
> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>=20
> There are NOR flashes (Macronix) that swap the bytes on a 16-bit
> boundary when configured in Octal DTR mode. The byte order of
> 16-bit words is swapped when read or written in Octal Double
> Transfer Rate (DTR) mode compared to Single Transfer Rate (STR)
> modes. If one writes D0 D1 D2 D3 bytes using 1-1-1 mode, and uses

Acked-by: Mark Brown <broonie@kernel.org>

--rkJTPNj4LORPrGCV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbypIMACgkQJNaLcl1U
h9CKUAf/dMY9j4bSZx1832KGGjShmasj2G7xkknbjgcczinSBwK1bJZ1KqJSqN8E
0HoKDomE4GO0WENZ/Rzg9CPgGntZ/O5wKUQeHkNkfAHVJgqKZ5PvB3ex3P7VAt1l
oXtHSKHcQrI7GwL/bI5YZGikp97PC1HkG3s+TnDKbi+aidtkSzrny5wVuLaYrz4E
wYCgEVwusWNFxQi2hqorFJukBKR2Ep5/Cl8jfbN7R0laKaZ+btW2c4V17FAJHV/m
7SMHmiQf5H+8cTz45hI9QVe38a1/hG+BRpZmxovfg48KvV/+Gx2LUC4r4QrNUXrH
SLjDzdeXXMMAihMbfo0kIdIsMYy8qQ==
=i85L
-----END PGP SIGNATURE-----

--rkJTPNj4LORPrGCV--

