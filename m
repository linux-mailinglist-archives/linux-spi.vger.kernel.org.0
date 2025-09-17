Return-Path: <linux-spi+bounces-10061-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FBAB7CFBB
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4B23BE52D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 07:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769A2F6186;
	Wed, 17 Sep 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GUtFQR82"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41F2F6572;
	Wed, 17 Sep 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094063; cv=fail; b=BcVFQnifRX5xqB09fRCLEEPJ6EI0afOQ5WYNTCrAzH0CJdfjby8C0TWAs50bb7nyPENgSmKqcX2bDEMNz0srGnNLwuTMTFoyY4j2CRhYpBPPrxtZWIP57S5CkVOPtWQZk381JZt8aW3DYPrSIa7KaqAS4KVy47w3DyPcHCVlYpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094063; c=relaxed/simple;
	bh=e/etS0ISZob4Ig8ik9H7GfK186WxrbMjguvBkDviCkU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LQIiMP2MZI4mjEm8wvHJSkfR89wTb2+Iz0y9fz3cdepvlEyPTs2CremKJt7GihCtBcgcW+3s6BdddA0WzltGOX/ctU01xF2kJnT4jp2DzWqgXNfr2d6eDQabuNtZqeFxwMK7GEFCvYWMcqYY+BgRzwMA/eUEI+jMsBHePOAr/GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GUtFQR82; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf0aXF5X+yydPZ9znll9phg85Txp5EjMcmJHVPtSU4oTdVAje7EgL07A7+TAHfTmLZufibzqxh0/7B5tFXYg4wssIL5awkggbXaLa/AAnzbdZGf5H/qW7H2OkGRJDQgF2HQRQlVaY0OTt9NzHNBw0C2aGadBbanM9DvL2xPttnUQrokNG7RG2FTJrlCt6InhyWcJ8TIuVLjjvQxJ9tyoDsJMhVITKdk0pjcB1p8nX5NuDvylBUDvTn4H/gvRUEPlGe+TA0mQ3HJNU3z3sy+/0wguztmVLF6VnwtW3nNX/ul3pRqZqy2SPCBZIkgRY02a2CCo/twpocKfsvaNZhyi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPT+2clts6iO+BBV0zeV+H7JCWlQy1xQiYpubobd/2A=;
 b=JJQvBC/zxggKz+ZbiVJpNvkyG8g2Xiv/lbpTs/c5VB92wuesz/mVbx3YITe72iUzw9dfWv5vYFfUgQ6avE1sfsR5ScdYPcRVHYKObRQK1DnfgjIu5iS4KfWOikX05rLb9PeQw7q7OkSd2ZySQ+rM+nJ2oCcF16Gk5PFVD+KaznY9ztGzGvtz5QnAUHs41R50r24yMEqTt4kNIoY1O5hPXTW28w2LH3gYHoVePCWo5KCRJLz8kCYXroCVt16tpIpCEeoP6kqP8XiM1EsIjtqC3IYAETDhNpvoq0UQQRdWw14ov9UMTNnPK0Tz5XcDDVOEmIEnpYOYbQVBbmJ3L0oC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPT+2clts6iO+BBV0zeV+H7JCWlQy1xQiYpubobd/2A=;
 b=GUtFQR820waBC2HNuN09TVgVlXg4n9RGt6uq7Yg2qr1hBSv/YncL/VXfOFp6L2+qgKzdUED4eZzTLgOFUuiKYgOedNS8INji8gNMY4AvKcs2ReHfUUcxpTrbif7NkUle5y1pPVAnb3GnodYxHKK7h3206aKI5leh5dO47p+ISWb189ZzK1kLFg9gcwrMZJonGvkK7gYFVm40dJthrufeYMQY4AhreTk9sZG5A4VDl3FDyz2znlK8n3w90qQI0EXtmN4J+WuTQwQrO+/O9AyxU6kjVJQnCp4hmRhKPmYlZ9cq5ZZ65eEO42LYrzzMmK4JlLcvqx1HjTBGAZL8z8Zp9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10800.eurprd04.prod.outlook.com (2603:10a6:150:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:27:38 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 07:27:38 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 15:27:06 +0800
Subject: [PATCH v2 1/5] spi: spi-nxp-fspi: extract function
 nxp_fspi_dll_override()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-ddr-v2-1-bb9fe2a01889@nxp.com>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
In-Reply-To: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758094070; l=1891;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=e/etS0ISZob4Ig8ik9H7GfK186WxrbMjguvBkDviCkU=;
 b=opnFikrJrHVfsFW8PebcHX3eyCxpIpsVZQb5zk68Xe864wZIVGAKaS2LwTU54cmAwaDBLgR9L
 28leeBo+GOPAlYEH3lLnL3oHlCY9YUfYg/iKh9kdoB5vLjkwLya3paq
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10800:EE_
X-MS-Office365-Filtering-Correlation-Id: 797f2952-74f8-4c43-0839-08ddf5bbadab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ujlyenk3cUtjc3R0eEMybWoxVnFVS2VYaG01MThKV3JoTUVsd3ZkeXdSU3Uv?=
 =?utf-8?B?Q2VkdCthMVlDcS9tV3ZjVkN6bTZ4Vkc0K2lIVisrNEFXVG9Zc1BsOE5nb3c3?=
 =?utf-8?B?SkNXYXBaV29TWFl5b3pmeUlvVDBBNmpwditXNkd2ZVhzVXMveE1GQldPRWE3?=
 =?utf-8?B?RzEvaFpPM0Y2OGNvNlhpTUJabXNZQmpxVGNlOFZlaWl1VWdrc3NlaUg2aS85?=
 =?utf-8?B?U1Zhc29aOGcxT0hwZDdjUjh0OXBrMlVBTldSVWUvZXpTYy9wVmljS2xmWm0w?=
 =?utf-8?B?aTJPQTlkRGlkU210RC9tSTZvTDBObWV3QjZ5SlVLbUFKeEw4c05MTHFxNm5T?=
 =?utf-8?B?T1FUcVBPV09QbkVIUHZvdEJDaVdNRTlkb1FBNldUbnlkaVVnaHNwT3JaMnRE?=
 =?utf-8?B?YWZmd0loMFpaSUgrTTBkeWw2TUpzOW1yNmdORCtqV2c5R2tlNCs0M0pmODdV?=
 =?utf-8?B?RmM1UzdCcWFxQWRKZWZvdWtkbHZjelo1My9ORFlsREtULzRRcUxhcE9jYmFv?=
 =?utf-8?B?K2h1dmRKZCt6WFNDVis3TGEzc2paYWdacEFXYVNrVXBMSDdpdjRHSGw1TWRy?=
 =?utf-8?B?dWNPdzNLSGhXYUt4Ykhad0h1eHBMWEJxMjFFTktXQTdyeDFUaEZlckRwWGtq?=
 =?utf-8?B?STFkYnUxYWg3UkM2Q0pSL1d1SFZMTVdRQzJMSXpGNFVPMjJCbzVLdldNeE83?=
 =?utf-8?B?Uy9jdDREVVpXMjlvUldqUXpRbTlMZmlpYThSR0k5ZGNTZHZGRGZhbWxLUFh6?=
 =?utf-8?B?UkJSR3cxSFU1TDRLR2hGYmFOK1BqeXFmZTRDQ2xkaU5idkl1T1d0VVF0OGpB?=
 =?utf-8?B?cVFzWFBrK3JyRE1RdmQ5RExPTGUza2hNRVBVUmVGWVhRaGdZenQvSmczZTlm?=
 =?utf-8?B?QzFkdjV3TXVTeDZrVTNvVWRmZCtsM2hWeHNhNGVrVkdjVTVvMDB3R2xuNXhX?=
 =?utf-8?B?SVRVT2dSc0xCWXEyQlNsZW4xWml4NnJFTDlxMkMvREp4Wi9kS0lFeWZ1bTJZ?=
 =?utf-8?B?UGFWRGY3Vi9EajV3dWZpbkNJZ0RBYTNRQ29JcUdpMWloTFNxS01SczcvTDRC?=
 =?utf-8?B?SUJEWG0zVUZNaWZFVU84ZjM0WklYajBoZUZpQW5PRW5RcUtaVlZRVDR6MGRj?=
 =?utf-8?B?dFBYVW10V0dhd2k1UG1iUjdUN0N2eHZpbWlocFMwMUt1YVQvRS9wMm91OHl2?=
 =?utf-8?B?cjBEM2tPdU0zR1h6UkJDZC84U0lTUyt6MktqNEpxMXJUK25KSDRpaTZqUDRU?=
 =?utf-8?B?YmFZU1ZydDduN3JNbkVWN1h1TXA3SUZzNitFbzUrY2xxUnZLbFFnRzYydDQ4?=
 =?utf-8?B?aFZkaGhuVVpDRW9OZDN5eVlIYjhINzFZbUZNSzR6VlJUYTF5TTRCeEhkVktx?=
 =?utf-8?B?UXNNclMwaXh6VGZHSkphSjhIS1AvOTJ6cDdPL3A5MVpTM1VLRUVGOWV4aXhF?=
 =?utf-8?B?L3BNZW1kUnNoZ0srd0V6dzZ1dmV6ZS9ocVRyUHdHSDlodFRkMjFjUHFVMWl6?=
 =?utf-8?B?c2RLSlVFZjdpMFovQnRRVUt3RUxZS1FzK0d0ejZ0UjNTQ0FmcmFnSDUyc1FO?=
 =?utf-8?B?Nlc2Vkw2MUZRcDZlZUJLckZJdEJZSm8xK0tLYS9EL3E1Q2RSNXdBYThzMkxB?=
 =?utf-8?B?Y0Q0UFFhc3Z1UjltQTFYVkJWK05wM1lhSlNRbnBXc2dSUlpDTVp4VG4zQzRj?=
 =?utf-8?B?dUs2RnB0bklXS1RmYzk2RWw4UGN3d3lVMDdHYTdsSTJHdmtja1dlVDFGZnlT?=
 =?utf-8?B?dmNjdThaSXFYRms3VENRYWdLWTU5cnpxSnBKQ3huaEsxRVFhMzVEdW1ReEhS?=
 =?utf-8?B?dlVTRXV1Q3NlOGluRVAzb1VxZ1FJQWJSN1RuZENZVFlVLytHZmM3UUNKYVBt?=
 =?utf-8?B?bjR0QkZYWUhVNjBwbWZ4cGY5clRmUHpMd2k2eDlFQkRocDRPVjM4b1dpT3ht?=
 =?utf-8?B?cWtyanZ6dW9YVXBtL3BSM2g1RGNpWkVuQ09GOVZha0NNWXNRU0lJbk82Q0Ry?=
 =?utf-8?B?MkYzbGUyMFNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YktnMEYwa3ZPbkZZZFJZVC9SbS9yVzlDWnMvSndRN0I5VWVzZDdJckVGT2Va?=
 =?utf-8?B?NlpIc1ZkTWJWTllpQWF5WXQ5OHNRL0w3Q3d1WmlGQWpXVWFpaHRFenFHNzNm?=
 =?utf-8?B?V1BWbzh1YUM3VnlVSUcya2dzMFVjSUtNbVQ3eG96Rnd3VXZ4czd1UjE5ZnpC?=
 =?utf-8?B?RnBYZ2tMWEZoZktzeXZuSlBpT0lNamJkMXFjR00velhOcDRtUnRWY2VWYUN3?=
 =?utf-8?B?U0o1bGZPSkRFeGVLVmsxQnJ4alRQazcwc2RYUTRLMHpSajlEYmYybTUwYVh0?=
 =?utf-8?B?ZFpXZUZxckNyQXZrMFplcTl1Q1hKTGNhMzc4andkd0MzT0tKTW5XOTd4dUEy?=
 =?utf-8?B?QVdYaTUyT0tQWWZsNGR6dE5JQzBqdVRHMXZGQmlaekhuR3gvNUhuWXh0MmJG?=
 =?utf-8?B?M0t2Q1VxN0E2R29RYmVRc2J4dmI5NVdieXgxaDk3cllKSzlhcnhhZ2pkSkp6?=
 =?utf-8?B?MWlyL2ZXRkF6SWhMQlhOVXBxYko2VWttNVQ5M1FpZHcyOVYxdWMwT1kyaUw0?=
 =?utf-8?B?SllkK1BNTGpOQS8xM2h6WkNEYkxHbFIvYll0REFNRHRUaUNXcmZVRnJmNWZt?=
 =?utf-8?B?ODIxaG5HdTRManM2K2JnODA2UGtOMW42MWN4YTVHUXhvdWExTHhuWmJWQ05B?=
 =?utf-8?B?ZjQzMlJoQXZWVS8wUUpUWG1maEFodjh4RWlxQmFaOVpRRFJnLzJKbDk3VDVx?=
 =?utf-8?B?RTFVOElZT2hYbkNncStFckRRTFk5NmFQYkluZ2RnY0FzWFpyNjBrRDlQWGtC?=
 =?utf-8?B?dGtiVlY1KytyQkRqSE4vTDNpb2FaM2gvTzZ0R3JWdGwzTGhJMnNDVW1hbGMy?=
 =?utf-8?B?L0VrNDNDeGQvQ08yL3BFOTVqUnZYbjh5ZXpBQmdQdy9SbFY1ZXhRZHdDdGJK?=
 =?utf-8?B?Mlg2Z1VmYms4dEMrcmVpUlRVaGNML1l1aldiUU5kalVkalB6dGlpNFdpMDF2?=
 =?utf-8?B?MEo0dmhjWko5aXNqWW40Z2RBYkprSVJUZjlIQzB2Q1VMQ3hDSkdWbzJXMktT?=
 =?utf-8?B?SHpXR0llUFBCNDFrcWlJOGN4TFM0NEtHQktqR25DSUF0SkwrbXoyc0Z0WWtS?=
 =?utf-8?B?UEVwR0V2elhhNWJia1ZiaUc4bGRnUjkyeWUrQmF2cjZZRHozQWgrMVhHT3R0?=
 =?utf-8?B?TWllZkFYT1VtcXorREEvVWM4dC9seUR2S1pHaDB0L2VLbE9tM3AyalRYTjJE?=
 =?utf-8?B?T3pqWkZoTkY1Z2FPR1lyemFoK3FJNlJvNzRnSG54MDllZ0d5N3pLQklLVjdG?=
 =?utf-8?B?LzBhMTBoa3pESXFnS2R2b1RxZC96bnRYc1FNWTRoZUVDUG4yUDJvL0xVOWxN?=
 =?utf-8?B?SjBOREg4V3lud3duYndBMW9BeVVaaEMwRkFYdi9uMXdjalJJVU9EQ2R6dGhG?=
 =?utf-8?B?Mkc1aFZIdG5aR3NGVUlBb2cxNGpFQWNmbEtPTU9MZGF5a09RSnBkTmQrVGtG?=
 =?utf-8?B?Z3poenhXYnpNdmRVaUFJclVGS1NJTFZEbDMzcVlOL0NaVzFXanl0MG92L0VE?=
 =?utf-8?B?bVpqQUZteG80NkR4VURWV0ZPQWl6UTFVTWYreFcycnkrWUJPQVJCajh1OEw0?=
 =?utf-8?B?L3oycjZJSklqcHd4WmFRY1hPRU4vRllUaXlPTTR0Y1VtNWtKWHRoWFFnT2J4?=
 =?utf-8?B?NE54WEgvMVIwUGRaMXVqdC84Q28rd1FOUGNFRFMxTXBqZ2hsUXNPVUV1b1lw?=
 =?utf-8?B?cVU2ZkNGSXNuc2xxbkM2Y0R1eS9za3o1aTZ4Qkc0RGJnRzVqalNLYkRHRTRx?=
 =?utf-8?B?djRGa0lrc1pHMW8wT2tIMjRqdE9hU2ExeVkxdTArMUtHYklaODJQSGZ4ZDVM?=
 =?utf-8?B?YWwybUdwMG0vVHJ1K2VmUnQ3RkFqT2VhWWJleU9zWDlqWWxkOHZrRXordjlI?=
 =?utf-8?B?b1JTWlZxMjR2SklBc0VWUzFhd1dHVU5UWjFpVEthZzhNczFKc3dIZlRqZTBh?=
 =?utf-8?B?OFFSdVNHZnJBR2t1ZzQvdThWNUhiVFlOdTk2UStIZFJiTDMyMU9LMmQ1ZXNH?=
 =?utf-8?B?a0t5WFVqWG1ndTZhZGJJc0dSS3lEL2ZScU12WjZoeTVoZmFuWlZ0RTZyQnV2?=
 =?utf-8?B?Ny9URkU5cHNwY2RXTEVwa1d5K3dBMWVYQ2E2K0ZqZnRIQ1A3U3BVVEllZExi?=
 =?utf-8?Q?romZhYawfBIQ0Qn6pC5vrSU0L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797f2952-74f8-4c43-0839-08ddf5bbadab
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:27:38.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLEuB3Tdd48mcB4/y7LVdK1NKPFdz3D5R1OMWtMPdpoWqLafhUAaNwVYJ7hRLDCmt2Q8u/Q7ysfGmUle8Kw9PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10800

Extract function nxp_fspi_dll_override(), this is the suggested setting
when clock rate < 100MHz. Just the preparation of supportting DTR mode.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 848fa9319e36d65e8152931324b8e34eb162f5d3..db4b92490de957580c6298baeb8b68a310c23615 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -674,6 +674,17 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
 }
 
