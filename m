Return-Path: <linux-spi+bounces-9510-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF0B2AC99
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 17:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5A9188C269
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FDE253F03;
	Mon, 18 Aug 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C09LzqeP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7621ABDB;
	Mon, 18 Aug 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530320; cv=none; b=BX2KEVHIDnzF/eF+W5HSEBcynsli/ZOg4K3SIFRIOJAdHUEBaLG/m3+CCB5DoVredQzpSaprGKyb0X3sPK3oT4UVX4rCUMhhDMjhJFuCGo76rrQkNr8nnmodncPWRJWPwkXTOlL5bmyeLNVEBR2lA/SwDjPYiwScT77ixu9XBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530320; c=relaxed/simple;
	bh=QJEtlbsljO1cRUNNutDsrpeVJivV7FXwntkgcCfCtGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd5mJ4JaCyp1n5PdQfYMZIsMkpghU7uH3sgtalN3pkKqhJeMPGOcHpYUfWHtpW0yQSdCHupXOjXqusws95f4GS9tZJTKWikuOFzWv4H7GuXjFYucfUXez2V+9b/6XxUy9YkZ2ggmV1+kY+g8B3PPOqdqvNTED5eeSB2KdLSny2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C09LzqeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8502AC4CEEB;
	Mon, 18 Aug 2025 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755530318;
	bh=QJEtlbsljO1cRUNNutDsrpeVJivV7FXwntkgcCfCtGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C09LzqePS/Fb4k7SJVgOSBBo16oUsAoNCKzD8whALVN9ZBzBpjvs2ITTo5NVOslqR
	 v3R8FsdAC5xLJN9GbCuogFhwQ+AO7T+/0TeqJKUERl5OsRf8wMf8C25iyhKF3ruaUT
	 9HIKOY+0y/3zHTFTeDJqOlC+8Y3tb76SUo2XYtr9NdnRPI+YTWWOTkW881m8f/lxIg
	 Jrm8KX2kXPasz7JzZ8SsWnE6winjRokSnB0cet9kX8hVVvZynJ8jqdFMvioIgRZPpy
	 aij2awFL1rCpfnaYKgBC0ejmBWJmBhTSS44S0TXkD1bBfUUNbsLTIlK2OJIOjTaFYm
	 /e6lVfi0nFCPg==
Date: Mon, 18 Aug 2025 16:18:31 +0100
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Frank Li <Frank.li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for S32G
Message-ID: <35f6a3be-d924-403d-b60b-d4c78d833a60@sirena.org.uk>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-10-9586d7815d14@linaro.org>
 <aJ4qNVIp788gc2ZU@lizhi-Precision-Tower-5810>
 <1f3b68d4-e0cc-4952-a695-322ed9756b95@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5H3ikhGOIq/UysY2"
Content-Disposition: inline
In-Reply-To: <1f3b68d4-e0cc-4952-a695-322ed9756b95@linaro.org>
X-Cookie: No guts, no glory.


--5H3ikhGOIq/UysY2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2025 at 03:31:08PM +0100, James Clark wrote:
> On 14/08/2025 7:25 pm, Frank Li wrote:

> > binding doc should first patch. Create new patch serial for add S32G
> > support only.

> I'm not sure putting the binding doc commit first would be right? That would
> imply it was a valid binding before it really was because the code change
> hasn't been made yet. Practically both are required so it doesn't really
> matter which way around they are.

It's the general practice everyone has adopted (though in this case the
bugfix bits might want to go before the bindings, possibly it's also a
bit unusual to do that).  An unused binding is more acceptable than an
undocumented one.

--5H3ikhGOIq/UysY2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmijREcACgkQJNaLcl1U
h9ADAwf9EA9tjGoRA6LQDgfOw247uZwjo291ecBkDaxkVbX3dq953UASin7Wjo/3
HePo5osEfES6M+Bt4fRqamFLriHmv/Z8FoWffHS9q4Pa9RcimZmbxS8kV5IjQBAh
8uBngTX1ACW317uz1l7Jb3BUArfHC2zzyqKv8IZlOGpvimlEhNrRVJBHbYkRAPXp
8DfRqvKDLg7W4iFvi1MwGEasq9d4atnxxYkANLmRq3LJJS8/J13WtnLPDz9fG0+0
h6QyWfqIBsKHRc/bIKnbeFq0XiuNqh6fPUsIxCgtVAiMmlgOAfH8yGE0eauSX7SA
W6px4TOYn/AjOyeNBqXLTlDUiLuz6g==
=SRkW
-----END PGP SIGNATURE-----

--5H3ikhGOIq/UysY2--

