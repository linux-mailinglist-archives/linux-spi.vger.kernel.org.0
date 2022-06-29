Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FC55FD45
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiF2KZf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 06:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiF2KZd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:25:33 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8100D32EDA
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:25:31 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220629102529epoutp046c5fcb14ee8d3571d5eccda9d752413b~9EHQ-sYen2853928539epoutp04Z
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 10:25:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220629102529epoutp046c5fcb14ee8d3571d5eccda9d752413b~9EHQ-sYen2853928539epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656498329;
        bh=pjHYI27Oa14gnaUGIzY06N46sdKZEuguAgDFOPdfjZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riZy6mO+AOchViaYhTAYBkpRvHlLBD1hrO4uXvabcxcofKOxTkmLg8Mb4KkyiGCV2
         nTRVN2nYqON24qI6X3vXNMEAkPyfsoS7OlTPhI55MmR3t0dtozJdWDnpO+80DvXpsP
         yN4slCCbQbzA9QZSXNZ9e7Ud+Hq9UwUR9PTLSNaI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220629102528epcas2p1235870925d19450b0e2d246df917551b~9EHQX8x_31371313713epcas2p1F;
        Wed, 29 Jun 2022 10:25:28 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LXyK434rgz4x9Q1; Wed, 29 Jun
        2022 10:25:28 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.36.09642.8982CB26; Wed, 29 Jun 2022 19:25:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epcas2p17d7347cf06341193ec91b5f892e69217~9EHPktU_n2175421754epcas2p1K;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220629102527epsmtrp2cebd600fe4f527acf22fcc1e6ddc59d3~9EHPj9IdU0374703747epsmtrp2i;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-ce-62bc2898fce8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.33.08802.7982CB26; Wed, 29 Jun 2022 19:25:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epsmtip1ba64cc15c541033e5f7da32d31ed9529~9EHPSJwA_2693126931epsmtip1Z;
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
Subject: [PATCH v3 3/4] dt-bindings: samsung,spi: define exynosautov9
 compatible
Date:   Wed, 29 Jun 2022 19:23:03 +0900
Message-Id: <20220629102304.65712-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629102304.65712-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmhe4MjT1JBl9OiFs8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xoVjS1kKbnNWfJq9l7WBcSN7FyMnh4SAiUTL
        oyVsXYxcHEICOxgl3jccY4JwPjFKXN39nxnC+cwosf3PQSaYltsdd6CqdjFK3Dn7lxEkISTw
        kVHiwFQxEJtNQFdiy/NXjCBFIgI3GSWmn+0D62AWuMEosXfGeqAMB4ewQJDEvFNyIA0sAqoS
        N/f1MoOEeQXsJC5+LIZYJi+xYT5ImJODU8Be4u2V1awgNq+AoMTJmU9YQGxmoJrmrbPBLpUQ
        mMghcfrwFTaIZheJW317WCFsYYlXx7dAPS0l8fndXqiaYomlsz4xQTQ3MEpc3vYLKmEsMetZ
        O9idzAKaEut36YOYEgLKEkduQe3lk+g4/JcdIswr0dEmBNGoLnFg+3QWCFtWonvOZ6gLPCT+
        f3zECAm3SYwSb7d2Mk5gVJiF5J1ZSN6ZhbB4ASPzKkax1ILi3PTUYqMCY3gMJ+fnbmIEp1Yt
        9x2MM95+0DvEyMTBeIhRgoNZSYR34ZmdSUK8KYmVValF+fFFpTmpxYcYTYFhPZFZSjQ5H5jc
        80riDU0sDUzMzAzNjUwNzJXEeb1SNiQKCaQnlqRmp6YWpBbB9DFxcEo1MO1d90XvyZa//z/e
        dLob9uvEVfkPCUc/F51tLI+5tkAhYrNOpYGrxApvpXP5/vNUrx3nkpxRe20N44X+gNrY7Wv2
        FFpJm7N/bP+hYnU0golL+t2ym51FiiKnOHa/ZV+xuSrH4aFubrb68kqNb1b1v2tubWKsSZyy
        c2fo4Sh7k+1pZ+b5neWa2Mr6QMtfLtjUL2lLaYyGUaiv9g0hTwazjYeOTPS+/Wmi6Sphv+yd
        bXymcZb+c2WmSn5sePb8bvnJJIXACpbKZ4cEGeKz3H71LQ698oT76Ovo2S6v7BpX8BTNFdpv
        Ijpptmvvj7uPvdJ/N7Qn8C7UXrx0i2DMtPogi4a1a8znxc59/+rc6c+5i5VYijMSDbWYi4oT
        AZkluPQ2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO50jT1JBvtu6Vg8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvjwrGlLAW3OSs+zd7L
        2sC4kb2LkZNDQsBE4nbHHaYuRi4OIYEdjBKTp21kgUjISjx7twOqSFjifssRVoii94wSNzec
        BUuwCehKbHn+ihEkISJwm1Hib+M2NhCHWeAOo8Sj5XuYQKqEBQIkDrw4ygpiswioStzc18vc
        xcjBwStgJ3HxYzHEBnmJDfNBwpwcnAL2Em+vrAYrFwIqWXJ9J9hFvAKCEidnPgGzmYHqm7fO
        Zp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBcaCltYNxz6oP
        eocYmTgYDzFKcDArifAuPLMzSYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6Yklqdmp
        qQWpRTBZJg5OqQYmqaI4h5eT7L1nT1b4FbNXfeOrvF+HN1tFXVqxJHgHyzGeA2/ltmq3l9pp
        2b5yPG8+48yEKInG+pb0B6klzfd04m7OPbbpx1M989ArPNnxUZ9YN20NedTvonI4Ibhy2iUj
        xbOS07wCOjhP5iyz2zstaKPwhAmPmJq7FfufGuybmXXfybjxm4iCSVLC8uX/RXZmzjdnZD+4
        KO3jA6kItRgDj7l/6q5GSHX9euS00enTov1Vp47HyfCrxH9YdsTHrDiyPPXROiVL1b2MnDGK
        tgpbc6sPX+SfO//vKsflMm+19gXcl5oY0MLcdV1fKU/kZXd04h69timfrZhfXrjXZlm5z9Ev
        ZJLgce4FMSae1WuUWIozEg21mIuKEwHBq/bd8gIAAA==
X-CMS-MailID: 20220629102527epcas2p17d7347cf06341193ec91b5f892e69217
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629102527epcas2p17d7347cf06341193ec91b5f892e69217
References: <20220629102304.65712-1-chanho61.park@samsung.com>
        <CGME20220629102527epcas2p17d7347cf06341193ec91b5f892e69217@epcas2p1.samsung.com>
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
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index ef59ff62e88d..e0a465d70b0a 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -22,6 +22,7 @@ properties:
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos4210-spi
           - samsung,exynos5433-spi
+          - samsung,exynosautov9-spi
           - tesla,fsd-spi
       - const: samsung,exynos7-spi
         deprecated: true
@@ -86,7 +87,9 @@ allOf:
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

