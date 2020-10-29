Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8533729F7D8
	for <lists+linux-spi@lfdr.de>; Thu, 29 Oct 2020 23:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJ2WYr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Oct 2020 18:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2WYr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Oct 2020 18:24:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B93F20782;
        Thu, 29 Oct 2020 22:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604010286;
        bh=YG/qxazDuQPMcKZmC7ljVHQhblVK5QCVfedcT2wad/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+7o71nv/1i3rhJzUK8M6l8QW/8pg6qcdFZO2g0JLozXQo7Jx7SGkNTbTXGNIxjdU
         z3dR0SmgfkECRbGBa7jM15PO9azr/NviqEZKDI7RtYC8Zmbdsk86LwfuGJoX/lOMhk
         R5FDozOzLndJh87uPvkAKQsVsdaMTmmTdOVLoqx0=
Date:   Thu, 29 Oct 2020 22:24:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Use after free in bcm2835_spi_remove()
Message-ID: <20201029222439.GF5042@sirena.org.uk>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <20201014140912.GB24850@wunner.de>
 <20201014194035.ukduovokggu37uba@skbuf>
 <20201014202505.GF4580@sirena.org.uk>
 <20201015053829.GA2461@wunner.de>
 <20201015125335.GB4390@sirena.org.uk>
 <20201028095946.GA25358@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline
In-Reply-To: <20201028095946.GA25358@wunner.de>
X-Cookie: Monotheism is a gift from the gods.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2020 at 10:59:46AM +0100, Lukas Wunner wrote:
> On Thu, Oct 15, 2020 at 01:53:35PM +0100, Mark Brown wrote:

> > This feels a bit icky - we're masking a standard use after free bug that
> > affects devm in general, not just this instance, and so while it will
> > work it doesn't feel great.  If we did do this it'd need more comments

> A combined memory allocation for struct spi_controller and the private
> data has more benefits than just memory savings:  Having them adjacent
> in memory reduces the chance of cache misses.  Also, one can get from
> one struct to the other with a cheap subtraction (using container_of())
> instead of having to chase pointers.  So it helps performance.  And a
> lack of pointers arguably helps security.

The performance arguments don't seem super compelling either way TBH
given what SPI does, cache misses accessing the private data seem
unlikely to be perceptible when operations boil down to accesses on the
SPI bus.

> Most subsystems embed the controller struct in the private data, but
> there *is* precedence for doing it the other way round.  E.g. the IIO
> subsystem likewise appends the private data to the controller struct.
> So I think that's fine, it need not and should not be changed.

Given their ages I suspect IIO copied SPI; I do think it's this reversal
that's confusing things.

> The problem is that the ->probe() and ->remove() code is currently
> asymmetric, which is unintuitive:  On ->probe(), there's an allocation
> step and a registration step:

> 	spi_alloc_master()
> 	spi_register_controller()

> Whereas on ->remove(), there's no step to free the master which would
> balance the prior alloc step:

> 	spi_unregister_controller()

> That's because the spi_controller struct is ref-counted and the last
> ref is usually dropped by spi_unregister_controller().  If the private
> data is accessed after the spi_unregister_controller() step, a ref
> needs to be held.

I agree that it's the asymmetry here, the disagreement is about how to
fix it.  If we keep the allocations combined then that probably makes
sense but I'm at best unclear on the merit of keeping the allocations
combined.

> I maintain that it would be more intuitive to automatically hold a ref.
> We could offer a devm_spi_alloc_master() function which holds this ref
> and automatically releases it on unbind.

I don't know that it's super intuitive to have to have an explicit free
in the driver - you could equally expect that having registered the
thing allocated with the core's custom allocation function with the core
that the core is now taking ownership of it (which is how SPI devices as
opposed to controllers work).  That's what makes me lean towards just
doing separate allocations, there's no possibility of expectations about
transferring ownership.  If it's *always* done with devm it kind of gets
hidden though so perhaps it's not so bad and my concern goes away...

> There are three drivers which call spi_alloc_master() with a size of zero
> for the private data.  In these three cases it is fine to free the
> spi_controller struct upon spi_unregister_controller().  So these drivers
> can continue to use spi_alloc_master().  All other drivers could be
> changed to use the new devm_spi_alloc_master(), or I could scrutinize
> each of them and convert to the new function only if necessary.

It's only things that explicitly unregister the controller (rather than
using devm) that are going to be affected here, that's a *much* smaller
subset.  Everything else will be done with driver specific code and
hence private data usage before the controler goes away, though it looks
like a bunch (though not all) of them have other issues and are using
devm when they shouldn't.  That's a separate problem which ought to be
fixed anyway though.  The removal paths aren't exactly heavily stressed,
especially not under load.

In any case for your proposal your plan makes sense, I mostly just want
to avoid ending up with people getting confused in the other direction
and introducing another set of bugs.

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+bQSYACgkQJNaLcl1U
h9B6OQf5AbdnKL+t7qN3rKqjLzOVW0j2Qg5UTJcNjuhK+hYRqIYLby3DdRvFhp9q
XKOz1rXEGJpAK+5YhwIIEf9EQL3OSLsbPKLel3huRAUr96WFw7Qe1LawGBSmxczu
zPumOxiOpwyrob3blMnyrWi6FqdGZrmLcyUfD3+PSK/8/bX9inCrHHDOMzplnMjN
OW2T9Wz4DimVwCevjrSmv2Ft82G1MGAdRHNChip3dVMhtcYJdBVZCiyN42QFMrQJ
n+EAe+ZPz+yFX4q6Stut702nsq3ShrucHmHXZq7VTormcT3HoPx70VBf/tiLIAeX
Mt5fpg2v8NO5U1hjXPuJGfO6XHlSsw==
=A320
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--
