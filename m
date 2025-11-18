Return-Path: <linux-spi+bounces-11272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81668C67C87
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 07:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B38524F19E2
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A552F28E6;
	Tue, 18 Nov 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dZ23SoER"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D622F25FA;
	Tue, 18 Nov 2025 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448644; cv=fail; b=WwB8tb8FeeEgyQnZR3F6JEklPrPkqIsEAdE/F1e/T3rFKt8jgl/hDFHS2tz4e5joYm1O8FlMPKw398x88X+WWW0/SVIjBNzCewUIW02H6YE+h95tmYQgLiO19c7Xm4QEgH/6lw5dFzI0SBJxAAiN+SfNsZOgO2V6j6dTqbIPC4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448644; c=relaxed/simple;
	bh=EVC9rY0RPQg+lxbi/AJeS/JHj1nwve6Q2GpZgMUO2Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WjkstG5WVE+aRcWyTDM89psWIxBwHFYuGHMLgw0I18rIsXRt5CR6Jr2YapWVQO22vg4UrPvW0UYNfMC9DJ+XXUIj6NrHZlBnGkh7OShghaDcKS0zN37fZbmFO+Tzno4g9k3FLM5yAJG+OcP5ihcixrWY4kXWlgeW4jvuE0pvo7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dZ23SoER; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7FFFEP7kXBg7DS49JGOMKhBxzwgk0XLnMx+Ar26dfgbhTM5yiBEoZcMExElbrCThtu23AYq/HhGhW20adA243eUfhujzbxX2NCdTzivRUhk2P3jARunVbr3bJXkkPk6KlvW+qiZeTkZsdeKTBdSCvF0WsxMFQ4K4RzCnthX8Kneh+2eLJ4D6VeupNExEmAWyK4YO0ghh6icG/HKIR8c3UrR9/VYqWFtxWjvib6GZz/dshIGfs9tl0GZ+CUIwHn2R/wStkWlokMezNTE92CH5WxsKOd1dTSA2r7ZZj6ydD7122x5Ah9zTcU25niQ1tocVB5y2H6Y4dXtsrDunfytQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NdONRSD0BeajyfYzy+X5O7slm079JoxorRHY4kTlyI=;
 b=cYFk59UezVjpMryxnr8S3uCtFpozH+2r1gL1bT/TpaD+TyOBgkqsPxwIJlWsC/9qqS5PWSI1hp0F91WeaATQkXjZjpRlf6zDBH9xKIduNtWXwg/nCCL1CKBIBBcYkCHbATaCh1oWEztbO/h0+uD8kT/rxobWIBKDZ9F/ExLZVBUlwTaKq8E6Wgzl41tTPrWdoV+9dvrPruJ+Je1OaCW5IW3e1MrxFXneCbHAay6I17noda4brq4hdUQpPZlHKSe4HaXBfrntuxXkeyqFfBjzb1DADZDmsdKbs1d4DDK6pgpsStah510sPjpwqWwcnBWtGQP5wh+b5YJ/AB2TEKZwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NdONRSD0BeajyfYzy+X5O7slm079JoxorRHY4kTlyI=;
 b=dZ23SoERON0Q5Bjkqyniekduc12npwjYC+YmR9WMUTR6mB00uoySeXLaEBz2abTqXEkgV6fJRBrFhFOvspG0CVwBrIHQFlc4C8Gzo2HR2opX0d3REmDYJhvjqkDpn7nfVRLeuAXsL55jJ9YYC8jees33sByOYyWL8qFtAP9T6Rq+VllAh/mOyW2lS6xeCEYzdcagrmKk/0nbioDziHVHSUNGVntUHFbR6WIrdhXO/5bbGClXuzSb/oHQMnn0vnO1vtQmj6+CrPOGB3uxaD6XPgOqJsP0pRbDamFQoSsoLY4L+XXZyB9YFgR7AYTFTYxSfxicyrXfh0kGmv7NQBAtKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DB9PR04MB9843.eurprd04.prod.outlook.com
 (2603:10a6:10:4c1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 06:50:39 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 06:50:39 +0000
From: Carlos Song <carlos.song@nxp.com>
To: broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v3] spi: imx: add 16/32 bits per word support for target PIO mode
Date: Tue, 18 Nov 2025 14:50:12 +0800
Message-Id: <20251118065012.1418279-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0042.eurprd04.prod.outlook.com
 (2603:10a6:208:1::19) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|DB9PR04MB9843:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0c7cd2-07ae-493c-bd78-08de266ec887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?shZk5eBa2heFVbH9DMU63WRBbojH8FZ8JpQusVArz6VtEprodjJ2gNSVA6c3?=
 =?us-ascii?Q?DO41xBexHTif3VDUyoAlymJVfHRZ3h+xucCmI9UQEwioSusW2SGqTYomiWwU?=
 =?us-ascii?Q?XINCQy9eqlWadBOCQiyrxXxUgbUU0fl11ZiF6SyL19BeOa+mJktY4/ZFouzE?=
 =?us-ascii?Q?EHXV7137HdikfGIh3hKZzcHiX4d1K9OTobQbLM0SfFWaJqg/F7vTCTMVYYSf?=
 =?us-ascii?Q?XylKx3WNLPd+DO8L8XIVd1iYnBaWwnW97WSnPMvt3fJb2/vrRMqXTwZ3y+rd?=
 =?us-ascii?Q?tXaRVGg32jm7UCKhKlyP0f94giYHPdpJ/RjFcLiDB/suXF3w1bOG3EYd3Xlz?=
 =?us-ascii?Q?Ob770cm8BltSwdrTIgzFRpaMhZkdz+gPLn5XVjqh1GwKH4POc5TcgLSGF36j?=
 =?us-ascii?Q?JCAfvFjVh60JPkzw9CFDhFg7JCTY71KHMiIv02U4AWroaaqlZNsyf11PGECt?=
 =?us-ascii?Q?hQ6/xPj41xS4462Cd7VJo+Vno20markFbsOhYkmX4PZvFnQ1JZ7uPiFcAmV4?=
 =?us-ascii?Q?9BKUmWDtUk9gjbYsEtuJsAs/IYWhZt8RFOdKi412SHX1oVhhODz08ZW6ZP8X?=
 =?us-ascii?Q?5zb+ntfYTfOoaAikNmO5MI3SUPptE072NREMoHKbstWydIIQr6zgIgr379gO?=
 =?us-ascii?Q?pWu93udeHuGbR9EBS92mthmDo/2l2nuUZdjvZsYDE4F0UjAewJnO9ly4AyPA?=
 =?us-ascii?Q?5hByi5zyeGYEX68ieHJ2Mc4vHTUvhpt6hLJnKugdMNfZqGztOzPJz7ISRw73?=
 =?us-ascii?Q?cp43RA6lqIO5M1ask8gWMlZjcfBiJqUjcaPiw0iZe8ZdiehGwcidn2jClGnE?=
 =?us-ascii?Q?dsi/Ypti0b3IGE4zHg0Bg9QTVyxAcuC89VYgiyOYZ1yo+TTkSAfRlR1CRU8f?=
 =?us-ascii?Q?0dsevQ6ediVyP1bslVhhrsFiUhY16ES9ICXqLHq7RVOqrnLuncc3IpGlLwzv?=
 =?us-ascii?Q?qF4lvAA5MprCfI29ccK+u02WBjZuW2aav/EDmYFtnvo15kjdzgh8Ga0iFOTF?=
 =?us-ascii?Q?9wr86KkdQPybtJBAkZBVNghsF3soAA+ktj/iTYD/s5gD5IMxzr6R9FOEtvDg?=
 =?us-ascii?Q?o28XB804cynYcVtot6sH5ZdHrhKpOqdr7ItwCQA02z0r78hUzW+Wa21hANXX?=
 =?us-ascii?Q?YRWknBBSM8XRiwYuw+Sif+A5rLFex9RUHyuJuU2oylzTdK08Wcin3+CFm+PW?=
 =?us-ascii?Q?x+rRJC1n0W0/BLetFW9JiPeCwkr61gD3o/CTquqFKZ/BDCnkQVmQBttbvquM?=
 =?us-ascii?Q?v2HcS7rcIfYT0xWLdWsbbHbMKVDMKl8C/nQZfVYtLWQUL0gw0bpMJXR2J/SN?=
 =?us-ascii?Q?69SuC4LltuQTECOUxwViNO2LADdFtY2VCnY3UCxiR2WZipM4K4IiyhPC77EX?=
 =?us-ascii?Q?PZUnpZRVoaVK2QGjluMB7iDbVBCNENXvZ5rrwRLJgjviNtrJHo7EyPWvsFfP?=
 =?us-ascii?Q?altzyqET19cQ+CAV5LRMQuRMH/l2hU/kAyvKi36/xa57Z4OEJBw2LBi9mq1v?=
 =?us-ascii?Q?7tQydlcv3WdNN0Lvk9lqhQ2l2xchsYZRMVkS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6oBgy3LtxC2ADu5fSlkxfquY0hZy+pNJw/PyDRZKLsSOMlSWcXJYYbN0zhL?=
 =?us-ascii?Q?fY14a3OwOsjIaM/LiCkdrWifGrFaY4rtlpp3iKWpQgQbfAibOnpQ4OTIP55h?=
 =?us-ascii?Q?GJGXu9Gl9oCjOeMwTsI+YfNECkV36Dpbry4PS+mLFhPq29DNEBCnS2Y1j5kl?=
 =?us-ascii?Q?Qzd9AvyeRHz/8PQlxT/YJaf6zF1AeFE9Z5x5guFl4DeQ8hETkt4NeZ1IY02O?=
 =?us-ascii?Q?Gx+72jlO1hCKob4do89R1nRVaoq3r1OH21LTdWu8cJ4LjstEkXsdXB0XsfW5?=
 =?us-ascii?Q?WLgkltH0AJOEKuTf/qgmTQFy+gDVfqyaXJukbRes0LJS0SAx3kqfNebWKb5U?=
 =?us-ascii?Q?w3ZAg+QIVY32Nf8pJdxMLtg9TOcUjFW7hfTsv7s2j2pk5auUI9R7gva1uKtl?=
 =?us-ascii?Q?HfFCL9GxqzKuKSaEvPqlf6RMuhTDid3QOItlde3QTo4oKbuDmdpXVSxDvqGw?=
 =?us-ascii?Q?gdOBHCUGOuk7z6X4boE9Uqu9TGUuQYpkvl3egeKCGRlVWHFBz8975UxCXw5r?=
 =?us-ascii?Q?F+rCsaqvGNUllte4ZpHvTY35sRw1gDpPzHikd4norTc4NtL0vgCbBqvlhSr6?=
 =?us-ascii?Q?ipbB4wIi6FprogDxOQ2sjCv259X/O2riCIvcW6nsXrvbMCcz/Ne0Qki/Q3QP?=
 =?us-ascii?Q?DWNJ1595uZVepgpQWXrZ6UCW6JmGtg4mf6ODPAg4eEySiN2bvgtAdZok+Da/?=
 =?us-ascii?Q?sZBg1S5PfG24NzLLFl0d/LeNIqvBJIR+autOu3SSopcIwpRhVs9HRvqMEX4O?=
 =?us-ascii?Q?xMBUYH+dgkkQIPP0oJtZUftS2cia0NYap4oZi95t+wOvEmecScEdlfx3IhYf?=
 =?us-ascii?Q?0Sa+zH8VnTGJu06mpWu7lJGXiHPSSsochgVUAXGWcKmqSMplUPeSeSKNdze6?=
 =?us-ascii?Q?BESzls4oODy3G5m3kIpJ2lDP1EVAbDZMpF1wkB/V8RQXVuUnhW54YUWuGqdp?=
 =?us-ascii?Q?rzpYFD+b7o6Ykf9zHJ2wmjELaa46frZsl5t4mDM9yVOr9r7RD17QolorEuUw?=
 =?us-ascii?Q?QAtRK3PHIqMXyoSJh3uIZRsTJgGpuJIctLDQCtMY0XJM+Bu71WijX+DNP30Z?=
 =?us-ascii?Q?7AP8+bvQ5QU71Y9Qi6Xa6zYBAgDZq9cXSd+haTss59UMaXaz/1R5fRN6ohbk?=
 =?us-ascii?Q?ybUUplwXLCSqGgMECynbZdJek0N4UbRE1MvdF8fEm10N2ddm6ZoQZMZdXQyO?=
 =?us-ascii?Q?/dLbc2CFRSbCnbJ/EChEL+9ei0rvZ3BOQxoxH1G5UzZQL+ScHC+qv/yBbfFH?=
 =?us-ascii?Q?DPto3p68eUIBLRua9jIyZkrUHcYKKfCYrcbEXu0zOkCSmd84AHeUPFgoVNSi?=
 =?us-ascii?Q?otEyw90pgXhQcL9uoachK6FB1+ND2DdEctNqXLrmPrQnm1IuD9PaHec+q4WN?=
 =?us-ascii?Q?kyKfVbsqvtTUbIGgN1tlguaYue1udAhWCMC6royrGFpnRmW3fem4OYG9jxYU?=
 =?us-ascii?Q?QQi2BOi47ZxsxERYKRaa/kKYzl6iZiHegOdkq/JpkMIdzfX3tNWsmvVl0YV3?=
 =?us-ascii?Q?mGaRjOthZRpyYOUmNOpu3freVV5NzZTDXYoJVjuUuCQjI3S0P9fsCiR0+4C5?=
 =?us-ascii?Q?ocYHeMF3/GItWaGyZFJqYVae0PONy3x+rbNjn1xw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0c7cd2-07ae-493c-bd78-08de266ec887
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 06:50:39.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THMthH6XncSbMvWmuuHNibUdjl3XhS4Y9pRxmBlUgW/NhatxBV39J8VnxQNRHQ1ZWA6qKR42TXgkgsdT9f+9pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9843

