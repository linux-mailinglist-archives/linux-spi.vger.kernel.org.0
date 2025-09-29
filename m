Return-Path: <linux-spi+bounces-10332-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60310BA87D8
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E8C3C482A
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4EE2C178D;
	Mon, 29 Sep 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="f7Q7keyZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022119.outbound.protection.outlook.com [40.93.195.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C79273805;
	Mon, 29 Sep 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136321; cv=fail; b=r6zZDcgDjPLl0j9Xr3s1AY+wuvCZb3+s2Igy6MDb+cRiI0P8iubYS6Aesb02ifCLqqhcb9jTfg1aya5DUdmxqvaYSXq7FtDCm6zBm9P4L1SiHmXRivha+mEGWiXNGgJb905Um+IxzKPzJ4YheZAKzMHOrZrEfMvoMo4klW1kSUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136321; c=relaxed/simple;
	bh=C7nnMnsyXlhPIhICq87VESYreB884vyiukeXP9i7ARY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ix4Ra3Z9Vyq72uOJV/SgISRiQn8PykunE9BhVooKBhtaFzvj37v1OVsZDRTmB5Pu5PvUAzhYAzBgn43d/HJn4iesal2PJH7RMruGV7Iu2zBEvq8+4je30DQg4DHy5ZK0IgN+srwQpwMmS4KYlghsDmPHKMyLoC8e2pIftPjktqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=f7Q7keyZ; arc=fail smtp.client-ip=40.93.195.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF1LTo0yIKkHf6Bo1HGRep4vTCQmXl7juxwvTNgI4NbKbb7FkPZ/xEk6I3NOC78OMB/bSfncofRudkBYvVSwgLAaN/sJopom5Q8KfmMuBJtWY4seSDMd2MFyHA2MGdftJGSjwfRYgENe3j8IjWsA6VIRipH/stL16xCow1EdK8rphOr3TQcWhcp5aMaMu9afOdSMgt0NMteQyRihjZakcxNV3ANCbgz36HaOr//UAr/PJsEANndL1HDcXEy3gJycU1GSQpXXSVVcbf1R6w+Djy/wQdoAQ14M+8HjAnLsDZBEf8OkCUcxVbXlVIgx0pjMGV5zPehyJK8wvioFCgkjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX+Rs2GpwX4p7YWz3dNrHF8TA3yFyKelo6x88KoABqw=;
 b=j/oG0bCv/cnq/pOZQ4A0DnoAShCMBWitf5Wgly4xSpyAvm0yggP6uRmDDDet4cpP/dDSE6hjGYjCDbp2Np200P/gT+CfGbwGr1TGARYh6CEi2OvSAZ9uhEOGalvXHzgj38KN7R/Jzz6JrK0qUIg8aPuAoSUbObHCZyja3JKuj+Vqga2aN/Kh73cUid+esdlA5OmSSW+R5tSyYOd/MpdzU+iVeEbI5qZs8ZvKOv/EDCPYGLJDqEOq351/wEkK3uIgp5Rh8+y4igpqAPH0AOyAqk5KxuveA21Kc83V0UugKQ3yX3qtBm3B1E7M/wywjnKIYYQr67le4pAhUktzIYVzDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=axiado.com; dmarc=none action=none header.from=axiado.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX+Rs2GpwX4p7YWz3dNrHF8TA3yFyKelo6x88KoABqw=;
 b=f7Q7keyZnayh8fNKbrkZh5pF0j9MTzmxylSM8rj3k98g7L/pFSZ3GnEMd6HjKbFAj/lGDxnSu4guRbhIgkjXpuXYduMWfVlaPii/U/8C0BqkUqDNO8lSceFQXuHP/4aMnEewY5IpT5P7/tsBaGCr5hl5jqWfTzlnanSl0hcyaeSgNumYDrFJoPQGo4fRkcn1XblwVtn17cBgcFerbrdgH/+mUa/SS++Ji2wBIPoHQA0humIQTNa5TTNj3fMPClLIi8ajR5VCedzI13QSBcObq9SZBizeCdJqa14YU/uZ58uVsnoGNvXz0H542x020134gxkkS76UEKEeFrYBWy6Pdw==