+/*
+ * Config the DLL register to default value, enable the target clock delay
+ * line delay cell override mode, and use 1 fixed delay cell in DLL delay
+ * chain, this is the suggested setting when clock rate < 100MHz.
+ */
+static void nxp_fspi_dll_override(struct nxp_fspi *f)
+{
+	fspi_writel(f, FSPI_DLLACR_OVRDEN, f->iobase + FSPI_DLLACR);
+	fspi_writel(f, FSPI_DLLBCR_OVRDEN, f->iobase + FSPI_DLLBCR);
+}
+
 /*
  * In FlexSPI controller, flash access is based on value of FSPI_FLSHXXCR0
  * register and start base address of the target device.
@@ -1071,13 +1082,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	/* Disable the module */
 	fspi_writel(f, FSPI_MCR0_MDIS, base + FSPI_MCR0);
 
-	/*
-	 * Config the DLL register to default value, enable the target clock delay
-	 * line delay cell override mode, and use 1 fixed delay cell in DLL delay
-	 * chain, this is the suggested setting when clock rate < 100MHz.
-	 */
-	fspi_writel(f, FSPI_DLLACR_OVRDEN, base + FSPI_DLLACR);
-	fspi_writel(f, FSPI_DLLBCR_OVRDEN, base + FSPI_DLLBCR);
+	nxp_fspi_dll_override(f);
 
 	/* enable module */
 	fspi_writel(f, FSPI_MCR0_AHB_TIMEOUT(0xFF) |

-- 
2.34.1


