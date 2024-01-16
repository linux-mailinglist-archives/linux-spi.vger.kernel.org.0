Return-Path: <linux-spi+bounces-481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B68482EF29
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 13:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E906C285B64
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F31BC25;
	Tue, 16 Jan 2024 12:48:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9A1BC23
	for <linux-spi@vger.kernel.org>; Tue, 16 Jan 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPirA-0000PK-0q; Tue, 16 Jan 2024 13:47:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPir8-000FGX-Nm; Tue, 16 Jan 2024 13:47:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPir8-000sv9-20;
	Tue, 16 Jan 2024 13:47:50 +0100
Date: Tue, 16 Jan 2024 13:47:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-spi@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Michal Simek <michal.simek@amd.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 17/33] spi: bitbang: Follow renaming of SPI "master" to
 "controller"
Message-ID: <piglwxn65qh3n4mbl7v7teog7mrwwshtc3kabue4s7bmmvvn25@4cq3upkgxddg>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <95602f4f5b17eae6f3381a3153dedd0031b03aba.1705348269.git.u.kleine-koenig@pengutronix.de>
 <CAMuHMdWj-LSfWv=qFGdC5mQ2GNHt6_Z=__ou7D=u04NuzU6E4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g7d67bqsfobkeig6"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWj-LSfWv=qFGdC5mQ2GNHt6_Z=__ou7D=u04NuzU6E4Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--g7d67bqsfobkeig6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Jan 16, 2024 at 09:33:07AM +0100, Geert Uytterhoeven wrote:
> Thanks for your patch!

Thanks for your feedback!
=20
> On Mon, Jan 15, 2024 at 9:21=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> > some functions and struct members were renamed. To not break all drivers
> > compatibility macros were provided.
> >
> > To be able to remove these compatibility macros push the renaming into
> > v4l2_spi_new_subdev().
>=20
> ... into the SPI bitbang controller drivers/?

Oh indeed. I fixed it in my tree, so will be better in the next
iteration.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g7d67bqsfobkeig6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWmevUACgkQj4D7WH0S
/k6QmQf/XWtpRmiAb86dsHd8Jo2AGqx9XsMLHXI0I1ogNGoNSa3J/v7PwM/H/Wze
ksG8YLCb2xZGR8+axSjHtCFZUB7Y9Y8rucVehbbOxhdy1Vp50bu8CHFKdOlU91XY
3fe6WN5c6W0/K2K3PocC2xi3nRVplJbgdbHbOSzLjeHlb0yJTk6THrb/FvYbu3Hr
Qq91CTgOAVU86rlsdxdhxI+sY6PgpdN6V7VnxvdWMY3qMa0lhxXcZ5OdqHVO5Y59
wnF5/2Spuu9AlTQRbx0p1OcIuAZ6NqU46G5A/4LQHZExsSiFGBQ1oaXEVGXh7vJ3
vF8vCp1vdFfzpzSDK5nS4hhUo3ZQvg==
=f0u5
-----END PGP SIGNATURE-----

--g7d67bqsfobkeig6--

