Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CBF357B05
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 06:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhDHEEM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 00:04:12 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:37793
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229808AbhDHEEI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 00:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC0jXD5w4jK/PO/U0KIeq6nU3SdFS1VM6Gx3f4JMkjC4Lyp71el0E1TXACZFKVxlj4mVkbNLc+7SFhEIrAqxOeRNrK1pxnzmxUKJZ1zneaywUi3Ria2Bnbw8uLPfiCiQwrDCexu49L1l22lV0yjd8iSwai4SgDFIXufeSS/IP6PSbXHJTGtoU2uEn3Svpnvg/2q3HBIDgoVyQP6Dlv/ahNMaMtEApcFqG3PRgh0gnJHLeEDu6XssyrV5rGQvH8IhOtZwy8/cY0Ljew6KrtyPfOSth7sEAY2hsXX+VQ4EbrOZ0L934h0Uke6osgCr8ffF6GSpE1nevzcxQhlVQYYTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN7j0gso45bPrIgnwvPEp25vyLarXsMx11CsrlZB364=;
 b=nKglv5XYzK9I0Ov78sa2jMJkLV6lulQyOTIwsHubbaO9mjeZcOLGT8YhEfzzwl4Ozw6Gz1MCZL6bU/CSSx7D4wR5izngG7XssR4q2yw/do70YoWpoamI5FWdTfm74kLBTE1jjeK7Pma2Zw6xnFrlOPiisX5EI8g4aWlO26c2BiF9D5hPlcS7GaTAcWDMjuJU2x8R3jCmXyt6WPtBRg/a5ZW61S+Gy5+8Uv/VPACUz2YMuX1AYvz7ARlDEYF6hoNnBnlZKRGCe+lzEosrD6ZtIgBNb4iIEciBrdma+z8ihd3LcIpPUzAZ9iaySlOi2mVuycFZd7j1dx/yX+NZd6w4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN7j0gso45bPrIgnwvPEp25vyLarXsMx11CsrlZB364=;
 b=JL8EhE5DRbSHX5F2Q9Zm0/55bonULHLWjEIJN5wWUsp9TsZd86kSj06hFXOlerF6DBUGnr+6qwzUkinKxPQDK1+HeXpkmLXO3i/tp7nGcMe70C+hf4KLD2GNOYKhrGs+Z8dYXt0D3tehZs21YkSy54QtaPHEsfa6ErrIu9UOYKs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 04:03:55 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 04:03:53 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 3/4] spi: spi-zynqmp-gqspi: transmit dummy circles by using the controller's internal functionality
