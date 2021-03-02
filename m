Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8532A5E7
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446208AbhCBN20 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:28:26 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:38274
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1447230AbhCBMvg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Mar 2021 07:51:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd29Yz14b0jtuBAyX2UquNviI/26TEVHux0Ksb2ILEk9fmkL/oymcFZbFyZVzyTb2jkK7qmWwfdik03MWAcdWqNdVOvNvTpc31lq13gW/VCJTRy/k4/U8+4npgpRf9wJGagQUVMyKhejvOP2bjyvO8HiDBTJW8KMikfGal+ZCm4fPS+Kt9+4chbSbMiFf6K1fRHJ4YCCucmUoapByxZFT8mFsdNxcD8IojEFAkLy/94vWYntK9fDEPVfhoiAT1xPp4uDxjUH9+ExHyvrvcrNI6r5Y9B90EX90ryU+Ia/FUtbbOjxm+yt7wVg05wigv8WDkEi3bpZK1w1wbP6j2oeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDyEs+sMgwFhTstNrq4MfxeqhJrN3c73iNJsEA52h34=;
 b=FkMEDdZrgZMezaxo1FwduQEIOxNfHXSmBb9t+IF46E5n+Fjh+GVY2yM4i+BZeXMnD2XtzAd3p3NREkYpJF667+KUQSTELgiC695MJ/OXDEByL2tKbOiXC6DPCWNoie+Ij4WxnSAC/yDgw/z5MQL7xtJHz3n8kVrGac72a7/YEMU2tOMK0vA0+KhHUSbmJhQaWLUIQkkFV5aiXt2FOy/ocNMb/kTeRyiL2tF6gmBCk3j1yGBSJeScGRODDM/mF53M8vXkk0BSXJMX/3yhBKZcIwujYG41r2LusKVEv8P8/A4/ef6NVHnZptj8iiw/RGX1p92cWQq2p6ntoccBOYuOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDyEs+sMgwFhTstNrq4MfxeqhJrN3c73iNJsEA52h34=;
 b=Zi9/KDSeyw/huVZwMN61kyhSlP0gN0eRqaCqs7H5amZd4nQUBpOVCn1BSuB7KUftbR8UCVSwVJRF3OwameljAoxKW9Cv4ngdSLySZOn/G9Pa/hrG7k15W2KTDGvaUzxryDr3LgsWPPS1lklVBHklZt4bQiIB9PwK6dvFiwUNEt8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 12:50:15 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 12:50:15 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>, Han Xu <han.xu@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 3/4] spi: spi-nxp-fspi: Add imx8dxl driver support
