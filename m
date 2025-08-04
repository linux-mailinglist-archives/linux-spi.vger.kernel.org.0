Return-Path: <linux-spi+bounces-9280-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F7B1A997
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 21:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951A23B8CAD
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4AE28D849;
	Mon,  4 Aug 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="NnSt/XuL"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020122.outbound.protection.outlook.com [52.101.69.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BE28C2C3;
	Mon,  4 Aug 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335317; cv=fail; b=u4FO4ZNQxBhNasBy2gZoSyNUytA1RRiJ4AiUkld6y3WmrCddX4A1r2ijf24YetvxUrfPXo6oGhIfR+HBPVwdB+CATlkGa/pOdm0rrdAV175KJezXgExYrQBuJrYU48XRwVzP7gv1ciSIqvzWg31g8XxC5J1jp/xTsAVpLZcd7w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335317; c=relaxed/simple;
	bh=AfEfCBnAM0/Kx8tkEurMUWUbJjo2jjPJSDPJRNKNJdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHOClyBHqlYdBOpKfVWP0JUaqc4oD3lMSRywFdG++Ty0glCrCWhPV9tLmt+BvTD0D2K/MUFtTgPa0VIbUobJuAlCn/zTPB5Mq3x57Jfq4VmJuQ7/QDQqm5DegGNPJEDa9BHY7b8I+SvW/tSmgWMviOKTb0XKu2YeB68VDNryXBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=NnSt/XuL; arc=fail smtp.client-ip=52.101.69.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+vX4nAoQfOOrQiU9Ln3BhFRGTDmmb08HMWE0LFOzBrz4Bh23Ar6n82PoM8FhBAJS7Rwx6Wjy1JBB0kpwvlZ3Zf2HBCtS7o2znMJ2ZV4XBThZRFV9WbuqGAyhRfADsNUOkSka7CK2Jq8LJy7drAaHss26tJbFyitLUT4JFIdxuG3FfJiHlN/rG7+2jlvd9LrpYuC+9Clg8e7LR6v0NynFuFjHDYiNt+lKGFWNWHPwOKkj3LRATpwEW17Ty9FBiADYZXoRaIJy5QIZHgBQxHYNi4mjMtrzl4RcA+UaUWXUdjlpKlv8+YhK/zlR5fXC3hkBKGc/7x/pR5f5vIX8zz6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jkk+3t535n4/UAVvjzJbOsMv5YHbb19o1eB9ufbaG6U=;
 b=jQeWXYmgnFAKTxzwQfN1erUT073iiBHTJcYR9tYOEQfvgG6nUc0k5/iHYeZ2jqXWx/iZ389s3Zk9CdtAioQ8X+ttfA6mYGDHR5OrfFPZLSE+RW7LFlC2X2O7Ctc9H7zuHQ3ZpIZFNWbi1ddq+E7+1Cr1xrXOMSnLdeanKdO8Mwew/3jbabM1oWmvwj9l6sAOgyVgyeuBV/j+HjhZQN9FN0+EgbpKd/5IUKfjxXjX0a/jA8wXhpwszQZTL8peRRV5ZQ28YA5YjASAIB3xhru10K5P/XudT3ZA2AM95ShGXoP0ZYQ6n6whZWC62gh+wUcbHlucX7aAX46KpaRdXtB3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkk+3t535n4/UAVvjzJbOsMv5YHbb19o1eB9ufbaG6U=;
 b=NnSt/XuLSaUfIRjK8juwwJyXBRnUzN7uxSzLYsikgpmiS7q6wlWOg4hIZidCbRBHD9ajltXsP2/d+grdl/tARnqb6ZtopTe+jpHtq1PO/vo4ROOMrYDZRfRNyIWh9k/bXdOmhJvanRsfPuAC6Xq06l8eYvmDaUK1g6CBiOH1gPBlW/33cglklUDmFJPIdUETa8pR1xFCrF8KotseKx8AcQrcDi4P4i+X8oQhiXUMI2z4j3KTXgw1dvhox4lBXAaFC4CrNYCVsJvpAmWd4EOTCFZgCbCGDkJNDm1I3k+b2iPQrPzN+xhQu2r7h9SXLx6ezApQiOEN4RIvr83UcdSRmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10844.eurprd08.prod.outlook.com (2603:10a6:10:538::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 4 Aug
 2025 19:21:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 19:21:48 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 4/4] drivers: spi: spi-airoha-snfi: return an error for continuous mode dirmap creation cases
Date: Mon,  4 Aug 2025 22:21:32 +0300
Message-ID: <20250804192132.1406387-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB10844:EE_
X-MS-Office365-Filtering-Correlation-Id: 4715abc4-2d64-49bb-96c9-08ddd38c283d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U7aDrEGbxhzRYthTN24Uh1CiLCgRgZ4ud4IeJmlDzHwTgiG8UzO9ab25ykMi?=
 =?us-ascii?Q?+/qSfHG2YrINbwtLzV4dwCPj5Q4tRwX9iEl/Jl6XQRtsRTBlkvfb5FhhSO0d?=
 =?us-ascii?Q?c5r4lDWkbyRrFiKiose/auC40hbDHItTWfPrv+lbd9i2RDUYOrgS+P4DcjFb?=
 =?us-ascii?Q?9pLJXcUuGda3TVabMZQ352466bIc9/XPQ8Ake2vetqy8CqTBU+sehq/AhLeo?=
 =?us-ascii?Q?HUiQzwD7/7/MJOPdMuU+1DudHInFg8Tn158q0m2iJ/g9O24KMTiyr8B+8f4M?=
 =?us-ascii?Q?kKVqca4FJsIiUzLhIwVfjAv27HjGo1g6PI+sn+frp2hxXbhxj6AydrcX72KB?=
 =?us-ascii?Q?zVA5PMdEEoFGUnQSnFBOjPYqRxwJ0zrzlWWgOMz44WW8X1UMc32lPrbZ3zP7?=
 =?us-ascii?Q?vgiDsxIhEFGOoKHI+xx9li/z/upoenu/7VkdojlUM+QVMv+uv4oE1hH89mhF?=
 =?us-ascii?Q?UndtfE6qu/blLXIvFVoAZzDFy2QPC6L/XYMR7muoNmJT4/Q2+yj8IHk2vNxH?=
 =?us-ascii?Q?fnYnGL7XdLpeaLlsGn6Eb0G44Si/jlzBHyTAUnyWpFysYj5ed+BzIJI7UDYg?=
 =?us-ascii?Q?Dn9uF0YMAW9niWChSzojkqodp+C809l5voy8jwtbxn43+CJ+kgAZu/R6T5ow?=
 =?us-ascii?Q?cPFt5FwfQviRXuchpUz66IVx4WcClH370LNfAEMe+VdG3hoMt6nzxsTPo08E?=
 =?us-ascii?Q?jeZyAwUjK0aR1/m5Z2SsvtsWtQSu2rie9ytTkJjL/2OJNjLQLKZzcNdNXHIW?=
 =?us-ascii?Q?NkMiomzwxRezgTuIj2Gr1myO8iQDrdGStS+W85N9/NNzjDMRBlOx80xTezmX?=
 =?us-ascii?Q?lLm0lWDQZwtcMDOkEFS7alqLS7m/vgyxsQjNJba4w2IPvYqdJFUsQZmXm0cs?=
 =?us-ascii?Q?y1O51Z8qcfj1Y1yQ1WKp3Dd9H5caBmVWKoEtpoldqn8M2sE/3LpfRRYyj7xj?=
 =?us-ascii?Q?S9pUvfWSN7ybwJLM/l4MR+UK3hvYAwDdqWjFoOd/3/ihd0xu7dyauhs002cv?=
 =?us-ascii?Q?+iY//AL7d6moX1eRq7ItSpoi3pRYTYt58Ket/ZRnvNAnSgoKnj0EVP/DeyY0?=
 =?us-ascii?Q?ei1awqDkLqHTUKrZYAz/95g3DDtHs/bG8/5qbkNSxyAuKAknoTUWS9oJxyZb?=
 =?us-ascii?Q?PtCMKtIoxzXQk3Jp4aoeTQqur2p7qjDQwSHbM2hOWJXpCkDo6OQWw8uSTihY?=
 =?us-ascii?Q?ABsArQxQPC9KmtIoS8X+xZYozZsQEdiL05zNe29TiJzoSOMO6shfsabQCFgy?=
 =?us-ascii?Q?HcXGPCDOQoCjqEDkmZXPLx6v3J1Z2RCHKvSs56tWWaWxfCvECdcRfooOFPoi?=
 =?us-ascii?Q?KtMAU93bFKNwoBtInQR3G6H/55N6v3DxGyVUEn8iBmhPMADOYhtmXH9JDNUp?=
 =?us-ascii?Q?x/UeHM9mEt5Bt4VtqBuvlv11uSYqh3rvAnF1q4INEky0LGNBUpO6LzjNcdBj?=
 =?us-ascii?Q?5AA2ePCby+SNiFmHneNNj08QWyNw/npJXFmEBOz4LH8hZ8Ejtqjg5h5fDlIk?=
 =?us-ascii?Q?c56KzCuoi1v84po=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmQZS1b32/cYIg0M/JLuooLIMfQOpy/Zhq8oApUSUQNoYJY+fnzfQuT7vRv4?=
 =?us-ascii?Q?Cfkr0BYC0kE2EH9VTEv4Z2mhqdmqDxFd2zk+PnnmhPAzjZ5WhoBh7jW78VCY?=
 =?us-ascii?Q?gmD6A/O5G3brJt0U7qhcOiTiku96RGe5/Mr33KCbNVXQ+P5pekpHEoD61zgt?=
 =?us-ascii?Q?S6LuwjdS+7RyZHWtVWjiiQzOEsYt0FEekUISrh3o24v4ye/moAk/W4RDpSCo?=
 =?us-ascii?Q?89obwrDR8F2Ina7MQ6XjXcZI9shDpYE8F5KJSZxk/fM0fyPteoU3ai2R/bL3?=
 =?us-ascii?Q?BiQELBlzPQKePLx7OAyUlblfjzB9lq9GQ1qDcMgqXBIXh+lKhqsVNOLRUnDv?=
 =?us-ascii?Q?4PHgxJQBPPZmh790uqfzc7nHqYmaKjFcEbBjW89NFfLHKTQh78wlW5yMX8ad?=
 =?us-ascii?Q?E1ICws1aQFDH2JLDpsvjNVxZGIX1T3TujUHJtVzYqKWKLnrpwt/maH+qAlDx?=
 =?us-ascii?Q?bRG6OGmRXY4BPTc9JCbH1LBznaSzt7U+gSy220p13uu7dORIHoLWk4QGoz39?=
 =?us-ascii?Q?YipUip06DNwbgCQLTUcm9GTHsej9c3EiZlWQBjoGDai7JY8SjnRrqb7QoGMy?=
 =?us-ascii?Q?8D99WhGdRZF3JhrHkhUNZ9dRpwHBXrPPvB0DyugnoovMrAyUNEmqQVcRan/+?=
 =?us-ascii?Q?f+vgV3pRhntb7CcMh7MkL5qMmCfp1rxn7bdPfx1tTTh/FFJGVBG8b+vG0quX?=
 =?us-ascii?Q?dMh1mgIm+oIcUKOHGiu16qsZE8Yd+821iMCgdp4l6g24FnaVXmasSXzPdTZy?=
 =?us-ascii?Q?0W57Ay2YLldJPf9f3wZjfavWaLaN+ecmoUNxL3Af17H98XZ0wt+lPGqa/DbF?=
 =?us-ascii?Q?AjtomEhsRPOKHTWz+R5+VwpAXXAPcvnXlIdR0V7XGcEXWJUTRqHUaH25ZGlp?=
 =?us-ascii?Q?HkW/Bhg2wqLBNO5BEgBN27rlYzYgZM8fajC4ED8yxir8wfsuO+FJGjBXvm9z?=
 =?us-ascii?Q?VnSi7asYuDYUZ5UfE1Jb4944fbczOKHkM9HOlmm6K9vL0vhGPUEF3WMDuilv?=
 =?us-ascii?Q?VA5vKTJyL+INSxaLz/TTN6sQ1BivPZCNUrRxBtBwXcWRBkDZg8vYfyarLT30?=
 =?us-ascii?Q?EOvTGMR7ZyjSWNqwbb0rqIokrI5kwjuVptiZXnsPMZegD1sACRcPIyJRLn8n?=
 =?us-ascii?Q?bvP0n4rbU1Lc73t7za5tC/+2Ozk7piC3ahhqIOgEPvkHGykP9AkUf+ZAY11N?=
 =?us-ascii?Q?piuDwbY7qVIK0NM4PAYgF1JPledyL0dKlRVzjkPe8vGd3t9buEkJsnNf++cH?=
 =?us-ascii?Q?9jeIQWUImDtlLbZIiKNBIGCbvULinlpGE7yJz5EK1qqnLq0LnfHJ7XT1vlWR?=
 =?us-ascii?Q?1XnUskbK/sigEt8NHM+gNB/Ofc/4ySml1aclIrd2QoFX+KD8ikN/4oOKqPk2?=
 =?us-ascii?Q?9h4soTGzVTOlx6gclwOUGPDG1NILayVOR2ynB+BxT3yW1swJekiQLRiFbUCX?=
 =?us-ascii?Q?se3e/omGLhUOGbdgMyMyISau9AE+9pvpfV2qhxOhbLrAYIz0OvCc1PhnzkND?=
 =?us-ascii?Q?NnHRNmM7sGsJXl+FRXmlq5+seYXZcz2hg2sLHzn63+aw9yU4W3p0MQXzmbCa?=
 =?us-ascii?Q?/CD5vL6/xfd5RiPD1bfYgtvLqis4yKY2FD6Mzya8Imj7+TY8Awvs555uXVBT?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4715abc4-2d64-49bb-96c9-08ddd38c283d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 19:21:48.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CB7nPK0DI/AYmofRWNgMvHX2uQB37LgD+jxsbHDob+S+es9rMkZqD/NZmTHwZpNLbV7lAdXdhcLuaiRgfl360BPJg9lEFw8PLB6nIzgEtMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10844

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.47.2


