Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA752EBE2A
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAFNB6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 08:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbhAFNB5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 Jan 2021 08:01:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C865E22DD3;
        Wed,  6 Jan 2021 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609938077;
        bh=CD0iNCkpztEvHdJ9A3TiuhkWfAXCret5rxhU18dMqTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IofVltuY0CVBWHJW1asMas7R3/Bm45tY46e2QZ6OC92OVrCN+70ooD6xUYqS9Wgp+
         aPQug9AlybvtskczgP+yoXha02wiJ04z7VijsNI09D1ldTgFZ4a++GBLDTl/qTkOx+
         tazN2WqQolSqGGT58oR03fMXysjCcVw+VkMGtsvaia+4c25U4iO5TWxaItzk2MgRqy
         WhBEbDWnquEbRknQKIXm+w9VzhccZ+VGXtnxJwFCt5ntYFyzv70dVey6qAA5CBqVQC
         GCV0F1AqzhzM0YFs+w562/zdSVQQxDgEf88RT2oRHaVQh6RoaqcDDik3PtIqfvk71P
         DjFR7HtDxim2Q==
Date:   Wed, 6 Jan 2021 13:00:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: 5.11.0-rc1+: "Division by zero in kernel." when writing to spidev
Message-ID: <20210106130049.GC4752@sirena.org.uk>
References: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
X-Cookie: Happy feast of the pig!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06, 2021 at 09:55:45PM +0900, Vincent Pelletier wrote:
> Hello,
>=20
> I am somehow triggering a division by zero when writing to spidev
> (a pair of traces at the end of this email).

Please check with the latest SPI tree, there were some issues fixed
there that might be relevant.

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/1tIAACgkQJNaLcl1U
h9CtOAgAgaf8Apxu4mvVlFIm9Ku0otASgbipQ0P0BeTbeVrUnY7uHLrWzhWMZW1Q
zzExqdvCx2ivDeJ1jpt8oNGzTv14JVcvWvpZGhhIJlpuHPNqL3vVoNGwfl/pwflw
g51f4qJ99VDidBL+jRIGmCTaI3Wa8Lajtuif0pviCw1zHcZxYCQg85VE5YF9ch8y
Bq5vurV5yV4R2hLlIMzLz5Nroh6z9r9K2b8DFilVfe7mpNiQbFYSO5RQnguh8ElL
Tw51/o4x7eQghEU2DpHubl432b3q68+YQgbMZfz3exXhjzU+q1moIlhRJjpc+/em
l74IaBp65y7s+DwqNdvcdrNMgMiIYg==
=2zQq
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
