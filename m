Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F13580A4
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHKdg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 06:33:36 -0400
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:18746
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhDHKdd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 06:33:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRPQJ0QQmtOCnBCgjXfVRzIp0kFbnOg0Tj2ZhapedsmW6e5aGAU8WwlyHojXX8LUbHEQPYOIsgxGzciF5tERK+esR8I9rAMr27pppmcvF8IIu1YDGOQAOvtf79I3p/VflzmOGMqW68IiyKGv9k8A7iMBN2TI3I5YDoz/C4WTlRsfVr78RyE00MFpByHIONOmCPgCoYnvo+MxQH9Yv0PW5UrzCGSuFpUiiQq8on+Z7hkY6iKFivlD+CCIIfcgVVH4WLIZQgw9zQ1gYdjcHkv4bBdpXzSq2iLLQCaXLi9ZTmYV3JJwKde9VoYsREeM6Sg6KrW+RDLeJLNF9Woo9pIr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txps5nmahOf5u3Q+w3JoCQTJBfXxPeXGk2BSAcV8q2I=;
 b=HVF/QFJl0OmnDAcRw6aD0D/kBPGwDFlYPVm2R1NnepZzejzj/fSUWkqYEyDbumIrfRBOseNtQDLbtPGwvulSqPU5HwyXwI48U7S9hlqmI97X5ku6IgKddrEe4hFOD0iBAAA8LVn12+l3DDJSgTY/w3kUDyTWUgQMdQNVXfw/Ocz4V8PxQEqbG2+bqtY0vqpwjRCijjMKQVy2szgVzL2dekW1Dt+8afPQGONvr/VU6cYZE6EJIYXfk3jlv7YrsVx9AY0tdME7tz4wLT+vW/PgYSNvFj4WR62Cxo7Ws7cFQKYCof+3YXU267u47vWi+giENaac99AJQyFjPkGYUp+Hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txps5nmahOf5u3Q+w3JoCQTJBfXxPeXGk2BSAcV8q2I=;
 b=jsU5Z37veOr6QHPRhKTR630tUo+ALGONWhumWJkimZWuWlwR4pAANQ9jRAduQlgnqq4+PHtzxKc2M9Nz44SCstFiNMBeQUTczH04LNtWG11WQbpqPHRbQRDbmr3BYxnxlIy6H8iH2ADUsY9q+fYg5jwYIobGWB3M6mrNZTSTHD8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4982.eurprd04.prod.outlook.com (2603:10a6:20b:5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 10:32:51 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::5cd9:3da7:144f:36f9]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::5cd9:3da7:144f:36f9%3]) with mapi id 15.20.3999.035; Thu, 8 Apr 2021
 10:32:50 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: add 16/32 bits per word support for slave mode
