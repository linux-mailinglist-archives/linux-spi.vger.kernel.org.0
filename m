Return-Path: <linux-spi+bounces-5792-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E79D4B3F
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2024 12:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1972844E9
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2024 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128981CFED1;
	Thu, 21 Nov 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCxTFDkj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30715C120;
	Thu, 21 Nov 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187108; cv=none; b=nHj3EIGSQhorulMz49DiPV2ofB7DrWjZ2W6XPBSdrTazgFknJDQPp7VkOweBZjrl0FQ/UxOmSdStQiCqBKzcVD2liCdKTZJyMObJz9I3mWet6ml7gOuypf/7vXrCvl2tBKR4Sps89YjXz+fXiLlJzkcfJqpt8ioVIzYeZNjl1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187108; c=relaxed/simple;
	bh=k5dVXDOTAihj9tWNR6WmNQRgIaOTe3OJFFKzKxUcEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5CC2JtmC9gTUQB8rDRR1WebpKkjbK+gr+8jlL5vP8ClEGTZWM5eKNI4p/F/bLn3obM9K6GpGAm8oZ4D/6T+7etJWMRrUCgcNE8gYqJfDtRMeVO0rviHqxR2+a2Yj7y6vb1RAbvIaJ9mDW6T0r/0Y3PN7ZFxI+UQsXiznJHZq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCxTFDkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AB5C4CECC;
	Thu, 21 Nov 2024 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732187107;
	bh=k5dVXDOTAihj9tWNR6WmNQRgIaOTe3OJFFKzKxUcEsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCxTFDkjIPdI9BGvplqQrovUeZY1/9bjSd9nJVyTa6Qd+xU94hnXO6r+Qjcbs3Ffe
	 lL6IjRq4aRwnyur20E8Lmjywjm/qqWhnpSD6IbdZzv1dgw0yYvgb0IBxkiUFB4z3hS
	 46EbCQEWoWpMysnNxzzoVFlS8xjzzNLWXXkJiWraZZrKwFmai9fEe5iA6kwsBzRN2u
	 /+b1c5NjqXQZTc+DOUblphZScPdjV3U5XNeLX67JoD3nvPJuwmFMuv4K3rssDUlbWO
	 MgVuxet2FC71xH9bQk9+qedpQ7J9XG7CTEDp7U9XK8GU9zTR5TLyJdC6GLw+TPT1oY
	 Oz5jrNWcJIqvw==
Date: Thu, 21 Nov 2024 11:05:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SPI updates for v6.13
Message-ID: <708a1007-d7bd-4daa-96c6-4d4a8e12edae@sirena.org.uk>
References: <1c6bb542f52ef9a8428a0f35dc21dfc7.broonie@kernel.org>
 <CAHk-=wg9TZSLX0Dtbh5_oQK7temAjQCScVFnEY86NYSAO83pQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jzdlADKYbvbbUjJJ"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9TZSLX0Dtbh5_oQK7temAjQCScVFnEY86NYSAO83pQQ@mail.gmail.com>
X-Cookie: Fortune favors the lucky.


--jzdlADKYbvbbUjJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2024 at 12:24:29PM -0800, Linus Torvalds wrote:
> On Mon, 18 Nov 2024 at 05:33, Mark Brown <broonie@kernel.org> wrote:

> > The Rockchip cleanups

> Ooh. Cliffhanger. Continued in the next PR?

Ongoing work, clearly!  Oops.

--jzdlADKYbvbbUjJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc/E98ACgkQJNaLcl1U
h9CwWwf+NxCbsmoHOYHmudmgGkjBNFo0Dwsu/wxHyeeo/4i4D5DLkfqtdXTamYu8
Bnw8+aP9EVlBjuhhD5ROL+xCG6am39Y6c0ziyNIgDs+ZiFKMHLhDUlatDnyYEifI
cBxSv6BTPb+UA7NyDq/bwmAtIs5UfOFJtnMnFKpBvl/N+Zu67+2jRN2OQ2fwc2QP
ym/DTvlUlQylGlFW+n8lY8xd2V/cQpX4DGCQ8+cM4Lae7eu7SUzEpAFgYxbYIWgN
ve1UIXyAMIJe+tu2+f53nB/qlRIYdhGOiEVXp8myDgJw9FtDqXzCwUd0AWDxQfr/
HKLLIp5kuE+ShyNXbPw6HVxYfcMEXg==
=DGr+
-----END PGP SIGNATURE-----

--jzdlADKYbvbbUjJJ--

