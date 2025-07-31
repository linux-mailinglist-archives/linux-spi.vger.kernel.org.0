Return-Path: <linux-spi+bounces-9248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7199B174D6
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 18:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB1D1C21D68
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5CB238C2D;
	Thu, 31 Jul 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABonlWAy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F63239E8B;
	Thu, 31 Jul 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978811; cv=none; b=l151gAi97/rom8JWY0S2zdxzQ68VV/2mC7w49g3sOJg4qXO6xFtoKODW6DOgJ6aodGo1fqv8QgbeHpcRIgUKQ1KD2Av64zAF7QcH3gUFr8ZyQoHfO4LYi177uzebvHWh+o6zKqGxb72wEz4BAhDlX7vx1M4OBbwcruf5xHULQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978811; c=relaxed/simple;
	bh=dnuBUhyXxx6eEnqiiIdfYQFX9xeUXT9k0YSrzphmgb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2KUfvXXhg/ebaLPwlHXpLw8DjhYWU59W/2/J0BC2/6Ze1tICB/l+FuylppRUAUlrCORBPr0U/9jrMOu9zHN93XptQGljkTJc8fX25F/n8sqdOAx6IbMz1+Juw1ApnCoG+COaVQziMFj1X9Rcuco4E+INI/Mox0CAsZmTzbl0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABonlWAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889AFC4CEF6;
	Thu, 31 Jul 2025 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753978810;
	bh=dnuBUhyXxx6eEnqiiIdfYQFX9xeUXT9k0YSrzphmgb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABonlWAyKikiuvW1GW309CBL2bKEkXx3ZijcsD3BrznOm2XbGT8x1OeNtmo1/Obh5
	 jMge+WpTd/WeCcrs/29+gdopqi4aW5cYNnY8xcqSQOLd797gK/8CKl0myUZllFMqgn
	 DXAPKnXdC6MEDcwsDmeGK9BmcfWIeFln1t7R8jU0aJBpHHoIgwge5EFrn4dU6zP+pw
	 BG2d8XJ5/CUML/5NlEUx0gz0Bbx7lzK82tdgrC8agT6SMPR8TE0f2c5Kbcx2d20xtr
	 fAemzXBlkC1H0A/Y7J6CN/4xjJUlHlUaltQNSxiFN/zsrJHRXkPF2ADf4lDJF+0DlG
	 g1n5E3poB+J+A==
Date: Thu, 31 Jul 2025 17:20:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: cs42l43: Property entry should be a null-terminated
 array
Message-ID: <5f9a040e-c0d9-4dca-902d-74bc043d90c5@sirena.org.uk>
References: <20250731160109.1547131-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tZlxq1wObBazuEVR"
Content-Disposition: inline
In-Reply-To: <20250731160109.1547131-1-simont@opensource.cirrus.com>
X-Cookie: Gloffing is a state of mine.


--tZlxq1wObBazuEVR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 04:01:09PM +0000, Simon Trimmer wrote:
> The software node does not specify a count of property entries, so the
> array must be null-terminated.
>=20
> When unterminated, this can lead to a fault in the downstream cs35l56
> amplifier driver, because the node parse walks off the end of the
> array into unknown memory.

>  	if (spkid >=3D 0) {
> -		props =3D devm_kmalloc(priv->dev, sizeof(*props), GFP_KERNEL);
> +		props =3D devm_kcalloc(priv->dev, 2, sizeof(*props), GFP_KERNEL);

Does kcalloc() zero initialise the data?

--tZlxq1wObBazuEVR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiLl7YACgkQJNaLcl1U
h9CtMwf8C1yDA4EJdoRsmJFScmC/QXV48qd7yq937UTarOYQdIIY6FTBVy3ocEcz
3hkQo4siSPoOzqD++zUuxVYcQq6xFKthDycNsRDJqB4O1Cdk1ZTUbFqcFSPzhpHA
4XUj4eDeXcQWwWrUgpQxiM+ieHjrEochpzCyRwnUeIoqFFegGdwA80To//nBvskK
fBavaiBTLyTdhRg97gwHW5vvu5KAU2f24Ca1L0vzvP1/2e5W8d9Z93wSo2sdsarS
d/JhgmlYyiDXNdmi5Ja9HAgMUHEEkIokM8EcWHrmTMr+oP42b/t7fmIcvp7VLbsG
KPqnsMkNKsZjGPS2/nzqqvhPipZdcw==
=BL8d
-----END PGP SIGNATURE-----

--tZlxq1wObBazuEVR--

