Return-Path: <linux-spi+bounces-10040-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B04B58FB3
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 09:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EEE520863
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA63284B3E;
	Tue, 16 Sep 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oFPnepoz"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F7284886;
	Tue, 16 Sep 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009434; cv=fail; b=Txx88vAin6eUJtCzRlheJQeCbCULLKxn/aafGldmNWL2SJxkhA3HOmdJ8HDIEt6niRpGvEcXt+5OPDt3U/9WfOCFbQMw/o2SHbBOwLwsBucUwfkgToAtrjUcN5cbzxTdzX7L6NzFIHHdZWAOTOftCTNSBhoguh7s8fyvNaIFHfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009434; c=relaxed/simple;
	bh=hP+GZBOk6LHHZqKWeJTn1LVXizvUezYbt2jXvKLGZJM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=o2C4uOZEd92vlRlK+Ssxp2UnQXm70HbPjEab8z4Qq6BFRhddiIw5MJf9hmRt7s8n4aAp3YN1RvNsaBu35IgLkqEx+z78Kj2qJqNOLzDdwPUknWB0cmjksL46zibFXOZWMkuX+ql0aCrwPXlcx2ZJlxSctUnjU7+LF1xsNx7V3KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oFPnepoz; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8MmNVDys3bHEiAJx9hn2R3pRzd7sSG2TYTh9NHUEGNftARJIb3gfxiDmDL8QyeqF6CFnOjJkmR3Dfw0DBZcUHA0M4VtNh10UwJto6MYnMgOkJkBAv7zx8HEjPYGiJ7UathWgLFxdaqu5h3rBATX3Y55oYxKi3jmphTv1FfzK/hbK3aTGuFADcPE9KJMwRXD+7FYCHW/e1kOXueWiCD5Ca8L/b5Bp1AuB6RA4CIVj3NR2GtE6K319QIgQfGOYNAENrd+9hsqgkr+g8B1jT2qw0CR7zaVzvRQImkqPHdrcokRwV7+hok8S9jZuioE169cJco7JJRbd/bHc2fVcpF3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNAlmMfdI5JSqIQ7Jeabp7I5E5gnCPod3piVuEIgWY8=;
 b=OWraBkMpOsXv4Oz8i7IfRAC4K6VKlt676W2W6mA/f2sxe1+0bwyHqaGx38ay39EN0eRItqtRAkPPCnMKtdLF8Am7cF/KLw3TP5XDIgdX3bEtCfNorR2DgEio8QCkbLovNkIaHC9Zy3BAfAP1qnKAdJ8OHKkuce2Do/0R0kmi4fEJ0mB/Taduwkcxmga6ZunN79WNtolA4gE4A1jYpGUIEL4Pawx6o1cniZ5yzs/pPOyOd3zAe/a5Ol0EnQFrK9W/fgGz1PDxQ6hgyrdzT996PQ15pmYzZoj2jB+x2ZCtpODW+RFx48lp5wgKWlQIaSPVzcD3reRnyHT6WBzY3jMbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNAlmMfdI5JSqIQ7Jeabp7I5E5gnCPod3piVuEIgWY8=;
 b=oFPnepozuDdVCFJ57I/NmS1PR6udAfk/MVMj3ru86KYiOZY/JTPxs+oBHfdCw2f23KOfKqRuIJhgp+xPu+zZTr/39SrFZzj5JKPNAcEbuIHkavZIWEg7I2FCs7ee5hRDHfBDCL92RaBIMwO7+lQFzKm6dlw0IZs182BUkbwvcrG6U4VD88WjY8L+xgOOXp0oCocJH6HRfl43JhxCttHEVkgYg2LgYwBIOE29sBq7saiY6mQggfkKvUwOTkTGrLPGJs/tsu6A0aFxzpFMD38JZsi9REg05YUKZ8GgxKijF/cD4I0hYHkKjW4nHbSeNrGb95Epvukw6B+pzsySSvbYpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 07:57:10 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:57:10 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 16 Sep 2025 15:56:43 +0800
