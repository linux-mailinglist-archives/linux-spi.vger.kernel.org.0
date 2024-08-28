Return-Path: <linux-spi+bounces-4389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218CB96331C
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 22:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A21C21E99
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 20:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C991AE026;
	Wed, 28 Aug 2024 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB/UYxms"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CC1AD41A;
	Wed, 28 Aug 2024 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878483; cv=none; b=XhvE/qcTRmKnpYbCerLpKWK/q2fKmdQ0BQoWPJr03ALtdS9/4KAUQGJxwvT702X6v3ikLOmVcjGXktImWKrQc6Y0kCFioaSzV4IS13N3ljaVBWC19OY99f+V+/6JfuztEUqaVbSJsTlt4GUlE63fSlMJiVWu+B4kbKZqc1TTtOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878483; c=relaxed/simple;
	bh=90H0ZkD7bHdb+HSY8uQ5TlwZaWJEBOQLpbJ4Kx52iaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3wEuo038QDiACuZNJyv3MMGvJNgyH7q67f0Cz6emXI9KSr/z9xLIdGI4GDdmWeTNiCD8ieUCD8/DMdwYKP4EEdejOu3XWVtOJkPkXoHi7sZnCUJQepYwaXN2C2+w2X1BxYA2RjbXOHgT4yjBwAZvBJSfMZtyp92Tkd8i+FsKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB/UYxms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CBBC4CEC0;
	Wed, 28 Aug 2024 20:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724878482;
	bh=90H0ZkD7bHdb+HSY8uQ5TlwZaWJEBOQLpbJ4Kx52iaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OB/UYxmsAA1SgyzWVLqBOtgZOLSJ2ii8BN3hjmCRi/hrXoQ7W/yaBXWrsuoIGpu/w
	 1FrB8PrcuPWt+Iv7CR83hZfy6466219XA683zFiwNwW2PSb5lF+BKEJHQVmoGpvbKa
	 /DHCfp2qfqaM/gPPd4DBG7UTYUjTWLp+aKDLmKm4x+kJ3dskygnNFpjJo3zCnXXq12
	 bB7b1wPm3DH0z9MgZVv/YqYZK6OizvpiImA8/Jqx/d5fVkRrt1y27rJCHU3pXnx2ll
	 cbpgz6ijVUDKIrc4sNh0k13PD/e/+9lQtIsq6JF477mBqaCrXHSntHBowLx3B+6XPz
	 P0UT7429/le7w==
Date: Wed, 28 Aug 2024 21:54:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Yang Ruibin <11162571@vivo.com>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers:spi:Insert the missing pci_dev_put()before
 return
Message-ID: <fc9d3f45-818e-4466-be73-e4fac3cfacd5@sirena.org.uk>
References: <20240820111236.550379-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lW4zlkPSvZhMpeJo"
Content-Disposition: inline
In-Reply-To: <20240820111236.550379-1-11162571@vivo.com>
X-Cookie: marriage, n.:


--lW4zlkPSvZhMpeJo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 07:12:35AM -0400, Yang Ruibin wrote:
> Increase the reference count by calling pci_get_slot(), and remember to=
=20
> decrement the reference count by calling pci_dev_put().

I haven't seen exactly how but your patch is corrupted and can't be
applied:

Applying: spi: Insert the missing pci_dev_put() before return
error: corrupt patch at line 18
error: could not build fake ancestor
Patch failed at 0001 spi: Insert the missing pci_dev_put() before return

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--lW4zlkPSvZhMpeJo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPjocACgkQJNaLcl1U
h9BSMgf/cPR5ye6NbRt8XDsDkJDudQTuZZXYLrmc4tYAIAIfTIaDZ61vQbuQWtV5
sKgfHf93Lz1IxMp6SPCZjAK32gPeRag7luBBf4YmlLbhEQzBdURPTczaK1RkbZra
s32DRVKLcE5+nghTlvtc59x+ZtagmNYwVrxucz6aVT068yrh0/vyNm7GH9po6ASL
78jTq2xNDrrOgr51jHun32/s0ZSqbGxR08OMhRF9KipmzmNUPg2RZ/3s2pQDaHpL
N7ok+0EWQTk6gG7W/IVvlEgbNKNz1xzTTp3u+PPpeCKl5bp0l1TpyL4ROCCevwQa
AE4nQAzkhumKEQVOi/zcfJIuovxKqA==
=58Gz
-----END PGP SIGNATURE-----

--lW4zlkPSvZhMpeJo--

