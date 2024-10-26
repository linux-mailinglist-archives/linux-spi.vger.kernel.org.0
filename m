Return-Path: <linux-spi+bounces-5504-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C89B1623
	for <lists+linux-spi@lfdr.de>; Sat, 26 Oct 2024 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3EF1C2146E
	for <lists+linux-spi@lfdr.de>; Sat, 26 Oct 2024 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C61C4A3A;
	Sat, 26 Oct 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tLYoDJej"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4A1CF7A2;
	Sat, 26 Oct 2024 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929261; cv=fail; b=JeW4hlFYigvBfk2Rl9ZJtxYuwPJW/GG7gVOAppYKbyZ2t32/h+aLf6IHxKS8gPdtecX6kgMfJsED8IhbQofBza0jJ+zQrHPi34t1xgqvFhue7cIBAgGSauxpAXwLFkN4V/j3vbfiUgz5uTgizYhrx+BtEkt0lvoEhWZHzPWbEEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929261; c=relaxed/simple;
	bh=0q05/MbevCkEmzTkh3vQ7Wca08bw07kSjIbrFNOKAys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjYzDZ5J1ppAySVKmrBC/KEibevr4VHl75zC0rSU9eSXA8fMdxOvHLbQSTJ+pJuNo5RHATwxdtfpTFpEOWgmw43j2Amws8W2Smvfo09wo0UAJVchvkptaoZ1yySbrRtcTj0doyYsl+nth1YMGWYAsB8soLdAWDQn1tCO+9f5LzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tLYoDJej; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGa5b1Tb8Ec5UNVg69VQ45wWus7I5LoKduuRd69tEP4co/3bbduMxHBcb2YG2I1XQPa4jUi4vf9/0qE6AHYyaih0ULAhJBDrc5qOU0SXee8UTum4nT4iuQAGVaXmaaMrqI5yXSd0bVJn0lph1NQyJA6dNweyvCWngI0QrQzSsfVuqYq7GKvvwq3l1N2aA+4VORUzjorL2NSIBnZnh3tSYP5OGPKnsuA/qeUvvOyKWoKhBhYNXhcKL6PE8tqK/bhqAZHF6dbwuhHmMSKCR/P0Gea1tzI4Z2LcHa2p1OhmFgCwq6fvrJMLysbHn1o8GtI496jTvkDdyVwSP8zh9LZAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owYK/6+V3VUTla7EukrIdWHtCfgdNgNjjMHBG3WW1+E=;
 b=pfrBohqvElexBbyvO1ocJxVuwo1n+ZZTPolgfZAcGKWsaElV4d4T+UTFFyRppq45DiUPF+yp09CnMGQvPDIacubwJu242Sq2/eTAA+64cu+gX+flPcodXvl1d/Z8Z7nSWPuuCgb2IGR8lL2+7uxdL6n4TrWvQOVbuaj+/WY2DVsOJmuDpS2HbVmFAzhOoYrVwlr9nYk+zC/JZPeuQcsc6JzxGyAmjHwBNHL2FgvZ16e9JoJZCLeKyS8qJ0LD0MTFIBADwalnnyOh8c+9BsxImSWu5xg4hiQqIF7eQ2sk8jFvlgn/Vgu4u2y076hlvPt5PmJ7uID2/vWTykMdm1fdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owYK/6+V3VUTla7EukrIdWHtCfgdNgNjjMHBG3WW1+E=;
 b=tLYoDJejm9yXd5otWASOIRpGzV3hVu555/6sqnMvbYMADckGUMc7EUeOfQV6SyZK7NmiA9OdrPaRA9UF6IZqrOZKwFZfQNMvL9moeRo9fADP8bi4MYe7wxB2qMEYDqt5EEaB7UAb6OZOQyURz3i8H0R8GiHv4MDIrm8jow/4V9A=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 07:54:14 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::7b) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Sat, 26 Oct 2024 07:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Sat, 26 Oct 2024 07:54:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 26 Oct
 2024 02:54:12 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 26 Oct 2024 02:54:07 -0500
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
Subject: [RFC PATCH 2/2] dt-bindings: spi: Update stacked and parallel bindings
Date: Sat, 26 Oct 2024 13:23:47 +0530
Message-ID: <20241026075347.580858-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: amit.kumar-mahapatra@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da072c1-1097-459b-0c34-08dcf5936289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzBmMFBlUitLelU5WCt5UWxnbDhsUDQ4MlJPVVdFMk9ieENrTU8yUzdVY2tt?=
 =?utf-8?B?N1N5U2RnMnhRTGdsbmU5dndwVU1jTHFFbEY2SUxsRndzQ0IwNXNhaDdkOTFX?=
 =?utf-8?B?OVh6WWp2dnNGOFUvaXVSQVFwbUJTbkhkNDlhSnBLWXlQamRzalRDRGdkTVlP?=
 =?utf-8?B?S0dzY1VtUFRQdWlkNnN6aTByOVZLLzdvTVdRaUxBMnBmUVdSY2dIMnN5NkRR?=
 =?utf-8?B?ODREaUYvejJuSlQxVzRTOVJVbUhHMjk2cy8vV1J1dElTRW12dUtpSHVJSU9B?=
 =?utf-8?B?a3ptbTQzRVZhdWdCWUhOU1RFYkhXVHFkY3ZBemhhRjZCL1JPM1BKU29VbGdL?=
 =?utf-8?B?VlBZK01CZmhTV21EdGtNeVVvMllXalNHaHJEaXBHd2J4dCtLR2MvZDhoWm13?=
 =?utf-8?B?KzBJNUtnbC9pN0xtazRCajc2ZzQ0UG11MVMybGdJbnhhcGtsZFJzelEyTE1C?=
 =?utf-8?B?Nlo4Z3ArZzVBOEFqRHB1ay9jOThZdmJ6VDAveWxvNG9tWGRrd2tFRWpkMFlD?=
 =?utf-8?B?WkRvNWxldWtSVmtyTUZQUGpWNjRiQVhKdlRpOGxsRE54TzBEa2YxdW9VdENn?=
 =?utf-8?B?ZTBCUzQ1eHhjNVE1WHJtaVpFRWZoajRObUhwSTZqaUt4RXAxbEQyZXRDZm9J?=
 =?utf-8?B?ZytjcmViSkJsbW9uMDk2ZE5uNVpuOVJIend0UlVJakJhSlFoUmpZc042YnE1?=
 =?utf-8?B?NnJQaGZwOUxvY2Q0VWRWVFUxOFB2aVRQZEtGQTZDUVdKdmJ2S2xxdGJ6TG1X?=
 =?utf-8?B?ZkNRdDBQL1VaNmJiVWtnbW9hRzNXbmZkTDJodWdJOWJrTVRFWGovRU9YUkZw?=
 =?utf-8?B?cEI3NEN2b092dnNESjFvaXlQL3dmeTg1cUFuOHBPZktqaHZ2d0xDdHhCZlk5?=
 =?utf-8?B?N0NhZTUwQzZUazR4SlhabGdrTEUvYlQyRU9KVG9KK0FEWkg1eDhaR3BDeXNP?=
 =?utf-8?B?a3NmMlRBM2N2eGRNN2tFN09aSnlMYUlZUHNYN3dNdURnY1FyT3JLL3pKU3dF?=
 =?utf-8?B?UW96OHVxMllpMGdhK1U5d0FjUDdNdE5YKytJdHQvdytVd2w0ZVFlaXk3R1Vk?=
 =?utf-8?B?amNqRkN2S0Q1RGpuQ2RwQlFhSlFtRWhrVFJqRWxvenBRN1JMbTEreVNMV0px?=
 =?utf-8?B?SGtpOUhsQ2FFeDNBUTNyTTJ3MHF0NzFRcCtCYUpWVElqTG44UUdITmYvVktp?=
 =?utf-8?B?U0lPenhYYk5Xc0I0ZjczTkdqT0kya0N0bzlEN1NMZ0htWGRuVjJFNk9hWEJ4?=
 =?utf-8?B?WXVRc0JTNXdobW1wMmovamhqbHRqamdMSjNqR01lQ05ua0JhQXkxTlQ5Qk9o?=
 =?utf-8?B?eEdma3F0ejcxR09ROStzRzg3ZE52WStnZGwraFVJTXR1Y3lVK3J2L2tZTkpD?=
 =?utf-8?B?d01KaXpuNEVOSHZHTU9qeTk1MGRKLzFYRU54dDBQM0R1THVrV0VKQzRycjBs?=
 =?utf-8?B?akhOVHE5QmNobzZWYjFPcThkdEczbWx0TTE0SmxONk5lUTBHRk5UbkRRVUN1?=
 =?utf-8?B?VEd0cDBxR2FZZDkrRU8wS05yWFdXTXBvdmJ4aHRTYXdQNk1HNHI5ZlpwY0ZU?=
 =?utf-8?B?V080N2hSQlFuSFhLQkNlZDlRSU10QkNma1dZSG1XckNudHk4dzYwVlJQV0x3?=
 =?utf-8?B?MXpWS29EQWJ3OE9UUE1MSWM3M0pmd3dEdzZaRUkyektMZk85S1BCYjM3ZFNN?=
 =?utf-8?B?VDRXOG02VWpBRHZMRG45emdSNzFCZ2VRN2ZsQnQxdkluNDN4Vy9SU1hCNWpm?=
 =?utf-8?B?MVoxRGgzWS9PeUlIcmwwTUtHUGYrbmxIbWJaUEsxczVXMFJmKzZJcEpXMHRF?=
 =?utf-8?B?Q2dXa2tieW5SQmt3aWxJNkN0OWlpQW5Yb1psR0NtK1lHa2lUN1FPc3oxMU9Z?=
 =?utf-8?B?Y0pqWklzWEhxVG1mT2tVb0g1Q1FGZTlLVlB6UTVrNi9obWRmbjBMODlkak41?=
 =?utf-8?Q?PAV9WO4hsQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:54:14.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da072c1-1097-459b-0c34-08dcf5936289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733

