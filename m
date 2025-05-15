Return-Path: <linux-spi+bounces-8123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD3AB7EC0
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 09:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F264A75AA
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 07:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5781FDE1E;
	Thu, 15 May 2025 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQLLs5Tr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B910FD;
	Thu, 15 May 2025 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294087; cv=none; b=US2Xl4kBp/y/dMuRDDg/vK7/ZsVtyUtF0+k6g6xYzdQsYp+QML+GDsIvqjNDvrA3lPCbBrOgHZR7L5X3uzhTdg3vVBFD3LnBIQkska+7bTee7gTNHMsG+OILM4eIlaQSWL79HfeuE2y7O9nuaUPq44zaWGe6EjAh8uaAxtXH2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294087; c=relaxed/simple;
	bh=K2kUtX+3sSyMkCcm+fzXWw117z2H94yxsye744/gz7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR8CDmV0IrObhQEH8zer/AePJfrPwapjUAz4aff9nJLIB33jbaDcO6BrbyopvYjBrKO8V1BPxxa0OaeD/yg381HSgQPK/MPlN/KM2MDEGyNtGCG0WlotpZCKmpJ9n5V21VibhxqegHNASvJuMgNDXQFmdqPTBH15xgOfjC7Uk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQLLs5Tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DF9C4CEE7;
	Thu, 15 May 2025 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747294086;
	bh=K2kUtX+3sSyMkCcm+fzXWw117z2H94yxsye744/gz7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQLLs5TrwNOSBRrmMd7jUhq4XAeup4XQi2txNbv3ohveOJ+STBRYSt5KHl35oaUHs
	 91131g16MUnYnf8HLdESBbYLwd5yeAsvwOMSOf7tdzJ7wfPhqlUIc8he58wnmqOEKZ
	 xZAB8pfNPgCzNfzo7YD7fEnKuGvS2AGyAlCf4EZTd+i2DQZgNkymDEbIAkgtRqMIYC
	 lxZ0enCio1n5EksoI4Ri77Ndzzmt5prYoJxBkMQgGCg59tKhrN62gG5wIWbCouVgfe
	 DoKwL6aNp4+XH/YVdgSgT6tPbmQY3qj10LTTM/79YFRRKEQYS1y9oenY5Ld8JYiPF5
	 rAmpIsiSiEjYw==
Date: Thu, 15 May 2025 09:28:01 +0200
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Vishwaroop A <va@nvidia.com>, krzk@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	skomatineni@nvidia.com, ldewangan@nvidia.com,
	kyarlagadda@nvidia.com, smangipudi@nvidia.com, bgriffis@nvidia.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] spi: tegra210-quad: Add support for internal DMA
Message-ID: <aCWXgaZ0x98y_bC9@finisterre.sirena.org.uk>
References: <20250513200043.608292-1-va@nvidia.com>
 <20250513200043.608292-2-va@nvidia.com>
 <9971eb7b-bf39-4b4e-aed0-7ea1fb9d23d3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hljwcVz6JxnWgiw3"
Content-Disposition: inline
In-Reply-To: <9971eb7b-bf39-4b4e-aed0-7ea1fb9d23d3@nvidia.com>
X-Cookie: Well begun is half done.


--hljwcVz6JxnWgiw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 08:01:47PM +0100, Jon Hunter wrote:
>=20
> On 13/05/2025 21:00, Vishwaroop A wrote:
> > Add support for internal DMA in Tegra234 devices. Tegra234 has an
> > internal DMA controller, while Tegra241 continues to use an external
> > DMA controller (GPCDMA). This patch adds support for both internal
> > and external DMA controllers.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--hljwcVz6JxnWgiw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgll4AACgkQJNaLcl1U
h9Cvowf/U9gM36cTsDIlpm/xr5FpzTqgckPbf/ufQQsN0wuWA1n/I25ehq7p0nK8
TG41mpliO8/qnFvJaijnHv8ria2ls7TA9aK0fzM0QdscRPf/9AiXOA94ToYeu9mb
hG2K685Gnb4A894piAJsUUA2Em1xkfvCF+hXdZQpTlyi8P/KXdL8X3adhjkLXqso
hhAV9F/getV3LIQ1n6uHAOX/VnKkFS56HbaCMXq/y6OIDTl7g5GLAwlh4vjhjR/d
lO35WKf+L7CaLZ3PIa9LgAkjkHSydvSksbQp/kgY2Ts1jmjZ5zSTD7AW4DobBxwU
cxCJgmOrlnwQbDJ6uON/qB8i/EHLXw==
=FHak
-----END PGP SIGNATURE-----

--hljwcVz6JxnWgiw3--

