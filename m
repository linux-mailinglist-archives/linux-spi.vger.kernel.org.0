Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E05421151
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 16:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhJDOcB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 10:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233516AbhJDOcA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Oct 2021 10:32:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BFA461360;
        Mon,  4 Oct 2021 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633357811;
        bh=EpLJKvVl++4glyuBcs3wE3A5VpNDxBX0i+l17VgYCuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNgFBq7ByvflYkQvJ87rS9YNAzW/yLSQjGOBh/SlzHg+bsThXpoThzFSYgfBIsC4w
         335FUOhi9JRK2K8+4aC+OjNm0fRZ1ZdSTuVOa8dGlfmxEyFYYMaxmEJoCSFMIlbtSq
         i889zQ26ELqmTS7S+3Zc8nrBYgjuQV8KXxtEYK8bbYyQEWJctcrM02KCBz4dwuEMaQ
         VI0jmBX21372yH9n4Y3FpKc9RSrrMBUCFl8nZ/tvmHJGU6siSis9CyFzBAD8Jhf8hV
         ZeL5pgT4umbhDVOwEz0GsaAaz3Q72YLTjvt2UOc9VMdUL1G1Uit0O8XdE/zmeeXFcJ
         B+zKghuVu5HUg==
Date:   Mon, 4 Oct 2021 15:30:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <YVsP8KpJqISGw7jk@sirena.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
 <871r5j6nlw.fsf@igel.home>
 <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
 <87wnna6hdc.fsf@igel.home>
 <CAHk-=wi7DB2SJ-wngVvsJ7Ak2cM556Q8437sOXo4EJt2BWPdEg@mail.gmail.com>
 <mvmlf38ubz1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoZ+3G89DQrRlSoB"
Content-Disposition: inline
In-Reply-To: <mvmlf38ubz1.fsf@suse.de>
X-Cookie: If it heals good, say it.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZoZ+3G89DQrRlSoB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 04, 2021 at 04:00:02PM +0200, Andreas Schwab wrote:
> On Sep 20 2021, Linus Torvalds wrote:

> > That is why the regression rule exists. It is NOT ACCEPTABLE to fix
> > one thing, and break another. That's not a fix at all. That's a
> > regression, and no amount of "but but but it fixes something else" is
> > valid.

> That regression has now landed in -stable.

Like I said previously please stop this, it is not helping and just
taking time away from people actually working constructively on the
problem:

   https://lore.kernel.org/linux-spi/20210921122228.GB9990@sirena.org.uk/

--ZoZ+3G89DQrRlSoB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFbD+8ACgkQJNaLcl1U
h9BlAgf+NIVwZecw3P7SPB3r8v1YDvvW3uu8wEr9XCOhwUTyAuCwQI6lm4zs5xzw
1hiqU5/KPe0wfAlgF4q/LDOu4BJDmmDJUKWGUh09KkOiBp6JrYp1UfiMFLr2ggYO
2882h2dkm6+OVbj0h3I8EgCHeux4z3JmnyRzbhzfrS5gut9VOrudSLosgO8SLwVm
093lMGJdIxdtI9dHQEXgtrxuqDgr8CIW670DELTnNKTl/w+BK1b3pfl5jUH/Q5Kk
Exnfy+Kl74l3O1oz2/+7SOb0Ie+Iu/wwWC9IVuJbN41KpYmPAm511NPck9OXQmdi
iwPbR7rg1X+XgKoSm26wFC56dHvJVg==
=3SeT
-----END PGP SIGNATURE-----

--ZoZ+3G89DQrRlSoB--
