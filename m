Return-Path: <linux-spi+bounces-10589-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E7BD0242
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A2114E94FF
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D72561AA;
	Sun, 12 Oct 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="rC1In+ra"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023096.outbound.protection.outlook.com [52.101.72.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1227A919;
	Sun, 12 Oct 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271469; cv=fail; b=ZjyiJr5q8baQDd0GBKPKF0pVaqVkJySeeQhFfMZiLRH5C4mDxHk1FdN8EA4fxTR3x7EKKfYykKQDyUv083lBM+V3OSmL2yCQjIO5qUkqI2jhESEYTmQTKmBMrfWrnxkgIFjq0Gfubx4+DGqDTEphGIBE56cvw+T8FwkZFAHs0Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271469; c=relaxed/simple;
	bh=SIrwQsj5DNcb1bSDBn1B1Ozjs/tTqcuM7XO1rq6r+2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nic6O2p/qnBzG90zGoG8/KX6G891QtAkQAWuniI9gI6KaAN5fXaKNa6GtqAyYMqjberhedUUfO22FBvtRkVkTur6f0U0dKmZ80J9j4L7HvOhcKJx5TMbVks8NdAaZMbMM/V/JXMAUTz8Rf+/oXgatUE8p2uAEa7e2cD3r6S20Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=rC1In+ra; arc=fail smtp.client-ip=52.101.72.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Glrnf8n6D/OV8fWA+ByvHsQeYrtfAdLoGRJSdOGi0/oRump6s2v/XR0IoiwKeezSwNDSJEfMY6SmoeA3BZneeC6Y+yvgbcREsL8BWoNW0ubyfMbuIjO+zNKQFrS1zDD1iSwSjV/jGYMz2t6YEsL02E8xa8QN3+8BcfTYh8vGz+yRM6JLABY7Q9tCoafSzkwoTmkCz9hhLaM8TZv/zEnkodcGk+WjZC1/D5W+Zjh6pKJGov5BEjqkMfFoc9ueo3zFDep3HkOBC2a+7ZyBuNfOAzIZSZoMq4HrYiFO8zaXOMX/BurN5Pn/YVfWVK+n4rgwsR+Hdrq8BX/xF1Tpu55GrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ACFEDXCqWsjssDon/bjZqDbkhHS29S6qhRh8npBda0=;
 b=LnkwlT03x6LegwFoC+u1MfUE3y4KrQrnw+umBPGwbRun4nIs1gbSZJS+lIOC3FI0R0CNAAUYVk46SYrkU3Z7yMlTqbAlC0R8m5ttsQZhsUk51eb9oe/ab8MZlVslL9fLR5WVg8rgiBQ+KIqwkgj7aSTwegvbxdqA3MYKZn1Q/fXiZq/Nr97yD2ZXn86Cr0qi10aLib2Eucp1NdNLhqBKutGQMwkTPa4y/G52nqMg64l0fXj89ifDGDABRV51QmMYUimWzYeG92uI1hOBEpdG57i+q8Sgl7lYKjZAfQ9FKbgaDviTFkfpfEp9q+ZPkz3CC3a1+LM0CKlSl12whsc1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ACFEDXCqWsjssDon/bjZqDbkhHS29S6qhRh8npBda0=;
 b=rC1In+ra3OeJQCk+gXSUyUCc46V43yqNIy2vrblgsdIkZ4V3Kb8ribs1HPo8BjFNcF1QBRE5yM+XCS9CllDuoA7dngIPMl+WO6mhqv0E+O09HjpKZDbTAMU7v2WvNqDKPD0STg265aE8yurvRAK/R1WhJco3wLfiOrG9oJt/NJBFOi7RnrzwTrnNNLiSLTc6vRV2gIhUdy4uIDTxPkGClxeBhMN/dFWEuBnCw5IZ8lF7WVtuwRdigdEjhLXnH51YiAJUfhaNxal+xw9LsEvmtq6q3IbJjXGKbFRoED5wOompRptbyJkwOmIxIl7KMHbhJMszkOQkWAWIFV+k4V6Hig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:41 +0000
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
Subject: [PATCH v10 14/16] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
Date: Sun, 12 Oct 2025 15:17:05 +0300
Message-ID: <20251012121707.2296160-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 279bcb5a-f447-49a8-0a82-08de09895715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J0fr9a0ulbO3QrZ7gqQGBSjCtT7sSDeWW7k5YZo2FG7/uRl17E6H7PMHLx/+?=
 =?us-ascii?Q?bimlrprAwg9jzBSvA2WfuZm9zTNkmtP4a60K2Ai2gN7J7u2vn8OFh2Rwores?=
 =?us-ascii?Q?bj808GdD2BsPHnqBkIUr0vFEXZjN/EmD8lZOv6nZxJjjHhy3pn0pi1kDk0sB?=
 =?us-ascii?Q?ae1BO/p0tkj8oG50op5HENf2nttL39Q1sxvI6aYyBYd3AgN0WhlPHCfxxu6T?=
 =?us-ascii?Q?7v1GklXPPU/h+6Q8RmxXCQSAmqLTSpi1M+eYRFzflJlKcgYSf8DCmpmg3/fv?=
 =?us-ascii?Q?6V2too4NCOJfN61z0oRRNkz2XSF+620bxwdhvXmk8EM0mlf3rPX6k+K0xfwQ?=
 =?us-ascii?Q?TJNH3kkLsY1O2bHQEZkIZ0WtPT0Jxsy4O3Rs8UKTr6FDQS/0d59cUM68IIgr?=
 =?us-ascii?Q?lzBbx5IiugCi/Jc/4LcTdwSNTeFxvyHVYS2lRfb/M8khih2XLSrlymMDQXN4?=
 =?us-ascii?Q?HNoTsdScyDFA0DlO6iB8Labta8qjgrIdsdYKGZde44NxvGyWYCvfGGLxZtMh?=
 =?us-ascii?Q?F3+TWJhcdrG6H0Y51EZ4+Q6gtkOEev+HJSYw4QSzmNQPi/SUmVkhZvBo42t6?=
 =?us-ascii?Q?YXqO1T62P7AC7NMnBjMidbpLAbncTXWtrAtpoSKPQ1KG76YZCnD6EKMpYpRl?=
 =?us-ascii?Q?lQD+5/bFuEWS34d84S95/qdAM/X5SRaX7l9Zs1x8jRM5snr3FnZ6O/5eoZPU?=
 =?us-ascii?Q?/0ojiNSMU7OqINl36M+TDOAvTLOtN3QbdYMqQpjagsZBFAJYum4P/zNr8vbx?=
 =?us-ascii?Q?p9ERI6eQ+xdN3MC6BkTqvlX8psdBAXNHZWZb5/oasMkwRApZB1WDTq8eMiJd?=
 =?us-ascii?Q?UvpW1MLDOCNQl8WwaZBrRue+sgiXs/3bGA1LY6vuAhyhbbO82Snvu4WNqASx?=
 =?us-ascii?Q?YphtXolOAh2N3zLs0WNFa6wvlys/Ye7Gv1OG8q7HHEe6/cgVnUa5FO5mNgrr?=
 =?us-ascii?Q?DlAgc9ZdtwqcMPsRXl5jOQINI5MomN9ggP388qdVKYoYpiabKkAJ7bvYeat7?=
 =?us-ascii?Q?6fGIqjPMDeR2h0QMR+/E0M2mkKY9GzcvYGvgMdhN3ioxYFMKHKPnoXqZqbx8?=
 =?us-ascii?Q?hXDcxWbemog+z0n0StHjP7r+jOLY1H+zKmvr69IBJv46ICFzXm5vpTRDtjXz?=
 =?us-ascii?Q?PCHrYIrB0U/HRCve/mbbHBiBiXZ9sSgkF+kcgFvFXWVnTMAeZZ/CX3YKpmpI?=
 =?us-ascii?Q?GFA+5ebmP4rFKBuYdexg7VHXXgIVMaQRujeOz82e8sXiuBSJKCXxzMtpkuNW?=
 =?us-ascii?Q?VpFstc9Q6Y1l7nVCb/L+qGgYsKKWeh/S6bRcTcOigZvt+feOCegKUsabSncf?=
 =?us-ascii?Q?6oi1r5w00NbeELZIFG66q55uwSmMk1uK1kdqtii6I95EiLM6okkAohWi9uHN?=
 =?us-ascii?Q?WHusbmSFi1QeLCZ9g9yeD4VxPOmErBAD38tffBME9rS4IMzbmY5291Iu73yw?=
 =?us-ascii?Q?KOn+cXWzrKe9RRnRs4BuAer9XS0pf4cfBu1wAXVc46NdIza2awu5zzghOsEq?=
 =?us-ascii?Q?IiCFBGm2Esc6DM2MWHvnrqLn7Q3rqxShamrFQ7qEzGdzY1olxhxD4cYbjQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nSj+CD/5TucgQEnTF/155FMnwRAD8Gn9My1lEqUi0RRIa5VjPzvvQMjcvCB?=
 =?us-ascii?Q?yMKp8AwUvP7EuAmgBV9+ROPCDa0b7XhR+TByo6a2hyxUsfk8GDSLQKwzdocM?=
 =?us-ascii?Q?RmP0j5Gb3Unvm4JL7YbUVh4tmPavkqaVi/asCqOUdBGvr8Fq/XkadSGkU/eI?=
 =?us-ascii?Q?L8eMFg6Ch8shbVeOEGQt3ahmm7nOpL8qPboyysnyC2gpR/QJPng9toE609eC?=
 =?us-ascii?Q?Dk6QXFwHBtpO6yhsSIU8nfmJX62YpEI6peMf4hbzbIyBhyyMXybfc1H8VKrF?=
 =?us-ascii?Q?pRv39jDWJATtmAQ8ny2m9rj66z5nNYSn3HfHcWHAPW8BEeT6GoMHkIsvukRc?=
 =?us-ascii?Q?JhKgoeb9aAkmkVrIkG9CODZB0QQ+YUhL5FSjopFbJM0qLB4jlyIFBqilMFBi?=
 =?us-ascii?Q?ntSe0rJrdBgH5eNub1K8oNoM9lv+3//WkgsJFhKPSg5280ixID2mkSdYoe6C?=
 =?us-ascii?Q?LZUwk7Z+rw0ioJTMnnaDOa0dg4k3pIQWEmwWWvywT/93ADEI+w0NS49e7n6Y?=
 =?us-ascii?Q?0Gq//y71cLWe7ymOtt31w5e1qQAHpLu4rw8zch+WxyKt0m3ZfCefSY2GS4hW?=
 =?us-ascii?Q?69+ilvoTwxCwomU3blwEVIOGYoR55QIJdzgWMG4GLpSM28rGtDNy5TQ6MLsb?=
 =?us-ascii?Q?aEXjec0SDYE/5yKHekE294mTuyrDPzno58Ic4hxN+9lWZIOK0X156v0EPbve?=
 =?us-ascii?Q?NR+QPIYpXN93LnkK8+t4xocUiCaFIbG4I2XhiJNQm6iHVMwJoPV14PoUUuRC?=
 =?us-ascii?Q?WMftqmJO2kKhQMTM7Qv61iz8qojchqAScRFV6vAtQNxD3zEpgp4J02K3jGNH?=
 =?us-ascii?Q?AqirCgUffdujiqpasazYzDCFmqrKkw0qPULdjfUypVQ55lgtf/dsKntDuaKJ?=
 =?us-ascii?Q?FUM85wpwEIG+88gxp/WhgsC6xVC1W1ctPf7Z9yfnqGwVsZXirLqwzDOiZDb1?=
 =?us-ascii?Q?m/nqHdRX4bPhbENa3k/BGRP2RNZDkHLDO2VGK6Va9MP3LzDRbPQD8ZugsTEc?=
 =?us-ascii?Q?+f5aqM2njG4uke0xZiAvBkNQxv39h8dMwJG7X6jZYWcqNQcjIJql7b0OrzX1?=
 =?us-ascii?Q?cdMksbhtjUWmNSZ14/O0IT+ztaL3hyr5ojK1CaMVcl8fI1R36cy5ZI8QEnM/?=
 =?us-ascii?Q?iedpGu3dX9LehThHlTbXiWQfSAKrNvinTIlZaV3HPIC6hQfMjpeiynmvnurr?=
 =?us-ascii?Q?mmOjtkihaHtLvAddBPZPK6QrdfuUfZL6YmGPQIJDh1oE6UQqRv3nvZZu/mA2?=
 =?us-ascii?Q?Hppg5zHDdQBwRsCC69fnmQ5akYky7HACQKaGsrasnQ7y6EdZ1fn+QY1iWHgB?=
 =?us-ascii?Q?jnVHdLGjFPpXvRKpz76ZRazoGQMJZp2zLHBK7GCtM9Z/M3/oF1RE0PQqkLXD?=
 =?us-ascii?Q?WT85L0dbkYuQLDQ7Dn85xCBll5q/hT5fR8aRaREXpAYiH6ht5Fx99TtVqZPj?=
 =?us-ascii?Q?WDQYB/4k9We/aIzBU3tFGJqd/Eu8RjHSZOPKjQw6Q3EYAhYh7qyv8j/AMQ6e?=
 =?us-ascii?Q?08nqqVRvA2HVYn7dSDyn11NyujvEzS1x0XbQVFkz+QKglUzVsBqKZAudLazk?=
 =?us-ascii?Q?WrutbgzRCfCK9CfGQO7OLaA8GQ8XGQBdZlXMgcpTpSCPo6UGCrkFLr1GxO95?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 279bcb5a-f447-49a8-0a82-08de09895715
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:41.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f47K6qcOZc4EzKnPqc6nszE2a1f2rlJqjqwI6oB6zaZhwpT+0WeYVPWzkz9d777wtn9y/4IyJX+03WaM496N3Ux3zEKjQY5geYhN20pg6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are NOT affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. Usage of UBI make things even
worse. Any attempt to access UBI leads to ubi damaging. As result OS loading
becomes impossible.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 40 ++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..0e84a9addfa5 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1013,6 +1013,11 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.dirmap_write = airoha_snand_dirmap_write,
 };
 
