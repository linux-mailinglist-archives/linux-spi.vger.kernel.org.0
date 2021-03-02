Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2419232A5E6
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446204AbhCBN2W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:28:22 -0500
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:3652
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1447219AbhCBMvb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Mar 2021 07:51:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcAmCv/ZrNDBWqWXQjHT03keHLx/XA+HiUvAhen6XfutNPV92rzPotBmVBGMYLwYkIMB7X4/zOW1vhYC/V7XccEZgQSe6tMmk7SQtb4g+laFjopYwsQ/7gu5y1+gYaDiLORKJw4X2sSSxrHKb8r953i4UIVzEZYG+l4rpCnUensoA4Ol1YFXb0Ge6PqQQjjfL/uga8/Z/UNkKfeMvDGS40KTU/wGBMaetQB+IquU4Ta1KsilaCuWW2MhqP1G9F2EaQbx7UaCRIWSHNrHVhfwVGrGUZxVdaDw8GQLIvaFjhEOfGjfKr+x+CnmrHGrOQgkK1TVCiuBcmt2eDz+DrX5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqzPEJILRp73F1ViQtQRHxlA9U3Ih7hzq1x8DUMvH7o=;
 b=MhZjhNUpRuUWAecu/PsvLqmqGX8LA1+TQy0aBlHOqJCk/AAYhqEMYcYU7/cmH7luG/SXK/r5HfkeYQRwY/iBWNiu247vpukA2M42lls1TeNwwNAOUwIF3aJhnxx75udIESv+ChgGLn3toVynGOSBXXo6PpVbDfaZZdYcEqRdmLkHRoqIwyiN1aPKtoO2ZRqISbxMiO8g46mhfBp9Bmx//uF0pvfPOvGrPak+0ewD2rCV41oGi8VN9GMGPwZRFG2cPPsoMm8up0JyNSxvrUxXJmzk71L/KwTRx9XNex+T+kK+z0mHtqPt6hPYfIjJwSBzMnaeW8fz2L1s0+0S+3mgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqzPEJILRp73F1ViQtQRHxlA9U3Ih7hzq1x8DUMvH7o=;
 b=cDMdXilHsLSvABTdEB2ivKExq+kjYod+JaZf6pY5nT6AjNYgunwiwxPQASrtaRLkB6SRNbcxaYOLXfzt1XDgtU4PbXSc4nWY0ncF7C882+aFgsD7qiSYEfTQ33eXRGj1aExEvWb7Esu24ieUvLyjPIuyui9BvGhjsCTvlI2i+mM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB7PR04MB5083.eurprd04.prod.outlook.com (2603:10a6:10:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 12:50:10 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 12:50:10 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 1/4] spi: spi-nxp-fspi: Add support for IP read only
