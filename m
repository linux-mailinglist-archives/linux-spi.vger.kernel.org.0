Return-Path: <linux-spi+bounces-10334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4EEBA87E4
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 10:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9134A3C483D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B62C21E1;
	Mon, 29 Sep 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="trhC8hpC"
X-Original-To: linux-spi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020098.outbound.protection.outlook.com [52.101.85.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75F277C81;
	Mon, 29 Sep 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136322; cv=fail; b=JtIyJ39OE7v8g1Qc0VM+mlwqDvDH6Ws4j6A2S/z0HEilW/bfBRJOSS24mnlOC6Toq/4uvjlWA3xns0QBH8UVkKRRTpreaUATq0kiYBYnNLyAo1LjrB3V9mAl5F1cQChNzBTdLAsGkseXQFgTAGpTkjPZ1mRWKT5V+ALKgcvTux8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136322; c=relaxed/simple;
	bh=vYGOOTnQBaqGdCt3t08y5JBdsIEx+9rc4RRzW7ytz/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZE330AxgMf3+yGMkonYRmBLj6EZFZCpjOrs0GWItNvyrihxz3ceeI4DfnA6qSLLEO1fuyBXQpuXRUJSZHvw52Y7v994+Wspj9zt45C0UaITyn7+HvK+sZl1jgqUc9ersz9H/jPrvZ0fqLjmiBUCyoj334H5hUrR5LyU/z/DKfhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=trhC8hpC; arc=fail smtp.client-ip=52.101.85.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zpir4c2TSyeeoAJ1AoNe5cllpbJ6+9tGBCN3xw8Hcw2E4iL2M05uPmkz+Oh27KYkUp98fGs7ckVIWTHShxIah8uUDeletEAa/xzF6xZrtn4oAPRhOCQe6IlIApreqA0QepDezL/XiCN3XEyWte5JibIs7bX58A4n3FKugLz3MhLxRy60Z0k9CPdJ4MzdtREm9gyWRPWW1LlLuKiymZlB+ElaopEmG25PeDx79UKiKb55PpEIzfZFnyQaSwrMfwMoDNFeSgbBXnHv2jnjMvtEE6mdyGINwuX3sjK3sAa8/NsKdoh2B8AvEXMURg3VAU35Is5KivBuUmDV+jiNb7Lk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGrVg5qN9yKJdaqTcGaOG0zYohh9P+eZTUHjMEpllS0=;
 b=ihHSuzQ+o5wPhAO/LeVpXlustccg8woL7PwAMN6keHOMDb9jBhZbpad+r9W87zCplI+Xid7mA6XMXvt0mhbq5+BUyXC2H1eSmKdiZT8tTi39K/OPa5noHayCFj20vIhNM2Hm/Ilmb795CEtYWzpyP9avfRMCjgDx0sLtz42rGTPM16PFSEKDPM4uJEyptSju7AWAZQVRBKWa0GrtzOOFkGfRm84W0cinFXcK4nRLIjZUFfLDqjOQexI3GbLG38EzydSTywrwyuLwu/cWcvumemgqNSc4OnUs4I9yok/NVwLGu0PHVViot7r0rIg09jVVkkKcywU8rJCTZCnNGy1jCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=axiado.com; dmarc=none action=none header.from=axiado.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGrVg5qN9yKJdaqTcGaOG0zYohh9P+eZTUHjMEpllS0=;
 b=trhC8hpC12Z7Dkq0OnXHi3UbTOD0IiN1vofq2Taq3655XcYGumVafuLbSIvDRhYgxr7IHrkW5ZUxcOlTlewTASH1+QOf7gkYtZ7KwwY6E6n2GQhZvAA63ZPUcF1wceI+SLpjfbRoeXhgoxQnamFCKVqav28YltuTNSKZlWfo+/oJcy90aLppEL8H82220Co88e387NcJwFkUZQWc5cOJqhjoPW6GermcuLikDikw8FdGp0SvzAtiJ1Mi4EKNY827xM1RqKq/owR1N6ieG48MhVEDNp4x7cDsKjZa7RNo4hk+6B0ua22kFqHDt0yM0rFqupdVCbFdDTqls9yz3FBLeg==
Received: from BYAPR07CA0084.namprd07.prod.outlook.com (2603:10b6:a03:12b::25)
 by DS4PPFC86AF657D.namprd18.prod.outlook.com (2603:10b6:f:fc00::abe) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 29 Sep
 2025 08:58:33 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::c0) by BYAPR07CA0084.outlook.office365.com
 (2603:10b6:a03:12b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 08:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194;
 helo=vm-swbuild15.axiadord;
Received: from vm-swbuild15.axiadord (50.233.182.194) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Mon, 29 Sep 2025 08:58:33 +0000
From: Vladimir Moravcevic <vmoravcevic@axiado.com>
Subject: [PATCH v2 0/3] Axiado AX3000 SoC SPI DB controller driver
Date: Mon, 29 Sep 2025 01:58:00 -0700
Message-Id: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhK2mgC/5WNQQ6CMBBFr0K6dkxbJBZX3sOwqO1UJkGGtKTBE
 O5uRS/g6uf95P+3ioSRMIlLtYqImRLxWEAfKuF6Oz4QyBcWWupGtrIBu5D1XKKWUkJiB2ki8Hd
 wPM6RhwEj+Ei5RKtsg/rsjAlBlMMpYqBll926wj2lmeNrd2f1aX8a9ZcmK5Bg1MmqYLU1NV6/4
 6Pjp+i2bXsD/r1jO+UAAAA=
X-Change-ID: 20250905-axiado-ax3000-soc-spi-db-controller-driver-91a5e27c88ff
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, 
 Axiado Reviewers <linux-maintainer@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759136313; l=2397;
 i=vmoravcevic@axiado.com; s=20250904; h=from:subject:message-id;
 bh=vYGOOTnQBaqGdCt3t08y5JBdsIEx+9rc4RRzW7ytz/Y=;
 b=gXzhi4I05IVfrPrvLWgSJkkUkDavRsbYTOmFJ7g9s0nQH/hl0oKeG9xSqdbwrMGC/PcWTZfer
 BGuhqr1FbTABu/KHe+dYQ8PgousoMYpFnQ4/9mZgp1EBAw5PoFMW5tr
X-Developer-Key: i=vmoravcevic@axiado.com; a=ed25519;
 pk=iiyhWhM1F4HlCbbW3I3qKZhPCE8JsCrDQMgCBRg4YMA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS4PPFC86AF657D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7b90fe-146b-460e-6f85-08ddff365e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE9BVkdvRjExVGtjVG40c0ZuSXFudlV4d1FWOEx2eHlWYS84dXdDY2piZDVJ?=
 =?utf-8?B?azkvZEo3YzVxT2s4ZzRmTXJwQTA2bVRvRGxjMy8xUE9ESmtjemREUHNieUU4?=
 =?utf-8?B?T3FlOE1nN1FwV2RWbWdZUnNVcmI3Q0JZQkwxRFZva2Vrd3MzR3QyTWJtUnJ3?=
 =?utf-8?B?WUZXSVFvTkc5Ly9pLytJeTBNMzRxWHNKRE95bnhUcm5kbjlTVFRJbU95RzMv?=
 =?utf-8?B?d2ZuckdGWWgyVTNVMG02TVN6WkNUTWIyRTRacERFbFpVbWRSckozRkNxUHpO?=
 =?utf-8?B?MTZwL3ByUEV6SUJTa0VyVmpVVmY5QWJRcGc3RmVlaUV0bU5JdEltNEo4NlBh?=
 =?utf-8?B?dW5jSFZKVFZFNUVROEFPZktkNEYvUlIvNWJFeEJKWlRHM1ZLY2dzVW9VYUZ2?=
 =?utf-8?B?ODRHcXNnQm9PalVnTmpuV2RWY3RMSjlpREJtdkFuQmxqWWRVTkhWa0RlZ1pC?=
 =?utf-8?B?LzRyOGFQK2E0ZXRsVzJsNzB6TzBKZTRNcndDTERtMzYyMFJaVEQ0RDRsbC9a?=
 =?utf-8?B?c2tMa1NUVmpPMUlGU1MrNkV4K0s5dEpnZzF2OWNzZW9MM1RRaDhhb1Z5bXNN?=
 =?utf-8?B?VFo0UHI2a0NwaEZvUk5vSnQva1N0SXI0alU1NFFxTG9hK2loOVRDOWV3cU1Y?=
 =?utf-8?B?R29QcnpkU3NmQTZKbmg0d1VxeWJyNHg0VGhoZXcyYkRhQmd2MGZUdW9zQVJL?=
 =?utf-8?B?dlg5OU1qbmNrMFg0MGxsUGFFQlVidzZFTmtnRlVUVjk3Y0p5R3BSckl4MnJv?=
 =?utf-8?B?d3ZTYVlGU3E2OVVLemhodU95Sk1MZU91USs1ZktpcEdubnBhY0s3cGVtaTBV?=
 =?utf-8?B?OUhyNEE0Nk9ROTFDREU4aGswdjE4Nm1YRmVnVFNMVFNrOVIzSlJYRHFjUllD?=
 =?utf-8?B?eVJFS2FlbW82cDdkRUo4cU1BRGhOSUJMZmlMblN4SHRGczlhSnRSbm1yZm5N?=
 =?utf-8?B?cmk4TThJY21lMFZ1V0RUMy9pRW9qeUhacUxPTFRoU3h2NnI3blZZZDVYZzM2?=
 =?utf-8?B?OUE2TU43UWFmS3U0MFpSdTdlY25TNHMvZWU2czMrVXlMaHZENWhXS1laRUUw?=
 =?utf-8?B?NjErMXNKT3Nsbm1hYytiNE1oVlJiaDYvQW9nQ0svQjJNQVAxTGxwSElLL3ZJ?=
 =?utf-8?B?RnBzTm02Q1RNTThDUnVibUllTllSSnJoQ2k4Q0ZEWmVidkkwVTJ5RkNUUXlG?=
 =?utf-8?B?eFd2QlNibHB1eDRZWVZPUG5PN3dLUWZVQ0ovL0hpRnpxalIwaHlEUnQ1REdH?=
 =?utf-8?B?bHU1bVlKL0gwbm0yejVaVURFdjlNdTBzVDBnVzdpcVBwUWlSd0dlNk5DNS9t?=
 =?utf-8?B?bE1WeGhteFBPZ0hvR2ErTDAxOVl5WWpGeUx5Z09WNUR6SUZmanRRSnMrU29E?=
 =?utf-8?B?Y1VoOUY0NFY5RXJBTktMdzBtdkdqQUpBdU1nOERCK3JHTTM4TlY4WEVUNHBv?=
 =?utf-8?B?SkQ0Z092TDNqbWU2TzY4QWRmV2tyT2l4OXpwUWFVYmo3ZWswTDRqZGl2cytN?=
 =?utf-8?B?eENjaWNMUEZjYU1PZGVWMlJWQ1I4dmpDLzlTSkRhYkJFRjE4aFJNNkVtNU5p?=
 =?utf-8?B?dlZibSs4aDRDMTdzRTFRSmR4elJUMU9VdTBOQmlEL3J3TDJJU0owRDhIblht?=
 =?utf-8?B?c1NJTHFacDllRTB3N2NTNnJnbS9TNXc3R1JLMUZVTkNMZ3Q5RzJ2Ri9LbXdV?=
 =?utf-8?B?cENsODQ5TEN4UjJUakZPWW5FSll6eHJXSU9QeXNkcTk0ZTJMUjFLKzlnelRo?=
 =?utf-8?B?SzNxSnEweGlPODgzWXRSenI4ejE4OFdCRkdYSE1ZMVlXME9lQ2w3bm9VRXRw?=
 =?utf-8?B?UmxlWUd1SStadmhlbC81a1BtWjlhTXNDS1JCclcwaUlaSjVGT01oOEdhUWRp?=
 =?utf-8?B?dXlsMmdrWWFXazlJVExvU2UyS1RXNmtOUXZDS2FiaXhiZys5MDgvM25xVERz?=
 =?utf-8?B?T1RIUzh4OTJyVGN6b0JLYWcvdWlmQnJTNkFUa0xUSVJqdlpCMTdMbDkwSkR0?=
 =?utf-8?B?VlduOUQ1a2RxNFVRV3lFcmE5ZTJQcWo0ZUVmUFp6MHVmTGwwclFFcUZXcTRG?=
 =?utf-8?Q?zu470K?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:vm-swbuild15.axiadord;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:58:33.5219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7b90fe-146b-460e-6f85-08ddff365e8a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[vm-swbuild15.axiadord]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC86AF657D

Dear maintainers,

This updated patch series address the review comments from the original submission.
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

 .../devicetree/bindings/spi/axiado,ax3000-spi.yaml |   63 ++
 MAINTAINERS                                        |   10 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-axiado.c                           | 1029 ++++++++++++++++++++
 drivers/spi/spi-axiado.h                           |  129 +++
 6 files changed, 1242 insertions(+)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250905-axiado-ax3000-soc-spi-db-controller-driver-91a5e27c88ff

Best regards,
-- 
Vladimir Moravcevic <vmoravcevic@axiado.com>


