Return-Path: <linux-spi+bounces-3469-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5990EEA6
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13472867BB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA161459F2;
	Wed, 19 Jun 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1EMpIZT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B783C0B;
	Wed, 19 Jun 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803838; cv=none; b=rJk8cMjQ4CvRLCH8bLlj/u1fK14yCeXXTjDtX5BzM0vNaVmJN2RPmXy3+P+nASoQTo2B3Yw4mUklcJ25+yZVGTBr+QNkhnZc5wrtdT133N5YVj1TjgtSaQhBxMAUj9ALlCGyLUt6OxIBjkV2wKPx56lVnJigkZu78M7OprmpvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803838; c=relaxed/simple;
	bh=wYOFD82t4v7k8JjPLQqTT4vKASwcpulAg1FaGqWT578=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVwMSOC1n6dUt20yQsDpd+MAN2LJZ3YP2eqPmCDKXs5VRiutyye9oNZckkIlQ3lnalPLlG0ZVV10t6RCO6azEvsEgaBNf3aYX33QqxDSiY3vNKWwu1Dq9hKgxNyTm2mjeeU2wZwPSXakGLXjnzGZZEr02OM4FHM9fJc+gnimYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1EMpIZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8288C4AF1A;
	Wed, 19 Jun 2024 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718803837;
	bh=wYOFD82t4v7k8JjPLQqTT4vKASwcpulAg1FaGqWT578=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1EMpIZT52pGnbOuOjlfbzaimv4LfFRUs+qkfCam7jTmpCg2E/Un2vmmuvmdKxmrt
	 lZlJpQDElii1v+2/e4VHknKtPDRrnjz//abJ5FTZURavwXnoYqDz1sCnrPTm7cHM0P
	 lljEJA02Btk7sk4J2U1BrSAxfemRn1iP1Koyv5zuvKYLCEN08o9lnPUm4s5kssm7f/
	 ZdPDqlrTrWU2/A0nFQHguY7G6Yg+hFAo5ZIkcMbi8wE0vKtit/466Iqp7ZPhcojuRm
	 AVWp2qiEeKuKlO68vyn6+TnfpXdYtC48feWpgGvIjcWpRfOm/S8beIOYLciG9iudHH
	 EYXrgh78uEMBQ==
Date: Wed, 19 Jun 2024 14:30:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/2] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-ID: <d7502ea4-03bd-425a-8566-9ab0a6ea32e1@sirena.org.uk>
References: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
 <171880144842.113265.13864100805243474696.b4-ty@kernel.org>
 <ZnLcjO67FH2weX+y@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uNjr7feeoI/PFmkY"
Content-Disposition: inline
In-Reply-To: <ZnLcjO67FH2weX+y@opensource.cirrus.com>
X-Cookie: Don't I know you?


--uNjr7feeoI/PFmkY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 02:26:36PM +0100, Charles Keepax wrote:
> On Wed, Jun 19, 2024 at 01:50:48PM +0100, Mark Brown wrote:

> > [1/2] spi: cs42l43: Refactor accessing the SDCA extension properties
> >       commit: 6914ee9cd1b0c91bd2fb4dbe204947c3c31259e1
> > [2/2] spi: cs42l43: Add speaker id support to the bridge configuration
> >       (no commit info)

> Not sure all went smoothly here. This seems to have picked up v1
> of the first patch and not picked up the second one.

That's because when I told you that the second patch didn't apply I left
the other one in the queue, and what you sent now didn't apply either.

--uNjr7feeoI/PFmkY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZy3XgACgkQJNaLcl1U
h9AJiQf+J2SYf5OBoaoHE0eCB0wRaGj86y8jzvLRw4+FzRPLyd91mv3AJic7zj93
i7iN5fMg9oNNpX1DTiEQwfjkhC8iJ11YwVwp3ARPxWbGgIiSG/j4/STbYxjkaiNh
s2ySGwCGjzzUVegAej0LDQyRKRxCj7BFyWgG1D1MMj9uMkZfFNSReN/mks2rLZJ4
wHZuYqfk10MGAc5AStw9jX16C0plttTd3yPlEn+kPm5y6o16tTzt+s11oxmvB6Sd
vm5jH9LAzYLlG+zo+iq7ZG+lE6GxtRWBrJew27g/Plrqff1ZL9eER2vkSDKVVR/l
T4+KzysGjnEGSHTuTKnWzibvM209NA==
=XR22
-----END PGP SIGNATURE-----

--uNjr7feeoI/PFmkY--

