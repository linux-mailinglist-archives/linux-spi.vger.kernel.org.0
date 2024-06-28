Return-Path: <linux-spi+bounces-3660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2F91BEBC
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0B11C214C3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 12:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF715884F;
	Fri, 28 Jun 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV9LUABN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E421586D3;
	Fri, 28 Jun 2024 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578331; cv=none; b=LhXvvwvtPFG4mAZDXyHZIFqM+YDMsasheHQ3VLqSu0IEqZphf7KLsIdevXspyr3WFPrlqgm+B+GGIOEH1a1YlH+ngThA36ag0qm+eOzOtClbDU7uO6/HxgbPgo1HeXq09KfgapDVWPe4z35OecvCa9CL0IA/6j6EK8YvXcdL5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578331; c=relaxed/simple;
	bh=v6Tmwm2SOnpAxDFJbKcNvIWNVRmLAY0tK6sWL8pyKhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLlILYj+KfW5K9bQwVPhVPBjC7vcv+NSUOEAr9K6D+y9oRI3XETFIw/xqaxPLbBphlY1GMqURsjKOVukMXX/8JOETaGRZNUQYH0LqpfbpGamR4R1UHbVNHOh9v+V8MVokjJcak7mJ5ro4HrT5Pb3IxQVVHSTaikrB/gfirwdBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV9LUABN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74767C116B1;
	Fri, 28 Jun 2024 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578330;
	bh=v6Tmwm2SOnpAxDFJbKcNvIWNVRmLAY0tK6sWL8pyKhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iV9LUABNUwxUeCSVH2+KO0en83O3mEy1tn0QNmBWn27DVjzBkNXW1DpPFGdKmYzqf
	 aYM4W4FAWV39OgEks8UlCC1cbkoYDQ4JdRafnQKLnfDKTPwe9IUi6fPc+T5xonWG9e
	 ViPTle9+gqvwtdoLkiYdLUZh1ydWPErX0Crq+XD/1uI6ALC9D/p1MPPJOfXurMLGC7
	 C5nUxoPxer+/h2WvMF7glkcUymgm24tFW4JYDKPnjz0rGlqwX4v5VPcHi52Z7w+1Xc
	 ke2w/mWeQAXME9068ycq8Z3BFRHe1PW5RGtGkjgOkKYVgPzc0a6cKJ0nXaqvbMcfsu
	 iFRy0Gc1gy94A==
Date: Fri, 28 Jun 2024 13:38:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] spi: dt-bindings: fsl-dspi: add dmas and dma-names
 properties
Message-ID: <195094ea-a80e-41f1-acaf-5fc54189f80b@sirena.org.uk>
References: <20240627203308.476437-1-Frank.Li@nxp.com>
 <20240627215338.qrry6zpkusw5nazw@skbuf>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kaMkPeSm3pq+liID"
Content-Disposition: inline
In-Reply-To: <20240627215338.qrry6zpkusw5nazw@skbuf>
X-Cookie: divorce, n:


--kaMkPeSm3pq+liID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 12:53:38AM +0300, Vladimir Oltean wrote:

> and FWIW, I noticed this as well, but didn't want to put yet another
> roadblock in the conversion of a binding which was way overdue.
> I was planning to send a patch as well, once the binding was merged.

If I've seen a report that a new binding introduces errors then I'm very
unlikely to apply it, I'd guess that's true for other maintainers too -
it's probably best to fix reported errors promptly by default.

--kaMkPeSm3pq+liID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+rtUACgkQJNaLcl1U
h9AJTQf+PEHTn93k4qLukGylGhh845NbqrD670qzR5ZpFpnl8m+8qo+eWuybYaP0
UqbUOuZWz4AMYpNzqyXSRZjV4m3FHB5cC4o2jG4foJcdbGhuvEG0JIw1JYPEDUei
73a+GhuspCYVFFBMhpMxUk5nispBSapETUPcZb/1xmiseM1TV6l4VEnaSFQ9Twdu
k6dhWgyg2yIYovFaXjxYpn5eLfR102i3Ua2o1Wp02qgV23jYZ3pGHEUn2CkAdGsP
RC/FI0AzSyPphTxvVCRr6yDpK7nZ96cxeLIoj9333nYt7fFP5FSzaqpVQ87qr1LF
7EMM5uHx9jM00aHrVEmX5oEDw2TBRw==
=Uh4I
-----END PGP SIGNATURE-----

--kaMkPeSm3pq+liID--

