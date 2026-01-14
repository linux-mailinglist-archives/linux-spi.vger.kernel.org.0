Return-Path: <linux-spi+bounces-12367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F82BD1E5F8
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 12:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F126830057C3
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D78387573;
	Wed, 14 Jan 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRxBz2YN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A538171F;
	Wed, 14 Jan 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389937; cv=none; b=FmGJu4DZJLqgipAXdueMeXhhulchNws+oscOZnBAPAZ5U5OqunuPhWSalCQVpseSSej0ZKaBVO7BXqgKoDTF1x66kVsmv7HrNJR8ELwg35bgCZcyZCXkRigzodoc/aV04hH6CULdPyLq8eQEI0eGL6+46RGj3/tlCklcDsiL/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389937; c=relaxed/simple;
	bh=U6RMlAgcFRqPdzpR/EIwWZLTgG6XUg9BI1Pj/Gbu3QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS8fW2tAFCWSARMHLQHcKiPqWU8gKuYGSgnmakraTU/FyJLMsYY58xglWrV8Oua5QzS6a5VkPP2C6sWshmhnAYYeN34ogAgGbXTDoKhC9+fHVfbplAjq3zOxgizWqaXY5IBYrhbFe5ifi1xlxfzAe71+Ti7gHzD9r8cGkc9Rncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRxBz2YN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4886BC19422;
	Wed, 14 Jan 2026 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768389937;
	bh=U6RMlAgcFRqPdzpR/EIwWZLTgG6XUg9BI1Pj/Gbu3QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRxBz2YNtMNGHq1aCPPsMx0QHp4s8EDEZCsxOLNTTC6oqWlYR2SoG0G+ymX53S/Y8
	 e5z3B8UL6c/YhoCzk3QgGy37GFJckD5WJxeEvTp+ht1mTfFXEaqn1imiP0bGCSf20O
	 Fai/jt+k1gGXLqJYS+LHiMI4J/3/Oq1EALiZtXQSQOUanB5qeLCc1UUnr5liFRpW3g
	 TLkrS+0PlR6t1pAlz2FSq3DWYmPqWX6cIrrrpRGgXJtjhPSXQ5TvpoC0Bm4cA+1hyE
	 1VAtYAmKa5gXL29T7qXTNgqrxG8v9evr6WIZiKAGT1jJx7Jl4x8pnhDxZv2mGDc+ZB
	 TRO5y46ie0YEA==
Date: Wed, 14 Jan 2026 11:25:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 00/27] mtd: spinand: Octal DTR support
Message-ID: <61a547d0-592c-4cf5-ae4f-54456b08e83d@sirena.org.uk>
References: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="itinsQmmtHTcSc+n"
Content-Disposition: inline
In-Reply-To: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
X-Cookie: Absence makes the heart grow frantic.


--itinsQmmtHTcSc+n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 06:17:58PM +0100, Miquel Raynal wrote:

> This series adds support for 8D-8D-8D in SPI NAND, which can already be
> leveraged without any SPI changes as controllers already have this
> support for some SPI NOR devices.

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-octal-dtr

for you to fetch changes up to 8618271887ca10ac5108fe7e1d82ba8f1b152cf9:

  spi: spi-mem: Limit octal DTR constraints to octal DTR situations (2026-01-12 12:40:30 +0000)

----------------------------------------------------------------
spi: Octal DTR support

This series adds support for 8D-8D-8D in SPI NAND, which can already be
leveraged without any SPI changes as controllers already have this
support for some SPI NOR devices.

Among the few spi-mem patches, they are needed for building the SPI NAND
changes (especially the ODTR introduction at the end) and therefore an
immutable tag will be needed for merging in the MTD tree (unless all the
series goes through MTD directly ofc).

----------------------------------------------------------------
Miquel Raynal (3):
      spi: spi-mem: Make the DTR command operation macro more suitable
      spi: spi-mem: Create a repeated address operation
      spi: spi-mem: Limit octal DTR constraints to octal DTR situations

 drivers/spi/spi-mem.c       | 15 +++++++++++++--
 include/linux/spi/spi-mem.h | 14 +++++++++++---
 2 files changed, 24 insertions(+), 5 deletions(-)

--itinsQmmtHTcSc+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlnfSsACgkQJNaLcl1U
h9B91wf/ZanJsMJVyxIu9u84HYAFqkU4Kl+90t40mG9eWlxraksjBKZpzqupnA3D
Nrzw1RwMPqiWTlkcKlyJPzYnTb++uuYEDTOexISgEBN3WKBhkV6fFQQrkuWYqsZ1
qnaRwV3NwC5wGjXrbufqkIXrIvgdex9lZWMu3YRL1N2bHTscK5xZYo0q7IOZ0YvY
vP7TeSF7ldXzpWo+z2hFdHxKAcXtHopbvDxWFWFR6kDZ4eoItyvRpJ5P3eqAuUC8
X6IVy4ajVfL4eKlmnkwwktKsKq1bQBUVZmup6LKzoEwymLfvmSgi1Pqifgm5f15V
1QTg5nj5vZrDOKUMfi3wF4P/cvIuaA==
=xyvE
-----END PGP SIGNATURE-----

--itinsQmmtHTcSc+n--

