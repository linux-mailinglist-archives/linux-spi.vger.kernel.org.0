Return-Path: <linux-spi+bounces-2726-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113408BA52B
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 04:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8E6281A48
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8A12B89;
	Fri,  3 May 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS5YaRJy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9470134A9;
	Fri,  3 May 2024 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702156; cv=none; b=LXNFLVyPea9xskR8nvA50IRDrjLLF+NaVcUUHSPCGb67zY58IyDXKj3yRmcbNo7Yw48qyd+ug1ixpZRcrBsam9c8Un/ZaxDxB/KymRfO/g6LSJXYrAMjC0+ZDpWRwxjyEDKWSmm8wbr5VVqIpnfHmN+YkyIFYxMIguqzh1u7oGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702156; c=relaxed/simple;
	bh=MJBdyf9VYWHJGmA+QB2TkOt5s7JaSbIJGeg0ZWG+4RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDpaHP39J7gntC0zCkArjkHmLlmrwJufChgvp6aYOQmZ4xO7DbCQJLuiSGQhGWCVEpPeELso/Xs2pwyyh9GXqw1N0ZwS4VNMHxniu1MVRn2CfuiPyD+axdL6OFKz20V2Msw8BNZuPxGBJ7KiHCcUHfkAHxYjNz13Lbgv1M1v0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS5YaRJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E57C113CC;
	Fri,  3 May 2024 02:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714702155;
	bh=MJBdyf9VYWHJGmA+QB2TkOt5s7JaSbIJGeg0ZWG+4RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iS5YaRJy++rBCyYOVfA81sBL4E7fgyB//2kS5D/e4tc43a4+h+m5ZwRN8g2jJM7UW
	 lgiMso7lQCAc9akSdneXzzhnV+9EXuQdIgZM615bKVK3usoRg39C3oRnF7mAu8iECb
	 Ghrm583pZEmX0w944gv2diRc90b0WHLSA4/ZGIwhQCHDnBQedhThfu22iUy0TSlJO3
	 0SvkKppDYvAb7Lmd7Wao/yN+ir8MVjp/BCfIF8ctdgC+k4NDy8aDTDJuzWU25GMkqf
	 myMgI7WDYu5VN6LV0SmYsXAvDl7aX+6qpDhAbfVBnwe+vxdnqHPafmw1jo7qWG02sK
	 CFIUwu17YSQlw==
Date: Fri, 3 May 2024 11:09:13 +0900
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, conor@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v6 3/3] spi: airoha: Add spi-nand flash controller driver
Message-ID: <ZjRHSWEPbFijFXqT@finisterre.sirena.org.uk>
References: <cover.1714571980.git.lorenzo@kernel.org>
 <08f55e89a1eb655402a748d700a023e1e27a194a.1714571980.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZexUTQxd0t1JGJxg"
Content-Disposition: inline
In-Reply-To: <08f55e89a1eb655402a748d700a023e1e27a194a.1714571980.git.lorenzo@kernel.org>
X-Cookie: Kiss your keyboard goodbye!


--ZexUTQxd0t1JGJxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 01, 2024 at 04:06:43PM +0200, Lorenzo Bianconi wrote:
> Introduce support for spi-nand driver of the Airoha NAND Flash Interface
> found on Airoha ARM SoCs.

This doesn't apply against current code, please check and resend.

--ZexUTQxd0t1JGJxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY0R0gACgkQJNaLcl1U
h9C6wgf9EdYIXAELt0UZtbG/aPEekqnkEW559LNjkJUia3lVyGF2iBWTnKFkBegF
9VAmveDm6XoW+yRbAOS7mTNVdEQc+OO76Ld/OAJBsv+uqW9FE+KesDOkJe99lUbd
cTruXBT2wPDoRZkMZrwfmCxOB4SaVtPWhL/IOGtZRk3Vvrwtq9QNr/pgH/ut+wG/
Tajflzo57zK7tgUgRXs3pW0OCNhZle2zc3PX/2f78cWyS25JmIp4O/0tN0YgZP+a
h3amiRtxRZT7XsTXiNHXCAhtoOHbZd2j8UJ6j0jE0jQWer4iIvK4YoF9xTVm7gQK
JLUOF3D/j9ACzucqvjQWKEhl8W1iOw==
=U/9F
-----END PGP SIGNATURE-----

--ZexUTQxd0t1JGJxg--

