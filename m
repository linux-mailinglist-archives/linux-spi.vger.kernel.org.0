Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735B82D4A69
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgLITfN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 14:35:13 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:11681 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgLITfG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 14:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607542325;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:From:
        Subject:Sender;
        bh=hBXvPQ4Ec+qpGD7kc0N2xFQQUJzkElcDdJ7p/ycRvDg=;
        b=hXQjTlcxzo4FxmpPSjAM9TKA/AwUslSPWvK/0ANsjM9p5IqQO1rzm78e5YeQHjnXTy
        4edy2pA7FotILrfuInBIDwYA4CYc3wlbufjEavnzEqecPNfU3Lmz2a+PspGJiGegXcRT
        kOrEpjarHbNP8H0dTi9GKC3HyPnrcGBDRcIpL9do93M0JKgB6Irr8jeK4YqFw3LBatBD
        ZhN1G2TiL6+x6VDjsE/LUqfhK4KZEi2bstbm5UUQqYXoye2xxtPHmdCe0/hi2ZjV5s3E
        uDvEbZtb6WkHjrfI6ATz5OmxRCytoZa1uGgczLtA1tFa8TyQimQgKHech9eAFXwLU0lV
        heAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlafXAoNHQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.6.2 DYNA|AUTH)
        with ESMTPSA id 908871wB9JVt8I5
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 20:31:55 +0100 (CET)
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and gpio descriptors
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAGngYiVL9M72hFRWnmT_8RRX9pUTSLsNuYz6mUo0Be4Vivk7Xw@mail.gmail.com>
Date:   Wed, 9 Dec 2020 20:31:55 +0100
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Maxime Ripard <maxime@cerno.tech>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCF3FDA7-7385-423F-9B30-836CBB446BF8@goldelico.com>
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com> <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com> <3FA1D050-3BD5-4A97-9D83-520CCF75D147@goldelico.com> <CAGngYiVL9M72hFRWnmT_8RRX9pUTSLsNuYz6mUo0Be4Vivk7Xw@mail.gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> Am 09.12.2020 um 20:04 schrieb Sven Van Asbroeck =
<thesven73@gmail.com>:
>=20
> On Wed, Dec 9, 2020 at 1:16 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> This is also what made me wonder if that is really intended because =
then
>> the whole discussion about the cs-gpio-flags and inversion and the =
fixes
>> would not have been needed. The current code and fixes are all about
>> not ignoring the flags...
>=20
> The inversion you witnessed was a bug caused by spi client drivers =
that

The inversion we witnessed came from:

commit 6953c57ab172 "gpio: of: Handle SPI chipselect legacy bindings"

There, I read a verbal description of the table I want to formalize
with this patch, because natural language is not as precise as the =
language
of logic.

This has nothing to do with driver code, which remained and remains =
unchanged
for long time.

>=20
>> Secondly, please imagine some reader of a device tree who finds
>>=20
>>       cs-gpios =3D <&gpio 7 ACTIVE_LOW>;
>>       spi-cs-high;
>=20
> That reader looks at the rules, sees that:
> - the ACTIVE_LOW is ignored,
> - presence of spi-cs-high means active-high
> and concludes this chip-select is active-high.

This misses information what the reader should do to resolve the
obviously missing beauty of the DT.

a) remove spi-cs-high;
b) change to ACTIVE_HIGH

Both appear valid in first place. But one is preferred. This is
again nowhere documented if you simplify the table.


