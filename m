Return-Path: <linux-spi+bounces-2770-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B18BF606
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 08:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5C51F23148
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069417C72;
	Wed,  8 May 2024 06:21:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52E1758E;
	Wed,  8 May 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149276; cv=fail; b=C4O7OwhkE9ueszZ/te6g29iW7gjq/UyJNV89Z2GAQvG+9k43V8YKFHOtpUMkQrgRpiC7ZcGeSTNlbX3MX0JGA9jbH5HzXh2STohVI6ncb/iL0S/UsybYQWKblyln+P89Xcj8QboNRMfGuBrrS3QVBPSg0Bai9Eq3gFG4IBgHCfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149276; c=relaxed/simple;
	bh=vhyXDstkQ9XgXmpG/Wqgw0Oa4OHHIdRXHfTJo/HjLNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyAcso21+7bHqspvGC62oEDNv0SIcOW0zAwszMgq6T055Qrnyz4svOMq6TL13tnRz89UkuwsOeEUTM6h1E1e97kIAY6sVM/jCny4SAOCLLbw8792QEg4Dhf5rgyJYasa31ZHcG/a6f/PBRNyOgYGJsE6XAxOa2vrohexgVJHLGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+D02S3Jb6qLpQtBYM8R9QOaaWfsrK76jMKvm5OLJR0GzGhyV0Ny4SSt62ZbCcDHfFSapyM/zFiw+W+3DDoV7mhPbMQFHBgTTCXzdSvO7ji+vPXKrVDNh91mmuADDm5myl0ZGqh+9zzNBiJ91crLZg+KH1jeGXk9ITnPnJ758T+rswY3l5ffxDfueaFMSLGBwjyqu/rpTLckujqCLUM0QE4bgsXPA7xU/Z7KIVXm39pMOE8utvfhXZaPZUhTHnNRlbJeU4tttN77JDEZntkgVIDanRmoFXUFqeB431FV8Url7TZXHjroDHFoZaJPRr64PU/t/yxt5k/ZuxP7bx5pmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l/yhPdxSaHesfLxpxwia9e0XvULHbFNP3fr+SAq+x8=;
 b=UDBzAgAWUwBxAKQv8cW9dNNsgyPwaRmuAVvwUaQ2SolJ6bk8UUR6uPE/7ansGk4KsvYN2MpI+ocisU/GTedB2hJQbPDA9Ui9E6cy2OlmvRjwQq9sx7I69iVamGepKGzvi0Z+fAsMQTRFZWmhoOqQHO5f24VaHVgv78t3MCSrzlWbWx1yxMqtR5/GzNLnGhXCnzCgQ7u8TYPNH/c6Pu1F1WRkQR5ultfzZUVec8z/mbGKdanwCUA7CN3fU9Chea/4e7hUvkfIoqJv7zuJCk/+Se/JGSbKPJE5dtkDKrXHgSFKpWQqANfupdcEJuVsBeiFVKivlvVrUxNLg6gsSdh0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1283.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 8 May
 2024 05:48:05 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Wed, 8 May 2024 05:48:05 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>
