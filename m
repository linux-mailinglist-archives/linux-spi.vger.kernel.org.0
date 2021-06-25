Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0873B427E
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jun 2021 13:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhFYL23 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Jun 2021 07:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYL23 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Jun 2021 07:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C6B561483;
        Fri, 25 Jun 2021 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624620368;
        bh=5gGlFkG5ejd5XqK39wO+xof0g27mNIXfwL4EcnWkZIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOvqvDd09a5EaIbb7zxlefl62wNMvE/KjEeeQCnCIVk4vgQP+tWLc/idfafcor625
         zrPm14rgtbxoeUVODbsFTGyXWjZn+G1ggCVJewDk2vgYlvmOGsre/dftdvYYpLGYZJ
         xto3Q7lXgmhKxrfe37+FCw9apLHmi9GR4sLpOFrhHC3siVHQ8odA/B/91vqzuk1ldP
         U7rCHBxDenkSuG+svsY+a7n4r9r0nuuFNPUUyhRAK65b/eeTe1ahbRNPsYG1j6oeQX
         GGuZXN6knJLskd8QFqRPrm3/OyuwuhIEi71/a+DdCsK3lXvqtMsowMVfcT8KAdoQB6
         9Et9SeGSXj5BA==
Date:   Fri, 25 Jun 2021 12:25:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mason Zhang <mason.zhang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, hanks.chen@mediatek.com,
        linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
Message-ID: <20210625112544.GB4492@sirena.org.uk>
References: <1623721803.24597.9.camel@mbjsdccf07>
 <20210615111426.GC5149@sirena.org.uk>
 <732a8061-e8be-5c8a-ea75-6da87947db02@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <732a8061-e8be-5c8a-ea75-6da87947db02@gmail.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2021 at 05:31:41PM +0200, Matthias Brugger wrote:
> On 15/06/2021 13:14, Mark Brown wrote:

> > I don't have either patch 1 or a cover letter, what's the story with
> > dependencies here?

> No dependency. The dt-bindings was just send a second patch in the series. First
> one can be found here:

The point here is that if you're sending a series that's generally
because there's some dependencies so it's important to copy people on
enough of what's going on (generally at least the cover letter) so that
they know what the story is.

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDVvTcACgkQJNaLcl1U
h9BHrQf9F5/P+HsqVqRSUY1U2QheeUKbq475n6BZxva5qfaOSn478e0/IRiOu9zM
pnYfiilc8Ut5OlZQQ0634J2LZZydDSIYarRrPxXXFXxUNUIEDCIjJGHn0dkrBsUm
VjpWGlGAbl1lLkIzFWb9O19H7Uo7rOzTb5AtPO4Uo5EPg0y40dPYFXZFZ0HYA1mS
1aQT41fHHPHsZohCWwiLkjIYn1iMFco+Z3n8pwp+1pgsOcbIkcFLFB2FzkO4QU9z
IRgwgWTVZ7sMMw7t/zPtYbRO4WoDfys7qtRwkF/ORU5LjjPlSgaH0FAo8c+8sp+8
QBTEM350xjoF50d5SX2HBUOg7onqlw==
=D5wu
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
