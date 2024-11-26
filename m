Return-Path: <linux-spi+bounces-5843-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 842699D98CB
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21837B274DD
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2024 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF01D54E3;
	Tue, 26 Nov 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ThArSLF4"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92461D0E26;
	Tue, 26 Nov 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628774; cv=fail; b=N8ktEmW6G8jY2eSjtW2LIz/0C9O1e7/D1tXFoynszZ7MUiKhlfwVTwK3GvG6qAdYvTKldbl34usV1QU5fopkLLEVzzn8gZUPdQqPP2O40W/9wM9jiplJC/Wo+DqpbsmDxG3DaiwmUwFZwrsZppTbchd83j56ak/7Gv5GNGdh+wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628774; c=relaxed/simple;
	bh=qrZonj35rnIcHQI4BMR+ux+zr0LHark6rWRaccwSy10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPkOgJRNSsNSgMFSixqY8L7FeLftwk0g1nPX73wHqNWAdJjlHX0sRAzQ8g64YaDgluTIc33lUmY6wyRV61Gzc0iV4FOWm2KY3HZgMQmRYG2omyWK1fR8XDCY5jiOloLhRfYaEMkyzBMsGS8g0EgAxS260je4V/kSTCpN1iNYeYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ThArSLF4; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poAYZnjG8sHL+mF68p/FMc8d/PdTpGmrv0uu7iQ0DNlvyRDMuthOMNoY9Hz1lk1T2DBLs64RDwOW/qfA9hY7NjnqPiYeON1jShyAChcMK85GBX/Ll8BEXGJepMr3JeDlLuKkFmKAhUf5GxQ/3hmcdXX4oowBPlHe9f4uKV0PSRP4DO5fsTdGZMymvHniygmxT8zQSbB71s5ej3W1KkE0BYmaZbpheDdNzkKgqKOeLyYkIzck1PcyfJCP8w1lVPmEQ3XGL/UUogvIQKmyR36lwniWXOR7gIZC0GeYFGZAOLRxuSnOxZJLQz+HEKGfCUOxq14QokGhcpi3Oljs1Vzi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRTBLyG3jWM3Efm8wooAo/3JODOL4lFcgX1yHBL0uoE=;
 b=RCg4W8683pNyFqKC0nH/S1MvAwYwjX2CPr0J0jMTPYhL2+/J1igpHP0NI38fJ+AMQ7oKLrYL0M9TUp235ocShhTf5wAPek0NSSRdsnSs2hy3E0FXkdgt/nnGuoUZBaq/Q6xlEcEwcvre08i4+sNvdtqt0Lzb1TJnAVzU1SF676RzbOWURUVqA0y/Jydyq4eDMtWFO5T+a2htQCLJnDPVjjb77oyWTzNi7LyW7RNhr2qBtP1krD0kUPsVxwSXIlAvOo6IomxdZEwFApmpCBn5h3dtUemwUW4BWo0JcCow48sYHDjsb2ivIqRgx0Y3Le++RUeCcvfHi/5qn/DHqKomyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRTBLyG3jWM3Efm8wooAo/3JODOL4lFcgX1yHBL0uoE=;
 b=ThArSLF4SosXxirpkfFLH0T2NuzzQjLed4yYfhaFcx/f7DHQT0NJtK7Wac/vztYcmlhg779vrIvMQOKwCK+Jwx6cQeAxWf2gpmIds8uqQQbCo8RxG4AmNVdaW0SACxzcK0eonaLdSriFGMij/EZUmLQERDR7/xJecslE4EmvoBuWXF51Yu8ovG7yKCJz4v6q1jR6sEK0sIRnTQTIh3d98r8LMlNsudbmE9u0JIBgSoDYjhPMD0Z+kdoN1EzEv/YZFAFuyq9qgXNzWtMWmP4+bJK9qtZJwCLqQ7MXKRpldWN+uLk4UUHJPpnltwA0Sqv4ztm/12FWIQeyd3XKqqgg9Q==
