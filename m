Return-Path: <linux-spi+bounces-9463-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8971BB272F0
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F8FA25BB5
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F729614F;
	Thu, 14 Aug 2025 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Y2+F9oHX"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52832292906;
	Thu, 14 Aug 2025 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213162; cv=fail; b=us0x3JF0mPIvqVCle9mw2sgYqVa5QCOVzDBZtW0jxxjgDcJ9GvPn69I6c9xZjyWb4FGSuXvYv3UcLKtY5JyzuBdD6fjyV59oIKuOsUvYfwxfy5S663thd3t0xPzbix15HfYTxEPhwLTmF2s+2NX8InFkJZ9MMm+FgzLH9WXzJNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213162; c=relaxed/simple;
	bh=b2XFhDfQ7rvKXMoJWqA15XRUTjL3RXherGLHJGaoJOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoiZKA9KM+VVH97Bp0GCSr3PwkinjktKricrB5i99bi7rAIDNGpFHSbKHKqt8S2Pisy0lNyAe4wp+bmV0RXK5UAccCYOBAzmJC+Kb5+K0XMp9+wG2uOUCUL7D7F+CbztSP4ZXfW0A0ibmPPOVxrdlRL2IvKvkut7Q3aS1eicaDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Y2+F9oHX; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5ECp8o7rucZz6pLPFGv4+juRDTjbqPwhd9FUQ5RQJf8fPvm6XEzKNDI/AzFTdQVI0EUF4US3K5vqDvKPVe0Ab7Vb7Izkp+EZGQdLHrmDElfgS0W4NLk+fHk1IwvtgWoXQ2ykTnihUAuDuNxGZrLyViB/1A+RDfKcbyAgbOUbNUwhlLBHoroa6mrItWdooMRklv7uGhJkADk5F1bwvmIbzhxKcwDHNUvyfz0pYRGvBsroNVCrw/HQHhS3bzWLbQfyJqj+OE4y5tBohpMY2nslXvCCpDp7Mz8fKEYNSgVyTUxsnKNjONPoOL9fsT4XjRrCD8uYIGsxpSv0+WIBducNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIUB7/26Aju9zakGQ2NgjLnDhWemAPhuZaJm/Bxwmh8=;
 b=NR/j/nweM1B02we+0ToSbhFpDf7tCmVTB2a7kX1AQIs+ihZHyt8pHyqgT5N9wXHWnxyoiloJ2zs07m5/KGqF4mEOxDferxrbkVcuaXX8msJz6SGVZ+NmiNb5mRJvhz35RJ5/uL3GzJjNP2K9g2DLGO583bPYyXPiJCf8scTkmw4n7/LyE0ayRbOK+9ctENhVhk2xlVoLMsg1VACKvclzfgfn9Nlt9Ey9C5mXs47cBcrTVG2KMpzIYEXAtAha+v1vIW1cBmv8Y7yoBEhjC4oqz/UAcf8iHT8EcykNDzzrEGv+vfsn/VwO93L2EwFeeJ4oa4I9iMZ/1IN94fe5RI0Dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIUB7/26Aju9zakGQ2NgjLnDhWemAPhuZaJm/Bxwmh8=;
 b=Y2+F9oHXnPy1ON+MseE2tplh1pyy169DKewZrmHmZhRm5TPuATUWOj5Y96sS25WcMKKRYtjlJ7uSWDFWDMEsP2SCPOp1Y+jBVaCYK+Zo8xKFEHZClvImCyQECWuk6ibyLqz1ph54CF85g2v1JONsqh1ZsUg/brdJBPZt8qKFQqmZs40rq9I8zSkbjyEJg/3zTxJtCqGS+tily4jo3pcVxrAoNrV9DVDfzIe9FWRHyYSDldapK98d31balUEU9RwQxL03NLIl1DBhx62Pa07HehlbLO7uxNLTb1bvc6I7zXbCOUxlGTNMBy1aU1st01s0/hplPJ20NZMf6eHw8WKpZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 13/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Fri, 15 Aug 2025 02:12:10 +0300
