Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9D45D7CF
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 10:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350024AbhKYKB2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 05:01:28 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:31296
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347793AbhKYJ72 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Nov 2021 04:59:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7SMvna9RH9tC7K7omJ2p8n1vYyNk4da51v/Nope0TECrITBqv05hVVe33/P62nVpkdQ59nuWmuZmUJNaK+wTuDCP2VZtSnfYMuD2Zqa1mFdGN4/mRvyoZIOQ2l0LMgqHz4rKGF4QRx6+ZCdnVxYug1URXBhSOI75mMxw5dMRFA/1ki9k5bbQeHjhDGRmoePLD0/gb6VWnIyz6KYQEKhv+T0ltaXmozj8pAZo637pbeM9ncsWGTAphKDJyyoGLqx8lXyZmD8CLKAguRa2LeUIdJUG9OeuFvO5TJ1AXrT6QRHh7Pp6QMYQfMgGONIDhBmrnSF5rvknHZ+BKSIU4IeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6X7sv0mgRedp6/gRHB3RCvjWo7ithMwxxZeA6oJHrw=;
 b=Hg2qd4KvKnvh0CIj9yBAY7jl/GV6q7tHeG18xtVToJAJ+Q/pu5hvmx5Kxqz1Uyy6TkfW/mDe9Ch2CMW5flxpSxIwsrq4qvDEIRBMqk7159MBuw0D2oz83siDisOTAN5jNQ/gBIhfCoB8W4Iben38BCYZzgsTpakgBZw+UZR19lzWvplBjgiSrZjWbSOFJ47S+ebD2XSpLATXS/Y2hXZkmbq0pvs29zEKnUDt5TBmjt2joJUa9gfNZvVe10Fh4/IkxhevKnyca5Z99cSEKAMpzM7ISglQh6vggZEIS5ltEdB1kXnLRUfFL7KKJBKeJrkKSwovgcoY9PSyfDOL8jQCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6X7sv0mgRedp6/gRHB3RCvjWo7ithMwxxZeA6oJHrw=;
 b=aBJbfdjqtY19cmmtZkj0RMcDobpM7MQ3GuQFwdHuLo773nm/dV/YWbVCqTB+lRgjHCnbwSqcscuB8vlB6Esot6FqTBf431Xcz9KXHO9qZQJPz0Gkn/U8HLGhHNRu/VfS+jH+2hX9lj5N1V1e+k912blxADncflrU3SpRnHQpNnx6I4maRbmjoyuWUlFN0DJz8fmLkSjsDYA0+2xWjP8vbcQM5gt8MObhRf8MkS0l5+f/kq1sXVervRyN7jV0O/WWNbVdZYY1AFCkD+79Aj7768+2NceEEcALk3qKkoWfbfFg7rEXZC/BuNAkJoDoQcKs6bGiYusWTxdSR+uwpRfpCA==
Received: from CO2PR18CA0065.namprd18.prod.outlook.com (2603:10b6:104:2::33)
 by DM5PR1201MB0170.namprd12.prod.outlook.com (2603:10b6:4:59::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 09:56:15 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::c0) by CO2PR18CA0065.outlook.office365.com
 (2603:10b6:104:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 09:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 09:56:14 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 25 Nov
 2021 09:56:14 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 25 Nov 2021 01:56:11 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
CC:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] spi: tegra210-quad: add acpi support
Date:   Thu, 25 Nov 2021 15:25:52 +0530
Message-ID: <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dab4b455-40a2-4dbd-ded8-08d9aff9d1c6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0170:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0170559C17BD0520AE16F3B2C3629@DM5PR1201MB0170.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn+HEo8+BZewjNyoDmD4W2E50n+b5J8WnC2EWJqGBanX/8BoLM/aHCrlUh9Y7Kx8DgZY0U1ngGSuaaZiXgIfiPQZLRhB9K9POPj2t0MCUMCm03JsXrFrX4QvexMsX9fO0VC3v5CGzhtH605CNp/6LLqdZsltnAzSn2VH7ePf9a3ogom3aESyEtdLHoj2sWJvzKVn6VUT1W2rk1GFakDwUzU07dBae1li2MbztUeibg6RPzcmgCKO7YCepe2FJtjlbhcyawluWQwYMBHBDCwtlAnXUOoCnaezv6I/0/auMfViQ2rHdtpa5YhvgRmgiaXdsBH26K7T6aPp7hfqpoPZuAc0GSgm4O2KYBNZwVnref1NU9764378h/1CdvKBJl5jZkiHiz4XkJX00KQH7iO7hjDYUFHuMZ03SyF67X/4qGCxXOEri0cN0ZBSJBauLxQqN0sj1CbImGOVtfzO8/UquSLtBIWlRl9H1dSXzLAeV2GEk6FZHbf4ZERKiSfYozmR4DlHFayCGtEpvjk0K9q0DmSTDMBsg6LCcuKYsKL38NHg3hsP2KmdUH3iVGzyCdf6yhM3wnOmB7UhGix4xDe43HCQsdKvErhEaqEQzGRPLkSnlJxKAXEn1R6clGyW/OENh9tOGaqbhppQwb9wYALEaZ0Jde/Syzj8+S4+icKz4lMieEVKL57S8r7mnipd9asbGEyRlrIKOrdwfn6vV8JzyQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(8936002)(110136005)(54906003)(5660300002)(6666004)(70586007)(47076005)(82310400004)(508600001)(426003)(336012)(8676002)(2616005)(2906002)(7696005)(70206006)(316002)(7636003)(86362001)(36860700001)(356005)(36756003)(186003)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 09:56:14.9716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab4b455-40a2-4dbd-ded8-08d9aff9d1c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0170
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Support ACPI device enumeration for Tegra QUAD SPI driver.
Also pick device features from device tree.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 74 ++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index ce1bdb4..20c1fa6 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -21,6 +21,8 @@
 #include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
