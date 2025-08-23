Return-Path: <linux-spi+bounces-9635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC698B32A40
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A871C21F2D
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012B61E835B;
	Sat, 23 Aug 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="GEIphivE"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021097.outbound.protection.outlook.com [52.101.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C0393DC4;
	Sat, 23 Aug 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964890; cv=fail; b=gVgcG3wHqAKPkUIcnyxTGK8qrhkSsVahfbgrT8jXZahoMMGGyDSrnYfnw0n92BuS2bl0y1LFRHcTOz4ppKuPhOWkTcvBZTMqcyTzncvNFeFC3tN9RP9a8NeKCZ9u8KOMdM3cvctD4xKmPd9xK/Ep228bkenlhRrTsVrAaP0viCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964890; c=relaxed/simple;
	bh=Qq+gYlqtzz6CG7mtJNSCF0aVK0FXEIKbLY663RXT/8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZtgcAq5ASVH122OsRpaZonvcwajvPmYTO5H4LTYZ5PMAMjjln6t0I9AbGxc6b6LlKUNb4KtsojPtwsL/Ar3XnaHSZEzpZ1D1nXcwH9PT1Z/Z4D1ne2EiBSiCO25MDT/PzjbDFfTzXvk0oA70MEQXjUanVIhtaX1+5Z99FZx7x0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=GEIphivE; arc=fail smtp.client-ip=52.101.65.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=con9nHixz7xwflEtmmQA6A94SqClce1w5UJchEMpUrkiGnynNglDgSqtbT4Kuu9/rcobDp7Kdjfd94rMkqZ2bFBOMZskSkpcffD51jPq7HhDxD64E6FfrUiX5qOGyxR0vDAlFjvyHvM5iKoJHkv8XyINT94qTQWkKtcCcr+WqGbC10qZBtXS+jKDc+av1WLSz3EUQLVxr3qFsqNokvvcx4f+Xknhm2Up2B+QtuifU4ELMGPukgCPMbRanddR/JN5CNC6EZB9djUbKxJ/0EacmqBnpwtPT1EyzCCTQ+Ik69en4K5/DUMdeBO0cU0SiGPhTz5MwDa8vx2oPCj/HgUgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRR6j2O2EeJr4QICLyLkDSC0CZxVoX4BMUNYPfD06RY=;
 b=YkEhOSEubThV9lqHMTj81G9BFue4lQr7e0R7Jka3i6uToKndPGSQ1d+ChfgRywEK1uqB5i3iIYFGR0LjDMEk7eXZnu9nTCSZ/tG25w71ZPxcxF/RUAolgHsiESrvFOoFFH3NFUkVOvre+s1p/LEwcxUT7UgPC+gFsYFlegfzHZ+dKz8WRcM/V3K0h5Wo4I3xViPs3fT6EA7+mNwNCmVjjH7Ocet3qsuef06NShOB/Zp5LnT6oj5UpuTKvsnpHFJh3swomJa9csWm84C5kUEwx623ynPg89LDeOi/USviYsihv+Mim4oSqk6G8SmQnfeZ+mys8XXjuFBW8FBnKI/A3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRR6j2O2EeJr4QICLyLkDSC0CZxVoX4BMUNYPfD06RY=;
 b=GEIphivEcKsY/5a6Ha5VNRY27rUCmcLKCsaQYLGJAg8E7w/3Hk7x/jcNVccwaS9cccggCvfhcfOKu9ROnuLXlfsSkEuk7RvJdQP3T4N62HqGFsKgUPVXRlL9L9FM3G7u5int2gHUSyBLz1OJcCHXfljAesXKPg63Uz0KCD83mLPW/hOBQpNg/jOohe994DokVgUTQTthZ6PfFbT7ZViVKk/vrs1/er7eAqq2Dj0yCXPpYkrBzOC7OW0d4STtzKeZ03b7/dKwGLTByfq9ZpmErGDlyZFCYlyCjXO70WXX9RzcNDAquRbA0W/20zMHz2NipWrDk+XbnAky5aA+JA1i9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 16:01:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 00/13] spi: airoha: driver fixes & improvements
