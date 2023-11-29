Return-Path: <linux-spi+bounces-101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAC67FE1AD
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEDB282500
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4324C5DF34;
	Wed, 29 Nov 2023 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJGsY37q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434D5DF27
	for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 21:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61002C433C9;
	Wed, 29 Nov 2023 21:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701292757;
	bh=/fnIy3jD+36xv/6RVbKvsPzVZU//UMZaIm+uyGyKuVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJGsY37qWAKZiaCPTj8usxvNJEo9ZjhCkmSFdb3EuOQP8O3tGp/pzkc8CgKfMQexL
	 AzgxmckMb+VGbyGPYDZBGEKN0mGNEM3oRIM+Md8q4qyDVQ9Mp+E9THhxalSeJYPVA/
	 nyMkErvsc5Q81ne41oYTE6NmOXl1MD5mM6aQr3uhd9CPha7TtcXcyys8c0UD0bYSgD
	 MW/pdtMIwTbu3HdmHS7t7nOKdDu3orAeP/eEsZSD4uJ1hRuWUjBMtflrftYnD3PPmP
	 MbnpP1ow5fPamK7cxRxJQX8fD1As2jOCKtYZCSq64maE9juW70AWhPoUFeDboMvp1G
	 a72GRv2mLlyCw==
Date: Wed, 29 Nov 2023 21:19:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: AceLan Kao <acelan.kao@canonical.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Mario Kicherer <dev@kicherer.org>,
	Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
Message-ID: <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
 <20231129064311.272422-2-acelan.kao@canonical.com>
 <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7YWgVhkvHWbLOpD6"
Content-Disposition: inline
In-Reply-To: <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
X-Cookie: Are you a turtle?


--7YWgVhkvHWbLOpD6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2023 at 07:46:02AM +0000, Tudor Ambarus wrote:

> You haven't specified who shall take these patches. Is it fine for you
> if I take just the SPI NOR bits? If you want Mark to queue both:

I can certainly take both.  I guess there's no build time dependency so
we could each take the subsystem specific patch, though there'd be some
bisection drift if that happens?

--7YWgVhkvHWbLOpD6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVnqs4ACgkQJNaLcl1U
h9Bfywf+IhNs9FBX4arNA6V1SfNZlB4veB+gZpxcSWRk0wMv7//dofmoZXk9dEee
9dSuk4BjfDCsrfhbwbDY+3ieYDb2zZtxC3Zr3Rhfq8Y2e2amI5cRhc1x0XiQ60aZ
F9l4e2NteA9xPCZx2+IiE2tZg/guvNe0r1YgNM+iB4/yamLg/guVjCxpvvHPO1Wy
rpvn4WEUdrCEDAV7uk9dEtswP4ikWJAaWikmiZZUkto3f1pxhuU8g27GwJf5O7kI
a+wNykTKWEGa7Y7OS1wp+KhkrGlzz/L4e2oLyI9jT7QKw02+mR5PunZLOB6BcPv4
cljHGqo8YFG8eNl9P7dbAlsK0ZVpRQ==
=nOsL
-----END PGP SIGNATURE-----

--7YWgVhkvHWbLOpD6--

