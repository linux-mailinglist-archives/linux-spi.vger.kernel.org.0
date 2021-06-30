Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281F73B81A2
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhF3MHV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 08:07:21 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:17337
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234498AbhF3MHT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 08:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dduNLiLuzh7zeEN89x/uG5T9Lyio0y1s4T/DN15CxSdv+StRUKK9ErYQixWAivHTE6aRxnGxVFFigH+1XBCJGas5J4wSykdfM7pn+7emhhrV3VdHr3RcPsih6A3AWweOrgKRA9hM3VYdmGrXRdh7BUkusZd8y1oAnlJ1k4ItgXDrlVMkZOH5Qtor3uGPuz61atzJM94oeDjV4Nj+NvKIcDV+l+e0vujgBwupwD94BCAK4gjRzN4f1tpwjuhNw4jBySuVV7850IitBFEQ2UFAPbNRM42jLFwyASs//gGinUJhVpUl1ebb7VWPPRv7q5HunVlZzg8D+fOdtAcKEaQrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR/ArOBgut+NAPXxXwppebwgI2N4y+/+c0hbpjqcmO0=;
 b=FwQ/ayRUjgXKBlcRIUIdj42ttTXUE6wjofr1R/JxWcwBn15E51I0iNZiTJ60z2mCeqZPmVn+WhdveQZ/CLVskYrR8MBRsm50xCwpLwY3x+c5Dckw7ZI+PKkaJA359+bQT6OQq20ytmPcxpsUqddozZZ2mZBtiOGGtYZ4tg3fWcXJxvv9v53CMf25wFgZngWUN4rkCG03bLsTelLrnSWNmu7FtxQRFMipYD3xKS4GivuTE6bj8D+UNQtbGzeVa96RtzdQp+cJg64m8CENfSTxLvCA9RApQWJoBz0LY80xT+P3kJdj2p+Yyv6cLS+sHUQFzwpILwZKzzUOus4vNw/jqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR/ArOBgut+NAPXxXwppebwgI2N4y+/+c0hbpjqcmO0=;
 b=CSL804gryk5YilrJbBNVlHi/yIgkEpF98ZxeOVYIb1iocHKBwM3Cc7a5aWoxY+DqGROL5JrIGISJD18/tCGlrhXipGCu0Xq32HIOcSYV9vObUb4KY/1zfIBAsxrWxZfTjxw5S3rtR51ptz+tb6q/FKKhvRotmwTfS/NyeBZI5pg=
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by CH2PR12MB3816.namprd12.prod.outlook.com (2603:10b6:610:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 12:04:49 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::9e) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend
 Transport; Wed, 30 Jun 2021 12:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 30 Jun 2021 12:04:49 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 07:04:46 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>,
        kernel test robot <lkp@intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: [PATCH v3 3/3] spi:amd:Fix for compilation error for non X86 platforms.
Date:   Wed, 30 Jun 2021 17:34:25 +0530
Message-ID: <20210630120425.606957-4-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
References: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd2d4ead-7623-4d97-a9f6-08d93bbf429b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3816:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3816E9575AC1F89CBBBAB949A0019@CH2PR12MB3816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPELlNzL5OUZ3UxE7IcmViRKGUUZiniCt52CI+AueAir+G+KYn3DcvI2HuPtcDlenG3TQAAzNyjDDs+K4/k6N/il/j2wJvvNX40NJVz6SbH9WqcSN/oyXUWvMg7NnH1GRXSQR9CKG3hfG5w7MrAFT6qsrDpByAeKixr5mKUFURsKyYAwI3kRsB31I7Sk35Y2KtJUwjVQmK5EHTtV+CZ30o5rWgomr1mxXLziXa+ndKLjIBAkaESnUi8TEXpTaFsMn7JpZjiI0w/aTdzadLIZnC4OJQPy0i7fakox+0YegL/EWNJ2KVHdZ01Aj/rBWhi3PJiOk6a6XLdF+ZDmbAMlsor1AWXlE3AXJUcKro5L9K87Y2NQuJGmQcg+p1Moqsh86hgmvJeGzq7idnUfLtrLikA2LNQEeXms7Ocm/jmvfFQG1IWQSqTaV1Eei8GlVyTnsJ+my3smAOBJo0eV0HIUxXkM2drGrUvyckhFMkK0bF3cpGBfIbQx4YSoaWGv2rH6HTEiRnf7vqhemOt4btD1Ymhm8z6NF6JqRTlyzqrIJsUSXFrwo6WgTv/20XtOPQLwj99zp8d4MImAolO0S+dH+YqrnSiRLyFcCeiXS5ps/lDfvvvJuLi/lRa6h/2WDSkPCtDmY4QnglyG648n/CpM6pqfEIKWSfAHgtUIpk5GkwbuwdZK0JeP2oY/XPPjrYPn6YUUTXD9H7YFzbj2lSA0H1n9qcW2tH5xiQkDnJqvtLc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(5660300002)(83380400001)(82310400003)(478600001)(54906003)(2906002)(4326008)(8936002)(7696005)(81166007)(16526019)(186003)(70586007)(8676002)(6916009)(70206006)(82740400003)(356005)(26005)(36756003)(6666004)(36860700001)(47076005)(4744005)(426003)(86362001)(336012)(316002)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 12:04:49.0266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2d4ead-7623-4d97-a9f6-08d93bbf429b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3816
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update the KConfig with dependency for ACPI as driver is only
supported for x86 platform. This fixes the compilation error
reported by kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Liang Liang (Leo) <liang.liang@amd.com>
Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e71a4c514f7b..532387929085 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -978,7 +978,7 @@ config SPI_ZYNQMP_GQSPI
 
 config SPI_AMD
 	tristate "AMD SPI controller"
-	depends on SPI_MASTER || COMPILE_TEST
+	depends on (SPI_MASTER && ACPI) || COMPILE_TEST
 	help
 	  Enables SPI controller driver for AMD SoC.
 
-- 
2.25.1

