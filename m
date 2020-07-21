Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873CF227C12
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgGUJtN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 05:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGUJtM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Jul 2020 05:49:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416092072E;
        Tue, 21 Jul 2020 09:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595324952;
        bh=HBl3U/frwOt22N3pqrjLjSOH31yq1r1eFl3vgEFJ7KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EgAhMgk3P2S9xtaT8KwyEsD8lQixAzJAQTEF8OrXQgw/MNtxENV+YlWrqW5EYzuUp
         qQWasjc85rxrgpep4PmBIyYM6ycTEvZAMwm2NVzj3mQi/6U0griHMWn9qCTC6EE/UL
         L74Cu6Pb5+vHL7pnSUv83VOEYTn8Huqaa/T3u1eQ=
Date:   Tue, 21 Jul 2020 10:48:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spi: update bindings for MT8192 SoC
Message-ID: <20200721094859.GB4845@sirena.org.uk>
References: <20200721024819.7150-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20200721024819.7150-1-leilk.liu@mediatek.com>
X-Cookie: I'm also against BODY-SURFING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 10:48:19AM +0800, Leilk Liu wrote:
> From: "leilk.liu" <leilk.liu@mediatek.com>
>=20
> Add a DT binding documentation for the MT8192 soc.

I'd expect to see a matching driver patch.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8WugsACgkQJNaLcl1U
h9DNOAf/U7WSHzWn6QeIOU6cZmJEboD/Jpm+YlFFOmeZ09Tt588WYDWCW7cfjiTE
JaFOMr53LA1OdW8WeKXklihwqEMP3dXcKdEpNbtVbU32PrCRAxj4XyrBxaBHEoKn
LzcMAcpmLngZAI6/1o9qyQte2d9r2EMNtiJz8XkWO4N5ZlLf04x0tD1TUqgwz/4h
lGTCCLPmVFbKZzU/V7QW2BgUKu/EEmVyhZx+EDQoUusWET66R92OHTMOJQil+aPC
XwPhYt9Lynxv98qUDDhxjfaKpBQqEk2wLSBHJ2xNDKPQes9Ea+CabdvHp5Jn92An
0sYM9AzJTTmbxHc4MBM51af5Ny5/jQ==
=lcjN
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
