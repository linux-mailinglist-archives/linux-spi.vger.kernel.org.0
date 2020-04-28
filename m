Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950D11BC77C
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgD1SHX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 14:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgD1SHX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 14:07:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D05206A1;
        Tue, 28 Apr 2020 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588097242;
        bh=6Q6rZsQKt3VbM5vsorruYmknW9KDG4BhASuWxBjwPps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2YmrdxTyFXsLPz3KoKzlB5aMEhzBWJUyFz9KQ206ampsbEYlXj73HWwL2v/8k7aS
         F6a1PD3oQdwDZb4asZS5W7G/Fk2ujh/pYI+s9155m0v2CtQONf8YxE+hYNpS5fgnp0
         +zyjD00XiMMQLgdVF1W7Dy4RzHYCrCuxhA/LxXKE=
Date:   Tue, 28 Apr 2020 19:07:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/7] spi: dw: Add support for Intel Keem Bay SPI
Message-ID: <20200428180720.GO5677@sirena.org.uk>
References: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200428141449.GV185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RHdRtM27np9fZUoh"
Content-Disposition: inline
In-Reply-To: <20200428141449.GV185537@smile.fi.intel.com>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RHdRtM27np9fZUoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 05:14:49PM +0300, Andy Shevchenko wrote:

> Rob, can we get your Ack if everything is okay, please?

> I have more patches coming to this driver and I would not like to delay this
> series to be applied.

If there are problems with the DT binding conversion it'd be good to
make sure the next version of the series that moves it to the last patch
so the rest of the series isn't blocked on it.

--RHdRtM27np9fZUoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6ocNcACgkQJNaLcl1U
h9A66Qf/cMqeJIlT91QLvY9dPiqnO1A10PHzEQwAtrdnlQ+90vx1tk7LFDWma9ju
Z4mQoYt+c9hli2iykz3Cv/ch93D5x4//GckKbZQlpnfnB1DQ3Zy0Ta6CTnxgpr66
bINssfFcMX35TPNgVxTo54EdHXgDSC3aBQrMz8mIg8LdJ+Abc8EaqoYoPpSr3x7w
Gz8CswZfKFTAB8o0L1jYL4+ucui74ij2MA+SG0jkiF9OPkaj996Er8aCwro7SY4F
fOxl1jjHi4Rq3FmYazj+U5Pqa8z/TYQQeKunF20T1CXrhH3XMtAY9wUU27QS8OLr
FlwPxbVl1bjGFKJbqwHlX89WHqcMDQ==
=FKgl
-----END PGP SIGNATURE-----

--RHdRtM27np9fZUoh--
