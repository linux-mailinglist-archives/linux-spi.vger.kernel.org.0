Return-Path: <linux-spi+bounces-7719-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC20A97ED5
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 08:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF6A16118C
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A9F266F0D;
	Wed, 23 Apr 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P9agtV0X"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EF266592;
	Wed, 23 Apr 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388633; cv=fail; b=fkAc7CYIg0xBp3h9+N3k0JNTjBMItGaxdCKv4m3jGsY1AqZm3lbkjpxrsAob2Otpn/cpORYlQytPnWhvo2yKx/mU97UkpuHT2HJe7EgxlwBkhSYBDICz76Z+Rpe67+99MyHl+EamQj+1qtOsw/RX11ce/Evx7l9z3EB7QCoYCz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388633; c=relaxed/simple;
	bh=R+E0blCnr84VOgWVUzaNmlI5G0tHD3+mnj0wlyBAGLc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b9/7yS6Q3YuAQN4colG8FcUG9R50uhintfZn/ZUNxTNn3SCWYjCe0QlMWmPHe3yIvISiWBl/ETT8gXUBDV/hyvYp+h3Vz+9WiJUdlfsje0dnusdwmcPmMNweMGkex1tKF9mH93QO9KbFqNjjGJFT7/GvgpZeGv8gd5Gud1E12zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P9agtV0X; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fa/t43VL5ad01SkXpKzwxi/tgKGHYtR3zHREALLui495Owpa/72uVhSqXDIQDiu6kw0AdMN9+oL5hbNaQlNu9FFdvahMQUFsvEwAWrcfacke9lUmcd5F9OHwJeVFMwXdSY3XL4XW1lAGuRBRFCusbMtg4eSFdFJwvJuKUduNYe5Lr0oeGkHvzSDquntHVx6M0kNPkvMRn1T0dSVJLFm/DCA5I076MYzZAMMV9jVvMqzWRvIrRR5hCh8EGeL/gQFcIePMDhINT8WxQ6K5EssYDRArjqphBjW5CuOhFS43GOOOPPs7E9t7rLCMPJyhJgmxIHC0a+UoDwjPZp/anFLPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkoc45T7BYUh7B6StD6VS++pbiV1SAITGBvZZWupjxI=;
 b=Y02S8rlBWBWd96JNvkoWJWtkEdKZMHmyH/xAaK13cS3T/oon19+KVhuh8T6nMiZHEktCAEpYB/ul1QiR37lL3tBIEUEUQFZmi1f5PGQjO5buEt98AXv1HuXz4J/6s/KTNPExtG7gCLrxwqp1OowzDxIbIg0sHLghvDW6b0x7HAQdiXCnZcbZ+YuB2pLiZu8JNpdKLVa8Rg+M7MpP2AaG9CiyziosjDyez5ktp2ypl4EhjKCZAdvl5dtHVd60QmPYryWbUF8Ysq8JchZxwdtewoXwf51QpLPSD0Ty+O0CeJyklRe6xiTCwQwVeDyuwaf/gVadBlXTapoBMRtU/+DIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkoc45T7BYUh7B6StD6VS++pbiV1SAITGBvZZWupjxI=;
 b=P9agtV0XxQ9S5sKMD8qLqLze43aAhSNVtmp/+uCgFbJqs9gt3ZRY9LmWd2nJd5I6Xrxmlb6l2GT51zKfmOjqrPQsWVQYKOggiNXW9H6y15s2A+uh8UbnGJ16xjQ57nGOBmj5veqm+t0LuW9Ut3kaCegMBRO8GM2h5yLE/x6lMlzqWNe750N9K+o7UPbT4XkXa3xSwcMd3OoPg/IOfd/jFV+75yOn1RdMBnpnD7VVUI4ENsZ4YG7YBMOfRhtDkMzq9X2NCkQBXJTFwuOj4UFf4ucLW0HDO51m1d4uzD7177ftM/UGct3RdG26fsbkNTx9m1WDNwbc91p76tLQCEk/BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:10:28 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 06:10:27 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 23 Apr 2025 14:11:38 +0800
