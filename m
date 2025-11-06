Return-Path: <linux-spi+bounces-11081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31255C3B1D7
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 14:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B4501CC4
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA932AAA4;
	Thu,  6 Nov 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzv8VfOt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32CE2820AC;
	Thu,  6 Nov 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434327; cv=none; b=bT4vB+HkhzmwuBseAh8bPQ67RXQ2EYP1sL/tXNoUjVUJMJzh7TCFY/g+7V391QR1X83ITTqnVe7HlW52mzYC7hs7XuGsAYL1l9IQ11Bl/BbQbjWRRfbX7t+e92PYTVYD35LA/HBPf+8ETVazdxeeklm1pkWlaLanP7o+0mu7Gyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434327; c=relaxed/simple;
	bh=tyPnkBqS2IRKn0BX1hOVQKSWQFZ9GJ9UpVno1t1C2pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toJ/rRBJ+n10U7zDGvSv3vBkkMSkxY+T338Y7BZWRK9vLiS9oyA6cXBXeVtQg8eyfO0GSciTo+aaGWOaR8qPO1DnAT/Nsi4TsCVGhowZVv6+BVoBff9acvPc12RycK/kPA196sgEHOxyOUJXvLAEuvEO8IO4EbkuHUgYcsWJ9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzv8VfOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7966C4CEF7;
	Thu,  6 Nov 2025 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762434327;
	bh=tyPnkBqS2IRKn0BX1hOVQKSWQFZ9GJ9UpVno1t1C2pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzv8VfOtPdu1QaOc79gAmHKCNRM89n8eIfaAInyUzKUTTC4CDL/Ksag+0AptmdbOV
	 DC99z6Z+xZsaMQgIgzIJq0Zb3lqdv9X4EWGcN7dCSpfei0WtgJnRELjPbmvqLDmBLD
	 VRzd/BGOXItW/JukwgchgPbH5E+poy0YNT0A0bi1dPeFtHbVapGZS6bmFwMP1m/FY3
	 OCrw0JHHQLx66mrEh1TsHiYlKC5axtEMEDJfraKP91RIxutIsP0nNPYlHNzRtOSDO3
	 qDa85IO8JOEVM49mkT/utqkKZVwlyBSSozvOD/otR6j+rh8gfc6UjPbXX8D3h81Ons
	 ZW9zLZZ3GL8/w==
Date: Thu, 6 Nov 2025 13:05:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
Message-ID: <aQydE1pSmCcDwCPO@finisterre.sirena.org.uk>
References: <20251102190921.30068-1-hansg@kernel.org>
 <176242886085.2357454.1138821772017853306.b4-ty@kernel.org>
 <935e8578-1c25-4015-bd6e-a41cd0f07c81@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FPjVcJTpgg+5Ndqb"
Content-Disposition: inline
In-Reply-To: <935e8578-1c25-4015-bd6e-a41cd0f07c81@kernel.org>
X-Cookie: If in doubt, mumble.


--FPjVcJTpgg+5Ndqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2025 at 01:23:21PM +0100, Hans de Goede wrote:

> I believe that Andy's Reviewed-by was intended for a v2 with extending
> the comment with an extra paragraph with something like:

Possibly, but that got sent well after I'd got things into CI anyway and
I didn't see it till after the CI had run.

> Since you've already merged this now l'll prepare a follow-up patch
> to extend the comment with that info.

Sure.

--FPjVcJTpgg+5Ndqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkMnQ0ACgkQJNaLcl1U
h9DUwQf9EvJuDvVEn1XNm633osZNAi4GjExAe/IwGNcXMzkbFi45RMWmr/SJrKvI
mBxkUcPrBK15kI848zQcPPgXO3j34jSS4ne/6rF92EBk0tzEw5YZQenf2DfTde6I
DzNysK3Hohje8jcd16WpJ4SDcRSWGFb4UudPe31G3e2t41b6HcMIXdeklwIk18Ga
R1tiXBo8hOW+qkKXUZ5MRkXcX+LZnk/Ofh1HA10Xxq0o0qXnm3VzCN8pOJpZ7HQt
Mjxv2cIlLuYnHH/qGIkXfuLPySm6s6uSOiJVELK2x1U5Ls6mKajNeixP1H+kUlek
gzAQruJfutn62isNb/tGZPp9Lu5RFQ==
=uVud
-----END PGP SIGNATURE-----

--FPjVcJTpgg+5Ndqb--

