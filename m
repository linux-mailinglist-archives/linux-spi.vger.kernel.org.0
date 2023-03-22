Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210336C458C
	for <lists+linux-spi@lfdr.de>; Wed, 22 Mar 2023 10:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCVJDH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Mar 2023 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCVJDE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Mar 2023 05:03:04 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2907EDF
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 02:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQiO8iR4mK/Y0DIkj/7CbkAo7a4cSHTHRv70u8CQsdF+5PQPcpbuRhk2pG5DKhL5YlYqP8ui+fqZxlOVfhq3WlrfMd6kNfVtdMWe7pAAMzxglF+vW0pFXaRY9f6dDgBXzt2Oc0EGwE3Tcvg+/B74y/s+GkvGgFFqokNf9weyT7HNJ5PzXJGdAmGmL6zgOK0RH1/OlE424wADalorbQ32NP87CrwXQVJKLcIuH4lMb4H9E8c0ayJPk5GEVl/vyVLQOpLHlI8NbAcerqZ0XnPO/uvZgFg0WaWwO0gfSjU95Gu2GI5pkEt+3HQRay+Xf+0f5AUg7jzMYIq6cz28WvUNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NoNo06SV/+6J21doXq6m08sg+ILGWKHOX6UJSJKy0w=;
 b=JWnWapIb62fRQc59aaFTG4BM7F0E1+grTxh8FBsPH0C5i9I1JCZevKi6ZezGKmdOaXntJtuPByhl1xHYmTDXqZ3bLaumsgbtGMN8ilKm+AsVCSNnPdcBeQOK4uMjJpEescr8hVTYVEC1ilrcpOTrA/LVvLpfgVsMZzHr4zZbVomf1+O3rwrWi+vc8b8DhSRU5Bb+Yv0C2Plz3qvjae6uAigNxWDY97CbpbGobpbQ5XsrIxywQCK43hMUK9d4DH2kXZYySAjkpQ3cdgB9E6hB7msu2k5vQ74HADKk/8M6Io10cIXASbWG+u/HClXJZSkTmoMpzGiMaphUFkeFqYKO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NoNo06SV/+6J21doXq6m08sg+ILGWKHOX6UJSJKy0w=;
 b=YK9kRtdsgbaE/fvmb4e4tbiKsiyWJvvxd4Bm+tT0l8dHA/lOA0dRXPTrXuoehOd2tfM5wmkUSaJXZr7qIMRzA3RSmQcTV542hub5Vm5lleIM3EaPvQDjqnmeN6881Qew1pQ+t5pFDB3sm3AiEhYGdG81MCLBf5tQnL3xvw3mteI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 09:02:59 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::df09:aca5:4487:9fcb]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::df09:aca5:4487:9fcb%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 09:02:59 +0000
From:   haibo.chen@nxp.com
To:     broonie@kernel.org, han.xu@nxp.com
Cc:     linux-spi@vger.kernel.org, yogeshgaur.83@gmail.com,
        haibo.chen@nxp.com, linux-imx@nxp.com
