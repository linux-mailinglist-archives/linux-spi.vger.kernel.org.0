Return-Path: <linux-spi+bounces-148-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB6804DCE
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F591F212D5
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5903F8DE;
	Tue,  5 Dec 2023 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y29SVj0Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC21B5;
	Tue,  5 Dec 2023 01:28:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 293681BF213;
	Tue,  5 Dec 2023 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701768505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ah8rFZzaoCOG6tWC+OXcYVYNejwejwSxxUHciVjGroI=;
	b=Y29SVj0QfTDCsTjUMTpzzAWrkPNnENITOnw2ALozUKcgKRn1+/uJ9HIv0/EpPUbdl5nAmE
	+/TlRd27EpqNsRN1/wTe4Rv/cuHxjUuvrMtAymZc1Ao/QfNVTbFYDLQ2EUwe0I3LaUEHOo
	kFAQ6/YIk57tWPRVyxNcyaO5/OusZTN/iSCP2cVIuRQEUdl0IePkhKOI/rwlWV17018pdI
	GElj2pBAFov0MkIT/+FOwBg7IUfkUMlhXDBOO4sZBN7ai3NHnPVo1NUG1OA9E2XVqO5KoJ
	LXhRBWjg6075Uu+w42xAY5K0flUAVT6tmpxZvxaU4+HyvD361IrMWwTVlf5idg==
Date: Tue, 5 Dec 2023 10:28:21 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ryan Wanner
 <ryan.wanner@microchip.com>, Ronald Wahl <ronald.wahl@raritan.com>, David
 Laight <David.Laight@ACULAB.COM>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] spi: atmel: Prevent spi transfers from being killed
Message-ID: <20231205102821.224ccbe6@xps-13>
In-Reply-To: <1788823860.72909.1701768176780.JavaMail.zimbra@nod.at>
References: <20231205083102.16946-1-miquel.raynal@bootlin.com>
	<1788823860.72909.1701768176780.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Richard,

richard@nod.at wrote on Tue, 5 Dec 2023 10:22:56 +0100 (CET):

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > All being well, it was reported that JFFS2 was showing a splat when
> > interrupting a transfer. After some more debate about whether JFFS2
> > should be fixed and how, it was also pointed out that the whole
> > consistency of the filesystem in case of parallel I/O would be
> > compromised. Changing JFFS2 behavior would in theory be possible but
> > nobody has the energy and time and knowledge to do this now, so better
> > prevent spi transfers to be interrupted by the user. =20
>=20
> Well, it's not really an JFFS2 issue.
> The real problem is, that with the said change anyone can abort an IO.
> Usually file systems assume that an IO can only fail in fatal situations.
> That's why UBIFS, for example, switches immediately to read-only mode.
> So, an unprivileged user can force UBIFS into read-only mode, which is a
> local DoS attack vector.

Right.

> JFFS2, on the other hand, dies a different death. If you abort one IO,
> another IO path can still be active and will violate the order of written
> data.
>=20
> Long story short, aborting pure user inflicted IO is fine. This is the "d=
d"
> use case.
> But as soon a filesystem is on top, things get complicated.
>=20
> Maybe it is possible to teach the SPI subsystem whether an IO comes from =
spidev
> or the kernel itself?

Well, it would only partially fix the problem, I was playing with a
spi-nor or spi-nand chip (don't remember) which was supported in the
kernel, just making big reads/writes (without fs, at this time). I
don't think deliberating on whether the driver requesting the transfer
is in the kernel or in userspace matters, but whether there is a
filesystem on top or not. But TBH I don't think this can be solved
without ugly hacks...

Thanks,
Miqu=C3=A8l

