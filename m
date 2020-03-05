Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0FB17A5F5
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 14:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgCENEv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 08:04:51 -0500
Received: from foss.arm.com ([217.140.110.172]:48310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCENEv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 08:04:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902B71FB;
        Thu,  5 Mar 2020 05:04:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FA033F6CF;
        Thu,  5 Mar 2020 05:04:49 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:04:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Esben Haabendal <eha@deif.com>, angelo@sysam.it,
        andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times
 as necessary
Message-ID: <20200305130448.GC4046@sirena.org.uk>
References: <20200304220044.11193-1-olteanv@gmail.com>
 <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk>
 <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
X-Cookie: When among apes, one must play the ape.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2020 at 03:00:22PM +0200, Vladimir Oltean wrote:
> On Thu, 5 Mar 2020 at 14:12, Mark Brown <broonie@kernel.org> wrote:

> > This is a fix and so should have been at the start of the series to make
> > sure there aren't any dependencies.

> My reasoning for not submitting it as a fix is:
> - The only driver that uses the functionality so far - spi-fsl-dspi -
> has worked thus far even with the limitation that only byte-by-byte
> transfers were supported properly.
> - I removed the limitation before actually changing the operating mode
> of spi-fsl-dspi. Therefore the limitation is effectively never seen.
> - New SPI drivers that would want to make use of software timestamping
> would do so through your SPI for-next branch anyway, where the
> limitation would be, again, fixed.

That's mostly all true but it's still better to pull fixes like this (or
the patch limiting the size) forwards and not have to think if it's safe
to not apply them as a fix, it's less effort all round.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g+O8ACgkQJNaLcl1U
h9A7pwf/XZVDWjQSxu5rxN8xVzJtVaBPgpdSXOfAxk82nRdHh7AI/SoMIe/GElEL
heL+Cu8F+ufVKbPZDbP6mS2DYQKgg5Xt5+Y07ShJfLK8WrqkU+WihtsRw9fkgp53
R4QwW3IfXPmfL7U7EHa4Ri7IbdpWiaAw6PWoFcRCcslI17FWWWpnB0L1NaXzlAp1
Hzf9OAzmW0HWqVdSI2lgxM3Rm9qqjQAF6fjV+yZkSHkCzKjl+Pjl1KVbjznmNe5c
uauBl5vQ/2TKZSqeQpix91rf/nio4YSNUiKBI2PFzMXXx0GK/BfXWHTA9MjlOpVp
keVlQduGvzfUHCT7G1GjlZV+LXgInw==
=WInA
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
