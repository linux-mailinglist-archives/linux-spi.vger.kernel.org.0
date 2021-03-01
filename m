Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE790327C49
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 11:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhCAKfi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 05:35:38 -0500
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:13344
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234512AbhCAKeO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 05:34:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTQ60qbteh1P+Umtqb9XmamT+pwJsuYLvBFj9IqxHp4ukjSX3tcM2k3CYwht774R0OTng8h2fecU6ZZM8BiakbLljXkGn4RmUsnI3ZXsryIXc1ZXpJaZH8EFFrFLuph3sc7NY9ev30xTufdUVqx4yXNPo2G7yE8Rt9QAKSrlMYmFfaqRfMucHcwalMQoc13BnKtG7p7ptXfGQGjzHLNP7kGN4gGyOdldfGQ8jAH7briBafiBh+LJBTUz9zolVlPQAI7T6C1+M9Sd5QC9T4iogZNx9EQgukA9rx8wj9HIU9ImCxl0YltcovyA9EmfXLEygOuHMcE9w+sLfbQ3fEhA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KdcLIJuE20GDPx8dfX8Ryie72EJbuU70G1qnuuEqnY=;
 b=JNGf5OIZL75cjsnwhOlYls3Yx5EG0Vo3JxHNEL5X/OjyiE8zNxltgFXWbidDk4JZqQeFFGIFpsg/CC1NoIFYd/SSKBwAUv9bijDsedEmrsuchncpu3ppqEK9cMvE9iQMTuKWkZ06fEAYxm7nW9Yb+HbBmaX9bulLvLscDeqWOVbiRDv7kszuTJ4+ee2uzGIdE2In70TcXSmO5Bv90s0HaQUY6DJ32c5xwusoVG/lPv3lJW+otdpjVRKOPVCM0H120cB5HnLm+VTMOJ7eYCYGw7jU48aAgzzQOSAvqheAQ80YHgEeLKBwVOOgQ+dstk4+xFacYSs2OV4sgNshRmqDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KdcLIJuE20GDPx8dfX8Ryie72EJbuU70G1qnuuEqnY=;
 b=L+SI0WWz7qhZqitAQ7EhbaYYmxK/H7aWO5NQ/+JU+jQNUgKsGniVR8sKadZaJochjx3Ykk4FqPK4a57UrKD/4N6QOgkPzzf0a6kzNiLGlqN8QEH9PnVef9CrmVR5ccfkXN4OeeIAnUg2oOUkqjqs08lWoHCvPKn9VdIJpEQcZkY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB7PR04MB4236.eurprd04.prod.outlook.com (2603:10a6:5:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 10:32:54 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 10:32:54 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 1/3] spi: spi-nxp-fspi: Add support for IP read only
