Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9481DB37B
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgETMeg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:34:36 -0400
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:34089
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgETMec (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:34:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnM8C9gh0IoKajH3kscnEgEjO9jOlxQCds6pmz2p2T7h6HkuKrO0vram0m7igyoQIBT5wuHuSSFVxq5E3B/RgDZNUqUwWRVD9UAQ1X1b0VbKNk1Ushupnr6SKhibOuOdV/XerWtvYA/QEfAc48rpibnVEsY+1M/HAy1r2jebJXyCRbih22nv+WYMsygc9c0kNYjKRSkXnVNTbAuInyqvVRnGtwl6pB23nusTX1O7TYbDvVXNIDRyRf5gRil5oLJJxWmsYpCflEh42AVxA20tMdri+WjPUr6vAxI388jwx66eIahkXiElN3nhsieYOYdL3mfACu12WEcd3s95mK78nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yx0IR+9/TNLsZpIgHM8O9jKDpTRHMYZbaruFg9y6So=;
 b=O/TIuAU6iYnayVj7b00MTiBqnFyhm57Qran6vYvVqMQdQS0zJUUeidqjv6GF6P5lOHW6p5G5ZstsEXqHSxERMudVDhyS8hadnZ41zSE+lrbzq10O8le0FtGOfRyniKn7jSjRF5IzDMMN6SrA4ZWlDYJ+dfkj17rjBz6+xUallpOOYl7wV/Fik61c2fic3ucsrrwgXhJHMaQyfYd7QQFaD28qoO2Hkvr6G1dDylChkbSBw1jHAWBbf3drunvTTwPFUkgO4fITfgt9t40dltcjqL+EB/3+sM3EXPnojyGqfF4Bx/jG6Ki8oOD5vX8ZFZz4xY1uYBRCM4aL2Q+MY/iA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yx0IR+9/TNLsZpIgHM8O9jKDpTRHMYZbaruFg9y6So=;
 b=plsnZal9cvZyYmYWBZ5itSxSvn5blhxyugGiWd3xBdRtjCc+0YHiBB4k/nl/oCFUbMKsIYh6Nk1EkUjIGwdxmyKy9rhpUlb8Y+mdImErI8pmFWdEE9/PsyimXdKlWBQgaVYIaYI+oqgWuUJZ0qYIpFspMZ4Ynz1dtwXm4SaZ3hs=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 12:34:29 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:34:29 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 06/13] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Thu, 21 May 2020 04:34:18 +0800
Message-Id: <1590006865-20900-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:34:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57c0d02a-a9ec-435d-5a03-08d7fcba238e
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4279BBDA36660B864A680A6C89B60@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sl0gmkPaxF/lrT3b2UtPQFm3iHMc7XI8MQoxIfbNwg8aa3pjYBfWiwAz4BCABUYnXlJEooTlnZu6unOSwQINRBbSrHLzCNIQgWlUeaH30TY52y9IZ+sWtPzVYJ4IrOPqncC8x0kRIEr8y63NSD1KdHCevadqks7QpMf8rINtFlWCOJdm6ds2sUPmpzKu7rhpRQCg3RGdsUvxVAASDFImI+nJR/DIIt0Qty8GG0anXM+4vNRalHm/pZ9/oEe9mGk1RKYRI7IOjumN8VXrfZpD1Z7jjE9U+vguRRT4rRi/uYv/xC/5l7nNs2aBn8GTS8dCuDOQPapCKGvQoihF3KAFn2GmShytFltVQIl+WWPpndX2LRpsU1q+M528SeerEFj5TejpNZ+awNse32+Nl0xH/SOkEqmssrrjlF6IdkmWQ8IllQa3GgXRiiJvSmmgb5Nh7XGzTRf6dZmmxiYMd4gqh5Zyl/rfiFz2xsWCnNeBixE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6512007)(36756003)(8676002)(6666004)(52116002)(66946007)(66556008)(7416002)(8936002)(66476007)(86362001)(4744005)(5660300002)(186003)(478600001)(316002)(26005)(6506007)(6486002)(956004)(2616005)(4326008)(2906002)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Hey8q2TAFvVu17xp8gd0iI1Am2T9o0iopDcLt/eXE9XzTLpKeLj5I2eGqkKH44npToThnVurFLLAToeyJSeQfXHhDP1cC1TGJqB9Vwf3tne2hWIb8sGuCqzqv6j3jFUsQVYklLTQ49cnQG67ZOrOwYfCvezI/keaLlMb/yXgKzP0qdt0SAp/JAsX7S0px+8SL1J7EhLL+qZHnjD3cdmC9N43UzQIAlXhB0XVzQ2mykGec/bySOY8OC+sYMcu1xvRu2GPK0H/2LG26kMKvWT9/lj+QQDn5LgTODzYIi+nWZZ6t54tcbJG3pTsfM38eLKerbv0+FSUzPGjzes91dnZA4VFTYk1gaUtKrKM59NIhsmnwS0wH0VVNEJDnPP3g9lY/5/ZzaJ7hxUwFzXOYbySvRSxe3d1kNGaM0OeTo3BoFEX6mKIgsSaeWaCucrRZngoHYVYdx1lz7EIx9F76C4iQYH6JkXiLH6AMeMN2Z33U8U=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c0d02a-a9ec-435d-5a03-08d7fcba238e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:34:29.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: On9cksjIeAWHbMNaY3AV926iKDIEXG/a6rj64/452/5y/DmOn85o/7hwHvJd6DDrIiad2KJj7RXwGVEWB9cuKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4440ddb..db4132f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -920,6 +920,9 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
 		break;
 	case IMX_DMATYPE_CSPI:
+		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
 	case IMX_DMATYPE_SAI:
-- 
2.7.4

