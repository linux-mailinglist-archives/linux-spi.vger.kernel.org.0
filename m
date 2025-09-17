Return-Path: <linux-spi+bounces-10064-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD338B7CED4
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90C61C05F85
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D830217E;
	Wed, 17 Sep 2025 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iGt3vROE"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDCD302769;
	Wed, 17 Sep 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094072; cv=fail; b=OLIGf75GV+wEQQdG8RKaGxaouCI9ogbw19oSy8nWgsL4/VQpdDPIrubGsCHEOcvvBTrZfPKTLXFkQna471izjDCIAeMBtdjf0aT1g5oH3czoaFVMv0Iq2gz66jEqh5vvNd2w50Ft5qMtg+3aJKDsvmIZO4H5SZHt0y4ePhyG1eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094072; c=relaxed/simple;
	bh=A7NvCJTXHjdqLiosdwIGrGa+tymxc1g72mhNEicU/8k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hTsLxXfUdC5c2/uZ9yyypEOju+xuogGYeRQJR9NMeqIuuQ68rV0KtxX8dWOf98DtVLIg/Jx4sSwSyXAi0wvNkL/WiQ+gqf+1MBv1rbuk815xRtw+CvJgLNcyjCQQ+AtRiXrBN5sp8jsV5L9r2gUN8K3VV2K9PsBzlVkQHts8PH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iGt3vROE; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ6wOt2TeO0DREqRq/rk41GF9+vz89FQcKMaOVuurrSWDFKbENoUm49VQGtltbBhor+WR/cLfSjY/Ggx9LcrZiU1B+JXxBlN/KJ3tVMar/Xt116Yy/23n8vubRxEIGs9KXIuphW/32WImLofILZYvqGlZY/dbWGcxDv8caTekmC0tQfxrBqnJkG38Q8FkuWYjceHiZOaSudApkI1O/TPN39MdqVGE6D5Ok9hkU+ZlohVnpG73jcdFncXKT8w6auqUabkk1czIejQR0DrMIv0i3iAL1IQ3C7+0rwLccRZFVKX3EVjDlEyKwWHqTdJdeEuqevnI3hcOF2qps3qS6qadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1mD60g4u2A6dtIFMwCSkUL8BCbvFKR3jK+PWGmyi3Q=;
 b=abhQ4lJr3WHLYaBYTNcd0b53Vn/YnU1xj7Yt5130TmxM4phFmyf84ZWd8d3fkQClCALNVttwhDawh3n1z6mg47l/SF/YYomnScpICulesNeDvFZqCZQk1sxt55l0ajN1VOyX32UAtXFYJgKzZkrGS0W0JZHZPTj6V5Gm7jnLhm8ZrqK6xYXc7wFe9j3uk3s6UUhwtf8QkoNAHFEB+EuV9QO/ZHNVZYb3rKINj/YjYtMx5bUEDtNtPAFRLYeSZOZI9EhG3vZLOR6cURfFxe49bAGvIx6E/suBvGotMBXAvyVDCeQNGQPR0+5UZHVS15ijeZN4WhiLZcqk8socFyICVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1mD60g4u2A6dtIFMwCSkUL8BCbvFKR3jK+PWGmyi3Q=;
 b=iGt3vROEyMyaVF0goE5YqI2Z42DWwadZync02THMTyUcguDakFVO9/cwXbeOYwd33XXDJ0LOW949yZO9uXu/LDHPGmjbQEI6xo3VgOhcRpMFR7z9IYDvVDQZ6Ceryp3uwatu13vJjrMJC9nheFJjBiW1Yj/ZkWRg7muPq0vjzyRYUcuhrFVp5W08f85fmtbvcsdFQknTOhrFVIiQftIog9otYo6Wosen0ib+7x+lk2eO8xnrJMlOB0+tGnMVHOB5gGTqODmw9T5g5DQNJ4Nva7nxoi8ukMFdSBvbAXjs7bVMV123G5khfkLZ0pos4yYQtGGlMYd7eHJ7vqnmBpG3Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10800.eurprd04.prod.outlook.com (2603:10a6:150:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:27:47 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 07:27:47 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 15:27:09 +0800
Subject: [PATCH v2 4/5] spi: spi-nxp-fspi: add the support for sample data
 from DQS pad
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-ddr-v2-4-bb9fe2a01889@nxp.com>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
In-Reply-To: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758094070; l=4159;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=A7NvCJTXHjdqLiosdwIGrGa+tymxc1g72mhNEicU/8k=;
 b=0WpZ71yY/vEQCjAocrFq6Xe31QuqGcm07+12T/+jsp7jyranOkjXfZm200q0EMgV/YhfgD/j5
 Pl5SwBB9QwUBA9cse3mjhx1R76Z0BzdDdkgU6LtdWm9l53s3BXrX0dc
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10800:EE_
X-MS-Office365-Filtering-Correlation-Id: daf65cc9-828a-40a4-09bb-08ddf5bbb332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkNiMEVXMjhwdUl5ZndpSUhyUCtwVUJDT0pPcDRlNFQzOVQ2MXA4anpVWmdh?=
 =?utf-8?B?V244ZThiWlZnSGJJRjRMWFhWVUI4T2V0WSt2SG1yWUR6SVB0TlBNZ240ZXBk?=
 =?utf-8?B?U1pHNldHazFWbEJaNEVXRGVwNS9DSDVxRU5BMWlmbEVVSkNaRlFEVnR5ZzU5?=
 =?utf-8?B?SGJYYXg3L29NZU5WVEh6ZGE4eGNGclNoL3BzZEZ0cjQ0MlZScWNqWmVCUWx0?=
 =?utf-8?B?RHB0NlNVVmI4YzNLcGdabGhoTVhFR1lMc1d6b2RXWlU0S3hrWkNWZDA4VVVi?=
 =?utf-8?B?MnNNdnB6STFkYzlXUGNXTDBRdjY1MDBReDgyc2QwZXQyWVJkU0J5NHdvMDhi?=
 =?utf-8?B?VnhOWTkzNVBJWmhIUm1zR1c3eFdjTDNuV1J1Mnl5eHVSL0pkNEljN093SXM0?=
 =?utf-8?B?RUtWdXBUeERFVWtCQ2VTYXhhWG1NNGZrbFFzakhSOGYybk9LbnVIQ3lLWUY5?=
 =?utf-8?B?SUdWYzZtOUJSNFNMN1hMYVVIdFNWOEk3U09qUksyTlEvY3BmT0pxVmJhZlhG?=
 =?utf-8?B?WjNKcVdFcGdzelFsQ3NqRllVc251cjlVb2FZUHo2ODZrSTNqaHdsdmV6QnAx?=
 =?utf-8?B?QXRVamR1dTJGLzd5WTR6Y3NtcFdJMEtwWHNkc3NNdHlxNFhPbzZzS25vdHBE?=
 =?utf-8?B?blQ4eHd0aEI3cTV1N2NuZTJFRmk5aGZKR3pSQnpnN0hpZmRTQjBXT0N4Ym5z?=
 =?utf-8?B?SHdRNldvSjdZSnJueXNQNGM2TVFOVWswcTBVSFhsc1l0bXBjSU0vKzIrS2ZJ?=
 =?utf-8?B?c0toaVRJZW1raTlzQUFCRjQ2dHVEU2NzejhUb3VwTzloNnZyZENmLzM4eWd0?=
 =?utf-8?B?elpPU0NTRVpIbUY2UGpmU2Fhc2ZWZzcxSHg1NUFNQUN2QTB6cTY1SXZkL09I?=
 =?utf-8?B?VUswcXpJaGV1L1E5dVpxY1lUZWZJTXBPS24yOW5TZTNDNWcxV3BrTHZhNTJN?=
 =?utf-8?B?ZGZjYkRKZ1hxdndSZCsrUE03dGhjWGs2UkRNeFhFNCtmc01lcHZXNlRBTlA0?=
 =?utf-8?B?anpmY2xXUWNYaUx1dGJkcmFnaTFWdWlZSWdIM0xibEFTREh3dWNqTng0amE1?=
 =?utf-8?B?VGVLMCsrMy95YVZKVDl1ODhSRWRnQ09lRUJUd1VhMkRpYXNSU0gvUzcySU1x?=
 =?utf-8?B?NWgxRzVsM2JYbDRoaVZndzhhWkNWOFVOT0ZEdHY2Z3gxbkdoSGFVV3FqSTRR?=
 =?utf-8?B?a001UXBIdmd3cmVZNkYzKzJPLytFdER1RWxXWnFYNzcyVDRUQm1WaFVQNVor?=
 =?utf-8?B?T3RxbG9wSm40Tm80blh5Y0hZY0JRRG5IWVhpQ0ljV3hiSWhrRjlnZkp1d1RN?=
 =?utf-8?B?cXViakt3UlRlVnpaWDY2SnFhK3hteGFvN3FzaEV6d0hRcHlmVERrZlhwZmtL?=
 =?utf-8?B?NXc2dVdwbTVlMjd3K0JpbktUYjFtWUt1UFBTZnN1YjIwa3VWUVlYTlFTdTh1?=
 =?utf-8?B?UFRJTzVhTzlUU0dBaGp6clRrS3p0VCt6OXhoOW5QR3E4OHBjTHBXRkRMbXQ2?=
 =?utf-8?B?NFd0TjZxTnhQN0Niam5tVTZ1RWtCdGlkWnMrMjJHMmttTklKbUZBRmkxWHVv?=
 =?utf-8?B?cCs3akRxK0E2WlZFVWVoS3ZNUEczZkxYbHlzd1phL1pMUU55QVd6NUtCUWFm?=
 =?utf-8?B?dXdDRTA3bXpLckx4MGdPaEhRMVJwSjhhSTIxR3AwR01wbWpDeFNpeFY0aElz?=
 =?utf-8?B?WENQQi9LNVJ6RXBFUWN6YjA1TVVrZVpLejQ1cVZjSFAxWTBOcm5QdU1UVXAr?=
 =?utf-8?B?T3pYd0VxNzAvc3E2dHNZY25uRjJ3OGp2ZjAyVmNvcTVRY3oxalJEdkM2Y0dF?=
 =?utf-8?B?SHFKNndWbG1pZ0ExemdqOVJNeHd3bXAzTzdiMTNURWI3Zy9CMk9kNFdBYlF1?=
 =?utf-8?B?T1N2ODIwbDJTbHN5WHlmekxoMlJ0Zk1UcGdDL0tmRDhrR3pxWjQ2c3NzYnVi?=
 =?utf-8?B?VisyOUhzOVVKT25YaGpCTVFKMmYwY1ZQT1RLc3d0MHE4V3ZmWHlHMm5VaW5P?=
 =?utf-8?B?N0RkZm5SQVdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2M3QmJiSnlhdDIwd0FTb2RDME5pODhObE5ySUtjSFZtMUdFT29vK21oTitI?=
 =?utf-8?B?aVUraEZrbEkyWWRnbWFESU1XZi9CQUNndUxPWkt5OUR6aEZURkdxa2tOWjJ4?=
 =?utf-8?B?dU5wZ2p3TlBXVDV4dGJIOW83bDZ3cGpHN3gwZG96REN5eGg5UHI1aEI3Sm43?=
 =?utf-8?B?WHJFaXZRZldvWnNWWW9Cc25MUVlUdnY2VHUzQjRkaFdwQ0NEOGhpZEhaUUlQ?=
 =?utf-8?B?UFU1U0NhNG5kUldXbGxPT0lObVN5Mm9va1NzZVJwaHcwU0Vid3RLTEh3VlRi?=
 =?utf-8?B?Wkh0Tm1mNDlwWEZBZjVBbStDQXo4RnpTdlFjR2tiWjUwd1c4MVRZNGh5UDNt?=
 =?utf-8?B?d04zdVBLcDFoYjl6WHptZkgwckx0WlRMUU40MEliZDF3QkZFc3NhejUrdGY1?=
 =?utf-8?B?eGRnMDIybm9HcTJad1hKTmtCbFM5R3p4dmQ4SkI1TG11K2QzOFU5bm9GQVhK?=
 =?utf-8?B?R0VlZmtxUjh4bDdUZkF0N2NoU3FPUkk4K0pNb1pTdnlQVFVJRnYyM2o4dFJo?=
 =?utf-8?B?SkZ3VVhWTHNJSlZGbE5Fbm5OSW54TEU3aU9JZElyVi80NWoyaUFqNjMzWTB2?=
 =?utf-8?B?Y0N0SCtWRG5FaWlhY1U4V29lYlpEVk5RRCtjS085QmtLeHd3ejZwaVB1eUlp?=
 =?utf-8?B?SWFOd0R1RE03VGtZVitrNEgxZmxiUU13YysyREU5YmVLZkJOL0cvblpHVWlr?=
 =?utf-8?B?ejRsbWxvSVVqUk5Xa1htQnU5aVJQM2R1V0I4Q2R6V0ttYURLUkVSaXJjSzNy?=
 =?utf-8?B?QTQzS3pqR2UybHNJd1NidWFmemhDRjRsY3VuWG43enF2WnFRWWhzcXJHRWxJ?=
 =?utf-8?B?UU4yUld5TkRuNHlXZkV5ckZNZ0F3RVArR3c1T1A0UGN3bTQvajJ1cWdRbW9H?=
 =?utf-8?B?UVV2b3E5YkM2MXZETUtYbnRZQTdtNDhnRGtMSno3blZScjEzVVg1THlEOGgw?=
 =?utf-8?B?TWZ5NXBUWU9BSmZ6YldrSDZ4VHZ1MnBML01VajlFSmpSQUhVR0JBdklqVHhh?=
 =?utf-8?B?V1RZKzdZSmpYMFM4RzlnNGxER1VmUEliLzJmc0o2dEV6Y0diQkpneEFhRlAv?=
 =?utf-8?B?SCt3MXBKT1NsdTNHNVRWOTBLVmQzNWtxSnZWbTdTVmh3dFErUDdmSzJsNUk0?=
 =?utf-8?B?UnBhWTRIdHZkWXdCSS9FYXNiOVJEL21QWnBnQTRzaWx2RlUzdWRmUW85UTdW?=
 =?utf-8?B?YktjUURKNGRYZXJrQ0FSZHdyUytGVzV0T3R3TlZxZGNteWF6dTJLTUJWOVRr?=
 =?utf-8?B?b2Y1NW5JcjZ6V2VXM2hhemRmM1ZwNlFNR3FTVXl4NWI1OVlpQ29RM1V4cDZ3?=
 =?utf-8?B?NVFHYWpUTEdzZ0xqYUhaVnFtWnFDamFaeElpODlFYTdNejJYMnAwRE9uVnpG?=
 =?utf-8?B?MVlxSUdlejg2NzZOdTdTODNwN25rVXZsVld0MEZZbmdaR1hLdFg2dm5mQ2li?=
 =?utf-8?B?dGZtVmxqWkdtcVNMZXlHeEJTbFpJNEkyRnpLU3MzTmxLZENma241amJCekJX?=
 =?utf-8?B?MWY5UmplVm1FV0dpU0pJWVQ5WGFPUnpVb3MrcXZDZUE2dmJoY3N0Q01uUXoy?=
 =?utf-8?B?UmkwZXlIVjZxQ3FHMjFTMlFuQ1ltUlZXNVdJSnpaOUwvOFdwNTAwRnhkd3BH?=
 =?utf-8?B?bmNSbFVvcWswVzgwWWw1YVd5QVBHZmVMQThWMWt1aTNmeU9MSi90YWhzSkx1?=
 =?utf-8?B?YkY5WFV2eFpOOFh6ZldsbHBoSDgxTHB0bmVhbHU5ZTl0ZW5jSUxiSFgzYkJl?=
 =?utf-8?B?SVh5RE1za2R1RnczSjZSRDE5Nm85STdVaVNUMnlrSnl4L0RSSmdjcnRKSHlo?=
 =?utf-8?B?YTd4YnRDY0g0TWdoenNZN01pK3cxdXRkMUZxMXdOd240L25DbTRESm9EZEhH?=
 =?utf-8?B?cmxjR1MrZU5ZeWRGUlA1TzlQaUZVUmNKUnFPYk9vZ1B0WkhaVnJCd1UrTTRK?=
 =?utf-8?B?WTdwa2daU1dyUi9mbCtZeHdrTXQ3TDZuWEJhdVJyWFlCMTJqRE5QRDJWbE9o?=
 =?utf-8?B?UEZhWE5MMU5LM00yTWcvTERqeXlmMzdERGFqOUtsdk1wMWlMYk5ESnRZUG8v?=
 =?utf-8?B?NlI3c0xjeVp0ZWtaMUdBVHNQUzBuYWxETDh0MzBOb2ZKYWJDQ1crZEVtWi9u?=
 =?utf-8?Q?DL869PcBcZgG9u05zK/wDFjLG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf65cc9-828a-40a4-09bb-08ddf5bbb332
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:27:47.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lde3ke4iQjhFvML9BzBKSk2xO7Je+9+QWihfQn2+9hmMxAe+TnS4Kgds+7Bodn2isJ6bATfTzitsBQqWHykB1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10800

flexspi define four mode for sample clock source selection.
Here is the list of modes:
mode 0: Dummy Read strobe generated by FlexSPI Controller and loopback
        internally
mode 1: Dummy Read strobe generated by FlexSPI Controller and loopback
        from DQS pad
mode 2: Reserved
mode 3: Flash provided Read strobe and input from DQS pad

In default, flexspi use mode 0 after reset. And for DTR mode, flexspi
only support 8D-8D-8D mode. For 8D-8D-8D mode, IC suggest to use mode 3,
otherwise read always get incorrect data.

For DTR mode, flexspi will automatically div 2 of the root clock
and output to device. the formula is:
    device_clock = root_clock / (is_dtr ? 2 : 1)
So correct the clock rate setting for DTR mode to get the max
performance.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 56 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index bd61f951d6befdb78cdd84d4531aab378a47c56f..d25679fafad7a94a7ea2a79d7e3da53f4939c9fa 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -399,7 +399,8 @@ struct nxp_fspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
-#define FSPI_NEED_INIT		(1 << 0)
+#define FSPI_NEED_INIT		BIT(0)
+#define FSPI_DTR_MODE		BIT(1)
 	int flags;
 };
 
