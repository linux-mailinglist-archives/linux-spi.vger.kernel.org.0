Return-Path: <linux-spi+bounces-11771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8ECA531B
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 21:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCDE1309E2B7
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2AD34B1B6;
	Thu,  4 Dec 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O1hHItIw"
X-Original-To: linux-spi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B8223DE9;
	Thu,  4 Dec 2025 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878439; cv=fail; b=iD2PnA9fZuMM7B0rCTycubPQpDmdh8dn7L9rYpd990BsJv+qpkIZkCQIN8MFODLx5eitaXN2viawLYTtasjrLaFzMwovcqo0BAfhovIEuEfoaVg+n3NDTju9o9xVeUv8kOASFDw/Bm/p2uucDrK64spYqVENEvMKCPxtHK7/zj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878439; c=relaxed/simple;
	bh=MpvkAc+KlVoJf+qblSeWLePxaK5VEa9d1VXBWa51UWI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnTHZlKgep/hinmEjBA1X2dj/62XCcH/gh4eI9NmrO/Jn0Lr3eBuGqzkNtyEFyJz8enG8QQjiTSqfzQg8vQQNELhrdxXSvIH17PHsupaXNxgLise1XPn+L7Y4MUlKTuV7pMjDpQ6AURihlU5PvxnI9iOQKiTRlUTJH9yXm5yxfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O1hHItIw; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR17gMavGaj3g493nHOYnqdE0TJnhBPQbs7L855IOeCcouEEV4Pe4bwHLOVSe3Klt/Dff91STg7yjL4cCJIombDLjFdOEurTigPH/McbpH2rxkptfGt7SZ9MNhShUEZFS40pkS3RcFK3AzoYkjZOeK6e8buzoJCsrfzbZwqMYGgfpXuwd4IWX4MxUVZlHwoRz/gsobJ7irSp22JLN4Fi5yIURSpbNJEjkzkx7bSWy2HdPwTYgJlCqpgz4Qy9otkugU3Ms0QES+3Bb0mm19Vh7vs1rRaKQJU+uS/cXcQz+ZGxkLCEfxk7lRL6uh39tq06G+/312owyi+JrX0XgjcZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr299ygOYKrb7ZtM/r9SlyNR+PjJ1Mq23oLjbw7K9qk=;
 b=FROoUuX2ms7kIApdhz7un2xCgcrwhgwQvdx8s8auLbTu0UFwuqQUNYAI58KradpINZaiL21Du91yFK3w3OyzPOs2nEpSK4huHSzzvoEwzgqmhWHyXClJvpXBZOIoI6rHGiL0kth/SczCLrVBLHkbMN5IctvCa9Q54DdR4HSNRSaLPFzuIGinaPiCnwywDq1dEdjwABtLEhk5c3ih90CCFubZ0lk9njy8ch5/DyeWXtv7VaJS1902Lp0IWI69qcDb9TqWOZ8fDg1e4SGyHc4qamiwULP5FoCtcRwEXqKD5xCHVQTW3PioEADAWf5GPkVliHUEAJWWZRo4PYJfAxhaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr299ygOYKrb7ZtM/r9SlyNR+PjJ1Mq23oLjbw7K9qk=;
 b=O1hHItIwtz6Bb0lSGogYhbeiYLogmGDg56vFBj3pLlewQ8sKDOAgxuLsFcrB8OFjcZN4gAJCsiTYn4Bt54Tr8ucmFWcgw8qjxyfSCjpZ6H3/g4wuwLx4l56ZMsVF8GMAWm6jF3oj3aZ9xIZVNf2ONkmPQvSqeNSUAQGH+5faWUg=
Received: from BN9P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::30)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 20:00:33 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::7) by BN9P220CA0025.outlook.office365.com
 (2603:10b6:408:13e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 20:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 20:00:33 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 14:00:27 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 14:00:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 14:00:27 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4K0RMT2099191;
	Thu, 4 Dec 2025 14:00:27 -0600
Date: Thu, 4 Dec 2025 14:00:27 -0600
From: Nishanth Menon <nm@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Francesco Dolcini <francesco@dolcini.it>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Anurag Dutta <a-dutta@ti.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] spi: cadence-quadspi: Parse DT for flashes with the
 rest of the DT parsing