Date: Sat, 23 Aug 2025 19:01:03 +0300
Message-ID: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d18b758-a69c-4dff-7949-08dde25e4ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p935h9mzQ1JgFi4BwmAiFD2n9DrzKQ4bMgaLjJLHNbqcR1bMjz5G6dpFAgEa?=
 =?us-ascii?Q?oMWSacX+3Ae994yRP7/8fZoDRkT0v6Ajb43vIVxw/peSpABvIKM1pa4ahSQi?=
 =?us-ascii?Q?iX9+fKnN7Q7HTbLOUf6/ME8enxkEvy1CNOL9VtREnKutXcu4ZSZ1PPcpgFL8?=
 =?us-ascii?Q?5zYuZHnpPD8REQaZEsSeFgbZY1x3s01NvDdhB5C4SzInGLwfM3oWM3/1y1Ij?=
 =?us-ascii?Q?KLVO7FOTPii0kumtDczO+8Rxhu4kevQe4J9c73ahPCn0BWlE8ETfazqWHVP6?=
 =?us-ascii?Q?SCGvFzTw2Do9+36BTMbYPxYpDeirmkErnbNZHykt6fc5VvfaHC/5Lcif8KKH?=
 =?us-ascii?Q?Te8STzmiZNU/JhYAbyF3w9LFu0Q6qbE+aMYNjouFLURMnHlbC1RK/Wtlahym?=
 =?us-ascii?Q?5vNNxqT29Vx5cvVMN7XT/doTBzsZVihCiwpG6JNfBnZQMZbR1rtNXtjWDsk2?=
 =?us-ascii?Q?uDpERSC4j37Jqu98FC8vYIs6v2A4dk2V09ndKJAX8gTj3swErSI8I4JHSURW?=
 =?us-ascii?Q?XQpPaoZgJrDkyVSxVvWPi/ipuUEy8nYe3v8AzoVSFPmxpZWR0GwDa/ugyv97?=
 =?us-ascii?Q?JTPPfW8A/jZVd6Py3GP2zjXCOpXXTDZeuvm3/w56wg/qVc7DeD+huvTI2DTl?=
 =?us-ascii?Q?o4eMAY7rTUstvFSXAMQ4kVw6E73DnvYjigzxAq0tdWDhP+r5bx83rJC3tulX?=
 =?us-ascii?Q?3GU2FUOvis1IUPUgivLZexuBDgW0CKeX+RlnjTtEM8wDP0Yr2QFFqVrg6nwQ?=
 =?us-ascii?Q?/u39x1WwU7nhYGnn3DM6HRUwHWoOHmMRiRI2/nIKdpweUp9sS95RRc9aJ8st?=
 =?us-ascii?Q?w+wNRyynvyyv90dy2js6KmiY18IWcfNuWqg+mYLZoOwex+JTUrEAw0Ojk9lx?=
 =?us-ascii?Q?ljbhMWuBteMmSsVdsOU0UmdrKQ7Xu2XA5HREXqFF/xxUXC33BqliQRRRNuew?=
 =?us-ascii?Q?KsjyH2ZQjtaSv6hm/NcCc1ausVr30wL0UTpTetLqK6RAvbKv/qbaNACkT+P1?=
 =?us-ascii?Q?TzbxHsTOtEUxu/olqP3O6UQddK+Rqf6iVpApV/3FXdUUkgjG8HKdXo8az+X9?=
 =?us-ascii?Q?USfTmuZyAwuwcGbRpS5qTBgcMGYQmooHEIKj5uF2pmGx7aV50tOLZQ61Arhe?=
 =?us-ascii?Q?y7lGaRRTPXCVSm2EAjDB0nxoTKsnMuvKNTOcSTRXNbk54W59nrlQyTC6G01v?=
 =?us-ascii?Q?CWWKuE6Vpe4JiHId4uPRXd1We/unvJhXvCG/xH4DJYK6Tn8mJNdNgmEhiNAW?=
 =?us-ascii?Q?EORF7Ljz/1CxFVbrCB2gz6I7S+hfA5AThZy00OK/WZ2cDcgaDk1gRl99JE17?=
 =?us-ascii?Q?gXu+qbF+ASiaLdeV1rR6ZLDUS70lXba1OWkVsy/2FY+Pz0vEetZQqjvOLqLM?=
 =?us-ascii?Q?EIJJxFrWZrPTalTL7h0MpfcCwG4CRLSbmSpSL7jzg3L2SHqGcuv+FX8VHVDv?=
 =?us-ascii?Q?PYUB+Fk1xSlb/LN/nqbVMqSLW+QXloAYfZzfeddHuzNpTATXM9qkGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SD/6ayKWwgQjlUdGsbIEWxPEUnC7E8bCgxvYm/fYFjZXMXcprAjRcvhBPe0M?=
 =?us-ascii?Q?zqqpiDBHwuU7Hb0CptjL3I5DCdyOUMlMf9Qca/xfn4VBGk1p+rpgxFumA1pY?=
 =?us-ascii?Q?GHlSxpftH70Bi6VsIAIIW53JPTXVg8NnaXqlML3sqFfH5NllNdTYHWEi2Hlb?=
 =?us-ascii?Q?8M47oU/UfTNKhpGpgDKup1kIclaU/1Ew92CbgtlvLTl4lpGf5c55SviDqArb?=
 =?us-ascii?Q?P5Pb49Xigo2i5vfrPrbU5DjrTIbZAPUWOdbMLUlay33V1EaKQz1bB+Lji1sT?=
 =?us-ascii?Q?732aNFULHuSZsT49Y3sUGtDVWq3wxvi/ENGyr/gE02OWl5y3zu7ylLKROE1w?=
 =?us-ascii?Q?U6vgDe1NaX88zyP6QyRWfWhhwd4I57u62F2Gn1JhOkXWNpFTldE4w7V24u4q?=
 =?us-ascii?Q?+YZx2vw/kh+K6cpsIMWUPnIR4F5JVzG3O8t6Bifo4JkQp+t6d1XlPYqvylqu?=
 =?us-ascii?Q?XiLF9CcL0qMcg3+Q2yzUBlARZ/7WNJ5E/aiL+kQwr7nbiXcLGQ3jdJmU6qKl?=
 =?us-ascii?Q?L0ta4pMedb7/8J53e7JPpbPYvnh1y/6kofN5u53Sf7wasf7aSmFUbjeh/mHy?=
 =?us-ascii?Q?fLSYiFYuGdJbn5nYG+Uz9+t5R2aMWA2l+78XTaXadz9HjJ+VqRHmwkzcWfB2?=
 =?us-ascii?Q?FG+EBVsU0TCmMMph+/DDny+g4ndpmQp6z8OM5LFqMg0xHFpPFZy8YBWIn7Jv?=
 =?us-ascii?Q?VlRFSWDgeBJzy99VhYwvPJ1mVMB7tLtwAFYAICxSHfbUCN4CUpb9uLOSNine?=
 =?us-ascii?Q?5aBhoZ7xK7picoRqY5MRsfuhZj+JzxntFwf+44qbk5nfUgjg7wSdXZakirdr?=
 =?us-ascii?Q?7g5VVaToTYJfHoY5GXmfHIRBvyLy1Z//Fz7YqSehM3lvtc6XlGQDeIMfqE+u?=
 =?us-ascii?Q?wI81HSIOJT34gADY/fM0vZI9vQ8lq8vfCw2ZZa56sDmWda4tAzJDQ26k45Dj?=
 =?us-ascii?Q?LYgI5+kWxt54nrrdGlDOYJ0OgAuuqYCKHQcCjQJovmjZ5XgffPnB1abYVk3U?=
 =?us-ascii?Q?7rjaLdLmlq9AP20V0PsvM8qdygY0bWVYFvthEQxMBThcXkfHnf3VpptWlkpI?=
 =?us-ascii?Q?sg+Q0ZOy4Uj3k9AxxHrBnicERiN/s8k+ejEM1jIPcS1lafViv/JcgbLNQD5V?=
 =?us-ascii?Q?I0aHHhqBR/alT5kxuHcmqv8zMveTDVeKsYf6SytH4zGbyTVVgwhe03OBv3yS?=
 =?us-ascii?Q?kbFmp1t20L9OFeE0vnh6s/8J5v1WJD45JDU0XUZ6dqoaTBtKBWtlIujYO5ll?=
 =?us-ascii?Q?8ai0lru8rfwKQ/YXXVJDtwK3jmEzapuY3V2IcJ5/41X69CLSitk6BjlZAW/v?=
 =?us-ascii?Q?hkgZtvkZwtHRJIxAUiQGQzJZWcbOd04z7jyKGAWwYz5YFtZrEAK6YXiT0A7w?=
 =?us-ascii?Q?6G5Y7EfYTQ+kNjtV3QhgdHClkX3VvJcGZtgQZ4aKdz53StQeRotwPElNTJvd?=
 =?us-ascii?Q?4X+GP/6+VYPUhVzk8xb9HdAmjUXZiDdV9rueVMBIjZDUGFo2REGwMwGRSpcf?=
 =?us-ascii?Q?XzzM/ncMaDKzFTlqynkzZm4es+Xlh/mKpnjqDWdvPLIxu4nVXJJRrG3kh6eE?=
 =?us-ascii?Q?raytCH8lAP7d+V1ZefFStb1nuHSUYj594Hv31QPn3Czx8Ybv2jydwILqAxEh?=
 =?us-ascii?Q?qfeO2tEYutZrXon2JZYuzWw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d18b758-a69c-4dff-7949-08dde25e4ef9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:23.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdH/vo+OvSLYhhI0tAN5UoiGEGnafXtAaIX/kIzGD2R1shNNMPJGE3ZH1mqpxluoUD+RajOftmgjnPgX54yUZoE0n18CKpr3wMOR99FXk8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519

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
2.50.1


