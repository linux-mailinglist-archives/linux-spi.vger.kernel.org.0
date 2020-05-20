Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA881DB395
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgETMfM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:35:12 -0400
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:10702
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbgETMfK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:35:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGN5lXjDX6hPXvE+wWrgfZgJPlEEICr0J/dGGsYOEk+SyVqciZnKvX99MNgUywAY3EPgUgUowngJ7geEJ+EocwCx5dOlWY9ZxCFDhv0zR4sHkd4I9dItzsmtYUr9GbgO2gzBB0Xlp0ygWAPHqEsIZ3/ySjD0f1ehvDgIN/Gv8PvybDQ9DBu3MANaBylDxbfB+yQ/EoFPKJfnS2BUcJLgQ2pCyJB0TT3Z0zqinMfMl2qflXW292qowWVL4fI2tYnmoS3AkiUZut2Oas/+3acqIU2BY3eWiOLbd5pCGdopVdCEiFIwrGi0g7jdBWpyELaYyYDbgA2nzalPoaOo7MuE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVa9IWELyHni7gn3nuBup0HmNm+xItFbTKwgykt4ySE=;
 b=nmSr4ggtOv9JLOPkAh19OYFJ/Klj3XaTo4oFbtbdQRfwAGxjhu6XsJCFUkOKaL9rIU9AP2w6Mt7aNEBFgSp5B1dal3OCNcivW04uT4HZBfuEEgPbLS+nsq+NgbBvg5GdWQmUWRIgR2rEQEEwqQ0InB3iV5pm942TeKbZE3AgHWfzjxG0+TYSiX4cuJJaBR3ZsZwZBMPE51b713cR3Dh7DIShy53cAxnx1wvUX1NtiGw8i9Uc7We3q9gHVQAei923ofx3sBoSKJidTawW2X+swK0NXQcyxGnIBWUmg/VIgL9jHnCKk9JobmPWuoyl2OYWBGVg40Vp0btUiCK4L2yTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVa9IWELyHni7gn3nuBup0HmNm+xItFbTKwgykt4ySE=;
 b=Wxt5J1a1C+v2V2NWBnfem7KK20+N2WFAbusMZtZJcZSQkr1KhrK9e00A6kSQmqYJkrkDA9iQywqalwZDXz3Q2du1I37br+2DMpWI9vN+3Qq91HzwKrwcDk5Dy+2bqY8OMpMeBAIqX9az+sxMj/rneNvMo7n0NvKdQOIuKqs3uvU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 12:35:07 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:35:07 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 13/13] dmaengine: imx-sdma: add uart rom script
