Return-Path: <linux-spi+bounces-7370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89FA766C9
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CD43A7AC7
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807891E1A20;
	Mon, 31 Mar 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYvXl2aH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCA17A2FA
	for <linux-spi@vger.kernel.org>; Mon, 31 Mar 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427465; cv=none; b=Z/21OwDPD4dtWMepPi4aTCGa2jWnOcUKASGmDPMvjzVQAZPrlXKNGrOQxev4jXVWwHrJwRZLWEEdoqrQ2FnkarITo3dm6xYIOHWgHZ+1Pwn0DuKcUsJ6iIEednZu4ZT26nBTc9EzMHNnDe812CV9r/cHdtYPLzPv7QbNgsMR1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427465; c=relaxed/simple;
	bh=2zFoOTRzQTZr5QCxm7s/N9wzff0SHtQ89oCTYBxhhOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK9MepGxfNBE2N/qewwfXCikgqvbkU3wtBATFZsXRihPkeo89vZ/0WqJtCK5Fy7UlhXGXMVo5BnbAw2sVcJhJ6CwagiEjFgzOusywLoc87NeyBCtKdGbWIwikW3nFsf60mo522QhwqyFRsND5fHmHpwYYmH7WLyaCt7et4rhqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYvXl2aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD39C4CEE3;
	Mon, 31 Mar 2025 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743427464;
	bh=2zFoOTRzQTZr5QCxm7s/N9wzff0SHtQ89oCTYBxhhOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYvXl2aHzM06ScPluSrtPjc/Za/LX342HRLh5WADyNue0YwfY7VB/7t7gd3uJFPOu
	 H/AcWftNmMA8u/4zbQ6ABXMrb7ZJixSchAqQRLgFOAxFNbffJoIX2YCUgsLBiFR0uW
	 hMw3mzLYT6gJNfLa1hpuzmxAAVD3XLMXT5nwbO4FQZTSRRA13lWw80ERPAzcDEI3N8
	 pirCib1ttI+V5Wl6lKZ4lp2vfdlDPpixjue5jmHOgF0EKpWcT9+NwMRnVxT4nc/VlA
	 cy5evEpzCV+Lk6ke37JoUTOus3uG2+ualOXlVaiHHwRc0hV0PasQx/ZfX7c+bkCMcy
	 s94/tQhXaehVA==
Date: Mon, 31 Mar 2025 14:24:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-spi@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <stlin2@winbond.com>
Subject: Re: [PATCH] Revert "spi: cadence-qspi: Improve spi memory
 performance"
Message-ID: <01d6ed23-72e4-4c86-8b1e-d7d9fb440c0b@sirena.org.uk>
References: <20250328173500.3687483-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pph/ciYbLzXIiN2d"
Content-Disposition: inline
In-Reply-To: <20250328173500.3687483-1-miquel.raynal@bootlin.com>
X-Cookie: The Ranger isn't gonna like it, Yogi.


--Pph/ciYbLzXIiN2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:35:00PM +0100, Miquel Raynal wrote:

> the probing of the DMA controller has been fixed, and the performances are
> back to normal, so we can safely revert this commit.

> This reverts commit 6e6363dd2f1e5b3e42505606ea494572c81dbb64.

This commit doesn't appear to exist, you seem to mean cce2200dacd6 (spi:
cadence-qspi: Improve spi memory performance), I fixed it up for that.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--Pph/ciYbLzXIiN2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfql4IACgkQJNaLcl1U
h9DS/Af/SikWQoXb9KDOZpTPfWks1hOs5hW4C+cZwM2+og0A4NXGXv4C+/ZMS32Z
UcWfmrLzvXrhNV41NXdV73F+dglEs0TJx7SWWk98GG4PGI3y6lOh8LZhlaiCV0qi
gVqPUeoUAIkv0Ban7IhYRspQyz1tKEeYxEt66fVk2lOhAT0a5z0qf0ECmVjMu7S1
WtvgB/XX9c+te/GJhiMCGC8jWj+7HIkMXCX1s7gtKvCTy6R4V1wiCKBb+IE0bluW
bK4bEfIQGBZU2AmXcITe7uqTCO9ETiVPbDR2f4JpkppXCDR1tTeaDzRJBEbW6ZFx
gok/7wML3jgrSzDjH2jlnvzaCSKOrA==
=NqLD
-----END PGP SIGNATURE-----

--Pph/ciYbLzXIiN2d--

