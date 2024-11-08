Return-Path: <linux-spi+bounces-5656-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C679C1D75
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2024 13:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3DAB20F04
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2024 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBD01E47DD;
	Fri,  8 Nov 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOgNYNiB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BC1D0F5C
	for <linux-spi@vger.kernel.org>; Fri,  8 Nov 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070749; cv=none; b=eo9abV4FA54f/O81gCqWPt+PVaUWM7VFCBpewW17hHKuzm72+qnDq8w+bQ/cUblT03iUudx4BTCVVlCKHRADqLrfuL/TU7GLztamTJ/hF1q8qgrt3+EpqaZh+5wDr8Zy/PoJ/HHNOT5IIKybHrIGQMLn+tRctVKrbvSttA7wFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070749; c=relaxed/simple;
	bh=6kWrOSprHBdWpMGWOkcTlPWCrFTmXU5zNwwK77wqz1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3JgKjICQtMdqX7dx35WPjx/uzxW39YigxO0KTZL5eM3zI8QNsweH9NlsmGTmex2BAHvCYuZX5BerU/Lz42KIthbghHkgDq5n/BOKlGDgb4KSMPWk33shm4ESlaI3mzQqcqujzwTW/tJbGGROPPpavLInDj0jzuXffgthVcaXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOgNYNiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B67EC4CECD;
	Fri,  8 Nov 2024 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731070749;
	bh=6kWrOSprHBdWpMGWOkcTlPWCrFTmXU5zNwwK77wqz1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOgNYNiBd3cqRb2XUKK4/2xgXjrSk2/EMXQyo8Xc6hea76iVOyQDsFuc2owXAvjey
	 beCaHqPjnce7ltswYhiPqDj5j6/9mmD6bcoTQ8pnqz6Pws+QpbeAt81dtJpNaYIiUH
	 lDzswaMIvWtUqh1t9tnloulT4d8xQm6JdM1LTNsZCW7jSP9eL79s7Kr2xYSm1SG/FE
	 pNIN5NFoeDa+ga5vrhHRzRX1rM8yZfliR1vkHQ1Ty41SN8H+LB/6WvQ5nYdIpUqz7p
	 8Vdp+vDWhSdxFrrTuSg8+AHzneGnAR+Za29QLI/8+UoRk/VOBB9Ebzjd026v1cQvgU
	 ibZChmgf8LYVw==
Date: Fri, 8 Nov 2024 12:59:02 +0000
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
Message-ID: <fa56bccd-b044-4fb1-be9d-dc143978ad3e@sirena.org.uk>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-3-miquel.raynal@bootlin.com>
 <586cf617-37ee-4859-a11b-67654d650380@sirena.org.uk>
 <871pznqqdb.fsf@bootlin.com>
 <f0ea6706-17a2-4500-b426-a53c836c52b8@sirena.org.uk>
 <87ttciayvo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqiNPQ2PFHMUpvNQ"
Content-Disposition: inline
In-Reply-To: <87ttciayvo.fsf@bootlin.com>
X-Cookie: Do not overtax your powers.


--nqiNPQ2PFHMUpvNQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 09:55:07AM +0100, Miquel Raynal wrote:
> On 07/11/2024 at 17:15:03 GMT, Mark Brown <broonie@kernel.org> wrote:

> > Yes, that seems to have been the issue.

> Great, thanks for testing. I'll soon send a v2, but I guess that's too
> late for this merge window.

It should be fine at least for the core bits, the driver bits it might
be better to hold off for the next release but the core changes
shouldn't actually do anything until the drivers start enabling them so
they ought to be relatively safe.  That'd also make merging easier as
there'd be no cross tree issues.

--nqiNPQ2PFHMUpvNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuCxUACgkQJNaLcl1U
h9B4BQf/Y1K5ro5h+ed1EKxy1lpiWJ0TdiTK5iTOY6Kn8SpCmo3uaxRGzHlQkMk6
qNORE5be8GDO1Ovf5fVc1SnSTvD3IFV5lV2vxf96B6vADYo4OSmT9Z/zbwOiRsK2
ppracs+cE5EOiaj9L4nB7dYoN6kW0jxUCDGOWFP7xqQPwiEdsA8xbsGdHCSXRsQO
zURKPBj+BmGtq09S0u/01OKSO1X3aG5442ihzWReJm4CUWa+5j/KMendRv0UiRT2
VbUb7Dk+d0a04WinHleeh+Ik2R+chrrPK37Y5S7EZ/x2CLpF2V4kjJnS0lVWHQGw
I39ThnLWL22J8oNAfLJqRuaT1xaOIA==
=HuAN
-----END PGP SIGNATURE-----

--nqiNPQ2PFHMUpvNQ--

