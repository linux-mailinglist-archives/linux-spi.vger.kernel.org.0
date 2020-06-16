Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5570B1FAE25
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 12:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPKkE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 06:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPKj7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 06:39:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA0320786;
        Tue, 16 Jun 2020 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592303998;
        bh=7dldRWO7gGRPlZ/8sV26jPzle1h5yQEqABWokXqyW38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3YG0XKIGUKezsbFPu+LsttzfENLcVz6uOAgoe8u3j2JVe5uZvas/7wxHmBbu6K9t
         ALdsxYeae+Xo/DSQ0UB0LtxZzXhGyfjKzGlO9MCz7WZaFInHWsgW/aTqaIQ1kR92IS
         kp6WqPseGrtvHr9CykwXRzc0VOenTXqXbSlzpie0=
Date:   Tue, 16 Jun 2020 11:39:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/3] genirq: Do not test disabled IRQs with DEBUG_SHIRQ
Message-ID: <20200616103956.GL4447@sirena.org.uk>
References: <1592208439-17594-1-git-send-email-krzk@kernel.org>
 <1592208439-17594-3-git-send-email-krzk@kernel.org>
 <20200615120844.GL4447@sirena.org.uk>
 <CAJKOXPfEpLN9jS11WW367Na3Ukfi8p3urKDcJoafg9dHuCDSUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/0D4jGRsNl8cPNu/"
Content-Disposition: inline
In-Reply-To: <CAJKOXPfEpLN9jS11WW367Na3Ukfi8p3urKDcJoafg9dHuCDSUA@mail.gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/0D4jGRsNl8cPNu/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 12:11:17PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Jun 15, 2020 at 01:08:44PM +0100, Mark Brown wrote:
> > On Mon, Jun 15, 2020 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> > > Testing events during freeing of disabled shared interrupts
> > > (CONFIG_DEBUG_SHIRQ) leads to false positives.  The driver disabled
> > > interrupts on purpose to be sure that they will not fire during device
> > > removal.

> > Surely the whole issue with shared IRQs that's being tested for here is
> > that when the interrupt is shared some other device connected to the
> > same interrupt line may trigger an interrupt regardless of what's going
> > on with this device?

> Yes. However if that device disabled the interrupt, it should not be
> fired for other users. In such case the testing does not point to a
> real issue.

To be honest I'd say that if you're disabling a shared interrupt that's
a bit of an issue regardless of anything else that's going on, it'll
disrupt other devices connected to it.

--/0D4jGRsNl8cPNu/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ooXsACgkQJNaLcl1U
h9DoHgf+JwvDuPobncELlcEI/vWSGXCrDuPyH/+FJU0Ji63DjRavjk3dt7UI1UsD
m70QleSoyhqku2gmsEnWKgRz08Y3KD8XCX6L/LwqmB2GKuZLlV2qHdgr6UkJ1UQ1
XOF2w75Vip+CnBp6AlVuEGyJ9k32y6VGDXyAe8nkFZU1teHMEZ2BPv8ZwrtHIgjs
/Mq6GUrSDXYSWkDD1AhLBG+ZjuCWm/UBy5anxCbAcnlIADxHVfLLzL58CPtOYNpy
03RoSphUoITpHPlTssE5VGdByMnxY7116n0XbiCsP6+mVmm/KU9FpHwOYN5qmFWS
hFrkjmbsmqNIpLXjzKQBxAiyDk5G0g==
=x0XR
-----END PGP SIGNATURE-----

--/0D4jGRsNl8cPNu/--
