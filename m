Return-Path: <linux-spi+bounces-8778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B96AE9135
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A20D4A5FDA
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758926D4C7;
	Wed, 25 Jun 2025 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9lM+5Gc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3C4C83;
	Wed, 25 Jun 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891409; cv=none; b=h1aQw1yAqx7iGEjfbkTKKVr5nnRSYVb5WYqMCrdTZcSISmx4xhgp9A92LE6j+srZ7MDp4o3qykj2gBFpPdbGvg3fqH2a0W4RvR5AQmwjd5VsIU3RIVO+26gsSR5WlIMDqK+CG6IGBP8eI1n88pcUWDpoAsaq0lf4fxH2hBP+ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891409; c=relaxed/simple;
	bh=xZtSzPqdbJ8208R4RJdG5ryYeh1/4FRyOAC1mvLBQrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POr3dysMLqATQjGuCpPU8V1Y+DztNFb2UZ5WykRrvERZN74Jl0mlIYIFny3VJfZunKIjO2fQdnf5dvmE1Tzd5Ud4vo9mQef5yPd/iCT1Al5wgiRHFsT1fhhJI054el5sqei29d2BwMG55H8ip+PYBoe5EfWeoOEO71wwplIHNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9lM+5Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1586C4CEEA;
	Wed, 25 Jun 2025 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891408;
	bh=xZtSzPqdbJ8208R4RJdG5ryYeh1/4FRyOAC1mvLBQrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9lM+5Gc+L7q2ca8HZzWtCcZHjuqT+xnq1wlbdQIhJl6GxXCYLWDUcazMsQC5MTo4
	 PWlHHO2snzOKBmHolt4bLf062MLyx5QG6GE2bhJ9ZbK9EmvPasMFPL9zEeyuvo0qNw
	 fBJ3p3ZiEeXAE6UEAwEj10f19WjdQI2lI9up/mosp5lmH/F5EJe1XMkZsEp2Vkn7JL
	 E9H7kNoTVa3jHkzwArtNGJvJlyFMPmCIM4ahC0ZNwPAGu3wh7NxLYzlxlsl6aA4K3D
	 X1Lw6y4+4UA2spjku2uyUuXl5D0ZYtt0Enns+LYhuqghGJN90o4xxLnXBoqBOW9ikj
	 +/tRezTKybA0g==
Date: Wed, 25 Jun 2025 23:43:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Subject: Re: [PATCH v3 0/2] spi: spi-qpic-snand: avoid memory corruption
Message-ID: <aFx7ix0uikB8dkm4@finisterre.sirena.org.uk>
References: <20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6lvN9Ro0oZtMf/Z5"
Content-Disposition: inline
In-Reply-To: <20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com>
X-Cookie: Do not cut switchbacks.


--6lvN9Ro0oZtMf/Z5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 10:22:48PM +0200, Gabor Juhos wrote:
> The 'spi-qpic-nand' driver may cause memory corruption under some
> circumstances. The first patch in the series changes the driver to
> avoid that, whereas the second adds some sanity checks to the common
> QPIC code in order to make detecting such errors easier in the future.
>=20
> Preferably, the two patches should go along in via the SPI tree.
> It is not a strict requirement though, in the case the second patch
> gets included separately through the MTD tree it reveals the bug
> which is fixed in the first patch.

Miquel, are you OK with this plan for merging via the SPI tree?

--6lvN9Ro0oZtMf/Z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhce4oACgkQJNaLcl1U
h9B+2wf/eAiUMzOvjQ9ulZwzoVeTR/QxB3I0UmI2oTP88zeNfeOivQc5l31yTtca
U5r6vueSYI4LvMYCwSgpG+4ye/1ZvpBMbpRXuNYCV/xC+jwtWwGerxk7MIlp3vLC
yLkvKnpYCwljsjZUx2KgkKmrrA+zttfJWWQwhRbYif+Q3mo+p2Y0kqBF01V7GYDu
CKOQP+xrQnTLzgmr38Rnw+YH3/x/gZBxWLrwIqagVaFfY6iMDWZrgw/Q9fzOFX0V
uqKFR36pBXSue/r5MXTFY1mLwc4IVKqz8jq+wLZuo72ZBxvcboZk7I4sgSkrivkF
kxPnKDJjk9t+6mW0SWfYBAHS1+qZcw==
=3z7M
-----END PGP SIGNATURE-----

--6lvN9Ro0oZtMf/Z5--

