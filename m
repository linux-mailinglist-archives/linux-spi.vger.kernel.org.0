Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6E21EAA1
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGNHxA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 03:53:00 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:35812
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgGNHw4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 03:52:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE2H/Rwn9nJeViGzz4r7N7oxEPv5AidmlWl9i9kqTf5GuG8X0QH5m14B2zZ6Wj5YN+RN2kXbac24TOJwwSKPOvcbyOrvJFAIiymEJEpVbRp4+NfkvJk0Bz9KETRC1BJSzHpySwuZHUC8Br50Ef/EZFWUHsiWZB7nY+D12CbKF1IjkScYyzi0CNV76H8FDixL1+LGPJ0OLMm3Fmg58Hr8qCW8bhlaL+Hh9GQ46XoIuCksVbyWo/bzl0Y2tu48wfHBxQLZxFjNwZYUFOc+6Qr984ntKz7wAkLiSxnOxoUW2YMsAlG7Kd1ptvvaN4VFI2DUJ/a+MP7ylXx/hy+kJSiJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onCOD16eWwZHuHHvKpJzSHjqb+pPqi5wyJDP/Suhuuc=;
 b=bK21nR8nBh1BlO6ijuSVv+SObCZtA/SH0xrZ0Kei9WS6gsYYmidijgTdqilvGEuP4r5v/A1fGsUK0qFdRh+NCwc2waCJBNSV4/fIzm3I0Ve0heTv15qH3GuGlmlBLcHqsSUxJgALHvqUpnq2ijImL9WIwxSM5KSRUIQ6Wf8bdg9djBnUNuBoRwSQV9+dFspYBaeJcfdq2oSfdT/7BooZ3cNBBvxbS/1GHXugruXcDPb7RvQuSkjejnwW/YwYYMc8SxBCrfsnnySmGSOJk6xDJeEhAlNk1OiKrd5F//Ht93TrASdE6Z+h5AlCp8QAe+jXynjxn84LnLIGrj4sJhJtew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onCOD16eWwZHuHHvKpJzSHjqb+pPqi5wyJDP/Suhuuc=;
 b=TVsel+YqYdFUXSfqRU7JJZmps/5HZfFaRLIjbwgdKU3el3yftNj9bBhSRaF14SD7HsJUqx9DLum0LDn9E8Li550LztQupRWQHzJILPi2muGTlo1xIFNbP/3KPyp3B9u49aW3JD9yvlOovc5Pdg4oOSXLiXLquFaLPO87uqf9WMQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4854.eurprd04.prod.outlook.com (2603:10a6:20b:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 07:52:53 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 07:52:53 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK
Date:   Tue, 14 Jul 2020 15:52:51 +0800
Message-Id: <20200714075251.12777-6-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714075251.12777-1-xiaoning.wang@nxp.com>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:3:1::23) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:3:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 07:52:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 428720c2-c2d5-418a-07ff-08d827cae98f
X-MS-TrafficTypeDiagnostic: AM6PR04MB4854:
X-Microsoft-Antispam-PRVS: <AM6PR04MB48540A25A5DA3336701FC7D1F3610@AM6PR04MB4854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY8g2hPUDl2d7eXBdpD7b1K4FBOkaJGBXnTjMd2hmF7Fe9cUk4VsKQvG0fHpiOAqv66dDT3AKBqpgNbEDg5e2fKR1Gy3+/iXu6+j3h1NXvW1DwnFeTeTMu6vyY/vDXeDwhbd9O/NCZ8aMCLc75j0jnelyGzIDwlJZ4Iz38h2jZU/HbiHbl4kX7K83C9xAYmhMiiwFddHtA9IKr9dm8ERlLfRNcAHHI+d0E5m+gsBz1fSoGTASlFE+5fo07SfzfLnNY3jD59EoYW/G2T4WIXy6wJ6u9z4zemax9ogbfAxBf20jq+GHgGP7mgB7Io45lXHRlm/9MGDv/wA4UtJM8K6OkzU1ejKCMlmgLjxFEaHh7MdbYONuHlxS+fq4KMNnjLr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(66556008)(8936002)(66476007)(66946007)(86362001)(316002)(69590400007)(52116002)(5660300002)(6916009)(83380400001)(8676002)(2616005)(956004)(36756003)(6486002)(26005)(1076003)(6512007)(478600001)(2906002)(4326008)(16526019)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Wzv0nOVXw85nkn6kiSuI5eTCiv38ADrw9qM+CN0sCNEyzAPxPdyRfLyZnNma0s+vJhrhmnrHlB9tzDN1wWoPT0hVV2aUYwE4wwjgbZ95no9IVq1LGdvuxqzO6uC/iuPWAwTu0XRrxZNuejc+/QDr7URVxrLztaa27atNrGQbeN6BhmuaFLo26sbglQfN3yu2mvX8WDw7ArYOb7nC+lykSzEQ6MbpkbCPbXbo8+fZfLjb3JpBILeCntSWUqsBAwf5xLRloQvy+F7YDVZTBZlDaMQCa7ASbrQpZNPfI+q6EVKor+tNY8tNyOPURYD6kRLCYtsXC/ZI+98TyiOVpNqqSF6F83mdCTtg3FXTmXrpoREGDWNOemfMBraHeG2IvlMhY9DM2Y/HwrOiCCPII9D3Lqz09NTCeSbfT6z5turjaBUMK9U8L4QJucq1F96/pv7ZZ6o3PVWXMtPw5t/JGl+1+tTOt+dSosC2HKv/6Rh+ALY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428720c2-c2d5-418a-07ff-08d827cae98f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 07:52:53.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTqATb+NjOaJIIufTPDlwYVjqy2/LwFUFIPhKuPfnfnYYRgB9QOOPrsjP2dXiY6Wokw8T5QypvvOSrbeCS1qVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4854
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI common code does not support using CS discontinuously for now.
However, i.MX8DXL-EVK only uses CS1 without CS0. Therefore, add a flag
is_only_cs1 to set the correct TCR[PCS].

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 05b6ecd82974..3f722f8f143f 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -101,6 +101,7 @@ struct fsl_lpspi_data {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
+	bool is_only_cs1;
 	bool is_first_byte;
 
 	void *rx_buf;
@@ -276,10 +277,9 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 
 	temp |= fsl_lpspi->config.bpw - 1;
 	temp |= (fsl_lpspi->config.mode & 0x3) << 30;
+	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
 	if (!fsl_lpspi->is_slave) {
 		temp |= fsl_lpspi->config.prescale << 27;
-		temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
-
 		/*
 		 * Set TCR_CONT will keep SS asserted after current transfer.
 		 * For the first transfer, clear TCR_CONTC to assert SS.
@@ -440,7 +440,10 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 	fsl_lpspi->config.mode = spi->mode;
 	fsl_lpspi->config.bpw = t->bits_per_word;
 	fsl_lpspi->config.speed_hz = t->speed_hz;
-	fsl_lpspi->config.chip_select = spi->chip_select;
+	if (fsl_lpspi->is_only_cs1)
+		fsl_lpspi->config.chip_select = 1;
+	else
+		fsl_lpspi->config.chip_select = spi->chip_select;
 
 	if (!fsl_lpspi->config.speed_hz)
 		fsl_lpspi->config.speed_hz = spi->max_speed_hz;
@@ -872,6 +875,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi = spi_controller_get_devdata(controller);
 	fsl_lpspi->dev = &pdev->dev;
 	fsl_lpspi->is_slave = is_slave;
+	fsl_lpspi->is_only_cs1 = of_property_read_bool((&pdev->dev)->of_node,
+						"fsl,spi-only-use-cs1-sel");
 
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 	controller->transfer_one = fsl_lpspi_transfer_one;
-- 
2.17.1

