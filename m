Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65238216B62
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 13:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGGLVu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 07:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGLVt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Jul 2020 07:21:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533D3206CD;
        Tue,  7 Jul 2020 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594120908;
        bh=LCXyDHmTACa91oTt6HIAuKnB5ZBvshX1CUGP0YfokcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf0k8NwYKTwSPgXD/+u13NKY+MI2lSJc8Dhy8uBT0QGrOsRZxpiEENGd6VwYuaAP4
         Og+T5dw06LVk8ngqh4ov/N1211OKU08qIk/GQjjKrjFdlJ2vNWCSCyWvA5VH31wfcI
         HyakBUEcls7b0cFcLewMalppZAuDtY+WrInb7wVc=
Date:   Tue, 7 Jul 2020 12:21:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de,
        kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: Add the SPI daisy chain support.
Message-ID: <20200707112144.GH4870@sirena.org.uk>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706161810.GB6176@sirena.org.uk>
 <0072bb03-d6ec-38b8-0c31-61571b77bf93@fastree3d.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <0072bb03-d6ec-38b8-0c31-61571b77bf93@fastree3d.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2020 at 12:53:38PM +0200, Adrian Fiergolski wrote:
> On 06.07.2020=A018:18, Mark Brown wrote:
> > On Mon, Jul 06, 2020 at 11:22:43AM +0200, Adrian Fiergolski wrote:

> > this.  Perhaps this needs to be a library for devices that can daisy
> > chain?  It does feel like the instances should be aware of each other
> > since half the point with building the hardware like this is that it
> > enables operations on multiple devices to happen in sync.

> Well, I assume that one can connect completely different SPI devices on
> a single daisy chain. In order to address all devices in a single
> access, a controller would need to delay a transaction, wait for a
> certain moment (how long?), synchronise and then transfer the message. I
> think it adds unnecessary complexity, as MHO many engineers' issue at

I'd imagine something more like regmap's explicit management with
pausing and unpausing transactions (indeed regmap might be a good
mechanism for this for devices with a register map) would not be that
cumbersome to use.  Pause, set the desired target state and then sync
that state out to the hardware.  This isn't something that can sensibly
be done at the controller level, the devices do need to be aware of
what's going on, which is why I'm saying that there's a need for the
devices to be aware of things.

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8EWscACgkQJNaLcl1U
h9C9CAf/RCKRB0Hy7tmjHtb+eFWn8xEg0QykkkMX2+o03ZcMFdr81ycG2RWsJADv
Rj64p7v42qb4f7xhn2HTNpbxV+kLasRIUWJmAloPPhLomUzxHP3NStyqaRf0Ts+G
lvDA4oDzYAulv7SO03//M9p4qv4P2xAXKRKpO7O8YYWU5sx8r7OssJZhUdyEnqLG
l/EMPP/nRXODodaQiMz60ZtDUb6hmIGYhKeI3tCFiatjFhGb9vKZSQdiInNlZLI8
mYldBLQQe1cGpOaEI5BHt/KyJSDLkmHjVK1lyczD+1ksSY0OZpHjAxAoeHDexNpq
hd9q0OOhSNO6Cz9o0+B/MOd7nYMY2Q==
=in23
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
