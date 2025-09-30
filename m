Return-Path: <linux-spi+bounces-10360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB5BAAFE9
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC5B1C03AA
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB98231A32;
	Tue, 30 Sep 2025 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="HR4NCknZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008721CC4B;
	Tue, 30 Sep 2025 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199238; cv=fail; b=cvrJC8wBFyoOVk3KTw2FL3cmdfDFNRAm9L9keO7IBfQQ7PVANRFk7C0MFJzHkh9FzGP2Pxu2I37qbvcGV445D62gvNRCIGQqYbZrSLolN5gmcJvlaJLuJ3LSziw5D7GhhyDUIAubK40NROFpExU/8AzT+9/f6tV9D4IrTcNQaxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199238; c=relaxed/simple;
	bh=+Pr5xbkYAw+q8FoItCod/+LYoOg1rinV9uKuXdBj+b8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FINWthpc0EntZjn0X1AIPrzrQHKms4ZnS8fqoVzdJkWt3tvLaqMyhEaTZwcyqn48YViqZX3rlm4eWP0tpcC+s7AgxyY/J9idPTNHJSFCSl+lzZFTEgl5JKjKzyKAuCAFIPfWWZ8DruNZblyv+az9jBSMhcQ0fC0GUuRxo79KtwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=HR4NCknZ; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O69GaxuTbrpUvw9nDjS/fukgsYJRZdMDnoseAEKLFSrIa36LhcGYzsACIsklX3BLBDD4zj2CDr7fmUseJZBSZ+qLlLZQDzMwANtYfyesaO8yxcOcDoBK+wre2pSiOs99/BPReKOZl6hkHDlgzB8WR8mSVT0duXCGMZfRZCw5/EPQz8B2klieqB4UZwSqNHuUnJaCsxA26WSku925r4NZpATUPT3L3rJEvn9+S6QyFIe3TeyJd1KaAvDCg0SeeIDUzmN/YNTFhGU7+DRk/y+46+g0ZJWLvAabC1x3deLgzngzIA5h4iqsg0+VzZGr+dgRiaE90WMn9KkS+g9qhGcmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dbTf/DY6ZielmflzT/XAFets08BCyHMCTNXAI2ZxvM=;
 b=sZEkVGwTfjdy8pNh42fxzymOLi79mTrm/RCykO+6qkXgVfihGJw6trKImsAbsHBFhKBWNBeHvBk9umlUvAIHf7dFg2fxHIiN9gnnZT4tVO4oh7BnlITBc2gx9z9mrwa2Acc5HNAba6XkBpp9o/1Ole9qLYGL85UlERS+49H5ZKNFvtPcyUaV6gaUKGfVRwk0aAZeJJqSqg9cuul6N3x0sbdQcFAwDSM9ercK4GVbyOMfYbXKpGt3QkDDXa0U+/S12d4lXxq2wMB07b77W20PlNwF3Fi/OzzBUhKk/jfYluOSbsuZvtwDvwUhhTAk9X4amz8VNPL3JiZA6KfaatpGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dbTf/DY6ZielmflzT/XAFets08BCyHMCTNXAI2ZxvM=;
 b=HR4NCknZgATJdVp2VUP8bNdfJtNnEmh/Jbg77xLGeHcsbp5dcQsVGh9Y/KnDsfsmT275rR1MBQgJMSv7NWYIpAXzNx/FRTrxRvCuVM3QWXwIEUBES3mMeFFIZRkmZdG6rY8y3j5Nl9aiOfzvGDnex7qexx0aUKeYyUn92bFFR/Eq2qNLNcsjwnXKLhACKz3brLtv2MfBixv1Z6R5rOTXUfgV9THjubhKrzJQ7A4EZ3SGiRzy5N4ujVpr/F8gYJ0zZ/ROT81jAnujAwyIsnazQVMBJJiPXEGgEHwjl8UhRyI3NQnBdfaNDNdSW6t0SYkhlyrrSgewFcr2M11xcvRxLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 00/13] spi: airoha: driver fixes & improvements
