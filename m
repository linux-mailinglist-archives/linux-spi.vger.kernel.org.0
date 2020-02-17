Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2916116E
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2020 12:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgBQLwQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 06:52:16 -0500
Received: from foss.arm.com ([217.140.110.172]:34552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgBQLwQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Feb 2020 06:52:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA5C330E;
        Mon, 17 Feb 2020 03:52:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E0BC3F703;
        Mon, 17 Feb 2020 03:52:15 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:52:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        dinguyen@kernel.org, tien.fong.chee@intel.com
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Message-ID: <20200217115213.GA9304@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
 <4712cdc4-34cd-990b-3d53-3d394ae1250b@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <4712cdc4-34cd-990b-3d53-3d394ae1250b@linux.intel.com>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 05:28:38PM +0800, Ramuthevar, Vadivel MuruganX wrot=
e:
> On 14/2/2020 8:11 PM, Mark Brown wrote:

> > Given that this is a new driver I'd be very surprised if it broke other
> > users?  I can imagine it might not work for them and it would definitely
> > be much better to get their review but it shouldn't be any worse than
> > the current lack of support.

> *[Vignesh]*=A0 The legacy driver under drivers/mtd/spi-nor will be remove=
d as
> we cannot
> support both SPI NOR and SPI NAND with single driver if its under
> spi-nor. New driver should be functionally equivalent to existing one.
> So I suggest you test this driver on legcay SoCFPGA products.

You're not actually removing the driver here, you're adding another
driver for the same thing.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KfmwACgkQJNaLcl1U
h9DBWAf+OHZ1rJV0+WA7kk3V0MqnCBMFLhoDTTlX4vp37gCaeNjn4YryKDsoh0qG
uoW93R7bcLcYmXsJ9SWxOWU68D2ekuSx0/AGRk9kMfDEmfQUQvjP9pTF+4wASigO
7vi7ml0sLaRBEWViXX0oOpI6RaDBmU7VO/au9QZogPHKPtCqkw+yAc1v0tszou65
bkg7faKKy6UCEUK2cgPxMkcLGKaN69B4Ov+AQX3uPubbQ5GhpmZ2f8lB2NbTHohX
etPjO6YF/D/k/r9OT+eFfAA8WUseco1PQX4ol46IrkxFMA3ak7FTDb07JFt4BB+s
lpLjrWId2xE+4PaCIvCTJIhEhEcNOA==
=fH+E
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
