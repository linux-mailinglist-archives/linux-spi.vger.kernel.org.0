Return-Path: <linux-spi+bounces-9559-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7DB2DCA2
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1165316EF8C
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91363203A7;
	Wed, 20 Aug 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="KpKtPDf0"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021135.outbound.protection.outlook.com [52.101.70.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8A31E10A;
	Wed, 20 Aug 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693223; cv=fail; b=Td52MfD0jZqHTrLY/rtVvp4kL/S20d3mFS7oVINST92RxwhdWY4jY+Xu5G8xKIUoTlETUN0uTt4QeSLJVDVmklxyA3F/FULdY93sUoUtQDi05o1kGzYWBNbBlIL77H7n2uDfk/lie/wmVA8/Lflb8pzOJmi7cRpIAxIvoRLE4gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693223; c=relaxed/simple;
	bh=y7UPrBO4XnnIa8IYyLSwLNIqtz7XJoM+1OR6Vk1zKzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GFtALg5bmk9GoUPwm/cpnMxTRlHJ5pal02JL8u362dAqoB3GaNEezsQ1BD13Sd0kRmtZnWZ3lQGa+UCHWwnlZSNYnaM5c94LEzDOazBy3zepC4wgwDw5oGH0ce34PvDxodnHDvpCYE1GMXWqeZQijZFLFQAz6PzJZSfuqlPAVzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=KpKtPDf0; arc=fail smtp.client-ip=52.101.70.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td25lOXFVim6PCE5Txk+N4jh4A7lIbj36Eds2pfX+Fsa0AjGITV3ZNzFMmHSTj5uHEEzSyc16qYVt3Z9Wd5ci6BTeM9zj/zdyMKuEOMvagXscqpo5BsB4ttNNlDVP1jDK2OyqsxMmUQ/49h5QnVMESVGYc6OGmTO/7HCZwklral3agK8HwX37edkEDIwdBq2Rfqt9RwG6z4e/27c3CqgVNHSSDUv7x3UIMuE2AyNYDcUweqJYxJhVLgBy0m7ks8xtfZi0gUZjaH4VeQFLqb37i8vapCH9DLIY830B7tne7xgjDEnDb1NFOb+PqLw/fECt2FwanAfU+NC9IXf4BWf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/LxhQuVL3Cl1NRvv4uAxK1hzZqlvNRLbG3I1eHfwbQ=;
 b=pldd4EX9JPozqOG7WihllhSkAzStKMuzscFvPGiyg8TK1bXoK8MwOJe/9ZjFN8f2zCZOuUyvCD313V+LeSd7Bfs7PPAwOpJcXMT20Hui8RalCA6H37PEGyuCcMLIGpyeB2ov+IbIIGdMYLg46Y1iI6dhSk17AH7rV3zQnz4rg1NdIp697+bNbNVUUFkIw9wiFhnaLF4V9MudgdX0iGe8Od7Dy7PaR2euFWj1bB9fAMQCqwB61c8hVvEcNikA7c5ziX++S6Os/nl8cHB2xumVQHwnGN7aWfMf0YKN+Lx9C00BEKA8tM7MVPs5i2A56vXXKeWZ08D6kv6w1Dzu4Y2J7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/LxhQuVL3Cl1NRvv4uAxK1hzZqlvNRLbG3I1eHfwbQ=;
 b=KpKtPDf0EnN2+5cI+CcL3YboDEuxocLAq+tapINhp1Mgoq/TxmNrsATT9gh5GOB16QJ9G8u0Vtk1M7ELLyFHF1LhDMNNG6ZvwoV/T+MnaCJQiqmjn/hDFPpSKYxmxS46Aze63Fx+dy7d6eJB08DSpeOvp6fxH4R8R/SYFa4t4dbpac5T+guKP15mK5foTeam0D4bBclLLLIdgmnrN21J1D/MzopACdsCCPm8LjglFcOrpYdGF3HsoFCiLzdUWdpA+GwxYx/qVWQGxAv5FjEWNpVvG7mJIuR7t8vzg07mWyMeATGQ0dGmd5l5wIPkfDrNL3R+Qsq65HC6DL0DIDR2iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 10/14] spi: airoha: buffer must be 0xff-ed before writing
