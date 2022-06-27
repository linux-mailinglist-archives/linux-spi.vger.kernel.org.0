Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2691F55DC8C
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiF0Gts (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 02:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiF0Gto (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 02:49:44 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D4E10A7
        for <linux-spi@vger.kernel.org>; Sun, 26 Jun 2022 23:49:38 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220627064932epoutp02d85d4303ae5a7dc28bd54cb52832f65d~8Z4J162091744917449epoutp02W
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 06:49:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220627064932epoutp02d85d4303ae5a7dc28bd54cb52832f65d~8Z4J162091744917449epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656312573;
        bh=KIHUOxmBHy/D6F1aB0MGazUyNOmjIsMLigYMMuWF0hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEKB18SkUV5BngZ/HySc45p6oiHKN8IH5EvQNn4ncx5oT2CM3FHdKhr2Mm6B8o7cL
         0KPssEhV2SeWS+m3+Dv/BSYxf+SkNJtpYSYANMwFmXgDF0UK7FXxoeJteZoMBmcs6w
         iogeQh4Qwy0ebLRBhNF2OxM1fU77eFxN6hY48gT8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220627064932epcas2p325bc5c50884ffba5f002ac5ebd7f8c24~8Z4JSwCP90596505965epcas2p3M;
        Mon, 27 Jun 2022 06:49:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LWdcr0hGHz4x9Pw; Mon, 27 Jun
        2022 06:49:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.BB.09642.BF259B26; Mon, 27 Jun 2022 15:49:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epcas2p4d90034c1fe583a3460f0e4613e83e6d0~8Z4ImqmwY0616106161epcas2p4q;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220627064931epsmtrp260d3847150badfac2255b16146f6e075~8Z4IlZ5Ot2152221522epsmtrp2b;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-65-62b952fbdd47
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.89.08905.BF259B26; Mon, 27 Jun 2022 15:49:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epsmtip2953cb9137cb83ce1b0e290d9fdc47347~8Z4IRu3-m3090630906epsmtip2f;
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
Subject: [PATCH 1/5] spi: spi-s3c64xx: increase MAX_SPI_PORTS to 12
Date:   Mon, 27 Jun 2022 15:47:03 +0900
Message-Id: <20220627064707.138883-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627064707.138883-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmme7voJ1JBhPv21g8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xvxzc5gL2lgr/jQuZGxgnMvSxcjJISFgIrFy
        9lfmLkYuDiGBHYwSx6+1MEI4nxglNq49AeV8Y5T48e8MI0zLu+7dUIm9jBLvZ7RC9X9klJi/
        8jcTSBWbgK7EluevwKpEBG4ySkw/28cE4jAL3GCU2DtjPdgsYQFnic8zDrOC2CwCqhJH//SA
        dfMK2Eu8vfCSGWKfvMSG+b1gNqeAg8Sip1egagQlTs58AvYGM1BN89bZYGdICPRySGx4so0N
        otlFovHpY6hfhSVeHd/CDmFLSXx+txeqplhi6axPTBDNDYwSl7f9gkoYS8x61g50KQfQBk2J
        9bv0QUwJAWWJI7eg9vJJdBz+yw4R5pXoaBOCaFSXOLB9OtRWWYnuOZ9ZIUo8JM5elIUE1mRG
        iZfHXzNPYFSYheSbWUi+mYWwdwEj8ypGsdSC4tz01GKjAmN4HCfn525iBKdXLfcdjDPeftA7
        xMjEwXiIUYKDWUmE9/X1rUlCvCmJlVWpRfnxRaU5qcWHGE2BYT2RWUo0OR+Y4PNK4g1NLA1M
        zMwMzY1MDcyVxHm9UjYkCgmkJ5akZqemFqQWwfQxcXBKNTBNjpXL5N/vPv2U9LTdcUHP3d69
        rrEVkz0mf3rqt6wnt4/P3fUzf5lmzcvFr64l+5ctqnJsyPBRXzPJbWriX9Nup3cnbX13yDTP
        O/muviTYd8/vy61bWGXXrsvsvM7WsDiNsz/L4fLMFT6zLmiZGHc6Ckz4fbE5/Mj6x1ddWE0s
        HoUs33JBjt/QJKlw8/vv4qqbfCq3Xrs1a+a/DNZb8gec22sW75h3ufaj27Uvnv3Mou1Mb0U2
        MC5meiXXvo41Ue/P1eKZldsnL3j7p37PhU0Wd+w21Os9v6/91Njq4W73lSyaCYIH587dpbDv
        fLrz2btH3xyU8n2vI9m90+TTsXvNrwWlsq79vrX2roztnB5VPSWW4oxEQy3mouJEAAjdl8k4
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvO7voJ1JBq175CwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJUx/9wc5oI21oo/jQsZ
        GxjnsnQxcnJICJhIvOvezdjFyMUhJLCbUWLlzCtQCVmJZ+92sEPYwhL3W46wQhS9Z5Q4smIC
        WIJNQFdiy/NXYN0iArcZJf42bmMDcZgF7jBKPFq+hwmkSljAWeLzjMOsIDaLgKrE0T89YHFe
        AXuJtxdeMkOskJfYML8XzOYUcJBY9PQKUA0H0Dp7iecHKiHKBSVOznwCdh0zUHnz1tnMExgF
        ZiFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzgOtDR3MG5f9UHvECMT
        B+MhRgkOZiUR3tfXtyYJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUI
        JsvEwSnVwLSlQKjL7cNeC+2sia2vG2atbAt5z2Vs90z3PNv6T5ePPT1itCH64muldQ8SD8re
        VJrGN+GAa7vO4/f/d/H57tLo3VYz/d9rLtfWO8uvzloT/uGVs+1PU/M9/R6H5jouK1/Wd6Vx
        +bINh31WBOnxGW8ItmXc5dOhKbxmT7ml5EHlebt7mXUyLM1StcUyxX5+76q6duO7ownP5E0b
        U36zVzY7XDj3Xuqj6PwLXOdleR0Pl0Wp3Sw+9nf//xKDleHpe+18tHm7mJ6WLFDwO6PttsrZ
        +ejNvAmXReIqPm+z2nlP501cbFgC+53d/23uOXCWb8qqnHfgePW57aeuL/3s2BW88Yn+YUb9
        G4lcSeGz3/9TYinOSDTUYi4qTgQA5pdkc/ICAAA=
X-CMS-MailID: 20220627064931epcas2p4d90034c1fe583a3460f0e4613e83e6d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627064931epcas2p4d90034c1fe583a3460f0e4613e83e6d0
References: <20220627064707.138883-1-chanho61.park@samsung.com>
        <CGME20220627064931epcas2p4d90034c1fe583a3460f0e4613e83e6d0@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For exynosautov9 SoC, the spi can be supported up to 12.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7f0faf0d75d9..a62c7baadc8b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -18,7 +18,7 @@
 
 #include <linux/platform_data/spi-s3c64xx.h>
 
-#define MAX_SPI_PORTS		6
+#define MAX_SPI_PORTS		12
 #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
 #define AUTOSUSPEND_TIMEOUT	2000
-- 
2.36.1

