Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D36417013
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 12:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbhIXKL4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 06:11:56 -0400
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:48704
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245436AbhIXKL4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 06:11:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUUzfH33yX/65KSeElGdZJ+agPNdlyUEwSPdPga2Y2b8HaNjfQ8PviZRNOJc7SFLbIXD2F2svObQJRHHfFgKX5QybvFDlDk8oXF4dJ2NqqpdgLtkSJYSkVbJa7FUdksHHqkSxvMGQzqfDmzLbUfSKthscmKTiZIPAiodLNoS7SbM9NETPfrQQt0/s1FMhdTK+gOpyVn35m4LoV1BRl7T+lFD60JOCLqcSrJKXEg27A4MVMP0z9ESbRy2RseOC7wbfghC6oeFBX45EQ/Yhdqg9DXxD+UpPNOzJ9YuV9HubbkkwkDf1Wf2WFoIcU4tHAIEzgsIrsYCKA9tkem1Ms9xkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D0Dkv3uiJ5+JoiZhPqd1e+U3suPX9un9OfR0l27hITg=;
 b=lCB4PKnU5Ghh6kRsBsOMAExzPUbmWGFMEpKDMj9izMew79j49c6MKXyJ7taHxyjym8Gxm5cwpfm26U7UnjOwztNSsguqIZO7yrR5ItyD+kZUN4Djnn4+eZk7+U+SYx+zsk0NyKq7FRnjsyDdqCCHu5IiIBR1G6+L1hO7fxft5wy/f5K5qkbw61scPXPyNfAwZxlZ1eemGGH4AOZ8FEZc502BrWcnkhqOZUX22lUL5yYje3MKc6JQkEkcdeULRMbF9/m90exkvzGy7daKlqCx/zwXeZojA/O8gc4ScgIZl0i1AJ2913hkm7RbYpSmVdSjmuya8m1EME+hr4gN16LidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Dkv3uiJ5+JoiZhPqd1e+U3suPX9un9OfR0l27hITg=;
 b=Q5/rwMsMhudSaL8gWGSIbRtXfwxAbTn0U/LN2+chYLmCA201VgHa0fP6RwexlHIU5ar1VRkPawt0Qp4sxXS66BlVuXcVbROl1gC37+VG9xR3FPRgVPzBRwd26Nr9QkpHpgs4gkX9cCkr8INB/aktovM0SA6h1Oqg3th6+n+NEgQ=
