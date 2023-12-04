Return-Path: <linux-spi+bounces-124-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D2803292
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 13:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243A61C20A8F
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4A241E9;
	Mon,  4 Dec 2023 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npdgGGtS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98E241E3;
	Mon,  4 Dec 2023 12:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B42C433CB;
	Mon,  4 Dec 2023 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701692790;
	bh=YovzdwyeTKDZ5DVdLeomgGxw2Pm3ziZCMy1aF6v84XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npdgGGtSJFZhvbFnJGhAj53dUdNSzwrYXE+ZSORe1wf6YizhYF7l/0u02ytnGkfI7
	 dN5si9DwwgjXHwJLdXbX/ugmo+o1kWuQXxs+ZWv68zSRxXAIww8necas1wahyt5un6
	 cVmkhk63h4pkAUpwMq0OHL+vcNEEi975XxxvEbHZU9OIWVEgQJAG+dnqDdEpAVM+mY
	 Tt6UhGh4JC2YVkCZUbBCc0Kh1OSWmpvZmcb1PahqXPZz08KJznL1ZEc3AkqnwnqayJ
	 Y8sw0og1oiPZm0fEixqgJ+vvm030wfWue/C1D9Ah6O/kFYysK4NsTUgusjW1rEC8md
	 VTGf8hK+ZqIeA==
Date: Mon, 4 Dec 2023 12:26:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Ronald Wahl <ronald.wahl@raritan.com>
Cc: David Laight <David.Laight@aculab.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	linux-spi <linux-spi@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	stable <stable@vger.kernel.org>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Message-ID: <79a34e2c-013b-42e8-80e4-52fa3c9e1194@sirena.org.uk>
References: <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
 <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
 <20231129094932.2639ca49@xps-13>
 <723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
 <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
 <20231130211543.2801a55b@xps-13>
 <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
 <4642281ef2e749a3b69bbea5474ecdf1@AcuMS.aculab.com>
 <c7980bbf-04aa-4c52-9c6c-f3a1169e90f9@raritan.com>
 <6f603fdd-12dc-4929-98aa-bee1f533e8e2@raritan.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxdGx1TjhAw5cCTy"
Content-Disposition: inline
In-Reply-To: <6f603fdd-12dc-4929-98aa-bee1f533e8e2@raritan.com>
X-Cookie: For office use only.


--bxdGx1TjhAw5cCTy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 12:54:50PM +0100, Ronald Wahl wrote:

> Revert e0205d6203c2 "spi: atmel: Prevent false timeouts on long transfers"
> and the two new patches that are already added to one or more devel trees
> [1/2] spi: atmel: Do not cancel a transfer upon any signal
>       commit: 595d2639451d3490c545c644ece726a0410ad39b
> [2/2] spi: atmel: Drop unused defines
>       commit: 28d8051efae17b6d83544f3c1cf06f6a71677e91

If you want to submit changes please follow the process in
submitting-patches.rst.

--bxdGx1TjhAw5cCTy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVtxXAACgkQJNaLcl1U
h9ApIQgAg4yln6y42AK2Z8YVL32YRdPxhKnohjQNR60syOC30bBSBgK+3VuHz2fm
6r+JwbvsGSUhGDHNXlARaMP5qT5GKgDlgFx0mEAWnJVwiLDr3sw3gVxmaRyTJDcN
nJeQWbpnwX68aA72M3ajbjM8lbumQ8QZQsbkkAPGFFg/gN+M9xJbxGFqOUaI19ch
zzU78iLhqBWtFM93gEjQZ+dkHQWJ8fWIzO3+jMAo7mHpKrhxLGYQwuGZP+AU8thR
MSTQt6YdxDUssqN0SWBF1nskbrSs5JWETH18qQpbO2VASgNW5bhg1G5ivf9GYXgn
DpmssLh6Cdx7FE8EPARethplVEIJzg==
=XLst
-----END PGP SIGNATURE-----

--bxdGx1TjhAw5cCTy--

