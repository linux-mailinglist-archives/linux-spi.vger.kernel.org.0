Return-Path: <linux-spi+bounces-5502-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61799B161F
	for <lists+linux-spi@lfdr.de>; Sat, 26 Oct 2024 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADB0282E93
	for <lists+linux-spi@lfdr.de>; Sat, 26 Oct 2024 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE3D1632D3;
	Sat, 26 Oct 2024 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VzzSAhIk"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED3187850;
	Sat, 26 Oct 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929249; cv=fail; b=E+E+uTihvLUZlfqB6BFgWIWi+khmSgq7zqgc43mli+nHmEjDQOeGiuvwChtcxP519yUfjVkxN6TfC+j0jbYTcFfnPx2VlKoUQXZGbCSCM2VsmsZeh5Adx5ZXosLbcSLdftxc2sP3DiZUrccoZbDYklYMmyVTM+4v7i8lCRrs9+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929249; c=relaxed/simple;
	bh=oiAnf2OTO/OXBRxpxtLXqfhN9DfSLK5aFiOKWSrOVqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lARHSmuHGdtox+oLJNyYjlrB8VfZwd1mJTg38jiZa52KUpPze7VAVOtYmVFWq0XqntJedzXOGXeQSrW/UgClrqpR9pUVi0hfCCii9o7PczT7aJ74oUJ7KIt9cAwOFMvaTBSq6mTjjMGILMX0TutMK7AWdKg/9PSAbDekibdatsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VzzSAhIk; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHotzg0n1+ezvf408CQ+tF82XOKThWuVPyEClIXEBroMGbitdiQphZyqHX/3TrbeR3/xbuDj+Q0C+om7TdHYQ44j9LKA3qGTqE38hAx1E6CBlnaoT/zwvlOMsGRKvslgTOshqCYmwDfPToshSwM4RR/jrfqKhaYBaqcXP8aNU5aq8lmQXMSNWrnlE9UgABhrqo5qzo8kdRDVqdHnGcJVtXVaiwy+p4AK++HURNekYNBJc+tVW357TrlJDhxSfkVp6JPC4ndyooFNyqZdiy3Abilq0ABgGxYZ3MpYvoEm78Opjcx/0GU+rkg11I1kPts83+VeMn5H+E28qkWuFOwdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCkx8x6mHsRXwVvB+TNKNXjz58tewrfQLQaerKE0Bnk=;
 b=ebyMPDZPATJyG+Z/Qg5MDZAVlgV7hSgoW4OqEk7XaBOk9D47pYDoUPCB2vUgcdx5oooxQB+oCqM/7clG8DEA448cVKkPK4fkiEmTipRTZ0RtWVTIjJ7IoszR8CrgaomdElA4Y92AwObl/NPz7AojtQQQV3SHvSxW2GU7xUTFo9yjpDwK614RDsw7WD6QKTlxKJWwvnaz6WEUMYVSvvhfPszEPeSGthH83s/wm83eisNYu1UwMLsX/wTsqH4pL3dGu8PpRFEt72GxdyPr2XULaBKT0+68o8co9IqaDe+nSe6+bZC7KqBz1lLGLx8oNVMMX8Or6USUkSjQNsNBwkv2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCkx8x6mHsRXwVvB+TNKNXjz58tewrfQLQaerKE0Bnk=;
 b=VzzSAhIka1EsnzhwTLxJzCQ//WOc3WC6pwFIrbzgSxM9Fn8kgyVlCh1d8I0Z389HL2nSeX09BhZN6OsXpgY9IFnymW/b1QRAE4ep1JY1sxtIOjZD5e6obA04avMtyy5GMavvW9M28Vyr8ZxjsbHP5TkmLqtuAIKxKHEr6QFgfhE=
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Sat, 26 Oct
 2024 07:54:02 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::f4) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Sat, 26 Oct 2024 07:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Sat, 26 Oct 2024 07:54:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 26 Oct
 2024 02:54:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 26 Oct
 2024 02:54:00 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 26 Oct 2024 02:53:54 -0500
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <tudor.ambarus@linaro.org>, <michael@walle.cc>, <broonie@kernel.org>,
	<pratyush@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<miquel.raynal@bootlin.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<krzk+dt@kernel.org>
CC: <venkatesh.abbarapu@amd.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<patches@opensource.cirrus.com>, <git@amd.com>, <amitrkcian2002@gmail.com>,
	<beanhuo@micron.com>, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [RFC PATCH 0/2] Add support for stacked and parallel memories
