Return-Path: <linux-spi+bounces-9767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C36B3BA05
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 13:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDF41897F22
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5D2D0C78;
	Fri, 29 Aug 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE82NuKE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB02BE032;
	Fri, 29 Aug 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467499; cv=none; b=UNrJmK0S4kmKFnD5QdIVyb4GcDxVzaHMxe+0+YLIGhO+y3uVmRSNOrC08TxsusOqtvBHa2g+PLOKFsSiLUN3nKThTG9SvZHLV3eyOYOMDH8b23oRUY35NA7B4v3BhU/AAOsZ0XkwXY2a0GqvkN0Ym0VYmsiSXKd5YVS46/Pilu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467499; c=relaxed/simple;
	bh=nHAYpo6wXjpLKv+/CXT76ilRJMZZ8lJzeKl3nb/cOpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEB7IZECjDaTbZhy0/b3vAG73slI7cqwjug3eeaEwuxluHM1985ZOqK+CHrHe8MVraY7AbB1kxn+A64SfExDCtWOwRMxVJK+AaDmmReS5zEwXR6UtvhB1TsWLqK6G00LubckvGY93DdfGmvhxyWXd8klIMWontZLXMGpkhJ1vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE82NuKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45F9C4CEF0;
	Fri, 29 Aug 2025 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756467498;
	bh=nHAYpo6wXjpLKv+/CXT76ilRJMZZ8lJzeKl3nb/cOpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nE82NuKE+B/pSpMI5LpYWzYZhImueEVotH91cK0zQCoyIJqHwme+zHQaGw4/OGY5m
	 AaGRxk7Hm/IWEG7GOULbM3UWhZh+oWynz6OZXuG6K+97+3gB49iGCs3XWVxbuK3tFf
	 //8Hw88cdT88dmCh39doUET0vDTQ/u0+6WiA5fStVKs19fLu/XHxnt6W5WYjksOcYd
	 1DgN51OQMLhKjYB1rLV/D/NsbNBNPlabNt10z1PQQLYLHR9p44zzANmX75YOLYbvtN
	 h2Esw65Tyl1XhHm1TTtSDr7N6wxgQham5w43rPfuodJS1EERCxOJ6LkWgfY+E0UU6g
	 1L8JatzGpYdRQ==
Date: Fri, 29 Aug 2025 13:38:15 +0200
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 1/9] spi: spi-fsl-lpspi: Fix transmissions when using
 CONT
Message-ID: <aLGRJxK5Lr44P5hG@finisterre.sirena.org.uk>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-1-6262b9aa9be4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pd6qdlkt/5wcHhzI"
Content-Disposition: inline
In-Reply-To: <20250828-james-nxp-lpspi-v2-1-6262b9aa9be4@linaro.org>
X-Cookie: Filmed before a live audience.


--pd6qdlkt/5wcHhzI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:14:40AM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>=20
> Commit 6a130448498c ("spi: lpspi: Fix wrong transmission when don't use
> CONT") breaks transmissions when CONT is used. The TDIE interrupt should
> not be disabled in all cases. If CONT is used and the TX transfer is not
> yet completed yet, but the interrupt handler is called because there are
> characters to be received, TDIE is replaced with FCIE. When the transfer
> is finally completed, SR_TDF is set but the interrupt handler isn't
> called again.

Frank, you've reviewed the whole series except for this patch - is there
some issue with it?

--pd6qdlkt/5wcHhzI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmixkSYACgkQJNaLcl1U
h9Db0gf6AoJSvZDKXJviUVG0Yqs+SG3QxzNw3w5A9NAfgh4rui8jEqjcmRlusFLT
2rm2b4mLIiqNNowLA0Qn4JchSalEbgdLjA6yRik1NE4qvPKET0YOge0VZBUGhqRl
UmzvmFmqrZ0pHzqqUH6AKFR88L0/+I02OMNEUoWGLPCb6uh21n5FVVynFxYNfbdK
W4LNje4uyMu1EsoiVP0z6H3wl1xFQwFEEkm2HVOoEY7Y56Ku5JYUC8nEByY4UCr0
79cu1i/ioR5UfVpCuM6XHF+E61Zwb5AiYzLOJCrCSLjPS5xgKRFaiSDIE015zNBD
ItUVYx2za1SsgiyXzMPeIgn8868Lcg==
=qJji
-----END PGP SIGNATURE-----

--pd6qdlkt/5wcHhzI--

