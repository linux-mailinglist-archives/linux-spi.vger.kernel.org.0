Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0917DF8B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 13:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCIMKW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 08:10:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgCIMKW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Mar 2020 08:10:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 116B530E;
        Mon,  9 Mar 2020 05:10:22 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888603F6CF;
        Mon,  9 Mar 2020 05:10:21 -0700 (PDT)
Date:   Mon, 9 Mar 2020 12:10:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mtd: spi-nor: remove mtk-quadspi driver
Message-ID: <20200309121020.GD4101@sirena.org.uk>
References: <20200306085052.28258-1-gch981213@gmail.com>
 <20200306085052.28258-5-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20200306085052.28258-5-gch981213@gmail.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 04:50:52PM +0800, Chuanhong Guo wrote:
> This driver is superseded by the new spi-mtk-nor driver.
>=20
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Is this move OK from a MTD point of view - should I apply this when the
rest goes in?  The patch was in prior versions too and is obviously
straightforward.

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mMisACgkQJNaLcl1U
h9AW8wf/ZiBUrxNc95s6m0g5fMy2/cs3/LsPrWZSb3N2E1e27ymrx83CSPad45sg
mGRE8ZNrAjJejZVzFdgOiQZQtKXKFVjY6HjAAatKDSNqcX+8k/VR6yCE/xQB36h/
V+fLMlrzLx1nNEF3umZAmtdkQIQN8OuSTUbLAgAVe3bZVXWMQAZfcJrCy/FuidfY
ZjU3+caJ3jC8rwDB6+1xVujEe3+eCz63rkOHoSGzqXBYI0OpQfOLd9M8fu77WW4U
6RV5Z5lUl26EOpzOO2+FJKEdguXeXDguoAjKlqcc+CzhGBVdnRetzqf+LEujpAOd
xU3eqFZzEBmUHpNr4i2GACoDY/MBSw==
=H8Zm
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
