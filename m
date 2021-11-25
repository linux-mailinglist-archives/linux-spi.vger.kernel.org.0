Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA21845D7CD
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 10:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbhKYKB1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 05:01:27 -0500
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com ([40.107.223.62]:20193
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354091AbhKYJ71 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Nov 2021 04:59:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjgfVSMKOcjBGI+TzxBc6EIkYT4l2WcVYcaCNIYLvzYB5aeoFdULgCo/Ie7gslMz4pR/OpFpF1uMWUFVfPTG6JzbgHQSZOwTIVCluS2v9E97mBM5lEnc3OCOh6wfFG9HWpwVZtXqnl4NZAxad0zBVNHYc1ixtWVJ5d9wAPAzjpAGsjzxAiq345MUAsmdSLLMg3ve+lZ5zK4rdpZ4j/vQQeTTsShqXMBGix1bbuO7Pq9N0OWd2CuGU/v2mVPQ/7kNMzIomP3wUA+s9sm8WuGDZmUiL2Qz69cN80TIcPiw1+u5b7oOQwULKQB7xlYzWFs4XWCknIb8p4v3Kord92Xq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKOHTZ8sxZlNIkWbInk0cfd1ut4fbU7U3yP/JoH5I6Y=;
 b=cnCwaqZIULlQdutXG842Zn6MlHKV/sJqCx08XXO1KAsLX7FujufEPCPimE3xAlh5+42T7FSFKuTU+M4IZhcCK8KVgCDrKWl955410Bd0J+LR7jFp9YssLFcp8pQHTRS/qF/q7ALLj3zXrAVFwaWKtPycJ6k89MDDFg3FpJWthb3Kpi50+G7amoJ2yer7BsXEAYM6OxihUp0xdMulU9Lrc9cWYOa5bid+yJZsgHJBte0ttpowvg/nnUoPu9FMt1jVSppBhSOV+ZUv4pAk90lzBn5257hoQ80WdCN5MOjMHzg8PU9f2HC+jedZjoKcaWCqD5hCeAU2YjSC4UT+iXoLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKOHTZ8sxZlNIkWbInk0cfd1ut4fbU7U3yP/JoH5I6Y=;
 b=pPyrcsEu7INNxJyjPmTRJHXGPwmEgCAQ3kEcAVRYA5IM/7GTUsARfK0DbTPluZhIumgSsazHsUmZD/GqF4VYvy1C20KsSzz82cl3/q2jPih6dapq2wlWcAidxkn6+WPfe3fuT67IPIUNAEJ/odqJY+FKkIVSxyEntrNobYW5vK2ZW+77O5KPTb8hrs/w4jsVJifPPpYgdNiyIJ3howjKBcDYwZGoWxf5R7/j9qNNiEF8O8EB/Wj9DBqdOIkMgACrj90soBHyJbHKyUA5epzJEDV4D4E/MdoSeoxR6i/oWM5dOIq5/plZkSbnSs40G46H/4B+AOnrcHJsg8urmvawFg==
Received: from BN6PR1101CA0009.namprd11.prod.outlook.com
 (2603:10b6:405:4a::19) by MWHPR1201MB0109.namprd12.prod.outlook.com
 (2603:10b6:301:52::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 09:56:14 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::2a) by BN6PR1101CA0009.outlook.office365.com
 (2603:10b6:405:4a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend
 Transport; Thu, 25 Nov 2021 09:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 09:56:13 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 25 Nov
 2021 09:56:11 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 25 Nov 2021 01:56:08 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>
CC:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] spi: tegra210-quad: use devm call for cdata memory
Date:   Thu, 25 Nov 2021 15:25:51 +0530
Message-ID: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec9a35f-2eff-424c-9ce6-08d9aff9d13c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0109710F218B81BB6362899CC3629@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+cjT102aFeHIHvdFB1WJbAZ2527RmKQ+4OV9/dUpxahIgOkDmCPWyo6pU0l8soWLo5NE+qzH/w0IXF4CHAo9K+NXpQyQriqwmSJ/VXnAkGjLsyuRfL/vX1FXe1aSu5S9umemwb9xw0vQ+MLxzJwbtRqRNLBBXurytC8/zbhoIqAJVbmqzp1EyE880tGFvVF72HBRg/Y7WVfymn0adejngEuvL3hE2A+qTygtukfXuqcBqeHZLWbR2cIHAgVbQZ7ePLR35O2u87jKcn9qgYhpPEhHQ71TeuXvXnA4qNr5Z4v/v1UVGokALWGLPLGBC+P6ph7e+wYBIcCBRT7oCrvb8WazVjSP6X52P6Hym3wIETowlGQfsvAL9n931+W0WKZBLQp01tFsEPbsUD09U9AltFF9GzUt6pN3NnjCt2JjIVzO5Syg3qwcxaB0Rz2grXtymszTy2H7hiejPZzydGeQ6HIFicI/GdbZA3ZHNNnyvYPS7hOTwfS0+2dY1wI+zI0TJN1A7o5jp60bLgCeruA8RQYacEHN9GnkiCKLDo/G5jcVrT1JZ6H9nLtuZORLbnlsVinhcUPtQWTpcPI9lHTBUm516dg7d0MDT5jHo3GJozI0LdxZ9hw2K6olzmi/OLui9pbkcZO+qgZFgi39/627Byw2N4SEBVUO81NRLwj+paR8WJ73uePJ2DOpUS0cRwJ2dHauTaXnR3IxFiWd03UUw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(2906002)(110136005)(54906003)(7696005)(36860700001)(26005)(47076005)(426003)(4326008)(336012)(186003)(82310400004)(86362001)(6666004)(70586007)(356005)(70206006)(83380400001)(7636003)(2616005)(5660300002)(8676002)(316002)(8936002)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 09:56:13.9864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec9a35f-2eff-424c-9ce6-08d9aff9d13c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm alloc call to allocate memory for spi controller data and
remove free calls from cleanup.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index c0f9a75..ce1bdb4 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -877,7 +877,7 @@ static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_devic
 	struct tegra_qspi_client_data *cdata;
 	struct device_node *slave_np = spi->dev.of_node;
 
-	cdata = kzalloc(sizeof(*cdata), GFP_KERNEL);
+	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
 		return NULL;
 
@@ -888,14 +888,6 @@ static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_devic
 	return cdata;
 }
 
-static void tegra_qspi_cleanup(struct spi_device *spi)
-{
-	struct tegra_qspi_client_data *cdata = spi->controller_data;
-
-	spi->controller_data = NULL;
-	kfree(cdata);
-}
-
 static int tegra_qspi_setup(struct spi_device *spi)
 {
 	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
@@ -1229,7 +1221,6 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 	master->setup = tegra_qspi_setup;
-	master->cleanup = tegra_qspi_cleanup;
 	master->transfer_one_message = tegra_qspi_transfer_one_message;
 	master->num_chipselect = 1;
 	master->auto_runtime_pm = true;
-- 
2.7.4

