Return-Path: <linux-spi+bounces-4844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7497BB1A
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666FE1C21E5D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0F178376;
	Wed, 18 Sep 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TQZ8fs+L"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BCC165EFE;
	Wed, 18 Sep 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656743; cv=fail; b=WQKptUEuKgKUbc+VhCxGbmY5FATreYppnamcA3lQT6H21u9y4/+phxZh+7kIonhG5D1zqCTRxIE4d1/3AOdC579RPD1cFJn5O/H8sW7IJ8mZ4+mtuBKs65qiQJePpQLJzF+2ewjHOW4kEAmN/K0T4nke80VC7WiheiWuWrt7iHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656743; c=relaxed/simple;
	bh=cY/Grf3hBzqNEfOsn+GQRjS0kVX8hC9eC/d8VxFxBuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F9NZ1mksmk9fA1IW+BzAJzgcUMnS5aqnM3cea4rtvWzcTl13LBP5PD6z/CZpB/mHDO78aFtr83CzUGwKJJCZ6OE7egOWe3u1UipOlBZF9hDeJ0qFe2DRZTeqoUqUMhcERHEOrfn2SmVYwVwhp3a6Ec3eiBkBy6IlUX9R5hTdRWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TQZ8fs+L; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcCKUmsB5yUWCb/j0ybDYp/RPmXxv0/Jndex/AYvjKFixQhWqih8sgF/sF50bdpG7ddGF49WpjQ04Y2aWbnUZ5HLR3xvLZVAIEct9I/IG7/SDVxk4ph1Eq/sfYAl+q8hg/AYU0nZ6qt3mVQ0EGRN3gSqzHDcMb0aqM+PqAOPiCvtN3zFb36fOfWXniMj/7wLjVZufr+rPlxsLeRj8lAwFPPTR9dfm06R6inImVLzrvDpnduvL/bAaTrqs1SFqv5nghsmtYBfz3a5dIcoWkFPUA0nmiBAgqdjQWBSerlMr+mZ9C5Q0zzHAOEJi9OL+iV0t7bcM9gCCc2AI6zVIHGqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2rdK+wRgWE4XapvHb46CP21Pum9bwGTE/xiNWb+AbM=;
 b=ca5mojMS2W9i3zGGcfpZ7va946BaPd4IONABzhH6wnJm5iMnctAeqny22jcTMzLZXeb9LjGpQ6vUXka63x7qaLQUuvaGOJiFXTFx461dtoF6bUVVPMBRlyN4mdi5FKuwODY3iuNvE74ZamYTYpccVmnOkgpLTuFSDW1juLUbDrcp9opc2zUz0PxI0YWAzutes8AZHYcQHEHOkS/z1+CdCHUOsjdjkM1McZf5x2tXHTw6NsGmFlrKMH2Sh1WLhEt6Y++Tc5BZp4QVq+Bv7ZPZ3H6RX9365Zw5eG8kJxEV1Uh1Qv8u5vghSMJ9RFB6cNxRHVjKqc8tol+xw2FLOLUgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2rdK+wRgWE4XapvHb46CP21Pum9bwGTE/xiNWb+AbM=;
 b=TQZ8fs+Lz9RTs7SQdg6db9vE/xHtMqRG41nQ9EqfaeMAR5gMf3ZxJ9e2UVis8/YgjT02+IhsqB2UVAH72JBABgyJJ8ycDztJcSz8flgVp+lXGOD5MbnScy4redVny36ZT+cq+z5fXXy7SdCYkMMJYBNgtlQQ5LuDHoup2o1dYnM=
Received: from CH0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:76::25)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 10:52:18 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::c5) by CH0PR04CA0020.outlook.office365.com
 (2603:10b6:610:76::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 10:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:52:18 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:51:18 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 0/9] spi: spi_amd: Performance Optimization Patch Series
