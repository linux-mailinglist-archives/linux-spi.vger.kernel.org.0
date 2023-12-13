Return-Path: <linux-spi+bounces-257-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD56810D06
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 10:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494BB2814CE
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500FE1EB47;
	Wed, 13 Dec 2023 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c2WIBRNe"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C6CAB
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 01:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzOetlFohWrwHsZRkOG3PQ0R3TFX+p61lbeDzGy99Nb4y6bQd8208x+zeHMyOzF9B7ntuMQijV1z/OZrMQHiytAfBq0/G4s/SfVov723LEik34CsMmkJ0WfUlDNedubNvVze10mdBzIfEbWCZLZSvZZdZhRSyZjZt1zp4n4eZWTzuXIsTxrbx6/DRUz08XTXf6eUKz3MbaBpB9LwNhLB2EmNxxFTo4J2cMbUZrA2eFjmVlMyrsUvXemInDt8MlzqBbfbYDz+iWOVmPiY4uTw/6jpxZOJwOEgBNEeDDpnYZ7Ah3PUeNr6LMM45+qvNZ0piGAM8I9UVt8I1gSFMBKbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC22BE0U++AlIh/jzxT56zC29pTQW/83790aRgwkMWQ=;
 b=e5Nac59xh2qTvXUyx+JXg/MbGub9z0Ye+9fHU+VK7hJVDueW0dNhY6E+lZRroRCcwTRYGPoQkSVfrT8vx81KqgTnpHxZnaV+AwwdvGf+BAJm+AMV0BUa+HV72yTWWZGT4f8pocEqUOeM4MZ2h6Qc3nlwImRnzcIOAWyXTVNA1z3FKpX+Jhm1Ulyj27kMF3QeBUsOrW0jgayYcyg/nVER3uNHIAhJbiPHJz8VJWOHrG1TTt78eKHXX3j7vTydINfrWSkxQ4evQcPRIPH8siUGHTnvlDh5yXu/QzT3YcV96xCR+4YjWtW+Wr+gu2urgRfHtPZaC5nTjMUTQf3Z4P1Eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC22BE0U++AlIh/jzxT56zC29pTQW/83790aRgwkMWQ=;
 b=c2WIBRNeuOwq+L9yh7t9Er3I8pPrFpJGtII8IQIIXoJIYfmJlIyauQ1ipZiZ8ZRsrDe9iw57uW0U9RQwKKFcHDlY2NzTTZkBtMCXTkAsIZEQoR3a97Hw0gcgzC3eTZh+y9iS7KKwQR9vTKmzHhXs/ddLs0da/Yak0Ee9U0yK6GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:08:44 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:08:44 +0000
From: haibo.chen@nxp.com
To: broonie@kernel.org,
	yogeshgaur.83@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-imx@nxp.com,
	haibo.chen@nxp.com,
	han.xu@nxp.com
