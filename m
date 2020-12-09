Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0672D4D4B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbgLIWHm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 17:07:42 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:30939 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbgLIWHm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 17:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607551487;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:From:
        Subject:Sender;
        bh=gqm/9MTwR8OFWYxZA+wFt1gJnEsBRn4X7ntuVOAfVyw=;
        b=HJICz6E8ejwopvkqMVHVVQwUVfNgiEG/u0wR0I6b6dgOdEDrlXNXzbBlgWmB9kUjgI
        BOcQvSIGuEneqCfJhRrhoJbqcIr00CTAe/IpQdFuAOXW48VPI6TKglKh8dOTjQnU1YRk
        ZbnWuB3HNn2ejg/bVtoHto2QlPDxDBvsJRG+/5XaEFQXl59CXVnz7bpTXchOSqH0B20h
        j+t7zq1QWUCd89C0wBIEiuibFGmE2IxYIfVlTwhSNf+kGHs9BtDpzrNmgzfbbb2svXRZ
        oPDiiSnNJyNBiO8/QZOWU1mqghj4qwFu50jctUBX6pRypcyI2Qf/FjK9tA4wZeN3BDhU
        s2FA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlafXAoNHQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.6.2 DYNA|AUTH)
        with ESMTPSA id 908871wB9M4a8bd
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 23:04:36 +0100 (CET)
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and gpio descriptors
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiU3DptnURBH=xf0eO4ZtKMH1sd2qWQqfBNbDkXDpzwGeg@mail.gmail.com>
Date:   Wed, 9 Dec 2020 23:04:36 +0100
Cc:     Andreas Kemnade <andreas@kemnade.info>,
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
Message-Id: <BC1AFCEC-DE7D-4135-81DC-1B20CC662917@goldelico.com>
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com> <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com> <3FA1D050-3BD5-4A97-9D83-520CCF75D147@goldelico.com> <CAGngYiVL9M72hFRWnmT_8RRX9pUTSLsNuYz6mUo0Be4Vivk7Xw@mail.gmail.com> <20201209210133.44ab9c97@aktux> <09D41BD9-F6BA-4566-8151-ACB3B2274B52@goldelico.com> <CAGngYiU3DptnURBH=xf0eO4ZtKMH1sd2qWQqfBNbDkXDpzwGeg@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> Am 09.12.2020 um 22:28 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> On Wed, Dec 9, 2020 at 3:08 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> But I have tested with
>>=20
>>> spi->mode |=3D SPI_MODE_3;
>>=20
>> which should keep the mode intact. Right? That did not work either.
>>=20
>=20
> - make sure ("spi: fix client driver breakages when using GPIO =
descriptors")
>  is in your tree

Well, if you remember, the panel did work *before* this patch was in my =
tree
and I found this patch as the reason of the break...

> - your panel's CS is active-low, so 'spi-cs-high' should be removed =
from its
>  devicetree entry. In accordance with the rules as explained in commit
>  message of 6953c57ab172. Also in accordance with the table you posted
>  in this patch.

It could not have been different because the table was the result of
experimentally checking all possible combinations...

>=20
> When these two changes in place, your panel should work. I have tested =
this
> by mirroring your setup on my board:
>=20
> spi5-gpio {
>       compatible =3D "spi-gpio";
>       #address-cells =3D <0x1>;
>       #size-cells =3D <0x0>;
>       pinctrl-names =3D "default";
>       pinctrl-0 =3D <&...>;
>=20
>       sck-gpios =3D <&gpio... GPIO_ACTIVE_HIGH>;
>       miso-gpios =3D <&gpio... GPIO_ACTIVE_HIGH>;
>       mosi-gpios =3D <&gpio... GPIO_ACTIVE_HIGH>;
>       cs-gpios =3D <&gpio... GPIO_ACTIVE_HIGH>;

BTW: exactly this choice is questionable ^^^ if you have an active low =
CS
and it needs an explanation.

>       num-chipselects =3D <1>;
>=20
>       ethernet-switch@0 { /* active low cs */
>               compatible =3D "micrel,ksz8795";
>               spi-max-frequency =3D <1000000>;
>               reg =3D <0>;
>       };
> };
>=20
> If this does not work for you, then what are we missing?

I am missing that you notice that we are not discussing what I should
do with the panel driver or my device tree. I have these patches laying =
around
for a while (which exactly do what you try to convince me about - except =
that
I would apply an GPIO_ACTIVE_LOW). Just not submitted because I want to
have a clear definition agreed on first. For a simple reason: reviewers
of my patch should know what to check for.

In this thread we discuss a patch for the SPI bindings documentation =
which
is something different. See subject and the file the patch affects.

And I am looking for an ack and merge by maintainers of the affected =
subsystems
that the table is ok. Nothing else.

Please let's stay on topic and please cooperate.

