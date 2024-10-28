Return-Path: <linux-spi+bounces-5527-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5709B3C7F
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2024 22:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEB4B21A92
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2024 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C21E04AC;
	Mon, 28 Oct 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqUpI8Qt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885318FC75
	for <linux-spi@vger.kernel.org>; Mon, 28 Oct 2024 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149817; cv=none; b=ZWu/I6QT9dOukKQnYbAHBwggK4ithrah77XV7HAMNUNIlzz/3D/iMtL21dtnv7KEOQHg2fOQNM+zyENQXmis6JuZBQxoE+nYUtKm29ql5QCHwhTv3DLa0bj5wx+qqKP9lJpvPAue8Q3thXXCKAd32EKpUaw45ajETRE/aMY9Ttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149817; c=relaxed/simple;
	bh=TenOVswCi2FxBf8paViD4gSc4Q9nfnp+Lxzukvx5Ggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5Lja4fqFWQkirRqODqV9yeDQijGR5vQ2cTtG29V3cDLMWWj9n21A2GHkv1I+Eomh3aLTPjnatwpNX88xI/qUpqXaBW7CPJDpC0Xrq7buDHoHbQ6B+kt2n3yxUX464uFO+6GjYS3ZfuJ22ljdCXv99Hhs1Xw+pkwtmtouHuUVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqUpI8Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6580C4CEC3;
	Mon, 28 Oct 2024 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730149816;
	bh=TenOVswCi2FxBf8paViD4gSc4Q9nfnp+Lxzukvx5Ggw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqUpI8Qt6dNFEsk8pUrus/16RKinKgX8UenlTxoGniCL+sPc8e4N2L6N7gnV0mYtB
	 WQAf/sa8+35/QyS3FPoFzIrhg4aMToWUYdShwyxU9fITfvoSsFyZv+WzEBv0SJu9Vx
	 0foLaYTM1fsXJyL0JhD8IzNW0TAnRhf5kBVtvyKGYmO1TRChsOdC7Kwap4VO2CkQRv
	 Tj1YRyEuyp9UWhvdJGZVim+rmPNlhru91IyahluHfcK5Kr/kTmmVvZ/S3Xg4VOezlt
	 d8/A8PUyU8rNTQGqk36SaFfwRuWlufY6bzO/L/kkVspPLdrDHAQr2y4+WGiyRb623F
	 f01CsxLYBLbpA==
Date: Mon, 28 Oct 2024 21:10:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org, Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 02/24] spi: spi-mem: Add a new controller capability
Message-ID: <ddad474f-826f-40e4-ba7f-410a088813b6@sirena.org.uk>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-3-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rVIVdUbm9/vkM7Q"
Content-Disposition: inline
In-Reply-To: <20241025161501.485684-3-miquel.raynal@bootlin.com>
X-Cookie: Remember the... the... uhh.....


--3rVIVdUbm9/vkM7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2024 at 06:14:39PM +0200, Miquel Raynal wrote:
> There are spi devices with multiple frequency limitations depending on
> the invoked command. We probably do not want to afford running at the
> lowest supported frequency all the time, so if we want to get the most
> of our hardware, we need to allow per-operation frequency limitations.

This all makes sense to me.  I'll leave it a little bit to see if anyone
(especially people working with the individual devices) has any thoughts
and assuming no issues apply the SPI bits on a branch.  Does that sound
sensible?

--3rVIVdUbm9/vkM7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcf/bEACgkQJNaLcl1U
h9BjVwf/XF7IMIoYSYn6DyESYxB0+bQLaPzmZ5+0vRkDO0pKcu6VsAbWB3vPfM6c
SP1r9lk+hMsUleHIwVSmIUlnfti75RN9I9u/jB/wkGHxhQncExs/H2NvVe/qsoc6
QV73NmGJkk9xeTYPxW4i/m9sGOQAwWhj3DvRMZc4y5gFj3OJxVERC/u3VZfHwPJD
h/msp9wd2D7hDvbq2c6xdlMXaHx3cvtL0kRomSmGge7HiS52d2h4YB2mQjCm2ioc
4zrQLL5XWjmb4EBNvT9HvRCQ6htwC/4m0T22j2bV6YLScTMKizZB1rTb55skxQTT
VOlL2ZsbU3KLKMbBDACU0kefGf/cuA==
=LbX2
-----END PGP SIGNATURE-----

--3rVIVdUbm9/vkM7Q--

