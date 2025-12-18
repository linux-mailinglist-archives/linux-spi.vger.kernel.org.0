Return-Path: <linux-spi+bounces-12022-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17452CCD595
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 20:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB812305A628
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A4312825;
	Thu, 18 Dec 2025 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nbqjjhJz"
X-Original-To: linux-spi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C730F532
	for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084917; cv=fail; b=iWe3vXrmjzxaJIv8H4BBrUNrQ99F+JJctecIvf8qYMGsz4UxKJJKSipBbP03uFaTsTUOrd2ZrXZxbyHCW0OlFSe70bhuW58tLmDbnWMyBoaJZ0vCiTxmjvMPfT/G+zbI0xJauxGtH8yTJwXKkJocV92zaOrmH2HjCRJDIVFHyaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084917; c=relaxed/simple;
	bh=ALf2bUiun45CnICjo8IoIeJ+ZOdbH5blMFhfQUgDTc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwsfYL68vcjnF+5QCzvFPH+yIge+3g/chp6YlgCYAuHVwcMdN3Duq5JAZQoRKaJ6rnwCyTm/96uOIBdP90n0kcwkEaFFB2lfFrdl95kfpbdrtTDeDJAf7bYfG2RJUfTJEKlJ14G869x0OMyTmJBhdcNFMtfxpRotFUtUnIDLpHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nbqjjhJz; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmXao6FCxf+OjupOh6YiP723xaD3LHoxUfeThDJBZP8mtGNyrY1u9CyGCbi3JjyE3t7rMPe0AorVg5tYieLJJPZYf3FEgbeMbwc6Ogr1cwaAJ6DRqAOcuWXlHGobpgEmpOAZBveqKUk0bwtdn3QpNiOiyC8UpwpPCc+0YZ9JvkwVi//j5wdlsXAnY3SBG6Fp53vXYu652kpK4M4dHBu5/e9v7rBex+XStNIN9HM+3Uvki4Ek6ePDEFHAxu3x7cSenZLb1QYKeCbeUlw5Jhr/W9ocsOURBQ7/C8CmqWaXRUwn2hHhXjBR91MrSQoUKai1wxshLXGu60FmDsq35FoGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy+0DLYMcxeelzv9B/nBdXEFo64pf4KBhuTSjbRVVNc=;
 b=eYzwyZw5oB8gRupsvFVwNQz7TJWtponmvbh5/a6+0ijQ5bpiP7QNqFqLajKVSLupY5dwvUa6yBheBSHqWUpjpRFdCAbsGrjchjeSqLVP4Mc3vXb1G26UA9YkUFPlwMQpRyJ55bGIlT0admWAFFQaQ8WRa/C1mjG4TQY3jaK3XhSW3Ntipr1SX7NvcldPvjMqUiQ9VODmdcWSkCwiPXYQZYTW6sOvID0viOvXo6a7DhCgFsdeOCsZsTFM7Pr5CfmY/L9inwKWfAGakFr8rEGhqDQieno5VfzGghxWOk1V5N+hhfW/VqOphaSISJqiDrvSACSsuki/qptILPzKQ+jzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy+0DLYMcxeelzv9B/nBdXEFo64pf4KBhuTSjbRVVNc=;
 b=nbqjjhJzb6U6p2fPOxmIASzcAR9Q+VeG1PCmBxlEBUg00U9jCLmZ9yTyeUhvkGlKOJB2cXnequpFohTKU6QY66aVNqHL2XidB3mxPQmtT23ASAqwz5femWJBvwW3tK3tx6NaB9S6dbAtOLI0pXJhxGNAgj6wuWzUIRkYnRE0SyA=
