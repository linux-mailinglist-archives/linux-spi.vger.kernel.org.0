Return-Path: <linux-spi+bounces-3041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 325768CD1A6
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84171F22C0D
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208AD13B5B0;
	Thu, 23 May 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzgpqT2d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3F8208A1;
	Thu, 23 May 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465706; cv=none; b=t/t04YWnvQit/99tK977WtaSxFX4dDKg8pysTsVIPaU/1v9XTMucOUElTSyCPrG15naGMd5xsYbn0dyq/1ZvgJFwzUCmbFE60QbgrbHM/K0uPrQJgioiK3aliTBye/9rCVCLv5FZzwqDjJ/2gy0m7RDrlOM24h0BJ8U56CwyB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465706; c=relaxed/simple;
	bh=YBPjtDb/JXFKq66PcO5AIit/qgta0lNNGHZBGcZ6v3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO/J3yWjKu8Ynby+ezedbM7dUT+5CtuHz9cGZxB8a5mVhGS7VhpFHcLPtfUA0DcRUZLBqecR2lflEOumuqbD+29Dlad2RJWTzAFi2/c2+YfEdGEvSOWSanD+xLEzNsNOfcR7PPXXWwIK0qs3w08gjePdCSCa2TEt/qnBpqqpRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzgpqT2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB2BC2BD10;
	Thu, 23 May 2024 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716465705;
	bh=YBPjtDb/JXFKq66PcO5AIit/qgta0lNNGHZBGcZ6v3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzgpqT2dgX5wU4d+k28+SEDbxk2WNAlF7UYDbzRKg7S+LRpdITZxg79nRa6fYN94r
	 IpeMOf0hHBfJkojfLJI23YMF5LS4jHO8P/KgF94CQoDO8SQWlQLGGViNDTday+k705
	 2N58/Byi1D05LjJObCDJ4jIY5QMZgia3cc3qoKJ8HxTcsDN03nK7PS9VF1WLNbN40f
	 NRbORl1tEVN57r/j1+NQN5UZYnrD5JTImwOTxfZrVTN7ny2/zrRvQqcKrrzKbsbPyo
	 dGCCnH//nMyxIRITHPZAtw8NbCOiK/U1vaFsl3tr36n5S0PsL9SEyy09naHLdHekYI
	 N4BI8AtEJwZzA==
Date: Thu, 23 May 2024 13:01:41 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/2] spi: Check if transfer is mapped before calling
 DMA sync APIs
Message-ID: <424a8c56-bde0-4b49-ae16-a018fa1b4962@sirena.org.uk>
References: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
 <20240522171018.3362521-3-andriy.shevchenko@linux.intel.com>
 <4748499f-789c-45a8-b50a-2dd09f4bac8c@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eovZZzUrEQFpC6/X"
Content-Disposition: inline
In-Reply-To: <4748499f-789c-45a8-b50a-2dd09f4bac8c@notapiano>
X-Cookie: You auto buy now.


--eovZZzUrEQFpC6/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 02:41:48PM -0400, N=EDcolas F. R. A. Prado wrote:

> I tested this series and I still get the oops (attached at the end for
> reference). When I tried this change originally, I added it on top of the
> patches you had supplied. And as it turns out one of them was necessary.
> Specifically, if I add=20
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index f94420858c22..9bc9fd10d538 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1220,6 +1220,11 @@ void spi_unmap_buf(struct spi_controller *ctlr, st=
ruct device *dev,
>         spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);

The other two patches are already queued, could you send this one
incrementally please Andy?

--eovZZzUrEQFpC6/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZPMCQACgkQJNaLcl1U
h9D53wf/fkMqZQCyZodZWehUamrTAkwubsZLOYyTvWNrNebKBT/sFevYj1/p3WuN
sPhPBTb4tPUxSCGGl+uNxTKKztBHwrpmWaHGkvsx8WExRUlB9GT/+8OCqHNdh6Se
CNbYssM21raUwt0VK4yy+qmFPdNvG+mAUp6WbTVz38rvYbP8j5Meeyc9tRtv0x5F
c3lFz6ex980JVDZvSM2RF0ghwLJK0GkSrzwD6JS9/tzl+1Y5pVTMLSYyYpl/rumF
FjhkDx+vfl9Hes5m6p5pu1k1rhfWSnZqZ3zU+cKfc8ghySEkVn5QQV/qgU1Iw6On
7OFfYQSg+zJO8wYeuJXbDpS0hZJ8Nw==
=H/oA
-----END PGP SIGNATURE-----

--eovZZzUrEQFpC6/X--