Subject: [PATCH 4/5] spi: spi-nxp-fspi: correct the clock rate for DTR mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-flexspi-ddr-v1-4-69358b5dc862@nxp.com>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
In-Reply-To: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009434; l=1117;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=hP+GZBOk6LHHZqKWeJTn1LVXizvUezYbt2jXvKLGZJM=;
 b=qTTnjfKd+BP8AUIYS404FrRnbf5jgOT80XjsgU2Tx9OlT0cN4RIEW/UiHexp9bBydeBHDgT3p
 7RRViEhEMIOA9NUj5v+fGxN4MqOjAa36xcOaRO5Z8beZVvP7OcrdUSa
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fef999-0c87-4730-0611-08ddf4f6a39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHZ4WHM0TzljUXYwVzF4SXZCNUxSMkY1eWo5ZStveitCU0xVSTNna0JCWjNQ?=
 =?utf-8?B?SWVaRkMzd3IxUjUyYUFrOWMvRWQ3azhIWEk3V0JVN1NUYmFyVFhaK2JNc3Rv?=
 =?utf-8?B?OXhZRWRQS0tiNG9kc0RaTU5oSGpwcXpCWklHVi9rVVFPMVNDWjBPNFZndGkv?=
 =?utf-8?B?Wm10VFE3akNLZjY3b2lIY0NMOEJsdDMvczdndTRZU0RvUUliejArRk96Y1k1?=
 =?utf-8?B?dmJFTy9JRHRoMEdLMUZkUWg4bWV2ZHZmUVJFUWNqdU50WHdqQVFROWhsSThq?=
 =?utf-8?B?WVpadExyenhjRis0YnplTXZFcjFwNEJIZHgzRUczeDdSNkxPZ2FES3NnSzAx?=
 =?utf-8?B?bUd1WlZYQVlnSURsRjJBbEZ4djBVdEl4NitXa1phdVhIUDdKTGp3Qk1GdE5R?=
 =?utf-8?B?L05zTjlVZFk5b0pldzVZWnRndytMc0xhb01wcENTOTFWeElpM3VQdURaNEYx?=
 =?utf-8?B?eGFNbitQeFB3TEpWaEl5VzI0Nk94TTY2V0xHaTV3cXdvdm5NcHNYYlpGd2Qz?=
 =?utf-8?B?eUhSMmZMalRoSXoxQkZnOHJoMkNEMENtNy9rN1RVc01jTnN4dHZhTkZ6WG9V?=
 =?utf-8?B?Y3Y3SGZ3Vy9oQnhienRwQ0hvSnY0T3J4QzR5Mm5TRFBiaVR3SlZ2YkR6Uk1C?=
 =?utf-8?B?dG9KOWllaFNDa2ZIWGlZVm90Y1ZiU2hadTVKcmNvQk0xeTNpdmEyTkl5OGNB?=
 =?utf-8?B?Z2QrWFh3SXl0Q3NzMUNEUFlRZE1vcW9GYkpWMnhvTElwRHZvalhaaGxnZGlT?=
 =?utf-8?B?QmFjcWxoUWJjQWNhUG5IaW0zRk9XdlFGVlpNakN4ellJUURFQXZBU0JmWFUw?=
 =?utf-8?B?cW5NNGtaaHVUem1ZY3AwV25SWVptYlVMcmw4cC9sYkt1dVl0cldqNENrT2lK?=
 =?utf-8?B?MUFaT1dNSmJ6THlEOXhsbTJIdlFPVjdxY09laWpsM3FVMVdyc2dYbkhmbUgy?=
 =?utf-8?B?U0RtazFOTXRSbnRCQ0RGUmt2U0xzOHltcEw1bmF4VndZcG42T2NCY3RLODBU?=
 =?utf-8?B?bFNQUEZQV25tZ0V2bDZXZmxGK0VMVlB6MU5Fakx1cEtaTDdtS3F1bnB1bDNi?=
 =?utf-8?B?ajRzVWh1VUlWYk1pWnE0TTVCZzlEUXZTWlgrWi9PSWZ3TCtLbWUycCtxTSs5?=
 =?utf-8?B?NEVLV3JoRkptam1oMHNSQU8vc0xMU05CZFBqRHYzdVRnM0xkeW5FdkVLalZs?=
 =?utf-8?B?OVZReFZENXNCSU94ZGRRczQ3bWV6VkR0Q2k3cWdTVTl5UytLRHBSZDZnQ2dH?=
 =?utf-8?B?WjVJN3UvUTVhMkJlc2dTQWpWT1BrQWk2OHFxM2EzdlV6WDQrMHYvY3RpVGFT?=
 =?utf-8?B?Z2w5MWVjcDFRQ1ZpMTlXM1VYdkZza3ZBUmF2NWhLTFhsQ2NWcUw3T1BHWmpn?=
 =?utf-8?B?Z1hrQ1BmWFVRT0pmcWhhQWNlNFgyWGJvV0dzdWhEdkhpcU1XMUNHbmoxa2Fh?=
 =?utf-8?B?Y2oxaEVuYkw4WldOUUtTV1IrQ3ppNEJ3RzlNbEtCb042UkdlYmpNZFhIa2xq?=
 =?utf-8?B?T2FkaDJRVWtCdnc2QTljUmZZUU80V3R4R29BdjlMVURuY1BDTzQ4U1c2V0Zw?=
 =?utf-8?B?V1lmSW1LVTVZNUtxQ0dETkZiSGlFZjk4WG4rMXVnemNuRC9aQndTYjFTRDkv?=
 =?utf-8?B?ajBvWTZzdzRlS0xNYmp1dWRrWHpsK0RkenlRYzVLYkU5TnpuckxtZ3RJOXFv?=
 =?utf-8?B?ZHpDcENrV0hJVUJBVkx6cm05azJJcXlQYzR1NkFhVkxQVE4wMDh2VmErMWZ5?=
 =?utf-8?B?Rzh2RDVCOWU2dHAwYzIxcXhYQThEQ1FQVmtwK3RzMlk4dkNnT09IcS85YmxT?=
 =?utf-8?B?TC9jbTZ2QVNHaU9PY0pMdnlpV1NVMWExWitxV2dubE1Ic21zMDNnMDJiVDdP?=
 =?utf-8?B?bVNUNnRQbk1KdzUzSjlBNnFkNVEvdUlnOGJYczNkaFptRmtyS2lPZ0JZSGll?=
 =?utf-8?B?djlEdDNkRnVjSzEwb01BTUc2bm1QMTd3S0lCZmprbnhWSGlKbHFTeGhMR2M1?=
 =?utf-8?B?Wk5vTVd2SHdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3ZaTlcwRm8xWXl4OHV5TDNFQ2JUM2pZbTFoNGp6TExQNmpOeXQxbmpPQWd5?=
 =?utf-8?B?ZjFNbGgzRDNyaWlUcUN2djVCRUFQVmFvV0JldHNlY1dkcG1TUFJZNXc5T0RV?=
 =?utf-8?B?Nk93MUl6SGovcUZQNHExT0M1SFo4T1lReldBaGk1SHJOc3dHOG0vTUdGUDJH?=
 =?utf-8?B?Z0NKVU4rQjJXWDRNNmxRZlVRUDRkb2R5MVFFVWhOc0lxR3AvVjQzZCt2QVFO?=
 =?utf-8?B?Sk8xMFFoTDRMZzhQNnpxMEZQcVVWK0tKSlhBdkJXKyt4bFpQa29tSmtkekpm?=
 =?utf-8?B?TEdjZFQ4eEdJY1B0dVBEQ2N3RWtNeEVpcHVkcTA3Q2oxWllIMG53MDJaL2wv?=
 =?utf-8?B?YWh3aysyQ0N3T3g4eERtVGFMdUZUekxKbkgrUk9EUEpwRFpJaHFsMEN2Z3Ft?=
 =?utf-8?B?aGhwSDVmY08vWUFIWVVFSXFMTmdCaG5FcmQ1M3ZXZnNHUVBTZlQzWFphNlhs?=
 =?utf-8?B?RWNJUkR5WWNBWkMyV0l5NUJpdEh5OTdhck5NZ2IvV3g1cXY0NDkvRExNRlZT?=
 =?utf-8?B?VGlWUVdFam80UVFQd2lkNE1icnB4SWp6SkFRSTlOUjNjYXg4ZkZkZ25hZC81?=
 =?utf-8?B?UFV3aFI4YXVZR3kyYVlYeXc1L3F1TW4wbTRodUZiNXR0M2R2V2hNVGQ3dDFY?=
 =?utf-8?B?VzVDYnFTK3VFQVZEeUYzUkJkQ1pxeHFoTHZHVStDR0tvMlVoNnE3bTdWT2FN?=
 =?utf-8?B?QTJ0c3FPU0VKNHZlYVJUSjZuenhWN0Y1eEdqekVSWkdrNUZoQkJhQlhQamNl?=
 =?utf-8?B?bVUxSmdmRDVTZEFsSmpIQnR2eS9YaWdIU2I2MVNLWHZIMk9YNkNhWnIrazhC?=
 =?utf-8?B?MkdNY0V6SjZFQkpGbGxnSUtoeHBFNExxN0ZTdHhDa2kyN2F2YlpYVGUrb1pY?=
 =?utf-8?B?R0R3UXBwWG9tQlhEMkQ2Wkloa2RZekdFTk1yZlRDNWF0Ti8vUU44MTBRNUsw?=
 =?utf-8?B?cGpxaktHMTRsL1JZUW5mZzEwRnl2T3RtNi9BMVVDS0dJM1VOT01CYy8rV09L?=
 =?utf-8?B?Y3VlcFhpOEJpTWxJOHpTMXFlSHFMbG56d1ltOUJtTXIwTFBYZXk4YTdYNkxG?=
 =?utf-8?B?MFF0M2htVDM2SERRdjY5VjAvMzZkZUpHYzRjVVo5eXRwWGtwOEl3SEF0R0Zq?=
 =?utf-8?B?cm85WUY4YVpDdkNEd3d1SEZvaFhLdVBiQStIcnBtZ0VCSzhzOWhOaGh0RzMx?=
 =?utf-8?B?enlyQjVqTzJFMzE2dVljbllRcjRrY3ZhcUxPdzRYd0ZiWDFlK1llc0J3N3Bt?=
 =?utf-8?B?MDlmVndPV0V2UkVCU3B2ZnI2VTZCczRJcnkxYkhtZm5ZRExGVHVURXpoaEMv?=
 =?utf-8?B?eW9JMkVtRCtJQTYyZHdRdkhrbjJZSlZBdDlTWUxjdlVoeWlHbXpLS211dG5k?=
 =?utf-8?B?QUVCdXlrZVBub25hS1hkS0I2L0Y1RHBKYVBJOVNqNlFONG1Dd0lnZ3k4aUFP?=
 =?utf-8?B?UFlnZkpHVUtyaGJTU2hrVzVzektqelRLVWpXL0xMODlaY2JjNEdsQzJ5UDlp?=
 =?utf-8?B?RmJwVFVOYTk2WEg0MElZODlpQnVEWmZRd2Fxa2FDQkZvNE5NZGVyVkdpajA5?=
 =?utf-8?B?Ymh2eFBoY1dmdlRXOXAydXhlMWlDZDRrVWxNMVRYZUxOZU9wREhlbkFFcXJw?=
 =?utf-8?B?K0k2ZCtsWDk3TElsQXBET1dIdS9oQnNzalRMSnMwRGUvT2RBMnBBNytENm1D?=
 =?utf-8?B?NnlqVnd5MjVDbzVqR2R0WTRQZWV5T2Q0ajQxQzhvQ20yRmxGOUY3TDl3QkJw?=
 =?utf-8?B?YjFiSFFmZUU3MysyalpLVFU1dkoxY0pMT2lRRTZkNHJraUUzMStLQU5DV2NZ?=
 =?utf-8?B?R2luRkUvR2V0ajNQaUtHeVBxS1pja3psOFI3dXU3QnNKbmZNTFR3MDdtbjkv?=
 =?utf-8?B?MVJrOVp3dHc2YXp2MkJmRE8wMWdXNnl6blgvZFpTMFpRWjcvdmQzY3NGcWxF?=
 =?utf-8?B?SmgzZjBGVjJrbk5NeWVEQ0J0NU5RWUlBbTVKNFlmNnMrTkF2RGxOZkh2SW1I?=
 =?utf-8?B?cFRHeXN2a2xwTHBTWm9WK1Y0RUJzQW9WRWJxb1FoVGp1bUFUMVMyaVBNcnNl?=
 =?utf-8?B?dDdlUlZOaTJ0dk1FSzAyaUhGSHREaFBMWDRwMzhONkl6Um1xdjlVeXgzVE1M?=
 =?utf-8?Q?L2cwyGBFYfPd/Nzhc7avh0t9C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fef999-0c87-4730-0611-08ddf4f6a39c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:57:10.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJVf+K/GEK6kXk/Cq+GkdTu5j/XJU6xu/38lGTVV8v/GhYLYTLRf7Crz7ZH2HmRFw7imn0t413mXQm1bClLY2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

For DTR mode, flexspi will automatically div 2 of the root clock
and output to device. the formula is:
device_clock = root_clock / (is_dtr ? 2 : 1);

So correct the clock rate setting for DTR mode to get the max
performance.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index be1e56072b94f38af934556055e321d9834bb07b..15b094e8e892f0b61c1f320bba897fa1f588be91 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -806,10 +806,15 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 
 	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
 
-	if (op_is_dtr)
+	if (op_is_dtr) {
 		f->flags |= FSPI_DTR_MODE;
-	else
+		/* For DTR mode, flexspi will default div 2 and output to device.
+		 * so here to config the root clock to 2 * device rate.
+		 */
+		rate = rate * 2;
+	} else {
 		f->flags &= ~FSPI_DTR_MODE;
+	}
 
 	nxp_fspi_clk_disable_unprep(f);
 

-- 
2.34.1


