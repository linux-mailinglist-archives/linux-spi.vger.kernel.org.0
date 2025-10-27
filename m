Return-Path: <linux-spi+bounces-10861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D423BC0E8D2
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 15:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B61A4FC163
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1002C11C7;
	Mon, 27 Oct 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8pM6eAd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9181F5820;
	Mon, 27 Oct 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576049; cv=none; b=fEj5uS/FJhuwlBM07Gec6J1srN4q8fyvsAU4ZMr+SEyEy4d2ZCcRi2I9EhA/ScMPxFF+rZEfhEVrYblDyAShrAbeR2Kdc3kUplu+/iRhLoeb/k8JuMmncLdkKIZcJeJPkamvOFAN9jHTQa8+1XpBXCLmnR9anfl9LkB0tjwKT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576049; c=relaxed/simple;
	bh=JvAfMBBkyVWcNMHDXRKVwxzm6paC2VoX7J/SV8+itDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuiBF+BDrefeTgH45kzV37FMN+AD3Gb7445/eXBTeWNByyd+RGO8zZPOqaXAPHuShQ29q1MiBx6trqx2Cpd2YPdOuFIAQhShoa2oh2bVKEde1zIq9n259YIfT6NYjYNLdMYeWM+iCGpQeQ0whke1p/g2S46Sco8MmCa4Fql90rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8pM6eAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566BEC4CEF1;
	Mon, 27 Oct 2025 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761576048;
	bh=JvAfMBBkyVWcNMHDXRKVwxzm6paC2VoX7J/SV8+itDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8pM6eAdfQ7Affh+16V4Uo0SMsX1kkLfgxRRwwGy7USvUc5RCIyHAYNAw5gz/XBmd
	 HPi+bL6eED+ACWkzb6qWaBjhdYk9bSlTByK/UunFkuyU3jYipBrGZZBsbMZanbkLBF
	 Jx2z9Lsh2Rwo9m41wPErHLzV4Y9j3lx3P4VjECE75XBgGdrBVLy7JlEM+RCgL9jhiI
	 gK1YqgzaVhZPe26Wjy5URc9b7Bp73QQ+1MDQAWIDJbH6XyIlJHsyPZVuICpwgWT4nW
	 NN6J1DQpufra1soiEOk/NAdNW36yjod74pERM2JOn8vA5YZA6ubwpPf3wc5V41CuC/
	 XGfSSlw8QZskA==
Date: Mon, 27 Oct 2025 14:40:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] spi: support the SpacemiT K1 SPI controller
Message-ID: <e4dd3db6-d554-4fd3-a674-60f2ff6e5475@sirena.org.uk>
References: <20251027125504.297033-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CFGmoVkBdJi44PFO"
Content-Disposition: inline
In-Reply-To: <20251027125504.297033-1-elder@riscstar.com>
X-Cookie: How do I get HOME?


--CFGmoVkBdJi44PFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 07:55:00AM -0500, Alex Elder wrote:

> Between version 5 and version 6:
>   - Rebase only
>=20
> Here is version 5 of this series:
>   https://lore.kernel.org/lkml/20251013123309.2252042-1-elder@riscstar.co=
m/
>=20
> Between version 4 and version 5:
>   - Added Yixun's Reviewed-by tag on patch 3
>=20

Please stop doing all these resends, this is just making things noisy
and pushing you further down the review queue.  You should not resend to
collect tags, and you should leave a reasonable time for review.

--CFGmoVkBdJi44PFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj/hGkACgkQJNaLcl1U
h9AvUgf+IWfOtlEyWJeQvX09oJOdwtThlYWV06oiVLGS+QFAQAIUAvUnNHQ0sqTH
pQMdxUhxO6HQRPwhyPD5f5D0jXiUS667iwaG7DBJ4OhxjxOkG1OY/xASk3cKuqgm
TKb/+5KBAqA/xfFdtNI1VuXGygqBDiiV/i6sjgv84H49ANNpni4fDENl1bvJ2GWM
ruZc0BoOgJ+ZLOW9nBQKBPbYArEc78hre6N+sOSFFFAIvZAd6plescE/JjwJCXZU
oh4+GzqvMFeRFS90Gh81C93o8RjPzBVaEdGOkWn2j1l/570wI3XcuxD0zSO+gF9Q
Gby20wQHnuD0zDNrRXcNtzN0oOrjOA==
=VZJx
-----END PGP SIGNATURE-----

--CFGmoVkBdJi44PFO--

