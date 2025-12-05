Return-Path: <linux-spi+bounces-11777-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E848CA5BA4
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 01:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E48E300A8DD
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 00:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA664A02;
	Fri,  5 Dec 2025 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKUJ8NCZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C92581;
	Fri,  5 Dec 2025 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764893202; cv=none; b=qkbfnOxYfdj/QKGIkfvSfhfd0x7//akS19lnUD3U4kv70F/P/CDkJev+HyjLNEGuadv0W0HasMBTYmbwmBLkPNXy4tICRkbZAvN97FxCvr7p//Kh47DU+kpBtbTTvgM7pGzuetgDdQ61M3mNNrAMORPAIRzYLWbRmpo5YRdEaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764893202; c=relaxed/simple;
	bh=YQnKrUjEgtIVsv8WkDZ+KCirUu+Ln8/sCybMgbPSfHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6jjiYmtRdrvL/pYYGtdcbUV2vIYvE1V/glZH9MKxu64ARCHOGYBuYoCYQoTH/r+gDZK9TA7ZqtBu3mrn4+QYqVuN8D4zE/Ba4EkxrjPo2qCAUvviK4z86Y6rMX4pT83km7TKhKWjEyEPnlgM5CydHMaPT0OZuWPFg0AsNk349k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKUJ8NCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B106CC4CEFB;
	Fri,  5 Dec 2025 00:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764893202;
	bh=YQnKrUjEgtIVsv8WkDZ+KCirUu+Ln8/sCybMgbPSfHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKUJ8NCZDtw2Dt5nh3VzDbG44LxfXSLT0UrLiFHS86bU4zQyWGtLODg0kAsInCj/s
	 OtBiyzZLroratRhW8ZuJ0B2GFSWKovcZGIBlyqcftCjSesVOOTAeWdGfkF+mDinUj2
	 xFyPmfdnYB3sytuTi/eOMsc30bX/JKXscReP124isFj3FtRtRznpslCj5KVyqNsGx/
	 /4JM57a8b5U7spsae8IbKA+KXffw+SbMaolS6UIxHExpRi292GMXt+per752C8qPSL
	 9po2dRYjXDnMESv+oQHlMk1BiGfTSNpDinyfpacnt6jJAc8i29Eb9NmkD2so1h88Cw
	 m0IxOs10lwerw==
Date: Fri, 5 Dec 2025 00:06:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Anurag Dutta <a-dutta@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] spi: cadence-quadspi: Parse DT for flashes with the
 rest of the DT parsing
Message-ID: <d48f11de-717a-4b99-bba4-27f1f341bd41@sirena.org.uk>
References: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
 <20251204200027.p4osjcj67bcmsvck@skipper>
 <1f8b3c12-acf9-4828-818d-3526c7675e14@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3DG/rV6FwpTFtPe"
Content-Disposition: inline
In-Reply-To: <1f8b3c12-acf9-4828-818d-3526c7675e14@sirena.org.uk>
X-Cookie: volcano, n.:


--c3DG/rV6FwpTFtPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 05, 2025 at 12:03:14AM +0000, Mark Brown wrote:
> On Thu, Dec 04, 2025 at 02:00:27PM -0600, Nishanth Menon wrote:

> +		ret = pm_runtime_set_active(dev);
> +		if (ret)
> +			goto err_probe_setup_failed;

Oops:

s/err_//

--c3DG/rV6FwpTFtPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkyIg0ACgkQJNaLcl1U
h9D7Wgf+Oto4ou3t8gAG5y8nTWMOPm3CWY7KWz2T3nPXPVUDus4liQZeOxHCkH4h
sNKxc9Nmp5p7l//yTKnSX1L5Bq+M/DEVeTYPA1QI+vMzSBBPV2XJVDNLBolMInlY
bfyG9qQlgzWJlrjc2UQ2C9ZdXDPBLMFikat5a6R0VOZ87HfUbSDzz9B2MGNpkVbq
Xrp0iE5FWT38XvdEqvoeKQpGz5PGC9NMU3LHpB5tNaMYxLNGhIT5Z4CvKsYnUOBA
EZpPrgE9KrqSj+Z62CR3q4zIGOsioDonQW0N+58/SFBdE9ghLigIMTBWj+kfATKm
xAyw4Bh0ndsGtEFlGJd1WQgC/pOb3g==
=CBvG
-----END PGP SIGNATURE-----

--c3DG/rV6FwpTFtPe--

