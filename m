Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD022E443
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgG0DOt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jul 2020 23:14:49 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:43635
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727833AbgG0DOs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 26 Jul 2020 23:14:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3JEhuhX+Z1T2fP8apSM564qk4SXuM3WLG1mBaG4gnMWiH0CwTy1ThAAPxOCQ5nog5cQ4ruI+3HQIfbbQeFzs66UshCn+s/pk/gYEFGj3fiOfmzNSxtv92t+MM0yMNBqSuC98tGbW1C4fYTSHcjudyEQ5LKupewlZ3+04NpeKtg7EE70zHWWkw4qF8jrAGGV4ThXyvaCRj6rN7WOukRSJ9KnnnyL6jayKls5a5oKTcjZaVQEF/EYXGLP3VMv3hfR2aO3unXQiXIgUkW3iOTkCXrId/gZCyFLnfJRGWafnA68B3luf8Yc7ctTl2wO/SHpLwD8tKG71egjkybdk8Yvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDAKbdfVKxySHHaqd4L9V4vtTgkQfc3Xl0wM7Ab36Mk=;
 b=Yo41JLqafK1ig/SrpABbJ4gqFLx/J6prCH8MlHxwWk+YvX2LbTUcu68EyvfNcs7ipHfWU1emQcI76Y9vdyJU1LX7FJzkgO9Hgdc4H/CsXIeN9QV6Z5uIPPx+4iT3xZb39iATiwxsYM0XYlSZ6OdYHsCxeQOpHfGf2n74uAqu2sF37TW5bBMvtsAXeZCAxOMGYKqa/0vWjJfpVbbCgsQOalOylyFjsw5FPl2wc3HlErWCVgKW9SFthPKIOmxSvPFj9DZUNFhCjxEALyIOEpf0M/tPMQ5St0js+iMfRBvAXktV7MT4iGFCIqnFNBrayNbRQNG8qvq8Vxj9lvsTeOi+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDAKbdfVKxySHHaqd4L9V4vtTgkQfc3Xl0wM7Ab36Mk=;
 b=nwnoORyDheCP0yDloenJuvuGXKk7sllUDA2cud34R4XTHUMp42BCahfqd/JnKspQ+G7CQUsNM0qrW7d5zgeNofeE7+NiiTUMGWOAyboIeb9uqm1hvBsC9eBt81ZJlJUdpFKw2poqp+Iep0X3Z2KS7ePCt/0t6w1qhS+wZ07RNcU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR0402MB3880.eurprd04.prod.outlook.com (2603:10a6:209:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.31; Mon, 27 Jul
 2020 03:14:43 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 03:14:43 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] spi: lpspi: Fix kernel warning dump when probe fail after calling spi_register
Date:   Mon, 27 Jul 2020 11:14:46 +0800
Message-Id: <20200727031448.31661-2-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727031448.31661-1-xiaoning.wang@nxp.com>
References: <20200727031448.31661-1-xiaoning.wang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.1 via Frontend Transport; Mon, 27 Jul 2020 03:14:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72e29980-ca22-4ce3-bc4c-08d831db355a
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3880:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB388031CA1BFBB209A61CDE2DF3720@AM6PR0402MB3880.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrtQMYbWKT3Q19b9JufvOLcsLWaWJ47hrDNXK5u/b3r+GWWCxEBz2DS/aO3d42yUPzlpCAk/AYfGcFSslmPN091LoLnDUDBhdJaaD/TbDv7KNDkDhGZCgOTXN42mknSRNFGoWHxjkdVo1k1fo6rzpf3OM6NMyUzynN327a7A0sC856wGqIM9YT3kb3fgB9eyEpniZ9nzGzbq+/MZLlZT5lJD50wMWcUUgo5oCLPxbKUOu90E+bum06rxFTwby7v1pv02i36V9aWYr4+yMLtC7pCR4G+aqTZDTWFpp3G/3JRFBb23RuObNjdBaWm+UpNCzUoq+2hmrgr+ybO8iF+ybtwRL69S0wLlEpuSxjkNj2i0100rGpOqcHrFdLeCqSPM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(66556008)(66946007)(66476007)(5660300002)(956004)(2616005)(6916009)(8676002)(45080400002)(478600001)(6512007)(36756003)(316002)(4326008)(6486002)(1076003)(26005)(16526019)(52116002)(6506007)(186003)(83380400001)(86362001)(69590400007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: URFBQSQg34en/6pLhh1qRSnlZR23N9B3pAGCXZUTmkaTlXNJk60r4Yx4VE+8wNo7jTF04ZHeVJzrqpIfUKA/USzIB5j4i0et8Xy2iktPZQfi3GEDk9f2nintGlxpVbPzXiXvHx0kQx+YtA4YvzzEa3DrJE52i80D0TgEJCmfSU9qpbESKhQ1ce3ge4BcgoNpyiBPZyu9zR/KSzpYtyqGMJ/Wcfk4iuE2ietQQldk99zG0fBhzqDasq9WvNbGwoayy+2fbzs40mVJMxkkOEdcel69sNG9buDTNIBNDMf1cPNA8uuC3cMWwtOWl8bmLz/LUY8jshnM8cIZVYVpunM6tRu862wUWMU8mtAOVKdm1h7ieDX/hw0wWokxIKLrh3G3XT1f0+pH9ZRWsasNcV523AjIrM8J5FOf6OIMGsXJO2a3m9WGsj4/vDnPCQenA8Hs0aZ/bbCAQUu4iHx/2H6WfY0aOnb18Nvz+hW5gQ/iIWw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e29980-ca22-4ce3-bc4c-08d831db355a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 03:14:43.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpRBM19ihcch9kxlV3W7Jseecm9sHZ6m5Wt7XkKnFHd3FjvszMXM03gBkILBBsI2L82AsC7OPT9m6BMgjT1WfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3880
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

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Changes:
V2:
 - redo the patch base on the new code.
---
 drivers/spi/spi-fsl-lpspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a4a42e85e132..b0a1bb62f10a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -850,12 +850,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	if (!fsl_lpspi->is_slave)
 		controller->use_gpio_descriptors = true;
 
-	ret = devm_spi_register_controller(&pdev->dev, controller);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_controller error.\n");
-		goto out_controller_put;
-	}
-
 	init_completion(&fsl_lpspi->xfer_done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -913,6 +907,12 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
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

