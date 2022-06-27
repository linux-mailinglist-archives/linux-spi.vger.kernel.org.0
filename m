Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF255DC69
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiF0Gtq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 02:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiF0Gtn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 02:49:43 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932010AC
        for <linux-spi@vger.kernel.org>; Sun, 26 Jun 2022 23:49:38 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220627064933epoutp01f3a6192418b7cc1cbe02af7f8c4cfc42~8Z4Kf5F_Q1243312433epoutp01N
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 06:49:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220627064933epoutp01f3a6192418b7cc1cbe02af7f8c4cfc42~8Z4Kf5F_Q1243312433epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656312573;
        bh=5Qi4uQ4SfmkVB+VbSzwx57Dt6G1IUaoGOdyjf2fRKSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4tP7jv1a6gQBEg6oA6qAQPTlhhOP3YX+M5PsXWFEWn5zlD4RnlcyU9rxBrza9I5E
         uLQAdqv5aNtA1Jz09TXDS8drbz1mGXbhlN6M3bs7iITtQXwawJywdQ8LA7BUX3vfTW
         oNFtajW41sW5V1oTWjYNSYsM9f9tjeaswchNiBD4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220627064932epcas2p2a4b1a1440b30e483eb48de706eeaf09c~8Z4JoIfdP3006230062epcas2p2k;
        Mon, 27 Jun 2022 06:49:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LWdcr36Jjz4x9QG; Mon, 27 Jun
        2022 06:49:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.FF.09650.CF259B26; Mon, 27 Jun 2022 15:49:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epcas2p2ad75d53ceabb2b0f10dfb13f5fcb0ff4~8Z4Iykc5i2456724567epcas2p2R;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220627064931epsmtrp13dc66e23ea164d5538eb24748a196c80~8Z4Ixm3BA2249922499epsmtrp1V;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-31-62b952fc3ad4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.89.08905.BF259B26; Mon, 27 Jun 2022 15:49:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epsmtip26e5c5d393fbf6e5068265436a053b860~8Z4IjAzDA3088130881epsmtip2X;
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
Subject: [PATCH 4/5] dt-bindings: samsung,spi: define exynosautov9
 compatible
Date:   Mon, 27 Jun 2022 15:47:06 +0900
Message-Id: <20220627064707.138883-5-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627064707.138883-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmme6foJ1JBoevi1k8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xrcHrewFLzkqZlyZxtzAeJKti5GTQ0LAROJO
        41qmLkYuDiGBHYwSE470MEI4nxglFq7vBasSEvjGKHF8ex1Mx/6vN1khivYySkz6uhXK+cgo
        cXnKe0aQKjYBXYktz1+BjRIRuMkoMf1sH9gSZoEbjBJ7Z6wHqxIW8JeYuukqC4jNIqAqsXzG
        HWYQm1fAXuLLvklQF8pLbJjfCxbnFHCQWPT0ChNEjaDEyZlPwHqZgWqat85mBlkgITCRQ2LT
        9G1MEM0uEgv+rmWEsIUlXh3fwg5hS0m87G+Dsoslls76xATR3AD0w7ZfUJuNJWY9awdq5gDa
        oCmxfpc+iCkhoCxx5BbUXj6JjsN/2SHCvBIdbUIQjeoSB7ZPZ4GwZSW653xmhbA9JN7s2cUG
        Ca3JjBJbJ+5mmcCoMAvJO7OQvDMLYfECRuZVjGKpBcW56anFRgVG8DhOzs/dxAhOr1puOxin
        vP2gd4iRiYPxEKMEB7OSCO/r61uThHhTEiurUovy44tKc1KLDzGaAgN7IrOUaHI+MMHnlcQb
        mlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgOvgtd3IIX8DF0zH7vTY9
        5WdScfpfvEe69O37jvVX1nRNqpEQny/Cuum5s0Ll42lM5YLJ5+1PB/iUzOlcxKUpdUVaKI3R
        xMu32UHsXE/f1YXrDwrsevDYye1dntR7hQcrE3K0TZlOaBSyJd1exqVa/lfVzkvohPQ6hvVX
        i1WjBGu+CKq/O9OTuZhBO2hy5jT3Cxz+UVmrDb4E7D7kona393LGNvHv2yY7hOgLpT5fsJkz
        b6blLLUb0TMnvwrwOnCZKfvebaOLwqnqTPJP1l2YHX1r/ZTVE08beHt/SHgQcXj1hJhPVew6
        /43v9z/eEXElae3J09yP3n8/zNI3b/tBE9ZXb+1ss67We05m6jDLVWIpzkg01GIuKk4EANiY
        mEU4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSvO7voJ1JBkvO61o8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj24NW9oKXHBUzrkxj
        bmA8ydbFyMkhIWAisf/rTdYuRi4OIYHdjBJ7emYyQyRkJZ6928EOYQtL3G85wgpiCwm8Z5R4
        eVoSxGYT0JXY8vwVI0iziMBtRom/jdvYQBxmgTuMEo+W72ECqRIW8JU4ev0QI4jNIqAqsXzG
        HbANvAL2El/2TYI6Q15iw/xesDingIPEoqdXgHo5gLbZSzw/UAlRLihxcuYTFhCbGai8eets
        5gmMArOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcBVqaOxi3r/qg
        d4iRiYPxEKMEB7OSCO/r61uThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2a
        WpBaBJNl4uCUamBacn1e/ru2Rbv4YoVkhbaz/JO/19r/Wjn/kcQnDsuJm/ZN7cpZrndk/0y1
        hITNaZOvGMX9XTDzbV9m4uescnu1CV6nedY/OvLxx/Y9vM9uCij5/HWXFMjXCxBfy7XhxIfp
        hZY+qpsc1LyWfZ97WUyu+fWf61Ne9k1carviZNvBO5mMk9fyaU80cZC8Eqme/tbc9ZZ+rHLr
        qsn3GfKWrFSee8aJs3PLqk1eRVo7St8I7NP3cfN1X3XjQg3z6yz30L0alxZ6MJ46/MJ1/Z67
        Ont9DG0mCSyMcI4/yhP9Rkk2ibu+v5bj9leTiXyv1rXN0z2ZP81O2zLvJ/Or7euLD672fh1c
        YNCTuuPpfOX0yPBuJZbijERDLeai4kQAECmSPPECAAA=
X-CMS-MailID: 20220627064931epcas2p2ad75d53ceabb2b0f10dfb13f5fcb0ff4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627064931epcas2p2ad75d53ceabb2b0f10dfb13f5fcb0ff4
References: <20220627064707.138883-1-chanho61.park@samsung.com>
        <CGME20220627064931epcas2p2ad75d53ceabb2b0f10dfb13f5fcb0ff4@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Define "samsung,exynosautov9-spi" for Exynos Auto v9's spi.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index a50f24f9359d..d51ee3e6d604 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -21,6 +21,7 @@ properties:
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos5433-spi
+          - samsung,exynosautov9-spi
           - tesla,fsd-spi
       - const: samsung,exynos7-spi
         deprecated: true
@@ -85,7 +86,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: samsung,exynos5433-spi
+            enum:
+              - samsung,exynos5433-spi
+              - samsung,exynosautov9-spi
     then:
       properties:
         clocks:
-- 
2.36.1

