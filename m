Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0410E35DF5E
	for <lists+linux-spi@lfdr.de>; Tue, 13 Apr 2021 14:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbhDMMu7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Apr 2021 08:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345982AbhDMMsG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Apr 2021 08:48:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B397611CE;
        Tue, 13 Apr 2021 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618318056;
        bh=eOCfE3+OtnGfsXGCyWIZXUukmSHv96xSbyeoVM3rwOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbrsXmK0TNkHLA9+POErBtGIqqZRcNZot0uN1p62q223nZKm0hOeKmKjkBs5EqYPe
         RD5+ALAmrXBWutUky+ngOlZi8aqwLb1FRLz1FZ5VHRvC1ruH6dJKfJeWlVAJu0ZueP
         guwJBsl7fohRQ+/i63FoIhICrVv551uAxclr5i1mHTjFsAZj5vHQ5/ff/9n7kdzyv3
         n5h4WkJEQa/xzBya3V2wpAD4KgLuNSm70CneIkmlb75sfBMbJEEI806I6yK5oOCvWL
         NicKz4YtipTCk98GeodkOIP+pirKeFZxoxHBuadYsD+YYyeqQpcUZHSV+wnIZZocUX
         SaXiVx9YxAOjw==
Date:   Tue, 13 Apr 2021 13:47:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jay Fang <f.fangjian@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: SPI_HISI_KUNPENG should depend on ARCH_HISI
Message-ID: <20210413124715.GE5586@sirena.org.uk>
References: <d93934dfdbb4d35e35371517de3b64c144aeb5ef.1618316782.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
In-Reply-To: <d93934dfdbb4d35e35371517de3b64c144aeb5ef.1618316782.git.geert+renesas@glider.be>
X-Cookie: Shake well before using.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2021 at 02:27:23PM +0200, Geert Uytterhoeven wrote:
> The HiSilicon Kunpeng SPI controller is only present on HiSilicon
> Kunpeng SoCs.  Hence add a dependency on ARCH_HISI, to prevent asking
> the user about this driver when configuring a kernel without Hisilicon
> platform support.

Are you *sure* about this?  HiSilicon produce a wide range of SoCs with
very diverse target markets, this driver looks like it's for enterprise
stuff while most things guarded by that config option look like they're
for embedded applications.

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB1ktIACgkQJNaLcl1U
h9ASfgf/WsTNq06NA9Wh5kac9lvI9OF3CYRGevaUxGMVLnjIJaGGU+A0xUuWXqWg
j1k5pZDaQOOnNsJWd/gAajQhkuN81unRHcZ8Vn0fFuXfYofkLidYFHrZGQ8uGi71
kQc+AuC0vgy2MYqSgb6NYY7mR99EoWsYMGs+xzhLvRwofoyq4NVogwAgodgKn6hw
ZmWeMAw4wS01m8bL1Cw89vNV2LM88L5ZT1LV9FEFgGieImOZipWyvi29VmFc8/AT
o6wuGyGnwOyLJ1oxKulFds2suOWsTiJmQTkEHSldU6dyx1EmEanfzpNDH77SCfYM
jWMStyHChfx+zH01/3PH7yYFRRNd6w==
=23nh
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