Date:   Thu,  8 Apr 2021 12:02:22 +0800
Message-Id: <20210408040223.23134-4-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040223.23134-1-quanyang.wang@windriver.com>
References: <20210408040223.23134-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 04:03:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcca6eca-6842-447f-b2ba-08d8fa4352e3
X-MS-TrafficTypeDiagnostic: CY4PR11MB0071:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB0071A806539647A567E2B582F0749@CY4PR11MB0071.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUXvbIrWoSoVWxqvHALaLq8l1VgUhjM1tqgvrRcxgew2/w/aZ1R+QTmPa+Do8CjBoeK8GIXUtz5iX4aDndkhExOjjrGKnZSefKbvnwLw2f2KGuIkS1rSAkIg3Mxcx/SM3EFYB3utzC7YPuad021VHfiL466pIbGXVmBeyVudFUr2DCMzCHK/9BSXWVGr6vpmcO864Ei30RC3xQuVoKURdTdYT55TE4QU23UPhDz60Z+0mUs2CDZEwSopEaxTOeHURBKQqnVdcYpxWP9Q/ZsfCD1kWQ3MMqB5lqHXwCapIc1L0xNVAIvYOWRBraUhdsx4A7rBv5tDDdSWxKQbWNQ6XOQ6G1c9StVXmWaaZCindv8mk2qusLLPnS3kXJ718+mwIri4lr2p+VzWcHET7E5YLqW+rcrT83VvVgul6wDKp0XOGIo615lZFas6ucTbiZGZdU+e43wsESCOsJTm8MM1i0SpvRCTZOaP0sksZH1onbm/ZqkDBenM92QWbY/XJFZivpftMs10v+KBsO9ui5d+KMxciqby/wcdpES2caOMhluUTJlUYBa8PgPW8wIDbXLL7XbTaVgGA8dVFfTWHiGfQNa65Q01o07k/TawA6TGOR4BSJIeMv0Yvb1CxyG7LM3ZzvIUWqK1Y/9oPVxGmmZyv0fOpsgq8KTEg6SkJrHiMSVGKpI6e/4oXOXERqbyaV8q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(396003)(376002)(346002)(38100700001)(16526019)(66946007)(66476007)(86362001)(6666004)(107886003)(38350700001)(6512007)(110136005)(6486002)(83380400001)(36756003)(26005)(52116002)(316002)(9686003)(8936002)(66556008)(5660300002)(478600001)(6506007)(956004)(186003)(8676002)(1076003)(4326008)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6TPPGOaVI4aLUTNWBVJOpsqSeZKVh5PSy1kAExPOIDjXzV5sAX5nvOn6WiOk?=
 =?us-ascii?Q?SD0vCd3lEEm7AuZVIErYk9rjFBYbw/BkILbxcaTW0phePT/whvG73vV2rJ5O?=
 =?us-ascii?Q?UU0GVljcy5vmk8rZqkl2TQECt7kDzb35uEHXD2mbEGqRNYj8jgongNF5sBAq?=
 =?us-ascii?Q?e2ovjHt4qSXBR0Bxyoh6bAS1qz68ORXytv15c5GhLIa+qUhibXGYf+DNbJFc?=
 =?us-ascii?Q?H7XOYQ0V0wQuR8tjFoK3eN2MkXJga3+PORO+ymRugecN6biM+hFZv3Ori1So?=
 =?us-ascii?Q?/W1D8+UMpjLma9xdrbqpKxlYKn+vYjA8v8fnsLblQ1nG3GB5BeCOk0N53SYP?=
 =?us-ascii?Q?t0P1DNfPLhX+rwhxeoxXkL3VVH/mledRxd1QSkG0ZZ1i2K+kKgQRUFw0pp76?=
 =?us-ascii?Q?QbHXrsNinSJcC+3KAhuNSisNSSc04NScE36muTCSNojmuKpL8Wn7s/apHihU?=
 =?us-ascii?Q?XehnX8V/vfkGcc1mLpfMASBqNEtODwJIX4hPfO+BwHdEgQr6UlaaLn51fX2q?=
 =?us-ascii?Q?KQEtmlsbQRoQdrsiy7nfVKJiJCg6mfiw4jAigqyqBzW5820UECLA2/VRPHLu?=
 =?us-ascii?Q?uFJI4KH/fY0oQwEWh3U/0skJSuiTQ4kQtOvT/0HdessruRhMGg9LU+Lsjmyn?=
 =?us-ascii?Q?KtuLXwko/fCUDH1vKBeevM261zDTDDctopykOcDv+KUR6L0vETdgJsOLuYlG?=
 =?us-ascii?Q?Q6mx7SFlXwysHhkAozniHkV+A1upfbIXtpxK7dnMOnogjw/1WS7DEh93BJNi?=
 =?us-ascii?Q?5WcZnWmiFYqf9EUPVt2Fiag4QB25AHy7e/mJiPBuRthGr8cwrxFQPgJs7PS4?=
 =?us-ascii?Q?VnP/VhrCtrvPPfpL5CYtVUVFt54vM+Dp1R5zLKqQcGGD4lJZZJHZEYeTHWq2?=
 =?us-ascii?Q?GLz4lCEt9ONL/IT9E/BMBmcxYM5NhsNEZzw/Q0VL394nzGj6DBv2m7/mzkS9?=
 =?us-ascii?Q?Tex+pOqyaSDMo9cVvlOKQ53GjHrD7KvY1rjSqFGivjkjJZ5OIzjt3PJhM/ID?=
 =?us-ascii?Q?RwBZYIKd6vaw6x2ooATXH2tHLf38QvdeiWXl7XL3z48f22dvS3l7wNOm4wk3?=
 =?us-ascii?Q?WiZx3tEUnPGOdTiLwPhwNPFB/0bEdSWNOohuJ24t/RMbITguzLv9j6GmuDlV?=
 =?us-ascii?Q?+bxY58XDHAanspIG7JNKQByoWWcPGnQqJAhuiTFW1zkwlXrRbFDXElLbFHPf?=
 =?us-ascii?Q?dztorB4zY6hYtJbi+Agzkatf7h/UC0z4/+eymY6HXSGmXrijTZ9tw0PGzrx5?=
 =?us-ascii?Q?wZVYz0tQJtsrzTBp1fauWAIXO8r9Zqv5U6/nFbyqGV0byNmEKKdfa2y4o4M0?=
 =?us-ascii?Q?yJKrbIWLYDl7HNCrAcsK4Dnw?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca6eca-6842-447f-b2ba-08d8fa4352e3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 04:03:53.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHsqhL+cZHvn01d+FZ9QjHiepGjYHh9HahRpnea6y9ErQXfX1dNXOmcHjdNGfV6OeV/YD5FN3Jxf7kZhjP04DtZigHoeY0PvhfPAuE7PFGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0071
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

