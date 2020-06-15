Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57C11F9E77
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 19:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgFORar (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 13:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgFORaq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 13:30:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5E67207DA;
        Mon, 15 Jun 2020 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592242246;
        bh=zjfjIr28wp7lz1LzhG/6HN/tE1zYdIy5YMG1lFm5t3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbiOeSJ5hsV6hDsh+iuN2Phq6hYAF5UJ44P9QG4f+TFAQCtZ64BlSAiZYOQpulXiK
         67EgWWNfvy/lMMgh8iWjub0lDsZ+oJADxAMCsvwN6/9PXWGWHMOCffBDH1fAQ2ccWu
         cq3OE58P8henl7vX0sG5AOeHjm9kUWZlb5TbeQWU=
Date:   Mon, 15 Jun 2020 18:30:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, lukas@wunner.de,
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
Message-ID: <20200615173043.GB4447@sirena.org.uk>
References: <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
 <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
 <20200608112840.GC4593@sirena.org.uk>
 <bb9dbf11-9e33-df60-f5ae-f7fdfe8458b4@gmail.com>
 <20200615170031.GA4447@sirena.org.uk>
 <692bc94e-d574-e07a-d834-c0d569e87bba@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t8N2qprAjL+0GVly"
Content-Disposition: inline
In-Reply-To: <692bc94e-d574-e07a-d834-c0d569e87bba@gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--t8N2qprAjL+0GVly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 10:04:46AM -0700, Florian Fainelli wrote:

> OK, how about I send you an increment patch (would a fixup be okay?)
> that adds __always_inline since we know from this thread that some
> compilers may mis-optimize the function inlining?

That's fine for me.

--t8N2qprAjL+0GVly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nsEIACgkQJNaLcl1U
h9DSkAf+I43C4D+5MeXey+DqEhoeIq/jqtEbSPUS6Liq/5dDiTCy2KeFvsYZ5v46
Cvvn7ou6wPLdnXrPMiMdEl38cJzJfNAv7d3ydsMBlvAGRo6+3noBPoAU9k/gWDAd
ZE9v3hNFw65ZI4XUK0+SsSOrXGIW9405DEUkKvstmqE8VHyvlSwtAyztcjBJubAj
M14yKL96sow3/AUJ06Tay2iZK6k6n8VgDTy+/3AmXhX9hrw3jrE2VWYJCan9lhkZ
64cvvmhjLHeuSa3XVtVk/+qE59QwOk9fkdIOcIgWsjL21/udkyHSNJsaWLdk5dy1
1TdbguW5djIMdY6+QrNrDDQKtVU27A==
=gAli
-----END PGP SIGNATURE-----

--t8N2qprAjL+0GVly--
