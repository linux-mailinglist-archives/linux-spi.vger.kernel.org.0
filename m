Return-Path: <linux-spi+bounces-11750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8264AC9EEC5
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652443A7761
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5F2F618F;
	Wed,  3 Dec 2025 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCnIW6Jd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9DB2F6173;
	Wed,  3 Dec 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763115; cv=none; b=JAXFzAF2GRpAYC182CbTOgpznH3YoVhijfnthH9xQ87jzfwaqr2jARGLrI7qCJ5aYf53lWr4ZMmol00iZdMXIkVsVTjfkIziCXOcAyVSPt4IvRGO1qpJDD87cO7kpXOtg6CEdvCgToizHM4A/iGkc7ntYVNIGyRfdRNDR1IRfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763115; c=relaxed/simple;
	bh=UTyWH5ewlKa1kF4ff8wnEKITBqENzCxrbE3dAd6HxYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFn1TA8Beyn957SnBysEGciLrufNQvfGS0MZuFt62x88A0wDi1OMY7wdtCqoGfI7gRFOgsBqdhlq3W8zr9Z2reBXSthcY0wJQuEcaq2PDIftgafCn2zTmnJhv76CeNkdCIpGoxc6KMGKFMLyHIJe4atbWBvZadSd/MIHRyKTHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCnIW6Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8686DC116B1;
	Wed,  3 Dec 2025 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764763114;
	bh=UTyWH5ewlKa1kF4ff8wnEKITBqENzCxrbE3dAd6HxYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCnIW6JdeLNjG8oXPYDymHCbu4EQw2YnYyF/hwe6+5F4WldR485Au9CayIRKrMg7i
	 uUm06o6W3yo301/6fFa7dPl+uHyZKC5vv8qcHr8R6sk1pb0OZVGG3Y+9/n4zO1Gto6
	 NUs3t9pZWIqm4KqA11mduFDx6Cg8888Gfupy/LzU8ojUAg4jVGJ9zaff9fcDupWyJw
	 sD6p9ByDS8+XOKrxIuOqsyW5gtWUY3zFwwzlO91Y4LVAw1VSFloVU7/UO6jJ9ZpW3m
	 V5nwiREISQGinEQa2MMFNl3I77sE2W84xz1kVzoH8p8IdpjU3KucdZ2FpR5yabSDY8
	 yfjBqKEdAQTxA==
Date: Wed, 3 Dec 2025 11:58:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Anurag Dutta <a-dutta@ti.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <e95bb125-6b73-4991-acce-a964854da0a1@sirena.org.uk>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <b2c0f5b38ed01836c025f2672a883484765d91f5.camel@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qWIYdQJDeHZwOpxx"
Content-Disposition: inline
In-Reply-To: <b2c0f5b38ed01836c025f2672a883484765d91f5.camel@ti.com>
X-Cookie: Close cover before striking.


--qWIYdQJDeHZwOpxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 04:12:04PM +0530, Siddharth Vadapalli wrote:
> On Tue, 2025-12-02 at 22:53 +0000, Mark Brown wrote:

> > Avoid this confused ownership by moving the pm_runtime_get_noresume() to
> > after the last point at which the probe() function can fail.

> Thank you for the patch. The 'clock already disabled' issue persists on
> J721E SoC with the patch applied:

Do you mean it reappears rather than persists? =20

> https://gist.github.com/Siddharth-Vadapalli-at-TI/a664f59366ad681856b862d=
621487b7f

Interesting, I can't see any logging that indicates we should be
reaching the error handling paths in that log...

--qWIYdQJDeHZwOpxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkwJeYACgkQJNaLcl1U
h9DslQf/fPc5wiCXOyCyoZBN/wMFXUvlVu1M/sdRkSlcX25weOXE1pRqtX7/YHKx
u6ByK3OAMEain4aVhpufPCTPuD8MnAjB+fFN/FzHRXYWXpDEtrFoie5z4HY4EyCK
zEr6L90UXYrru3e8uJaFZVWeBHBQT6sEOO/AC/tSdx0mw6CEClnM0a45BQjKGrnl
q80eZKCA6tRa1tp+S8FGoAcnxuIuNVNETMZNFGvB8ZH9+Z9qZUsJpZe9WbqAKOfq
g1CVAjG7oyGxysujLrQlEc/Csdm1p5kPprINlI4tP1gErmH3yNO+6oFisLMk9LMO
FWhrmg3rNMalhrPz6t68TSipAMtjwQ==
=ezhc
-----END PGP SIGNATURE-----

--qWIYdQJDeHZwOpxx--