Date: Tue, 30 Sep 2025 05:26:45 +0300
Message-ID: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006627.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3cd) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c545d14-b852-474f-afee-08ddffc8d8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tk/jITKPvawcP6krc3QVSklr+mg+Ed9ZSvz+AlaFFMEwNZkXh3s5Mi3nj0Z6?=
 =?us-ascii?Q?F4+c02TGsFEKw8dkaUSGdHliycZQG2uL+3dCfcGidMQohnHKYTdYga91kIeC?=
 =?us-ascii?Q?WfhwBYwG0yBPfVzB5nhyFsrXMIslm6nWBnJY014SsLNV8cf6iVsbnp4Ljb8G?=
 =?us-ascii?Q?bj59Ps8w2qisbIhJRIkxrKDxfsuQaLRN9OBP+D0ku86p25Ceea/pbK/W0O+0?=
 =?us-ascii?Q?0HK75lKpUmCCBruhY1ka/yA0ZcUQKtp6tUlMyYYe85CdPmGNkVx6fxgQm9qW?=
 =?us-ascii?Q?TzOCsqL0IHP7FMnWCow1kZxIXSD7+gCykiyAdr3VlsP122LeKyeQnHKwylNI?=
 =?us-ascii?Q?pYFwdPiVlPpNnZMuuXTqC4Td0t0RvnCsK32nZ+8BHonG9wCBR1/wMf8r94xL?=
 =?us-ascii?Q?x7vGGIRMJgVijpPaKAfJRcLKMLYlQImoTFXzZRxCHLTu2OTaETHi+F3PCzJa?=
 =?us-ascii?Q?ho04mVh37x7LBvT4+OPpSb/P/E+YJ8ika3ermIhEE1e6b5C+WyWcM7HoSmyj?=
 =?us-ascii?Q?Di4uTt/mZh2xTVHgMLd/YDu15V372CI1WGO3jGjqZ+H58SgrWlZ5HVElLp6r?=
 =?us-ascii?Q?rQqeZJbM3I9HQQGVxwpFrZh7lowa9F8fBgshIFUtwWJIufZjTDHVdwOQzx+n?=
 =?us-ascii?Q?rRU5FwtPtBBc2Ip1LVNDCV8Ne6RMdYiQi8cIbyzFyZ3IRJZ5TFYhZOflcobF?=
 =?us-ascii?Q?/fxk6IUTMSetk77n8TLL+brx4jIVjO31wYIiX1ze4C+Uhf7I43EIozOiad00?=
 =?us-ascii?Q?mdDyyCWO1KHM/esx9P27yWCA8S1RUH3oqbWTX999MDSlFGH8mFYMqSMJogK7?=
 =?us-ascii?Q?Z8Wj6GaXaYuRrClrvhYrU36TV8sIvvwZM3vAePyfLfMJNYjBCVORKmy0Njx2?=
 =?us-ascii?Q?00JuHKVBBdvo8u6vKJX8BlD5OtAYZeb/Yx4w6d9soIcvbJACEOi1RAk45x0/?=
 =?us-ascii?Q?GnHRhogIOvJGdEPa5XMEta0BB1QdzuhS/PhAzJyCZL51CdQ2+8LxlCcDSg8d?=
 =?us-ascii?Q?GUkS6zYOG8kTocIPv2oCYhANkoIaTZ6+N7ot+ZaBcKt9K/dz8Y4oAEadeVNC?=
 =?us-ascii?Q?uALT4RcXP9g5o0wXJD7P/MGQcOZllLmkmMnG0osUolR8ypLInvyezrvCz1DN?=
 =?us-ascii?Q?st/9SSo3ExXJ8hXDwcltLGR4QhKojzTZt5DUpgbj4lEWnkcTz5X7byeP2LK5?=
 =?us-ascii?Q?PAHrIv/246qkM7rZChrFMPgEiAL3qAdxy5ejZ411ljVSAp06lh5Ox3ZvIP4H?=
 =?us-ascii?Q?Z1Lg0uoJNKz5EsWYAVXcNlTXP6fuxdI6+JdbtrOEB6nIA113DhTmtayO88A0?=
 =?us-ascii?Q?eq6k/ooThqFvWXXX7VVrciXuW+0vJKe5gGUhKGa/JDHimw6ZhjihPVTYjt5M?=
 =?us-ascii?Q?wY0Tfivh65XS/fONo8oQUydxTZ+0PBulUsHa2dFs4XPoS65DA2iXiai6ZPoy?=
 =?us-ascii?Q?o4TaI8nLL02ZAn2rELTJndQlMSsvaM0t5JOPERMeYMMk9fAAMjjTTMXHUUMW?=
 =?us-ascii?Q?netchuAxtrSC45FMF9JeQBbSEvNxqbBtlxPM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAtHPtngIZ6pZ2xDWY4B75PJgsMHu60ZNqjlZGfRvdAi/0S4mrzss8kJsBpQ?=
 =?us-ascii?Q?xZfLe332PLmeuVWM0NvUUq88FMWpZMFPcxGEILribJUN/VdozOoab3WQeaA5?=
 =?us-ascii?Q?Ga7lCd67VWcw8a8uBWF3Csoz2XTN+SnvEBjrFavt8LUgxgrz9I/ZO+RXNIq0?=
 =?us-ascii?Q?a9vjadlytGy5agBfazt3YvBybWo5rinZ/OJ7/jM24dk0MyIspQ8VJZkNDYFb?=
 =?us-ascii?Q?lZ1MRTiAtFxOWt353wOR1Ysx0D4q8bcPnwojg9sjnvYzQ7YJlxlr2bH6NpOI?=
 =?us-ascii?Q?/evhzUYZLtjaVxjkMoq2l7vHgfb0M7Qf8HCFKq606FhmxGg3C+cdfq5qCwRW?=
 =?us-ascii?Q?v2x6CrjYE6/Kbb/5ta1JL8L71zXVK9UHw8IydZ1FlodCplDlcX9MbVIq91/j?=
 =?us-ascii?Q?DYLvg7w7v4MRHpkv3t7/+dSkwVgU37qEwJaULvtYDrLF/ZAxWHzd3AKem8iN?=
 =?us-ascii?Q?ns5otwzfMx9UteafTEaBmv2C21V8CqvGHpAyE5X/rZ1KwSft15RYgTh/N4RA?=
 =?us-ascii?Q?5CPh6W3njNzKgeggJ0tKicUOsJLWnmFLHf4oLoZ6p8P+TBnIthQdv7hzKP+M?=
 =?us-ascii?Q?nZHNbEgYtuxEhLchIP87Iul0GDyOY6dNgiNfgjpa1h1uu3HoiNALHc0bR/GG?=
 =?us-ascii?Q?l6eUJKSiNNKv97ip8C3aoFL6F270fGwc6QqIpQVN6ypNMNhSkUEYIISRFglw?=
 =?us-ascii?Q?iYKKP9v40ZMpinY/oA+D1qCEzGXxKdKO9jrlv8xizk7wTLC5QnEFn13OY68s?=
 =?us-ascii?Q?Mzp1WQp0xMN7X2ykJr+r3xhSKixOhDXtYxrqlYZFi8RMp3qag2tXR7lpBIw3?=
 =?us-ascii?Q?gHgz+JJdKoX5NqbkZXbjH1ORdsNVD82srFT2NWN+Je1aASQrWKXDGdv40z7N?=
 =?us-ascii?Q?WxmCW/SlV6lislwCSw6YoujW/VkE1JST94A/oedpzQ+EFahBXOqSjo6eIeyk?=
 =?us-ascii?Q?RfAbUr2g2NwJgTd6nbt2H/HqDgVRWqNIXvJiayzQBpd8M4JUhdPkSMVfnaoB?=
 =?us-ascii?Q?LHLTwYroORnRNrrckjuAae0jnTquhJnJC5z+u3gHmtxsY5CyN5y9HStiR2pH?=
 =?us-ascii?Q?QUGgKqbfnSNRezULV/bVtyFGgAKVHMoHr8mF/J4fBOVFVQlfV+R4G7McbeQU?=
 =?us-ascii?Q?0YqdCysngvhVIt2kMXxInHYl0/Vi1k0/ZD7sLB9pIYXzpVEQbp5Nh2EDN6m7?=
 =?us-ascii?Q?DGCObbnrHFJEha+tgpR8g4JHX51Ashv81jRIj+2dxUYMXSEuguSjOWFtj8hq?=
 =?us-ascii?Q?hOyc8BqU7If0GeneEhFTTz21IzIWCDuxN4lZdtKjYQryP92UOnQ2ajuGS4a3?=
 =?us-ascii?Q?Ab6opPSVarLlE3pXIO+YpzVuC77pAtC2RpALqspfyV5QBrj2SEMo74js5z2X?=
 =?us-ascii?Q?KbLXqn1EZqfoIHanYwqZZVc8aElINJYI2EPZxiHSLyEtTaKlqVwVIz5PryUq?=
 =?us-ascii?Q?QOX2oDlcQp5CFXvqaTqCcU76JWezD51cauLde2Jh7z+gotPuIrdFfUofetIt?=
 =?us-ascii?Q?bct3GdT+8ZyCKOKgt7LsI0xPhjjQOdczYVPSN96vtsFqkdUQHAUQJ7lzVaAf?=
 =?us-ascii?Q?IgB33mcAfoifET/dcOBFOESrHt5ENIOe0EppM5d2PfAqvnJH5ZIOjhnF21DD?=
 =?us-ascii?Q?lTCFgDLsqphE5s6najR2LKY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c545d14-b852-474f-afee-08ddffc8d8fb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:05.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TP9gqGyYb7SWJNDMWLEVDGtBsAp9bGjQKq0trErb73GwIs2zuGLXyDYuHUh08h0wte0AgBcsej5AVFVHTgmvPaauNpUmXOfrazwjZqLM2q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