Date:   Mon,  1 Mar 2021 16:02:28 +0530
Message-Id: <20210301103230.1816168-2-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
References: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 10:32:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3b0ac76-8df3-4e03-ac58-08d8dc9d5f39
X-MS-TrafficTypeDiagnostic: DB7PR04MB4236:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB42368792143B4DEE552CDE08E09A9@DB7PR04MB4236.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wiAcurn/i5GSEroKiZ3hd+BiH/+zaJpPwdESsKBmm2cXxhJ8m80nndOXkw81LLOI8UiOAFFdOJiPTajXWi7Yvj+iEMw9jgTFwGMYcdo/FO6ZdzAxx25hCuzY1ivguYTAGtBMeMsIJ8PurU0qlQ86D0PVskV4CjNi2nXWwNUnYKISaJKbS0735tT5HPH4zPewfR54JGlJp0eajJ8FViZpg2/y8/+M/6WsemzbD7/hJH0duwXACLZlCunfCMak9HZBJDSU0AboSzbYZNj4poHe8nulPppQkmFmX22CqzzWSLLdlB4s1u9jR2Kn0qKUdSbehxGN4t8E2YVEyz7Z/mo893POjAvaMC1d/YjXkaIjgkmXW/i5kKBhvc6p96Wb1YkJDjqFazkCVrIeSOWTtu0xljyIhsW4oyBHATG4X14nJS+HtFf8yvzsd1mUbZzal2dC+v/lNCoDqGC8eCk/qhpvWyFQ8YB9a/DhL7FBRJkv1WTZYT/jlvChnR9MVqHo/0rGxLykkjPQU6AIT+48K1oC5TzwfwFRBVNFFuKxRSX62Vu7xfrfQUeTpWodmhIGpuXmug9Cf0YEFhidWwNBXV7FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(86362001)(1006002)(5660300002)(7696005)(52116002)(6666004)(66556008)(66476007)(66946007)(54906003)(316002)(478600001)(16526019)(1076003)(55236004)(36756003)(186003)(4326008)(26005)(956004)(2906002)(44832011)(8676002)(6486002)(8936002)(2616005)(83380400001)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fbvse6f/8naleQZh69EZjT4Rz7AZU0e8qUfauQK3Z1vV9TqkOFoZ/rRSKdIk?=
 =?us-ascii?Q?LXzWkCopC1j9XiqcJ7G3F8tcN6Fn3VLhLOF6eOjspJHBJlk8vAbm9zI7PRTD?=
 =?us-ascii?Q?Oi3o7uIFwFZ0lIIRZopTQoXyYAKWsHLd94jJNsr0IrLOGj6u26Z3FtWJnfUF?=
 =?us-ascii?Q?z1kSZjUDiW3I1mevW5qUbQv/czgLob+Y6C9H2Kfq8gBnLk5ri/Bl9wm2cRav?=
 =?us-ascii?Q?WPakOzbIp6UGH5GFSFwVDJrf9a2Ylu+QoLXw3bAe4kSVSx3OAp2nQmYgSVo1?=
 =?us-ascii?Q?NqOmGGlzzCaP4FRM4Up3JPehx2x8G6AHL0j58mqfFRhdutxlzduyXCL9ZsFX?=
 =?us-ascii?Q?QvWSy8DBiRnqcYWW8X90hmBTB0TQJtoEQI9a6aq077PyoLwxjhsMn8SZh2c8?=
 =?us-ascii?Q?Kd10Is6CdejON0uV0SVJnJtmK4Gc1AuhQuu4uCAa1w/jVnkR9h+l5lbd0Xpv?=
 =?us-ascii?Q?R0ywEehURcZZIPqmBGO+qlpsBTKy2Bykx8MCT9CdVD7JJSKdvp2Q8Os4Uejr?=
 =?us-ascii?Q?rYhKL+TM5qtlVX3QI6266MwEqfWHzngq7RFUe9lYmFP/8i/jNjUSlBn0ZJSc?=
 =?us-ascii?Q?9SAMFmVZ781R3ZhdNCfXNkc0eNhK2hJJfa4gb3aXtqkMh3cxIdmjoZ3UAZYu?=
 =?us-ascii?Q?Ta1zQnuPHmXess5AH3fQZHDNvbEC1gUV6+fuWJfc9rtxuYmY++Kqmc4loEGc?=
 =?us-ascii?Q?qEr4rwg/3L6w5ENNK/ocLnTn0nmDLgwU/q1maddIAHAXyzSqiGR8hTQqLVj8?=
 =?us-ascii?Q?3vH0koc6ozIODcIqIE6FWYfW+hg523nyiIQD+jxfOPs7CXpW01SLpa6XLbtb?=
 =?us-ascii?Q?a2fo6yTTR4v6QlctWRtufOBEX0AtpuD7rYC+3FLWHQXDmH2RHbi+ZpWxj2oX?=
 =?us-ascii?Q?NYq03ixc7aBn2o1SkgP4FLXMXt2S5q6hI3pCaoIyHpIrFOujJMh5GgYkllqo?=
 =?us-ascii?Q?9jpO668PHBslgBMRgK4DU1Nd2fFKCSOM3AAJQqob2RMOJGYqBF/mw9IsbdQr?=
 =?us-ascii?Q?yXpIk+zRMBVcFW3mnYAYVccjAsRCaYkORONxKequrOFaWdz+qqTZYOJZlAsM?=
 =?us-ascii?Q?Vuj/DJhCOZrAwxrLP001WX1ZJyXyFGLcyK5jIBNrQISHez6mu6tDmR3zzQhT?=
 =?us-ascii?Q?t/iP+ZZM16Kjyw3i+exciQ1pd+f7F25jSN3GX5IXEo34zjUQCLL6RkxhJXUc?=
 =?us-ascii?Q?ZBiAWsuJoLph9JUad9CK+6sF5LFCs4yw3jnGFqoJiuGJJcn8oCZ8hrAWjVVz?=
 =?us-ascii?Q?q9C62+EUPjK2I8BJHSFOu/33d9N5Rae98x42lW1HeV/Pil28ZS/C+zj3RAcI?=
 =?us-ascii?Q?wsilayUKeUfyL68YwmybmHKa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b0ac76-8df3-4e03-ac58-08d8dc9d5f39
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 10:32:54.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2Df8ROzFs9YfDAMG8PZ6QbwqsQsoQZU4UrvcXWz3xkooZUYRSrgHM/+vmW10BROYnlJ/XuAscHrwcE73ji5aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4236
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for disabling AHB bus and read entire flash contents via IP
only. Please note, this enables IP bus read using a quirk which can be
enabled directly in device-type data or in existence of an errata where
AHB bus may need to be disabled.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index ab9035662717..829391e20e92 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -311,6 +311,9 @@
 #define NXP_FSPI_MAX_CHIPSELECT		4
 #define NXP_FSPI_MIN_IOMAP	SZ_4M
 