Subject: [PATCH v1 1/5] spi: spi-nxp-fspi: remove the goto in probe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-flexspipatch-v1-1-292e530509d3@nxp.com>
References: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
In-Reply-To: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745388747; l=4520;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=R+E0blCnr84VOgWVUzaNmlI5G0tHD3+mnj0wlyBAGLc=;
 b=QD7wQJRRqPHqXnIMDoMZ+QFi5bqroDqpQ1Li+UzTf+Mpxvr+07BEzhaadK9WMKOVz3iKk7++T
 NBNxO8+sPpDBoXtSXvvyXP6K4faAXp0wFMcwHnLBrMm6/EI/Z6Hb3sd
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
X-MS-Office365-Filtering-Correlation-Id: 975c4043-8f28-4678-8658-08dd822d8b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTBnUm5mY2Nid253RmRXaTZHUXhiamdCUUl0cVkzNkFxTXpaR29mcVl0azJG?=
 =?utf-8?B?S0hrNnBSTWV0OUdjUUgrVSs4ejVaQ1dUd20yaDhlZkRsczEzemE1UDVzQWZU?=
 =?utf-8?B?dXluMnZjdDBQMHJjc1V3dG1BaXlXMitkdzg4QXU4UWU4b2QvYkZBWkRIM3Bv?=
 =?utf-8?B?bmVqRFlnUWVyQ3Zyb2hpS3A3SWdVYnFFbGpHYXFOb2ZVTmxLbTZhVC83ZThG?=
 =?utf-8?B?WWxEc3JkZHlsWDljdGVHZE92dEtrckZmdzMwZVJDdklQaEg2Sm11M2t5OWFH?=
 =?utf-8?B?bFVoYkMrZmFvUnVFcm13THRzQ21LTDA0NFkzNld5dlRhUnUzejE3eE1YZUxk?=
 =?utf-8?B?bnVpOHNZLzNhaGg0WFFLeXRGUUtFcWRPdW11OWN1TnZhL0s1aEw1T3hLSUlO?=
 =?utf-8?B?OU14OFlQK0tQZ2VPeHh4QWxLaHhYWmlSNTZ4T2t6ZlpQU1hxUW5EcmhJZU1S?=
 =?utf-8?B?Y0tmWjMyb1dHZHUyTjZwNTZrd3lxa3JBYXltd0JiT3QwakppeVJFSkNJWUMz?=
 =?utf-8?B?eUxldklzM01INk1CeUJ4VktET2pzeXJXbjhBVmQxM3RKbjRUQklBYXp6aUY1?=
 =?utf-8?B?U0JLNnVYdWIvbnRzNjcwbkE4T3RBREp2MjArdW1QemVGZlh6elJidk15R2kz?=
 =?utf-8?B?TXRuUG9adXF3TGJyL0pKODR3Q2lLLzYvL0R2WFI2c3duTnc0dVVDc0tsZ3kr?=
 =?utf-8?B?dUx2RFJsaEdCeDZabnVmU0RTL283ZGdwNVRKMGFkRVowZjIzSDI5NzVwNjJZ?=
 =?utf-8?B?T0UvaWFqcEF1cktqVVJkcXloeXJqSDNNQm5ZRllLbWw0RlpFWFBZNGlIcVRP?=
 =?utf-8?B?ekYvOXlqR3h3bk9WTHlwN2VuaC80RU9mK3JMT1JDUmVzeFFsY1A3Z0RNaFlq?=
 =?utf-8?B?VGFRcnJvZW1VbkJMeHhKdnowZWNHNW1peFNmUnBwY29Ha24va2NhRDNoODlW?=
 =?utf-8?B?N2JUMmxlNDlEVDVUN2lLc0dzd2sxQ3pOUGY5WGE1V0orYllkY3FhSHozc0Z0?=
 =?utf-8?B?cVhsWFVJTlpQM3BoL1FrWmRsVWNIdC9DT2lTejFTTENmTXJ0ZHkwT3BTVmNH?=
 =?utf-8?B?c2F3eFlPWGZpaUYwU0FHNlRuM0VacjhyL2RvdzA1RnhRVndtd0FEcXlVNFNr?=
 =?utf-8?B?V0ZVZ21RMkZCWHU4SkU0MGNsQ0JGd2dBRzdOV1EzSU0zTUR2dWJZSDFJclVp?=
 =?utf-8?B?YzJ4eHdDUjJQblpNRnc5eTBDVmtiNi9IanYwUDIwWDd1anh6Zi8yZGRNbkNq?=
 =?utf-8?B?cUJacTg5S3QvNzJ6VTNNbklRQW5JZ1pKY09KdTNIZVpRVUpNSlZjVnhqMlNM?=
 =?utf-8?B?NitDSDJyK2NYblJVdkp0YjFyK3lUUFFLTlN3TlZWcjRpQzNJSTdxa2tIVW5E?=
 =?utf-8?B?VVJiTWswUEJiMzRQNFcwSGJWcWNDamhSM3IyZHdHN1YvWlZPYkQyaUNHQWt3?=
 =?utf-8?B?UERoNFhqaHpOejFwQ0pMVjFLWVp3VnV1cHFHSjhIb3ZVV2F1MXNZL2RrYUNP?=
 =?utf-8?B?cXZiRUl6TlBhQmpaWGZMa2pEN1BQN2w3YllnWlVOYkNlOVE2cURJL0Zza2Zo?=
 =?utf-8?B?eVVNUWMzdkszc04yMnQ3VmdBMm0zRSt2ZmllRWxCWDBuQnJjUmZlZ2Y1SGMz?=
 =?utf-8?B?OXRPeHZ1aFhsdzlUSmsxdzQya2FiUHdqR0VLdHc3NUQxSTdoaE5KQjlvSXNO?=
 =?utf-8?B?eklqUGtZTHI4WCs0S0x5QzV3bFRXRDRZek5DVllObkRvSFJxOUg1TlF5N2Y2?=
 =?utf-8?B?M3VoeWNjQ29TcnlIbFo0eVdLZGNSa1hvR0ZOK1VjOUlDYnE5ZkhSNG9PdEJl?=
 =?utf-8?B?S1V2ajd3VlhneHBZclRWbGVUK3FXMUtXd3BnOHorUmNORUhFTDhxM2RHVFo4?=
 =?utf-8?B?MitnZ24yMWNmNGYzN0twMjNPaHU3MzI3WkMxQXVEdEN3ZmcxTzEwRmlMYUts?=
 =?utf-8?B?VjQ3M2ZFUHlibHFqRzBJSithWnlPZ3NoL0gyQWdJMHNBRUFSYm4vQzNIWGEx?=
 =?utf-8?Q?/R/+l79kk0q/yMoXvOmvVwbgcXn/II=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS9SQlFIbmRNWGdVNWFlMGk0VTlEQXZocWtmVFUzenVhamFGUXc2eTJwd2d5?=
 =?utf-8?B?WEVEUkRWMk9ubTRzdDhSZXdEa2pyL045YTJjYlEzK0pYaUVCeXA2Ukx4QXh0?=
 =?utf-8?B?Qkh3SGZaS01Rc1FDMWNYaVJCaWdzeXA2bXpTVlJWQnRlYXZWYmdkR2hXUklE?=
 =?utf-8?B?NDU0UXhNN3JYdUV1THBzS2NiTjczd3RSdVFmV3c3QTJGam5FOExtZHFOY3p6?=
 =?utf-8?B?QURjOFlxVGdzV1l1LzVQWEtkKzFUUXlha1NjZWtwYlR1SlpzVGppL2gvMHJw?=
 =?utf-8?B?Ulh1ZThub3cydnk2aCtpWEJyT1paMFZ1ejlXTElyWE9BSHZyc0pFaWpJUFJQ?=
 =?utf-8?B?TmxVZDFNeGYzdHJUOHdyaFhHbzRsbkFVWFFqV0l5eFNiM3pRTDVPeHJwRnFM?=
 =?utf-8?B?NHdyZUd4NmFrNzNPeFk5d21iTUkxVDNwakUraXJwanpYV2l2dFVhMS9xRmhs?=
 =?utf-8?B?M1dvV1FnR0REdFh0Zkhmd1FPLzNhMWdISHZ6bTVNTnI1MTFPTHJvVnA2RFg0?=
 =?utf-8?B?b3hoZ25BeVZBL01lcFVvb1NZY2hzL3ZmTEFCL1hnRncrcnFDT2kyTjVqMDBM?=
 =?utf-8?B?RFdqcmFkUmdkcGJyMWtpYnNTVmJuTUtRQXFWWDUzM29ua3QrZkMxcUV0bEFP?=
 =?utf-8?B?R0d3VkljU2NQbTU2UzR4dlJrTzlXUFY0MUZZMnZiR2NqZlBDVlJ3dmVXRlpp?=
 =?utf-8?B?TnVnTGljRmtxR0RmSlVrQXg2UStGWSs4VFhocmNTTnBDdUFkbU90UVM2dmNs?=
 =?utf-8?B?NTBISXFRdGlZQVdBT1Y5N1B1Y2NPS29qdXMrMG84NmJKUjdwZVkzc3ZxRUs0?=
 =?utf-8?B?b2RGR3psVldHSExhUkpUUjJBSlpGdDNuOGZXNCtxTGI0andZNHZNSnZFcjZz?=
 =?utf-8?B?RHU3aDVPOUxUbVZkc0c2RFNQSDBzcWJXMmdhc0hrZ1cyWG9iZWthYmwwaHFB?=
 =?utf-8?B?SXROakxmSUN4UlpMNk1VZTBrV2JKYmdjYmdCM3lTVEtYZ2lON0ZQclVOd0xZ?=
 =?utf-8?B?aVdkRmxBL2d1Tm5ncFpmUnVOdmNLd3ZKWjVxSXd1WU1xeHozRmZzSGRkbkgr?=
 =?utf-8?B?YnNYMXpvRDgwR2RYTTltcDY1ZWU1UFBuYmVzUXZBbWRkN1I5YmlDcGFPOXU4?=
 =?utf-8?B?TG0rV1RsbTlrNklZWEJNaWlyc0ZOaFQwSlBGM1Q4MlJUZjFMRTMzeXRZWWsx?=
 =?utf-8?B?aERWZDdiMCsvQ3o4eHZWWGN3Z1Y4a0ZGQ3BlanBDdXJnemRNWjE4NWoxTVR3?=
 =?utf-8?B?OFFQTno2NytuQ3RQaVFaWFpQV05Vc2JXajB5K1pQeFNPZEh6V2Y5ZEFHNURQ?=
 =?utf-8?B?UWpqdk9sZG94emZjdmtpZE5VNVRGeVZCSGJ5MDRCSjVLODZSaGVqVFAxN0NW?=
 =?utf-8?B?MXdXN0ovTHZYTWcvaTN4ZE5UZjVVYWZWK2VOcXpHY2pyek9FTnQzTktNOGEz?=
 =?utf-8?B?Y2pmaFRSYkZmb0tXclNJOUhrUndSdU51b0hZM0NpRDQzRTZSczFZdWliNnEv?=
 =?utf-8?B?WFFHdjEvY3R5Zk5GM2dqVHVITUFVeDV3eWFkejUrN0NlRlJpaWNvS2N5c1Nx?=
 =?utf-8?B?ck0zcFZSN0tDRXdlRHBHVU4zdGx0cVErc3d5Q2JvMVU1VktUVGdsMnlFd1ky?=
 =?utf-8?B?U3FTbnZBOGJkK3I5WDhyYUg0Rm9qSXhwYmtSZlFheDArbGV5RUFxV1JyL2xL?=
 =?utf-8?B?Vm9UQUVYanVmM1pNcUlSUm1YT0k0Yy9TTFFDRjJnNzNOWndCbEhWMTh6aHNM?=
 =?utf-8?B?K3U2MVpDSmxlblF1RTVSbHhnNkk4V25wc0lyeDVrakZGSlA2ejY4dXkrUHZP?=
 =?utf-8?B?RGszUDZRc1BRQ2NVUHhueFc4N1NzelF3clJJc1dkM1BjbGFiODIzQ3o1dE1C?=
 =?utf-8?B?TnVwTmUwNktPNzVuQjh2b3VuREhvbVp2bnMzQmhMdlBhMjlpSExtTndmcEtK?=
 =?utf-8?B?dUJPdW0rQ0RtMG9nNG1KUVhlZGxrdVh5eHp5UnlIOXdhNTBna2Q2eXNXMjg1?=
 =?utf-8?B?cjgrUzdubGpSMjlRSXliTlUyWEhmcWZONXJxK1lhUTFzZURhYWQ3VGQ3bmRB?=
 =?utf-8?B?VWYrUjdWOGZPVklHVVVlMDdjZERBMWM5eXV4THdnUmlYVzZIRzRkZ0JsV1ZQ?=
 =?utf-8?Q?c6JMZPpgEym6AAPGqCabkjg1D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975c4043-8f28-4678-8658-08dd822d8b19
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:10:27.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpAkhPblBrz494UB9Vz/BdHcbGXn4c9cRt1X0+++of8oDstkPBsIhy9d9ROAlKWvkzSStKBfeQWG15p7FD6sDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734

