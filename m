Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09FF55FD3B
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiF2KZh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiF2KZe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:25:34 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B603D1F5
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:25:31 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220629102529epoutp04244d984a5ad9ebf9f8feea345cb68023~9EHQ5G1iW2853328533epoutp04X
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 10:25:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220629102529epoutp04244d984a5ad9ebf9f8feea345cb68023~9EHQ5G1iW2853328533epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656498329;
        bh=JUaaLOm2Vdh8kNNKTN2Jn6RARBdGKmojFqo/8Wg4Ij4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UiyqRLmKQ/+q+4kIBB41hTfJYOWjTm0bQgjDYCh/RzF6vHAKmfPtyUZf7pv6qdSJR
         WcrNlYTcZTDEOExaKEnV6hgZ8VIhbl4M2ioW+7lMro4KZOiFWR3T6P47jKlMghO+es
         N/6JIFbhR1wNYsRy+bA73GXA0iJQujPHTMDLsAho=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220629102528epcas2p2eee2220c437aa84222194f700bc07bb9~9EHQTA2DV2249722497epcas2p2e;
        Wed, 29 Jun 2022 10:25:28 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LXyK4210Jz4x9Q0; Wed, 29 Jun
        2022 10:25:28 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.3E.09650.7982CB26; Wed, 29 Jun 2022 19:25:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epcas2p4ab04f91877e5f744c4a4e37827d19ce8~9EHPSJBqw0589905899epcas2p40;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220629102527epsmtrp2748a1c0bb9039072978716bc670624c5~9EHPRHK-Z0374603746epsmtrp2j;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-d5-62bc2897d0e6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.D6.08905.7982CB26; Wed, 29 Jun 2022 19:25:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epsmtip1f4cc829a1148dff24130b2bbded68e1d~9EHPGBt9g2596825968epsmtip1i;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 0/4] spi support for Exynos Auto v9 SoC
Date:   Wed, 29 Jun 2022 19:23:00 +0900
Message-Id: <20220629102304.65712-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmqe4MjT1JBrubGS0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7o/vXA/aCTbwVC19oNjDe4+pi5OSQEDCReN85
        jamLkYtDSGAHo8T/A3OhnE+MEnMvfWWEcL4xSnx78J0FpuXNmkNQib2MElOOvIVq+cgo8ePf
        LTaQKjYBXYktz1+BVYkI3GSUmH62D6yKWeAGo8TeGesZQaqEBawkdk/ZwAxiswioSuzafh3M
        5hWwk3jw/QAbxD55iQ3ze6HighInZz4Bu4MZKN68dTYzyFAJgY/sEh0f97BCNLhILF12FsoW
        lnh1fAs7hC0l8fndXqihxRJLZ31igmhuYJS4vO0XVMJYYtazdqDrOIA2aEqs36UPYkoIKEsc
        uQW1l0+i4/Bfdogwr0RHmxBEo7rEge3ToUEkK9E95zPUBR4Sf5Z3g50vJBArsXTLQbYJjPKz
        kHwzC8k3sxD2LmBkXsUollpQnJueWmxUYASP1uT83E2M4CSq5baDccrbD3qHGJk4GA8xSnAw
        K4nwLjyzM0mINyWxsiq1KD++qDQntfgQoykwfCcyS4km5wPTeF5JvKGJpYGJmZmhuZGpgbmS
        OK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBqaS19VT/t4zO31u8r38R7H3rSeqHZy/0bf6zmup
        oPM/40yE9zUdrU46fr3q3J7z8wUF9pSmG55+nXN/Cof0w6VHkrq4RRm47vZWCjy/G1jow79u
        X1jM+6TVXjcEnsf5P1E5U2Ze1MqTOtVNVLHq/bUzG5emndq4t9iz5qj6bp/fpZvd6j7nqN/4
        ono48PakMJ3puqbFZ1qeLglr4Xj75njS1VNuP/uDjC8zMx7iLtLJ5rgxeX6T4MXOa193q828
        4t13tLfq6Tn+Q94vlT4enbhcjdcqd2KEzWWj8C+ej6O9HNteBRvO3xMxTeDkvHdcqs1C2x7U
        +pu/lNXWcGQM3XtOavbuNaKzun7/nBRfz7dAiaU4I9FQi7moOBEAze+TqisEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnO50jT1JBq8+y1o8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSuj+9cD9oJNvBULX2g2
        MN7j6mLk5JAQMJF4s+YQYxcjF4eQwG5GifOLtzNCJGQlnr3bwQ5hC0vcbznCClH0nlFi089v
        YAk2AV2JLc9fgXWLCNxmlPjbuI0NxGEWuMMo8Wj5HiaQKmEBK4ndUzYwg9gsAqoSu7ZfB7N5
        BewkHnw/wAaxQl5iw/xeqLigxMmZT1hAbGagePPW2cwTGPlmIUnNQpJawMi0ilEytaA4Nz23
        2LDAMC+1XK84Mbe4NC9dLzk/dxMjOKy1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHehWd2JgnxpiRW
        VqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAtLLcmtX50Aqf+dKi
        vw4+CDOdVfjA1EKV5V2HzFK5ym89jR1rkyaGGhf3HynKOfH+a9Xfiaqv0l6vXbc7h5FP70Oe
        UZLKRdN11zwlbLqzvu5TjdBdwh60XnD3nDn9FUnPuGT3CjXwTM1bwfdQgLNw98+mlYmJT5Or
        Jz1/eLXELJ5n//7ac0pGqZM2HV9+UXnJ4jdCezjiXF5kFmzZfF54Ej/3oTYbO+2Ps9LdihZO
        65u3VymDf13OiqSswP9RDdVe8qFKtTulmGbJHL0w90zQvFpjdsWfJZu6GdiWn2HMDl61uu3u
        T86rISUljNYu3/YpP+zm61RrPThhzS4G3j8zb3QK94bdlmRpOLOV5VCDEktxRqKhFnNRcSIA
        lfGTL9oCAAA=