The were no any reply in almost 2 week, so resend patch series.

This patch series greatly improve airoha snfi driver and fix a
number of serious bugs.

Fixed bugs:
 * Fix reading/writing of flashes with more than one plane per lun
 * Fill the buffer with 0xff before writing
 * Fix reading of flashes supporting continuous reading mode
 * Fix error paths

Improvements:
 * Add support of dual/quad wires spi modes in exec_op(). This also
   fix flash reading/writing if dirmap can't be created.
 * Support of dualio/quadio flash reading commands
 * Remove dirty hack that reads flash page settings from SNFI registers
   during driver startup

Patched kernel tests:

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_oobtest.ko dev=1
    [  263.191711] 
    [  263.193218] =================================================
    [  263.199014] mtd_oobtest: MTD device: 1
    [  263.202768] mtd_oobtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [  263.216791] mtd_test: scanning for bad eraseblocks
    [  263.221956] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [  263.227361] mtd_oobtest: test 1 of 5
    [  265.077216] mtd_oobtest: writing OOBs of whole device
    [  265.121767] mtd_oobtest: written up to eraseblock 0
    [  275.174147] mtd_oobtest: written up to eraseblock 256
    [  285.210279] mtd_oobtest: written up to eraseblock 512
    [  295.241724] mtd_oobtest: written up to eraseblock 768
    [  305.280167] mtd_oobtest: written up to eraseblock 1024
    [  315.326883] mtd_oobtest: written up to eraseblock 1280
    [  325.364049] mtd_oobtest: written up to eraseblock 1536
    [  335.398609] mtd_oobtest: written up to eraseblock 1792
    [  345.358981] mtd_oobtest: written 2047 eraseblocks
    [  345.363694] mtd_oobtest: verifying all eraseblocks
    [  345.386088] mtd_oobtest: verified up to eraseblock 0
    [  349.830833] mtd_oobtest: verified up to eraseblock 256
    [  354.276245] mtd_oobtest: verified up to eraseblock 512
    [  358.721496] mtd_oobtest: verified up to eraseblock 768
    [  363.166881] mtd_oobtest: verified up to eraseblock 1024
    [  367.612694] mtd_oobtest: verified up to eraseblock 1280
    [  372.058211] mtd_oobtest: verified up to eraseblock 1536
    [  376.503820] mtd_oobtest: verified up to eraseblock 1792
    [  380.914843] mtd_oobtest: verified 2047 eraseblocks
    [  380.919660] mtd_oobtest: test 2 of 5
    [  384.202620] mtd_oobtest: writing OOBs of whole device
    [  384.247584] mtd_oobtest: written up to eraseblock 0
    [  394.305121] mtd_oobtest: written up to eraseblock 256
    [  404.342199] mtd_oobtest: written up to eraseblock 512
    [  414.374204] mtd_oobtest: written up to eraseblock 768
    [  424.409891] mtd_oobtest: written up to eraseblock 1024
    [  434.453378] mtd_oobtest: written up to eraseblock 1280
    [  444.494321] mtd_oobtest: written up to eraseblock 1536
    [  454.534480] mtd_oobtest: written up to eraseblock 1792
    [  464.490962] mtd_oobtest: written 2047 eraseblocks
    [  464.495681] mtd_oobtest: verifying all eraseblocks
    [  464.518015] mtd_oobtest: verified up to eraseblock 0
    [  468.955635] mtd_oobtest: verified up to eraseblock 256
    [  473.395502] mtd_oobtest: verified up to eraseblock 512
    [  477.834373] mtd_oobtest: verified up to eraseblock 768
    [  482.272717] mtd_oobtest: verified up to eraseblock 1024
    [  486.712148] mtd_oobtest: verified up to eraseblock 1280
    [  491.150704] mtd_oobtest: verified up to eraseblock 1536
    [  495.589439] mtd_oobtest: verified up to eraseblock 1792
    [  499.993138] mtd_oobtest: verified 2047 eraseblocks
    [  499.997951] mtd_oobtest: test 3 of 5
    [  503.404228] mtd_oobtest: writing OOBs of whole device
    [  503.448822] mtd_oobtest: written up to eraseblock 0
    [  513.480773] mtd_oobtest: written up to eraseblock 256
    [  523.489361] mtd_oobtest: written up to eraseblock 512
    [  533.506896] mtd_oobtest: written up to eraseblock 768
    [  543.506268] mtd_oobtest: written up to eraseblock 1024
    [  553.506503] mtd_oobtest: written up to eraseblock 1280
    [  563.511266] mtd_oobtest: written up to eraseblock 1536
    [  573.519567] mtd_oobtest: written up to eraseblock 1792
    [  583.455111] mtd_oobtest: written 2047 eraseblocks
    [  583.459837] mtd_oobtest: verifying all eraseblocks
    [  583.499358] mtd_oobtest: verified up to eraseblock 0
    [  592.382953] mtd_oobtest: verified up to eraseblock 256
    [  601.267297] mtd_oobtest: verified up to eraseblock 512
    [  610.150907] mtd_oobtest: verified up to eraseblock 768
    [  619.034702] mtd_oobtest: verified up to eraseblock 1024
    [  627.919683] mtd_oobtest: verified up to eraseblock 1280
    [  636.821168] mtd_oobtest: verified up to eraseblock 1536
    [  645.705487] mtd_oobtest: verified up to eraseblock 1792
    [  654.520336] mtd_oobtest: verified 2047 eraseblocks
    [  654.525134] mtd_oobtest: test 4 of 5
    [  657.578146] mtd_oobtest: attempting to start write past end of OOB
    [  657.584336] mtd_oobtest: an error is expected...
    [  657.588974] mtd_oobtest: error occurred as expected
    [  657.593848] mtd_oobtest: attempting to start read past end of OOB
    [  657.599953] mtd_oobtest: an error is expected...
    [  657.604569] mtd_oobtest: error occurred as expected
    [  657.609450] mtd_oobtest: attempting to write past end of device
    [  657.615367] mtd_oobtest: an error is expected...
    [  657.619990] mtd_oobtest: error occurred as expected
    [  657.624864] mtd_oobtest: attempting to read past end of device
    [  657.630715] mtd_oobtest: an error is expected...
    [  657.635333] mtd_oobtest: error occurred as expected
    [  657.641043] mtd_oobtest: attempting to write past end of device
    [  657.646966] mtd_oobtest: an error is expected...
    [  657.651574] mtd_oobtest: error occurred as expected
    [  657.656451] mtd_oobtest: attempting to read past end of device
    [  657.662277] mtd_oobtest: an error is expected...
    [  657.666901] mtd_oobtest: error occurred as expected
    [  657.671774] mtd_oobtest: test 5 of 5
    [  659.382333] mtd_oobtest: writing OOBs of whole device
    [  659.388056] mtd_oobtest: written up to eraseblock 0
    [  659.393526] mtd_oobtest: written up to eraseblock 0
    [  659.704525] mtd_oobtest: written up to eraseblock 256
    [  659.710187] mtd_oobtest: written up to eraseblock 256
    [  660.021093] mtd_oobtest: written up to eraseblock 512
    [  660.026752] mtd_oobtest: written up to eraseblock 512
    [  660.338427] mtd_oobtest: written up to eraseblock 768
    [  660.344048] mtd_oobtest: written up to eraseblock 768
    [  660.655718] mtd_oobtest: written up to eraseblock 1024
    [  660.661462] mtd_oobtest: written up to eraseblock 1024
    [  660.970676] mtd_oobtest: written up to eraseblock 1280
    [  660.976386] mtd_oobtest: written up to eraseblock 1280
    [  661.286858] mtd_oobtest: written up to eraseblock 1536
    [  661.292587] mtd_oobtest: written up to eraseblock 1536
    [  661.605397] mtd_oobtest: written up to eraseblock 1792
    [  661.611142] mtd_oobtest: written up to eraseblock 1792
    [  661.918754] mtd_oobtest: written 2046 eraseblocks
    [  661.923458] mtd_oobtest: verifying all eraseblocks
    [  661.928812] mtd_oobtest: verified up to eraseblock 0
    [  662.072499] mtd_oobtest: verified up to eraseblock 256
    [  662.216152] mtd_oobtest: verified up to eraseblock 512
    [  662.359956] mtd_oobtest: verified up to eraseblock 768
    [  662.503238] mtd_oobtest: verified up to eraseblock 1024
    [  662.646847] mtd_oobtest: verified up to eraseblock 1280
    [  662.790603] mtd_oobtest: verified up to eraseblock 1536
    [  662.934269] mtd_oobtest: verified up to eraseblock 1792
    [  663.076329] mtd_oobtest: verified 2046 eraseblocks
    [  663.081114] mtd_oobtest: finished with 0 errors
    [  663.085647] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_pagetest.ko dev=1
    [ 1142.213082] 
    [ 1142.214590] =================================================
    [ 1142.220433] mtd_pagetest: MTD device: 1
    [ 1142.224278] mtd_pagetest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1142.238388] mtd_test: scanning for bad eraseblocks
    [ 1142.243536] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1142.248935] mtd_pagetest: erasing whole device
    [ 1143.962562] mtd_pagetest: erased 2047 eraseblocks
    [ 1143.967301] mtd_pagetest: writing whole device
    [ 1144.011729] mtd_pagetest: written up to eraseblock 0
    [ 1154.137933] mtd_pagetest: written up to eraseblock 256
    [ 1164.265201] mtd_pagetest: written up to eraseblock 512
    [ 1174.393365] mtd_pagetest: written up to eraseblock 768
    [ 1184.525700] mtd_pagetest: written up to eraseblock 1024
    [ 1194.650920] mtd_pagetest: written up to eraseblock 1280
    [ 1204.773676] mtd_pagetest: written up to eraseblock 1536
    [ 1214.896934] mtd_pagetest: written up to eraseblock 1792
    [ 1224.942600] mtd_pagetest: written 2047 eraseblocks
    [ 1224.947410] mtd_pagetest: verifying all eraseblocks
    [ 1225.053133] mtd_pagetest: verified up to eraseblock 0
    [ 1250.760034] mtd_pagetest: verified up to eraseblock 256
    [ 1276.448242] mtd_pagetest: verified up to eraseblock 512
    [ 1302.138825] mtd_pagetest: verified up to eraseblock 768
    [ 1327.824020] mtd_pagetest: verified up to eraseblock 1024
    [ 1353.532178] mtd_pagetest: verified up to eraseblock 1280
    [ 1379.234385] mtd_pagetest: verified up to eraseblock 1536
    [ 1404.943865] mtd_pagetest: verified up to eraseblock 1792
    [ 1430.468816] mtd_pagetest: verified 2047 eraseblocks
    [ 1430.473702] mtd_pagetest: crosstest
    [ 1430.477717] mtd_pagetest: reading page at 0x0
    [ 1430.482328] mtd_pagetest: reading page at 0xffdf800
    [ 1430.487469] mtd_pagetest: reading page at 0x0
    [ 1430.492084] mtd_pagetest: verifying pages read at 0x0 match
    [ 1430.497668] mtd_pagetest: crosstest ok
    [ 1430.501409] mtd_pagetest: erasecrosstest
    [ 1430.505323] mtd_pagetest: erasing block 0
    [ 1430.511511] mtd_pagetest: writing 1st page of block 0
    [ 1430.517166] mtd_pagetest: reading 1st page of block 0
    [ 1430.522505] mtd_pagetest: verifying 1st page of block 0
    [ 1430.527739] mtd_pagetest: erasing block 0
    [ 1430.532565] mtd_pagetest: writing 1st page of block 0
    [ 1430.538229] mtd_pagetest: erasing block 2046
    [ 1430.544181] mtd_pagetest: reading 1st page of block 0
    [ 1430.549498] mtd_pagetest: verifying 1st page of block 0
    [ 1430.554718] mtd_pagetest: erasecrosstest ok
    [ 1430.558900] mtd_pagetest: erasetest
    [ 1430.562381] mtd_pagetest: erasing block 0
    [ 1430.567208] mtd_pagetest: writing 1st page of block 0
    [ 1430.572858] mtd_pagetest: erasing block 0
    [ 1430.577680] mtd_pagetest: reading 1st page of block 0
    [ 1430.582990] mtd_pagetest: verifying 1st page of block 0 is all 0xff
    [ 1430.589279] mtd_pagetest: erasetest ok
    [ 1430.593023] mtd_pagetest: finished with 0 errors
    [ 1430.597651] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_readtest.ko dev=1
    [ 1478.691648] 
    [ 1478.693158] =================================================
    [ 1478.698981] mtd_readtest: MTD device: 1
    [ 1478.702829] mtd_readtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1478.716939] mtd_test: scanning for bad eraseblocks
    [ 1478.722072] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1478.727475] mtd_readtest: testing page read
    [ 1548.352125] mtd_readtest: finished
    [ 1548.355553] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 1617.353002] 
    [ 1617.354511] =================================================
    [ 1617.360332] mtd_speedtest: MTD device: 1
    [ 1617.364258] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1617.380150] mtd_test: scanning for bad eraseblocks
    [ 1617.385428] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1621.021861] mtd_speedtest: testing eraseblock write speed
    [ 1700.915306] mtd_speedtest: eraseblock write speed is 3279 KiB/s
    [ 1700.921250] mtd_speedtest: testing eraseblock read speed
    [ 1734.931886] mtd_speedtest: eraseblock read speed is 7705 KiB/s
    [ 1738.682742] mtd_speedtest: testing page write speed
    [ 1818.818644] mtd_speedtest: page write speed is 3269 KiB/s
    [ 1818.824058] mtd_speedtest: testing page read speed
    [ 1852.913595] mtd_speedtest: page read speed is 7687 KiB/s
    [ 1856.674492] mtd_speedtest: testing 2 page write speed
    [ 1936.437284] mtd_speedtest: 2 page write speed is 3285 KiB/s
    [ 1936.442869] mtd_speedtest: testing 2 page read speed
    [ 1970.498124] mtd_speedtest: 2 page read speed is 7694 KiB/s
    [ 1970.503624] mtd_speedtest: Testing erase speed
    [ 1974.343389] mtd_speedtest: erase speed is 68316 KiB/s
    [ 1974.348479] mtd_speedtest: Testing 2x multi-block erase speed
    [ 1976.068855] mtd_speedtest: 2x multi-block erase speed is 152811 KiB/s
    [ 1976.075309] mtd_speedtest: Testing 4x multi-block erase speed
    [ 1977.790232] mtd_speedtest: 4x multi-block erase speed is 153301 KiB/s
    [ 1977.796693] mtd_speedtest: Testing 8x multi-block erase speed
    [ 1979.511905] mtd_speedtest: 8x multi-block erase speed is 153273 KiB/s
    [ 1979.518367] mtd_speedtest: Testing 16x multi-block erase speed
    [ 1981.230700] mtd_speedtest: 16x multi-block erase speed is 153539 KiB/s
    [ 1981.237249] mtd_speedtest: Testing 32x multi-block erase speed
    [ 1982.948381] mtd_speedtest: 32x multi-block erase speed is 153648 KiB/s
    [ 1982.954918] mtd_speedtest: Testing 64x multi-block erase speed
    [ 1984.665992] mtd_speedtest: 64x multi-block erase speed is 153655 KiB/s
    [ 1984.672531] mtd_speedtest: finished
    [ 1984.676054] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_stresstest.ko dev=1
    [ 2190.651750] 
    [ 2190.653263] =================================================
    [ 2190.659087] mtd_stresstest: MTD device: 1
    [ 2190.663105] mtd_stresstest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2190.679846] mtd_test: scanning for bad eraseblocks
    [ 2190.684981] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2190.690389] mtd_stresstest: doing operations
    [ 2190.694655] mtd_stresstest: 0 operations done
    [ 2214.262705] mtd_stresstest: 1024 operations done
    [ 2239.019612] mtd_stresstest: 2048 operations done
    [ 2262.820899] mtd_stresstest: 3072 operations done
    [ 2285.061376] mtd_stresstest: 4096 operations done
    [ 2308.297322] mtd_stresstest: 5120 operations done
    [ 2330.530459] mtd_stresstest: 6144 operations done
    [ 2352.651759] mtd_stresstest: 7168 operations done
    [ 2375.188275] mtd_stresstest: 8192 operations done
    [ 2397.738174] mtd_stresstest: 9216 operations done
    [ 2414.792572] mtd_stresstest: finished, 10000 operations done
    [ 2414.798257] =================================================