Remove all the goto in probe to simplify the driver.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 87 ++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index bad6b30bab0ecb90d0aaf603b6de5bc834d19de6..00da184be88a026bf562c9808e18e2335a0959e9 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1161,10 +1161,10 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct resource *res;
 	struct nxp_fspi *f;
-	int ret;
+	int ret, irq;
 	u32 reg;
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(*f));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*f));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1174,10 +1174,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
 	f->devtype_data = (struct nxp_fspi_devtype_data *)device_get_match_data(dev);
-	if (!f->devtype_data) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
-	}
+	if (!f->devtype_data)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, f);
 
@@ -1186,11 +1184,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		f->iobase = devm_platform_ioremap_resource(pdev, 0);
 	else
 		f->iobase = devm_platform_ioremap_resource_byname(pdev, "fspi_base");
-
-	if (IS_ERR(f->iobase)) {
-		ret = PTR_ERR(f->iobase);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(f->iobase))
+		return PTR_ERR(f->iobase);
 
 	/* find the resources - controller memory mapped space */
 	if (is_acpi_node(dev_fwnode(f->dev)))
@@ -1198,11 +1193,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	else
 		res = platform_get_resource_byname(pdev,
 				IORESOURCE_MEM, "fspi_mmap");
-
-	if (!res) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
-	}
+	if (!res)
+		return -ENODEV;
 
 	/* assign memory mapped starting address and mapped size. */
 	f->memmap_phy = res->start;
