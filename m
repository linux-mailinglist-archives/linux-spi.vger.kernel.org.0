Return-Path: <linux-spi+bounces-3750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3507927B75
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113DD1C2161C
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2C11B373B;
	Thu,  4 Jul 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChPzUC53"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A4182D8;
	Thu,  4 Jul 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111764; cv=none; b=JjXSUB7jT/R5NKaA4C80q6d6W98HdCJOpWfjzBQV+GimIRxeTYOeWZpYS8igZgj6le6YOv5Zr+4sCbviFnDlMQ9nmvYamNDo699253EQDyM8BUdVeYo1xALgCUww5cJb4JM5QonOaCg7ZJ08QVd8FS+fmBaB0NK6H2bc2XZd1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111764; c=relaxed/simple;
	bh=V/hNryxYUoqX/3hr4qkJMKJe/sxOnEhMLqbIa0w1mOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYaztPo3MbYtggFO5MYbtWhAcyMTdNHoGjPmsVoTJqw1ZVk/khe9Ibuf34YirbNlxeImFEfk5rvOQGOkrb419t9bVQ4a+OEzPKKXuG9CykQDB07WHJdNlS/bJxgyuTNdOQU0hsCn00JXrAMb3wTT/uru7eDcDxq/FHQkv8p8yQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChPzUC53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B306C3277B;
	Thu,  4 Jul 2024 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720111763;
	bh=V/hNryxYUoqX/3hr4qkJMKJe/sxOnEhMLqbIa0w1mOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChPzUC53rna8olX5yXkpeizcxuhdkvoYsJyKcGnFlIstZh48N3YMeD2dM6zNSfUlL
	 CGeSlmXr1KfvsdCQRDKBFX7d8Id0oUlHq1awnegoPAgSHebCDicc7n8NOp9mSgaTfD
	 BTMFfS8WoRS4JOx7tARRw6R5tE1DBOySbN+u+qDIQcp7XPwOYHwjAwVubSj5DNfFW7
	 79QrD59o3EGx0QxC9SKZ6p3iani42yt9C7CH/x2lqyXhmNx8R5As7bfGWWSMVbBIIK
	 7LM3cryE5eYoY4wv2Q8RhLX0sFVHDTDQWvhGOqhS+vaMrHbpijgf45c3pBP2zCaQaN
	 xc/Dfk/nPyyWA==
Date: Thu, 4 Jul 2024 17:49:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: add basic spi node
Message-ID: <20240704-nifty-footman-a0b21ee461e0@spud>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-5-kanakshilledar@gmail.com>
 <20240703-juice-refreeze-62c468a56ea5@spud>
 <CAGLn_=tVZ3StW3uB+CkcHBpSJG8PfNGSM6zOVV6OSJeL2Pz56A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iudhDWt6j+LdvUYo"
Content-Disposition: inline
In-Reply-To: <CAGLn_=tVZ3StW3uB+CkcHBpSJG8PfNGSM6zOVV6OSJeL2Pz56A@mail.gmail.com>


--iudhDWt6j+LdvUYo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 11:12:43AM +0530, Kanak Shilledar wrote:
> Hi
>=20
> On Wed, Jul 3, 2024 at 8:15=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > Kanak, Drew,
> >
> > On Mon, Jul 01, 2024 at 05:43:54PM +0530, Kanak Shilledar wrote:
> > > created spi0 node with fixed clock. the spi0 node
> > > uses synopsis designware driver and has the following
> > > compatible "snps,dw-apb-ssi". the spi0 node is connected
> > > to a SPI NOR flash pad which is left unpopulated on the back
> > > side of the board.
> > >
> > > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Separated from a single patch file
> > > ---
> > >  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
> > >  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
> > >  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
> >
> > Didn't you say there was a flash on one of these two boards?
> Yes, there is a SPI nor flash pad left unpopulated on the bottom side
> of the LicheePi 4a
> carrier board. https://wiki.sipeed.com/hardware/en/lichee/th1520/lpi4a/2_=
unbox.html#Board-hardware-overview
> notice the reserved pad in the bottom part of the image.

Ah right, unpopulated. That makes sense, thanks.

--iudhDWt6j+LdvUYo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZobSjgAKCRB4tDGHoIJi
0hWfAP4uT4pgwm2LlqNsYq0IrYwSClAiEbvyWGLDIpcB45LO4wEA/iWiNXaMCveq
fX/ADDYJWod2qCc/NImHzdaaCxqBKQk=
=fj/5
-----END PGP SIGNATURE-----

--iudhDWt6j+LdvUYo--

