Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7023616E9
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 02:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbhDPAtR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 20:49:17 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:20833
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237138AbhDPAtQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 20:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh4FFp3LJ7AofpWAbMncw1FxgefVsB4kAmett08rWE84vZZs+XzabTm3C5uai5B+ynfzGY+40V1X3Cejqc2RhAcFb9WgrKu4gCpNxIeS3cGQEQysV6Uvm+7BEkgbbdf/o0uqHz9xL0u9IUb3dq4ERvQberv0bQiXDackvXbeei0MhXMewfK72SYflByOXsjwRpW2MI8cL0xuAShYW20GUjAP0pLVht3RmjksELDRvauZShocv+lA6kXLep1fMZtDXfr3he1t0zavhL5WnDAkhUAaOpRq18CNHjYp99r20rf/x4ea7N9x/18IVBgrxlREkziErLkjFvvh1oPeYNwD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAeWcDglp/iUW4ZtZXf6uKGfIkx9mxrtd4grUP8b5UY=;
 b=R20dV7WGLJRaWCHRGxQC/5iuFgFE+nMCFeeJfzI4f7d7Nz+w4LutrpxQ8W1GvV+hyMkrb7/LRIdJWo9d1tJXo8gHkACrx2DYE1gfLlNX+xCC1aon+QJK5j3yOcIU9lkxSCnfBoEvOcQPxcsv5ds0vl6T7xmbwUAJ+/P/Igtn9pMYO2PV2FVP9qIiMrb0apEv+iaXLRmG0nE9voohqXvdvxwu4QmXS0r5BhvtFhm9vZ/aaqIxMW/RnatvMYkqizFKYi0qGrRrnaiuBdiiC2ZfV2Qc+mtUyQ/618lrgFM4z79i2Ph51Excd2RyM1Nfw/fSnWRxXWpapGkrUowh5vuunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAeWcDglp/iUW4ZtZXf6uKGfIkx9mxrtd4grUP8b5UY=;
 b=FXExzOXo64Wq48J8NjTbttrgCBv2VdHF5rt7cXfsNOxnY/e7mE1/2+WDZ1t/1Uq+5peLHDkLG61ZsmjYNtyt3akPIjtq6m62XfK9O8/PHIFWXmW5pfYHss61nYeyFo9qkOr2ZCsBvz82SoMcLBSNPqFaSF+Hx4zbGle0nkMAsXA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1256.namprd11.prod.outlook.com (2603:10b6:903:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 00:48:51 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 00:48:51 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 2/5] spi: spi-zynqmp-gqspi: fix hang issue when suspend/resume
