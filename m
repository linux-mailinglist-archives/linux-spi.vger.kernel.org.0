Return-Path: <linux-spi+bounces-8052-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAFCAB20BD
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 03:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E128A21C69
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 01:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE3263F3A;
	Sat, 10 May 2025 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NumnG3Yk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BD1F1507;
	Sat, 10 May 2025 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746839987; cv=none; b=CUZwJagTYYxkZa6F5Al/9soet2zb0tdLM2wmhBgD8j0tv39bXTYaw70o6LqL14mdbEyTHQ1tKfLMnihl3QU/YSY0mBx3y/xA7W4424HtbI9FjdD/K7x2t4lp6kYNKh98jAA2ol8sVtrppWlp12T5avciWDe3f6Q/vgjdN2iJtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746839987; c=relaxed/simple;
	bh=zg5HXGTrlhhiTOPA2jjHZNaufpDMA8T3jdH8ZIjofCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ6gsFU/ItPkbjw/IvqNjmFEF5FlC5dBVsmHtWeBtNhL1ZL4CiZ0578GxpAv51XPkvHoc+7b/XYdE7nnYSWULGOHMCmarhbn8xQQmmNk5o+W2XEUesBtwlPlsCnsG7YwOGgYzRDwCtuu0YvqGYboW/4aorHuTxRbD8Rx8VF5xxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NumnG3Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679F1C4CEE4;
	Sat, 10 May 2025 01:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746839986;
	bh=zg5HXGTrlhhiTOPA2jjHZNaufpDMA8T3jdH8ZIjofCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NumnG3YkxGfCRVCRqFGOxTVTNokveYQU3KGb+ew7fW3U9W8knAl9YOvv9vQAQKUcE
	 wc0l7IkUC2x5IJzv1rXo5TzKv4GA+tUyXIT2UkFBX8NZJgUSOFFdV8liH4mdDdT1iR
	 g2nLt+KTnipcSshGEND00NS4Z/cbqznavW3ubfAL0l9csA4lYTQbrPF+okif5Sr+n8
	 UUGHxSNwN3XM+EA26Odbm0Np9FDL6Fo6BwXtnSdhpv+tp+679oL8CYC2z1VLtC0FY4
	 hNP1k1Ij1blLOrpyGohdWcJQlscEJ8FLHKZ1k3UYsgxpSbNNf0tOr2aBamujglQqT3
	 B88t6ewQtaPlg==
Date: Sat, 10 May 2025 10:19:44 +0900
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com,
	arnd@linaro.org, andrei.stefanescu@nxp.com,
	dan.carpenter@linaro.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Subject: Re: [PATCH 11/14] spi: spi-fsl-dspi: Halt the module after a new
 message transfer
Message-ID: <aB6psNq3F-bsAA3e@finisterre.sirena.org.uk>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-11-32bfcd2fea11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W8tovzokLkW8kDL3"
Content-Disposition: inline
In-Reply-To: <20250509-james-nxp-spi-v1-11-32bfcd2fea11@linaro.org>
X-Cookie: Well begun is half done.


--W8tovzokLkW8kDL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 12:05:58PM +0100, James Clark wrote:
> From: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
>=20
> The XSPI mode implementation in this driver still uses the EOQ flag to
> signal the last word in a transmission and deassert the PCS signal.
> However, at speeds lower than ~200kHZ, the PCS signal seems to remain
> asserted even when SR[EOQF] =3D 1 indicates the end of a transmission.
> This is a problem for target devices which require the deassertation of
> the PCS signal between transfers.

This also looks like it might be a fix?

--W8tovzokLkW8kDL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgeqa8ACgkQJNaLcl1U
h9AOTQf/dvvH6zQ9y3ahPtoaRH796SUktbVlwo17kK32GIACKMksAuQXPZd+9n7b
4FxeO+I3OfdJYftlsCGwhls/p18ok4/vHQ/wFzvMlt3zMXx0IM6e4UyB9rEqnuVy
YqERHCwORZvPcv3bFj7vRmkmzxGRuygjl9Wo02e7LEEztSJNelk1PVruHYUiRkih
5Tj739mOIqhPsf7zIhSnliDUDGcfEiFTJo9Hai3Jx6z3Wj6oTy4hYyq2g/G5g1pi
g5EgAwO0st8dJKenYZf109W094rXshtEywMUZd1DkB2+Nf7JaPCqZUbm1IAsAX9L
vLwgHrh6qCnJk1VYCOiW/qs30XD5+w==
=zCVN
-----END PGP SIGNATURE-----

--W8tovzokLkW8kDL3--

