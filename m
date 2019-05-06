Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89ECE14558
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2019 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFHhn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 03:37:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38842 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfEFHhn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 03:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ml4uJzXcGzydWf79ydXHif8mbv/MfKjBeSGO2rM7E+g=; b=DwMEcOpnMtddv14wrkldHEyB+
        hF4fks1qiB5DJ7lI1MC/QJ8Esa52mK+osjDFyyJpEL0lK+dKFPvL+RRZVN8jY4kz6yijQKF5GQOjX
        CUQ+0Hkw9MpBZ6xzGOHuRcj8hAF+GQrrTtmpF+qypulZ1LX3tpLkwvIN2DnCEtwjdx7oU=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNYBt-0000s5-BM; Mon, 06 May 2019 07:37:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DFBC3440040; Mon,  6 May 2019 05:49:16 +0100 (BST)
Date:   Mon, 6 May 2019 13:49:16 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V3 3/9] spi: add SPI_LSBYTE_FIRST mode
Message-ID: <20190506044916.GO14916@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
 <20190419152208.GT2803@sirena.org.uk>
 <BYAPR12MB33989D8DCEFCDE5DB76429E7C23F0@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AoBLyXwWXtFbU0pZ"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB33989D8DCEFCDE5DB76429E7C23F0@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AoBLyXwWXtFbU0pZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 27, 2019 at 12:32:58AM +0000, Sowjanya Komatineni wrote:
> > On Mon, Apr 15, 2019 at 02:30:28PM -0700, Sowjanya Komatineni wrote:

> > This is byte ordering as opposed to bit ordering which the core
> > already supports.  Do you have any examples of devices that need
> > this or is it just being added for completeness?  If devices are
> > going to rely on this we probably need emulation > support in the
> > core I guess given that this is a pretty unusual controller feature.

> Current upstream platforms have no specific device requirement but
> added this feature as Tegra support it for specific requirements of
> some slaves.

Do we have any examples of such devices?  In any case I think the main
thing here would be a software implementation of the feature so that
drivers can use it sensibly - at the minute they'd have to provide code
to work without the feature anyway and it seems like a relatively small
optimization for most things.

> [Changed mail client message format word wrap limit to 74 columns]

It's not working, and it's also mangling quoted sections of the mail
too.

--AoBLyXwWXtFbU0pZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzPvMwACgkQJNaLcl1U
h9BhdAf+KaNn14IkNGm8rJREfmZNBQNH91xi4m0l7rxa6aW9c9YwozOM6cKxPdyR
LRhdsAMvfNxCdosH7hrOPptQgEsAudA3+JVIwnhOuhFkkBmqfeNlc2/HUQIoXkKr
+RIH1nJJA9bxD0Z5u2x7wAt1F4bQ6EQ1kb0oSSuHThMI7WI5u7y3kafC/gUctwzB
JeU9TplFlzXmGLHkve6berLhGmZOvZ+bnOPHC7H0FlGScV6M6qk9sw7zxt6zxPF9
Aw9KSh05HPZ5aCYz/4kYBGYf7K+w97bjpUxX73idvJeXauzklnVgAnaq2S1JZf8q
hUny8YE9djcs/IQXidQFluYReixJDA==
=8Pu3
-----END PGP SIGNATURE-----

--AoBLyXwWXtFbU0pZ--
