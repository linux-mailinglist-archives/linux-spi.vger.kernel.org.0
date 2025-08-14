Return-Path: <linux-spi+bounces-9415-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D847B26AFC
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 17:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3347AFF13
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3F91E520B;
	Thu, 14 Aug 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7TfFErG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BEDF71;
	Thu, 14 Aug 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185387; cv=none; b=T1vvQi8fdhuz5qRzvE4s/dQbF8yqiXOiO0vXylrYMA5tXojr19JJIn8Ghcb0bxe26CBYDsgvz9+Jj9qza7F5FWwEp39elaJuKfNyzyDUZq1011rAGMhYCdR3mFqdCxohYftwMBw6Vq1vp0S709na8uih/VwmpbhETtayhkCX5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185387; c=relaxed/simple;
	bh=s97MAlDwomWWXJkni9RvSqvFaqBepHk3zZBs+yEln9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mINpI8m6TNpmIiVb+RqHQdzLdEf5BaJ6bAKaN5I3vmvFeywCsPVUgxDN6K+s5nvOC1OpdtRYv1MPz0Jz2QEi0IcUacZIjomE4w5qX9qq/TRr99hVz3HD2hlgQnRKnuOvsmyCycIQoY7HDraM0DBbtGHzMfO2IYiA4yyvnKrTqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7TfFErG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B624C4CEED;
	Thu, 14 Aug 2025 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755185386;
	bh=s97MAlDwomWWXJkni9RvSqvFaqBepHk3zZBs+yEln9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7TfFErGme/r9vbo9zUCCMpzYUBGPn/hn9Q7C7cL/QmPN6MFFbVQ1XuN/vcmE9Avg
	 jSiL7QHHg63IFl3xwx3P8vCG8mPoUWY/qJkjspf4qlk/TnWa4Q4aYowvT51NqwUOn3
	 i7xjJruMBACp62sDt6p2oyMPNAXbJZNE5NoFx3W7Dawqg573L123gU9ekta34kP2eM
	 5lf3lE1M/7oD6p0d9aMO9Twcbb3fBHAQ6l4oTGpu5SNshJvNHIBtj0yejWucXTLh1b
	 F1O2rbka5gXNq3pMoShT14fs1xeSG86fbqnchp9+kRmE3UPUc6gON9iZVuC2ZlIHku
	 vyk5IDYR1OaLg==
Date: Thu, 14 Aug 2025 16:29:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for
 continuous mode dirmap creation cases
Message-ID: <78542bbe-1def-4aca-8424-cc26542d9762@sirena.org.uk>
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
 <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6fSP3sMls8KI1L99"
Content-Disposition: inline
In-Reply-To: <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
X-Cookie: This sentence no verb.


--6fSP3sMls8KI1L99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 09:54:23AM +0300, Mikhail Kshevetskiy wrote:
> This driver can accelerate single page operations only, thus
> continuous reading mode should not be used.
>=20
> Continuous reading will use sizes up to the size of one erase block.
> This size is much larger than the size of single flash page. Use this
> difference to identify continuous reading and return an error.

This seems like it just applies anyway regardless of the rest of the
series?

--6fSP3sMls8KI1L99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmieAOMACgkQJNaLcl1U
h9Ce/gf/fkA6B9sVlHP4Xe2KTll2KPZmoVSpZ2HLM1D8sX6gin8ZUikC/pLkIKRi
jCC9jrFTlMqXJEU7JpRhDMb5DODMgrMYP4Af93m4rlcKCkujTovwz82LA6t7dILo
3NiTCY/S3vSoRPiqgTEzRv9FYzjkA77WolhZKC5zfnIQvFbADU2l64j5eeK+Rnwn
FoVXBhQxnu9B+KEXwMcxB3veP+vbqEexfWAV0jDd2N8pMx758UPoxsd9xHCYtIIC
YvyKZvIrj4lCmunNAb+LjljJRO6PQk/XQrJBK/5/gZjO2BgamcibPk3CVhbmJGS0
FOw/2eOsSFwG9ikfk+SEPWobdN1A8A==
=9/QN
-----END PGP SIGNATURE-----

--6fSP3sMls8KI1L99--