Speed test of original driver (with patch to fix support of flashes
with more than one plane per lun)

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 2894.142208] 
    [ 2894.143719] =================================================
    [ 2894.149556] mtd_speedtest: MTD device: 1
    [ 2894.153486] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2894.168888] mtd_test: scanning for bad eraseblocks
    [ 2894.174023] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2897.500416] mtd_speedtest: testing eraseblock write speed
    [ 2977.807233] mtd_speedtest: eraseblock write speed is 3262 KiB/s
    [ 2977.813171] mtd_speedtest: testing eraseblock read speed
    [ 3013.906597] mtd_speedtest: eraseblock read speed is 7260 KiB/s
    [ 3017.440320] mtd_speedtest: testing page write speed
    [ 3097.833394] mtd_speedtest: page write speed is 3259 KiB/s
    [ 3097.838812] mtd_speedtest: testing page read speed
    [ 3134.004981] mtd_speedtest: page read speed is 7245 KiB/s
    [ 3137.538423] mtd_speedtest: testing 2 page write speed
    [ 3217.906288] mtd_speedtest: 2 page write speed is 3260 KiB/s
    [ 3217.911883] mtd_speedtest: testing 2 page read speed
    [ 3254.049757] mtd_speedtest: 2 page read speed is 7251 KiB/s
    [ 3254.055254] mtd_speedtest: Testing erase speed
    [ 3257.599146] mtd_speedtest: erase speed is 74027 KiB/s
    [ 3257.604213] mtd_speedtest: Testing 2x multi-block erase speed
    [ 3259.320945] mtd_speedtest: 2x multi-block erase speed is 153139 KiB/s
    [ 3259.327413] mtd_speedtest: Testing 4x multi-block erase speed
    [ 3261.044585] mtd_speedtest: 4x multi-block erase speed is 153098 KiB/s
    [ 3261.051047] mtd_speedtest: Testing 8x multi-block erase speed
    [ 3262.786520] mtd_speedtest: 8x multi-block erase speed is 151479 KiB/s
    [ 3262.792979] mtd_speedtest: Testing 16x multi-block erase speed
    [ 3264.509898] mtd_speedtest: 16x multi-block erase speed is 153130 KiB/s
    [ 3264.516454] mtd_speedtest: Testing 32x multi-block erase speed
    [ 3266.233403] mtd_speedtest: 32x multi-block erase speed is 153125 KiB/s
    [ 3266.239961] mtd_speedtest: Testing 64x multi-block erase speed
    [ 3267.957985] mtd_speedtest: 64x multi-block erase speed is 153029 KiB/s
    [ 3267.964525] mtd_speedtest: finished
    [ 3267.968039] =================================================