Message-ID: <20251204200027.p4osjcj67bcmsvck@skipper>
References: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: e3634828-1de4-4503-690d-08de336fc89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ITNIR5aE3K+K4IAjOLyaP306XxsOcr+mffjH407qqegHXfqyBz3GbI4kLAN?=
 =?us-ascii?Q?cJe3nml2BYNrHAeDKURnZp5Nu47VKb5841XK5XKwdjOG/MPFERB+ItKx2ZhD?=
 =?us-ascii?Q?Gc1sd2fP5vKNoi9C+8ivzKRHpO8k2ViX2yDyaeyXWpsarsqk+bXjNH4GDRhJ?=
 =?us-ascii?Q?MW8G5PRmhU9tJBIP9mzJJuiH4Pi0iDahJyqwUbenzDwXdv9+l2peru2K2Q2u?=
 =?us-ascii?Q?EWWMq2t7kj+CC8zqamG3CjVCdKGp1VeMMxR4cxcy5IB/vIG5NJN5af751WuX?=
 =?us-ascii?Q?HgSsv45bivH9MTskLrt/1JjeNiAZSLCIf+AU/PUdTAmlpbX3fLeC2UTFtOlw?=
 =?us-ascii?Q?qwmXGqn/ON55uyRMcc5tn6AL2p9NxEuMS0jmnQ8k1MEOk0GjEXFsWU43TXAR?=
 =?us-ascii?Q?7DzMVMc4wp+QqLLHV29UBWBWqcBy/SDQ9K5XJFl8NNHqbTY+bfnpDvREb683?=
 =?us-ascii?Q?EgOdzsXWhmF44yQgu2jq6lMjeX4W4hcDRTVLHtpZflJSXeogt/9HnmoDvsDk?=
 =?us-ascii?Q?kO4pc+G7M3x+j9tMFPNz0lXWOC7sWWpUalwgiLpZjigrjswq4ZLoRWv1yFHX?=
 =?us-ascii?Q?JO4y0DoL/1LPzzvPR7s5y3dgjXbQR5T/iWD1Yt9Osz4hgLIs0kAXM0KeLerI?=
 =?us-ascii?Q?JTFaPXtzHwwhZd0Jpf7ebWt5AREBqO9k07V4ZRoQ2/Yb7qKtJzdAxglIpeQO?=
 =?us-ascii?Q?wVjjU12V1kLR7zmnOQWh5I6qF5IZmWRqZDZfYaPcAKAkxTOzqyeN66n5hQCP?=
 =?us-ascii?Q?InFqv75fe8yNM3L1Uc2iNauQ65rXp8wrrR1LD3adnZqgzUzbEkkKBUHpwGo9?=
 =?us-ascii?Q?Kn95atESNJ1xOc55pbcv/g1KyU1rTs+wFMJHJezHsN8ARF1NEBJNLyWgpQxz?=
 =?us-ascii?Q?zOIWklN3PnTVgm1sMdmSQj5GQQ1NkhCLM4U1db++AnNGRgvTD2uftkpIiZyg?=
 =?us-ascii?Q?U8zKL8UKAyUiddtiHtyc2e2ohjTyuLQxLPEJ3WXUTf4IGfdLR7naEEXZj4V3?=
 =?us-ascii?Q?duNQn8H/lzX3LMxyx9Dvr9OfJOL2Xo6PNRiwDU4s3sAKDOLCe31eatqTKmd/?=
 =?us-ascii?Q?mMP4THGwpRZJnctrMhuDVutpniZRvMgNo+l25eJVAvPm5lRmiIo7WggCW3uU?=
 =?us-ascii?Q?pe6F68YiVvTj9whnxUdXM08YAKXWOhQ+k1dDH8a6lo35dYx+l9/4x5e8otJL?=
 =?us-ascii?Q?/lIiuWtTQRPMyzBVvyh61SEzXF+3wijDQsTBKyAJSIbZhJZIh8X7PLAwFplf?=
 =?us-ascii?Q?U4J2jTo8N0wQWOBUDuOR/oxkvL3mt1BCY3HJ5yOVfkYRuskg/XARtubVaMko?=
 =?us-ascii?Q?4IUHWV4QmVQPB7wtFup7yhgx1HG/pFrJQ2hc+kAmknwc5i6lDIk8b1gQq74/?=
 =?us-ascii?Q?jtTsLnIEo90QkFfhHr2IPqU3/gafMrq6lgHdaEHDluVlIfPe0wKYNnQz/cug?=
 =?us-ascii?Q?PdOKtoBBK8Zimwp0IrjzOq5MDwI9HiVPwBZIGqqGWojHk/7zeKKLtXnDqrmU?=
 =?us-ascii?Q?30Li91Xm2Fx+zhv5Z5IpFG5uQ2kE4r/A22rh?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 20:00:33.1928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3634828-1de4-4503-690d-08de336fc89a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687

On 19:13-20251204, Mark Brown wrote:
> The recent refactoring of where runtime PM is enabled done in commit
> f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
> avoid imbalance") made the fact that when we do a pm_runtime_disable()
> in the error paths of probe() we can trigger a runtime disable which in
> turn results in duplicate clock disables.  This is particularly likely
> to happen when there is missing or broken DT description for the flashes
> attached to the controller.
> 
> Early on in the probe function we do a pm_runtime_get_noresume() since
> the probe function leaves the device in a powered up state but in the
> error path we can't assume that PM is enabled so we also manually
> disable everything, including clocks. This means that when runtime PM is
> active both it and the probe function release the same reference to the
> main clock for the IP, triggering warnings from the clock subsystem:
> 
> [    8.693719] clk:75:7 already disabled
> [    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/clk.c:1188 clk_core_disable+0xa0/0xb
> ...
> [    8.694261]  clk_core_disable+0xa0/0xb4 (P)
> [    8.694272]  clk_disable+0x38/0x60
> [    8.694283]  cqspi_probe+0x7c8/0xc5c [spi_cadence_quadspi]
> [    8.694309]  platform_probe+0x5c/0xa4
> 
> Dealing with this issue properly is complicated by the fact that we
> don't know if runtime PM is active so can't tell if it will disable the
> clocks or not.  We can, however, sidestep the issue for the flash
> descriptions by moving their parsing to when we parse the controller
> properties which also save us doing a bunch of setup which can never be
> used so let's do that.
> 
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/r/20251201072844.GA6785@francesco-nb
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org

https://gist.github.com/nmenon/5ca89b617113e9dbb31d4630586af945#file-gistfile1-txt-L1004
next-20251204 + this patch -> The issue still exists at least on my
platform.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

