Return-Path: <linux-spi+bounces-11678-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA32C974D9
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 808263430FB
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A74A3054F2;
	Mon,  1 Dec 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ndODyPcz"
X-Original-To: linux-spi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6B30103D;
	Mon,  1 Dec 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592655; cv=fail; b=Ich48mdLdjC915/qwp+hZYn2B9v3vDEay1Vv0S4xiKBmpDPOtnMfQ7+I9PNKF5QKqlRkX3L7miOtJF4oEihaC7fp4kULHqcuSQ4W1ztP97hb+ATHeM4gZatlKHFdSomUmxUuPdd2fMbrGhsw0WlZvq+yRMgyIbQ2wgMkaj77BBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592655; c=relaxed/simple;
	bh=VYAAi9x7JEkeRFSSfyNDJLverodVrup9PWYjw5Sndo8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9KEy1EHFvWHvtCSeFmUmKMiYyF1pMwcS+wIr6p7rwOhzIycGCIJWM7EeTA/lOibxQh0ZDQg2S8gg2TgkC7h2hQsBQtPwhQzhZ9T+Fvu3KJkoQ5asTipuxHfq5Zt2kyHQCcRjUbRGP7kS7FNeOk5r8cR2pUZBuE2xpI7GtO0gKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ndODyPcz; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZiNx1WDCu8OI6fSubk0tnFEZTr6kbQ4+4BC3OjgdO1X9xistxlalVBPvziwR5p/v64LIOp/tfnOXPJwfOMr5xIJQcpiJq4ovHjvHt2PMVAqC0EB1vrso8EHS2tzV1BtWeFputfhtmOCqIZjelqb/xyI5+B89HJ0k89KofA2i8G6P6mp884Fp2pHcnIh167NjXI/k7icilePKqA5VBZBgc/+SkYDAZBx3QFaRDHwdgrKEXbyZZht6pgs2ZwQD4BD/WlD0n/iOrOOkU/tjQfy+XwKeBATCPltU5cDAtk60hfVkepffatuFepToB+UMtJsOOWBKEDHuoVKFU0p4q43mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbMgwfUb5bvwvSgY782rs/Pzv8xHt3wWYuNHetXOLe4=;
 b=ho0te54LA8ZtJQSqMV/yZEb3CjbxBhDXRvQA31JqqPR95SomBwlI9b9as5BOGO+vJe5IB/jBOe5fi45kwFqozwY3gxFw9rfJJCZGBeus3wsTt++/fQZ6fyBugVg7OWNKPhuxzJfoIT0HN1Ws5vYbpgmACySzMPXhjPWZ9RZbaDWFaA+7XaAZZz9PDHlEmdqi1p8mAeT9kK/uooaiOPDNHbzsjgc+3cpTClsiJwejcKl9r6NguOIyF/fUj7hIJpB+jmbPlnI1lj3UdpPk8caRbXrO3sIyyMVjgmDX1nU6jg5LFd8za4ln3qDXcYI6vgmk5sj/3HvcmNGluMAV6/kP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbMgwfUb5bvwvSgY782rs/Pzv8xHt3wWYuNHetXOLe4=;
 b=ndODyPczyWjbF/HInPwOXv4qF5s1uynNTnFE3cdOYO9/t7aCMtBjGm/jETxJSPXD3g27FAeBcDWfOo4FSE95OjQWQOkXu50anI1yg1ItsfIkxTaRUHUrcVHJf0Y3T/hqvWA3627DwJ88NWVxkNhIxBzepo9uEKkF+CiVXI74Pb0=
