Return-Path: <linux-spi+bounces-7744-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A027FA9AEFC
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E819A1E5D
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58D27CB12;
	Thu, 24 Apr 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/v5YuJ5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829514B06C;
	Thu, 24 Apr 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501354; cv=none; b=jAJqvUaLsyw9sO3fbcUD6Hcz/SjN70lXPjyjzwjnUN1OVrPKV0axWf62huNCuaUdPL57ekFpzehtUmJAWGXJJO0cBNw7xrwxO1+FcQ9X6tRWAdoZGisDbpjY3wro+nfUZlcyVkhUmAukkN5uT2EuZsg9cht/d4fihYoYaiNwySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501354; c=relaxed/simple;
	bh=BfwZuS5qWp/PCKn69n0OyRsKh0sB1r30vAbBifl8M9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMRcWCBIFi0NegojyGGTdDF/lXFeao33qYzaIVQ7z+Jwyn1hN5zr223zJGgJGsV5nY+m8EEsZATkygHNXnK0BXFZ6OMhQfhPXPnz08GhGqlRmszqLBlnacuERoDV2DeXytGhN43+iAmnscOD4gEqKM2aIT4wSgaGwLy+1yJT6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/v5YuJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BFFC4CEE3;
	Thu, 24 Apr 2025 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745501353;
	bh=BfwZuS5qWp/PCKn69n0OyRsKh0sB1r30vAbBifl8M9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/v5YuJ5s/tsbcrDMuYh+oHTJ1IvlMoLUcCsvGMLZ6VGE4vIWDO5WlNMYG3TW5Nwv
	 xcw1kh0bERp331SqtZNxd1RiRzFagY69ftydjHf95WTvdCAuT4nLRnKXQSILYdoYjF
	 ozb9Jogjd/Zvmy+wIvr93UtTc7bY9OIuuFOPsTsUtY38+jQ/rPlqb1f7tCXqYLmn9/
	 3MOCsMONKl/jOCrl6MZVwoqGTguzb65zYxcNvQev7dEss3/HDvoMnGH+rnFRdgrglK
	 fvyTl1r7vkTJ2bCuYRZEz+TqY33nx9os2mkOosaa2RoCJvUlHvGUNc2XDhvN26ni+9
	 KvXkD6aU4xFOg==
Date: Thu, 24 Apr 2025 14:29:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, skomatineni@nvidia.com,
	ldewangan@nvidia.com, linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH v3 6/6] spi: tegra210-quad: Add support for internal DMA
Message-ID: <4a4391ff-d632-4c12-90d9-6c301e64612f@sirena.org.uk>
References: <20250416110606.2737315-1-va@nvidia.com>
 <20250416110606.2737315-7-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5DWBOk62MdjZ4De0"
Content-Disposition: inline
In-Reply-To: <20250416110606.2737315-7-va@nvidia.com>
X-Cookie: The Korean War must have been fun.


--5DWBOk62MdjZ4De0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2025 at 11:06:06AM +0000, Vishwaroop A wrote:
> Previous generations of Tegra supported DMA operations by an external
> DMA controller, but the QSPI on Tegra234 devices now have an internal
> DMA controller.

This breaks an allmodconfig build:

/build/stage/linux/drivers/spi/spi-tegra210-quad.c:1091:7: error: unused variable 'has_ext_dma' [-Werror,-Wunused-variable]
 1091 |         bool has_ext_dma = tqspi->soc_data->has_ext_dma;
      |              ^~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-tegra210-quad.c:1232:7: error: unused variable 'has_ext_dma' [-Werror,-Wunused-variable]
 1232 |         bool has_ext_dma = tqspi->soc_data->has_ext_dma;
      |              ^~~~~~~~~~~


--5DWBOk62MdjZ4De0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgKPKQACgkQJNaLcl1U
h9DJNgf/Sw6jEiIgKo9TW4+7ap0L8E12mk9B7QC/qyj6juFHB4tUJULHFK+94uRq
xGtjdXiAv9e+OWGVC1J+YDR5zcs2YEzRGgyKLWFzwnWBtUy5nwb1TAQXpNLi7PjZ
8AnB+dRPyvMdUs0CJ6amI39SHeGr3+WM07kqhWuIpkFnhlZ2hvD760x0WsACQa+W
QZVWQ/tjGAuLsvRosCQZNxzE25zkoqVCIhUa0zhiKedQZB+wS63DsOS2qoVZwTRL
wFCg6DX+6LF4MmylABOkJN1h4QIqG0Ex/Zt9NwswdpJJAGw9ninWQLox0SDn1yEs
a9TekZEWBXUGuCWHitq2c/UeD0ejWQ==
=s4S1
-----END PGP SIGNATURE-----

--5DWBOk62MdjZ4De0--