Date:   Tue,  2 Mar 2021 18:19:35 +0530
Message-Id: <20210302124936.1972546-4-kuldeep.singh@nxp.com>
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
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 12:50:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72e6eb57-fd16-48f5-1dc5-08d8dd79b9cb
X-MS-TrafficTypeDiagnostic: DB8PR04MB7180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB71801E29BD0797768BE17676E0999@DB8PR04MB7180.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0/Wfcj02hotEshR8W/8LZqtfGh/EHs0JQfzim1otcX0BVM7gd9f7dQjk+MHf1r0zwnZQfIeSPsDsa8ChWz2MDQqwgHadEMv/41qyEsxQCB1UKvuD8IjhOD4d299WKCyGjqCEMnjIX5R2L9GLUT847ksP/QyxghhlO74HCNg4FTs6ZZeya+tPkLd2WQOt9N0cPXMAmpjrR+80TgHeMuWLr9m9f6kmPxOEpTM8AeNLrl3iyjugeWB4BaoqEpKx3grALvXoojRdx+fHVZzWrw5JeU91KN33tdx60GpnJmhSXTjSaX3QXdpDDyfKy8tsln0yB0mXrheHvia0fDflExb0XC2eSoxhF8b17/M/9gJJ0W6lxmmAtUSLKGATPZGn/NnAO7GimLnoaaxM8W9xu9/01a4mG7BmKZWl2HAQBa1h8XppHpnJxkjH+rEvrQRMPItJqYAtzDapx1Xz/Rz+TisRaC4fhVWxhtliG2jGQSpA06GO/kfbdQIYfY4qDqZ3U+NdcmzZPefX52HARZrzmMNhc+xMe8QYfnm88dLPi7LdTk7ObKnxhdFCyMnc8s49P1YV3b29vIJ8braryA1o2i6Yh2RPTVrVXLqwIEK6LBn04Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39850400004)(136003)(52116002)(7696005)(8676002)(8936002)(26005)(54906003)(66946007)(66476007)(316002)(66556008)(83380400001)(186003)(16526019)(478600001)(6486002)(5660300002)(4326008)(6666004)(1006002)(44832011)(55236004)(2906002)(86362001)(1076003)(2616005)(956004)(36756003)(110426009)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GibyjNJ6tRY4jzSkGd0ApEjOW9MURCynO0UEb4iVRX1RrFwvCC8OHZ93XWUq?=
 =?us-ascii?Q?GK9An+iqFKGR21Swywpz360UAEDA9CW2AtVlEyKLce9i4FY7lU87GJSxlg6Y?=
 =?us-ascii?Q?iECeS/nl2Jdv708e+qqCBEOM7elQmsgpE9iYtDY87e2zWGvbSTr+lPEq17o4?=
 =?us-ascii?Q?+YTDzijnX9837m2e5uNe1HtlrDOCf28kXN9HAI5X5hGI0adxwFNqSrGZvUQT?=
 =?us-ascii?Q?/5GuOKFlsvrexunoZ7dkz3NMjb+/2vuW+8JQpvy1U/noMIOcOD4e8Vu/lkOU?=
 =?us-ascii?Q?gh6AT7iJGBpkyQFOJVoqy9PkHpwKljKWe9cfdbOnYztem6Lg05i8h5DjAZ27?=
 =?us-ascii?Q?XjuQsk3HZgEygzBKfF0h6ckCSPSQ3vijuooMz7SirkwcpcuxcffcGqs/y33W?=
 =?us-ascii?Q?iCDieEEMnOICLwm9oAeipq0XP2y5MMpzZuZ7teKPrHdoBQV7Rdlo9aucrFzV?=
 =?us-ascii?Q?lKydZDTBa5+QoHGTHHAlFfVFn40C27q9YCNCPifnt/PzUAdpWRs7BjVqMgNE?=
 =?us-ascii?Q?avkDHUT294HLyEAqwTQr4WWbYt8t4rAc9mGtiHz20FECXPVJeSt0jUwq5a3F?=
 =?us-ascii?Q?cyerNLc7CIEbialWDMAOs3+CGt30+hJ9GMLeqnsOG1HHXLYBTnmM5vpJwE0B?=
 =?us-ascii?Q?RuyB7dkJ5d/jKCUNYnfFitVpdiJRluraZrFTrfOvjZ0zdldcOJHGu1RXPcOj?=
 =?us-ascii?Q?JgwckSxlk6dM37S9qhs5oQ7OGyDu8viC82SKV/Q3XI1/HYAqYVEkeP83s3o0?=
 =?us-ascii?Q?vDGUA1U3/qDWzhgCV1L/9Q6ndB+RJp/DpV7Ty0CvOgowudEt6sBkEbSbMZWd?=
 =?us-ascii?Q?vYv10K504RUHCa+3HXdibibpsOc+xLv+pbSzMvTsyRGxihsJV+ubt7zsYwdh?=
 =?us-ascii?Q?45+iJT2dJs29ea5qu6cqgCJwd+E0qdBimfri67JJQUYJG+CWMFFwcbXkXt9F?=
 =?us-ascii?Q?PKUVd8jlL8nuzu+sSyUhNF5rrR67D2vETZ/khv/Ub2rFAng60HOGkUfSt30c?=
 =?us-ascii?Q?4IkAutur2hbreBm/hwmkY2SB8YQjqLhoklHSIsF9EdT9aCBZtghY6vp4Mqjh?=
 =?us-ascii?Q?Bnk/gTRN1QnM6tKIw5mh2aE1MwzsS9l3aViqf7/UDG+fUZ45Hkw6ayI5fEEX?=
 =?us-ascii?Q?Q4SbjTS0vwYLWDGLs36LYRnJCQE7v+w9ebOPlojuD0sQ/jEUV3B7yTb8FkIe?=
 =?us-ascii?Q?zs40qK+JKS0MXcRu23ZmFIYtQd0QPem0h4J7Vwp9wu7QoHWgdx0xJcRBA+P+?=
 =?us-ascii?Q?8guSPxm0iM1YCwqgmArBx9rN3brRG2vkrJ33GqGgoaFK/gpWPZI8bGjQGltk?=
 =?us-ascii?Q?aUx2vnGwBrk++6vT4lIOsMLc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e6eb57-fd16-48f5-1dc5-08d8dd79b9cb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 12:50:15.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67zj+wFL2CzwY/6tizp3YcsnmTL0V4rK6bM+XSO+/WzSrasafLCHudke7wkskkn0jq/Yy1iESesAVpzBXtJ/wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
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
v2: No update

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

