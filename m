Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CD616FDDD
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 12:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgBZLgN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 06:36:13 -0500
Received: from foss.arm.com ([217.140.110.172]:34498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgBZLgM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Feb 2020 06:36:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2680D1FB;
        Wed, 26 Feb 2020 03:36:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DDD73FA00;
        Wed, 26 Feb 2020 03:36:11 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:36:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Message-ID: <20200226113610.GD4136@sirena.org.uk>
References: <20200215065826.739102-1-gch981213@gmail.com>
 <20200218125557.GD4232@sirena.org.uk>
 <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
 <20200225173137.GA31830@bogus>
 <CAJsYDVKqcd-ytLLf5zKqs8DfjPAa5ELCX53OiPDAi-tDnLd=Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <CAJsYDVKqcd-ytLLf5zKqs8DfjPAa5ELCX53OiPDAi-tDnLd=Eg@mail.gmail.com>
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 09:31:33AM +0800, Chuanhong Guo wrote:
> On Wed, Feb 26, 2020 at 1:31 AM Rob Herring <robh@kernel.org> wrote:

> > You should should really only need 'spi-max-frequency' if the max freq
> > is less than the minimum of the host and device max freq.

> But current spi framework forces that a "spi-max-frequency" property
> is present. [0]
> Should we patch spi framework then?

That's one option, yes.  As far as I can tell the bindings have always
required an explicit frequency specified in the bindings but I've no
idea why.

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WWCkACgkQJNaLcl1U
h9CC6gf+JGnksoKyOcf+87xz30r83FSXTXHP5TSv0S1iEPWe7PYG3vPRv0NdFdq2
95nsCYkfFdyrl8ayy/LjsXvZMbZPUv2oDhJGdq11H7EX3/DrKCTcChXdkzpD64NG
dlKWpB6xvJ6Ka/g9VowGe+WcTwrhQBQByb45Z0EkTZxQ+YScJHQkJy8HZXQKf85E
IAW7t7mcHtmmIXmJB7yHHE3exT6cOcDurwuz6QOJ+w3YwNYNO2HcR5ZS0T1IjPe4
WgWVxid2OxLorFCxu8dUxxsq29uDD49lP/kfbyVYkND761fTbk2idLN94r6vvCyx
6PNQ3DIDylR48WUdePXdGADNjXBUog==
=d0oJ
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
