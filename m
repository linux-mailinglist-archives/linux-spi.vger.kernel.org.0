Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8889728D2CA
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgJMREo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 13:04:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36928 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgJMREo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Oct 2020 13:04:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1A67F1C0B77; Tue, 13 Oct 2020 19:04:40 +0200 (CEST)
Date:   Tue, 13 Oct 2020 19:04:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: leds: choose correct color value of
 multi-led
Message-ID: <20201013170439.GA28123@duo.ucw.cz>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-2-thunder.leizhen@huawei.com>
 <1565f22c-7be9-e771-7def-afbb28ec07a7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <1565f22c-7be9-e771-7def-afbb28ec07a7@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> > +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> > @@ -197,7 +197,7 @@ examples:
> >                  #address-cells =3D <1>;
> >                  #size-cells =3D <0>;
> >                  reg =3D <0x2>;
> > -               color =3D <LED_COLOR_ID_RGB>;
> > +               color =3D <LED_COLOR_ID_MULTI>;
> >                  function =3D LED_FUNCTION_STANDBY;
> >                  linux,default-trigger =3D "heartbeat";
>=20
> This is not correct.=A0 ID_RGB is the correct variable here.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/comm=
it/?h=3Dfor-next&id=3D3d93edc77515c6f51fa9bbbe2185e2ec32bad024
>=20
> Correct fix is to update the leds-class-multicolor.yaml

Right. So lets not merge this one.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4XeJwAKCRAw5/Bqldv6
8vUOAJ41V+XbVX0DyC/lyzkofgmV7ZUDSgCePZO4075S4sKZU1LyDLclDD/cimE=
=Voh5
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
