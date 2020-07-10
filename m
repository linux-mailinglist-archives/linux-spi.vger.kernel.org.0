Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDEA21B9A3
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJPfh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jul 2020 11:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJPfh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jul 2020 11:35:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F9E20725;
        Fri, 10 Jul 2020 15:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594395336;
        bh=gI3yEGsGyMaUOOnDy+UZFfrMEPrpJsahOsnjo0T8Coc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HLdx85blFvC788EU5GISpD8YvLXgUcUqFLh1FxvQIhJA12/km9XIFkEF3IXMXm2P
         nsw8XESdyQSCcinvt3Aq6Moa/pDJO2nANG7PoXscm0YfNnjvrNSGS9JuyXQk+dUxWG
         4BKm0M/Zfk5CDuyE0QEo0tTk8dRS76QzbWH4m4jk=
Date:   Fri, 10 Jul 2020 16:35:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shreyas Joshi <shreyas.joshi@biamp.com>
Cc:     linux-spi@vger.kernel.org, shreyasjoshi15@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-cadence: add support for chip select high
Message-ID: <20200710153530.GA46888@sirena.org.uk>
References: <20200710045140.458-1-shreyas.joshi@biamp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200710045140.458-1-shreyas.joshi@biamp.com>
X-Cookie: Do clones have navels?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2020 at 02:51:40PM +1000, Shreyas Joshi wrote:

> spi cadence driver should support spi-cs-high in mode bits
> so that the peripherals that needs the chip select to be high active can
> use it. Add the SPI-CS-HIGH flag in the supported mode bits.

This doesn't apply against current code, please check and resend:

HEAD is now at 3ea4eac3e29f SPI SUBSYSTEM: Replace HTTP links with HTTPS ones
Applying: spi: spi-cadence: add support for chip select high
error: corrupt patch at line 18
error: could not build fake ancestor
Patch failed at 0001 spi: spi-cadence: add support for chip select high

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8IisIACgkQJNaLcl1U
h9DBxwf/SNduPQaFfCuvDvvx11pYNTr1Jepbd3k5HKVQ+kEu7WG40id0/bBfbnFg
apY8ORg1zqSq4Q1zogVp42+OnQ0qVrKOIYPEAXr4ztDzA7pM0LfNdKtkon2ZBkJS
IJ6p0ic+/j4X4FTZddd/cNn6oFERL2Gjnoa0QD5MjRhlEufMyybvRZj1zGWWpcF+
hIXIEuKJrrUzyF2BCVHnmdr9Bn2jqcMsIVXc8Mm5VDdHSTyax0V8TxSlttKmnBLa
LoXyvqRE4T3hF/WmOHswjhlXaZKNVhkw1O5mzkyUun5mAya9wtmtrU1QXqGvv1P7
f8nmdDKKnccShhOjafcjckrcH2Uwiw==
=NRw/
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