Received: from BYAPR07CA0108.namprd07.prod.outlook.com (2603:10b6:a03:12b::49)
 by DM6PR18MB3588.namprd18.prod.outlook.com (2603:10b6:5:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 08:58:35 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::2e) by BYAPR07CA0108.outlook.office365.com
 (2603:10b6:a03:12b::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 08:58:35 +0000
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
 via Frontend Transport; Mon, 29 Sep 2025 08:58:35 +0000
From: Vladimir Moravcevic <vmoravcevic@axiado.com>
Date: Mon, 29 Sep 2025 01:58:03 -0700
Subject: [PATCH v2 3/3] MAINTAINERS: Add entries for the Axiado SPI DB
 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-3-b0c089c3ba81@axiado.com>
References: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
In-Reply-To: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, 
 Axiado Reviewers <linux-maintainer@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759136313; l=1038;
 i=vmoravcevic@axiado.com; s=20250904; h=from:subject:message-id;
 bh=C7nnMnsyXlhPIhICq87VESYreB884vyiukeXP9i7ARY=;
 b=icejvxRouaytdxpijmKVRg7yr0FclRQlpsrUfOD3nutH6C1AxUiCwk54g8jXAfQCz3/uTIjha
 YpzyiCmx01SCN8MlUhyFBkGP0biihaaB/OYUPfaw5Jk90N1Z2YAhw/6
X-Developer-Key: i=vmoravcevic@axiado.com; a=ed25519;
 pk=iiyhWhM1F4HlCbbW3I3qKZhPCE8JsCrDQMgCBRg4YMA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM6PR18MB3588:EE_
X-MS-Office365-Filtering-Correlation-Id: e30ca6d0-ea5f-4d87-ba2b-08ddff365f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZCtxQUF3L1JQZ1psbWc1dTF4aTdoUXNXaTBENkF4cy9kYWEvb0xWTmJpWXNL?=
 =?utf-8?B?S2NneHFYWi9lWWtGQ2FPem9LdGNxMlUrVlovYVFOT3k1NW5ZRzFRQXNkZWUz?=
 =?utf-8?B?UGsvQkpwdmtvV05pRlJPSlFPSXlvZHVmN1Ezb2tDSVl4Z1Izd21TWXltT1JO?=
 =?utf-8?B?c0N5MTV0UHl5ZVl6MkY5TktuVWg1MUdHVWFoNzNzTjNmb3g1MGpzKy9wRzdy?=
 =?utf-8?B?RHcwTW96dlJ2YWNrbE9ra05vc2Vma0R4cmVLT0ZJdEJFc0EvREJXcmVUNTJF?=
 =?utf-8?B?bVppcHBJbFZteUlhNDMzSXdFcTJ6RVFqck1xYmx4eTZjc3BKOXdZUEo0NWRM?=
 =?utf-8?B?NVY3eG5ZeUt3S2VNNFJIUUx1ekZWa3E4T0pNUFZaL3BVRVhmSWhiSmk0MTNJ?=
 =?utf-8?B?a1ljcGpxL0daUUtLdFlRZldoeG0xMGxmNy9qZEEwS3VBNDR4ZGl2TjR4cUlk?=
 =?utf-8?B?T1lNdXBjS2p0VEZwcVphU2JwRG1nVHNmTk04WDY5OFZwVGhkU2J2VjBrQkFs?=
 =?utf-8?B?cmdCMDdOMlNUYzdPMEdZQWlHdzRsVVVGdkE1d0NzS2ZIMGFlKzNybVdVbE1m?=
 =?utf-8?B?RXFrUmVRMGYrK0hyeXl6NFRUMlVjeElpNHI0WCtRRzAwYWpVUjdmK0JteHZj?=
 =?utf-8?B?dnIySjF3bHREdUhzQ3owMktJSjV5ZjV6eGNTVVRFQjdkbmxqT2JqTURaTWJl?=
 =?utf-8?B?aS9XNWlwdytJTWE0TWZwbG5ETmQ0WGFiNElBZnRBalBJMzFmQXNxQTFUSFNt?=
 =?utf-8?B?bnRlL2JrU3Z0RC9BQXFmTkNHMW5EQkNuU2ZOY3F6M1ZzeDVkT3dSL3V3M0NL?=
 =?utf-8?B?Zm04NlFWOFJWOHpKb2daMXB2VVFTbFpmRGxwR1U0K3ZuUHhuUTQrdkJJdU50?=
 =?utf-8?B?V2xvZmROeStyVjRCQjAwblpyRnRaQjJkNWluc2Y5WEpBR2hVbFl4NmNMNkNO?=
 =?utf-8?B?a1hkUmU4TE9SemdndmplQlQvUDdJNHg2Tkc1NnlnVE1GUElGRUs2d1pjSVBH?=
 =?utf-8?B?NVFqbEFFQXRSeml2d3V5ajV0bGgwemo1UDhORkNwbEZkeEZNb3VSVks1UTdo?=
 =?utf-8?B?ekhLQzU1cUluS29jNENiTmRjU3ZNaDlmSVptUDFEYjcxWkI5dW5Id2ZXWG44?=
 =?utf-8?B?TVNDcTI1V2N0RDhXVXlKQzNwRVQ3Umw2UkF0aG5pK3ROR0NZTW50enFYNFJV?=
 =?utf-8?B?ang2S3FqSVZBY1FQclM4c0JQdGo2aVBGdzBFNFdzWldWRlBDaHZqMkRYSlVL?=
 =?utf-8?B?a3F6cnR1MHRRdnExZmZNdi9jdzRwL2VRMFRXYUdLT09lWXZvZk55N01yZTA2?=
 =?utf-8?B?S2NqKzFtMENQSnRsTmhadmhXb1pYU1RGSzNnNjJuSVUwaGhTNGtLeE53ZmZl?=
 =?utf-8?B?TXZFMGlkVEZxWUpnMGVLQWw5QTJFbmNCYVBVTC9jOTdGcGZicnAwSWp2TDBD?=
 =?utf-8?B?WHI1U1JRK2FxSlcrVXcwYVVxV0ZsajFjUzJGRWhQdzNjbDFrMmJHOEwxWUlp?=
 =?utf-8?B?dnNuQ2cxRWwxRWZXckVmbXdkeVM4Z1V4RS9QKzdXOUJleUNmVVpISml4b2JG?=
 =?utf-8?B?WjZmS1RIajFuUDU5K005ZVMzWjJPL09TYnVMdjlSWEJBUXRtTkRzcUlIbUlv?=
 =?utf-8?B?RTRtZEF4TjVtUy9pbXpaeXBGcU9QSDJ6UWk2T1FMam13MlZuNGUza2Y0V3hK?=
 =?utf-8?B?WE5IMm95aFVRZTNicE0wbjI2cmNQVTNSVVlmcEpWblRhTUFCNzBOT0E0bkdO?=
 =?utf-8?B?TVJIT2hyMGpSVnBicVpDS2pQbHhHdWkrcU5hbjNYUUU4Qks0eERNVVh5ZlN1?=
 =?utf-8?B?M0UwL2ZRMHM5VnpQVXJLN2RhSzc1UVBIWDdMTWVEVDQxYk14d2QxSFNlZVNk?=
 =?utf-8?B?bEtSTDRZZnptdzZoamxNTDA0SXJqTmJ2Tk5TRzlteWZ0OEZLcUk2Rmtpelo3?=
 =?utf-8?B?Unl5WXBpbCtCYTFBR2VSQmhtQno2OFV5Z1p0NzZGZGJ3b0JYMG80YU4zbXly?=
 =?utf-8?B?alZ3RUx0cjFtTHRpajEzK2dIblhFV05tdXAyUklsMlVGcmwrb3o0elpJUlJj?=
 =?utf-8?B?d20rbkluOVhkOXZkNGhGWVlqM0Y3UmFadXZXRjU3TzNodGZYc25ueDkyS1VU?=
 =?utf-8?Q?jtfs=3D?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:vm-swbuild15.axiadord;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:58:35.3343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e30ca6d0-ea5f-4d87-ba2b-08ddff365f9a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[vm-swbuild15.axiadord]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3588

Add the MAINTAINERS entries for the Axiado SPI DB controller.

Acked-by: Tzu-Hao Wei <twei@axiado.com>
Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef87927041f5cf58d70633dbb4b18d..4fa4b99661b37b161e4326526e0c5049cf24691a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4130,6 +4130,16 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 F:	drivers/pwm/pwm-axi-pwmgen.c
 
+AXIADO SPI DB DRIVER
+M:	Vladimir Moravcevic <vmoravcevic@axiado.com>
+M:	Tzu-Hao Wei <twei@axiado.com>
+R:	Axiado Reviewers <linux-maintainer@axiado.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
+F:	drivers/spi/spi-axiado.c
+F:	drivers/spi/spi-axiado.h
+
 AZ6007 DVB DRIVER
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org

-- 
2.25.1


