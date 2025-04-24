Return-Path: <linux-spi+bounces-7740-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFA8A9ACFD
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11ED35A0B81
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16303221FBF;
	Thu, 24 Apr 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jhEevd0F"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F421E7640;
	Thu, 24 Apr 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496870; cv=fail; b=R4PmKRsroipiH8WbzFc2JUrLyiYbetY42jqlvp8tkKQAbC7YZe8h5EW5vT1yZKHLazoGkPA1owkvXg/igUBMpnodys/6J5r6r2fj+chnrgV+8vmaZsIWVl3CP0T4vw4AhAmV7b8Sm1P0bR9Kuj65x1MsYuX+yK8+XNi/Q9Ko7QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496870; c=relaxed/simple;
	bh=iB0WAz/oKrQVn2GtKmds3TzW4DBEkUEvJDPCB2gZE7A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AB0YEz9fVfVtEqt2MEKjI49LPQYeg1KChZLfKfIWmVfp8932VTtf97YaUs75Sx+8X1Xn2v+O2EiGlQLVk1Hr6o3QleoujVtyLGoG9ROcdcasmWvgtZpTHPRVH9MtgzR+FHAI60SRIlnCEquS/sBz80q6CGVaek07pdjGmqsD3pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jhEevd0F; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrQnIpWiMRssoJ+D/a1nNF/0c3jRJIrZUUoQ74onprCBSzu1AV1/mVodmcrEOY6Y6Sx9BdfZopT0D0PgLIkT4Th31KR1W+A0SqfM+zwqS1SXAwud1sfTaoVRec2cQ35htFONPZF18ySqC9C/pf9NwAq5jzWTRvN1ZF9RGyE/A9iMWp11oimU1YKyy3CdcKRQF0hft8Z5LW0i87GaLoKgTvkmJuDjUT9eWMt+Z3GoIpYVV/hifJVK3QEPzoHtAOXb+i96yB1iehFoiyMMVPQJeSyzyuEwYstU3A7KMNfzYWzrJG0g3D736dM0v8YGYdbWXKV77JlEWqLccf4gBBs4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q93s1ZIUZJ5GAsqUoQE7cBflAXJ3ChSZnowpWTLLl3c=;
 b=t+S40bGKxZatMr4VQ96+7pTppiGaAf7TmP7Si8qAJQx4xCZauR2/VBsKrf4SJ3HvI3S26YN9xwvDlDUK3jGUrGlSPISgNGgVZIioQKIB11jhJu7WodiWo0RlFFPnBQfvpn3gOV75drV4YGger++cG5237ynxzxEoE5tz4+gzEK/JKi5J7q9nYY5Bcjh7DUPn7LAKqe3iA6qAk4XPnypv80nDyf2eoOfXv94IloYWCvvYbkJF6o1sXY4m36iEl9m7soGxJjOE4bOiPWeMNhbzxRsbAKzG8acnlALY+RfSIuJcVY3QyOHHrWtOjEgJ4EpkNCe50DrQRCZRw+U+W7ok2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q93s1ZIUZJ5GAsqUoQE7cBflAXJ3ChSZnowpWTLLl3c=;
 b=jhEevd0F4blNpx4i7GgLtoLtJIl8HkIocIxXl5hMT1bePivrOt0XlqNRkMpu+3ZAhybdtEoZRll2hEzQicH5MXv9XeR4YG7EXbVUUbI5tdSJzUyJlIvmAeKQdB3o9RK7M/q6s2pMNumjsWWTZ0apIlfSEzgnM9A1P0wAYmmksIM=
