Return-Path: <linux-spi+bounces-7333-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B6A71E00
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9999C1759E8
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56F24F5A6;
	Wed, 26 Mar 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJGvO2cp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D724EF9C;
	Wed, 26 Mar 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012417; cv=none; b=igbiZPWsMzNJRaEi6c6Q83xjcevCysECMkSUtBv2iSONQbY6GyYxW1d4iEpPb6Ye2pTs7lioTLHXzhPMT7gkA/fwWXjY72BZvrG6a3dE1J9KO9vt536Gxa3omZxqEIh7WAhcV8IPjBoz39210SAMcuSXVtPjrzrvCvReugS8v+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012417; c=relaxed/simple;
	bh=xZmto6xy2FwJIOZh4Ms9BaBl9VJWAQErx7qe5FfI9Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGcfspX/LX4ou8l5aCWlnG4A3fcM1mC5PpOJLe4pJoJjwTBUGpYDo0CarTbPiX0lgPdsGY0HaT+ysDMqmb40hIVYVSfJwLntKE3ZRFIuREljwIdwnCWP4xBDqyj+d2pBI3eiUFtBOUEP91NhEGZu3NOZUYyhsIVisnllu4pOXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJGvO2cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91847C4CEE2;
	Wed, 26 Mar 2025 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743012416;
	bh=xZmto6xy2FwJIOZh4Ms9BaBl9VJWAQErx7qe5FfI9Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJGvO2cpUVz1UYns6XwtDkaMcSSuLLWiPEInQ4aMgR3h6HoaEjccgoG8NxK3YnvjV
	 zp863Il9wP/cAQ34QXwVPkNqoTC9sCqtNG+edcXrYdl+3NNLUaMiaW+CXWqsO4m17g
	 7o7sWdvcsKrA6I3q9fYaegv5jwXmaK8HCxr3NwifBIkokrgb/FqzwJDDugRvaCVmY1
	 Z1dM+GppZZ8+9xZCqLtT5u9cVnDysRmJrr+sw7uRpUAzWXS8/BND94k4hUkAAmX8CO
	 v5gHOlaOnbUQTuBPjUl/ousdRYcUcSn6dwFRS+HVXmcgRSY3KJ955BGHNLeDGUAA1G
	 9YakQDM3cT7qw==
Date: Wed, 26 Mar 2025 18:06:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spidev: Add compatible for LWE's btt device
Message-ID: <5f514949-5162-4944-8424-bf19318c5611@sirena.org.uk>
References: <20250326174228.14dfdf8c@wsk>
 <20250326172445.2693640-1-lukma@denx.de>
 <83685ed2-f41a-456c-8a22-0ac069304386@sirena.org.uk>
 <20250326184553.0756c496@wsk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KOmYkEZJBTd6ttoT"
Content-Disposition: inline
In-Reply-To: <20250326184553.0756c496@wsk>
X-Cookie: To err is humor.


--KOmYkEZJBTd6ttoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 06:45:53PM +0100, Lukasz Majewski wrote:
> > On Wed, Mar 26, 2025 at 06:24:45PM +0100, Lukasz Majewski wrote:

> > Note also that as previously mentioned I expect to see a binding
> > document update too which doesn't appear to be here.

> I've just send it to be accepted to trivial-devices.yaml

As previously mentioned you should send the bindings update along with
the driver code.

> > Please don't send new patches in reply to old patches or serieses,
> > this makes it harder for both people and tools to understand what is
> > going on - it can bury things in mailboxes and make it difficult to
> > keep track of what current patches are, both for the new patches and
> > the old ones.

> Ok, I thought that it would be the opposite - that you would see v2 as
> the reply to the old one - especially that the change is just a single
> letter.

That's exactly the problem.

--KOmYkEZJBTd6ttoT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfkQjsACgkQJNaLcl1U
h9CV1Af8C2RDdHT2B4JLU3zx122STiDveRWhulz2BqVkulBmEStb3Bem1f5YDj2j
EHNS/ZpQ2/Hyz+pCtoMg+rFvu7iMJ16M0+FpDtH+I1T+h3ESsPR78MGEs5ou88Nh
N8ZSExLFOl/IYJY3ydbDHHgHxBs8NjgjufCTvHHcNXtHXmkJtWvgD2ZWJtSChWGY
RuQuEvB+UQAO/zARGfaSOE9CLmGhPc7ys1EExo3W9zrvLpnwVF3wbaPIGvCkmMyF
dGT/JK3Obru58bNaiZBxMCJFIcWwqH9wgVazw44JfoWHooEH68X+VzYAcQpHi5pR
KZyW+58iVuD8KXMQX1oz3Vj1SlUrGg==
=oY37
-----END PGP SIGNATURE-----

--KOmYkEZJBTd6ttoT--

