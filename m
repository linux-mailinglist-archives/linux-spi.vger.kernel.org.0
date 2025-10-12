Return-Path: <linux-spi+bounces-10583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C97BD0218
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32DE3BD951
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39121277C88;
	Sun, 12 Oct 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="tNdq5o8V"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569982773FA;
	Sun, 12 Oct 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271461; cv=fail; b=a+J7LCWQJd5WlfQAj4kYOwNkYjKoOfOff4IyZ3lFWWJ77glpnHXs9SGQBPXSQC+C48V6YhY8NOUpSnBiSdLRtSGdFtNJamlBJZGkM0BWsvVMzfMkpWCuJwJupUWySnTyqxQTT7YK88J7mXHmj4AMaM9Auji7FBdupxk4YQf88wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271461; c=relaxed/simple;
	bh=1Z4+3ky3F5ePAz1LwMNxiUe87RYnFEz9pATQjAUyt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nqw9A2eWR2s7geXzMDgRU0iOrwJq0WHTGvSgocezFGgYMeZZIgelmyGUw1No/4Jt9c/ThRdqJ4rGLjcvkjTpItYxlxN6J9BZSxn5HZcKIU7Z9vO1cpbt9M+NOCHzlaydvbzkylDVZ+N/T6Wa35UDTxt9UWOwpcRoWZ4df9Ua9Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=tNdq5o8V; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9P6U0CsZmoSnlf2JbgwZglWvz7qDwiSAnSHu4QTowpQ4EQTsasU3vBilXoEPmX6V7NPdI+lh0zNa6wgYn6bc93lh+HogObzb+dzsSjprRfGMJq6ApZxV0clirBnn0HrkklBl7YxPMHcJJqEGkdB9GXtQQ1xMR0xXXgCa0JXHNxYAYshWJS4O+zUKyR4y14+eUrYp1eRWziTqs2VUeippXQJt+ZbSvDb684dGvSpwty7S5TSZa4bkeRPu594zLSMzU8Drr9UyhYOYOS1lsb0MXnGeOIifAnpeWB08Zx0SM8lzIrzo0sTUNeYeMyj77A3DV6Iu1MXstTMENCw6D5+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=pn1jmxRH9fleCnpuuEtPMIzylH7l3/n0iI6x0j5hjOghCYnneunUKDaa3M5P0LoU25Q1GrDivlvRJmHcm27GNCrr1m4hnLIpCZCl02Bbnwf8owW3cV+uKvQ8AmlJQHCKKlg2T8guhKegjkE+IUkhpXNdB15F5YDm093FF9FUqPq+QY2PcAbucdQ2PUbZxMJjYrkAokabZAqxn+uVgyP/UvAOKIxLuJsM84S2LrQNQaWNGh32J6VOCNKklMYpK1mIqiMG4/iNUe4uAQ/UCYE1PZ5MZejVZqoWVOiejkLvzuyscd4FI4zcTUqUZcow4SbW6xgt796+VDT3dFFL0WN2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=tNdq5o8VQEZYNTv2BmuhzcDb2agIfploJEVQKTbu0MNPp+gBkLVXH92QpboNJZTXkx2lw2MdLzPdXBMjkTl9omESxzn9Y5rz17r70Zu5AAAW5XOPHPrxX3R1eLg++i3YxutnRtzfDD38jY/l0+YiwjvNAw61Oiz74lNxemKlwURGyLjdj+rhyblmjGtD+FssrVrvhzrnF+25Ov2m/IhR00N/QG4HN9Mn22d2rbNo8SGY3N+hjYYjAUUYE5WVSFHc6y4bEYPM9IOYze81/5hv+OXUwXmlla97M/o1lNWdhs3ryKCEhXhZnTlMUxRyrFtU/16VOkJ/0kzl+IHzyDP7yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:32 +0000
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
Subject: [PATCH v10 09/16] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Sun, 12 Oct 2025 15:17:00 +0300
Message-ID: <20251012121707.2296160-10-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 97522935-94af-478f-1897-08de098951f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ja9L0SMYLEotiOe1ziBwWIQS3TKUsQ9EPRo02A5/loiq2poJ0Jrbd+nx/5e6?=
 =?us-ascii?Q?kT7Gojkpon54i/OS3/DQ3yuXzO9Oxgni58FC2mE1w9NSvWlV/vLEQ5/Ll2i2?=
 =?us-ascii?Q?/CLXjFa5/b6dcQl2ZYcsqBDnAbVJz/Oq7tDPUu87lsrbo2c8ojo9gbGGDeug?=
 =?us-ascii?Q?XlTNvaZXqqniVIYN1Ok87A0vCJFZOWH9xEgq2ZQIprSHMD/G5wM0A5k2ELwz?=
 =?us-ascii?Q?5v4mG3xocV4fmzFyE8/CO1/T8GfFSOJkEom+zzmiFU47/NIexyRU7dhc0nM5?=
 =?us-ascii?Q?fwLINatEvDH1ApQkm+SDY6plMFb63Wc87v9/Qaq6ccRSq1KPMc28eNVb6PSF?=
 =?us-ascii?Q?s7eg47BGYcKc/BBwjAMmr/c0OmAFSUuMYzyAiO9QalOSuNzdjaD4Mw3PJU1j?=
 =?us-ascii?Q?4UpIaS6FeFN72jBuLkW41wYQvD8ifM9mvTMJ1t7M1v8MhYHooQD64aIGKTjX?=
 =?us-ascii?Q?GhGzpgqkNxeN+6eNZEiFbLaRQjuntnY940mhnZ16wP+RslJsUdCSlFpZhnWM?=
 =?us-ascii?Q?ppNU79gMg6SFtW94H1CQI/dwWDB9JPUrysP6E+q0os8ORc3RjTCZ0x/pBluc?=
 =?us-ascii?Q?VNAxt6mW3CtAav+bRIjIP4uV1KCwC2kIxtyChHj7HgdeMVQe6FWj6DZHfZiG?=
 =?us-ascii?Q?/Kwsb8+w+AOMXJj2kNp57gKqH5mbhwo+moXd276KvCNgibryOINuKOB2zJTx?=
 =?us-ascii?Q?NozPMt5wpW3T0sx05FUc4ut2yPUGKl5DY+h66auRprOLGQv8oMQ7QfsFczOX?=
 =?us-ascii?Q?tyFxEzaRkQ/9Ysok8jdU3bMj5EDx3UHIOnV4xIetzVa9KiSziiAGrq1hgUGv?=
 =?us-ascii?Q?u94ShLwNHls89VC4Qbw/k1QIzwhU7w3d5OSRZ4amI9DEDfQ3Mz6crmvvgl9v?=
 =?us-ascii?Q?e2eADRuChZh6ExLtG6pcZ6T7i//XCutEqea9woIoE39oi8fynIG0mpTtw1Qy?=
 =?us-ascii?Q?518gJv6ufLvbwqTTg7FdokSW708iU3JD+MglU+AyJPqUBSUr6z8aWv3Ei7gs?=
 =?us-ascii?Q?OQETw36ZpkK9WMb2PpitSUZiQZwIl6HuXGswTPF/KnAgKOgBSeBwuMZxW73g?=
 =?us-ascii?Q?T+eGx0LpQkfnNi3Xs/nHRDwAKFmZQAGiJDWu+7lc6ZJVC266WY+BErDqBhpi?=
 =?us-ascii?Q?AHx3VInguly5aM9PyJh26LqE64YJwbWjM5kRWic7xmF8hac+nY9pRDBba0kO?=
 =?us-ascii?Q?EkIyn904duXV4+Ph5uovBfUY6TuXBYj5gvkoHZQxoJGmdinSNNlqboGiRGT/?=
 =?us-ascii?Q?zSB6yTEHQe0hr/ukFalgnP+YwZXgi4drvcPX6qttHkzAh/nlWcS0kdQaxvG3?=
 =?us-ascii?Q?80LyCxMe5QrPMUy1T/BOrP9IhBKrKGhcwZfzRaC488DNScK2BT2wjzCyrCat?=
 =?us-ascii?Q?OcbPV7whLl2mKDpnaZKh3a6r4AO+zJ+yk+DdNq5KfC90qYp0YykLF1BIgyVb?=
 =?us-ascii?Q?g6rLBRwimq7NvaP6cYIGo5kKrD4/adCzqo283w7d6yVody4T73qjQB1gTba+?=
 =?us-ascii?Q?NEXR9Emeh0SI9VI6c0HI18cHKbN/4Oqpo/eyjryjeWAcHbgf8uCBOQZAHg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F4fj6aNFB7jE3S9PkmENMgTPQjsKlCti6faaIjFHSY72OKYtHD5HBd1V2cYE?=
 =?us-ascii?Q?HmSY+Axq9Jbj2q97XnsdRvmh/B5fWzEq23ycW+n2NjI7RM6Bu+VvGMBmEMF2?=
 =?us-ascii?Q?Lx7sQqfvQVq05s1oV0nwMrRsSHmAe8mlQb4UruL7yvinS1PNL/t/fz2QcQRq?=
 =?us-ascii?Q?O7dVsRaiwpJmKPUBhUIrigMXnkuDDRUF0AoSr/Vuv3pRol9yMo6F34Xh0d5a?=
 =?us-ascii?Q?taQUsIYo3neyINyRzss0RVwl0Hwq4UK2oHsdLwnvwCb/nXTE1EP+FH3/ucjK?=
 =?us-ascii?Q?c1kVHfI4UY+aaVQfmSyBpw0wMqQdbG4CND13A2CrwP36uoZPj1iiegqOVQgp?=
 =?us-ascii?Q?wI9KOufQHeX5icOXvQlaZM6FsgoUmdwct8JHA8SeA+VrDE6z64yAlOJY8jAA?=
 =?us-ascii?Q?/yO/Jis6f5EINll7NNOd5UId7IOFTTVxN7oW6o8q8wAqxYPzdkItbuI96/ow?=
 =?us-ascii?Q?G2WN+Uic4VcHBlYWwekpsvXHM9qGWRe3iBgVeL1iwpc/wnPjXONv1cQVngDr?=
 =?us-ascii?Q?yfZl4kVHco4SXYVaLsAbGwmHnndMO+5mfU8R5nTxfLAVGvCqdpMXKaN+WMRT?=
 =?us-ascii?Q?hRnL2VJ/cTJN1GjGAngvCQGUiFnln1QNgj9rhZFFKLRzHb1ZhC3uS7y2M/Qh?=
 =?us-ascii?Q?OOlcwg3ZQ79Dec9tvmHPi3N2mcFoHRXDY6cNQniio498mSxqFZ08PMFVc6AE?=
 =?us-ascii?Q?WFLM0BkY3OobWhHnhj+hSvBTAzTNjAWiGJKqwoenNjKR8+14k1sgCu4kqFel?=
 =?us-ascii?Q?RgiopR5r+XB4o+cSMQ5rwhIVPR/L+F+8rnGKDUPUbrbT7l/vSqUzjGTBoii4?=
 =?us-ascii?Q?nY3sCv7OJPUJE+yLzuYM4rr5L3iXG2YBRhGWM67ypPhnIxen2xBKzjkNDP24?=
 =?us-ascii?Q?k64AnZfzMNHqXFSroTWQfLLzi+9J1xBUgAjZoGwKeHyI5+4GPDtwyHIoxOCX?=
 =?us-ascii?Q?8d79qIXZqvhaJFaBmXDCoy7k/OCknLN6fb5KlMiUgwd+h+PYiCFsLB78uPK1?=
 =?us-ascii?Q?9111h/yMxeOoiojGZjSGsiigo3ND4+AooH87pvY8XsEDTYpWGWoZBd0nD1XI?=
 =?us-ascii?Q?qEvILtONj6AUpkTdZWO8aR1Jwj0TcvoVJnlcOKn0zym8JUz+/6h4pywN+8X9?=
 =?us-ascii?Q?QlgF/hezololRRQzrAn1LHWL18IsLAVqLcJnbNs4blNkUuLN5lZyyvJj8Nv7?=
 =?us-ascii?Q?FK/a6LCKp1/OavwOs9b21qVzQGHVMmlCe8lH0o+hu+JUfNfVvFw/VFNvIons?=
 =?us-ascii?Q?lnh6h1IZ8GOrgvWoVblU5kFMORo0A2ZSMWod6HebeGp88I4aXsTVNIPfSJGe?=
 =?us-ascii?Q?kV/s1QgfH7Qx1kCxNw0iODg99HzFRquRErLkaDIugQEBhxoHJRDoenV8HWhs?=
 =?us-ascii?Q?fjvygLm3YVVF2YMPY/xNywddi6UZsjYSOQKlnIi7mFkswdVeTyn2IgPXppn7?=
 =?us-ascii?Q?7NEXiH2/Lbecnso0lgDlUfrErz7ZHW83xO4XEx96qzdnQzpB28qbrca8eEfz?=
 =?us-ascii?Q?Q96/9ey2IWed0nRWvtsm2VAaYVSFp6QE6UE7iDOAR+kHON4EA5AdROiF9zgK?=
 =?us-ascii?Q?N0BrvegnTqUXgm5Urqcmbva2DPu4OJG8rjczcFApfb5xRE58YTbn+KqKzqhR?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97522935-94af-478f-1897-08de098951f5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:32.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OqgGZCGvCxa825xwZ7WRSrHVEJ8CHHzueZY0wf5rSGRI51+rQXduoLEtQUcstu6M7jFCC9NbEdZTOCXV5JDQ2qULaNsbnL18Zs6EtyHZM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 744eeb2b24ef..719b424d4cce 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -518,44 +518,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.51.0