Date:   Thu,  8 Apr 2021 18:33:46 +0800
Message-Id: <20210408103347.244313-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by HK2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:202:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:32:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e73e417b-5481-4f46-94e1-08d8fa79a853
X-MS-TrafficTypeDiagnostic: AM6PR04MB4982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4982BC7D60B0E4218D250B7DF3749@AM6PR04MB4982.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vR4+QQZ8cLXzqy+LGk02phLk0DY102yAEybP144AnB8XjMSEIQIaBToUfphohUt++XdmWIYVPpg3JPycrBknGEKiYpryDf1DAYmmqXtdLByP5+bWtsuM0KTdv5nYtvHHBBVsWAgUVlxtrZyA4eG7uO1MuLENw/i8RL7Oln3xZ666crQzhNeaVpm48++ACUKvNDvtacbputgfLLP4tfSyyVK27Q8YkGYxAPvE9wYKA84VlQ8i+FvQzpsyCXCmParkHaeo0u5Z24u5fHBiOwVpCM4MwU/TLpAH7WZYnndzZu1tApIIg894rUjUTvkvILQ8pXfagbjVCt7WxFkh4iJVSmU7GqvuwlzAiRJrObaZB5WhhXUzCs2VjkW6LUykw2RnDGpSRWA5KSnOps8HsfoSrajXBCZiC94hz71SqDd8sj0N9M1Nen6Ulsy1haDWbdDJyGiJuADck9EgrBps0w2FkGBVKJkJpFI7E5YYwiMLnvEWHza5dsqM+MjvbuTe37i562aLezTxfqf6shWTEwRhltM+OxSo7SpdhwZtyZjINd/OzEg2lQJYNfhnbejm1ffhuTT7vxcD8dKrSh8NSR9Knqk7oZZXhEcRA7FeYEuanjgNjTScGkTBBVJ0VqIE9fxSNDt9m5Key7MZ6lD6kSJAaXlT3fG2m5Htc4WEu39JATgV5Vlh2oYCR+BRRefEVrS3B4tv8Av9mvUGUlFH5bOakw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(6486002)(66556008)(38350700001)(66476007)(16526019)(86362001)(956004)(2616005)(66946007)(4326008)(8676002)(36756003)(5660300002)(6506007)(38100700001)(52116002)(26005)(69590400012)(2906002)(8936002)(83380400001)(6512007)(316002)(478600001)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F8NWHqYAdzMRoVlRR0hlMU7qbHBFmleui1IxaX0/OqVyRvUMMxurq/O/xb+n?=
 =?us-ascii?Q?7pYXKCij2NKjD10PisIXIxKp+czk5NUPwRXzYFIeUuxkmtrS9nOF9jeCWVI0?=
 =?us-ascii?Q?6ehr7Kk4rqhnpGkxc2Vgy6Qh+aH9B/J3eXO++S1/Khv3hZ4nyJOPxmyoy0mM?=
 =?us-ascii?Q?3DtoOMb2GWtSXMRBOhHyRaNh8UFalomEIkF4rKPAMDZu0bIFwX3LcaKr94ak?=
 =?us-ascii?Q?ze8dwCmTPwbiia0cneKpTnDLeUw/WCpnzA1ySWoulAvY/mjKH9mDcEaKb5Xw?=
 =?us-ascii?Q?aznIHfqXPCFqkERy2KkShqGb6+OSiT+ZkMgsLh5q+vEf0666m/WV08YsOMr8?=
 =?us-ascii?Q?xPys5qAGmqIfoHJb1dM+Bq7uPnzJG4DvPZQ7N1iZPmyOePoBg/5mkCm/StoF?=
 =?us-ascii?Q?V/BGRc3Bil4VhKER9RKz/Ce8X4eOUBE8VklcIQWjm8KusfdjasZxp9P9w97k?=
 =?us-ascii?Q?x/SXzPjZ5q9BmlQuOYYa7rWPybHkl3c26lxbtG47y2t+lam0epaahfHnCdId?=
 =?us-ascii?Q?Pob70/Cwoujo56G7acRkakx45k0he8CPrZsz8j4wAEkyYy9znnHjMkiycI+m?=
 =?us-ascii?Q?yomsLJRgMLxXhDrCpeoPs63QddvRAvLRiXRXnuEvlqcAvodRzQq7XLvw3KOz?=
 =?us-ascii?Q?/A2LTvXBlNUEy0ouz2GkUUc4CZNxOnkf9Rdzs5B2VzDLAaiXTF/2kHtpHAea?=
 =?us-ascii?Q?igX3IuStHV6JIQ5VuosWc6cX3y8sghVpu2g1wvV7ZEE7Ok//96dNVVolV5KC?=
 =?us-ascii?Q?qDYQMcY7wyVAvRGmQVeEHEBmQTULiKFAy1WdjDbV8fbVjTnc+PnQyJAVa3Bd?=
 =?us-ascii?Q?v8K+AC1EA71jNTGKGIw6rqIqQtvA51gFq+YdLWhNu8HGkvWPbizW3jIQjESW?=
 =?us-ascii?Q?rS7AabjEOIu52oumcMLROkR3PJ5bqBm6vnfiv2j50row8cARf95Kouqk29nq?=
 =?us-ascii?Q?b/VWui/1cCCuyQDMfuqm3zkbN+9zMPbKYB4+mxlxUtwSfwVPiLLaN4AY9J9D?=
 =?us-ascii?Q?bcS/e2rCkseWRqg0e8rKuVb7QjZDt+S3krYWQo9ml1MjBkUA8zE0ew3jSZM8?=
 =?us-ascii?Q?q7OJQdJmRskPzL8/G62w62us9ZCW97vgvskuyrqqZtfStudFdNEu2UAZi5E3?=
 =?us-ascii?Q?bxphWfYy5Nxmo1+EOtS3Lx/QsjpJnNQYACaKhuwxZHMalBFPrOmW6K3Azy0e?=
 =?us-ascii?Q?cAGYSw2sWkSlfLlwt9JeraEJOGHbWq/67GG7pMJySnYanS0UP8AnESvzqMmO?=
 =?us-ascii?Q?d4p9Fv78D25ZQOBGdjY0vDNZs6PR8Uu5njI1nffv3prm78DK3WZ8Z6rmMfr4?=
 =?us-ascii?Q?x7k3zX1YM0Q+/RwTlyTjQHiF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73e417b-5481-4f46-94e1-08d8fa79a853
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:32:49.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAWQ2KFVkrIKZNSN+hVn/Lzc38YtHF5tCREBIbEMOBDtTXGX7DQh2ou45mf3/SIf6rV1sbOwLfYa3+nbXnaQsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4982
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Enable 16/32 bits per word support for spi-imx slave mode.
It only support 8 bits per word in slave mode before.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-imx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4fe767acaca7..24ba7ab1b05d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -386,7 +386,12 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 
 static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
 {
-	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
+	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
+
+	if (spi_imx->bits_per_word <= 8)
+		val = be32_to_cpu(val);
+	else if (spi_imx->bits_per_word <= 16)
+		val = (val << 16) | (val >> 16);
 
 	if (spi_imx->rx_buf) {
 		int n_bytes = spi_imx->slave_burst % sizeof(val);
@@ -415,7 +420,11 @@ static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
 	if (spi_imx->tx_buf) {
 		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
 		       spi_imx->tx_buf, n_bytes);
-		val = cpu_to_be32(val);
+		if (spi_imx->bits_per_word <= 8)
+			val = cpu_to_be32(val);
+		else if (spi_imx->bits_per_word <= 16)
+			val = (val << 16) | (val >> 16);
+
 		spi_imx->tx_buf += n_bytes;
 	}
 
-- 
2.25.1

