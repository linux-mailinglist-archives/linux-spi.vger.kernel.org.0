Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09A55D505
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiF0Gtr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiF0Gto (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 02:49:44 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868CB10A6
        for <linux-spi@vger.kernel.org>; Sun, 26 Jun 2022 23:49:38 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220627064932epoutp02f54cdaa2e24acfdfe65fbf33ab359f19~8Z4Jt3OKD1744917449epoutp02V
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 06:49:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220627064932epoutp02f54cdaa2e24acfdfe65fbf33ab359f19~8Z4Jt3OKD1744917449epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656312572;
        bh=B/R4yfBkH5CP2rZdxW6UR9QRkk+o2aIAV9MsziGKGg8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XwAIfCLGmSlWIJfCdHPOluz+YWRSJlMdGI/DXOSSAm6r50ptR6tzKuYFDjKCeWoqI
         x/SPytKkMK8xBdlLRazthKPvI/N+9UgpR91DBot+rmZ4nd63H0ZIZQhWg/NjFx6UUR
         yo5TjdFjZtpx790RmHBwXm9iVu5HhfMOgdz14zDM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220627064932epcas2p3a76bdc88ffcf831db99bd02f08367846~8Z4JJU9Am2829428294epcas2p3E;
        Mon, 27 Jun 2022 06:49:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LWdcq6f7tz4x9Pw; Mon, 27 Jun
        2022 06:49:31 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.BB.09642.BF259B26; Mon, 27 Jun 2022 15:49:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epcas2p1944df2c6c54339de17e32c7116837f52~8Z4IaWAsN1429114291epcas2p1g;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220627064931epsmtrp1079dfbc81ef4a57225adc6dc981cab2d~8Z4IZV1QD2249922499epsmtrp1U;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-63-62b952fbb723
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.89.08905.BF259B26; Mon, 27 Jun 2022 15:49:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epsmtip2774248f36d5e497f19797450d3e64b35~8Z4IJ4nGz3088130881epsmtip2V;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 0/5] spi support for Exynos Auto v9 SoC
Date:   Mon, 27 Jun 2022 15:47:02 +0900
Message-Id: <20220627064707.138883-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmqe7voJ1JBn3vTS0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE74968m2wF2zgrHp7maGA8xd7FyMkhIWAi8WDy
        UkYQW0hgB6PEzp8+XYxcQPYnRonji9eyQTjfGCU6/89mg+no+jqRHSKxFyhxpJsJov0jo8S2
        kw4gNpuArsSW568YQYpEBG4ySkw/28cE4jAL3GCU2DtjPdhCYQFziVP3roKNZRFQlWiZ8J8V
        xOYVsJdY+Pc4M8Q6eYkN83uZIeKCEidnPmEBsZmB4s1bZzODDJUQ+Mgu0XBjA1SDi8TCo7+h
        bhWWeHV8C9SnUhIv+9ug7GKJpbM+MUE0NzBKXN72C6rBWGLWs3ag6ziANmhKrN+lD2JKCChL
        HLkFtZdPouPwX3aIMK9ER5sQRKO6xIHt01kgbFmJ7jmfWSFKPCROHaqFhE+sRFf3D/YJjPKz
        kDwzC8kzsxDWLmBkXsUollpQnJueWmxUYAyP0+T83E2M4PSp5b6DccbbD3qHGJk4GA8xSnAw
        K4nwvr6+NUmINyWxsiq1KD++qDQntfgQoykweCcyS4km5wMTeF5JvKGJpYGJmZmhuZGpgbmS
        OK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBibubw42hq8+fw5ee/xe4+zpT0ynJ2ifPvX06bXK
        5ed9V+h3pXa5bfy23DpPbNEsxSeRcakiRvPDYl/tqC2ccMXD+G/zt6W3HjoUZr17YnT7EsNd
        efGzm///7t25VYRxUVHTl+TVfAXmRv6Hyma/N9qz3rFUoFdPdbdAbyhbxfW/XStfXeotvaTJ
        oz6ba6avoHDXousLw5IK/vpsVdnqcbP19TzGyhzGr5q1XCkxTtnmDvwqEvmp7/4xS+899y1e
        6bq9s+ipb8tUq+/8fzHRVWJJuzY/0ymPgPqAXt2F7JGHVE/PdZ/18GTdzIxJiyYLR7Z3J+0+
        lPXswAq7VwFuhz9ql2VUsJquXXN73bKIzDAlluKMREMt5qLiRAAotbk4KAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvO7voJ1JBh/eiFo8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj3rybbAXbOCsenuZo
        YDzF3sXIySEhYCLR9XUikM3FISSwm1FibeNFVoiErMSzdzugioQl7rccYYUoes8o0T/1JxNI
        gk1AV2LL81eMIAkRgduMEn8bt7GBOMwCdxglHi3fA1YlLGAucereVTYQm0VAVaJlwn+wFbwC
        9hIL/x5nhlghL7Fhfi8zRFxQ4uTMJywgNjNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55b
        bFhgmJdarlecmFtcmpeul5yfu4kRHNZamjsYt6/6oHeIkYmD8RCjBAezkgjv6+tbk4R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgkmqf5svnp/7seP0i
        k2NnrUtZKyxW5ed983Q+eTGc74oZ0wN1LvFTuhlSXEe3xjxkc3/67ubZBbs3f3G4d2Lth9uG
        2zo4Foc4rz0V/8Wpfofhg/szj/Su10zJULzbp+bndcLQu9LomUWXs9S/97evSEUEBl7Yu1cs
        bYkxk7rotIfdGUqpjyQZnWZX6jkfne70yTV9QUfq4zab83OUPKqnz6s/lej/z2Hz5BYPqVOv
        V1daaR1x72wNCXAVqv9/2ofnVGdz1l+222JeF3uPaFrPZXxct+OozgmWR5qfG09XJeTmR17q
        6JnwOnNfYrh19r1YDQENh5cLQ2R94rXVlTiTSzllrzrkqF0Pa9p1TECJpTgj0VCLuag4EQAp
        6mHv2gIAAA==
X-CMS-MailID: 20220627064931epcas2p1944df2c6c54339de17e32c7116837f52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627064931epcas2p1944df2c6c54339de17e32c7116837f52
References: <CGME20220627064931epcas2p1944df2c6c54339de17e32c7116837f52@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add to support Exynos Auto v9 SoC's spi. By supporting USI(Universal
Serial Interface) mode, the SoC can support up to 12 spi ports. Thus, we
need to increase MAX_SPI_PORTS from 6 to 12. The spi of the SoC can
support loopback mode unlike previous exynos SoCs. To separate the
feature, we need to add .has_loopback to the s3c64xx_spi_port_config.
Furthermore, it uses 4 as the default internal clock divider. We also
need to clk_div field of the structure. If the value is specified, the
value will be used. Otherwise, "2" will be the default value of the
divider.
Device tree definitions of exynosautov9-spi will be added in separated
patchset to include usi(i2c/uart/spi) nodes all together.

Chanho Park (5):
  spi: spi-s3c64xx: increase MAX_SPI_PORTS to 12
  spi: s3c64xx: support loopback mode
  spi: s3c64xx: support custom value of internal clock divider
  dt-bindings: samsung,spi: define exynosautov9 compatible
  spi: s3c64xx: add spi port configuration for Exynos Auto v9 SoC

 .../devicetree/bindings/spi/samsung,spi.yaml  |  5 +-
 drivers/spi/spi-s3c64xx.c                     | 49 +++++++++++++++----
 2 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.36.1

