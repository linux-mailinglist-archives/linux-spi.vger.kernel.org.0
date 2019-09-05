Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7578AAB43
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 20:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbfIESkD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Sep 2019 14:40:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:40131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732133AbfIESkC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Sep 2019 14:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567708735;
        bh=bhJITHNaDSNk82tHbXwjAU2m4OSwrTVq9Dh6XgoEVgM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lz3Av3TLOi0x6l/ZeUn+JxA7lQAvjyfrdG6ivPQ0tce6WJsbQnRbTWZ4LLQEViLGA
         XYtu5l9Sctw/yz6mYOl7fHcGBSORZGwnAXbJe3W2yzfsgKoKGLZ0flZoolm7UAaCzK
         4/1Dy3RmaMBNVt3vWnheS+pgVtxqCQ6sZIorEq/M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.90]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86jp-1iIvGQ1k4f-00vgyM; Thu, 05
 Sep 2019 20:38:55 +0200
Subject: Re: [PATCH -next 05/36] spi: bcm2835aux: use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        eric@anholt.net, shc_work@mail.ru, agross@kernel.org,
        khilman@baylibre.com, matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org, krzk@kernel.org,
        andi@etezian.org, palmer@sifive.com, paul.walmsley@sifive.com,
        baohua@kernel.org, mripard@kernel.org, wens@csie.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-6-yuehaibing@huawei.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <491084d3-c2d6-3a24-687b-2668c7f0c09a@gmx.net>
Date:   Thu, 5 Sep 2019 20:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904135918.25352-6-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:AhcbQzoTSubicST5gNCmmM86WbvgdCiog0LAte4hswQdx10x9U3
 BT165vadZAyHuDZCp8X1/ZeC5JqpOYObS1+m486oNy3rM9gdrgI14dPE3E74e3EEZB2IUMv
 MVb3xpFYe5Ue4GjAp6XFrQN4OdX747yTNloHKxIU674bbUjkCOPjkelEUkEYdQlffEFwOWE
 srn/8FFG4jK+iaZNJwzcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:adRENuIYEO4=:fdhVudO9gEG5Ljf2I1JjWN
 zlT9EzVbICLQwAwbKCfsOQRNuiWdjGbg1HTZ2n4vqfeMrXKuzzWTLhtEeKL1GurMQubfSs/Nk
 504yTYHxt4sRVjaoRan5iROj5BY9QkmDRr8AR2aD+SLeCvN9O51OW2iKDxAcHaRR1nRjkKZ1Y
 cAqTQJNfItknmAGHIip3RZ6sHJ5VlXl24G3y9etJ1beufi4/srwC351zuj83ePNdlyoiDVxf3
 P9XLCesHv0eNFNXwgmqL80K3zUg5d58q0+xUo7NX1Hh9xuJvcMgYXwJ/+aDTcSJYVy/AOHrHQ
 Afc8wED5sIUL4pAW4+tAZ/SDzFy/vjq5Owrmo9URhzEi/3pjAKI1tOrNstohH4K6Bv+BP5Dln
 FE3zFYzkL/wXe7iONVwAJCncwvNcKN5/SDAnltTPN+euDlMjG6u/t/QPU8kxRmNFBfSrFHUGn
 2ndDpb4GRcpEDzL5kN/45FZavu4H+5ZcdR7lIMK1aChVCcWOhwQ7B6YrGvUg2H50N/jvHCfyn
 526BdViUsblAPBwL78V1gj7j3b9AAzDQHY2ympbwgl7wwOFtQlyAE6T7lgSgeA/PYdB62bzF0
 04yzE+TeCWjBBaZgBYNMRSHy8Pwcu9Zat6gk4NEH4h8SgFnU9gRUXmGo0ep4Bkacd8jXRscQT
 iBr0yIlAkLdV54u3L5bK4j6h95WuCXfYrSPR6qFwVBks3dNc9Xy297aBj90c3iNAnr+gUAz9e
 lW35VtwaT5cBBOwI4hYvgqF2US/amjBWJPmXRj0I90xdZguKHhfjno/vwpjLWDvkelwLDm5+J
 6tNo++B91nktW884NEgj9AGSRua5xKVDINuKE9Y/DhqGiNSSglBs50DCigRddr/LeX3kZ4nxb
 Z0FN1ASdo0wA/mnyPx8EQ+lGCmHhnCdsBCL79Dls3gKaDuiioQVb6Vw4vNrkaC9E0zGMUF8Hp
 rxDOttRPcszyKuJbeG0T3D9t4RcGnsYDo651EDHRCwJYx0umLWiClmoacgCwRL/CpknpINu1w
 b92BDA9sc3Lu6cjTvQCNmZ5o3r+o72tNaMaJtJ5zobxWoYrjUalmzxQ10KG4OjoO5GkOloodr
 Fhc3rFJkKoMqjXC0xxg1nmlPg3vN4+5ICP3xT1bv60sGeu0+mUNwM3Lg290Q1ASsbXndICX2M
 WNqNpRy/dU6NrJ1Ll6zy4xH2n3a7gVFBzIVh0d0giFSOdX1vhKy2ZLyxgO8MgBCbu9DNhDmr/
 8vEOmM+86m1g+1+ib
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 04.09.19 um 15:58 schrieb YueHaibing:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
