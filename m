Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11DEAF9CB
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfIKKDP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:03:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33760 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKKDP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a0Kkj21KsvH+4VqiIM/Zj1XZfe1a49Milh3+Rqzxq0c=; b=Oe3vlnwfQYHbmzzSlu1stRVmc
        vWirk4HKb/ywIzeJRQYjTKfIQPMP/aAkdDXPaTUVTgtRSMpvr3Yzx3Xpugpe77qC2BpIUz8pcJh8/
        BRdmqfi1HirizyKZ/xZiYXIVVHLZf+75AhRCXgpPLg+y0o+dlX13L2cz++BPN1eEuqT6M=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7zSu-0007X1-Kw; Wed, 11 Sep 2019 10:03:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id C2AEFD02D76; Wed, 11 Sep 2019 11:03:07 +0100 (BST)
Date:   Wed, 11 Sep 2019 11:03:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luhua Xu <luhua.xu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 3/3] spi: mediatek: support large PA
Message-ID: <20190911100307.GR2036@sirena.org.uk>
References: <1568195731-3239-1-git-send-email-luhua.xu@mediatek.com>
 <1568195731-3239-4-git-send-email-luhua.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="By57YlnFViWR/M0S"
Content-Disposition: inline
In-Reply-To: <1568195731-3239-4-git-send-email-luhua.xu@mediatek.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--By57YlnFViWR/M0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 05:55:31AM -0400, Luhua Xu wrote:

> +	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(addr_bits));
> +	if (ret)
> +		dev_notice(&pdev->dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
> +			   addr_bits, ret);

Not sure why you picked dev_notice() over dev_err() here?
Otherwise this looks good so I'll go ahead and apply.

--By57YlnFViWR/M0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14xlsACgkQJNaLcl1U
h9BbAwf/WPyI6V+J0eXXtuhrkDPyjT7RRzxv1xzvLZx1r1SL66BLPAJce+D1yrmY
VNBKLZ8pS9tW6rmkDJEQVeeFJ+vQRJGca0DJxgiww9332H2aacH7gkw21eM/Zmi5
b1ziPC3WDTN4LAjDaGmPUq91NcXI3yzc1u+mUAsUEk/3oy/WzrqduSq1K8O2eBhV
vAAKEn+rE33sTz2BYQzMx8LbHaflmHYKxqT+HK111Cbq+ecGEOke7ItpZx/zVrFU
nJS3vxD35VwGQstEMIMgeXWsNGtD4y+sf2d2T/7DejwYWX9adSmPRdGSkyhCDLBG
hWBq3cFtRpYeF/ox+P+R1Zqr+y/J+w==
=+5QQ
-----END PGP SIGNATURE-----

--By57YlnFViWR/M0S--
