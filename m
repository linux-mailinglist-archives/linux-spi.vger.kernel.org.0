Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA651B6DF1
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 08:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDXGQq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 02:16:46 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:17403
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbgDXGQq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 02:16:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU4aGUqZXGmvLXeeOm+VMVl9VUI/+Vl5ckY0Tl09i4SEvdbd2I1CodIzviL7us21VeNOCgbn27wYAeblWW3jjrFzq4qZRM8d2yAp6LrNDlFr53h6OSPnvEh+e8DUP7bmasIXI+9QAcuXr6or3MMHg9bqNeH6/QhT4MzSDs9+BNcLgsUTxztkmyCvd0+92fnhosbPbFaJQRP9CAkVcBq5aMXqtnJhVBvZXSqZl2233kxB1hAGGvwAfRAwlMR4QsJHemwRd74szNPEZkplDmRtirNjpQuzdIdc2TO75ST5onTWUj9RthxK/rq0TvAQjlWWp7OnzfhiB5utUCEC3OWPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCTaU5dEXps+rcxp1EQhmuEkT8hv9nYsEW3h8THFJzc=;
 b=VKZzDf6YScJzfPXoappLFGLqylarZwcg/CutAAem9NSlpetvymOhGVh9re/fU0LN0OcFz7yKtP8cw4CB1Z3Ej2kyIZpqqWGTlimDRtDX+EW+ob9ZDu51GrA4vqaKt6+HP9O5N7xcvCs8CnMrhKUgPWWaLBihqYXv3WEgHE9pudbBO4gwZgxQN9GrmlKyDPPCjlrl4ZxVGpMSi9yH2b9N9L8p8ogKaBARYMgJ3ZazEmYU8ccc13dEcfqLikrb0L01iq2xXrbK+KgbsSPbJwupBfDj/b5QzEM5Nbj/L0oAMmSXQrYMBZ2+zBElmWu59WnEZVQ0s+qMQ9luD711e5encQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCTaU5dEXps+rcxp1EQhmuEkT8hv9nYsEW3h8THFJzc=;
 b=EHnLR5s6an99RIXXz/2Uh6fkonXkHNFK9GEd+OjgBRduhAJY1ZuaYFXlisv7V0X/zpCxlWuECgp4YdYBaIRKs+QEvs8iYuD87BMxQOa/2c3laOQ16MehgFj/W3GwgcvekHSaX01SQXsj55ok+7uOFiB7VB40/VisE8i71kN3DJc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
