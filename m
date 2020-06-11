Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597AC1F6120
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 06:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFKE6y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 00:58:54 -0400
Received: from mail-vi1eur05on2065.outbound.protection.outlook.com ([40.107.21.65]:48096
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgFKE6x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 00:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff8ObD5/JLMM4A/Vn1A6oXx3oP7WTsbgk99LRGK0V0lIy2onz2FD+hiIAkeRnhZ4a8UDB4zWT2s3Tj3SJoz1gODOFhp+bLUFkpfUUbDrcsedIhhr90GjqKVpi6WUR2y1u4udgtc02D0fDeT0mgTQWptSyrNfr9TBPExva7dMXG090HIT0DE4fkTPmYV/iTAf0A3Traw+8wGjS0qMJoBlxuK94FNi0BciYtvLLeqGuDFd9zekIfGaUinAyqXAWRlW9nQYFGMzPGQcWTxORFnsk72LaEBXxrQ1IvY/9dYYhw5poXr4lRIgA7K4nnnJSI6kZpUUf6Kvv9VbvP2JLGoiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT66pU2Ld/sBMXoloOT/I5elczXNNTyfPnONQW7MvCU=;
 b=JW5pd7eV5esQUIGXoceq71L2LHxNhTMtnPIyAIg82bqdAIxc8tjX7GpJl+ln7/p+WJKjkc2mpsM00NW5V8hNqaQ+DozVzgvBhjlBJqSXdD7ZZM4aNHrVGPL9L0rsmogzJPratwp/g1ev6/GcFJLaRImI8hZfohS1nvz2gp70z4+BZDilOAKSSKwoYFMpjF9rr2H4+sX3pgqMj0x30i6rC+xVeHHDuc30IxrV77Sglw3K1eYujCy0PQzDZ6xL1bPxrB5SIfq9tFJlcRDvGcJnUNwKJNSQm5X7u2kiMLRRcQT/XprqCZfj35h+rMUPwrQhj6oma7p3QsI65nNVwJPHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT66pU2Ld/sBMXoloOT/I5elczXNNTyfPnONQW7MvCU=;
 b=BBr7fQYYOEvZb0Ib6/2Qa9a+/lrMsRHejxXb/g0chX8txwSYc13geKv+QV+1OHdHgDvVzQ5Z//RC6YSgsLK8EBuAJ5a+beoklo6sSbnTwNejrPdbvU14Yo3OwBJFqnUiZJKv1K0Oo1VlPs+EZtSpeA6lSxIBf5hkj8Ai2XKud/E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6750.eurprd04.prod.outlook.com (2603:10a6:803:123::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 04:58:50 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 04:58:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robin.murphy@arm.com,
        matthias.schiffer@ew.tq-group.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 RFC 2/2] spi: spi-imx: add fallback feature
Date:   Thu, 11 Jun 2020 20:58:30 +0800
Message-Id: <1591880310-1813-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.23 via Frontend Transport; Thu, 11 Jun 2020 04:58:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2df7363a-d707-4ba2-a954-08d80dc42174
X-MS-TrafficTypeDiagnostic: VE1PR04MB6750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6750CD626706AE0A9FE72C0589800@VE1PR04MB6750.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvcbK4Gs9w8PVDQFsGJDZcPdybqOSsQvKPYipUCU4iCIvo1l/Mg0BHgTje68x2G9wGXMOOZr/vzg0taFG6ihW10qYvsaHOmexVsF4tsBebpwQCObChQMeEPzradYNF8CRs4D7ncRHjY2nEX7Xsvm4e17nZhtVtvQsdBvCFpWmuSBR5l+CTRU6omTrrrh8Va8XIXYuKEypudnQ1+NryMGEMLCu3ZK+tj7Ha4C5LDtf4C4POOIB6b7+tewrzv8y+ER5T4Eh/XxUxJvcegAMaER8DQonYnbdRTeMCy8qemZWmYE2vyz+witqpfa2Qjq5587SVXchDfoIFEyP60qNYZxpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(478600001)(66476007)(8936002)(316002)(2616005)(7416002)(956004)(36756003)(86362001)(6486002)(66946007)(8676002)(2906002)(4326008)(6512007)(66556008)(6506007)(83380400001)(16526019)(186003)(5660300002)(6666004)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BN9hOjFr2QcrxjV3PTxYs/E1ZlDgUJqBglej9retEDd75nYydcDFhzMq0qKuHhvz4I3mW22c8hiVEyTNg2zjFO2PabdghcGWN0i8a69XvyUmHXCHIKvFeUoSxcbB2/lIyVCwQhSoQZ6aldme/HmHMUxdb/Ay9eoBsfWSkl1ZQHRWPBljIa1LcUiSHcZWTIxvAGc5DM2HEbgAPUvp50uCt6UYYT/DNb7CPByZKoH8Gk+mlv1uIFYyTdyy0Vw/ZDsHjtnz+Vs/Ug5GJXaafjN7juwxd1XQFkt/+qkgQpEQsPkvtAo66zye/nPjQHQIvzx8824GvGD+B2tK2REVuVWYqI4MPWt5NVxwX3yzOVHXRQ0Ks+dc6j2VIxhh+6R47IA8V84M7r1R5+MrNrPwl/9q6i24ePsH4TQ1/PxOlTOAQLYvOMjQuoVot+Qf0+RmhNs5+Z+IrAI5WUwPvNsmaf3bsnKbq0rI7la5QNOm567CKl8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df7363a-d707-4ba2-a954-08d80dc42174
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 04:58:50.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWh8QYD6S+kCV11XWEW1ywZPkPG5zkxB/w6tCK0CX0DHIY8TnTUtstzXZq/1QHXemGk3VghSjkZg2GtN+bEHrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6750
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add fallback pio feature for dma transfer failed. Since another whole
pio transfer including setup_transfer will be issued by spi core, no
need to restore jobs like commit bcd8e7761ec9 ("spi: imx: fallback to PIO
if dma setup failure").

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b7a85e3..afd31d7 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -224,7 +224,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	if (!use_dma)
+	if (!use_dma || master->fallback)
 		return false;
 
 	if (!master->dma_rx)
@@ -1302,7 +1302,8 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	master->can_dma = spi_imx_can_dma;
 	master->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
-					 SPI_MASTER_MUST_TX;
+					 SPI_MASTER_MUST_TX |
+					 SPI_MASTER_FALLBACK;
 
 	return 0;
 err:
@@ -1507,7 +1508,6 @@ static int spi_imx_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
-	int ret;
 
 	/* flush rxfifo before transfer */
 	while (spi_imx->devtype_data->rx_available(spi_imx))
@@ -1516,21 +1516,8 @@ static int spi_imx_transfer(struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return spi_imx_pio_transfer_slave(spi, transfer);
 
-	/*
-	 * fallback PIO mode if dma setup error happen, for example sdma
-	 * firmware may not be updated as ERR009165 required.
-	 */
-	if (spi_imx->usedma) {
-		ret = spi_imx_dma_transfer(spi_imx, transfer);
-		if (ret != -EINVAL)
-			return ret;
-
-		spi_imx->devtype_data->disable_dma(spi_imx);
-
-		spi_imx->usedma = false;
-		spi_imx->dynamic_burst = spi_imx->devtype_data->dynamic_burst;
-		dev_dbg(&spi->dev, "Fallback to PIO mode\n");
-	}
+	if (spi_imx->usedma)
+		return spi_imx_dma_transfer(spi_imx, transfer);
 
 	return spi_imx_pio_transfer(spi, transfer);
 }
-- 
2.7.4

