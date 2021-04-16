Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D8D36221A
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbhDPOWq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 10:22:46 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:56161
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235300AbhDPOWp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 10:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0VDfuBk9ij7v4Sx3k6GqhXc8MwlzNzGRcB/xbVq7fkUmgGB8psiVDwlOp9p2BkythrY7x6Q6oPPLvzYOv8Caaa10nn6MtoL4bEeSjmLG6z8d8MpUGJg9fqHFY6KJDptPw2qjVkF4PJWdlL/Ljfe/GlXMivE/ANvQ1ZIOI/XMD8/Zrc7Q5WXoU+1m6R/veA0h9kxY5Osegcg40XD28F7EcV+XNeEQ4SZegWi0A5fOj4NPc7C9ewal/kN2eq0F+SWBOBcIbSRSflhMk3s/h5CVi+lm2MS+9DZYA+Y0oIbamddl7SneB1klEanMgQqLSUyPELSDx2OpEMDy4ihdd3OuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/VHzESPyjV8fkVOcutFrKHaOw4oAKVGuUsCnUXpXpE=;
 b=ZwsGmtiBrm3ssBlu+IvsfdwN/KfsWh8s2xMNMm8IoG3Jz/z/ygSaC5DsMXdYAVMMPIUyIu3If9uHYQQ9BVrP4eK1cqQMfzLf5FgMUIJ/PlgcmRn+5T5VzPX2HNQa2y8Iol0lG3yFAUok50JY6gzXWfnQSBk8igXf544EALKeR7rGb9sjRn/N9E1Ngeh/TJPk9Aafme0Fz9HMfsM9SqTpQ4uZFYYraC4Gnve0EAGGtjiyxnbCrDtLUlOFNvK/lHLLD7L5+eU9nt5ueCI81Lj5rScQ/C75Q2OQUZ39CCda07u1Msvj6QE1Vb25hYVucAdOSWe427tnvYFIm2oKzBJd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/VHzESPyjV8fkVOcutFrKHaOw4oAKVGuUsCnUXpXpE=;
 b=dcGJthAb6n4Rf2SlZY9nIrw9Sa1ULkGVnR/KI016HbRmNqe3BpjutcXvWYVR7KnnJLnA3zSMNsOipnWAA1t9op3N5s5u8t82hBNMRRmRTY/D8dGgDtbPEInHYRxwb9/gY1h8/NDIu9tGOthEKD0+o71thpo/v9zrrisM/A4VdEk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2264.namprd11.prod.outlook.com (2603:10b6:910:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 14:22:15 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 14:22:15 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH 1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue
Date:   Fri, 16 Apr 2021 22:20:43 +0800
Message-Id: <20210416142047.6349-2-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416142047.6349-1-quanyang.wang@windriver.com>
References: <20210416142047.6349-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:22:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d17bedf-974b-40ed-c739-08d900e30894
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2264618BAD4D8ED2B9127083F04C9@CY4PR1101MB2264.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Otln4KfR/aNvWIEsCTU9hfAd2M45mzPiie2tfmAUZI2YGu8u4z8uchLlgxTFDUfl9S8a1zBDj6EbbzlOfrcxsjEFITQlNmLnh0gJ8wtB3LiCdKMtGNX7RelP3fj7ZhIcTRtGEkNHr0FqvKmdI4wvbEs6S69NJH8wc8CSjO3dOacTcI6C94TcrC3ahUp62fXco6j++43c4RCKWH8f72YyRAusdnnSfmiTfsboadH2zRD1z+ZBe6m2u4yAExBgpsVjG62wfqtF4GLyrbg2O0i1pGT8S4UBBwCVG/boke+O2id3sx2BMdpP/8zri7SiOoEm3p+KcEXeY8QpfKl/MAe6FkC9dYt/ZuOmXmnVU+KYxq7i1K8xVSmm77VJ9VccKvpRONjTqFyHnjpyv/pQhz4lbDbBkTezeCNn9oD5JAtrIJMUF3F4K80F8Z99RUuaWBJ0i++iZ5hZjUE4T2vK+OhkPR9Rz5uw5X8GV/3TGWgpSraP7XwSYiTu0s2NqEv7hIXkBAqk6SGlEE5bCh6u80iRRLLkHd/oexWHKciomyao1M12YBeT2AUbvVlR2Ee6jcyOTCs+M2RUaIndF9y6GLhy9V+OUOaiQAb7715DdrKMyqYLiYFkNXbMMqsc152UQGBdeOKgJSHtlCEYzXnbX2Uwy6fhDUjCvl7DJn2qEr0X4NI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(86362001)(186003)(2906002)(38350700002)(38100700002)(316002)(6506007)(9686003)(6486002)(83380400001)(66946007)(8676002)(66556008)(66476007)(478600001)(16526019)(5660300002)(4326008)(26005)(6512007)(1076003)(52116002)(110136005)(956004)(6666004)(8936002)(107886003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9JbiplKsAlJ3FDtIyTbAudCFLGIvTAgyAr4+O4E5XuL2ShKSuA7g9n3ry3wg?=
 =?us-ascii?Q?3fJYQdNTmmjTh3mMjqJCSNCahjcZP101Ty98kn7BPjCAb5+9SUoFaGej36yU?=
 =?us-ascii?Q?kVYfxCMtXUKJKzuTKex/kLfs5TAU8eH+JQehGzrRiwhckAWOa419Fdnn+mmQ?=
 =?us-ascii?Q?XRtrcMNrSRgPvF1UYqY5iHgToxN9QhQjNnlS6LFJeXUoX0ensatYZt1uBRtI?=
 =?us-ascii?Q?jBtZzaEoAICiQC1ToFjd2WZzlW14hQYNbg9x5sgkPR2P5DP+zV/TH+ofmpFz?=
 =?us-ascii?Q?m/Tw6zAh0CraKL8Z9pwHzO23igmbmli5PwGTPDxkinQAPhHrfBcm66f+9Z5Y?=
 =?us-ascii?Q?2EZuOnA3vO4HMZlxdTTcQ0gG2Khb2SUtrKCJoOq/6Zgi089ALEXhB65R42vo?=
 =?us-ascii?Q?aYtG+m5z9+q4iGeRH/kzTPV9nfVpGpUAG2qixw+xLkgbHeI8MMsgf86X+Fr6?=
 =?us-ascii?Q?okmCbEbyUEdmQcHzJNUFaK7Aj6OnMH3f1LWRN6IBymldHvHdIib/gUerGp4o?=
 =?us-ascii?Q?lchQK5EDkXpuEOdm9gGYWS8HOJhJaEhu2Fzf9P/J+hfoWLWjjR1IIjyUKAeX?=
 =?us-ascii?Q?QmRJaPrLBo31YmqKdGR0O5tGPkKCv3LXEB68wfMOhJTER5b675afBie8eHiY?=
 =?us-ascii?Q?mk4/NGDP4m/hLnosR2fIUEdjLhuKDXhDM6hVfvjBZFiva3gw5vbD40Y3adFX?=
 =?us-ascii?Q?XQ27Lg/iKG9Bphw1RQVbNL9TAVYJAAK4tQswHyTqGsrYL9QDnXYKBjidga2I?=
 =?us-ascii?Q?JudUwLS3fjx6OOqyoy3ZfnCFRpb0wpjvN1ysPvZgAJp2H9u+5M5V+siuoVTa?=
 =?us-ascii?Q?FiIc/2K/21hEglE2QdEZ0+EBwn4aEgoDwYk0IXFqDlCqzb88lAFrvJttNGAu?=
 =?us-ascii?Q?QaB9YMG1dQ6oUqjajA7sVxv0sIimENe+ApBJWT5uN/MQlCUOLbFGQQuws8OO?=
 =?us-ascii?Q?G69J2TB8tZZwck1/30lKcHANMIL5nEaZWDbf3KNPRIVb1wK0/pK0XpXZ7OOK?=
 =?us-ascii?Q?LUuQ5vdLR08qBVFHQ3ODfgiQ464OoAClApisz+e36e3O2qLGmB0OuLLUjE+E?=
 =?us-ascii?Q?C6Rh3CWAxmWDMnpAdEmn5jZynQHjFZtOFBMB970P9AA/1L4VVw+rkNIZPBkM?=
 =?us-ascii?Q?IzTgZzsyenuvJ1Sk2/glsXn79Ckbui4E77hPDdiFhVaxbHQKoGp1WZBbxN9I?=
 =?us-ascii?Q?zs1cNunZa3oSf5kZMaKGko6XtCYHkH0crTVai+0mH71/LwteEjRFpk25DReM?=
 =?us-ascii?Q?ulJxJKhH7QftxD+XB4yJWHZMxblGA/KBZYU60Pt+gKZeRODRDSqvTg7/PQa+?=
 =?us-ascii?Q?VRWb8mEcpHQfIeujzwcO96GL?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d17bedf-974b-40ed-c739-08d900e30894
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:22:15.3079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDg+vQdM5JhzM6cuUV5PdfjC0b5yUUdm3U/CgiSDIFq7nwrnmCmS8Gxqak7v/sHKOFwAjMqsZ2k0F1dExVWPaAK9S8oI2gnwtICsMR0D33M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2264
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