Received: from BN9PR03CA0288.namprd03.prod.outlook.com (2603:10b6:408:f5::23)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 12:14:21 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::18) by BN9PR03CA0288.outlook.office365.com
 (2603:10b6:408:f5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 12:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 12:14:21 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 07:14:18 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<miquel.raynal@bootlin.com>, Raju Rangoju <Raju.Rangoju@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>, Akshata MukundShetty
	<akshata.mukundshetty@amd.com>
Subject: [PATCH] spi: spi-mem: Add fix to avoid divide error
Date: Thu, 24 Apr 2025 17:43:33 +0530
Message-ID: <20250424121333.417372-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 899b565e-2187-4f16-1153-08dd83298b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4dEXhl47HNsEh011dLqe0OUtq+fphGmcAbNZZV9lF1zDuVt6eeW36kElyUf?=
 =?us-ascii?Q?XE1bDX6aIEBVmtWNYFfYnF0888sfP4+5iIS0L7m4bSBwfbuU0CT0JxK0Lexo?=
 =?us-ascii?Q?zM3W5tPSgeh3CfB2jTVlJ0/BtabRMXUcMlORCUQywQ+Wevmg1p7QECvoT7hM?=
 =?us-ascii?Q?4JnJaVvlaVVFX2mBxxTbN+I2Op97Zz7gRrr6PU2SoM5giJ6ZLBsGbZdbk6oN?=
 =?us-ascii?Q?HfrtwFdQbfFwCkmjB18EAnib2FlNAyQG+JWv41x4WwfDVBY8GgAnsDfF96yl?=
 =?us-ascii?Q?lYxQ8bUSj6Ic0LYbqAuyQrBHAMWnX+m7R8N5w/8vYg1FOhyAyXgmRUBahdmZ?=
 =?us-ascii?Q?xtVCbSKNYVuSHyhQrc8VIdhNI0WVYVt19dNpHeOZrGo3+S88O0EMehb8vAxU?=
 =?us-ascii?Q?1xzL0HHfZdgE3p0IypavYbNqV8aOI+9rETafhbClPcuALKJLBxA84F0Tk66T?=
 =?us-ascii?Q?jRC8ZQhMw7B2MjuiQclPUR28NIMQcQ+EUlr26r8OKBhV+CgQkkKhzxiAM3EO?=
 =?us-ascii?Q?s4ZGTzc1PTiILiCvFB1S4k1aigmyjaMT98zyN9FmdYaaKEnmzP3Z237Ralyp?=
 =?us-ascii?Q?8LGrLNh4vRYdDYqFy0jm1Ypqt8QS9lpFDRAv/hctM6Rqqnp0CJsiqHp/pD9S?=
 =?us-ascii?Q?tM3qKi4YldzGkGT6/IuEGqHBh3lBTMYSmnD7zq2qhrHZw2wewPg1za5nAnDj?=
 =?us-ascii?Q?ZAsNQWD0K0rjh04SiQsUGqXhf2i3D15msntP4b4K3aVxC3W9eyrvMBFbbtlT?=
 =?us-ascii?Q?D+9HRIrtxFBPwzuJQTK5GGMBwTaBBMziXHcrc/KCd2TXL4iUJwpQqMgQ2ypp?=
 =?us-ascii?Q?Pr40MQmd5H1pjFG4+1bddkxdo6oojD3j4WKSLc9hoM9o9SvY94biBOVBSYei?=
 =?us-ascii?Q?4WFSk8BFg2S+52hA9DXfql3uk5m1DBjM4X5WRtb9eOqBy4rGZ9rn0TjBZPaK?=
 =?us-ascii?Q?pk3BTyWJa76USOtDiXSHG8M8KAZn1Q97fvsdGbQVEPQ+rUV8fYLNXrLfFXLD?=
 =?us-ascii?Q?ue3R8A5kW0g64LLr0qjsPwBKDGb2bhshRgmkOF6TzcdTo70DEGHsJPGIfow4?=
 =?us-ascii?Q?vUQ5eqU3OUlfmsoWWQJAgh5XW0D5cS5/FwOUGCrl7xc/MfrP4v9pMeDkooWf?=
 =?us-ascii?Q?AjOQCyju0nWY3ZxJ4hQ3F0t2piDvYttFXYML15roGAJ9Pm91llzBIN53B4c0?=
 =?us-ascii?Q?5b2GJ6v9bTBRUs68RJPd/RvjBRk5x/0uuAObVbdkg8Svh/fl/RUD3QiOa2CI?=
 =?us-ascii?Q?R0A9CAi+zaD3A8B+JUzrnr5hQRC3yXQLpm66mLtBVVnvCC6vQON58ufrMZnh?=
 =?us-ascii?Q?DmQ0x5pqF3NVsfE4W9eyrbe4Uy8T7p80MjsbZHlwRnNsgspuV7sXlnb8O7gE?=
 =?us-ascii?Q?yVXuA6PoZdz32w4LTK8+FCNCktygWCCmVO9n+nIJ6wIwmVs3E4jBntX8kbWS?=
 =?us-ascii?Q?5T359NYAih0tvtHKgiY6HcvooW5FkBosFKOtHMaTT9C3bk7hs/ds7yDrDmxf?=
 =?us-ascii?Q?X03Kra8MsIsfU8nipbyC8ql8gs1rd4S84/VP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:14:21.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899b565e-2187-4f16-1153-08dd83298b5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

For some SPI flash memory operations, dummy bytes are not mandatory. For
example, in Winbond SPINAND flash memory devices, the `write_cache` and
`update_cache` operation variants have zero dummy bytes. Calculating the
duration for SPI memory operations with zero dummy bytes causes
a divide error when `ncycles` is calculated in the
spi_mem_calc_op_duration().

Add changes to skip the 'ncylcles' calculation for zero dummy bytes.

Following divide error is fixed by this change:

 Oops: divide error: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 15 UID: 0 PID: 1872 Comm: modprobe Not tainted 6.14.0-rc7-zero-day-+ #7
 Hardware name: AMD FOX/Lilac-RMB, BIOS RFE1007A_SPI2_11112024. 10/17/2024
 RIP: 0010:spi_mem_calc_op_duration+0x56/0xb0
 Code: 47 08 0f b6 7f 09 c1 e0 03 99 f7 ff 0f b6 51 0a 83 e2 01 8d 7a 01 99 f7 ff 0f b6 79 19 48 98 48 01 c6 0f b6 41 18 c1 e0 03 99 <f7> ff 0f b6 51 1a 83 e2 01 8d 7a 01 99 f7 ff 0f b6 79 20 31 d2 48
 RSP: 0018:ffffb6638416b3d0 EFLAGS: 00010256
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffb6638416b3f0
 RDX: 0000000000000000 RSI: 0000000000000018 RDI: 0000000000000000
 RBP: ffffb6638416b460 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff9d98d476b828
 R13: 0000000000000000 R14: 0000000000000040 R15: ffffffffc0f5a3b0
 FS:  00007ed599a0dc40(0000) GS:ffff9d9c25180000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007d798ce9cff0 CR3: 0000000111506000 CR4: 0000000000750ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? show_regs+0x71/0x90
  ? die+0x38/0xa0
  ? do_trap+0xdb/0x100
  ? do_error_trap+0x75/0xb0
  ? spi_mem_calc_op_duration+0x56/0xb0
  ? exc_divide_error+0x3b/0x70
  ? spi_mem_calc_op_duration+0x56/0xb0
  ? asm_exc_divide_error+0x1b/0x20
  ? spi_mem_calc_op_duration+0x56/0xb0
  ? spinand_select_op_variant+0xee/0x190 [spinand]
  spinand_match_and_init+0x13e/0x1a0 [spinand]
  spinand_manufacturer_match+0x6e/0xa0 [spinand]
  spinand_probe+0x357/0x7f0 [spinand]
  ? kernfs_activate+0x87/0xd0
  spi_mem_probe+0x7a/0xb0
  spi_probe+0x7d/0x130
  ? driver_sysfs_add+0x66/0xd0
  really_probe+0xf7/0x3b0
  __driver_probe_device+0x8a/0x180
  driver_probe_device+0x23/0xd0
  __device_attach_driver+0xc5/0x160
  ? __pfx___device_attach_driver+0x10/0x10
  bus_for_each_drv+0x89/0xf0
  __device_attach+0xc1/0x200
  device_initial_probe+0x13/0x20
  bus_probe_device+0x9f/0xb0
  device_add+0x64f/0x870
  __spi_add_device+0x187/0x390
  spi_new_device+0x13a/0x1f0
  spinand_drv_init+0xe4/0xff0 [spinand]
  ? __pfx_spinand_drv_init+0x10/0x10 [spinand]
  do_one_initcall+0x49/0x330
  do_init_module+0x6a/0x290
  load_module+0x2522/0x2620
  init_module_from_file+0x9c/0xf0
  ? init_module_from_file+0x9c/0xf0
  idempotent_init_module+0x178/0x270
  __x64_sys_finit_module+0x77/0x100
  x64_sys_call+0x1f0b/0x26f0
  do_syscall_64+0x70/0x130
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? mmap_region+0x67/0xe0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_mmap+0x52b/0x650
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? vm_mmap_pgoff+0x152/0x200
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? ksys_mmap_pgoff+0x191/0x250
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? syscall_exit_to_user_mode+0x53/0x1c0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_syscall_64+0x7c/0x130
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? syscall_exit_to_user_mode+0x18c/0x1c0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_syscall_64+0x7c/0x130
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7ed59911e88d
 Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffd5c54e7f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
 RAX: ffffffffffffffda RBX: 000060eff3d62f50 RCX: 00007ed59911e88d
 RDX: 0000000000000000 RSI: 000060efdbd38cd2 RDI: 0000000000000006
 RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000002
 R10: 0000000000000006 R11: 0000000000000246 R12: 000060efdbd38cd2
 R13: 000060eff3d63080 R14: 000060eff3d629e0 R15: 000060eff3d63780
  </TASK>

Fixes: 226d6cb3cb79 ("spi: spi-mem: Estimate the time taken by operations")
Suggested-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-mem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a31a1db07aa4..5db0639d3b01 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -596,7 +596,11 @@ u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
 	ns_per_cycles = 1000000000 / op->max_freq;
 	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
 	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
-	ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
+	/* Dummy bytes are optional for some SPI flash memory operations */
+	if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
 	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
 
 	return ncycles * ns_per_cycles;
-- 
2.34.1