For implementing the proposed solution the current 'stacked-memories' &
'parallel-memories' bindings need to be updated as follow.

stacked-memories binding changes:
- Each flash will have its own flash node. This approach allows flashes of
  different makes and sizes to be stacked together, as each flash will be
  probed individually.
- Each of the flash node will have its own “reg” property that will contain
  its physical CS.
- Remove the size information from the bindings as it can be retrived
  drirectly from the flash.
- The stacked-memories DT bindings will contain the phandles of the flash
  nodes connected in stacked mode.

The new layer will update the mtd->size and other mtd_info parameters after
both the flashes are probed and will call mtd_device_register with the
combined information.

spi@0 {
        ...
        flash@0 {
                compatible = "jedec,spi-nor"
                reg = <0x00>;
                stacked-memories = <&flash@0 &flash@1>;
                spi-max-frequency = <50000000>;
                ...
                        partitions {
                        compatible = "fixed-partitions";
                                concat-partition = <&flash0_partition &flash1_partition>;
                                flash0_partition: partition@0 {
                                        label = "part0_0";
                                        reg = <0x0 0x800000>;
                                }
                        }
        }
        flash@1 {
                compatible = "jedec,spi-nor"
                reg = <0x01>;
                stacked-memories = <&flash@0 &flash@1>;
                spi-max-frequency = <50000000>;
                ...
                        partitions {
                        compatible = "fixed-partitions";
                                concat-partition = <&flash0_partition &flash1_partition>;
                                flash1_partition: partition@0 {
                                        label = "part0_1";
                                        reg = <0x0 0x800000>;
                                }
                        }
        }

}

