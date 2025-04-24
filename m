Return-Path: <linux-spi+bounces-7731-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB85A9A441
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E747A85EE
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A50222592;
	Thu, 24 Apr 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmClFXHt"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155222256A;
	Thu, 24 Apr 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479929; cv=fail; b=m4VrX7mkxrQunkkNJ2ewtalBpCy/DCrdMeb/9mpyE6I3jYQMNf5QE1aELxaUD9JfdIsb1NJ/vc50AAlGiwTzISgocoUkXHR/1fuYYtB12BY/g/XfhvteWIN50qQqiC9wI62gapc0fV+91ErP+C7QwPKm7lR088Gl3TAjMFlr/Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479929; c=relaxed/simple;
	bh=OI4iSGXxyD09ySKPaTnSNkXPT4xN/jGSL4XikQ038Tg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OEDmLTh5mSlmyh9dQBPsNcu6sjOCZfi1cgD7JB6ddxhM/NbEZkAzFrlMpju92IolQnciRtuR6oBnW0qOfTBQefYzmJyP7rAjEAg6xh6x6qsTbsNcB3xCYY1/5zMC58c0KOTSltKifaE945dQ/u8S831n0KW0H/IJVbLUiRJeztE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jmClFXHt; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNum3iNGKL94Aa3Vr5xbRJJ6vE2lpt+aEG09wMcTKWvgLKV52xjLGbFLl3Pn7oQuicopPipQzqWOYT6ZcCKD1NuTyyi1wnJnjuU5zzuxxHoNxuIG8wTIwVkDwE8LHzUyhFoc3uWtmPnDUfYvrfPlkbtsxyF1a+DOOqjChq8Q+12J1vCbna6sMwCeOw/6hMW9ngVyzGG5Wv4DDSZOxwmQlNbZBfemF3TTQaT+Xu8hRMSsJGkCsPnj8ZKzv8GALnxRd9/KJen7LsbY5xB9hiKTEkBVew3GtZauOh06pDlvzmUStBb9yAOnb4wluD9lPq8KaUdpGgMUBW7Loj6FmZ4x8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liHQmwLVebmz6tdOh1EehsH6ZtR+3rvjh9GQwIhvxos=;
 b=IWQu7SA5aT2IboOWiNBW1B46qvoWioL421WCWOTKqBIkqNmaga+28OAampprmEfESwuhTZw0cwXu/76hqBb6dGT3Gp/QuwD9AutzL1B0K1itTuxMwYM3WgekpXUyIIdkzLEBPN2jDrrrtokyX+JduNIcMfwImB4l5lWkCZ0DhVDQFo0NQ4/IjhK7/xC61FBs7q0SafX4dZ5iRAWVHvtedvUk91AYjd2wvgU3+C7oAQAvuncIZlbcombArsPLif0X77/SFSY1fXgpihjg+ulRUBzenVsc3J0aYADEA0xpIoI8CwFfUCkZmsgLjzK05XJAgZvRRR5KdzRCpwCji0Pfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liHQmwLVebmz6tdOh1EehsH6ZtR+3rvjh9GQwIhvxos=;
 b=jmClFXHtIecKuQpktA47xvhpL5jAQtXE4WEZMlKi9dlfsaKz8G3lKC3f2KX4Yh5nFs0l4AHWEoQ12U/nD3/H+rD8ayo2ar83GRczTP5gbWgPqO1+uwSGB+laj6n2Dr8RGIM46u6O3JfHIvRIwv4fKOKo+MbX/cDshbROiTt2vmE6Uf7qJhXd8vB3fJ9If4Eq2YXKS5MYfxWV5GKhO31mBnHogyWzGQoHsaQPV2zDUIEsD7ADfxolqZjHq1MjJG7ALsYZ+OW+vjzk577TCSECxVOBkrG/sTlW/x4eDEAA15SgSFbh4/ZCN5UZBm0jK/g2l2O8Pf34VztLJnZS40emQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:32:04 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:32:04 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Thu, 24 Apr 2025 15:33:26 +0800
