Return-Path: <linux-spi+bounces-8481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0044AD7456
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801A73A26CD
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B005F248898;
	Thu, 12 Jun 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7mwEHWZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B42AD0F;
	Thu, 12 Jun 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739425; cv=none; b=GbsK4wM6uKbgNjGuq7V1LeH65B/HjlArpnr9m6r8N7+6vXjIbmSOzFhfoGbnMocxgR3bvqbIxi3BKwhCWlaYj6kgDmN8mJAgjBX72BHXRBI5CSNL9PMIBtKsF87BAru8wps1RGMwXwg4Ep1nJLWRldvPqTYbSKJ8GNC/qowEa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739425; c=relaxed/simple;
	bh=ZtzCGUcKO7ofBqSqQbqhgmhHnwrE9O52kbQHbCP1jvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmc0VKw7MD9F1U2Bh5n8lDet8+EPjdUoc4c1vlJhQwVUOtaeSBQ6+Je3qAbsHyLcwNWukkIJ5m+mA1IXlFQAOYikcgULH8G5DTfKpaWT35GvOOwVccrwZP22MJfosqJ95mZOFQTm6SaBzlcWZdsJRXQnDdXERCw/DPqoxYuurfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7mwEHWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3466C4CEEB;
	Thu, 12 Jun 2025 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749739425;
	bh=ZtzCGUcKO7ofBqSqQbqhgmhHnwrE9O52kbQHbCP1jvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7mwEHWZE8eyAr/H7ASaQEH5kbg5CK4c5wa8FcQhJEuTfFavJvCCrTnJQLmRFaOIl
	 bq32IBWLg2tyz7BNkZ0lMU2s/LtlFSk5DkY5/+/uFG1rNUGVBlN0Omc9akqbbTXpkf
	 9fPBuD3xZ0LleJwftXrwcpGXepJjlBnrbxAMNVmcVEkVToAAfuLzJuG3mDatAvqPeP
	 LrRuuE+bqlaB7FY1/uZcI+uxqGPVy6tYwh8yBqdsHwm2Z2hJw4w/GQhlWHLIU6o5fx
	 XhzkJzPrNie13dSsZVDfBSMSzcDnf38X0GgRZEFoZvnG8+n2k15frp4K2o8RGXBU9C
	 EYq5dl9+7jGDQ==
Date: Thu, 12 Jun 2025 15:43:40 +0100
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <56b158fa-5fd6-4582-8ca1-296863d6d2a8@sirena.org.uk>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ceHDVB9mwfIGPj3Z"
Content-Disposition: inline
In-Reply-To: <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
X-Cookie: Biz is better.


--ceHDVB9mwfIGPj3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
> On 12/06/2025 12:15 pm, Vladimir Oltean wrote:

> > FWIW, the XSPI FIFO performance should be higher.

> This leads me to realise a mistake in my original figures. My head was stuck
> in target mode where we use DMA so I forgot to force DMA in host mode to run
> the performance tests. The previous figures were all XSPI mode and the small
> difference in performance could have been just down to the layout of the
> code changing?

> Changing it to DMA mode gives figures that make much more sense:

If not having DMA mode is making this much of a difference shouldn't the
driver just do that?  I'm not seeing runtime configuration in the driver
so I guess this is local hacking...

> So for small transfers XSPI is slightly better but for large ones DMA is
> much better, with non-coherent memory giving another 800kbps gain. Perhaps
> we could find the midpoint and then auto select the mode depending on the
> size, but maybe there is latency to consider too which could be important.

This is a fairly normal pattern, it's a big part of why the can_dma()
callback is per transfer - so you can do a copybreak and use PIO for
smaller transfers where the overhead of setting up DMA is often more
than the overhead of just doing PIO.

--ceHDVB9mwfIGPj3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhK55wACgkQJNaLcl1U
h9CMBgf/VJO9WjuPi0aBZxJZhyQyaQaSdXSBjBrvaoAlnxIReJYlUc8M2WFC3axk
l4k66fEvfcbGMqRyMOQKZznP/fnZs4Yr2R2k+48rdXtzAfIvQhHktFn2Pnw9t0lY
gfmizPsqtzAQLwDurtA4cYdTjlWBSv+BUnmTdq+emLeet2TIFLwc5NXRZLXD/2pj
frdxxtcyV5KyHXAeSG70PO4BrmnNaZ2zoNO57yCHTErzY/IrnbF+pjO7sQriO2SD
wzagPaFIACR1bA9V5ofFVKvg4S6o13x6xhvO9TMSWGjRVEK4XcHA+Da5Elvg+mLC
/EJ/xklLC1s3YpDlY+upoPDENWPmQw==
=tGE1
-----END PGP SIGNATURE-----

--ceHDVB9mwfIGPj3Z--