Subject: [PATCH 4/5] spi: spi-nxp-fspi: add function to select sample clock source for flash reading
Date: Wed, 13 Dec 2023 17:13:45 +0800
Message-Id: <20231213091346.956789-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213091346.956789-1-haibo.chen@nxp.com>
References: <20231213091346.956789-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM7PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 609e4db4-4b7c-43fc-3a8a-08dbfbbb1b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A5puDSjsWMrIkiGOT2EYFitOwHf3K8oeYb9xV9vmHswcq16TaHeerQdTK4/71WNv8GfULrB0Q1qGwd1q+0RRjGO4yIkQ+/G+uWmfoF4L1M2I7YfK7f6PIIfVqyIQIw3QnqU8AonHqiC89vL0wKcNb3PjnYUuZZzsr+4Zv49ZrHV7SzHcyoK67LhQe2sWHSDgfnWZi7lKl3iCxg4cejJY8/bK6di2fSfg+plNWq1UJILO9g43UFErDPuEWSQVr4U4NQCr4+2kqZXZHHrU1QxsRVa9td5BxsdppmeX/nTRV/NGX5GP7MQjiMNvE8i3vrHNk63TxLHymKgcUV7oxFWm8Md2g05pObIbRxsKAtOAhBIQFD2/KEOC/maR759QAyWtut8t5TuRQUUWyjYJ82kyNj744VI4mIQAL5l0PIxTsd2Tm4EguU0BXTrMhBgIllS5D0HsG2PzHgWcefyGiD9GEFAQKuE8joeX9NkNttwnsJsbFgliNdL3NHif9sRrZi6jUROuailD7SLc5Jjl+ktzkBHLT46xrtMIuhFdrTlG6MUHlqNSmnuPBjFahrTfdfBK5r7pzA4HrymOd4MMOesBr5YImvApWDXuY8vCFTpfqH26LGLATgZK/1l7m59lzsBu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(2616005)(38350700005)(86362001)(38100700002)(36756003)(83380400001)(5660300002)(9686003)(6512007)(52116002)(6506007)(8936002)(66946007)(8676002)(66556008)(6486002)(316002)(66476007)(41300700001)(2906002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MCnpN0c/wM0p54gGpt7faGgaRF41mMF6djWUib1u1tPiCuFUqcOX51ZHClEk?=
 =?us-ascii?Q?HhnWogvA13yFyDv8tatCa2vlGDx2uh6wg1yzR8ktopYFnV6FwS9Q3dwJ5Xhe?=
 =?us-ascii?Q?UGokkQVImwAopeGZZTog98ZlwXdfpXQ+lRACxtEUYijU0fDFhg4A8EKEMPGW?=
 =?us-ascii?Q?AdNliqaZd42W+KdphD0nH4TLjwig+XJhRWenLEg0WJ0QcLGUiGCL2F2Nkh2c?=
 =?us-ascii?Q?3ijk0CrAeYxY0Hm3KLOMqtztv/XU4R9yWHGSLNPyC4eSNEjzKfDwHT/twVs4?=
 =?us-ascii?Q?8pI/wvEpI0GcChA444onSwwrfKcRLz8u8ghJwyKneP8mETIQWumtwoVzi8qS?=
 =?us-ascii?Q?potuTjhEPeiD13MMikkuWGecAAdGC3DTocy9ebV6abDe3PqnbWKh9APrAmOz?=
 =?us-ascii?Q?qAtYDfmRWyxNiUCwyJXBoqPRWtTo7XFENuMxfKfpLlGyQQl2EUwgxcAuKeCm?=
 =?us-ascii?Q?JGqoBDdAwqUMAYVwKAMvffEi47pS/p5MvEoaoduJGyGCyMXdYHsoUtE+FFr7?=
 =?us-ascii?Q?84PywtOqK0OCqw/HNrmZJ5fRrJdtOyrqc/tuKdR6uaOjmEVbLNz+oAalIATt?=
 =?us-ascii?Q?MNJy4HBwH/C92/0SKQ+4SRJ+fnvDQf2B7gp+pOUOAZHIr2zNT2D5ISYhAgek?=
 =?us-ascii?Q?DJ8ss9WFQAZIj7PHcndWsiPxyQhiSNYggSvmL4RzeuhfhI8EL8DwNq9hr95t?=
 =?us-ascii?Q?Y1sK53vwRlLh4/SNmSlWml4PWk6M7hfjxhMLWC5bOQ4IfjwM5FNpJrutw6T9?=
 =?us-ascii?Q?pho8gJcoZztqAiXeUmnnxq3bEG1fywFQLKwOf/H9Buehi7IhkaC6G1G39/bl?=
 =?us-ascii?Q?HSKzYVVcttS4TzgWhX5m4h7Tu5CpARt3Cx0sSI4a8v9ueHbbYH7fLcxjekLo?=
 =?us-ascii?Q?Z4FUx3/t1xUN8bMIO38MfH9DX+ri3EdPaZSu+5UOIJoxb6aKd13K6Y/baI+w?=
 =?us-ascii?Q?3blvRcONWZmxMeS64SZShXzAjZORwz5R2V2GgEBnNvkvLh09U49oGSzBYZMl?=
 =?us-ascii?Q?q5LEhxrWipOQm/ngryNk/NVr8nV8h/SDpjdVnOu2mbgd6Na8kMw695mmuH2v?=
 =?us-ascii?Q?HsMKwCRPQvU+B9qFVMErw38ZfSbFsNqauTc5BK0HdpT7G0t5Kg10IpX1rOP2?=
 =?us-ascii?Q?AEahe1NBwOiFhPfIEZ8LJiE5JNlfVxOmOGmiLsZTPJUmaubdI6uTUGt4GtQ5?=
 =?us-ascii?Q?tR4bWD3CyullVi7zHcxlMzrIRSZXwn7kjJyasHZldQVW9+9CyYYpEEIeS7BU?=
 =?us-ascii?Q?3pcu0Ph5TSF6n65IVW9uVarZqkcTExRQkFKyH92u/eiyqZyk2fKEfh/zhTkE?=
 =?us-ascii?Q?+sLkFJIoJ8aEdsZ3iepwVBYL0YGdxlAWCd/O6BEvTOL+BZ4iFOncrlLvWyl7?=
 =?us-ascii?Q?z5WUy3uHAZv2GgfrnqxDVX7TGgz4DD4sERpi9kCmXXjCIVCLM8bKAJFxPFCU?=
 =?us-ascii?Q?Iq9T6SK4QE3YZpY3kykuECaZiXIjmkaK0IecJhne2cItVoVu0YYG6clDBBSW?=
 =?us-ascii?Q?ryCYhU8JWnxi+gTC4APx+1OodPZEN867X1ateabk4hyBP6c1LGf++S2LBoW5?=
 =?us-ascii?Q?8biVxN0fQlW4XkRpQAlkYwLyASKjzxpYzBbgcg/M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609e4db4-4b7c-43fc-3a8a-08dbfbbb1b99
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:08:44.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Li3/juJ65MDDPO5Kg/So5u48YTsc22mpxNQD+Ckt0Ui3sl7KuVq63IuXknC0u+zCC8jOrl54ZXD9JfpNSJVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981

From: Haibo Chen <haibo.chen@nxp.com>

fspi define four mode for sample clock source selection.

Here is the list of modes:
mode 0: Dummy Read strobe generated by FlexSPI Controller and loopback internally
mode 1: Dummy Read strobe generated by FlexSPI Controller and loopback from DQS pad
mode 2: Reserved
mode 3: Flash provided Read strobe and input from DQS pad

In default, fspi use mode 0 after reset.
For 8-8-8-DTR mode, need to use mode 3, otherwise 8-8-8-DTR read always
get incorrect data.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 47 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 2562d524149e..0330454b76c6 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -395,6 +395,7 @@ struct nxp_fspi {
 	struct pm_qos_request pm_qos_req;
 	int selected;
 #define FSPI_INITILIZED		(1 << 0)
+#define FSPI_RXCLKSRC_3		(1 << 1)
 	int flags;
 };
 
@@ -928,6 +929,50 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	return err;
 }
 
