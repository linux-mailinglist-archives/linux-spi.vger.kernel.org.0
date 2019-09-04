Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81AA8C85
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 21:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfIDQOT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 12:14:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732481AbfIDQOS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Sep 2019 12:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1EyANVYB8OYlB3yXu3/GSCY+3MXUWjqGnAuH+zG2V+8=; b=oeJSTcdIDcOk3Y6i6oSHYnqaK
        mbpR6uQLQflGkucJXLK1X+2eg2NvuIzkQ2cgHhhXiK+gq+r57luFLU1d+pYjzappehwqj8iyH2FRH
        3UVBQP5H5gwc2TmttChlxUCjhqE0xghi0XAtJFdsAa7iqj1fNovs+5a+x0opvYVUoIEAo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5Xun-0006R9-Ad; Wed, 04 Sep 2019 16:13:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 67FED2742B45; Wed,  4 Sep 2019 17:13:48 +0100 (BST)
Date:   Wed, 4 Sep 2019 17:13:48 +0100
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
Message-ID: <20190904161348.GE4348@sirena.co.uk>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
 <20190904143928.GB4348@sirena.co.uk>
 <CAJKOXPeRtbAvmR-=8Qa8ukGXt-cCj3ud_7y1Z4LgRpX3YCeumg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
In-Reply-To: <CAJKOXPeRtbAvmR-=8Qa8ukGXt-cCj3ud_7y1Z4LgRpX3YCeumg@mail.gmail.com>
X-Cookie: Help fight continental drift.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2019 at 05:09:45PM +0200, Krzysztof Kozlowski wrote:
> On Wed, 4 Sep 2019 at 16:39, Mark Brown <broonie@kernel.org> wrote:

> > I think it's reasonable, it's giving credit to the automated system
> > they've got running coccinelle (which they do mention in their commit
> > logs).  It doesn't really hurt anyone and lets people see their system
> > is finding stuff.

> Running internally coccinelle is already credited with commit author.
> The credits are coming with "From:" field.

I guess if other people look at the same CI and send patches as well
then there's some use tying them all together.

> Otherwise for commits I send I could use:
>   From: krzk
>   ...
>   Reported-by: www.krzk.eu
>   Signed-off-by: krzk
> To me it is ridiculous.

Sure, on the other hand it doesn't really cost anyone anything if you do
that.

> Different thing is that Reported-by is for fixing bugs or issues.
> There is no bug here. There is no problem solved except making the
> code smaller. That's not what is Reported-by for.

That is true, this one isn't fixing any bug but then the line does get a
bit fuzzy all round with things like warnings and coccinelle output -
even just having the warning pop up is noise for people looking at the
output even if there's no concrete problem.  Again I don't see it as
something that's worth getting worked up over.

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1v4rsACgkQJNaLcl1U
h9ADfQf/V7pUFkik9p4ok45W4iQXJ+1Wee9ghMi2ut+nuRzX8NRSwWYnFgK3w119
nf1YXfJsWCcs9af+DjcSoEyJWq/wegSyF/egvEd36QdqtaJJbMs/J5Kl+TEcglDA
uRJW6F/zevMcwamDE2I6UqdQjTIa2R8QG2S9yaw36Hd2b0k38lLq2Z1knHnQNbX7
6mFEqyt+sTaFjsBtlkgeUiTkMp36WsnTY7oRzGr/RKAd9ByHDmQKtPTuJl4eQTx6
zzkUK0PzNpBPqNyILAt7MYr01EyZfO3gjxnRNIH8yKl+80mkhiV2Td6DJehCuNqE
F30QD0NUhsOuqyDT26hqXFcIWtym6A==
=GPj9
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
