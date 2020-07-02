Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF59212751
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgGBPH2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 11:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgGBPH2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 11:07:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C24206B7;
        Thu,  2 Jul 2020 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593702448;
        bh=Q0FMYaPVSrA10wNzRKcnGhb/N+PbrVbZEAavjZJ3zr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIn9XCwWwgqKCymrYhlNVjTfIelcPlc19Gojsw5ejxUUCaOJMwoUh5e1VEpeWJLnX
         B9f+Sw4LKUJO7g3WscWaHrA/e5r715O15+yrov4QhxI6bI8M/dMptirEbfIlA7HepK
         kJYY31PmspumNmonmlN92CrI7dBxSIzAPFme40HE=
Date:   Thu, 2 Jul 2020 16:07:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
Message-ID: <20200702150725.GI4483@sirena.org.uk>
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svExV93C05KqedWb"
Content-Disposition: inline
In-Reply-To: <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--svExV93C05KqedWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2020 at 04:46:09PM +0200, Frieder Schrempf wrote:

> My intention is to use the spidev driver in the default board DT for an
> interface that is routed to an extension connector and has no dedicated
> slave device attached onboard. So users can attach sensors, etc. with
> userspace drivers without touching the kernel or DT.

The expected way of doing this is to describe whatever was attached via
DT when it's attached - the device is what has the compatible, not some
connector in the middle of the connection.  The way you've got things
set up if the device has a driver then they won't be able to instantiate
the driver.

--svExV93C05KqedWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl79+C0ACgkQJNaLcl1U
h9BXJAf+NE1knwGcyl+LclVgMTjUDqll94imUwZuKczsQY8MXZQotW6ujyrh03G6
gWg1/eVBISXw/QIZgyFQL59+USxj/8nlEwcMacEIRJgFgoZVedTkN/m76qcAemfV
z2fZpApk6Istwg98owGK8OkY67l5xbiDdRociNmDgID6TXdixZItsJokFPJIpwNq
yFK8KOvg4Jcy5Td9JW3rAdkeTQxsT4qidR0A8GpdPPkIRDk6prJi0BPPq84Dtz1a
9ZT9cwR6ePI0T1fY2+oFBd42wUmpi1E4IcboBBV+fIKk3XCIxg2d/NKCGlUxNrx6
FGMyQo+cqfsyYyCBCYXKp3qKIdI2nA==
=gUvE
-----END PGP SIGNATURE-----

--svExV93C05KqedWb--
