Return-Path: <linux-spi+bounces-11474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F50C7F9D6
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 10:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 769564E586B
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717272F549B;
	Mon, 24 Nov 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MBf3ruNm"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A192F5A2E;
	Mon, 24 Nov 2025 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976295; cv=fail; b=slNMoiwqZjblNgJfMkHVPeCnbX9yH565xw0tB1BQ89mPMi0GCgDUpNGGEeyI42rRfC2UXwAECXC/EzqjJjS2HCSTuFKyEIsk5N0N9mGJNC635c8UTHp9Jjl4OJ3dvnOafQMdzzsv6qQ5/lSsmro68tR/VKJHdCfbytr0c0XNk38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976295; c=relaxed/simple;
	bh=t9nmuF+AYqPYe2xR2QY3YmYZNaePGN4B6+QBkGUOkL8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DtSlDF4W5Bjyd6oYZMT/2QDQA8JwlqntunFXKT/juH273uTR9wmMtxDF/3f3vuRY1cpnbXMockVy7Taxv5fPT/UvMJYSfb9hXTl+8n2AgumkECX7Dm20SF4h7jjdXV+ltvQnCkCs5wMFGQ/DJbjkZg37Cr5gzUo+jxAI1hpNKag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MBf3ruNm; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeFny13Ygs0iNOx4TIc0Iq1vW4QHyNjrirW+AvWmcZk+R1M9hvtnlLl/5/BJd61gWxRek+ZHxjcLZwJlkFB5CFUFZEuqZDwBkatbp/+gt3bIkeAlcLdAGFYVh3Un1O7Bhl3/cckSVbHZr7W8eT7GqczO5u4O/naCjIwbH+VmraoB0xsNYxJpsg2erp1JGBKlV/BtMrmnrqbT8cOViqoTHmferuyIv4bzee5/GrgqH9eQ/D/a77E7/UR9wXKwH1BxCXD78b0y0/t5GJTyX2gF5Pi8O1i3d5MdaTAdB2JwtnEMrkCJQEEA9G7nBCMa7f6hyQINmBNlpo7nZ07jLfXXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5pLZFZMfP1dgbjyeHnljiGSzKS0GE9v/YZNqyEaS2s=;
 b=tJIReNosf3KoybU860VFOFgsBCO7dx5eUKcdF6ZvUBOwuGhwflacS9wrWlzJrt0CtjsaHm+MprAeQmpQ/ZUkPrZDSK0UrDZqYHh+RKBDW6OpqWzLI+crHnPmMW1PEdwaScROGs/CvgFSqzD87xjZDQU8ItB7IgA7jYbvueQmTGJzh0PVwzAz65UVgzD8H54XqR24DGJoOrj4TSs4+5H0TaHMc2pL+HYiIK1123X3tPM0LpTsNWRVASBkEakM9VthIeOgYhV1eTtjtkL1PicK6mOyhD6AKMcISQuBvpY6DVuW4u5t1q8MZnvWJMKekBdK3V2kYkIOnHvtoUYPd5cpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5pLZFZMfP1dgbjyeHnljiGSzKS0GE9v/YZNqyEaS2s=;
 b=MBf3ruNmQZj4b/iyL6nPrX62oL4ppjfAPtHkrIxMejR2I60awkqr3Qm3wNLXZfFOPWanrZIlgFWHjqAmxnn8+Xisw69ij41M1VZ7ad7zZbvWqTTnyLZew6PKldOUPU6cr0il9RL3cyXYXkL2NBiLZJiPCYKa3UfPLJep3RR9HYFFbB9MLatBHm5qzQeDJisEy7WlXwkqi1pq6YtfWsXUc391XLtlVnXTmYejO9d1hExKwpRO6b8ioyJNZF3hif+bby5S2mul7bxHRoQ6mKxLk+S1s0h4le5Xogh1XRztygIyZxrdLKY2EhXfagQl7qd0ayhkUgDc+J6pH0B+zuTMdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10697.eurprd04.prod.outlook.com (2603:10a6:102:482::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 09:24:49 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 09:24:49 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 24 Nov 2025 17:25:21 +0800
Subject: [PATCH v5 1/2] dt-bindings: spi: Document imx94 xspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-xspi-v5-1-6fd03a6cb766@nxp.com>
References: <20251124-xspi-v5-0-6fd03a6cb766@nxp.com>
In-Reply-To: <20251124-xspi-v5-0-6fd03a6cb766@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>, 
 frank.li@nxp.com, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763976342; l=3868;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=t9nmuF+AYqPYe2xR2QY3YmYZNaePGN4B6+QBkGUOkL8=;
 b=XppBrxfhpChyJEnEYiqS74QmSuRAd8QZOR998RseZ4kwO6cYhTYIk5+2q/Wu6u/vNLHMTpWsA
 X0icVfz+kdsB9liHcK6aySKaOTT+7ISFS8ROdmZ6vPwilyvGmpqEi/E
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5P287CA0252.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::8) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: bb49deeb-87b2-4a0f-f74e-08de2b3b50c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkZIekQ0dURRQnJEYmNYaDlxTWtJem5JUm9ZVk5FTDlDZFFSWlBnbWlkc1p0?=
 =?utf-8?B?ci8wcWhGRU5kcXFDSkVTVC9IcFBMdXVwUnBXM0NZdmxDQWo5MjVSRCt2LzVx?=
 =?utf-8?B?TzNpLzY2R0dkT0dpZEd2RHVvWkp3WUttZlB0eTRUbjhxTmtKeDF3TkZrbDgz?=
 =?utf-8?B?QS9SVUh5Mllia0tDVW5QSFNKVnNLNzR4Y2lROUNRUVU5UlM4RVhBNUs1enpD?=
 =?utf-8?B?YlJGbm5QNjVFcVVvS09Wd1VkN3pmZGcyc3NMcHlzMnY3bHNkRUZPckQ2R0ZE?=
 =?utf-8?B?NmZ1ZFVyanIxNG1kNGhBRUg4ZG9Zb2tCWGdFN0RjcHhnM0krUDhwQnJzWmVS?=
 =?utf-8?B?UVg3ZjBoWnhyakkvSjRKNUhCUUlBeGpWaTRIT1NpR3l3bGlBNnFMc1E1eUVU?=
 =?utf-8?B?TmMrR29tVEQ1M01zbkRjM3hINEFyWnFDS0FIM2NIUm52ZkNyN2N6eVBzeGll?=
 =?utf-8?B?ZU8vWFdrWjY2dHZlL1VDZ3lMaG5RekVRa3kwSlkvdkx2MmdwNDVrcGgxQ2R1?=
 =?utf-8?B?RUcxQWhFRVMvdm4waGhzYkFndFhuMmRHOHVyTWl3MU85YWdFSTB4S2daNzRo?=
 =?utf-8?B?UEtud0EvSk1VRXQ5WUp1aTM5VTV0MDJhRFBYMGRkVnUzVkNwa2pFbTZPK1Za?=
 =?utf-8?B?djBxNlM0SEVOeE41K0dxY2tzYjYva0FnWTNYZHBwV0FHUEViSVluMkRVQmh4?=
 =?utf-8?B?K0hhYmxQMlJ0WE1MK0pDbmR2eCs2NndiaEdMZ2txYVlscFBPVTRHMU5DNlBo?=
 =?utf-8?B?QWFzK3c5aFMyK2hISHllUVZ0Tm1ueEpsL0RyTXhXNU95Yk03bkNPdk1scGdw?=
 =?utf-8?B?cTI4UjRPWTFwWm9HZjZBRGozUmVkeHNlb1EvV2grZWhKSnBLdHpEWlZQUEcy?=
 =?utf-8?B?WGE5RzJlRHlkamN2RHRkS0crbytiSXM1Mkw3bmlOYjZqUGpEV3N4MHpnRjMx?=
 =?utf-8?B?eHpzeVJKak53UmdranNSeEV2bHBFUGZFNTJHVUdzcDlmdm5FdHpjWGZiQVlX?=
 =?utf-8?B?THZMSXBWV0lLc1A2enNUTDVxakM2OURXQmhZdExqWTAzeFN2WnorbWMyNXNh?=
 =?utf-8?B?YWhuMUYwN2ZkanVUdnFDTUs2MjhFd2NaQTlkU3htOHFIdlppMEx3dElEUjRs?=
 =?utf-8?B?KzJNSmV0Sk56MGdkSHJXRmhRdVZDVi9lV2oyVkVRSllqczhJVjdoNFlwWUxM?=
 =?utf-8?B?Lzlwa1k0M0pnSUNoalhRU0ovR09BK2FqQkNFMzJDTXBMT0k1VitCaWQvb3BW?=
 =?utf-8?B?T21PejNRZDhsZEpFalZtV2h1Z09kQTVqUDdIYnBRNzVEMUZkcnRmWVl1L3NE?=
 =?utf-8?B?aERBdXUyVVRURWxVbHFnR3gxWXB0cHF0eVFjY3VtQ2VWWWhLSUhGamtBcVRP?=
 =?utf-8?B?L3JYQnIxU3l3cm4vUm1kY3JiOUo0NUQ0b0w2c3BmT1hONk80Wkl1RTNDbXI4?=
 =?utf-8?B?aTF3RGI2d3d6OExOaEx3RTd5dHRZY2hyYThNbm85OTRCMHdERHNabkpTQjVh?=
 =?utf-8?B?SndFcUd2YStrWHFzdVFBL0hOOUdEanBYRTN3bGlLdHI5VWVtZm90d2IxcGpG?=
 =?utf-8?B?d0dONHJ2VzJjdE5VUytZRWVxM2pTZldyditqTVpaQkhwNlFjN1cyaFdycmpV?=
 =?utf-8?B?S3o0T1ZXMjc4am10aXA5VHNnYzhwZmVpRCtqMWorZGxtbTNoajB2dE9XMjVV?=
 =?utf-8?B?MTVsbHZmaURiMDJtVXFYY0tpTEI1YzArUVZrTEIvaFRyU0lRNHBndVgwREZG?=
 =?utf-8?B?WkRScW5xeG01VkpoSVBhZEtYd3VQWkpVajBPUCt2WkFHeHN1S3NTaTVvVDI1?=
 =?utf-8?B?L1BKTWhGbUtEd1pqcDhNdWtOYWhVZksxdlhtaW1rQ3BlQTJxaStZRllxRSts?=
 =?utf-8?B?TkRwakRIUlBtSW40d0FTMG9pelpkQjNxZHZyeXd6aU9TU3RiNG12QmQzTmNh?=
 =?utf-8?B?K0ZaYzNMOVhubjJTZ21hM3VicjFPVmQrYjNUZ2E3OEw0cnVkMks5NEsycEl5?=
 =?utf-8?B?NEZWaSszZndRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlhxcFpwbm8xQUlJNFNoZkFydUhiYTNSS290eTJnbWZJWnBxYWJESS9xZzJO?=
 =?utf-8?B?ZGd6TGhQL0cyekZ2S21oVVhMc2xIQTZKK3hXZnFWQXRyOXZuUXlSSnNjbk5I?=
 =?utf-8?B?QjJ0clZ0cU5tNkVBMjAwWEI5Yitnd3VFelVIZFJGcW5vTklaOEJkRXVWV3Za?=
 =?utf-8?B?YkhJNllMZHZ6YXdMcTJKVTNYdEhzekVwY3RkZWpSOVNKNUxvQXpWUGtjTk02?=
 =?utf-8?B?UVo4a0tVZXJudnhMTXo0a2pWcitXazBRdmJXMzU1WnBUeXhrQUxGY3B4a2lC?=
 =?utf-8?B?TEZ0YnN3M01lRWxrYjdsdDBJcTNyU3FWaWxxdGVoNlE4STZuS0I3S3VMT3pR?=
 =?utf-8?B?LzZNYkU4ZWJXMVZhREwrL3YrOVZLaE0wN29GcUdWNFA0bWZxWWgwTFFwRzlr?=
 =?utf-8?B?eStGaWZzcE9uUWtBNEg4aVYyL0tUaXZYeFBQaW16eG9PMUh3aDhLN1UyQWhx?=
 =?utf-8?B?STBkN0tyZXkzdXEzQ0RoZ05ZZ2Fiek95V3RQR1d1Ym82S2ZiNW5CQUR0M2s5?=
 =?utf-8?B?dlJaRTVIc2xOVHJjVXpTMVBZa1MwVy82bERCS2hnQ3BTMisvdGlNWUxXbmxz?=
 =?utf-8?B?MmZDaFJvbUxsM2U3SThrTEEzZzVyT2ZwZCtSb3JJckY5SVIwaFdMbUF6dVll?=
 =?utf-8?B?eXl5NjVNcUo3dzRsOVlURStzYm9xM3UxcFI1dWNOUUxNd3ZkR2sySWFWL09U?=
 =?utf-8?B?OVdKSXhGbUxmdTIxSTBNL3BRQ0hGdzVqcHhMSlNxK0Yya1pJTjU0NWtkZk8x?=
 =?utf-8?B?Ni9YbEZibzdoWTg5clFGRHdZT0FZb2NVTzgrWGx6eW1PSXlDblQwU01pWHlD?=
 =?utf-8?B?UXhieXliL1dUZy9rWUF1SnQwdHNZb3kzSHlYYllxMFYwZXBCK1JNOVUrWTYv?=
 =?utf-8?B?QmkyUHA2M0NTSGdna0xKdEJneU5GU3g1Y2Vla1phTmVaOXYzaDlxVlFSTEQz?=
 =?utf-8?B?NnJ0ZjViVTAzWEd4VmxkVndUTnRob0VrY0JIRHE5NUNIQkNSVFBBYis0Y2RO?=
 =?utf-8?B?TzJKVEdwR1c4WmFVRzhhNkNscHlTSjd0Y0FuNzJCdDF3MFJMSWJEc2w2TXRn?=
 =?utf-8?B?dDRjVDdrTEdYWk01WE9vTTBVNXBqSWxXaXhkNitLZ3FjdXVQR3B0TFRDbzZF?=
 =?utf-8?B?Zyt3MXNkcUVGR3N1QXcrUVBMYUJLaWNtZlFqQzdsc1hzaFdDdy96a0F0dHo3?=
 =?utf-8?B?M0RGK3QycWpDZW81eGJOMmxnZ0Q3NXhvYS8xRFZMWm9EYWdUcTVjcEg2QnN6?=
 =?utf-8?B?Y25sR3BHNFllbWNoM2pIQXhUdWRETExwQW5nci8zUGJtSzJXT2QwSE9vR2Qw?=
 =?utf-8?B?Q254MjV3ZStVRzBrVWJ0aWIyWWRIcGl5RWkwSGlxaGVjcnN3Y3FhOVpuaGhn?=
 =?utf-8?B?d051aHphMDJHU1FyY1R6QXRyaStKSGJMNkZuZnF6eHFCTks1OFVjYkF4eEt5?=
 =?utf-8?B?dnlnaEVVMUUyRHhvWkI0N25oM2FjWUhNaVN4WkoxVjAzVy94MXUwcnF0RWVJ?=
 =?utf-8?B?YUo5cHpZSWxrVGNaa2Zlc2RMWk50bDhTTTI4L1RxU1FHQS9oUHV5VU9aY21J?=
 =?utf-8?B?Z1JyWk01VEFtVmdCbXBvMDkxODRta1hXU3JKSFBWRmNVazAyV0NyczdhYVpv?=
 =?utf-8?B?Wjl4ei95d1hWZXNTRjYvalpKWEE2Z3JEaElyY003cDZ0ZWp4UjJubUdQUHhV?=
 =?utf-8?B?azVZbXNqZStoRDhCN1UvN2p3NTd4eHlpelBPZWFkSm5iVEw5b2k3alpHTHhJ?=
 =?utf-8?B?eFdKclkxRmZ5cWk3dFBxYlBFRTBhSEx6dGx3bkZwNXpaaGx1NFgzSUlSRmti?=
 =?utf-8?B?Ymg2dWJwZkxQV0syb3VSdmJ2NjZaUUd3SlBPbVJiU0RuTFJQYnBQM0toZUVP?=
 =?utf-8?B?L0YwYlp5R2dRb2x3TnFlTGdGbUdQMWhUWTFScFlyVVBrdS9oZVBGN1RZZGUz?=
 =?utf-8?B?VXhDS2VNL0dXUUE0bVlTNXFKdzdlSlh0NWZDK2U4YVhYRnBVbDlyODZpL1VS?=
 =?utf-8?B?NjhVTnQ2eld5b2puNGRkbjVKMVR4TGp1anFOSTVXUk9lNTg2WU5iSkh3Yk9O?=
 =?utf-8?B?Vmt5SFV5Y3hQU3lhUjJ3bWRYSFdGY2xjRysxeTF1YUZXL0U4cVBST0o3Yk1k?=
 =?utf-8?Q?m5OZUrgs/033vqwKunryoKZDD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb49deeb-87b2-4a0f-f74e-08de2b3b50c5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 09:24:49.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUE3hm5O3GiC7x8U/Pz4TgLyuwUV/dQY+C12K7DG/lYlMiWQ9ug4zH+yJdKHGXUp0IrYxfBrZMzAuJsId7GjRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10697

