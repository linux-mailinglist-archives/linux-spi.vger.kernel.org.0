Return-Path: <linux-spi+bounces-10500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8759BCB83E
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79FB94E7B10
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09B17A31E;
	Fri, 10 Oct 2025 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="qcR6mBGD"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E93D76;
	Fri, 10 Oct 2025 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067112; cv=fail; b=oGtJBCElsItZg1neDW7keqTajWT3juikbYMzIvs7qPvTwLQ8fRIYIs6Qb2LNhXnVSgfM7h8SBi7RcLlcJPkzHyxhQwK4jk0sWtee2fOgkQm2/J1RxewMXX4rkfzCC1+oB2BhvUet6nYRMOu81DqDTLMVDEZSpq5vAWssiitlxlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067112; c=relaxed/simple;
	bh=uVLR0g0j80Ic2oNQUDD9+WKx9oDToG6pPo5DyIRChE4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sXfgf5EqbxXMxJPbecep/0qOTLhZtdy+Op5cJB6v8ZNOIS3TcmCCcUupLhmCJm8SrTPR5wRzUyT7O1Ed+8x12LnvR7mDbkbF8rnucrV/603zGP56CcsQWJhJw0ENl/+zyM3RZCQrgvuz6zmCyAQjVTQNI6vWNoHFrOJ/VSfJjkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=qcR6mBGD; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlWS+qC3LRz6PD+04ronY2vuv6dJLEwkr773G15KClySz0FitlgKu3VqUkmH7qXmYquYW5Mi7sZH40PF+/pEDN9Upb0sYUDGBzllKd0n8NDPes6NciYta1XeMSEXsOk13J8W8LUY9JjvKwtMHcGNjK144JPU/QPFlsldvkYQlw9xV7iouX/vPbV8ZiLFKBNX8AV6cRPnSsj+OtmqqN/8V4RqzNkTrMkL3HQK1YRgdc0UXIgAYTIXG8SiXZGCi0bfxi+dXeJkJ7zS3WFv64srykSe9ssfGwoRtFm5WrPDSBBP0cuYlsAf6t6oKEpXWjgTAplq5XDaDBXT1YDeeSxq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a89L6/9WNj0S6+ddoEzkTfIbVnZlejXvUhOGsahirsE=;
 b=fGV5e2vu6dVYpj/NtaT7YE9Ax2TBHChtX22Jw9oQQJna6vjhqXwW3ZVFvgM96kUak56KdumrrpjZiakFodPWsFN6FCdG9jj9Kni08wv3+uNLSNRa8e0AoGOQNX5xZXlgbKldO8ut565BiYNYOXpi4MI/tmwd8hk9Nr0xIq2aQnpQ6OXAZ5lYodZrd/Lfl/qHm4GwNTd5b1H0Wq0M+u4Hr+r0Q+H4NiwMJTC4iraL6J68NxLnfQBs7+4NCtI4E0gqynjvCJ6Ptnj4m0XUxkIoxvrpmePxMJzkzwBJFdRSXKIlAT9bIjF5lSrtv87ESyHA4itzVbrBtROGHFUOvGN3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a89L6/9WNj0S6+ddoEzkTfIbVnZlejXvUhOGsahirsE=;
 b=qcR6mBGDzLWRNcnEpvOWqLbViQU4nlZGa1hpFN3b49gs4PPBJtptXFDkBzrPxa/gTLD4LcZLTp5MmtzF5geDRrBTDW2vvHpzWYvbHo3U6ORXWbuUvJhjzOuvewunonFqjy0IKD8srHhvmU2VOeYBsnTt2BMo7i6HSAdW+yvQ8rB4k2c6/YNlyQpXJ2QFb90YtJiXp6Ua127TDdymqBx4xhfE9HW6tjwibDno2eMVsVeaN2cdpWIowV8W3eDKu+lD0kPp3AEMk+RieXRUNOnoBZeKWUxiO4+mr4pTCS09VnS/wEP/tRyfyCzGkdPG4+y1U0tPETvRF7jc1fKj3gExEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:31:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:31:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 00/17] spi: airoha: driver fixes & improvements
