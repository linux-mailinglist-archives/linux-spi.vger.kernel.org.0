Return-Path: <linux-spi+bounces-12179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAABBCEEDEE
	for <lists+linux-spi@lfdr.de>; Fri, 02 Jan 2026 16:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B326302049B
	for <lists+linux-spi@lfdr.de>; Fri,  2 Jan 2026 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B922701CF;
	Fri,  2 Jan 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VlFGiiQg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393D26D4EF;
	Fri,  2 Jan 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367671; cv=none; b=D94xRkL44mV0q5Tnx+3KYcl//VTztDzUxt9OIqtj0N1qyf9RqIywf6/epZJKWAEqzKUW/Xr+bVtycPWtQQGqRsr6qJvlFWRaxfwSDG+qPDuxcTMJwOKnxZH71ROwHM6GXJaPT41i0YpwSYvA5YaYob0olJMVKzqM9ZcKqHSggd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367671; c=relaxed/simple;
	bh=SS2yV2DafXZ82Hx7kPgx/KxsyZ2YqKWv5FrorUnyBug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvrjyuTF53b3cMHqRFZ0Aqygnh8DyaU5FKk/NUSGM19eos3nEiKrNXl2Xz2pkvIy71GhGHwHj1Ofc2E/2fXxXpY1uIZsCW/HhlA+FgPSfj9HBz7W+nR+9uZCAnlYSap7ChMRZFZeQ66EolJukxtcLyfyow9yT+Gf2WOHQkBNT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VlFGiiQg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0DC53C1C3B6;
	Fri,  2 Jan 2026 15:27:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6D1E606C7;
	Fri,  2 Jan 2026 15:27:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F036B113B0726;
	Fri,  2 Jan 2026 16:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767367659; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XPS1mjvtZ+X94jm0JM9hHsjy2dgTByBQDp6LZfgUsSQ=;
	b=VlFGiiQgyp4A1jr1xVk3EEGB85uX0RicBd+tpt6aBlXBJJU5VZFGs6HfjTaleC9IT9dWb7
	jX6NkeMB0LJLHzQIrrQS4yM/1qqtyr/87Df1aMhUdLNwOZQkkcF2jM5DpztcXTVufyhI+5
	2Tej944Nisw1cu2YXgteKsF2Q2UVlw5UHguPe8eFMuK5sPihb0Wm956X0UgjYfX3Pb33iP
	sjtJ793m1Ixv9v8AeNS0VbMTUo9LGpXn2u67apY/pOeHcOD8CYKNTXq5sApIopOPQOBmuH
	0C/zIB3QNzw2rWSJJWf4923tCBNJf6D0IXuXmSuTTGxCMo1Kdf/co5qh64vJHQ==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 11/13] MIPS: Add Mobileye EyeQ6Lplus evaluation board dts
Date: Fri, 02 Jan 2026 16:27:34 +0100
Message-ID: <2775216.vuYhMxLoTh@benoit.monin>
In-Reply-To:
 <CAD++jL=7eU+jSHn0t2KKzHjipXYKoQreOdaHH8OcyriPmwHJQw@mail.gmail.com>
References:
 <20251217-eyeq6lplus-v1-0-e9cdbd3af4c2@bootlin.com>
 <fe9e594f-9718-48b5-8208-fb567a54cae9@bootlin.com>
 <CAD++jL=7eU+jSHn0t2KKzHjipXYKoQreOdaHH8OcyriPmwHJQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus,

On Thursday, 1 January 2026 at 23:42:36 CET, Linus Walleij wrote:
> On Fri, Dec 19, 2025 at 4:57=E2=80=AFPM Beno=C3=AEt Monin <benoit.monin@b=
ootlin.com> wrote:
>=20
> > In my particular case of a microcontroller acting as an SPI "relay" on =
the
> > evaluation board, what would be the best way to describe it? It connects
> > the two SPI controllers of the SoC, one is a host and one is a target, =
so
> > it behave as an SPI target on one side and as an SPI host on the other.
> >
> > The trivial devices bindings seems to be dedicated to devices, thus not=
 for
> > SPI hosts. Do I need a dedicated binding or did I miss something I could
> > use for a trivial spidev slave?
>=20
> That needs to be detailed and discussed with the SPI maintainer on the SPI
> devel list. (Added.)
>=20
> Can you illustrate with a picture or so what is going on here?
>=20
> Yours,
> Linus Walleij
>=20
Here is what it looks like on the evaluation board of the EyeQ6Lplus:

    +------------------------+          +------------------------+
    | EyeQ6Lplus SoC         |          | Evaluation board MCU   |
    |                        |          |                        |
    |           +------------+          +------------+           |
    |           | SPI host   |          | SPI target |           |
    |           |            |          |            |           |
    |           |        CLK >----------> CLK        |           |
    |           |        SDO >----------> SDI        |           |
    |           |        SDI <----------< SDO        |=C2=B7=C2=B7=C2=B7=C2=
=B7=C2=B7      |
    |           |        CS0 >----------> CS         |    =C2=B7      |
    |           +------------+          +------------+    =C2=B7      |
    |                        |          |                 =C2=B7 (1)  |
    |           +------------+          +------------+    =C2=B7      |
    |           | SPI target |          | SPI host   |    =C2=B7      |
    |           |            |          |            |<=C2=B7=C2=B7=C2=B7=
=C2=B7      |
    |           |        CLK <----------< CLK        |           |
    |           |        SDI <----------< SDO        |           |
    |           |        SDO >----------> SDI        |           |
    |           |        CS  <----------< CS0        |           |
    |           +------------+          +------------+           |
    |                        |          |                        |
    +------------------------+          +------------------------+

(1): The MCU, when the chip select is asserted on its SPI target, starts
     a transaction on its SPI host side. It then copies data received by
     the target side to the host side.

With the spidev entries in the device tree, it is used to test that SPI
of the SoC is working with `spidev_test`. So the MCU is part of the test
harness found on the evaluation board.

If the SPI signals of the SoC had been routed to a header, we could do the
same test with jumper wires, directly connecting the host and the target.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