Subject: [PATCH v2 2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-flexspipatch-v2-2-e9eb643e2286@nxp.com>
References: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
In-Reply-To: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745480038; l=5768;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=OI4iSGXxyD09ySKPaTnSNkXPT4xN/jGSL4XikQ038Tg=;
 b=BusK+8s7WH2wxjAPfZ66YvTu6soiMc/s9g4inZMg3Dc3FarF/DhUeBZKMVf85El3tsqHyKTic
 K5nu/SgFP0qAmvc/GPgAOgZ2jTZL30iE+0ABTirD85ON935Kwbhvkjm
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI2PR04MB10594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b86aafd-4598-4501-1f45-08dd83021ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjVRUnZxYm81cTJDYk5hOEprS0hrM0oybGJDdVIyWFlWR3JLNm1KQTNmZlU4?=
 =?utf-8?B?WDVEVW1qSWkxS01IQXJsYUxTSnRiTWt3cGtvZ3JremNsRU1FdlZmN3dLUjNt?=
 =?utf-8?B?cTdYd3RVeEp2UGpQd0NDTDFNZjlWd3Z2MS90bnUzWnoreVlVcVF4RWJhZ2VL?=
 =?utf-8?B?VGQwa0JnVmpFYjlkd3lxbWc1d0ZkR051VG5vRStJaW1oZmxYc1VOSFJRYzZj?=
 =?utf-8?B?bnRQaUlKdjZXSFcrcUNzcW9UdzlDRVNjazBoMlV2WCtzMWVMZ3ZGRHB6K1hu?=
 =?utf-8?B?MG9FTG16anNVc20yQWhvS3hpbTBlSEZnZnYyeFU1YzNyY1RkdHBqcDZpRHhM?=
 =?utf-8?B?aUVqZE52V2Y2MjVHVVFoZmV1d2JvMlVYYUJBNUdtSDRDejcwUTdQVGlrSTky?=
 =?utf-8?B?S1RyTFZRanJUVGhRY3pIY3B1dWJqUWZkbDFuZ3NkYUNMOFFvR3VyWGR5TTBH?=
 =?utf-8?B?ZHBORE8rWlpkbEJuQ1VaaGxmdi9QK1J6dk1qZTRwYnArcit1S2RSOGRneG5P?=
 =?utf-8?B?bEN0Zjk2U0M5L0FlWnE3Q3pWbndLZmlJUE4zUUpvSDJIdDRJRUdCS21EemJR?=
 =?utf-8?B?M2FJS1c3NzljcHRPNklCRGppUWF3MWE3ZWJxUDBsMEsvRG1heVNySGRaRTBW?=
 =?utf-8?B?eUZYTVNJVGpNOFJoazRtQzhkUTdkTnVpTG16MktpNDhLaEZmNkRVWmpNc1BW?=
 =?utf-8?B?alFmbnlqUHU1MEpnaWVtbWpzR0RjdUJPbWJDUXFObjU4RUFBNWZBczkraURq?=
 =?utf-8?B?dG5oNXU3TTJCMmVocUswaTZ0aWJXeGF1VjlGUlFOUCtsNW9MSHRBVUVkSS9l?=
 =?utf-8?B?SXNTWjhCNm9ySFMvUE4yUHFJTjgxODdkOGZBUmduYndnUEtnaEFpYW9GRVZN?=
 =?utf-8?B?MkVNUHZyQkVUenBJN3J3SGFVR1NQTWpPWHJBSVFGV2FxYUthcHVma2duTGU0?=
 =?utf-8?B?ZWVQVkxjcWZ1d2V0aGF5WGw0Ti9iQnF0N3BNMysxQ1g0OC9wbDhqNWMreEs4?=
 =?utf-8?B?K2tyNjVja3ZnUEVVQ3ZCSFVCaldEVWQ2cUxSM1ppUUFhWEFsMUZnUmRvdnRi?=
 =?utf-8?B?NnZhUS9zME5lN2F3eHF5TkhCak5mTk5ORFZwVXNFNS94Z09WTWQyczUrUlph?=
 =?utf-8?B?UGMzKzFTcWR3dWNxdTZ0dnFQdDByUzQxeEwwMFlNTEVUQlJsNnZQUGZSWElX?=
 =?utf-8?B?N2s5aTNmUWUzZmRCTjEzZ1BjSE9WdVAzcEt5Mk94NFFMZ3ZvdWtRQ0RZTFpa?=
 =?utf-8?B?OStyV2NDYmhLUW1SQjRzNVVOQnRad2JMWlM1eU05byt1OVQwZVRPVU1pZXg5?=
 =?utf-8?B?cmFXaCtrRkZuV1h4Wm5Eb2g1YkNQU29wOGExcnhWQ2dQa3JzYlF4eG1TZ0xa?=
 =?utf-8?B?YkpNcnpYbktISGVpQmUvU0FIL3dJdno1L0VjUnUwL0dQMWo0TldyRlVzRmZG?=
 =?utf-8?B?YjdBcHRwTEdROGpURDFDbkMwd1ExajR6c1AyaVBGV3ZRZXJVUzE4bGFTLytz?=
 =?utf-8?B?RUZPSEwxTG9BM0cxck8vZkpwdUlJTmZ5VGJjRG5pRW5SRXdVSVNSemtrcGFK?=
 =?utf-8?B?dE8xVXJwLzlLcitwbk83eGhJa0FLU3ZqZmwrQnBZZFlsYnptRldISW9xNnpF?=
 =?utf-8?B?L2RXNHFaUzV6bitubjM4TUtscm1MeGo4ZTFkOEJHcFFqemZSVnpRQURISCtm?=
 =?utf-8?B?RndqNWRBd1FHM0JYdWxuaW1OK2Y1UURVUFNKQlFWbkJCUkJIR05RZHg4MlIx?=
 =?utf-8?B?OS9IODVRdnFGMWNUb2pFODVFMGtEQjVUaUxPUHAxOVFZeUpGS240SndtUWd4?=
 =?utf-8?B?ei9FZEZrK3RpVUtObW5meExQbzlPZjR4RVBIeEFGTkthQVR4NVNJR3FaNTIr?=
 =?utf-8?B?bnVsVDhKelpHdm54ZURYd0txZkluQStvOEtWSTgrM05lbjl4cFY3bnA0TjlJ?=
 =?utf-8?B?eklzZzA4Y3RSZUpFbnJXYSs5RHoxM2RuMHBHUnZkR0llcVUzZXVVWVQrbVdo?=
 =?utf-8?B?RERhck5udHVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1pRcGk0SFNOQnhoRXNkRHBsK2pZUU8vbUhDZnFhVXZ0aUpHYWp2TFJkVlZU?=
 =?utf-8?B?czJLTWRMZm9MV01IQVZpZ2hMZzV2d2FuNEozdkk1eTFhbDlBS0E1dGppMXo0?=
 =?utf-8?B?Z2NoOUhOZDJmVHlQOTM5ckdUcmw0VlkzZUljcXZYV1BPZ1JKVHIrNEM4RkJr?=
 =?utf-8?B?dGJvZXJrZHkyK2lsdXY1QmNWWWNKWWVnUm15dllsc3BJUzNtZlY5S1QySFFN?=
 =?utf-8?B?VHExUWpnQWNMNjVVdHozS1FmVkFrb01QcHNsek1XNXhpQTUwR3lVUlJZa0Fx?=
 =?utf-8?B?dndhUSsvRjd0cmt0MU9kNHFsNk1sblFnSnpPdDhhM1BrdHFRVXZ4N04vUVAz?=
 =?utf-8?B?bjNxTjBnSWR0WUluNGRORUp2aHBJL3pQSThhdjR4NGZ4VzFwRVd2Qm5MWVJu?=
 =?utf-8?B?WmRjWGo5S0llVnp5a2UyRUhFTmQ3czJpblF6emtBbWpqRnpUWWtzaElObUVk?=
 =?utf-8?B?QWRZQmthT2hhRzJSc3RPZFVvOEhmWUZFUW8zZWhRcXlZRUtscm93bWRIS203?=
 =?utf-8?B?Y254dVR2SGNablY3VW5DbVNDYVcxdVRZZ3VnNnZpZERDK0pyb3dkWXJqaXRO?=
 =?utf-8?B?a3pHSDNtVW12Z3dUT2lTSmZNMTNkcm5mTmt6YnNyUEFpS0RNRFYwSzYxaGN1?=
 =?utf-8?B?RVk5UFF0ZmhCUjF3K3pvZ0ZWYXlCT2QvU3lTdmZWNU05SHU2amtGZVFWRHg0?=
 =?utf-8?B?L0xSakFobE5sVHc3Uk96ZElIbTYrMHEvVUwvTUtReWRURi82cHNrMVpmVmFs?=
 =?utf-8?B?TkJkSEM2YjZjaHUrWWh0ZFZzREFlYnp6VkJLWTgyaXVIb0pneHovQnByb3d1?=
 =?utf-8?B?dGFLZGpLZHBiNmhVQ010Z3NpRTFRc1Q1S08wZVNNY0RTOFZuekZYaDRQdTN6?=
 =?utf-8?B?ZzJ3Tmt3OGphQjMrd242UlQ2a0E0aGkybzRyQjdaLzRBeGRBS2ppeEhhbUVB?=
 =?utf-8?B?dCt0ZWY2em92eWtWWk8zZmExQlh1U1ZCY2RMMWhGdHFWaWt6d0tFZWIyMG81?=
 =?utf-8?B?citYK0FGVXppV3NDY1k2ZjNaY00yK1VodHZHTWwvYVB0NCtlSmZESElQeUow?=
 =?utf-8?B?cGRlckpvTnZ0cGxQZ0lHc21DQlFPRDdBQW1KSzVGcmJ5NlM1aW1oZUtlVFBR?=
 =?utf-8?B?QWFjdzl3cDJvRnZYVjdpeFpYQmpsRHpqT3J5TVp6Rkk3K1cyUUNsU0RuckNN?=
 =?utf-8?B?WXQ3L0VqYW80YXVFWTVWUEVnclF1Znhkb0c0UFI0NHJTeXo2blN0Q1BwcnJB?=
 =?utf-8?B?M1czOXh4SnFkUFVDWnZHK0w4YmNZZnI5ZVNFYkIrb3ROVjRhcHBxU1l2d3hJ?=
 =?utf-8?B?cGpqSkY5SW1TQ20rSmtYSzdBZ00ydGFYME0rY2J6YlgrWk5IUjRxWU11WW55?=
 =?utf-8?B?QzlESUxOSkZGRHV2RkpNV29Jei80dTQzREJzU3AxN0M3QVgycC9JZURQOTZX?=
 =?utf-8?B?SmZjUHFEbFRaVTN0eUp2RzJETithT1dpWlVoTzVPQUZKNUYyMGs5cU12UVJr?=
 =?utf-8?B?ZGdObCtyQUk5amxkcW1qUEFnUytOYXJ2ZUt1QnhkSFUvWUUrVjQ1RElsblFI?=
 =?utf-8?B?c0dFYTJaUVE3OFJBc0JaQkZzSm1waEpYanFoQXlZcEFSWjBJNC9LTU41Mnlk?=
 =?utf-8?B?ak9kM1k0QnlMaHNROUxGd3Vra2pHdHBYVWYwa0tCRWlzcmU0TDhWS2tzK3Q3?=
 =?utf-8?B?dE4yRDBWd3MzcHhwNVBNQ2g4U1hjYjdQc1hYdzZCMklEZ0lDMEl4dlR5N2hI?=
 =?utf-8?B?RGFiOENTTFFoMEYvNE5CQVVoRktBa1RzNWZkUGpFWWl6ZXVIbm14RjJQMmRT?=
 =?utf-8?B?K01wL1RZVGI2VTZtaTkxRmZ3RGJvLzFlUllvb1BpS05QYVR6WVpnRTJpSnV1?=
 =?utf-8?B?YjgwcHJZem96QjNDVWpKNWsyMS9seEx4UjI2QlIyNTRJK044S090cHI2Ly9N?=
 =?utf-8?B?bUpNM2RoMlRjWVFrK2REMEkvaGhqRTkvZHVHKy9nU0VKTmFKdmY4UkVIaFMz?=
 =?utf-8?B?SkV5aXByWTNaMjlwS05MbjdmYnNJdmNnekFvajVjWFNublVFUmt4N0FHU0NF?=
 =?utf-8?B?S1Y3WGRiamNQdDBPZy9reCtJKzRYVmVHRUZmWTJRSnR6WmxPV21LVHYxNjAr?=
 =?utf-8?Q?7o9gQ1GiTf9PzoXInw66RK9Zy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b86aafd-4598-4501-1f45-08dd83021ba8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:32:04.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYWBmGpeK8mJcRi78BRaB3tNUxw9uA/569AHca7uHpus5/bS+B2k169dAjzdvFcoTJ9tS6dPdSN7uJglUsCncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594

Enable the runtime PM in fspi driver.
Also for system PM, On some board like i.MX8ULP-EVK board,
after system suspend, IOMUX module will lost power, so all
the pinctrl setting will lost when system resume back, need
driver to save/restore the pinctrl setting.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 95 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 00da184be88a026bf562c9808e18e2335a0959e9..438a9c103c5969bcae06b4e02d98397ffdcaa345 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -48,6 +48,8 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/regmap.h>
 #include <linux/sizes.h>
@@ -57,6 +59,9 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+/* runtime pm timeout */
+#define FSPI_RPM_TIMEOUT 50	/* 50ms */
+
 /* Registers used by the driver */
 #define FSPI_MCR0			0x00
 #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
@@ -394,6 +399,8 @@ struct nxp_fspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
+#define FSPI_NEED_INIT		(1 << 0)
+	int flags;
 };
 
 static inline int needs_ip_only(struct nxp_fspi *f)