Date:   Fri, 16 Apr 2021 08:46:49 +0800
Message-Id: <20210416004652.2975446-3-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416004652.2975446-1-quanyang.wang@windriver.com>
References: <20210416004652.2975446-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Fri, 16 Apr 2021 00:48:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a40bb3e0-81d0-4204-289b-08d90071674f
X-MS-TrafficTypeDiagnostic: CY4PR11MB1256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1256AC21331358096ACAF36CF04C9@CY4PR11MB1256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duoWy7+lRV2m1+x0ERiwasiWByFlcAHZcRp34k9X7uGI6mI4kHtvmzD8sUFhmjk+e+dYn6H5L5XMeytJ23R0cZkfD5j0iIg4KhMBUvxXEQw5MCGEEKDM/ijxOmD6IROZsJn8DsYvvhXypJMNd6n3Bv2WitrVYmopeLcNKl2a3IXLYqG3bowT/CFZk5NewuosNygN1RqshBoG2BjorrlyiCEB9DOrY9/gSPU2x/f62EtMYniQl+at7xuUc3woQiAQc7lk7Au4FExtYy2MchTVCpid27P8r7ZcuzSkwI+rfdx7OUpxTjfWZpGRI50Y/Lu2YhcU1R/ewgrWSOnS9/KrewL/6Y4oGjdxXAox3Nk7O5pryn5eFBv5iftIyhiZH9c0S8bmDej/e0pGPCidjeO09Lj0FYpCNlO58xjrC1Grrb+RcSAvUBDPpFBF2grmBwRwEiFtDkK4k03PJHOh3mpBEYHVJRDkWlilH729UeWPO1pCc5SikybGQ7qYNKqrl6/5PgPgH5AkApNpxbyq1CP6GgrMAQN7Uoik7oLnoK7wvw0a1Pi3oiiY5vb3nOWyBaTOzNyZYiHO02DgTxn15XRlNrFRIvi0KuX/No5HDkLjA2JPkK65maAV5NuLcL8j7RIY71xdRDHRTaViPVmwr/XNk5+4S7eb8kFgmu3QhlN8bn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(346002)(396003)(136003)(956004)(66476007)(2616005)(66946007)(86362001)(83380400001)(4326008)(15650500001)(6506007)(66556008)(107886003)(5660300002)(52116002)(1076003)(6486002)(9686003)(2906002)(316002)(26005)(36756003)(8676002)(6512007)(38100700002)(110136005)(38350700002)(16526019)(478600001)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pO9aeTRs7uQ+7hM7aP5gns79aIx0DfIWsBxdIL0H8luv51ufgvE45iMN9s8F?=
 =?us-ascii?Q?E7xw2KbpBbVoyRlnpDXVhRbSXuosws8u4cumRd6dFrDg3dK3wftlvVpFuXdJ?=
 =?us-ascii?Q?lO8Xgvx4ItN4dM7Qsv1hr8InR6o4Tyx+hGxnhcNdJdsAw4dYbaTZt1TiPgJ5?=
 =?us-ascii?Q?K99lAn/3BPm0lBiX3Sk5qiC0YZd1H7wMZOvBQ/7U87XzR0ObNyF5ptVUBOoE?=
 =?us-ascii?Q?/1AcWWRv4aWEzBgp6T0ZfFAVkhHuvqBKwkZa830mkL0xOjOX2z3NELG8u9XI?=
 =?us-ascii?Q?s8B/kd7J+LDPHw3+Gp5B0Q27qAyryGYD+3FhKdM5cbqgL3u3Q3V8orPg6K0y?=
 =?us-ascii?Q?oLhyImljkgWcZnp7mlseBqlPjFxV1LXDs3LmXcGa8fLvrOW/5dIUnc3hJfQf?=
 =?us-ascii?Q?jqW8c6hXiD+gzSPxkNMzcC/aA2BfYeOJAVoD65J5vuCxUyuBLZhflc1Yjj7L?=
 =?us-ascii?Q?9NP8/+AfxsF6f2A1fLLgQji1v26KX6QWOXMesp7lV0kjHBE33I9q76Vzki9Y?=
 =?us-ascii?Q?x/f0ATPO1TPr8Y99YCPqI9eLtsI47b9buIcz6K9Q50u7C4/ZmtyQC+5E/80J?=
 =?us-ascii?Q?tL0BgdNfSZ7yZkFZhES2y3BUd9suz5gLc2B4H0lS2IKL5OwPa6aNpZlGgZkK?=
 =?us-ascii?Q?QATxEJpNq7HzJydrCY/CoQ6+s0TadThjc0BL/yEwEgROd3ksx0IrC51scrma?=
 =?us-ascii?Q?qVn2I1Yvtkl/fHXgN5RLQm8YcuJ8UCqMKwS+QN/H8WnUGzXaBBT/VgS01G5N?=
 =?us-ascii?Q?qtGkImIjyGNXiY5lNn89CPZ4nxVAFX31dZSCte65cCgEaFT3a5MHGj84OAVx?=
 =?us-ascii?Q?w4EPgHe7vWwEznOHLnhyi773JT8JfjzdwobutLftJZP7ka/Uji5uZlkQLkEQ?=
 =?us-ascii?Q?KLAR20IjIUgQfq2omVtgPfRsNSx37T2UFSHjKiLqatFt8Yx1IYd6mp6P9SD/?=
 =?us-ascii?Q?nG7sMQ4nNQTZfFG1MMH5pK1MGff/6wy4VsXy/8GxIau4HqcKJxCxqSeYoT77?=
 =?us-ascii?Q?7+XKTeFd86sDEyKVyJgfULog6t9C3OL6ABkkueI/wKGWwWXTvzcMEZ4da7Hx?=
 =?us-ascii?Q?BvdSYx0fLjkX4pwJUkCr698Nt67EmYAwcHjWKK/uoEuflursXJ4tb8/k2bxQ?=
 =?us-ascii?Q?gacGTKpR692Cj1Wu+OW/iE7baSz1w3XxWKHpACLZTZJnAGZi/zntZkR2NUJo?=
 =?us-ascii?Q?rOGxEt/uzkoWfAFHhUyLJ2smkqau+PBYLl7PilJDfIh1VSzZiZwbY6L0AQPV?=
 =?us-ascii?Q?f/LYL1Y0w+jWzZeGkdkvKeZS7OcWgNKztgyDY9z8pqtbVqwpvb+FotdnlMVu?=
 =?us-ascii?Q?cf9DXwUE+8yBENw3Dvt+CVA9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40bb3e0-81d0-4204-289b-08d90071674f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 00:48:51.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmuUVxi+gMGCEitUsmmxOVJBLAO9vjS0PeAjZ7R7fGMQ4TYeqvvO0baY6TwgAE7U9CGUmsdnlzvYJECRTtoxBuhXi4yLgfmn9WQ2oN63bzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

