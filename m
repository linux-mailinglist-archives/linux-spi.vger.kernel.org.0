Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184BC36221B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbhDPOWr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 10:22:47 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:56161
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241677AbhDPOWq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 10:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al4Kp7w/6wPLdmsX2wZWoQ1DR3wC/Bfodpeiw0UtWezNqpYYFQnwTRnmcsHmWNByb57Mhl0J9i7cED3xATwgDAjEFh1jg4WKbPNxI2tuHK37LNA3irMLtbJAkMZa9588h2PP8ld50fVux3LfZVXd94A34uJXhpOag4OmD0SqYxaCcuQpusHXyOe0mS6V7oCJZYAFLTKQRp5+p+er1eUHhnrMkGjBrt1CilSsSbLHPqWuxyYxWGe3F2eI+wgl78lDmvEsRxJGxRQfqirb/J52cttX27KtTQQtoYbGRIZSmBP0Lp8UNa+vddKv3wDTbxFWxvkbbwtznF6CZ1TPIfx7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I7CUAfjMk3+NxBTFO1XpfCTeNf9E04NBBFxWYxq4ps=;
 b=kvRtOET2RYwXSNSnSlBA6OF+yO8ryd2r6xN6tnnCqMXFBuVh3PQYN6kRUbuRedCkOCd1WKNIoufKCvDOz59ll443TX2xyPwo3NJaDmEyj6AQ82jixONMl8GrPz0ns1k+hQYgK/WDkfvn1pgRPOeHQ+9kydWqCbM4DUlQO2zBk3tIxOtPYqgHaO8yJdJLFV1zGHBz519UkYK25vcPabsU3utR6yWpgpj5CEsQhUmRHx+Y+EZNP72Qy6Wewayq+e11OzBg73xvPMDiPzmU/ZuaFM4VINxZMeaFiQ/Fjgr9hLb/tZPSrJtCeDhfFj+wJ7pOYs65uapgomSsQzeA2TH/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I7CUAfjMk3+NxBTFO1XpfCTeNf9E04NBBFxWYxq4ps=;
 b=Mwl7KJc7uGGCgxyxSURNKiO4ndZcqtOzV4J7Ip29fj4Sl5pVcMEoqFj49rzbXf9ewh0GhCqwAsCimmO62JRcN83MC8eBqahFo3ZS9Y1/7wDVdnKIvrgE1k4kgn9J4fLG+tw7j5Lyp3wEcn776WMIyIC+kql2lAEbwCctYd7XCfQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2264.namprd11.prod.outlook.com (2603:10b6:910:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 14:22:18 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 14:22:18 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH 2/5] spi: spi-zynqmp-gqspi: fix hang issue when suspend/resume