Date: Wed, 20 Aug 2025 15:33:13 +0300
Message-ID: <20250820123317.728148-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b25e5f2-8386-4850-d3e6-08dddfe5c6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KuMdLMLXEiBZG7/gh/nb3HB+Wt3NatYYCldt96viTgJn7uo3BstJDw00+E1D?=
 =?us-ascii?Q?ZUkTucJns1NV1TKLsA+0S5SPmATctS82L2knvosBeDhlcLfsvCCFw/zl59pc?=
 =?us-ascii?Q?JXCb1INB8XvxLOMLHeAmw698SmabW5BWRAmBG7z/cakGRp1iuMa3wtb5pPp+?=
 =?us-ascii?Q?9gS0HyMlktIAIId5Eobdjz4uha9wCyYtrRoX0wm9s2VPZHHPUvhXD5NIIt8n?=
 =?us-ascii?Q?seJsO6BOLcLfaNaW/Mi/GnhTOAhB+e6BBA5AqjVX7kIpLIH1ori3EZ4ItT1S?=
 =?us-ascii?Q?zRCPL7FrofLhMdF4ioa5XSjQvABCvDECMtxdZ7YGJU1Do9SspJuCiKNO5mHG?=
 =?us-ascii?Q?ls1zExFdhXAYN0wCMuDhKK8DAYiAWxJYc4YCU/bv9m51PrkdCW2baaH5LDGg?=
 =?us-ascii?Q?W7lW5i2GSzsvYcA60Txx7eZgNazpSPqZBW0L3i33JQbc5/OiQhTTI2iplUDa?=
 =?us-ascii?Q?6+nqWBKwGOP0wEE/91z/wf5nLUV5G3ja/IBiTgVBAmWMsanzpXC7L4bzSMRi?=
 =?us-ascii?Q?7x9uVseshOV1yQ01mxL4/fuXEehZxqJt+htA++5PpTWGWXfX+1d6tYcMuMLx?=
 =?us-ascii?Q?I9NHunipylFUZiH6A29jM4iDh3TInqisJFWeky8gv/nPXqMYOzIPQCIk+8yg?=
 =?us-ascii?Q?uEPonKwgPD/mlY3m8FFVUzjxZyPKQ77Y0bBicFsI8XGTDOERKmcNyzSTc+bB?=
 =?us-ascii?Q?38leZngWHN+/hNrvFMcOqIPd0tzgvFYqh1l9m78HwR90+jbcCJhL8EcJMuoW?=
 =?us-ascii?Q?CZIA73G8aR6IaRbmuWSJd5paIRtsN75ya0r3gTEoJwMEpXphCJp/CSjePggB?=
 =?us-ascii?Q?u0PuOhu89Q22KZypZ/1gHTq/0EAw5lVNRYcEbD17HiAUgfnpOPjNsuQTzPSk?=
 =?us-ascii?Q?UGIOI06pVCt7agKNVLoOtG5x3m88oAVqB9sZccSE2XL42csBcfNXw7+btK+g?=
 =?us-ascii?Q?u5y9xq6Ab7XwlC7QWUizBgcyynU39ION8Qd0MBk1BVube8PPpZmP8Re7njEL?=
 =?us-ascii?Q?1Ye1XBbpJ8IMyqPFcAQM03TPzk/q5bi6sFSBsY10TNsMDTHx2NQQkpFgVHGu?=
 =?us-ascii?Q?t7ZWowjmuBjXFYacUd6+hzzCFkd7XwTVVRLzyPI04hx3+hJo4GHqx7HcopJc?=
 =?us-ascii?Q?5SpoyT47znWUaHijq3Vn7FoXE0eFI3e8D/gGo8R2oOQe+mM26DUgnTjA+3dt?=
 =?us-ascii?Q?vRJfb2DTKBPBfEeLkYkkPv94DGGn5xBiWuEpsjuYmpdFFDxyNB7Nh03oE/7L?=
 =?us-ascii?Q?2+lPepdR81NSRtvXzjtcJLUUZ+liWZMxTSy7PA9UuzgtdsOgailFj+ERaprA?=
 =?us-ascii?Q?vSEIJoPgK5PtoM9JO/l4vc1kZHLVGYAlPVj4kXmZGVbTAuNxIFM9Q/9KocyE?=
 =?us-ascii?Q?A0raMybptRzuuvr5t7rUI0TJTNY8ajDv3QRGtXGS/JVcRGizAnZZ9o79FJYs?=
 =?us-ascii?Q?0ZPXaaI1RMo33nLeW48sGEyY7yPJ9LCQLuwDZUxphY2RWmP2nJzE7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fk43SLQ55YqnszF9kGer0xDpoZYsiLQ96MjpsUOlzQ53JA1VCwDQ5udzhSz?=
 =?us-ascii?Q?/RLU/yVnR9lIkasxlNRGYEgbGh34L8WyeR0Nk1+yLSTZ//MNM1IwT6gqv5dt?=
 =?us-ascii?Q?lICTS6hWLfWtlnJyIbTXtDSxJXZsiNVzlhqDxFUl2zo8pmcg5ar4hU3PELiw?=
 =?us-ascii?Q?ksRV+QeXlMeV/lwItjW3vqE7KD0DsKSGd0bwZWuf0p0g8y7vxSZbkg+csIw9?=
 =?us-ascii?Q?r5xkF4kRi/Nn2X0UlB+sXQdPvJkrg1lkt6GZYSYWYOHVNeK3MwFZlYgR8tdw?=
 =?us-ascii?Q?j6YyhbJS4u3VRjDoUYIl+EaDw31hjixHuJ+oEC4w5fRqs3+jIUCe3qL9TRvY?=
 =?us-ascii?Q?G3/QIiwLQSg/2h4hE8CYj5RcgB9v1/J9NjCKLW7W1b8WNc8eAOYbHdJj+8/A?=
 =?us-ascii?Q?Zvv1L+42fVqqoIT4nsh7ZBp63Q+3gtQmu2xi+QvuUMkYG4ZX3/7iubmbc13l?=
 =?us-ascii?Q?BcEKlivJTS+K5dpv6npEXRYdDDizoRUzgsVk+yTOPOdTBFG/aIkENSGZe/7j?=
 =?us-ascii?Q?OdLhqduoaeNFJdbS0xr/3qzX4uL9KsOWOrEurar1mEUlKn3oaSBa2hlxKrat?=
 =?us-ascii?Q?5AUMKZX9SQf3+pHMdVtXtBDkHUDIWAYh4aFPOlrxrJTKmSVZpuUHcszCcr6B?=
 =?us-ascii?Q?wBN3pURGSQhcHgkMvvb3C5DmOwgfwfLoO7UGSUaTXIItv7oOORsXbrPbNf6J?=
 =?us-ascii?Q?oDBsftPF1qlS7yi4LeQDvJbwhiJ4LT3mC5YOp7FXa4K2k9w5U8PqZQwbo+zi?=
 =?us-ascii?Q?DcxNWyLgGRCqLaCJJk5txdwXbvG0WMTzuchqQYf29pjkyHjJxy2iJi3so7SU?=
 =?us-ascii?Q?7wUpOmTGUHLqrOHEJznoTmyfnAX0lrIFKHGgTjjyxLJFSbLrEdeVzj4siPBy?=
 =?us-ascii?Q?MZgXJX9rKeapm9Yz6SPzn03s6R2/CMiUDwzsK8F6YGn+zSp1a3bgLcCVib7n?=
 =?us-ascii?Q?epTptJXuq0ZngdvGErzJs/bgffzLWr0tGquOF8aa3AFHjoicVUZMBRB5q2CL?=
 =?us-ascii?Q?e/75FgRerQdAkqpXsTUAy1IjZuijed2eN7Dh+O0ix0FrTOZWlaUwhXSfZuZ+?=
 =?us-ascii?Q?PPda0OtzQS4dX9k4xbn0TiTgGXm0iRLuGZ2zm5HK36u1XgWejc3VcWBGyL4X?=
 =?us-ascii?Q?PV2SfZQnerfoiJsIIMJ9hSLFwVSq60EcsrOJzDe3fH3OThLCiR0q3ArCnvUb?=
 =?us-ascii?Q?TzlcQBRDnu27nc+B45CGmK18jdtcknEUJPYR/5GliMD3hc0Z89udbQ3yX03U?=
 =?us-ascii?Q?BGJKj59y+Nl4jCEuY+pdPueYKwyupz/SEeMBbY17EKwfvNnP8R6pV+Gfc8yP?=
 =?us-ascii?Q?KhL1OzOP4w21jNOeFn8MXnTNnqp+2EE8dhlqxeCPeVm8O1TbxWbjKmsmkJUj?=
 =?us-ascii?Q?yvCH3/O9e6PZm0crOUggV4mT7cT1Ow6oBxxFjjA8yoFh026CdLXk6XbTNmIt?=
 =?us-ascii?Q?B5obLlKoVqN2N4krLWkhqC36+YrdZcEoJsC6e9tc1nJktb18hgsU2IypAwAJ?=
 =?us-ascii?Q?s8UOggL8LJgeqUWw3kNy3FW3rUQQ8kb9V3BvoQwoMmtUD33WaM4pk1jXj3sB?=
 =?us-ascii?Q?5yU62WQHKdKJybHSlRi2+PlHN71cOnVlOMYr28KD9ggMV425v67OQIIWvi2r?=
 =?us-ascii?Q?5SdrSk8eRNgcpoPHOay2nj4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b25e5f2-8386-4850-d3e6-08dddfe5c6ae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:33.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7XCnsFnBU99y/pc16A7dog6gEEYgc2J3bw4dFb8UewnryUZXeoOuHNiTUNv1a4ro0BuUljiIWkAU5+h7Q0fNHd5O6QdbCdaM0n2sqBKIM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index c3348ef4fc08..57eee658fb30 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -848,6 +848,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	memset(txrx_buf, 0xff,
+	       (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
+	       as_ctrl->nfi_cfg.sec_num);
 	memcpy(txrx_buf + offs, buf, len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
-- 
2.50.1


