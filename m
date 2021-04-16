Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5EC3616E7
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 02:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhDPAtP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 20:49:15 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:47667
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237286AbhDPAtN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 20:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpBGt6sMiwFRnpY4/DUlXinGQHI7ET6rtJxdAj2r6OpQYTCC6olWfb9Sm4JW++/WktS5UjJEUEEZLCx6q0beY2OphL+cGdo1hkBhaXfcV3U07ixGIgO1RR1kALDxCKBFijWvpaNnKzbzLfTPFEUF4JUtfZDdY6ZEfshC2BBR7zxoukgROkZ1aDBOAeaWs5n2K1BoQ1Ik0yCmpJkyV5BsNCX7lBN9Nvn9KJ36n7wH9Gxs4dLK49656PARV5R1qOyQqun2paSQWa2i/ARFcpQubHavxBIC/Sj91OxsuEm+J1QYA8O3lUCbmznwoxQj1vVbey4RJFj7KDhF4iBKZT3CMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZCP/Pfg9LOhSPcM3lXsSmCp4La5FzklKzyVZBlOOA4=;
 b=k/+9xNi5ZlL/RdJ/VZwPhKBavZzIvL1+t47WqZL3hKqYQjE2yiEkGHa+8td0fuPTyI7HI4ta2rslgx390LCLlAICU3wvJuN3CxaA13uJiFL0qMuLLz4IMD19Lj8KTLqeDjc073x+NZ/rbXBKzApvlpbLzKFANICs6HJdsC2kVhzFtlQ4AeQxQ3lU9sFfMKNz3a5XbvmeaOf6fCeN3hMV4x2yOk/pUseIij1VeaiyGxOuJ4ioMBGWTlXMWZJVFeeDns7umlAqdY3XVDl/LS4eValQim/upMem+XNCrmAm1E6qbVWkV0bh37wZ6PRFld2Me3PNltxG3Ggb1VM9FInskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZCP/Pfg9LOhSPcM3lXsSmCp4La5FzklKzyVZBlOOA4=;
 b=meGNDjhYuAZyAMg5BCGB+1A4vLO9vGtNuidQ8kx/W3BC6g4HT6A3XmWwrZNezVvIXFDKbyNU7A6zpotzd1SUfxQN/caiqVspx7MO3PSpI2+hLeLn7uPGt1O6AMEEZ+t/H3HMRwsKgtfkrIpO40v3ZMibHI3NOeva/YvRDaIF5Jo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1256.namprd11.prod.outlook.com (2603:10b6:903:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 00:48:49 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 00:48:49 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue
Date:   Fri, 16 Apr 2021 08:46:48 +0800
Message-Id: <20210416004652.2975446-2-quanyang.wang@windriver.com>
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
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Fri, 16 Apr 2021 00:48:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 627f46a5-0ed5-424b-dd1e-08d90071657f
X-MS-TrafficTypeDiagnostic: CY4PR11MB1256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1256F56018B48DE237D65C31F04C9@CY4PR11MB1256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcbD0NEB/5JjDuZiYDUZvHQMTwY9MGOZkDL5UF9its3NbNRSURBl64wDwG9x/SEMwlPCJ1hEsr9sXeL//ohKd4YSeTyjh2MBBMNm7KHIkxWUCePhyaLql0RRrC8jIiA96yCXDilkzdagEGO9bbCNX2N+2xK82mqk+QsR5wo0tkhDomWafaMVB3wTuGQJ6cLOr97+AmZ+Zh/eU8PVwRxqYKHOAgbONd4YgFOXv0QWwQ3FqK9YBnueggb0ZrwVtVb8UZJQt8DQ9dictixI/lxs38cOPw+T+dmnYaOW4HZNwPRIPudc9xNtzlU8tQvO4DGPwR7pNZcW4zeK4QJ1Vd0koSJO9s4DnzqmG/WOlHiv1vSvTd6a0ICRMHPrzZ0tkRxLb1zC02Q5wzHA8/DxfTMzSC6ndtl+K1DMyFFZm3mkc97x7k9XlaQ29RFDzpp6wfyZuWQiabL6gp3XwlIktdJjYOnQUZJEcCjD5gWhKvZP6gCiMeMeS7SSWJj1Ekqfw5TX8yIa1l1zAy9RHnpqUlZ6H3Lm2twts/GuIyrzLh2pLyk6scrJfK20nvMZZykJAyxgs/IVXgVmc+fOyBFR/iDMl0DhKPMqcHZ7nLc0xJzuEar3sXFN4MqyLq5Yy+r89WTApmJKX+7nMIOLTrSBICbGU3FifMX2AQliTsnZQw3w++k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(346002)(396003)(136003)(956004)(66476007)(2616005)(66946007)(86362001)(83380400001)(4326008)(6506007)(66556008)(107886003)(5660300002)(52116002)(1076003)(6486002)(9686003)(2906002)(316002)(26005)(36756003)(8676002)(6512007)(38100700002)(110136005)(38350700002)(16526019)(478600001)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bTE8NdmQMLFcfgyp/HfuTh3WGI3jlXHyLRx7AvKbEKKY53URxxUMGY1b7c2T?=
 =?us-ascii?Q?N9PZ2PLVd/NS3hYx0aYyBkHm/xSyc8MvbZHO8Ygwr+ieV9H9g1y4wBBZbDvS?=
 =?us-ascii?Q?GgTLm3fP9cXTfJjIjyP6Ha6WWYS8es5p919VIt8SpKOR5xdvKKJcG2mIvPoW?=
 =?us-ascii?Q?2wt8aP6Lr+52Typgx4fG4b1V25r3TVBu38YFrR8jX7mhCtOPeAceif+ZReUz?=
 =?us-ascii?Q?JU6iGzQyLLLXxD3n83I2IHMW9P8PR+aDjoLeTKzgHXC/JfxvLsECH53e3D1c?=
 =?us-ascii?Q?RFuSg6HyzY+epn7vj8eaHpbfHLjiRoADVq7BQgkb0Ra8Nj4Ihhu1G5wh89L/?=
 =?us-ascii?Q?QkcTPi8s65TGNrOI1y1iOdY9bf1/J2RifNfjjPyP9lhVAPi/PAL5FybwWWfB?=
 =?us-ascii?Q?hndgjhMKOdQZ1XIJBFvaxLs3/w19xclsEwjPspreduIDtoKzXbB3/Gq1vDN7?=
 =?us-ascii?Q?QAo3CSO4oJB0OLZRYRCTUiqEQOvmtoFrCou100bSnwDiJ8XbqMQJg9zJtxoh?=
 =?us-ascii?Q?MEZTXP7VqC3Gji/ewFf0KNaimfwPdm8lnP44FFckQrBaCIAPVHlOVaQZSO+G?=
 =?us-ascii?Q?3ZlbPS0UpqIn6E5GuBf3EB29rXwtQEXdldHW8I6sGKTFzTuCcmipseKTLhbC?=
 =?us-ascii?Q?/P3pdtV6uAt9ZQQQmWsNVtDbRTmaMWtt8TEqIfaEa04Yb/evJzzDiil3TmvW?=
 =?us-ascii?Q?H/eF9RMWZkkgAcnxmO0birWXctcmbEvEnWRVy0bkFmnzhWYkA4GpcLZ1XOs9?=
 =?us-ascii?Q?03HSsqHHxw8qoJsqPpnUlz8NAorz3/ECIlHU8ywbo7FI5UFah8zNlzxqwVnT?=
 =?us-ascii?Q?HIbqbtsP0K2vcxoB1SEIebjOblugTN4zC5TUw70bEyvNdkerAKqj1yc2Fxvt?=
 =?us-ascii?Q?fpQeX7XSylQnTieuWi5MCiyhDtQXV1oU73VKPIEkXbpB8Pj9gwcXfT3RkBRP?=
 =?us-ascii?Q?UfhUnvGeMdoTgRtHQCAO1OsOjcUXi7hc8Csovmw/lPiqjByEHFTfp2q4BQsK?=
 =?us-ascii?Q?VUX5b926CwLtAunDse9i0jJxu8u3o/8GqCLTs8EZf1gXVUn9GMG2XAxMVkwx?=
 =?us-ascii?Q?1r6IK03h8d/LKETBpRgnrL8B7SxOkY1C8kTDX4cBAmdr/QdkOEK/nGqwX+Yd?=
 =?us-ascii?Q?QmPhyNJxnvGXsrtzdE3Q/QatnNs3c+YBZgvE2fg091MWHylEjUGL/LD3YYHp?=
 =?us-ascii?Q?3j+USSruDZ2NoyZD956oXjWcPApLVMuEA7S+5JwpT0VF2Po8lgIozVKx86Rh?=
 =?us-ascii?Q?Q4L2mLNP+lFnZGccYtG1AH0GOFA2pJEcpfuPF0k2N3TTYdClm5yp+dT6/10e?=
 =?us-ascii?Q?9M1k58BSbgoUzsz7dhPzXuMM?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627f46a5-0ed5-424b-dd1e-08d90071657f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 00:48:49.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vp2gSmlrkz4G0Y8ZkxTjdpUOgqbaGBfBuPkNi8ZtuIjCO9EyuMMpXuBEMs3nlGgrxBa3dhr26mJybx9zo17X63WNucGl40dKMO9/seKp5Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The clks "pclk" and "ref_clk" are enabled twice during the probe. The
first time is in the function zynqmp_qspi_probe and the second time is
in zynqmp_qspi_setup_op which is called by devm_spi_register_controller.
Then calling zynqmp_qspi_remove (rmmod this module) to disable these clks
will trigger a warning as below:

[  309.124604] Unpreparing enabled qspi_ref
[  309.128641] WARNING: CPU: 1 PID: 537 at drivers/clk/clk.c:824 clk_core_unprepare+0x108/0x110

Since pm_runtime works now, clks can be enabled/disabled by calling
zynqmp_runtime_suspend/resume. So we don't need to enable these clks
explicitly in zynqmp_qspi_setup_op. Remove them to fix this issue.

And remove clk enabling/disabling in zynqmp_qspi_resume because there is
no spi transfer operation so enabling ref_clk is redundant meanwhile pclk
is not disabled for it is shared with other peripherals.

Furthermore replace clk_enable/disable with clk_prepare_enable and
clk_disable_unprepare in runtime_suspend/resume functions.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 47 ++++++----------------------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 32e53f379e9b..f9056f0a480c 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -487,24 +487,10 @@ static int zynqmp_qspi_setup_op(struct spi_device *qspi)
 {
 	struct spi_controller *ctlr = qspi->master;
 	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(ctlr);
-	struct device *dev = &ctlr->dev;
-	int ret;
 
 	if (ctlr->busy)
 		return -EBUSY;
 
-	ret = clk_enable(xqspi->refclk);
-	if (ret) {
-		dev_err(dev, "Cannot enable device clock.\n");
-		return ret;
-	}
-
-	ret = clk_enable(xqspi->pclk);
-	if (ret) {
-		dev_err(dev, "Cannot enable APB clock.\n");
-		clk_disable(xqspi->refclk);
-		return ret;
-	}
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
 
 	return 0;
@@ -863,26 +849,9 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(ctlr);
-	int ret = 0;
-
-	ret = clk_enable(xqspi->pclk);
-	if (ret) {
-		dev_err(dev, "Cannot enable APB clock.\n");
-		return ret;
-	}
-
-	ret = clk_enable(xqspi->refclk);
-	if (ret) {
-		dev_err(dev, "Cannot enable device clock.\n");
-		clk_disable(xqspi->pclk);
-		return ret;
-	}
 
 	spi_controller_resume(ctlr);
 
-	clk_disable(xqspi->refclk);
-	clk_disable(xqspi->pclk);
 	return 0;
 }
 
@@ -898,8 +867,8 @@ static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
 {
 	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_get_drvdata(dev);
 
-	clk_disable(xqspi->refclk);
-	clk_disable(xqspi->pclk);
+	clk_disable_unprepare(xqspi->refclk);
+	clk_disable_unprepare(xqspi->pclk);
 
 	return 0;
 }
@@ -917,16 +886,16 @@ static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
 	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_enable(xqspi->pclk);
+	ret = clk_prepare_enable(xqspi->pclk);
 	if (ret) {
 		dev_err(dev, "Cannot enable APB clock.\n");
 		return ret;
 	}
 
-	ret = clk_enable(xqspi->refclk);
+	ret = clk_prepare_enable(xqspi->refclk);
 	if (ret) {
 		dev_err(dev, "Cannot enable device clock.\n");
-		clk_disable(xqspi->pclk);
+		clk_disable_unprepare(xqspi->pclk);
 		return ret;
 	}
 
@@ -1136,13 +1105,11 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto remove_master;
 	}
 
-	init_completion(&xqspi->data_completion);
-
 	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xqspi->refclk);
-		goto clk_dis_pclk;
+		goto remove_master;
 	}
 
 	ret = clk_prepare_enable(xqspi->pclk);
@@ -1157,6 +1124,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_pclk;
 	}
 
+	init_completion(&xqspi->data_completion);
+
 	mutex_init(&xqspi->op_lock);
 
 	pm_runtime_use_autosuspend(&pdev->dev);
-- 
2.25.1

