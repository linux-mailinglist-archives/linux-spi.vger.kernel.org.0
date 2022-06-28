Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE955C186
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244310AbiF1Eon (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 00:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiF1Eom (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 00:44:42 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D53264D3
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 21:44:39 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220628044434epoutp019b1e618afd883caf2869ea3cfcb4e617~8r0UYSvo-0066000660epoutp01V
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 04:44:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220628044434epoutp019b1e618afd883caf2869ea3cfcb4e617~8r0UYSvo-0066000660epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656391474;
        bh=dcRRY121HxQELI/G/iJS58nUkk5oUSZCKSDNdRBjJKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojpoPuKzHji9B5d5TUWj2gmyW+AKrGPQ7B519pasHk+G/P/c5ONp9iwiOaWeRw1i0
         AHgx6RUWQJh9Q56p5BGgMRnnmVGA6+WbLE9eEzeF87e4L9thz2Ld43DjW13KdkEIhJ
         cRIfN0k9pq5wkcC0ogxrI4t4AECg7wwBTZbhP8pA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220628044433epcas2p21ef7d4017e99dec638adaf14921f4b78~8r0Tzf6_r0060600606epcas2p2S;
        Tue, 28 Jun 2022 04:44:33 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LXBp91lSFz4x9QB; Tue, 28 Jun
        2022 04:44:33 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.D6.09666.1378AB26; Tue, 28 Jun 2022 13:44:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epcas2p2116480d15be87cb723855b7a39ced6dc~8r0S80Et20047300473epcas2p2O;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628044432epsmtrp17233c4708f4314e1d46d75949becec61~8r0S4CmhY2149721497epsmtrp16;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-88-62ba87315f55
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.70.08905.0378AB26; Tue, 28 Jun 2022 13:44:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epsmtip17aed2d3d4ebf3a8d035ebbb4d93f689f~8r0Sp_eIV2861828618epsmtip1i;
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
Subject: [PATCH v2 1/4] spi: s3c64xx: support loopback mode
Date:   Tue, 28 Jun 2022 13:42:19 +0900
Message-Id: <20220628044222.152794-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628044222.152794-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmha5h+64kg78fuCwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE748nfl2wFC4Qqvl+/w9jA2MnfxcjJISFgIvHz
        1gT2LkYuDiGBHYwSHyb/YIVwPjFK7L/zihHC+cYocfH1ciaYli9/JrNAJPYyStyadJkZwvnI
        KDH7yT+wKjYBXYktzyHaRQRuMkpMP9vHBOIwC9xglNg7Yz0jSJWwgLXEu7+v2UBsFgFViaa2
        dcwgNq+AvcSfta0sEPvkJTbM7wWLcwo4SCy4vZ0RokZQ4uTMJ2A1zEA1zVtng50hITCRQ+L4
        nlnsEM0uEl+e32GGsIUlXh3fAhWXknjZ3wZlF0ssnfWJCaK5gVHi8rZfbBAJY4lZz9qBtnEA
        bdCUWL9LH8SUEFCWOHILai+fRMfhv+wQYV6JjjYhiEZ1iQPbp0OdLyvRPeczK4TtIdH28Dg4
        gIQEJjNKvLtpNYFRYRaSb2Yh+WYWwt4FjMyrGMVSC4pz01OLjQoM4XGcnJ+7iRGcXrVcdzBO
        fvtB7xAjEwfjIUYJDmYlEd6FZ3YmCfGmJFZWpRblxxeV5qQWH2I0BYb1RGYp0eR8YILPK4k3
        NLE0MDEzMzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXANNPAQTLcZj1HYorLvp8d
        l63Yny1nDvItapC5Xt226HVTWHZZr1u7iLxT7+wHfq4pL18+nDr7euHddMOqfRdfuV+a5/hg
        3rWm7183cl99EPlsxc2v5WfaBEUjUtjX/gpjPTQvbfnJZ+vZ/7LrrXjoH3XqzZ43Zg8sja6b
        zbpm3J6143207Bnl/MKrsdanzizlkj3au8BprSJ74BKBwzUsGuqeB5lOPOuNm7fhsM/jWk3v
        E1MKl4cvunWkpYKZbdOXQ8KebFKSBpu51UpfXDZ7e/azaJbulG3y9hVukl6r7/v7bNWRDgrr
        nKBRIPUzoDKG4YD6oZufynq8LqoKVb3TK15zoOfTxKW5PvVzH+2br8RSnJFoqMVcVJwIABMt
        uRA4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnK5B+64kg6ftihYP5m1js1j84zmT
        xdSHT9gsLu/Xtph/5ByrRd+Lh8wWe19vZbfY9Pgaq8WM8/uYLBo/3mS3aN17hN2B2+P6kk/M
        HptWdbJ53Lm2h81j85J6j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mp48vclW8ECoYrv1+8w
        NjB28ncxcnJICJhIfPkzmaWLkYtDSGA3o8Tmhv/MEAlZiWfvdrBD2MIS91uOsILYQgLvGSWO
        XxIFsdkEdCW2PH/FCNIsInCbUeJv4zY2EIdZ4A6jxKPle5hAqoQFrCXe/X3NBmKzCKhKNLWt
        A9vAK2Av8WdtKwvEBnmJDfN7weKcAg4SC25vZ4TYZi+xfudaVoh6QYmTM5+A1TMD1Tdvnc08
        gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxguNAS3MH4/ZVH/QO
        MTJxMB5ilOBgVhLhXXhmZ5IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1ML
        UotgskwcnFINTHF2zbPz3mzzzWL5fyf905mAm65s0ouvTPqn96L+vnkl4wfW1Ufn+S9yaLRP
        97Cd379n5k4+dZsDKqbLmTklnyQd23jfsf7129X3cw4lx3n7mP3MeTv3y6v8My8Yyx9IhGk8
        dp082Urz9G2FE6unOO8QeNv8QYBTZZnMNJHfCV8vvmjWKzt3L2v5c8nVLw7cMmbqWr/ic+rp
        Iv4JmxpC7k0LdU6YNknoEcsZwZVTf/spZW2b17zfsXuFZtwZYYb6JTynHV4fWVkV7JicKhay
        JrO+/dz3ru2K6S4ap2yyci59sAgz3VllLx4rd8yE4WFcgVk2w++Fz95KHTdPiez3/Lns37X3
        MxrtHm/82H9aca4SS3FGoqEWc1FxIgB5xk3C8gIAAA==
X-CMS-MailID: 20220628044432epcas2p2116480d15be87cb723855b7a39ced6dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628044432epcas2p2116480d15be87cb723855b7a39ced6dc
References: <20220628044222.152794-1-chanho61.park@samsung.com>
        <CGME20220628044432epcas2p2116480d15be87cb723855b7a39ced6dc@epcas2p2.samsung.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7f0faf0d75d9..b3c50c7665fc 100644
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