Date:   Fri, 16 Apr 2021 22:20:44 +0800
Message-Id: <20210416142047.6349-3-quanyang.wang@windriver.com>
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
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:22:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aee7060-f483-456a-57e9-08d900e30a2b
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2264B1FBE93FF074E3B846E5F04C9@CY4PR1101MB2264.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FRJAs/xyhahm09BTRYVYUxZu3OHLVJnDGftTITncsmkmm6PAF9zqPCh5pnMXeL2uzWwqjby6l5Ee/hiHa+5ye4OBmplXZPK5NE5zOOxh8ehkH99aeAHNDa0zc5H/bQ1/keliLK7L8KJvvs3kXp8au87H4UdZwL7CQLwqOTXNGej2S/n5Uad0/bCPUxNevl2rxTSSY2szDOSaTPRAEs5sqhfGpSPtN5tBeu19SIn337Wy5zvmLp0MydPt/3+VbK5fbThYz0qKY9/j2YBXuMfpQkvSiMawxZiP4OYQLAhis2QXrSQ1mVyM9G2aTwOwdvzTCE/CNcPYXZ45573ezJlYf66dBG+U0hYo8I9VdOu3sIKmh8tfn7XdJGXsmC4nfd4PBMgeyrbjDCgXmCL15UW8C2d6Rza7okGQY6vH07Y6dZ2edbtwiAhXnaEXZlB+HlWZwThqrGBa3LBldqRNk5FLbZtSRwXS3WmndOV12/Aeg/+MILbS97l/XKMa/N0S+gFmEkL/lhAtxj1tPHajKKSTuwUWTbt99eP3yqSA6TDV5dpmYGuSJomxCOvaPDNCWW11pSm/FrHMnVvn71o4wsQ9HL+plkgMX2Q6PUCVF6DtD4gSbJioR2CWsQGbdedcYNL94PAtT/sZMBcGcP4bo+h89U7JXeuwXdtUofq/3C7zyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(86362001)(186003)(2906002)(38350700002)(38100700002)(316002)(6506007)(9686003)(6486002)(83380400001)(66946007)(8676002)(66556008)(66476007)(478600001)(16526019)(5660300002)(4326008)(26005)(6512007)(1076003)(52116002)(110136005)(956004)(6666004)(15650500001)(8936002)(107886003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vODrabnWduXzr+IsIYCsanQMb4PQxXyTClncF/N6EnSl95BOKuBLl2lZLKKn?=
 =?us-ascii?Q?Qy6kGUJaYGZRenCecF7e3Yxi9t13tCKK758SXV0HGCwDmypV+gGD/WOgjewj?=
 =?us-ascii?Q?cll5AekrCv7ecH51Zk9p8ioR6k7LaejmCwGc6I4DpVsEK/csjZcmiIebu+1P?=
 =?us-ascii?Q?vmFpCACMTb2skbl0KIgFcuY8JS10JTtD18J/cDKqqSD5nP8B1VNhhEclqttq?=
 =?us-ascii?Q?0PicD4qUIUyYW6qcpTttrJsdabW4yu6aAvC651cktSY0VITMLZuilzo7h3zY?=
 =?us-ascii?Q?P6oJkt+4BlB39uLw8NknEGxFNOtu9LJ5/h1hGPCtLByseCUagh4sTr9EmzdF?=
 =?us-ascii?Q?2gIPwgk/U8kBqwvLJD4hrRRqukCB1tgRlIdQz5HTmFUf5Mafk3+hnsd/polW?=
 =?us-ascii?Q?4QLDs5Aa+l9JL/DqQ4r+SeFEgCUaEaJ7Vs3zUavCoU6QkTz+oLY+qIgKzBPu?=
 =?us-ascii?Q?WK8BDx0C95+xrjXwXBeIYb8PnjaQWaTCDUlId+b7dTVAWA+AcNlJ1L9qxUbl?=
 =?us-ascii?Q?D3VeziJa2SOJSOv8hxWWlBgI3c3gv81t4ToOgxJBM/qY6kvMb8SQmEo8R57K?=
 =?us-ascii?Q?eYm2AkXNvWZQLGwtU8PG66tgLpppEkPdcYTQbrAE4/ca+Q3FCv/Ys0lNESG2?=
 =?us-ascii?Q?POYHoLYM1MSn1ubLa7trsan79ZBOworgMh0hYlJ7LumrKVTsn06T/muSFkrw?=
 =?us-ascii?Q?RWwLrLmrNxutF5lkdjJ4Hjn+NDpgAyGbq45Tgh30UVdJPq4bYNKOZ1QDO5f6?=
 =?us-ascii?Q?cmkBrD2TtKKhjKsBZGcGQcu7qxyhDaOZBpEv/EvIHllrPZNbJu9crq/DgfCH?=
 =?us-ascii?Q?ygvzkhU58JZd2RVnKK5NVpVkmYvjqoiuUEuo/FTbXyCSYHzoz9faKlocjIym?=
 =?us-ascii?Q?LILdc95qDrew0ujzXXaX6lwmCks6v4bkDDIuFgB8/qhHdMJMMd+MLKxBx0RS?=
 =?us-ascii?Q?c181rB4sSkehzHMF+/bwtS5iXiHgXjS+azX5Fy97yVHY7mZXINAfpROgpeXZ?=
 =?us-ascii?Q?mrDBwCgG9vAP+Nx/rP5TXX0IJFTP1ob7/Tvogdqg47no6xGeKRWd9xH3/xz+?=
 =?us-ascii?Q?2mKnurhE8IpFGPYL5PTndupNpaxIjhNL10/TAjArPcdc+4G+hK6gHSWhh29O?=
 =?us-ascii?Q?XUx7yP3vtreimDwhPamUVLgKoXBFTNLFTShQObu/xtB8Z+BF9LEYaWsMt9BM?=
 =?us-ascii?Q?cnHVXimfN6KyDW1l7PZnmidC+0lTH49lbQdPSiUH1r60Rp9lO4abnZEU/ckN?=
 =?us-ascii?Q?tZqXsEmsq89c6nqcPtKJIjcoXt9Zq1UN/UL7ippNkvdFMlWWiCQqYdUvZriy?=
 =?us-ascii?Q?8oRF0/uDZxiS0Xpcqii20ilp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aee7060-f483-456a-57e9-08d900e30a2b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:22:18.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVEVTaKp0w8dqGSJ+U5fEXzLPyHAU8n3ImG8nKEtmevGrmkuI3CL/QDIra1jjqqBafegeiGs59dUkvp0W57AH4dhLyziYA0+aj0ajiFMb8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2264
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