It looks like a patched driver is a bit faster

write speed: 3260 KiB/s  vs  3277 KiB/s
read speed:  7252 KiB/s  vs  7695 KiB/s

Changes v2:
 * minor fix
 * add comments to code

Changes v3:
 * add patch to prevent continuous reading

Changes v4:
 * removed non-needed patch, other patch was a bit updated
 * treat zero buswidth as single wire buswidth (thanks to Jyothi Kumar Seerapu)
 * changes were tested with linux
 * test results was added

Changes v5:
 * reorder patches a bit
 * improve description of some patches
 * minor fixes & improvements

Mikhail Kshevetskiy (13):
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: remove unnecessary restriction length
  spi: airoha: add support of dual/quad wires spi modes to exec_op()
    handler
  spi: airoha: remove unnecessary switch to non-dma mode
  spi: airoha: switch back to non-dma mode in the case of error
  spi: airoha: fix reading/writing of flashes with more than one plane
    per lun
  spi: airoha: unify dirmap read/write code
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid reading flash page settings from SNFI registers
    during driver startup
  spi: airoha: buffer must be 0xff-ed before writing

 drivers/spi/spi-airoha-snfi.c | 510 ++++++++++++++++++----------------
 1 file changed, 263 insertions(+), 247 deletions(-)

-- 
2.51.0


