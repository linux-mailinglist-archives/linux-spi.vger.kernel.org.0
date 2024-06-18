Return-Path: <linux-spi+bounces-3433-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A2F90D397
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 16:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175DE286BED
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442E19B584;
	Tue, 18 Jun 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyBXJ8sb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4913A899;
	Tue, 18 Jun 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718580; cv=none; b=p+qYQV61cKZmXfV2/u5tELML8w6RBN5OD04JCJMF7MBgvVLz3ESr0yiK0cq7JNeK1y2ogdE913r50TAd5b1AvswuhV5Pf2RB/uYm4zsDAJRJBXrNd7UxM2aXCv+zUHZNbCUxp5D1rrCCKlRTUAorlis9AsUrT360Vex+pRV6y4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718580; c=relaxed/simple;
	bh=E17YAOzFbfC+jQEJ9xvHNzCYANA0NHzB40zEgSfNb8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tkaxz2R2zdVcegNe7nVeilMy3F9t0gWIQva8zFkCQeAmh3z6zF/PVhi2QA+jxYUf8wVy3otGYI3/kzNtI4n6vmnghbX35XQ4N//mEYFEJdCUA+7n+XqNJGqXIQU9bgJ4TUc1w3KCexrDFOtOIxS+FYPwCO+5n6jJoq26lBw3GCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyBXJ8sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1732DC4AF48;
	Tue, 18 Jun 2024 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718718580;
	bh=E17YAOzFbfC+jQEJ9xvHNzCYANA0NHzB40zEgSfNb8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyBXJ8sbS3dmNBGeyUaA+c+2R2KiipS5dL9JTLa8BnYrINsYiaFxPkIHwoKrj2EHn
	 g1lu1bBF2p7MkvVsQN/cNCZaE+04AaKlBul9WrDNWDTv0V1E9ZfURi9po4dgpH5Pqv
	 wn8jFHlvmmo8C955fOQ3FRiahq3Lm5uidyyKdCpXfYkk6XB7K6PQiMMxm3pY7FIfoi
	 +lxKdpd/Ml8nGui7OaKx7RJNOsh+jY2SF7m6pkzrK/mYAfDPm1yNF/3gUsw9iOOacc
	 Qj7zeLkvXSLMsbGQW08X2cu9QnSDa9/CHzkwdiMOMJb05+Gpprb3PlZ7fxOHSHtFOk
	 wntuIYlFNeW0w==
Date: Tue, 18 Jun 2024 14:49:36 +0100
From: Mark Brown <broonie@kernel.org>
To: alain.peteut@gmail.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alain.peteut@spacetek.ch
Subject: Re: [PATCH] spi: omap2-mcspi: consider gpiod chip selects.
Message-ID: <c7239675-6021-46d5-8325-03059db244aa@sirena.org.uk>
References: <20240615100610.11587-2-alain.peteut@spacetek.ch>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QuW5hXZiGpRnuM4b"
Content-Disposition: inline
In-Reply-To: <20240615100610.11587-2-alain.peteut@spacetek.ch>
X-Cookie: Do you like "TENDER VITTLES"?


--QuW5hXZiGpRnuM4b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 12:06:11PM +0200, alain.peteut@gmail.com wrote:
> From: Alain P=E9teut <alain.peteut@spacetek.ch>
>=20
> Consider gpiod chip selects, in which case channel 0 is used.

This doesn't apply against current code, please check and resend.

> Upstream-Status: Pending

That upstream-status thing probably shouldn't be in submissions.

--QuW5hXZiGpRnuM4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxkG8ACgkQJNaLcl1U
h9BYrgf+PP4V3EMTNKTKmYva3ta57wFqC/Ry0F0M+v9gryMZ+k9VrJFwoeYn+zkj
v1yGf6oC+PEuYPNB+kfRz6wGCmEYH5N5ax0d258jO3hOyjWGuL1X3TtaCtIuo3mL
lnyxo0wZJjLC2mBxcs1iuRHKWkeuBRaXA4AkXxWIxxAT4XXsgfiY1IvfF2ni9kcR
ullWDv2EWRGNvTb7PpDbmgQLSzU1Q+Yx3Xt8JWLMkWwbVqhqNvvyeW6NltV3QDuU
gFr/YTMXU0+Iak4JRIr5MWOE1yftndbVyMd/Qo6x5l8yrW2eeF37R2T/OQqmESs1
79vKDOBkh2xoqOOSSx5FIKlbHIrqkw==
=aTGY
-----END PGP SIGNATURE-----

--QuW5hXZiGpRnuM4b--

