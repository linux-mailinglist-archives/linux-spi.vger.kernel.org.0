Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C83AA47E
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jun 2021 21:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhFPTqP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Jun 2021 15:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFPTqO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 16 Jun 2021 15:46:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC41861351;
        Wed, 16 Jun 2021 19:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623872648;
        bh=j9ynxHknBJ126O20yV9NCtBHpuMMSFHd+6cOx4bbSvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACVfc4MqIA2RzJDX3sLe7G5tBj6Sov2YBNJsDg2lvVsRT+yAZMeT40lFaoCtgoNJx
         vuDdAfw7oQN6V7WBCwRrUUZs+AO8jqawrEI0m/TE64fEGhX3cWI5wmPwl8TNkvgP+c
         Bhu8Wjg7IAiTRzbfTYhOX8mt7lS9xv5uCNGx5MV+zVX2c7UkZ+zMCQZekHhBT/XUO1
         1CbITT3eXbQAwkmSSeNaCIRQaLTfaUzHCVyJO5MPMUZ2gkQRMjtiYlgAuFcQvJVo6d
         UXtvCvHJ11x2bpotNSXftgldi+ceLNNehQnp44vW2JwRqT43UBv8OD1obmmAbOR5Mq
         71YgHfoNXxmaw==
Date:   Wed, 16 Jun 2021 20:43:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spidev: add platform driver support
Message-ID: <20210616194347.GC6418@sirena.org.uk>
References: <20210527084531.18989-1-christian.gmeiner@gmail.com>
 <CAH9NwWfh9-2+kLoTXJgkVSStb1cHHvC-He5jnfFxMpUngMeAtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <CAH9NwWfh9-2+kLoTXJgkVSStb1cHHvC-He5jnfFxMpUngMeAtA@mail.gmail.com>
X-Cookie: Revenge is a form of nostalgia.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 09:16:44PM +0200, Christian Gmeiner wrote:

> ping

I replied to your mail some time ago...

Also:

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDKVHMACgkQJNaLcl1U
h9CgAwf/SZkO/HjNIFM/RidhIxoBxxnQ5kxHSzWhR3ugDNQOg+JG7VY6A/62iTeD
KdkG61J60c1sA2ZxJvSofEUSaylCtkq64ZTh6Uq7LNA5rdTdDdIrafiIpmx7MjEa
eQ3qT9nb5iYQU9z0zR+x5SMD/jtbBCV0hohY+8jDNX9VTqEoYtNBIFEdwjkdyFJ4
FflFhCSCfAX7Ac3V/vtiEo4Fajz2E4Gf+7xv1rio1W1PG/3IgGa0FneGkrytKgKz
bsVGozjSr/6E4fUChAhR8Hn2vynfN5rKQJflUv11ardfGbPkMTVvyt81GkiSWxhC
TGiz/phMGKzZVP+/S8KI13XVjU+BXA==
=8tlc
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
