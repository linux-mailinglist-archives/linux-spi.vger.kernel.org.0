Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775D0327C46
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 11:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhCAKfN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 05:35:13 -0500
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:55680
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234581AbhCAKdu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 05:33:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH8g8cXNcnaQYMRTTclYMlfj5Z9n+4HL3TpqVfx154TyX9qHEjDEy4NcCZGQMiIB2v2ud6pPVEKzLvJ8bsB3baCFLiJjYRSy5xjAywjkiS1EDlH4Tv68ZhycDq1uteE5SJ5OokobjKucxdYnQ5vOhQJH89dDAzpJE6x+69q2QNu2tZ6ksdudW2CElts/P1wGqLeDdz/YNZVpTC/iEX95fC/npYvgTtlz/rWZahgaI9ytZ+kME+b0HRsIxR9iomyt2U/A/08y7z4G37t0zaDLe6YEyL5pyCLNXvnNfYPbgReDCDX141f+xM4/Utg8xUPGrinwaeFMMeSN0QPBeqIIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+SVYIWvq9PJTpZM8DucAP1a2Hl/FFE729zmW4OtalQ=;
 b=FKZESkYKfRcm8SSqjQkWG3F9BFUXqNyF+Eyr0y0ILEjJCIahPsL1ZHmfdPVy1Ssk9TsqWWxR1tqz1Kwt+gvx6MG1/kh7gvj1+pV4V98QrPSOW2ENHrlgEv5AC5t0d4GpXIhIxoGHApRZRj6w/Qr/+4OzHlPoKSk+gh178aeeYLS2sDqygZ/O3Zg5P3e1jibxQhWnCprJfNOS6xoxJyPEaDK25DgDG1sapqsy483GGURMW1dxRmTpZ8CWzVFm22ZzK7mMRkooyA6kJqF/VC/uINqXkmzVXRh26GdTTyANKnqK3Ws0lTERB5n5dStSluJCf1bxAko7o1RlCn5lAJBU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+SVYIWvq9PJTpZM8DucAP1a2Hl/FFE729zmW4OtalQ=;
 b=cXqqo10Yt+N1CTdB+SDUy7Hk7xr1YESWK4Yd5eYz8iZob06oFWvp3V+DV6JWwbPGPtLncitX7sgAQ1Cr/p/ejOih21ltLbJ3lfpyswA0Z2TwH+gcz5bHwbi4iuIjyyxE0znZtAIXYbagHkv+SmnLJrMsBT3bwamy9T7ewWVDcB8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DBBPR04MB7563.eurprd04.prod.outlook.com (2603:10a6:10:206::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 10:32:57 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 10:32:57 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 2/3] spi: spi-nxp-fspi: Add driver support for imx8dxl
