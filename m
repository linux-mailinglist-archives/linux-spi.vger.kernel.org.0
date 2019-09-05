Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E411FA9F43
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfIEKJH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Sep 2019 06:09:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39153 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfIEKJH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Sep 2019 06:09:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190905100904euoutp019c3fb88940e131aac2700c13f8fe9444~BgvdSTqE20300203002euoutp01c;
        Thu,  5 Sep 2019 10:09:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190905100904euoutp019c3fb88940e131aac2700c13f8fe9444~BgvdSTqE20300203002euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567678144;
        bh=/gWIDZvkTZVAyd2igvpxAXU5UpAa7v1JWESLTLXaxFw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IfOrNb+kZTkxao1FkAlfYSuc8UYpRuLZkeYTp0AmZWnqYGrhNdC1uJwpM1LUQ0o49
         3Kw/1TAn0xoy5xgy2Jv1q092BWMiCrVw2rrOy3T1DGkgXu1xSY0zkkhfqa14/d6jag
         vjigfdntWpwgehGDFmhxbPl55oa+X35ck/BjSiz4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190905100903eucas1p1283984102bb9a7fb247fbcf34bf5dfcd~Bgvc2KnLq3213432134eucas1p1e;
        Thu,  5 Sep 2019 10:09:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.9C.04374.FBED07D5; Thu,  5
        Sep 2019 11:09:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190905100902eucas1p1ce36a6d769640de92f9ff880728a3d26~BgvbnHTXS3108231082eucas1p15;
        Thu,  5 Sep 2019 10:09:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190905100901eusmtrp1407fd3d63aef001914d4e303eb138f5b~BgvbXMxgv1278212782eusmtrp1k;
        Thu,  5 Sep 2019 10:09:01 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-92-5d70debf8784
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.F9.04166.DBED07D5; Thu,  5
        Sep 2019 11:09:01 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190905100859eusmtip21ad6487f711eebd3b0f45bf62944f9e5~BgvZXo8JY1345813458eusmtip2b;
        Thu,  5 Sep 2019 10:08:59 +0000 (GMT)
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        eric@anholt.net, wahrenst@gmx.net, shc_work@mail.ru,
        agross@kernel.org, khilman@baylibre.com, matthias.bgg@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, kgene@kernel.org,
        krzk@kernel.org, andi@etezian.org, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <d3803e7b-4d5a-8260-e999-12465744c2a7@samsung.com>
