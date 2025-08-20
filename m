Return-Path: <linux-spi+bounces-9549-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8383BB2DC9F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C13B4A52
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B1B311C1B;
	Wed, 20 Aug 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="lTaDHhTm"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020141.outbound.protection.outlook.com [52.101.84.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4412311978;
	Wed, 20 Aug 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693211; cv=fail; b=MKbcvRxmROyfPh2X0YTX/N16VNTo/6s3PwKwoYWA6LFaTChZxDn6x3R5foEnF88RsagBZNDNLB+O7MbH35kn2slpjylobHLNrWfP/pMRNbOyZcENld37X3ObGilsrWN4DsbSqUKLqz2hJWLaEjsTGoqb/lpYlX0lANkjczUWSVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693211; c=relaxed/simple;
	bh=RMnrJhmapH6U33gutOs7LqvtORnoZ68TWttb+OE5YXo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BjslNuepKfa0Dh+CD15mCxU+V7BXQzfYc+ifdzssK35rkphhAhzRVZKyDBt7+AEUbQOU59w3N4qAYy8OStxM9fHF2bnuLARxlTqo307N8S8VFgnj6gcWO6U92sH/5t2SAKDIBI0vlbv4QQD5R6bAYk1DOrVmT6zVSSTT5Pt6e6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=lTaDHhTm; arc=fail smtp.client-ip=52.101.84.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ragFa20+PyChxwveqs93h78ob3kyDKWpK2JCwxVPiz7rPI++HsfRVDEKYDVxO3cHkKsUmE3tiledhGzvH6/7chjHsoUEdBvGSp5HXG+145dbKEfyP+T0WurliMuYFQ5kfOIqsvVyKa27idbpZ8zg3MPu9DXKuBZ2v5m2CRZ3c7EGfd7ckLneWyo2ruKckVA5z3bdQkBuXCHvStaA06UaJ7KYBQx8lp+0jd9vXWbon0uwwmH6STwh0kT9ZeKvOWnSCu+l01oW2RKOi59mcoaFidoeP3K3US/o5xZpApLhlOSCOqz7WbrQkrBEAF3xjYjKSBP8ILrd8s7VC4rIYvT9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSZ/LjC5768hUMr9zDVcroq0xoo8FigV4LjbdGj4gYo=;
 b=fk3/j5IsoM2RZsVpFQ8MtDrmTOAtlQz/FH2mQ2nSUK03x6qJ6hCsTZFt0nCRif8tQTjaNm6BI96mxeHtpVgxXTQHJdnkQar05FBkuSiwh6exBYmB68N2mmH+bnIlQOidrNH7aNrF/QZZI+PrPU4DcjfI8rUwJrX1dc9/jXaNDCUVKfIj6h7qQL4Zs5zw/ArHWkN1vcg2Wm1w4CFBRx75yppB4o8OCN+cv6N4d6Oeg4qmUpuuzyKXfc7UtN0Vk1d5oQqt0gAc46b/pNE2rbsOnIr5rjUacFvyW/Oz2KwbbF3bbFPRI32VSRH/axg3MNbN+4sLTkaEBcGSeXpIYbX6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSZ/LjC5768hUMr9zDVcroq0xoo8FigV4LjbdGj4gYo=;
 b=lTaDHhTm9fm96RHOeR/7CbbF5xOJuOiay+HJVh3dMa1KpoteaIyxvsGRyvfRgFa4QRwWoLz/7mz/nlC/ifhpwBoCWGuCkhHQ1oQZNoZ23bwdUrIBx+nkBOvzHpeGd91gcLf/D2nwlu8SLSkUpYennO7h7LqhZYVEOrLBg5Lm4VNQ/x6N2C7RpG9tMdr2iDY4uPpyNg6NWEW9mJ2WKZOjs/bglXtpFDnkCNzHoF6f0EKB60ykDX9q56kZVB7S6vaXReYpw/pbwf46l+wcrLSI7e6RXXn1/CiCLW9cBh1GgCBJmtCj7j4S3BqlRnyKZUqKvObKMCZqvx+yA+lEREnAeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6355.eurprd08.prod.outlook.com (2603:10a6:20b:363::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
Date: Wed, 20 Aug 2025 15:33:03 +0300
Message-ID: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe6044b-308d-4636-5da0-08dddfe5c162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oVNfiUlm4et+3pM6JqhvresnjqhGtKX8fRw05wM1DGvvShgK3+60ZmInUbAF?=
 =?us-ascii?Q?3LFcYgJABOxlfSIqY4ijfyuK9sd6q4SfHxj41EADsUcCvItEhg4UGrlmUIYX?=
 =?us-ascii?Q?PznkAymHRvrt+0t9eAWQnuNDDIU5Jov2TTZaLb1TmKHs6CI/3Do/uPGRYXBm?=
 =?us-ascii?Q?8wjZwI2TFl4vc5uwBftxH1BUAYeJ+Fn7fOo3OBA7W7rR46815wfrJ8UXSW7K?=
 =?us-ascii?Q?tQSdJhsf3MbhwiRUqMzwXb8XdR496nAnIhsuh5S7hu8RTdwagwiKg2MP9vk6?=
 =?us-ascii?Q?zHNW/oM3aEk4zJdtDUI7wmWCnYf+tqLiV8Gp2qnYehDtiVCd+3uCi0a5MJ5f?=
 =?us-ascii?Q?FlRjEvK/linxdptdmmp1cKUSLzSXtWL5191dOysLKCOc7nYC6umvkPIp880s?=
 =?us-ascii?Q?OL7vuGr11f+JwCjHUAjH5JaFnrYgKdIHihenrN4OSOnhSDWtnPOtCPf8Xfve?=
 =?us-ascii?Q?/vyPx5KQLj2FbPNdyOsZbIgTGO+rAa1A00GLAugob0fAmSjHcbLRcsyb26hV?=
 =?us-ascii?Q?7EgxZd9KOSlRnzDMNRe3u/cUC12Glqg/Z3BpiuxxMWsunjUOKy6cZc3IoBLv?=
 =?us-ascii?Q?AL6Jl9YAjzvozPS9fAdOUmjeB/G/CfjGd4twsxMYduE5enMH63GEpMXW0mbb?=
 =?us-ascii?Q?khnIYP170c0AAq/OqNu97XeYdA0k6yLAQKMqlsWSn8BKkphmqZsze1vO506O?=
 =?us-ascii?Q?QDHsZBIwjYckU4F+5VjJTtaxA2SXInm/8BdQrngp/gtc4pwsqZ9cWPvF8JyT?=
 =?us-ascii?Q?0CXILPKTcfsdzMDBLmQVrd9eF1Yy4H8pYRbJWUoDMmMLTtHGUCpRA8XPyh0y?=
 =?us-ascii?Q?JBJk0kJUdEYJnzq8w6N8Mx6q2mAmot/xWkw87+waxd8T7wO2azskGzHR92bB?=
 =?us-ascii?Q?/RQ9rzSg4XmIMubIXr9I1rOY7GretgDmmtskVPQh+LKFqfzuYKHeZeaKp5Pm?=
 =?us-ascii?Q?qMRAmWtpcGCrRKvplvtISfGf3xw4VXB2sGn0MUDbXW+0S+mXKjgPvzOfI329?=
 =?us-ascii?Q?AHOsUnrL6ryeh5OINV4mIVlVa2dOYC3cXDEb0opxcyceWlS5h9+ziqHDgR7T?=
 =?us-ascii?Q?0lTg0gyvZQpTU3f0hw6ImqHphlFDqLNau8A3r/pfHOn2IVozrPnCDuWJp3Be?=
 =?us-ascii?Q?slszibfAk3eStLrzsOWqEhfZ31sn4tmBNJcS0YeU+EAXiMnly1CsHOekilIX?=
 =?us-ascii?Q?5jEgtJJucQOqABwX8gZJ7GoyTq0wbIBsToTUH6qo0c3px0UGjqZ+qx2COnaF?=
 =?us-ascii?Q?eM1zliZK/KqhzsXqmobv/fUXaRohY0HsLVAiHVSb6s/p9pD9p36oLBpgqWwX?=
 =?us-ascii?Q?P2c2MHqjTEXpDqOJHCcFRWQ8H3ZFpw9YSTfxGXuVbszUWuP1etNAlY7h3/gJ?=
 =?us-ascii?Q?F0Uk0u1wDSZEisFuTfLTTOWVuLI0zVyb2QXsfacFl/H0h4R3/rm9iGml/0eR?=
 =?us-ascii?Q?QZiFITjidQFp5g9h1QkBl6mQcXkmwm6bFI6v/xeRycpETxJisNY9Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1fuWvi3WtAZavRtqt3nAAt6OOjGtaoP97DTL2a7gXrJ6vdLiCss30rCPhdG?=
 =?us-ascii?Q?64PQlPFtoOu4Su68jenGO4YwhKjCHPUl7dVL8LV09Kr8q7i/ZaEHRqRa9Fy/?=
 =?us-ascii?Q?pkDwM/1YQwexnMlpnOg4nELEEyGe+8bIUP7xk7xhmFwcperKfZ2cM/n1RNjJ?=
 =?us-ascii?Q?ku/M0A3mNLuz7aO9GTVV24GYs/8fky+3O8iHe94TuQ7rydubmdn72IavmJP8?=
 =?us-ascii?Q?XvaXFxkvFZf36azDp3xlirsjiYgqqBQ7+PdsXFYWDPmkBn/CDucxJBBP0Iyg?=
 =?us-ascii?Q?kU+FJsQS3x7fzzT8LkppiRj8vJQzEDahHH0ZOFTd+evFEkcahG5mef0IYkya?=
 =?us-ascii?Q?Fh7yhs6pQy+DjAwby92ww9uKc9D4MxfOYwYCy6awnYYKhIVNXsPPwVvwMUKM?=
 =?us-ascii?Q?D5iUglUxeBbDnoWgiAIswOSKQQGSJ/dAViO/1OUm4P1h7NI8YX+Qh3geOq83?=
 =?us-ascii?Q?7X7hYOdy0OWsVHyYdzEbg3AXm+A11dpTyzxPXvs88dk0ozRQ78d6C1zpi0rj?=
 =?us-ascii?Q?wLO44dF4HM3ft3uRvgN36uSwGeNMGpWj63mtQvOD+dAaFmgbNHZFjyWvca54?=
 =?us-ascii?Q?urAFAhozNzVdb25a2gPRXhg8kw9OpdVvDrzrIMgSS0JAMfZme0NPwd86iWHX?=
 =?us-ascii?Q?c2+ECwG0oE4Psi3KB3HLR9wp++UEO1QpZK6xbuTfZ+JXFptjLoEHCZ62jVXt?=
 =?us-ascii?Q?5iX40ANtMKc4u1/OGpx9S8LJ/idZ8MO887v+73gUxv7YHCttuBeq1wRWwPLT?=
 =?us-ascii?Q?Jhr7Q+7uUBjwyx1fplCHerF6CmDJa3IP7fI0TLCBbujSZcvYRK8oq97JlfOe?=
 =?us-ascii?Q?KhKxN8nohUG8QDaI/Xq6Q8umxGqmcOiha+XwIf3qqytJSePKJvUS1Sy97DL2?=
 =?us-ascii?Q?guSWLb+3RH5o1ktm38/dUjApeem7M4me3iM7nQxB+lfP/y2X2lhSN1/mZpyV?=
 =?us-ascii?Q?Ms0qUEcVg28aBqWe1vBhTMIxyRn6CzeCXlv8a7V2zaePaq/BjZvG6KiFThCf?=
 =?us-ascii?Q?DLn+HKpS7hs2t5VWZD+ql4dro7nWmW426ZmqozAjDgf1R+v9qcg+GHA6y7QP?=
 =?us-ascii?Q?6LMOQ9aKzyht4bF57O4TAMHy3TLZuTCJAFF5F5CNk6n2M/tl6HJw5KYKcpzB?=
 =?us-ascii?Q?Pu+Jx9xWA/YIoqJ/g77GTmVB1hIRP6xZX8qYsJX1emILYVQoR1AxFIc71+mk?=
 =?us-ascii?Q?AHnOv4kM4cvypHoMMopprvphIecsEarRt8xaHSPf0UmbQerkWLdEK3AyHPTQ?=
 =?us-ascii?Q?zELHI+sTdaWdHu9qO7imFsCW2P+uydomKJ91JZBKQ61ZjPU4GujcILwC80gH?=
 =?us-ascii?Q?CFap/w3pfVZPqg0l5t/q0yU/qF6PmoRdMnlSzccaivrrQV4QaKlyW7m2uh2z?=
 =?us-ascii?Q?biHrMjWNOnEyOWDhvCnH+g16vq8lIgHIQhfShy8zcxzOUQ+xsN/y9o0kYVem?=
 =?us-ascii?Q?Jj4a+PWfI2bB5IWUy2YXAATOsM1UmbEU7JjoWWQ1lIN/+mPhynLvnijRWSgG?=
 =?us-ascii?Q?9Mzlrr33QBonD+OZRIk78GxwVEz6/TX7mReDQXWxPu4QnUVlbmcfj28n878m?=
 =?us-ascii?Q?uOOr7xgn8oKAFlyBFRIGIzGxJC/EbC+guqNVzrutdDfKAWQ0GF5HPHNRqF6H?=
 =?us-ascii?Q?5awIsdnTmbXpfv81ZUsDgUs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe6044b-308d-4636-5da0-08dddfe5c162
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:24.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lUoIBjlD4H+rVpP/cWJsFsQhOH5C3RPwGMqNIg5va0VCXKTFrayBIwbTqRpbBpcJAEm2FDjnShDf/YSpgGN/N5AW03wXNbM9C2EPItnkeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6355

This patch series greatly improve airoha snfi driver and fix a
number of serious bug.

Fixed bugs:
 * Fix reading/writing of flashes with more than one plane per lun
 * Fix inability to read/write oob area
 * Fill the buffer with 0xff before writing
 * Fix reading of flashes supporting continuous reading mode
 * Fix error paths

Improvements:
 * Add support of dual/quad wires spi modes in exec_op().
 * Support of dualio/quadio flash reading commands
 * Remove dirty hack that reads flash page settings from SNFI registers
   during driver startup

Unfortunately I am unable to test the driver with linux at the moment,
so only the following testing was done:
 * Driver compiles without error.
 * All changes were tested with corresponding u-boot driver. U-Boot
   SpiNAND driver was modified as well to match linux-6.17-rc2 with
   additional fixes for continuous mode.

Changes v2:
 * minor fix
 * add comments to code

Changes v3:
 * add patch to prevent continuous reading

Mikhail Kshevetskiy (14):
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: remove unnecessary restriction length
  spi: airoha: add support of dual/quad wires spi modes
  spi: airoha: remove unnecessary switch to non-dma mode
  spi: airoha: unify dirmap read/write code
  spi: airoha: switch back to non-dma mode in the case of error
  spi: airoha: fix reading/writing of flashes with more than one plane
    per lun
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: allow reading/writing of oob area
  spi: airoha: buffer must be 0xff-ed before writing
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid reading flash page settings from SNFI registers
    during driver startup

 drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
 1 file changed, 260 insertions(+), 248 deletions(-)

-- 
2.50.1


