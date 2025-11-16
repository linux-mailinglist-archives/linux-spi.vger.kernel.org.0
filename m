Return-Path: <linux-spi+bounces-11246-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850BC61DC3
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 22:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 25C3728A54
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E1E262FD0;
	Sun, 16 Nov 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf2oeuyl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A25274B39;
	Sun, 16 Nov 2025 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763329510; cv=none; b=Wl7FKHrrr3vOLHKTmLSu6OW7LcCUoC4Vu8xiMxO/yLYkiXeYCxImyiicSNfB8dSmlOX+9LIBmapw01KmQ2S7dgMhX4GgyNtbipnOnvmAGZWCFPhYrQSzLFwBXcLbZBqHQLjbQ5gwU7b9lZybgAN6MakuZWoT/dZtGmKMSUf6/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763329510; c=relaxed/simple;
	bh=OFcKRCVjubrxzsJleuthq3OzYLRHIbcDrAF37egFXTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XissR7C/Bu80mACohmChYX8WPes8dfurqV6hyaeldsdhEu8aJ8id3kjhfqGZtxhjLTZlQd6Ld/4TOAez0ox2HZher5ne76DPhVkYQz5tQo47zlIZENoOikPj+53yWfzszBVLVWKIEMtjB+v1Hw2KX1b2zXnzHYdZCygvxUUgikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf2oeuyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6410DC116D0;
	Sun, 16 Nov 2025 21:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763329505;
	bh=OFcKRCVjubrxzsJleuthq3OzYLRHIbcDrAF37egFXTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jf2oeuylhF7xDEtEkCnG3eX2TR4cafRNZCBiEJegX44Zz68WV45R/3jDRQ/CeCwTs
	 J0PrHZoIapLPYpwIseg12m5MpyR60L8UT6paWP6zi0wVfXohPnVTqCPVvGP6jk2pb5
	 H5sAYtqu4qRtVypeuv40mIEl4a3DWkTVXgqHExfuainH4+0lVm8SAh7IuBdELCjkcS
	 xrt1nXRwXNg1Nz1ORknq88gKVRvJCBOeO+EzgDjNzCnZvzmeX/lCy4tN6YcvM8Ar6o
	 OSplpV89BcsviGz8zmGJBP9d9KqOi4CUNDc7zx0JM5VRw/iF3yeuw19p6i9iNRzLJu
	 lrYDlz2svjaIw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 2937D1ACCC98; Sun, 16 Nov 2025 21:45:02 +0000 (GMT)
Date: Sun, 16 Nov 2025 21:45:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Hang Zhou <929513338@qq.com>
Cc: jonas.gorski@gmail.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: bcm63xx: fix premature CS deassertion on RX-only
 transactions
Message-ID: <aRpF3jRTs23YrPgC@sirena.co.uk>
References: <tencent_7AC88FCB3076489A4A7E6C2163DF1ACF8D06@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NAmoIJdmrm/O9qw9"
Content-Disposition: inline
In-Reply-To: <tencent_7AC88FCB3076489A4A7E6C2163DF1ACF8D06@qq.com>
X-Cookie: marriage, n.:


--NAmoIJdmrm/O9qw9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2025 at 01:08:35AM +1100, Hang Zhou wrote:

> Fix this by writing 0xff dummy bytes into the TX FIFO for RX-only
> segments so that the number of bytes written to the FIFO matches the
> total message length seen by the controller.

Why 0xff?  The core's _MUST_TX handling writes 0x00 which feels a bit
more natural.  Given that this is PIO rather than DMA the memset_toio()
is going to be better than using the core (which is more for DMA).

--NAmoIJdmrm/O9qw9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkaRdoACgkQJNaLcl1U
h9Bbmwf/QkvNS2zKL1I1vPg7PN4GS7OKvQ0CSxyK2LpnAe+YDzWu7a/H5jKBipcS
SyMJ+C87vg8qWSJuDwMmNmt65W3nT2AaUIyxGV8lpFRDiB+gx144F5rwWTWDFclv
O6kZXuMw2CNHrW/z1vXVyAUoan0OpoAcGyyg/9lFLViCBkSVJj3oke4eBaUrYHKU
3rhSwhoz9zY3dS4Kwz5iNrzKcrGV3b4VFWWzHywj6hNYxCYg+ylK4QkNKNrOtTDd
Td3qOjy+/Oz/mujjv2JoXX1cmHZkCu7ATEUEkxChAEyh5lHzCNkBUA2KyS3ZlSBP
wek9eNeZCuZFdKTjikDe+XQZkSGtKw==
=RcUq
-----END PGP SIGNATURE-----

--NAmoIJdmrm/O9qw9--

