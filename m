Return-Path: <linux-spi+bounces-10024-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DBB57C90
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F24482922
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A573115AF;
	Mon, 15 Sep 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ne6bv0Lr"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2090.outbound.protection.outlook.com [40.107.244.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393230FC07;
	Mon, 15 Sep 2025 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941965; cv=fail; b=pvhpUyUCepNGiuV/6/qdxswQZpgrQZDw0WNbTy9WBvZ65crR0wUus4tXmRvs5NkKZO7S2puw7PWrERIG3zGHqKsgTDSWzbWhECnMtyn5lTiApur0+LVIiRWjJ9/2vV1VJajUjNHkCkcOQHD9k6cWx6j/iuUiMpJR+Ha/g+JukxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941965; c=relaxed/simple;
	bh=wjM/Z60yT3XGsqKt6Q2eBEk2denv6GLiM9kLQ/FpVCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpU3XrLt2edtpUXqrfTgDpNIwsIk1XrHqdn36NxphX8wxQmNT3k9cQhecsA6aSTjmmy3tNe/DO7FOipQEK6PWNNomyyzHKzBqKm409FGqe3mGSUL4paWp9ckWGR93BPnJrw5zho9cSyeVpSdpVlsKkbM3JLkUm3UD4bRBi4ooNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ne6bv0Lr; arc=fail smtp.client-ip=40.107.244.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wU7M8xry31LQYRk6mlNWW0y53eY13IhVryT3MCh/IoyoMpgYFovdnSDF3CXKNT2kus+ytBnFxxhqAwtI0ZipD9gbRHujvI826O9xIOoVFNlwEfHWEZ41gybHB95GkophxjKlw71RG70Av+r229p6loqch6HUBAQG5tYLqVruYlzr8WQNVtpw0UOzQ5P0GaHVdxWWLfsQyjluSYZgmwL8d+v6mFp3OXzSVlx52jeboOdHmngX9SAi6GDXfn89jrmq7VQqIghLju+eBYuEp1PaEtYwKk8JN+eb3Q0AychYjK4CKOJOOUPkX1a1aW8MXJaVXSGZgLSIqrDZlYWzvUm3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwxvSH1sO4Rm6uSuAzNE9CGGfkbYPLzgRPPStkzLlw4=;
 b=M6CZMqD8SXfIJhDQQoyWBylWFmdbx2rSmmvg60byW4xvDE869Y5o+vPstzwfz48ejk4tAIjqAtbgloJlAkKx57eq7+ovfI0p4N58ZceEWvKQXD32PmetnobyDw1W+EO5jTP6dHK9wGjmCbk0j5+BFAwSOSN86YxjptSGQl4ug8Mh9kSOJ0VwU5us9a4pODXPyIcxJae3crfhlRmDzg1IKQK8hIGpEkAUPsHVd4CAHjWhdCt6CQATPwt/IbVQTlpjWEsoXtGVKgAhixJ01EzRZr6yOeQjAh8TeVuCnrkKLl75AF1JucoaErnFcH8bK3VEbfdXroSmjEwvsSKdhLG7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwxvSH1sO4Rm6uSuAzNE9CGGfkbYPLzgRPPStkzLlw4=;
 b=ne6bv0LrJQqbxJxIFnaHJ04i2Yi00HulR3KQuSNB2M+peMJvmICs/lQI3wAuwNpFICMpzSDmelbv+Ryz2zUZS2NXEmnCuPOlAX+FciQsWnkLa108DEvAKdIis2gxF80zDSVP2NDtF7iZedy6eswSSkZZ91iQIJXhTu3r9uYtpbm5EPmFBDwoEYuDuqYxO6iObZeBZdSfHCsK9JcExwtxzxw71HRqJBH53QmHJ64z+oI+jzqJ6KOUqedMG9kTURyBT7Y36MQvE81Gwn1tctKCW8KsIAwsjDTrOXDrjUTEeXiIvAH68stDQYGn86kmfJIxjq0afSJJ0rwgj+2BwUxtpQ==
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by BL4PR18MB6407.namprd18.prod.outlook.com (2603:10b6:208:5a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 13:12:40 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::3d) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:12:39 +0000
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
 via Frontend Transport; Mon, 15 Sep 2025 13:12:38 +0000