+#include <linux/property.h>
 
 #define QSPI_COMMAND1				0x000
 #define QSPI_BIT_LENGTH(x)			(((x) & 0x1f) << 0)
@@ -767,7 +769,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 	u32 tx_tap = 0, rx_tap = 0;
 	int req_mode;
 
-	if (speed != tqspi->cur_speed) {
+	if (!has_acpi_companion(tqspi->dev) && speed != tqspi->cur_speed) {
 		clk_set_rate(tqspi->clk, speed);
 		tqspi->cur_speed = speed;
 	}
@@ -875,16 +877,15 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
 {
 	struct tegra_qspi_client_data *cdata;
-	struct device_node *slave_np = spi->dev.of_node;
 
 	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
 		return NULL;
 
-	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
-			     &cdata->tx_clk_tap_delay);
-	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
-			     &cdata->rx_clk_tap_delay);
+	device_property_read_u32(&spi->dev, "nvidia,tx-clk-tap-delay",
+				 &cdata->tx_clk_tap_delay);
+	device_property_read_u32(&spi->dev, "nvidia,rx-clk-tap-delay",
+				 &cdata->rx_clk_tap_delay);
 	return cdata;
 }
 
@@ -943,14 +944,27 @@ static void tegra_qspi_dump_regs(struct tegra_qspi *tqspi)
 		tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS));
 }
 
+static void tegra_qspi_reset(struct tegra_qspi *tqspi)
+{
+	if (tqspi->rst) {
+		reset_control_assert(tqspi->rst);
+		udelay(2);
+		reset_control_deassert(tqspi->rst);
+		return;
+	}
+#ifdef CONFIG_ACPI
+	if (ACPI_FAILURE(acpi_evaluate_object(ACPI_HANDLE(tqspi->dev),
+					      "_RST", NULL, NULL)))
+		dev_err(tqspi->dev, "failed to reset device\n");
+#endif
+}
+
 static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 {
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	reset_control_assert(tqspi->rst);
-	udelay(2);
-	reset_control_deassert(tqspi->rst);
+	tegra_qspi_reset(tqspi);
 }
 
 static void tegra_qspi_transfer_end(struct spi_device *spi)
@@ -1202,6 +1216,14 @@ static const struct of_device_id tegra_qspi_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, tegra_qspi_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tegra_qspi_acpi_match[] = {
+	{ .id = "NVDA14E2", },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, tegra_qspi_acpi_match);
+#endif
+
 static int tegra_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
@@ -1242,18 +1264,20 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	qspi_irq = platform_get_irq(pdev, 0);
 	tqspi->irq = qspi_irq;
 
-	tqspi->clk = devm_clk_get(&pdev->dev, "qspi");
-	if (IS_ERR(tqspi->clk)) {
-		ret = PTR_ERR(tqspi->clk);
-		dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
-		return ret;
-	}
+	if (!has_acpi_companion(tqspi->dev)) {
+		tqspi->clk = devm_clk_get(&pdev->dev, "qspi");
+		if (IS_ERR(tqspi->clk)) {
+			ret = PTR_ERR(tqspi->clk);
+			dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
+			return ret;
+		}
 
-	tqspi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(tqspi->rst)) {
-		ret = PTR_ERR(tqspi->rst);
-		dev_err(&pdev->dev, "failed to get reset control: %d\n", ret);
-		return ret;
+		tqspi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+		if (IS_ERR(tqspi->rst)) {
+			dev_err(&pdev->dev, "failed to get reset control: %d\n", ret);
+			ret = PTR_ERR(tqspi->rst);
+			return ret;
+		}
 	}
 
 	tqspi->max_buf_size = QSPI_FIFO_DEPTH << 2;
@@ -1277,9 +1301,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 		goto exit_pm_disable;
 	}
 
-	reset_control_assert(tqspi->rst);
-	udelay(2);
-	reset_control_deassert(tqspi->rst);
+	tegra_qspi_reset(tqspi);
 
 	tqspi->def_command1_reg = QSPI_M_S | QSPI_CS_SW_HW |  QSPI_CS_SW_VAL;
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
@@ -1353,6 +1375,10 @@ static int __maybe_unused tegra_qspi_resume(struct device *dev)
 	return spi_master_resume(master);
 }
 
+#ifdef CONFIG_ACPI
+static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev) { return 0; }
+static int __maybe_unused tegra_qspi_runtime_resume(struct device *dev) { return 0; }
+#else
 static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -1378,6 +1404,7 @@ static int __maybe_unused tegra_qspi_runtime_resume(struct device *dev)
 
 	return ret;
 }
+#endif
 
 static const struct dev_pm_ops tegra_qspi_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_qspi_runtime_suspend, tegra_qspi_runtime_resume, NULL)
@@ -1389,6 +1416,7 @@ static struct platform_driver tegra_qspi_driver = {
 		.name		= "tegra-qspi",
 		.pm		= &tegra_qspi_pm_ops,
 		.of_match_table	= tegra_qspi_of_match,
+		.acpi_match_table = ACPI_PTR(tegra_qspi_acpi_match),
 	},
 	.probe =	tegra_qspi_probe,
 	.remove =	tegra_qspi_remove,
-- 
2.7.4

