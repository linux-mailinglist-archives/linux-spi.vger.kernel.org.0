Return-Path: <linux-spi+bounces-9660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDE2B3504B
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 02:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E05E1A86589
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 00:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490C231A3B;
	Tue, 26 Aug 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NfwHzkoH"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559E20C00C;
	Tue, 26 Aug 2025 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168449; cv=fail; b=JM0EGJEmkBWFIhLbyuYcKB2HXwhdggzteCphIx1bG6c6v+dMaXGIlkWqa27AnOlbHN4RqMJiWIBKj42m0dDr0iL/7Aw13zq9m1sKDEM0yCWe4yntwWRpIZ7koiX1UMnXFdxxDeVl1K0G6M96tc3396sqy7Dj65kC/mgjnRU/DK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168449; c=relaxed/simple;
	bh=oNKko0shaWNnAe7//s2CnetQz98Go4fe3BYzORxXoCQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CgvWyVASkOjnUP1LaMVb+stI2nsSBnMm0lenL1bq8eHx4rIHYO628GUvqmdN1xBM48IZVR/uQOI4lL2gIWrwDkBfqBdWtQL8LkGPCK1BnmQRnZy6wUmaK7OnAPT35LkpPC6CqpzGnLYOV2tMSSQQJjnIFgVwBnm6leelbqkcNyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NfwHzkoH; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md0DVO3aLD/HKcLiE2JGKrYWQHkxeDBq8V7yhX8TfsBYw/cmPdov73etW/ld6YldE+HWB6x7jtD2RtGzCPclw7uE0JGE+GU/6fOyI1+JnANSlfSWQnS0mM/qlN/XpvxAQXlb8ZD6m2vMTqonF5lMO8i9oHT9P9yz08V97rp7DnbR0cCxCSR5y25UBuITAho1YonyA1WhirJAtGiWfolExN1BZh19WbW6QhkZnToOKec1l3Bi5YgEn/QxFxWLhl3uUeOWuhtLfPlBFWm/IjxR37rZ8DzxaUke4AV3RLUp7FcuMjSrfSgegjZvrBwmY2M2apbgSQiCxtUgpPXTcgBg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fmPstK14TdsNlFruRmHqJHPLGN8VPxTfr7eXUjlVX0=;
 b=iPj2bX+Xs5xDwXK/f2g+1NaIdAQ7UzjRNVNnG9eBGAhZQCzgRP6a5CqevdLOukyaolptcqdCngFKzwu/D4jZbP5p1MVyg2PZTZccPXlJZIa5awtfBHWHOthuucHDdFodrhWAIVLb9UiWeC662KdXYM253A/SyTmQ6+senbmS3xEih8hX8f6U9PlnIGv3mH9YyQMvQg9dWCIEbbJrKOYokGo44qIIg6tcQLn/dAuWGk1161a0hI/m50upeB6cDsFY1KfA3YVLYAOyeQOSMt4ZM9fFrZwndNItB0LwnY5+OViO57D/68uxHt91TdzZY+sG5ib8hALYmS+0HAH2JURjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fmPstK14TdsNlFruRmHqJHPLGN8VPxTfr7eXUjlVX0=;
 b=NfwHzkoHmMK0ApgrjWoDG6ex19FtvfiWG95c9rYnXa5sKq7o6QZUtiN0611iZZiC+15IAzH0eIX1ZfomD/DnyMeKDCm1y6pRPNDasi0Asx12A6JrAOBTCLK7wXp6jxY5Z1z/4sagjCw30khysX3NnSw1SrjNzvZ3Ul26AIGcTKfsd0haHXxRjPHublKrlCowmSasYtd7c58ZrBN6vG7CJYDhOTq/57KtTvYAl3umtG8+bIKOIEvi4uyFwAQtfy4nF5jBqrsrUI1MVBdaZrJ/Dz1EvFwU4lvZYi5+jk98g9wWRcC0rBHn+3HDxZ271UsvFW+NsnJ6PU5gyAgfiwdP9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH0PR03MB6978.namprd03.prod.outlook.com (2603:10b6:510:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Tue, 26 Aug
 2025 00:34:04 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 00:34:03 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>
Subject: [PATCH v3 1/1] spi: cadence-quadspi: Implement refcount to handle unbind during busy
Date: Tue, 26 Aug 2025 08:33:58 +0800
Message-Id: <8704fd6bd2ff4d37bba4a0eacf5eba3ba001079e.1756168074.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1756168074.git.khairul.anuar.romli@altera.com>
References: <cover.1756168074.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH0PR03MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 332adf82-2f95-4ebb-b81a-08dde43841ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eKRaLjwimbcUt8a1UhincxAKy9jPICTxURBd9Wg45WXx6NMY0EoUgRAsV1g5?=
 =?us-ascii?Q?+XsjCIDmZqSbEBY75lsAowNQBbpVCaaRe7SaLBZkVfG+swRuaHjc+1apeQ+u?=
 =?us-ascii?Q?RTgpPGF+TbHSeNCjCALR3gXgWD51Zqg/b+RpnyRnlYMkGDm2OvNg1cGzQ7AD?=
 =?us-ascii?Q?vpNFuZClMlnid/JAqBUpJ1JiW5/vjbWuU0hdu0QS+Gxj3k5OPSxL6+X5uH+R?=
 =?us-ascii?Q?S+EQgDr+p/Fv2R8q92sQe09sjD2KrZEb1SjH8gxj/TyswiP4xy3sCizHbXYy?=
 =?us-ascii?Q?d+vU7arzuEK9M0rJAkuBeXpELkKTfy3s5ulc1jhKQoVvQGhbu7kCI4H9+3Q1?=
 =?us-ascii?Q?G1Q3BbCRZNf7YWbDCY08zleWQp6ibmh6b+a4GEnj0Dl0pA9p1p8zRh4U5uUN?=
 =?us-ascii?Q?5Op83x/Gg0cJloqf8ltswF7ZtuEkaMCZf1XeJp8g8GN/CCsyejOeam7RvsWm?=
 =?us-ascii?Q?uD60ZET6I7WGkLXMCXTMZyzvKs1DeBdjrFaicA4a8YRZW6fQYu3mmkQHQKvY?=
 =?us-ascii?Q?6DKPHpT+2P57IHVtlrR9Yr7Fk3xj6g2Ai941ltP8YFpFgwzEPBOW3PgNZHrg?=
 =?us-ascii?Q?rqlGsItOZze8N79FCDq9PkiXPFOiR+/dI3Kr2dMUsnqlapyAIz/aKVOpGr3T?=
 =?us-ascii?Q?L7FwTk/ZzcPeQiHr2jRCfQAhCyEUu2W/B5PEZkqhXdZkhMPsOra31bfst6xc?=
 =?us-ascii?Q?pUDODNx5VWpCsTmzcse5cLwmQNU04Jt4nJUNjQElKtOvnGzXc4a6cB+Eblsq?=
 =?us-ascii?Q?O0jp8520IK72+ElV8+RwXSiD045aBs31Nmk3gb5bMu9vFRjZUpwzDV8bQdAq?=
 =?us-ascii?Q?S0zm7wfPnxKmC/a3Q7DGMmFl3nvsy7SLKvGdTRv7fEXJoh7vRkCNDk4dCw3/?=
 =?us-ascii?Q?rkfUlhKr2HVIhwsU1fts/s0KMctrbdsz9zpTRNDSe/qJ31GAPz8XEHz3OnDT?=
 =?us-ascii?Q?Z36o2+Wvyls1WE3hCmmdgy5qi2nCgj06PXjA484uPEFoU4jqzv8+JYY7GzX9?=
 =?us-ascii?Q?8tpNNCGNitp75h2N08/4dVS70pdsPgHLRhBzPm7j20WoV71PcDWdQi6aM72B?=
 =?us-ascii?Q?aMrs1bYhqgAXBb0X3M40Fzua91dyWuBeXpotAD61lTPB9JBDO2fV+nLmJpBQ?=
 =?us-ascii?Q?ZUtas0w1iFwaPTvd2+2ZuIEcT9xOn29iv7+FXwV2Gk+xqgWbRQ9pU7uSsGct?=
 =?us-ascii?Q?6Enyis6PB+qtB4TIuraifaWLuT6xr/rZX3Hw6AnPrinv37AHkdYaK/vzMy5P?=
 =?us-ascii?Q?VkT5HEDmDmKwJbUKKoOETC7PxArNMDnsnLfrm2JadziEkqpsx/eNgZ8Cc04v?=
 =?us-ascii?Q?VpBWw/BnzYDwaEF566KYZGckARl88X2JAzbYjtFPKu8eji3V+Rn9OqnrJyQk?=
 =?us-ascii?Q?rCL66XHcd6Eg0G/hd4EbimbFbLwCqVoCow7ZFco1FY5RPET0iQVcfvGz4rWk?=
 =?us-ascii?Q?e88ysNMszzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q8qtrr52b4kxFyDg2s574jrTQqZVB6WN/9E7W76Lg3UpBusm4FHpemvyaCob?=
 =?us-ascii?Q?BPggGJlJEsFWywxc/dpHRFPyItqNWhAReKtfn+GvIuLxOQv3leQGbjTEWmAb?=
 =?us-ascii?Q?+7mDhGIxx8TS8Qp4SViODgmzCKBVdL68TDpLOJVNBxqAMH3rOM5LCOQHcgqW?=
 =?us-ascii?Q?+rZfgU+4GlQZJncaRKFUhdyrKA+x8MzxGNlDxah7I6t+RwtUiorrcBBIg6rD?=
 =?us-ascii?Q?gHiN1YCv82AZx3cLJ9vLrwPuMgVdO8FUwP0yeRTcDCUikXmrT/q5fyDfy+0F?=
 =?us-ascii?Q?vA9DorYBnNZYbS/oZyHRwv8JM6CmjILJKJN2PpYgc/TJc8SPRnb+7ZNHMmhb?=
 =?us-ascii?Q?VeEgD6KgF5DjbY5zIYIFxfehDZOzH+R4PGp6SkkgCXNdQkGJ/LPG557CJmH6?=
 =?us-ascii?Q?8R+xXVK4+QVgUnZjYMq71lLHCrfVqHlwhcaC7RoaMN3uGCweG7rzztTqESVL?=
 =?us-ascii?Q?hl1tf9LVUwqYV2QRdHLuguC/uqDbNHaski0Q/VsnUCDk85LNRXbBEbwgVfyd?=
 =?us-ascii?Q?r4Pfe60b1lO0TKxglWwL2507CkcHVsn2JPsijky56bhCSmELM2P69kA6bVDK?=
 =?us-ascii?Q?vkrPQBRnJGf9vTPVJ+C9NxDpYzG5nOyioCdJVLgMsXkvpY38oGY0Pb8hmE08?=
 =?us-ascii?Q?Ud40CTcg/QHLNFtXkSMgiLx2TTvm9mLIzwlCraVAaCH2PTAZwRbmOKsNGG9u?=
 =?us-ascii?Q?sfnUWLwGR5iHTzm4DBdhpEFWFFm9hlEtkjsWd7gZ9aztWQ0CYOKAENBdb2w1?=
 =?us-ascii?Q?9X0KqAtZKW0FS0C8fyHsgErd7CeEJZq4suaFhD6nQX9xkRDjlq7vd5MJTya+?=
 =?us-ascii?Q?cxz9qcRiqTA5Bw8ujOtQqkHhQbGwXXmlRs0j8BtXBJln0UXYe3bzIlRM4yj6?=
 =?us-ascii?Q?bCA/VKIe/YYqAXY4VAtKtcTJ3WQlOraFdiPrayBeg0eCBGpdhyraswjr60Z1?=
 =?us-ascii?Q?0CC05GaQ3qXvLcPjAINa0Vllbl1hC/585elGsIDBSWL5pp95EUNREF+Zws1M?=
 =?us-ascii?Q?xCLQm5RtuvICFp7YfGHuVEOH07iTjxr+CL/eeLNX0KOp4qXBinKOgvSs2uUv?=
 =?us-ascii?Q?5aZ4yLr+c1GCTcARhMNpaz57bIoU0ePjOQN8u3s2QmquEX9sUnZVBEqmSE6C?=
 =?us-ascii?Q?iScihunz/CWGUVSx21UvdCFpGRPBTcM3TdAlXcw2AVLJbRR6EyHXknqzmusN?=
 =?us-ascii?Q?SZY50IYhnM+AsmvJwLMPzKBFMagr9VtPe67/YjXAKc0EOJLymjdkiUqV9qT9?=
 =?us-ascii?Q?BBZff49h2OurfamuPlH5ch5hS4CFIdcdKH3J8daOnsCbKDWKLKFknmQp3r+O?=
 =?us-ascii?Q?8MftvFnWy6yx6fTROkCkmqKt+nFbVV2WZTHR8YARHK+obrJoZ4mrIUI41gEn?=
 =?us-ascii?Q?OvyY0c60VYr+qwwHKF10Ueip3dwZTA6tUr1yKtGMkLwYmdUp6s+HtfFYnsu8?=
 =?us-ascii?Q?2cZxPtbyNcC1rcu+su5Jj+SI158RVAvfHRdMYOzw9OIQEq2yrS8odnqVvkeC?=
 =?us-ascii?Q?mGZ8yBtHlwIDfiGN1qjlMzNp/Gm52GdyQcipe8rVgQkbTjfhkvTT33dG/yIj?=
 =?us-ascii?Q?QADw6a1jD1jVC0N89cUByTc4neIGDbuuxl+8JVFBePi5aFfbOxIbY0RQw9vP?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332adf82-2f95-4ebb-b81a-08dde43841ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 00:34:03.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yumzp3kpBz8u+74YxlTIm1UY08WgqYWXog4jzlqZiSosmYOp5GmC+aN/C7HYGona9WawI8haUN6ETeeV/suSUsH9XUNpNwD8oJsu5ulcg2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6978

driver support indirect read and indirect write operation with
assumption no force device removal(unbind) operation. However
force device removal(removal) is still available to root superuser.

Unbinding driver during operation causes kernel crash. This changes
ensure driver able to handle such operation for indirect read and
indirect write by implementing refcount to track attached devices
to the controller and gracefully wait and until attached devices
remove operation completed before proceed with removal operation.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Reviewed-by: Niravkumar L Rabara <nirav.rabara@altera.com>
---
changes in v3:
	- refactor patch to align with 6.17 mainline kernel.
	- Add internal reviewer.
changes in v2:
	- refactor patch to align with latest mainline kernel.
---
 drivers/spi/spi-cadence-quadspi.c | 33 +++++++++++++++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 177f9a33f3a2..9bf823348cd3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -108,6 +108,8 @@ struct cqspi_st {
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 	bool			disable_stig_mode;
+	refcount_t		refcount;
+	refcount_t		inflight_ops;
 
 	const struct cqspi_driver_platdata *ddata;
 };
@@ -735,6 +737,9 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -1071,6 +1076,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	unsigned int write_bytes;
 	int ret;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1461,12 +1469,26 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
 
+	if (refcount_read(&cqspi->inflight_ops) == 0)
+		return -ENODEV;
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
 		return ret;
 	}
 
+	if (!refcount_read(&cqspi->refcount))
+		return -EBUSY;
+
+	refcount_inc(&cqspi->inflight_ops);
+
+	if (!refcount_read(&cqspi->refcount)) {
+		if (refcount_read(&cqspi->inflight_ops))
+			refcount_dec(&cqspi->inflight_ops);
+		return -EBUSY;
+	}
+
 	ret = cqspi_mem_process(mem, op);
 
 	pm_runtime_put_autosuspend(dev);
@@ -1474,6 +1496,9 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+	if (refcount_read(&cqspi->inflight_ops) > 1)
+		refcount_dec(&cqspi->inflight_ops);
+
 	return ret;
 }
 
@@ -1925,6 +1950,9 @@ static int cqspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	refcount_set(&cqspi->refcount, 1);
+	refcount_set(&cqspi->inflight_ops, 1);
+
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
@@ -1987,6 +2015,11 @@ static void cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
+	refcount_set(&cqspi->refcount, 0);
+
+	if (!refcount_dec_and_test(&cqspi->inflight_ops))
+		cqspi_wait_idle(cqspi);
+
 	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 
-- 
2.35.3


