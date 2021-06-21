Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3413AE895
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhFUMC3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 08:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFUMC0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Jun 2021 08:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C031610CA;
        Mon, 21 Jun 2021 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624276812;
        bh=hfpF5xOMS9H+mOgIyytpQe4f0X93gYvcpEhuLJ+2E6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hK8BCx7OLrk4XbO4qSesVVQsa1DiDtsd8NgfkCq0dpk119zW7+Hx3dfbhXn8m9jbW
         k37H2z102KxGjFgr1kujcWnP4N7KUlgBB9w57vNYKbLPFDDXm9osNqDOPNOgL8+/6N
         qkU+2IZfVzsMe+MxKfC7jhJ5aOedK5kYPSFAAgFE3C9eQKIXUsWseBWbE2Oj0JWUBx
         4C+dfWreU1i7gmGGjObR+WJv+Uixeqdr2awZNzeb/ubZJdZIAxnXXNJFDeEqHp9NvJ
         UEXZqpYrSziYyZjNXKIfJAJC4ldsU3keLfsRoVZoU7DIfZhCsp/t4J/fVjynw7uk67
         L8nG0WOYz0ufg==
Date:   Mon, 21 Jun 2021 12:59:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Remove unneeded parentheses in spi_map_buf()
Message-ID: <20210621115950.GG4094@sirena.org.uk>
References: <20210619111526.27776-1-andriy.shevchenko@linux.intel.com>
 <20210621103923.GA4094@sirena.org.uk>
 <CAHp75Vc8CDRBKMiJNehsU2CUc4VVrWL9fHZO1rr7V7pZDg_QaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc8CDRBKMiJNehsU2CUc4VVrWL9fHZO1rr7V7pZDg_QaQ@mail.gmail.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2021 at 01:43:41PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 21, 2021 at 1:40 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Sat, Jun 19, 2021 at 02:15:26PM +0300, Andy Shevchenko wrote:
> > > The boolean expression to get kmap_buf is hard to read due to
> > > too many unneeded parentheses. Remove them for good.

> > > -     const bool kmap_buf = ((unsigned long)buf >= PKMAP_BASE &&
> > > -                             (unsigned long)buf < (PKMAP_BASE +
> > > -                                     (LAST_PKMAP * PAGE_SIZE)));
> > > +     const bool kmap_buf = (unsigned long)buf >= PKMAP_BASE &&
> > > +                           (unsigned long)buf < (PKMAP_BASE + LAST_PKMAP * PAGE_SIZE);

> > No, I think this makes things worse - to the extent there's an issue
> > here it's not excessive brackets.

> How? I can't see any issues here and dropping excessive brackets helps
> to read it better. For example, the exterior brackets do nothing
> except making it harder to read, i.e. the expression inside them is
> already type of boolean and I have no clue what they are for.

This is purely a taste thing.  I think the >= and && being the same
length and the second condition being visually distinct from the first
don't help here.

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDQfzUACgkQJNaLcl1U
h9DhVwf/WKFxLwC/YgJDfht0vbZ1qhStKfSJHoDEebWaS4Y3/1fI65LOGCej+Kvp
HH2F2GDv8P5erO6SdAq4NHD7CjCxxULupydvhdRhxL388e2OH9HxcGdfI1vyq6sk
YNljmUfDn7bB9RkpDtiToMg6juFbUUIG0LOmxo+0lboN+FhQxDPdA3kP1JB7tiCZ
jmBtQYAyWkJNrf/IRSRGWM1rvhCSfIjIMFCnYPbVojN5Cvu4i1jZFLI2z2RQ0fS3
HX3TSJTZ2gV9TRDao2WxncQgeLfqMOGjojSqL+bMcwSR3WPMZtTFNHgBPhltryW4
+atBb7k6i1DAMM9qZnwtHqliEEy+0A==
=fPFG
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--