Document imx94 xspi that supports interface to serial flash
supporting following features:

- Single-bit SPI, Dual SPI, Quad SPI and Octal SPI.
- Single Data Rate or Double Data Rate modes.
- Direct memory mapping of all AHB memory accesses to the
  chip system memory space.
- Multi-master AHB accesses with priority.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    | 88 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++
 2 files changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a0f4b162c85855c55d06c6ea1a2417af5121fab2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,imx94-xspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP External Serial Peripheral Interface (xSPI)
+
+maintainers:
+  - Haibo Chen <haibo.chen@nxp.com>
+  - Han Xu <han.xu@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,imx94-xspi
+
+  reg:
+    items:
+      - description: registers address space
+      - description: memory mapped address space
+
+  reg-names:
+    items:
+      - const: base
+      - const: mmap
+
+  interrupts:
+    items:
+      - description: interrupt for EENV0
+      - description: interrupt for EENV1
+      - description: interrupt for EENV2
+      - description: interrupt for EENV3
+      - description: interrupt for EENV4
+
+  clocks:
+    items:
+      - description: SPI serial clock
+
+  clock-names:
+    items:
+      - const: per
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@42b90000 {
+            compatible = "nxp,imx94-xspi";
+            reg = <0x0 0x42b90000 0x0 0x50000>, <0x0 0x28000000 0x0 0x08000000>;
+            reg-names = "base", "mmap";
+            interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&scmi_1>;
+            clock-names = "per";
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                reg = <0>;
+                spi-max-frequency = <200000000>;
+                spi-rx-bus-width = <8>;
+                spi-tx-bus-width = <8>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e2ed9827be3f40999e97b15486d99508f7ca30e6..0f3ce467100d7600f498656dbe36b52a2a575cb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18900,6 +18900,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/trivial-codec.yaml
 F:	sound/soc/codecs/tfa9879*
 
+NXP XSPI DRIVER
+M:	Han Xu <han.xu@nxp.com>
+M:	Haibo Chen <haibo.chen@nxp.com>
+L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
+
 NXP-NCI NFC DRIVER
 S:	Orphan
 F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml

-- 
2.34.1


