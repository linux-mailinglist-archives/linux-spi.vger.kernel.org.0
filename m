Return-Path: <linux-spi+bounces-11269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1DC6729A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 04:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 038B64EAEC4
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 03:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDF932AAD1;
	Tue, 18 Nov 2025 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHwc5Gsy"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4B32A3DE;
	Tue, 18 Nov 2025 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436842; cv=fail; b=pzm50dH4Fd1QFKYaI5pB97E5vSy2ZqpkAuy10F9eKPpZSOHw8ercXEfcyaYaAf32rgJ+ubcjDToUxLSQuTodo0yNv8wZZBkIRxO+tmytZPk+7mO2OeUX8cGmp3VoYvdLThG0d3G4I5pGkcENf9czzDoEvixFzbQuBfNv6tPflw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436842; c=relaxed/simple;
	bh=FYIvqRaNqoU2hk0ff+SJXcmpOJqQZdkDIi7KqeKq7Ak=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FmhFgYqe8NIDCnump7aIQEgz8nwAPnZPNLCcieLdsPwS0QsCGOgxWDoaqb6l8Qki7WShF709Zys9oxVeAnRdWuObVKk1VGXFin+zOIqzh3gIGFMo4221qCm2I7+eFCafNc0AJS6Nyl/sbgk7vyuSZPNg6QFTZ4KuHKITtRPscjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YHwc5Gsy; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEmxlS8vLr2c8o6bhIuRlh0VVEGznpucL77ugnXN5bWvM2pX4r0om1KNJPBCc8/7r5S+xctakiWqDhSF0d4ayZa5chCetUyVjT0R6TVXIx2sMGViwFGdpfyVwuJDDi/KPVLjmQAzirHmZc20a1k/iX2QczU6ynNXtwN2iW3z50rfcdz93L/CgiLj6JDO/KbZuuKaA91WrRWfVmkN42UHhzHPvrH0//iasuEdEzw1jGCKoZvIiGurbb4Wjc8w7fhd9Ge826ZOhTRFnHZMOlMaKSqoap5LA9x6e11f3iGRBTa889TR4tassxCoKUDNrQNlCPw2ntC4BeLejS9rqc/pVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30mEPyilJXdXAStCRjmG/mi9BOfccSTYA8UD446vBeE=;
 b=SYVgb71rjKuHFts/Gzu0nFVE/YXzo59EgislRF467/dou+O860rNwlHIqs13uvjJsUBpUSvmX52t8jepRuxHWNVzZjP5NmyE9wvBBHPP+xnTmy/+PXfV7PHu9GmFTP37ndDe26Z+0SKnnalFMBUimh7HtB2iglLadqse3jjoOykDV6viQ89iJE6mBUdurE7VKCbhnTZFsMJiu0vcswUcfNJKS/MliLVu+FWSqUdJQ2YYLqaYJgO//XTVpUFy1HWsJJhJTFW1IkmnTreFnfoteSE1PWYi41KLLh+7y1AGYSuZUIJ7sOlADwPaXB1lb/ov5fBfl2lpTNNiUtr4vpNCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30mEPyilJXdXAStCRjmG/mi9BOfccSTYA8UD446vBeE=;
 b=YHwc5Gsyvz/JwwKqGvR/xioCqOdf7DF9zWho2WzbzIK1mw67QzLsozBbDhjJXGXNylvNg+g4cybCW4fL3ezL6TXPJ825VTOKU3l/RhermVIdLw/z0FfC2uBsbxH4lji6cPIV17CAX4cOtBoukT8ZD/WV9WzJaqwH+3Cj+mhADOm+MqM0MtTJYd07cpEGR0LVH2jICUDkSsVbNBFfrOMNqVAL9YfBXrRDci/Kh+HcS0MUMAe4m6YSiG9ZNl8oWr8cehiTmdb8EfHWqVJaSsek5JtSJ6ckYwYH98pQleQJSK0Mq5KBSJB1UtHUWEYojWjB57k5MOXsDDYDZW6oy+z/6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB10404.eurprd04.prod.outlook.com (2603:10a6:10:566::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 03:33:57 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 03:33:57 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 18 Nov 2025 11:34:16 +0800
Subject: [PATCH v3 1/2] dt-bindings: spi: Document imx94 xspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-xspi-v3-1-6d3a91b68c7e@nxp.com>
References: <20251118-xspi-v3-0-6d3a91b68c7e@nxp.com>
In-Reply-To: <20251118-xspi-v3-0-6d3a91b68c7e@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763436890; l=3866;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=FYIvqRaNqoU2hk0ff+SJXcmpOJqQZdkDIi7KqeKq7Ak=;
 b=UuSWJE+hDF/Dvj+ygIbDSs2cAKMTU15m+Sjd6DHx/oMd/YzxtDT1aNhDgSqWsUOXDF/Sd+Rw7
 CcxHmzXbpq+CAMlKQ0fwzL1X+fiScbeQkc/IueLqPmkQ85UnjR6DlvR
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DU4PR04MB10404:EE_
X-MS-Office365-Filtering-Correlation-Id: 198617ea-ff93-43f3-e9ae-08de26534ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnpPWlc4aE1HQmFjUHk5aUg5dDdvYlZTNnlkUXFmOUNxY29JZzlNTjVOWm5H?=
 =?utf-8?B?ZkpQU2UyeDNlemhUS1BoeHZqS0dJVnNyd3lEZVQ4M2U3LzJ3NVZIL3NtMUxZ?=
 =?utf-8?B?OEdvSWhtdFVRRFRKK2p5M2FEMjdEcVVhT29Rd3lDdFhUYk5uNmQvSDJBUlds?=
 =?utf-8?B?MC9tTkZhdjNvWkpiOUs5Qm1OY2s0b2VFcUFGSThUSDJsWnVmOGFzTUxoVGZE?=
 =?utf-8?B?d0wvcVBCZ2JvNWg0SUE3VTFrbzVEc1NHTTVrTzBHUE5OaXNaRjZydmpOSHRF?=
 =?utf-8?B?U0ptaWthNUVGdVZVVzc4Qk9pWHRrTi80Q0h2VFdCYVBrVG1wcHZDbHNCanow?=
 =?utf-8?B?Y3FRbWlxT3RwcEZ3bkhBTUVKRlJuNGJCTGdUYy9oL0I3VDdDRHVXd1JYU1Nu?=
 =?utf-8?B?cEdWWGUzOS9KTDNNWVlCN2JUczdRNnNFVnFmVzlydzdEY1B0SWY5Z1dTcXdk?=
 =?utf-8?B?UGJsUTFGWkI5RDBDQ0srd2wycGxUSjhxYzRNbnk3ZGJQS3ZZM1labkZ0NFBv?=
 =?utf-8?B?ZEE4TFNROVYyTG5mR1RRUlBDSTlCUzVXWXo0NWpLY09VYkFHV01ndWZodDRv?=
 =?utf-8?B?QWNabXkvd1FyS2RPbHI1aUx4dEp5SHdFVnRSQy9ZTzZhZVVPbFliSDJpV2tK?=
 =?utf-8?B?UUhSRGlIVEEvVlRJV1pqMFRmcU9GNDl6L0JDRUxvWlMxSllEYk0xVVp1dE5F?=
 =?utf-8?B?ejlYM2FHMUM0RFVlZWNrZ2kweDFaOUhrZms4L1RQNTlycVh2VXIycHpZaEsy?=
 =?utf-8?B?RlFCVTlqd3ZVYnJrQnpZbng4R2xuK3RXOFVxQzFDSk8wNWRCb2tKR1dHdk9u?=
 =?utf-8?B?Vk5tUC9lSzd3MXNJNjhlbThjM25UWWxlRlU3dVlUOEJGalZLYmJRRWkyT1U0?=
 =?utf-8?B?ZmxmeUhxbHRkRmE4SUppZEZKMHdGNEpjMWtrU3FYTjUzZk1wQmpOSW1WRlhW?=
 =?utf-8?B?clhZQ2dRUUw1K05CRUJlZTJxd1NWc09FZkVNSTVmZUdCd1RQY0tWM0ppdXZl?=
 =?utf-8?B?bGVzQ2lwOU56R0kwbE9uWG1WODJtZ0tSUWJXQmNRVTVyK1V2S2xvc05zYVh0?=
 =?utf-8?B?eE5rcThJK0hOamJPYU9MYTJ1Y0FMWFp0OUhBNkhEdFgyei85U0Q5NWxuN01R?=
 =?utf-8?B?a3Y2QkcyNVBLdHZsNjJYMFM5S21lb2VhQnlXOTN4N05wWDZxQ2UvUC9vN0Ex?=
 =?utf-8?B?SHYvRnRhRGZsK0s1ajM5NUZGbkR5cS9pOE1ES2w1YUYyb3ZkK3doOTN4THl2?=
 =?utf-8?B?U0VwemlneXk4a25xNjRRMGZOVFM1ZnNTdjNXTW4vOC9aWkwyR01YbTFRVzda?=
 =?utf-8?B?b1dtOWh1SUN5UGREZE9QaTVYTWg2eVJTakRmY3JqdmdNR1M3S3NhMnRvajJi?=
 =?utf-8?B?QlVHd1BXbnkrMkxscitxeFMycERhT1lVdW1MUjJBdm9hYS9lVzdoOTBTZ2VO?=
 =?utf-8?B?eVd5b3UxeXhuQ215amVHb0tnQ2N1VW9mMUcvY1NJL3A1UDNQZmptM1EybmZQ?=
 =?utf-8?B?NG9aa0QvcVd0MHV0TWVMSEVlVk5ib3huZUZxZEY3R1JLQUVVaUNrdC9HMzVQ?=
 =?utf-8?B?WjVVbEQ1d2I4dWI1TU9OYzQzNEVORHhjRlFBMEhBT0YvUHBQd3VpVEx1cGZh?=
 =?utf-8?B?TzJoaHlTc3RKdGlkRlNHcHFvTW5aZ01VcGU2WG9MR05qa0ZZaURSMVFjQ2VG?=
 =?utf-8?B?TjNMc21rcHZNd3hNSFJCK0NsdlV3TDhKR3FtNWM4YWdEbEQ0MXBKYWZzMzNV?=
 =?utf-8?B?VEp4ZmhiN3Y1cklKTGVBT1hEZzZKQm83MWZBM2lEWVY2N1RFdVAzaG41SEpM?=
 =?utf-8?B?Z1c5UzFzMzN5L1lJRWpvK09qaVFBWmI0Y2FTbmJrT1A4V081ZzJlRXRLYTh2?=
 =?utf-8?B?ZmI5dkYrV21hOFh2UjRyTHJDUGdWM0pnaVZOdGNNNFFGd09yUUo4VEhCdC8v?=
 =?utf-8?B?ODdjVTVoWW1KYjZ5RC9vY05RTzl5ZzRpSDh5eGs0a243TEV4K29wdW9FTjRm?=
 =?utf-8?B?Vm43VWJBLy93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUE1a0lRbk1EQVpRbm0ydmNMMEZOOHB5bVczWnlQUzB0YWZhS0hDOEYxWGl1?=
 =?utf-8?B?UzlnakY5M1NpNEpqbmpPNkZJb3lCWDV2TVJZMmU0K2k5SldEemRzR0I3TXdO?=
 =?utf-8?B?eDhrSlAxczVZUHY0eDhlaWJ3LzhTbHdOdGh0UnZnd0V5UWs1ODh3ZXlYZEtQ?=
 =?utf-8?B?RGR2OGJ0K0FPSDBhaVBIVVBLWi9uMkZsQ0tMUzNtYzQ0Mk5hNHJWMENkT1JC?=
 =?utf-8?B?WElOOE80Tk5IOEozdkg3VjNzQUl0anNIaWFNdEpoOTduT3VacmtFdldUTnNL?=
 =?utf-8?B?N0xnUmNiYTloVzQ5andGTEtYQi9YY2ZBUHVVUWdKNDZoL0RCKyswR3gzWVlL?=
 =?utf-8?B?Y1JNZDJpMlMwMzFid2NhQ1AzUjZYOUxnTjh5ajRucUhYU3N1ZDR6cisvckVt?=
 =?utf-8?B?NERWRVlIbG1pci9HVStFNXJ5UkFTUnBpcHhHOEdWT2FNd24ydU1CNHFybkcz?=
 =?utf-8?B?UUxqZytQTE9qcEFtQVJkT2JESTJDUjAwaGN3cUVsTHY4NFFFaWJpS3A4SjdD?=
 =?utf-8?B?REJmOHljdkRvSUY3UnVBa2VTb1NEWkhKWC93NTFTMmhZZTluRU52aUxhMlRM?=
 =?utf-8?B?K2thU05FcnN3YTJyY1doT1piN1JYalFBM2wrdzBMNUx1Qy9zMDU5YmNxTjE2?=
 =?utf-8?B?WmNIY3Y0OVV1a3hHb0E0Q1Z6ZlVUeFV2K0dhekdNYytSTndyYlF4dkNjMFhF?=
 =?utf-8?B?Y2pnZ29JTnpIOTZOSy9RUDliSzZpdGJKaDNOSUdiS1h5UFhzd044T2ZjV01T?=
 =?utf-8?B?UHpLOTFwZG9pTERoVFMyenNFaGFVWUpnUENWZTZFaE1IckJhQTJjSVdTUVdm?=
 =?utf-8?B?YnlmL0dBZHRXcjFCbzVsWWJScFBzQXVxbUFoV0dyVUdIOEk0R1IzYVZBWW11?=
 =?utf-8?B?TkxNYTd2UGpEY0hiS0VuczY0U0s4czltblJkeGtjdGgyeEZsUXhLNDJGTDgz?=
 =?utf-8?B?eDVaOW9QZnpJTUVISVRCM1l3SHh5YzExeVhMc2tWbDdXMlRaRjNCNG0yeDN6?=
 =?utf-8?B?THNHLzloUEI3eXJldzRzU0pDNXpDbXpiRldNcUNidFR5L2F1S1dMbjlqMFNy?=
 =?utf-8?B?Ri8rTXN0dzVNMW1ZZTdWdTg5d3dnTGplLy96K3FZWjBWS1hyZ2txQ0VPMWRV?=
 =?utf-8?B?MHcwQjFBTkRGTUk1QXhHajhRWnc4S0lETXBjSWtSUTdQeW96d1lDaXRnd2RC?=
 =?utf-8?B?TUhLVXBDSFJQTlZQOEUxNnVMVnZOdHAydXlEeTZpZklqcFhCeHU2L09rUG5W?=
 =?utf-8?B?NXNDRlN2UkxCYTVMQnhBdnk5ZGF6M2d5MmtpbUxkQ3h2V3JZQVVsTGxDd1VK?=
 =?utf-8?B?SnBMZ1hFL2JhelBKWGswS0lhUjRkNmN5Y0tGd2RHN1NZTGtaZ0ZWMmxTOE5i?=
 =?utf-8?B?VEcva3JldlFmVUNuWlAyWlRkbC9INFdOeHMwbkZYaWpSUXhmc09HRVBPZU1S?=
 =?utf-8?B?bFRONnluOU4zcTJNSjdkNVhzVDdhRVpJbzlkV20xVlRUWmVaeDBmeTVCWGhk?=
 =?utf-8?B?cEZSSnB4R3JKSU5CVjdKMVlKU2NXU1Rta0cxK2p5QklqcFhISzRjMGVWK056?=
 =?utf-8?B?SnhuNkQ0MTBqcTdnbHVtN2w1N1JtT2VMQ3ZLVlJ3cFE4QkQzTmU0Vzk2UFpN?=
 =?utf-8?B?Mm5qc0I0OVhrSU1KakkrdWNMRHBESWtTdlZKOTh0VHdFNm9wZXVNeVY0ZHhx?=
 =?utf-8?B?N0lJY21jRGc2ZHpvQUg4ZitIYnp2dStoVktSVFdmdUU4WGcyYmJYa0orSW9T?=
 =?utf-8?B?VmtNb215TndhMUE1Zm5qdDN2MS9FNGNJejlKUWZoT2F4RHV5MFhGSkVERTA1?=
 =?utf-8?B?djFCSmcyWlArdXh0NWJBZE1JWXRZbE11dStCeGpsSHBmYlJOMTFiRFgyNExK?=
 =?utf-8?B?UVhaQ0Y4ZzVhS0g5NDFBRUlXSVBpY3czbDR0NFZ4T3lSMnBjVWRDaXNNWkxi?=
 =?utf-8?B?a0NrbklydkI5L1JjeTZhOEFkS0p3M1BiSkl1eElhcnFGd2FBMFF6S2U0YWFJ?=
 =?utf-8?B?dU83RnFxVXd4YTVtUVluL2pHV25lY2xVTEp1ekp3OGRDdHJQL3RCREwvTXRj?=
 =?utf-8?B?ZElqL3c2K01VZm9mbWJheXdwVC9UclpRT1VoVlR2bDBxdmIzazgxUG5UV3My?=
 =?utf-8?Q?YugGAG9LIyzOF38SY8jldioqD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198617ea-ff93-43f3-e9ae-08de26534ea0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 03:33:57.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpXsNbA1KmN7bBFeV4x5GJTb/vf51QWXzhhRxW+1zyfAlYQuW6fxzD2r7iCT5kFvNun34MZ4hoDU228gGdZJrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10404

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
index 836ec73c604d6db452c63fd155d6ae9625da24e8..2f17f925ee23dd90acc1b4bf25f158070cd2b65e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18846,6 +18846,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
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