Received: from MW4PR04CA0179.namprd04.prod.outlook.com (2603:10b6:303:85::34)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Tue, 26 Nov
 2024 13:46:08 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::69) by MW4PR04CA0179.outlook.office365.com
 (2603:10b6:303:85::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Tue,
 26 Nov 2024 13:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 13:46:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:45:53 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 05:45:52 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 26 Nov 2024 05:45:49 -0800
From: Vishwaroop A <va@nvidia.com>
To: <robh@kernel.org>, <jonathanh@nvidia.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <broonie@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV controller
Date: Tue, 26 Nov 2024 13:45:28 +0000
Message-ID: <20241126134529.936451-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241126134529.936451-1-va@nvidia.com>
References: <20241126134529.936451-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 46adf3dc-7e9f-4707-d60a-08dd0e20ae5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlhLTkErV1pqOFR1bHRVc3M5OG9mU3dZV2s5SkplWFF3OW1nKzEyYzhnMjh5?=
 =?utf-8?B?M3ZvL3N5ZVBwSGdUQ3dHQmdwbFNCNnJja25TVWlFNnRSSGhIYnpSYUNlRVda?=
 =?utf-8?B?bk5hU3ZZMXZ2TzdBSWl1cUVoSUQzQmVzbVFBYVBzQlB3NEZsa3FCRW14eEp2?=
 =?utf-8?B?NEtoM21xdHBSK1VFK0VKNTZEaUFrUmQ4eFFISXorczQxWnhqaVg4Vnc5U3pF?=
 =?utf-8?B?cnFrZWRmaldFektHNEZzekZJSjlQSXZNSTMxUGE0K1pBYnFNS25hMmUzUTY5?=
 =?utf-8?B?ZVI4Z1hCcVVOVVRaNUhQL0l3cm45QzFxMkZlZEN6bDVSalBCUElhTjBtMk9u?=
 =?utf-8?B?WjdFb0NUeDhFcGh5clpKRDBoTERIcnNGd0ttUUQvb3kwMURPcFQvVklTOXdJ?=
 =?utf-8?B?TUlyTVUwT0pPQUwvck1tNWtOTDBKL3J3TEN3N0I3VnF0QnhMY0VyVUpFdFV4?=
 =?utf-8?B?eERkZFU5NHAxc3p4MkRaOXFRYnJCRk1YTXlZSnY3amN0NlR4d1VlWUZObUNr?=
 =?utf-8?B?TVErN0RVblhPNytSOWNKamtucFRMeTZLZEhjU3d1d2g4dTRBY1hWdE5Ed3BJ?=
 =?utf-8?B?QUdRM0VpK2ZOS1o1ZVBhYkUyY1R2ZWgyNjdCZmE3UXl5VmowZmJVRTUveisy?=
 =?utf-8?B?V3ZBaGNlRXVPTENTUnh5ajFZYWtESXFhell4VnZhUkRVcFYyanlvdnJJdEZU?=
 =?utf-8?B?SDNzNEJiZG40K0twcEc1ZVdhOTJ4dEoyYU1oclhYVDl2OEl4MDJzNkFiUWpR?=
 =?utf-8?B?cEtrNnMzZGpwbFI1WktXWjRuWlo0d0ZTQUhEdmR0WExyU084MmtKTzRLVHov?=
 =?utf-8?B?RlpSV2JhRkt1cUNJc2w4Zmhsc2EyVWhHWFhobmY5N0gvRUZveGZLL2VhV0R2?=
 =?utf-8?B?ZENpMXEvS0NPQ3EvWVY0QmhCRjVHSVpxQlRDTnZNNnhERXA2bkJnUlBJYUlG?=
 =?utf-8?B?bTNsRlF2K0w2QXRWS2FOOTVoeG1PaXAwKzh6eVh0NkdSL1RKQXdyM1hzN3o5?=
 =?utf-8?B?R092eTduUDdpWDVaSStTaTliYkxBUmVlVW1tMkhTbGZ5ZTRWekpXTWxVdWhq?=
 =?utf-8?B?R2ZNdDBoYWZ5ZEZrV2VIZnEveGRuTFVJczhKdXppREVCU3hTUkZsaC93NWJM?=
 =?utf-8?B?YktTMTR1OFBUZmZMSEFkS3BSVTk3TWlCanRidXVLemRzNGNJbS9hSFR1V3F5?=
 =?utf-8?B?d3VVc3VsVW1qbWllMjVoY0hOTVYvdWNmZ0VmSWlxRTVxMGw3VlF1YkRZbkJm?=
 =?utf-8?B?NmVQTDRNTEFnc3dnZGNSSEZWY3ZYL1pKRnRqNWRnK2ZrU00xcHcwZG5jNlEw?=
 =?utf-8?B?RlRqd1JCd05Ob1hPc1c1aW1PTkY3blgvb3cxQlRmS2tqcDZ2VHhHT0VzTGZG?=
 =?utf-8?B?eVUydktkc1pHSXdzWVJlcEFQa3N3NzBHS0VRcHRDYVFZNnc0NzZwS2dPU3dJ?=
 =?utf-8?B?QmhtYVJaNXV5bVBFQ2thNi9nMjhVS1J1eEl3ZzRPNGJzM09wblhuS24yYmtZ?=
 =?utf-8?B?NXhJdFozQ3VyV29WVHZMdm02NmNpbTRVQ3J6V2Y4U1dxOHV1ZnJyT3VsSnBr?=
 =?utf-8?B?b0lsbkJqZUk3UW1DZG9CNmhwN2ZPc3hRNC9abVl5dkJXTU5rSllKMkNucDJ2?=
 =?utf-8?B?U05tK0t0YlhRb0NyS0l5VlhhejFPQXlqUW9OQk43cWhkUFZ3dFNKbXpmbGRl?=
 =?utf-8?B?UFNWdng5Uy92RkJ6bStNTDJxNWtuVGtLQjU4NnlwclhrcXFEem45TWJha2d1?=
 =?utf-8?B?QWRYRGNKYTBhZVFCeWRFVUp3VXFpVExrZWliVENrdE01c3lBdE1tM0lrK3JP?=
 =?utf-8?B?NnZLRkVVMXNYNnhCMFlQdi9WRVNXQURHSjJNQU9NblFiWHlaUkRUSnFZNW41?=
 =?utf-8?B?ek8wMjV4Q0NKeFRnT2piZitFR1hqL08vd1VxR3dkUmhCVkg1WEhzNk1QVkpR?=
 =?utf-8?B?aVVIYVpGNkNJZ1hwYTNPRUxuMGxETFlQNkxxZVRyOU9MeFplZ1daWEV3RVBa?=
 =?utf-8?B?MDNMdjRWRHNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 13:46:08.2643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46adf3dc-7e9f-4707-d60a-08dd0e20ae5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235

Add DeviceTree schema for NVIDIA'S SPIDEV controller.
The schema supports both master and slave modes for data transfer
purposes. Specifies required properties: "compatible", "reg", and
"spi-max-frequency".

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 88abb5c174f3..c8b39a513fc5 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -293,6 +293,8 @@ properties:
           - national,lm85
             # I2C ±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator
           - national,lm92
+            # NVIDIA Tegra SPIDEV Controller device
+          - nvidia,tegra-spidev
             # Nuvoton Temperature Sensor
           - nuvoton,w83773g
             # OKI ML86V7667 video decoder
-- 
2.17.1


