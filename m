Return-Path: <linux-spi+bounces-7327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39715A71C75
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4217A92A3
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6411F4178;
	Wed, 26 Mar 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXGV3BTK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CDF1E835A;
	Wed, 26 Mar 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008129; cv=none; b=V0bxMhZQF8TzmEJLyGVclGz/3RrxuHLbVajAMH4wFHzYHfgpW5+Tx+39YosmK9P4vFBR3JKPMj85UA7jKcI/cM6HM7HqgL2e40szRFBdqDGCAkRFJCwF4DyfxcdExfjd0WZlzQYPhrkqqhuZ+CiGnlM/KqiN0c5htza7Ket9Ey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008129; c=relaxed/simple;
	bh=xUH+r591VfZvvi48wtVpf1oVKcmO4AvfWE+ihcIT/sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pChUWaRmpbrbSLONmFWAicHdRT9McAFXHSjqi66QJ6a/JfiomNMv90PT0cz2DUIt61d+mo79D8eij7ZqnFxaqzYu2zim94nJEZpYqvG8N1IO6reOggc8aWTo6sid2WRfeRpkPgVHTJ74ODmVNYptY3T2FGJyGsx9+b6J64cb+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXGV3BTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA92C4CEE2;
	Wed, 26 Mar 2025 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743008129;
	bh=xUH+r591VfZvvi48wtVpf1oVKcmO4AvfWE+ihcIT/sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXGV3BTKRSh52WreuGx6SZ13KMFC9b/jMYXF78SjuQYL4LLk62DH8ljs32wONa1tX
	 7KwtviOXJ3XQrfraMv70gcQhyK6p05XuFU4CdR6Wju/qFF5roLMJSTiudyd4wW5Vfr
	 kF4gmYouaJ3tuDZArUV3QWovUtAldpWfB0URt6uO/qDsxE9zPU1xcdgJoPgcHh5ilc
	 PrhHLx1BaunkVbXalZf9EW2E0IoscE06jD06IDKlKEeU0+PTCVE5XpWmu3C+0GSdz5
	 v7Vljtof8M5E1/v/sn67QtGkIfn4c2m/IErdXn3lqBvCzbMYIgT+U2Kxugo96wk9EZ
	 FlVZGiTYFMNsQ==
Date: Wed, 26 Mar 2025 16:55:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for LWE's btt device
Message-ID: <6575e094-dbf9-459e-b222-95a7ce7e1c85@sirena.org.uk>
References: <20250221155644.1168860-1-lukma@denx.de>
 <5661510e-3aea-4c07-88d6-2c3efccadb37@sirena.org.uk>
 <20250326174228.14dfdf8c@wsk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bint7rKj/FLQArSq"
Content-Disposition: inline
In-Reply-To: <20250326174228.14dfdf8c@wsk>
X-Cookie: To err is humor.


--bint7rKj/FLQArSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 05:42:28PM +0100, Lukasz Majewski wrote:
> > On Fri, Feb 21, 2025 at 04:56:44PM +0100, Lukasz Majewski wrote:

> > This is fine but we need a bindings document update too
> > (trivial-devices.yaml should be fine I think).

> I've just resend the update for trival-devices.yaml.
> https://lore.kernel.org/linux-devicetree/20250326140930.2587775-1-lukma@denx.de/T/#u

> Hopefully you can pull it soon.

I would have expected the two updates to go together...

--bint7rKj/FLQArSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfkMXwACgkQJNaLcl1U
h9Abewf/YkPA8w4NfZYSC3pvZCu3Fn+bI+hKTgg6ZspkStlk1z9gZiqFIgmcrrdF
CQTsMTRzc6gEdS8FagkLObLxsRUJVmSsAm2Mi/DRtW7UmD+DOspi35AbKhqX/dlE
coNrLJWQ9I1ROT9OtRUX6JNVtOfFl/RdZy9dlyC05df01K9a6qkXfPf6T6ljLbvD
YA73XJaWGOXqAecnJtvnG/CMO6TQo+6IjTi1XWb8Sy0aJspQqd7RrrIvMn7cEjFv
4PbVOEKMJhngBlTqVTJVOhLrKaPhhONg+LMQ7n6ho8YA8kOHm3jgavIThCy3wq5W
M29Jjy3zmhRE9gXK9+b7+o2cfTV2mg==
=CPvd
-----END PGP SIGNATURE-----

--bint7rKj/FLQArSq--

