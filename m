Return-Path: <linux-spi+bounces-4967-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1E9860F4
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15852B24655
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F40A18DF8A;
	Wed, 25 Sep 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZBRYT4uw"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374FA18DF66;
	Wed, 25 Sep 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271599; cv=fail; b=EUlUgemUuDCKG1HycyxRl190CWzGpMfErDwVdQpvXxBavGDakSYcEg49HB0S7QOA5r4yN65oFmmAUuUwa6nWTjYtvcVHvz1p57GkXpCYoHeJvvdQ34+lBhOvRVJ6gN1GZXbB4JJlMs9LCRCL/27VOj97Lnyg9HbynwJ3ZjBFUg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271599; c=relaxed/simple;
	bh=ZhTUv9D40yIsLucKv2wUX61ykpGcQH5gtI0RaKckER0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mjieinK9il3/jw10n9kKB0GlFPjktvkzCHJXd/cyVDpeYRtPPnucDN/1aloqOK6iFq0yHSnc01tGC9PV+rMVkgoGBHiQgPeQcD9LcA/57Kt3q02emYi7bvnFMBJiSNm5BfiYwIEQQZcUcxq0wbXdT7YXa+2KX8lKXGBw7fxCnbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZBRYT4uw; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rx5guD1gZpDb+yDMvuv65HCKuUWNR9Vnuy6KduzpIHEMt22TTDSugzgf6Pcs+DhACkurpZeAHNIZI7Macay4zrc0S4CY0EVAmu2DrArJJEBGzdTdllHTqEXnGmwl8YDDwRbh+Y/hMjby4AX06hOgFDDUmo/K4Dz25YLEXZ+82huNokNESmFteQJ1LbngJwW6qTvHCknizpmllSUkgyefQa6MbliIH0JTIir6ekLmUjH0eEWepeBqDpHrIxDWvuzDR/o7ZpCi+dlapuGB8KdPPPRmeiGEVHQa2RjmMLjvprZktd5wk3lAv2hii/UhBr5j3Wfm+z3+FRbzyghrm4Dswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAAqF8UYlKCDJtQ22L7KPPlXgZ7488yDG8riXIGGmwM=;
 b=OPHuDQX/IzE0vNV3W1qf5jOe2Ol7hcP5fJo/Sso0A7iGT2DYXTD+sBs0lhSpaK07e8sjBGxv+b+uaSHwMH+TOFfnYx2IhO5f6TK9c7S8S0A9Cb2cPpb5syCvO+3SQZXEV5mDBAKDe6ncG6sP4YeDg29NxS1aj5WX8xaeGdytPH4YHNDajDGvSu5jjaHvnjdC7ihfz8eEGaD6EIz1A76qVhi1XLwWJjtu/yVze2kLocci4kSRg8CKLxPK9xtQA1cE+FnOcek56aQy5srMN4h8+DBR6i6jVQy5tGijMyPtHVp2FwLG2W8eGk0SPtfkOUrQIQCRZYnhDD6UA99SRYD1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAAqF8UYlKCDJtQ22L7KPPlXgZ7488yDG8riXIGGmwM=;
 b=ZBRYT4uwGs96XmJoNAZd16KPNtSo6IkATNn5x51AtCAhdiDvGYDk7+Up3G+Fl3Qn0chY1CfZ22+R0A0Uwr2N7ZqQqKBSXZaB2OrDYsamWZxrSwIdzXjcF54zQaMrrI2c5oO2f2ebXA5+pU1/mBUN7FB5lcD+kBkCAKiufRFOrIw=
Received: from SN1PR12CA0076.namprd12.prod.outlook.com (2603:10b6:802:20::47)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:39:54 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::40) by SN1PR12CA0076.outlook.office365.com
 (2603:10b6:802:20::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Wed, 25 Sep 2024 13:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:39:53 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:39:51 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 0/8] spi: spi_amd: Performance Optimization Patch Series
