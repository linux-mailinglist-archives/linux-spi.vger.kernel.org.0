Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E484545A61A
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhKWO6u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 09:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhKWO6u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 09:58:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D89060551;
        Tue, 23 Nov 2021 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637679342;
        bh=8vC6pff78pFsqEuzbrQ19ANCo11e7crtOgTZriKASZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IfXSUeKh9NsKJcZ/gtVa73Kv8VoZZ6NpKSb0NKJychLbT+6L84EdzE05UDC9mq9Q4
         q3nT/9F3XcEshYf1+fbmMcDcFFx2cX0EzdL20aOsOq+n6jKtzZzVnAa0dZWXwF1+e3
         YwcVAN77oNadMEd4eGXeQK7j20nPXgxKWvSA1lvYNHOIZuCupPKrPzEZ8vmCKtIGrL
         w5ySJ03hnI/inCZiOxfXzStDsew1azGVak6Hir+o0eT51kKi+TOrqAAdih5D4gIYYD
         PMLG1hlx098ne0R8N7olJ1dILND1zUxnEOdqSnL+YnhLbwIjFVkMYW4PzQ6G6PhVjK
         Pe1mWe3PfW1CA==
Date:   Tue, 23 Nov 2021 14:55:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
Message-ID: <YZ0A6rrpDlN6e5Vh@sirena.org.uk>
References: <20211109225920.1158920-1-javierm@redhat.com>
 <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
 <YZaZpx7cudaAEGIP@sirena.org.uk>
 <20211119074015.kji2hzarevxgfl5l@pengutronix.de>
 <9b41eb05-a095-39af-8b76-a73fa2532e92@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YQShgxr84o7K4zMq"
Content-Disposition: inline
In-Reply-To: <9b41eb05-a095-39af-8b76-a73fa2532e92@redhat.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YQShgxr84o7K4zMq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 19, 2021 at 09:32:32AM +0100, Javier Martinez Canillas wrote:
> On 11/19/21 08:40, Uwe Kleine-K=F6nig wrote:

> > Not this affects also devices that use

> > 	compatible =3D "myvender,devicename", "spidev";

> This is indeed a corner case and I'm less sure what the kernel should do
> about it. I just learned now that of_device_is_compatible() return value

TBH I feel like that falls into the same bucket as any other uses of
spidev so I'm not overly worried.  Grepping around it looks like we have
no examples of this in tree, only a few plain spidevs in DTs for older
platforms that were most likely converted from board files and *probably*
aren't too relevant at this point.

> Or just consider DT nodes with a general "spidev" compatible string to
> also not be valid. I would lean towards this one I think.

Yes, I think so.  Your other options are worth exploring if it turns out
to be an issue but hopefully it's not.

--YQShgxr84o7K4zMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGdAOkACgkQJNaLcl1U
h9CmUwgAhniA0H/TIzFWYMVQyG6nGgsKv2HKt+Nzjp7suxKhjrewWR5R0TObXEQE
nBRbIs//N9FDHhujWkkwqqmH2Uk80MdxI/Cs3l/hAGrQOLrJt10kkJq/m9JoV0X9
O7woYtJAi5w9SXPxWk8b0Le1iIzL7B7CY1GJcqxQWjgeI/lBvNRzwf5omWJUht/a
N/puXkHLjf3gtYbKoS06Gl9AXMD17oFqjRId7EYpZUolqrQCwE76IY7y8e4bsqlq
/552Q+9sXdArS3sTwt96ZdgDqafs7dEUeg0S03Gytb567BwfjFBpA/dh04s1r7iK
hT8NFyqBMa6kW67SxaChgCrMZ5wrmA==
=ek2y
-----END PGP SIGNATURE-----

--YQShgxr84o7K4zMq--
