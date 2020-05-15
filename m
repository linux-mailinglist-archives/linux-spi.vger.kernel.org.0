Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F11D5658
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 18:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgEOQmH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 12:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOQmH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 12:42:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67314206C0;
        Fri, 15 May 2020 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589560926;
        bh=wP6rN+0fcyq9AqNL4mJfVYCMurnxEiNZYbbiBjX71PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MB7fP4O+o4JDp6I9/D4xpNZ6udvmMRewLpl1ChMf7/zBU/GPuKsrl8ZKkHfAXglfM
         sOvN9Q9uzqwmnnn890ATCTtg9mN5JeR2MK+xIYNWsU0Yx8X7k98dWRrKjvuP7wz9pC
         +u3dLgL5MD1B8AKF9x0BoULoQpPL3/aKCaRK8v68=
Date:   Fri, 15 May 2020 17:42:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/19] spi: dw: Clear DMAC register when done or
 stopped
Message-ID: <20200515164203.GJ5066@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-4-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 01:47:42PM +0300, Serge Semin wrote:
> If DMAC register is left uncleared any further DMAless transfers
> may cause the DMAC hardware handshaking interface getting activated.

This and patch 4 look good as is but they don't apply against for-5.7
due to context changes in -next, unfortunately everyone seems to have
decided that now is the time to start working on this driver which makes
combinations of new work and fixes awkward.  I'm going to apply these
for 5.8 but it'd be good if you could send versions based on for-5.7 as
well so I can apply there - I can sort out the conflicts with 5.8.


--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+xloACgkQJNaLcl1U
h9ABrwf/WQm+mOxb45Hxt0ho5+NLAIHIGJtDEbVnzaKIAHrJ76Kzbfpw1etZeWdL
NFMGaUa7GJED/7kuBofBOtVn34ZIuNrtS0ljxoxka2Ajcz3nmXxshzzgC8PkiDMG
sCDtGqBikWu9Yy/GqD7y5BfrZ279aadvlln4JTM0PCAILyQ39kps+aliMjXeHsdc
UrSJjBUuMePJ9LDjKQ8vzzTmQkrxQ5rKYL7vvIFA6shq3Yn21unkO0UqFfNVRgSQ
jdwUSiSYndO+lwk2aHH2jHmrwpZMsdiDGCtNX9VAn6D2lYdYmhNKmWPUF0BqeIp9
5Zvi4BlaUwxZS+41vq5pOJaIEhH4BA==
=rfwh
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
