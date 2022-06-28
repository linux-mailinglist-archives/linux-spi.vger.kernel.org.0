Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA855D5BC
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiF1Eoq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 00:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244311AbiF1Eon (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 00:44:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF777644
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 21:44:39 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220628044434epoutp045d6545445f399120c0fc6766343caa90~8r0UKQ-el1325913259epoutp04u
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 04:44:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220628044434epoutp045d6545445f399120c0fc6766343caa90~8r0UKQ-el1325913259epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656391474;
        bh=TDT7luq6+JFg2qdyCz6SSl+GGNPWnobjhUV2LgvKce4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LDLyVC4iey5M6U6UkUl+Emiyv9zNzWbP8UKGxhY/PLRZ5iPxolLl3TgFCYdxAtWPa
         XAciuzSmOnPQpR0YlivMg36EhO7xh88vmkRNxUdND1Jshy3Rd6twtGZ3rDqa/D59/0
         y/paVPL/pXqLQuDTutiDUlf85HEUemi1q79mTVF8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220628044433epcas2p2ac84db00b0267c2dbc18ef7d1be6c9d8~8r0TlRio20047300473epcas2p2T;
        Tue, 28 Jun 2022 04:44:33 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LXBp90ZFDz4x9QJ; Tue, 28 Jun
        2022 04:44:33 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.7D.09642.0378AB26; Tue, 28 Jun 2022 13:44:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epcas2p13af378bf5c8cdb767f4f06804e07f7c7~8r0S118YM1157411574epcas2p1l;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628044432epsmtrp15ba865ed2397a27decc3be9d008c5b0c~8r0S0xE692149721497epsmtrp15;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-03-62ba87308d3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.FC.08802.0378AB26; Tue, 28 Jun 2022 13:44:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epsmtip1d9345b68e30f2221e444bd4d0563d1ad~8r0SkGk522875028750epsmtip1c;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 0/4] spi support for Exynos Auto v9 SoC
Date:   Tue, 28 Jun 2022 13:42:18 +0900
Message-Id: <20220628044222.152794-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmqa5h+64kgxMbmSwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y23TMdaCW1wVB56+Zm1gPMvRxcjJISFgInHq
        zQTGLkYuDiGBHYwS55uuQTmfGCWu7P3GDuF8ZpS42L6dBabl6s+ZUFW7GCXm7drLCuF8ZJS4
        e242E0gVm4CuxJbnr8CqRARuMkpMP9vHBOIwC9xglNg7Yz0jSJWwgJXEgmefwTpYBFQl1n5c
        B7SQg4NXwF6id407xDp5iQ3ze5lBbF4BQYmTM5+AncEMFG/eOpsZZKaEwE92iQtTITZLCLhI
        LN1/kBHCFpZ4dXwLO4QtJfGyvw3KLpZYOusTE0RzA6PE5W2/2CASxhKznrUzghzBLKApsX6X
        PogpIaAsceQW1F4+iY7Df9khwrwSHW1CEI3qEge2T4eGkKxE95zPrBC2h8SHC3fAhgsJxEq8
        7O5gnsAoPwvJN7OQfDMLYe8CRuZVjGKpBcW56anFRgXG8GhNzs/dxAhOolruOxhnvP2gd4iR
        iYPxEKMEB7OSCO/CMzuThHhTEiurUovy44tKc1KLDzGaAoN3IrOUaHI+MI3nlcQbmlgamJiZ
        GZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgKvDsDyls7H/HH9f4IUBp0+uYBc77
        5iflZp67Ny9E/8dDF8sFr32/3CwwkLiTJvCsMe3h5ibbxmVhv1LZHn5g76lUinWWe5aZo31t
        j2up2EaWXuWeE9PaotUW/VQUfPqNs/mTvFdPXapFVf2/kMKN+7oqp3RYiSbKHc4OmiWWxM2t
        4/9bafWKxe7VijFFuxde8pt/K8NDk3vLZHaV29MTfm27Mfnf0R3br97jXjldb1ls1erwWmOp
        t5r6kbv+TOZ8cOXmRMZsW5aXy2SW8R+TCPwkeF1r6Zq8zv9r7t4+wh1So9+9Pcep96DdoVWL
        /FYVNe7/1LI7iWm3mX6MgrXQ5R4Z2WbV9pncHjfdk/SVWIozEg21mIuKEwEgMA1OKwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnK5B+64kg7mnpC0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJWxtukYa8EtrooDT1+z
        NjCe5ehi5OSQEDCRuPpzJmMXIxeHkMAORolrnQtYIBKyEs/e7WCHsIUl7rccYYUoes8ocWvj
        ZlaQBJuArsSW56/AukUEbjNK/G3cxgbiMAvcYZR4tHwPE0iVsICVxIJnn8FsFgFVibUf1wGN
        5eDgFbCX6F3jDrFBXmLD/F5mEJtXQFDi5MwnYFcwA8Wbt85mnsDINwtJahaS1AJGplWMkqkF
        xbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFhraW1g3HPqg96hxiZOBgPMUpwMCuJ8C48szNJ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqYUm4KtzVP3
        CfK0BNc+XN+dKOpxaQGn1KHvPx4lzEmapFejcrXwtcz6tRO1Xuf+vFGkYzvr5VWW3gqtg7ps
        mntPvhOSDghrP3ReSXiDBYtnA3PZjMxfYvFmDW9Xz34//8F59eK1JQf7MzuavR9pyK5Qf/Zy
        e/tMs1fvszvF80sXlGptjtr6f3cqt8+Bac828OUnl4iwhBddON/v3mZR7OT/qnj2ZNcF+ndT
        5hTV3JrAfXSDu9JDvR1SlnkT5q83eKLOsSeM99vH+dsadj6aNKGCYbdgHztXhEdfxsYpvh92
        d6Yv/P9rt98NNvv4PSFX2S92+Ee3FEhcODkrXmBV5I21+a3bhX/3Cgb89kp6u0SJpTgj0VCL
        uag4EQD2QkQP2gIAAA==
X-CMS-MailID: 20220628044432epcas2p13af378bf5c8cdb767f4f06804e07f7c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628044432epcas2p13af378bf5c8cdb767f4f06804e07f7c7
References: <CGME20220628044432epcas2p13af378bf5c8cdb767f4f06804e07f7c7@epcas2p1.samsung.com>
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

