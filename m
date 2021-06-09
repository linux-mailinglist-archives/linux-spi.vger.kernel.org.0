Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC403A1A25
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhFIPwf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 11:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbhFIPwf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 11:52:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980CCC061574;
        Wed,  9 Jun 2021 08:50:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 591B61F43705
Received: by earth.universe (Postfix, from userid 1000)
        id 4C66D3C0C95; Wed,  9 Jun 2021 17:50:37 +0200 (CEST)
Date:   Wed, 9 Jun 2021 17:50:37 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 3/5] dt-bindings: misc: ge-achc: Convert to DT schema
 format
Message-ID: <20210609155037.glkvwomea66dlrww@earth.universe>
References: <20210528113346.37137-1-sebastian.reichel@collabora.com>
 <20210528113346.37137-4-sebastian.reichel@collabora.com>
 <20210609114747.GA19966@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6vhugcjkjposj5f7"
Content-Disposition: inline
In-Reply-To: <20210609114747.GA19966@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6vhugcjkjposj5f7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 09, 2021 at 12:47:47PM +0100, Mark Brown wrote:
> On Fri, May 28, 2021 at 01:33:45PM +0200, Sebastian Reichel wrote:
>=20
> > -Required SPI properties:
> > -
> > -- reg : Should be address of the device chip select within
> > -  the controller.
>=20
> There is an existing binding...
>=20
> > +  reg:
> > +    minItems: 2
> > +    maxItems: 2
> > +    items:
> > +      - description: Control interface
> > +      - description: Firmware programming interface
>=20
> ...but this new one is incompatible with it.

The current binding is broken, since it uses the same compatible
value for two different SPI "devices" (main SPI interface and
EzPort). It only "works" because compatible string is only used
to export the device to userspace via spidev and otherwise ignored.

But the main spidev is not used by current FW and FW update cannot
be done from userspace because it requires reset pin handling during
spi transactions. So basically upstream support for this binding is
completley broken anyways (downstream has additional patches to work
around the limitations).

In PATCHv2 it was pointed out, that there should be one device for
both chip selects, since the reset/clocks/... are shared.

-- Sebastian

--6vhugcjkjposj5f7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDA40YACgkQ2O7X88g7
+prw9Q//VEO2NWaRHNhft8dtEWXl4TFIqRVvBrMi4eShlvI7qJSAOp4/q/Xd0StX
OncpSd0kzJitxdVz423AailoCw5zW0K8Kbz2PihOr/LOaBRrJxTBvzmXMSaxTgFQ
0v2ZPKof5b/kvOY/mQNBKb8wa4RGfz+5slb4meRvdoyIoPbXb6EdtcGkMr0K/5bN
pkC1Z6wIunqBXqAXQ2LmbPY6081MAZtFplXE38LW6zvKa81A1512N9ChsM/Kpwx0
fJhBoJ4VoHUcT5GkGem131WDQ+F8WHAfGxk6z7QzvEU8uZqTN9B5K9BZCJhsJHy3
mgod7xcF7T/SJ1FeBA/FPG1tjspQqGNt/bm2GpzdNwnMj518PJvtoUU/XEtYuki1
1WB6pFotJ6Ku5wQ7oE8Hojp74eyO75OXvjYFhBN+PKJDOeq769gVDz9sxkQDWJSu
r5oADyxLx5a+4MBy3XLupsdncfI98pUNR5tKkHeRpaVYXukRqPGrpKQKxs5NM7aT
kkwpP0I4rRQpYWmfR3NImRyp89Kf5ZjKBchHBbQKiAmNpdpKTvjocKJfuhRpAHy/
fzbzR8T3wC3oCELzwWsDT0Y76xIKUfNSrfkLwSjjjRHTFcpbpwLSi8ohPigO0icu
MFbK58IpkW21S9L4n1At/AoVZCg74XMpAYt8u0L0HQLH1meQgw8=
=FyZg
-----END PGP SIGNATURE-----

--6vhugcjkjposj5f7--
