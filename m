Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015F81DB36C
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETMeO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:34:14 -0400
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:18311
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727027AbgETMeL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEdoUFePiZkIsw4CqqrIOdZYMUUXVE2f7KCuiIxX7d1JMav3C2tCaEPMMve2Li1mb+VbgxjovRptgjTmEqYkwR7TEUixU4gPgxzjIy71lYh4YcDa7YBWFR1lDIqRatE5O7Fi+dLR39+0VBFG9UK8Rfhd0jfgHwzuZ3FZ9bxDG0PI+XY/NYS0Ka6kTamtoQvjRyKOwJARm96gG5XkeQRix+8+Cd/DXfezYVtuCGvtC9o1yQd4SACG655iBuSU4z4LdQkZlyw9T/52Na2XkdUnGO9jXZIFwu71dvg36TyALEWDgg3kUKUOXZsQmk/imhsNRnOw73gaa5tryYW0GbBEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkWel5GTo4Ihj7UHKviP/TaeYL/ZKKWPea2xxel30eY=;
 b=jogScNNwimgJX8thUYjeY2t0SkX5ekAomqlCaF4x4o9l3F2KlJoEkS2QjI8H1wsviYjctvcTnNHoIai8q9cn/yC2X26qI5P7IV47P2Y9j1gTDhRqEmNLgZh0oFnZ8Nz7DqH45FQn9/AYy4vcTIXUrzSm6Dp54DEh3FkomKGYILm0CNT+WMAA/DtbhxlCzMd0xiHAsPquDAb3U+z4TXuTpJlE9BNboisEvdzaliGyxHxJXMKe2QIL9UdwuZld5jcLRXG1j3UYN75FFOqoyZrC/Xm8HE5IeZwSrX8+gdcu5VPNTYB4of5giXU1jgic591GytJFobqO0bwbg9g5N5Hg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkWel5GTo4Ihj7UHKviP/TaeYL/ZKKWPea2xxel30eY=;
 b=RfMk337X4W5+eLfP6ANNY1SlpdEFBwdMaQXlea9mGRG8az4sb/5tGsIHoYD9LdeqhqwbQObVeV2PPJnbPdmxdj6Hh36ludaIkDFtcu3DgEttQxzvodv6794VSvycDxsLZOdmt+rKdfQwuGbX4i7IrX+ZM/od9yLM68o2hgusuIQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 12:34:07 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:34:06 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 02/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Thu, 21 May 2020 04:34:14 +0800
Message-Id: <1590006865-20900-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:34:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a604e03-0f41-47a5-ea49-08d7fcba1663
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4279B149006CC8C205F8D2D889B60@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itqrnfTEUV2I5WkH0hJfoAvJN6s9X3e2870/MDBgTmycxDnAg8zuTpNFrUhftcxv36lAzr6aUCMlU2kNjRPI+AbECl6643mCsn4lasBuuXnDlWaUH0cuwQwF89x/LbfSvwSX0eQVZGCLNChQS59gFsynywG3bbt/+FY2Er/pHA420+ysFENTroE9ekXutm50+HYuJoFjo66zNBq5ljlXUn4UWqfdNIBD/97bFmGqMENkL4eY8fz04NuHjIXZ4nN7aGrbJsqPKp5DkSqtAV2wObpWXQzJ4/ljunSkH5B100ocAaeQCi47kHNt8N8D4t3henQDi7JsUDFnwZGFTa72oElnoMTXEK/6y7b+S16Ht85BcezpMXI2ZuyABHRCIMpwf7pnDfolKWmoVn88+sG+brSgio3yhwFnzUdG9I91m0QZ0980WC8HZbfk5611Gbyz0oXvPYdG2ntRXG8HhCPUW4sDUMr0mj1muTNIybjefYw90JJbsiC6LGl8Ds3w7MuyYEcJRM4xwS7VrcIkebiYccIOY8zR8YzmMPY8N6LPikDglXr0173mVsiGqQt/og6W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6512007)(36756003)(8676002)(6666004)(52116002)(66946007)(66556008)(7416002)(8936002)(66476007)(86362001)(5660300002)(186003)(478600001)(316002)(26005)(6506007)(6486002)(956004)(2616005)(4326008)(2906002)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lv2V2twpuKz7aPNiJIrlmRATay5skuOEcBZu4yX483IacEAN7GMUBxpRX2QQX+mB/hxnhBbg1zZKHkN9O2IOMX5GjXANKHCVX+qvtzApBb3CYAenukCwsdsoKxBOmlFFNAsAIOdvkaPM4r27H5Q5vH0zIZYLaWq7IFXt0LenP/vjlwzKf0W2a0hN+KcaZaODYl2WaPhPaxb578dNBhu/qXLPW0VlNGDRu0DG7YOaewYdtLYH6YZwB0J4j56erEnFSvKVa83TWbbdISQhnH7fhBh4oq9quVcCRxiVnxmxKkV255rZuWcZwyW9Xh18uBoeg88ms3Q7/+b3fisXVJ6zlLLBOeNJFzA/6RnSnH2hwc+X3t08G0YAj+2Y91GuI+qzmS8kpLC+kyr0P3aDrj8HLh0kUpDD/mu+H93G98IInqsADrOMB74+KXtYmze8YTxcFrYCCPMUbdK70xFIFLw9gYxOdXaJ9bXdwQgLSsiN8qc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a604e03-0f41-47a5-ea49-08d7fcba1663
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:34:06.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYJwY6FvVbbDClT4wPwZXMqcY+qoFC1YEj+8sTeJeprmTCwho+eTVZx3Qgh3+UoV3AythYEMvA96Le0vAD2ohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are two ways for SDMA accessing SPBA devices: one is SDMA->AIPS
->SPBA(masterA port), another is SDMA->SPBA(masterC port). Please refer
to the 'Figure 58-1. i.MX 6Dual/6Quad SPBA connectivity' of i.mx6DQ
Reference Manual. SDMA provide the corresponding app_2_mcu/mcu_2_app and
shp_2_mcu/mcu_2_shp script for such two options. So both AIPS and SPBA
scripts should keep the same behaviour, the issue only caught in AIPS
script sounds not solide.
The issue is more likely as the ecspi errata
ERR009165(http://www.nxp.com/docs/en/errata/IMX6DQCE.pdf):
eCSPI: TXFIFO empty flag glitch can cause the current FIFO transfer to
           be sent twice
So revert commit 'dd4b487b32a3' firstly.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 98da446..4a50331 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -337,7 +337,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -351,7 +351,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -365,7 +365,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -379,7 +379,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
 						 <&clks IMX6QDL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 9 8 1>, <&sdma 10 8 2>;
+					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.7.4

