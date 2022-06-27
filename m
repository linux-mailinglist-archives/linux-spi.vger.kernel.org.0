Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2255DB94
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiF0Gtn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 02:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiF0Gtm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 02:49:42 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39696103E
        for <linux-spi@vger.kernel.org>; Sun, 26 Jun 2022 23:49:38 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220627064933epoutp03a297d2594fffb192de7e8c8256772b91~8Z4J75jox1848118481epoutp03K
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 06:49:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220627064933epoutp03a297d2594fffb192de7e8c8256772b91~8Z4J75jox1848118481epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656312573;
        bh=aje5CEHvhfluM9KGxljECullw1hHJr49mcSeKXQWNxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1LgKLWiFrKXpxCR80sqFpEagbVtPyl0Z+nVskZGoRvEIYd+MDoEgXvbYp8KEFSHo
         LVqa/qWnV7hfmUWr0MPnBODSZ3ik5CJfghgy2vaP8yKVADcvt4AlGGV5BRB11cRY7p
         q1LlGLcsmR3LvCL9r7YVfVpTOTQrm3jxvhJ/4BBM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220627064932epcas2p4a2f7494c6def2fb36308557cfb356c77~8Z4JgH3610616106161epcas2p4z;
        Mon, 27 Jun 2022 06:49:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LWdcr1vMfz4x9Q3; Mon, 27 Jun
        2022 06:49:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.CB.09642.BF259B26; Mon, 27 Jun 2022 15:49:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epcas2p3052d80fd448aed36b9414e7733c251f5~8Z4InvKqU0596505965epcas2p3J;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220627064931epsmtrp1c129c979bb0247fb8e3f103f57daffdb~8Z4ImsTyz2249822498epsmtrp1X;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-67-62b952fb6757
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.E5.08802.BF259B26; Mon, 27 Jun 2022 15:49:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epsmtip2811c05fe60b4fe358f290aba4f002f5e~8Z4IaqPbQ3088130881epsmtip2W;
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
Subject: [PATCH 2/5] spi: s3c64xx: support loopback mode
Date:   Mon, 27 Jun 2022 15:47:04 +0900
Message-Id: <20220627064707.138883-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627064707.138883-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmue6foJ1JBhNPMVk8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xrGdfWwFdwUrVrZOZmlgPM3XxcjJISFgIvGx
        4RoTiC0ksINR4lN3dRcjF5D9iVHi8aazLBCJz4wS6+8mwzScWnKNGaJoF6NEx8LTzBBFHxkl
        7jfxgNhsAroSW56/YgQpEhG4ySgx/WwfE4jDLHCDUWLvjPWMIFXCAhYSp1f2gNksAqoSy5Yc
        BVvHK2AvcXjTJzaIdfISG+b3gm3gFHCQWPT0ChNEjaDEyZlPwOqZgWqat84GO0lCYCKHxIV9
        b4AcDiDHReJ7I9SfwhKvjm9hh7ClJF72t0HZxRJLZ31iguhtYJS4vO0X1GJjiVnP2hlB5jAL
        aEqs36UPMVJZ4sgtqLV8Eh2H/7JDhHklOtqEIBrVJQ5sn84CYctKdM/5zAphe0h8fXuMFRJw
        kxklzk2+xDaBUWEWkm9mIflmFsLiBYzMqxjFUguKc9NTi40KjOERnJyfu4kRnFi13Hcwznj7
        Qe8QIxMH4yFGCQ5mJRHe19e3JgnxpiRWVqUW5ccXleakFh9iNAWG9URmKdHkfGBqzyuJNzSx
        NDAxMzM0NzI1MFcS5/VK2ZAoJJCeWJKanZpakFoE08fEwSnVwKSySFKU+cqn5fa6H12m3/BQ
        TVz82Sa88aVUzEWrwwZumk05uRdjLt5w/rVH8MiSQh4fNbkIrqcPxC4cSTinltgmunnxcRW5
        vaURAR5sc9+yqUv+27J0Ru1hF5nXS10Fo/p6v6XOtHuk+/CZPPdN9rkS9T6Lv9gX3/oU4VtQ
        NfvOw/x305oqmb/xLv8yUXn/pt+P8rM9059HXLURFPR7f23bn44NH/st9mybd9DZ0faHi7/y
        zquGG/esdp23Kd/4/u8a1fj+3itrU+dlZG50jr37/mtC/uNvc00sgh89eGY7/0RFz5u4Y1cM
        NEXVpK8ms2idjryaf+iA3bXKcydmTpHs5Wu5waG37fy13zrCfo+VWIozEg21mIuKEwER1QNJ
        NQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSvO7voJ1JBpdnKFs8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj2M4+toK7ghUrWyez
        NDCe5uti5OSQEDCROLXkGjOILSSwg1Fi2bsMiLisxLN3O9ghbGGJ+y1HWLsYuYBq3jNKXJ83
        gwUkwSagK7Hl+StGkISIwG1Gib+N29hAHGaBO4wSj5bvYQKpEhawkDi9socRxGYRUJVYtuQo
        WDevgL3E4U2f2CBWyEtsmN8LdgangIPEoqdXgHo5gNbZSzw/UAlRLihxcuYTsFZmoPLmrbOZ
        JzAKzEKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAUaGntYNyz6oPe
        IUYmDsZDjBIczEoivK+vb00S4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6Yklqdmpq
        QWoRTJaJg1OqgSnA9f53b19+vcQLijYHC5/LvPTduNo88G2HYL7j9bOvzSoyLLwf37ktq3eu
        sHLBT+0pjr7Klz4ZLz0yuSPrUMQigQ93v187MPPYTu3yOzUdF/0O3p7SNuV0e6/fzBlRq55b
        7978x0o2+KPiqd8vUp++uvp++czbM5wzfqlU5ajfdfLxnxzul7L0R8fLM+tk3HNnNdeKMyYH
        FS17YreKO/1Zj5yBV9rcIvYAW4aYa1vt5q2Ys1Xjjo3P74nK8sF1vN9+S+zf2PrFoCvz1faQ
        jJ6nCXmna52kXrItsHAtupe1KpjjT/62zfYPuPYuYeGb9bvVc9vLF4z6EbZfD9WqLJBnaHnv
        nXFTuYLNsjz+iYMSS3FGoqEWc1FxIgC2Fdia8QIAAA==
