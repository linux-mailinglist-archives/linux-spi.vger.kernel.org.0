Return-Path: <linux-spi+bounces-11941-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1524CC39E3
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 601E63007A81
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03BF347FCF;
	Tue, 16 Dec 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjaqvgEE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D52346E73;
	Tue, 16 Dec 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895682; cv=none; b=S2YYI7VKP3P2Rc5mH0ZlLtmN9qUoZRKaI568oaEX3RLvbz592nTYW7WFaEx+2rhHvzp/9xiXkxmKhZ2p5X6T+3SUK/o6vuswJIXgxK8+RYV8Ka8S2whEfw/5xEOQsyxl480wFPFmRG+DGo2MWZPgNpWbMYc0a7hR78BvgmmAOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895682; c=relaxed/simple;
	bh=S6esN3wft2T5E6VFVjabpJYJD3uugA8OjhnQ5Fszg8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+sSzwtnNae5FyEIfwilOE5IcA8jZ53048HlJlOWIg71N9hgdMcnVPJeOV1gq0iWrtrvnGsFd7CAFauL1diz6XqbKqxloRI5NvfM+IqtTKyGqVOvW0zqKWi9022JDPihykXZN8p5OzjUnC4Foa2ULR7tAqlzhhA66zS6IYh0BeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjaqvgEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2243C4CEF1;
	Tue, 16 Dec 2025 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765895682;
	bh=S6esN3wft2T5E6VFVjabpJYJD3uugA8OjhnQ5Fszg8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjaqvgEEeY2Elte8EJHJvLjQXlkPMAhfG+Eqb843WcyWkiNi/bl4nt9YFsJF4Q9x1
	 KE/IqNWYMUmaLcel8GCMuGCqbpA7ndsgJR12B6eI3QJ7uzdv8yTO/3n9/4gRGpDGnO
	 RgSbTyHcTsqt/Z9/FG+WOA3f9YJDo7tLKdyS4KrsD8hJ1hdS+Hmx+AvJw4+fllV/tA
	 EmXMtyQpqsQrRrABltaw6RaWxJW5ZTZutvP6VHar2R3RuWpmqnloQ//SW2n5YqnWRa
	 CNj7spWONpmwQ9IleOKU9PikFj6kLq3BteDthcUCYJ5b8acRMx0m3GCWz/5m8kYN2g
	 jC6D28fNqvZww==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id D468A1AC568D; Tue, 16 Dec 2025 23:34:38 +0900 (JST)
Date: Tue, 16 Dec 2025 23:34:38 +0900
From: Mark Brown <broonie@kernel.org>
To: "Dutta, Anurag" <a-dutta@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] spi: cadence-quadspi: Parse DT for flashes with the
 rest of the DT parsing
Message-ID: <aUFt_hLak5QNg4ai@sirena.co.uk>
References: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
 <176580718260.161463.4539075429059025833.b4-ty@kernel.org>
 <82ffe3bc-6789-43b5-a48c-a1f490a70c64@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1R4mcgewwj78Qo1g"
Content-Disposition: inline
In-Reply-To: <82ffe3bc-6789-43b5-a48c-a1f490a70c64@ti.com>
X-Cookie: Think big.  Pollute the Mississippi.


--1R4mcgewwj78Qo1g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 16, 2025 at 09:38:01AM +0530, Dutta, Anurag wrote:

> I was under the impression that we are agreeing on this solution :
> https://lore.kernel.org/all/20251212072312.2711806-1-a-dutta@ti.com/

I think we should do both, there's no need to do so much of the init
work if the DT setup is just broken so the device can never possibly
instantiate.

--1R4mcgewwj78Qo1g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlBbfoACgkQJNaLcl1U
h9Ay0wf+J++UL9gR2qnh2NOoaQkn7QDp8fiEs6/A29kt6PM321Tr8MjDEgSJ/15h
FA6c9xUhGW8SW4mQQ9A3t9nKqU5XHwMWWuhCCoDcw4JyStIyedJ3GlBbXdJ3CA9k
Jy1q6GGzQ/fMTE+zLdooHFkBq9tFBRDKtucLpMd6vO9bCfzk++D5g8kqlKhCCs8k
OStaTa+wcBUu342PanFXPxTDVMDxFg5IBAGZ0nMUyYhuMTpF+jWrAKoksktxyidy
p9JridZfyOfiOQKTQi2VAKFVQz82ONuyuaYAxpF23M0URIfeqz8DRS22qWC17JUp
nSKAfHhNFh+1Kl8a2s1PPPMFh+YD6Q==
=NE0p
-----END PGP SIGNATURE-----

--1R4mcgewwj78Qo1g--

