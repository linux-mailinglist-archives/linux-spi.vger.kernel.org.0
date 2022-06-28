Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16DF55D12E
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbiF1Eoq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 00:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244292AbiF1Eom (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 00:44:42 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5846581
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 21:44:39 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220628044434epoutp03a3561e04a0e6210b6ee5475748575342~8r0URb9TD1311613116epoutp03d
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 04:44:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220628044434epoutp03a3561e04a0e6210b6ee5475748575342~8r0URb9TD1311613116epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656391474;
        bh=pg1DKFGFeJP5gxc9XEzGTEP/OW75qIBRA0MM9cRt76c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VruVEAfoTWtX768coIhRrjw34FDsJY0grsoHzRspFzNRV10OMXCnUQ4CuEI5EPBZ7
         BLtbxzoZ5y/J4E9AbG4g+IG/6PW2vkzKFwPXl9AHPEiKiwtwrkPnIp+oD9c1R3F6J7
         kuHsqBQvb0TFJ3khvrtLuphrHnBx6ZjKWEQ6sI+s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220628044433epcas2p1304d17972c3230df4d443a4f416cdec0~8r0Ty0tQH1424614246epcas2p1p;
        Tue, 28 Jun 2022 04:44:33 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LXBp91vN4z4x9QP; Tue, 28 Jun
        2022 04:44:33 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.79.09650.1378AB26; Tue, 28 Jun 2022 13:44:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epcas2p3781648b3cade1dcac6b8e0f3899d7299~8r0TCr-SC1828318283epcas2p3A;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628044432epsmtrp1eed3b2aefe2c2d2f867134caf623435e~8r0TB6cwg2149721497epsmtrp17;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-ab-62ba8731902c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.70.08905.0378AB26; Tue, 28 Jun 2022 13:44:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epsmtip1579e51ade53adfd5cfd996c440a255c8~8r0S1G5bG2861828618epsmtip1j;
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
Subject: [PATCH v2 3/4] dt-bindings: samsung,spi: define exynosautov9
 compatible
Date:   Tue, 28 Jun 2022 13:42:21 +0900
Message-Id: <20220628044222.152794-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628044222.152794-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmha5h+64kg0vveSwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y8rOJraCNZwV85q2MjUwtrN3MXJySAiYSEx6
        cQfI5uIQEtjBKPH45hImCOcTo8SNO++hMt8YJX6sus0C07LxehcbRGIvo8SOk2uhnI+MEte2
        n2UEqWIT0JXY8vwVI0hCROAmo8T0s31gg5kFbjBK7J2xHqxKWCBIYtaN92A2i4CqxI1td9hA
        bF4Be4nrj1ZB7ZOX2DC/lxnE5hRwkFhwezsjRI2gxMmZT8BqmIFqmrfOZgZZICHQyyFx59tF
        qGYXiUsbljBC2MISr45vgfpbSuJlfxuUXSyxdNYnJojmBkaJy9t+sUEkjCVmPWsHauYA2qAp
        sX6XPogpIaAsceQW1F4+iY7Df9khwrwSHW1CEI3qEge2T4e6QFaie85nVgjbQ2JOx0IWSGhN
        ZpSYMq+dZQKjwiwk78xC8s4shMULGJlXMYqlFhTnpqcWGxUYwSM5OT93EyM4wWq57WCc8vaD
        3iFGJg7GQ4wSHMxKIrwLz+xMEuJNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5wBSfVxJvaGJp
        YGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qB6cycfedz8pexze06bGIXUTD5
        1svbcwM/yqY7WadpPOY+tsb2e1vF9kUzfXSnts4JiT9k8uHXIbWp6yLDP12Nn6nSbrTiFbdH
        7rKNYmHLM+SPBPitUgpl80kOYWG4y5526PVpEcUu73OTXx6+5+doc3xDT84c2Zzi7b2ycYkt
        sVZf903I+vhtiqW1aPlm36D5tydd81wt772IZcOzb+oM4rlbmF9kxPTVL20JcdrGu+dh4cW8
        w3tkDRkcj/22cWq6/yvgs7BYjVp4i6xNxkWhObx3439l838/O18k3MfkrN9yqQkrORLnLfDS
        E5k0j6Xni7NI8ZcV3Sm9DjzOLrxXrkyPPD8zcG55mYr7JAMtJZbijERDLeai4kQA+g8iizkE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnK5B+64kg7079CwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJUxZWcTW8Eazop5TVuZ
        Ghjb2bsYOTkkBEwkNl7vYuti5OIQEtjNKLGppYERIiEr8ezdDqgiYYn7LUdYQWwhgfeMEk82
        iYLYbAK6Eluev2IEaRYRuM0o8bdxG9gkZoE7jBKPlu9h6mLk4BAWCJB438sM0sAioCpxY9sd
        NhCbV8Be4vqjVSwQC+QlNsyHqOEUcJBYcHs7I8Qye4n1O9eyQtQLSpyc+QSsnhmovnnrbOYJ
        jAKzkKRmIUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHAVamjsYt6/6oHeI
        kYmD8RCjBAezkgjvwjM7k4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQ
        WgSTZeLglGpg8g2+WXhSLP9Zhb20nDD//06Lk/P65/6fLvzq2+nyGSLsXgZ+xRMOvln//E+J
        b9BUrk1dB6wlfB3eGJ7U3qYT8kaw8fzJN6Knll/xic2c+ENJc+/WhWk5Ngnh3gtq+7c/bGKb
        dGmK9q7M3L0+V8wkSxfI3j717/vL9Cxv4bMfI264p/Ee3Dlt95fZysU+74/O7jy+T8yjJe9l
        3ac5d3LfGzC+M+LPPriuY/M7finO4LZzmndkQzj3FzlP4GZNS2APnbtOxyzoOo+Kc+K005un
        zNRace5ak9HqxtqJT2d4Pspk+Csa2vX4Y8a5ZRtC3+c49jk+mceYu9r31rllH+boqhbYKN2s
        nLnr792g/R17xJRYijMSDbWYi4oTAZTy4F7xAgAA
X-CMS-MailID: 20220628044432epcas2p3781648b3cade1dcac6b8e0f3899d7299
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628044432epcas2p3781648b3cade1dcac6b8e0f3899d7299
References: <20220628044222.152794-1-chanho61.park@samsung.com>
        <CGME20220628044432epcas2p3781648b3cade1dcac6b8e0f3899d7299@epcas2p3.samsung.com>
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

Define "samsung,exynosautov9-spi" for Exynos Auto v9's spi.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

