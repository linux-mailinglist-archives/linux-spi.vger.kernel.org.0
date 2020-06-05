Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E9B1EF556
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFEK3A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 06:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgFEK27 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Jun 2020 06:28:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37ABC2074B;
        Fri,  5 Jun 2020 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591352938;
        bh=yVCgfIlqCzi+uxjyo1zLQ98C29QSMhFXMCE8J+smxzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UM8OrjMXAVHbcSwvCYTfQDj36kyTpdwaC9wenIPr85WsEQYQcCDaaxBmNEXNkxKgx
         dzmVHYOYm06xJNMWYZaCgfbeJkZ+cZc8ulSvs4+sQTHYK+Hd+2G7odslRiKHcXPBbT
         6OmM2mF0tvQgFrf0GpONLnjjojvObsNAG0LOl3Bw=
Date:   Fri, 5 Jun 2020 11:28:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
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
        Martin Sperl <kernel@martin.sperl.org>, lukas@wunner.de
Subject: Re: [PATCH 3/3] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200605102856.GB5413@sirena.org.uk>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-4-f.fainelli@gmail.com>
 <20200604123220.GD6644@sirena.org.uk>
 <21772111-fa1f-7a50-aa92-e44b09cff4eb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <21772111-fa1f-7a50-aa92-e44b09cff4eb@gmail.com>
X-Cookie: Air is water with holes in it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2020 at 09:05:46AM -0700, Florian Fainelli wrote:
> On 6/4/2020 5:32 AM, Mark Brown wrote:

> > This feels hacky - it's essentially using the compatible string to set a
> > boolean flag which isn't really about the IP but rather the platform
> > integration.  It might cause problems if we do end up having to quirk
> > this version of the IP for some other reason.

> I am not sure why it would be a problem, when you describe a piece of
> hardware with Device Tree, even with the IP block being strictly the
> same, its very integration into a new SoC (with details like shared
> interrupt lines) do warrant a different compatible string. Maybe this is
> more of a philosophical question.

The big concern here is trying to support things going forwards - if it
turns out that any quirks are required by this version of the IP then it
gets very confusing and hard to keep DTs stable if you've already
quirked something that clearly isn't the IP version with the compatible
string.  Conversely if we start putting flags into the binding for every
feature that might be changed in a given IP that gets complex as we
can't ever learn new things about an existing IP version without
updating all the DTs which is also bad.

> Instead of counting the number of SPI devices we culd request the
> interrupt first with flags = IRQF_PROBE_SHARED, if this works, good we
> have a single SPI master enabled, if it returns -EBUSY, try again with
> flags = IRQF_SHARED and set-up the bcm2835_spi_sh_interrupt interrupt
> handler to manage the sharing.

Like you said in a followup patch that doesn't work as the first device
to probe will think the interrupt isn't shared.  You'd need a callback
to change to shared mode from genirq which feels...  inelegant.

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aHmcACgkQJNaLcl1U
h9Cibwf/c8EkXuOornxa8rgJTVll6CNfZJosZy2JB/9uRxBsBkr+C0AmOA5gLJ0G
/blupLSwZR6QOO5HP8QR29piU1V1gXX3/zQcDnz7HtTDrD3q+SSJADKu9rMvXrMW
/FeddfnOo2o2P62qopKisrQS3tK6sRQxm/hlqCCa8lHWfDZ10Iuow00sUAnI1x9h
4OG1erLcr9L5tJtAWvyvbtL75yHNJl7Dbsvwz0I0+NFMLu9etTbQ4OXtwIiab6Xu
LlkhofTCHh9B3yD/Fh8RmRZNJUwcXUmjwMBbIAdITglUNtDMiJaZtxUrn25V4PiJ
UKlz+CR4Hi2Me0h1JgY79Xnam2hf9w==
=Pvqk
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
