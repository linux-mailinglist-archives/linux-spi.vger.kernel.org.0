Return-Path: <linux-spi+bounces-7718-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2163AA97ECC
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 08:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F43216101A
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 06:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA34265CBB;
	Wed, 23 Apr 2025 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="feRXYIA6"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CB264638;
	Wed, 23 Apr 2025 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388630; cv=fail; b=lxMMaFHVK6mp5pRXydZgAAnu1CDSZnhJgoi03a8YdpMH2H1yyf0erv/rUsPa9ENbGKfmuKBvzOYNIBme0S70Lwv7iJUQp+HjIrXYejhgf21ZzYsTbFZd2omU18mwr5tSXSb58SjP1gUU00bpR61/PwjxFCNEijKHXLSp38ASR2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388630; c=relaxed/simple;
	bh=bNme8ClesAVLFVoMTc+t2bOMLLC2Yd5WAxafaK/yUAk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qGQ/KSR4RVwfPObpibTQbA+OEabHMsYeaWKrg34hb0ryVWKPYbG5MF+UBuhFDWPOdPFfm21k7SxD6vygcvVvQgNHoUJsesaNaUk76vCf+nmNQMW/hINvwybvCbPiKdC6rfoDdlQUe/J39ugAsrlDprLiKiuuC4AQ8QReCu9NZpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=feRXYIA6; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ4MCUD6OW8j6Ujoi05fQ897W9B4z/WceQ5ye1H+IuYaVsoJIVqWo4BKWFs0hyeRPnKqk1QsERUujkwqI3pfG7xeuCwhZFFc6utm2pCGo6LIdnDErHub7724nO167qEliFxW2QkBUdDbarTZNJ1mgSYuEyZX1YLTwol758IixuRsvhpIq4s4lTHDo2ir6JZSmi9jF2D9kAEYI32PD6xb4VqoQlXRZIWBZuI7CEFJwjoOSdFgJH+GyJPqKwfoaQ4DW3tDXi4PF9Kp1C05OtMrN5NxlFDLHCA6abRYkhVsLX9Bu+LUI6SFcye5NCCyeKXKYN5x+6kNpr0LeGfgGjeYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvLHz6EfA3AawkmAhAdGDZ1vXakj1H6y+epx7P+vVVM=;
 b=mxfbahsqutenqr5mdUHZ6GMDJq7MLOZnC6Y7yMEEQppVVHSE83PMK0DqEKMC57fdola+75SzrQWhExRYaIE3kt8dig5Ulz13OhHyC8v4rGBkVHHulem99yBzUgWSNzJaTFJKgIIs2w2IX/U/+JMJljvGrIN6wyhoaBJgrgTmJhVwsfuXZwCf5XLJeezGcTkyokFsJ3b60spXlleDgI6raU2lN2dz5TE4ZtndS7oWZAFuKygjXvpMWBbJSizr2bBXGjzxbi/3cpZK3+IKCybS7WXXN4M7bHfaW3NLnCTZJz03J7BCL81kqtNjPSvl/ZjlI8O0QKawkjUv6v89lnq8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvLHz6EfA3AawkmAhAdGDZ1vXakj1H6y+epx7P+vVVM=;
 b=feRXYIA62XhBKFZJHnr8hE0aL0tQJdg86GZWCrVu0EyGzVMYUrhCJb46s4JAXPevbvYdJm0PzMcejd6G7734llBvvNEKqEvxbrnoOETBo5/2+3hU2SC0Btz5lrlkMWYQ3SobyGOi/GjGc2D2NX3t4aZ4lICQqa1LI49rL2UXEGZ7FIfEU/NHUE3orftHgGEXtQGiB4cf1FvlmFKEW8UFdRUDoJ1SVK13p8Bg8HUcvLOl7so7jR/o0DxmgfR94RyGEQK8es6TehlTSzyfT4SYEhBKhK7WpHuCFjp+QuXg3+fEhlDkVInI3WPN6GMeaBybkqrisgI8LNSm/z/ov9UHnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:10:25 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 06:10:25 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 0/5] This patch set did some clean up and add runtime pm
 support for flexspi driver
Date: Wed, 23 Apr 2025 14:11:37 +0800
Message-Id: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmECGgC/x2MQQqAIBAAvyJ7TlAzgr4SHULXXAgTDRHEvycdZ
 2CmQcZEmGFjDRIWyvSEAXJiYPwZLuRkB4MSahFaSe5urDlSPF/juTRuVdoOP1sYSUzoqP67HYq
 Eo/cPS7th5mIAAAA=