@@ -927,6 +934,13 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	mutex_lock(&f->lock);
 
+	err = pm_runtime_get_sync(f->dev);
+	if (err < 0) {
+		mutex_unlock(&f->lock);
+		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
+		return err;
+	}
+
 	/* Wait for controller being ready. */
 	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
 				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
@@ -955,8 +969,10 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Invalidate the data in the AHB buffer. */
 	nxp_fspi_invalid(f);
 
-	mutex_unlock(&f->lock);
+	pm_runtime_mark_last_busy(f->dev);
+	pm_runtime_put_autosuspend(f->dev);
 
+	mutex_unlock(&f->lock);
 	return err;
 }
 
@@ -1216,9 +1232,14 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "Failed to get irq source");
 
-	ret = nxp_fspi_clk_prep_enable(f);
-	if (ret)
-		return dev_err_probe(dev, ret, "Can't enable the clock\n");
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FSPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+
+	/* enable clock */
+	ret = pm_runtime_get_sync(f->dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable clock");
 
 	/* Clear potential interrupts */
 	reg = fspi_readl(f, f->iobase + FSPI_INTR);
@@ -1227,12 +1248,14 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	nxp_fspi_default_setup(f);
 
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to disable clock");
+
 	ret = devm_request_irq(dev, irq,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
-	if (ret) {
-		nxp_fspi_clk_disable_unprep(f);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request irq\n");
-	}
 
 	devm_mutex_init(dev, &f->lock);
 
@@ -1249,28 +1272,73 @@ static void nxp_fspi_remove(struct platform_device *pdev)
 {
 	struct nxp_fspi *f = platform_get_drvdata(pdev);
 
+	/* enable clock first since there is reigster access */
+	pm_runtime_get_sync(f->dev);
+
 	/* disable the hardware */
 	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
 
+	pm_runtime_disable(f->dev);
+	pm_runtime_put_noidle(f->dev);
 	nxp_fspi_clk_disable_unprep(f);
 
 	if (f->ahb_addr)
 		iounmap(f->ahb_addr);
 }
 
-static int nxp_fspi_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int nxp_fspi_runtime_suspend(struct device *dev)
 {
+	struct nxp_fspi *f = dev_get_drvdata(dev);
+
+	nxp_fspi_clk_disable_unprep(f);
+
 	return 0;
 }
 
-static int nxp_fspi_resume(struct device *dev)
+static int nxp_fspi_runtime_resume(struct device *dev)
 {
 	struct nxp_fspi *f = dev_get_drvdata(dev);
+	int ret;
 
-	nxp_fspi_default_setup(f);
+	ret = nxp_fspi_clk_prep_enable(f);
+	if (ret)
+		return ret;
 
-	return 0;
+	if (f->flags & FSPI_NEED_INIT) {
+		nxp_fspi_default_setup(f);
+		ret = pinctrl_pm_select_default_state(dev);
+		if (ret)
+			dev_err(dev, "select flexspi default pinctrl failed!\n");
+		f->flags &= ~FSPI_NEED_INIT;
+	}
+
+	return ret;
 }
+#endif	/* CONFIG_PM */
+
+#ifdef CONFIG_PM_SLEEP
+static int nxp_fspi_suspend(struct device *dev)
+{
+	struct nxp_fspi *f = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret) {
+		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
+		return ret;
+	}
+
+	f->flags |= FSPI_NEED_INIT;
+
+	return pm_runtime_force_suspend(dev);
+}
+#endif	/* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops nxp_fspi_pm_ops = {
+	SET_RUNTIME_PM_OPS(nxp_fspi_runtime_suspend, nxp_fspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(nxp_fspi_suspend, pm_runtime_force_resume)
+};
 
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
@@ -1291,11 +1359,6 @@ static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids);
 #endif
 
-static const struct dev_pm_ops nxp_fspi_pm_ops = {
-	.suspend	= nxp_fspi_suspend,
-	.resume		= nxp_fspi_resume,
-};
-
 static struct platform_driver nxp_fspi_driver = {
 	.driver = {
 		.name	= "nxp-fspi",

-- 
2.34.1


