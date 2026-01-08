Return-Path: <linux-spi+bounces-12202-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ABFD03DB0
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 16:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 281D531501AA
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA536CE06;
	Thu,  8 Jan 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=axiado.com header.i=@axiado.com header.b="iyjnItIv"
X-Original-To: linux-spi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020138.outbound.protection.outlook.com [52.101.85.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8736C0D3;
	Thu,  8 Jan 2026 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858318; cv=fail; b=bmq68sZRJyptbOL5mP8VDyq5UrzIBtfTaA21vbIbfCNoYPLcWcZvuzpwW4sD5IxQrSL6lzM9Y4YQxH/WmR2c6os2c8VgIJamUNG1ZMQJeEbTx4x6T/gFT7xvaLQQnt4It9buYWlwWPKfa+JYmcDeA383+++NmH7ZKibcoVZZPf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858318; c=relaxed/simple;
	bh=2q0iqUlX3PP5Ro+l9O1De9CDuyVH54cZc8Jh8rvfgW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e1tEYW7k+nlQG9FyVklEV51Xr1ajSTjdu5uYJzWoNJI1RH/6fFQyE8hxoCM/S6sMjnA7uJGxXU9jg7cs2ST9tT9PqxJtWtUWBXRhkMWcnQ3+N9DB5Ces+C3kgyUIxItocENMZbxwDI1DBxwm2wWh88YW/Unuv6V+19vKYU+ZY8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=iyjnItIv; arc=fail smtp.client-ip=52.101.85.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB0UufCcWO7loMRRGKaWqRlPHvyM1XEAkHkKWVJmwUOqbCna42H5rOuPTTmef0r8TroM7D7SdBC+MQ9yAzP1+UXtk96EhNKROqx/ODish44tbHJIrGGjkrsZpJ+qPcPKlNRxxKQNCuVHLaaisUrDIJzz9xBIsVkpmRX4XzqVJVb39fh1HJxD9feIwDfq66OgXlOcOftskO50u14WZVlydMRs75FjbSi63yaU8ga3WZhcQKhC6pD7K9pB8fJrLK7zHxZxfuzv+YaKNI4W3AFiApnKIgn7ypj1Z6pndJ+LimAs0ItW5rMJH2YrPBmGrlmDkXr+7fB0cotOjpu2Z85AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zax+rW3q86WZnv3RJFAWuPsEv5YwyZbtOZGDGpQMYsc=;
 b=EiOO4JemXP43TMplwubFsP3SKgGaFiIcEAf8qekV0AAmYOvX3KEQe0v/3sxmUmrjiZYzfnWVi9Xb7mESJ+Ixanv7dEAh7Mjbf+Qnd3GNO9s/oqD5qgmposTejZM3pXW7qDldNoCZBBkNToG/zUcsU3hvdFd9LhtG2j8GvSgOtPT93u3WaIZgjqqVRxpbBI54fQIoY3kkWmawo6VF/5IeuUlUQxyiH44asnSyX6tJbxWQKqrSK/uZ9BkVlwTmaCi0ynbUPKTltsrtIiOnxbKTIgCjij1AwMEcC3qa2LKrDuP7B6NfkD/5pHEBPqUCxLqu/SJJuMNdghE3cSfgx8E4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zax+rW3q86WZnv3RJFAWuPsEv5YwyZbtOZGDGpQMYsc=;
 b=iyjnItIvTUoXyEC275p3pPm3cVs9azKWA9/rs9yNC6Hnfbxmyl532OINHtSjJSw42NULbjonBPoc8mxHmTW3xdjYyvUFst6j3DaasBmdSs2QeJdYXDoilwO/Pz/ptvBpfKvKGQ1uBOZ6NeBYKQe014ACiAXnnyM+njuuaGvRgPp6CUGMoqwxccmwgixuozQal+09/rwQEEjq2yv0p6S1ymaixuffsIRAi6QksVJ0e1IkwjGkjqccBhHxZhOB62sl2n1Poh36Z27MWtJW7IosN36ZEbkP2/0FN2GV8LmMJ8R9LzC6h4L4IooEgdC+9rVUoFxSVUA5x8XpkB5e4GCGPw==
Received: from PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::17)
 by DS0PR18MB5337.namprd18.prod.outlook.com (2603:10b6:8:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:45:05 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::e1) by PH8P220CA0034.outlook.office365.com
 (2603:10b6:510:348::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 07:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 8 Jan 2026 07:45:04 +0000
From: Vladimir Moravcevic <vmoravcevic@axiado.com>
Subject: [PATCH v3 0/3] Axiado AX3000 SoC SPI DB controller driver
Date: Wed, 07 Jan 2026 23:44:36 -0800
Message-Id: <20260107-axiado-ax3000-soc-spi-db-controller-driver-v3-0-726e70cf19ad@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRgX2kC/x2NywqDQAwAf0VybmCb1EP7K6WHfUQbkI1kiwjiv
 7v0NMxl5oAmrtLgNRzgsmlTq134NkD+xjoLaukOFGi8ExHGXWOxDg4hYLOMbVUsCbPVn9uyiGN
 x3TooPSLzRE9OEXpwdZl0/8/en/O8AJTUYaV8AAAA
X-Change-ID: 20251222-axiado-ax3000-soc-spi-db-controller-driver-2b4a33f293ba
To: Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767858304; l=2683;
 i=vmoravcevic@axiado.com; s=20250904; h=from:subject:message-id;
 bh=2q0iqUlX3PP5Ro+l9O1De9CDuyVH54cZc8Jh8rvfgW0=;
 b=Edntwsk71hhossPIFqd159W1TPGKDMoB5XW4pH2bi+zIWnCLQhFy18jKCzv8J9SSQa/5Qda8c
 p7g2o5yhOf4DhUSm69YCPbj+oRQ2L2HU9MC7b+SVQPc8tNC+B2I6Ruv
X-Developer-Key: i=vmoravcevic@axiado.com; a=ed25519;
 pk=iiyhWhM1F4HlCbbW3I3qKZhPCE8JsCrDQMgCBRg4YMA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS0PR18MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8f831b-d575-4731-f45e-08de4e89d6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDNoTGd2c1hYRnhWSHU5NEtKQTNGRHFoUjBneURuaUJVOEYxcXdlb09JOGpu?=
 =?utf-8?B?QWExL3g3K09TSkJTVzBYOXJjSk8wL2FWQ0gxN1Zic3hWT0QzQmZBQ2tNbDFo?=
 =?utf-8?B?MjNOc0YyR3BRUUxGQnRUKzVmVG9HR1F6c2FiVXltNGFCSVA2VEZpbGdRS09q?=
 =?utf-8?B?aUUwcnJJN3loeml4OWEvcWQwbTZ5MzJDMzB4YXlQUDVXREhIRGo5VDdjSmdD?=
 =?utf-8?B?cFN4WXAvWk05TUFReG5hYXdTekhHT0NHT2RXb1FkVktZT2xUZnorcHk5QUln?=
 =?utf-8?B?U09MbXZ3bVJONTdSVlRObnA2TUEvUUM1Y0tHNzBPaVNvZVlZMWs5cm9uMEh5?=
 =?utf-8?B?bENhYmxoc1ZlQisrbUdUR3l4VVAwSzRKamV1Y09rbGxmYlNEZFFqM2l4Tksy?=
 =?utf-8?B?U3RpZUpFeFJIZWU2Q2FFbE81bTFVQ0JXTEdIODQwZDZSbnlvMmlIdVdjd25E?=
 =?utf-8?B?Z1U2cEMyeEFyQTdBWlExQWlsVmgyRnloUmhxVThib2pOSmdqMVlOeUt1M2dz?=
 =?utf-8?B?V2tvL0VQbFVSb0F1WHpQeSszbjlWRHNVMm9DMG9QN0ZRRCs0emYwVm9DRHNo?=
 =?utf-8?B?NlZ2WHdIeG9EZ2pRWjN2QTRIMUFWY0ZxWFZoVGlXazJSdzQyWUJyTUFKT3l1?=
 =?utf-8?B?R3UxOWFjUjRMUVhGdDJIWnhNWm5hTEhtTGxJNFpaMFRJcHcxbGN6bUxUQXlL?=
 =?utf-8?B?UDh3aURWQm5aTm9oZkcrSmVueEI3Q0hwSUdEbTdHRXNCUVhBTXlpMVdXZjN2?=
 =?utf-8?B?SDRNSjJ3a1BMN2RWeDZXWHNWNms3WUlJZnYyeGQyNExZVzIwbXJ4M3U1WHpR?=
 =?utf-8?B?M3BtMjBBSFpEWC9Hd3NvdHFOTHZpMnJ5UGNOTGV3UWJ3OWZEREJpSldqaXVM?=
 =?utf-8?B?VHZlWmVRYW1yTy9BYnFMY254VTYxcnl1VE5Hb1dya2V6SG03QngzY2x0SEVt?=
 =?utf-8?B?Q0pUdkFkZ2xhNHRiVjVmY2VRMngwSm5CcTJScDBxdUlwZ3lxZmIxcExpcGlR?=
 =?utf-8?B?UWxEUDJGR25jVkRkWXpDem1EZHdKUkkxd2JiTHFzd01Nd3FsbERqK0ZPRi9J?=
 =?utf-8?B?MVlqR3FFQkhpRWE0cUh0a204NURjY0oxYUFYOHdBc2hrb3NGb1RtamVmNThE?=
 =?utf-8?B?ODNtUDI3TEZ3OW9oU3BHRmJiMEVycjY5Qk83NEw0T25vSy8vdWgvNUJtRm1Y?=
 =?utf-8?B?VytWV0R0RnhDbkZIcGdLbFp2L04wYUFYOUllR1lYNkxZcXlQYWxUVXhJWC96?=
 =?utf-8?B?M3I5TDJPTW5hM2pRUGd3UjNtcU1IeE9iY2VTWU5SUXM4R0VPYU5VVEpGL1F4?=
 =?utf-8?B?VHlsUXgzemNlb1FEUDhKKzh5OXNBRjdyNitQWStTYW03aFZOMytrRElaQlBP?=
 =?utf-8?B?NWhOeXhINjJrVjVwSEljVXJHUGp6N2wzWWx3TlB4OEZXbTNobUFERzV6ZUVj?=
 =?utf-8?B?bG91by9KSlh1eEMvSlAzRklOemdHejd2ZC9jUExFbngrMlN5MDNtWlZoSWsr?=
 =?utf-8?B?REJNdGNXMDYyM2p2R0kyeFJjK3ZBZk1GdG00TXFtQ29qdjAydFJLYUF1WHhi?=
 =?utf-8?B?T2s5Zm4vWVFNQXRWSFhnK1pPL1RsckI0U09WaGJKUUZRSlVIVUFncFB6TVRQ?=
 =?utf-8?B?dlVOcVRlQ0JxNVhZUEt4ajN4RG1mR0EycmhzeWJmNVA4d0tWYkdBSUV3KzZ3?=
 =?utf-8?B?K1Y4Z2M2bWhzQ1JjZnlXZjRGc0tnek5pMXlOUTd0NkpOVC9UbVBPaHFsaDJ4?=
 =?utf-8?B?OXdNS1VYOUI0ek15VW9wZEl1d2tRVndDUlJpT0JMY0VVbzFhRWtqbWJNdHMx?=
 =?utf-8?B?R1pvV1NsdWZkcmRmenBSNndHdmxQY0VVZnRVbU9Kczl2NGFXNTYvTkJCRUFK?=
 =?utf-8?B?UHplYWVOVXNybEZJMklBWDFYUVZvQ1pjaFRrM094TCs0YzBpbHFVckJjbDNO?=
 =?utf-8?B?WlRUVzlmQTFIUDRaZFlMZ09qQ0diUXJJc0hQQkVJblZoMkZqaUJPUzlZWFI1?=
 =?utf-8?B?L2dHNDdTMG10NXJIajFhTWhmTVBWZWRyZmlwTHB2dFdzaUNPQWJIQkl2a05G?=
 =?utf-8?B?QWhlWUhPSWhzdFByakQybFN0bXdDWUIyeXBRcGRLUUpDKzk4cjF5c1czQ0Nt?=
 =?utf-8?Q?P/Z8=3D?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:45:04.3825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8f831b-d575-4731-f45e-08de4e89d6a1
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5337

Dear maintainers,

This updated patch series address the review comments from the v2 submission.
It introduces new SPI controller driver for Axiado AX3000 SoC and its evaluation board.

The SPI controller provides:
- Full-duplex and half-duplex transfer support
- Configurable clock polarity and phase
- Interrupt-driven

Functionality has been verified using the `jedec,spi-nor` interface
to access onboard flash memory. This ensures compatibility with common NOR flash devices
used in boot and storage subsystem.

The driver integrates with the Linux SPI subsystem and follows kernel coding standards.

This initial submission includes:
- Driver implementation under `drivers/spi/`
- Device tree bindings for supported boards
- Kconfig and Makefile integration

Further improvements, including performance tuning and extended hardware feature support,
will be submitted in follow-up patches.

Feedback is welcome.

Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
---
Changes in v3:
- Make comments uniform
- Remove return value void cast
- Remove unused variable
- Remove transfer delay to avoid double it with core implementation
- Link to v2: https://lore.kernel.org/r/20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com

Changes in v2:
- remove _clk from clok-names and chage clock style to use <>
- remove set but not use variable
- switch to dev_warn_once
- use devm_spi_alloc_host
- update ax_spi_remove to unregister controller from the subsystem first,
  and then tear down the other resources
- add PM operations
- update maintainers in dt-bindings
- Flush FIFO while transfer done
- Link to v1: https://lore.kernel.org/r/20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-0-814a1fa2a83e@axiado.com

---
Vladimir Moravcevic (3):
      dt-bindings: spi: axiado,ax3000-spi: Add binding for Axiado SPI DB controller
      spi: axiado: Add driver for Axiado SPI DB controller
      MAINTAINERS: Add entries for the Axiado SPI DB controller

 .../devicetree/bindings/spi/axiado,ax3000-spi.yaml |   73 ++
 MAINTAINERS                                        |   11 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-axiado.c                           | 1007 ++++++++++++++++++++
 drivers/spi/spi-axiado.h                           |  133 +++
 6 files changed, 1235 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-axiado-ax3000-soc-spi-db-controller-driver-2b4a33f293ba

Best regards,
-- 
Vladimir Moravcevic <vmoravcevic@axiado.com>