Date: Sat, 26 Oct 2024 13:23:45 +0530
Message-ID: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: amit.kumar-mahapatra@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 39930f44-7c50-4111-2fbc-08dcf5935b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1pwTHRHc1ZDVit1RDAweTRHVkZoeUtFMjFhVFNTekYxYkdpOS9MSHE5S05a?=
 =?utf-8?B?aStURXV6eTJjREFROCtrbG0rVkE3ZEE3eHZ1NWtLa0VTejk5Y2ZadEJ5MVM5?=
 =?utf-8?B?RWxHQ1lYa3RNcVlkdm0wSThvanVsRk93ZjlUazVyd2l2QUNZejBRSExWSUNB?=
 =?utf-8?B?R1dUcnZ3MFg0SU1TNEY3YmlvTGxqaGtuMmQ0R2dpMGhvR1RoWDVuSGVkRURv?=
 =?utf-8?B?SnF3cStlL3oxNzJDa0JhWGFXSVhOUTMrTGRxTkxmSVRReE1Cb0R2RytmdGxv?=
 =?utf-8?B?WWVyeEJvOHByckVpS201M1h2VEZuekJzWmJ3OW56dWVBdWk5NWcrS3RoWTY2?=
 =?utf-8?B?UDlrbGVEY2RBcnU0VUpXLy8yMFVRaGtncmlzZU04aHR5cUxaemMvUHl5Y1JF?=
 =?utf-8?B?bndRVm9DSXRVUVdLTDhwK3lZVVpZMXZZTFNTc0Zkd1JRRVRDbEJzT1JneVZK?=
 =?utf-8?B?cjNTNEROdWNPYlkwVCs5eWV3T0RXY3Q4bG04OW9EeWg4R3J4MUZMTTY1TXR1?=
 =?utf-8?B?WEdkbDk0N1R4UUVwOUtzSUFRcDRERHBoMnI0T2MvempiWGNyTU9tQXVZM0tk?=
 =?utf-8?B?SWN4QWgrWVZ3RWlVdW5vSmhZSEFnc3FsS25DZDdHMlBCZ1NuYXBqMENsOXBF?=
 =?utf-8?B?bnVBWFNGQWp1anVyZVZhbWF6MjhRKzg3Sm1iSzJkYzJyN1p6cHFKM0FYaGJv?=
 =?utf-8?B?RzdVNUk2U3dmMytBaVYwM3AwMGZOV1pmcTRuc2ErUm5INHNLSzZpdEszMWtT?=
 =?utf-8?B?NEVSNHhsa0FSdG1kWXRqbWQ3TXNWSlBmRlpaRlM2ajE5SWtZTlUvdmlXcnpX?=
 =?utf-8?B?T3VQQ094eHVGL0kxYU0vVnh0L3E5dGNkdDU0aDE5QzNSbHdSWXpZQm1MN0pq?=
 =?utf-8?B?S1ZqVThSbUtnSlRCNmwzaTkyMEtGcHV4cU9GMVhpUWgxenkvWDZnRjlqM0ln?=
 =?utf-8?B?eVJJdkI0NUJVLzFDcDgxWEFTTUErQUZvTXlEcFpyZy9QQlFab0ZLSWQvTlVU?=
 =?utf-8?B?a2FTWXBhakJoTU03VWlUSHBUQmwyQ1FzTS9penhCVFJPbGEwaHE3MGo3Vngw?=
 =?utf-8?B?MjdmY3pLWFdSQWRyQjhGK0FEbnFraEREV3BWVjlyTTZHeWtNdmNnb1U2UUtJ?=
 =?utf-8?B?bGpOS1pCOHduT00zd09BQ3E0ZHpUZ05aZHczclJYY3FZaTJ1MEIwTUVZZXJU?=
 =?utf-8?B?aUhEaXRxcXhyWkNRK3hZMzUrYTBYK1VJQzhvVXYvNlUyVVVsdFFzOTRtekNo?=
 =?utf-8?B?aktGMXhzdEc0KzcwYzR1aHp3ZXcxMGNQdnBoa0tXZ1dNYjBHYW5zQWp5WGQv?=
 =?utf-8?B?cFk4dFdYTzQxbTFwM0o3UUJ5aGhhbzl5NFNzRCtsU1lwSHVpTVEwVlYxc1ox?=
 =?utf-8?B?WndzNXpPbFNSRVlSa0tmNWVZVW9PNFYwUHJMbEgzM09RYmU2QXU3K2hybUhH?=
 =?utf-8?B?TW9mVGRLZ01tblJsd2xkaTFKbjV1ZkdlRGlIOFJ0cXRBMi8rZGQ0c2NKOFBn?=
 =?utf-8?B?ZzdKc0c5RjR0NUtMVnV3M1NVNWxDVkw1UEsyczV5WFd0K29DRFFrL3hsYWlv?=
 =?utf-8?B?SjArci96ZHc2Vnc0V1ZEeU9NZEVFb2ZHTVpvWEN6U2pYU2RBNzByc2hzNXZJ?=
 =?utf-8?B?ZnZoM2dCNjhMekVTRDBrcUtpMnRrcFpOUS8wRlpTTktiQXRMZU5kTkVVdk92?=
 =?utf-8?B?ZXBvaWE1U1BsVVBydHkvQmFRRVVjL0Q0MUxrVzNva2lVRFNMU0pLM2NpSDlu?=
 =?utf-8?B?em1EUWg0bnRCTmJXNTFKakhkaStKcGYyTGp2b0IvOVdBV3ZHN1pxUEttUm94?=
 =?utf-8?B?SXdxTUpCdkdlbXhhdDFNZ2ltUkpOZGVsalJLRXh0UFlCN0g0QkcxckZmNDdr?=
 =?utf-8?Q?/srWuIqbdshKP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:54:02.4119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39930f44-7c50-4111-2fbc-08dcf5935b8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828

