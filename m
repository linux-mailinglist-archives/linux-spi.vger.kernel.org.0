Return-Path: <linux-spi+bounces-10740-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D3BF2EB3
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 20:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38DE14EAE11
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF2C331A72;
	Mon, 20 Oct 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWuJm3dM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F92C027F;
	Mon, 20 Oct 2025 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984792; cv=none; b=P8r3UJfu4gJYF+lRI8J+BQDLxjL38DSykdWWTXu3SAQNSxQAGo0g+R885iey6hYuXFWOc2Mjs2Iw1jFCHDAJny5nUXJNNFWrPGcniPAf/2cvSWzzkUz9FYDszdOCyVx6sQbPygnRaR5N+I1Hi6SO8XmYCRJilGbdHdilfomqtsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984792; c=relaxed/simple;
	bh=UhEuqXmpACp9+BKJqoedP1MDXtc1UXLJvMj+JY5pTyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQnMyLAPN9ns/FurwoUCg8fhEc4GpuvLaMZfJqJA+hpSMRg175TKVKATJwwNuWpI7hmGg9GUUYupfvHqYxZhrFGmcfMSxYxB0msVFpQyiU4fc41vh4dLxT/mC8qOfC6Ub4l7DrRvg/G0FznG+jOK4YwRGEjU7cDXWnx3QxjYUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWuJm3dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79D7C113D0;
	Mon, 20 Oct 2025 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760984791;
	bh=UhEuqXmpACp9+BKJqoedP1MDXtc1UXLJvMj+JY5pTyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWuJm3dMrAYII/skw3p/IlUTy7oPL9I0uiKPAhPQ2VzN0siguzaAr74GidlJjPVy+
	 Kyvu1GcQE+6dBcjjzPwT7S39Votqvpj0GgU9FmrtWZBLxvvS6KOg4JoxgsECu9bizU
	 HatC7VsRRuoQYspXdNEPNLSQI5eSzox/LRoPsQmXTWxkvbDJ0vtea7tkt5NNfLZlxl
	 uy1kOeee6cGXzEgBtD5CNjg1fNJ5S03kXkWO2TPbVFr//TGv0khXQFqWtu25O490PY
	 a+sPDmO7WXmP0eOVDO3bNEBzRsXyvWFdoiV6LLIXxhNgZcGC5Iixpp8T7jFXLObhhh
	 gbbbDBw82yoFA==
Date: Mon, 20 Oct 2025 19:26:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Conor Dooley <conor@kernel.org>, han.xu@nxp.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Message-ID: <710c36f2-3551-4738-a965-f1564416348c@sirena.org.uk>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-3-elder@riscstar.com>
 <20251020-blinked-primary-2b69cf37e9fe@spud>
 <b28d71c4-d632-4ee5-8c4b-270649fca882@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1I0XRDn4R0XgPcRQ"
Content-Disposition: inline
In-Reply-To: <b28d71c4-d632-4ee5-8c4b-270649fca882@riscstar.com>
X-Cookie: I doubt, therefore I might be.


--1I0XRDn4R0XgPcRQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 01:06:46PM -0500, Alex Elder wrote:
> On 10/20/25 12:39 PM, Conor Dooley wrote:

> > > +          - spacemit,k1-qspi

> > Are the newly added resets mandatory for the spacemit platform?

> This is interesting.  I never even tried it without specifying them.

> I just tried it, and at least on my system QSPI functioned without
> defining these resets.  I will ask SpacemiT about this.  If they are
> not needed I will omit the first patch (which added optional resets),
> and won't use them.

It might be safer to describe them, otherwise things are vulnerable to
issues like the bootloader not leaving things in a predictable state.

--1I0XRDn4R0XgPcRQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj2fsgACgkQJNaLcl1U
h9CK3wf9GM9lu076QzbbHfDafjhtsrnlltUssWfJoUgfejWm+v92kvQuJeSJHBDk
/JMRLFe5T3zA0orRcegrs3BleAWhIhn9HqanLLCg9l/4nVqimJD/UbDj8zyKrPxD
9uHpITAxRzkVNEO7LevpxKk0uXnBNweZ2uTjl+ZFJbR6ECOu1b6/4xifiJPX2MM6
QO4iDWxZKpfPO4YixpI8kbR3f0+Lf9MtkXciYEyT1gY41jUPzQWyprpp46RISYl1
UN0q3/gbogtU5ks2C9siT9SNZxTD/WQCMl9+nm6MkE579TyhPYAz9822qo8/cys1
H3EixL1NAJ5gK51lVXMyOwLDwPzbWA==
=j9iT
-----END PGP SIGNATURE-----

--1I0XRDn4R0XgPcRQ--

