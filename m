Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3F8562C43
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jul 2022 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiGAHIu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jul 2022 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiGAHIt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jul 2022 03:08:49 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C841677E1
        for <linux-spi@vger.kernel.org>; Fri,  1 Jul 2022 00:08:47 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220701070844epoutp01f29087f8f5d35901f177e2b528069dc7~9ouDyAL533131331313epoutp010
        for <linux-spi@vger.kernel.org>; Fri,  1 Jul 2022 07:08:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220701070844epoutp01f29087f8f5d35901f177e2b528069dc7~9ouDyAL533131331313epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656659324;
        bh=ypTefoeSVkPWjAGuItwY+WTxkukhI+Absfpa0HG1lNE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=X5NsVPUuzI7SmbdjR11R27iaG2Ae/R4cPNdHzqUd7zahjZMbtIJ0SwdfZPF4Yv4Zk
         h7pOVaTOFxXflEJeVX7VqbkSuad2Pe9Ql8PtY1vXJgYMsUIGek8P3ht0RDTBPsLW9N
         h55bfQhqXCvUA/TuraN4emYdXc7LVxP15FKtojUo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220701070844epcas2p2b8362413c1112411a71cb137f066aff4~9ouDXSctk1846518465epcas2p2i;
        Fri,  1 Jul 2022 07:08:44 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LZ5s81Rzzz4x9Q1; Fri,  1 Jul
        2022 07:08:44 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.E6.09650.C7D9EB26; Fri,  1 Jul 2022 16:08:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220701070843epcas2p4d97f7fb559891fd06c23e074e106ce9a~9ouCnvYd01227112271epcas2p4U;
        Fri,  1 Jul 2022 07:08:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220701070843epsmtrp11bd553be9e0fe3e95ce6468efd208e8d~9ouCmrd_y0113901139epsmtrp11;
        Fri,  1 Jul 2022 07:08:43 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-63-62be9d7cb590
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.48.08802.B7D9EB26; Fri,  1 Jul 2022 16:08:43 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220701070843epsmtip28aead7c8a42a916704a58289b73c2177~9ouCYo_Tx3139031390epsmtip25;
        Fri,  1 Jul 2022 07:08:43 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Linus Walleij'" <linus.walleij@linaro.org>
Cc:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Andi Shyti'" <andi@etezian.org>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <CACRpkdagXnR0jjHNOVgGkh_ZntfzF0h4D_+DX85jNy7q=6DNEw@mail.gmail.com>
Subject: RE: [PATCH v3 2/4] spi: s3c64xx: support custom value of internal
 clock divider
