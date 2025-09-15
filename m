Return-Path: <linux-spi+bounces-10021-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A4B57C86
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991013A85E9
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBBE30BBB6;
	Mon, 15 Sep 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="MCeLEdlv"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2133.outbound.protection.outlook.com [40.107.223.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835F2FB978;
	Mon, 15 Sep 2025 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941959; cv=fail; b=EoPkXIjmBOgncve0v9NPsyrWkGWtOeQLsuP5OYgf3oF9QorxW7+FutyvMU6zvztniu8lOA5q6hsDTfjQsBoo69Hfz33yndyR4tWb+7eUEzK0mQkQyAe2BccwSYreAEEw2SJyUx+UF9AnT0X4i9D6D/JBMGuOHPSzVpkGI8+mb24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941959; c=relaxed/simple;
	bh=71sFFii48Ua4ksZOAh6tYpt0yxPpbk0cq4laI3L0ZcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=il3rCC1P5/dw9/Y+BxLLUjVjCA+yj6M84HEGty/1oXutGp4yOq3YmQNajKi5gkMXcER2sD5W6FLchEnk7bfkWpPwsmsN6V+38KfpbYblhR0qkcDAhj9RZ41oaLPyKwuKEWCQlEIEO0xfDWqX4j0ObP8Hsbm5jUYHxlqUydCkUZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=MCeLEdlv; arc=fail smtp.client-ip=40.107.223.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGJrLj7P3p3njtOgZcgFTIuFzGkc0IIRObfAusDRpVnIz1DNhm8C86MatTrE9ITjuP1Q06gC20o7UqzhNJu/JkwK+N8ZtPXH7pJyFV3kTlTSkCp2iKtDIPpK9gwJVtZefc7iYoIDtKnkJohTo/RCIyYBlYEEsCyVjNP925PNBNpRoz4W+tZ/uhQOJJ+r5O61ZogodyYRR6S5YY8ZcZVF5nTP08Y1atYrUc1vCNHZ0SDhiFx9Y4iBekytIE5hJHuBxBWAqj7UKd7QLsGqIJO5Kw6004owAdws4mm0+QGHYOiRI41Keb422vshQ5SVXCsPTBVfdblMTqpPVTVYfCnzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVg8IX+fmU84pkxLwxCCOG3wrXVMjM8O93gMvDPVR4A=;
 b=GmX0d8Dd5jNgmZQDW4FvkPyj34VrDJkogh8OMmXPadvGmSxDMDmom3ktFbR/YTilVEVLOkCnOatsXPKnAX+8M/5EQZ6wyuKe1wHuGEz+OTtQserfwrk5Y3QjM79NF0ur0MmD9AgkeFDgQzwugZTROhZIC2Mff2MWpyaiolm5U1voNZijyeVSV9gBvMD0T42uQSvxneyAdbqd9+0Cf4EW0g7Io7xdhxLulbMTmO81/IdtXupCWZPnee7ZwuhtlJnHyb6uunXhMzWz2GCBFWunTkYDdadSKuQ8Elc0PsiOlS3I/fkZL3ZhX4VWcb9Egw0WSHuRffV9CbRPqq6ACxUeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVg8IX+fmU84pkxLwxCCOG3wrXVMjM8O93gMvDPVR4A=;
 b=MCeLEdlv/Ev5LDQ8MkRuLUMHO5wgRbBBe+o7SUfp11nr134xmY9CzLCGj+44OiRj1ry/gntcuHpZsGQvqxGxKleWgLYAmZIphpop/9RIi+YdxqLw/FdolHFMtR0wJa2XsWdTxS1g2V6Re+Ll8d1oGV+Q5SvFgr8lZbHYMbwFio5qav4tkeRegisI0L2kQSMXn3vMgREiMy6H8v1LX1XGx1pdr/ChWKcVF05dtrg8A0SbVRJa35OsuleqXCEURHP85hHnQNtJvqw2smv+5cjork39V1Q7REZu6MadTRInFk/AEPKpQ3USaKZkdHi1VscAvypANqgc9uv+eBWkqSN4ow==
Received: from BN0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:e7::35)
 by PH7PR18MB5775.namprd18.prod.outlook.com (2603:10b6:510:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 13:12:34 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::30) by BN0PR03CA0060.outlook.office365.com
 (2603:10b6:408:e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194;
 helo=vm-swbuild15.axiadord;
Received: from vm-swbuild15.axiadord (50.233.182.194) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 15 Sep 2025 13:12:32 +0000
From: Vladimir Moravcevic <vmoravcevic@axiado.com>
Subject: [PATCH 0/3] Axiado AX3000 SoC SPI DB controller driver
Date: Mon, 15 Sep 2025 06:11:54 -0700
Message-Id: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-0-814a1fa2a83e@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoQyGgC/x2N0QrCMAwAf2Xk2UBWKW7+ivhQ21QDoxmpjMHYv
 xt8Ou7l7oDOJtzhPhxgvEkXbS7jZYD8Se3NKMUdAoVIM0VMu6SijisRYdeMfRUsL8zavqbLwob
 FZHPMY4ocbnmaagUPrsZV9v/s8TzPH0EXVjB8AAAA
X-Change-ID: 20250905-axiado-ax3000-soc-spi-db-controller-driver-91a5e27c88ff
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, 
 Axiado Reviewers <linux-maintainer@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757941952; l=1815;
 i=vmoravcevic@axiado.com; s=20250904; h=from:subject:message-id;
 bh=71sFFii48Ua4ksZOAh6tYpt0yxPpbk0cq4laI3L0ZcQ=;
 b=z4N4+XmFYWbAGiVrpZ54Vu4qz9EkdOXl3Tnamk8cLiArIcOc9tMk0vr/eUZWXABg/HCD9zbJM
 J61IfcaQTAsDhA0zMW8H/j94Fe31ncUxGtY+C/NQVgrWQp6pxPSBx89
X-Developer-Key: i=vmoravcevic@axiado.com; a=ed25519;
 pk=iiyhWhM1F4HlCbbW3I3qKZhPCE8JsCrDQMgCBRg4YMA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|PH7PR18MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dbb32b-469e-438d-f421-08ddf45988b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU9LenJlaFoyNjJvTzcyS0xUQzJocTZydi9XTXhWeDhTZUJQcmFUbkwwQ2tB?=
 =?utf-8?B?ek5MdjhESTdVTVpDdlZJQUNpTTJJQVVBeTVPOGpnRFRlQVNqNVE4aE1Ec0M2?=
 =?utf-8?B?SXBDSHBPd1poNkp4R291b1BibzZvdVUvaW1CaE1sM3o0VG9kOEZ2TEdoTlJY?=
 =?utf-8?B?eklFN3FURlFHc2FneWtWVitNS1k5WnpSMi9vTUJocDBycVBHeUE1SXN3NzYy?=
 =?utf-8?B?d0t6L0doVll5bjVSOHdFNGNRZFRmRnJrY0tpazJteitnWGs0UUtjUmlJTkxt?=
 =?utf-8?B?UkFZWjRTSHkvVXovSlVpZExzTWlGR2J2YXRhKzNPNW9aMTREVWRqRDl5TzBI?=
 =?utf-8?B?K3pzeGV5YjRyeTEyM1RGOW9ZWlVOZ3BtY01ySzlaUGlCaTFIU2RCdGlnMldS?=
 =?utf-8?B?R1IyUHJTcEIzMVVmZGNhTEFtMUhLOXNpbXFXSFNDMnlXemxvbzg0MjQwOVpE?=
 =?utf-8?B?d2VWaENJY1FOQi9HSm5nK1dTUDNsS2pheXlDRUZFYk9aNEw0aHhMN2VJN1Ny?=
 =?utf-8?B?WnhIeEdRWlN4NUp1SklNM0Z0UkE0UUNyZW14Q1J2akl3R3kxK2ozZ1hFQnA4?=
 =?utf-8?B?VTMzUWUzSlBzc1AyOVpyc0hqSHVTM1ZCWGV1RjllbU5jWGxKVFpPV2VuYi9N?=
 =?utf-8?B?c00zYU1CQmtFemVOVEYwQnd0cmx3WDZNUmF4cEI1MDcrVUQyVFhiL2NKTlRK?=
 =?utf-8?B?UEFtZHFrdTVsaUwwSitlMnVEalpYRXRWWHJJQ2ZSWWVKeGNPM3doSUl4UHBZ?=
 =?utf-8?B?V3dvU0xUTXpldm50VjJObHJyTmpSRkdYNzU5Rm5BVk53RU1ub1poTHhqN3Y2?=
 =?utf-8?B?NHRvNUdHb05wSGFGbVVrRjR5TysyMlZHdi8zUy9XeHNPNTdqalAxbEtTak9J?=
 =?utf-8?B?YSsrcTNDZ2dtVG5ROWJicnVpeGZBRjRBbUhBcSsweFd1K1pYUWQreVoxVTds?=
 =?utf-8?B?bHNVb2ovUjA4cUZkS3V5dEtyUEwraUV0bjROaFdVY0tzM3NIaS9uZTNaaVVO?=
 =?utf-8?B?Zm1tWWdVZkRhK1hzRUs1U1p5Y2IzSGFnWlF3aUsvZlRRU3ZlWEVJanQxV1Za?=
 =?utf-8?B?ZXdoZVdnU0o4akphdVJ6MEVUeXpLaURVZFg3UXVlOTFRQ2RwQTZST3FLYVFW?=
 =?utf-8?B?a1pQd1d4bmVyL09nenFDcWdGM0FGV0JOYUcrVlBSZWJJT09HZ28xaFFkTmkx?=
 =?utf-8?B?Y1ZVamZ0OUt4c2U3ZE5HOU5jcEw4TDZWU2QyUHZpdCtLK3lHUldNTEVsa2lP?=
 =?utf-8?B?QXNhdFBEY2JqVXRURnpES2x3Wms0b0x3amhicmtzeisxWmJaUUJjMHJ1Y20r?=
 =?utf-8?B?MU1aeHg3UFhHWGRtZmRKV3hGZWdKNWJ4djRjZGc2YXptdHRvS09LbG1VaEdE?=
 =?utf-8?B?TGk3enJlNG1TOUJGeTBPbktoS3BYV2FiWTJSVzNyRXd6N3hyUDB1SVFwK2lB?=
 =?utf-8?B?RVhqZkdCRUtBUVQ0dW9kWHpLejRXdXRCZ0k4MklBR0JQaDBFOXhqdFNTQ1VI?=
 =?utf-8?B?ekMrV2hLQjN4RDlGNmJURGZjellZQktnb3dtRmZOZE1Gb0Y2eWJOdU9zUkJk?=
 =?utf-8?B?VktuMDhvaUUwOU1sQzBna3V0Q1V2bk1HRTBQNjJpMmVYTlBtSzFJc2ZRSGtI?=
 =?utf-8?B?eHVYZHg5Wlc4bXdjM0I5Rit5MHY5V2dyeGpaQjVCbzBGUXV3K255SHB3Ukhw?=
 =?utf-8?B?M2pnMHNMd2pOdHZielM1czliUjU2ZHBNUkQ4WUZWTXRuT3pqVUFFQjlMd3U4?=
 =?utf-8?B?dHZpM2gyN2hvdDBRTFIyUWxUVkR5d2lFV3MwS2hWc1UxSWxVZWNiSnozNmNC?=
 =?utf-8?B?Y2laaE5DTk9KMXVvemR2WGFBbW5VUjFEMEhzTHpQeGE0d216WlVRL2RPTmI1?=
 =?utf-8?B?TW5PQitKMHZEUWNFMllxclFib3lJOWRhRk9EQVV3Y05LZE5IdHNiN1lyQ1BK?=
 =?utf-8?B?WmFqcHV1SDdJVjhDWjVFK09DeHIxRThYb3JWR0JaUWxWU0FYdmxuNzRkQUNU?=
 =?utf-8?B?YVlVSmpDdG4wOUZSRXNyVzdIaHB6R2d4K1NOZUVRZzkvbFR3RWtlYVkvQ2xM?=
 =?utf-8?Q?rOTeEx?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:vm-swbuild15.axiadord;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:12:32.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dbb32b-469e-438d-f421-08ddf45988b5
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[vm-swbuild15.axiadord]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5775

Dear maintainers,

This patch series introduces new SPI controller driver for Axiado AX3000 SoC and its evaluation board.

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
Vladimir Moravcevic (3):
      dt-bindings: spi: axiado,ax3000-spi: Add binding for Axiado SPI DB controller
      spi: axiado: Add driver for Axiado SPI DB controller
      MAINTAINERS: Add entries for the Axiado SPI DB controller

 .../devicetree/bindings/spi/axiado,ax3000-spi.yaml |  62 ++
 MAINTAINERS                                        |  10 +
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-axiado.c                           | 840 +++++++++++++++++++++
 drivers/spi/spi-axiado.h                           | 124 +++
 6 files changed, 1047 insertions(+)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250905-axiado-ax3000-soc-spi-db-controller-driver-91a5e27c88ff

Best regards,
-- 
Vladimir Moravcevic <vmoravcevic@axiado.com>


