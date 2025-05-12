Return-Path: <linux-spi+bounces-8080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC36AB36C4
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 14:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1925B1884ADC
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D4D267B92;
	Mon, 12 May 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXQUd8a9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DA259CA7;
	Mon, 12 May 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051905; cv=none; b=oa1DErWaUiEkOnVwM4RtdxRpHW8/5Vvb/1D2WnXJCZdOq6Z6sAZDkNIp+By+X8DQrv/sCQF/ACXCdcCAsQknfWucAKna+JSmHfTAk/Qtnjpyf14AT3TbTLvbKxbCX513gk8Mkiv/o4GVOkbvCIja7zErwPMJD8myEvzJlKz0UoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051905; c=relaxed/simple;
	bh=OIzn1mPnTSPLZjpB6j7XRj/AFW6cs5zlnmrS1IKRsKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUKX8rztmUEWi6pjLyv2hntGYqAUnXtyqC52U+zWdBy8F1VtpQYZGl4+66dZv27H1bhGKCXokonWGLsZLWt//vvbLcBSbY27syltP2oS8h+uDxpRWCgXAbeqdrfpp4PApmbk1+G8bQhC+U1ZSPhyAszZ+dP1hpl9VbaddOjOC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXQUd8a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AADC4CEE7;
	Mon, 12 May 2025 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747051904;
	bh=OIzn1mPnTSPLZjpB6j7XRj/AFW6cs5zlnmrS1IKRsKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXQUd8a9pbhwP2kR2m3LdSR8Eo636ZyBTl977P0+jodT/APhlh++OfPy+q40Zr++q
	 A7HeU+/IxQuwBLqbj8uWkmNS5STfJoxMZy6Gt4P5yV9f/+4JSQSj7YAUyMGxyIpmOM
	 z+yb50PYdw1v7QJbwiAOM0urByyiZz0EOFAQLtHwVU9CIxWQTn/DED+7bg3WfY7Bqa
	 Q2usjiip4zWsnUrdnTKmwrOzpGtNcoWNNz9ghRBS8eFXsE9ZPF/YbUUV7UZuRJpx70
	 shZFJ3t/znt3ob3UFGdyu9MHLIBsQww892qr9CHVX/n9sHP2MhFslkJE1iS6cxs3eN
	 sMXp/ydGhdgPA==
Date: Mon, 12 May 2025 21:11:40 +0900
From: Mark Brown <broonie@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Message-ID: <aCHlfED7b-W0pGXY@finisterre.sirena.org.uk>
References: <20250512-b4-upstream_ospi_reset_update-v4-1-982c6f7886ef@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Up6TTTXwV3c9rzJk"
Content-Disposition: inline
In-Reply-To: <20250512-b4-upstream_ospi_reset_update-v4-1-982c6f7886ef@foss.st.com>
X-Cookie: Well begun is half done.


--Up6TTTXwV3c9rzJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 12, 2025 at 09:01:04AM +0200, Patrice Chotard wrote:
> As ospi reset is consumed by both OMM and OSPI drivers, use the reset
> acquire/release mechanism which ensure exclusive reset usage.

This doesn't apply against current code, please check and resend.

--Up6TTTXwV3c9rzJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgh5XsACgkQJNaLcl1U
h9CakQf+Lpn5673L+a+Kd8BDCJp+K0LSEk6Gm4jTSeW4OQokDsRA9bfIlOjLdgzV
ORMqH5XETEjmrOXd9mXLWBQKn0v6qd0oRNx4NS47Guka1G1cWRgZN07vPz6TtS/j
yIPNVBaSJdcbTt+vq8Hi39KyW1v6+Bfltd83BwLFfF6VZSlr1JG5wJ9QLOfYBYx3
eZ+/8Uq9O0ZKBmoLOT32s0VqfoT82snwGrh4GPKJ52cFJ4UT8PQ2ijxB82pQK6Ni
9W2yxwEqiIyRF7V5UT1SLGH3mTkQXxf+ehJY/s8wgdVv4FdxJ/qcTWFkXBmMm4DS
DZoG5cAUB75NzruPspH29ac7txNyXw==
=OXiw
-----END PGP SIGNATURE-----

--Up6TTTXwV3c9rzJk--

