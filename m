Return-Path: <linux-spi+bounces-7721-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A0A97EDB
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 08:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F3A7AED59
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 06:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7E266B4F;
	Wed, 23 Apr 2025 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f+8pPvW1"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D72676E6;
	Wed, 23 Apr 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388638; cv=fail; b=ooQxgocTCTMXqlrWj7RNRSbqphzoF5nlmW5bvwxus1T/P6VT6ANTDNW7vQtVytZxvndsi7NYQynDo1K8xvxpxfccRJRgaShOfO9W244IeytWksiNukDeTXCN9QlAA6EBWGpuVGkq6R+r506epNOsglsw0tvrxnRURxprdFSW9vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388638; c=relaxed/simple;
	bh=cFeaoFNjKwmU5hGpWchyxAfTmDsLy1lX4PKmxseUalI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U+B7tkxwl0IALvqfQytFIFpY7iBEy4oAZJG0qopo5DgQT1B8I3P+HV/50NsP678JToFwLqXJjOIru4u2DfT/ia1bNHseVPM4yQasGPh19KSt3jmgkLtQ1xqZN6p7GRpuKLGh1Cy12m7X/9OfZviWlImnvcnDw+Y6aGBHFnfOQPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f+8pPvW1; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2d30l7HT+G8UTYPbV51RSZ4xhnkBWUd8QXuE7A4UL2Hj9G6fkQbVvbHNhSDmkigGAtabZ48TltBfOVCFA0ApcoP6D0LR9t+Z1gRNj+rpoGT4zkxGbz0AMfn/Mw5k2huCTbMZIyVjPGU6LNwEidKaFBLg8whzWpQi35ysDF+CalQbSdufwMNOzxMp0fd4iOIu7T6KBPbT4wt0ZbqPtz3seRuTFiLvxwk1gaDiWZZMy+1bcoDQfHysFHoe1MTghgXYUVS2Hpj/HCOgSozefIE67xeBn/x3ZmDP19fosWURDhwhT5P3iSKeniX22aK231Q535Ox7KUyAmcIq6kyWIL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbAp8vCutNlLewUj11P0p3ODGShz2QoawscXWAYxCRI=;
 b=NoiQmXsrXgj91wR73VY+WU2Zork6bOpSLG02uz1apocCFs/8J55c9PZ30bratqA/PP3cOpiKYuC8yyhNMc808KddTRoKD1lv2ZL0rt8gwDNG7n20TdQ3i6/yPOvBCYoXPR1hh7G7mjngqLhh7kiIG3gGtAUmH5oS3a8nP5KTFUiFfArVtlBM6PTxZ8EmlkdFVDrXMjjOcyqZHZ/CAruhXSJVEd0AwddEZgvs37A/2tzfAQ82lcM46bzIWTSyl4mjvnxPjOk826qoCD/81xmvckp2z4mjLfq3iLRDTa3inmMi2JLXERrWewLiNiDvAUwGLcC/ldGBJFmqKb/RG004+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbAp8vCutNlLewUj11P0p3ODGShz2QoawscXWAYxCRI=;
 b=f+8pPvW12wZAVSJQu4fp5I2gR3Jwr3kG7r/sPKPOCn6zRekxjC7C+bSgqhY23BOZ16ZlsMhKYs5r2BsogQpDhTuu9gWLTElA+3ikfSorQwUJUW7Fl6eyHyYmOa+KGapvHAR2+iEbuTBclANuv4eMs1fkb7pqIX/SNSgUREjBb28oZGLBGGawl+MH8Z8CeD4nYJohqwDpwWD7clMqMUFU9b474dJwwecIj47DPSPr1+KH90d72bLN8BgRAurCwC19xNIaitgc7MoUy6OF2ePKJ0fbXhUVfysXk/DOONLlfK0dZHWd83grrcLPSsVIBYHyJcMHMPJZR2mzQvtbf5oHEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:10:34 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 06:10:34 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 23 Apr 2025 14:11:40 +0800
