Return-Path: <linux-spi+bounces-3583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCC917029
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039131F22795
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 18:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3261779BA;
	Tue, 25 Jun 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7SeaQ6h"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B717B437
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340084; cv=none; b=etoWa267eyCX9wizLod3vmt4lYQ2FZ7ZWrA/FdnN1aYxJwlE4gcSJWsAE2nHi8c9N4CcwwgLX7svqE9cuBKAEBpgPMOSm47mja5Z9ybsfSPc1qKRxTPKo9Td4YonmicALdJ+EJdJPR9sI3plGfGjw7lsj6NS63M30GAH5wttUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340084; c=relaxed/simple;
	bh=kCWmRp2ovcsYSisy815zarPRIqJiSMQrowdlboB2pPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc4hTc6A4wXylW2a38PqF11qR0HBMPhz1jDZHy4nj0qiu/9FA0gRhvwKcb3j9KQ2VrjzlSTCeRpE6UPSmN15JyLgWlknfMOyJyOPbV9mxY6lMQOvStm/kMjdpA4w/g0qc+4cYtuxrjbuhJ/ZRQfLKUBeOBfLwm8AYTpFeuTrxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7SeaQ6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049F4C32782;
	Tue, 25 Jun 2024 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719340083;
	bh=kCWmRp2ovcsYSisy815zarPRIqJiSMQrowdlboB2pPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7SeaQ6hri6Rua6K8Nmv4a3NdDISGoMKeh7sNmFXE3u2ZywJ8aiIHj1r5WA/2morg
	 iB+znnYngoCLM6HI4homl9g0aKN9IUf5V9ePmJJNyhmGOKKeK2sUigUNTpKq9D1fdT
	 SWSU7VQ5VL8lz+LK0OHObDWLnEIii6odZZZswtIvcxMQqXt5p53u5toDdBnYnbxUsZ
	 SdkI6twKF1Js7Idw6VkYazotPrW+qXZCJpgiDQDZY2U8KfBTSBChsjJKxvv6agsaRM
	 y5rF3+foKR7gTw4MmNrTc6EnJ8iJzBfT8nGNfdF+K3FKdVrVmSy157or8hwYYIr6rs
	 ltPpxcvk5+0kQ==
Date: Tue, 25 Jun 2024 19:28:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] spi: spi-imx: Switch to
 RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
Message-ID: <89e733ec-77af-4aa8-937b-6883b873837a@sirena.org.uk>
References: <20240625002023.228235-1-festevam@gmail.com>
 <171933915475.1078311.10439532819634651237.b4-ty@kernel.org>
 <CAOMZO5CahzdBb3+J_+voJ0u_k-oS-toFarNL8dxbHqdJJx+1jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="04EonBgU6ULcW0vL"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CahzdBb3+J_+voJ0u_k-oS-toFarNL8dxbHqdJJx+1jQ@mail.gmail.com>
X-Cookie: Results vary by individual.


--04EonBgU6ULcW0vL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 03:22:04PM -0300, Fabio Estevam wrote:
> On Tue, Jun 25, 2024 at 3:12=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > [1/2] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
> >       commit: a93f089ccf823dcb9cf678969e127047762a1473
> > [2/2] spi: spi-fsl-lpspi: Switch to SYSTEM_SLEEP_PM_OPS()
> >       commit: 6765e859fac9acdc1265b6f16ed33f42317ed30e

> Please apply v2 instead of v1.

Please send an incremental fix with whatever is needed, there's other
stuff already based on top of this.

--04EonBgU6ULcW0vL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ7DC8ACgkQJNaLcl1U
h9CgZgf/Y67/KPIoRvSx6/OkbregE19JUTundbxYgRHGoF5THHkXF05mxXH9h+4j
MCUJEUytDbCpYDctj15bhRfHpVxUr4649ACt0aOL+yv6tYlMHYNwJKvfmcIxVrZA
b00iCitxoa4GvGOjnTbVB5Vp40IqN59RLUkdcbfMWMGI/NVBz1Yn9l4mSUwoPRtW
DTnzYyrNPcl5nMmRBK0730fGBxxOqMaBEziy0LwhkdrR/kxD7cJ3Q+hHumDXZl0f
u+Toj3NJmF2rq4sDwTjoZUG8nXd1DsHxRnQNhFtI8lkbOjbyZTg1p3sFiVd6PwJG
sUrTS53OKZOy42qDM4co7e66KM33dg==
=tH1H
-----END PGP SIGNATURE-----

--04EonBgU6ULcW0vL--

