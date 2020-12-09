Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769C22D48C3
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 19:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbgLISQt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 13:16:49 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:27749 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732910AbgLISQt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 13:16:49 -0500
X-Greylist: delayed 29744 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 13:16:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607537630;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:From:
        Subject:Sender;
        bh=385GotCTTVp6WiXp7P/PPzEqWXNcE+6k1Muc5VljLWs=;
        b=BvdBAgYuw6xhVZz5S4NYc/xYpdRwes3c94gVBDDxUzC/dXuUZ/CaPgquS9zO9VdPZ1
        mfi69MFsee5oJ0fzoc9cmCM4ebfptW5ZAfW3ob2NscV10onmXQN+r36kDeh2QreG39cD
        P3nuXZLtMlHoT/zhshJ+JeWZBeOoaQyDtB1jzh22iz8Y3NdTuv02R9RGhc0Jv2yinIYc
        eXFLKdeTZAJGT139yvwdMc6pixcgO2yPkxhEmZHJ9zwut2Gs+V5eIAr2V9yDxm2dO/vP
        bTCMCy01Nw6lSHQNVF3lFjKLqJCJE7FTDgSIx2nTNzTX5wsrdfLwtTmaJSKnbv0CL2B0
        0RsA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlafXAoNHQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.6.2 DYNA|AUTH)
        with ESMTPSA id 908871wB9IDe86J
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 19:13:40 +0100 (CET)
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and gpio descriptors
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com>
Date:   Wed, 9 Dec 2020 19:13:39 +0100
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Maxime Ripard <maxime@cerno.tech>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FA1D050-3BD5-4A97-9D83-520CCF75D147@goldelico.com>
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com> <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> Am 09.12.2020 um 18:36 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> On Wed, Dec 9, 2020 at 4:57 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> +
>> +      device node     | cs-gpio       | CS pin state active | Note
>> +      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D
>> +      spi-cs-high     | -             | H                   |
>> +      -               | -             | L                   |
>> +      spi-cs-high     | ACTIVE_HIGH   | H                   |
>> +      -               | ACTIVE_HIGH   | L                   | 1
>> +      spi-cs-high     | ACTIVE_LOW    | H                   | 2
>> +      -               | ACTIVE_LOW    | L                   |
>> +
>=20
> Doesn't this table simply say:
> - specify   'spi-cs-high' for an active-high chip select
> - leave out 'spi-cs-high' for an active-low  chip select
> - the gpio active high/active low consumer flags are ignored
> ?

Yes it does, but I don't know if it is what we want to have. Linus =
confirmed
and you also seem to agree. Let's wait for other verdicts.

This is also what made me wonder if that is really intended because then
the whole discussion about the cs-gpio-flags and inversion and the fixes
would not have been needed. The current code and fixes are all about
not ignoring the flags...

And I am sure the code would be much simpler than currently for treating
special cases. Code would simply be: make any spi driver look at the =
gpio
descriptor and undo any inversion that gpiod_set_value() will do in
gpiod_set_value_nocheck() so that we can really control the physical
state by spi-cs-high instead of the logical gpio activity.

Something like:

static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
{
	struct spi_gpio *spi_gpio =3D spi_to_spi_gpio(spi);

	/* set initial clock line level */
	if (is_active)
		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & =
SPI_CPOL);

	/* Drive chip select line, if we have one */

	if (spi_gpio->cs_gpios) {
		struct gpio_desc *cs =3D =
spi_gpio->cs_gpios[spi->chip_select];

		/* check if gpiod_set_value_nocheck() will invert */
		if (test_bit(FLAG_ACTIVE_LOW, &cs->flags)
			is_active =3D !is_active;

		/* SPI chip selects are normally active-low */=09
		gpiod_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? =
is_active : !is_active);
	}
}

There would be no need to detect spi-cs-high etc. in gpio-lib or
elsewhere. Only for printing warnings as suggested by Notes 1 and 2.

>=20
> If so, then I would simply document it that way.
> Simple is beautiful.

Firstly, I would only think about collapsing the table if we agree that
it is correct. Beauty is IMHO not a reason to declare the table to be
correct.

Secondly, please imagine some reader of a device tree who finds

	cs-gpios =3D <&gpio 7 ACTIVE_LOW>;
	spi-cs-high;

Documentation should work well and be helpful especially in such a case.
Otherwise you don't need documentation.

Saying that the gpio flags are ignored would be helpful but a full table
with Notes and recommendations how to resolve is even more helpful and
unambiguous - even if it tells the same.

BR and thanks,
Nikolaus