Date: Wed, 18 Sep 2024 16:20:28 +0530
Message-ID: <20240918105037.406003-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 93663559-ec8a-464c-cf58-08dcd7cff728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVc3K1VXRVU1WHVJYmd5TGJFdjVWM0RjaGFkNDEyU09KOVBNUGhVS3ErNjFE?=
 =?utf-8?B?NnJ5bElNREN1ZUtFdGEvdmk3L25Qc1orKzZJbWUzODBtVkU1eU1BMkFEZHUx?=
 =?utf-8?B?SXliMzVnZUN6cndQaEFPMExWRXRDNlRUOFNFV2JHQ2NxUXc4NHBlRnIrU2ps?=
 =?utf-8?B?U0FQaVVCbHBPVWJ4d25JWnRJbWZzUTNVcFBkM0syOHpFR3g2UXgvbFFKY2Ro?=
 =?utf-8?B?SFBIK2tnZWtIQm8vdSt2SHFTK09qYTFROXFWZmhqWkRGcDd3eUpRYjg5SlNF?=
 =?utf-8?B?QmRaTWRWdVN1anE3MTNZOWw4N1Q2YVBpWkZtUUpnM0NMb2VERHhKR085UzRm?=
 =?utf-8?B?WjNCZkRTSytFM2g0b3VCMkEva3N0ZzUvM2dYcWxMZnFLUktSMjlMcC85VmZE?=
 =?utf-8?B?dHVodGx4andwOEhmNjlseit5WkVjakFBM0lCdU1hTS9aVDV1aFNYWHhacnY4?=
 =?utf-8?B?b2h1UFcrYk9CR1R1MW8zL1lrT09DbldkcnFPWHMwN29jK3NhNjc0MTcweldi?=
 =?utf-8?B?TEtVcElZaEd2bTFJcmR1ZFdrS0UzZnFRcGZFR0FNa1VlRTFXNlNzMStPZW5o?=
 =?utf-8?B?TWxlUlpLNHVGc01wYmVkdFVQZXJMSFZ6R25KWWczWmwrMnkxZmhhOW85NEdU?=
 =?utf-8?B?Y0t6eUtaT20wNWVzTnZVVThHRy9keEhzNWg3d2RkbnBHbDkwdkNyR0JZM01F?=
 =?utf-8?B?VmphQlNBVHlvQ2NaMTVNN3AyVlMzRXZXNmZMWElSWDJxWjJock8yUU9sVVhE?=
 =?utf-8?B?UTU3QTgyTGlaUmZxSEU4azA0aHZ3c002dXZWWk5qOUUyL2gwM2ZFbVdMRE5z?=
 =?utf-8?B?ZjNReERlV09MSkxlWDJiSmdOR2ViV3B5aVludWoxVUFjUnJhUVd3T2xvSkNH?=
 =?utf-8?B?QUVrcC85dlo3dWxkZ09IVzNtZVBPNEJzemVvZjJxMFhVTSszdHBpb1pkZGNM?=
 =?utf-8?B?ajIwY1M3Y1ZPQzZHVWJYWHRtU2JhcDhtdWtZRTdtWGU1a2FkdE5ZcENmdkY1?=
 =?utf-8?B?VS92RkNGaXZkMHk0QkNEdEdCRDNweTRYenFIcGtrWTVXY0gzWG5uUFZsMkJL?=
 =?utf-8?B?Z0l1NFA5TWc3aE85OUduVEIwY1JPcXExekcyQ1RLMTlCeFRZaUM4eUFIQU82?=
 =?utf-8?B?b0pRUUhMV2dxVXJqSkU1VzFQYmVqNVVjTU5xd0dpTERYZVhRWGZyUDVYbmdy?=
 =?utf-8?B?QkVXbVE4dEs2M2M0UHlvZGV0YXhZc1pVRVVoVDlyYXJLZndDYWwyc2RvQ1R5?=
 =?utf-8?B?S2dFdTFURmVScDhrcVF3Y0JaWFVLNk9WMXVDWUlLVlFQK3lXdE9ESzR1K1FV?=
 =?utf-8?B?aVg5NXJwMCtwV1RDOFJRVnZuaGZXUkROcFlLZ3hYVGdlR0JvMjhZK0ttUmJN?=
 =?utf-8?B?MXRHRkF3RzhrVGZRd2dNMU5GdGJBeVdhRE45ZUNKZjVDU3BTS1JZelltcEU0?=
 =?utf-8?B?clR2cUNkYzRRaXJkNmlCdnI1N0R2elFDNktWSWRuNHh1dnAxcERGTzYycFoz?=
 =?utf-8?B?Q3kzTVB6R1FJYW9RYjRnSGY2aXVWWUwrZ1ByNW1CNGhEcTgra2FaRHlWWnh3?=
 =?utf-8?B?Y1FRNXM1TjJTcGcrTFFOTkwvaVg3TzVCT20vaFd4OWRQZmFXZkxVUFRyeVVC?=
 =?utf-8?B?WTVXMkFFNnR2d3JkazZxNWVYOVphY1VNMDUvNm5oY3R1anFtNEhlbGtJTm9o?=
 =?utf-8?B?U2tRNXA5V0pBenBrWVdQNm9lSjFTRVd4VWRuSFZvcndBNHlMcFRJdHNBTTQr?=
 =?utf-8?B?dG5TRHc4ajV6d2ZGSFlobE41eUd4djg1ZXk0bWI5RzhyL1pFbUZQeGxHaE9Z?=
 =?utf-8?B?UFA2ZTV6ZjM0OHd2b2dSbE1wdUYrYVMrVUFTb1hWNzNIZTZoQ25EaFFwRHUr?=
 =?utf-8?B?UDFTdHRvNS8zclpHNERqeGx1YVVvSkxDeVpuY3pvTFllTUhPUDRWa0F4V3B0?=
 =?utf-8?Q?sdt0NyBlXnwkKXoXmW40T37borXAOPS4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:52:18.3835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93663559-ec8a-464c-cf58-08dcd7cff728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

AMD SPI controller’s index mode performance is constrained by the hardware
limitation of the FIFO queue length. This patch series introduces
optimizations to the spi_amd driver, aiming to maximize throughput and
enhance overall performance. The changes includes,

- Enabling SPI dual and quad I/O modes
- Optimize I/O operations using efficient kernel APIs
- Optimize I/O operations by optimizing set tx/rx count functions
- Optimize I/O operations by reducing the data read calls to fetch the
data from FIFO queues
- Add changes to support AMD HID2 SPI controller
- Add changes to enhance SPI-MEM support functions to reflect hardware
capabilities
- Add changes to set SPI controller address mode before initiating the
commands
- Add changes to implement HIDDMA read operation support for HID2 SPI
controller

Raju Rangoju (9):
  spi: spi_amd: Sort headers alphabetically
  spi: spi_amd: Enable dual and quad I/O modes
  spi: spi_amd: Replace ioread/iowrite calls
  spi: spi_amd: Updates to set tx/rx count functions
  spi: spi_amd: Optimize IO operations
  spi: spi_amd: Add support for HID2 SPI controller
  spi: spi_amd: Enhance SPI-MEM support functions
  spi: spi_amd: Set controller address mode
  spi: spi_amd: Add HIDDMA basic read support

 drivers/spi/spi-amd.c | 325 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 295 insertions(+), 30 deletions(-)

-- 
2.34.1


