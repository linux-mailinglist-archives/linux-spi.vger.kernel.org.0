Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21ED39B877
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 13:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFDLzh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 07:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhFDLzh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Jun 2021 07:55:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27646140B;
        Fri,  4 Jun 2021 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622807631;
        bh=wkfBTP/8Cl/ZYhpzN7ZVw7aCTOAdTvV8+7bQBKp3nZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvakbyQQCWtRIie4mr+fW8ixx5ZhdhV+5EQXrALyKAawM8b7jRBcj9uARUx3Ha7Bi
         h5qJMBL5cf1oYy+U1NZUcgpiI8uHBUmDW9sFqVVxN/1/+fpUO+g23IlQv66RvsdzF+
         3cFLi02K17Zr9ilnAxJbczMV7MnVRyklIlzP167BZzKJIdpDBy5k2NZWjX7yqnP0Al
         yBUvT8ie5lrAU0ifTIALP1WNKBCaLijLqrxrks6ABSXatjl/OGLgJAwzi6/8F8Au7v
         /B2K571o3i8hLBUoiH7LabIgiRvWd8f153TiquK7pg4dLPy+KSHbaxNFWqI6c+MCCO
         v2hcATRA9SfPg==
Date:   Fri, 4 Jun 2021 12:53:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Add support for second flash
 chip
Message-ID: <20210604115339.GC4045@sirena.org.uk>
References: <20210525160318.35802-1-mika.westerberg@linux.intel.com>
 <20210525191414.dc45h27rzqen4dce@ti.com>
 <20210526091250.GY291593@lahna.fi.intel.com>
 <20210526092417.GA291593@lahna.fi.intel.com>
 <e82f44552d0d4284fc5ed22ee0bee85a@walle.cc>
 <20210526102810.GB291593@lahna.fi.intel.com>
 <YLTILUh+bPhZ4ToR@lahna.fi.intel.com>
 <YLi3/DRqGzdlosNf@lahna.fi.intel.com>
 <20210603180843.hjzynysgby3d3e5r@ti.com>
 <YLoOSMxeGXP07Tfw@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <YLoOSMxeGXP07Tfw@lahna.fi.intel.com>
X-Cookie: There is a fly on your nose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 04, 2021 at 02:28:08PM +0300, Mika Westerberg wrote:

> Yes, exactly. With ACPI/DT the SPI core handles this after the SPI
> master device is registered and that would result spi_nor_probe() to be
> called for the children. However, with this one there is no ACPI node
> for the controller (it is PCI enumerated) so there would need to be some
> way to create that child device. In the old days that would be "platform
> data" but that's pretty much frowned upon these days ;-)

No, that's totally fine and normal - it's just like probing a MFD, we do
it all the time for child devices.

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC6FEIACgkQJNaLcl1U
h9D6Ggf8DZvlbuhVo6ZA52w7CxSWflHRgEqUmQ3ABMtOk7hUgKOiaRL1Wq4Poz9T
2sCKQgDlQAQo8isCFh+7wUlcIvLG4RHEFs5xns/0+u4ZQGXfovR35yCdKpGfzoR3
X4+vtWBvG+tRyv7ZimkiUSEtlZxMjzPzFipboBDAwaa8vaTKDfPOfIiS+1Addbrw
T8RgG7hYD5eZJ8kbzxxzI4e7oQKVD7ceg39hBwdhEzWtNQyvz3g9g+psInmwaqAI
31RMJzdL3J01OUIPPbxQxw+sfKItkW+SOXHfihUjwK/9wj9KOxZNuNMt7f6bUAcM
lq4LtBV5fRgq6l8OTWdOWCDZMkTryQ==
=51cF
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