Subject: [PATCH 2/2] spi: spi-nxp-fspi: use DLL calibration when clock rate > 100MHz
Date:   Wed, 22 Mar 2023 17:04:51 +0800
Message-Id: <20230322090451.3179431-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322090451.3179431-1-haibo.chen@nxp.com>
References: <20230322090451.3179431-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: e94fe5f7-eac6-42a0-691c-08db2ab43be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Wz+raWEGPMPZiEag64Ze+c7vC8VnWVI7xEgsLhU4iJOPMzOHW4lb6OtHg6pgNdmMtb5vkU9FgoWDLGRX3DdCyrJ7fKv6E3LXHOPrmnTcI47+iwuDuyokhwaoIsp0Ui2zrK/h1OD9edEiQSYT+nfdTB3d6dyBa+pQ6iO4x7/I8BP55iIMlcz3qjYX/CS1Tfv6TujcP9XL7u792mBPPJVeI8Cmq9MBBvogj8Yd03PUeR2ZuB64BgDLzS8wCpAAyJgQt0Amh9VQxOCdrUJyDJddq4vxFMnHRsnVSjxLe3LwgEFA5GQSU9Zh7tMXkCAyei2j9BVL2J+7rJREQu9YAtpUh0e332GNSCTHJGn6ajesTgYY5yDIhAius7PS1YLSlNKpSnNG/46zKbsOqx6epdp3YZjB8GG/H0m7RjUwDxr1d4yATUDhEb+ANlizXbuQSchQGqCdNUZTgP3K+ASDnfKKfT6YqvpfRjt5/TtjNw1odk5qCjrVphC8KImdFiZko61bwq9VsQD6GZGk1vbZ4DBpAsRnlbAlIOBs+LosaFj54HJ692Vpfm6Q1/5cfzQmNsBekX8qAuazsz2sR8HYG4+z4N3tLeKVZf/KdWmNTabL7eUaQoYLxEGjPaL6SumWuMYhHgkIbDP8zYbfcKotuXHtgF5mhPYZKEnWyHgJCOt5ORjhgcNwBby4jphlh/vuwI0T/zDqJN1FnuYPi0sOwXl0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(38100700002)(38350700002)(86362001)(36756003)(66476007)(66946007)(66556008)(8936002)(186003)(8676002)(6512007)(6486002)(6666004)(41300700001)(1076003)(9686003)(4326008)(478600001)(6506007)(316002)(26005)(52116002)(2906002)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5TVVTGHA8RXZIC99DBIEtm0jWU6n5RrAiWjyFU1hrB1J8Sg/vW58XSGxeFs?=
 =?us-ascii?Q?5Y+VcTcVmXZ7TIYXJ6uTP+Owwo0bYtg5lUokj6IQ13Y9fVT+M9lWSR25Lej4?=
 =?us-ascii?Q?wH/sJKCUOsyg73CGC3XizdGRq/78ejoZBBssLyHp+0i5drYwcnJ5eW6CgWzO?=
 =?us-ascii?Q?+7rxdMkpTPsKjBvnBrJhfdLS+L1pHq8PcteqxgKzWawSMO1zcyES7hl+JM3R?=
 =?us-ascii?Q?GCuo4JTlkogJzY3QjwVeT5+USYFmLHTxFxHaRJIndGyOQnhPHj6MjGvtYwRj?=
 =?us-ascii?Q?Vz1XB4neiHJj20HIUr6zxp9gW3zTsLSM7aKISVbjydGW1LMqFOfIXx/Ek1va?=
 =?us-ascii?Q?utv8u5CF9tazvGGRS5co2jZFBpCf5DqJRkqqNxO3xghHjogMyTN80uH1Y7bQ?=
 =?us-ascii?Q?LyyMB7kb75Hxit47DOOC8yrzlgMYhjzXMDCm8aC2t7yLF4p3CHv7U1kyBEUX?=
 =?us-ascii?Q?psA3mWhmHBRqIYdPmv7LCS/0QSAyQ0xRW7LLYWeUASzWavQ36zLmdtUS74ll?=
 =?us-ascii?Q?9Oscpsf+ByJ1QNncUqetz/vTSdP9REy+PBKU4s7dihRuRlqCLSWeA4kcy4hF?=
 =?us-ascii?Q?C1rtvNPhT+fgptHogtxOJumRGcaEh0/x03l1E2VO9YOZ2cZxOPsCeR+2n5vN?=
 =?us-ascii?Q?mBLD+8Eh80DNakXTJZ+nKkzliygq0Vtvl0AcQnHYwPwKMCP95sGYGq4mhJnS?=
 =?us-ascii?Q?0GnAIJPM/u0xAIh5hTtqvAxJ6bUjBRlv73O6Ow4uXUQYQZsiH33ccc2tLyc7?=
 =?us-ascii?Q?MvkNaH9SRd5DevD5MFpIR/j+H6eVLn+aNH5IqOaMFq4/Z2Ktc9YOzINCl2S0?=
 =?us-ascii?Q?+lIDJXfy3nmKtp0CMU70LUjgJfU0s1eNev9KCxQic6MR5LFvH6jXS61/B2NH?=
 =?us-ascii?Q?hlFP99/yLH8Eh+KPgsY1jR9wKTTqHU+AIg2l5pfldJzNq2H1D14EdkrRusWJ?=
 =?us-ascii?Q?eJ/fBWx0hucqjXR0oC3jVkzRWjfPHZdmFUyYI1FeUyBECd8NMIgQRtz+fsgk?=
 =?us-ascii?Q?ftOcdtftAFD5M+dqbFF4SgXiMrVqzM7r35QZCSirlth45ak7adaVO5/0DD35?=
 =?us-ascii?Q?FZ2TJWaVX79+Ik2I+6uRe0FP95ylyVb7KhYJBwXapnSKf35Wm0RhsiGxrjE7?=
 =?us-ascii?Q?WW5WKLY+iFcE8BFu8VnImohqsXcLCPUT2a5xeomaucm3lVrXOFLIMTbCaTW4?=
 =?us-ascii?Q?2Kn16mroObxggrwArhFtHmHKxT0YnLhMj6Gd9ja9MI89Y4cmdanbyxdY3Fqt?=
 =?us-ascii?Q?Zh8IKkNoQC4mwTMIlUCmwcLUHHmtN8McCidWlOK/o6jMAJSjv+rs1D6ztZoY?=
 =?us-ascii?Q?lHyZoBa7sIRWX7spyXTMzVnMcEt8RImkZANw8x7BKTF+2Qao0VFsfjmcFCFk?=
 =?us-ascii?Q?PjNMIrb4Fg2/yDLkeb07WaC5WBofPe9WDmsySw19wK/gj9awgaASWmK1+rwF?=
 =?us-ascii?Q?8nz7ngQtnCK3lyFeOAIY156fwOdlNWbt+YSe6+joFnpo6zU9lcut8BTrqYQG?=
 =?us-ascii?Q?+4r1zPhk+BKPO8DkJXKhimn3aMD9ElhVxfSalgaEL1PgMix+RYtI3d3nXgOP?=
 =?us-ascii?Q?2HBQEtjxsE0JbAnrQ/Uer2O5Bbccp/8MLAS8IEsr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94fe5f7-eac6-42a0-691c-08db2ab43be5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 09:02:59.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh+HdcflwoGkLmQRWeWMA6GmhXCTl/lUUVC1ZapkjjF6kE8BOlWQWDJ2fVhpfQ60okpFYXfCLdf/ujy/6+3IHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When clock rate > 100MHz, use the DLL calibration mode, and finally
