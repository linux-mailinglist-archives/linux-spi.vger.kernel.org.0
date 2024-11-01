Return-Path: <linux-spi+bounces-5596-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0F9B994C
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 21:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526E81C20DA5
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 20:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579519D089;
	Fri,  1 Nov 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRRjd1uz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575E14D2A3
	for <linux-spi@vger.kernel.org>; Fri,  1 Nov 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492261; cv=none; b=KyW+oYLeG825KcByrN8VJIvVqPHKSTHoudZf+6UrhbvpODgrJmoKmJuVI+srhgQc5MHCOotP+tPwOTe0joZ23jmUeqzsiYf1sKM960zeq13EyIoyKqbIaErj5PCGzO5Ifh6kB+VbzmdKq3dt640TzpY8843c0qfd8M1//0WzH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492261; c=relaxed/simple;
	bh=DTMvimcaPJL7Uwv0Ncbed8oxLceIdgnzJxEcOPQzz0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCrcIN7LHBbdgjv9WZ88TfihnLKBdVj85i4LM0PyBY63FhoXshRNFa786QNymxujc9S8mheBxwATGjvZh/8RlA7+/h+8BMKMEMA6lukcottDaTTAKB0S6GMwHBUT+vB5Kw6a1EUnS2iDLCWa73rgKQp67YmC3wkR6Z2RWJ3jfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRRjd1uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92945C4CECD;
	Fri,  1 Nov 2024 20:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730492260;
	bh=DTMvimcaPJL7Uwv0Ncbed8oxLceIdgnzJxEcOPQzz0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRRjd1uzGdPH97UxA6QIE+UJHRmfNiWeTTusFWRUe2d5S3AmmxBHBb6co14uEdnlm
	 N154o7MAvQnlrTy6tHLLb8Lfmx317jFmWMasep24lVQNwcuvTTmE8TYgCyjjkfgquW
	 85Yt6kVHu0aNFn0GMU7xVPUu4/MCNqO/WCs5szyO7490cike3H+xUOT3+lims6lg96
	 ltpbmp4+Ub/eGb9lurv6pLiRkwV0tNlEit7F4nmSXJau/JFLLp30SQZTdoOBeT7VtG
	 8rzGcdGWT1Tm60RKy7AwQ6orEpDeT9BNBU+ACxI68m/CCiiGI1alVCsszxMRHeRBos
	 mZFvE26Jn0rTA==
Date: Fri, 1 Nov 2024 20:17:33 +0000
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
Message-ID: <586cf617-37ee-4859-a11b-67654d650380@sirena.org.uk>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-3-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R9v6F9gj3D0509P0"
Content-Disposition: inline
In-Reply-To: <20241025161501.485684-3-miquel.raynal@bootlin.com>
X-Cookie: We read to say that we have read.


--R9v6F9gj3D0509P0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2024 at 06:14:39PM +0200, Miquel Raynal wrote:
> There are spi devices with multiple frequency limitations depending on
> the invoked command. We probably do not want to afford running at the
> lowest supported frequency all the time, so if we want to get the most
> of our hardware, we need to allow per-operation frequency limitations.

After applying this patch (I bisected the series) my Avenger96 board
started failing to probe the SPI NOR flash it has:

[    3.567876] spi-nor spi0.0: probe with driver spi-nor failed with error -95

Full job:

   https://lava.sirena.org.uk/scheduler/job/925156

I didn't spot anything with the code on a recheck but it's late on a
Friday so I've not looked too hard.  My other boards are all fine though
there's limited coverage.

--R9v6F9gj3D0509P0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmclN1wACgkQJNaLcl1U
h9Aqzwf+M4nDW7XRYbgeIzByr8yYSw9oapqWDeYjRlCHLC6wQgZ9h9kWLKw6xZ4V
Hxn/c9mAKJtjFZLynYIKtjtYskph0CgtVHuWDx6UfAbMOiHFjfoXLJISNNBpjzV1
VpZFT4bohJBqMbFvd4ph8Id+XUF6QgiKOIKEp8YPJxCOm7t+dHHNJ69K09acWItg
q+eK2fh53Fi1j/IG0lT5hitbLzM4MJsCGi7an+kdCgRqL11c/LFqTrD0oueGN5m2
EHULNgHt5J/5gBPTILkkTDhN6V1/ykmXI5UIYTkgYfTwpqzbGf1XmUf8wnqHpkl9
phi4fN1+Sq4ya+p6nLrGBC5Ke8GGQA==
=cWfe
-----END PGP SIGNATURE-----

--R9v6F9gj3D0509P0--

