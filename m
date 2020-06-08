Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417EF1F17D4
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgFHL2n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 07:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgFHL2n (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Jun 2020 07:28:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06725206C3;
        Mon,  8 Jun 2020 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591615722;
        bh=YYeYKTubuK8uMi7Ksz+Evqk5yKQweEpTz0M3eAYB77A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSssz0ftDvak2V1jNm/rzjE+e3b8E5DOT4ArB6KH14YgxL9PCjBbkPYWE8eSyESxe
         HepGmVKPZIJj9kL9YwUIaPoveXgvhY9UdwnMctjrGkzYwv/Tu1YFc+cPW2+jw9jniL
         oEXhLw2diniklq+QavDjLkejFy7X/SGrDRlF51yI=
Date:   Mon, 8 Jun 2020 12:28:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, lukas@wunner.de,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200608112840.GC4593@sirena.org.uk>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
 <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2020 at 12:11:11PM +0100, Robin Murphy wrote:

> Again, 2 cycles. The overhead of a static key alone is at least 50% of that.
> And that's not even considering whether the change in code layout caused by
> doubling up the IRQ handler might affect I-cache or branch predictor
> behaviour, where a single miss stands to more than wipe out any perceived
> saving. And all in code that has at least one obvious inefficiency left on
> the table either way.

> This thread truly epitomises Knuth's "premature optimisation" quote... ;)

In fairness the main reason this driver is so heavily tuned already (and
has lead to some really nice improvements in the core) is that there are
a number of users hitting 100% CPU utilization driving SPI devices on
some of the older RPi hardware, IIRC around IIO type applications
mostly.  I do tend to agree that this particular optimization is a bit
marginal but there has been a lot of effort put into this.

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7eIOcACgkQJNaLcl1U
h9De6wf9HKTAjmkja1i1t3bz0jmsUYY8xaAjvc0kqwlkowJdSjfUHX/0ahbBtdkn
2/kzIAPvx4B0oTHNyL3hNwMWo8hEGNhRQXwZeJjeR2MJREW6qqOXooWyFCDMJq/z
R1W/rcSbLvGORXBiiFFhpBLEiY5rRRTZXNqw4An12tduk05ZOmpqVdKvCal0i48B
UZ0u1AIdNOmauU8JnlhygidT3ErLH4EIFirK04AhVs8ZFVmKOvfTWzHR/zUXHzdD
MWXKAFJcfcywFnWlqq4yeRpPFbu+c7/Ko4MJZNSpEViAzDUo7wy5SyDP4mXmC+tI
BB0LR91M/J64eJtjSEN8MMW3rGEzwQ==
=CMzm
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
