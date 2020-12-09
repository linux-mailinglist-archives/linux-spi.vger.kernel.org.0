Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2402D4B3F
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 21:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgLIUIe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 15:08:34 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:32891 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgLIUId (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 15:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607544339;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:From:
        Subject:Sender;
        bh=kAc/V5WPeRumZiIL2C7//K0I/ag/3WCMLZkC6BLUYIY=;
        b=tnN7fzM2sHaoRsjb6kd5YC4nSvZyYh+2wNJp1HWOjmlzWWEcAW5n6FmAPu13bk5z5Q
        qvt4r9ji543zqihPd9srP18YijIbM///g6yetmY+beKKCdM7KH+yHq1Hnkd2BQBt3ldj
        1z+IHyg/pUVwJ8xr1eU2IQxPtpuPftD5ekq8qUz+8b5iwkeGXK0/w1gupIgTJ/NduzYs
        qTXalCN7L5drpsBjmByj2+Z5Iu9hLfTx3n+Wl9DUu3z6qv5NHI/IH/Z2LsoiNeo9Eba0
        4bwnenL9wr/FGtrrFVaHk0P8sy903uS7eGcvJ+Q9vSNnEAKs2XqXsV19gAqhvF6R+Ajq
        vr6g==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlafXAoNHQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.6.2 DYNA|AUTH)
        with ESMTPSA id 908871wB9K5P8MV
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 21:05:25 +0100 (CET)
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and gpio descriptors
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20201209210133.44ab9c97@aktux>
Date:   Wed, 9 Dec 2020 21:05:24 +0100
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Content-Transfer-Encoding: quoted-printable
Message-Id: <09D41BD9-F6BA-4566-8151-ACB3B2274B52@goldelico.com>
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com> <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com> <3FA1D050-3BD5-4A97-9D83-520CCF75D147@goldelico.com> <CAGngYiVL9M72hFRWnmT_8RRX9pUTSLsNuYz6mUo0Be4Vivk7Xw@mail.gmail.com> <20201209210133.44ab9c97@aktux>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andreas,

> Am 09.12.2020 um 21:01 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Wed, 9 Dec 2020 14:04:26 -0500
> Sven Van Asbroeck <thesven73@gmail.com> wrote:
>=20
>> On Wed, Dec 9, 2020 at 1:16 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>=20
>>> This is also what made me wonder if that is really intended because =
then
>>> the whole discussion about the cs-gpio-flags and inversion and the =
fixes
>>> would not have been needed. The current code and fixes are all about
>>> not ignoring the flags... =20
>>=20
>> The inversion you witnessed was a bug caused by spi client drivers =
that
>> simply "plow over" the SPI_CS_HIGH mode flag. This includes the panel =
driver
>> you're using, see:
>> =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/panel/panel-tpo-td028ttec1.c?h=3Dv5.10-rc6#n337
>>=20
> ah, it would be set in spi->mode and is cleared by
>=20
> spi->mode =3D SPI_MODE_3;
>=20
>=20
> Hmm, but we have
>                      spi-cpol;
>                        spi-cpha;
> in devicetree. Why do we need that spi->mode line at all?

Because it is there in almost all or at least many drivers.

But I have tested with=20

> spi->mode |=3D SPI_MODE_3;

which should keep the mode intact. Right? That did not work either.

So let's not derail the discussion by moving to the code of some
specific driver. Even if that is wrong it does not solve what
this patch wants to solve.

BR and thanks,
Nikolaus