X-CMS-MailID: 20220627064931epcas2p3052d80fd448aed36b9414e7733c251f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627064931epcas2p3052d80fd448aed36b9414e7733c251f5
References: <20220627064707.138883-1-chanho61.park@samsung.com>
        <CGME20220627064931epcas2p3052d80fd448aed36b9414e7733c251f5@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Modern exynos SoCs can support self loopback mode via setting BIT(3) of
MODE_CFG register. Previous SoCs don't have the bit so we need to add
has_loopback field in the s3c64xx_spi_port_config. Exynos Auto v9 SoC
has the bit and it will define the field to "true".
When it is set, SPI_LOOP mode will be marked.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a62c7baadc8b..e17c74c0d7de 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -59,6 +59,7 @@
 #define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
 #define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
 #define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
+#define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
 #define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
 #define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
 #define S3C64XX_SPI_MODE_4BURST			(1<<0)
@@ -135,6 +136,7 @@ struct s3c64xx_spi_dma_data {
  * @clk_from_cmu: True, if the controller does not include a clock mux and
  *	prescaler unit.
  * @clk_ioclk: True if clock is present on this device
+ * @has_loopback: True if loopback mode can be supported
  *
  * The Samsung s3c64xx SPI controller are used on various Samsung SoC's but
  * differ in some aspects such as the size of the fifo and spi bus clock
@@ -149,6 +151,7 @@ struct s3c64xx_spi_port_config {
 	bool	high_speed;
 	bool	clk_from_cmu;
 	bool	clk_ioclk;
+	bool	has_loopback;
 };
 
 /**
@@ -659,6 +662,9 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 		break;
 	}
 
+	if ((sdd->cur_mode & SPI_LOOP) && sdd->port_conf->has_loopback)
+		val |= S3C64XX_SPI_MODE_SELF_LOOPBACK;
+
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	if (sdd->port_conf->clk_from_cmu) {
@@ -1148,6 +1154,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					SPI_BPW_MASK(8);
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	if (sdd->port_conf->has_loopback)
+		master->mode_bits |= SPI_LOOP;
 	master->auto_runtime_pm = true;
 	if (!is_polling(sdd))
 		master->can_dma = s3c64xx_spi_can_dma;
-- 
2.36.1

