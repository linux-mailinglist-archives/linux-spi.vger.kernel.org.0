Return-Path: <linux-spi+bounces-12369-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DAD1F58E
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 15:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F52E300AB04
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17102D9EFF;
	Wed, 14 Jan 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLu5cszk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD532D94AD;
	Wed, 14 Jan 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400205; cv=none; b=Ls1pkY2Z9c9nRtXS+UAueuKleOvydCZkkiyWpCQZM89Lio1+oY7zgUxORatsljGWuPh4gvhi7egvHjhX4pRuqsXVsF4oQt9WNE2hgbrowD/T3dWAOfFCosXBKvTWhdrBLi/046aA5srbToZztMXq9XFK5ClByXCb/At6EyVlyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400205; c=relaxed/simple;
	bh=XrqqcmRsyZwRmeY/OgsS8oou1an44/FjjqRcXEmPp1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xv6svtBCCZ+/WuIljWsSRJSrhkC02EPiNBa68t06k+tmkPFTGTgHKjOtAwjdI7x8eq0JPEDRRhsQ9WteNGw4TC5hLhYoZYBdUBwYdQAS0hxu7SdpgXKwtkIspyx1+qd72urBdEPLUmmsyegiRGxDcDy4iBqtzdo+Ks2CzHXgjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLu5cszk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C263EC4CEF7;
	Wed, 14 Jan 2026 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400205;
	bh=XrqqcmRsyZwRmeY/OgsS8oou1an44/FjjqRcXEmPp1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLu5cszkj/qDoM0fUCiBAB/fwApjXi2cTZ3BA6KfsdtvRmO/3dMzC8qxZIo4esxqY
	 0F1XBDX7+BtrFZ+CiJ6XKS6RB2PAMfOzxeMcuKeOc8vDS5CpaSSqjDrj580DNcYtEn
	 I1s1jwEvEsvKkUdERrlMiRlR0ZfC9oV0PVEXSeXYU1NbLa+jnSQvvkGhnUJq6Lgf0k
	 5UGqy8cgkzg2fX2LAYbyyczccVJgo6Tbc6LoWuWFm4S8YrR/ng8CDZGIs8HmUOvw0H
	 JEgnbIBqwWI+AQ0DPzQC+sNGUcBIvaMJ0CCHh8/50lIvUl9lh4wndW/+a6QNFFY/pv
	 +4KINxvSfUMcg==
Date: Wed, 14 Jan 2026 14:16:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
	fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	michal.simek@amd.com, cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: spi-cadence: supports transmission with
 bits_per_word of 16 and 32
Message-ID: <0dbf3a5b-6a60-46d8-a358-61b8d527a8da@sirena.org.uk>
References: <20251031073003.3289573-1-jun.guo@cixtech.com>
 <20251031073003.3289573-3-jun.guo@cixtech.com>
 <fu4ujdxwlhyhuwjtsiebje5pyc32rfs52vo2gyy7nay2krkxeh@wpls44xdfgy4>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QTaNkFSiAOD+g0pr"
Content-Disposition: inline
In-Reply-To: <fu4ujdxwlhyhuwjtsiebje5pyc32rfs52vo2gyy7nay2krkxeh@wpls44xdfgy4>
X-Cookie: Absence makes the heart grow frantic.


--QTaNkFSiAOD+g0pr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 14, 2026 at 02:14:35PM +0000, Rodrigo Alencar wrote:
> On 25/10/31 03:30PM, Jun Guo wrote:

> > +	if (xspi->txbuf) {
> > +		switch (xspi->n_bytes) {
> > +		case CDNS_SPI_N_BYTES_U8:
> > +			txw = *(u8 *)xspi->txbuf;
> > +			break;

> > +		cdns_spi_write(xspi, CDNS_SPI_TXD, txw);
> > +		xspi->txbuf = (u8 *)xspi->txbuf + xspi->n_bytes;
> > +	}

> cdns_spi_write(xspi, CDNS_SPI_TXD, txw) needs to be called regardless of xspi->txbuf.
> Otherwise, there will be no clock for the read operation to work.
> This is a bug I am seeing on a Zedboard running on 6.19

So the device needs to be flagged as SPI_CONTROLLER_MUST_TX?

--QTaNkFSiAOD+g0pr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlnpUcACgkQJNaLcl1U
h9AykQf/fa08uztzIN9yVJs4AA58mWTVqubsPzSh3dnOVMLV7izelhCJFicPBFxl
eShEt7Cze9aeJnFVU/cQQTJBSRj/HhyKqjiO9ZaW4yeVwpdC0qWeiFOgiElLyHSv
bCCoSc+66mkIAJO2LraXGxuioDncWszN0BU1rSj0bTwOJuLTaPPnbs4D6SrJTQO5
3De10i9Vg3KI6O+Jv57oscDmI8aPuJOlKHJMr4z1a+aCCGjJEp6Vgf8ogLLiKll3
/jTIuOo5239aqPxFmWXLe+il/N1tG/u6qsnnc8AUvSz4vByZJqRDy83e0i+Q5eON
Ktd0aGNIEwAeNDElb9J/638PyXOhVQ==
=NTct
-----END PGP SIGNATURE-----

--QTaNkFSiAOD+g0pr--