Date:   Thu, 5 Sep 2019 12:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904135918.25352-26-yuehaibing@huawei.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRj17X1776Wz89LV8Ib5kXQkRjOByX48iQQx4cf9oUH/IYZoHXeM
        yFdaOt1m4qClCgNWhhPabYBQt1EygcL42viQlRU2oUwCMhmjSAk40xKh6GBjs/R2kX/POc85
        ec55k5elFFYmks3MyRc0OeosFS3DHTc3XG/2389Li+2clcPYwiMMDQ+XJLBRVS4Bz2AZBVfK
        hjBU97opODvvoWGgYALBps/BwPxkMhgs9RhsZ7sxnF74i4KNb9ol4HK1MPBjXxOGunO7wL4w
        JYWK/lEGSjYbKZjoOU/DhP4Ogo41Aw0VMwFttatPAgV/32Wg2G+hodAQB74/U8BYfFEKtwzL
        GNpMdVIwWl6ARXMbDVuddgy+Jg+C5fYIONMVCT0DBQxs9NRg2Gx/gKB3oBWDc7g4kGfQJYHe
        +2sI7q0vYTBuXqQTY/jClZs0vzJdxPCWuVGab/mjScr/Zl2l+G7LLMM32Ptpvs6u4w0Or5S3
        24ppvs36Ne+q/gHx311wSPkyvY/mW31dEv70VuwHylRZfLqQlXlU0MQkfCo70rZsQnmtki/N
        7h7qJNJLSlAYS7iDZHRxDZcgGavgLiNyyj9Oi8CPyM/fmykRrCFiejiPnlnuVbSFFpcQqf1n
        XCoCLyK/ls4EVXu4w6Ry1Yq2F0quhCaO9cogoDgzRVzmu/S2iuYOkLKh8qBDziUQT40Bb8+Y
        iyJLo8ag5kUuhay6b0hFTTgZMXuCmjAunvw0fzXIU1wEKfQ3huZXSaf3fDAf4cplpGzsHCMG
        TyIj455QiT3kgbM9xL9EbleWYtGgR6T02gwjAhMic866kONtcsN5J3CCDZx4nTT3xIj0u+T6
        L15mmybcbjLtDRdD7CZnOqookZaTb40KUR1FHtmqQk8fSU55nmITUll2VLPsqGPZUcfy/906
        hG0oQtBpszMEbVyO8EW0Vp2t1eVkRB/KzbajwN+5/cS53oX6Hn82iDgWqZ6Xuy/kpimk6qPa
        Y9mDiLCUSilvbs1LU8jT1ceOC5rcTzS6LEE7iPayWBUhP/Gc+2MFl6HOFz4XhDxB82wrYcMi
        T6Jbw0/zx6MmU/2X7BOXtxQLj6firs1OR23F1e4tsibUZ0oao2c0SenvjdS83xWffGLyyf6a
        yaJ/X5naFdb5O14ec1QfRtdbEl6u3Z/4judgcspKg5wbxexHqY1vscL0oeNM9D5NbO3cYrfm
        qw/jlPor4Ulc4ms23b6hvOHm+quVWUoV1h5RH3iD0mjV/wEZcpemNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf2wTZRjH895d725o43GM7E0TozQmGhM6bqX2GY4Fjc4DiZCoyVQarHBs
        hHadvRaZEmVb2VxN6abg1hNmBwXCFh1txxiNZaMMUEltZDo1zP1wlU2QTmEmbGNou2Gy/755
        v59PnudNHpbkO2gNu73MIdnLzBYtvYi6fO/S4PLoYLlpxcCfRvhudIaCI3fGCJhq3EdAMuYh
        4QvPBQqaosMkHBhJ0tBT2YdgOtXLwMiPG8ClHKag9cAZCryjN0iYqu0gIJE4ycDRs20U+D97
        AEKj/Spo6I4z4J4+QUJf5CANfdXfI+i87aKh4WqabUqcJaDy718YqJtUaKhy6SH1RzHU1B1T
        wbeucQrC9X4V1CgPwe++MA2zp0MUpNqSCMY7cuDjLg1EeioZmIo0UzDdcR1BtCdIwaWv69L7
        xBIERAdvIxj4Z4yCmulj9JpcsWriIi1O/LyXEZWhOC2e/K1NJf4UuEWKZ5RfGfFIqJsW/SGn
        6Oq9qRJDrXW0GA58ICaaWpC4/1CvSvRUp2gxmOoiRO/sio3Zr+sK7DanQ3q01CY7VmvfECBP
        J+SDLm9lvk7QG02r8gza3MKCrZJl+07Jnlv4pq40PF6PyoPELt9whNyDqgk3ymIxtxIPNIRJ
        N1rE8txRhK9VVzFuxKYLDf7cpZ1nluC7/W56nrmB8Mzxe0ymWMJtw5/cCqBMkc25adzoujpH
        kZyPxO2+v+gMxXMW7B3unxtHcwL2XNiHMlnNFeJks4vKZIp7DI/Fa+b4pVwxPt+l3GcW4298
        yTkmiyvAX46cUmUyyT2O7zZfIedzDq6aPHH//RF8+uZBsh7xygJdWaAoCxRlgeJHVCvKlpyy
        tcQqCzrZbJWdZSW6LTZrCKUvtvPiVLgLXQm+HEMci7QPqocP2Uy8yrxTrrDGEGZJbba6PVhu
        4tVbzRXvSnbbZrvTIskxZEh/roHULN1iS99/mWOzYBCMkC8Y9Ub9U6DNUX/IndvEcyVmh7RD
        ksol+/8ewWZp9qD1z67zrck1zUZeOd7y9vPtnfHa1QPFRYZJYn3WhgL5xZJ4xcgdU3iSS1mu
        767ctdZz/t9P98LE7lr+hxeW9egbg4vf8gbcLz1j22bb1F0/U/oEvO9YZhqMFp3yLrfqmcBh
        /7VzxNNJ1vDae/6hVQ9/tH/HVy1Frz5nu/zOWs0QP+5Zp6XkUrPwJGmXzf8Bw90gF8cDAAA=
X-CMS-MailID: 20190905100902eucas1p1ce36a6d769640de92f9ff880728a3d26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190905100902eucas1p1ce36a6d769640de92f9ff880728a3d26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190905100902eucas1p1ce36a6d769640de92f9ff880728a3d26
References: <20190904135918.25352-1-yuehaibing@huawei.com>
        <20190904135918.25352-26-yuehaibing@huawei.com>
        <CGME20190905100902eucas1p1ce36a6d769640de92f9ff880728a3d26@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 9/4/19 15:59, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