Hello Everyone,

Following an email discussion with Miquel regarding the binding changes
and overall architecture for implementing support for stacked and parallel
memories, I’m sharing this RFC to initiate a discussion on the proposed
updates to current bindings and to finalize the implementation
architecture.

Before diving into the main topic, here is some background on stacked and
parallel memories.

The AMD QSPI controller supports two advanced connection modes(Stacked and
Parallel) which allow the controller to treat two different flashes as one
storage.

Stacked:
Flashes share the same SPI bus, but different CS line, controller driver
asserts the CS of the flash to which it needs to communicate. Stacked mode
is a software abstraction rather than a controller feature or capability.
At any given time, the controller communicates with one of the two
connected flash devices, as determined by the requested address and data
length. If an operation starts on one flash and ends on the other, the
core needs to split it into two separate operations and adjust the data
length accordingly.

Parallel(Multi-CS):
Both the flashes have their separate SPI bus, CS of both the flashes will
be asserted/de-asserted at the same time. In this mode data will be split
across both the flashes by enabling the STRIPE setting in the controller.
Parallel mode is a controller feature where if the STRIPE bit is set then
the controller internally handles the data split during data write to the
flashes and while reading data from the flash the controller internally
merges data from both the flashes before writing to the controller FIFO.
If STRIPE is not enabled, then same data will be sent to both the devices.
In parallel mode both the flashes should be identical.

For more information on the modes please feel free to go through the
controller flash interface below [1].

Mirochip QSPI controller[2] also supports "Dual Parallel 8-bit IO mode",
but they call it "Twin Quad Mode".

Initially in [3] [4] [5] Miquel had tried to extend MTD-CONCAT driver to
support Stacked mode, but the bindings were not accepted. So, the
MTD-CONCAT approach was dropped and the DT bindings that got accepted
[6] [7] [8] that describes the two flash devices as being one. SPI core
changes to support the above bindings were added [9]. While adding the
support in SPI-NOR  Tudor provided additional feedback, leading to a
discussion on updating the current stacked and parallel DT bindings.

Proposed Solution:
The solution has two parts:

1. Update MTD-CONCAT
   Update MTD-CONCAT to create virtual concatinated mtd devices as defined
   in the device tree.

2. Add a New Layer
   Add a new layer between the SPI-NOR and MTD layers to support stacked
   and parallel configurations. This new layer will be part of spi-nor,
   located in mtd/spi-nor/, can be included/excluded via Kconfig, will be
   maintained by AMD and will:

   - During probing, store information from all connected flashes in
     stacked or parallel mode and present them as a single device to the
	 MTD layer.
   - Register callbacks and manage MTD device registration within the new
     layer instead of spi-nor/core.c.
   - Make minimal changes in spi-nor/core.c, as stacked and parallel
     handling will be managed by the new layer on top of SPI-NOR.
   - Handle odd byte count requests from the MTD layer during flash
     operations in parallel mode.

[1] https://docs.amd.com/r/en-US/am011-versal-acap-trm/QSPI-Flash-Device-Interface
[2] https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf
[3] https://lore.kernel.org/all/20191113171505.26128-4-miquel.raynal@bootlin.com/
[4] https://lore.kernel.org/all/20191127105522.31445-5-miquel.raynal@bootlin.com/
[5]https://lore.kernel.org/all/20211112152411.818321-1-miquel.raynal@bootlin.com/
[6] https://github.com/torvalds/linux/commit/f89504300e94524d5d5846ff8b728592ac72cec4
[7] https://github.com/torvalds/linux/commit/eba5368503b4291db7819512600fa014ea17c5a8
[8] https://github.com/torvalds/linux/commit/e2edd1b64f1c79e8abda365149ed62a2a9a494b4
[9]https://github.com/torvalds/linux/commit/4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b

Thanks,
Amit

Amit Kumar Mahapatra (2):
  dt-bindings: mtd: Add bindings for describing concatinated MTD devices
  dt-bindings: spi: Update stacked and parallel bindings

 .../mtd/partitions/fixed-partitions.yaml      | 18 +++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  6 +++++
 .../bindings/spi/spi-controller.yaml          | 23 +++++++++++++++++--
 .../bindings/spi/spi-peripheral-props.yaml    |  9 +++-----
 4 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.34.1


