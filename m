Return-Path: <linux-spi+bounces-8806-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E032BAEB59D
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D2F562507
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294229552F;
	Fri, 27 Jun 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjI4W1Z7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD529A9E4;
	Fri, 27 Jun 2025 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022049; cv=none; b=B0SipqKp9Ixj7ejzVxp9nUQBMgnabIFZXLOhbWSMoDyJ0rvtEjrDfoDOgbF/ORqGvlle0kZ5IG7LDofHCq43R1jegm+Yt/0eyVtDY6biGy24jCrVxctaabUupwr6HnDkTheWd9HfeSD9EMjJSm+F3oCi1b5j/tEp+oPqQEugNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022049; c=relaxed/simple;
	bh=lqMMTP1yhhlfjf6iJhvfIFcNWwN4TjqIAC4xUq/hPm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNZ39buHCvCCI/PZAgC0I+1fO8Jqi+xh1IQYhM86yiTrGPZ896Cd7vorrF8rmnJesXR4TJQ63h2ZSknf1/jAFrKL9uPGweCKSCithgKRnqAqvi0ombzDB+KYKe2hQ3yZ2BoNcEUd7PybJTEdQlMuXP1LYJR2I7E2aHnbnGTzhJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjI4W1Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3EDC4CEEB;
	Fri, 27 Jun 2025 11:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751022048;
	bh=lqMMTP1yhhlfjf6iJhvfIFcNWwN4TjqIAC4xUq/hPm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjI4W1Z73WmLTsreROLH+fYoV6wXIJEMOb3MNKX/yuRJmS7griT1taFprJ5PGNkNc
	 m4gYkn7Nhnb5Tc56ERd9/1X4hQK374cglRCaWiyqZxi/Fk0gywqShd8G5bzk/HAVZ+
	 uhJNuoqDhUf0Qp7A2KdbKTSj+oMxAoL7cvdDg4XwviAc3mmrmckadBlt9H7uDT6tL1
	 Gfkr9kz7XBadf7H9ZVcDnz+eX4FOzkmyjzpQ7fmbXQdbVuXSyJHppShIXRR4L20wk5
	 STdzfO503JuVgiF3SrFLsZ4dmDNUjlzyjWtqGKnj1GLPzX/ig29bWxlCTtP7EMyecy
	 bT/Kk4oT47SGg==
Date: Fri, 27 Jun 2025 12:00:44 +0100
From: Mark Brown <broonie@kernel.org>
To: "Hohn, Torben" <Torben.Hohn@bruker.com>
Cc: "amit.kumar-mahapatra@amd.com" <amit.kumar-mahapatra@amd.com>,
	"frogger@hardanger.blackshift.org" <frogger@hardanger.blackshift.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux@roeck-us.net" <linux@roeck-us.net>
Subject: Re: [PATCH v2] spi: Raise limit on number of chip selects
Message-ID: <aF553GU_btT81_b_@finisterre.sirena.org.uk>
References: <FR4P281MB343441EB901D3DD286B923D6837AA@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u0SfgTdM+pvwNqIA"
Content-Disposition: inline
In-Reply-To: <FR4P281MB343441EB901D3DD286B923D6837AA@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
X-Cookie: Do not cut switchbacks.


--u0SfgTdM+pvwNqIA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2025 at 04:58:20PM +0000, Hohn, Torben wrote:
> Hello Marc,

That isn't my name...

> +#define SPI_CS_CNT_MAX 16

> If this is increased to 24 now, we need to carry another patch on top of mainline again once we add another Chipselect
> into our FPGA, or into the next iteration of our hardware. We would really prefer that a Kconfig value is used.
> We have handed a patch to pengutronix, because they can send proper emails.

> In the IIO framework there is a Konfig Value for something similar:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/iio/trigger.h#n74

This doesn't really work, we're supposed to support single kernel image
so putting per platform configuration in Kconfig ends up being at best a
usability problem.  At some point it's better to just bite the bullet
and make things dynamic.

--u0SfgTdM+pvwNqIA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmheedsACgkQJNaLcl1U
h9AplQf+MNNvZr6JlQ5WWyzKnDpp9b0sjYa821cSH1QHeD+oHTrihMnplm+jnQ3Y
B1V8xWmszYWsy6m8ZtpZPr1be703DDoS2dfyOe6EnY8dLI2hrWQvJmtUcLvBxZQi
VZakbibVhTbWVaUWk5z6jLtmpGMuQKG005S0jtuMJtOgLICgYTYeHX4dzlxuR4Wm
I5vzSZHDwEBDoVH62o4FbWllRnV6Vm281oP/dXWcP6L2xxQngG4/LmxZZy70/Zro
5uL/rLzlOPGj+/48E8Abxn3lyKv7Azt4O9grikgyNfFjN2719QjyZ/TkC6c5e1pv
2NV66TvwnpBvh162R5YLFzPToo6dJw==
=Pcx2
-----END PGP SIGNATURE-----

--u0SfgTdM+pvwNqIA--

