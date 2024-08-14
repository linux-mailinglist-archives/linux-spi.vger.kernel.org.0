Return-Path: <linux-spi+bounces-4195-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A53952107
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960FD1C20AFE
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91A1BBBE4;
	Wed, 14 Aug 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgHfFeve"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF41BBBDA;
	Wed, 14 Aug 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656338; cv=none; b=pfR1C9J8tEO76EqqLziV/wNx3BcIU27hdC7YFLTXkb8+ozgV8F0FZ27+MYhPR68yUZBeqS2xNrqJMxClgY7Gtb2vswHYgIhhLV9Jh+k06rRJ/Mx+jaUFJTZYTUG8mKTuex9E7zoxkXarFDHd2c2eNB/x9cWVqGPIY1jypK4TDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656338; c=relaxed/simple;
	bh=OvWqIDYW1TJozwYWmQwgU+NqjY7ZtiSgr60J19zdmjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeWesAesX6sEv0cHZou3qURZq3AizovIYSIhHpYqjEt3n831O+5geW1FPHB8Hsk5jtfPqZ7DA2uxAQpOXbCzGfxjx74ZF5Le6aU9XcOyEvrrtO2eT1VYh8CubaZzEwS0KeX2CqyhBMsPjRTVNOJPaeeBzx9ZV8k0JjbCjmIPqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgHfFeve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A60FC116B1;
	Wed, 14 Aug 2024 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723656337;
	bh=OvWqIDYW1TJozwYWmQwgU+NqjY7ZtiSgr60J19zdmjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgHfFevePbdkzlTIJnyOF2XC0FJkSntKBL4QKqC4eezf+7anNZArL+rupvynOevUi
	 K+NFmCz1hIi4jTeWnHTo1ETcdPicJVlTbeNJAVZ88Z22LC3qwUVxAng7v2/PS9eqbj
	 V86rFgYuHJOrDBpgCC4vaUADKyuQ1UXy92tLqaSMU6PMUxSfu3xM4EjpnpysY0Jaa0
	 inaskwqUc+7f+jrxcVfzMikKpH4PLJa4UuAyHvOVPYOn36xIglEGLNejYxWX4UYdqH
	 qRxBKpZGv8b4w09N+s6yloaq4IrNEqo6I3JN6W9cFAieeK+ocFcUGCYmQBFGhh9sth
	 HNx+my3LnbSTw==
Date: Wed, 14 Aug 2024 18:25:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: theo.lebrun@bootlin.com, d-gole@ti.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix OSPI NOR failures during
 system resume
Message-ID: <bdbbc2c0-265f-43d1-8bc5-03cf6d84c495@sirena.org.uk>
References: <20240814151237.3856184-1-vigneshr@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UTNRJheu+DfhM/pL"
Content-Disposition: inline
In-Reply-To: <20240814151237.3856184-1-vigneshr@ti.com>
X-Cookie: Do not stamp.


--UTNRJheu+DfhM/pL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 08:42:37PM +0530, Vignesh Raghavendra wrote:

> Without this patch, OSPI NOR enumeration (READ_ID) fails during resume
> as context saved during suspend path is inconsistent.
>=20
> Fixes: 6d35eef2f868 ("spi: cadence-qspi: add system-wide suspend and resu=
me callbacks")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

This commit isn't in mainline or my tree...

--UTNRJheu+DfhM/pL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma86I0ACgkQJNaLcl1U
h9Ad7Qf/QmEWLWcXj6njajMV852o3yuSyOwKee2mb1xmvRIbhmNB38oPGveeQyT0
7fzVKq5vkrGpvleinHj+Jl0xtDZgRtRCzevRGa0SheNKdwmuCCDa6EzLFykimXa7
Vtxt10Irlq5JCG2lnTklMrF2uHt4WstFaRxBhPuDSEKGer3k8AeLnhVbAL6nMJCg
kVLOjvV0HtmoqzWxuP5t7+WNHsDWOubVXFjQYkRhQ6ajVLb54vVCpgFysAI5Qs0E
x7lDAdAaEr0JKVCACMmn97Gkd/qSsCNLjoyfR41Yu4ZUZciDfj7l/A/jg8Nz6EsT
r4u/+UcEKwOrHZG06Qtbh40qTHlATA==
=Myvh
-----END PGP SIGNATURE-----

--UTNRJheu+DfhM/pL--

