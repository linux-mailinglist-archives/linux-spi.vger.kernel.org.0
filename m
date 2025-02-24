Return-Path: <linux-spi+bounces-6895-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4428AA42299
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A353D7A1988
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693E13F43A;
	Mon, 24 Feb 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzUlrUEa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8E81386B4;
	Mon, 24 Feb 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406429; cv=none; b=FxZRd1SDAdSMJNNoRaJXG96IiJHJlUDEg7aMhVSMMtEc/9+Z+mCeE+eRm9NzrqvwcqVg4leJhmKpQ3MIuW/LrMNwjCUgjV1yIgMs3am/yqicEKNo5Jmb1JUzN8i1+DRTwZP8DM0NlEGV1/Ie0owvg6P5dW0m/NQrv0f8E8QMl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406429; c=relaxed/simple;
	bh=Wj5zNTFE65XNxiA8k1aNlq7fh0+PHSo3kv55LtTe++g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwW7mRGHSjh5M1aPWhnsOSvFLS6FBl0G/58S69GU7Ns0NJ9NCTPXabcQax4CaGEPQgASqvL+UWTjW0CqveLh33+1yKLUoGzEFIqBS4EFCRi4InxG4nUoHf8cvBzYFeNn3C7ky/WdNvuPgFKz1IZCe7VIIwyKB2age5WysCBxcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzUlrUEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9A3C4CEE6;
	Mon, 24 Feb 2025 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740406429;
	bh=Wj5zNTFE65XNxiA8k1aNlq7fh0+PHSo3kv55LtTe++g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzUlrUEagmgWDkKMcYHpr3NF/IPe4G+kar7+P8A56kIuePhlML7wmBe1IHbDViWKe
	 DaimGC8xz4/2YgHzW8v+mzDqDCzEjd2dhWKhqJz9f5pTvaD8htiZj0tuDDkNKOoDHX
	 c3i2ZVFiw5RNkyVjiFn3cxazrNNePCNmzFhrwHZLSzpOLm5MS99S5YhahN33KkXE0A
	 YXSJYRUSlVU1TxHbryTlNFKdJ0iAyjVdeQOgRu0SIE5CE2vQ1DROI7XQt4IaACKbUQ
	 EhzCMUXxb5Ag6ueoRxT5eWBkzTEKK3gLhti1cG2hZpjgsXpq9+y6vGgOXZFshN/AoP
	 at0TSPXrBj5pQ==
Date: Mon, 24 Feb 2025 14:13:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Longbin Li <looong.bin@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] spi: sophgo: add Sophgo SPI NOR controller driver
Message-ID: <0f129e58-e6fc-4089-8342-d80563884fcc@sirena.org.uk>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-3-looong.bin@gmail.com>
 <20250224132115-GYA41655@gentoo>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UWZHJyc+GhLlyMAz"
Content-Disposition: inline
In-Reply-To: <20250224132115-GYA41655@gentoo>
X-Cookie: Phone call for chucky-pooh.


--UWZHJyc+GhLlyMAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 01:21:15PM +0000, Yixun Lan wrote:
> Hi Longbin:
>=20
> On 18:12 Mon 24 Feb     , Longbin Li wrote:
> > Add support for Sophgo SPI NOR controller in Sophgo SoC.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--UWZHJyc+GhLlyMAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8fpYACgkQJNaLcl1U
h9CvhwgAgA7reQo+bW2TBpz7S9P/Vf9l+tPV26EuZw1UD0BK6c26I2whD1dwZ/Cn
YX6TXKPVtAW7/vg4GKLNlCjvV1CfGfPBa+3SMnW+o1a2VBbs02Yy4gK1G9JVlGI0
qZ2qhE+RsgoWmLeb5/k3k/qN9OmWLXLIjBXAl5MtLpn0Zvxc60zLxfymrwmweR8f
BHTKormpZ8eWY62Alb/9h99yW1tzG4UzhZTEBY0aBIsaZ+lfOGWg105ZJAOrhIIn
ub3BU2ABas5zIiCtmAj9ya7FC/87J13/s6ZSjz14B0Mw+nm8fUQ6RHIJz9CpDmuG
GApr8Se4bDfFXOB7ZHlGw34RfHczhg==
=W+n0
-----END PGP SIGNATURE-----

--UWZHJyc+GhLlyMAz--

