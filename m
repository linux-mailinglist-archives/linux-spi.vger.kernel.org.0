Return-Path: <linux-spi+bounces-3396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7988B907BE3
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 21:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B7F282BB4
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2541137905;
	Thu, 13 Jun 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dhEjWAst"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05502F34;
	Thu, 13 Jun 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305257; cv=fail; b=ByzM7OhlflGtU1evUtbPc1DEqpPg+cuFL69/Ui8boVXYRncRdlYawG+rLsxzxXfi78XIxXEgIIo4711nkL+xpSRz7yaZBhy/uTuFtuzFjyy+PwY2VgJQ4VlYUNcxKrqpMtdJ7r3TjwFmcVMSP33+PDhQOby/PYv5bLmCbr3xIak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305257; c=relaxed/simple;
	bh=bp2CqPQj9e1L7ZUVCEd+6JZzs5bCZwX6xdjL2vNhsh8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=cDSpHaw9JzuVwpuBB3Cke/EXx1KOqePnATbQgX4aqGornZr+zU27P66zBiFTGj0Qf7G+trqXFBmAK7UBuzgj0Elzx2uhcO7AOt7hEBHbHiFDuaVxORMRfBWcBic+h3ffV8Bd55qpshzlNNcmxEnU6r5C6sHjkEU6SlNzSCfxthI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dhEjWAst; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGBAUnAKlLnEkUY/uENXX4G6eZmZpaHhEnW7OVKbDD4fXrutUvpBLjqrgvNHho9/Z1ZQe/h6rawcqS/gh40oTYtb8zfVl8ouTydW3b+gTFoDpdYHz3zDFAgK6gMm1iBcPTHj5K0uZoYg25geb8+CyqhqCJqBS7AQp3ABP/DdeOk0g3xKJar3T9g5PVKRD8R3bMah3xFJ+v2okBbZGYPnjktqfnTV42oddQpSKRaNXFR5pAYqPJPH71K90lJlujYO+mkG/XFrO/Hy6Jv4chPPcFgdZEYgezlKf5nu5FOans4jnzPYkLW8pADHXos8j5/HMu3W3THmqroenR7j9I6ZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxKH/qIic3iCuVIyy6jLNuMjeR8izpHoh7jKAAp/4SE=;
 b=jX6e9gOuhDMRLDvJQomO8O8SHz44PEN7aSHno9NJJEAH+3yGAMHYxG4DSsN6+5MXrGj/GLA15bNWTwBy67i3OsKcmwfmyBZYkrbruDSEqO79ddNDMM+Uhchhi25E613WdpQPr/T7Zsgh2UCmk8Hi266w1nq7qhvYc5psDzi9LIqW/f4P+mw3OaN/LLx7cvBkzAhjz+R9OHaOtpwtyzoFPgwfB1d3KuFA1UmVYD9IMqzXrXIbhskmd6dOobPT/PllBb/Le1ArJPJa6oRxS49Cmqw6aEI4JaH6qWVO6nOOoDU2cHq+hNZWZGW91/pFIds4jCzG6brXzG4njm4WDgQPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxKH/qIic3iCuVIyy6jLNuMjeR8izpHoh7jKAAp/4SE=;
 b=dhEjWAstU6Bopga90mm7SRp4dGCrvZ7BIgjO6JNT+cxuStSlIVbptkk1oLSEOr5Jga+1TnRQxTKDLjKJurDee8vXW5Oa2tAyCiYe6JpEGosO6gs4Nnzo/DuaW/ySk6NNS6YQFeyfrG+uCJTvJbNoP9JyMOi4yEkS0ivwOR5WGhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 19:00:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 19:00:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] spi: fsl-dspi: Convert to yaml format and use
 common SPI property