There is a data corruption issue that occurs in the reading operation
(cmd:0x6c) when transmitting common data as dummy circles.

The gqspi controller has the functionality to send dummy clock circles.
When writing data with the fields [receive, transmit, data_xfer] = [0,0,1]
to the Generic FIFO, and configuring the correct SPI mode, the controller
will transmit dummy circles.

So let's switch to hardware dummy cycles transfer to fix this issue.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Reviewed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 40 +++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 3b39461d58b3..cf73a069b759 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -521,7 +521,7 @@ static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int size)
 {
 	u32 count = 0, intermediate;
 
-	while ((xqspi->bytes_to_transfer > 0) && (count < size)) {
+	while ((xqspi->bytes_to_transfer > 0) && (count < size) && (xqspi->txbuf)) {
 		memcpy(&intermediate, xqspi->txbuf, 4);
 		zynqmp_gqspi_write(xqspi, GQSPI_TXD_OFST, intermediate);
 
@@ -580,7 +580,7 @@ static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
 		genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
 		genfifoentry |= GQSPI_GENFIFO_TX;
 		transfer_len = xqspi->bytes_to_transfer;
-	} else {
+	} else if (xqspi->rxbuf) {
 		genfifoentry &= ~GQSPI_GENFIFO_TX;
 		genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
 		genfifoentry |= GQSPI_GENFIFO_RX;
@@ -588,6 +588,11 @@ static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
 			transfer_len = xqspi->dma_rx_bytes;
 		else
 			transfer_len = xqspi->bytes_to_receive;
+	} else {
+		/* Sending dummy circles here */
+		genfifoentry &= ~(GQSPI_GENFIFO_TX | GQSPI_GENFIFO_RX);
+		genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
+		transfer_len = xqspi->bytes_to_transfer;
 	}
 	genfifoentry |= zynqmp_qspi_selectspimode(xqspi, nbits);
 	xqspi->genfifoentry = genfifoentry;
@@ -1011,32 +1016,23 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	}
 
 	if (op->dummy.nbytes) {
-		tmpbuf = kzalloc(op->dummy.nbytes, GFP_KERNEL | GFP_DMA);
-		if (!tmpbuf)
-			return -ENOMEM;
-		memset(tmpbuf, 0xff, op->dummy.nbytes);
-		reinit_completion(&xqspi->data_completion);
-		xqspi->txbuf = tmpbuf;
+		xqspi->txbuf = NULL;
 		xqspi->rxbuf = NULL;
-		xqspi->bytes_to_transfer = op->dummy.nbytes;
+		/*
+		 * xqspi->bytes_to_transfer here represents the dummy circles
+		 * which need to be sent.
+		 */
+		xqspi->bytes_to_transfer = op->dummy.nbytes * 8 / op->dummy.buswidth;
 		xqspi->bytes_to_receive = 0;
-		zynqmp_qspi_write_op(xqspi, op->dummy.buswidth,
+		/*
+		 * Using op->data.buswidth instead of op->dummy.buswidth here because
+		 * we need to use it to configure the correct SPI mode.
+		 */
+		zynqmp_qspi_write_op(xqspi, op->data.buswidth,
 				     genfifoentry);
 		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
 				   zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
 				   GQSPI_CFG_START_GEN_FIFO_MASK);
-		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
-				   GQSPI_IER_TXEMPTY_MASK |
-				   GQSPI_IER_GENFIFOEMPTY_MASK |
-				   GQSPI_IER_TXNOT_FULL_MASK);
-		if (!wait_for_completion_interruptible_timeout
-		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
-			err = -ETIMEDOUT;
-			kfree(tmpbuf);
-			goto return_err;
-		}
-
-		kfree(tmpbuf);
 	}
 
 	if (op->data.nbytes) {
-- 
2.25.1

