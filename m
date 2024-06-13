Return-Path: <linux-spi+bounces-3399-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902D8907BEC
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDCD284817
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248214D71E;
	Thu, 13 Jun 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l/LVu2RU"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F8F9F8;
	Thu, 13 Jun 2024 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305266; cv=fail; b=pdk2v9USr70uTPOj03wilQXs0PnaUFSfAurq+3k5T54tugvNo9aRMupw7k4C+2cQYIKB13oImWv88A+0n+BN36/U9Jl47tVqqQTLKugmqoGrFeKWPRjY73V8CfCRk5qinRo0G20+2NLpxeFmPgvJornzsMxqTJChSvDY9qAAiY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305266; c=relaxed/simple;
	bh=q4FEChlMBWe7+qQsPtxCF3AQjmJ21gIsWKeyAI0eW5M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jq89dEfr+I5lciTgfDeJWz/2BIVVNgdv0IXrbJ+8WtFWYwSr9DnCDVznVz/hm2hVdXzvVuMFjvJZOOoLrG+qGInfS1PFkoDR78Upy9UdxwImMAiY9bG7t8HfKVTCqQsGqkyTuLsWAQZDRW9BBwsiftw7AOYnCAYyNlQaaIK6qGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l/LVu2RU; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eosc09M10Xz8dIgrRgBqLazqiXwRjkV6TI+v76c0ugZ36yR1vBcKu1Oq9/3j3uVGpr6en1cv/O48PtyEjUL2OufGHGYPVytxKYi1JzZckMAt2nmzMxVdq5TEi8D8Q9u/Avk/2COb61TUCI3lJrwjWGMe5xNHVqahHh6ZXAe4u0vCgyyX3+2kE1rB1kcimhc1s2kOORbTBbUD+O5zyA4Rvj++qBrLh1/rlB4vk7+Sm094bpDeTKuj8KLC3zdgTTxHkZCu/2mKN9K8rq+HouZJcrxaaiQ0PEu+uuasEoXXXESOyr8Z6cGyNIuy6nnt+OMSau732pUXEXhHbIhNZ0IKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQjFS8nsU/xVWAFHmZFbO0nCdjiIS8tAQZur7F8RPTI=;
 b=L7WMXl6POXcCtoQYXXpsmpdiS3dd7ZO2iNlBVvy/YjnrGdjIPFf5ywz06gvk3QXukhlnOLPc8uhdnMDqO2pduWywyBTiYPdDowfvBrQz1byMP9nISjQS8en8aP7K/AaOgXw3cuuuMe+5Tu4Y60P1ZK4G4F5TZM60i5H8yHTAqjsuIgjMIGBXIsu8oEmpHo3Zdy44uzuJf6zz6SmzYVNS9r33x5kvtrWiv2RDswzjNnp4ix6+t0o+1yiRdMq343XcXAUToQcJFuSkMRrP4QMGcfczwqA5RpfyOOAikFUIjrPRAPsKBw4i0fiKb92FHKtjzF+xQVbENDuhGPLzT5A0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQjFS8nsU/xVWAFHmZFbO0nCdjiIS8tAQZur7F8RPTI=;
 b=l/LVu2RUyQxq4nyhQT5XastQqei/SIgqJiEpv/+QBHJRFhPHgFb5vM5CztRsVTEn9usDpq5hhfsdO3ZI4vjeW4r5R2yTMIOJ3he3pP0zitJuP8lyy9mucl1qWQZ82N7JveqzKKxAniDCmexo8/zqgPkuFc3zBhz6GTptJIiV8M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 19:01:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 19:01:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Jun 2024 15:00:39 -0400