After calling platform_set_drvdata(pdev, xqspi) in probe, the return
value of dev_get_drvdata(dev) is a pointer to struct zynqmp_qspi but
not struct spi_controller. A wrong structure type passing to the
functions spi_controller_suspend/resume will hang the system.

And we should check the return value of spi_controller_suspend, if
an error is returned, return it to PM subsystem to stop suspend.

Also, GQSPI_EN_MASK should be written to GQSPI_EN_OFST to enable
the spi controller in zynqmp_qspi_resume since it was disabled in
zynqmp_qspi_suspend before.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index f9056f0a480c..1146359528b9 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -157,6 +157,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @data_completion:	completion structure
  */
 struct zynqmp_qspi {
+	struct spi_controller *ctlr;
 	void __iomem *regs;
 	struct clk *refclk;
 	struct clk *pclk;
@@ -827,10 +828,13 @@ static void zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
  */
 static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 {
-	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(ctlr);
+	struct zynqmp_qspi *xqspi = dev_get_drvdata(dev);
+	struct spi_controller *ctlr = xqspi->ctlr;
+	int ret;
 
-	spi_controller_suspend(ctlr);
+	ret = spi_controller_suspend(ctlr);
+	if (ret)
+		return ret;
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
@@ -848,7 +852,10 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
  */
 static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 {
-	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct zynqmp_qspi *xqspi = dev_get_drvdata(dev);
+	struct spi_controller *ctlr = xqspi->ctlr;
+
+	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
 
 	spi_controller_resume(ctlr);
 
@@ -865,7 +872,7 @@ static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
  */
 static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
 {
-	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_get_drvdata(dev);
+	struct zynqmp_qspi *xqspi = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
@@ -883,7 +890,7 @@ static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
  */
 static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
 {
-	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_get_drvdata(dev);
+	struct zynqmp_qspi *xqspi = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_prepare_enable(xqspi->pclk);
@@ -1090,6 +1097,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 	xqspi = spi_controller_get_devdata(ctlr);
 	xqspi->dev = dev;
+	xqspi->ctlr = ctlr;
 	platform_set_drvdata(pdev, xqspi);
 
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
-- 
2.25.1

