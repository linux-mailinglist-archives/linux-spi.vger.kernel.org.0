Return-Path: <linux-spi+bounces-8437-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B04AD45FF
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 00:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E2189C301
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 22:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293A25D546;
	Tue, 10 Jun 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pcPhDUXT"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9911442F4;
	Tue, 10 Jun 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594708; cv=fail; b=tz+SyYWnb45jBk5efkMlyC/70PXv8DQjr4wEPQCU/VHvWivejw5jnRTb64/pm38kuOOWgawMz43pQMjfuZ7NQXMSkolv+rXeu54F5i9TpPxqRUUsycShGA44GKIjslE5AjvdlakOcJ8NSMGH8XjOM4O9o9IQ3B6m+KbzNfJaRIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594708; c=relaxed/simple;
	bh=wiY5CorgzM4QcGwmEf0t1yyokqMbYyhDOnz5RJeQdAI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jk5Qba64CocTH4JWvsuU/VkcgZDyJmz08kXoUced0+FoTwGoM12e7WdcsuGWbJeK+F088A3WABHoSDhU7jVYP4lwZ/enxTCC2MXfwbDEAlIVchGw7T+wTIVeEi/PqQS2kY6INS8w+2ruIpQwjl5x57IpoGkWPu+Ka9nOZRP09fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pcPhDUXT; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcoBRNCU2tDsI2x6HL8YWJ9TYSNvVkNx0VakD79i1kRJs6AjaxGng+9WiWMKx3iRFGqaBl8H1CqEIuJglWacgpyfblvF/mJ9+5qF+L5dzwYjD50Z4z7obD56vVN/S0gQemZO7tQzIaiBJsCPMxA/IEn04KiRVse7GBCqdppaFGpYqVQwbpa97XWsuLGE5SnZQBvW+NJVwWAf8Ol9jhxDkBya/U3XXiJvZsZlSc4H2PG2mFFTH1nrgUDCUMi6hZHBTqBTpll07BV+hawcN8AWtgirRU1op1TOLvXOY4tBTMCZb0icEXMYM+0XOaE+50SzxL5Q8sHtETzJK2i5N61R1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgEjPL4dPqJZGO5LJV9vU7Dwya8117JGidtDk1lDvuY=;
 b=D4978jAJXcV7GaDdFNgQuyE7gxsowaXEh2cSCOXYYVO84EKzKDH8jOvqCtNbCPssmOGbABUHJ0A4OuHKMUoVPmxEcEolXa/GZBnLqID8Z/3dsFDK147Gap6I5sMOzZOTg6O8ZMO2nPAob3vUcRhAfX6GSh9NbADEOty7TOOLFj0Prl5X3IvQILYeeWOTb528AE3oBCy7r0BZFwkZbFDFipCgZk9DUGxHUU0EaYvqFdQOo9ZKi5teoiSYGlIUYo0jJ++pAY4rVY8NtAsiKmNQ94ihr/L9w9ghFiR3nhr4fupbvRSkQrxcmyCWsB5VXuGVubrIJW0ghY1twnsDMbr2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgEjPL4dPqJZGO5LJV9vU7Dwya8117JGidtDk1lDvuY=;
 b=pcPhDUXTP7fsHPNpLASElmF+kMcbRsCwD8j4j+IsiDZUY+IxtBtvkzWI4SdlRSRKh5HGBD9qHXc8DVXuJD2p0iRNciUl7a7UBdsBiCz3/zvbwf/w3+IvUumLT4gpPO0bnS6P3jr7PhEft3u3dMIXUpKjwSkWTwR9zIkbSB9YJ3tFkIBKIvY71Ug81n8SQn2w/6OG9Pg7nlV7MwTi5qYYg6Ec4cCqL1IDB7Y/SWev/Tv2HRD7up+/TzTsDrXO+LDjUbaHZ15yWUrZCMNc0oFaaeFYhSTPDX5/MpKOYp3oOsm7riEaz62XDirKyNDQXH8x6TKsjMw1783rs0JtjdEW0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by DM4PR03MB6029.namprd03.prod.outlook.com (2603:10b6:5:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 22:31:44 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 22:31:44 +0000
From: khairul.anuar.romli@altera.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairulanuar.romli@altera.com>
Subject: [PATCH v2 1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Date: Wed, 11 Jun 2025 06:30:19 +0800
Message-Id: <e1ecafc55f7fc1b2450f7c7ce0c11b9efa68844f.1749516352.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1749516352.git.khairul.anuar.romli@altera.com>
References: <cover.1749516352.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To DM6PR03MB5017.namprd03.prod.outlook.com
 (2603:10b6:5:1ee::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:EE_|DM4PR03MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9c11da-699a-4787-262b-08dda86e9291
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a6LZuw6JNJirwaG3N+CflpPyhiavoAEdunigY8rMF/lvvm01V7bK5MS2KvQe?=
 =?us-ascii?Q?gQaugjzN7MU6CpYJtf83SGTkY5UKp3MXIXeqMJxZqS0grMTDOA8nwK78rJZo?=
 =?us-ascii?Q?d1OV1kgqZj6uq7R9OqD/TpnHvOpNAbmJsojEXEPXu4mi5YX81K+XNnd0Aa1m?=
 =?us-ascii?Q?xA4tnHpCnQCwHbm+BK7/7cDOwj91lqSYvrKkvAjfRlNJxaZXX1+/US5Ms4lu?=
 =?us-ascii?Q?+SPahBe9RSdBwQ40UA2VoTwcrMbTmFwmnYl3dVfIHvqrVQ+4qa5ockT1Mmvy?=
 =?us-ascii?Q?AUU8JnP+YAEluBi7Q1Hw5Nz38rjeA3HbjedAafi8mOBvQwL8tBrF+HRSChmX?=
 =?us-ascii?Q?c2cLxdCWEcdtpmcWupiGRlNGpFZ7PD3Qh1+VDe7emqzsMtp6XqQUlmFHG9+y?=
 =?us-ascii?Q?2fEitYFbY//PJBR53O2r0IaElDlzlsQNjgUoYkAkPJjrDJBG3h/Iya+8g5Uz?=
 =?us-ascii?Q?+w8zvOEkaRxKjXVzg+OuebUT/kk6AlZjbeBssYyUXZMaMMmZfvExQTahY/iI?=
 =?us-ascii?Q?NzNCPzdi/AuSx3tMVtJtKo7hVwwGwfrbTlN56adbDzxY7+PpRfZT+cg52GWY?=
 =?us-ascii?Q?vXsVIrR/PMUiF8EIPkjl6J+nimjEXAgfxSMBfccuIYamFfcMI//zujL3qmgX?=
 =?us-ascii?Q?1r0rb+yOcNZhMipcLeD1HjDusTPuKZi6SklHq+1r2xiMK9clm0Rd1KcmlY97?=
 =?us-ascii?Q?XJLwHK56638OB5S/u1cN6APOnxMEP43yztzcE3fiKg5lk6417pjHBwleZk5W?=
 =?us-ascii?Q?E9BbrqwSSaJIZ5CK7F7axasCUPjzesVfKlyFZeDSHiNueUPWrgiE2xdFR2Lx?=
 =?us-ascii?Q?f+6uwXbTvKXqI0Zch5iD/BCqjyH4PRrjVMR0qg3IZfCtskxWJ6Yafv37j9Cl?=
 =?us-ascii?Q?qmZbSp4pgls1NitSMDuW8fed55t0GGfjc6USpFpfWaicO21xvDXvByY5+57t?=
 =?us-ascii?Q?sUM3uSlZwwtEgJ7OF1Zm02li13ICsfdLXHRMFS7Q8DC8XpohTh8G59vw0UoH?=
 =?us-ascii?Q?JmrfV1UcUZOZ60U9v7lICfRu7EAG+5QJyGPglOZo0w5/Dhi+CK2itp30grG8?=
 =?us-ascii?Q?DhMQZeV7NpOwSazobD2s8j7HvPAyx5hVTouwiYn7HX2vmwJjeGnfQ1G3dyso?=
 =?us-ascii?Q?9Xgbzd6Suh7kVa7xHBzIBX+waqlRg2MQD7BnaiYjyJcX+yIUdIi+WBpQn2et?=
 =?us-ascii?Q?IJ7UiI0A/K4KV2SlxtzjDQWZigZfzeuluCR1tQs23weSjT7qAZpb6kzeiBYw?=
 =?us-ascii?Q?b5Z5dC7uhXaQ+HycvLohC367OZ/FvGvSM0IM7DbYy2Ge/dtRReUuLTlQB2+v?=
 =?us-ascii?Q?q2vl/7HfAQjI4tPEFD9WDdalPCTRRR2Dg6/nS5BBvEQel/a+9tCfAJMgv/p3?=
 =?us-ascii?Q?BSjDXDtzwh1anR7b6w0Fmq+r+OfHzvElgs27affL0lrHOZNLsvB8dnC6b/Be?=
 =?us-ascii?Q?BfmsqBSj28c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6S/zwgNA1xdCtzXspksfqUjbbzNMKLVo4rdcr9+v5YFXXliEgHWJB9vBfRuC?=
 =?us-ascii?Q?0yTWe49C+v0x4TiciCKsIQIfvaVFg+Mwrf2Ya5Hw1zITLi5YtXgOoHsSZv49?=
 =?us-ascii?Q?mq0iCXq7m3Z9JReRkXr48eK8JcQ0LsLS+wDz6F2Bf7pGlk5i8K08L3x2nQ2y?=
 =?us-ascii?Q?UkS+/+hrirdjPPYb6j8N+3BJ/p0nt0BaogJCCN/SGsjJQZKF6gv12P8Lg4a3?=
 =?us-ascii?Q?VaWUOK55ByhbD87LGWyffkNaXDK3hDOV6caurtexcVp12CbTUh7VqjDG2WKY?=
 =?us-ascii?Q?pbpwGGTY/xzFNY4pEs3AbJDO/my09Ap84/H/QRZNOmMfrComUQV1ZDGECd21?=
 =?us-ascii?Q?+JEAMDBDjN7H07FZuk7xFipM3cw0twTKUkJYkZU5y9HkbrYiPlKXJ/DymK6F?=
 =?us-ascii?Q?Yvw5E1j+1r9yqzx310Hj2/ynrhQxj0emrqmL/zh2AlE4JHjJiHaW/uJZTNNL?=
 =?us-ascii?Q?7FjaIIBXxZLbaNzcKNOOdVbkcmDtuyMNezARrMcT+11RM99zsgfIyEWy9nNV?=
 =?us-ascii?Q?+GBgXRc6pOLYAGxUbERswGc6R0GZqrWLQRUqz40kWhTD09pZPZWcFlg2tU4l?=
 =?us-ascii?Q?b0tra0zE8SPBTkt0tV2nHJfl6PtBp6k82/TUOBXqwy+/W0JhzXdF3b1DwvXi?=
 =?us-ascii?Q?afOxm3XxyOBN5QQxZldpm2JUhQR+tewsZkGGA1MgM8PvAaWg2eNnOgxOmD0H?=
 =?us-ascii?Q?bt4SgqsTauygadoI13KaxingO5gElZBc6wAQbBXiYF8LBoqsSRiZHt6k5TBy?=
 =?us-ascii?Q?srlUcm0PDcq8u4gIN75x8CHSx38sceqqYvptvGwfxYCjn9ZXeaxNZ2Ep5diT?=
 =?us-ascii?Q?MabsPWwGNnB0fE1aIN+44QSK5FITpTBDc7f4lhD6YA+tTFDRFOWzLUQePio9?=
 =?us-ascii?Q?IZqnjCVMxGUDW/B5pZIpbLE9cTRDKdDL7Al7pONKHjh6sRkIDok9FmQ/Rw1S?=
 =?us-ascii?Q?7s/XRKMeF0k0axThzisCSCl/4NtIan8ajYBIDFtf8GGUTVAJ+PQEIAn716HT?=
 =?us-ascii?Q?b0Y301/d12QytD1Xhgp7THviUwwu3pLFnOieOwRSSvwrC+rJa/kYyPTMB/Iy?=
 =?us-ascii?Q?FMeEm4p36TdHq+GtetTnai7FQX3QqthpgfCS4b+L7aM0NjSn5YMoNEf3ODnE?=
 =?us-ascii?Q?ErNbNRcub0atk/QDoZTfYV+v+44KBCVjjqv4Lw7djqAUDOhpAaBfL9bGYQeL?=
 =?us-ascii?Q?1bljovr7UChMG/ARv4e9EzrS1ZzShdgBiytGfyZWAnccwWzYPfgL1iYaOHY1?=
 =?us-ascii?Q?hi15K3E70KzGQTCK84rcMkPGdORMDwBX5zm1O1+ZteRI5MuriioiVoodNRLq?=
 =?us-ascii?Q?JuQtatjT/0ZZfhBx5LMjrhILK6c15zzBmTurPPMWZ7AeWz8EHgUPonjYX+js?=
 =?us-ascii?Q?usg8YTIo5ODnWjrnANYpikfc991V4hLqHHir7PFczP1lp6/hAy14Nk/cUgKv?=
 =?us-ascii?Q?viM07sZq6IjMSFiNEqGgO9Lt5b4V91VyxT82ZKT5BknyoaBRRZ7vRmwVyz2u?=
 =?us-ascii?Q?M/NmcSX06NfCAMbzaPPFMp1SU2/PwQadxzF6DAR6TCMv4XS3PZaZ2Weat+Sg?=
 =?us-ascii?Q?5INiWnq+iqSC8/mz5kmpMuFsLdrwnVkJq6AOBv/JVZBVODmcJ2ldaUu5cSCY?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9c11da-699a-4787-262b-08dda86e9291
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 22:31:43.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGNYOfSUN3wnGSdJsXxRBUVbX0+HIz2jn3Pr78ce7BUGBGtNhe93qKCCrPvHf7AetapqwKbliqhWzT6gcWc/U9frBbmN5mHwJoi/jYSWlbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6029

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Having PM put sync in remove function is causing PM underflow during
remove operation. This is caused by the function, runtime_pm_get_sync,
not being called anywhere during the op. Ensure that calls to
pm_runtime_enable()/pm_runtime_disable() and
pm_runtime_get_sync()/pm_runtime_put_sync() match.

echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
[   49.644256] Deleting MTD partitions on "108d2000.spi.0":
[   49.649575] Deleting u-boot MTD partition
[   49.684087] Deleting root MTD partition
[   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!

Continuous bind/unbind will throw Unbalanced pm_runtime_enable error.
Subsequent unbind will return No such device error while bind attempt
will return Resource temporarily unavailable error.

[   47.592434] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   49.592233] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   53.232309] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   55.828550] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   57.940627] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   59.912490] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   61.876243] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   61.883000] platform 108d2000.spi: Unbalanced pm_runtime_enable!
[  532.012270] cadence-qspi 108d2000.spi: probe with driver cadence-qspi failed1

Also change the clk_disable_unprepare() to clk_disable() as continuous
bind and unbind will cause warning being thrown with inidication that
the clock is already unprepared.

Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/spi/spi-cadence-quadspi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index c90462783b3f..506a139fbd2c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1958,10 +1958,10 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	ret = devm_pm_runtime_enable(dev);
-	if (ret) {
-		if (cqspi->rx_chan)
-			dma_release_channel(cqspi->rx_chan);
+	pm_runtime_enable(dev);
+
+	if (cqspi->rx_chan) {
+		dma_release_channel(cqspi->rx_chan);
 		goto probe_setup_failed;
 	}
 
@@ -1981,6 +1981,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
+	pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1999,7 +2000,8 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	clk_disable_unprepare(cqspi->clk);
+	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+		clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-- 
2.35.3


