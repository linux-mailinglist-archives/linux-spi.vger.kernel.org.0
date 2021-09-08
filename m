Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7FD4039B3
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 14:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbhIHM0e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 08:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346096AbhIHM0d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Sep 2021 08:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 772306113D;
        Wed,  8 Sep 2021 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631103926;
        bh=Op1osRVlypqUXTNk2HB6kEqPziP17mPtU9hc97lcRR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sv4EvN2ILSEpoFKcksm9T2ctQc3iG1XtvCc36EauLX8meibXnkvhkwE+vBjRbHBy2
         zO0WGKC+L39GKaKX1yaKCLctXEkzF4XuTVzdrI4Cgpi9qgnaHS/+4eEiDxyz4kUwLA
         fl4VqoFJHlCDDyz/doRwLbwebFL5iyUnt3Qy/FlQ95qteW9xE1cBjEksNmJ5bZ22fQ
         6kR1S7Xp9w+vPlG8HxNU63VDtKE14+5R4jubcnH2ozuuBzSmaAi2nzhi7PTKR5fnk/
         g2vQcKOKMZeC6INgWK1hzC4+B+5DmACawdLqLqSk6Zl3eNbf+Rhe/xiUBxrgUC3uqs
         qHSnlFQfcYCSQ==
Date:   Wed, 8 Sep 2021 13:24:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Message-ID: <20210908122449.GC4112@sirena.org.uk>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210903185653.7vrfn4qfzvuiaiq2@ti.com>
 <CY4PR07MB275737A008CBB58C4B108D2FC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
 <20210908112113.smnwmayjb3jit3eg@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20210908112113.smnwmayjb3jit3eg@ti.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 08, 2021 at 04:51:15PM +0530, Pratyush Yadav wrote:

> But it would reduce performance by a lot, no? I think we should try to=20
> figure out how we can accomodate controllers like this before resorting=
=20
> to using the slower modes.

OTOH if it's going to be hard to figure out perhaps merging something
slower that works while we do so would be good - lets people use their
systems while things are figured out.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE4q5AACgkQJNaLcl1U
h9B6rgf/ZXheC5wT2g7JhNRwsbHSAEd9l4klCXXrduglacPawsSmO1rR+UJ0QBf8
6h4ilOO9l15mBopd46W6IjqMaiXV+hk8vIhe//DwLPQljJGIBq9U431RKINCrita
RIusPSjOXYLevo4HrBagjXXGXVr8h2tNsjtkHRnzfOnxeD5zB7dh8/gPSLbA+9gb
xwxNL+rINyJAdUzJ+MBzIWip4wz2JbL2hBay4s/mCijZhqlCaC2YRKWYORMqB3pu
9BPk2Mgyo9DmI/wE8ezSQMpMgIK/QNOEhv5w8EgCl4OocYN9dM83OFqBomsmyO7J
s/IaixQZq+npLtWBSy+6/Oqpf7coPQ==
=kewD
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
