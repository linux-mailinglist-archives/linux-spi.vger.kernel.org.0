Return-Path: <linux-spi+bounces-10039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39248B58FB0
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 09:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D27E1BC1EBA
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76F2820AC;
	Tue, 16 Sep 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hbDYEdJq"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016C28466D;
	Tue, 16 Sep 2025 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009432; cv=fail; b=tUWJWNxAqa/OExr9RzPf8+NLgBbBtpY2vuhxgpTdDEr0ZV6q7ly8Z6B3qjzR9K8ylVntvVjUrqXwNwKKXG9bhAi94lEz4TYf+Tu276LxvemKPmcEi0TihoDmbiBh8njXvvpGBw8mlWA/jIj0XmUu6EBaKBoR+FL0aClM9iiAzss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009432; c=relaxed/simple;
	bh=PUmsUUYWRANqeCSyDcOZwR/07m9lWSZ2Ween7zJFNis=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V7CgQrQdAG7Wyt7/mbCTOucX8qo8vct2PSgz69isIHq3GGukKeCoNusKFgydYDMMhioNrj3mq0RpwKnwPnZ2Hakr9yoqdZwa8Wxat0OTIhM15joZLDjTTSYYEI5MDh1ObUlt3WdTLlM5z7Lni7PTLuUP7cPW9dq4YKX92csipHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hbDYEdJq; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wq3JEPI7zjN9zUo6LOz5uA2/59yqq5abWzYuxts91E0ffPAvE6vypDaceTqoyZLmHdDlV9tnbiqv2qDwk4zWEVu3D89WKhZDmjCS3uPHa2cxmgNR/84X5jjj6GSHxagll8htgrwY+1Z5C6uwivORXWMD76BZp2Jfg75NNGItA3fnFZ5D7GHd36N79P+dKaBTnZIQybmaUmvtiLhxzOJNzN3tFi7qVLFOSIAFFRTxIwXuga/Slnyu+Ugyq+93JSM9wlqsSsIW2aYxgTyTzk7nxrSgBeitDT3Gm4eq574JkYCe/7J/XRV8MePNz3DH99Nj0dKtvzLh/J/5Pz8YPJEiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye828KogLCnW6Mugeskb6ja0f8ZHNt9SI2ue/HI863k=;
 b=hvoPi8S00Ajr4PHuLKFwqP9EBQ0ZTgr0Gx0eNs1brSOl2PQq4z94iOx728LzgNbRW/j29A6/YcA0kN441Q+MFcjojnFjbd2YX1tprbKQE0MzVZuza17dLNWDG6Y7Vy0suzDNwsswiyd0lMMWvLYKGB1OI/XOr+ajNaNE6c4FrnNcVVYyuMZZJFcvOqW54qQZ/vDqdBrXFrVDVB4iHcdITIv6hDleqVTbhHY5s9R9Fw5mrb8QVP5UIydTJaD4jd2Wb+7zxhA6+4WlrUk8GepMG3lRTOALNn1VBIo9QxcXGsO8HEB91xhnm6/OgsXKO7RgRRb12rndCT1/VrdcEpSrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye828KogLCnW6Mugeskb6ja0f8ZHNt9SI2ue/HI863k=;
 b=hbDYEdJqIOwyQcxX3TM+kqNmQ8BWiz4P85Ac7VTPE4Nx4HEViBioMpibTiuCd+bv907ShB28KJM7lU4J8oVv7S/VyJlkLXbY93cr2SSANfXP4cWz3XG3L6Gewsc9ZbwScCT+yMw2RdXC1YcXyucdQXobEc4JnSPKfFhVSt6eGl3Kd5a7U74sGQkNBRFa05qoppY5Xn8vsgC4eNLtFk8MmlCPUjaL9sHMr0osvKvbUjB4f4W0rKiGchkzvwDM4TYLvF6zaXILjXrNf2YlXz82xa3ASvwUNFNelqg3U4NnZEq4Vfi1K0xbQx//3XfEKT49LQ+Z99DbeSZaXUEfCVmTtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 07:57:07 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:57:07 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 16 Sep 2025 15:56:42 +0800