Date:   Tue,  2 Mar 2021 18:19:33 +0530
Message-Id: <20210302124936.1972546-2-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
References: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 12:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fe6587e-d8dc-42b3-009a-08d8dd79b6df
X-MS-TrafficTypeDiagnostic: DB7PR04MB5083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB508393131DD49D9FDCBC5C5DE0999@DB7PR04MB5083.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyxr+9aanOT7NsgRL4i7sNI0d8Q8XzElcw8z3ZwzSoXTaV7j+rLK/V8piXNs5R6bAX4bbsBdq0pZpdO8hsXPIOgqlJQIi/TeYDVc/2OwGJkecluJ7aCjsZrJGAv4Y8L3cq/D0gMdfSLNdAH+Kc9A5AkYRu5DKL5B0gog6koZKOAOSkFAdXeQBvm5YBeWFvY+8AFwAX0io4BMV2IzLkIIJmVia5ycTbCGlh575gLe9FNomgugzX5FL9Av+ncr3kmBxWGZ3Ea7zfCcsf0ce3/eMXWgDpKyanpMthvUyZrSTKpr3F9I7KGEMQ4NiHInyaMioU6jlHb+LNNrSQ0mliNPr/CSlJFnLap92finQEILehO5xsS+xH1W5MNuNYyar57Uia8PsPN6M1XK3hoHJX4KAX86dh15LW0ww6isPoOwYDCbOyvxaQS3CSqQm8bUt2+3ib4UwrMvas7Gf3vXUxw5gxXZEnHUvARxoRGqpp/nsqJ1T3Gdh0N7l17UbqK3nhS7R970UmsRFVYg40NzSedokFX8PUi4lMeEtyhZ5Rld30q9I5tqBUf5hvox1Q7f/7+wJ23N2TaaCpg0KGFN83l7sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(366004)(136003)(86362001)(1006002)(6666004)(8676002)(316002)(54906003)(5660300002)(83380400001)(1076003)(8936002)(2906002)(4326008)(478600001)(6486002)(2616005)(66946007)(36756003)(52116002)(7696005)(956004)(26005)(55236004)(66556008)(16526019)(186003)(44832011)(66476007)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IKxwqA7iqpxUqB+iYm8SGeNQ7oKT0EAHdMhhCDuXFFpCHk2M3wv/dF+QmWtI?=
 =?us-ascii?Q?X5ni4DHBl2hSOCQ0yuLZdRBTkGNvZ6vFnc+d0MGosiveAs7KmcvdvTVGKTsT?=
 =?us-ascii?Q?5/R5DoDd1NpiCpzHs0CZ95mDnW9JOh+6OLnAGe9l9J0v4G8Wov6118BhAHFx?=
 =?us-ascii?Q?Ati+bKxJF4f9l5xTtwiBOnD8x5s2sfy47zmkdPQ/SiYJ0SkXZbV0nO89G4rK?=
 =?us-ascii?Q?yBBH8ux55E0CYMht7wVru/sS7MXn0grYwDo+bG4+MTFMZiBnxbF4U/p8Bw/J?=
 =?us-ascii?Q?cqas6f4hXe39Q+5pIMVbs4mTe26Y0A31JSTyMQM25gg/TV4pW/+ayHQbnPp2?=
 =?us-ascii?Q?QB1AsM6yeYTgk546ABXnQDdMyJKr7qLHv8xUKqKNWAxaF04m08hPrCD1f58z?=
 =?us-ascii?Q?/1BXsJCTKj+w0wgGzJ6wTVmgzDpnkplhQs5RYu42krOknGsAOpMZV2zF5UyR?=
 =?us-ascii?Q?hJ7TUYCPCyMKYbx5ddM7hEYIvCi34x7sDXEuGxB0pCOAgPHuGUYFANriEOqn?=
 =?us-ascii?Q?rB962vaPcoxVS/jr173kWMexHYCSryqyVeM79XwIxi4Dhw8ijEmEj8PDxbCh?=
 =?us-ascii?Q?Q/CtFtn6OXaBtAJJ3g9ZkrSgVcx+15aIZnMfuvNpTM6mDKWBHjBrmThhyZCb?=
 =?us-ascii?Q?NcnwKJX+dHxRTdr9cx6+wPnuaBCNmmj0khKao05hl32w7+/Qrxa/NkV0u+Mx?=
 =?us-ascii?Q?aFom2IQW2s7+JwZuUrmrhDwiV56GDOkR+wkB6zggRw9m5fT0E6IA8uE9+zuC?=
 =?us-ascii?Q?5vyLBe4GIYp65GpVwe8LOArJNdsYTjvkPsEuzB4H4SVxwiFqwal93+VQmE1N?=
 =?us-ascii?Q?+HLwFDpNNvDXct1lejsaLAysSNSMe87x8YNzzHdMEdXIiXVHShKLVPZVmICn?=
 =?us-ascii?Q?BJUhKGDo8opA6pSZTtoH8vAif6e25w9XlBZ1U//wwR+fXxThIkOlytQx40g4?=
 =?us-ascii?Q?kGy6yRbKl3gZ+VRClVCl4jlihK99yIdCr3SPgMWs8H02pZAOp5Wyv9JWRbho?=
 =?us-ascii?Q?8ssg1QSflOUklX65JhSUfK4kyuuYJUUavYbYd6Hujhm/YEe3mTxGijKoTa7x?=
 =?us-ascii?Q?Q6RFC9EFjYAPp57rU9KU8UiWCrUBFKZeo2rqp/kde36LZO3/B62nu8hdyCHD?=
 =?us-ascii?Q?kTgKwMNQV0+75nUDTU1HbMUEQCpDbmc5ly+ehj3V0bEZWfsZvYRFQ62hoBc7?=
 =?us-ascii?Q?718ZsMFqrUBfUWpEzWJAar12WFhcQDalF+Ve2lx0ycyw/RbwBmRPtDuL3RVh?=
 =?us-ascii?Q?+bUOyblktjpBOMIDhQLFLo48Ny73LpQEqXAYDGwXpzyJIi35DI7uwR4wHaN1?=
 =?us-ascii?Q?KfTe9EyFsOJt0wduqSCi3aAS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe6587e-d8dc-42b3-009a-08d8dd79b6df
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 12:50:10.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zTK+oKQAjInImOs+VjvmGa2pGJrD3MnhLP2smeGzFAhe7Vel4nLX0kQE/yHS60WlZq8D3LinIYnzAO65tEUxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5083
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for disabling AHB bus and read entire flash contents via IP
bus only. Please note, this enables IP bus read using a quirk which can
be enabled directly in device-type data or in existence of an errata
where AHB bus may need to be disabled.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
v2: No update

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

