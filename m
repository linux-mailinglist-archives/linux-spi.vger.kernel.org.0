Return-Path: <linux-spi+bounces-4880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD6A97C874
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 13:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55F81F2827A
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9DF194AF3;
	Thu, 19 Sep 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhRAE9is"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853E194083
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744692; cv=none; b=PpW6ukCTVe20yZ/sVvl36btszVPk25WhGd0f5SvTtwgfHMGBHW219/NAl9Nk5e2Db9sgdzAJi+koN4vAgmpBJUO1Hx0Z2vr8EptIReEU5OkaT5dIUwxPfkC4Hk5pH99zdDQr8mC6J+aeLWC4sIXBMmvBiTaftFoUU4zzVkqrGgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744692; c=relaxed/simple;
	bh=wh+1OaEabOJgjsBjLpcs+fVaPjWSLZAsZW1bfWkeSwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9kNasgbqftm3U6kAPJurzjzYQhyrGwfPqOCSRUSmDmjHpWxp7qmT6aXaHOHhesMjyCTw7IHgThmW0+or+XC1pPrpsKg89zVNwLTQ9XBhdt9YFn32ugec+nsv+Q1ATGE95VwHdBhhHc08GDFPj92ZddlPQ9V74yIJbNUgf3KH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhRAE9is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F9C4CEC6;
	Thu, 19 Sep 2024 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726744691;
	bh=wh+1OaEabOJgjsBjLpcs+fVaPjWSLZAsZW1bfWkeSwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhRAE9isvxLGrvxvMzhHj8qcslajJshaWfpcCokvRfmMkcX1GTd6X1X+S/osh4cop
	 a06d9uDxie2/wOVAEBLecF3d1W5b90/p5Wa6LoG5pCkqdielPCO3tnxdNkZypnG4iA
	 cTlSgrRiEECyGMnMilAfpwdv3EWsx14qJ0bj+SZBJe/FsY9elQ6YxuIYw+VoiBaI4p
	 nSpML2L+T5/pnQA6C9Rpm6RiCeF3ZJI/P654X0ZS4HncZxDJXL5YemjBWHgAATO0fI
	 3sOc9qMhffdyjR/tD8nDhvLhrd6pq1BE6gY+b5qan0x7Ru2n+7O0bFkBvkPOg/6jf+
	 SP6rynKNcrX/Q==
Date: Thu, 19 Sep 2024 13:18:09 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	upstream@airoha.com
Subject: Re: (subset) [PATCH 0/4] spi: airoha: Fix errors reported by
 mtd_test kernel modules
Message-ID: <ZuwIcdPbSa78agkj@lore-desk>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
 <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>
 <Zuvn6H9wmb7PQLac@lore-desk>
 <ZuvpR9GJkZZAqbHI@finisterre.sirena.org.uk>
 <Zuvr5nLxTR53b9Gs@lore-desk>
 <ZuwAoZ5zE16t1tjr@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ujfEkRUZ69plHeL0"
Content-Disposition: inline
In-Reply-To: <ZuwAoZ5zE16t1tjr@finisterre.sirena.org.uk>


--ujfEkRUZ69plHeL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 19, 2024 at 11:16:22AM +0200, Lorenzo Bianconi wrote:
> > > On Thu, Sep 19, 2024 at 10:59:20AM +0200, Lorenzo Bianconi wrote:
>=20
> > > Your changelog doesn't actually describe what might be fixed there and
> > > it's not obvious from the change itself.
>=20
> > sorry to be no clear on it. Patches 1/4, 2/4 and 3/4 are fixing outstan=
ding
> > issues while patch 4/4 is an optimization and we can apply it later on,=
 up to
> > you.
>=20
> Yes, what I'm saying is that I can't tell what those issues might be for
> patch 3.  The changelog for the patch should describe what it's supposed
> to fix.

ack. The issue is the 'read cache' logic present in the vendor sdk codebase=
 I
added in the upstream driver is buggy and it is introducing errors reported
by mtd_oobtest kernel test module. Since we do not get any read/write speed
improvement using the cache, in order to fix the mtd_oobtest test, I decided
to get rid of the 'read cache' since it is not useful. Now the driver is pa=
ssing
all the tests available in mtd_test suite.
Do you want me to repost just this patch updating the commit log?

Regards,
Lorenzo

--ujfEkRUZ69plHeL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZuwIcAAKCRA6cBh0uS2t
rK8FAP0QMmZOoqyY6tgfjZ4aqtOQoumzI7pmH7l3Jg6F92kzJwD/cUJCuNxw/rj9
6L38kN0UThfAs6cROV351wXJcpn7/g8=
=IwRv
-----END PGP SIGNATURE-----

--ujfEkRUZ69plHeL0--

