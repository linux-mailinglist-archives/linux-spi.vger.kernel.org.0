Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1E1EE646
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 16:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgFDOFO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 10:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgFDOFO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Jun 2020 10:05:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791F820738;
        Thu,  4 Jun 2020 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591279514;
        bh=Epk5WMtzALPNz+dltu72WrLGhF9VGMjphVrnc6COsEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sf7Hy+B1x7rYiLFDGpZcfyrckIXZn5Y1kIlUFPDPjdiiOSqQtrTMcxXb0oGyI9iLn
         8jCUl4YlcOzZKOCauoNq2XeYV6TUrG/h8/TnYezlbVFMIHtNSI9OXb0L7C8W5p2kFL
         tL+4fGnqSSpZVdGYrCnig3VUHI1yScvIB2HDtq+4=
Date:   Thu, 4 Jun 2020 15:05:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 2/3] ARM: dts: bcm2711: Update SPI nodes compatible
 strings
Message-ID: <20200604140511.GF6644@sirena.org.uk>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-3-f.fainelli@gmail.com>
 <20200604042038.jzolu6k7q3d6bsvq@wunner.de>
 <20200604111325.GC6644@sirena.org.uk>
 <20200604112112.b3k4wrftckndscu6@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <20200604112112.b3k4wrftckndscu6@wunner.de>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2020 at 01:21:12PM +0200, Lukas Wunner wrote:
> On Thu, Jun 04, 2020 at 12:13:25PM +0100, Mark Brown wrote:

> > Regardless of what's going on with the interrupts the compatible string
> > should reflect the IP version so unless for some reason someone taped
> > out two different versions of the IP it seems odd that the compatible
> > strings would vary within a given SoC.

> Hm.  I guess it may be possible to search the DT for other devices
> sharing the same interrupt line and thereby determine whether
> IRQF_SHARED is necessary.  The helper to perform this search could
> live in drivers/of/irq.c as I imagine it might be useful in general.

That's another option, yeah - it'd be DT specific but it seems neater
than a property and much more tractable than trying to dance around
doing this in genirq (where we'd end up with callbacks when the second
device registers or something else horrible).

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Y/5YACgkQJNaLcl1U
h9DPAwf/UjD04C156SRCI5cTBUUAOg/X61gumN+fuyVQkAPs8CeP4cmV4HjtuXG2
9LOnl4/Bdq17EjTvWg6+HAQvBa7i0pwE8ppy8gqcGiNqq+dn5+n9ZpcLvDea0tLX
h2jq4LUfR3X3OgnTILP69XeLpk/ePNcpFTRij3YMnGqoa8VnlXiqP45YLEgVp0LK
RHlYDfzgBy1NxyxckRk+emfSKseAHtWQjUz4P2zvyKUXl/tqW+Lwc/fGlfE3QfFu
Eo1q4X4V2DuX83TzbvM8VXdJ/Lu0V05gyeYoEcQU+7j8MGno+JpLRX9C2J6uXwG+
edz4Gd9KdV/56AJOMrKWO0i8BPznbQ==
=DHOU
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
