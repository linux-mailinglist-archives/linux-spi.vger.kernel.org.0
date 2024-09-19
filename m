Return-Path: <linux-spi+bounces-4878-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4861897C828
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 12:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9554B25ECA
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD76335A7;
	Thu, 19 Sep 2024 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5wko4y/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EA33D8
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742693; cv=none; b=b8ButC0/34NhEBSu37SEAUZbk33AlcC3NocbJVN0O9L4QkTg96t0XySrr0wAmxKWiZrgUm7mhMyKzcfF3zpSe7dTEajwSkJ4btrUsO4IXeCiOOn5PTPaQKjD/wReil5O+rznoqbgrYLlyALKQxpbchPiDDei8rDBNugv6Dp95dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742693; c=relaxed/simple;
	bh=Z3zxI1/fr8MmSV063Slqqp3maad+2mYbQlqEopj2j44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUGy0OQ8OFT2HSMDfP1tfZsP1vlvjra35h/NFaSbqUzvFGLBehDmyWXu31tJOIRKJsQYQvSHlbqF7hvWU/bKuRtArdA27iLy7pBdSj2EBPO9UpKSvh/V6qX1KFm/lfgG8x8BGf0Nr8t4fLGCKJhJzsdVnLsebQUzrY6o6Xd1m1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5wko4y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65008C4CEC4;
	Thu, 19 Sep 2024 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726742692;
	bh=Z3zxI1/fr8MmSV063Slqqp3maad+2mYbQlqEopj2j44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5wko4y/W+0xxLXEQr2aeyc5syhrA7OPe6NTGXtxCm3e8Z4qmsiv5sPryOISHpOrV
	 jFigxhd5R27zXJVWkdy2ZgsloN3S4Pn0OH8e6UFJslwC7tHXNp8n8Kb40uVmZBIwEb
	 NlCcQNLoF7YKCnbeh6Ip0kao6t4bNK/FUwDaNE782zl9auqrScB/oAbku6v8fZb1DS
	 XgnySote7OJuUg/Y+rywhSnMGQh+cjenbSY9GsKt0fDAhR45MfEq5ABjH77895fJyZ
	 X7FJwscdpIbUuEJ42PGeswQC1Phd2zHr6AQlbsL4yFu83tq0B8BL6UmTDPX2CoXeJa
	 D25QVZ8g8zObA==
Date: Thu, 19 Sep 2024 12:44:49 +0200
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	upstream@airoha.com
Subject: Re: (subset) [PATCH 0/4] spi: airoha: Fix errors reported by
 mtd_test kernel modules
Message-ID: <ZuwAoZ5zE16t1tjr@finisterre.sirena.org.uk>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
 <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>
 <Zuvn6H9wmb7PQLac@lore-desk>
 <ZuvpR9GJkZZAqbHI@finisterre.sirena.org.uk>
 <Zuvr5nLxTR53b9Gs@lore-desk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CYpvGN415jmU9jGR"
Content-Disposition: inline
In-Reply-To: <Zuvr5nLxTR53b9Gs@lore-desk>
X-Cookie: Editing is a rewording activity.


--CYpvGN415jmU9jGR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2024 at 11:16:22AM +0200, Lorenzo Bianconi wrote:
> > On Thu, Sep 19, 2024 at 10:59:20AM +0200, Lorenzo Bianconi wrote:

> > Your changelog doesn't actually describe what might be fixed there and
> > it's not obvious from the change itself.

> sorry to be no clear on it. Patches 1/4, 2/4 and 3/4 are fixing outstanding
> issues while patch 4/4 is an optimization and we can apply it later on, up to
> you.

Yes, what I'm saying is that I can't tell what those issues might be for
patch 3.  The changelog for the patch should describe what it's supposed
to fix.

--CYpvGN415jmU9jGR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbsAKAACgkQJNaLcl1U
h9DSAgf+MjxQiaYsapMjvOxmKlcfFL80IjEzsoFxYin/lblovl8uepj9CkIBQ6Rx
zmlenNUn2BdZ6Yb0z0nFavLF2/40RuykCAm8xnlUmGpOZMN/+zDeLzvfVssiuc6J
M3mtuFh9ry3wvk32rHX7ChO5GzAe+nJCrnfuTlkCB7kO136dWCqhxClg1EueEeR8
1T4z4EY2YwA760X++VKi/Sd10w017sYz+12IqsUyMyN1D/y9puFo3a3NjRzE3/99
MVL3Ihr89SstkEjt0nrRBYxU2MEtjL9qZ6AOysdV6eXeRpDi06dCb/q/krlpa6I/
ZYOz1eg7/QJpeKJsM+QfxK4MKyoLfg==
=8xBU
-----END PGP SIGNATURE-----

--CYpvGN415jmU9jGR--