Subject: [PATCH 3/5] spi: spi-nxp-fspi: add the support for sample data
 from DQS pad
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-flexspi-ddr-v1-3-69358b5dc862@nxp.com>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
In-Reply-To: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009434; l=3812;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=PUmsUUYWRANqeCSyDcOZwR/07m9lWSZ2Ween7zJFNis=;
 b=QskhipJ8+FTixB91sKou4nDjYj1m1aqg3fdzqQLws40jRVVTARwnbLCP93Fl6/sH3fhyImlHS
 ulA8q8tSmM5DmsOuTkkFoNa9/GuycjWY7+NvZ0z8LaQPhviB0EucwhE
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
X-MS-Office365-Filtering-Correlation-Id: b27086ac-6781-410b-a681-08ddf4f6a1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzIrZkpyd0xaQ2g1T2xWc2ROT3JyMzgzdXRDbGFualZ6SUk4dnVSN3Jjd2NF?=
 =?utf-8?B?cEJoTXJ4Qit3SXlaT0JQbUozT3Y0U3R2RFlQYkFRbldaYmxPaWlmSk03Y1pm?=
 =?utf-8?B?MHlpMHQyRlJoNnJzeDB5SS8zVWZ0WUphTXNXWldkSFZZTUM3VGF6TC9KSGhY?=
 =?utf-8?B?WDlKd0JMOTllRG9vbE5MK1ZQczA3YVg5RTcxWFRQL2V0UXJYM3RNejdlbHpp?=
 =?utf-8?B?dlpQclMycVo2aTYxL01NUUk1ZXh2dXViZlRHOG1VaXd6TE9kMUFtekEzWWw0?=
 =?utf-8?B?eWJUc0xmT3VXNHpuNTNyNy9sQkhlblVYTTNCaUdZVnEzc0gyWnBWL1MxMVdY?=
 =?utf-8?B?ZCt6TGNIMXVZUXNrU1pBcUxmUzFMWHJwS0kreDZnOWN5T2gyS2pqRGNWQ1NV?=
 =?utf-8?B?bytMWEtadHlJNUJIRnY5NWZBVkpsVWJ3LzJlNW1ERXJkeTFaQjVJLzFaMzla?=
 =?utf-8?B?RGJtbWxKTyswSy9FbWZ4T29HbVZBbmRpelBvRDN3ZUIrWml5ZkhQZ1dZYmdO?=
 =?utf-8?B?aE5yRFE2M0ZTcFlHQ0NxTWRyRHErbGJRZzN5azVIZktmYmwxNDZ0T1lpMDVl?=
 =?utf-8?B?MTBadkgrVEpWMndSN0NMNnZDOEh2M2lka1NLVzZKbG1CbW9Jb1QwS3BnUkI5?=
 =?utf-8?B?QTZvSjVYMkxUdlVhZ2YyUmVZcG8wT1oxc2RIN0IxNzh4bllHRmtkTURHT2lq?=
 =?utf-8?B?WHNGdWcwdlc2Y1VLQTIvL2FnWmdCOTI0WEhwNDMrMGtwWkxkWGNIVmNDTFJN?=
 =?utf-8?B?WWNSQ3V6UGRsMWFyMG1qN1QwRHVsNkFTNjY0bnV4T0JUdjVaYW5XTzBCeGhR?=
 =?utf-8?B?R3hvWUszdDh3MmtLa1BMd0ErTXRHK3JYYUpGMHJ1bEREUGM1ckFON1RYNEVC?=
 =?utf-8?B?cUFnWDVsVk5mV0V1dDRFNGVuSHdFMDJjSGNWNWZnWWMraVBLR3VtYVF3UUpn?=
 =?utf-8?B?d29qSkFaamFOZXY2bzNXYWNDSWRzMmt5RUdESk5LOFZUMkZ1OVV0dHNmZExK?=
 =?utf-8?B?WTNmQ0ZXVnJXYVdJM1dlMXBxbXhrUUE2WXIrMUpEejN6bkg4TTVPMURORjFt?=
 =?utf-8?B?V2Z2elA5dHVBaDUxb1hNV2dUREZUTEgybG5YOFlwRUZXbWlVclZsaHRkaGJO?=
 =?utf-8?B?SnVZcUNPRG9ZNExNREdENFZhWU10SE52MDlLczdJdWIvOGNqTnBXUEFmT0Rn?=
 =?utf-8?B?U0xBWEFhT1FuVldyM2lPUU5MMU1ZdER2dlhJcm05aXBGa1cwV3RQMFhvSkxL?=
 =?utf-8?B?T08wUjRoYTFjYWVJQzJORUY1YlN6L1dzSzlTZ2M0V0xHRjlMaG9FTTF0aUJa?=
 =?utf-8?B?M0hYUmxiYUl3NFZMN09wTk5DSENidXFLbjl6RHlpc1ZUMThTd1llVDNWd2Vr?=
 =?utf-8?B?ZjRERHRVeUVFYk9Ccm1yTXBQMkVxTFQxandaalBlRUl5Y2p3bUczR1dlLzE3?=
 =?utf-8?B?UE9xTk5LMnl3SEw2MElLa1gwQkdNQi9FNC9CdmtJbWxOQnNQZkthclpCZkdp?=
 =?utf-8?B?K3FuTVdLdXdPVmhCSG95RElLUk5oZEV3QlBNTFdtU05CV3hnQnVwdUIwSmcr?=
 =?utf-8?B?V25HbWJEaGEyekJOS3l3WHZBVEl5RDRRYytqd25kR01wK1RkSExObnZsNkVy?=
 =?utf-8?B?VnJhMEY2Z1NFMTh3VklWRkpqK1J4ajZGdmYxZE04b1h1WXpSZ2ZiWjFuK0E4?=
 =?utf-8?B?QjlyWW5ZeitSWkpNbEhHY2ZqMnNsY1F1c0V5NFpiQTZrTVE3TzFzTXFnSjg4?=
 =?utf-8?B?c3prTnY1S2JkZDlhbG16Sm41UERsUHJMYTlRVnUzNmlpajVnbEEwVExldk9t?=
 =?utf-8?B?VTRKWGFiT1NHUW1LcnlpblNVZ0ZqMXR2V2hlcjkwbTdNakhHL1RtV0R2emRL?=
 =?utf-8?B?LzFvZ3BGSU9rbkNzbHdqemVjODh0ejRadnV5V1VRUTBGYmRoajZEYjh2YTI3?=
 =?utf-8?B?MGR4SzBBRjlnOXU2S1A2QnpaRXhFbXdaUkdtRXlFeEMxaW5naUUwZmFIY0Vq?=
 =?utf-8?B?VWlHSU1pNGlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBuQkgxTEplelVCYktCMWovdVVHd1gxc0pZNGZoai9XQ0RUQndoTHYyZkUv?=
 =?utf-8?B?UmJ6ZHlGazljT3JYM1JHOVh0YlFsK0JpTlgxVHVBeTBSODRoUVlPcXBFcy9a?=
 =?utf-8?B?aWdnU01yT2FsWGZ1UVZ1MWxQc1Bka3hrWFcxR0tLTU1ORFozeUN1OWVMNXh3?=
 =?utf-8?B?dDhDcm5RL3lIMUQ5REcwQ1VBOVphZUx5d1dJVDVISi9SS0FCSm5ocVlQeUtU?=
 =?utf-8?B?Mkh5aDMwTCtPNlpjMjI0UFROZk05N1ErNTI5OVN5WEltY01HSTF4a2FLYjVE?=
 =?utf-8?B?TGhOdUVpTENKdytYYklETEZxcy9ZRWt5TTQxM2VTN1d4SDUxbm9tSlI0VWxj?=
 =?utf-8?B?UVJsUzdaaldUdWVTYmNXdEVyTnNIU0ZMSWwra045VXR2YVhoclR0OTdndVE1?=
 =?utf-8?B?bUFQYmhLMHZOWnJVS253c2gyM3BmWFNvQVZMd0xzWkJaNncrVmduS3czLzhl?=
 =?utf-8?B?ZEMydk1Mek5QLzZ3R3RnVUxaeUU5NEJrMnRuZmdjOG9IZ0lYSHdJZHozeEhV?=
 =?utf-8?B?azNnbTVJczZuRVl5NGFEY2pjbjh5dW5tZ0dOMlQreWwxQzYwWFd0SFpxWVdJ?=
 =?utf-8?B?ZjY3Z21pUGlhRk1QblRpWU43QTY1emVXaE5xRnZWOG5ES0hDY3dWVnNvbnhU?=
 =?utf-8?B?T3VTbit3NUhRNnRYY29RRG52MlBvMFk5N2syOHhCMGdJWndZcVBodmhQeEJ5?=
 =?utf-8?B?WU1JTld3THE5YmhXcjBZL1lHTmJaek5QV0hKeW1IaE5JSXZzeVkweDFZbGhQ?=
 =?utf-8?B?NFJJbDVQK21yZWJQSk5LV2EweTVXU2V1OEs5UHR4R2M4UHkzWjR0QTFwQ0lD?=
 =?utf-8?B?MDN5S2RjMU1NMTk5TGdzSkFFNlovdDY3WmRxWkg1Z2hTN1o1L00rRnZXdmdz?=
 =?utf-8?B?MWR3K0xOYTFJZWQwalBKc3VVKzRJaUFmTXJET1lraXRLUVJIQzRyd2ZXcXpR?=
 =?utf-8?B?UjVXWnBJaHJzanIrOVdnL3QrRm1hUTF3d29QTnBYcFFPVDE4dExZbGc0cWpN?=
 =?utf-8?B?eUwwamNBbkFlb0tDSktUMUZsWkFKRUhUc0hpaWt1dnRrMkFIOHhDYUtmenNn?=
 =?utf-8?B?dlRoSVpGUS8rcXlsbjlSdHpGbHg1bUdOd2cvczFIU1ZFelFEN2wxeSttcUwy?=
 =?utf-8?B?Y0EyS0N3Vm14MGFTMXM5TTNNNHQ2SnZBbHgxMXU0SytMMTBDa3BxN1E5c09R?=
 =?utf-8?B?eVpyY29CWFN1K0Z3OTNoV2o5YWFiUmdDSjRmSmhzYzlPNk1iQTRUSjA2TzJ3?=
 =?utf-8?B?dytnQWVyKy84TFRuUzFJZGdSQmhlYm5HTm9PLzhSQ3B5QitWZ3VmV0M2d2lm?=
 =?utf-8?B?UHEwSERhRmQ1MENXWTFBYmxFaTNFM0xkMk9VRDhJeXdiei9XNHRqVkVtRVph?=
 =?utf-8?B?Y2VIRDg2MThCWVF6cDlpUFFiV0lSd3ZXWjlrS2JIS2JMbVBoV0U2RkxrdFFR?=
 =?utf-8?B?SG1BMGJDZkM1NFZMdDNHWlFKcWV4NWJOd1Qyc2ZWNjJvckhiV05wd0wwOUtU?=
 =?utf-8?B?MG1CSjJxUVVHeDdsUHdmaG1JN0hDY294S0RPU09lNkFGQVcraXFBZ3Q0cXJn?=
 =?utf-8?B?RjFsQnp0cEt2WWt1aHFuRStXdE92WU1mdFBXSFZrQnEyZVJzTUljR1Q1L0RB?=
 =?utf-8?B?VmthbFF2aG9VTGo5WEVXRis3YzB1SXlGTEg3Uy9MQzZpSWtlTlNQN2wrWVJo?=
 =?utf-8?B?NjlMVTRhOUFlVnlYTHB3YzJ6dU5VZnJ4L2JSWmJxL3dzK29jYUtsbHN3MG5W?=
 =?utf-8?B?b0R5ZUNOL1JCSE00enZLS0FnZW92Ym1OUlR0OEJrTWlwVEFGMDR6QXg1dElD?=
 =?utf-8?B?M0lkWDA5U1QxN1F6L1hPRnMyUVlsbTlEL3cwT2tUYk01U1Z5STg1blVSWVdF?=
 =?utf-8?B?UGlHMFNnRTh0cTJjZkxZaTBwNTRWNUJPdjVPN2FuUkY2QStrMWJ6SUZyMWFl?=
 =?utf-8?B?enVyVERXZWNEbTd2OFNzTGliK1d5TDVpTEdGRVZDSy82Sm1SWUdUZms0Zm0z?=
 =?utf-8?B?ZnZEenFVTXRoc2tMNk1HQWxNQWRXVUk4enZ2MG11dFNWMDNRK1JsL3ZucWp4?=
 =?utf-8?B?Q3BoZG1CRjRlbGIzM29vUjdKeUFQOUVaZGhMTlJ3V1NET0F4N0p5NWhudkxU?=
 =?utf-8?Q?ENmGzQHamZlNH9JB1pNb+r2e2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27086ac-6781-410b-a681-08ddf4f6a1d6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:57:07.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93dkhf7HgAwFrt/dcrRMFGx2nr05kAWF1CaDc2KdrlE6KZ6gswaR7BOUlgiaofro03EUQKo5LPohDpzuuyEvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

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

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6b3e6b427ba84734a2359a964635a8f05cd146fd..be1e56072b94f38af934556055e321d9834bb07b 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -400,6 +400,7 @@ struct nxp_fspi {
 	struct pm_qos_request pm_qos_req;
 	int selected;
 #define FSPI_NEED_INIT		(1 << 0)
+#define FSPI_DTR_MODE		(1 << 1)
 	int flags;
 };
 
@@ -657,6 +658,43 @@ static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
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
+	if (op_is_dtr) {
+		reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+		reg |= FSPI_MCR0_RXCLKSRC(3);
+		fspi_writel(f, reg, f->iobase + FSPI_MCR0);
+	} else {
+		reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+		reg &= ~FSPI_MCR0_RXCLKSRC(3);	/* select mode 0 */
+		fspi_writel(f, reg, f->iobase + FSPI_MCR0);
+	}
+}
+
 static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 {
 	int ret;
@@ -738,15 +776,18 @@ static void nxp_fspi_dll_override(struct nxp_fspi *f)
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
@@ -763,6 +804,13 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 
 	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
 
+	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
+
+	if (op_is_dtr)
+		f->flags |= FSPI_DTR_MODE;
+	else
+		f->flags &= ~FSPI_DTR_MODE;
+
 	nxp_fspi_clk_disable_unprep(f);
 
 	ret = clk_set_rate(f->clk, rate);

-- 
2.34.1