Received: from BN8PR15CA0056.namprd15.prod.outlook.com (2603:10b6:408:80::33)
 by CO1PR02MB8427.namprd02.prod.outlook.com (2603:10b6:303:156::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 10:10:19 +0000
Received: from BN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::8c) by BN8PR15CA0056.outlook.office365.com
 (2603:10b6:408:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 10:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT059.mail.protection.outlook.com (10.13.2.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 10:10:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 03:09:58 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 03:09:58 -0700
Envelope-to: git@xilinx.com,
 arnd@arndb.de,
 saikrishna12468@gmail.com,
 broonie@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 iwamatsu@nigauri.org,
 p.yadav@ti.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.63.68] (port=41314 helo=xhdvnc208.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1mTi9U-0003aL-Le; Fri, 24 Sep 2021 03:09:56 -0700
Received: by xhdvnc208.xilinx.com (Postfix, from userid 14964)
        id 4C05F207C0; Fri, 24 Sep 2021 15:39:16 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 3/4] spi: cadence-quadspi: Add OSPI support for Xilinx Versal SoC
Date:   Fri, 24 Sep 2021 15:37:10 +0530
Message-ID: <1632478031-12242-4-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe9c912b-ec0a-4f47-4149-08d97f438386
X-MS-TrafficTypeDiagnostic: CO1PR02MB8427:
X-Microsoft-Antispam-PRVS: <CO1PR02MB84272C38E72796F059A57BA7BDA49@CO1PR02MB8427.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lZZoGsrxuIcGZwgeCNQYWG8SSZjCQ2/kEGXwaW0lWLLaJogXUwdjjRy9ml5woNzmXSvtMFZrvX4E7fcMqR/+Y4zS4CYxXK/MLibjw0AOAe8J5FdehoLrdgm/jRF/X6F0aabdG8qUOenta7tTwLddfcBju5cKriPP0q5MePETt3iv2iCcfxOZ/q62+FzwyBQVIoC1OYdm9NuzfWc1FyQP0Sa4WzS7U9O+fFww6gKgawU8N2Fz2qk/DRse4m3Al/MYSNuW1gO2v/wD3lj67C/0y2qM/mOv9Ylg8brfjcY2eGik4O1AhSdAHW2tJfWaHM38ARRsqfoYQXH9re2O7GPSrcd1Ncsdqa4otPGMkOLQG8SpsuMDgm3BmshKp+KgYrbhW5nPwRlEQ1xuaONpW7BYOLlCcT9r/4A9MrHmcbK+AOaIQfwpFd3nXICRbmjvKOcwIis9P0VB6ti6h4E+es6er6+eMAKUbYlwMUm0xUpmCsnSBUcNOh3HzaIQUQA2A8WFYYD8FRIybzLS4VUYuni4yfbdRlrO7XGHQoYFpLj7TQwPg2rdi6Dr0qFRb0FRo6/82WvT6R6B2Nb39hOICno1BNMe9AsYttk4IGc/+88Eo0EpaVknMu71QLzSzGysEywSyC5s7p+mrS59UMC+VTBqTjP7KXp/HpRvXpaP7BpYpi6zGJCuGtIylT9gNcyKoJ/zVUe9kJ8lY3Fauke/M70WUShDDcLfFHPciKDrQg+pyQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(70206006)(42186006)(6666004)(83380400001)(7636003)(356005)(110136005)(70586007)(54906003)(508600001)(4326008)(8936002)(316002)(36906005)(7416002)(5660300002)(47076005)(2616005)(6266002)(426003)(107886003)(2906002)(336012)(36756003)(82310400003)(36860700001)(26005)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 10:10:19.4396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9c912b-ec0a-4f47-4149-08d97f438386
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8427
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add OSPI support for Xilinx Versal SoCs.
Disable the Direct Access Controller for Xilinx Versal OSPI.
On Xilinx Versal platform, AXI interface need to be selected as Linear
mode (driven from interconnect rather than external DMA) to use
Software triggered 'indirect' mode of operation. This will be achieved
by calling Xilinx firmware API.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 drivers/spi/spi-cadence-quadspi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 101cc71bffa7..32cba7830b58 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -13,6 +13,7 @@
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -82,6 +83,7 @@ struct cqspi_st {
 	u32			wr_delay;
 	bool			use_direct_mode;
 	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
+	u32			pd_dev_id;
 };
 
 struct cqspi_driver_platdata {
@@ -1299,6 +1301,7 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 {
 	struct device *dev = &cqspi->pdev->dev;
 	struct device_node *np = dev->of_node;
+	u32 id[2];
 
 	cqspi->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
 
@@ -1323,6 +1326,10 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 
 	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
 
+	if (!of_property_read_u32_array(np, "power-domains", id,
+					ARRAY_SIZE(id)))
+		cqspi->pd_dev_id = id[1];
+
 	return 0;
 }
 
@@ -1548,6 +1555,15 @@ static int cqspi_probe(struct platform_device *pdev)
 			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
 			cqspi->use_direct_mode = true;
+		if (of_device_is_compatible(pdev->dev.of_node,
+					    "xlnx,versal-ospi-1.0")) {
+			ret = zynqmp_pm_ospi_mux_select(cqspi->pd_dev_id,
+							PM_OSPI_MUX_SEL_LINEAR);
+			if (ret) {
+				dev_err(dev, "failed to select OSPI Mux.\n");
+				goto probe_reset_failed;
+			}
+		}
 	}
 
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
@@ -1656,6 +1672,11 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata versal_ospi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
+	.quirks = CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1673,6 +1694,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,lgm-qspi",
 		.data = &intel_lgm_qspi,
 	},
+	{
+		.compatible = "xlnx,versal-ospi-1.0",
+		.data = (void *)&versal_ospi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

