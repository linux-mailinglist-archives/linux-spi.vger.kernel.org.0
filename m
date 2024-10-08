Return-Path: <linux-spi+bounces-5146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA899456B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC751F2425D
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8E61CCB3E;
	Tue,  8 Oct 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwX6e7Lj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00F1CB308;
	Tue,  8 Oct 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383373; cv=none; b=p+Kla33yRCeau29L8wkcCcrk2DYCf669wsIKM2i9/QfWiQhq0RKMq+dVFoKn4kh4t8SwNRjAk+xpDXmNbU8rCZLiWQkbsJ7UCNCgCK7ksrl2EVNGjqjDfPVeJ7c1YRc8lAJ+rUL7kUEwenlFGN4Vik501IPtZwt2awSn5lum1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383373; c=relaxed/simple;
	bh=r6uqx0gKzPJlQTnJfU80WZi/CjkKIp2ytA8teYg3T4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln0S092mkda2ihgErE3r/+Dw1AYVSxU9rYkMJ4IZQjeYVtdumBAM3Rxj7jhvyRUj0pgJxSzO3mr8z6tQk0IJoab6a2V8ASBGQrKa7eadsAz2ZIOLqf9K38HEB0AXMmxgtaKXNCq2NrrDyt5EdKScCcQTCHl5lcuLrxwchDCTFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwX6e7Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91C1C4CEC7;
	Tue,  8 Oct 2024 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728383372;
	bh=r6uqx0gKzPJlQTnJfU80WZi/CjkKIp2ytA8teYg3T4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwX6e7LjdGFMW4ZkZgiEBpTLMqqIOX+ATRyulL2aZFJDHiTuBoF4o4JvneLbRrW6S
	 ur+UM8QSxwZXgdJeIKD0nTtiN9mXgz+z9if/L38DwR1Y08fjwMhHB/pN6jfRpY/3JR
	 Yj/Wvb20obNLHveykP5AwmtYg2wQ4fhcPjfKwiihnJTr/UqBpm08yO3N4FM3UzVCzh
	 HgRl0j7T9fLWvGST3nJ8bYjhmPHVUYMQj9oHfJ3qpIKT5EcwRCnMvualHgOd3nPGt7
	 sbtzOgnQeP0rHfGBsINPGGh+gSdu6QaTl54XL4ZytkxT7DaPSnndgE598gmf2UCboW
	 xBAqqpGGd/EsA==
Date: Tue, 8 Oct 2024 11:29:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mihai Sain <mihai.sain@microchip.com>, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: atmel-quadspi: Print the controller version and
 used irq
Message-ID: <ZwUJiAj_ZVztLvS5@finisterre.sirena.org.uk>
References: <20241008083226.51163-1-mihai.sain@microchip.com>
 <1c525e43-d71c-4c4a-a8ac-96627cd6ea7e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/tCwxRMHdmQqa9TN"
Content-Disposition: inline
In-Reply-To: <1c525e43-d71c-4c4a-a8ac-96627cd6ea7e@linaro.org>
X-Cookie: Editing is a rewording activity.


--/tCwxRMHdmQqa9TN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 10:34:39AM +0100, Tudor Ambarus wrote:
> On 10/8/24 9:32 AM, Mihai Sain wrote:

> > Add support to print the controller version and used irq
> > similar to other at91 drivers (spi, twi, usart).

> > +	dev_info(&pdev->dev, "AT91 QSPI Controller version %#x (irq %d)\n",
> > +		 atmel_qspi_read(aq, QSPI_VERSION), irq);

> This pollutes the console. Better to add a dev_dbg if you care.
> And irq number doesn't bring too much value as you can see it in dt,
> isn't it?

The objective of bringing the various AT91 drivers into consistency does
seem useful so if this isn't OK for this driver we should probably
update the other drivers as well.  Ensuring that people can get at the
IP version does feel useful, I guess it could also be a sysfs thing?

--/tCwxRMHdmQqa9TN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcFCYUACgkQJNaLcl1U
h9DDOAf/Y8OAs67WdyBhy6znpd9MnCRbd2ynn7x0IFVnQeaOcNPJFreZ5D81G9DO
G2dEOU68qbHH7LCNDDUEcNre1C95gQpAFVWg7zVeLcRR7iXOSgYMjybkQp8A9jEM
w8RucD9+/6SHS/y3mEflYgtRk8QnbA/1Gu0cVhM6606Y8sxXQKmiDEEEIXqoSzp6
Oz9LVdlk1GYyGFflv7eTTvy1CVey8xOOVYQBpjohmXxzYUqhrNNw+ef7tUsHDued
k7jyRfC7ndsYamet7RzQFrMVXvP1TJxcgYcAkv/CDdSB8LUyTpq7+vSc/zEVpbD7
onHIdDe8ZvRplwY2vgOHjYDzW0gc6Q==
=4Gul
-----END PGP SIGNATURE-----

--/tCwxRMHdmQqa9TN--