Received: from AM7PR04MB7016.eurprd04.prod.outlook.com (2603:10a6:20b:11e::22)
 by AM7PR04MB7191.eurprd04.prod.outlook.com (2603:10a6:20b:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 06:16:42 +0000
Received: from AM7PR04MB7016.eurprd04.prod.outlook.com
 ([fe80::7dfb:6472:5abb:c5e0]) by AM7PR04MB7016.eurprd04.prod.outlook.com
 ([fe80::7dfb:6472:5abb:c5e0%3]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 06:16:42 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     broonie@kernel.org, leoyang.li@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] spi: spi-fsl-dspi: Adding shutdown hook
Date:   Fri, 24 Apr 2020 14:12:16 +0800
Message-Id: <20200424061216.27445-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0180.apcprd06.prod.outlook.com
 (2603:1096:1:1e::34) To AM7PR04MB7016.eurprd04.prod.outlook.com
 (2603:10a6:20b:11e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0180.apcprd06.prod.outlook.com (2603:1096:1:1e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 06:16:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 530e8f99-62dd-4f05-eed6-08d7e8170e52
X-MS-TrafficTypeDiagnostic: AM7PR04MB7191:|AM7PR04MB7191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB71913C133DB91C04E543C469EDD00@AM7PR04MB7191.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(478600001)(52116002)(6486002)(4326008)(5660300002)(6636002)(1076003)(6666004)(2906002)(69590400007)(26005)(6506007)(956004)(2616005)(16526019)(66946007)(186003)(66476007)(316002)(86362001)(66556008)(8676002)(36756003)(8936002)(81156014)(44832011)(6512007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JBpoXH++sBiyqWnvzGAhpZAs5g/x82d4gdP7b9clJ+bXnindiL3c+z2blcnJxoMzIXUkr7BMcOMQsQ1R/6+ORXyVZc2tTxkz0ng5sDOSuWepIneVyj2SdTObGy6fJ+pc3U87+0Hn+GDGAhlLsZ6CZ67E7H0IHz/8GakgGal2gmOAAr2Ml+qxtfh+orstlx64hP8IpSi4NDhkhvRsmj3fuLQtM7cfKDC+PEf/5UyrUtzxNpKW301ReN1BcmbLsc5yKRW4JE7b6Ca9m5k5gLVSfjU8ort/f94r28489YNALBYSXAx39R4W76Lx1ZCWwzPuxsdFnMx+7Atv96K9FJvzYZg+mYYQ41xVDa5/8V4SNkLwq1YvDhFABLxKkI6fPu5X06ONySrqkJvAHA4TDTdmZruBanfK4b9NINg9/kCjc2tJFSj22i+9BR+mkXPwNobsLHdCWraqW0oAISHxApEtXoW5i5Euyxk0vUdTKx8sv4P4FG5YZ/RPPV0Usv/u09H
X-MS-Exchange-AntiSpam-MessageData: 3i/dQoESFBhcvehviynds1NaVSSadyz/XBoAW4iMNCIoxF2drorAGVIxI9Mt5ACr41fommSOQjaG/6vJMsmKY8OmztTAH0eMFW+8JqV32+Wr4dWmoXpoX+AIMbdBgF7bwrtr5mLNfOC/4oHYfCHGQA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530e8f99-62dd-4f05-eed6-08d7e8170e52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 06:16:42.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7E4hvLgmEWn3TUKdJpl86Uhx01IW9ZZNYpu0MVuomXeIsvpjCAbmmSYeQuaq5ap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7191
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We need to ensure dspi controller could be stopped in order for kexec
to start the next kernel.
So add the shutdown operation support.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 50e41f66a2d7..685afdf9e807 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
+// Copyright 2020 NXP
 //
 // Freescale DSPI driver
 // This file contains a driver for the Freescale DSPI
@@ -26,6 +27,9 @@
 #define SPI_MCR_CLR_TXF			BIT(11)
 #define SPI_MCR_CLR_RXF			BIT(10)
 #define SPI_MCR_XSPI			BIT(3)
+#define SPI_MCR_DIS_TXF			BIT(13)
+#define SPI_MCR_DIS_RXF			BIT(12)
+#define SPI_MCR_HALT			BIT(0)
 
 #define SPI_TCR				0x08
 #define SPI_TCR_GET_TCNT(x)		(((x) & GENMASK(31, 16)) >> 16)
@@ -1417,6 +1421,24 @@ static int dspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void dspi_shutdown(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
+
+	/* Disable RX and TX */
+	regmap_update_bits(dspi->regmap, SPI_MCR,
+			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF,
+			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF);
+
+	/* Stop Running */
+	regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_HALT, SPI_MCR_HALT);
+
+	dspi_release_dma(dspi);
+	clk_disable_unprepare(dspi->clk);
+	spi_unregister_controller(dspi->ctlr);
+}
+
 static struct platform_driver fsl_dspi_driver = {
 	.driver.name		= DRIVER_NAME,
 	.driver.of_match_table	= fsl_dspi_dt_ids,
@@ -1424,6 +1446,7 @@ static struct platform_driver fsl_dspi_driver = {
 	.driver.pm		= &dspi_pm,
 	.probe			= dspi_probe,
 	.remove			= dspi_remove,
+	.shutdown		= dspi_shutdown,
 };
 module_platform_driver(fsl_dspi_driver);
 
-- 
2.17.1

