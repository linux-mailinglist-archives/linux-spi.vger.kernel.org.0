Return-Path: <linux-spi+bounces-11500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A15C83C19
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 08:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B3D3A7381
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1EA2D9798;
	Tue, 25 Nov 2025 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JCNYbzma"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641632E8B96;
	Tue, 25 Nov 2025 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056509; cv=fail; b=IZGSgiAOF87H0iqmsbqAO5+EQDKbv639CyC27PuQvEUNWJweO0kjTy9KBxBiLsiJATMLYm/WXvvGmERsbPSHspEWb6UF2wzNJvWln+kORqNVyJbweOym/2YVDPaazQbDp7T5tPBMiBN+i9d7n7FdvUDzfaS72Mut3la5IhhEXAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056509; c=relaxed/simple;
	bh=t9nmuF+AYqPYe2xR2QY3YmYZNaePGN4B6+QBkGUOkL8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n3GL9+z/Z3B38uUCSLeNUda1Xo7dpSxglRwq7b45VeBYd8XqIq3ZYu4qBYdciSvvWjtkqc6+vmAxA+NKrxx24FqJRAKPfG9agJPW7nl7r2FwyW+yWof04qWVPqO4+xdZPzK4rmfteKDzbMYdmsEtYgS8klWWhXRf8ND60o/Psto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JCNYbzma; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQavTSCStunyDsz6lh/qxfi1jxHoe5QrMtcLWk1hwr/U3U8oo0vIOlM+kPneZOzFYp1BytiNa4OiyGNYT4y/DxS5L9fMwRXHU8E1Ihpw8r3z+nxCRl1TcWLG+sYaoAMAOTF0t0/Au0QevAcjcMG7kLRNR4GNI5uksU5FNIKkDxtTkgWINxqE9pQ3q5uK8kyirz3L2FwzQubpESEwDePY7utbOx9t+jCSkx2QibFLMbdKAHRtn42LgVVBONFAhKdbSLPUVuyU3AHbeFXKiqKNU5MMWbtg3o7s2yT5jBE/6wUhrcuVypujTju2xWdaLxDvsdwh/kzAluDTnYgv13YbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5pLZFZMfP1dgbjyeHnljiGSzKS0GE9v/YZNqyEaS2s=;
 b=eqTbfXMMhVNFr/MdkP2mHzaEje/HTB9B4K6e6I0IkJIcLnDxFDb7hY9z8rRWiwWkvGpyasG8bwzXcFOGh3EaGMDj8pfejZCmMy306C7Uje26+1HITs3YuY/yD8033rfsS0LW6ZyzOkvlpoqjSL3p7NZ/LjpeMVmsxdNxUV0xVWEEVwKMUob95XNhZ+7WUXBG17hFogaHr1kK+bPfS44hcV3poy9hhOWEoT8bvsT2Nu2MPVZLuRqpBREbEyZ4qYuehzJeQmmLRP/yqybuWetSJ0ktB5//mTvGabxBeHtROrmOyBm5rnL+t5X1PkiEtUtECkQWFlghg+969tAZmKow3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5pLZFZMfP1dgbjyeHnljiGSzKS0GE9v/YZNqyEaS2s=;
 b=JCNYbzma2RaXc8RKlG1JICGMC1UTY5/dmEKB/z0Xd2OuAoZ8hASx+68/RJGVEq+5/GwEMhsSzhwCLpHZJCCMDMWdS1Eft53Y5O9boe+I7sBt5j6R+qqQ5tQtjm7qf+s1scJZDXFt39qcc0iHn6SRigctrXIMx4SlbWgTqR/LqDNyYGPg3I2YoXvn2LrSDgFZ+r1tYCvfigb4FlhJ2p2/DcrpH2ovqwfixNF6vz3BdQ1dqhQ2xvvSjayVOt186DLIso2BOT/5iKoIG5YqeIVFdI9DRwl0nUBH7EK9UAnVezFAGuhkbckvcm/+iQd+OZyL375qJdfwefACzGDM9pEL3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM7PR04MB6967.eurprd04.prod.outlook.com (2603:10a6:20b:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:41:43 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:41:43 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 25 Nov 2025 15:42:18 +0800
Subject: [PATCH v6 1/2] dt-bindings: spi: Document imx94 xspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-xspi-v6-1-22b22de50cda@nxp.com>
References: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
In-Reply-To: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764056560; l=3868;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=t9nmuF+AYqPYe2xR2QY3YmYZNaePGN4B6+QBkGUOkL8=;
 b=gIRxb4/SVDRRhnvtc+4CVB8hIssKFDvZx/zJ6QQhg6tzd3OnzXXz22+2MwnxV8nkhrSXCgTPG
 exCkTAwXZvbAfNZomomcIKmYQzNjbxbYUxLfHAKX/wi44ZMn9F3wIls
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM7PR04MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: b7090bd6-9c84-4fa6-8119-08de2bf61438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWpVVFJpTTI3eTJwZ2FQZjVHcmNkTDBod3ozeG8vZjBqUWFmQzBucktMMld5?=
 =?utf-8?B?UE1EaG05T2pRWDZCSU15ZUFtZktrUHliT1dMZzFvNU5hd1pMaHF0UWlmV2hk?=
 =?utf-8?B?YXprNXhXdXNpYkhBNlNGZHNzRnlDNnlZbmFsR3gvNzFBOG1aenlCOWdjVHd4?=
 =?utf-8?B?eWFEOXg4Q2tLS0d1eCtHcGFIYldlU25qSHpUZzVuWk5iMzYzSzBYT29Bd1VE?=
 =?utf-8?B?bHBvMk5SUmQ4N3g5YXJyS0Q1Qmh4M05jMmY3RkV5bC9lQVluWnR5U2ZleExi?=
 =?utf-8?B?WkNHa1hVaVN6bUxoY3VLVzNSaGovYkFOWUdWVXdIUGNLZlk3cEx4cTdONmRa?=
 =?utf-8?B?TkZrT1c1R3VrcWcyak5xdVdTM1FOb01INU9INDNTNzlRN0RDNnJHeE4zYzRv?=
 =?utf-8?B?NHVscjl2NVJrbi9CMnRJbEV6elpzckxZOGxGUVRxRmxzanFpdHlqT0ZKOEs0?=
 =?utf-8?B?ajdsVFM1K0VOSTR5dlZzRHFSelhVU0d0ZmpuZ1RJeXB3YjdyeXd5ZjNTcHow?=
 =?utf-8?B?U3RXZDlNcjJ1TW9HbWE1MXNOczhURkFYUCtvelJGS00xenAvNUl2UU1qQmNM?=
 =?utf-8?B?bkovdU5iQVNGcW90bmF4ZGFPamFYcjk5SDNSVG8reHlvVEhVY0llNlJka1Rw?=
 =?utf-8?B?dVM2dlpoZEhKVXgxU1ZSekV3U2RBNTdYVGw3VmpxaCs0Z2h1RTNjdzljMTBH?=
 =?utf-8?B?dTAwcmZwZHByR0ozQVZCZVNMYXpma1BwY00rQnR0bHJSNHdGZFMyMWRlNjl5?=
 =?utf-8?B?SHZQNnFvSFl2cUwzT2l6THYwMGpBRkQvMHhLelZKMXVncXYzbGk1SUY3M0ky?=
 =?utf-8?B?cEswQmd0NzdUZmVoeGczend3WXNJaUhKYWFlVG92TzFFQit1RUhOcVV2ZmtI?=
 =?utf-8?B?YlNTeUdnNEIyS3NzTWtnWDc0cGU1eENVc3I0NjlyNEVYNllzdWxrWjhzR3RR?=
 =?utf-8?B?bXlqVlVQWTdnK3VBUGFoSFNSWktiMnVrcUxTcHpSSUN2ZFJwU1ZMR0RudG1W?=
 =?utf-8?B?cjI2ZUdaRHA1WEtwUmJ2eUp5a0xGWjl3MzNlcmtZK1o2VGtNYTNSc2RzMS9J?=
 =?utf-8?B?WmZ0SFBsUFlqZUVxUVFkc1hIUjBzeGc0RjY0eFpyQUE4cXlNS0ZhV2hicWRX?=
 =?utf-8?B?dUh2NC9mQnJSRDBqd0I3bzgyM1B0bkduRWlrRW01enhFV3NXU1hMc2w3WVdX?=
 =?utf-8?B?cGhBVU4rME5ZQ29VcmhSZkVZY1gvd3VSYXg4WStxbXpwb3dzUE1Iek0xUmJk?=
 =?utf-8?B?ZGExNGJRVy9VaWVHcnBiZWxBS1F5WmoxeXF6VEdtdjRaSFFlcXhMKzVxeVh0?=
 =?utf-8?B?empvWnBQTDF2YWgzTXVPSHFsdFRzK1ZudklDM3l1K1ZBcjBVM2pnb2NWeW4w?=
 =?utf-8?B?YW5kbFRjMXIzdStXSDVFRlVNQ0NYSUJYNTBZU0kweTQzS1lONXVzQ3I1REQx?=
 =?utf-8?B?UncwcmxFVTVLekFRZ0xwcFFYMytuYStzVUYzN3dMWlhQNUNRcEtnL2FoOCto?=
 =?utf-8?B?ZUVkcEoxK2V3WmMxUGxzTktvWTV0SjNnbWtXMGhVa1dOM3ZpN0dQVVkrdm9h?=
 =?utf-8?B?MUJuM3RIZTNWUDhRanptZ2gvMU52cGs3ZXNBUFhsUHNUSjdRRVlRT295UWQ4?=
 =?utf-8?B?WmlTVjhKeVltK3djd1VKblp6Nm1yVzQvcjRWVVN2MlFja1JhdDFlOWN4Qml0?=
 =?utf-8?B?Z0JYMWtJclJ3ZnpXa2NIa3ZVSEtlZE9KbVNjQkF1UmZyRWVLVFErZHhVb3hG?=
 =?utf-8?B?cnlQdGttNzlVdGQ0NVQ1d09hMUpoZDdPak5ReFNVMDVJVExEd2pWT0NMcHRU?=
 =?utf-8?B?bE1ucmVFcEc3T0hqMHJzZEY1TVR5c0d4bjNwOEFZczl4M1UzWFdjcDF0TnRV?=
 =?utf-8?B?L2lDMVlNVmhiWkE1RVJhU2NFckl6bXhKWUZYUkpJeEFad0w5NWE5V3pVZnZF?=
 =?utf-8?B?MC93Qy9oTzZPNUlmQlR3QVJkNTdFaFV3clMrUXUzTHowWlNzVUo2YVpwS2w2?=
 =?utf-8?B?czdEQ2NwZ0dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0FEeEtVVGl1N0ZLa0p6TDd1YmFBSGhCSUpDb3FaaWZFNnNra3BpUWJwWUMv?=
 =?utf-8?B?SmJqcHFBY3NjUDU2YnJtMmNOaHdYby9RRmFpVUhXQVNzN0w3VFk1SjhvU0x6?=
 =?utf-8?B?RFJXOG1UcEJiRGVQaDNUY1dpaDhVRHJ4VVJaaFJkTTlRa2cvU3JoWEQzcFFs?=
 =?utf-8?B?bHRnaDNxQ1JNYUxXREI0a3ovTWl4L3I3VUVaODVkMkxlTmVpbVhSakdkdnJt?=
 =?utf-8?B?dThWVVA4Z3MvTDlCcXRzN1ZXZTNVNEdkOElQZmdyYUllZnNBbHNQZEVJYTFW?=
 =?utf-8?B?YldKQ1Z5MWpxbG9tQjBmZ3lLVml6cCtzSFpmUG16NkpaNno3WDc4QTFuRzVt?=
 =?utf-8?B?bzdQSkhEMGFkSi9hUHlhT1hadUYwMXR4QTU1TW4rQzVWYjR4S0M5bE1vMmRY?=
 =?utf-8?B?aFp3bEN5TjhhRE5QQTZlN2p0ZWlOcWxaUFBvemJJWkZsWXdkMnFpR0dXaEV4?=
 =?utf-8?B?dEFHWjFwQS8vM0FsQm1UMlFKODJITzk1YlA5VjJBSEFlcFlMbUh1SHpUaEZI?=
 =?utf-8?B?UVhYN2xzYkgzV2VtVDRoekcxMkhjUUpWQlRCZ1NoV3lrdDFKamhGYldZTzU4?=
 =?utf-8?B?VkY1WjkrQVd4TEJmUVBFQU9DYkM4Q2ZFUXdKVmZEV3Zlc2FtZkMwRml3THVQ?=
 =?utf-8?B?bFd5dWhoL2NuZW40Z00wSjZmbXlPMmZMeUVBR3BBbjRRYWRsdEErZHlHSVBW?=
 =?utf-8?B?VGJjOWRXOGJ2NEo4Y3NPNW10WDJTNVhWYTVHMFJlSmZ1OStXamlzZ2NEUEZl?=
 =?utf-8?B?eUtObkIxcTB0SExCYmJzTkE3VXRZZXAybVNTMGRRelZXSjZST1lKanN4SGQr?=
 =?utf-8?B?elNVNjMxeGpWSjRkdWV5MTdPbDd1ME5ST3JNalpkSjNtWGhkemlFSlNKVy9o?=
 =?utf-8?B?RGZ4NG02Rlh6anF5bzQ2dzI1QkxSd283Uk9ydTdDdk9hWFJtUTJCQVZiWTVZ?=
 =?utf-8?B?dWpkRkRWV2Jwb2NiQklodVIxeTJMcUthU2hnQ2lwbC9oN2I5dTFKS1A2VEwz?=
 =?utf-8?B?ZUNVY0hqaVJzWVFRT1lCN3pBUmJZUTRjaTlGMERiMVpycUpoYjQwU3lJN2RK?=
 =?utf-8?B?eUtiUjR3cG1uZUlsZFdQaG4yZUQ1a0hXRWFaQUt3anJYTzZzSFRXL01zZmRk?=
 =?utf-8?B?L01sNG1Cam9VTndOQk1OajFhSEo1NG5NUjdHdFpkVlF4eUV1WkVDVi9QK0Z1?=
 =?utf-8?B?czkrbldmb3dvZFZzR096MWVpNDF2L0pyRk03UVBOTGRGYUtFS1JQeGhTZzB0?=
 =?utf-8?B?Q0g0MmRLVzJ6emlJR0xWQnBGenZMWHNTek1jL00vT25OMk9mdlRqdVZWMU5L?=
 =?utf-8?B?Z3Q3eWRXYklaVEx6SEZiek9QVGI4czVtNjdmM0VSdEhPd3RwQ1NkMEkrL3ky?=
 =?utf-8?B?WGgvS2JxRGhrYzlFTGY1QitWN21YZkh3ZW1lN1BmTDFTVWJYQXQ4SUlQYXh4?=
 =?utf-8?B?c05ubTBlcmkyNG0yTVRqWS9LVHNLaWc4MG9zUnNuSlk2QkhkS1VWL0s3eWZn?=
 =?utf-8?B?K1lZaDFVb0Rrbm5kc0tjRStaNStRWFcwTFU1Q0RSUXBYQ1dUZUdhaGVXaFF3?=
 =?utf-8?B?VGdIdjlZMlZlMlJKK21RcGVmL0ZBOEg5T3pKcWFKSmFKbUc5aldoZW9EbFNG?=
 =?utf-8?B?TXlyNVpyZzhTcGFZalZ0Zjh2SlZXNlpXSFJsNVkxTHdmNERNRjJIcStOMnps?=
 =?utf-8?B?bmx1ODEwL3BCcjBsQVZmWkJKakhYRzBHdTNsditlVUk4MEc3M3o5NHQxM1Fp?=
 =?utf-8?B?M09xVUpXLzM0WEpVYU1VK3dRUzRVS1cwNFZ2S3pkdlJtQTZsWGJ1ZTFXL0NL?=
 =?utf-8?B?N2kzRzlaTFdKckNObDZSd1VORldhTW9VcXdkVUd4NlZDNnJGZjJOZ05oaUFL?=
 =?utf-8?B?ZTdnMDhuTElRMWpCTjhlWmtIRTVqNkFBaFVWblBoOW9STmVORVE3RXlUMnJ2?=
 =?utf-8?B?bWY5emJuUEwyTkVEWW5MUVovREo3SXlINDdJbjNMdzR0S0NxSk0xdWwxZjBw?=
 =?utf-8?B?YXl4VWpINEQ3MTNrSUwvSEhNS2RVSC9tQWRMeXVTSGJ1VlZoOWlueHMzV0ho?=
 =?utf-8?B?WVZpOHNyUEh3ZTdGS0xiS2tXc0FCNGllMTNPZENaZFMrbGdVTFViTkNacm43?=
 =?utf-8?Q?cd3eK8q9la81KUs83J2K8w2WU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7090bd6-9c84-4fa6-8119-08de2bf61438
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:41:43.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ6g6ug8uEkf2GtDDvd21P2vj/N9hp6B/UmbG3GVGHz4mPKbZmKxy/vStazGJgNQg5H7DQm1PONlp0ccLGrgLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6967

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


