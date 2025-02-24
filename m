Return-Path: <linux-spi+bounces-6896-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B6A42331
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 15:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F897AA019
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26018A6BD;
	Mon, 24 Feb 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/ibNImO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5E18A6AD;
	Mon, 24 Feb 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407461; cv=none; b=j7x5xkp3XC2Y8/l2ptFA9JwWSsh1aVqUl3yikynoNs7VbWGXccWbFWCYTvnByCFcLUXX9qEt1teS4YvHl3N2X1uZ9pCKbi0jlFsBmCe5VUvOOte6/DDq4mDY8bTazfHOvt949OrHOYm9TUHpvwonyaJHl3QGNYdHV9NUXudmJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407461; c=relaxed/simple;
	bh=I3P2jx0QsippUmVmm7L8IZBjxP5VjYTHjdhTlWaW9Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuynxJnHJdd6UoJAIG/DEyDGJVQbVDso8YEA8zrQQN7lXlNML0Emy0XXfoQXhaBPDgbCtfb+LhkOytbatQuYM2CBW+ljSJo+OF8KQ0whwHgvig38sHI4P9l1hjRwyZWTlAxqavix5zVBSxgrprjqzU48AJb/F/7rn4J2c4cJL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/ibNImO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E0CC4CED6;
	Mon, 24 Feb 2025 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740407460;
	bh=I3P2jx0QsippUmVmm7L8IZBjxP5VjYTHjdhTlWaW9Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/ibNImOh5PSSLOokVXE0TcwmYgSgdkk/TwIb56jmE4/lE42TFDxhcIOOlbtDlfoy
	 XoecltAvevoKJCWNKyhhobAw+/B6i8wOlk8x7nwIyTNWrpI+t4Vnfk9mig06iMsJG3
	 EwJauDgIw2vtOlHD1W+MNiJm9iMx+SbSQl1EkAz9hljpa+HPrtl0nXeHSl/Iqv6O1a
	 p29tmVYAH/eYMmDXIPrkKPwsb+b9fv5V3PmEeslEXhy5uXa6171t8yVDUHthSMr1mG
	 49LgjUtxy0dGnS1mtBtXDXXa3m/XYl43t+/EOipU70DUqLnzvRyPRnLF+VMZz7XZJY
	 gwNMvmyNM++Wg==
Date: Mon, 24 Feb 2025 14:30:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: unglinuxdriver@microchip.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 for-next] spi: mchp-pci1xxxx: Updated memcpy
 implementation for x64 and bcm2711 processors
Message-ID: <188ffb7d-47e2-45fd-80b1-b31ca58f0c0b@sirena.org.uk>
References: <20250224125153.13728-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MlLoVElE3MSUpvYy"
Content-Disposition: inline
In-Reply-To: <20250224125153.13728-1-rengarajan.s@microchip.com>
X-Cookie: Phone call for chucky-pooh.


--MlLoVElE3MSUpvYy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2025 at 06:21:53PM +0530, Rengarajan S wrote:
> In Raspberry-pi CM4 devices with BCM2711 processor, the documentation
> points to a limitation with 64-bit accesses. Using memcpy_fromio and
> memcpy_toio for each 64-bit SPI read/write causes the first 4 bytes to be
> repeated. To address the limitation, each read/write is limited to 4
> bytes in case of BCM2711 processors.

This feels like something we ought to be able to figure out from the PCI
subsystem rather than requiring us to enumerate specific SoCs, or at
least have PCI drivers be able to enumerate the system PCI quirk from
the PCI core.  What's the story with making this a per driver per SoC
thing - is there some reason it won't come up elsewhere?

--MlLoVElE3MSUpvYy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8gp8ACgkQJNaLcl1U
h9AOAQf8D+mdh410SkwvAJh4jYE+cRoC+y24fSxtgCAugnVBJ9rTnWZ5xAPWU91v
xqkyF3+a9L0BO60nuXO3TmU5Jt3JBIpF9K5W8oRqF92g++dLthRDfu3/MlH/lGLW
iJIH4w476T0Ay5FU98J5jwFRYzkyG+MiQXfFpnykiprAzEQ3ejAJZnZhx1F6kWSr
tb0CBZcVGxCoyB0ratJtVXzABdrIFtsco4/s+B4M5GVm3mTjSEH1UjeZ10poZCxw
RIfUMEmn/XQy2IrOLOKw+LZQ0Q2AXYf5akdYup2nDKRg+6n6PFnHae3wtgte7Bhc
k8CJ3wO83JDeJuWq5/8UEHwttxn+Gw==
=8P/F
-----END PGP SIGNATURE-----

--MlLoVElE3MSUpvYy--

