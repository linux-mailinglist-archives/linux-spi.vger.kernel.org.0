Return-Path: <linux-spi+bounces-8359-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C64ACBDEB
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jun 2025 02:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FF1188DF3E
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jun 2025 00:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF532C3271;
	Tue,  3 Jun 2025 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YC/8S8HB"
X-Original-To: linux-spi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A2173
	for <linux-spi@vger.kernel.org>; Tue,  3 Jun 2025 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748910115; cv=fail; b=SO3tv+glMpfgE+kd7/FdxidmqUeZ2JA8bb4WEuxupKoDH2OhIbtWo8grZwHg69b8gHiSJKTB8z1ab2lLToka6jdMCvofsiCxPgwQNICmxZ/HJm1P+rMSFwAsh+0bp1RwDVfgukM0Y0/K2YAXJLWIQf4Zza5iV0iBsT/+gDEYymU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748910115; c=relaxed/simple;
	bh=wZdwDMXRqMMovHC7d92fGhpUHz2zlMP6edhTfPWntGI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kxB+8XVWFvz11xY3W/Fh6AgQFZr/Bdv3mgtx4kb1e0r9SApZwu9QNS6ryfPr0nFTy2Wc05111UzD3RCjivPW2OZ4+LxUU2qSLR9jwjizFEPM82ANzfYSeoAAbxq0GccGlVgUnGh2n7gP4OXaXB1mJ/lQli4jQAYylBA60cHEGBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YC/8S8HB; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kY0kviht9Kk6wOGkgooRHCrJZTk/VJqg8wXMULS29hrauecrv9zjHHXrYHKJfQxw7A6O6ARDOhktV8a7+KrdubQrr4ecGQZ/CBbpYr/I/DjC9bI7pUm9gEdCeVNs8a6oxNysIK8Z9QT+Z1FIfyxNfI0elUjC8z+//GD/9CaZJw4ko+jHWRjX94jGK1ulB44Vh7lbgRY1329xtfjFfFCv/+kcuYMW9bnXkcqgGU1U7ey6Jc0M+38Z2D8A1fDzLGRAQCIcNDXnB3tNH873s+Bk4xFlIhE3iIid7Vev3PJsygJ5xMDtlitAL2FFfp7maF/KcjCKltSGvoBnbReqhIxyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3uddsPxfGYclcTmDz67i3jrg6aOYwm2fTAfiP0a0Xw=;
 b=hrJD9RBQTtgp69lxfDqlZ3l34155h54cD3QD0G9fgbzyoF61p7yLyGxiTIRaEZE+JM2L8mPCm9jXnfB4jQDvwrWfRKTiuIBu3dU2Ir0hn7ucWlGUKZHOvNIQblkYqhmrdODC2sivFQwjRXyuZjXr3PQ1JFOQ7wFspLKj7eCfK36nEUwKWg9iduiyE4R6k78C18tJo/ylReulinvLN9S7lL6w27Qkvlw9KpYnrtVqLqNapf2KklTPV+rxSlzosfh5788vSdzjECVe5/M+uHaljwHu1SR+plXhgTMVd0lqhXLhM2BcEcezPrGwA1mcEgUjWkC5nREgfdrMi5ZUOGsp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3uddsPxfGYclcTmDz67i3jrg6aOYwm2fTAfiP0a0Xw=;
 b=YC/8S8HBK1JRnztX8apVY8dXauDQBc70Y5SD016ij9K6TytShOwFOSI9AXk/zC5wzv4nBFRlL27G8jqLZ6s2/J2zCd0/8VcYGLgA/4Ye21g1co2LYYSAw7qkBBU/c+b3semTQOjg6pZvZAO3QUUBNXTcJ8P6g9dmg51YP9KYlHEwZg9BH6wUSbTBzV4YyfrBs5t/1AYNosG4G82+v13aHRfyPDTU3cZ7zPxXVcu1c1/DM/MoK7Q29uB2sSZMx9Ea6R4aFZ08fuTSgIL8/Ipgge2ik7/ML1vvPS8yh0tQqoetonELAH4GmXTYf4DK5xZQZHlWFdjvi1n56Tj4/iAaQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by SA1PR03MB6434.namprd03.prod.outlook.com (2603:10b6:806:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 00:21:50 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 00:21:50 +0000
From: khairul.anuar.romli@altera.com
To: linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-cadence-quadspi: Implement refcount to handle unbind during busy
Date: Tue,  3 Jun 2025 08:21:47 +0800
Message-Id: <20250603002147.10584-1-khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::26) To DM6PR03MB5017.namprd03.prod.outlook.com
 (2603:10b6:5:1ee::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:EE_|SA1PR03MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0c804e-ad8c-4acb-986f-08dda234a276
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f/axcjP4b2B8Zny7+/EifHUJ7ac7c23MRwY3Fh+RDHOqsN6bEUIhOZH6FAPN?=
 =?us-ascii?Q?V09RhyQZMxw6F3iCURXGm22//tvO5TuAqG8lalFNKzmDIJYcNzuBR9YnQSL+?=
 =?us-ascii?Q?UksTni8vMrLaLRj1dW4pfxaHGJhYfFMY+Vh8Vr/7f78uTsElQEk7YnUgghVR?=
 =?us-ascii?Q?lc4L2i0rD7dx53eLsqzpkE6DGiEYtQ7OzISbPVRf95k+fBURrKuw6AhajNrY?=
 =?us-ascii?Q?rdUi+JVsnk9tbIfYrkoNhImeN12UAOokDpPJFRQWvr3LAIyJ+r4G8PiLTxEU?=
 =?us-ascii?Q?d4fEl1xThdgpgYRP3AFKaNP/jaISOFpvbscKFa1mnnoi9RCySOApfYFsb6pg?=
 =?us-ascii?Q?+e9WLjR9DCgMJE3IihqMxPatwWslkkGdUNyf3M2q/sUaqvd1PSiAoar4zkbF?=
 =?us-ascii?Q?LD19dcTv6eA2WWE2Ls+4Vw2uY2VZA0uO3MWlSBdUJb3lY5I8SFAMEODScIPw?=
 =?us-ascii?Q?csRTczSqnXA2XECgSoOgS1fYxHk0wJThYXASSaahN9pKkIIPMKkFmJ4aA3u0?=
 =?us-ascii?Q?koReqI69PKoUHqPs2Jq/tYME4t6gZWeOrYbv77JrlCzuZ+ArRPpAnDbl7jgc?=
 =?us-ascii?Q?k1l3UpAg+V7zMjLrIy+VJZfvVwSUVbab6t4Gah6P6GyGdKtPx1acAZpsOlEc?=
 =?us-ascii?Q?LmmCkYuw9BsiDfT99jkoJtzpv3kmyIuJUMcbDCuOsZKfo9oMfhZ3cnWgWWBx?=
 =?us-ascii?Q?WKihaawsHbZDMSDRfegZLElGpYFvQXR45OhHtyH1OCbN/orCnTS/uw4TgYMq?=
 =?us-ascii?Q?N8UdyKHSXDceG6Mrp4xbhHPnRfljw1stYtO1slj/RRGhjDT7jO7xfxgHu/vc?=
 =?us-ascii?Q?SgAAn8FIHcZYzxtnIZ/Kgv8t39pSbFEUI6ZePBS13rLJJ5+svkX5uI+xC4Ru?=
 =?us-ascii?Q?iMSPEgN9Wb3df/wlbnnmJJaPHdZ+TE3jynpkBI/oSyGR11JZJtt/SSsKvAxU?=
 =?us-ascii?Q?FU7B2S9vrViw8J7B4mEDaGinmwXFZGrPMavXpxFlJwkC0HY28v1HcHB/+X7c?=
 =?us-ascii?Q?tLPH0MexqrErjmp+gQ9Rp7XrbMMzZVxchmFKvRk1N5WBDVJbyn9xTtQls6Nc?=
 =?us-ascii?Q?PGiOEC4SO1j9QRe/Hb8d7LkYkPdkOBHHx+HugWA+SgKdc+0wOilJmiM88XIb?=
 =?us-ascii?Q?ZhTDucKeMQ7TzgYveN5WyrcG0swop389/ooKbPdcLLn0GpiqW/d9xW6pJpi1?=
 =?us-ascii?Q?5kBG6HnpW6eraXVgCi4aMZ1a05Yb4c30uw0xatNjw3dee2jN5RW9B87m9OUR?=
 =?us-ascii?Q?AOx/ZHoCgTUVAQPHx4WHwckfgxzbb5sn4AyLrra9G4bVhqt3/7NO8p0lZ1KE?=
 =?us-ascii?Q?9A200ou75SOkHR3Y4ohxwzh/fLNnGAdaM/PD3chR/rGBf5+eK41iai6Odkgx?=
 =?us-ascii?Q?7TmT6JBxl/GijbHehkzqbUnY3+zIpkxTkVHzHElz/DffvEcfwkGqbmgoiGkp?=
 =?us-ascii?Q?8tRuQAkTVpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gs3mQuxXKW/iafOEI0aBg7msvDnplJD7B9lyAE/KMtWIlC02EscdugLgbVLY?=
 =?us-ascii?Q?SdipIQiY6zN7TmtVWLYWylPEHX4OuobA/RQyk6Jt7cOzfADAQn2VUAdBIUkI?=
 =?us-ascii?Q?JzKKwvbaE3Wj5d/MRzyXZX/UCXk4k8e923xSPGSiGSnbERtmq0b3CIHQq+GR?=
 =?us-ascii?Q?sdHbuTW4ktuO0zTz4LM8JfO/rChi4o9MoyOkb95l2iw9TRw5AE1jRAqk4OEM?=
 =?us-ascii?Q?WaaMZLVL768MsFK9FfA6jF3lSmXyIIPkzHvswUdarg4t2KgX6YY5UwyMeM++?=
 =?us-ascii?Q?LbCBImj1Y8HU1dPfhP9wj7C7MY6FJhmdQoEf4D4VxLuKuhte1A/y+Quz2rsg?=
 =?us-ascii?Q?Uu8n7YIRVAk+YU1AtIuouq58UwSVj+J5zS0fbgjLKXlviQd0AawpO5vETnE8?=
 =?us-ascii?Q?sVcOh6jrTRzZtkrZoWkvP3gyzaztXAdy89wTQhAUSN6ih8K/CF340WhiLq1l?=
 =?us-ascii?Q?oPqXSyfmEchgMzKrIEyI9i6Pc0FW02SEb5orWiPwX/NbirLudIM1izxUDcr9?=
 =?us-ascii?Q?NfEBr0c2mJSS0sk88od4/a+ZRhXg0Jz4P5mLM7eb2Lrzi+HxnQi/LxbHC8ly?=
 =?us-ascii?Q?H/D1ValOvEn9I0aygvlh6CMP1+hu2Ytq7OVpHMN73iO5Rvt/BW9Uw+a1VoW5?=
 =?us-ascii?Q?fw+/sVRU/ff9L+DmVfBx0E2NSa5izq1uzFiPukxdF9CUXYgqMULathYlIXSU?=
 =?us-ascii?Q?ESy4WvutB1WoNMrASru9Lj5g/ya5amu/4PVKfKVBAnlvHF4blVKYvpFjc9Dh?=
 =?us-ascii?Q?PULa7//nMNt+Z/Pm0HaDHnabZiQWqJP2rlcTX6wu2H0oQkhPLAJSNDrxzgDv?=
 =?us-ascii?Q?nCggvKOB0q7PBBKyIVLxLX1KJAUswwih+Yq+xeaDHvC5w+audFIPg//HVoOd?=
 =?us-ascii?Q?X5OKcjH7bGFS2IKdboG/XY53jL9IEW1CyFQj7vAqvorQj8z3C+GksduJeKvB?=
 =?us-ascii?Q?eozbwMGW83G8RqNDIv2AefAMLEXh3TdgX15vCXsZOQHZhjH8SuaY/ExFDY7q?=
 =?us-ascii?Q?bUJZqHVhehGnaiMTtPCIBfPgXOJG2D69/341ZN16NEvYkAWhIE1e7Bv5buPD?=
 =?us-ascii?Q?AyQnaD6+yNklFcBRyJ/64LQqCww9IstpGdEwdkMrJRmwIkoQdT7uaptK94wS?=
 =?us-ascii?Q?O7oOWoFZlBxclljzKd58aNsHLIVzEUNJEBy+o8zm9bp6Sqz3F9c2bXC/rLRI?=
 =?us-ascii?Q?JRTPV+DPqMGMJ12BGjm33nGv/yTzF2QbP0tLkdOnm8ZmHOOX0IuhRI29+48+?=
 =?us-ascii?Q?U90AcJ4elkrKJiadCRwlmj/EZSzMpS3u7y4XQhLMClfOlONiWpj7XZ456cf9?=
 =?us-ascii?Q?TKfZJ/qR4o3xVD0UYSTUVWtxbW+r33NqdN/dCbXZ6Z3xgaKWipA2zJI9lXfn?=
 =?us-ascii?Q?bHnJ2qoKf5I0IvK3i1/u/S/5qXCZb7cpuWoHVqirlNtvPepG10Vdd8daA6Ji?=
 =?us-ascii?Q?a6RwLYCHZwfNzgvoU8uNrmOLziW2DFSQCacPC1M52oIllJymUfRgL5ODt6/0?=
 =?us-ascii?Q?Arz4o+MC742wtM/7WtFtT7cbALweOMFBN6oqfYqPkhCEvu11LxeNP2f7UuSB?=
 =?us-ascii?Q?RbQaBNAYqJ6yDr+asfw8QQkF+kTstcSszX/5XlpPHmFxPw7ogTPMQHhCGk4f?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0c804e-ad8c-4acb-986f-08dda234a276
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 00:21:50.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2/9w72Oa8HRO+pB8PmnB7ccv3FlX5aGzyI9i6eriLbN2ikiRBJL5GOGZytQhYOVTPlk41DWAJdzEVavmGbN/egQXslIVHPrhumuCX9Ao+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6434

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Driver supports indirect read and write operations assuming no forced
device removal(unbind) operation. However, device removal(unbind) can
be forced by root user.

Driver removal(unbind) during an indirect read or write operation
causes a kernel crash. Ensure removal(unbind) is gracefully handled by
implementing a refcount and waiting until the attached devices remove
operations have completed before proceeding with removal operation.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/spi/spi-cadence-quadspi.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 85e5f0304dce..d3a9193c8060 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -109,6 +109,8 @@ struct cqspi_st {
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 	bool			disable_stig_mode;
 	bool			runtime_pm;
+	refcount_t		refcount;
+	refcount_t		inflight_ops;
 
 	const struct cqspi_driver_platdata *ddata;
 };
@@ -736,6 +738,9 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -1072,6 +1077,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	unsigned int write_bytes;
 	int ret;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1462,12 +1470,26 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
 
+	if (refcount_read(&cqspi->inflight_ops) == 0)
+		return -ENODEV;
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
 		return ret;
 	}
 
+	if (!refcount_read(&cqspi->refcount))
+		return -EBUSY;
+
+	refcount_inc(&cqspi->inflight_ops);
+
+	if (!refcount_read(&cqspi->refcount)) {
+		if (refcount_read(&cqspi->inflight_ops))
+			refcount_dec(&cqspi->inflight_ops);
+		return -EBUSY;
+	}
+
 	ret = cqspi_mem_process(mem, op);
 
 	pm_runtime_mark_last_busy(dev);
@@ -1476,6 +1498,9 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+	if (refcount_read(&cqspi->inflight_ops) > 1)
+		refcount_dec(&cqspi->inflight_ops);
+
 	return ret;
 }
 
@@ -1927,6 +1952,9 @@ static int cqspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	refcount_set(&cqspi->refcount, 1);
+	refcount_set(&cqspi->inflight_ops, 1);
+
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
@@ -1998,6 +2026,11 @@ static void cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
+	refcount_set(&cqspi->refcount, 0);
+
+	if (!refcount_dec_and_test(&cqspi->inflight_ops))
+		cqspi_wait_idle(cqspi);
+
 	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 
-- 
2.35.3


