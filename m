Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B313616FF6E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 14:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBZNDC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 08:03:02 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:34596 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZNDC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Feb 2020 08:03:02 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CAF6A1C0370; Wed, 26 Feb 2020 14:03:00 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:03:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Ezra Buehler <ezra@easyb.ch>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        csd@princeton.com.tw, devicetree@vger.kernel.org, sales@fdhisi.com,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        zypeng@titanmec.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Dan Murphy <dmurphy@ti.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [RFC 00/25] arm64: realtek: Add Xnano X5 and implement
 TM1628/FD628/AiP1618 LED controllers
Message-ID: <20200226130300.GB2800@duo.ucw.cz>
References: <20191212033952.5967-1-afaerber@suse.de>
 <7110806f-ddbd-f055-e107-7a1f7e223102@arm.com>
 <c86c6bc0-b0e5-c46e-da87-9d910b95f9f3@suse.de>
 <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
 <E33E27B9-D33C-4182-A5B1-C72FA40470BC@easyb.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <E33E27B9-D33C-4182-A5B1-C72FA40470BC@easyb.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On 13 Dec 2019, at 15:07, Robin Murphy <robin.murphy@arm.com> wrote:
> >=20
> > I also have one of the H96 Max boxes (which I picked up out of curiosity
> > for the mysterious RK3318) with an FD6551, although I've not attacked
> > that one with the logic analyser yet to see how similar it is.
>=20
> I have a T9 (RK3328) TV box with the same chip in it. The FD6551 uses an
> I2C-like protocol. Every digit (and the symbols) have an I2C address,
> but, the display does not signal ACK. AFAIK the FD650 and FD655 which
> are used in other boxes (Amlogic) are very similar.
>=20
> So far, I have whipped up a proof-of-cocept driver that uses i2c-gpio.
> The digits seem to be rotated by 180 degrees. So, in order to use
> map_to_7segment.h I had to define the BIT_SEG7_* constants differently.
> My display also has multiple symbols (WIFI, network, pause, play, USB,
> alarm) that are controlled by writing to the same address as for the
> colon.
>=20
> I=E2=80=99d love to work on a driver (similar to Andreas=E2=80=99 SPI bas=
ed driver) for
> these I2C connected chips.

Create a driver in drivers/auxdisplay for alphanumeric parts. You can
then export any remaining symbols as LEDs if it will provide benefits.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlZshAAKCRAw5/Bqldv6
8kZqAJ0eHpZJIq9KvRkuA970vGoHRW+FxwCfUVhxIMi58/nyPvs2Fhxkk2zlRec=
=UP4r
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
