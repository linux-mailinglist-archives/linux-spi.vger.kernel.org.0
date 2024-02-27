Return-Path: <linux-spi+bounces-1516-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E178689CF
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 08:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0639B1C220DB
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 07:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328165465C;
	Tue, 27 Feb 2024 07:23:27 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4B654729
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018607; cv=none; b=fMcdpgLKqF+hQSPCt9Ug7FeOn5wxjNZd6T6dTvGB8/Q/QjWn40kZoN6lTodaIWcTulOj88SDNFwSDX3lJftxczKLuXjk1TKSs56C5HnFDo2n2X1/SDflXontLhsSBdVm5Pk/7fah5/Y1SsO3zqOVrgzAuj7CTWDRO8P0WEXSJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018607; c=relaxed/simple;
	bh=iZ3LhNgFCYLXsBRnQ+g9Z0X3K3VlK/P41vpE3JYKd6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL7kdg7mkJmMTtw4w1VNEtefAu9Z1sNW9VMAQQbfovOdycpnaO16B4NJ9puTxrh4MFMJi4K/P+oA5OVqnrRISkc9nsbbSRasWb2gNl0oyZR7Pnk5TTtXSNJQ/L/0vmNlnFlGi5I/J9Jlmp4bBGx6m9BHybMP6Loa7eLe+POrGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rernv-0002le-8J; Tue, 27 Feb 2024 08:23:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rernu-0039AY-DN; Tue, 27 Feb 2024 08:23:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rernu-00CIST-12;
	Tue, 27 Feb 2024 08:23:06 +0100
Date: Tue, 27 Feb 2024 08:23:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, kernel test robot <lkp@intel.com>, 
	Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, kernel@pengutronix.de, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/3] spi: ppc4xx: Fix fallout from rename in struct
 spi_bitbang
Message-ID: <y2my7hxrpnwg72ols6a5w7n6zqz2yaxtswq4zlv6xpguiyaunm@tguc7ua3ypa5>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
 <20240210164006.208149-7-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xfad3cqeidqpairm"
Content-Disposition: inline
In-Reply-To: <20240210164006.208149-7-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--xfad3cqeidqpairm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mark,

On Sat, Feb 10, 2024 at 05:40:07PM +0100, Uwe Kleine-K=F6nig wrote:
> I failed to adapt this driver because it's not enabled in a powerpc
> allmodconfig build and also wasn't hit by my grep expertise. Fix
> accordingly.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402100815.XQXw9XCF-lkp@i=
ntel.com/
> Fixes: 2259233110d9 ("spi: bitbang: Follow renaming of SPI "master" to "c=
ontroller"")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This patch made it into v6.8-rc5 as commit
de4af897ddf242aea18ee90d3ad2e21b4e64359c. However 2259233110d9 (i.e. the
commit that renamed "master" to "ctlr" and missed to adapt spi-ppc4xx.c)
isn't in v6.8-rc5 but still waits in next for the merge window.

This patch applied to v6.8-rc5 made the driver fail to build.

Assuming we don't want to have this problem in v6.8, I suggest to revert
de4af897ddf2 and reapply it on top of your next branch.

If you're interested to prevent such problems in the future, there is a
tool in https://github.com/krzk/tools that can catch this type of
problem:

	linux$ ~/gsrc/tools/linux/verify_fixes.sh . v6.8-rc1..de4af897ddf2
	Commit: de4af897ddf2 ("spi: ppc4xx: Fix fallout from rename in struct spi_=
bitbang")
		Fixes tag: Fixes: 2259233110d9 ("spi: bitbang: Follow renaming of SPI "ma=
ster" to "controller"")
		Has these problem(s):
			- Target SHA should be an ancestor of your tree

Thanks to Anthony for reporting this problem (by private mail, so I only
added him to Bcc).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xfad3cqeidqpairm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXdjdkACgkQj4D7WH0S
/k5yRwgAgp0i6quBP/xiG9njBGmFgomRMkdjKqKMG3EXt/gymMpcTqs1KdyR20Im
5OV8X9kmzzaWjA4Syqgp9nWcRxdw86X5psp17Bp6YpV5aNcREivDIYg5LXBDGn0U
tPYieP20nrJhmaG62hzM+IAg7XrqwKJ5j2rMnIeXL+Yr0zNNoR8XMuD0xmLJFmht
uXEUvm+FVFPauj9xG+Cab8xT0TBXoFeHKfswfDlunzWUsWGjCxv00Dph48xPGcuO
pU/LL5hzyjthFeJdPSegqAMk6EHxqbSjhw6dDv290y/76lLgEpFfkliPouzdprNK
Gu7reGLuMQRa8OqyQDq6wnLMldd0ew==
=XONH
-----END PGP SIGNATURE-----

--xfad3cqeidqpairm--

