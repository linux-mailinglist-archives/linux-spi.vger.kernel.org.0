Return-Path: <linux-spi+bounces-7722-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD69A97EDD
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 08:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D985316A581
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 06:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E156267AE4;
	Wed, 23 Apr 2025 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NuB+hfJ9"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDCE266B4D;
	Wed, 23 Apr 2025 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388641; cv=fail; b=bMX7paGJtI7mFkuDnumyNpMxASy0UqycsBcIZX51f+r+AHTQLUsw0deWiBUYzQ+gzxE1+yjO7waA/D6pWHfbZaA+apQuW0vykcPCxlKGQYiVDJZbhxX7KOk98pHakJRAeBrlTcP9yXX+ngnAaZzpCR/N5GNCn77sEyJ11baCswY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388641; c=relaxed/simple;
	bh=fUn5jDyhYUsXm23/ABNx1XTbcYMXnPQqJeOIadMWw4A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cbzoe2PEzzHsQXyiLIEC/hEVuOiX/01RwLa7T5iaIGoBSwuY5ElVL9kKaSjAOBjjTU/qviJk0ZFXajO81cFCp6cNcKn59/vq7/Ao/DULUQUD7LpR/b/LyP3El4VOPL+jq9CrQ8SwJzYt72WSaLsJnHq+GQwFdQMtoOfMawxPfPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NuB+hfJ9; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKMrIadI1eqA900yAiWJCPAPEQ4SwNp6gAfYH/ZIcaH7491lu1KPhd+q2pAqWMSfiHwMzCPewVXzvOHsMgHK/JlSljKvS1MA2uNG/P3ZFQ/BN7jHVPjfpwmTp0kNZe6j5+dJnTnnKs7c+A45/myTRNQAuGZC9kAx+c8VkoTAmMhdU2BpxKjZZFYCuJ3ptzK5vw31R9iJNDNybT5SzMqOzLvCtKWaVWZnUZpgCE8Zdrfn4YKSePmDitqhcd87NAj44SLg5SiOFDJgzeW47VwjmU+Csn/bq2oZQD785DOmEiIAQmKHt+SQwV3u9dgrDFITeA70PRMBsckwseiKG4dMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaM4Glkti3o9Y90EVkqIzQvnPwfcMdA0hPWqHJldfa4=;
 b=EDBcUAipSpa0/p4aTCEySlkFYrbSh3pvnwgzXftWAhV4Pwzm++9pxn2J6l+6ZhhliFWZn6kI1ppRp4zpLQagHpB2kBdxKUIWJtCiwje+EAUKPTuoy59UAjCPhB2TFv6qFtJ1iQgc/0UyVpTyRN0eMmtIE6JJVShiHQIIy3KZe6nF/sB3MvUrwItsAGfVNciVpe5Ag8y9yuq+TDkFyaQBYw7lyzG+UdtOO0HHbHv6r12R3YemuVNLLRUXpjPtEq2S57BAEDhz9pQ5DH52Pu82c1gUUqFAoeOnvhfdHEeRfTL6bXK4aHJ++KMoy5fKoYmNQhARYff4lP98YjTUaMSaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaM4Glkti3o9Y90EVkqIzQvnPwfcMdA0hPWqHJldfa4=;
 b=NuB+hfJ9T3ij5rFlRffoAhrTAMppdfZok4GwY2ggnok1j9fApQaHjM++6XCM5uC2aBQKCIk6KEunLFHd1VDkv9uzobXHmYwGiOsI7jexISsQ+KGq4B03MINCwPJUrcL5aFHAri3nQzODz/5GBMEiIev2qRg3yZPntcp1FDEltsCC5ejIaDZtEjnFwBJQCtmnUbhxh23y+Eh7ENngToVf7zvMX1CxsMvCiSmEY0aCxbKqpqBULovWWL+2zsRZf4LBl/ybiHCrMY0TMCoIV1coDRqBMvT59MXw1h3nKZFKHyNKZERHZRJsc7eFYY8boh5Ru297cLTedeVhTmS7qj35hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:10:37 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 06:10:37 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 23 Apr 2025 14:11:41 +0800
Subject: [PATCH v1 4/5] spi: spi-nxp-fspi: remove the unchecked return
 value for nxp_fspi_clk_disable_unprep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-flexspipatch-v1-4-292e530509d3@nxp.com>
