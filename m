Return-Path: <linux-spi+bounces-7720-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26882A97ED8
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 08:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E31516BD6C
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 06:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC32676D5;
	Wed, 23 Apr 2025 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wh1qHvOJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A672267393;
	Wed, 23 Apr 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388636; cv=fail; b=cqyZsoxiHdCOH496o2XwUw9HRt6YQPZ9ckKP12ZqMSt6Xn7wukXsNCuRWWOA01cuHaC0e7yLic4KVBMrv2CMWLfpW1FOuve1R/jJdrvOHDLb4+5vTz6xxt6IHFwY9Ijk3h1hUBPsZjdp4DmD0NCuK4anvUZDGLmispuFwwAK0bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388636; c=relaxed/simple;
	bh=8iYNp+JFHipH+AmfWSTSMxP+/1DcYqPBlnLSaPPHCzE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mZNPLCovK7FoUgeykobi2JxN7RR/9ANvPHP/T6CzBKQKw+Ub7wTc2HrOhrvrKTMwwP6VZY61FVRCj84oHE7WQFKHKlmktU72XOqr1bQExewlnsVVPZ0z6bhY4IoTZ2HFCYqveNshEfJvbYLC/QdjsY/pBhG/7d4OODmhvMSANUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wh1qHvOJ; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEpxfnyD8Vflzxsw6l4+FNjSuyucYD4rIf57K7qcTaKh503Ol16+rKn0Ui11oXJPXafsJ15gZrr4OFE8GKE9Kf+BATaEdCG59W8MK+KCBth2F+4j7gDBsgBMjLJpG7Imj0CmzDsjeuzTaNQCLgZJGzzlhGeN5qcRvX3uXe00UXoJ+DGfL1DmdeagCv+gwGnyzIu2+acR9gmM0NdYNI4n5jt0JBshwLNvfzFruTG3RSV6ENiuq3Db1XNn/wH4PfkgvcNLz5vq8XS3F8EvA1ucwuq6tKmvJfxY1++fmE63jOqzZll4YLIr2Rsa4p8M51stvtp8tdngfGvddEncqUoBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDLmNpfz/hy42XF8b2IbGlwahZ8EdIc7PMUiHEmp+58=;
 b=PIR8GxZjxU6B8IjbsS+kWP5w3mj3voNx/jFpsA1ze98uDG7lcVb5yyeuzgxbc3QdzHfKXjNhKtcR/MVvdfzdha7h3pH5Gn19Pcmr9HWv8IOdyMXTSYTUzasMF0bYPWq67aWO6Z6ARcZ/1g4Jmr2Y8rnZVWT1fcbkPDbMD0QMuhQ04QjZDw2AsUD5cy1Hz2DT8d37MiBNkS7ND5Ut6rTdL/5Q78wFPW8f3n6VkX9KvmIVLodXYZ70Df1pFuPomFGPeTJoxL9Xj7elLKX3f5nyjYQt1zAItbLSM8e+iYLY84onoEA4F7cBFD6+/zQOZKs6RSnKthmRGdK/b/7z+6ftOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDLmNpfz/hy42XF8b2IbGlwahZ8EdIc7PMUiHEmp+58=;
 b=Wh1qHvOJ++pMNfHKBT55bm+MkhRf79hpZMmsZulv9LqMGtBlF+J6+6z1/NXf03DVW9iCgeLT4alYK6tCkV7565ymvLGB4fXEwCsGlnw2huWNh3rjaZCBKKsi18peoec8XjwpyLHUYnmZKLUl+d11zIKugpzwB2WvlW0GjbgTYFSwYprsfqJiDhL8xPttiEbUm8AxUmVG7O6+VHJZIuvRc0VcKpTgn4O8R6y0zcpFgCWiubYmcqMIkD8Ne+PuIWy1mqzIT409dVaMa3eX70tptjgTS+6sCRDhKJiEuUp/COniBi9HLeNdIl+536mLea55a0JhxNla25Fyf91o4DxRCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:10:30 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 06:10:30 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 23 Apr 2025 14:11:39 +0800