X-Change-ID: 20250421-flexspipatch-1cf724d4213d
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745388747; l=931;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=bNme8ClesAVLFVoMTc+t2bOMLLC2Yd5WAxafaK/yUAk=;
 b=mcq2h084Q8hTCDz6oMaHVRDXVd4/Rj/lXLAszrOgYoigpx/BFYtxXU8KoxDWWAR0veEV5Lwf1
 paqpoVge4g8BtV1Afq25sHp1RezilTX6argG09vhFAdSY6NcF0nmf3o
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAXPR04MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: dabcdb01-1559-466e-5608-08dd822d8973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHVtNlBKMGpDckhyNlFGcFV2RXNTaUhBb1lSM3FTaFBuL0RKTlFoRHNua1Nk?=
 =?utf-8?B?a2pRRFZiSGcvMnl1dThWaTRYRjNZWFlTOUQzUlR2TkNZTVliQ2lZaGg1Wk9W?=
 =?utf-8?B?emRUN3lTU04wYlI5RVo0TEgzeWV4aWNTS0NzSXl4UHU3NGZ3Skg1Qk5xZTJQ?=
 =?utf-8?B?Q1dyU0N3T2NuNmJBazlEVWZrajNOUTFXRDJ3OE9IY2dESkYvOGIwQ0dSWldJ?=
 =?utf-8?B?QWxUWTdodEk3MStzeEhteXdlcjRENHB1UmU3TS9JcVFFejBnaHM3TTc4R3Vp?=
 =?utf-8?B?eEpURm55amd3SEo4ZmpKZjhsUUIrZ1JuTFNsNVJ5K0w4TzEzNEoycjJVcnhC?=
 =?utf-8?B?VzFCdzYzWW9XV3JDWHJ2bTBVRW41Yk5vQ2tydFNkVWhpcHg4MWxtK2RLNEJr?=
 =?utf-8?B?RjZBYVZzb1RKdEJ1RGFIajh6MElGdnpyVzF6N25QdHU3RFV5Y3hjay9PSlFJ?=
 =?utf-8?B?NzVyN2luSHVyQUNUSnJTNlVGdmI2RGdQT1NIWkwwN1JmMWQ1YStIbGFBQzBE?=
 =?utf-8?B?Z0ZnRldwZzNxcTRMY0Z4OHBKSVRqcnlZdUNIZkFLVUJJM3BjaVhZQjkzbmxM?=
 =?utf-8?B?VXBIUWM3KzBPY1E5MEszbVlhSmxvSmVWdkNXN2tNYURaa2hFMWNvMExzY3Bs?=
 =?utf-8?B?UjdCMzM4RU9xY25QUVZ1cnFKd2JSVk9NaExYUjdOeDN1NXpLNkdqSFYwT1Vv?=
 =?utf-8?B?MmJjUmNQbkV5aWJQd3ZPNVFjMDd1RURxeE9PUDMvMW9FYmRnMDFIZkE2Wll2?=
 =?utf-8?B?a1JjNDYrTE4yc3FNMis3aUgvOUFadzI1c2tqUnhnY3BqKzJMdTM2dmQxakQ3?=
 =?utf-8?B?NXhRWW9QRFRKZ2srTXM2ak52cE9hNll2eVdDU2xPMnhvWTZzbDZ2ZUNhMFZE?=
 =?utf-8?B?MlFSa01pV2YycVIzcDdpcW5IVWpkQlpTcHFkUERrYnZyUE5NZThSNW5keGpF?=
 =?utf-8?B?cE1rRFQ3dXN0amw4VDgrODA0UlRpRUJmbHNwYmJlUTJKNmhFMHUwR09nQXlT?=
 =?utf-8?B?R0FHck93VnZKb24vVTNDNmQzclpNbFBSd05NU0RUK0RMN2ZqbzNWNjVTTnJ6?=
 =?utf-8?B?dGRDVDlPbDA2bTluaVFITVFlb01GVzN6QTc3NkxGM1ROYXVvbnp4a3dmN3l0?=
 =?utf-8?B?bHplelRxM0RLK3EvT0JzaFFOeVdtVGlxOUU5TnVxRitGb0pGZXZ3TUZzSmRx?=
 =?utf-8?B?aWlHczBUUlBHY0xuSXgwTzAxMVNER3hGZll5ZmFLRGU2UmpzRU9IS09VWU1v?=
 =?utf-8?B?MVEzSUVDK0l3RUZLTm04bDBPY3oySk8yV2luWTNJL0gwOStzMlVDSlBKeWp0?=
 =?utf-8?B?bWxraE1DLzduRlB4OU5aTkhmSDVIOWs4RnlBV2c4UG11M1VFMkdiVUM4U1JC?=
 =?utf-8?B?MG01NTVHMkNLZTM2TEFUZzJkOUNrRWZjeFdKS0xDREZSOG9QaEozNU4vcUtR?=
 =?utf-8?B?VzJnSW0wUzBuc01LbW5BYjQwZkp1SnozUFE1b0s2VFpGaUVudEdkeG1PaVE0?=
 =?utf-8?B?aVlEWE1TQkZsUEFNTklUSTJvY3U4U0R2QWlqbVVIaWNUMmd1TGpqNUhSeXVS?=
 =?utf-8?B?Q2MzNnkvcjVBby9GQzd1ZWVQY0dJMHJrYUE3YXlEdFRRQ2t6TUdpK1hFWFFV?=
 =?utf-8?B?MURWZTJYcWN1WjB5Nkt0MWt4S215UFZFcTJWOXdTOHdqSERFQTVGZldoYVFL?=
 =?utf-8?B?dGVZa0xhSzFZU1FIdDllQVFlR2lOS1NsaGRwNjQrY2NqdjVDM29NTkE4TFRO?=
 =?utf-8?B?ZXE2Q1JuTSt0ZXYzUDZSU0RzS3F3Vk5UZnN3SkpVV1pGYXVNMElRVGJtaHYr?=
 =?utf-8?B?YWhJa25jZTYzalFyQ2NpNkFZcjdvRGFra20rb29ESVRLWWJrczVjaHBNb09U?=
 =?utf-8?B?UjBtV1Y1Q0ViekpSMi81ZUNhQUJ0MFRVME1oSkhoTmUvellqcnYxMXlQVUQz?=
 =?utf-8?B?TWxPU1NRVGovUC9kNmkvQ2VCZFlhV3lnR1g2MFcxcGZRMW5pbmZ0SjhrN05a?=
 =?utf-8?B?bVJLNFRIYi9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW01QThoV0FaenlOVFdsWEZTRXAybk1uVHQ4RCtqaHVuZXJrUkpLeTVKVVky?=
 =?utf-8?B?V0NEZGZBNGJVWEdqbmNxeWhMbGIxR1BlUko4enRzU3JudkxYa3huQWU0ajkz?=
 =?utf-8?B?cVFPK2VMMXRHNFk1cTM0clNLeFdTYXArV05aQ2xuZCt5VFNwdU5UYVVkYTJQ?=
 =?utf-8?B?Z2F3SjBMS1ZwL2d2REZqTmJkKzhjbVh2WWJGVFY0TVpMSWZnZ1RtQkdxOUpq?=
 =?utf-8?B?aDgza2VIamtaV0VvaHRxSldpSGtobkJSaGVMU1drQVNqWHZSZjhIKzF5cGhn?=
 =?utf-8?B?MnVKM3gvNnpyLytRRGtZVjMxMHNhZGZTNEV4YmxHZFFGelQvaEZybm9UWlp2?=
 =?utf-8?B?UHhNRklFSm1DNndCcXJUelMyR0RwVEt0WWg1TFoweTJaZHNzVzNUKzhseUg2?=
 =?utf-8?B?RE9yOUZncVYwN051ZmdicExOSDNIL0VQUTliK2JPZ0dqbDdXR0lrLzhMbWRa?=
 =?utf-8?B?ZmE4c2cyMFlsVmd2b3cwbTNQZFpjbFZqOFVwR3ZFWlYxak4yNFpsY3U5dTdW?=
 =?utf-8?B?eVRYMFgzcEFJYkZxbmxqUjlzMVpyQlJuSGZvSFBMeCtqNDIvYnVoQng2WkFU?=
 =?utf-8?B?MC9qMFAvMmpySm5lNGJYcitTQnJpdEJaZ3FOZFhDZzhReVd6Ni9Ob2ZDYWo0?=
 =?utf-8?B?Q25kWmFVNEU1eUdRd1lIa2sxMzY2d015a1lJTUFNUlhTZlZEbDIwTlFIQ3Ru?=
 =?utf-8?B?c01nQTdkdmtnT01ERWd5OW94YkNHUzZWdHNxS2xJRWV3bE1rQU9wbFBad25O?=
 =?utf-8?B?a2toeHZLbHU2SGJPZGI1R2xOZ3VkUm9UVkJXTnBWa2xwNXlNZ3JqbDdQNHIz?=
 =?utf-8?B?enp0R0FkY0tBVGdXZ2pIZFRNODNsa3RycjRJSUZ1MElkU2ZxUzhlSWhzck1C?=
 =?utf-8?B?NzVlcFlqbytPQ0dvZEMwSzlwR21yY2FVZmJQVFhoajI3aWRsU29rVEtZclRu?=
 =?utf-8?B?aUVFSDNsQUdYY0F3bkFONmF0ZVN1bi9QTmhGOE1oK3F6Y0hiQ2FYY2hhaGY3?=
 =?utf-8?B?RGZyLy9TenN3TnNqWHRGaHMxYmlsMVFzRHZLQ2tkZW0rNExPRk9KN2k3R05x?=
 =?utf-8?B?dUdGWSt3TkZnTmd5UzlyZDU4N2tucXZDcHlFNTloMEVxZGttekNtRDZkOUVp?=
 =?utf-8?B?dzc0bkZyYk5Id2pwU25sQzdxamU3TTFmRWU1bUg1eXBrMHBSeGFJQy9ERkY4?=
 =?utf-8?B?T3dYUDNidjdjQzRYaE5sR01UR1ZTeklsUXl4c20veEZJSUxVZG9xUU1kcDFz?=
 =?utf-8?B?TzZhK0o0cFp0UUI4OUxhYjg4M0VpYkt2OEd4cGhEU1JOUnF3cjVvUXRZWFB4?=
 =?utf-8?B?bHk2QUl3dDBScE85WHhhcG5WQkgwd09MeFFqekpWYUVTNHpWdkQ5K3ZQc2tO?=
 =?utf-8?B?bElYOURQV1Q4NE1qbVVpL3JiYXJwYk5BcnE1S1BiNWNKdGQzTmhtN0VFdTdW?=
 =?utf-8?B?dGdBcDM4YWovbDV1YU50UEZ4NjdsYjQ4Nmt4NVBDdnowZ3Z4WDk0bFY2MnZH?=
 =?utf-8?B?eW1mMkJmNXJTZ1VIZWxUMG0wL3JOM2ZjRnFUcE95YmEyTC9RUnhJZ01WNW5O?=
 =?utf-8?B?bENJektHZ3B3Q256b2ZETzdFYUhWeVZvTER3Qkgvb3pKYzh0bEF0WHE5L3dp?=
 =?utf-8?B?VkhtNVlJSHRvSGZNUDJDS1BrTUYxSDlacndkOTRobms4Ym5xTzBRMjd3NmJI?=
 =?utf-8?B?MkpjTno5K295Y2Ivd1dnVW9qT3pmU0VGNndpWHh2YTd4bXdEMEFrTFl2eFdN?=
 =?utf-8?B?Skdnbm1wZ0FHdE1aRDRxKzVIREVNTUp6bHE3UVJPQnJIVlppM0wrcXBZWFhO?=
 =?utf-8?B?T0NIYWZoaGs4WWNHYzFxOHRRNkZnTTRYWWJLQXVDSjNOMEFRL3daTk8rOGJ0?=
 =?utf-8?B?eXdGWnhlRGMxY0ZFalNnQlZmU3JQUjRnSzhhT1lic21PNWNoNUQ2UVQ5N2ZX?=
 =?utf-8?B?R005cG9vb1JEcWNwcHFPcyt2SjQ2T00rcjEzYmVqbEY2ME8vZjB3Vk1iQ3RK?=
 =?utf-8?B?alE1SFNXOFJvT1FVS05FVi93dWdEZVdZWDQ1NllaVDZGRDlVOE9iUU5lNWhG?=
 =?utf-8?B?UEZRQmVXQXdTTnp5TTdyUEdtQjQyZXZJcDBQWkt0YVI3ZitHSFRSQVRLU2ZC?=
 =?utf-8?Q?ARHorlkZc3Y0Dz5rSh1pQP747?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabcdb01-1559-466e-5608-08dd822d8973
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:10:24.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaL2T025BH4EXfiftBKKbynlZCc/OoVbw6beOKx2BhZfR05g2sfiWjOj8r2Z6W/VbR8KM8xVokZsUssF8dAupQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734

PATCH1/3/4 to clean up the code, make the code more readable
PATCH2 add the runtime pm support
PATCH5 use devm_add_action_or_reset() to replace remove() callback, this can avoid
       oops when do bind/unbind test

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (4):
      spi: spi-nxp-fspi: remove the goto in probe
      spi: spi-nxp-fspi: enable runtime pm for fspi
      spi: spi-nxp-fspi: use guard(mutex) to simplify the code
      spi: spi-nxp-fspi: remove the unchecked return value for nxp_fspi_clk_disable_unprep

Han Xu (1):
      spi: nxp-fspi: use devm instead of remove for driver detach

 drivers/spi/spi-nxp-fspi.c | 189 ++++++++++++++++++++++++++-------------------
 1 file changed, 109 insertions(+), 80 deletions(-)
---
base-commit: bc8aa6cdadcc00862f2b5720e5de2e17f696a081
change-id: 20250421-flexspipatch-1cf724d4213d

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


