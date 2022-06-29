Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7755FD50
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiF2KZg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 06:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiF2KZd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:25:33 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7173CFE1
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:25:31 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220629102529epoutp044cdc0dc0497e41670eaff7daa54e999f~9EHQ2aChH2618526185epoutp04U
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 10:25:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220629102529epoutp044cdc0dc0497e41670eaff7daa54e999f~9EHQ2aChH2618526185epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656498329;
        bh=onO80sWXtWcduHpTS4S3lVmeyinruHntd0PpS2ykAUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uN1BJU4Fo1meaTQWDtrKEgoa9zy+1a6cucBP/twH41QkhVr0yBGj9B4ZiV48WF7v6
         tXJigelRoutmE9TZOZhP7EaqYGd5Znk+ebFahpiWRVlOqEfkY+79xAtZF0wqei0DbR
         fx9YlcdgVA+toi2LZXtEIS/ahA8cw7loPyz/+yuU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220629102528epcas2p2f8110955244faecb355e003b89ca294d~9EHQEe7-z1990319903epcas2p2p;
        Wed, 29 Jun 2022 10:25:28 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LXyK40PX2z4x9Pw; Wed, 29 Jun
        2022 10:25:28 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.5F.09666.7982CB26; Wed, 29 Jun 2022 19:25:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epcas2p21c9ba830afdf5ec5a8afde4707206186~9EHPVm0tG2062420624epcas2p2j;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220629102527epsmtrp231f9d6a2252219ed0d75911379fa898e~9EHPU0PqD0374703747epsmtrp2h;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-76-62bc28973237
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.D6.08905.7982CB26; Wed, 29 Jun 2022 19:25:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epsmtip1843173c8e07f9f04c035f0e5dfd5e270~9EHPKHDRS2685226852epsmtip1Z;
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
Subject: [PATCH v3 1/4] spi: s3c64xx: support loopback mode
Date:   Wed, 29 Jun 2022 19:23:01 +0900
Message-Id: <20220629102304.65712-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629102304.65712-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmqe50jT1JBvPnW1s8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xss1mxgLzghVXJwwm7mBcQN/FyMHh4SAicTr
        1zxdjFwcQgI7GCXeH3zABOF8YpQ4/u4lO4TzjVGi88xUti5GTrCOk7OXMYLYQgJ7GSWuLwiG
        KPrIKHFw3nl2kASbgK7EluevGEESIgI3GSWmn+0Dm8sscINRYu+M9WDtwgLWEt/X7WICsVkE
        VCWu9p5gAbF5BewkZrcuYIZYJy+xYX4vmM0pYC/x9spqVogaQYmTM5+A1TMD1TRvnc0MskBC
        oJND4urEySwQzS4SJzZcZIewhSVeHd8CZUtJfH63F+qfYomlsz4xQTQ3MEpc3vYLKmEsMetZ
        OyMomJgFNCXW79KHhJiyxJFbUHv5JDoO/2WHCPNKdLQJQTSqSxzYPh3qAlmJ7jmfWSFsD4mm
        jb9ZIaE1iVHiUdtJ9gmMCrOQvDMLyTuzEBYvYGRexSiWWlCcm55abFRgCI/i5PzcTYzg5Krl
        uoNx8tsPeocYmTgYDzFKcDArifAuPLMzSYg3JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnA9N7
        Xkm8oYmlgYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKYPiYOTqkGJv5rntGZj9+s3CHs
        l7a/aYrgbZN/DB0xdtM2umTd/KU5aaHAVyPza7secG15a3D1kP6KB1e7cgt2dsf9/ijRM+1e
        Qs+7HjcJr64Fq5r61j3j27mGSS3sZZ5cMH/e3nxW322rjtxKT5MrWzy198UElVNejz+FHdmr
        2v2k/rGn+F+ZtK3yN/YbJkxR3lD++Mny9pJP7MX2ab+unjl/TH+CFcMN5Wu7m2VzLdUc517m
        WrPi/N73K98qvb+4ZtW2x+sWsAvWbu6v0ZUMKbmc1dHNIGWYr9RYua9jWn3l1rf+hySWr07b
        0H5N1Oe9/Nmaqyza6fc0rmUbvU96dOejXEP7xVfN7+QVYj+ZPL1bldpQUKvEUpyRaKjFXFSc
        CACOF7jaNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO50jT1JBv9fK1o8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj5ZpNjAVnhCouTpjN
        3MC4gb+LkZNDQsBE4uTsZYxdjFwcQgK7GSUerHrODpGQlXj2bgeULSxxv+UIK0TRe0aJk5u/
        gCXYBHQltjx/BdYtInCbUeJv4zY2EIdZ4A6jxKPle5hAqoQFrCW+r9sFZrMIqEpc7T3BAmLz
        CthJzG5dwAyxQl5iw/xeMJtTwF7i7ZXVrCC2EFDNkus7oeoFJU7OfAJmMwPVN2+dzTyBUWAW
        ktQsJKkFjEyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI0FLcwfj9lUf9A4xMnEw
        HmKU4GBWEuFdeGZnkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2Cy
        TBycUg1M54IEpVsW/mVx5z4uX20QV6VTWbzXaesbsdRzs+XDGr3jj3/4xmbXdtnitcj30H0G
        mi817JOXdHpJRyRFnhdUj1gz6cmsHRoqWwy/OmtetMss2ngg4EH8rzl39Rp3z39e3TF5utpT
        zpKAt48OPNtb9jO43LK/J2dRl+mrmzfWtM+8NOu8zPPlWr2SyXNcMv7sSNtsZZ/Pbdhstuyb
        HuPijorosOjjG/4bCZ1OMSrhedqUu/jRavGG1b5VHheWvrXr57wsznI17lLrX+k9smlbsltW
        h2l/6M98bztXJnChbf7pf9uPvGgM2vZ4hrNzwDTDtXVHeOZ8Els2/XfyXNMS1+vrDroINX4p
        nbWhh7NWiaU4I9FQi7moOBEA25ieC/MCAAA=
X-CMS-MailID: 20220629102527epcas2p21c9ba830afdf5ec5a8afde4707206186
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629102527epcas2p21c9ba830afdf5ec5a8afde4707206186
References: <20220629102304.65712-1-chanho61.park@samsung.com>
        <CGME20220629102527epcas2p21c9ba830afdf5ec5a8afde4707206186@epcas2p2.samsung.com>
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

Modern exynos SoCs can support self loopback mode via setting BIT(3) of
MODE_CFG register. Previous SoCs don't have the bit so we need to add
has_loopback field in the s3c64xx_spi_port_config. Exynos Auto v9 SoC
has the bit and it will define the field to "true".
When it is set, SPI_LOOP mode will be marked.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 302c1d4a28b1..0c917cf891ca 100644
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