Received: from SA9PR10CA0012.namprd10.prod.outlook.com (2603:10b6:806:a7::17)
 by DS0PR10MB7296.namprd10.prod.outlook.com (2603:10b6:8:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 19:08:33 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::5b) by SA9PR10CA0012.outlook.office365.com
 (2603:10b6:806:a7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 19:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 19:08:31 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:08:25 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:08:25 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 13:08:25 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BIJ8Pua3863343;
	Thu, 18 Dec 2025 13:08:25 -0600
Date: Thu, 18 Dec 2025 13:08:25 -0600
From: Nishanth Menon <nm@ti.com>
To: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "afd@ti.com" <afd@ti.com>
Subject: Re: [BUG][RT][ti-j72xx] spi: cadence-quadspi: boot failed with
 rtmutex deadlock detected
Message-ID: <20251218190825.oeucrspxenta2oix@steadfast>
References: <CO6PR11MB558695EFB87C578370014430CDABA@CO6PR11MB5586.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CO6PR11MB558695EFB87C578370014430CDABA@CO6PR11MB5586.namprd11.prod.outlook.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DS0PR10MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e49f69-a143-412b-c732-08de3e68d562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5GeSfWeezU+co4FHCy+Tp+NQXrEIxYzdHhe9O5Ok5i5xMYNT70cphEQ5C/MI?=
 =?us-ascii?Q?cwo6M1os7y2vWj4ojesidFhwDhRmkxCD0nIzjKEyODt+vmDF+bwoZZ1RuO1B?=
 =?us-ascii?Q?wHloGDnaGTl4JkyTpgQ93cucSbf9N2Zw6Ygh+btcQOZACaQ0jnHaVoCd+Awb?=
 =?us-ascii?Q?KzndkC8rJYvi3LAhryyWQ3BwuujLNRYqnveL6WIE/9vwrrUu0AFWgonWyouj?=
 =?us-ascii?Q?PzSnTUEiXHwOAmhcUwW9A7msGLOkGcMcLxIeem37XKEzMGgE77n9P5ubSAH5?=
 =?us-ascii?Q?lN/lSUi//aBJpYh6u8X5kGJh5dt6obYXBFBE74eOzkTfpdVOmsHozGF4oRrd?=
 =?us-ascii?Q?2ZP197KKVeTSnEsi5Pt3YXjShjh6dbi2aw9A5EDb0ZQ5Gd42e6JfRM1DeMLh?=
 =?us-ascii?Q?KstrBhXSrVtRtcpYd4lDJb/69P89p3M3Grv4h9kMfZ0uTZHO8a4kQAoz5hMC?=
 =?us-ascii?Q?/Fc02X4+g8ldzfuoo7B366Xdsl3dAx+9kkr5hH/3Zp3pwIKYdxA8UXCJaneb?=
 =?us-ascii?Q?hKt0LLQFKHCDoQzBcFS+6Qh4nkiNhEeBLjTJzgDXIAobGdM1JYwhlWgSjwGh?=
 =?us-ascii?Q?mJCaNerRjdFkAhEQpSFD/lR9/4aAtVosRZUuJGL7SH7GeiVk2oV6yYatHjFM?=
 =?us-ascii?Q?OyYGhaY9ydImj+ArSCB3wq2kqOdmvex4k/rDAI+L4PD+UM1T8+3voqxn8kEj?=
 =?us-ascii?Q?8uDySmMHj81kR1pbWykRXmNmhxdmse3b7z3e+EzXtRm+5Y8290G7OCqCNP6K?=
 =?us-ascii?Q?gQOQq7v2yAS2mK7q5xlRdRIDz2SnY9mQuTFH7vho9vyKeno1wOiwFvxw6m5a?=
 =?us-ascii?Q?mUJKitNOBCArDrtSRlLbZCtf+qPiKyZIhfUandfFXPCdIQ0PVX949Rsho7x6?=
 =?us-ascii?Q?O7iwZGRaQImOXVn2z1Mrt5jjFySsaiE7wBP+ySAB/JqsfejtXdh82wkQCuJi?=
 =?us-ascii?Q?aRt6qq5yAqhr7RLDk6X03ikNlxfTrfjg4baMvFhbHUUZsb/s+2aHkBgIP5vO?=
 =?us-ascii?Q?216d97NC6Rv3WZY2IDlb+kdwVEQPWZA1JZZTuctAhx3dUU+mRz0pBavVCZgY?=
 =?us-ascii?Q?ZHk+dtYE9TZKqqrWebKnDMXdunMNjx82bmA8V5QRKsZ686O4uQDMlcIMh/KH?=
 =?us-ascii?Q?hQx9hi5O8G6KYJrN7bie1/5y23Ehwh8b6ZQpJIsxy1Ux45DrMUtXZcC86WsJ?=
 =?us-ascii?Q?p1zk4OHR5fJQeO6ee9dhBJTFHm5iUljlxatKKhzspNp0nkNzftF0CQJh4qG0?=
 =?us-ascii?Q?6qn51W9UrrFktp4O5pBHcvo76pDU5L6gQ79XK9M3EmidLEzr9iceoRizbI5Z?=
 =?us-ascii?Q?PakRKVnhNKdjB4ALkrl8eqZcfxNrtaNAKGcmXssgg0MiCKzp3WaIBdP5As6Q?=
 =?us-ascii?Q?XSfmRXpjWItY91TDWxBhXzuwzGVum7A7ZkSzxKt3bGN5+lH84ik2N3JE1N/y?=
 =?us-ascii?Q?J7Qs8IfU6UDLtV9ywiYBeGum1/ltlmD4nCGsaiAQopGA251zHzHFOmvy1LiI?=
 =?us-ascii?Q?4+W+YNejY0tdrU0MmZaiC+AEG+SRD6++ZU78jNm8cdB/uNsOLJQf649JWm9v?=
 =?us-ascii?Q?ktrPI7JiziOoAa6hpN4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 19:08:31.0461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e49f69-a143-412b-c732-08de3e68d562
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7296

On 08:21-20251217, He, Guocai (CN) wrote:
> Hi all,
> 
> I am seeing an reproducible issue in
> drivers/spi/spi-cadence-quadspi.c on TI J72xx platform.
> 
> Kernel:
>   v6.1/standard/preempt-rt/ti-sdk-6.1/ti-j7xxx
>   (based on Linux v6.1.159 PREEMPT_RT)

^^ sounds like TI vendor kernel?

> 
> Platform:
>   TI J72xx
>   QSPI controller: Cadence QuadSPI
> 

Will be good to discuss vendor kernel issues in e2e.ti.com please.
unless you can reproduce this issue on upstream stable or mainline, this
might be the wrong forum for discussion.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