@@ -655,6 +656,40 @@ static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 	return;
 }
 
+/*
+ * Sample Clock source selection for Flash Reading
+ * Four modes defined by fspi:
+ * mode 0: Dummy Read strobe generated by FlexSPI Controller
+ *         and loopback internally
+ * mode 1: Dummy Read strobe generated by FlexSPI Controller
+ *         and loopback from DQS pad
+ * mode 2: Reserved
+ * mode 3: Flash provided Read strobe and input from DQS pad
+ *
+ * fspi default use mode 0 after reset
+ */
+static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
+						 bool op_is_dtr)
+{
+	u32 reg;
+
+	/*
+	 * For 8D-8D-8D mode, need to use mode 3 (Flash provided Read
+	 * strobe and input from DQS pad), otherwise read operaton may
+	 * meet issue.
+	 * This mode require flash device connect the DQS pad on board.
+	 * For other modes, still use mode 0, keep align with before.
+	 * spi_nor_suspend will disable 8D-8D-8D mode, also need to
+	 * change the mode back to mode 0.
+	 */
+	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+	if (op_is_dtr)
+		reg |= FSPI_MCR0_RXCLKSRC(3);
+	else	/*select mode 0 */
+		reg &= ~FSPI_MCR0_RXCLKSRC(3);
+	fspi_writel(f, reg, f->iobase + FSPI_MCR0);
+}
+
 static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 {
 	int ret;
@@ -736,15 +771,18 @@ static void nxp_fspi_dll_override(struct nxp_fspi *f)
 static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 				const struct spi_mem_op *op)
 {
+	/* flexspi only support one DTR mode: 8D-8D-8D */
+	bool op_is_dtr = op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr;
 	unsigned long rate = op->max_freq;
 	int ret;
 	uint64_t size_kb;
 
 	/*
 	 * Return, if previously selected target device is same as current
-	 * requested target device.
+	 * requested target device. Also the DTR or STR mode do not change.
 	 */
-	if (f->selected == spi_get_chipselect(spi, 0))
+	if ((f->selected == spi_get_chipselect(spi, 0)) &&
+	    (!!(f->flags & FSPI_DTR_MODE) == op_is_dtr))
 		return;
 
 	/* Reset FLSHxxCR0 registers */
@@ -761,6 +799,18 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 
 	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
 
+	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
+
+	if (op_is_dtr) {
+		f->flags |= FSPI_DTR_MODE;
+		/* For DTR mode, flexspi will default div 2 and output to device.
+		 * so here to config the root clock to 2 * device rate.
+		 */
+		rate = rate * 2;
+	} else {
+		f->flags &= ~FSPI_DTR_MODE;
+	}
+
 	nxp_fspi_clk_disable_unprep(f);
 
 	ret = clk_set_rate(f->clk, rate);

-- 
2.34.1


