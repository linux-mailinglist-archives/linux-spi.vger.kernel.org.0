Return-Path: <linux-spi+bounces-12356-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB767D1CB9B
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 07:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FE9D3008C9B
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64036D508;
	Wed, 14 Jan 2026 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TEKZjEpT"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B736D4ED;
	Wed, 14 Jan 2026 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373444; cv=fail; b=PnKN0uCTq7r9LyXBhlmv0onUSr22sxPGJnj9N9iNT1SZe3/X6QApcg51cWKv5rVyUS+u7TvwtoAV2qSklbFj68J6NNOYq+cnIS60qRQpTweJIaPyX4xZXIMI3eR7XyQ6T1lYWVXfzyDa7BaQz88dclPe4hR54r8BxdNTv78hiHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373444; c=relaxed/simple;
	bh=SUd8s5IADsytjxUIHslmvzBbfIDdnWdyZNNdPYXgmxg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=R3n7UMZTmYitrBjTyRiYYqKltE72PJ+YYYLqmNOXuheGQA66YfWz+H0qSxX+k6ZnTuA7In2fDnpvYPWtT4ag9N4fI9kpvEmlY48NornM7jMWlIwfGScfHufRfTPQfeT2jbxj/U8+2mP1C4yYPnwUOEBI1cPN/tfBOLesZhFw+KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TEKZjEpT; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr4Zas2MkeLQNKMmS3iLhA1BiIR0jGXoP6Zd7dPPquICn9N86dWGA/3+4nJ69a0PfCTGpxX64uyeiC42E8oCrfLTGJ2wc25sSFbnzljfXqEP25xdl9E4t64t3t92+FQT1frjsJJNE1zWX3WA0RiPY3NWMe9qa/7azr2zy+31HdQmkeICMZmyRReNrAJwaCaxdIoi7Y3kOnIn/GE3odL143lbg09RUxwM0vMlHALnOqxDsw4MfMT2jRkIzQyIA1ALDhTwHxASGgwXHZKelXhbH7UhV4uY2qnoYxKlaqjvEUOEq4SzuOSUt/PmS1WiRoiAQd3FU31JD7EOR1MaHP1t5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SYWBs5/LknOT4v5hgSegfKvirAWA6fpphIhFy9k45c=;
 b=rf8AhTqdeRAgzW8R7zWo6ClP4ARzRmNrspPzZ9iaJzwxyWKDm0XVFSG3iaIdqmG/BOtzalTYVu+MyvlELNblaRb9EMbMCCPIFyUdg0RG1sgcy/vLcBbhIppD5+iRQOomRz+RClf6ZnV/ZcOqPlPJEfmZ9I+XqjOCjJKSLCTsy7hM7N+Vh+F0+lR0GVRxwxu7o9T2FL/TNX6H1f+TLSdW636+PSDLm5SZ5TxYO6ehs0rNrhXgoAtcWdBD8P4h9Cb9nhOqiRCEi5UpoKnoR6EGt/UPK2kAqdChA4vyLNr7prjum1fTDLNZzOp21L5s9/wAZKwMmyIeMeXy/Lnh7fAomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SYWBs5/LknOT4v5hgSegfKvirAWA6fpphIhFy9k45c=;
 b=TEKZjEpTIS+ARdgZbSeDWg6ZYYfMGA4oWT3t8jTFRGm6ApzRe+Yb1sNARaZ23S+MEEX9luW2bGBFxDe+fxkF4X3FMFbtjUszc/nv2oja9e1rToeuDEjbgYuJJg4hoirbH0KCse4emxYPZ3ZoVip5QC0ZXxgOxVf+awOLyHw1UGOVen6+iX6ruIveJN6A4dCKtkufPUhAkIPq3N5hVsYOO+yNVCxA0B5XC+x1sdqbhIMHDrsboHj1MBJC+9OM111nvN86VAgtKfnNhgfbk3R59d+NtFbnrcgASu/HaXrbIWtcjomzoxLQcAQvTrDkewLtySzwfXe8WbnuQk2S1gdtyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 06:50:19 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 06:50:19 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 14 Jan 2026 14:49:45 +0800