Date:   Mon,  1 Mar 2021 16:02:29 +0530
Message-Id: <20210301103230.1816168-3-kuldeep.singh@nxp.com>
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
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 10:32:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce17b3ac-36f9-4a6c-a4df-08d8dc9d60ee
X-MS-TrafficTypeDiagnostic: DBBPR04MB7563:
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8760
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7563E01324D7086BDF9C2D9CE09A9@DBBPR04MB7563.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKp5V0yiAavs0HRlxubeTiPck1jVxgkCpwNiUWBlzkjfxbBBu3w35LcJ3vY9OX+OWPmipHIy13p7W6AmxtY/c7w4O1vpr+U9eREX0kLAhO3gC9i923x7DVf9+9IxC+aBkdnkrecnAXEu+VkgxmRuLqKuml5DCqHpv3KRwbS0FNk116XmviJ7MBS/hw8pFJJhxMnVw87MwE27ILOgXJwdA3XKYp3GJMKkHYKqXkNkt2vq6whooTqAzm2Mdou4BRZ26EK77mt5ayUrSbGW69YWRH2ZpcHjX7YJ1xNtUkCgZosE9GDYQIpW1rRXRIxvwJ+ll5M3EGaBRwG5Dvrzxg+8jAUoZBYx30XUiocSiVFExyjfx3Uex10S1KT7LPzNvJfgh3zPXhLpbhsvhwWtv8HGM3iWM9hzMBxM+tsNqS7BfHpiV4DYQzkrXfHUDOyGJ1wuRvYzuZN6sfXl5A20udOcYLGDhtEhmD2DUpb3eDopAmwUeFdaEdRZZExnJVngtR54MskaX1R6YQrA25jFjqRbMZIXH0wKZ2rLiPihKMUT3G9MT1nGA3J2h7z0T0UYpCvQjEWpuR2HRzQXkFR0tfftnhSUyV5NyaIfLE6gidjk205jAT8DKadX9g7Ls3fZ+Shu81Fjn1lREFGE/713nmUDW2jmYC8grRONJvt5FZRyWTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(956004)(2616005)(1076003)(66556008)(8936002)(478600001)(66476007)(8676002)(966005)(4326008)(55236004)(2906002)(44832011)(1006002)(6666004)(66946007)(6486002)(16526019)(186003)(86362001)(26005)(5660300002)(36756003)(54906003)(316002)(52116002)(7696005)(110426009)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Dw0/ZI56v1TVU0n84KEyuBscQcZW7uWG3t8ZgQUB0rt/IOL1hhoIUgud6PX1?=
 =?us-ascii?Q?fR4GkCtkusk0hU6+ZKwVta8AYNXE+dyMIGIuQh7D9V5Y3uZj87SqNXtTqcUt?=
 =?us-ascii?Q?CmWW3TArW1ul9G2c7EtxlVMtRBzPGO9P/CIhoILNlJXbkgRo6Rkk+rwZk/f8?=
 =?us-ascii?Q?IAH9F/FmOBkAQqZreULTBOmYDw8Ktgly8a/KwGc6ij36X/CS4jHc2jpvA36U?=
 =?us-ascii?Q?UyrLFoZ01Ai37uUs8ssiHZ7SW0vqkarbtzLxR2f6D3n6xz6ehCPeIn/QMiWS?=
 =?us-ascii?Q?q6H/zLZvCy6yKmHTck92P/AUoiIxAvNrtMSPqOo99fwjiDWq3U3YVptfjDeg?=
 =?us-ascii?Q?k+5FzXgZj1zP48XTleMkpAaBmY8iye5Cc2AuFRFvURgX5TgiXg3YFjgtR2CE?=
 =?us-ascii?Q?ssExZex6Zpl4LDLfKIEURC75250A5cV1h6YixRu7SY0agm5ChAAsax+/LzQ3?=
 =?us-ascii?Q?zizzjZ0btIZMPx2EBpmYR54efLPzOdgoPXd+VWPpqzg9kHWkDJBWpRw5Yf4b?=
 =?us-ascii?Q?itbAhka9mbaE+Ap4qxD3UJ914w6nm61Ri/+d4FNdBic5zXNIF+h24zC6YNQI?=
 =?us-ascii?Q?4KmXQMDkauUXBSXNbAUEDkoXrGDzO442NSMXIfQ79pW9a7BMcBBiXKoRPX1m?=
 =?us-ascii?Q?15FrhezzR/1lR7F20oO+E1R0Leu1iBVDP5KdXWeE7fTjz9Y1OFkdIlHZhHyd?=
 =?us-ascii?Q?qikqBE0Je033C8IG5K13UXoReW2CKvZof6+OeEImG1/ILpt6Gc1gHkyrVicu?=
 =?us-ascii?Q?11JvCZWn6ixto8cSkbCpMiZ5bvnejKhMW428B8pqTFcaWRwtmwqTdPCnb+oj?=
 =?us-ascii?Q?0+ATbq+Vp3KRvXe2sb2l5rwIxKLhnOpsjBwogR34s2tt4mb+EuYI1PxFGrva?=
 =?us-ascii?Q?vW9f++efI0EjrIPtDTdtnQ1mHLFpS6GE+t1KNFf8LsUh9iTN57K4QZkymSYY?=
 =?us-ascii?Q?fXW/vc9A0NrHilBJf8SgKbbSlhFf2TIvhhUVpaDgv5yiJ3RkcFiWxClme+N/?=
 =?us-ascii?Q?zKbG10xuyitYvdfO5Hhz26jXYbWRstRMyyypTqbnWuf/jhwcb4D+JSdvH62q?=
 =?us-ascii?Q?UAgcTOlSfM6cFST6ifEfnygIwFyU8RbpjztnW4bGfn3TtkHJWybcteawp2D7?=
 =?us-ascii?Q?hv16VtcB9Bg7hWQG2FLjXvfnMv87RbO301TkLQHtcGSm1wNCdy5lQuadTSQ5?=
 =?us-ascii?Q?WmdyDHLP9+FnOZKZ8nR7kczjTMcD+yPr2qJg+qT//keugQg/EBVo6RnVvpRf?=
 =?us-ascii?Q?IyMFtfUyUpy7s80lLTvUfEWNkMWrngn3tg9dOFEeMTbvP7VaRLbSlUK3ccRl?=
 =?us-ascii?Q?gHDrqLD5EX0YsgPzYcQFSW95?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce17b3ac-36f9-4a6c-a4df-08d8dc9d60ee
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 10:32:56.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+s5x9QOEyIANyX+Nu477OnAEs0e4AbOGnNkXWM1Cf3GvkFddphaX9Q+fBHKQOv8lADcoPebk/hdBqQyGKUJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7563
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Add driver support for imx8dxl which support read through IP bus only
and disable AHB bus due to an IC errata. Use the pre-defined quirk
FSPI_QUIRK_USE_IP_ONLY directly in device-type data to disable AHB read.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
Hi Mark,
This patch is dependent on
https://patchwork.kernel.org/project/spi-devel-general/patch/1614593046-23832-1-git-send-email-kuldeep.singh@nxp.com/

 drivers/spi/spi-nxp-fspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 829391e20e92..80a9278d91ed 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -346,6 +346,14 @@ static const struct nxp_fspi_devtype_data imx8qxp_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static const struct nxp_fspi_devtype_data imx8dxl_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = FSPI_QUIRK_USE_IP_ONLY,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -1168,6 +1176,7 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
+	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
-- 
2.25.1