Date: Fri, 10 Oct 2025 06:31:19 +0300
Message-ID: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bcb319-021b-4869-7291-08de07ad895c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzJULd+qblDydwUgki7LiPvLiQ1Nmzn9oDEGw52N/Zxfh+9hlB1CF1t74wdJ?=
 =?us-ascii?Q?eQoruOaV5qSUtoinTsTnHogJMS7d8FG7xNrrfgb7mJ1qjHL06FIZsaKQCx3k?=
 =?us-ascii?Q?4X6oXT3Y9OD3cuvc/CUIff2oan0dg9ABQ5YjklZTlApZXeByVi9m7kvw+boG?=
 =?us-ascii?Q?N8kWcclxtpXP1vC6tEOnCAwOdXZTiGnnct/ursfk2/FcBv8vBw1Zc0GtfUxj?=
 =?us-ascii?Q?kuNHQUA9vdm+Zs7cO0p/s73keoSgDpVPY8p5VusIO4oLkvNfLAUZcwqzfOtl?=
 =?us-ascii?Q?BFbLoAlAFZD1PCtsrKg7Tn2xYBu7CI4M6XMOYuDHh8oS8gMLEh1PW9alMi5j?=
 =?us-ascii?Q?S5P0oIp2zy19oXi8rqyy8TegbuKumRushO1NZV91w9/Mq9fWG04EvyQ3u6nA?=
 =?us-ascii?Q?k79UNZLq1bMA6gjWyz2G0QKdKM9t8VBXAbG64ynSk3424UFGf7JKzle0J1Dz?=
 =?us-ascii?Q?zwBA00CWvsx9wPRNpi3HKvwBQu2eygT/U8r+TMkLAlRSxwXoa7c49t2ai8u5?=
 =?us-ascii?Q?W+VEOPq64GUgRmj7hJHVUId7HpSWRH19Ca4+1SdhyVpP7X8CrsS4FAiIR5Qi?=
 =?us-ascii?Q?HoOQDW2JYGyeLWijY2V6aSoxaiskCt/DflOG3Utjf61YSgapnrZX2KvIhmZ9?=
 =?us-ascii?Q?rP+ssXdJtMjKl+m0O8bYxjk0hNbKdLQTxQ7PAKG6GRxH5Y+mp8EUFcTBe+Ww?=
 =?us-ascii?Q?RQaHE9Hv/MIJ1BxjyCUsG1Blm7q9MGHQ7nw5o7e8PZo1dzsBJn9/ewtm+4ed?=
 =?us-ascii?Q?1z4U2he96YpSGx7sN9aeXT1OpADFAaNd3pf4Uay+ZcyYeHLic3wITpWr/nX+?=
 =?us-ascii?Q?IUjKqGoRXhIyRtP9i5MLMNrWw8dv9D+NexnOpkBclzO4vi5hXLWKSsPrTWWY?=
 =?us-ascii?Q?nUwHZ0jo7HYrlmK1iL4MW8F3//6nrhqX5GahjCNZ0aU4UwBtm8cDuNx93nYm?=
 =?us-ascii?Q?iTofy2eiGVNBwk5iLk7LwQ7NMnuU9EnV6E/sDYB8U/bw+gfZu5b5L2T/inoj?=
 =?us-ascii?Q?wDmNqnjbqK2agK4ik/ZQH7a4qPxp/vSLZLUs1+1EklEnq7nKfxzrAXKq0ZdU?=
 =?us-ascii?Q?479HqGTTqIe76T2+R3OfuRbSW2mxmMH/qBJ6X2+6GFs/OKmzo0/fkPlLDo6C?=
 =?us-ascii?Q?R87A7Yz+AHEbL7wK3kRhVFepDzKQRzXr/ywbCe1fSnhbAwQiGAludZqDb6FC?=
 =?us-ascii?Q?/hcQfJPYoNjoZXRobPXpmUaT3XmrYO5eIMrKfdnd0JwWc/3BR/9m6usN3wmW?=
 =?us-ascii?Q?fGMOTt69WtGa0T1FCjOI+ej7Eys5V2z8ArC5SNLUKLkoG2gnNDyXeLLbCl8d?=
 =?us-ascii?Q?TpR0H46gpOgQ2k8E/1hlFbTw2frLM7rMjT5G+K/mxz87SQLdqDylK/wbZWxm?=
 =?us-ascii?Q?MWeIEa2j9oaHC/ZJrXF/9rhVfNd7XXRM271Z2Bfjv/r/1sLiU0SUxnlP30tu?=
 =?us-ascii?Q?vj/9HkGyO+Yd4KKgJS5UvBWUbr51pBY4PXjOSq3y9ghCGzzb0v/F7N9jh+so?=
 =?us-ascii?Q?C5YWTt7lCa/7y9SyglcZ48Chuf4wYEDfpRTc9YyxZ5xzafSXQUAQY8hQ4Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OVGQ6DwoQnB2MZasntx/8H+1+fLMGUsvm53hiLMBKKqPrXS+OREnUGyB9MNV?=
 =?us-ascii?Q?QYyc+nvQn7jb+4HFAlN3mJCBCT0SIunZFSgyxUGUDAQbcobfQIkbY7zUFXYd?=
 =?us-ascii?Q?XQ6YaPul8XIZlR/hO4jpxlsGUJJDPpIqp1xVGjUU/lL7LLGA7w/Tgf2kqH2n?=
 =?us-ascii?Q?Z9mv5J2EcQo7n5iGP5E0IHsdlTrE13/u/ILpb+3HjimAGzYZR0YY6G6JFsi5?=
 =?us-ascii?Q?2d/KKeBTRZVw5ttAuZz6Abps6/5l7fV5Y4+Mw1ln7NoX84+eA0jFio2zDIh8?=
 =?us-ascii?Q?y/xrHOCt0GwZ52/yeaj5SZ5qy97mDD+VQI0AGo1YjPE8WUCmeJoW5qEpR8qQ?=
 =?us-ascii?Q?CmIU/Ue5qFUKe7Myxos7bi6l4LO13+zpYRLzIUNEgzfsM78W+Jte69qiHgsw?=
 =?us-ascii?Q?FnOyrbdAajT6QvIeerRj7l/KrzCuri2ZsRCPehWm+3YI/nnAHH/Sgqsk8QCj?=
 =?us-ascii?Q?3TFMZEPEKi54QGvZep6wU3TrQiT2F7nI6FJtz7Ecrc5hdO4XfLtQUkCFb8ow?=
 =?us-ascii?Q?mENkTBuro16Gm6a77dANLQNXW16ikXCO2ZC45daKGzvz+8QQjBesJqoiWhvk?=
 =?us-ascii?Q?Eadnh7FCatWGLXpuluwXdP20TULkL3VzaH4v40zmmUZzVlyiaS8MtWRxxCbO?=
 =?us-ascii?Q?b3+0zhwc04n6ZqCVKnvKbRy/iAu93VotSsLqmHHtfcFWgWkT2WcS3wY2EXnM?=
 =?us-ascii?Q?KZuRhg9fRRpmUE31Hb0amGRwKx1TcwB3ozoyfOtbdJeWTWIqcfTxKq/Ub+j2?=
 =?us-ascii?Q?XoGkZZnCHdbs0haogugAq/a2t5z2NCp8UmiRasEr87REL4fa8KZIabL3V6Hy?=
 =?us-ascii?Q?xuiqoMnIKPIPU5GLUEqVjPUymwmbxXh2GnVc9FZAH99HacRMXRvEEVvAR7HI?=
 =?us-ascii?Q?vEjcG9VMSuqEc4/uJeLQvt1IfKWGn6KBywKeum/yxmcsDlJz6i5sUC/FtBi1?=
 =?us-ascii?Q?+wGYsv92EFS7iYUX2XYYKPbgS8cEy/kvk52q+bjSoEqGLRc9nxzqzb+3MACO?=
 =?us-ascii?Q?3ZWF5Hd0lD22VloHUccD3A1geODInImnbvFKSFKQ5LGdAwRTdTYG0SViVaO4?=
 =?us-ascii?Q?UhdxLosJPt7bl/dkvWSYpO5EEWr5azHdQYvnRDhk30DutmCiSAaurQIE8k+m?=
 =?us-ascii?Q?shp9GQLY58VOvEdd+D2FQbEscRcDGSCxojnZ5JanPlEfvFHD+zeLDRTIloYF?=
 =?us-ascii?Q?7CUBQkHnrTKUry0MtYQH/ERXRNAdI2ma8IarhsuqUI0PXgtQBo7AGDWfrHUC?=
 =?us-ascii?Q?tIaOBIjZfoLot7d12Z9SHAWMimzhTKOs7eTNYGo9HuYGhLlcfkdoXg9xdFvX?=
 =?us-ascii?Q?ADZ5z+te0CMRQlxi8bFgbjXjbtL8aju08wAiuBe0T5WlCIb5umhouRH2Je/g?=
 =?us-ascii?Q?tZJC06rH+WXUMl5iZxRSWdwIQEz/1894hBQf3NeeK2q6TI6jVwTYBQdMQRdo?=
 =?us-ascii?Q?rrtLQV+uJAwvvZZz+YchItIvYjHwhwfVajClYSinLxgpVDqntHlzjjaLALwc?=
 =?us-ascii?Q?olZLjufYcLz4wsH0x9fp7Xghoug21q30XET7Q1L+8C3ZAwgiZAVuxyWUQfe5?=
 =?us-ascii?Q?CpIC7VAVgtBG8q5a+LrQ6GXhnpAKGFe0uGoBzu9rNY4I8Z7Sto4cXWkeMlh3?=
 =?us-ascii?Q?R6xK2DYpDTSpCEoO6CBpk4c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bcb319-021b-4869-7291-08de07ad895c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:31:45.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1DJQGdkUNoWnrplXkbCQ2QEEZC5vt95FpUnXXt3IZUGIuziP8AJizGk94WVslKHZFpRAIhc3MRqbTA0OfUZGcLI0gL/DANF61SUEFMO4+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

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
 * Add support of EN7523 SoC

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

Changes v6:
 * do not fill with 0xff the whole write buffer, only areas not covered
   by user provided data are filled now.

Changes v7:
 * add EN7523 SoC support
 * add en7523 specific hack to avoid flash data damaging if UART_TX pin
   was short to ground during boot
 * add SNAND node to en7523.dtsi
 * update dt-bindings

Mikhail Kshevetskiy (17):
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
  spi: airoha-snfi: make compatible with EN7523 SoC
  spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
    short to GND
  dt-bindings: spi: airoha: add compatible for EN7523
  arm: dts: airoha: en7523: add SNAND node

 .../bindings/spi/airoha,en7581-snand.yaml     |   5 +-
 arch/arm/boot/dts/airoha/en7523.dtsi          |  21 +
 drivers/spi/spi-airoha-snfi.c                 | 552 ++++++++++--------
 3 files changed, 327 insertions(+), 251 deletions(-)

-- 
2.51.0