Subject: [PATCH v2 3/3] arm64: dts: fsl-ls1043a-rdb: use common
 spi-cs-setup(hold)-delay-ns
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-ls_qspi-v2-3-b288f6f5b736@nxp.com>
References: <20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com>
In-Reply-To: <20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718305248; l=1414;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=q4FEChlMBWe7+qQsPtxCF3AQjmJ21gIsWKeyAI0eW5M=;
 b=++gt9Oiuj8URfl320HFOoWUsqS5RK6YA+iIjCwPRFXvpYADfLJSG2kWYA4JRunL0Cdk+x41IA
 vbCAJGJQxEIAjVkf6ClGPHu3nLxyV54FO8OBJ8tN6WiOtF0rIxc04KC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: 39004c4e-ff44-4296-009e-08dc8bdb2b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|7416009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0R5NTF0N3QvZTBLNnZhWFh6UVFma2VpckN0NVQzV1IyV2xWUlV2Q0p0cXM3?=
 =?utf-8?B?M2srUzVuQ3cxVmcvWmlrQU5wZlA3TThwTS9JbVdPNUM0Z1cyaGorVU1ERTV5?=
 =?utf-8?B?S1BXdWg2VFp5TW0rTmUwWW9idmIyWFNIckRCN3kvdUR4TFpPeUgvNVZvbURQ?=
 =?utf-8?B?bWpReVpMTitzVENibWMyalE2UU5aZHVCbnZReFFzbEZvQ01vaDdaSzJCZThI?=
 =?utf-8?B?NXhtR3BueENFSFRoNHZkdUlVOXNZRUptb3ZISFBDUk4rNmszNUZmU29VNVUy?=
 =?utf-8?B?MW1WV21NOTVsK2o1RkdLV0p3NUM3amRJNEt5T2E1WnhLd2VhSmw5VlVvSWdW?=
 =?utf-8?B?akVPSkRkWGsyRDk0MHZNc2ZYaDNaVjZkT09aMjNTcklWUGJ6Wlg1TElQd3Jz?=
 =?utf-8?B?RC92YitpSEJVRVVMVnpnTFNoTWRHcERCaWJEV2YzTU85QXV6MU9hNkNEWFVC?=
 =?utf-8?B?K0lYRG1NQzhqVXBZanVKS2diemZQSDN1R29vOENRdkhHWGNIc3BNRVdRMm9V?=
 =?utf-8?B?V3V3Z2JCakpOeXh6NDcyTWZZYk9GZTZyZ2lJL05EamRKNmFXZmZkV0lGa1Jr?=
 =?utf-8?B?UDNGODl0NUVKcjlGbUdzUDA0K1BpZFJaYUdIUmpvR0NVZW8wMys0Y3A4NTJI?=
 =?utf-8?B?aDB1cTRJaGF6Zmt1ZG0yNEg0ZlkxY0FzeVJwYUFVSGhmZlZ0aHB6K0VRU0ti?=
 =?utf-8?B?MWpGZjVqRjUxU3hKeVZpbjVTR2lyR3pVbHFiYnNBSnVxamZUalJWUyttOFJn?=
 =?utf-8?B?NjBibTJMZ0EyZGdBQkhidU8vVHp1d1JhamM1OURkV2xSYXZCeTdQSDNWUEtT?=
 =?utf-8?B?cFNGWG9VSjRaSERmNFBKcjZDNnp1bUsxaFo4bzNVcHd6bng1QW9lekc3bkha?=
 =?utf-8?B?cGo3em1xbHFVUnVySHdPa2N6TTNIcWdIR2JyRXdCcUw0a1RjaVNzUTN0S2VE?=
 =?utf-8?B?OUZjcGMrc3JWNDVyN3oydTFTRlV0L25saGY0Slp1YzJvaUJKekpGY1pQR0tO?=
 =?utf-8?B?ZTVKcUZqNUZTNXNsTThDSjJjMXBpL2Q4bW9lM1h6RXZtcmZGeGxZRVNYMy9D?=
 =?utf-8?B?aDcySXJjdmRtSzhkZnpGTkpUc0N4ZlUxbVFUVzl5ZTAxZ0Y5bHlBVmpCYW1V?=
 =?utf-8?B?WXpQZlNZazdaWWRzSE11WW8vM3BJaUZOVUFjNkQ3VGJiU1Y2c2p2SVdGZVhB?=
 =?utf-8?B?bmFyZExrZ3VrTVVSRko0aGdxWlpxUnBqeUtCNjdnWW5uTU9DZTV5K2twd252?=
 =?utf-8?B?VGNjZ1k3U0JEcEZlNGpxRzNXWjFoN3JHdlhDRTNObzBQMDB2NDEwSTRnV2wr?=
 =?utf-8?B?MDdQUEtuZkM2d0YwelVpOUhJcTVqZWtSSFExRHVEb0JaSGtPYXRaNUVwMkpF?=
 =?utf-8?B?TlR4WFpZdEZCV2FlSGtaVWtWYzl5dVhpNXh0OVRtdTR6OElVR0VKTFRxbmJo?=
 =?utf-8?B?VGZINjZQeTRDc1piazJjYS8xTThvR1A1YlJKQ1B2Tk03RFRkYWVXUFF6eksv?=
 =?utf-8?B?VHNKTHFXTW5MbkliYTZRRlpqc0lkNmNLclRwU0RYYkRmdGVLdXVUV2VwRGZN?=
 =?utf-8?B?UzZhS0RJNkc0V3c0TFhPcnpiakxhaFgvLzk0RFZ5cVh1dVdkRVArVzZMd1hJ?=
 =?utf-8?B?b0ZGVURCRTJEQ0VNNUlGUGF6NUprYVpXNHRrTmwwNmtZV2RuR3R6ZDUvUDVV?=
 =?utf-8?B?aGtCanZ4V2VOWnQ0VTVSekRoUEdFYWpZM0ZIMHZkM3BXZ3V6bUZwYnRxK1ho?=
 =?utf-8?B?M29pazEwOVU3WjcwWlVOZi9BUnJMUFBHaHNmajdDbUNFRGZudkNhS0NZeXFa?=
 =?utf-8?Q?AIbklMuCl26hOmZAM9efEyppQ/t4Ye82Reh8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(7416009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXZRRUFKelRPNkYyZ0NGU1VkM1hpbzRPUlg4akpzNGNCbEszQWF2YzkwSmhQ?=
 =?utf-8?B?VlA5RDhKbUljTGwwbWZ6WU9FOHVheXVrY3VwNGRGdlgyc2ZGYlRMRkFTWXd3?=
 =?utf-8?B?NWZ1Ly8veHE0VjV5QnB2cnN2eTJ1cjlVVkFhbjhIODl5NVl0TU01RElUUysy?=
 =?utf-8?B?WitCZmVreXBHbHRKazF0SUViRklGSXRhVlZBTFhGZDlTWmExWjR4U2xkUXFx?=
 =?utf-8?B?aXFrLzNMeEkyV3VQQUxtNTlKTzdwaFZmeU95dllSZThha3Z1QVpjSG1WRGVz?=
 =?utf-8?B?TGVmWWs1TGdndGVrY0dEZzVLNzR4cnFtUkFwMjlEN2NpalF3YnJCWEU3MEti?=
 =?utf-8?B?dGlzTmhwdExPMlZRWU1DSUIzaHlycXg2MFJEOEhrZW03bVdYc01xZHhqR3h0?=
 =?utf-8?B?ai9YTXBSRXh4TGQwWDV1dmQ2SGMxUEtOZ3JJY1NCdXRtaGo5Um05TitkSjRu?=
 =?utf-8?B?aWE2MUR4MkJ1Qmh1emZWaXNPMWI1Y3lqL1Nab2xscVZNaDJhcGRmRnFHWkJZ?=
 =?utf-8?B?VEtUK25sWWNnNVc3b0U1WXFaclFWQUxaRCs2RzhUM2UvVXhoMkpCWUhnenVN?=
 =?utf-8?B?STBLSDBmYmdFUzdENmN1SmQ3Ny8yVkdGd3laMUlIWU4yVDBsTUVmMGVOQnpi?=
 =?utf-8?B?TlY1NEdDUjRTdzlZZENNNnpNaVN1ZjJOdFZZRUEwcWlxczI2Q1FjcjJLd29M?=
 =?utf-8?B?REMydk9pcjBMbXphSW1YdWszdlBZdHlZcS9kc3lKVUxSelpOQm9Hb2ZQTW9M?=
 =?utf-8?B?Tkx5b2lld04yVzN4K0FsZ3E3Ky9VUlRWRGR5cUcrMXlkdEQrVjFNQUVVMllH?=
 =?utf-8?B?NDFwWXVwelFWRmN5SWVVb3hoTEJzcVNhZ1NNVXlDczV2NE53R3lNR1RTVDFa?=
 =?utf-8?B?MW5mT1pXYkt5cU92RWdJeVZJektSbVBwNUR0Ny8yK1AyZGZ6NnlPaFl6TEh3?=
 =?utf-8?B?b1FmdktKWk85N3lzaXMxNWtpT1IxTEJxZ3QvUmNVeUFCRWFiWkdFMEZ3T2dC?=
 =?utf-8?B?ZVNXM3l2TWZBaUJvT21HWS9uQlh2MjkyYklwVExkQTdlQm9tNlVPdU5ZYnNP?=
 =?utf-8?B?eHh5TzY1R1o4RkNQRkxDVEhDWlVQNzN2V01uSFVtZE9JT3JQQWVlNUE0ZHVZ?=
 =?utf-8?B?STJZb0xyZWsrZWg1K3BZNWI1cmd6UWduU0dLRDNMdlREeHI4U1FHdkV1ODNt?=
 =?utf-8?B?SVdEc0owZTNnS0l3dTc0SWowSS9Pd2pBSVRJNkhHVk14UXpDcmphR3NiVTkv?=
 =?utf-8?B?bVYzYzFXQXFGTFNUeEladmdSVVVFbDlHWU1hbjdVNC9pVGhkUCt1Q3NpcFhY?=
 =?utf-8?B?a1hlVXZNTHJCaUdSaXhYNmZlK3ozLzN6R1JTeWhWVjVZUGgwR0I0bHhqc2Jv?=
 =?utf-8?B?MFNGQWJIdVVmRk5ZTlJ1c0Q4NCtXbmZoMGR4YjNnNGNub295cCthbVBWZFpJ?=
 =?utf-8?B?aDhtZUE4bjUvZTdtenBSTExIWXlGMjZrVHZ1Wm9EYXpBMEppQnBTVS9wSUhR?=
 =?utf-8?B?R1Y2M1pmMmpOZDlLbjM2Uis2OHpISEk1STFtK05QUStodDB5MUc3UktDOFor?=
 =?utf-8?B?RnFLcHVBb3g0MWt0TWZ5NWRFYWdRVXVRT2pZUjBUZko5WThMb0owbnB2SW1T?=
 =?utf-8?B?ZStPSWJMYWpxNDdaQjRMMHdvSGVTMlM3aGcxL2c4QnIzbndzUks4TUZwNFNa?=
 =?utf-8?B?MiswdThGdjl0RnZNYjM5dS82YXFOUEh1YXNpMVdYclJPdnRPWmxoWU91RVRE?=
 =?utf-8?B?MzNsZU5vdnhLRmsrSWo3QStBblc5aHo2OFZtVkJVU2NHQzNKN29Lc1Z2YjJR?=
 =?utf-8?B?UXQ2WXB5RTNPUUJtRGR3amJZN3hoY2J6N2huaWludndNOEZhK3Iyb1NrVENk?=
 =?utf-8?B?bk5MR3BieFZsbzRvdGFxZGozSW13TzVLSWVwaFdWYXFGb3JLL3oxYVNNd08w?=
 =?utf-8?B?V2ZoTFRRUnVqRDdkK3Z2Z1JSRmk5TEhFRzNzQ2tJNE5QUUFpWloxdVFaVU96?=
 =?utf-8?B?VE85ZWJpUVdISFlMZ2R4dnB0VTh4eVpSak1YWGY2UHBBSEc2c3JqU2R5VFFM?=
 =?utf-8?B?S1h6MWlFUDdQdkowMDYvYk01TWJpU0FiSzNKZ08zNXpsWjFCeVBnYmU0SFJG?=
 =?utf-8?Q?sSaMOOAXn0HNLUfAmyT68TsNV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39004c4e-ff44-4296-009e-08dc8bdb2b79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:01:02.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvFeNP804FfFWETJTurgVvkWxbdmsTx4Cpff2qKMLxsTh+2xx5B+AQZNKW39wfeLse/zkXKmdN8vV5FxkrbSSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

Use SPI common propteries 'spi-cs-setup-delay-ns' and
'spi-cs-hold-delay-ns' instead of private properties 'fsl,spi-cs-sck-delay'
and 'fsl,spi-sck-cs-delay'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 26f8540cb101b..23b9a8b315468 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -104,24 +104,24 @@ flash@0 {
 		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MB */
 		reg = <0>;
 		spi-max-frequency = <1000000>; /* input clock */
-		fsl,spi-cs-sck-delay = <100>;
-		fsl,spi-sck-cs-delay = <100>;
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <100>;
 	};
 
 	slic@2 {
 		compatible = "maxim,ds26522";
 		reg = <2>;
 		spi-max-frequency = <2000000>;
-		fsl,spi-cs-sck-delay = <100>;
-		fsl,spi-sck-cs-delay = <50>;
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <49>;
 	};
 
 	slic@3 {
 		compatible = "maxim,ds26522";
 		reg = <3>;
 		spi-max-frequency = <2000000>;
-		fsl,spi-cs-sck-delay = <100>;
-		fsl,spi-sck-cs-delay = <50>;
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <50>;
 	};
 };
 

-- 
2.34.1