Message-ID: <20250814231210.4174427-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bea57a-9a16-4b72-949b-08dddb880a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?38Qorezftb7AaVJr50pQyaOHpQwZN4hWJKIGja4K0TeiX0ZXhHlWqebTC6f/?=
 =?us-ascii?Q?bfcn799xct4qn3Ht2m7ervzg08+ijRxB7Sn4g/cFrcqbOlkbEHlRMOUlQVon?=
 =?us-ascii?Q?cz+s/7ur6QbkGarG1cwFE5taU1u3LjUKGpiE0vU6x0c276wcYAg5ErEpx1LC?=
 =?us-ascii?Q?8R4+o8GKdCmUBSlz+A5Wh9OuM4myTsx/5UqaysrICOj0LSNuhlNUQlZS1b5O?=
 =?us-ascii?Q?W5Vqi5D0QAJCqxoB44bi0RUSh2YRt3862DUoyyFohmrY8Opm/XvHgmD7savr?=
 =?us-ascii?Q?HftGcwKhtLMIgkyyFrlVXkOYdHji47ozPdkfKNES3kDvq1//PxbXNx4VvIjy?=
 =?us-ascii?Q?zS9oHe9soX2RaTla0Pafw7UNhwgRWenntbNli4/AAKQvCwuyMUxfD3bHKyKL?=
 =?us-ascii?Q?zKnaBjhq0TV9HWqOY3v9SGwYE341P4JbPzPIU24ROzJaM4UdbNv2mCx59Dun?=
 =?us-ascii?Q?kObmqlWKfclbW3Mov4YvwRfLG003w4yjkM9nKaHidc4cngfFJoG8r98L0UYW?=
 =?us-ascii?Q?NpjHiBqrDEaVfGztAOo+oWlZZygIPECTVpGIkshztabyd45LTSALoCutRFIV?=
 =?us-ascii?Q?yXZF0WKsoE8G8ng4TAF/Ac4CktNWN83PLfIXwIetq0HcE/aIhAoj0SnmcFtX?=
 =?us-ascii?Q?JCJWU4foMnsyAwKHHPTi1PmXtl+t7UM9QCJIzqPzihuGmtYoyQRJhoP65qEG?=
 =?us-ascii?Q?+NzyOVHO8JFov5zteoaGU/4CJwhJlmgnV1aTP64sAsU3Te8KR45s6RLNFp5O?=
 =?us-ascii?Q?0VS0wXWS66TdwJ/n3JfcRSy9wCtyq0OBJdluEQkjfmTWe3ukUkalts7sJeim?=
 =?us-ascii?Q?4xlYDzkuWhoPY1W3vTbZB2Nhj7UeGoXTviusxPAj5N1/qKvICca2V7FYV0cj?=
 =?us-ascii?Q?kE/MuWEM8V9HzdgubXJ4UoOwNBEnez/SADgnHu6eqm5YKIIVC9//oKHZ0ePd?=
 =?us-ascii?Q?Iv0FLg3C7a6/NrbUIKG0BGiUrRccbj1lLiVRaNVAbZ6yUEpszKMYCBlnnkgq?=
 =?us-ascii?Q?dlBp6KianczO25K267lrjifEFa6MmPYSEy7iY6n3onPyglyNliS1KLKIA3sd?=
 =?us-ascii?Q?m8clzcBjk1mi2rRmfa0YZ5DvY6X4y/cW6ekk8OJj/u4fzSMmENRYWNe7/ubp?=
 =?us-ascii?Q?mR1aSlomOfodsUEQVZe8Btm8NfBz6nkeCUIvpVvO6JYDAlEdV04izD/KWf9U?=
 =?us-ascii?Q?C5kNHWpTy7+TfXtCKiGLJBovat6pT2rcH8vMdubpWqTOPx+PInmPyTVpC66t?=
 =?us-ascii?Q?ksjSZMEJCZDKvRRZQrAhSDh4HXHKEvq2XdV/hPjxIYhoEpcj6XzxEUDgVBod?=
 =?us-ascii?Q?Wof32Jy4Cu4MRv3cDYv7Hv/SqtiaqiRKMgQjqLYFKeVKHrjSlMiPe2tGy665?=
 =?us-ascii?Q?WnRRJzKhwXWja64SXV6uKkM/283YEGKl49eWVRm7HVFutM0Gxra+kTlOUcOi?=
 =?us-ascii?Q?lmkB0P2JtxxbvMD9oBRCgBxNoPUJpFGorgkdge1XGdEVzU9TwnquKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b3WJQ0JF+dDmkutdwSjjhcpDLe+9wyFRNIjqL2YcdpY5BoccHIlli2xThJLA?=
 =?us-ascii?Q?ox/tEjZr/BRYOE4/SvJ0KQwvPz0jI1t3ArHg7UVDzh+38+6m0rsNE3bGIVLQ?=
 =?us-ascii?Q?ruIPooZCcpmBCQfCLeojb+cL/wuU+Z319BSsFmeaJlmzXUmKebfjjtCwBCD5?=
 =?us-ascii?Q?rjE/YEVjQagN47avlQmrLrKR9qTcbpy6pBfWpKuprwDih7LzzJGErL+mOFKe?=
 =?us-ascii?Q?dpkRcXsISK7m80Un/arviBsqoUDSjQ1ahz68YiqHsamdScOtsMMijYW6fTV/?=
 =?us-ascii?Q?kfmpTcnMDHnU01pJ572EJVp1lDGCaZ+ulwsNhzyBzWeSTKrLgzVG7FoiLIdr?=
 =?us-ascii?Q?bD0DT13+7w/3Gf2y6JK/IH/CN68TKl2VQt1nn4yu0UYHQbrgH4WcWQTWD+sw?=
 =?us-ascii?Q?gvpYaQnq/R/lGMyoAk+nZ0U71N1NgHedHWuUZqMX0XYHjbnfpV1UeJCLDLpa?=
 =?us-ascii?Q?r25iCDzudlmZhskWxURbFzc8iIfD2xdM1SfX6TBCRelJPHSWvAayOHImofxk?=
 =?us-ascii?Q?8j1VRXXV1tzJSFeptKev+oSbkaIg1eG/5yplW32OMcJbBBKCAX3ZVlcoMaXK?=
 =?us-ascii?Q?u/0b+R81vhTy8UdiTmEViZVDZVw+AEqf80+XnDdwEfCDD9y8JslXodwsu594?=
 =?us-ascii?Q?NAjDzFkEbbUCDZ2ohCPs3hLlBN5t3F4LoX1s06bOQoPz7UQ8VAsriBg1acOd?=
 =?us-ascii?Q?dRULsMxcTmry32AtuV8RdAQ4JNWe6Fqk85hTcDLy+xZIv4Xkp/qxs78RLBYq?=
 =?us-ascii?Q?kCvnSvnL/RqkMNJEdH73uQp851Y7Zl9PGCwsJG42Y+pmTA0/pzyf9KyPZirf?=
 =?us-ascii?Q?6Fk8dp2XQDQhbdinOmflNtZRKP+baSNkF9Z6mq6KLTy32hSyeYP+tMN27UK1?=
 =?us-ascii?Q?/Y/abeQczTPTqhTzk414FpXW/8eoR+NKv6UQYEz6XiE5+WPUJ53TH2BAaRfL?=
 =?us-ascii?Q?p4MwJFoFxbl1Zo1FIdNfoiX+cbkevcx/cTvI6rA2YeV/koEzSMdkO5KldA1c?=
 =?us-ascii?Q?MmW1Vq3ZPewX8p5gEwZXhUJkGlmRQHJj4rh5j79q89PU5Fy8THa5Go9RySyZ?=
 =?us-ascii?Q?xh91Ofajx4N8OOPBjs6Zr7iNUwsXxl1s+UjrIN6nAdkRVsuOCB6XLMlF+gZ8?=
 =?us-ascii?Q?LuP5gl+LysUnGwvZxFeQQvI/T6qfedRkxmMksylrDolm0jR7djIgQq3v2EJx?=
 =?us-ascii?Q?Qf3imHTUE47d1WjxWlS2gACnP/ITfMmWiBEl4vkg16uxE6OU3Jw3m2laOIQp?=
 =?us-ascii?Q?YPAzJ3C0h8vS0Qim2hz6a3O/cT5RcJnak+mPrnwtO+YhvyykyMvejsF+dqx5?=
 =?us-ascii?Q?ArAKqMQr0siIAecW6LaqNOb0uNDH1eoIKVx+lm/CkVlq2fHkh/Bd5YulZz62?=
 =?us-ascii?Q?XCJOz3zu3EzKbe5Wq2y9Yvmh0Sx3aeD/M/Wq319t/pyJ8Mv0UXIihuILw8Uy?=
 =?us-ascii?Q?e17mBDQEWl1KpaQ+BjLicaFa4Bw33Wlp+BSJR3Dlyy4wS7Is8C4XsuU1oqir?=
 =?us-ascii?Q?l6I+k9BKCw4OczbuHywEBNGVr8e58VAJ4okoMi/OxEwkTHrNj9UpZFLpFF1w?=
 =?us-ascii?Q?ljSCjQ1iZtNiSKTHXoZrZvn+etJQ8l9Yql1QsosoZ053//TOHL2dwW20oIK4?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bea57a-9a16-4b72-949b-08dddb880a18
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:28.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFpt0WGgPc1PAWanl5T7i42AQ19l+m2fAc+LTXJ+jiOKb+/8FH4zUMr6GF2igtSJhf9nJSplhOTlUoz8MdgOASBa0WHrvb51Oc1Woxy9ixY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

