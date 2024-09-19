Return-Path: <linux-spi+bounces-4871-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D3A97C6BA
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 11:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75521F25761
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486C198A3F;
	Thu, 19 Sep 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+gUAf+x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3818B480
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737385; cv=none; b=sjVyx1JSKFlmNEMgmw4GZTqdtO4u1UEvVzUJfMgdYWKH8bwMQx8O0usn6rHT30vxIpWRg6lZDltWfZeC+GkZ1qCIrv6y9Q7GHLP95UuDZvO1xcWq3PBrq7QxnuJChP2lx93GrIo8a7Ubk6EBHr9g2JsSg46Hb9otBrMFPbCad1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737385; c=relaxed/simple;
	bh=NrARgfVAjcpMqTeJsY0Kq9HYo9RuQYK80hIMe8XJClw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRuWdjIPHHcXXdN6/RMd+Q6VERD89RhJvEi7apBn3jIDyLaAX+mWVHXlq1Y+fYBEy3Yfo5lZkfo/prbeNy1Pa04XcB3wrgXP9QJEGElwNlGYojn02PIK02NsDqhrKzFSVcBW+y1enM31T7bdBiy1R1f9e/HMm4z84incfaS3/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+gUAf+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89CEC4CEC5;
	Thu, 19 Sep 2024 09:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726737385;
	bh=NrARgfVAjcpMqTeJsY0Kq9HYo9RuQYK80hIMe8XJClw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+gUAf+xBcnu6PqRfhs4Zaeqcq6chIr37Uk0jUnO9sUcbNa/n4sacnacVxHZLGAuY
	 0Wd5Al+ACLF53wqK/pPwsr6tEUQYuc9ndl5RT+R7dxkT9owmczm2VCS4TcUo3uaLsJ
	 hNvDV8VWffx9BfkvH/VArJe/2eBgVD1L35uF9OH2JNfiBHr8avqQw9SJC+YexCwyeF
	 J8/qkp7Xot33Bvk58idn/chz+amEtoD23LHwf+Btu8hkMqHASeJPxcMHCKLa2hwwjq
	 S9DfGYe3YBlFPK3yZL1m0UKyHQaZaVwqkSnTL8ezu8BPH/noZNT8id4ZDDYxKLhZXJ
	 4No1XYInNqs2A==
Date: Thu, 19 Sep 2024 11:16:22 +0200
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
Message-ID: <Zuvr5nLxTR53b9Gs@lore-desk>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
 <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>
 <Zuvn6H9wmb7PQLac@lore-desk>
 <ZuvpR9GJkZZAqbHI@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZfHqVz9r8AehQSOB"
Content-Disposition: inline
In-Reply-To: <ZuvpR9GJkZZAqbHI@finisterre.sirena.org.uk>


--ZfHqVz9r8AehQSOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 19, 2024 at 10:59:20AM +0200, Lorenzo Bianconi wrote:
>=20
> > I think we should include even patch 3/4 since it fixes some errors in
> > mtd_oobtest kernel test module (and even some ubifs reported errors).
>=20
> Your changelog doesn't actually describe what might be fixed there and
> it's not obvious from the change itself.

sorry to be no clear on it. Patches 1/4, 2/4 and 3/4 are fixing outstanding
issues while patch 4/4 is an optimization and we can apply it later on, up =
to
you.

Regards,
Lorenzo

--ZfHqVz9r8AehQSOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZuvr5gAKCRA6cBh0uS2t
rBU6AP9NbvviqALl8sHfJIwPZDwdWq9HzE+/pgUjIy1DaWLyhgD/frD44zZ/dSB+
Ay8DiKlwXZBWXwfGzoPd0RE0yLOPLgs=
=kvKp
-----END PGP SIGNATURE-----

--ZfHqVz9r8AehQSOB--

