Return-Path: <linux-spi+bounces-8909-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F63DAEDD42
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771BD189C8A5
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88228B7F9;
	Mon, 30 Jun 2025 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn1f6tcs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C3428B7F3;
	Mon, 30 Jun 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287251; cv=none; b=E9J/nq2c6696vIh6luvAFgc1exCGax76MUFl5ewV4zvpfq3mSgrAdnH8jpn1Q/DHemgIIBvXLrpDu6cZ2ZcGhZs9FIYraDhKyYaJP3KBqEHeDY5ELY1qZKCORCniZJ7d7g3Fl5p91M7n+Vav9TMgK1VSAcvwfkGBPDQhpXk8Mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287251; c=relaxed/simple;
	bh=spAwyoowfoyATP+MaW84Oxd2S7OG1Ngdx3wuUX4Xba4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebnHEc4tg3tZnJYnPvjsFRN3E4eR5af2Lng7JAWEMu34xydo1S4XUa2sWadLPkH9IMK0HQCK1ax6l5vSkFUwBBmyaUFdwp/RzqS/cSXm8nkKjwAOms7CHZPaxlbM+1ttoTxmEoM7wU1R1oWDxAR+3xJBPQAvPu8dlXH8dRE4mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn1f6tcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F9C4CEE3;
	Mon, 30 Jun 2025 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287250;
	bh=spAwyoowfoyATP+MaW84Oxd2S7OG1Ngdx3wuUX4Xba4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xn1f6tcsQ0idY7FNqgsnC1PaKVD93LK1dX/H0Ywpe3b5Si3QJXevAuormW+Q9B1J3
	 /KlDHpTUcRw33F4iiXTgfEHJs40ejeNijfcv5uDBrA0hFF4NomyYry0To1dalZ/8I4
	 +wpFkN8Swjd4RgrFbfBDHiyDS1S6Tfr4N4wCzPkplDgWnQT8LMc3SLtcqr/JvcaYfG
	 5xcEGOYYo8pc0fMkxRFbRI6Id3TV4Y98iQMWyUem+H0rd2aWnb8IL7eBM7ljpa0nCS
	 q1g2BoXUGAiVHQHzETn8h2OYgWeJrP+uQrLtCOla6Zspv291JqtIUoEkMCV9HF2R4o
	 GTyRKfGfP8SNg==
Date: Mon, 30 Jun 2025 13:40:46 +0100
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 0/4] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <a164abb4-0863-4a0b-b2f5-f7c1b36e408b@sirena.org.uk>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <175128365072.28911.16806664823646528710.b4-ty@kernel.org>
 <9f707fd9-a9f0-45d3-aaec-e20bad4c4f76@linaro.org>
 <e5dabc83-eb1c-46eb-b24e-6dc8b19c4ff7@sirena.org.uk>
 <d86c48f4-fa10-4205-b0de-43fc8be0c848@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z2dZ6c4cYg0MBwpB"
Content-Disposition: inline
In-Reply-To: <d86c48f4-fa10-4205-b0de-43fc8be0c848@linaro.org>
X-Cookie: Say no, then negotiate.


--z2dZ6c4cYg0MBwpB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2025 at 01:36:17PM +0100, James Clark wrote:

> I was a bit confused to see this notification on both V1 and V4. Maybe an
> artifact of the first commit that was applied being the same?

The tooling remembers if I ever downloaded any of the versions and
didn't explicitly delete them, if it sees a patch that it remembers
it'll report that it was applied.

--z2dZ6c4cYg0MBwpB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhihc0ACgkQJNaLcl1U
h9BHSwf/W81kNAtGCZwnZRMgyRS/jsFocTv7qE7Rd4PLrxkkxgi5JTc0uW4MW03V
ocB8vgPGZjncHjDuziHiBHGSR/6qW4bCxtEcoMaJQGuuSKw3zs02oP08i35NcRPC
/Rfj62UjDsuu9vHUGTePkc2HLQCcaIW21FiKnw4rUXklIo4+/f4ZH8t905llrqXl
gasVt0/aqaMQ2FATFdWiorcOadOZmVWEjq4O0cmkObTGoLHlpR0vVVId/ZMsud2s
t5gAOYEk4hS+xK5Hqe79aP/RiFrT1igqfRTtUY26DF3UrTCho/xp7xaw5Jr/Zvq8
HeAlZhDZgxXLv1yZ1Oe1FlGbDNmhBA==
=9PFm
-----END PGP SIGNATURE-----

--z2dZ6c4cYg0MBwpB--

