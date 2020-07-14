Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1721EAA3
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 09:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGNHwz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 03:52:55 -0400
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:6064
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbgGNHwy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 03:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP2lS9zPXRL8VHEz1DdQTG26kvWSP2olJ7KmeEcIGj5ftoh1stdZu1gF3qJt5OAfYZVinrrU57uDwIhbLy0aVpxcr4GtfFqm2U0jVJOveIrrwtNgV9AVQKITPqkmaGkOd+1aEpGLi0j8tCczCUvbGS6KMgF059GIhBzJcM4NkpokNOsK8Ul2Ir8rZgT8EK4v/64C2ckh4RHCtUu4//wtijxEY3WM72MlBQ1Fd2HZXdZs0ZQA8NUPtTmH6MuiFZGBvfdrtxFx5/hrcGEqn3ogUOwPA4s734BhqAMATknJBUW4MvVIFq8rvJ6MlAmAxpofnkNhVqmOUuFRrNbRuTcvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIyHQ/+ST9bDWSNEUdiUGBheGh53smk7iVf+7CuqPdc=;
 b=crfYEOoL6HeSKlmpZTMsUSyuSHwUOsQOH26MfMMfckRvznuN+0YS0n8uxk1/IWY6z2YtFT6D7E07JaZr+j7MgNkpno7dRz68PrcAt09m2akPSsXW8goudnzGBG7bUXHL8qdQVFblaVDKh2+eCCBHCj8m8E2WRXWMftHzkXsILOX4QYEgoIhmlzVOAsdNTGYwBdhYVXjR9Eg3Mzpv+TaWWPd6q0c2JumGObEWK2nW5GOp3pyuPm2ux66GF+nCD7EOlUF+lzJJk+S0nUpwrvob4rN+roWNycQHu7BG39DTKlCkmiQdGX7GfQ0ykAUCgY5w2jeFVnZoog6X54Nustjbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIyHQ/+ST9bDWSNEUdiUGBheGh53smk7iVf+7CuqPdc=;
 b=EqJ3SBi21jWI/pR/dAP2FrRET+iyrA87LTOoz3OsBf+/qYm8QBroLToJprIESgGIiun1CPoDQQwJU0nbhkChR8/Bm7KmlJd6N831tW+NbFQ+I7Z+9hJEB+sjbwc5cjQazO25GVAqxO+KeaADEyImhG1lKof43cg5YKuFtlsNx40=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 14 Jul
 2020 07:52:49 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 07:52:49 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] spi: lpspi: fix kernel warning dump when probe fail after calling spi_register