The spinand driver do 3 type of dirmap requests:
 * read/write whole flash page without oob
   (offs = 0, len = page_size)
 * read/write whole flash page including oob
   (offs = 0, len = page_size + oob_size)
 * read/write oob area only
   (offs = page_size, len = oob_size)

The trick is:
 * read/write a single "sector"
 * set a custom sector size equal to offs + len. It's a bit safer to
   rounded up "sector size" value 64.
 * set the transfer length equal to custom sector size

And it works!

Thus we can remove a dirty hack that reads flash page settings from
SNFI registers during driver startup. Also airoha_snand_adjust_op_size()
function becomes unnecessary.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 136 ++++++----------------------------
 1 file changed, 21 insertions(+), 115 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index a96c87f01f52..3bafceaf749c 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -223,13 +223,6 @@ struct airoha_snand_ctrl {
 	struct regmap *regmap_ctrl;
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
-
-	struct {
-		size_t page_size;
-		size_t sec_size;
-		u8 sec_num;
-		u8 spare_size;
-	} nfi_cfg;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_ctrl *as_ctrl,
@@ -488,56 +481,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_ctrl *as_ctrl)
 				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
 }
 
-static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
-{
-	int err;
-	u32 val;
-
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
-	if (err)
-		return err;
-
-	/* auto FDM */
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_AUTO_FDM_EN);
-	if (err)
-		return err;
-
-	/* HW ECC */
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_HW_ECC_EN);
-	if (err)
-		return err;
-
-	/* DMA Burst */
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_BURST_EN);
-	if (err)
-		return err;
-
-	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
-	if (err)
-		return err;
-
-	/* enable cust sec size */
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
-			      SPI_NFI_CUS_SEC_SIZE_EN);
-	if (err)
-		return err;
-
-	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
-			 as_ctrl->nfi_cfg.sec_size +
-			 as_ctrl->nfi_cfg.spare_size);
-	return regmap_update_bits(as_ctrl->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -570,26 +513,6 @@ static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 	}
 }
 
