Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A23A412801
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 23:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbhITV3E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 17:29:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbhITV1E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 17:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+ysRS6BwtFliwWWXdpLn+rK5xPMPu+YNVJtZA6I0SgA=; b=u9uNsElK1Nquc6T+r2HCw8VELh
        LeHK07wIeRkD6cOUV6jMRo7Pzto2RFWSbfkbUrt1R6bUTa16bUhiZEVKQjzbQ7/zyD1QTWk8Y2QO1
        6q0xX8KzurZ9t6PrYMXee71o9MnpdXb0UCNfjOt5Fo69C0qlP0lmCdSicgoPJVjqXeQY=;
Received: from cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net ([92.233.91.117] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mSQn5-000eUM-1F; Mon, 20 Sep 2021 21:25:32 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 797FED0E9AC; Mon, 20 Sep 2021 22:25:31 +0100 (BST)
Date:   Mon, 20 Sep 2021 22:25:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Andreas Schwab <schwab@suse.de>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, robh@kernel.org
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <YUj8S5XIR5+EAk7e@sirena.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
 <20210920183327.GO4192@sirena.org.uk>
 <YUji89/msWkijl+9@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gGoaXWZrWVSRZdmh"
Content-Disposition: inline
In-Reply-To: <YUji89/msWkijl+9@shell.armlinux.org.uk>
X-Cookie: lisp, v.:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gGoaXWZrWVSRZdmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2021 at 08:37:23PM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 20, 2021 at 07:33:27PM +0100, Mark Brown wrote:
> > On Mon, Sep 20, 2021 at 11:20:29AM +0100, Russell King (Oracle) wrote:

> > Are you sure?  Looking at the binding document it appears that the
> > fallback to jedec,spi-nor is mandatory in all cases - it's either one of
> > the two items: cases both of which are lists with jedec,spi-nor in them
> > or just the plain jedec,spi-nor fallback.  It kind of doesn't matter
> > given that we weren't enforcing it in the past but still.

> We aren't even enforcing it today either - running the DT checker is
> entirely optional, and it's not even carried by distros, so across
> distro upgrades it breaks. I'd also suggest that almost no one bothers
> to run it either, looking at the almost 6700 lines of output it
> produces for my build - the chances of spotting anything relevant in
> that are practically zero.

Right, good - my read of the DT binding document was correct at
least.  Like we're both saying it doesn't really matter what was
documented, what we were accepting is what matters.

> because, although the driver accepts devices of type "w25q32", it
> isn't listed in the DT schema. However, the driver code itself
> accepts that "w25q32" is used in DT - so the schema is out of step
> with the driver and has been for ages.

Looks like it's trying to list it but not quite managing.
Another thing to fix...

> > This then causes issues for anything trying to bind based with DT
> > aliases AIUI so it's just pushing the problems around to different
> > devices.  I think ideally we should be including the fallback compat IDs
> > that could also be matched along with the OF aliases.

> I have a different view. These patches have fixed one problem by
> creating another problem - they have _changed_ the module alias
> that SPI creates for DT.

> Originally, the module alias was created via of_modalias_node()
> in of_register_spi_device():

>         /* Select device driver */
>         rc =3D of_modalias_node(nc, spi->modalias,
>                                 sizeof(spi->modalias));
>         if (rc < 0) {
>                 dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc=
);
>                 goto err_out;
>         }

> However, as a result of the above two commits, the modalias that
> is now given to userspace has changed from whatever
> of_modalias_node() produced to whatever of_device_modalias() and
> of_device_uevent_modalias() produces - which is something quite
> different.

> So, IMHO the change in these two patches was _wrong_ and always
> was wrong, and was always going to lead to this problem. Randomly
> deciding to have a different modalias policy is always going to
> lead to problems like this.

Hrm, right - I hadn't really registered that we were generating
compat modaliases in quite that way (and hadn't had the bandwidth
to dig into that properly today, should do tomorrow).  First pass
I'd think that either SPI or probably of_device_uevent_modalias()
ought to be generating both formats (assuming we can list
multiple modaliases which I'm not sure on) but like I say I've
really not dug into this properly yet at this point.

I'm reasonably sure we should be continuing to generate the old
style modalises like a revert would, my main questions are if we
can arrange to provide both types so that anything that won't
match on the compat type can also work, and if there's any
fallout that needs fixing up if we can't and end up doing the
revert.

> > That doesn't seem particularly hard TBH, and if we're going to be
> > listing any compatibles we really ought to be including them all rather
> > than just a random one.
>=20
> Looking at the shere number of combinations given the regexp in
> the DT binding document, I think someone would need to script its
> generation - expanding just the first set leads to:

=2E..

> And then you have a similar set for n25q*. Once all of that regexp
> has been expanded, one then needs to add the list for "backward
> compatibility" with all the different manufacturer prefixes that
> of_modalias_node() stripped off.

> Are you really sure this is a solution you wish to require?

It's true that the manufacturer prefixes blow stuff up for this
particular driver especially badly without wildcards which gets
messy...  the interaction between generic parts like flash and
the DT aliases definitely isn't at all nice at the minute, the
compat stuff is doing a good job of sidestepping some of the
explosion in compatibles.

--gGoaXWZrWVSRZdmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFI/EoACgkQJNaLcl1U
h9BpxQf/f+rBiqBAbnxs3U4zAm/4shjcla/3qK1IrpdNs4zGcRwXVuIrRGi22Y85
jvFGshExkFoQ7Q+E7amlw+pn9FibHiRq4GMM+9eUIfhFwLNX+REMNxq0ZXYwBhWW
PYEPgVf8wTU8s0/z/8V6s3NrAguTB1CZuYrETo0RtXJC6aWRVcKgwgWu6GaQ5NAF
ekuFkzvOimvUb+BV/2IUImNjT/epPWCio9ypGm9XkzDXBJz/IG4JJ/e+A/Axrvwk
CmpqXGzcthZOVfWoNCqnQrkJdpvfCjCPelvCRApXnC4PoJbCyydzqfGcjxFCNVTy
2IbZKabOIQ3CHbu5kRROqtHVX784RQ==
=NvxZ
-----END PGP SIGNATURE-----

--gGoaXWZrWVSRZdmh--