+/* Access flash memory using IP bus only */
+#define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
+
 struct nxp_fspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
@@ -359,6 +362,11 @@ struct nxp_fspi {
 	int selected;
 };
 
+static inline int needs_ip_only(struct nxp_fspi *f)
+{
+	return f->devtype_data->quirks & FSPI_QUIRK_USE_IP_ONLY;
+}
+
 /*
  * R/W functions for big- or little-endian registers:
  * The FSPI controller's endianness is independent of
@@ -553,8 +561,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	for (i = 0; i < ARRAY_SIZE(lutval); i++)
 		fspi_writel(f, lutval[i], base + FSPI_LUT_REG(i));
 
-	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x]\n",
-		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3]);
+	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x], size: 0x%08x\n",
+		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
 
 	/* lock LUT */
 	fspi_writel(f, FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
@@ -852,12 +860,14 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	nxp_fspi_prepare_lut(f, op);
 	/*
-	 * If we have large chunks of data, we read them through the AHB bus
-	 * by accessing the mapped memory. In all other cases we use
-	 * IP commands to access the flash.
+	 * If we have large chunks of data, we read them through the AHB bus by
+	 * accessing the mapped memory. In all other cases we use IP commands
+	 * to access the flash. Read via AHB bus may be corrupted due to
+	 * existence of an errata and therefore discard AHB read in such cases.
 	 */
 	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
-	    op->data.dir == SPI_MEM_DATA_IN) {
+	    op->data.dir == SPI_MEM_DATA_IN &&
+	    !needs_ip_only(f)) {
 		err = nxp_fspi_read_ahb(f, op);
 	} else {
 		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
@@ -888,6 +898,12 @@ static int nxp_fspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 			op->data.nbytes = ALIGN_DOWN(op->data.nbytes, 8);
 	}
 
+	/* Limit data bytes to RX FIFO in case of IP read only */
+	if (op->data.dir == SPI_MEM_DATA_IN &&
+	    needs_ip_only(f) &&
+	    op->data.nbytes > f->devtype_data->rxfifo)
+		op->data.nbytes = f->devtype_data->rxfifo;
+
 	return 0;
 }
 
-- 
2.25.1

