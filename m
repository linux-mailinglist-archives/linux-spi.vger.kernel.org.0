Return-Path: <linux-spi+bounces-10371-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2557BAB02A
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5956D1923FCB
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E617223E23C;
	Tue, 30 Sep 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="H10RMzHX"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1820253B66;
	Tue, 30 Sep 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199251; cv=fail; b=BSLqxx1r91UF1CRg7nge5X86y2jGFauDCxFuEE6utaN+vNrPkFaNS/adHQy46b+69SUDc+o5vWCCob3wy/RqtB7Su0xbRz+8TsIo+Pz4KK/WLzq60DD+FbyJMGdbK6R9KkUhajHlWBOGmFJh0FuLutr2+ELaLOnw7NkBQqkEY1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199251; c=relaxed/simple;
	bh=TW0r7ZDi5Kpc0NOqesGU8kDdpINxRHGh/ajmzO2PuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IpbC9Gx4k4iERXnWRg0iqQo83AIXFFasftXBCToQEK7qBGab1pDcOhvgKwHkj6F7vA8ntNk+m32wUaS/Jm57vYiTYCqVdywlTdw6fpQIUGrGnk6adSRketnBPbQCfNMJaV+CuMlRFHTozpLokzvfnJFD9IEUqGIE3wseU7Ecq8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=H10RMzHX; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaruIAHL/8FBad65SkkxsBFy0aFsJJltQ+EeL8wYLAUegXYyIH5PbQaR9TQZ4dYB4iCdMsyLyvcVAHYbvulIf1Or+3z1eN9CrM88xv/8Nk9LVpqa0vrZ4TQiUh1MkOgO/eXzWdQnFgNFFZSP48hGV9niFBzdjQBaYnvEsfKoa1fmjvfldUwl536vJOasUBFW5HdNJJyH8+5pekhAUgslzr3qDDEvuYBem7MLe3vgbsH4sCkm2raBUCWVHyzQlrj+otEIwgu7TUPFLX3K2R59bg/WfmpMjNg+NTlZ4Fn2ZN5cGrP1J3gSwRUdwOKuWU/1vtJ5X/CsusvjKnjct3erBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=NoXhlKkxrTZIV71AdPMFa4piChsONbbLcWRrvM/e5pU7k+WKQbZqu4W8+aDjHoNj9UMA7eLTmxy0Im79wXy1IIkBrDjCN28ABZH9xYIIeT5+d3wz78uqau/RJZsLGI7iC6mdSH/PxKkIq8/qCOeFVw/YpGChuaGAtER4VQDlWqSdFhQF85BSOiNr2g5JnqdVYSy8UD2JkmKghFF2J0HD37F8WrO1715B9Byy9P8DoiMVjwy4uRiPKiWcp+K7mcrYfsmLyZKpYkeNEz0p9g4t5yT9liA4r2H7Vq6QlMRl3kvpc4JUZqZodsN3+RZxZ+r7KGgnm7sPMjTK5jgRd+sQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=H10RMzHXpI+5Mz75BnqZMlYog1Xtep9no3VLhKjCWw9G4W18Qpzm/vwC1QhhK9UurQbNzb2tmDN7erYMdnP2n3RitNf+9hXhEvrXkMrCziB85THbs/HqMUEdGufTIItLPZzwnwvSuQwaGYoibv5RSacLpUcAJAJaC59HIPpVOrKUp+4Wjx+G4ni6croIyoSKbhoDmQvcFOJDBEr3qXi3XaPJ/ZPsVT2GhhHEmvyD2Xg31Tt8dUgHIRSDI3R/RvaSICNt2lHAXFtQoa4vXgyGNPlO3Tt1I/NwK6fEwJtVLSEmL9ltT5F6Gl3ExNC7LAckXySPqmi7VBdCysavNR9NiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:18 +0000
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
Subject: [PATCH RESEND v5 12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Tue, 30 Sep 2025 05:26:57 +0300
Message-ID: <20250930022658.1485767-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 128ca7f6-e9dc-4d7c-3a67-08ddffc8e095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBhc6MKzZuNBAgGjF3OZJQxVR6zTlPB/0MJwDKTBAi7pyTGF3b2+vD2LzLb8?=
 =?us-ascii?Q?Dl3CU5PSOqpGU1fOZ2xN8H3n3TG5tuIyoiMmEa/rIcUILgZg1gZ/a2pmJJXP?=
 =?us-ascii?Q?h4waRTXzhZ6U3VMh3+sHocHX8N8bJlXcEoCpd4lrAbbBSsje3yHqWIB3jE1h?=
 =?us-ascii?Q?1A2D6twpwV5xKS/wkRWEMx6f/relUhAIiFK2cve7bEbIRbOUAUCo0V68PwWV?=
 =?us-ascii?Q?Aacy+HmItj+rBNo8FRNSxEYmySl44Uzs9DpK4Hv21W6+AAHTfgL2RgGdGXXN?=
 =?us-ascii?Q?DgexQMUVO9ONsohEoi8g/Fz5Qnducw6hHjABCMFk5617I89RYygU328poMIG?=
 =?us-ascii?Q?+GhG/XmY7R5g9saAIFrYhyvLt6uC0edy/sGR5Sic8XSH7CtjC8QN+RcQk6h4?=
 =?us-ascii?Q?nbrztdUrJ6CecaQ4OCr6pr2YfSPMrfl1dOjNKlyu8x92imoU0xUAaRN7AaPw?=
 =?us-ascii?Q?2O16at2jKVMLPnn/QsWXykIWrUTZLBRfjid1mOjG5/yG9n0CO5bupM5qUiC/?=
 =?us-ascii?Q?+4SSR8yaB3lueXGZ/RqEaYVAQ2UTgChbHxH00aMeNc6yfnjBum/xKJeHM5hW?=
 =?us-ascii?Q?+Ja89sLo/pvzvamYc6rrEOZBoLAGWJNpnQ2+6MQNAKY44cxHarFj/DWxFqbg?=
 =?us-ascii?Q?UAbhiZfdRE3P/Oi3hlVUrfjZ+P1ATia+bpnZpbTHJi/OTd6Sj2kFb7vfOZ0m?=
 =?us-ascii?Q?ee72ySYvtvHvRObYTHokaNFeL0CldAxC2dtT+BMJmJVPJ5AQV+QGpE97Uw/3?=
 =?us-ascii?Q?ND3olHGAJDTb4fTT10l/MoIkkStc77+WDbKu/+J95x5PhG2mL9Hh/023NN9J?=
 =?us-ascii?Q?RraMuBjzKxPSArSBhVIB/+isdDikUy61CoYddk5fiofNt0uT5/6nHXvQS1Nt?=
 =?us-ascii?Q?pcqJkzgZPmWn/h4kpaAR1eKXBECcCKcrkH8XtX1nFlV2gWiJ6cEchKOE7ETX?=
 =?us-ascii?Q?AatEAFASbWxUorPnXfTymA0uHw/0pGeB0YepfOBuqgfTlp+VOHq3ZiJyHYMc?=
 =?us-ascii?Q?bjc9jjb3P9NO9zGjJqm3NWO1jceQVYmq/ddwPNUqd7Lmg2SH/o3rtJZC1jKj?=
 =?us-ascii?Q?98RHiO1mpjuM8ca25SiI/eHHgG+OrCGnZpCdF0htTCJcuxflgVOLPmsPuqtJ?=
 =?us-ascii?Q?JRg8aWjFBvLUiITwpZjV8RBJ8xf7J549cEA8azbUotlCGJsVl66eGX+fq7Yh?=
 =?us-ascii?Q?M+y+vgMFnmzIG1479uDYmEGiqFR64KTy5d8U2vJc2EYvRXMhGStrJCMy8DIY?=
 =?us-ascii?Q?aYdJCrbmciBg6mmhUf8SK8kkXWVcHiQ69QQ2+dealjvRCMn1QHvG6D9yAVyZ?=
 =?us-ascii?Q?Nz0/nGb6eqi5vlVgKQTlC4TxPYNJ7OiqIh2OJNetMY57BWNUgsMjvCjyIvFQ?=
 =?us-ascii?Q?B+AJUopJ/7UMV4S6pT7TWZKyeypx5MSjZVnlWUAUfSrPmWzB4uMHxKJ+0/fD?=
 =?us-ascii?Q?IhkA3jgd/7yGk2/FcI8kHzXMXGvyixkK/W3F35ngdNw+O8YwzVMp6DL/7tBi?=
 =?us-ascii?Q?qdI8WipeNW56RANJdD2wMwlKORnBZDctL51X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jl2rE6lZvypNMgK7btT4QpjOP5Ty+sp3nnVAYDZ0HeTfLZge5lQ/Q486bWAC?=
 =?us-ascii?Q?2zvkHeb3i4rk0utnJ2sFf0S3h0FbAjL6Doo8szQKCX5WCK19SKPEceloWYVf?=
 =?us-ascii?Q?YQXuhtk563ppR0cmw3JcZDpVoWkjN9QaCV3Ewh7Xocc7qjyBtIzV0+6HSiGE?=
 =?us-ascii?Q?+a72wOC8/yHhktm7shb7MZ4sjEiXsXt4O+C7DLN/0ouVuv4CfBojr1C4sUtn?=
 =?us-ascii?Q?Y0y0dYVeIILOZUT4zjMCQmEWCso5/FG31HN3zDy1dGV/Qo7OhRVD+NDflXBj?=
 =?us-ascii?Q?ohTsMhr/ZwnO6zKs+IgE1v/uUyd66rFYi5JIeMKeK+tVxJ2PTRqvmU5t43Qq?=
 =?us-ascii?Q?OW73stI3iDBWw8JO+4P3t2tifxn6mlRxHxOD/1kaUw9Haq/h7Sg0SW/vd+RD?=
 =?us-ascii?Q?MKnXAs7B0b2UYhayFqsIGuBS/DERKSXhvsRMqMQTLo6tb7CHt6MU4tDksSYr?=
 =?us-ascii?Q?468+62Z6cMT5mr0pELs6DhJHs9VAQgd3NTS9adOrsJdjzl+AuEqnZd99KSZZ?=
 =?us-ascii?Q?NnYheUZTy5B3Cb1mIxsK35gOj3pdkwsVGznWjNhXC0SxJV+nD49MTCFWR+g3?=
 =?us-ascii?Q?d5ZNTXiAUgumhvwMlfo6o7C+hv1LL4juwLrAi1xm68kAoB5axwG2y4bMrVZ3?=
 =?us-ascii?Q?Xgtp1ceNMKi9NY63jtw7MF9J82q1fDxKcL1dLur8y6iC7UK9v+91T2/9WniJ?=
 =?us-ascii?Q?cOFUzBW7H7eSrwVVyLmlQVvMRiWTWqbpfCJSyuiCgab6b+gvqvvmglhKOWZM?=
 =?us-ascii?Q?NEWRTu4vnVdiwMvUn+PMjZMQH4hI84EGHbrZ4mpcWfN+bOMaZqGHYRS4MwQ3?=
 =?us-ascii?Q?msYOkHJiN15QvXRfgO1ArwB4gwxlb1dq6TzaQi88QE0Lxd9aG9dTPoGWW19H?=
 =?us-ascii?Q?B0nTOQM0eIDt/A3SAIpOF71H01bH6rvfEVa7j+krZeraMU23MM5ihIF+lIvn?=
 =?us-ascii?Q?T6ElkC1dChJWkCmU7WnbwkVPJhKm0GcFvpk3pho76/GCRWYHMUl9M/p4Op5x?=
 =?us-ascii?Q?sa1brEPZX6kRO+QBVcHleX/5aFLH2YSQADf+T6K+HtNPF0NYZgLLtM+DKHol?=
 =?us-ascii?Q?G7Wm50a160RHXS0PlJp8CU0xG9lxeYU87Qd0pYdLmE4IRZpXArt044qb/+kQ?=
 =?us-ascii?Q?xvJhmTuPQl9OFmpqhXoynEL6ELJ9/dYQKJ69nVNKnIT4TVkvnWhXanbvEXaq?=
 =?us-ascii?Q?zIbElqPtYS1zQ5ITbU5UNEvCNb5n3wASDV4GiDebv6FkYdUnpvAXi2LQJ1SX?=
 =?us-ascii?Q?ypEci5AdTpdU3eg0QsweYDIW3pSYLQqwZh6ydx1pb/pYkQ/7BMI6jE30dsCh?=
 =?us-ascii?Q?P4mrtGaYTreXj1j/1kPcVb7hEPUXc2wmyMNfT8oGhLtX2bpvKXjB2i2+56mv?=
 =?us-ascii?Q?1llCf1VMyy5BmgdyRuEM2pcvce8g5aQ7dPry61BW31KxVrfrrDKWL6rxC2os?=
 =?us-ascii?Q?XIyw6r295WdfZyqRqaRFBPE9h/4wh7BgaXZo6kY+X3KBJaaw82LpklsSklty?=
 =?us-ascii?Q?rjTYWYDSZeqsYsFlGrV5T5BTDUTbpGWQ22jclDgcKBOsK0cOXlpptd3xtfKJ?=
 =?us-ascii?Q?VgqstmFa3UYj3OW9jA3e0J0WhyQgz/PCVg3ItcJaJu9mE0TOa6hA4pIx1/gk?=
 =?us-ascii?Q?N/ZRW3BFUduuJnzejKrjJuY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 128ca7f6-e9dc-4d7c-3a67-08ddffc8e095
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:18.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpEBKnyy9IlMZ/QDSyfOvPnP/j2OsIzKuUtm0iZfpoIEDASYn+CVrZeAO2sgXD5YxzvkRhn8N3A/m9GxLbJn5f5+exZWFX4gGG5k4xbJ98I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

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
 drivers/spi/spi-airoha-snfi.c | 115 ++--------------------------------
 1 file changed, 5 insertions(+), 110 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index babf7b958dc3..437ab6745b1a 100644
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
@@ -490,55 +483,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_ctrl *as_ctrl)
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
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
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
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
-	return regmap_update_bits(as_ctrl->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -571,26 +515,6 @@ static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
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
@@ -641,7 +565,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -833,7 +758,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -1076,7 +1002,6 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 	.dirmap_create = airoha_snand_dirmap_create,
@@ -1101,36 +1026,6 @@ static int airoha_snand_setup(struct spi_device *spi)
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
@@ -1204,7 +1099,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->setup = airoha_snand_setup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
-	err = airoha_snand_nfi_setup(as_ctrl);
+	err = airoha_snand_nfi_init(as_ctrl);
 	if (err)
 		return err;
 
-- 
2.51.0