@@ -1211,69 +1203,46 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	/* find the clocks */
 	if (dev_of_node(&pdev->dev)) {
 		f->clk_en = devm_clk_get(dev, "fspi_en");
-		if (IS_ERR(f->clk_en)) {
-			ret = PTR_ERR(f->clk_en);
-			goto err_put_ctrl;
-		}
+		if (IS_ERR(f->clk_en))
+			return PTR_ERR(f->clk_en);
 
 		f->clk = devm_clk_get(dev, "fspi");
-		if (IS_ERR(f->clk)) {
-			ret = PTR_ERR(f->clk);
-			goto err_put_ctrl;
-		}
-
-		ret = nxp_fspi_clk_prep_enable(f);
-		if (ret) {
-			dev_err(dev, "can not enable the clock\n");
-			goto err_put_ctrl;
-		}
+		if (IS_ERR(f->clk))
+			return PTR_ERR(f->clk);
 	}
 
+	/* find the irq */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get irq source");
+
+	ret = nxp_fspi_clk_prep_enable(f);
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't enable the clock\n");
+
 	/* Clear potential interrupts */
 	reg = fspi_readl(f, f->iobase + FSPI_INTR);
 	if (reg)
 		fspi_writel(f, reg, f->iobase + FSPI_INTR);
 