References: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
In-Reply-To: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745388747; l=966;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=fUn5jDyhYUsXm23/ABNx1XTbcYMXnPQqJeOIadMWw4A=;
 b=eVxdYdwR7re0fR/TAD0W+OZl5S/cvtN2bsy/8ntMy4h0rjmsOm65gaih5CyLgfHQTVvHPXZma
 pMCuloEz/ZIDasmG7ajOR0JqLNL2cvaXaS4/FT81m8yOAwK42mzI/MK
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
X-MS-Office365-Filtering-Correlation-Id: 5242c6b2-a5f3-4fe9-9205-08dd822d90c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnlwbXVTNCt6c0tFb3NVKzNVbjZZNmZ4KzhZa0haWjNHQWppdnM2K0N6NUtV?=
 =?utf-8?B?Y09WZW43RzJleEVvOUFYcHhuMXd2Q2QvRVVnK0dicnFCMmZ5ZkJZMHBwL2dG?=
 =?utf-8?B?QjdMWU9yVlZnaFBuWE9rU3VzQWc2amxZR1RwaVFFU3crSUJsakZ1ZXNDeHEy?=
 =?utf-8?B?UHBuQUlXVmZjNXI1dWw1elhvaUorY3lpcHBpVVdRcVduWEJlSVlHaWtodHpG?=
 =?utf-8?B?ZnpvWnBhakVJV014TDl5ZFM4Q1VGeEpXRnhWdm9maUJSaFJzUDQ5YTc1RTQ2?=
 =?utf-8?B?YzBTSUFMaTZBNEdXS3RvRnhGbkJWc0hvYngzUVVucWtWa0xrVkhmWVdwWDFo?=
 =?utf-8?B?bERUNTNFeE5KUUsvUkdnUkVaK0RFVVRFZFg3WkJUZjcyZU5pT2k3WW9QODBr?=
 =?utf-8?B?aFA3QTB5NldHYjB5bHcvQ0NNLy9VSDc4Lzh6aUE1V0VGVmNSWlBYNmMvVkw0?=
 =?utf-8?B?VC8zV0dkMlR1RmdDN1ZqcHNqamtrbi93bWttNmlWZ1VVY3I1RUNGOXdXdlNM?=
 =?utf-8?B?S0JDZzM4TExMSjVqMENLL240V2F0UjZHbGY5UDV1dGtyR1kvTy9VQW1VWGly?=
 =?utf-8?B?ckFpK2d3SmZPVzhWTTM4Qk9Gbm1qU3BoVzI0YUtjRGhHTUhacDNIMnVvR0dt?=
 =?utf-8?B?amRTRUFyOC9HNGpyUzBIaTB1SlpkeXRQL0lYK1NORjFBNUZWQU9EcXJPcERV?=
 =?utf-8?B?amRVUjJXTVR0ZnJPaHR5MFVhUTJrN0JZZ2ROb3liaHJnWDhlUDJ3b2hmd1lu?=
 =?utf-8?B?bnZmNmk4SjdJMTlkaDFNaGo5L05QSSs5SHNvelhQUy93YU5PT0dWV1BrQzRj?=
 =?utf-8?B?SSthaDZmM2o1TzlLS2FDMkpVYzFmbWt2Vk9oQ3ZPUEs0b2REdld0STArN3RB?=
 =?utf-8?B?RXpPZUcwSDV5TGxRY0VUZENrYlhtZW9BQ3dhb1pOK3gyV0E1cXVKL3JVZGh4?=
 =?utf-8?B?bGZWV05VTXlMT0kxclpsUkMvSjZkVW9hUG9NVXlCVUhadXpTWTFhc0dENkMv?=
 =?utf-8?B?VitOcWJMcmJWNG5seE94ZERFM2hITU80ZkN1c3hzRjFVQVJQbUZFOG93K25w?=
 =?utf-8?B?SVp6S1E0ajFyZHkvZlVFNzZaVXNLd2tkY2hnY3dXNEpTRFRJbzNVMlI3OEtn?=
 =?utf-8?B?VmtaOC96UFBhL3JnNURDODlnaHlydThMYitkSVhoaUNSWi8rdjJkd1MzUVJ3?=
 =?utf-8?B?bjRoMGFFbWptOVpnekZXLzdlSUs5UkNXejdvQzdReXFIbUxqNWpxdmMxTTMz?=
 =?utf-8?B?YzR0Y05GMGZmcVNseHVIMmFJaStJMnM4SmExU3dPclpSSGppdXUxQW9nNnJB?=
 =?utf-8?B?bnphTGJoUEpBSyt0ZzBYRmI2dFlIRmNGaDVRTEtaVjIvcFNtTVA2K3B6Skpy?=
 =?utf-8?B?aDI1azVTdUlIWFJKUWY2Rmd3cGRuaEsrRkZ0RlVsNkxKUW96RzBtTU9PV0Q4?=
 =?utf-8?B?R203MXAzRkxPaHNoYkJtYXdHK2FxM2RydUtPNHE3TlIzWkw2NnRka1ZyMm10?=
 =?utf-8?B?ejJHYUhBQkxoaVhvT09YQXVtcVBGbjRlUEJEbXlpQWtSU2lIeExEMXVVQit6?=
 =?utf-8?B?S2JkTE9saWNNRXNaditSSHVHZEdLZTYyK0hwMkhLdHFmSDBVRUNPNjdNSWpq?=
 =?utf-8?B?MklOV2c3MWNKZzZOekxwaFpEUVJ1VGxGRXdWcXRNbGxJMjhHOGdWeG13UUtF?=
 =?utf-8?B?S0JoYXl5bWU2K1pIMVFpTEV0SVVIT0pyN1ZBc0V2Q1VrM1hzdE5SR25OVTFQ?=
 =?utf-8?B?RzJKTUJETStQSUVmWmZmbk5ibFppL2FqOHB6a24ydmpzSkNrdFJuYldrQzNM?=
 =?utf-8?B?dDdPc0dBQ1RDejJFQ1k0czVLZHA0cDdZMEQweVRQWGdjSTArVEdGVml6ZWd6?=
 =?utf-8?B?Rm8xcFFEN0l6MWh5aGhLdHFJd3FBUXdXZjF2ZjJNSWl4RnoxeW1kVmtnWXh2?=
 =?utf-8?B?MXppUjVOM3o5WG4vY1VCSXJCbTB4ODh0Y1NLUEdlMmcrZVdHY0I4VHd3NkJx?=
 =?utf-8?B?RDFRczBoWDlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxxZnhNRlpVbVpnaUJ0bHZra2h6OFJUdmlMZEF4NmRQZmNmSTVNQmZEOEEw?=
 =?utf-8?B?YTMxUnpYNlJaUDB6ZzM5Qk1qcmJpdEs2VGhnMlhzbVdCeENjZmtMbzFqVUt2?=
 =?utf-8?B?cHE2Ym1iWGxkTmNFUy9yY2VZVGI4d2pocEpZMTZIY1A3a3F3K2V2U1Y3ZHZp?=
 =?utf-8?B?ZDd3cFZndms5QU11VGNhcnJJVGZlbXhXTC9lcERJVGY2U1BPT1hrUHRWQk5H?=
 =?utf-8?B?MllmY2c1ejlUVTZnVW02TXkwcS84dHRyMGVOcGFyYUQrRWxCeUtvYmRSc1kr?=
 =?utf-8?B?dmpzWExjMG15c2VVVUpCelRrd1kyanU1ZDArOFNwSTBHMFdITmlYVTNlN3BD?=
 =?utf-8?B?TFFpMG1xYW5FVWx4MThvL2ZlQ01hUlBDWWNvKzB1Q0JpOTRlSXlTRHdrd2Rr?=
 =?utf-8?B?eUlMYnhZYjB2dWZIRzRKbG54Y0JzRVh4SUxqaFBjVGFsd29ONmxJTTFDajdV?=
 =?utf-8?B?YzczSFRrbTJHZk5zTjFtVEJrNnV6MDZQbnZJOVQ5VVlQemo0dWN6MCtPZEpn?=
 =?utf-8?B?Y0FHTDJ2SWYzNURPUnp3UWxRUUdwemp2NEwwZ2RNdjBkSUQvbzF1SnNZR3Uz?=
 =?utf-8?B?K1ZneDUvd2N0eHhLWXZvakRmVkxjemg5ZlBPQ1RrSlp5aUkzb0JHcG16THZo?=
 =?utf-8?B?ZFVGdHVSd0FyMGRqT0hIQnZHMmcyeVdVa280M3lvWUp2ODhWV3E1SUpodTJI?=
 =?utf-8?B?MWNTSFlUYm5OL05GTVpycG5vR3dsYXRsQi9LWEk3SkVhTFowV0drbU92THBD?=
 =?utf-8?B?ZE9xRHB2Q2FNdjNXOWR3em5FVUhVMm5OeEd6dlV0cDRNK05QczhUNWhIQW5I?=
 =?utf-8?B?Yk81cXpFQlB4K0s0dnZsMWNveGxMMktnV3BaaUIyeFo0eHVkdEMwaTBXK2lR?=
 =?utf-8?B?dmRIVENKdmM5ZENSSWViSGZGc0FWTS9OejZnRVNsSWVzMDNBa0NLVDlxdXM0?=
 =?utf-8?B?cHM3cHNkVHNrMEY0NkFsUng5Z3pWS2VuMlM4QkR3QnVVUnBmVUtuWXpVOGxU?=
 =?utf-8?B?TC9rNXBFOUluVzNtSjE2cUN4dndFSHVRS01Fb0kxellXSlNtL2d0V1R4Z1JD?=
 =?utf-8?B?OHMwbTZnQVlJOS8zWVdYdlpzSW5STktuK0Vid1NvbE5mZlRvcG5CQ0hwbFBv?=
 =?utf-8?B?Zm5iNStxMFJEOU82ZlFkaGYvQk1zU0dvZTZhc21YWWtNVHR2dHRIczV4VW96?=
 =?utf-8?B?eXFoMFI1bkR2L3ZLaHpUeVE1MFY0aDZheENPY1lMT1crT3lXZmpzcjlBSXpJ?=
 =?utf-8?B?KzBDSmMwSlVVUnJkMWJSOVhEMFVoRlVFQ1dXNGQySE9SenRhbXFYV3I3ZWJ5?=
 =?utf-8?B?dFZYVWt2UWVENmZJZ1Iwcysrc1lSV1FLNnBFWngwY2hPTUhYQWJjQlQ2Yll5?=
 =?utf-8?B?MUFEYVRtZ2pKcnVsMmFBcm1jeGJ3QVRVK3BOamR3S1p3OHZ5S3hrRHFPRGxt?=
 =?utf-8?B?M09XeGphS2xKdTNweUd3dVRkZTUrRUZOUmZyR0ZRazdncXpxOVVwU2pTd2dM?=
 =?utf-8?B?QmZsNHFQdmJiNVdoMWUzR3RyZnlKdXc4aXA4UUtFdEprUUtNYk0rMi80UU93?=
 =?utf-8?B?RXkveW9SZ29YQU9Od2YzbWtralhheVdaaFhFS1N5aFpGc3BlZUJTYWl2YWta?=
 =?utf-8?B?OEpCVEZwVUdhWnZYVzZxQUFSQTNOaGVmNUtrQXV4Ukt3NzBKZjRtQ1RxQklR?=
 =?utf-8?B?ZUVreFlvRmVLVW11VGhFM0F1T1hkV3JxUGdUU1NaZ2JLdm40SUgzT3BmRjlz?=
 =?utf-8?B?U3Q4Unhmd2xHVW15UHp4ZWNObmZNdEZaM0Yxb2RQK1V2R3RIZmNaZERqak9s?=
 =?utf-8?B?Uk9MeWtYeGVFUFgvUHhuNmw3Tjdra0UrTWViK3UvU1FGbVovdklqZy9SdE12?=
 =?utf-8?B?N3pZaUIyekRZdnRGL2krS29qWnR5dWllNU1PM0ZncFVZL29yMU9Ia1NkZnpR?=
 =?utf-8?B?Z3pvSEp1TmNxeHIvTG5tZWFHeXpNNFBpOHJqMXJTZVBvNEFBa0xSdjJPZkFm?=
 =?utf-8?B?NXpadG41L0N6cGlwUlZ0d3dBUUxnV2wyQVdjMnlxR1BwUXYzNUZ6QVdkNzRn?=
 =?utf-8?B?T2dBT1hlSHVsanFtRENGRWNvTHA0R09BbGRXZWVudnpQUi9tYWpYa3hHOTh1?=
 =?utf-8?Q?QwWBJoshmdyzAMIRgFEafJrfl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5242c6b2-a5f3-4fe9-9205-08dd822d90c0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:10:37.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rl1ih92RZLSNsOXnCgHVeQustFU50DXQY/d3hp4sgp64S5aGSODiP75+q593OQ7MMSRHQ+EiGvGZ87u0TWMPJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734

For nxp_fspi_clk_disable_unprep(), no caller check the return value,
so remove the unchecked return value.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 2eafd6bb819165740f7eeddaf5d2e90fc5682b6c..45d7b5fd9230ca122a61fe66a6e05dc4f823444b 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -634,15 +634,15 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 	return 0;
 }
 
-static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
+static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 {
 	if (is_acpi_node(dev_fwnode(f->dev)))
-		return 0;
+		return;
 
 	clk_disable_unprepare(f->clk);
 	clk_disable_unprepare(f->clk_en);
 
-	return 0;
+	return;
 }
 
 static void nxp_fspi_dll_calibration(struct nxp_fspi *f)

-- 
2.34.1


