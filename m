Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B09BF5B5
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfIZPR6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 11:17:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfIZPR5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 11:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WG3KME36uGwnmNkDpJ7Cwc7H808xTEZgOi18tajCQPw=; b=QPpkRSVTGaDweroR6KJzhb/Jr
        41ejv9lx8KatS4zgnYS5Tt4vYyQPyR+ov1UwXmH3i2wxp4CG14mC6Rti6rICQI8XfiYJ0m4FaiPo8
        ZOeOIr5sbrTA5hOHR9lU9aeg4kBKuW+hXSKZr8m6ZPlZfyusSe1YYQe1mUiEyGhb3B5Lw=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDVWk-0003tw-J1; Thu, 26 Sep 2019 15:17:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B3924D02CFF; Thu, 26 Sep 2019 16:17:52 +0100 (BST)
Date:   Thu, 26 Sep 2019 08:17:52 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Message-ID: <20190926151752.GU2036@sirena.org.uk>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa>
 <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
 <20190926144342.327a3c66@jawa>
 <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
 <20190926160645.0a2623fa@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksG33M87StcVQX10"
Content-Disposition: inline
In-Reply-To: <20190926160645.0a2623fa@jawa>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ksG33M87StcVQX10
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 04:06:45PM +0200, Lukasz Majewski wrote:
> > On Thu, Sep 26, 2019 at 2:49 PM Lukasz Majewski <lukma@denx.de> wrote:

> > > The question is if we shall call the spi_slave_abort() when
> > > cleaning up spi after releasing last reference, or each time
> > > release callback is called ? =20

> > TBH, I don't know.  Is it realistic that there are multiple opens?

> I'm using on my setup only one test program to use /dev/spidevX.Y and
> /dev/spidevA.B (loopback with wired connection).

> However, you also shall be able to connect via ssh and run the same
> setup in parallel...

It doesn't seem entirely realistic, but I can imagine cases like
fork()/exec() where we end up with two copies of the file open
but end up immediately closing one.

> > That means the abort is called only for the last user.
> > And only if the underlying device still exists.  Which means that if
> > it has disappeared (how can that happen? spidev unbind?),

> In my case, I just disconnect some SPI signals and the test program
> just hangs. I do need to ctrl+c to stop it (or use timeout).=20

> From my debugging the .release callback is called each time the program
> is aborted (either with ctrl+c or timeout).

Should be on file close IIRC.

--ksG33M87StcVQX10
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2M1p8ACgkQJNaLcl1U
h9Bsuwf/TlamYDm91mr1XHOC0hjSttkgh7Ert2fFhfaEAohEeAJN0x/rC8/LkLHD
XovhNkcxgUTfwfmU3mvS29CPqI5+bweRlut92TYTwqz8rPFJC2l9XxlKOI7uQVlr
p5+A8L7oIJcgWEjtKezRGh8YWRKJJVRkwUe4LyX2TstNVXtXLxZAIdtf6pdQEfoU
amOsXhJEG0nCtvXh/aay47c/wqs1WGHVrfTtVmUSsWaE7uXC46aDlTJLeGC1pCQC
3Vd/ZHtnneCngsCCxXOzg6lxFXTshzjltHBzhR4qQXlCAg+LqyEAHS4u4+6BrySI
x4UI4SRNKp9gkxM42VwNXzxBv+1qAg==
=WTW0
-----END PGP SIGNATURE-----

--ksG33M87StcVQX10--