Subject: [PATCH v1 2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-flexspipatch-v1-2-292e530509d3@nxp.com>
References: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
In-Reply-To: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745388747; l=5783;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=8iYNp+JFHipH+AmfWSTSMxP+/1DcYqPBlnLSaPPHCzE=;
 b=cRlsdgCxNPUMiUSVGiGSzOpzZB76wHT3K4qNe5xRXmd2rHquNKpbta9BUlpBe+g/6EL4Ux6Ua
 qKo3TyIKORSDrTGE7V3jWmVPFDSFL2rIKNxfZ2ve3f1kJLHMEdin9t9
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
X-MS-Office365-Filtering-Correlation-Id: 505b9f54-f894-4c47-68be-08dd822d8cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czBXY1JTVEdaNGZVd25PWkxiRm15UzdoVDdOL1R1b0tCUFRtZVNXOXRNKzlv?=
 =?utf-8?B?bHZjaTdnMFcxYzZvd0M4TENuMm82SXhScTNTaUhBUzRwM1JueHdVbWV4QnJH?=
 =?utf-8?B?WTkrallZRnFHWnhRQWE2R0dMR0I5NDlNRktSZHVyV0l3dW9hS1dObC9ncEhY?=
 =?utf-8?B?Y1J5WVg0R0Q0YTlYNjUvR25td2t2K20vYUd4aHRwWXdmaEc3ZSsxZVlkMEx2?=
 =?utf-8?B?RUdtR2Q3SDV5a1p1U3RrNm5nb2d2QnJCSWtnRHNxUU5Yc2Q3cXpKY0x4TFpX?=
 =?utf-8?B?SThjUVl1eGZiQWFHTkJoOHdmaUhVTXdiUWJXRHZtVWJ2aDhMS3NuVUFoQU1U?=
 =?utf-8?B?anllQnlaelhMb1hQNmZSb21XRnRLTVFRaDdJQlFZS3lMbzFIdU5ZUVZFcElF?=
 =?utf-8?B?bS9kc1BMVTFoOFRvOUdmaVlXckRjRFhRdCt6M2NwYU16RVpWQkVIM2Q5d25s?=
 =?utf-8?B?Q2puR0lnMys4d25vZzFDSnVrdFc2Y29XWFZWR2lrcXI0Q09Od2ZleDR6ZjhD?=
 =?utf-8?B?Z0ZLTVcyL2lDNFhwZ2Z6emhkVEFwSks1eFErWndXTUVDSnk4V3lITmZ2RUdJ?=
 =?utf-8?B?OGVQNEhuRElRNlg4b0hleElTUXUvQ2FlRis1a3hEVklPTUZvTjlFV2VGdk9F?=
 =?utf-8?B?Y20vdERJcWdIWXlnV21reDdCR1ZtZE9meGFOdnVhK0tPNFFMT1BJSC80YTc0?=
 =?utf-8?B?MndlbCs3dGJQRGsxUUJHNC9GbU9xVFo4RVRrMGlhVlMwcjBGU2RsWGNTdnc5?=
 =?utf-8?B?WmwyYmRUalJKM2tSSkVvM0l5SlZaTG1mbnZlWThoeW5sWU8zMUE4ZzhYRFpm?=
 =?utf-8?B?TXNWTXAvVjBpT3lybDRqcnpFR1Bjc3Z0T1B1R1Nsd0JZWklHdjFxTFdzUVhL?=
 =?utf-8?B?bTJReTRpVFlXTEhNdG5ubTJlYkNyK2lHRkFvZHFudFdRUXQvRTh5Ynpuc0x0?=
 =?utf-8?B?RS82Rk5rTk5KTFB6QVRacHA3aGYwM2d0MklCS1V1SHlhN0lvRWRqWkFTVDBE?=
 =?utf-8?B?L3RjcUY2NUdQV2xyWDlERkEvNXJ3c2ZUemlqVDllNXEweFhtS1NpN1orUjNn?=
 =?utf-8?B?MHZyZHovRFppaXlFWFBTR1Z5QXd4Q0tWY3R3eGtoeE11N1hGUHFLUjdsTnB4?=
 =?utf-8?B?QXV4MU1zUUtPeWoxdzBjSkZqRzFzbWI5elFrL0pHaGtCd2JNRG1CS0xSRTdF?=
 =?utf-8?B?TUc4WncxY1d2OGovTCszNGJOb1pGMXRrSXY0Y0F4WFNteVQ4NXhNUFVURXRZ?=
 =?utf-8?B?MHJxdjFINi9CSEgwdEJLNld2dk51WFhJVUpQbU5wZGw3dlp1TGxyaEdmdFVi?=
 =?utf-8?B?NGd0VzhlaXc5SGdlSlRrRGc3SUNtUzBuOFBOVTR1OXgva0NtZlEwZ0pKRmRW?=
 =?utf-8?B?U3Q0Wms0MVZ5RkRWRXR0YzdqblQ0blF3VTJmTkxPazB6T3Q0YlFCbFlUeGRH?=
 =?utf-8?B?blNVN1BKdmF6empxVkFRRlg5cGV4YWQxT0t4Vjc0RzEwQjV2eW5MbFcxNUNt?=
 =?utf-8?B?VmJ0VDY0UjlFNE5JZE9wQUxWSkV6ZHhQRkdkWTlINTJpMEVwZFZ5dUtoUmF1?=
 =?utf-8?B?WCtNTWQyNzlVQkNEUHJDY2lvdEVEUk9DVUVNSGd3YUh5SnB2WWdzN3Rtd3VV?=
 =?utf-8?B?dk16YzMvRmVTZUd5eUs3cmpTQTNFdVVzWDhoZ3ZXT082YUwyYnVQQUkzQ2Fv?=
 =?utf-8?B?L3M4c2Z5QWVtNlR4cVFBWlV6cjYwZGVsbWJRT3dsY2s2NElQUmRKdUIyNlg1?=
 =?utf-8?B?MC9MQUc3R09Yd1V5c0xocTN3MTYzMUhTamdJQXBQeENFWkhPVGRSSDhBcmJr?=
 =?utf-8?B?ZmxWRFA3S0c5alRzQmJOSms2WjZ1K3NLVk1HNVRrRVpPUlVaZTNnaldJWDYr?=
 =?utf-8?B?MFplWVRmL2xoa3l6OEM1UkFWQm4wRXY2RUQ3V3RHd3EwdXNHWmlyUUdvNEZ5?=
 =?utf-8?B?SDFSSjJRK0N0N1RSRHdzdUNySXh0WmN2K2RoVUxCTmlkalQzVk9PZDNQd3RH?=
 =?utf-8?B?NGV5RlBva3lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEwvaWl1WndCQVkxMy85Nyt2eTA0cFltSUs0c0ttb2R6aFRGVjM3WGxuTEdU?=
 =?utf-8?B?RGFLd1FHVEI5MnZpcVkwQURhbHZpSDdrQnNHTEhMZ2dValZRSWdid0YwaFYz?=
 =?utf-8?B?THQxc3F3SFBQSGRHYm03dmtKMUVJUEJ3TGl4eXZ2YkVaMTVZZStvR2syYnFN?=
 =?utf-8?B?ZkhjZUZrdVQ5aTZjdHk2Q04zM3RlLy8xazhWMVIvRVpSclR1c1hXUDZzZTdQ?=
 =?utf-8?B?cEIzR2RLWFo5anZiZ25iUHJNd2lLSmxENnVFc2RaMUptcjhkRC9tNXlsNGlV?=
 =?utf-8?B?RWFoa21Jdk1HS1ZILzhZR2tkVFlpWTRLMEptMWx3UXlYYjgxY25XOUZLUE8r?=
 =?utf-8?B?MHFxRk9SR3VQOWd2cTdIWnU2WFRtNTlXbUlFYmdVcjhZcjZVYVA0bllUUmpu?=
 =?utf-8?B?TGRjZGxIS0w0QlFIeGhwaUJMODM5Q1JHcko0WXJkY090N0pmOUVjbmN1MWZy?=
 =?utf-8?B?a0xpb1NXc3JRdWk3SWtxbmZ5cHhrcy94NCtCdzNyOGNxYnRRYlplc2hHY1Rm?=
 =?utf-8?B?YTFRZWFEZ045MmplYzJqTVk5aGhxNENSM0dSeXA1UjJpUTZ6M2JGbjl0YUl3?=
 =?utf-8?B?M2FRNjNOZ3FLRTRGNXBJaEhBN3FXOHR0OFY5by9uV0l3MTBQUjA2M1BMSk1B?=
 =?utf-8?B?bjFMdGswaytGb3Z1K2J4UnUxdEgzOHpNWndNRytQR0RYWXdpNnlCRjBpUm9y?=
 =?utf-8?B?OVJrOXp4Wnoyd3pCbVpDMFEwVkprNTkwQWlOM3NxUXVORElzWVNNbXhtVUk1?=
 =?utf-8?B?NG9IVk9yT28wRHFwVDJ2ZEhGbEd2bTd0dkJEWVduODh1Um4zUUU3OWVCVDBU?=
 =?utf-8?B?bFBMckpuNndXdEFCdjlTcFlncXFvYUdkV2VkY0Z0YkJvcndPSnkva0FYdjRr?=
 =?utf-8?B?ZjRZdlhMTGFSS0FrSmRHemgxR2pocTNiRzJmVlVpSlIvRVJLdWN6ZkZVUDhN?=
 =?utf-8?B?ekU1U1o1S2szQ3JBYmhtUm43Q2hBRjc2Rmd4VEVIR3pkU1JZV3k5TCtXOE9h?=
 =?utf-8?B?RlVDQW5iS3dZL2hmM1A3TWtOYjdaekhTczdMQmN4OEF4WENQd2QvVm5mUHJY?=
 =?utf-8?B?SDl4UmRyVVpjeUxvWHhLZnZ3RmhhNlpLMHIrSjdNSkpaRDRTWmhoYjN0enhY?=
 =?utf-8?B?eXdma3FGanZWT0JFVzg2MFpYVG1qOFFUUTJRQUt4YzF5WjI4L1FkTXpmR1JL?=
 =?utf-8?B?NHlYUHJKWDZqREdmaDQ4WEROditScktaTjZWWDVkc2xybkhoZGNpV1lXT1pm?=
 =?utf-8?B?ZTk1SXhYS1hQRERMNDIrMHltSTJzeGtLbFAwV3lPem1PWmtKSjQvTWZTZ1pq?=
 =?utf-8?B?aTBINEd2UGZDdHVLMDNtWjR1L2gwNGtPYnMzSnRJc1RFNkNGaHdoT3JYcGVN?=
 =?utf-8?B?aXJLcHBvTlpkM01FQ09Ta0srVVZlbnZSMS9YcnNHSWJNZStBcTg5enNSZDlC?=
 =?utf-8?B?S21PY050cXZ5eTY4dythUi83RGVUTlc3UEVjemxsTGI1aXpaZzk4VE5ZeGpO?=
 =?utf-8?B?cWhDRXhCOHFhZkFnYTB4TUtXK2VmaGNQaFp6Mnd4Rm40REZhUHhUSDVhUUVi?=
 =?utf-8?B?MjJVVFNvTGRqZFE5cVVva1dFcnZCYjZqK2hwRHMzT2o2RVhwOGhzL0E5OFRY?=
 =?utf-8?B?ZjhMV2lBalJBcktOTW1hWlFobC9WNEtPQ1MrMXJjMWliRlVKQVZhTTZLUy9H?=
 =?utf-8?B?YXdTQnVlODFDcnlCODdJaVh6S3NVM256akUzUEZncTEvUm8xRXdadjFJSHpR?=
 =?utf-8?B?eEIwSUhyOGRKRTR4bDdjTWplZDlaNS9tUXVVZ2NlOWV0UjRVUldvS3hNd01h?=
 =?utf-8?B?MjZnSlFjdStLY0lWVnMxMUlPQUdMQ1JHY0wwMmozUEY2cXIzK1lua2FJV2ZC?=
 =?utf-8?B?YlhxRnY4VTlGRXFpb1pSOVEvN0RFd3BhdnpCemI0MkloQWlIazIxM0I3ZXhz?=
 =?utf-8?B?UDVHcUxMa1c0ckVaMzByNnh5RzdraWp2T09DOGltSjR2M0dlSVcveUNIbzY3?=
 =?utf-8?B?WFg3L3VKVWdRTXpFQ1pPeFlHTENnQ1VTRndyVkR4WHM5WXY5K2k5ZVFRcEth?=
 =?utf-8?B?UUd5bE5RK1J4K3FueU00SWJ5OGlHeDlNNDM3cjBqU05hQkgxYUJIRGxZenI2?=
 =?utf-8?Q?BJH6/DD36wI3igBG0g6iZuY2o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505b9f54-f894-4c47-68be-08dd822d8cdc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:10:30.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vua7amjUyZcBW48hVwSoJEDdlVjaX/g7OsnVO/u8Do/tci8MlkKPIwwe85Uo81oWHyht+7HdTDtSsKoN4qLzeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734

Enable the runtime PM in fspi driver.
Also for system PM, On some board like i.MX8ULP-EVK board,
after system suspend, IOMUX module will lost power, so all
the pinctrl setting will lost when system resume back, need
driver to save/restore the pinctrl setting.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 93 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 00da184be88a026bf562c9808e18e2335a0959e9..23099e60b6fb7e899f95fa0427208b33bc5522ac 100644
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
 
@@ -1249,29 +1272,72 @@ static void nxp_fspi_remove(struct platform_device *pdev)
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
+#endif	/* CONFIG_PM */
+
+static const struct dev_pm_ops nxp_fspi_pm_ops = {
+	SET_RUNTIME_PM_OPS(nxp_fspi_runtime_suspend, nxp_fspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(nxp_fspi_suspend, pm_runtime_force_resume)
+};
+
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
@@ -1291,11 +1357,6 @@ static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
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


