Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C92BB140
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgKTRSK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Nov 2020 12:18:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKTRSK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Nov 2020 12:18:10 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E1822252;
        Fri, 20 Nov 2020 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605892689;
        bh=uy+51xeLLzq1vXGE7LGJb4vNbh6FZc0ca+/BpSaUnJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzOH+qDooBkM+qvyFtDXceRJ1uL8IxPw/J70qTrL7zQrK29OIKZBH7oM6az5lypL7
         jd3ZlMeuno8YVqrLgLffY6Ui4owRy524YZhVa7lW1GJJOgrvMhBGU6mrjy/vlcieZo
         iUem9dXye8RjtpAWFLrCcSs8Wn556NVCn8dNnurE=
Date:   Fri, 20 Nov 2020 17:17:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
Message-ID: <20201120171629.GH6751@sirena.org.uk>
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
In-Reply-To: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2020 at 12:45:17PM +0300, Serge Semin wrote:

> Of course I could have provided a fix affecting the DW APB SSI driver
> only, for instance, by creating a mutual exclusive access to the set_cs
> callback and setting/clearing only the bit responsible for the
> corresponding chip-select. But after a short research I've discovered that

I think the driver needs a fix anyway for the case where there's a mix
of devices with standard and inverted chip selects, it assumes they all
have the same polarity AFAICT.

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+3+jsACgkQJNaLcl1U
h9BwLgf+Lis0gdGmaCp6BXLmrpL/5yxKSuQ4g3xHQigJuLJyrPf4GoaQSMv34u1z
rGowoRkVYkjpfeqtFAG9ns/ozKKdVJkgcycEWl/KZI6Gia7COUdlNHHaiJaSeDQk
qqTbB4ZoDVrSRqd7tE6hAurM18DxwY5fFYEvN39XOZEakqMeqgQ8x9+iwe59VPsw
bwJV0FzAIPnCx/AbdIaU+FA6LTJpSJp1dWzzVW+tvxXkeEpBgVAHMOdSc8LwnkiS
szD4KAaR3VRvQ3rjunaXQlJPVctdIhPnknVEFnZKDwaQIBlmoyvy0By1CZ3+woMZ
Ogq5RaosPg+EOYnY3K0VFUFShzSd4w==
=YaE4
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--