Enable 16/32 bits per word support for spi-imx target PIO mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
In SPI target mode, we write/read 32 bits word in 32 bits width TXFIFO and
RXFIFO. 32 bits point is used to get the logic value from memory. CPU only
handle the logic value with FIFO, logic value is the same with value in
FIFO. However, in different CPU endian, the logic value is different.

For example from TX:
SPI tx_buff bytes order in memory:
addr0 addr1 addr2 addr3
0x11  0x22  0x33  0x44

For little endian CPU:
Get a logic value by u32 point: 0x44332211, CPU send logic value to bus
following little endian, the bytes flow in AXI bus:
0x11 0x22 0x33 0x44
but when write 32 bits word to FIFO, all bytes are grouped to one 32
bits word following the little endian to 0x44332211.

so 0x44332211 is writed to TXFIFO:
bit31~24 bit23~16 bit15~bit8 bit7~bit0
0x44     0x33     0x22       0x11

For big endian CPU:
Get a logic value by u32 point: 0x11223344, CPU send logic value to bus
following big endian, the bytes flow in AXI bus:
0x11 0x22 0x33 0x44
but when write 32 bits word to FIFO, all bytes are grouped to one 32
bits word following the big endian to 0x11223344.

so 0x11223344 is writen to TXFIFO:
bit31~24 bit23~16 bit15~bit8 bit7~bit0
0x11     0x22     0x33       0x44

