Return-Path: <linux-spi+bounces-7294-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80553A6FAD1
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 13:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0901891E23
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6DF256C79;
	Tue, 25 Mar 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrvZuadI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE12566EE;
	Tue, 25 Mar 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904625; cv=none; b=nkdXvRrDvaAA9c57R9WsMuSzKbzPIspPp5fu11+FqVoquQVvFuwTM+dUy0oTxBT3HSyCUJ6invnkwre7V2IQ+UwUDCQO/8IrYBaeq/DVxnnzEYcGtg4e6F5BO+pddu8uJJ+nBGJQGi/AxaY1Pc9VKjyhZPtyId71lrV93JFgXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904625; c=relaxed/simple;
	bh=577OtHttfNDdYR7kQYikDLa9bCmDa4e0P1wEjJehElo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKgEi3GGk9X9qbK2D/UyO11xdqmi6T7KRDJ7ZB7BJjT1hsHYO5Pvi3iH6rs9IqADZ44cisMprdRC6vARqvQdA4JTrncm4FbXAEdcpasbZAGLqHAX8TufhjIVpANR/np1vQsJNyvrS6SYSCN1J11EgGkJUZ4gvgh5z8VybA+FkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrvZuadI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61318C4CEE4;
	Tue, 25 Mar 2025 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742904624;
	bh=577OtHttfNDdYR7kQYikDLa9bCmDa4e0P1wEjJehElo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrvZuadIe2+4aPpaOAS6IwXC4faCLbVvZDlgSpVj/8LdaXU0l9YyHR88Wu5PDLH18
	 X89FwMlnz2RlbbfS2xrh/X1G1GEJRypX+D8P6POLM2y7lauQucO01MBmUO9Q08Zm02
	 o+FOn6DWHjeoaGqNb/ezr0eTtNFx+Jcrun9aB4t987ea2gwzT56e8owG+RZ0Q2Zz6a
	 EKuWFxyHQjYDqtIEVYs/JCb0KTI11hK3Eaeklxmjqp6fcx7KvukwmJAU9bbRBiLofi
	 xanWGChvu8ZkH5yLXkl2wEEVFYP/VEwORoBMnHZZyE1x4wM+Ssc4XjY7O/wkkO1Mou
	 5hrWsxpOzmVaQ==
Date: Tue, 25 Mar 2025 12:10:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Vishwaroop A <va@nvidia.com>, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LgORjx2xzCbCn3hU"
Content-Disposition: inline
In-Reply-To: <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
X-Cookie: Visit beautiful Vergas, Minnesota.


--LgORjx2xzCbCn3hU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2025 at 10:36:29AM +0000, Jon Hunter wrote:
> On 27/11/2024 17:31, Mark Brown wrote:

> > You can put 'spidev' in as the compatible and get the warning, we don't
> > require specific compatibles if the Linux device ID is good enough.  If
> > you genuinely just have bare wires you're probably able to cope with the
> > warning.  If something is actually connected you should use the
> > compatible for whatever that is, if spidev makes sense for it then
> > that'd be OK to add to spidev.

> We finally got back to this. Looks like just having 'spidev' as the
> compatible does not work. Apparently, it use to work and yes you would get
> the warning, but that no longer seems to be the case. I see a few others
> have been doing similar things and hacking their device-trees in different
> ways [0].

Huh, OK.  I don't recall any deliberate SPI change for that.

> I completely agree that ideally we would have a proper compatible string for
> this because after all device-tree describes the hardware. One use-case that
> we use is external loop back for verifying SPI by simply connecting MOSI to
> the MISO. Would it be acceptable to have a compatible string for external
> loopback connections?

That sounds fine.

--LgORjx2xzCbCn3hU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfinSoACgkQJNaLcl1U
h9AshQf+KwN8vInoOZVe4L+kGzKRjyLwMOBbHyB1kfYXH5JIlQUOQFJWRku/N/UG
tDBORCwZMXcFDJ349OftGFT1cT/eKyHcwNZuGuw0jNoOSeiMHnqkoIWrSh/6P4wd
0RD74H8cb/+jYFl01jd7WIBR/sUGV1vfInkA0RIJqaS7ke8DijsF5KnnVn+R6Oh8
82WqEwf5sNrk9mz4cW4VjibyK63iniaP27Kejt8HLXUUg94unJCdZfw84/6bBV8P
ojsYa9uotV2AqJW+hjuq9rb13l2oGhIkFeBrm8aZk4gYpk8NzFfzzFWiHmOCQNtJ
m5tZt/5YfJAULbaj9956RXHtlQoxGQ==
=gKll
-----END PGP SIGNATURE-----

--LgORjx2xzCbCn3hU--

