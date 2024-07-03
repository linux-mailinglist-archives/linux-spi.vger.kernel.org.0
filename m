Return-Path: <linux-spi+bounces-3730-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDC926369
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3413B23B77
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04117BB13;
	Wed,  3 Jul 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJOH6QUm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4917B432;
	Wed,  3 Jul 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016855; cv=none; b=BThQyasKENZ/01+ZdAuzoOGnnHUDMe38y2SZeR47P7UQRxAHG3v2d1+XTmmWAq+ONwFeTukh4m8BOUGVHm4f9AxEUYzwKDhj7QeHP6mAoK2WHvuDb0CHMlJl4pgDNRzaniySQgyh0jnc9SjqRln/3jX7butWt3Y1LPsAqQ4Ti14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016855; c=relaxed/simple;
	bh=Da1k3PzkF/P5dn5NS/xK2QBdWh+CFa21+xo9GpsOR+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQLybmD4DFeBvvbH8Enjqq6QzdxUPup9AQUK8QQx3+xRJ+fGRvcI2UFjdpGJMy4LwuaUjkAh51is2puDc1PYNM8e7tbKJ37V6mgTqu3Au3OPjEGnOSKiY055h9Tige+eShGgZjEDp/meQTNrD3X3BJeqSYLpDoPgmd2/FmFZoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJOH6QUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA07C2BD10;
	Wed,  3 Jul 2024 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720016854;
	bh=Da1k3PzkF/P5dn5NS/xK2QBdWh+CFa21+xo9GpsOR+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJOH6QUmjO2LsNelMSZ+fnHF1f7/M+RKugp5XZ5EYXrb0irw/Jgp1XnzcB8Ljvn60
	 eQ6CRgc26FeOct0mthjYpIlquau2mntGA0odmjnXdDzQgHxbh4l11sWLps3mqTKo6v
	 EWHfFVxJ4fQqRDFh3i8RsE1FyN3Mu4qozprPv99vLwntD91XOQEqWUcJqON6bW1orl
	 X3Lmx7MlFEU+G291Fjh9fhY24NrTXCb8wO2tgDmL5YE6eUfxl5CKX7v43z2NLUMe3e
	 O4Yb0qhseyhtonjoUHWMsIdv9lQn6pX+8bskOE9QFNo7RISn4WMpUuIdzwXgomQIKW
	 gyT0ey+gkzH8w==
Date: Wed, 3 Jul 2024 15:27:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] spi: dw-mmio: update dw_spi_mmio_of_match struct
 with thead
Message-ID: <20240703-postage-absence-15fdac24421c@spud>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-4-kanakshilledar@gmail.com>
 <f8604c68-8866-447b-a874-562bdad1df79@sifive.com>
 <23gvjkszxvf6zehiqetjfmtf67nlpnnfmhgx234jnxwrtmbdpr@4yv64sz2kpcs>
 <20240703-garbage-explicit-bd95f8deb716@wendy>
 <CAGLn_=tieSCGWix-0mGC7n8MnD46WPxuWh9xhtB6r+YZry463g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EU9d+cHRPc5+PaU0"
Content-Disposition: inline
In-Reply-To: <CAGLn_=tieSCGWix-0mGC7n8MnD46WPxuWh9xhtB6r+YZry463g@mail.gmail.com>


--EU9d+cHRPc5+PaU0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2024 at 06:42:46PM +0530, Kanak Shilledar wrote:
> Hi,
> So, I will drop this patch.
> In the next version (i.e. v2) of this patchset, do I need to include
> the dt-binding patch as it is already in for-next.

No, you do not need to include the binding.

> I am waiting for comments on the devicetree files before sending the
> v2 (if required).

I'll try to look at that today, not super sure if I wanna pick up more
patches for that platform with "fixed-clock"s, but I'll comment that on
the dts patch itself.

Cheers,
Conor.

--EU9d+cHRPc5+PaU0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVf0AAKCRB4tDGHoIJi
0s9SAQDaGbCpTI/xVyruCRzKJDgDQCVBVSQiPmkMWHtXReHTKAEA8COn47c8JK1n
nsX3uDFUqFEofK0Lenk0GQcCDuQpkgk=
=DN86
-----END PGP SIGNATURE-----

--EU9d+cHRPc5+PaU0--