-	/* find the irq */
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		goto err_disable_clk;
+	nxp_fspi_default_setup(f);
 
-	ret = devm_request_irq(dev, ret,
+	ret = devm_request_irq(dev, irq,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
 	if (ret) {
-		dev_err(dev, "failed to request irq: %d\n", ret);
-		goto err_disable_clk;
+		nxp_fspi_clk_disable_unprep(f);
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
 	}
 
-	mutex_init(&f->lock);
+	devm_mutex_init(dev, &f->lock);
 
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
 	ctlr->mem_caps = &nxp_fspi_mem_caps;
-
-	nxp_fspi_default_setup(f);
-
 	ctlr->dev.of_node = np;
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret)
-		goto err_destroy_mutex;
-
-	return 0;
-
-err_destroy_mutex:
-	mutex_destroy(&f->lock);
-
-err_disable_clk:
-	nxp_fspi_clk_disable_unprep(f);
-
-err_put_ctrl:
-	spi_controller_put(ctlr);
-
-	dev_err(dev, "NXP FSPI probe failed\n");
-	return ret;
+	return devm_spi_register_controller(&pdev->dev, ctlr);
 }
 
 static void nxp_fspi_remove(struct platform_device *pdev)
@@ -1285,8 +1254,6 @@ static void nxp_fspi_remove(struct platform_device *pdev)
 
 	nxp_fspi_clk_disable_unprep(f);
 
-	mutex_destroy(&f->lock);
-
 	if (f->ahb_addr)
 		iounmap(f->ahb_addr);
 }

-- 
2.34.1


