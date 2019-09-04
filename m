Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC8A88E9
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfIDOkE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 10:40:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34744 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbfIDOkE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Sep 2019 10:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=enb3Eyheh3ZkU2pw9T92ijFf5m2SU7dyW+9oN6nQ2aA=; b=oFA8lI/2MLZSL2jMQKCUNOcfF
        XetrvE8ySqtCDsZTPH+9NN/zpPSxY/TG1S4OO0GDQuWpfHDUZ/zfuWQ8LYe+pkAA+xR4ctz09hSK/
        +Y1eyPRBsTFTPh57qabVYjBQtU5LTICbC4jCLu9gOx4ChEN4/1Z8TB07anBun9+khziVg=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5WRV-00066D-LZ; Wed, 04 Sep 2019 14:39:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BD1A82742B45; Wed,  4 Sep 2019 15:39:28 +0100 (BST)
Date:   Wed, 4 Sep 2019 15:39:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com, eric@anholt.net,
        wahrenst@gmx.net, shc_work@mail.ru, agross@kernel.org,
        khilman@baylibre.com, matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org,
        Andi Shyti <andi@etezian.org>, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20190904143928.GB4348@sirena.co.uk>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
X-Cookie: Help fight continental drift.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2019 at 04:28:29PM +0200, Krzysztof Kozlowski wrote:
> On Wed, 4 Sep 2019 at 16:00, YueHaibing <yuehaibing@huawei.com> wrote:

> > Reported-by: Hulk Robot <hulkci@huawei.com>

> This tag does not look real... First of all where is the report?
> Second, it was reported by coccinelle.
> Reported-by should be use to give real credits.

I think it's reasonable, it's giving credit to the automated system
they've got running coccinelle (which they do mention in their commit
logs).  It doesn't really hurt anyone and lets people see their system
is finding stuff.

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1vzJ8ACgkQJNaLcl1U
h9C55Qf9ElRCnBTb/SuDEmM1YeY2Tw9dAMV0y2jsYTl6UYAcJqOg3iMhAjCNbAVd
K59JgRS+lKB/HrEidQ3L3QfwZfOPhtyOEY5BmhZekABU6SI9ggg6VPIg8jqkOFQw
8poyZkiuaDhdrDn5rfdOSLpAQ7wls/djlfQ+zeoD0EdoiF5dtadKphhA1dT5NuvV
szO9xfucbd5yuUBQuUPW3M5tTkXlfyN86C8I1NkgZ26Ozrz5IYHrr+Tmp8++LBUs
GheNNGndIR/W/3pgCevW340G3aEqQ0G34v9pk1/HOWYuwVS2S1jhaSl77YTk1wZ5
jDsHN8NDORkPvAnmKmyFVlA1Z3W17A==
=5oz7
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
