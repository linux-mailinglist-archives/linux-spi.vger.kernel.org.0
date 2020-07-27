Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C0E22E447
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 05:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgG0DO5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jul 2020 23:14:57 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:43635
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbgG0DO4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 26 Jul 2020 23:14:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVn1c6v7LcI2VBPPxD0UiwXC2lXr9geyQe5CMjSyAhHOOLbmt66usTajLsLeJkc0wTmTOHdk+0XMijZuQgtGNsKSdz1x5cM9JTLCQqKqh62ZSN0etm0TYcKAn+/wW834oqk/HKhjLJrG6m038Z4TVdJ9U1nbT2D7miGCJg0AeV4lhDkhSJ26hNR/+ZC3yNmOJ8b6McG3DrPgd7tQ0e7NEhpQjb7tSmqZecRxKnvhMk6h4gHpydRvRgh/V8SLHtN2RvEGjG1D4R/tTd3VoUrCDlKU6kNzABBTfR4PImo4roPg29dDA8f0sSE4onzf3Z3WCEo/FiKOpEOfvtdculH7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj0TRMtSQB2Bp0ICWC9g6Z5E8D7AFW3bml9bGFF3Rn4=;
 b=ENKvz0nDUrHbBbrbqp0LaV77GTjBttbrf2kq4rPr5e2CaJndZynkc0dZ07lLZl2OXD5S/YMsvR+Bq26TK4V5lCYlnOOj46vQAiTGDHgWUuQ/aN268T5emoYO709MsIpmZ3d0/BCGIa794hIqLMNLO7Lpt94wnDUJBTXDJE04uHXpQDcXA2rvzEODBkHfX598gDdVp9hZkSToM799QVzR/eoQf3IW8BdL527yB9D/iktEaU0F5QXD30y596ZOLKKtJxaW4jlcHFWcAIJZzYAHEMvGhp/d+c5qIDShRebpE1S2xRBUNp5/DsB3xqLuwRDdJPspdMfsDK7McPsPSZX0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj0TRMtSQB2Bp0ICWC9g6Z5E8D7AFW3bml9bGFF3Rn4=;
 b=OQzZzteG3m/ZCkt/wHLw5Oao+bnEP6F/ShNmR1ruzlyvGbI6TReUjE/FD0MtBd2Ure7a+79uJa982jaGAUA65uAJJkIOvQyYpWRPHaxCpT5cZPLE6j3H8/HbmqvPtCCtZLzy56GYl8yJOTvAQTMV1WaaqqVtWo0uRIHqzQPO0TY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR0402MB3880.eurprd04.prod.outlook.com (2603:10a6:209:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.31; Mon, 27 Jul
 2020 03:14:47 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 03:14:47 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK
Date:   Mon, 27 Jul 2020 11:14:48 +0800
Message-Id: <20200727031448.31661-4-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727031448.31661-1-xiaoning.wang@nxp.com>
References: <20200727031448.31661-1-xiaoning.wang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.1 via Frontend Transport; Mon, 27 Jul 2020 03:14:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 404da010-10c6-499e-4b4b-08d831db376d
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3880:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3880B548E8D333EE984C0988F3720@AM6PR0402MB3880.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jnu0pRRPXWi8bymedJtEEKsCe3KP8SjDJ4KVU+73F21MolorB3UJGwoVUnmj1fqFKWeq4LhKltVkeTr109qnixkPnB/ZeP1B/zHGRE8Vrdsh2zZ5QKKx2LAU0bXpQUO5RUc5lW0WMMXpFBs88NPyKtY/z/li1UNMHYufNE7sRgEhyVwxZ65+lpHsBmfbiIZlwe8yBRL71GfZo5H9vkZrNJUUPlNlEDdGff3Gz0c0bX/ZXILebKiT5rhiACXwnDjdkbIULEWWNXtjr2Yp11NiZnwhXMAgrGTpOesIR/WwarvGrKDOdu+TOw8TGQAYiKkKriDBzbpHv7wpbw9ACL7bBalj+whWJNQQeFL+pamoF7LxaCllxFGj5sKgXq9LFepE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(66556008)(66946007)(66476007)(5660300002)(956004)(2616005)(6916009)(8676002)(478600001)(6512007)(36756003)(316002)(4326008)(6486002)(1076003)(26005)(16526019)(52116002)(6506007)(186003)(83380400001)(86362001)(69590400007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cryyVuwYjgVBEJsU1geM+hL5eT6tauPGn6MreL0cSGr184cQNMqImCrE8z66Xcs0xQLvYS0/trR++iRWF1TtP8+aLuDhU58Gviqyben2/xhZFmcNEExLW/rSG3ep176scdZS52NybLIQwSmSGA5NWi1w3K8vvBoRTvNWIU3DVfZJuZd5qMjvGyqjyF1uSd27kI8PzF2T5ldKr65nlFaNd7KyW4QwA+r57HPk9zxHls+BJbn41JQl8QkCmcKwOAB40M96LuRI4TycChvSdD6vMlLeSqIMesCtbRBAPrMNzNqHoCj9bN1P002+8FG1lhuXqRwQKo+wOSsIS4Gk1TUMQYPqz8YWXiEp/TALC10AWbtpsA1UFS949s5jQ3Ki1oagwx9TLiXYFDgnXpEPnrOu5zBgysDTYT4YBl8COzbdOca1IOp7vEewsFwSvMozJtrly7kLalm/vWUsH3IklvTYfD1jRsZWLmCYh3Y7P4DeSlc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404da010-10c6-499e-4b4b-08d831db376d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 03:14:47.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+k1e3iYbbt53dGzk0x5wLr1EJuM6QKfFOZlJYw63YwL1z3KEHiamqAZwoOhS7wGMf2SrnY05rWwxthze1g+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3880
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI common code does not support using CS discontinuously for now.
However, i.MX8DXL-EVK only uses CS1 without CS0. Therefore, add a flag
is_only_cs1 to set the correct TCR[PCS].

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Changes:
V2:
 - No changes.
---
 drivers/spi/spi-fsl-lpspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1e426884ac37..85a5c952389a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -98,6 +98,7 @@ struct fsl_lpspi_data {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
+	bool is_only_cs1;
 	bool is_first_byte;
 
 	void *rx_buf;
@@ -257,10 +258,9 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 
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
@@ -421,7 +421,10 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
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
@@ -835,6 +838,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi = spi_controller_get_devdata(controller);
 	fsl_lpspi->dev = &pdev->dev;
 	fsl_lpspi->is_slave = is_slave;
+	fsl_lpspi->is_only_cs1 = of_property_read_bool((&pdev->dev)->of_node,
+						"fsl,spi-only-use-cs1-sel");
 
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 	controller->transfer_one = fsl_lpspi_transfer_one;
-- 
2.17.1