Received: from BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 12:37:30 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::65) by BYAPR11CA0099.outlook.office365.com
 (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 12:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 12:37:30 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 06:37:27 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 06:37:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 06:37:27 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1CbPUj419343;
	Mon, 1 Dec 2025 06:37:25 -0600
Message-ID: <dfbbd5ce209fac9a556c200748d8c521d0d4f450.camel@ti.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix cqspi_probe() error handling
 for runtime pm
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: <broonie@kernel.org>, <a-dutta@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Mon, 1 Dec 2025 18:08:07 +0530
In-Reply-To: <20251201074320.GA8737@francesco-nb>
References: <20251119152545.2591651-1-s-vadapalli@ti.com>
	 <20251201072844.GA6785@francesco-nb> <20251201074320.GA8737@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 22074bba-01f9-4492-1a34-08de30d6648b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGFCbFVYUWlQWTM1N0NDckhPNEJGUFJydXdFZmJHZnZJSlBMRzZYK3dsY2VV?=
 =?utf-8?B?S3lWRUtBZ3NvbFJFRWZnVWF2dHVjUFFFZEhyemsxbGlva2hxaXVOTDU1YkdW?=
 =?utf-8?B?WFN3Rk91ZHk4N3Ivbnd6YzdWcFJQcHhlNmR3TVptMlpza2ZQWTRzWUVaSU1Z?=
 =?utf-8?B?Ykg5eFVUc0pyd0VxaWlRL2U4Zk9LRDhQeE5QUkp0QitmZFlaTEZtTEtzRDVM?=
 =?utf-8?B?SEo4Ym9lWWptbnZGelBVT0N5RlpkQ2YwQ0NxOHYrUTd6RG5ZWUxEZHF3NUlJ?=
 =?utf-8?B?dzNuUVZtTDNZa0VSVnRFeEFoNE1RMWdxd0d6eUt4WFVRTGVWQTJFYVRreWJw?=
 =?utf-8?B?bllFZk43QjV4SGM2RDhrWjVETVFHdDNmUXBtbFVxNWhzQStpdm9rSXpEckVG?=
 =?utf-8?B?QW5qMGlKRXBHbjQxRmtqOVdxNU1sTWU4S2YrNWsxdVE3U0ZoakhjanVrTHZ0?=
 =?utf-8?B?N0UrenluS3RPM0k4MndLZ1RlTG1mc1p4S2pFc2NSa1kwMGxvM0JIeG5ONUwr?=
 =?utf-8?B?MGx3ZUJhYVl0dXUrZ2hzSTlJSld5QWVoRXRnejZnTXlEa0E1K1czOWxNWkZ4?=
 =?utf-8?B?eFhoYnhYb1hwNWRZZkRadHk3cWVpakxzL0lPWTRheXNpLzMwQ1NTSEtlbjJw?=
 =?utf-8?B?Z3NTWE9DbUVXMzh3S0YxMTFrMnAwTmJiRG4xalQ5c2RTMVFNbDYySjRQMTFB?=
 =?utf-8?B?NEJFQW1MNGhuTmZ3SVozK0MvQzBlL0JpSnAvc2h1WFpOeXRTcVR0WFk2UFhQ?=
 =?utf-8?B?QkVSdmpBYkRDN29MYW5saU1Ga1M5Y3RlUEpXVURFSkw1Q2Z2Z2tnM3FVTTl3?=
 =?utf-8?B?RFlOVkorc0M5REErekxjNmxickxGN3JnV3ZQSlRVT3JhWTNqbldCSkZTOGpZ?=
 =?utf-8?B?MnA5NEYyeXlxcmE3bVN2NkoxQ2p6STBmN01rUkJEVEdVYVhXODRXWlJEVmE2?=
 =?utf-8?B?emNmUVRJU3FvNVVYS3A3cWRQaXBKNUR4YTNLazROQkJzbFRXOHdoaFR3NStL?=
 =?utf-8?B?YkRVOTBPYllxQmhuMTg5K0lkUG5hTVhaQ2hsWTZEMFVNSWIyTmVMM1N1R0x6?=
 =?utf-8?B?bTh1K1Y3S0lNLzZCS0czQktidmNBbzdITG5IUFBwSzBxaDBrU2JYSDUvQjcx?=
 =?utf-8?B?YXJmWGxma0lRUGg2Wld2cU9hbjMrNk9aVnRpOE9LNFFKQUUydlRCY3FlMFQw?=
 =?utf-8?B?WEtGUXdEM1lKeXdEZW90WXNBdzVYeXlHWEtDMWc1UnF4SS9CV256anlYSEkz?=
 =?utf-8?B?OU1DMGEzTWgydFpqeTRXeFNBa0RCZ3RLK1BZZk91UWdyOVpodGdWcXZCTHRK?=
 =?utf-8?B?ZUkyY3ZJMWlydFhXTVlkbEhvWHRjdGpjbm8rZHhkV09HSDZLUDFqSjFiYjlx?=
 =?utf-8?B?aDZMUnVIbWRWSEtDUTZtY3Z4N1dGZjZJMzZKcDdEMUs5UDFEL0JneWRYdVpu?=
 =?utf-8?B?MjBZL2dGTks1NzRRL2VFZDNMdUpRN2ZFTFZxVWRYaTZpWDNZOW54UlQwM2VV?=
 =?utf-8?B?alRPMmF5dDhHamlzQTFKNnY2K1pobGtkMVArMDBKcmo4ckRDNUMzS3Z0M3NI?=
 =?utf-8?B?WVo3b0FsU3J2VHJVeE9uTXZKWnh3U3pPRWFEc3QyY2NZSXVoR2hic0hrVVU0?=
 =?utf-8?B?M1pjMHJoRGFvTDNaN2FJMjdrRjdsMEkyMzltdEUvbFViajFxNW5qZUpNYk80?=
 =?utf-8?B?QXhNMy80aTNPYmtqajBsQmZ1TWtjeVB0ZW1KVzhObFRsYUpvOUVlSGhPeDhD?=
 =?utf-8?B?Q2RGcTl4bmtEZGlaNDI2dk5rMHBOSHR6YmRBa3dWa25rWWNaWElHVWV0d1dL?=
 =?utf-8?B?MXBRVWtqdnlOTGdLQUpTV1plZU1UWk5ob1M0WkVoYi9uQXY5UlBoRG5FZ1I4?=
 =?utf-8?B?U2hOUWR5MmRCRHdKZjRXRGFRR09laklLWGxBWVM4UEtPSGdzcEt0YVFFcGt4?=
 =?utf-8?B?S3JlcTNYM2QyeHVxczcwRVZhOXJzVUdVRVlaVHd2akRNV3B5ak1FUDd2TEpP?=
 =?utf-8?B?bGhsOHg5c0tFckY5N3JkUVFHbXN5Um9YSVRzQWg2cFdPNFlkV2lBbStUU3hS?=
 =?utf-8?B?dnRWU3hpQjVBNUhMS3AycFBlMVp2SEw0ZUY2SFc5Wm53NkZwOFN4d01Fazlx?=
 =?utf-8?Q?XFn8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 12:37:30.0261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22074bba-01f9-4492-1a34-08de30d6648b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672

On Mon, 2025-12-01 at 08:43 +0100, Francesco Dolcini wrote:
> On Mon, Dec 01, 2025 at 08:28:44AM +0100, Francesco Dolcini wrote:
> > Hello Siddharth, Mark,
> >=20
> > On Wed, Nov 19, 2025 at 08:53:53PM +0530, Siddharth Vadapalli wrote:
> > > Commit f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime ear=
lier
> > > to avoid imbalance") relocated code but missed updating the error han=
dling
> > > path associated with it.
> > >=20
> > > Prior to the relocation, runtime pm was enabled after the code-block
> > > associated with 'cqspi_request_mmap_dma()', due to which, the error
> > > handling for the same didn't require invoking 'pm_runtime_disable()'.
> > >=20
> > > Post refactoring, runtime pm has been enabled before the code-block a=
nd
> > > when an error is encountered, jumping to 'probe_dma_failed' doesn't
> > > invoke 'pm_runtime_disable()'. This leads to a race condition wherein
> > > 'cqspi_runtime_suspend()' is invoked while the error handling path ex=
ecutes
> > > in parallel. The resulting error is the following:
> > >=20
> > >   clk:103:0 already disabled
> > >   WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x80/0xa0, CPU#=
1: kworker/u8:0/12
> > >   [TRIMMED]
> > >   pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > >   pc : clk_core_disable+0x80/0xa0
> > >   lr : clk_core_disable+0x80/0xa0
> > >   [TRIMMED]
> > >   Call trace:
> > >    clk_core_disable+0x80/0xa0 (P)
> > >    clk_core_disable_lock+0x88/0x10c
> > >    clk_disable+0x24/0x30
> > >    cqspi_probe+0xa3c/0xae8
> > >   [TRIMMED]
> > >=20
> > > The error is due to the second invocation of 'clk_disable_unprepare()=
' on
> > > 'cqspi->clk' in the error handling within 'cqspi_probe()', with the f=
irst
> > > invocation being within 'cqspi_runtime_suspend()'.
> > >=20
> > > Fix this by correcting the error handling.
> > >=20
> > > Fixes: f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime ear=
lier to avoid imbalance")
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >=20
> > Our CI just hit this WARNING with 6.18 kernel, on verdin-am62. To me it=
's a
> > regression from v6.18, specifically from spi-fix-v6.18-rc7, we did not
> > had any such WARNING with the master build we did run last Friday.
> >=20
> >=20
> > [    8.648915] cadence-qspi fc40000.spi: No flash device declared
> > [    8.675671] cadence-qspi fc40000.spi: failed to setup flash paramete=
rs -19
> > [    8.693691] ------------[ cut here ]------------
> > [    8.693719] clk:75:7 already disabled
> > [    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/=
clk.c:1188 clk_core_disable+0xa0/0xb4
> > [    8.693822] Modules linked in: gf128mul(+) snd_soc_simple_card(+) sn=
d_soc_simple_card_utils spi_cadence_quadspi(+) optee tee usb_conn_gpio gpio=
_keys display_connector roles dwc3_am62 rtc_ti_k3 ti_k3_r5_remoteproc k3_j7=
2xx_bandgap ti_k3_m4_remoteproc ti_k3_common tidss sa2ul sha512 snd_soc_dav=
inci_mcasp drm_display_helper libsha512 snd_soc_ti_udma sha256 sha1 cec snd=
_soc_ti_edma pruss omap_mailbox snd_soc_ti_sdma omap_hwspinlock authenc blu=
etooth ecdh_generic ecc ina2xx tpm_tis_i2c rfkill snd_soc_wm8904 libaes lm7=
5 lontium_lt8912b crc_ccitt i3c ti_ads1015 tpm_tis_core industrialio_trigge=
red_buffer kfifo_buf tps65219_pwrbutton tpm rng_core m_can_platform m_can t=
c358768 can_dev spi_omap2_mcspi pwm_tiehrpwm loop fuse ipv6 libsha1 autofs4
> > [    8.694064] CPU: 1 UID: 0 PID: 185 Comm: (udev-worker) Not tainted 6=
.18.0-0.0.0-devel #1 PREEMPT
> > [    8.694076] Hardware name: Toradex Verdin AM62 on Dahlia Board (DT)
>=20
> Same on verdin-am62p

Could you please check if the driver's suspend callback has executed before
the above? The patch intended to fix the very issue being reported.
Therefore, the commit corresponding to the current patch might still
trigger the issue. Ideally, reverting the commit for the current patch and
the commit under Fixes (f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm
runtime earlier to avoid imbalance"))
should prevent the issue.

Please let me know.

Regards,
Siddharth.