Subject: [PATCH v1 3/5] spi: spi-nxp-fspi: use guard(mutex) to simplify the
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-flexspipatch-v1-3-292e530509d3@nxp.com>
References: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
In-Reply-To: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745388747; l=1084;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=cFeaoFNjKwmU5hGpWchyxAfTmDsLy1lX4PKmxseUalI=;
 b=AV1OoL3ZN64HadpACvaQZvxF5DiVrswwhStTwJQ99VZlPpPDjN+uAyXKVEWNkV0wJiyTgq6MH
 r6GHYWtfuhNBejx5D9Cof97qopCObmWqa3WVAhtI6eihqECa5wTZ5aX
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
X-MS-Office365-Filtering-Correlation-Id: 0a7a6ddd-b748-4c09-06cc-08dd822d8f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1FWMVdpVUZZWGJ4NEdzY0l5VXpCSjNlSll4b29OTUtMS0ZlRmVsUyszK1RL?=
 =?utf-8?B?bUlVWC95YVJEbUthZlJ6aHBkUC9NQVdPZ0VZbitBdjBrTk5keEVjSzNxVEZj?=
 =?utf-8?B?SHBFcDFwNHdsSHJUd09mVWJMVlN2OUYzdHFLSEtyNTZGRXpTbVpEVWN3WTcy?=
 =?utf-8?B?UlB0UEZlWFVFMW0yUnNZbVNlck1PbENrRk9QVXd2b3NObGhVVW44eGNka2pU?=
 =?utf-8?B?R1NabXJWY3hYTmJPbmpZcnZ1NUE4RFNOM0VUODg4dm1sVGlXRWVpUWRwaHFp?=
 =?utf-8?B?eWpzU3JRdTExVDhGK3IxUlJIVEVRTUxEaVIvQUlqUlkzb3hlRmxQZGFOMHpW?=
 =?utf-8?B?MkxIdExSRWYxS1RuYzhIVTRpTUl0U3FtdnVZU09OUUlPNmFJQ3hIZDFHYWhQ?=
 =?utf-8?B?Sis3cFV1ZUppdExlbzJvaS9yZ3lqRTBoa25qQVpnOEhXNTdPN0hVYVB4UnRB?=
 =?utf-8?B?YWRpdTI4Uk1va0lXKytYdEVSUUNVTmMrWjRBSHlWQUZFSVFYTkhCenFtZ3Br?=
 =?utf-8?B?TFNNdkxFOVBhZnpMMmg4bVRhT1l3cC8zaHA5dWN6OGVId001SFVYMVlNOEIx?=
 =?utf-8?B?N01KTXFJVkUxTW1XbFBTZWdqeUFFZm9wMzNwcFg2NEkyWDAvNlphSGFrcUM0?=
 =?utf-8?B?WXhNazBLQzRKNmkvR1BUamJMNm52UVBjL1V0MExLOUNFWUZlWi9sTGVtK0VY?=
 =?utf-8?B?VVIzeWJ1Y1llOG9nUkZDc2hFOVUwQzQ3U3ZJYWdTUEowTnM4WlpOZ0ZIOGYx?=
 =?utf-8?B?Ny9ERktQYXhYSDAxUVdUTHJORldEeEE4ZzZWeVFuTEt4ZGtBamh2TmFQKzdC?=
 =?utf-8?B?dHFIQTlyb2lCY2xpcHlSZDNkY2JwNG5JMzN1SWY5ODdMd3NKbE5PWWM4QkJB?=
 =?utf-8?B?c1lIMS9GeVZUeGNVTGp2Vml2MFFGSEN1cUx4cElFQzJDNlRDcUthZXIxejlB?=
 =?utf-8?B?N0h1bFFsNmZyazZmcEFHNFBuRVdWYk5ZOFJ0bHQzTWJjS1h3cSsxYjd6bDNZ?=
 =?utf-8?B?clpmbitUQ2Zib250dXdxUFJqaGxiQjZCWWVnNzFGM1NGREpMSEtibUZRRjhF?=
 =?utf-8?B?WXdHMTVQRUVuZ1ZlRkdyT0dZSmtEaTJUaFlWbDEwYnlLQUQrYUhueUp1Smd0?=
 =?utf-8?B?NkFiUUVON1ZSTEF6dGkveStnRXFnazh4OGJNZktoRGpMdEFSNkM1Y3BrSFRO?=
 =?utf-8?B?SmIvc3hOZUZVejBsNldraGJEdEtEbGVsdEcyeEVmVjJYeU9YV0ZXM0hFK2hi?=
 =?utf-8?B?Y0tnQ0ExZm9jMS9BUXlMUWlRb3RTL20raG92dHlyajJZcWl5RDZuT0Y1bUt6?=
 =?utf-8?B?azJFaVZrd1JZZkxUNmlUMmVkejF6QkMxMjh1azlYczhlMnIyRHV1YlczckRw?=
 =?utf-8?B?dnJtTDVNcG9Ua2djU2Zrc2J6QVJCdjlnOXJBSUVTWkxtUTBsWkViaVh3VWJS?=
 =?utf-8?B?NHpQM2wwYTJ1MlNXV1p1ek5WMm9lbnZHUWZNeEN6aktuMlpuN0lzU2FmUzZ3?=
 =?utf-8?B?UXZ2QjFmU3BwVUNSTTV5Ym9DMzdmbnA2NzdWR3pMbU90d1ZFcVJrYjliTmxG?=
 =?utf-8?B?SGYwVmM1TEFtQkFjS0t5R0FjRitzcnRvSFFmMmRyOXhocy9IRlJtd0VIWVdU?=
 =?utf-8?B?eERkZ2NWbVR1Rnpzc0p4alNMbm5hSHBoMXNlMCtzTUVVTVhqR2loZWVub2I5?=
 =?utf-8?B?eWcwc0hDRnNRWGxoclh5ZlFvYnhJNllNR05lN2NuNjREMUg0bmRLdnU2elF0?=
 =?utf-8?B?WEFteEdGb2huRHZ4TWNlUWJ4NU54bW5IWDBVODNSdWZLT0ppL2l4QmduZzJl?=
 =?utf-8?B?OWIxZnBpQXZqdDVWOXFZRDdXWGNNcjBmZ1B5aXJPeUVmYUlVMzVHRTVsMXk4?=
 =?utf-8?B?TU9LcjdIYXZSSG1NMGpHQlJIODFEdjJjV1puVXExUEtSeVVCMmkwU05ZU0Jh?=
 =?utf-8?B?dy9sN0E3dGtHK3gyL2FRQzV5K1RBaWtYZkhya3FvMVl3MHdVOGlPWGxWM0lH?=
 =?utf-8?B?UFJMYWRnZitnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGtYU1ZqdGdZQ1VBa3p1eEdaVFZWRFV3c1JvenM1YXlRUzB5cXZZdnVBZitw?=
 =?utf-8?B?MVdVeWVuN0dwWnBiZ2NZRk9CMnRvUFIzRjd2QWlsUVArSCtpeHRJUXc1aE1K?=
 =?utf-8?B?U0NSRFJnL3dOeFR0ejR1QzNMNHg4cktwWVVsNWRVYTVFTjI1L0NUYkNLaERE?=
 =?utf-8?B?eFpxVTQwcWljYTQ4RXQ3RUFXNVk1Y05jV2V2WENlYU1XQW9TZVBNOEE3dE1I?=
 =?utf-8?B?V3FlVmVoQS9aMWhZUE5Ua1JPV1NibmhIY0hIem1mcE96MXdRdFBNdFQ4QXNk?=
 =?utf-8?B?c2RuQXhuSzY1WVUyWDk3K2F2VEdUV21rcjl3Z04zTU1UZVo4TFErLzVKNGVX?=
 =?utf-8?B?Vytob1dlaTNPSEdyOFlTcHF5V3VDVVNXckx4UVNCR0UycE1tMGgvNGpLS2Ju?=
 =?utf-8?B?ZWJTdG1pdFJtckNxQ2dVZGVhREFISkdKaWZpSk9jdTVYbzlHQXAyK1lTdnhZ?=
 =?utf-8?B?N1pzS2JzWlErRmtYL1Y1QWY0dkNVK3laWUdTRXVuOUw4TEtqYTdUbTh3Mi9F?=
 =?utf-8?B?QUZ1TkE1R0VscXgzODN4TDNxNXA3Y2haRitNUGp2WldtcTVxSzNrNjBPN3BB?=
 =?utf-8?B?SFVxMnpFMEhoblhXRVBqOHhPam9kYm9ad3QreEhPR1lMbmQyS1dBK0JPUkRS?=
 =?utf-8?B?L2MvYXRBOGJPZWF1SW9acXYxdlhwcXF3cE5RSmxSVFVWVUhDUmVsWFAvSEVu?=
 =?utf-8?B?RGRDTFBaMmh4UnFST2pXZ2dFNE00NlRwd0tNNHlHYzVvaG1FSXFLMGhsUGg5?=
 =?utf-8?B?a0xPdEViZzJIWVBlbHc4ZTAyWm0zSjdUSTIvQ09STVE5MkFKdjV0cDc2QmJO?=
 =?utf-8?B?SXVVckkwVVA2VkppQkh2U0UvMFhRR1gwbk5oN1dzQ1ZZQnc4amFqRWJublFJ?=
 =?utf-8?B?R3EzQnpmQU1ldnNsamdGUk1iemtSeGVybVlHVXBNNWwzNVkwMHNvamF1VW5j?=
 =?utf-8?B?dDMzK293WG9sYnZKc2M5WWFFdTczK2E5amZBeVBvMXBUSDVvaTJQK0ZTOFh6?=
 =?utf-8?B?MHluSzR3dVpCaDFQSndRazFaVXBZaHpJYmloWDlzazJmTXJKQ3MxZjhTL2dj?=
 =?utf-8?B?R2dPWWx3ZUFWSWRWLzF1UzJrMUZGcFRETmp3UjkwS004TGFnYXpsV2w4V1lJ?=
 =?utf-8?B?ZFlGMmR3TEkwVlVLTVpqUkZRYitCTlF5TnYvcFRxdDdET3V4ME9ydDcveUNH?=
 =?utf-8?B?ZE5mcDFWc3hhbDVuejJ1Rm1LdCtJZ2VZWk5vSUpwMDhmUVdjWW5zK2JJYTBk?=
 =?utf-8?B?bE9yS1NNOWlEN2ZNV0J5MlhNa1NMYnBhQ0JjTzJDQVp6UTNBNXpVSmQ1dkNv?=
 =?utf-8?B?SFpMNHNRemZpN01LZHRubzhmdHV2OVE3RCtiU3crY3JqM20ycE5rc1plM1hM?=
 =?utf-8?B?dHNqQ0pkUGFYaExtdWpHZnExbTBtbUNpL0wwaUtmaTBHTTlSam9IVHN3b3Ji?=
 =?utf-8?B?bnFHVEJGWUNNR3BlbXpJK2s0N1AzS05ZbUc0YlNLeStnOWxmeVU2cUQ1OVgy?=
 =?utf-8?B?OVRqc2tmRG0xOXlLbjAwenFCV3hTR0YwNHV6cFBQYys5SFhpZnd0clVHdHhM?=
 =?utf-8?B?cE5IWGp5alhhSVlseTgrTWRyUUkyd0IydWZiaC9ydWF0OEZIRkxRcGxxbXpl?=
 =?utf-8?B?eStPMXlqUmxwTUlmTlhGQ2Ewek4wWUJBZ0pqSEVZeDQ3bHhLdmRJQkhhQXVB?=
 =?utf-8?B?Qks1TmNUR3AzS2JaaWg5TGNqT2ZPWEUyYWZFd3Q2dVB0Vmdrb0RaY3ZZcitE?=
 =?utf-8?B?dDY4cTB3SEVTNEVLeU40SGIrN3lTZG9EUHc1QTZoeWlkYlhUZE9HVnJCOFhs?=
 =?utf-8?B?R1hUQnNyak5Va2hUdllwZXdqOFhWM29Lck1RdUw4Z2NNTU1DOXpEQUZKMHpw?=
 =?utf-8?B?WkdLTUdFVTZCNkJnR0I4WDFqcWNXT3dsN0tobUd3dHFPY2pVNVRaZE9hRXlZ?=
 =?utf-8?B?NHJ6a0E5aEZheE9WTjZFbklnTTN4ak9kVEYvUlhCL1VRbGNRUG1ReC82UTdw?=
 =?utf-8?B?dWs3K3BWVzdIdkROR1VNbXBqNlJ2eTlYSXJZN0tWNDM0WU84emluWVF3L1Fx?=
 =?utf-8?B?UURFYWliWGJLbExZUjNqYWl3aHNsQ1NGMEs2V0h3TFBGNUZKLzZNQzVWQ0Ew?=
 =?utf-8?Q?42/ue9ArXFE7gaKQc89gyykci?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7a6ddd-b748-4c09-06cc-08dd822d8f26
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:10:34.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qi30jiljJrsMZv15Qw7H6FPMA6qkl8bKtqFJemjcjRSBb98C9TO/RkLkorBjXGA76LOVxX6tCee+mO25X0PM+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734

Use guard(mutex) to simplify the code logic.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 23099e60b6fb7e899f95fa0427208b33bc5522ac..2eafd6bb819165740f7eeddaf5d2e90fc5682b6c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -932,11 +932,10 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0;
 
-	mutex_lock(&f->lock);
+	guard(mutex)(&f->lock);
 
 	err = pm_runtime_get_sync(f->dev);
 	if (err < 0) {
-		mutex_unlock(&f->lock);
 		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
 		return err;
 	}
@@ -972,7 +971,6 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	pm_runtime_mark_last_busy(f->dev);
 	pm_runtime_put_autosuspend(f->dev);
 
-	mutex_unlock(&f->lock);
 	return err;
 }
 

-- 
2.34.1


