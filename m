Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C221118F49
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 18:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLJRtr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 12:49:47 -0500
Received: from foss.arm.com ([217.140.110.172]:52238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbfLJRtr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Dec 2019 12:49:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3C581FB;
        Tue, 10 Dec 2019 09:49:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71A223F6CF;
        Tue, 10 Dec 2019 09:49:46 -0800 (PST)
Date:   Tue, 10 Dec 2019 17:49:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [spi:for-next 1/2] drivers/spi/spi-fsl-spi.c:749: undefined
 reference to `of_irq_to_resource'
Message-ID: <20191210174944.GI6110@sirena.org.uk>
References: <201912101605.WSMiIcKr%lkp@intel.com>
 <CAMuHMdVUS+=k0cK-Z9x8JAS=p3BauPXm6C2EmV-umsJDQc1qMg@mail.gmail.com>
 <af7a7385-4980-ab18-6c91-29ba463a3cde@c-s.fr>
 <CAMuHMdX86AYi-901H8V1NmuRmA9vLefS57AW0v8Uakuu+COqrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX86AYi-901H8V1NmuRmA9vLefS57AW0v8Uakuu+COqrQ@mail.gmail.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 04:06:12PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 10, 2019 at 3:57 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:

> > Right. That's independent of the present patch though, as the fonction
> > irq_of_parse_and_map() that's being replaced by of_irq_to_resource() is
> > also depending on CONFIG_OF_IRQ.

> That one does exist on SPARC, and has a dummy for !OF_IRQ:

> include/linux/of_irq.h:
> #if defined(CONFIG_OF_IRQ) || defined(CONFIG_SPARC)
> /*
>  * irq_of_parse_and_map() is used by all OF enabled platforms; but SPARC
>  * implements it differently.  However, the prototype is the same for all,
>  * so declare it here regardless of the CONFIG_OF_IRQ setting.
>  */
> extern unsigned int irq_of_parse_and_map(struct device_node *node, int in=
dex);

Or can the driver just use platform_get_irq() and not worry about the DT
specific APIs for this bit?  It looks a lot like this bit is legacy code
=66rom when DT had totally separate APIs for everything.

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3v2rgACgkQJNaLcl1U
h9AEmQf/f7uPGVTVpBz3BAwpgDHTUOAJ09AU57ZkC+85HGmyXL86djLx7YBchpxV
DBeE0s/P5urN+b4qTYpNwOQ+WeQ+ORfkxuDq3V1XAU922DDA/MbDbHZJYsichxBL
ssh0xdas8L3qE6+yWxZPcFaTawaMni4hgVGfImOZ7f9xKyQQqgbu+QdkaI36lO/4
8w3bXU/kMuYzSfaDQQ1116D4j0MVd8Nd7Q8Jm5cXkT3h5Jzzi/jkXwzhEORY0FyW
p8CJny0WAAyXcTktsIskH4NFOMmZ54oUn3YrlBK5v9sYmKymtxpv94Xrh7GGSMQK
iY6DPurlOOENSN5q+1HIteDljrHveA==
=o05F
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--
