Return-Path: <linux-spi+bounces-9482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C957B27F0F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8BC561F93
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72AD304993;
	Fri, 15 Aug 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="DR8Dzb91"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020074.outbound.protection.outlook.com [52.101.69.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A59304966;
	Fri, 15 Aug 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256610; cv=fail; b=k8UdtMGFRVI8w0795Uuzp3XMmYORiNZ68rd6eSsHqdO1oaiXPSPpP1mmbFgSAj2h9w/fX/No4BWCREWwHondvxsIhSE9XqgPQbuhMdWR7rhWIWcrUhzpXIMBdlUIUKDGVqmJQE+MUrq/E36WA4kiah4YQsYtFVUOFHv+SWLxSrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256610; c=relaxed/simple;
	bh=vVEst/f/mQqj353o0+F5J05rUOdCj4yUf1XMg1A1YoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ispv67VnDqDk4v5qak5vNRf0b21jPTRqcPZwrpMwCW0Ae6rGE1NU3dqvA+M/D0hk5QTom/X//5JpCAXqpbCT4gDArcX03gwP3bxQdFwsd6Fr5PIqAmJhbMmloiHWLTaTf5m83ZrvRMbwCdI78TG5ivaDgdd+PdXcN12BbcmFlvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=DR8Dzb91; arc=fail smtp.client-ip=52.101.69.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUYCZWj+zCzwUC52lzdHCoyQAtjflOsvh+zOLlTXWOy14mffnjhiF9IYPIPcau7revPyvXzLOqIerhDxTZq8qKJIfUApYCyOh3jxJ+uqZpq/ZNcLaoTWXyn0nDkpFhYD6ptZoCDhrqZGcrQfmzobB6F1dGpa1h4gZCn6Qif79vhTjNXNVMNVIi0B9W69Z4Ix0lxy1pR0rvIfMcsyR55DZcAR28AujRjfR7dDcf9mwIl8I96s4ilqj1vXLoVMqgsGQNYfWp4Sh4GpRiT8/agDe96PX7zJ6xfB9503fI6ntLg0juLSQTqw6xMn1hgqvotxeVZG5xjYORJ2TNjlIjblhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha1RonmRqGxnF3OFd03ajdTFlCJSBsEd6wghwE/FyFU=;
 b=AGXMFAqoyQ+ODQl9gW4PkyoSS/g6DRDzhGtwD0Pj3o6DTRvwGM4x3nHLX+LN25+FsZXD665Pc06f4F+W5cQrXtF1iNMhTNNf6ruwMAoKDIkB0vKARShofS9Pg+TEx0Q/0ehougoIH3bfZEe1Vl7Vv4OPTVVODBya6XRgwfCFZ7L/Qzx1WPtqfFOONi52Wcdboh/xxRht3MwB/KlY3cYKVdH82FwvjKokZl5mTgZwdcw+FkHx2WqIpigpcSqF95iaCQWF1mtyVwVmeQwa/saT7PMTxT/lK2r/H7eFsKPQf9q4qGO0VjoI83RbVSTNGdEfLJdSbXirnRUAZg9i90OOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha1RonmRqGxnF3OFd03ajdTFlCJSBsEd6wghwE/FyFU=;
 b=DR8Dzb91pVgwr3lWTLVLurY7s+wAIUA3O2at1sSAYtcSxgCNGRJrn4RQa5dEl/nNpj3B4wokPRHvwbRpSQ0XyeqZkVwoUWoypEXLkKbRkOWbZc/nUVDXgaRhXngMN3908DUp18ENW+V/dyWH4VSuh9xxzrBWNK91crglO8uzaINi61oWvs1ovVCLOU9/Ljpey6bPAwDu1gTwSxV/R5jnhYsTQMMm3pZtZ6ew5ALJZsfBszrEVhzcLLRdd0GnJBfjjtpnx9b+vC+s2xGS+NNxJktQJTTmIqlQPD8bS/HRRy5a4xUEQ2JY0poUE+aG1YLtXffA2xS/YbLiSOWKyqFnHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6268.eurprd08.prod.outlook.com (2603:10a6:10:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:16:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 11:16:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 13/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Fri, 15 Aug 2025 14:16:19 +0300
Message-ID: <20250815111619.45001-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee07692-3874-4ab0-f708-08dddbed34e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sdo55ZW1fUv6nU4Dbk2q/K4r+R9FQYwA10/gSVO+Re7Zauso3l7VnmmqXMEJ?=
 =?us-ascii?Q?QyZYqupdPr8ir1/JrUPe1eOHKouTY4AE3QiYA8XtYME6ChzbJFDVfOj9mUWX?=
 =?us-ascii?Q?52AfeB7nTzpNr6EkrnR8AJjtdEp6Tp14WT43ukBzfwUITJoRfKDawba3vt/g?=
 =?us-ascii?Q?HlscCkHxO9+6I6Wk0T8g7LiuM09qs+dRmLXXqnTjpgNssDeofoH2/EOgGaRJ?=
 =?us-ascii?Q?Nlqqh7X9JQse5dk0stLhph5J0mqW2i5vJhixAGzh6wQoWddbHY03/BdQ3dPU?=
 =?us-ascii?Q?XfBTgiQ/0cArI60VP0dW2OJSl325As3Mc53UvsecQBmjUx4CdKL+vTHE3Yk9?=
 =?us-ascii?Q?nS4V02bfbIklIBkgoT1YWGROcEbR+wpwAWxnpyS85wCX7d/wcKESRTWtzZlR?=
 =?us-ascii?Q?u4pB2vOGxhFgBZOCsG1xCXF6YmHT006SdiKw5Pm8X5Edha66+U8vLqoIgiXR?=
 =?us-ascii?Q?cairZSnbk6vH1rGY/MnSok+qc52Iq2lKr2OOJ5Eo4vVG9/E1n4lbA3tovm00?=
 =?us-ascii?Q?w5xncxBYXx6OQyiFRzn9tdOVgqM4HSLinzmT3mPABCzdi3RdmmKv1tQXiTKQ?=
 =?us-ascii?Q?2ZW2Tc+ztbT6Tm28L4RPUQzp8hBNKa/A187NEHXitkiIUBzNB5d5cWHJ9BXb?=
 =?us-ascii?Q?6FFUsmD1pcloP3Bt++UlIDpY38FpEKCKyE1nZ26SY8WqTODasYgCPt/hPV/p?=
 =?us-ascii?Q?M5pu40DX4IMEde0cy6lzJxPUhnExwRwCdyVGIZX/YON3H0qYAaK7/adem26r?=
 =?us-ascii?Q?HG5ecHutBdKiWoNBiqSNkB56OGUmPosiJt7SRGeOGsijYNWhrFf+YsaQ6RmQ?=
 =?us-ascii?Q?ug1wFDyjHXWV0p2VlO3yEhgUB2tQSnSv8G8TgIHgOWAm+B2Po7s3EvXABGG+?=
 =?us-ascii?Q?tZT1Nb8H67pFiUipIP9E5tQgtkvt240ILE5/gHST9f8OcWLALr+fE0HmQ8TQ?=
 =?us-ascii?Q?XkijDtSYMd1iys720GrLc4+lQG5nlygZuQTk5aJhCVPzQmO1O4ZO1zn/TyW3?=
 =?us-ascii?Q?wtNlWLhzzIoD0f312QmWgToEGCgMg7hGbCS7ahtFU/76oI9xqgxZpQspvPJk?=
 =?us-ascii?Q?7hf6Nkl8GCTVaBw36Yz74oTl+cgwqs5/jbmmZqc0Iv4FgRNkxryVGNdwk/Wh?=
 =?us-ascii?Q?C98qpaOg+txxZBpsNYUUX5ucSbm5Hv71WzkYo316WXucAdgRazk70MWk+yqm?=
 =?us-ascii?Q?eRVrbYqxWvNCKPP7HySrI3bI2s1KvfYvnwQbkVthpmh0DuwQLCMr+/JMwUuk?=
 =?us-ascii?Q?kNhm2VVJVcMYgkIRmbGxQfI22NplETWFMf2GHoyoJr/v7GCWBA/ZACGd1guR?=
 =?us-ascii?Q?Y/qpwr1+TwT2/F/O3LVDqO7Nbxk2lSVgn2dJakFtCN1xXhoogevjP84gQr0L?=
 =?us-ascii?Q?GQAyXnp1XnHjt5CY2QJrFmw5nL4y6Q4/hC+K2jeM5pQkoV2J9pGGLunFBF5D?=
 =?us-ascii?Q?1XvY7rDBvm/tZkXL0JWCnoLOXLBhhLmnx5qI6kHDmOQPBZwaOCfuxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/P1ah90CQ2NrwzNAAELxZjBceOQzNuEDV3jJ2K56lUtkHXyw5YlqFwDwpa/r?=
 =?us-ascii?Q?WRisXX5TnX/YgPbe85W4d/mjzCWEN2NLIfTnt2oNcz8Nxvv2p53gAs4PI5Rh?=
 =?us-ascii?Q?mxcbJn4qlu14Mk0cm3gBeCq1/9mGGtM3JHTH23exebZgha+YmHQRTKSR9BdR?=
 =?us-ascii?Q?3GOuPIZrI60BlLHc44iYu1NZowe1Svm8xYqWATp+NCm/uaBW1OBDQXVUJcJN?=
 =?us-ascii?Q?bPbmKriGLP2pSuT8urK/R3sF+S4jTr98Xa95CAyXH6uT9311X4acGXV+rnBK?=
 =?us-ascii?Q?5y7LJK5xdQu4SZH8qsrCTGtMTa3kFUIbQDFDOAkzXMezTq4uOQhJ10GX7wMP?=
 =?us-ascii?Q?WcfmfJTeLE8NcF6YpIza0vlLddNL8wXQMtlNb4qJ7kjOsSLzVfnAUubV5bUs?=
 =?us-ascii?Q?Vk8Ly2W4q4QK5JNAa9qd9kXfSRy02wWS4PSPT91QITLi5ZL3mcEzSsoO7ptp?=
 =?us-ascii?Q?V/Wof7ya6hnU5CseD7dcHaV0cPq8+7GGQiCBGlIMCYBXLyZDRr4E0Nh4H/Zz?=
 =?us-ascii?Q?7OBbs0U8sjCbwWnw7EGCZuEbvGSYCdanz4aKAhon6PnAT1GGZ4kb0I7uM0HD?=
 =?us-ascii?Q?XmFEH6kdy9VI1iSnapc/+aymLgLs09sZkPKJCq/cPjvSBqoyTZBTYVIcnMvK?=
 =?us-ascii?Q?Vt26KeUq/JSPQR+KCnf/ak7Jf5kiQp4gz/GjyN6lrXBMYsG9jaQgWjfARiDf?=
 =?us-ascii?Q?suz8nTUaZCAJb4tyBrde+Oyrbm3lzh4K6d/0d4d5LGglzKi3anh8rkrddq9J?=
 =?us-ascii?Q?LP7C2sZeynZ1y/4yD7jFt9nQ93BVHhWwF4fW2Jm1BZztlgdl+7LBivEmAto8?=
 =?us-ascii?Q?VjZpzZcF/ZWgD7YoZx9vZCuDf6hcEdkKRiq7Dt77dSodF1rflYmirXDHYCNv?=
 =?us-ascii?Q?aQgzgC6JoDxn/YTqMGTHdrGHTXt/2VxmWqTxNAdRdchXwosuf+2IXvbdI6CB?=
 =?us-ascii?Q?knZ56ZDQzfONDbX4nd89n6r9ujKPnH1adPSqw2TY5GxudNOad+0vcR1C2l8s?=
 =?us-ascii?Q?7okID8W0AYuHMrWiQD74Gbpf3QDmmHFYh+G/uZVdurucANY8cGW4oHNnK9F6?=
 =?us-ascii?Q?XeSc0dntdzEMaI739eednuHb+1ybRXB4yDcOavHMX2c7eIONwbe+Pld3taRH?=
 =?us-ascii?Q?DwpD2YVgyH23Pde6fUWfZ78XGngv7tRa1zs/0R09rGGHA7Qe/OJyucjCFRYJ?=
 =?us-ascii?Q?wZRLkopX87HmN3SP4Z+wbOjgZ5VoG8vzLULl/CErP3h1BQCOcSpXZLVVJyNC?=
 =?us-ascii?Q?4/cOkaGipsPWurMZHqIsKvERJz5Z82WDQytryRGSuiqwmB7/FqaM0HGQ4R5E?=
 =?us-ascii?Q?VRO0MHjntmBy4x0OuofQ0JRzONf3Cs5uuud2I5LghzLR9qQ1XEDecdUlCZKc?=
 =?us-ascii?Q?0DfVPqLxHe9xh10wFoxu+zcaa6PE+PZ1GPOvq+SBlLQZQjzVXAacBc9UYi7A?=
 =?us-ascii?Q?srXsPsYWWGHPIWbbTVkNJgsJUa/sb9GdhkMVbeTNsRUh00jBIylbZZBVhjrK?=
 =?us-ascii?Q?ddH+qtWn6xqqdLnjrFCAmx50Ta+his8ZJ7ha4wZb5+3lPNoL3vVtYgtJnGQB?=
 =?us-ascii?Q?QmWLlysVNPJIJst7LVojTWP9tpMEai6C8XImZZ1TLO9d/xwx26BijFps5Wey?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee07692-3874-4ab0-f708-08dddbed34e0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:16:39.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjYOF2+DNXTikYUuHa2XAC8HvGZ8u5PZrfeAbf3zC/sRvc1A7wubg4hkGuuJDPrTMpvxnkXgUUOCUoA4cLG9z0CHX4AJptA7dWM0duMmbcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6268

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
index 067d9925415e..26e1f2a96cbe 100644
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
@@ -636,8 +559,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num *
-		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -723,7 +646,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -821,8 +751,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num *
-		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -902,7 +832,14 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -1058,7 +995,6 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 	.dirmap_create = airoha_snand_dirmap_create,
@@ -1083,36 +1019,6 @@ static int airoha_snand_setup(struct spi_device *spi)
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
@@ -1186,7 +1092,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->setup = airoha_snand_setup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
-	err = airoha_snand_nfi_setup(as_ctrl);
+	err = airoha_snand_nfi_init(as_ctrl);
 	if (err)
 		return err;
 
-- 
2.50.1


