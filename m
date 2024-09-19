Return-Path: <linux-spi+bounces-4868-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDF97C678
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 11:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6911C22C76
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C6116D30B;
	Thu, 19 Sep 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFO2pZbl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188E12E48
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736365; cv=none; b=NLx6W/hD35l/c4x7qXYocMLbNzd1UZZMXjKIsvuH+h6/0eiC97Vpjg8rOaaFmdseCpAV9RrghFtQos3XXyzmmHih37oZbQLVh7rMUx+ZyGmu79nD4EaiG48jA+I6cCrg2esR85jxOXdZYWSd715Y8xbfXXItroF5680OAcdXdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736365; c=relaxed/simple;
	bh=yzMSX6VhYEAKKz6sRsMRX6VU4Qms2X2eK0on65DHWbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ6YtGiMcDGJQcfU/kFiJfh8bTnxlMzqAiD0rla6USjQFQeY17FSwujtFeAuzGZGBRhDRVHT1SisHsyYqlcrbAlZS94JzTTDXITfjYVKnLhef5z+KoYEKkJPovh2hbmxOkFnd91fQjlX/jMXEW2C1g8x2GS1V6a/Qwd6gXFJ8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFO2pZbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2557BC4CECD;
	Thu, 19 Sep 2024 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726736363;
	bh=yzMSX6VhYEAKKz6sRsMRX6VU4Qms2X2eK0on65DHWbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFO2pZblFU6HWQD4ETJ/miuffXGZ3tKrgwQXodQZceiK4TXMPMr+VUaAY2TiVSCjc
	 1I85+eddW6ymaVXxl/LIPxxVLRHf/qH5AESu2u789liauuj5HscjxDWx/PTaOB5vgb
	 xaabaX9DX7igYkjz1nLawEl8kvjoSc/rHEQGRVPSGIKHkTEDzZs1PnfED+u3c9ESFu
	 hIhD9FGn+ZJ1IXAHeVNKDj5MKy51RTjzn3cB3oiMw7ca1dI2262PBLb7yiaww8LggR
	 +naU5lSZMYtbdB8ITWm6zKsFG6+XJ3LoE66FPbmqljhfBM6NMsJsX/CqW9w8PD/NWA
	 /KXfnBh4qtanA==
Date: Thu, 19 Sep 2024 10:59:20 +0200
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
Message-ID: <Zuvn6H9wmb7PQLac@lore-desk>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
 <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yt5lP/jH7Y+I0R70"
Content-Disposition: inline
In-Reply-To: <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>


--Yt5lP/jH7Y+I0R70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 13 Sep 2024 23:07:12 +0200, Lorenzo Bianconi wrote:
> > Fix errors detected running mtd_test kernel test modules.
> >=20
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>=20
> Thanks!
>=20
> [1/4] spi: airoha: fix dirmap_{read,write} operations
>       commit: 2e6bbfe7b0c0607001b784082c2685b134174fac
> [2/4] spi: airoha: fix airoha_snand_{write,read}_data data_len estimation
>       commit: 0e58637eb968c636725dcd6c7055249b4e5326fb
>=20
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>=20
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>=20
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>=20
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>=20
> Thanks,
> Mark
>=20

Hi Mark,

I think we should include even patch 3/4 since it fixes some errors in
mtd_oobtest kernel test module (and even some ubifs reported errors).

Regards,
Lorenzo

--Yt5lP/jH7Y+I0R70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZuvn6AAKCRA6cBh0uS2t
rHbyAQCHnpAryxHNKvkSEMIEft3r7sAo8GH0k4cwseZBpG33NAEAuzmdPSfMcmhU
CjJkFapMOyQMbcors2kYWhoZMaPk8QI=
=W7jF
-----END PGP SIGNATURE-----

--Yt5lP/jH7Y+I0R70--

