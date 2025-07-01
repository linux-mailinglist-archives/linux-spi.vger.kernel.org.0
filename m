Return-Path: <linux-spi+bounces-8939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFCAEFA14
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 15:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C07F4A508D
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60673274FD0;
	Tue,  1 Jul 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh/etKiZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA1274656;
	Tue,  1 Jul 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375925; cv=none; b=f/qhV8bwBJS04taImGR+3POZqqUoiTat1mk27BLVd8gGaxSJNHswYqUjd/+8cMYBM8KETBV8wvi5GtyJU4KG0pLBJmSoomO3ZZBJbpCrnlGYUepxW4NInCSHHnDieBHCkfvG8U+JJKm4ZG+20hIh9EzKlpYKdN3d0VdXnX74Ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375925; c=relaxed/simple;
	bh=MNRcLx9dPkOwHU/DyKD9CNfHOWEu94pri17zYcEs0To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3LfaFJbtz5pr/RTLV8XibUr/5u3tJbofP0yU04NpEUatZAWosoZa1+Z5huqNS4ya0IGKZofB4me4paOjQe2QWNG2LjYJFQVsx5mlKVFKXB+VZmm1q4A/+xD6MD+2pJI9dD4ENyZCuTR5UGDF1rWLDWn5ldv8hMZoFf/N1BRSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh/etKiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB60DC4CEEB;
	Tue,  1 Jul 2025 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751375924;
	bh=MNRcLx9dPkOwHU/DyKD9CNfHOWEu94pri17zYcEs0To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lh/etKiZ2PvxLyivU3TdbcfjK5Em8+nLUS1dhYxArA4ue+N26/C5abQI6acgB3wtJ
	 dV09rUiHF84IiLKIm6y8xakyQWtMnWyJU62u9oGkVCw3Z/YRbAKQ9jwsU9JgoMnwRU
	 5wbHkKrFXqAUJiomYQ4wETYUUDru91m5hPR85rkDKBWHQ6Y9KTdhrq+fPeeUWOUZeU
	 999SarmvD6jIWBXdjtH7BYKBOS1QmdP9V4snrvnJTCe8LVZWOQx1jsP2V3Y5azYLv+
	 BAdMHW4Y7H+wVMXOveqlGKhVHg7xE+QvLYBhKye84Si4jSKBRBqDsTfYG8G7AtIrer
	 /I6OLQEin1/PQ==
Date: Tue, 1 Jul 2025 14:18:39 +0100
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <2775ece5-f4ce-42d0-9bf4-689df6527fc2@sirena.org.uk>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250630152612.npdobwbcezl5nlym@skbuf>
 <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7GoGJbkQXHjf/B6b"
Content-Disposition: inline
In-Reply-To: <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
X-Cookie: No shirt, no shoes, no service.


--7GoGJbkQXHjf/B6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2025 at 01:42:46PM +0100, James Clark wrote:
> On 30/06/2025 4:26 pm, Vladimir Oltean wrote:
> > On Fri, Jun 27, 2025 at 11:21:36AM +0100, James Clark wrote:

> > So after your patch set, DMA mode on LS1028A becomes more performant and
> > should replace XSPI. This is an outstanding result. That can be done as
> > follow-up work.

> I wonder if latency could be higher despite increased throughput? It
> probably wouldn't be a big enough increase that anyone would care. And based
> on the structure of the driver if throughput is higher the latency might
> even be lower.

Some CAN users are likely to care, some of them care a lot about
throughput so will be happy but AIUI some are very focused on round trip
times.  That's a fairly specialist use case though.

--7GoGJbkQXHjf/B6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhj4C8ACgkQJNaLcl1U
h9BAegf+NAwxDF/N676ItCGXyK/wk77abxCmNKAn9H94d+iWAnx2NZd2O4e8l9Yx
tB9Th3vuGRIW6i1EOorXdmMRQ6IFpaSLtBLQArcXPM8QWcAY3XbFFe0OF9FhaU6I
kKtS/WO1lRKGlBILCgDMaZdE11dMe6BNzD9a5wKpEzzDYIJ2KX0FW4zLXOu9mOYU
JVfdbkJvbDKjII9tKZ+YM+m0RBFdmaXbkSryEOnvj2vPTDI9lBXtX541QfjqCuU8
hInRnEgVloVCaoqHVEMlRmkIZ64NJ+KABxPZvEULGFCuod3PMFp7PAmkakMyOEAV
ic88w0WlNm0nI7Cej4zPZ2bOFUsxKQ==
=jedY
-----END PGP SIGNATURE-----

--7GoGJbkQXHjf/B6b--