add the suggested half of the current clock cycle to sample the data.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6735c22b9137..544017655787 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -214,9 +214,15 @@
 
 #define FSPI_DLLACR			0xC0
 #define FSPI_DLLACR_OVRDEN		BIT(8)
+#define FSPI_DLLACR_SLVDLY(x)		((x) << 3)
+#define FSPI_DLLACR_DLLRESET		BIT(1)
+#define FSPI_DLLACR_DLLEN		BIT(0)
 
 #define FSPI_DLLBCR			0xC4
 #define FSPI_DLLBCR_OVRDEN		BIT(8)
+#define FSPI_DLLBCR_SLVDLY(x)		((x) << 3)
+#define FSPI_DLLBCR_DLLRESET		BIT(1)
+#define FSPI_DLLBCR_DLLEN		BIT(0)
 
 #define FSPI_STS0			0xE0
 #define FSPI_STS0_DLPHB(x)		((x) << 8)
@@ -231,6 +237,16 @@
 #define FSPI_STS1_AHB_ERRCD(x)		((x) << 8)
 #define FSPI_STS1_AHB_ERRID(x)		(x)
 
+#define FSPI_STS2			0xE8
+#define FSPI_STS2_BREFLOCK		BIT(17)
+#define FSPI_STS2_BSLVLOCK		BIT(16)
+#define FSPI_STS2_AREFLOCK		BIT(1)
+#define FSPI_STS2_ASLVLOCK		BIT(0)
+#define FSPI_STS2_AB_LOCK		(FSPI_STS2_BREFLOCK | \
+					 FSPI_STS2_BSLVLOCK | \
+					 FSPI_STS2_AREFLOCK | \
+					 FSPI_STS2_ASLVLOCK)
+
 #define FSPI_AHBSPNST			0xEC
 #define FSPI_AHBSPNST_DATLFT(x)		((x) << 16)
 #define FSPI_AHBSPNST_BUFID(x)		((x) << 1)
@@ -615,6 +631,35 @@ static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 	return 0;
 }
 
+static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
+{
+	int ret;
+
+	/* Reset the DLL, set the DLLRESET to 1 and then set to 0 */
+	fspi_writel(f, FSPI_DLLACR_DLLRESET, f->iobase + FSPI_DLLACR);
+	fspi_writel(f, FSPI_DLLBCR_DLLRESET, f->iobase + FSPI_DLLBCR);
+	fspi_writel(f, 0, f->iobase + FSPI_DLLACR);
+	fspi_writel(f, 0, f->iobase + FSPI_DLLBCR);
+
+	/*
+	 * Enable the DLL calibration mode.
+	 * The delay target for slave delay line is:
+	 *   ((SLVDLYTARGET+1) * 1/32 * clock cycle of reference clock.
+	 * When clock rate > 100MHz, recommend SLVDLYTARGET is 0xF, which
+	 * means half of clock cycle of reference clock.
+	 */
+	fspi_writel(f, FSPI_DLLACR_DLLEN | FSPI_DLLACR_SLVDLY(0xF),
+		    f->iobase + FSPI_DLLACR);
+	fspi_writel(f, FSPI_DLLBCR_DLLEN | FSPI_DLLBCR_SLVDLY(0xF),
+		    f->iobase + FSPI_DLLBCR);
+
+	/* Wait to get REF/SLV lock */
+	ret = fspi_readl_poll_tout(f, f->iobase + FSPI_STS2, FSPI_STS2_AB_LOCK,
+				   0, POLL_TOUT, true);
+	if (ret)
+		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
+}
+
 /*
  * In FlexSPI controller, flash access is based on value of FSPI_FLSHXXCR0
  * register and start base address of the slave device.
@@ -690,6 +735,13 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
 	if (ret)
 		return;
 
+	/*
+	 * If clock rate > 100MHz, then switch from DLL override mode to
+	 * DLL calibration mode.
+	 */
+	if (rate > 100000000)
+		nxp_fspi_dll_calibration(f);
+
 	f->selected = spi_get_chipselect(spi, 0);
 }
 
-- 
2.34.1