Date: Thu, 13 Jun 2024 15:00:36 -0400
Message-Id: <20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRBa2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nj3Zzi+MLigkzdpJTk1BQjg1QjY9NUJaDqgqLUtMwKsEnRsbW1ALg
 5g51ZAAAA
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718305248; l=1340;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bp2CqPQj9e1L7ZUVCEd+6JZzs5bCZwX6xdjL2vNhsh8=;
 b=MvgnKN9wFZ/pxNKYslkjb0jhJTMZDOcMXmPeQJnPsMF1/gLliNjCHOUj3XIvQGmw5TcJ2Ls57
 tXI5qA5ONAsBAnfIFNFVtIHSxmnJESOp7vVfWqrfLMFZ3rILjWdfnu1
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
X-MS-Office365-Filtering-Correlation-Id: b4f9e630-d0ec-4e90-4185-08dc8bdb2541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|7416009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODd1QU1UcnVKNWlqSko4dU80dXRjendoSndyTS80Mm5VZVBDSjJLUy92UDBy?=
 =?utf-8?B?ZmNKaHFjaE4wd01iMTJyOTVieFIrM1AzVVhhVGRLUGY5eXBQd2UveWhiNzdS?=
 =?utf-8?B?VUJHaXBOZmk4aVgzWE9WVmdscms2RExXOVg0UUJPRjRMVjV0N3NHTEZ5cjVJ?=
 =?utf-8?B?VDFSNjBUV2Z2Q2poMUNjci9pODB4RUkxR1hyaUVUcUVvVW43YXFqa1dtTDll?=
 =?utf-8?B?ZHJOY2N3Mkc3WE1UQkw4Ry9jQ3hreEx5MVkzOTlIZTdrRW9ZbGtDUWs5enN1?=
 =?utf-8?B?OTc2MERmR2hQOW5XS21mNnpOQlZzanI4MktUNzN1aTBPR3JUQ3RDbXlTdVBN?=
 =?utf-8?B?L2IzL3ZvcnF5VlJyZDA3OVZiSnc1aVdzM0pKZlAxdy9qVVp5Zy9MRkJwaHp4?=
 =?utf-8?B?ZzlrZWs0VDBOTmEraFVjaWlucmFaVXd4VU05Y0RXemtSR2lYUUE2Q3c0MDZX?=
 =?utf-8?B?N2VnWFdJVUwwSHB3eG8xaXBFUWdZS0hUYklqZTJSVE96RlBtNGRPVmxrY0lN?=
 =?utf-8?B?WC8ySkd3U0xLQXBBd05tTFllNmRwL3dQZFl5dGh3YjdQeUFObjF3WlR4aHdy?=
 =?utf-8?B?M0kxYnZIUWduU0JTRVMxaDVjRGs5d0R5dGFvWkhBN2V5RVZUeGRDQkFlZDdv?=
 =?utf-8?B?WSsvSjdHZS94bDZuQWJ3ZFVTaE5QOFp0TUpUTEkzZlA5cW55cTVFSXVicVkv?=
 =?utf-8?B?YnRBYisyUUJWTTB6ZDlGZ0pERjZOTVN4RjRiZStvL1ZieFNBZ0g0SXFJOVpY?=
 =?utf-8?B?alZqMTdqUlY5S29HM3RCN1MzMEJGa1F0VXBMSGw0cXg2VzNuRGs5NnViaEtF?=
 =?utf-8?B?a0t3RGpaaFAwb1g4aGJ3WnhDTmZXcXFsOE94QlhRMno5ZWpEZ3Z0dTJPMkVH?=
 =?utf-8?B?MVhRTVBOZTJySDRHcEZOS0QvcXZFeHliVk5DRmc1TEJBRnZqblAyL3J4T25P?=
 =?utf-8?B?OFdQZkU5TjNZTkNaWFFhVFp5clVteHp6MnRXaUZOL2EyaTFRRGNyZGZhYm5j?=
 =?utf-8?B?TTNYcXVSV0gwVVQ4VUxzOXBEMGFJR3g3UFZLb2FmMUF5MVNlamZOWk9VbHRF?=
 =?utf-8?B?cTJTYm02Yk5ZaDZWL05YRnpKSHRoSFAyMmlabFdWdE54TmNwclJCdTJrOGZ4?=
 =?utf-8?B?S1VFSHJuZ0lCRXp3SXM2akJlb090cmVpNkRSZG1wKzZKNmV6MDZEb3hkWjdD?=
 =?utf-8?B?ay82ZXdJRlZscmFSdXV0bHZUK0JxaEpRVmpyTkcyMTlBUURHakM2L2VOQnZL?=
 =?utf-8?B?UXdsTjJWZG5GTHpVWis5bHdMbmxFYSthUDQxT1NBNW5VdWZhSk0zMnF4Umpy?=
 =?utf-8?B?dWphWGQ3SUk1dDM3ejhQSjFDOEdpSnVuU1hNZ1J6dVJjbGJHWGhpM3NsbGxn?=
 =?utf-8?B?cjFQVTVHdk14WDc5WWIrcGc3QmIyY1NabTl3enlEUUNaOTFtdnNuVHQyZWpC?=
 =?utf-8?B?dFBpK1VYdFp2TG5CczdGN0thalV4NXdwNzhrM1dWRy9JLy91c28zRVNWbzA0?=
 =?utf-8?B?TWpFMXp6aUFncFdyQWJmMjdlUmhDVUxUME9uL1FmdEhKTzl2b3laeldoRitN?=
 =?utf-8?B?QTZyekpsbG5hTkN2WVRETVRJNEozZkd1OHhlaVVDNXo2S2JPSmZ0Nm9WcHJJ?=
 =?utf-8?B?NzViUkFyTmlvbUN1aVFhcHVhN1owbkNGVXcwcTV4UWhPd2dYcGxWa1o0U2to?=
 =?utf-8?B?SVk2b0xmV1A0NVErOWJCelNXM0QwSThYMTFndnVnVVVhbmFJTzJ2NllEMm1S?=
 =?utf-8?B?TEVXYWtKR0RHNzdJamdid0tSTUQrWDd6ZlZ3WWNMa1lqR3hYZ29rZ2pYRVhH?=
 =?utf-8?Q?mO8guVM2zhi3kToJPt8V/qLy/UynvSFQkJqx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(7416009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW5DWGZLaWVORC8rNkpSSGJ6NndQc0lWMWxCUlNUQlJKcnIzT003UDR4ME9s?=
 =?utf-8?B?TS91S0NNdFpzWVRMRlNVa01hNHVhVzA3QkE0RDh2elB6ZG94cTVMMTlwOEYw?=
 =?utf-8?B?TS8rTW5QRlBvQU1VUS9XQllQcTBCMGRXUHUwNVRHVVVHQk1sMmtnZlRGMGZS?=
 =?utf-8?B?WXB5QUFqa1RPekdYL0RtZEh0L0hORm5pUWNYZXVRU1Z5MWNPd0lJRVgyYVdv?=
 =?utf-8?B?QWZ6RWk5YTJtZDlBZVZtMVJLZlB4bDVQa20xMHF1cURYME43YWJjOW9idDNL?=
 =?utf-8?B?bWI5ZUhFam0yampuZWlJeEdiWmorVktBUHo4T0QwdGtQNlAxOU1OT0tmV1R3?=
 =?utf-8?B?bmlUY3BkQ0k3MllZQnhNWjNMZCt5SjMvTDBGSEFpZ0xQd0FTZHRIV3pWdzIv?=
 =?utf-8?B?OUFBQ05BaWxuZk9uYk00WFhZWlRyenZYUFY5U1dSSXRLbmF0OEt1WGw3NG51?=
 =?utf-8?B?V1J1L0hEbVgzdS9sWDBUNER0Ukt2MVMxd0dwQjRhZHMvZllLWGtiMENFdjR3?=
 =?utf-8?B?QXFLcWRRaUlLQjNjS0xqNlNaRGhYS016SXVFQlVpaHBOM2srdUF3ODVrMitq?=
 =?utf-8?B?QUYwRStnRElCV1dvQWhHZkRxb2FpMVFJaHMwekRLeWh6SWJpMk1zNElpb0ox?=
 =?utf-8?B?U2c1UmlkMjIxLytHcVlOWEwwTGdqUDlUSlZlVFhnV1BvVGZlbG9BRmtHMXgy?=
 =?utf-8?B?amU2cFB3YWR1Nlp6bXRNTmdDYmRvL0FUVEgxakxRbXp2VHIvd282akZDYWRV?=
 =?utf-8?B?bHI0RkgxaEhUT3VVK3Awc0VSVnFnTE0vWXFVV3V0L1NiTmY0b1NVVVFKc29X?=
 =?utf-8?B?WEgyM05SV0Y5bGdLK3lBNy9ldTJaNXU0M3hCNExZNGdrT0hmbDMxNi93SUxt?=
 =?utf-8?B?a2JJNTEwaGpYQ2YzRFZOYUtxbDk3SFJiNTlVTWtGN0pZY0NIekZzZ1hTWGRM?=
 =?utf-8?B?MEQ4UVQzYjJINGZJbkNtaThPN2NjMGliM25MMXVSTmNlS1BPcWlCZGx4WDZs?=
 =?utf-8?B?TEgrd2toQkVqcHhBVjBqMGl5eWpNckVCcFR2Tk9nTkNPMUlHcExKTGFtSXN1?=
 =?utf-8?B?NWhDdFBSVUlab2VKcmoremxRL2pHTVFVVGR1QW81MlE2L1prcDFndHdVZzdh?=
 =?utf-8?B?dWgvcDhHRUIyaHpYT2tTZXFkbFdma2RsbmR1cUJUcXhhM2U0a0krOXQrY1du?=
 =?utf-8?B?NXRuQXhJcUJndWcvZUUrbC8zY0QxTVllQVhtbnlLcTRaY1d4N1d1aU1LQnlz?=
 =?utf-8?B?cnBDNmFyWWZsSHh2UGxTbmxadVZKM3RNUWVIbDJrbDVwd3FsZlRIckNta0RY?=
 =?utf-8?B?V2FLaTNOYndUaVE2QUpDaCthVW85dGlReFhQUW5Fc2oyMHNnMEhoNTBFWU4r?=
 =?utf-8?B?dFFxM0xCNlhBcFI1NVFoaVRYVnJTeHovT2FjMitmdzU5cXVMVTlOTzNVVVVF?=
 =?utf-8?B?QkxDcHFyY1U2SDRlYUNzNHlGWndPT1hTdFp0Zi9BeTdlOURtbi85WHhmTDVj?=
 =?utf-8?B?WmVSSEcyYlRJbFE4bFo2b3hiTXZKblBPNkZSYVVHOHBheTViS3hhQTR5K3dz?=
 =?utf-8?B?S2lyQm1HRXYyRlBVeE4zb3l1TzNKQVF5YjZnVTRhbUg5NjV3WTJnOEE5Q3JW?=
 =?utf-8?B?VHFxODZaNkVXLzZ5WnhCT3dxV25FRmRiRFVzS0pJK1o4akRNK1dmdndsL1l3?=
 =?utf-8?B?TFV3dEl0ZnNlUWw3Z0Y2QTA1Vm5SRmFnRUFqSGljVXVwdis3MlF3Y0pnR2xi?=
 =?utf-8?B?YjhwMDNOUnZBNDA0dnYyd3FNeTJqR2x1WnYxU1piNG04ZzQ5TTYyVkdBaXdh?=
 =?utf-8?B?SVl4MGwvcFN2YnJPWDNiWjRGdW1tS2tPbkRaYmNldlh6Um9MWnoxNFR3UCtO?=
 =?utf-8?B?TXlpcjFQMjRKSmxVNzVMQzd3STNDQ2o5UWU1M0lkUklJcVFMNGZ1M2tZWlBT?=
 =?utf-8?B?aE4yZmpvT3BRY3FVL05qbjZPTm82YnZ3VGxpUU5pV21HRyswV3RUb25TVnlx?=
 =?utf-8?B?YWhpZEdtUlN0NlVTOWtBb3FEUnJ1SWp3enZvWTgwTmhFYXV5NmFGUlJCRWZF?=
 =?utf-8?B?aUZuQzFBcTh1YlQyWnV2eHhTbG5tR1NlSm9wTmJvZUVwTHg2WlBML3BXaCt6?=
 =?utf-8?Q?8/BQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f9e630-d0ec-4e90-4185-08dc8bdb2541
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:00:52.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ma2bVzcALb7xcor6+Vil7KmrhEnlNLr6f83sscqVQo7loxWGW86X6Hs8fsAj1EyHj/QqfsgaCydFh/TmmFX2JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

Convert fsl-dspi binding to to yaml format.
Using common SPI property spi-cs-setup-delay-ns and spi-cs-hold-delay-ns.
Update driver and ls1043 dts file.

To: Vladimir Oltean <olteanv@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: olteanv@gmail.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
      spi: dt-bindings: fsl-dspi: Convert to yaml format
      arm64: dts: fsl-ls1043a-rdb: use common spi-cs-setup(hold)-delay-ns

 .../devicetree/bindings/spi/fsl,dspi.yaml          | 115 +++++++++++++++++++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 ------------
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  12 +--
 drivers/spi/spi-fsl-dspi.c                         |  14 ++-
 4 files changed, 130 insertions(+), 76 deletions(-)
---
base-commit: 03d44168cbd7fc57d5de56a3730427db758fc7f6
change-id: 20240613-ls_qspi-bdced20e235e

Best regards,
---
Frank Li <Frank.Li@nxp.com>


