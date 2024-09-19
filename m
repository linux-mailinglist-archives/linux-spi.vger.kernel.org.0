Return-Path: <linux-spi+bounces-4884-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C997C94D
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71FBB21EF0
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5919D08C;
	Thu, 19 Sep 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tburf6tU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE119CC13
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749402; cv=none; b=UOj2ZULb8dz5zfm7URC1lZiRflKYWEAtlEdmVgxPtGG2+s8eCf2QHwh/1xnWUeklR/0gJmnrA1Ks0rJM/CDoODpJchynWuE4ab7pJ48kviLVN9ZXOfk9B6B7ScsGzscS0VzbKjI2mwEdtVJUX0oRjQKwCGf607cNm43JSA9g6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749402; c=relaxed/simple;
	bh=drz/M8kFXL9ZPR3Lg1MLh8C8+oHJVn3wdZayUSYreD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZrv8lTlj2jZcH3OlO47Sy+615XaPpNPutfJ6kICZeN9m/zLRQXC7QHTptPgvGAGOj0F7//jB/0LG8DzbdaMAzsA0RSGYq/+w3ovUDXssZf1YsHlRbaV5Kro055nlxeXieYfV7VtUqmfRlEyWoKwMf7c9XaxACvKGm4PG3e7WL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tburf6tU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73944C4CEC6;
	Thu, 19 Sep 2024 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726749401;
	bh=drz/M8kFXL9ZPR3Lg1MLh8C8+oHJVn3wdZayUSYreD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tburf6tUAfmnJ28OZOqX6X/obau6SLTt9f0JA0YH8Qfq/YnaLfR1lgt2PAAakUVlf
	 YAeS84Wcs7kE81PA+8fnqG45qsZmQMqo5/tLNLVOM6+1gBqTGrKDcb/h4ZbRnwSXkP
	 5RVLY3zQC4atwqAzex1EbzBYH5mvy4aDODXk9yK9TSOr9UQJLH1ag3EjVDqk6CbXTl
	 el7SKhNMVPKBAi3TbF8IgwZcxYaFUxPsIcd4Z3HKsm2a9kGJWbUAYgy6VJKDnsFbBH
	 UiHd/nxZLuxT8GdNo/3ofNZVo7d6d2GeRENIitWTkPnCqTjPEyy0ZBv++HP/BDWTUj
	 Ch01IIrxGV5Zg==
Date: Thu, 19 Sep 2024 14:36:39 +0200
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
Message-ID: <Zuwa1wtNJQQIGvAg@lore-desk>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
 <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>
 <Zuvn6H9wmb7PQLac@lore-desk>
 <ZuvpR9GJkZZAqbHI@finisterre.sirena.org.uk>
 <Zuvr5nLxTR53b9Gs@lore-desk>
 <ZuwAoZ5zE16t1tjr@finisterre.sirena.org.uk>
 <ZuwIcdPbSa78agkj@lore-desk>
 <ZuwZIN6bPzlmB_Ly@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bibigXL21qbwIJJQ"
Content-Disposition: inline
In-Reply-To: <ZuwZIN6bPzlmB_Ly@finisterre.sirena.org.uk>


--bibigXL21qbwIJJQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 19, Mark Brown wrote:
> On Thu, Sep 19, 2024 at 01:18:09PM +0200, Lorenzo Bianconi wrote:
>=20
> > ack. The issue is the 'read cache' logic present in the vendor sdk code=
base I
> > added in the upstream driver is buggy and it is introducing errors repo=
rted
> > by mtd_oobtest kernel test module. Since we do not get any read/write s=
peed
> > improvement using the cache, in order to fix the mtd_oobtest test, I de=
cided
> > to get rid of the 'read cache' since it is not useful. Now the driver i=
s passing
> > all the tests available in mtd_test suite.
> > Do you want me to repost just this patch updating the commit log?
>=20
> It'd be a bit easier to resend this and patch 4 but yes.  Please mention
> exactly what the errors that mtd_oobtest finds are and ideally why
> removing the cache fixes them in the changelog.

ack, I will do.

Regards,
Lorenzo

--bibigXL21qbwIJJQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZuwa1wAKCRA6cBh0uS2t
rMiAAQCcaDkqOok/UgF8VirU5vAoayYclJkI+dQIHkQkSVYymQEAzpzxT2Dqq+Ni
sBbgJI49EQ0VllOkLJB6O90TXeLtzAo=
=7RpA
-----END PGP SIGNATURE-----

--bibigXL21qbwIJJQ--

