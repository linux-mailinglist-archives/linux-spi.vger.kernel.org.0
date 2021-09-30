Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3093F41DA2C
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 14:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351098AbhI3MtD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 08:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351087AbhI3MtD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 08:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AB2161994;
        Thu, 30 Sep 2021 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006040;
        bh=+LSXxf/C5lNbOrpCeow9qmR0dZ6TMRaZo780DicGs8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Or0BXotS/YChCOV++sPwAJYm3orZRArW42B+0g/1div/rnT3iAN3mslimfFCsHgm3
         jFZd8DcVq9klRreeOvz24ToxVXHrokq0gRJUsGwWowBggNutxn2bTEEzdBoELCroDX
         s4Sf7JteDCalbIhbDYv23sB7H+yrzKbFNUd7rgC3FusfK+q/xx5oJLa4ymw0VcUhyO
         McBm2mutaV2o3IjCw9E9jfQirhLiTIa/7rTODxRS26BcRs6k1I+4sucrpF4VAt/UZg
         ZufK9D6aM/hqD2lqXQ0StKRgm0KuFag0+/qK13reqGQRKSy0wQn547WDX+HkE3b96g
         ZRjIx9tch7NUw==
Date:   Thu, 30 Sep 2021 13:46:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     kernel@collabora.com, linux-spi@vger.kernel.org,
        enric.balletbo@collabora.com, dafna3@gmail.com,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] Revert "spi: modify set_cs_timing parameter"
Message-ID: <20210930124630.GY4199@sirena.org.uk>
References: <20210930120700.2564-1-dafna.hirschfeld@collabora.com>
 <20210930122513.GX4199@sirena.org.uk>
 <28f8af42-4535-ef9f-e521-712d37e2cb72@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sKosZo66cxuwvnFI"
Content-Disposition: inline
In-Reply-To: <28f8af42-4535-ef9f-e521-712d37e2cb72@collabora.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sKosZo66cxuwvnFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 30, 2021 at 02:36:01PM +0200, Dafna Hirschfeld wrote:
> hi, thanks for the fast feedback
>=20
> On 30.09.21 14:25, Mark Brown wrote:
> > On Thu, Sep 30, 2021 at 02:07:00PM +0200, Dafna Hirschfeld wrote:
> > > This reverts commit 04e6bb0d6bb127bac929fb35edd2dd01613c9520.

> > Which is not what the commit message nor the paste of the full hash
> > claimed :/

> What is the paste of the full hash?

The above.

> Since the second commit is only a warning fixes I thought it is cumbersom=
e to
> send two separate reverting patches. Should I?

No, you should write a proper commit log with (like I said) a normal
subject line - basically, follow the process in submitting-patches.rst.

> > Do we have any analysis as to why?  Do these devices use timing
> > parameters in some way for example, or do the values written out to the
> > device change in some way?

> > You've provided no analysis here so it's hard to tell if this is just
> > some random change that happens to change code generation slighly or if
> > there's some actual reason why this might fix something.  I'll note that
> > as far as I can see there are no users of this API upstream so I'm
> > guessing that you've got some out of tree consumer driver which uses the
> > API, it's possible that there was some error in updating that driver to
> > the new interface which is causing the issue.

> Actually the original commit not only change that callback 'set_cs_timing=
' but it also
> calls 'mtk_spi_set_hw_cs_timing' directly from the function "mtk_spi_prep=
are_message".
> So this actually influences all devices bound to this driver (in upstream)
> I did some printing and it does change values that are written to registe=
rs.

OK, so that's something that should have been in the commit log,
preferrably in a more detailed form that identifies what the change is.
However changing the values written out is clearly not the intent of the
patch and it is a substantially better API so can we not just fix things
so that the old values are written out?  Why are we jumping straight to
a revert here?

--sKosZo66cxuwvnFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFVsaUACgkQJNaLcl1U
h9Bwtwf+MtvgKYtUudf/n47UjD7LDb/EwrRnWOQ95GC+BenNNQM1lBYriL17NgP0
O9aGoqvc7JWUI698KrgSrsxHBSkDs0r8+tZQxZeEcbR5kUkOsoV0s98AlMjN2sHP
LoZwtgN4j/2R6e70+Wc4NU0fv1E0dlbkgg0GKEvtxxsGgGkvxvDMPJg6SEOqpKwF
gXowiuCHiI1TzZercbs5OCSSk9++MgiNOxNCNjMkWynYISicZB+LMbypkip7fGGZ
fGPA9av8KaB7UVCG6L34ink0d4gMWXmjrmCAB7JeX+KtkhLU4ASbNkjIc1eaQU85
kUoFycW/L766FtrdLQTy4+YScGyN/A==
=AH+t
-----END PGP SIGNATURE-----

--sKosZo66cxuwvnFI--
