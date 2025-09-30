Return-Path: <linux-spi+bounces-10361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A59BAAFEA
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913E3189FD4B
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57E232395;
	Tue, 30 Sep 2025 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="I3Ewb9Kk"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021100.outbound.protection.outlook.com [52.101.65.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2922D7B9;
	Tue, 30 Sep 2025 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199238; cv=fail; b=K8ef1oafs4lYMWjitz6yJekzTpOu7e+84dEh2hfEGBZsHeyvO0EVI7r1jO8OO+suSDBa/Inybnzd7xJyjai32PEyfPtr1iM7MMpoGe2sFAbCl1DpVSeSL53PpCpQDsrnZVurv0ekm0iyRBc61voGdbroUa0y7lfzsvUD8rbo2/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199238; c=relaxed/simple;
	bh=ZSfaTr73xb82h81CRPdx/vCke5Nz17gC9LcUQ4Wu2us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zl4MvVCP9ElTu5xXQgiU5hD9r87sOMtir8KaiL3fx1pAlT87PRqyOX7U6TK8iJEjODaK+3xl6fjOz0/uNWi1b0uIvnJjF+E3SLWV/AzN99+4tEiFdhKL3FuCUffhZcgNnpEDVermjgLyHe40wWAbbX7yizdEOTfiNmYeYBDcWSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=I3Ewb9Kk; arc=fail smtp.client-ip=52.101.65.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Db4/8TFFJtS7q3N1RplTzUJGvSqYo/46yJVY8MFiCJRhppwnHak4QhVNjIo7fmxzv02SGRaVPoLIP1+OL37h8gwk6uliLaQP3K5AL8jXjC+gqpcq/uSR9B1Bz2vQvRZx0JHnzjlOnXkzRrCXzELiLyrcrcFqXHE32tK2t+Gazh1V7Bvlc9BTr7ZDMRGV/iWffZPcDIBv/gWvWRHTLwDEntCZGYFUlYhWP5XGLQ6rlRnlz68Dpl9jiH/WWWtQsXV+RDdtntPIFeKWGZjxAUk+/CpdARxU02/dNr5FKWkqN8jvk0Rh6Dn3MkbBqjv5tpHL3ltnGxsE2xwpvpTPMe46tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJXIl0t0fJk0U6Copt18OPzvBzJ9Zn6LXXRLWBN3UcE=;
 b=oVuN8O8wvlCNxdGpPUqPFv/BvmQ3ySeLfdwRThcpOxrXwpXiTb5UM47u2Uhrr5otZr99yWR20ioDVwoqGCNgqHJlK0+OEDkMJX3MX8EdWtr4aLdkDmhdXCP5s3y5pAx1P/ocD90KoVFDxiQwzweCWjm87pvj1r+RBSyCgUgYz3SVQT/gIxPOgYhgtaVv3bKuK5qqIHKetWhhViF4q6kRwo/+ybBGTNMXcAZkBikFc3xb4ufby0haNLgj9p1bXSBI8GAFZ9XLye4h0FYBL7RaeH9wDcv5UpdX6VHlU/0hLMOmeP8PEEvPhItpXTLFOIwQ5rZGMMsGmPZjRiAp0WygUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJXIl0t0fJk0U6Copt18OPzvBzJ9Zn6LXXRLWBN3UcE=;
 b=I3Ewb9Kkk43luJUYjEYkhNOo7qDvskBXxzoMHypCvv6pct/sUAAYUel7G8IZll0Uv1U+s3NXLKFMGzYpYSU6HOfRQHdZeAJ+JRyVPmfWWxzJfJJeiRhvR4F3ciI8ZtyyCqyAQ2iKigvquhYqgABJS6uwshqhxgFib4jOwZBQ6qRbmpRQvhOeVIlrCkHYK24vNRcw6e9bikitb8Yh5snYHbpc06edGWGTCTrOdTeGbzcxvFq0jDHyMYaTEbNrsvc2PS9W/KajMKjt98DyIvCPIvSbxh/cbbUhVPy3hi7NnSds34jI3RKT777JOBJiPTBughrsLLIZJYoGK8DlY+sKig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:09 +0000
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
Subject: [PATCH RESEND v5 03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
Date: Tue, 30 Sep 2025 05:26:48 +0300
Message-ID: <20250930022658.1485767-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 8adbe88e-0761-48db-3134-08ddffc8daf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCV+aq6aUAurJ/2GKJMrrZwFiNutmFmMFJ6BN4nZBaEwOqbggYKS7hl7oOnA?=
 =?us-ascii?Q?DTNDwj1nSbJeR66+4ISKR9pp6PptioNo1C36kUCQGWTr0vi1d2VeASdkk07X?=
 =?us-ascii?Q?u6oqWs3y/al35Q0F/wfFyrkDlowaFtGHuD4LaZpfBersicI7WmARCuVukt9/?=
 =?us-ascii?Q?hmsBn/QULxt5qDxk4jIcyehh+ALwEdDHWzL22Irf9olkEBUFELKzq/gHcF6d?=
 =?us-ascii?Q?KjkINcaBe/quW85+6u3RyjniORdAUKE8F/5ootRYsBI92BDjH282ahBzE8KY?=
 =?us-ascii?Q?pz88kxVJ8RmFuKFw7TO4/nHIvUPRC5kdCkPxIX7Nhza9+d2zBxeNeQSZhdJQ?=
 =?us-ascii?Q?OlfpaFDse3D7D3YRn1k/Sw9UZVa+NNuJWzcWPtXwUszyf2GvRzQrs1kEdt2S?=
 =?us-ascii?Q?2KIQFpOV+bWqu/PrikN6dClxuCSMLfttF7eLFlWpfESRpUTYseHf2b/FsHSs?=
 =?us-ascii?Q?feMdagom5mlDWsJnSGQwZPzn9AWsy4m52PxCt/u1w6kLJCqHkXsLU1PwZlNJ?=
 =?us-ascii?Q?7QneCWldxABYCNUr8Ov+/ue6Be6vOxx58kZliQH3mB2CQgnhPwAs4wyKR0Vh?=
 =?us-ascii?Q?LSYosO6TvXnmWlqpDqnNE3UxPmITPNc5nEtdbf2yYb+W998t4AqeW0b5jVqK?=
 =?us-ascii?Q?3S9wS9eKOGM/3v++DcpSiOMxSJPzab+ICFdbM4NnYEmaY9EnfaFidRwe81S2?=
 =?us-ascii?Q?drZfysSQdQMrT0ZB30iD1uVLhmDqmS7FRfRluvYRhzY89nF9pTMqS6R2EkF1?=
 =?us-ascii?Q?SNcEVVuoBlQbiTKjNtMsygHDut9LNAGJ1EOw9KPONIHnZB7efWCb0Gqt6KSV?=
 =?us-ascii?Q?hK636fP2DeRefD+p0a97T8V/ELkR4sQzrn4TYjKYw9e+yNSeGW31KFiwi105?=
 =?us-ascii?Q?OI69EAfc1Qv/eTm/POwbX2VKUeZlTCifgy4O3fvBLWhikhqNEqsN9rPlHE8v?=
 =?us-ascii?Q?uAk1IlMT41M9zojLLkOrt9A+ItZKz2NWJfjpkyo1oodXH3eItcwWWMgz07zX?=
 =?us-ascii?Q?4Au2KFIzmG2hm1fr2zedcEIXvlHNNGKUXlUaRGNWHhAQ8FHU9tzcPB13a4P6?=
 =?us-ascii?Q?UVlhONfWaSL1/eNZD6MQ9aPLzNA6xSWqCOGTZ70Mr7ARSkFOlAdu+cjBCfMa?=
 =?us-ascii?Q?+m3W/qjnGu4h3p46pzWNJkCOTHg77wUEaN5F/tZZjSSwrWiasSG7ZTUx7n/5?=
 =?us-ascii?Q?06zhd0JVQyEG4sirQeZQKbEaeinqA1GgJE+JDtK4ApvKYNZK6mMiT+UIu/8G?=
 =?us-ascii?Q?YMbTZonXTng7d5maoaY75gN9L7GMKowtqs+tNdxbNuZcZJeoSk4j+U8gm9Ns?=
 =?us-ascii?Q?9KCxQxJQXk5GeiAKzuqRdZAAnXNlWntEual6ES8OZBqYGlJjI4MbxR09JY4J?=
 =?us-ascii?Q?WH2+/ywkRDafgLHyfIG2xZmLiNcn8jJlml6KkqcB563ODo7Ku51bUX47uOaG?=
 =?us-ascii?Q?ZYaCrAsLMchGbLMvpuXG6CEENhcTvWQTVumUnsdfSDSeW/8p1KDShHAcNkE5?=
 =?us-ascii?Q?lLdo7GEeQHPe1cn9vP76RtMphOCYu/lwYMni?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TFptb22/EgVS+82dP9tkFbQHnbngYnRJ4RDvBAYQNmUaeajalifEDGOgfOGL?=
 =?us-ascii?Q?T3/4mIx15ZqClnWmNUeU7w/GZiN8azEeCdsgidDhPxGtf9WN0FiglfrK0usw?=
 =?us-ascii?Q?KEcT7YX8JZaL6XYvGsrao9FJAIw13HFjtnYdfQrR3AYtJxmfsg4oQzkO0TbP?=
 =?us-ascii?Q?DsJwnP23j2y5Y7JDgsmdrb8xZlnC7WWMZlc/btezzc+mT3yGBbpiEPdXZeKv?=
 =?us-ascii?Q?smjI9CppLcD89mdWfNXOJgdYvKOnD6k8sJ304pp2TiZYjzCSHUncX5djPqRS?=
 =?us-ascii?Q?gU/eTURzjFFb7eOtDDKHFfaIyamNNdn+rGgAJw2NTVo0bg7Rzj1JjvSCvBjE?=
 =?us-ascii?Q?K4brd5A/bb55XYC95jQWiYCGFvf03gWhsmJBTgZnVzd06hbnYJ7UdpVmUFF6?=
 =?us-ascii?Q?meP+UpVvs5uHtwCg6h+2emxxq2443Oe0w977+srraBKO5clpbr+eqNBhN8bI?=
 =?us-ascii?Q?YI5Ntw9rT+fQeKlbTBlfD0n5AS85THuoAbny6mQhxLF08DSI/yT5QLM7V0ta?=
 =?us-ascii?Q?6/S97O1JOorwIBwT0DiFcA3gdMUWTEWBdnzf25F8lpjjLFBRmKlfrVl5ndLh?=
 =?us-ascii?Q?7YmMvfj9F2/DVSmczWe+BIHhvvft2397b7vXY9A/hZ2f4mIuhIDyevW8z5ro?=
 =?us-ascii?Q?nHIQCHQUb82Ziw3GSi5NcWnufXWqThz7y4ys3AbF0HMm+44a5izgxy3hcmW/?=
 =?us-ascii?Q?oK51SZA1/GYEEI5A/s/GDXj4oI22RbZr7NtUb23QSDY2D3ac78f5KhkOdhdO?=
 =?us-ascii?Q?pNu/fNybLgRlRFU32DSh9t8iEAnwS1cPfswvPn9FkKJcvpAfnmEttp22SrX3?=
 =?us-ascii?Q?7SuuQsHhKLt3Od3sSjhlJxXGXiPA35HkBkGgNJeY91BB6o86GtsAa4FpLdUe?=
 =?us-ascii?Q?w8HmMsuOCQDI8Ceg3S1EPaEEDaMQP7AWIn6KX2l/kSM4RL8OwDvmZHu5nViM?=
 =?us-ascii?Q?WFjLKZlvqr5BZsdhy9sIcIvd9f0LLvTqRzZuU47NBVFxSjWMyd9gm97pdz3+?=
 =?us-ascii?Q?GvGvMl6IWpgPtVT7fIDylexOOUDA7VlLT889ha2/w6yv/U8uOTKJ64JhOzoT?=
 =?us-ascii?Q?8J9RGHA/kVmr82zc6HV+h12xMGEmXmLLQH/mbb3TPGkDsIOumwnHcRO3FiVM?=
 =?us-ascii?Q?F9/QDwBVP82lMwxIQTa9P+IIK+JnhvCv2NdbB2lrSTVMiWN+AedRdhyJq3Vn?=
 =?us-ascii?Q?TjZquqOzJQcB4BVF2Sy3a+qHWqxLsiAJcRkF26IgkSETD9M/J80NbJUOfOJ+?=
 =?us-ascii?Q?d24SWUOfnmF5PHEDa/c3iDI6xyEb+MAyivFxrUXMqoZFbtX6R+HIvXP8Ta1I?=
 =?us-ascii?Q?03uaTKwzwZ2rgTPlJocyd9Ed1biL2EiI4yjJQ+Ln0GvdMRBi6ztkcosDKcp1?=
 =?us-ascii?Q?MbOCna4cSXcK/RXPH2CdQd9m7NyrRN+4qc6Ho6smOpSwx3m4KX2CupywkcSp?=
 =?us-ascii?Q?vg6RtMzW+5solgKvTkLvQfc0mqzJUusGrCtGM2LYWxxHg9srYE0+zAokX7vo?=
 =?us-ascii?Q?mJM6iZqS7cd9kdY0NmdOowPsMWlxS9Hbyu+iB4DckTujjtZsCMzv2dXj3B2R?=
 =?us-ascii?Q?UuAKaQ/pdA247MhojK8g6nFadk/a8KsMWfOmgFYygaGr7nnMqLvZxSTIyLIV?=
 =?us-ascii?Q?xRfG4m+dDP+glG1HnEEuyHs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adbe88e-0761-48db-3134-08ddffc8daf8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:09.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: II9r/5yNGLHrHxbpzSiD6vERwhj4by+Ts8k+Fcn6F3K9r3gA1rvYKNQFStrbTtPHQe2As0dsLifyMCpNYwubM50ye585vhaPrBhK1BGJZDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

Booting without this patch and disabled dirmap support results in

[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[   13.356897] UBI error: cannot attach mtd1

If dirmap is disabled or not supported in the spi driver, the dirmap requests
will be executed via exec_op() handler. Thus, if the hardware supports
dual/quad spi modes, then corresponding requests will be sent to exec_op()
handler. Current driver does not support such requests, so error is arrised.
As result the flash can't be read/write.

This patch adds support of dual and quad wires spi modes to exec_op() handler.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 108 ++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bcc464ec9c61..fffed26ff990 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -387,10 +395,26 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -895,12 +935,28 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -911,40 +967,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.51.0


