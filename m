Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6915139EF53
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFHHR2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 03:17:28 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:32416
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229518AbhFHHR1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Jun 2021 03:17:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMYeC1m8T+uF3eHwnteAUwc/AKb4V8LCiOjILwY4/tBcSE/lWQyfxNlzN+vNqXJRn4bkxvKuxjAs5T4BTqdMTBho9KdMP5MeKGY4ynY33m1mFc/2+bseL2GpMpb0p1nn7PYsahM0IPST2l9UmFoxdMXaRC3v5pg1U4VTHaYlcpv2PBvtz6fWx0QDatwiHMrLgbel5TNiw7H8Tndz2p8Mr+MYJJMaycYOLH931pfWOTJrOXjxRz4CsZGIhHz5wvXHKrEiIy/qiLtxjQZdGB1WbVA3wpRE2QgerlT9KVF6vgSI2+d0thutpzqFTJDIkGGS6f0gCtfeIHWbRa5P4CQR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttZGNSqHfiFpTjjBLHNdADY9lQ+ORcHETsuh4UQyAK0=;
 b=i/ft+ayh3dW4Zn2OcBO+Pk6wmIR0Jvnhuj0YCXiXYBW4f9xWEcyl/wx0qbCbcll9huNuJgfp+KsSPMRAEsdTVcYTCwfQnS5L7LNv5QsAzuLAaXGgmZgkjrhtTVfG1KDzmx2bsCAUyPOnMrq5eb/q1sQlS4G2sX/CZWNLR4oWWWtwHoP1/8qIieq5ZJ6dwr1xfDFhXM4AEPwe08kC2yUeK1pWRWypiSxbIKpkRRETTiwlRdwFC3zrT4XVZSWIxRsWeB8vUD+Hk24wnCsRMOWCttVXLLg48r4klUtzZEOt8nqISBWzGC8+9t4nIsU3TSeUrO8JwAW8AhgEUK+X6CBWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttZGNSqHfiFpTjjBLHNdADY9lQ+ORcHETsuh4UQyAK0=;
 b=cq2tglZeyRke0okc8ACNGI6ZR1tNUpeI5NqN9q/K5jx+aj5BWb1L8ay0XHJ3+sR+JXs4iwbgPwgHZ+KSf2cR7Y7SCpw4sh4rpIGo8R3O4WN2lA92LBdN8XNtOxivfT6/p/w8LCdRzSrCo2yuiIIAEshrHM05AV0PsNcQw72QVtqiXQKer7WyvQgtfboZLqjvM1cxSry3fuq08614bCHL6jHKEDlLCAfihRMs8kRFz1c+t841VmtH+HJXfLSIWOQGExRxnfxrIzTFseI/Dtrv/BBFDjUAWH3c1ngsVi9w3hqy1S6RfEeTws3ursh1A/9Pm48IX7TbcFiCY8DzOYU7XQ==
Received: from BN0PR04CA0209.namprd04.prod.outlook.com (2603:10b6:408:e9::34)
 by BN8PR12MB3076.namprd12.prod.outlook.com (2603:10b6:408:61::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Tue, 8 Jun
 2021 07:15:34 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::22) by BN0PR04CA0209.outlook.office365.com
 (2603:10b6:408:e9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 07:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 07:15:33 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 00:15:32 -0700
Received: from moonraker.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 07:15:31 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Dmitry Osipenko <digetx@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] spi: tegra20-slink: Ensure SPI controller reset is deasserted
Date:   Tue, 8 Jun 2021 08:15:18 +0100
Message-ID: <20210608071518.93037-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f24a6b45-2a7d-433b-c43d-08d92a4d350c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3076:
X-Microsoft-Antispam-PRVS: <BN8PR12MB30760C61E893AF158D262024D9379@BN8PR12MB3076.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZm7ISHW+BPTBhdbP1vbN2/v3dYgeKCp6fov4JsgSL1kHILRr+lfTYqf8iRiz49xdm8zlDp4RN6PjxplQFkraYnUme+9xCv9kjF2MBUAt3ElIrJVJ0u1i0FDLAsy/uuxmYV+mRJ82po6QnR4JZdnbR7VFVIZX2hdWBk+RWbQT6QaXbXefidGyeAeh6MEzQs1YrmlMzz0oHh+qczVsd4dcfX4BQEUnkSwIdGlcI9ZLY9rPCY0l3uDk4zFSxDohKdhlOM0hnzWYq43Y00JLmSFWNvC+ASk4iMSRiMM3nX9I5t5FeiznewUZKNT6o2OPK5BN8Oisu/3WrdQh9Fk0lqhODiKBzEglOFkQhvDbujD8csDyA6ypOMRpFPrB/ph3s4Ef8Wgquc3I3KoOaQbQ0Tbr7UeshfTI4+St++ZmnzuK83zqTGxl3N20rPOqe1JFYSHt3NUFCAlVNRw9OBhYyX4Tzf1utiezFbgxtutoHUKorSbc5QorqslCdxGkfQV+NGAacn9vcq9CB8CTgMIstqg158WtkrxF33xaUWCrukaj0NZyZDtsMsZ0AitS946oTIBdJ7SCnjHW7AidW9YulcPbQDvMrOXtxhQFKCWFLmZ/ttrnR1FKmIsr8HV97Kh0eMNTXEVBSEJectL+2S84yHgrgioCwYN+bIxRfaCPLyw4pw=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(36840700001)(46966006)(47076005)(426003)(336012)(7636003)(36756003)(86362001)(1076003)(6666004)(7696005)(70586007)(70206006)(5660300002)(2616005)(36860700001)(8936002)(82310400003)(82740400003)(8676002)(107886003)(110136005)(54906003)(26005)(4326008)(316002)(83380400001)(356005)(186003)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 07:15:33.8651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24a6b45-2a7d-433b-c43d-08d92a4d350c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3076
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling
clocks") removed some legacy code for handling resets on Tegra from
within the Tegra clock code. This exposed an issue in the Tegra20 slink
driver where the SPI controller reset was not being deasserted as needed
during probe. This is causing the Tegra30 Cardhu platform to hang on
boot. Fix this by ensuring the SPI controller reset is deasserted during
probe.

Fixes: 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling clocks")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/spi/spi-tegra20-slink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index f7c832fd4003..6a726c95ac7a 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1118,6 +1118,11 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		pm_runtime_put_noidle(&pdev->dev);
 		goto exit_pm_disable;
 	}
+
+	reset_control_assert(tspi->rst);
+	udelay(2);
+	reset_control_deassert(tspi->rst);
+
 	tspi->def_command_reg  = SLINK_M_S;
 	tspi->def_command2_reg = SLINK_CS_ACTIVE_BETWEEN;
 	tegra_slink_writel(tspi, tspi->def_command_reg, SLINK_COMMAND);
-- 
2.25.1

