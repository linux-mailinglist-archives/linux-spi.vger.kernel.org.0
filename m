Return-Path: <linux-spi+bounces-8218-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4434ABD69B
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 13:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEF9168154
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97921CC40;
	Tue, 20 May 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H07weQCz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C711CD1E1;
	Tue, 20 May 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740006; cv=none; b=NBNT+uEULxBx4Z9aSuesMHSrWJThwHHu8TQCGXM9wunDEVcNv0P4QKt3WObWUn4QitZjG5HFpzEDiRJqW9OrCQK6vMvjJAeJvAb2JXIHNY9HggkjSLGdgzQ0/ZEfNX+z2QXYbjuSiFNHRKjahRwpu4oL3wSunRV2K7zWvRC9SMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740006; c=relaxed/simple;
	bh=uvf7ZaTZaO4yB2j8Ahfyu1JB7XVx52gwFdoPqiZtg/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZIuCwTK0PXfRk/9rGG634LrtTZyn5eOj6pransc3153Dw0fF9OFuoUZZnS2P3ycfyuSaIoI2JaXMtX+qY/5MFVdyi6+bgxx5YuBeYCL7FiYBNil5juXDbjg5Nlr+7rmBz0KaFqL7CWeHXBrFwcmWEpNLl0mAwqSQA1bHbso6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H07weQCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F07C4CEEB;
	Tue, 20 May 2025 11:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747740005;
	bh=uvf7ZaTZaO4yB2j8Ahfyu1JB7XVx52gwFdoPqiZtg/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H07weQCzJUhM3aUYL3LzE5jXD3lUTMcRnBOHenFobLigGb00xcuTV9gIcjYgCt37G
	 FhYJeyx9828GZ4bNsOYt6s+E/XcdOH51muU3r3eT8AKvZBZX8hGAaFTGdM32tYKoco
	 jfoIcC1OFVTaTu3gZkfm/Bb+s4bgF2WbeL8OaRv04gVuCVmF2IqGXLxkEqE2t+c+jZ
	 a2SjUI20WiJu1Hq9rgCzqeu6L5o48FXH9bFFBe+r5OMiKf7WvNZWp9gLEdB+FvM0NK
	 LAN9+OYiZHS96D4edoMyKGqs9aZVfRmgq7OAKxl4a9+kuWzeelZOQKBRv8Ao+R1zBJ
	 IfRC3D90Vtk+w==
Date: Tue, 20 May 2025 12:20:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 22/22] ASoC: renesas: msiof: Convert to
 <linux/spi/sh_msiof.h>
Message-ID: <63d43d81-afce-4dfd-9be2-ec2ca2bda8ab@sirena.org.uk>
References: <cover.1747401908.git.geert+renesas@glider.be>
 <754ed54057e54effd06143e71d6cd305c3334eca.1747401908.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9u/60dkouFLa/oyG"
Content-Disposition: inline
In-Reply-To: <754ed54057e54effd06143e71d6cd305c3334eca.1747401908.git.geert+renesas@glider.be>
X-Cookie: Approved for veterans.


--9u/60dkouFLa/oyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 03:32:25PM +0200, Geert Uytterhoeven wrote:
> Convert the MSIOF I2S driver to reuse the MSIOF register and register
> bit definitions in the header file shared by the MSIOF SPI driver.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The dependencies and size of merge were looking nasty for a cross tree
merge, I'll try to remember to apply this at -rc1 but it's probably
worth checking that I manage to do that.

--9u/60dkouFLa/oyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgsZV8ACgkQJNaLcl1U
h9BVXAf/adHcPxfwb0JH4dJuQf58aSUVEWGX4D+xJkIZCxdk2IYlTa7De1CjmVl/
L5Cihdx+4X/Twjo1/EwtNx7ZoIOnT6AvFiHKBuJJQbKgY7iINYXLIjyntyQcNl3K
uQyGPIuq1d5+8Ii6GnbZ9Q679NFzbfSfLUFnhFcZNGDlkympDg8dvMz+qyaA2nTc
tlcvyVLfqFEOvXDmvFGlbzlPbJITqw47yTVyw7ALc0cDCEe25LL4XS/j9+ehDfzk
boOSOXu4CEr27+ZOZbgsQ7hO7CadEmdY85wVWzEyZtU3qJuAMjR/UGw5W2gb0Gip
ZRjqgISvKkCotEkvZojtAVbQ9QFG5g==
=H4cg
-----END PGP SIGNATURE-----

--9u/60dkouFLa/oyG--