Subject: [PATCH v3 1/2] spi: spi-cadence: Add optional reset control support
Date: Wed,  8 May 2024 13:47:27 +0800
Message-ID: <20240508054728.1751162-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240508054728.1751162-1-jisheng.teoh@starfivetech.com>
References: <20240508054728.1751162-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::35) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1283:EE_
X-MS-Office365-Filtering-Correlation-Id: 998f0a26-8430-4ed1-beb3-08dc6f226eba
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9HetvZxU7EBT869EaKJ07ubqr/HsEKBBYzECkyzXebkcYlZEN35kDNJgdpouqibyHSfbgDPzYtaUOGLU5kucuzZKwsrzzsfbWIJG2WBu4a3rFxArWXn1A3aFqQiYQ/vYB8qsVOVw5Vpd2LsZO+pMpsrjFzct9tRHCRTsZWHSljB0HKs5+GdJlhRSt+21W/lcutzY/42ThuOfbnAQFa/Ue6wD8k3do4cn/9YUGE0hwqgkDTuKbgurC21dNyxErx1PF8cxtZ1ILXfXWFlWH87uKcZdIO5rn10nyzzeqsAcYBsCXkQhvZ5DqLAKKn7sY3X7iQxBMUvKIdU4UMwfH2CBPoBiceJ9MRGtwOsOGTyG4+t+mULEgGRRfN6owvI9KYkgAFjD9WGc6IzmDuJdEe1oP3kxoL1VOZStCBTeytCRc9pn3NDTGlgFIhKFO82Glk6DjfZj/oEbwXw7NrwCxUIvoQMSxv39gXGiRZc+r1Wy6Iy2078qF/DbpwwSYBEvqaD9+RNn8QyZGvqMiOn5RKIhe/pnOhC6XKWsWob+noofVUcY1aRnH/nQBYKsq+97EiwC72pK1Taos1Aqwjrql4yLYHc156CW0cQkGsU46AocxD0xoYmn5f1fkr3dyCt5wYNz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9O6cryDGe8QDoZ2F4aMUN5sjrFH8XlN+HQtSmWZf4FZgndGb5c/YpHpwris8?=
 =?us-ascii?Q?QIhHI28zKMvc+oehHriojcdxSG+94fWwMwqJoujWRlKraRqHhyei2JEkwtub?=
 =?us-ascii?Q?ELdLpJDLX+nNpkEC+Ydt87I9nRPfbFlrCom7JC4izGWGKcYAmss+mjzYUpgg?=
 =?us-ascii?Q?h0Qzb+WChInIZZ3h+YfI/o9PN3S4C2v7nIQXvbmOznyyN1IMoeORk0kPcbNs?=
 =?us-ascii?Q?+EPz0I8v01MbLrgwuVKJQ1ciLruC1eOZ6vVnr30/rc0fq14Q+xj1IeQ+YIKX?=
 =?us-ascii?Q?OP8s7PA1gCpJ2eXiCTx1VDrKqskhWjQf+B2k8VKVQ7G7+pIQ77BLIqAETKBY?=
 =?us-ascii?Q?e9Ju/zBt/6vX2Bbu7IcX+rNFGeIJQZFLRii+y8hRGDROc1TEFsLtQGmuQk3C?=
 =?us-ascii?Q?bzp5X1YJJ8dAdftQOLerSJjxHnjMz6GWvMasVi9IVwQyGAhkSNKZ9iQZKft8?=
 =?us-ascii?Q?WhmIhXsR0alB9mrADv/BUZvoT3t/KE8oYl1BWmpVAkG9g4q/Rte7ecxE8XUn?=
 =?us-ascii?Q?RhOimozZeqJU4WPnJbZDjZWqRQ8+mdb3a1RWu7cCtDcPwtgqe9mabgsTmRnV?=
 =?us-ascii?Q?+GxbQpZ91Q2dt/cEJAoK9AxnO/XTThHaUQFEFODRcI4yx5ZnOB0bjqVB+evT?=
 =?us-ascii?Q?16WA6NhkOJvulp+DvExY3PkX2uhOEQf3Dp0epQjr5BW7BTQg3QSvINaTPWoU?=
 =?us-ascii?Q?jSqv6Da+K4DfK1Asm6EPaTPACDCMCO+nMf0HRNy2KQoP2JDQE755xzdDlKT4?=
 =?us-ascii?Q?P3bt3EMfenW0I8aUFf4c0KaI/JQtqv/gduQh+PQP/5PzErUepyY82E+yHxM/?=
 =?us-ascii?Q?XwPN9z1NABsvIE2SYDCG2X6aqQnIf5pWuSpvl+a0N1jfx0lPIxFi7RVNAiXY?=
 =?us-ascii?Q?x8iNltbBhCq98saxCGwl24vPvrxsbZ4mRKW239Rh8kd0NfgGtZGZbfkH2+js?=
 =?us-ascii?Q?JxRSQjaqUV/eOQo+1n/KtT3PF461Qly2h8UYElSXkM8bzKkBIklGDCaR8pL+?=
 =?us-ascii?Q?PvLgswe4J0FrfecLpCUa6sh0OpWFe5qDt6CjTPedNOYSIgAfNn2qsXEeA82a?=
 =?us-ascii?Q?bnmQJR66H7Lt/43olgtdocCLBZXW4mtFIYSrg7pEl/IZl6rLD0nfOiFZ/N19?=
 =?us-ascii?Q?V64Sb2LUwn3CT/Wmne1vG5zipI2ojnM4fAKIe7Bi0ZqRT8DJVPq1nPlpzers?=
 =?us-ascii?Q?wkiWg/iXb3ie9HO8jpOJfeX7GIit5SyCSvVjQd+a+MWKXJMPgWHEPWBGFpGJ?=
 =?us-ascii?Q?zeFHDXteCcRrRzbkiH3pdX/JLzepX18nOIsVyeDp1WKjLtNLK4q6CJ7yAGDL?=
 =?us-ascii?Q?SFiJ/Yd1bJfro+qOnp4fiBKb/IvfPwGeOs/LhmpVv3/e/QnGxTEMVcGsoIpZ?=
 =?us-ascii?Q?iC1daL4Kmi5y5/A/kWl+yy1PUqHYEFxXEFOL2aeMH+U5pc6CwOupJHM1bqg4?=
 =?us-ascii?Q?/qqecONl+dd0F0yc3uvq8n/sHyr3YEiDHfijcALDdIu6Q0DKs5AZ1+flxzs+?=
 =?us-ascii?Q?/332tgI17uDT7qTxnEyQVT6gEaQ/4mBzpBpkpH12gnVegASVGpvO0ZpkuWl9?=
 =?us-ascii?Q?3m3cs5GUhiC/XHKjIGvxJYtzHy+XGsvX8pW9aaI05mU16bknIi17ssjPpAN7?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998f0a26-8430-4ed1-beb3-08dc6f226eba
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:48:05.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Zp0qdLl+450JGSpGL3qELEcNcq1tQUOQk+Qhmbd03DGYUEWaX9tG1HTXsWl3esHutA3h2QJu4YXlYvNHRcGHFf9K0EJVicKfear4/mfFs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1283