Date: Wed, 25 Sep 2024 19:06:36 +0530
Message-ID: <20240925133644.2922359-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 15860e59-7e44-44cd-5d80-08dcdd67898a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVZ1RU84d1hkVnJyY0paUENOL2tNanByRlZBYVBFakIrOUNZM3RQdklMTGY5?=
 =?utf-8?B?Z2ZpZ1dMZXdMbGVYWmpFM3FqQ0NYKzVnbTlsc2FGdXVldzdJcU50TTFGUVlN?=
 =?utf-8?B?Wk54VDlrK0JCcWxsR0JNM1YyOXA0REY2VVN6SVR3eHU3K1lkSFhsaDBNWjlT?=
 =?utf-8?B?QlpUTnNLR0FySzBQNG9UTmxOKzRBelVGUmVDOE54UGVHRTNHaE9Gc3BkZXhZ?=
 =?utf-8?B?YVpockNNVTBlaGZ5VGFjTnhWQXJQTE4xRFdSMzRMZUtaN2cyeExZbjVETkFI?=
 =?utf-8?B?UHhSKy8xOFhKWEthdWtySFpZa1ZLTEVMa3ZjSHhmMy9CbXV6T2RmeWlCVCtF?=
 =?utf-8?B?L0dIeVU3UXdIbUF1N3oyc3JVdS94anhnVGszUWlsRGc1c3ZUdTE0S2RMRWlO?=
 =?utf-8?B?K1U3VE5zS3gyZXA4elN6WllNZ2JodE54M084ZWlmU0dOU0hPRXdKUmNCSm9w?=
 =?utf-8?B?QVpWMmFKZmY4Rk91Tk1vd1ZHQjFkb3VQWXl1eUVQYXFkc1ZvMEpNM3M0VTQ1?=
 =?utf-8?B?ckxCQmx3bm9yeVRHM2V1NFNRZlpiY2lXeWFTRHRTZEVRcnpHanFWQXhqVTlU?=
 =?utf-8?B?VmhmMjNUZTh6QmNHbkZ1bmZOWVhHZkJManlmSkE5WGZ6NEF2dDhsSEsxalR5?=
 =?utf-8?B?OWowN3M5SmxQaWNXSkV4elF4UWMzaEljRVlJZ2F2Tk1lTndHUWdDWnU0TkVa?=
 =?utf-8?B?elNHVDlRV1JzbGFzSVRvakRFQ05RRWNWVEVNT1c4OFRpRm9hLzFwakhNaTNX?=
 =?utf-8?B?aEVFeVF2aGtjVzM0RFQ3c2UvZDhuemlWRHBpMFhSUDh6NWp6R3RpR0wyTmlL?=
 =?utf-8?B?TDRUUDlXR3pwMWhTdzhpLzFIWjRsUVBEa09jbkpGRUVmMElMd0tsTkVlU0lS?=
 =?utf-8?B?U3Z3SXNqMGVnaDZTUHkrM0pWV05JMVdiYXFBOWhlVE5RV3E2akhZT0F2Y1Z1?=
 =?utf-8?B?RUdPb3hlR2s2QzFNcWMzekFkeDdrcUdNNCtWRG1pWmJ4aklVWFU1V1kybTFk?=
 =?utf-8?B?NlV1MDROaHNwTGgzNDA3T0NVMGFsWWY4VGhGZUNsUnQzUFZRcmFSMnRWZmpY?=
 =?utf-8?B?Y2FISHRWTWdnRVowNFJ3NTZRS2Z2cVNpSWRnVFRFNzhuUE9jSmxBc3ArbDc3?=
 =?utf-8?B?Q3lXR1pIeTcrUEFHZmJubGR0SFpMQ3lQUzlIUzRCV0hac1pBUm5CV3ZtYnJq?=
 =?utf-8?B?eHZld1ZQcC93Mk8vWVNid2xKYUJXNDdRNUcybERKTnRxdHV2NUtMQnA3b2Fu?=
 =?utf-8?B?bFkwOGpaQkpIbi9FNXBwc0IzdlBlS2puc2dtamg3YkxHOGQ0eldEdEY4Smhx?=
 =?utf-8?B?TG1FSnFtWEhtTEtMemVsTmUwWHBYZ1IrMXdmaXR2SG9NMDE5Lzh1NjkwL2JK?=
 =?utf-8?B?QlNXeEpoUFVRV0NPTUFBdTV6WVc3OVBiUy9JZW9QL0RuT3BTRGtsNkNiWW0x?=
 =?utf-8?B?K2dvQjJWVC9CSjcyM1ZHdkFzTXhkQUorbXg5L1pqbXNjZlppWllDanBJTCtM?=
 =?utf-8?B?dFErVUwvSGFqNW5kdWprZFNMUlVmclhIN0h1cWFxa25lejVUU2o2WE9aN0Yy?=
 =?utf-8?B?ZVg4TjVFV3dseHlsbDNzTFdmM1FmVHhXVzRMMm0yN0pIVXE4dVZZMnh1ZGFF?=
 =?utf-8?B?Z0x2ZmhmS0swMXN5dUVuNGVSTTVTUmdFd3YybjJTSWlwMzRERUdIMmkrK2Fr?=
 =?utf-8?B?cERraEhyNWNjVlp0ZkhsSG9kMTVra3hSdHlBTmtEanhSSWU1WUw1WWNmRGM4?=
 =?utf-8?B?U0JYb0plcWJPVTIwU3ZpKzVHTUtvckJETnpFcE5IeS9KS1UrQTFkanp3bGFu?=
 =?utf-8?B?WXE4YVRCRzhMZGlFaXpOVjFWbFJaVjdGTHJ2aFE0b0pyckdTRGZJT040ZC9p?=
 =?utf-8?Q?liWzTplIm2uc7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:39:53.7903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15860e59-7e44-44cd-5d80-08dcdd67898a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104

AMD SPI controller’s index mode performance is constrained by the
hardware limitation of the FIFO queue length. This patch series introduces
optimizations to the spi_amd driver, aiming to maximize throughput and
enhance overall performance. The changes includes,

- Enable SPI dual and quad I/O modes and update SPI-MEM support function to
reflect AMD SPI0 hardware capabilities.
- Utilize efficient kernel APIs to streamline SPI I/O operations for
enhanced performance.
- Refine the set tx/rx count functions to optimize SPI I/O throughput.
- Minimize the number of data read calls by efficiently retrieving data
from FIFO queues, improving SPI I/O efficiency.
- Add changes to support AMD HID2 SPI controller and update SPI-MEM support
function to reflect AMD HID2 hardware capabilities.
- Add changes to set SPI controller address mode before initiating the
commands
- Add changes to implement HIDDMA read operation support for HID2 SPI
controller

V1->V2:
-------
- Eliminate the separate patch that introduces SPI-MEM support function
modifications, and incorporate those changes into the existing patches
for enabling dual and quad I/O modes, as well as enhance support for the
HID2 SPI controller.

Raju Rangoju (8):
  spi: spi_amd: Sort headers alphabetically
  spi: spi_amd: Enable dual and quad I/O modes
  spi: spi_amd: Replace ioread/iowrite calls
  spi: spi_amd: Updates to set tx/rx count functions
  spi: spi_amd: Optimize IO operations
  spi: spi_amd: Add support for HID2 SPI controller
  spi: spi_amd: Set controller address mode
  spi: spi_amd: Add HIDDMA basic read support

 drivers/spi/spi-amd.c | 325 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 295 insertions(+), 30 deletions(-)

-- 
2.34.1