+/*
+ * Sample Clock source selection for Flash Reading
+ * Four modes defined by fspi:
+ * mode 0: Dummy Read strobe generated by FlexSPI Controller
+ *         and loopback internally
+ * mode 1: Dummy Read strobe generated by FlexSPI Controller
+ *         and loopback from DQS pad
+ * mode 2: Reserved
+ * mode 3: Flash provided Read strobe and input from DQS pad
+ *
+ * fspi default use mode 0 after reset
+ */
+static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
+						 const struct spi_mem_op *op)
+{
+	u32 reg;
+
+	/*
+	 * For 8-8-8-DTR mode, need to use mode 3 (Flash provided Read
+	 * strobe and input from DQS pad), otherwise read operaton may
+	 * meet issue.
+	 * This mode require flash device connect the DQS pad on board.
+	 * For other modes, still use mode 0, keep align with before.
+	 * spi_nor_suspend will disable 8-8-8-DTR mode, also need to
+	 * change the mode back to mode 0.
+	 */
+	if (!(f->flags & FSPI_RXCLKSRC_3) &&
+			op->cmd.dtr && op->addr.dtr &&
+			op->dummy.dtr && op->data.dtr) {
+		reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+		reg |= FSPI_MCR0_RXCLKSRC(3);
+		fspi_writel(f, reg, f->iobase + FSPI_MCR0);
+		f->flags |= FSPI_RXCLKSRC_3;
+	} else if ((f->flags & FSPI_RXCLKSRC_3) &&
+			!op->cmd.dtr && !op->addr.dtr &&
+			!op->dummy.dtr && !op->data.dtr) {
+		reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+		reg &= ~FSPI_MCR0_RXCLKSRC(3);	/* select mode 0 */
+		fspi_writel(f, reg, f->iobase + FSPI_MCR0);
+		f->flags &= ~FSPI_RXCLKSRC_3;
+	}
+
+}
+
 static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->controller);
@@ -948,6 +993,8 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	nxp_fspi_select_mem(f, mem->spi);
 
+	nxp_fspi_select_rx_sample_clk_source(f, op);
+
 	nxp_fspi_prepare_lut(f, op);
 	/*
 	 * If we have large chunks of data, we read them through the AHB bus by
-- 
2.34.1