+static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1058,7 +1063,8 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
 	void __iomem *base;
-	int err;
+	int err, dma_enabled;
+	u32 sfc_strap;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*as_ctrl));
 	if (!ctrl)
@@ -1092,12 +1098,36 @@ static int airoha_snand_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
 				     "unable to get spi clk\n");
 
-	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
-	if (err)
-		return err;
+	dma_enabled = 1;
+	if (device_is_compatible(dev, "airoha,en7523-snand")) {
+		err = regmap_read(as_ctrl->regmap_ctrl,
+				  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (err)
+			return err;
+
+		if (!(sfc_strap & 0x04)) {
+			dma_enabled = 0;
+			printk(KERN_WARNING "\n"
+				"=== WARNING ======================================================\n"
+				"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
+				"This mode is known for incorrect DMA reading of some flashes.\n"
+				"Usage of DMA for flash operations will be disabled to prevent data\n"
+				"damage. Unplug your serial console and power cycle the board\n"
+				"to boot with full performance.\n"
+				"==================================================================\n\n");
+		}
+	}
+
+	if (dma_enabled) {
+		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
+		if (err)
+			return err;
+	}
 
 	ctrl->num_chipselect = 2;
-	ctrl->mem_ops = &airoha_snand_mem_ops;
+	ctrl->mem_ops = dma_enabled ?
+				&airoha_snand_mem_ops :
+				&airoha_snand_nodma_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-- 
2.51.0


