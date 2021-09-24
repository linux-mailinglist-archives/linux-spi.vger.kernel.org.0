Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDE941700C
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbhIXKL2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 06:11:28 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:9408
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245488AbhIXKLZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 06:11:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIWdD0hk11hyq2xgin8im3yGLmAMBB8TW+OktEQPUN/R2BIRpiMwNtwQhwqylm41DW7nQK675tS3VLAFYTyahTU0MZyEFGuInxF4PxND1Kzk+WBcUSP/2iepPcydUn091UfVEzkZrT0KFAGPg11Qo1aGGCrU2mQS/UIalfrF7xcbLxT+BJD1PiypImjiSQYP86vwNnG01dYPG/x2W1pr7sZMZDyQu0QBPqhn8d99KwNWXZwT+2TRmpzijgADszmrYlQCN6Efpisqof2Ix0TzMqynEVyhs+JwyKb215nUJM1mwecs9SCW+pDVoHiszO5Jues/yb3uSIIVgVgFYF9gIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OKS2Kk8HyZHQbRCdNbxIQAtleox1qV8SwEh+GS6i5kw=;
 b=EjW154WLcvsoICSxZ/sPw9Pt94GdcpXraQABf7eiglwInhpr3MW4RK5eYMtP9RBBbG5rJkJCMDQ31U4GmyCvYFGDtvMq71fRhmMr0zZWPdsSxj3U3CW+mr6omUoj0HlJMGc8ghmes1ft7+dB5f5FqXDUNJKsipUDIFc+ZwMVW+zqZoccIyBucXOunWwZfdWI1KK1mPK1sMsjOiMm3bitnpvl+LxkLuiMXwF2V5WcZLqXQwd5bz9Obg4CWWvlDggVCzfMB2JElxywcrq4tom1Z0OP2u4OJWHlBonZ2+k3IXC03RT8JIk+0/IKx9rcwbCZ9BCK9pcCp0gvnFZhx4bHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKS2Kk8HyZHQbRCdNbxIQAtleox1qV8SwEh+GS6i5kw=;
 b=GRdRLxhh2Nk7qHy7D9mPJtDNO+bzAaMieEQcEUVS+4/8XbwQuNAWqbrDhq0T6rzVBSYOCsdxwrUVuZNfHmjt0fjiK/SbATRBLv+kxbH4NBNvSoTi3oC3zXoaPk30jqPfoF5VPHEXVVfhok2fBaxsyvN9vJl+2cHTQ4oTz/ujOm8=
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by CH0PR02MB8011.namprd02.prod.outlook.com (2603:10b6:610:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 10:09:51 +0000
Received: from BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::fa) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 10:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT033.mail.protection.outlook.com (10.13.3.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 10:09:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 03:09:31 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 03:09:31 -0700
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
Received: from [172.23.63.68] (port=40098 helo=xhdvnc208.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1mTi94-000EVk-96; Fri, 24 Sep 2021 03:09:30 -0700
Received: by xhdvnc208.xilinx.com (Postfix, from userid 14964)
        id 44D792044F; Fri, 24 Sep 2021 15:39:16 +0530 (IST)
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
Subject: [PATCH 1/4] firmware: xilinx: Add OSPI Mux selection support
Date:   Fri, 24 Sep 2021 15:37:08 +0530
Message-ID: <1632478031-12242-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7913917-ee86-4956-2649-08d97f4372a8
X-MS-TrafficTypeDiagnostic: CH0PR02MB8011:
X-Microsoft-Antispam-PRVS: <CH0PR02MB8011E099D3B2D0F2B3EF155FBDA49@CH0PR02MB8011.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4khxZYrsecYeKug8ShSMq2SQIZIBP8CLyCp6e7cyi8Z+G9b6rVCPN5Np3BdpRTgbBxCR+GtAuVvy7APak4eRKQBnJRG4xyFcAVWSyv1CX6J3oZMu7mc97ch7cdhlFLEpHCKlmOIKDX3c41B8AoUneRqsiBfYOAKHwolS0vZG/r4GdUuAW5Ps2d43Efl38k5rkaqIgRh19suTrGvHanFzOxqAAzYXl68b5d3IF7m9L3+A/69k3NammIT08S8Iv1ANUlsVppf4T2v0in5L4TZ840fHhImEY4GGYtqZ3Dx10P6iu0OpI8hMZ7QfpnzgwGNhlyzAy7St5jRXsUpLu0JkC3Wt6vpDotOeO2nCDgHN4gPggs4cu3Dl/abtX2+CzTIrONfxCRHg0irAJ4Hy/adeK6HqIQDPZb9JqHv06XQDFfIezKeRLPxAntpkDdvkcDH0nDdF/7ycSlDeIq24XDUFPOaUFRxucqo/EApJNWuKqlDyVHQF83v7ooql7sWaxLAc1aa+bz2zDPIe4W4QTpc2FUpMyz5y0t1TOoC2bRWNqmQJTPiFH7dsBcOsqUthQxZXqbnOgGb/dNgguWTG9dKy9OnJob3cZeeV8QpCFz82n67rgFTbxP9ocLysRdICv6KCWJPEfgT1Obc+yrAA1pLWQz2w22Mg+xmksVt1XdSh8NdaBuBJNtR4XP57Mpp6FTYhbYhSUL3m1da/0QXFzIznc78vIBDErxOD8yFRsLSaLc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(107886003)(36756003)(6266002)(42186006)(426003)(508600001)(8676002)(2906002)(2616005)(8936002)(36906005)(110136005)(7636003)(4326008)(356005)(36860700001)(316002)(47076005)(6666004)(54906003)(82310400003)(5660300002)(7416002)(186003)(336012)(26005)(70206006)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 10:09:51.1465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7913917-ee86-4956-2649-08d97f4372a8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8011
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add OSPI Mux selection API support to select the AXI interface to OSPI.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 15b138326ecc..43c3b5a9eef7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -647,6 +647,23 @@ int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
 
+/**
+ * zynqmp_pm_ospi_mux_select() - OSPI Mux selection
+ *
+ * @dev_id:	Device Id of the OSPI device.
+ * @select:	OSPI Mux select value.
+ *
+ * This function select the OSPI Mux.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
+				   select, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
+
 /**
  * zynqmp_pm_write_ggs() - PM API for writing global general storage (ggs)
  * @index:	GGS register index
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9d1a5c175065..6979a79f553a 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -119,6 +119,7 @@ enum pm_ioctl_id {
 	IOCTL_READ_PGGS = 15,
 	/* Set healthy bit value */
 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
+	IOCTL_OSPI_MUX_SELECT = 21,
 };
 
 enum pm_query_id {
@@ -347,6 +348,11 @@ enum zynqmp_pm_shutdown_subtype {
 	ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM = 2,
 };
 
+enum ospi_mux_select_type {
+	PM_OSPI_MUX_SEL_DMA = 0,
+	PM_OSPI_MUX_SEL_LINEAR = 1,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -383,6 +389,7 @@ int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data);
 int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data);
 int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
+int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select);
 int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag);
 int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
@@ -503,6 +510,11 @@ static inline int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 					 const enum zynqmp_pm_reset_action assert_flag)
 {
-- 
2.17.1