Because SPI spec is not ruled for bytes order, so SPI should keep bytes
order following the CPU endian.
The bytes order in memory is the same with logic value in big endian.
So don't need to handle data for big endian CPU.
But for little endian SOC, there is some diferences:
1. When bits per word = 8:
every word is byte, so bytes order should always keep the same with memory,
u32 word is 0x44332211, but CPU should send logic value 0x11223344.
So we should swap every bytes for the u32 word 0x44332211.
2. When bits per word = 16:
every word is two bytes, so every half word should be little endian:
u32 word is 0x44332211, but CPU should send logic value 0x22114433
so we should swap every half word for the u32 word 0x44332211.
3. When bits per word = 32:
every word is 4 bytes, so every 4 bytes word should be little endian:
u32 word is 0x44332211 CPU should send logic value 0x44332211,
so don't need to do any bytes swap for this word.
---
 drivers/spi/spi-imx.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 1dd20e9d9605..b8b79bb7fec3 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -425,8 +425,15 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 
 static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
 {
-	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
+	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
+#ifdef __LITTLE_ENDIAN
+	unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
 
+	if (bytes_per_word == 1)
+		swab32s(&val);
+	else if (bytes_per_word == 2)
+		swahw32s(&val);
+#endif
 	if (spi_imx->rx_buf) {
 		int n_bytes = spi_imx->target_burst % sizeof(val);
 
@@ -447,6 +454,9 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
 {
 	u32 val = 0;
 	int n_bytes = spi_imx->count % sizeof(val);
+#ifdef __LITTLE_ENDIAN
+	unsigned int bytes_per_word;
+#endif
 
 	if (!n_bytes)
 		n_bytes = sizeof(val);
@@ -459,7 +469,14 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
 
 	spi_imx->count -= n_bytes;
 
-	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
+#ifdef __LITTLE_ENDIAN
+	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+	if (bytes_per_word == 1)
+		swab32s(&val);
+	else if (bytes_per_word == 2)
+		swahw32s(&val);
+#endif
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
 }
 
 /* MX51 eCSPI */
-- 
2.34.1


