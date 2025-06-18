Return-Path: <linux-spi+bounces-8641-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694E7ADEC13
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0722188D778
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DBA145FE0;
	Wed, 18 Jun 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEQFVbGt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CA2F5336;
	Wed, 18 Jun 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249473; cv=none; b=jgVWwxwz0aDDvzmZ6eGzE4nBaws5ZqjfyoZ3z8u0fohXWPMckNvGC+RhZ+uemlXA3lsnOXOjti/yBwBqH5J9ETfAqrNp2JDp0G71N3JcBxilTkHm9lRKGvO9Ugov3F5bpnPyqDNfLIIlUI+yT5jL+SNfSgLLZQT5fe0dCyT/mRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249473; c=relaxed/simple;
	bh=zHK+0dJw9hbKdjwDqLPDdTE7UAQG7bf8mukhi58+Qzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIp+q7+DnuOkCEglxTW8sjiiQ8iGjzIVj1kGyujcGpGQYl5eMnijGkIZv6VItqfml7c1nXNM4RI2pz+jyigTZFISvpMIg50gABZ6PsSCSQrgr6va3TPFB853cHI5noZtNmUczVuP2mrxL+70a102zeUBF6myUAE29Tm5w6cqHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEQFVbGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743D8C4CEE7;
	Wed, 18 Jun 2025 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750249472;
	bh=zHK+0dJw9hbKdjwDqLPDdTE7UAQG7bf8mukhi58+Qzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEQFVbGtdoxye5TgEDftWMX5K/o7OKZiUL15zhRKaKhGk78Hhc6fBlGGLDsJe/C6V
	 rjWDcD0pJxgtFb9pHpnu77JJ6Iqp3krYvGlcDJrIBwNlETUn6PKwmsphwpLDxWgKz1
	 DU/mUrBMWXo42o9des5sO0hq9ljvo2VVN9QF51NqyT0eDAqAOnWVi3PYhmHXeaLRxp
	 WxXVvbjP5juvlMGUOTLfRza/R0lkhUjbBC6CYXchG+CFMdKARzU7RIqUVEVUg9ABup
	 Wp9/eJaCjKhVrawaXxnPG6V7n8gDdyswb6nfr6cRshd9zTBsZ40Tn7/H7xrTabAXv9
	 ZtcFquSzeQh7A==
Date: Wed, 18 Jun 2025 13:24:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Yogesh S <yogeshs@ti.com>,
	Santhosh Kumar K <s-k6@ti.com>, Steam Lin <STLin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/8] spi: spi-mem: Use picoseconds for calculating the op
 durations
Message-ID: <a44f8212-1d72-46a1-983b-9f46ed66da03@sirena.org.uk>
References: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
 <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-1-513202126013@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfg94TGuaFvTP94K"
Content-Disposition: inline
In-Reply-To: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-1-513202126013@bootlin.com>
X-Cookie: This bag is recyclable.


--lfg94TGuaFvTP94K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 18, 2025 at 02:14:18PM +0200, Miquel Raynal wrote:
> spi_mem_calc_op_duration() is deriving the duration of a specific op, by
> multiplying the number of cycles with the time a cycle will last. This
> time was measured in nanoseconds, which means at high frequencies the
> delta between two frequencies might not be properly catch due to
> roundings.

Reviewed-by: Mark Brown <broonie@kernel.org>

--lfg94TGuaFvTP94K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhSr/oACgkQJNaLcl1U
h9DxUAf9GvYchrnMdIcTNMB9jdHHlfaLK/FwKb3Ilgyeyek+3ELS/xvAkxnZFvsB
QZ0R21ZR86JtbgXqo8+s5P7E+y8wbfGRkhuan8C0fpCAppMH7vGbjroYijR9JbaL
koOZc5Mk9F+zAjKEhPA//OinNX4QLikcrM6BfgasFmmUgnTIlpxVGnv+0qz73bQ6
zRH+b00aMa0Sy6vYYxKkQaL9nMEWMmvAwMTBHtTChje/jvBOxTA/c3d3KLc6PCld
5aTehbQXMQdwlvwo/70vl7gR9vy4FmAz/4EPKBcO8YleQ69JL93xV3ub92T6Bv8R
6IkeyuzONyKWBjgnQ/8BECZmiNNJ0w==
=b2iI
-----END PGP SIGNATURE-----

--lfg94TGuaFvTP94K--