Subject: [PATCH 1/3] spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-xspi-imx952-v1-1-acc60a5a2a9d@nxp.com>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
In-Reply-To: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768373406; l=827;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=SUd8s5IADsytjxUIHslmvzBbfIDdnWdyZNNdPYXgmxg=;
 b=nJJjM9AcgqmtErP2d+mhwDHahLwm7RvnzSCFQf8vMW86BkFdY6BCwsm1AfXnyYLnNPCakSZ4Z
 2uViTEUmtKeDZ/uqPLvfg47dbFYvBasao8zXtpHBbjzW/FOXcx9UH6n
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS8PR04MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: f2805c41-2b59-4927-fafa-08de53392eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmtZS2IxelVuM2l0WFNSWVlqU2dPc2pxejVqdzJad3AzYXNLK3FFdTJIaDE4?=
 =?utf-8?B?N0QvbGl1Yi8reDd0WkY3QzhFcytIYnkrdTBxTkYwUUJHTllEbnQwTmg3Q09M?=
 =?utf-8?B?UEgwdEpmdzhMUFFkdmdsamlNSnp4cEtTTlUzZnNLeU8yRm5PWU5CWkFGKytx?=
 =?utf-8?B?cTVVT3lSQlkyWTk2QkRnQmFEbDFWZ3FkS0s5NnRZOG15V1NuQm1DNVkwYldP?=
 =?utf-8?B?TVJtaEVQdGhNdzNFZFVaSGNBN3BXNHJBcTZ5Y0JRUFR5aEFHeENnOE1VaDRX?=
 =?utf-8?B?NU9FZXhRV24wK3Z0N0trVU1GWVczT3NERHdLL3pnaUVwL1FtdWNTOXpIUUdH?=
 =?utf-8?B?Mjh3NkY0Z2haM3U4WnNmRXJYUURxaG93SHg2eTNOaVpiRmNJMHFOaGRXK21L?=
 =?utf-8?B?MFBOYm9aQTFjNkgvTUZJc3Jrd05mbFBMVXBiN05iODJqb0UrbnM1RC8yVklF?=
 =?utf-8?B?bVQ0L0w4aUFXVTRYeDJaL1dONEpMQ3RjelRGMUFIbEk0VGN2R1Rqc29RRFdk?=
 =?utf-8?B?OXNYc1JCTVhlWHQ2bG1LV0hNby9ONHFYcklqYXVXRCtzVGRhM3BqYzFzZDQw?=
 =?utf-8?B?TTBOTmZyL0gwb1JTTWxyWkpsbkNLRXJNK3lvRDZDSFowdi8rOEFwL3hlSm1G?=
 =?utf-8?B?MFh0MVdhanB0bTl0akEydU1sU3J6eThNUlRWcEZIL1dLMXlxakQzSldYUVdW?=
 =?utf-8?B?THpMalREckVZZ2FwN0VNeG4rOTVBS0gyYS9CWmVJNCtyK1p6VlkwMzZHb20y?=
 =?utf-8?B?V0FrUFV1K1Irbm9EUzF4Q1pCYTdFcnowTFR0QklNWktHWUFTRGVFVVBqRDlW?=
 =?utf-8?B?UThDRmdCZmMrcERVQkU0cGlkSU9PVnZ5RXBWcGdvVXg4K0IvRWtiRUFNQUJZ?=
 =?utf-8?B?aktRSzhvUGN4bjZwbUE3MUN0MGNFYUlISVVjYVNucGNIb0xZc09RS083WEx2?=
 =?utf-8?B?bjh3TkQ4aUgydnQ4eWNHcHp6eW0xWUVTa1JneVVLZWVHenpIQmRRc3A0T1lo?=
 =?utf-8?B?REo1NkI1VHNKTU45TXdHZXpsTHVuekZEODBWbWpnV0tZL01Ya2dRYnNTKzVo?=
 =?utf-8?B?c1J6QmJyQkFtVHVReUZRaFFrODNJTkQ0WnNhM0Y5SDgrSk9DckFSelN0bFJ1?=
 =?utf-8?B?TklhM3dmSW5iMXRiblRsb05uQ0twUXZyOXUxRWhGa2c4WmxBUHBjeCtyR1BF?=
 =?utf-8?B?d25xV016cVdYZWhMZElBTXNYMXdCR2JOUGpVSi9CTC9tL0ZpUHJKbzZuN0Ru?=
 =?utf-8?B?ODlySFExVVI1a05aZTVSTnFWeTlrZUYzSzlmWlBRclM2dzFMUFNoMG9tU0NE?=
 =?utf-8?B?MFJzTGFQK0FoZHMxK2VxWXRwMHRBbmhzNGNpNWF1Y3o5cjdweVAvRGJ6bkNu?=
 =?utf-8?B?WlRLQ29KMkQ4Y1MxMDlJUnMzRThTWVBWNmEzN2gwOUdtUlB3OHcxR09JUkZH?=
 =?utf-8?B?MUJtVjY1cnRaSW8rQmgwQTgzSGFxQWZJdGNLK3hyOHhaVDZWVzVpdGRLSEQ3?=
 =?utf-8?B?Rk83b1F4dnJUMERWQlF3NWxzNFlhdk9EbEZjWFdMT2NRNE9pYU45Wm9hdk5x?=
 =?utf-8?B?eUgyLzRjUjZEYmpnZ09nT1VJSCt3dkw5NGh0cTQwbTVlU1Z2alJHVStsK0RC?=
 =?utf-8?B?YjI1OTFRSW9UbkNsYWZOd0lVRmgwZ2FRcTBhYTJTWGY1TFlWMU00N2tJV1hI?=
 =?utf-8?B?dnV4RU1YVlFzQmttd3FNaVhoS2ZQaGdPdXV2Wm8zd2Y4ai9TU3VsZWhvR2dF?=
 =?utf-8?B?VkZjVjN6NXQ0TUpFSFd5M1VWMm5rc1pzTEdZTUd6Zm1BY1ZoVHFvUm9qN1pQ?=
 =?utf-8?B?ZGlTTnVsWmhGUndaRUsrSUYvYUx4QVp2SjR0aWtEM2czL0pYalUwNk9ZOFh3?=
 =?utf-8?B?K3FmMUY0d3ZhdVRlQ0VIMDZhSS82dzZ1TGZkNHF1TUZRZVM5UFkxakxkM0pP?=
 =?utf-8?B?d2F3ak1STjM4ZFBPSW5YU2VaWlE4bU93cVJyU3FGNS9nWlNnbUxITFVsN2Jy?=
 =?utf-8?B?TnMxemtZVnJhTmM1WjJXYVRXKzJaVXNGU3Yrc3F0L1BqN2FOYnBNaENIeDYw?=
 =?utf-8?Q?r+y2J6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFBqY0s0SEhzQk96Yzl3N2xHNElxNjFuNzJzL0tueklTOU84MUlXQTVSZVBB?=
 =?utf-8?B?eTFuQmoxRlNZMmRpbmhzRmFqRGROcm5tRituRjVGakxRV0M1ckYzek5OT2Zy?=
 =?utf-8?B?YitHczF5cytNRFNVRGlUQWNUbU1QclE1TmJCemxvMXpjTVNtZnN6NGNhVS9T?=
 =?utf-8?B?TCs1emN6T29GODFoTkgxSnBsS1J3Y054Mjdyb3hsWmZiSmFEdW5OazZ4QmJk?=
 =?utf-8?B?UU9VamFXWXYvZ1lzNWZaK0NWeng5OEJHNms4TVhmemRyQUFHS0E5aEQ5eUd2?=
 =?utf-8?B?YWNvcW5uL245bXBFV1BOK1VISVBkRTlmVHd4dy9qTzZQWlB3QVQrUTh5MUpP?=
 =?utf-8?B?Q0w4VmxjRUhKWUJkNHZkVW9jbkRCSGxjK2hkUjFvQWFUS1ByelNvdDRQZnNm?=
 =?utf-8?B?blN2N0FqbXVseThKT0RDaWYxT3YyakdJYUxrbUVBMDJ4eGU0TXpuelZQRHNU?=
 =?utf-8?B?K1ZhYVpKRHhncDFBVllKclA5bWNENXNBb3FwQWNQSHhpT3VJRmQ4QjhjdTJZ?=
 =?utf-8?B?Q09YR05GY0lGK0FBZmhyenQyRHF2RFBNcThxWWFtZVR3OEVJMW5aVHBnSFl1?=
 =?utf-8?B?N3Qwd0orcHRQNnkwaTZyU0dkVHdIOExWN0tEZDI1R1BrOFVYMW10TUoxa0Mr?=
 =?utf-8?B?TC9vQjliK2tnenFRTkhEOEttdFo2V0NlM0x1ci9TdmZVelVrZjlvaWd1R2F5?=
 =?utf-8?B?Vzl3YVJMNzYxaVNidEtQN1BsSGo0djZZcFVWaGpuVTFPSWQwZUhzU0U5bWgz?=
 =?utf-8?B?cGtFalVjZnUxQmpraTZoeEtNUWVBSG45Z2I0QmtQbTlSNW9GKzRaWmptRnpZ?=
 =?utf-8?B?SlJBSDRhZm1IVTdpa1Ayc0JubXJ2K21rUjFZY3FwTDRZbVZ0RWp3R3dEN3hn?=
 =?utf-8?B?QU5pUjQ3Zmtra2tBeGo5dW1rTitTSEs3Q1FuMXRlMVVnVmR1K2hoTWtMd1hW?=
 =?utf-8?B?d1h1dm8vQjM5cysycW5wS2ZFaFllQlVzRzJSQmVGVU91akR2UjViaWtNaUdj?=
 =?utf-8?B?ZTJtS00zRGV1SVhOOU9hV1EwcGd2czB0VlExanZjSkMweTY3U3JtaUdyMnk5?=
 =?utf-8?B?Z0pET3E1OXQ0c1hDZDhLNmdUVjNaM2FXSVNhWC9BRHpqVDljRXNqcURaQW9E?=
 =?utf-8?B?bjBEeitheTJ5YXNyYnlmdlNaVUNRcTRkdmFRMk9ON0toMy9wRUxTLzhtZ3NN?=
 =?utf-8?B?U01iYTMyei8xWmJQcmVIekxFMHdFayt1M1k2c0ppdkFQSGVSbXRMNU5EN2NF?=
 =?utf-8?B?SUV5NExVVEptWld6M1lCNjNSY2hLT3pNQUU3R1BCb21xeVYzK3duVWh1T0VW?=
 =?utf-8?B?TlZSUUcrRnFES2sxSjFscDhjSy9LSi9FS2Q5NitraFhBNXpaUThwK01SUTlW?=
 =?utf-8?B?Vm5EbUswbHZXYi92bHE2d29JeFluNjBDMkZmNFlzQ284bGhsMTVhUTBzVVhw?=
 =?utf-8?B?ZDFSVWtCR3JrL0U1R0NldUZqQTVSL1RrSi92Ty93TmNVTkp6VEZCc1dJNHpx?=
 =?utf-8?B?eTFEWFptQ2wrTXYvdERseEtwc2NpcGdmaXgrMjVVRG81Qi85T2tCd1pSSXB2?=
 =?utf-8?B?dGtWQVRpNkxXYXZKTWZYaWlweE84N25wZXZsSWlyOXY2eVJQLzlaRnNlcmh3?=
 =?utf-8?B?UVkwcS83WFlacmZiMG5Iclh1U3FiUldXd0tYT21VU2FoTWRtRXRFQUpwT1kr?=
 =?utf-8?B?TmlxZTRjZzBnVWpCMC9WNUwwVEdOMDVRb3A0cWw4OTRqaVJLN2lTQi93Y0lu?=
 =?utf-8?B?d0xoa3YwRGVEcDJleFEzcWF0dU1YNWdLMTJ1RHlvK2dJTWI1empiTk1JTkpP?=
 =?utf-8?B?Rm9ySFZQYmZ2VW5Femh1Tmw2TkpvdXVHTkF1b2pBdXRNTEJrWEozNVRmSmg5?=
 =?utf-8?B?SUFuTDNXcEUrc3FrNkhpcHdnbkcrNjlBcGZkT2x4TnB4N1JaTHk3elh6aERV?=
 =?utf-8?B?UTBlTFVqRnFEUHpCR1UzOG1MMU1RTm53T1llblpxTkFCK2IyZnNOS1d4eDY1?=
 =?utf-8?B?Y1NOeW1sQzFrOEdkeXFFWExiSnpBRHVEbVpYQlA4NUVOMXpseDhCWVlhN01r?=
 =?utf-8?B?OUM4dnprd2hmOWxsZytQU1g2SGVKTGJHVE5BTWVLcml4U3EvT1cxMjhlVG1s?=
 =?utf-8?B?L2toZUVVYlRzcWg5ck4zRnRkNlEvRlBpMHR5Nlg4Q1A4V0ZCdnR0RGJCS0Vy?=
 =?utf-8?B?MER6ZDlzTS9kRmtzcVo1K2hCNGNnS2ViUExqdFVod1NYRTdWUVNSWG5BcDls?=
 =?utf-8?B?RUM5eHE1d3VmcHNkTUNHZkQ4MXdhRXZhbFB2R3Z1eTlmbFJ3VFlOWlR3WWcv?=
 =?utf-8?B?ZGRsbWFIcDl1dzBVSkZVRjhyYW5IYmNmOVVxVVdpQVkvWXhRRFJNUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2805c41-2b59-4927-fafa-08de53392eb5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 06:50:19.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bUgGzR+3MW5B/VzXcjAm8bi49jdWlWzW0wP4z6A/aQRwKAAX80N6wEA/fyoBgGpykvCumCHbXKFGjqHIjG5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673

Document i.MX952 XSPI compatible, which is derived from
i.MX94 XSPI.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
index a0f4b162c85855c55d06c6ea1a2417af5121fab2..16a0598c6d033554ce5a42a13a3265315a16992e 100644
--- a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
@@ -15,6 +15,10 @@ properties:
     oneOf:
       - enum:
           - nxp,imx94-xspi
+      - items:
+          - enum:
+              - nxp,imx952-xspi
+          - const: nxp,imx94-xspi
 
   reg:
     items:

-- 
2.34.1


