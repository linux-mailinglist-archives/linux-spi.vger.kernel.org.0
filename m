Return-Path: <linux-spi+bounces-7326-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E1A71C0B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76401898C48
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A363B1EDA34;
	Wed, 26 Mar 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gStzZ2jW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79CF1F416D;
	Wed, 26 Mar 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007354; cv=none; b=AFvHEn91eBwHYiwApsn8q1yDyVCCX0kBvuDGcCe0NMnhNhN1F0Kmwp6m+tQPHYR5dzdzDfw07dTDVOjZUm3FFOVbyIcUy3WyDIeGxxeGoK3/3Sssxsejuu8Nhf4uvg+MHR379lxdqDxB44x23IIiBnjYMys+j6zTsPwC+3wXtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007354; c=relaxed/simple;
	bh=X2DxkO3Z0ZiZDUVuslfUvsTVKz2yIhEjymSgEAgeaLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olH5cRwnlPmJpFO6OAD3cOntBloEngKRRl2OK4vh2slJnD5G0wCDwbRCZgbET8oy+iWqqz7Ngv/axp2cY4CFsQHdy09daoKDNtTDV2YDVWn/gTl28d4zCQzO6VHBCgpsZFTe4zkJxhh/7s+exam7S7sElmC03jxQd7E2qDkrBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gStzZ2jW; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB251102EBA43;
	Wed, 26 Mar 2025 17:42:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743007350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hbMcfALOKLAN5Mw8Wpa0WVyi0wWl2REb7L9X3HcdnTo=;
	b=gStzZ2jWmk/ps9fxv0Xdm24uIRj7EOfQSWtMlG4q2HLsqIK2ipKvs4dCZOhcH48Xz4Akop
	wZht0GqxbGAcTqflnmDst9lZMj4ssC+c2h4TNql7nk7YcZ/g4BBXJjwaohk9tmc6drgS+F
	r4/yQYYfRaDnaO4pAVJ5cpB7FzGj2svJUqjW7jS8fjIi4cuuXmXqkrHJfZWtssJLItZJyV
	avTkPNmh8A0BO7pSa1z7n2zU9IT2S1QWERGrsiTv4TapRXaN4oZ3QuOMMtvEDv0FvRdwhL
	bQ0nrWYofK1SRcIpEz10neiS94keFeipxh4K1y6+oo/qyBJZ3xJ64JpgNTnF1A==
Date: Wed, 26 Mar 2025 17:42:28 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for LWE's btt device
Message-ID: <20250326174228.14dfdf8c@wsk>
In-Reply-To: <5661510e-3aea-4c07-88d6-2c3efccadb37@sirena.org.uk>
References: <20250221155644.1168860-1-lukma@denx.de>
	<5661510e-3aea-4c07-88d6-2c3efccadb37@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TbvFq.HIl7AIxb9_22=7h/N";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/TbvFq.HIl7AIxb9_22=7h/N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Fri, Feb 21, 2025 at 04:56:44PM +0100, Lukasz Majewski wrote:
> > The Liebherr's BTT devices are using spidev to communicate via
> > SPI to monitoring devices. Extend compatibles to allow proper
> > DTS description. =20
>=20
> This is fine but we need a bindings document update too
> (trivial-devices.yaml should be fine I think).

I've just resend the update for trival-devices.yaml.
https://lore.kernel.org/linux-devicetree/20250326140930.2587775-1-lukma@den=
x.de/T/#u

Hopefully you can pull it soon.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/TbvFq.HIl7AIxb9_22=7h/N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfkLnQACgkQAR8vZIA0
zr25kQf/cOf4hhdmDPZdvK50au5ouoJer5+qchALJYHNbPPJiz2SOnTORGBTMIin
asIWsLFA/0khJ998ok64v5e8TRqulltQxLAgZjf858QPpC3T0KXrBuXg+oGADSik
8Ioqs5dqKB/1hUCfu1sTxqUgS7sYjYCmEhjZnJEyklCtreyRwxjHpqhrvwBz7WOZ
u1wzMvNa0e+6Juqqh24QbkWC3/j8RsrMnU4r9FS3l6FukeCpBP/oqJm14u56KQOH
a1LQmVwsMm5yDNOjSFHmDCgV7Na/kXMBexLUaQ7idw2mcQudkd1/8l4I0OrTzoqD
0DgzwaYgtG8dFvgr4EehPu+BFvwdbA==
=umD7
-----END PGP SIGNATURE-----

--Sig_/TbvFq.HIl7AIxb9_22=7h/N--