Date:   Thu, 21 May 2020 04:34:25 +0800
Message-Id: <1590006865-20900-14-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:35:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1de97e8-79b2-446a-8858-08d7fcba3a23
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB42793DF2DD3B098C7941420B89B60@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mi5hlGs0tdYjOFEuLNJVEN4cK+IsTNWO9ex87kFhJy7KIL/63WKYILmbjVTq7NAk+xtBn8KLx7k6lFkM6wuQbqLMeKTM8S8yNgYkXFbt19bVG7PYjuhEIjG9GFcJ6FbFWLIyTbGv2p4avTqgaVpIPTDvRPUVl4hhVTKhycWqMhDfitmHv3hCukE32qQbnHDWPkvYCGRs3LtbIcJUX7vgYLNCmIgPj4B8wJO1tgCczIJgSaIecty4SXo6lGg+PgdOOTdZ8kauHIm5/V4TAwd6aeWZgdcru5KGjDiNw03z2wYWR0s+GbXQ4NbAssqchq7zTq3CBpq5ip07EXB0k3Y2311r2EonnX28+CNIrVkiQSjSo53H5a29FaZatqB8+KGmN/Zs9JnqzF0RcuFjIiJ0SttrUsHPW0j5fCtMSg0lJ4H0aE7ywmAVydaDsk24WpInl4mKehF6R0pko8CJK9VewdTk4IU6jO+BA7VIBRQ1j3tAK+iPmR37+NDBOx/d996dGkB0IcVvXwYOHt6uT3R9i/BKvWxmhU9o1hMP80XJNM8QvQi5es+sIjhTKLq5E1Y+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6512007)(36756003)(8676002)(6666004)(52116002)(66946007)(66556008)(7416002)(8936002)(66476007)(86362001)(5660300002)(186003)(966005)(478600001)(316002)(26005)(6506007)(6486002)(956004)(2616005)(4326008)(2906002)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mUvhQsFsX7x9AG0T9clLFbQ8Zix1LHkokOt5dtPfBYdV+ryvMb0GQeP8gkN93Xbah5N6MqU/F2Mhmw0IAsvWY66qCcLvRgWnTVnm6M8Ou/fPU11B9SlGg14zB/L+xzwFM/hR4kPkPAcNu9J3fAI9N5Ov8NQeRr1yC3UTw9jb52B0OjBUVt0RQVKVIfys70E/tEGteLHmNKXHOBRl+P5SmTig8RocKdIG8xqn3bfwg0ud68PtN9lxPfblsnMFTwCt/2K8Q7LPlblt2UDdDHtKvDgv4Ajx0TnbQfQhWFX3ss8FSeNM3qK8kKKc4xNDr5iZqak5DFcJZJxLJKZq3278ayL84foQzC3OYLV1kbDMVAW7tTPDJLfyQNVQZTzQor7d8m1htJMHwBSVHwiMiCrk1c9voGtYXCyGZrOOAvKbLQEq7QF8y9+x8K2NVDKGYGcjEJPEed+fCrnHPh2KvFNovhXE16Fkgi4OtrcEsGitP0c=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1de97e8-79b2-446a-8858-08d7fcba3a23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:35:07.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHqH0MGLCroThVXnRdh6qnqA0ODuYsoL2CWRLacVz1yvkNq4W5x0U1S+/hOPbmvPaV9Cl6zKFsUJnE9PmgVzKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For the compatibility of NXP internal legacy kernel before 4.19 which
is based on uart ram script and upstreaming kernel based on uart rom
script, add both uart ram/rom script in latest sdma firmware. By default
uart rom script used.
Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and add
back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for i.mx6).

rom script:
        uart_2_mcu_addr
	uartsh_2_mcu_addr /* through spba bus */
am script:
	uart_2_mcu_ram_addr
	uartsh_2_mcu_ram_addr /* through spba bus */

Please get latest sdma firmware from the below and put them into the path
(/lib/firmware/imx/sdma/):
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
/tree/imx/sdma

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c                     | 4 ++--
 include/linux/platform_data/dma-imx-sdma.h | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 320104f..2ca7935 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1718,8 +1718,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
index 30e676b..e12d2e8 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -20,12 +20,12 @@ struct sdma_script_start_addrs {
 	s32 per_2_firi_addr;
 	s32 mcu_2_firi_addr;
 	s32 uart_2_per_addr;
-	s32 uart_2_mcu_addr;
+	s32 uart_2_mcu_ram_addr;
 	s32 per_2_app_addr;
 	s32 mcu_2_app_addr;
 	s32 per_2_per_addr;
 	s32 uartsh_2_per_addr;
-	s32 uartsh_2_mcu_addr;
+	s32 uartsh_2_mcu_ram_addr;
 	s32 per_2_shp_addr;
 	s32 mcu_2_shp_addr;
 	s32 ata_2_mcu_addr;
@@ -52,6 +52,10 @@ struct sdma_script_start_addrs {
 	s32 zcanfd_2_mcu_addr;
 	s32 zqspi_2_mcu_addr;
 	s32 mcu_2_ecspi_addr;
+	s32 mcu_2_sai_addr;
+	s32 sai_2_mcu_addr;
+	s32 uart_2_mcu_addr;
+	s32 uartsh_2_mcu_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
-- 
2.7.4