Date:   Fri, 1 Jul 2022 16:08:43 +0900
Message-ID: <000001d88d19$662ccae0$328660a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGb/kKVVJlgx6bwfeH4bR2c5sxlLQIDgxMOAmkg2+8CSRXDAa2sh+mQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmqW7N3H1JBveXcFo8mLeNzWLxj+dM
        FlMfPmGzmH/kHKtF34uHzBZ7X29lt5jyZzmTxabH11gtZpzfx2TR+PEmu0Xr3iPsDtwe15d8
        YvbYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzO2c/YCzo4K67OvcnewLiJvYuRk0NCwERi
        6aUepi5GLg4hgR2MEuvnPYNyPjFKbJgzhxnC+cwoMWlaE1sXIwdYy7qluhDxXYwSO+7dY4Nw
        XjBKLL+8khlkLpuAvsTLjm2sILaIgIHE/fPT2EGKmAWWMUusmnCMEWQSp0CgxIrOVJAaYYEo
        iZObN4LdxCKgInFvwgKwXl4BS4lH988wQ9iCEidnPmEBsZkF5CW2v53DDPGDgsTPp8tYQUaK
        CLhJrJ9eCFEiIjG7sw3sAQmBAxwSb47PZYGod5Ho2bMb6n9hiVfHt0DZUhIv+9ug7GKJpbM+
        MUE0NzBKXN72iw0iYSwx61k72P3MApoS63fpQwJFWeLILajT+CQ6Dv9lhwjzSnS0CUE0qksc
        2D4d6gJZie45n1knMCrNQvLYLCSPzULywSyEXQsYWVYxiqUWFOempxYbFRjB4zo5P3cTIzjh
        arntYJzy9oPeIUYmDsZDjBIczEoivGzz9iYJ8aYkVlalFuXHF5XmpBYfYjQFBvVEZinR5Hxg
        ys8riTc0sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cAU3ya/0Inr5wYn
        M2/zs8a3jpzeue+96qaGFYrXPnKcepw27VyGcusipTi7Z++zdu9bmFL+5PdyxQI/C5/aR+FZ
        hpoLtvNxbfoqvvv6GcPlTG7+XIe5r/Qs6hNIS7d7mS/AacnvxrRW4McZa3Gxy7p9++TOf8h6
        KGbIrs22ZufiyvBfCoe1GTszWa3W5gvYHprR7Z5lMpvn3Ic1LiER2uf5U5WOt2m9OCZwKH76
        KuVww+27vSrbj/BOWLz3aeG2EBcBtgNK8nKvq0V0XMpfSbdqH2l+oHbzifXmnf8tP82f/6Lh
        zbTpp61PTDZSbX0R3ZsxTcYqibOzwvmA3I3LwqVLjfazt32IXLkpr1R5zjElluKMREMt5qLi
        RABMODitQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvG713H1JBleXKVs8mLeNzWLxj+dM
        FlMfPmGzmH/kHKtF34uHzBZ7X29lt5jyZzmTxabH11gtZpzfx2TR+PEmu0Xr3iPsDtwe15d8
        YvbYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXRufsZ+wFHZwVV+fe
        ZG9g3MTexcjBISFgIrFuqW4XIxeHkMAORomFB98zdTFyAsVlJZ6928EOYQtL3G85wgpiCwk8
        Y5Q4ej8dxGYT0Jd42bENLC4iYCBx//w0dpBBzAJrmCVO7TvPCjG1g0liwt4/jCDbOAUCJVZ0
        poI0CAtESGxbfAdsAYuAisS9CQvABvEKWEo8un+GGcIWlDg58wkLiM0soC3x9OZTKFteYvvb
        OcwQxylI/Hy6jBVkvIiAm8T66YUQJSISszvbmCcwCs9CMmkWkkmzkEyahaRlASPLKkbJ1ILi
        3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4NjT0trBuGfVB71DjEwcjIcYJTiYlUR42ebtTRLi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBKeNJ0VZF8V8z
        Slc/YfXN54wSUhV0ZS+3z5N4+Gv5RJbHM9K7A2p36s26YNndyarRF6LOUSaj5LZmaqnMpNMv
        pnz11nksI9Jjf/bzXP5pCV2K66z4HsiecQgOPazBf/uUklzlRYVbKetO6WnynOu3Wn6zf7tt
        3/Uir6qb7430vizPPmj45jyfi/vrfgfNzzVr6viz3qzY73VzZVN8rxxHwoZOicUuJc3veBv1
        sywzy3619O2/Yvx5zd2J4QYCrc61O6V0Ly9gPNsiyTwjY4WJXSIP++ZbT+Ys/7uO6Y4i417P
        qvKy6Sx7f0x6rH/9tfFK/R1vjrop3DorYXIqPNRC6tZNYzaDk2euJzZ7r1VTYinOSDTUYi4q
        TgQAbtKh2SwDAAA=
X-CMS-MailID: 20220701070843epcas2p4d97f7fb559891fd06c23e074e106ce9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd
References: <CGME20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd@epcas2p4.samsung.com>
        <20220629102304.65712-1-chanho61.park@samsung.com>
        <20220629102304.65712-3-chanho61.park@samsung.com>
        <CACRpkdagXnR0jjHNOVgGkh_ZntfzF0h4D_+DX85jNy7q=6DNEw@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> > Modern exynos SoCs such as Exynos Auto v9 have different internal
> > clock divider, for example "4". To support this internal value, this
> > adds clk_div of the s3c64xx_spi_port_config and assign "2" as the
> > default value to existing s3c64xx_spi_port_config.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> 
> While this gives a way to set up the default clock divider (which is
> fair) I think
> you should probably go the extra mile and make this clock divider a proper
> clock abstraction, so the driver can respect the DT standard property spi-
> max-frequency from Documentation/devicetree/bindings/spi/spi-peripheral-
> props.yaml
> 
> This actually isn't very hard: look for example in the PL111 driver, a
> hardware block that contains a similar internal clock divider:
> drivers/gpu/drm/pl111/pl111_display.c
> check how we define a clock from pl111_clk_div_ops.
> in pl111_init_clock_divider().
> 
> Then the driver probe() just grabs that clock and sets the frequency.
> The algorithms should be pretty much copy/paste.

Thanks for the suggestion. I'll look into it.

Best Regards,
Chanho Park

