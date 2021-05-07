Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4563137680F
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 17:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhEGPdK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 11:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237859AbhEGPdK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 May 2021 11:33:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3F4B61460;
        Fri,  7 May 2021 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620401530;
        bh=O3zHx8gGy8AU49D+Cnr2TBWRAoXneuMN59DU/Ks3vhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjOYIsvAC5gLtDgOeipF0F06gxKKV6y4oHApV4eIapZor+2Jwj5gHQ1ya1MhHIyme
         bn61u5vsDc+ZcuMPSOH8v51zHMySSD8emcgVya6okdgrrzXFEwxxa//ImRHWGV1gJl
         sHauyc5dg4V1lXYoUc+almVuAt38m/6XSH8ERigfRMQ7VQWrj8BibB6n8Q5FsVZ/cm
         kvZ+evUd1a3JB8VP9Zh54XD9EHXQxm4XwVvCPMJ7P1rOOdwGkb7AAM04G8tAH2OFlK
         0eu0oPZlAUEz/mqY+wnHxXUmeLJj3RCmP9mID3ZsScJvArFw7MoNkFYFTMyEy+EEP3
         QZZHlc+e1zE9A==
Date:   Fri, 7 May 2021 16:31:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: spi-mem: reject partial cycle transfers in
 8D-8D-8D mode
Message-ID: <20210507153132.GC6383@sirena.org.uk>
References: <20210506191829.8271-1-p.yadav@ti.com>
 <20210506191829.8271-5-p.yadav@ti.com>
 <20210507125533.GA6383@sirena.org.uk>
 <20210507135631.maue7gorfzsv4qpk@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20210507135631.maue7gorfzsv4qpk@ti.com>
X-Cookie: Postage will be paid by addressee.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2021 at 07:26:33PM +0530, Pratyush Yadav wrote:

> Patches 2 and 3 are a slightly different matter. They add an extra=20
> register write. But most controllers I've come across don't support=20
> 1-byte writes in 8D mode. It is likely that they are sending=20
> bogus/undefined values in the second byte and deasserting CS only after=
=20
> the cycle is done. So they should _in theory_ change undefined behaviour=
=20
> to defined behaviour.

> Still, they introduce an extra register write. I'm not sure how=20
> risk-tolerant you want to be for stable backports. I will leave the=20
> judgement to you or Tudor or Vignesh.

Ah, given that if nobody's seeing any issues I'd probably just hold off
there TBH.

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCVXVQACgkQJNaLcl1U
h9B8HAf9GZh6wXoQyIjqchDq4kgwLgCdMTMAnT1LjmrcRaeTiLr30MVfyjO+eLan
tCZYatA9w4eVKm2NbXI1G0JqZ+ZlmuGlgFEb1kRrSdWn/A6rUF0fHlCjygq6wQTR
GBqZ4wWImXKcry+Wc8GsZWggtV7XCkQYE3bp4l2QfXkhFtASgPkSYtLfYbOOKjOP
1Xpc4kqpfpaZIRDPJKqwTykeJaeTxY+T3Lfz/IUjFUa9mtr0RC6FjnA5+ekboY4C
pEMICHbnrt2WDRAk6HXqypb5N+HJ2V84XLi3Q/uMjFlgC4+2lLe/OEIkgzGDJns3
8/2LTp0aNJ+CgvTMYbnSmdorhvF2wA==
=+ofb
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