From: Vladimir Moravcevic <vmoravcevic@axiado.com>
Date: Mon, 15 Sep 2025 06:11:57 -0700
Subject: [PATCH 3/3] MAINTAINERS: Add entries for the Axiado SPI DB
 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-3-814a1fa2a83e@axiado.com>
References: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-0-814a1fa2a83e@axiado.com>
In-Reply-To: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-0-814a1fa2a83e@axiado.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, 
 Axiado Reviewers <linux-maintainer@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757941952; l=997;
 i=vmoravcevic@axiado.com; s=20250904; h=from:subject:message-id;
 bh=wjM/Z60yT3XGsqKt6Q2eBEk2denv6GLiM9kLQ/FpVCU=;
 b=C0rLw0QfBN2GOlHqUhPFyx8qwHRa7rNQrJOBk/5U6vj8ghLS7LJI0Rz3PK08NYuKYrBSP93iD
 v1Oyognadr2BLMu87ugMPWXLuSYU7VUoXwQ7APfPTUp9Fbgo4/xxqDQ
X-Developer-Key: i=vmoravcevic@axiado.com; a=ed25519;
 pk=iiyhWhM1F4HlCbbW3I3qKZhPCE8JsCrDQMgCBRg4YMA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|BL4PR18MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: a398d050-395c-40de-78d4-08ddf4598c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlQ4Yk1UVzQ0T2RBRWRPb3BNU1pYak9hc2ZxTlBKTVFMUHI0b0UrYUN2dUdY?=
 =?utf-8?B?bFB5SFA4OW11YlRYSUgrd3JkWmlGWkI2L2thbzcxcFdDUkl1c1hSUGNRM2du?=
 =?utf-8?B?cUZBaE04SDI2M01KQ0Y3RU5Xc0N1NWVyY1djQUc3V1RTSVZabzhTbWsxU3Bi?=
 =?utf-8?B?UE1nZEtSRDUyVUUzeUFham9DN3hHYXZGZS9kU0NaTlhpYUNmUTlhZnh5L2lC?=
 =?utf-8?B?a1pCYXRocHJRaUl5bGU4elJIbmtkWU10OUpjaEMweVFJcnRma2gxanNGRUsy?=
 =?utf-8?B?MmE0U3NpNGwxd2hYTzkxS0ZMVktZcjh6c21JenRSa3ltb3hodVRjaE9JL0Za?=
 =?utf-8?B?cTVuTXU4THNmbnRMNWpCVnBpNG4wN0tPVlB6cWNqNVUyQWRSV0NQcWZwblgr?=
 =?utf-8?B?N0tjcXFUSGFtM1c2SVVvOFN1T2hGNU1jbGY0c3ZWeVl2NXQrTTNXNWIxOXpV?=
 =?utf-8?B?dmtXOHJXMGl5V2xZd3h5L2cxUHhtT3BOUkVVQlJxSm4zQktKRlRQSDkvVnYy?=
 =?utf-8?B?a3dBNEtmNXZWRVNpdFI4Ynl2SHNJc2hjb255UUNaT0phUTBWRk9Ld25VK2l4?=
 =?utf-8?B?dlFobm5pSmEzSzczam42OGdvNE4reVAzc0dZOCtRbGJpUHA0eFJCbVpabHgz?=
 =?utf-8?B?RFBvR21Oanc1aGxmb2V5Ylh4SzR4T3VxRFpJQllXRXhQR3p0L3ZqVUFGWVFu?=
 =?utf-8?B?bUVWV0w0d0tWQVBmWExvTkJpNUN1d0NMQ0dKZ0t5ZUFKdGVJSTJsMGhhR0Fm?=
 =?utf-8?B?RklDRWp1QjFTK3NoWW9jVFhKQnhYRzQ0OE15WmpyRzlGUTZPYkRMcGFFd2l6?=
 =?utf-8?B?TWNtT1pkUTVUbk4zM281R3VudGlURW8yOXJIWE1aNmp5MmhmZW1CVk1NUlRR?=
 =?utf-8?B?UHNUT1pLUmV5OFFsdXdnbm9HWFEvbUZTRHRKdXhHYnRGNWxHT1JpNlZXaEN5?=
 =?utf-8?B?V01FREY0d0Y0ZU1tY0RITStmYld4SExhei9JVXdTWlJQWUw5dkNLMGVCVGRi?=
 =?utf-8?B?cCs4RktkTndBdWE0L3dyL1Z6Qkowd3RjYi9ESFJxNWMvYTJZc3NmSlB2ZVhw?=
 =?utf-8?B?OFNyZDM4dk1qZ25GT29FTnJ0c09zeXpnbWs2NUFSbEZ3blRISzU0RXdRa3Bi?=
 =?utf-8?B?SHBQM1J3dXM4dVdoN3hJUENaWWZ0RHdvdkhoY0I4YlpEMVJzWWNHemhxWTVw?=
 =?utf-8?B?VGhQVUw2aVFoQ3I1cngzUWd3Vmw4SWhwY1YwTUdnVGxjSGdGcHV3aTlBMVdX?=
 =?utf-8?B?VS8wYmtLNFhCZjJuQmRCSVlzdHFlVzNnRjl6VzlqYVNQSk5RSFMzMW9admZm?=
 =?utf-8?B?eUlENWpoeWVpN3hvS1IydW1uSU81d280QmlEK1pEcHV4Vlc5V0R3b280N3lx?=
 =?utf-8?B?cHlBRDRxaVBQWE9mOHJaYWgvcjdHYk5scFFEc1Nac29GVnhSQnhLaXRrVk4v?=
 =?utf-8?B?MG9aa1JnUXFsRUNKR1I2YndKNWtWaWZoMUE1dmNHOEtuUyt6ZklTUjlsdE91?=
 =?utf-8?B?S21GNElFcU02R2pzRmd5ZUtGTEtZTEVxTEpOUHZmVmQ0SUxoVDNyclVMQzEz?=
 =?utf-8?B?bC83dVNsQ0FkcjNYdEwzcXJRMmE4NGV1Uy8wdG5GUk1jL1ZRL0FXV0t5ZTds?=
 =?utf-8?B?QUFINUhoOXZDOWlSY1g0bEFFQjJVWWs4UkU4OGsrN05YbnQyRjM3M1U0U1Js?=
 =?utf-8?B?MDJsdS81czNMUmpVdHg3ZVQrSkN6NDlLYXZFUVRwUWVWU2c5NmJteHNNOVZJ?=
 =?utf-8?B?N1BOZ2ZTUWNtcTFBNEJ3bGNpREpYYm52NllnVDluUXZDZFhmL29RNWE5ZXdF?=
 =?utf-8?B?dElqTW5xVXZSdStoeWlvdVBXYTJiaXJPZ3Q4UVdLM08yWmdKYmhEOTZFSHJu?=
 =?utf-8?B?OHhWdUlIRjVRZlJsN085MGNVcGVIdTQ5eU4zUTArZlRJRU1oRlhyUEFkOUtw?=
 =?utf-8?B?SmJiUDJ4dkZVM2xFOEFrUk0rNXcrZFkvUERMa0JMOGsybmVhOCtDcFpnSy9P?=
 =?utf-8?B?U1hsbU8rR3UySFNJeGtBZWd1NnRBUDd5U2ZIeUlMZ2h1QXhHNTNHcXJYT29s?=
 =?utf-8?Q?ISl5oh?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:vm-swbuild15.axiadord;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:12:38.7208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a398d050-395c-40de-78d4-08ddf4598c26
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[vm-swbuild15.axiadord]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR18MB6407

Add the MAINTAINERS entries for the Axiado SPI DB controller.

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


