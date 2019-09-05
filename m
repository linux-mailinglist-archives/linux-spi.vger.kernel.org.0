Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0910AAB49
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbfIESkY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Sep 2019 14:40:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:48411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732133AbfIESkY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Sep 2019 14:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567708792;
        bh=bhJITHNaDSNk82tHbXwjAU2m4OSwrTVq9Dh6XgoEVgM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l5gka5lTwefMebb8U4HzIol6vblHmV57FMzes8yN8THNc2vXcQcJZM5dhzYH/tQK4
         Rm3QwWOLfBaeoh2LLT7euoAQqboVIkauh19AbkTP6fIUnF2EtRFEnmRjZxtUUyjeWW
         qjS0cTFWD7MMMZtMvn1Fe9ouR8oBJi5t0xopZDuk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.90]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMCFR-1i4Ygs4Bw5-00859O; Thu, 05
 Sep 2019 20:39:52 +0200
Subject: Re: [PATCH -next 06/36] spi: bcm2835: use
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
 <20190904135918.25352-7-yuehaibing@huawei.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <c9c6a9ca-5725-513f-2ef3-734ecf0878b8@gmx.net>
Date:   Thu, 5 Sep 2019 20:39:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904135918.25352-7-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:PJZW3p24Sgs9pPgM0nquSd55ClUOxvx8h/ANFNBZrD5MaK8bvKD
 dHfxSFK5ClXmMrJSUR8lOZtZfJA56JgmfFkwVv7amqZJ26WGT9rJFbEFaH/uolq/SSk3/Ik
 CaU2qBvQ+UiBNHCAXrwBe+mgP4L5nXoKh99c43NCmIKAYgIHM3GmDJzctwbGc8axkanZrqb
 kItlAw0DrA85Zrq1bckLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:anpvg5mTIZw=:5SNYFyWX4G6ecfNsrbwtlx
 /TNEmn+IvOxzbLdzuF8xREYo/Mb0quJpFUk4fLZIaDZRc/+F/YFcML45laZ3kAnjx4pBNoRjO
 FaTTfRdwtSx5/5J9nYb0tB67pARyFpiLNRZHPeVLgFdUlMdrfx0AViG2lcR1WyrQu8EmG0w66
 FupD6Vsv3CPNx5UyEqdvrM3FS14URpj0UbKkRqhhmqSsGNa/m8W9Eot0yghivFIPbC/W+4n4o
 jaTEuayyGrRuIkPrylx/NzddppI6WbP3xHMIYbF4TaVS3IkR+abQ7z50D/5xVjLSQDpKFa57B
 ckqCfAhpYRsoKkvJVpw/+ipQjDIAF41qmM6g4CRaGbxWun3LwiZB90S2AOGePNA4ppJ7aK6Og
 93MNpeQDqmJC4jF40SzBiV5bGYKY9t+sQ2mJ9B24d0iAjzEDa/g0K89frdKWOack+tm82B6gc
 ltMtrA0QSll5wIayinj6TBLy4S3mmBODD3LFeA67qATaC6MCSj69O4LuMtMpKbtfgth06HEMu
 YJ0FQhW4KW/0YU98OTNbUKqXrcY6VxuTAlHxN5kzpG2kcl73oo3uuVp/pW874PR2mqKpBYkAF
 o17lCCG8Hmrgnk+CY4zH2ZucP3GbNBJ3NPZXroU2mZYq+cy/1ZtQEuBRWNr5TfodKF+u15XKj
 cu+WWfsEaKkKsoLiS2dJnJ8c+Lwnn9jECz1wsbWKv4phl7tgWxwFlgPe/pNTVpZ++TjJKuCsg
 T+AEnJ5C7cuUvMW8Uy1C1xK5ZCiOQe9jMAtPKAZu237ChXgkj8wrwlFue2DSDeXfP9j+jtLTA
 0NhL8w0Uq3LMDQW6S8dUioyZ5pjNAaSxp88yWp0qceEyktCtxOL2hmy30iJPAB8V3qJyGe/Hs
 TDQiNNZqGcJ/LQ1EfJTKbn1KwFAg40weTKSTQFAHoG6T1sCUfd5POPN71s+ZYacM5pSDbzqBF
 deyy1C9MIYl0iKHg8Ajzk5Mhyl3sTIi4XtSYvss9RewaUBcYedvXA0rnnK1fxdjZrVzQAFLD4
 LAuNFdEbCzupNWUGMAeZYtJV1B6BhPD7j6jNYoXOerQckMjA6Ke57e0yNkddTN3RCspo2hPyl
 tvCoWGf7hkWKnybbkWmAhueCK2DCj42Dm/1l5jozBLE3rORYfNVAq64ralDwip1IBHAaf3bqR
 seRgj/4/fnfu787yaeEO9o1oR+2J5hYn41YKsgVXMUjRfztTZ70iv+mH+1iD3m/vETnZk=
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