Date:   Tue, 14 Jul 2020 15:52:49 +0800
Message-Id: <20200714075251.12777-4-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714075251.12777-1-xiaoning.wang@nxp.com>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:3:1::23) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:3:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 07:52:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97910300-949c-432b-487d-08d827cae72a
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:
X-Microsoft-Antispam-PRVS: <AM5PR04MB313943C69D5D6A39F205733BF3610@AM5PR04MB3139.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GR8FTEfsw4qyF7MRWqU9V8a5VTnbMsc7Ddd3Ldj2abYV+aB23eF4oJTh1unoB/CtlsPsX2ZvPCrnufHDpFLwZ1jvgZanK0bSbJso08t07B5NHSWsxMqKja3ApUgcRcBuOerJ/q8U6WMRPAaV40oz8F8fJrFvFY0/fltBFumt0DQfy3YDobr7+NF6hcwtlCsv/56vVX/hSeNAETtcnynt/EZBvjSYUV8DwdtcP6xNCa6OzRc3LvqsFBDIVSQo5IniAgPp5VDkg4aVOV6Q1S6cZY8kiETIXL3Kvb89CX20LN4rjsdFIGqKvUL04Fg9UcRcxOZooE4ZVngrQo29xfmYVnNwf0xroRqLkgX/gjs5SlHOkQmoqI4Bf3/jahrZjSxX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(6506007)(6486002)(6512007)(52116002)(8936002)(2906002)(16526019)(36756003)(26005)(5660300002)(6916009)(86362001)(478600001)(45080400002)(186003)(316002)(83380400001)(66556008)(66476007)(8676002)(2616005)(956004)(4326008)(66946007)(1076003)(69590400007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UPSrwK7121dpwXiTTdZ51h1SrvYATzJrHVV5pbJJcLQW1AcOsAwwHvTUVMJ8m/R9L4wXZYltU3NALM4uVR3Qo2Yhq5PnKEQNCYSEVE+icrrnJNYruUmLC3k8xNmtI9Bw6ydst+hzye10+NUWTpIJGjcCgJA+PvLS7eP8Zx3NVcJAt2kqryZz79+ps5GY9Z/T6hUoGT1n21RSGrpRJRCapUb9w0CaGgbMdcsePSjXQsolWwhd9hi3+w0wdgjx4MNhllugYkQt9Mk9zS7Uu5A29SKapANCcP1d9pyDHJKcCaQITw7jleqmrfKWm+A2ASTjrI/qT9Jr37ftwTbqSn5q+NHi6hrpCIyUXjHHe5plxNW0oBICgVrNJj7Ytk7SbxZBZWycLBQmM4ba1nn/QZZGqNe+ImsMYszFq8tQeFuniJp9i9NdvpvcD+ohjxGpQfyVEiKBB2rXM3maeBer5uziom+mPHPSSOFQmaucq5YLO9c=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97910300-949c-432b-487d-08d827cae72a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 07:52:49.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAAthPYJBQJCwO2XysrFk4ISoEz0Ro3jb5X2Lo5qObYNXjcEXcKOTfCM0DfIYNz62f/SA72SZvwLF8NZ71zm/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3139
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Calling devm_spi_register_controller() too early will cause problem.
When probe failed occurs after calling devm_spi_register_controller(),
the call of spi_controller_put() will trigger the following warning dump.

[    2.092138] ------------[ cut here ]------------
[    2.096876] kernfs: can not remove 'uevent', no directory
[    2.102440] WARNING: CPU: 0 PID: 181 at fs/kernfs/dir.c:1503 kernfs_remove_by_name_ns+0xa0/0xb0
[    2.111142] Modules linked in:
[    2.114207] CPU: 0 PID: 181 Comm: kworker/0:7 Not tainted 5.4.24-05024-g775c6e8a738c-dirty #1314
[    2.122991] Hardware name: Freescale i.MX8DXL EVK (DT)
[    2.128141] Workqueue: events deferred_probe_work_func
[    2.133281] pstate: 60000005 (nZCv daif -PAN -UAO)
[    2.138076] pc : kernfs_remove_by_name_ns+0xa0/0xb0
[    2.142958] lr : kernfs_remove_by_name_ns+0xa0/0xb0
[    2.147837] sp : ffff8000122bba70
[    2.151145] x29: ffff8000122bba70 x28: ffff8000119d6000
[    2.156462] x27: 0000000000000000 x26: ffff800011edbce8
[    2.161779] x25: 0000000000000000 x24: ffff00003ae4f700
[    2.167096] x23: ffff000010184c10 x22: ffff00003a3d6200
[    2.172412] x21: ffff800011a464a8 x20: ffff000010126a68
[    2.177729] x19: ffff00003ae5c800 x18: 000000000000000e
[    2.183046] x17: 0000000000000001 x16: 0000000000000019
[    2.188362] x15: 0000000000000004 x14: 000000000000004c
[    2.193679] x13: 0000000000000000 x12: 0000000000000001
[    2.198996] x11: 0000000000000000 x10: 00000000000009c0
[    2.204313] x9 : ffff8000122bb7a0 x8 : ffff00003a3d6c20
[    2.209630] x7 : ffff00003a3d6380 x6 : 0000000000000001
[    2.214946] x5 : 0000000000000001 x4 : ffff00003a05eb18
[    2.220263] x3 : 0000000000000005 x2 : ffff8000119f1c48
[    2.225580] x1 : 2bcbda323bf5a800 x0 : 0000000000000000
[    2.230898] Call trace:
[    2.233345]  kernfs_remove_by_name_ns+0xa0/0xb0
[    2.237879]  sysfs_remove_file_ns+0x14/0x20
[    2.242065]  device_del+0x12c/0x348
[    2.245555]  device_unregister+0x14/0x30
[    2.249492]  spi_unregister_controller+0xac/0x120
[    2.254201]  devm_spi_unregister+0x10/0x18
[    2.258304]  release_nodes+0x1a8/0x220
[    2.262055]  devres_release_all+0x34/0x58
[    2.266069]  really_probe+0x1b8/0x318
[    2.269733]  driver_probe_device+0x54/0xe8
[    2.273833]  __device_attach_driver+0x80/0xb8
[    2.278194]  bus_for_each_drv+0x74/0xc0
[    2.282034]  __device_attach+0xdc/0x138
[    2.285876]  device_initial_probe+0x10/0x18
[    2.290063]  bus_probe_device+0x90/0x98
[    2.293901]  deferred_probe_work_func+0x64/0x98
[    2.298442]  process_one_work+0x198/0x320
[    2.302451]  worker_thread+0x1f0/0x420
[    2.306208]  kthread+0xf0/0x120
[    2.309352]  ret_from_fork+0x10/0x18
[    2.312927] ---[ end trace 58abcdfae01bd3c7 ]---

So put this function at the end of the probe sequence.

Meanwhile, in order to keep the multi-CS working, add
"fsl,spi-num-chipselects" check.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index ca43d93adf30..6fb77f0f657a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -837,7 +837,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	struct spi_imx_master *lpspi_platform_info =
 		dev_get_platdata(&pdev->dev);
 	struct resource *res;
-	int i, ret, irq;
+	int i, ret, irq, num_cs;
 	u32 temp;
 	bool is_slave;
 
@@ -859,6 +859,16 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, controller);
 
+	ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
+	if (ret < 0) {
+		if (lpspi_platform_info) {
+			num_cs = lpspi_platform_info->num_chipselect;
+			controller->num_chipselect = num_cs;
+		}
+	} else {
+		controller->num_chipselect = num_cs;
+	}
+
 	fsl_lpspi = spi_controller_get_devdata(controller);
 	fsl_lpspi->dev = &pdev->dev;
 	fsl_lpspi->is_slave = is_slave;
@@ -873,12 +883,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->bus_num = pdev->id;
 	controller->slave_abort = fsl_lpspi_slave_abort;
 
-	ret = devm_spi_register_controller(&pdev->dev, controller);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_controller error.\n");
-		goto out_controller_put;
-	}
-
 	if (!fsl_lpspi->is_slave) {
 		for (i = 0; i < controller->num_chipselect; i++) {
 			int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
@@ -959,6 +963,12 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
 
+	ret = devm_spi_register_controller(&pdev->dev, controller);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		goto out_pm_get;
+	}
+
 	pm_runtime_mark_last_busy(fsl_lpspi->dev);
 	pm_runtime_put_autosuspend(fsl_lpspi->dev);
 
-- 
2.17.1

