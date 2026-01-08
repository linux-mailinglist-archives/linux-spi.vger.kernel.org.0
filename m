Return-Path: <linux-spi+bounces-12204-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BC0D03B11
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C2131C3F36
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3D2374188;
	Thu,  8 Jan 2026 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="kW7PiRaM"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022130.outbound.protection.outlook.com [40.107.200.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB936B056;
	Thu,  8 Jan 2026 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858338; cv=fail; b=F7w5/RM75uXQuml3AT2tAYqYDTmIBWKeaZExQZLSkFjaYq3VuvIlaqiOi6lhC79dKa3Eu2YwDASPaEoYb2zACYt4GpAyN0ciy33wuYWvkGiVEshM3wmnDVR9rNzPIZnoFZ/hRclTY7+bAUG3gpsCoCANTs8v0eT8rB1o15RUSaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858338; c=relaxed/simple;
	bh=Gs2fPQsJqqC0p6Q5Xyaf/g1pN8TOeWoqNAbutQbbAqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjqZVDMhITx7IOH6DBX1+qiQT1DmqAunxrDWb9yJDMsXktNV60AkiAHQNPQ59FMxWue1El8228E2eG4Sdp2fSNt6B02hAJnNt7iQH3Nmxl/4tfmwXQVeAcxsLhKpqJbfKXRXr20heeU8KvAyQo+SgXs0C+2cQGk1OGDnMJxg4So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=kW7PiRaM; arc=fail smtp.client-ip=40.107.200.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpbj5HbLzFrQCp9g/1PALkLXSqwWXIiI+u97ssgZlV9eNyzAaky1hKlHOYAxqUGxbTiRF+xq1vgMfQ9jrv0Q53A/js0k+odEskual/Xa/UJG6yJVexzvHZVy3akif0oJV6m7lUSAeul5Ujp9kG37y5QlHX8RxmaTCDCIYW63Gz1WIRyROpS5kcBJdbkLSzQI5Wma7HC5gInfdFP/CiOHhuIOmjRIcsDgr8dXV6trAiLjPpsGJD3F9A9Df9l5k8/fzK3S4q7LLHGrc/4JZvTbbnb/KLJaOXlXwSn9PCNMkc/t4tNdGcIepOldPdrDwpPJudVx2AfVyr/T/qF4wfmWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfBTlH+yu/jDIKvt+BhwMod9LRqfvGjWZgI4Mkze5Qk=;
 b=TYkjPNznoN69hNqGGhjfWNucrvmMAPBmxREKwy5kUb8HiRUD8+7r36fsXDI2GMTG/hKXMXBckd7r1hHIZ45Q4XMK2cIRQHwobiNAJY4ox2cENwx7PdAppFEqhFUjhBeO3G5GZa4mKRBYuB6T7x/8cFY/Cy97w++E9tUYvTdOQUz5yHoGKnS8l59sAEQq1WRUWNi+UyfyRiwKj0HtYf0qn36WWC/YG9RMXjJZONejCZEowWehcHnqz5XW1fD5bhxt0KmXFift3EC/jNQppMo04vnQNbzh0IIkq0/lfhN3cTZcgX0bFdz8KbLJzYCx001/Z+I4vSjpJFly6XXtv1Vc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfBTlH+yu/jDIKvt+BhwMod9LRqfvGjWZgI4Mkze5Qk=;
 b=kW7PiRaMaZpgQzgnlthf6AUZogaKxH5nCgfld3YBX7MFZf6iXjHA/WB1hYf0EzXXKde22ytD4FZTWTdHeUsMTMu59wZABWRoiqResPm/4RR/FiArL+hOmWCbuLReSG2SuvJHf3WDzYI1ISkrmEnfbZFsYzEdnkY/jwQr50dT5Nps4/QVyObdw28S8jNV/tEQDcM2EJGVuwhw51iton5YrdnBDsSol4RfWNDAAzHV5o1+rNGMVrPlZQLTt+rb0nPotdCJPnl4xFnPAPj9WLr4K2lzqXZJzRnYqRJnOUch5qTtyLQ4aglyT1Wh4An2Ia/8fYvjxp0Ooz4peUdr3jtqoA==
Received: from PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::17)
 by DM8PR18MB4485.namprd18.prod.outlook.com (2603:10b6:8:32::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 07:45:10 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::7d) by PH8P220CA0034.outlook.office365.com
 (2603:10b6:510:348::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 07:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 8 Jan 2026 07:45:09 +0000
From: Vladimir Moravcevic <vmoravcevic@axiado.com>
Date: Wed, 07 Jan 2026 23:44:39 -0800
Subject: [PATCH v3 3/3] MAINTAINERS: Add entries for the Axiado SPI DB
 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-axiado-ax3000-soc-spi-db-controller-driver-v3-3-726e70cf19ad@axiado.com>
References: <20260107-axiado-ax3000-soc-spi-db-controller-driver-v3-0-726e70cf19ad@axiado.com>
In-Reply-To: <20260107-axiado-ax3000-soc-spi-db-controller-driver-v3-0-726e70cf19ad@axiado.com>
To: Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767858304; l=1140;
 i=vmoravcevic@axiado.com; s=20250904; h=from:subject:message-id;
 bh=Gs2fPQsJqqC0p6Q5Xyaf/g1pN8TOeWoqNAbutQbbAqo=;
 b=bwBxHoay3NtOVTKBK/z3GllpVrwsxDqoGBXc/dUbO/LeqP7ypIp41AkSycH6tG0he5AFXJnIe
 aGvNv9O0LY5DwcCu9ogj+SpS4lYOMrqD+Kcj4QbQSYEPR9UQJI42v+w
X-Developer-Key: i=vmoravcevic@axiado.com; a=ed25519;
 pk=iiyhWhM1F4HlCbbW3I3qKZhPCE8JsCrDQMgCBRg4YMA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM8PR18MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: acb41091-cb1a-48c0-58fa-08de4e89d9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0w1emtPeW5PMWlhS2wvaktwcnE3aDI4RTcxL3J4Rk5TcE4wRkxLOG1HcWl0?=
 =?utf-8?B?L0U0eUgxL3ZlMnM2MllNc1dyT280Y2tQdXNBT3N0elRKemR0clRVZktVL0xn?=
 =?utf-8?B?SlRyVHpXaDJYSERPeVVVS3RIbFczTUhGTXFQdXE2WXNUZ1NzZXZEYTFzbHJD?=
 =?utf-8?B?UVBvVnJMMHlUMGhhUDJkV2lidTJ4NFdGampLYlVPZDRxbHByVStBYzY2U0tv?=
 =?utf-8?B?YW5ZMnJ6dlBJOXovK1JpeGFQQmpjV2RFVnhLeW53eW1kOTRUOFlUc0xrdkFR?=
 =?utf-8?B?SVdYM0VCYXo0UHJNeW5UZ1dteEUrMkxZeDNOckhDazFzZnp6RDJXUE00MEt0?=
 =?utf-8?B?cituLzlvT1BmTlduQTg4MHBsTk0yREdwOFc1dDNEak5NemZjOFhpVFd6bnVp?=
 =?utf-8?B?Y2hKam1vdHc1eXBCdEpnWkY4cXZwV1IyVVZ1cGpUMXVLZTloRFBhVUxER0gx?=
 =?utf-8?B?emZ6ZWtCWWpTcSttZktLTlJIQTJ6ekNta1RhZURjWTlobXdEUFpFVnNSbXNU?=
 =?utf-8?B?UVZxVGkyWHM5OGh5Q1VTbDRKQmx5NEMrT0FPZmoxeFZLekRMeG9UUll3d0lV?=
 =?utf-8?B?N2NsY2hOTzFHeDgwMjVUaXhSejVIK2YzTEJqemZBR2IzNzU3UFdDaUVOeUlm?=
 =?utf-8?B?Lytoc2tGbmt6VjBmdWMrcnArWUVYRk0zN2xPQk4vVFZ1bGJiUmhZRWx5dlNy?=
 =?utf-8?B?K1ozZ2d4Sy9XMXJCMWkxVHJUcnBBN3ZCbmpNN2x2dVFlRllDNlJNcnJqby9S?=
 =?utf-8?B?L0EwaHMvVWZHSWhJNU5ZN0pkNHlzYVlySFMvK0tLcWdyZEFWUmtyeUphbkNI?=
 =?utf-8?B?eXJ0VUUvRE9WZ090cjJSV05YT1dDeFgzSjVUMi81K2ttV0pwbFU2bXZiaWs5?=
 =?utf-8?B?R2kvWGlmOFIva1Vtd2ZzTlJKeEZSNU9BL1VKVnltSFBESXR6SklhRXdIVzNo?=
 =?utf-8?B?TkovemlRc0hQSUZSUlhrUVJtUTZQMFRNbHFnWHdsUGg5OVRUUDNqNVFEaE4z?=
 =?utf-8?B?ak00bWtsMFk0SEZoWlFBQVpBdytJbk1TYnRubFF2azdSOFEyWXZyUnJJNmF1?=
 =?utf-8?B?T3NNRmtDMlJMbTJTeVUyeXFNYUJXS0owajVES09WWG9xNDU4Ti92ZUo4VFZB?=
 =?utf-8?B?bVMvaWVieVhuVjZIUldEMmtPdGVPTEJFSDl6UUFoaTNBZFlwUFBvZWgxbWJZ?=
 =?utf-8?B?SEtNdUw1cWRrc2p0eFVidXlPV1pkUmZOMTEvSVRIdDlrekdvTDM0K0F1c2hn?=
 =?utf-8?B?UHRsL1dyVzhFckFIU1llcXV1K25SbURyTyt1QVRPNVR5aFlESkNBZnJ6bzR2?=
 =?utf-8?B?K3YxWGFyS1JDVGoyYlB2YkNnNVVZdzFSSXJvT2NGdEhtaTJRaUpMMFRUdXpi?=
 =?utf-8?B?aUxReUJNUklNOENNT283SDBKa0l4NGxSTnR1NDJHck1XaE5Ld2VYNW9PNjIx?=
 =?utf-8?B?b3RTT2xJUGZlUUp2NnVqTTdEZEJKZGttY0RURWw4a1BPclhidE93ZGJrNHRw?=
 =?utf-8?B?VEpPR2pib1BrMWplT1QvSUZvemJuMkdIMVVCMGx4UUJzWFF6VEVMRURtZkwz?=
 =?utf-8?B?MXhDdU1IYmNON1B6U3c2T0E0Y3RGYW5FdUphcFI0QTFSK09BL2cyNWJLQ0ZW?=
 =?utf-8?B?RXF6QTdzTVNMMm82dktoR1VocDFTZWJFSFJuanRhK0M0cTk4Q254YXNXVTZS?=
 =?utf-8?B?K2N1UkVFeENTM2NxSFc2UGdWelkvOUVnS2gyM2g2OFdNY2JkazdBcDZ4ZGJj?=
 =?utf-8?B?VUptNzRSTmNKNGJ5OWxzaW82Tm0vR0JSVFdGeHdoK1N5bllLaGJwaHlhSGU5?=
 =?utf-8?B?dW1iWEJ0YWF2eUVBM29MTVNSSW51UzRIWUdNSFRtZ0FSU0xiRVBvQnF0ZWh2?=
 =?utf-8?B?aWtveVYwcnpoSHVNM2xYaWRRdlZCTmhvZEpuc2ZEd09BVzZzL25kMmVENzE0?=
 =?utf-8?B?UkxiNEF1SXAzdHRqbHY3NFJZVXVBaDJSclAvWXZwWW80UG9hLzRobUJCVDFt?=
 =?utf-8?B?ajhaU1h1bTFtendQOHNrOFNtYWYrR0g0eks5ek8rTVJ1Wm5kVWhqUXphTGM3?=
 =?utf-8?B?UUdUSStIMkcvcnY5akdmSERTWmRldXpkUHlmdHhWZnAwTkVKZU4xbEwzU1JG?=
 =?utf-8?Q?m9yk=3D?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:45:09.7484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb41091-cb1a-48c0-58fa-08de4e89d9cf
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4485

Add the MAINTAINERS entries for the Axiado SPI DB controller.

Acked-by: Tzu-Hao Wei <twei@axiado.com>
Co-developed-by: Prasad Bolisetty <pbolisetty@axiado.com>
Signed-off-by: Prasad Bolisetty <pbolisetty@axiado.com>
Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc731d37c8fe..9b53ac06ad42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4270,6 +4270,17 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 F:	drivers/pwm/pwm-axi-pwmgen.c
 
+AXIADO SPI DB DRIVER
+M:	Vladimir Moravcevic <vmoravcevic@axiado.com>
+M:	Tzu-Hao Wei <twei@axiado.com>
+M:	Swark Yang <syang@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
+F:	drivers/spi/spi-axiado.c
+F:	drivers/spi/spi-axiado.h
+
 AYANEO PLATFORM EC DRIVER
 M:	Antheas Kapenekakis <lkml@antheas.dev>
 L:	platform-driver-x86@vger.kernel.org

-- 
2.34.1