Add optional reset control support for spi-cadence to properly bring
the SPI device into an operating condition.

Co-developed-by: Eng Lee Teh <englee.teh@starfivetech.com>
Signed-off-by: Eng Lee Teh <englee.teh@starfivetech.com>
Co-developed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 drivers/spi/spi-cadence.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index e5140532071d..4eacf3f6e031 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
 
 /* Name of this driver */
@@ -111,6 +112,7 @@
  * @dev_busy:		Device busy flag
  * @is_decoded_cs:	Flag for decoder property set or not
  * @tx_fifo_depth:	Depth of the TX FIFO
+ * @rstc:		Optional reset control for SPI controller
  */
 struct cdns_spi {
 	void __iomem *regs;
@@ -125,6 +127,7 @@ struct cdns_spi {
 	u8 dev_busy;
 	u32 is_decoded_cs;
 	unsigned int tx_fifo_depth;
+	struct reset_control *rstc;
 };
 
 /* Macros for the SPI controller read/write */
@@ -588,6 +591,16 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto remove_ctlr;
 	}
 
+	xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
+	if (IS_ERR(xspi->rstc)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(xspi->rstc),
+				    "Cannot get SPI reset.\n");
+		goto remove_ctlr;
+	}
+
+	reset_control_assert(xspi->rstc);
+	reset_control_deassert(xspi->rstc);
+
 	if (!spi_controller_is_target(ctlr)) {
 		xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
 		if (IS_ERR(xspi->ref_clk)) {
-- 
2.43.2