-static int airoha_snand_adjust_op_size(struct spi_mem *mem,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	if (airoha_snand_is_page_ops(op)) {
-		struct airoha_snand_ctrl *as_ctrl;
-
-		as_ctrl = spi_controller_get_devdata(mem->spi->controller);
-		max_len = as_ctrl->nfi_cfg.sec_size;
-		max_len += as_ctrl->nfi_cfg.spare_size;
-		max_len *= as_ctrl->nfi_cfg.sec_num;
-
-		if (op->data.nbytes > max_len)
-			op->data.nbytes = max_len;
-	}
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
@@ -634,8 +557,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num *
-		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -721,7 +644,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* number of bytes to read via dma (whole flash page + oob) */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_READ_DATA_BYTE_NUM,
@@ -819,8 +749,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num *
-		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -899,7 +829,14 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* number of bytes to write via dma (whole flash page + oob) */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM,
@@ -1052,7 +989,6 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 	.dirmap_create = airoha_snand_dirmap_create,
@@ -1077,36 +1013,6 @@ static int airoha_snand_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int airoha_snand_nfi_setup(struct airoha_snand_ctrl *as_ctrl)
-{
-	u32 val, sec_size, sec_num;
-	int err;
-
-	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_CON, &val);
-	if (err)
-		return err;
-
-	sec_num = FIELD_GET(SPI_NFI_SEC_NUM, val);
-
-	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE, &val);
-	if (err)
-		return err;
-
-	sec_size = FIELD_GET(SPI_NFI_CUS_SEC_SIZE, val);
-
-	/* init default value */
-	as_ctrl->nfi_cfg.sec_size = sec_size;
-	as_ctrl->nfi_cfg.sec_num = sec_num;
-	as_ctrl->nfi_cfg.page_size = round_down(sec_size * sec_num, 1024);
-	as_ctrl->nfi_cfg.spare_size = 16;
-
-	err = airoha_snand_nfi_init(as_ctrl);
-	if (err)
-		return err;
-
-	return airoha_snand_nfi_config(as_ctrl);
-}
-
 static const struct regmap_config spi_ctrl_regmap_config = {
 	.name		= "ctrl",
 	.reg_bits	= 32,
@@ -1180,7 +1086,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->setup = airoha_snand_setup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
-	err = airoha_snand_nfi_setup(as_ctrl);
+	err = airoha_snand_nfi_init(as_ctrl);
 	if (err)
 		return err;
 
-- 
2.50.1