parallel-memories binding changes:
- Remove the size information from the bindings and change the type to
  boolen.
- Each flash connected in parallel mode should be identical and will have
  one flash node for both the flash devices.
- The “reg” prop will contain the physical CS number for both the connected
  flashes.

The new layer will double the mtd-> size and register it with the mtd layer.

spi@1 {
        ...
        flash@3 {
                compatible = "jedec,spi-nor"
                reg = <0x00 0x01>;
                paralle-memories ;
                spi-max-frequency = <50000000>;
                ...
                        partitions {
                        compatible = "fixed-partitions";
                                flash0_partition: partition@0 {
                                        label = "part0_0";
                                        reg = <0x0 0x800000>;
                                }
                        }
        }
}

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 .../bindings/spi/spi-controller.yaml          | 23 +++++++++++++++++--
 .../bindings/spi/spi-peripheral-props.yaml    |  9 +++-----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 093150c0cb87..2d300f98dd72 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -185,7 +185,26 @@ examples:
         flash@2 {
             compatible = "jedec,spi-nor";
             spi-max-frequency = <50000000>;
-            reg = <2>, <3>;
-            stacked-memories = /bits/ 64 <0x10000000 0x10000000>;
+            reg = <2>;
+            stacked-memories = <&flash0 &flash1>;
         };
+
     };
+
+  - |
+    spi@90010000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "fsl,imx28-spi";
+        reg = <0x90010000 0x2000>;
+        interrupts = <96>;
+        dmas = <&dma_apbh 0>;
+        dma-names = "rx-tx";
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            reg = <0>, <1>;
+            parallel-memories;
+        };
+      };
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 15938f81fdce..2a014160d701 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -96,7 +96,7 @@ properties:
       space with only a single additional wire, while still needing
       to repeat the commands when crossing a chip boundary. The size of
       each chip should be provided as members of the array.
-    $ref: /schemas/types.yaml#/definitions/uint64-array
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 2
     maxItems: 4
 
@@ -107,11 +107,8 @@ properties:
       different memories (eg. even bits are stored in one memory, odd
       bits in the other). This basically doubles the address space and
       the throughput while greatly complexifying the wiring because as
-      many busses as devices must be wired. The size of each chip should
-      be provided as members of the array.
-    $ref: /schemas/types.yaml#/definitions/uint64-array
-    minItems: 2
-    maxItems: 4
+      many busses as devices must be wired.
+    $ref: /schemas/types.yaml#/definitions/flag
 
   st,spi-midi-ns:
     description: |
-- 
2.34.1


