Return-Path: <linux-spi+bounces-7204-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6CA67B0A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 18:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE6717B222
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BCA1E5B8C;
	Tue, 18 Mar 2025 17:35:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7761AB50D;
	Tue, 18 Mar 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319300; cv=none; b=nf1syCx7iZfwh5xtz3ahMBNHIpTxzoeHOAAHa83sMIEZOCcoWsUEDoVoeKB/RwpPr+iGLQgZ0ovfoMvfBSwAwrcC2Y1TuRAGdTbrt/b8qzbO3S5sVcNYaIVhSm9OJSV72ktD9VYtH0Kl8IXcBrrCf8CpsYe1HHPrZumN6Av5GpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319300; c=relaxed/simple;
	bh=4HL82DBf/CBfP1qpJ2X8Ppw31Oz4OHkRuMMG+zQJqos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDvLsGX/IaYze+xqHK7/KmkN5pL746DBuG35zrea2aoIYQTS+0A3gbdyBmWdzsbScDqEYw4hgX37jBeHfIF+OJBJEDG2mKGEMPCNQPHzG8sAStbYKMCZvci1Bt/zRtNx310VeM0z/qMO1sll2M4Wf37n8fq5Vhrx8rrgZrQEmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBF0C4CEDD;
	Tue, 18 Mar 2025 17:34:58 +0000 (UTC)
Date: Tue, 18 Mar 2025 17:34:55 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTbYYNihsxtWHMFK"
Content-Disposition: inline
In-Reply-To: <20250318-furry-piquant-orca-da28c2@leitao>
X-Cookie: Swim at your own risk.


--jTbYYNihsxtWHMFK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 10:02:47AM -0700, Breno Leitao wrote:

> Makes sense. Another question, for platforms like this one that doesn't
> have the device reset methods, what can we do to stop the bleed?

> Basically every message that is sent to the SPI controller will fail,
> which will trigger the device_reet() which is a no-op, but the device
> will continue to be online. Should we disable the device after some
> point?

The SPI controller is only going to be doing something because some
driver for an attached SPI device is trying to do something.  Presumably
whatever driver that is won't be having a good time and can hopefully
figure something out, though given that SPI is simple and not
hotpluggable this isn't really something that comes up a lot in
production so I'd be unsurprised to see things just keep on retrying.
I'd expect to see any substantial error handling in the driver for the
device rather than in the controller.

Obviously there's something wrong with the device description here which
is upsetting the controller driver.

> Regarding this patchset, I understand that patch #1 is not ideal as
> discussed above, what about patch 2 and 3?

If I didn't say anything they're probably fine.

--jTbYYNihsxtWHMFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZrr4ACgkQJNaLcl1U
h9Dw3gf/ddfL8ihoS+7tGpmIsUOLjQCe2qSQzQqvVDjWfZ8KhWzvnntcgF9+5Nt6
3xgb5Fx7VyHot6mCvIm8FUgs7AM/ya89KcZcYBbfp4I/IV/kqS3SW3e6cKQNHyPZ
NRfSr7QyEP/koFVZ4tjymKcgShaZ3crxFf2E0KDO6DW1HBBy8cjg2QQyIOBGJ67S
aXbrUEr5U44yCwzCDGLschywheS3QT76UTiYeqCyYopdqp6fXW1elU9a4XFchsco
1C0/32dWRuaSPnpQZ0q6TbxDtMvkU6RKrfgrEi2mo5ZqkkzSYVi3On/8YV5/ALvU
BOE/kmjwYTG9P/9WDJW+D6vmnvVhdA==
=WkYD
-----END PGP SIGNATURE-----

--jTbYYNihsxtWHMFK--