X-CMS-MailID: 20220629102527epcas2p4ab04f91877e5f744c4a4e37827d19ce8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629102527epcas2p4ab04f91877e5f744c4a4e37827d19ce8
References: <CGME20220629102527epcas2p4ab04f91877e5f744c4a4e37827d19ce8@epcas2p4.samsung.com>
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

Add to support Exynos Auto v9 SoC's spi. By supporting USI(Universal
Serial Interface) mode, the SoC can support up to 12 spi ports. Thus, we
need to increase MAX_SPI_PORTS from 6 to 12. The spi of the SoC can
support loopback mode unlike previous exynos SoCs. To separate the
feature, we need to add .has_loopback to the s3c64xx_spi_port_config.
Furthermore, it uses 4 as the default internal clock divider. We also
need to clk_div field of the structure and assign "2" as the default
value to the existing SoC's port config.
Device tree definitions of exynosautov9-spi will be added in separated
patchset to include usi(i2c/uart/spi) nodes all together.

Changes from v2:
- Rebase the patches on top of the latest next/master (next-20220629)
- Add Andy's R-B tags for #1, #3 and #4 patches
- Add Krzysztof's R-B tag for #4 patch
- Drop div local variable assignment as suggested by Krzysztof
- Change the data type of 'div' local variables to be consistent with
  clk_div (Pointed by Andy)

Changes from v1:
- Patch #1 "increase MAX_SPI_PORTS to 12" has been squashed to the patch #4
- Add Krzysztof's RB tags for #1 and #3 patches
- Assign clk_div value to 2 for existing SoC's port configs
- Make const of exynosautov9_spi_port_config

Chanho Park (4):
  spi: s3c64xx: support loopback mode
  spi: s3c64xx: support custom value of internal clock divider
  dt-bindings: samsung,spi: define exynosautov9 compatible
  spi: s3c64xx: add spi port configuration for Exynos Auto v9 SoC

 .../devicetree/bindings/spi/samsung,spi.yaml  |  5 +-
 drivers/spi/spi-s3c64xx.c                     | 54 +++++++++++++++----
 2 files changed, 49 insertions(+), 10 deletions(-)

-- 
2.36.1

