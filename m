Return-Path: <linux-spi+bounces-6230-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638BDA026C3
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 14:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26773A44E3
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6CC1DAC89;
	Mon,  6 Jan 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="bWZ7BNZu";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="bWZ7BNZu"
X-Original-To: linux-spi@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022109.outbound.protection.outlook.com [40.107.168.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862951DDC36;
	Mon,  6 Jan 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170693; cv=fail; b=uJhSykXAr8fzUSVcC96sKGhfTspI0hj5ejtK+HvvhPSOR1k4CwbLQi1UU3I7U8JATl5xl/CaW+0zj4tntq2xazl45tUZCy6xLOoSwx6EnI14EntIkBIA1vBHfO58DMoNfeqk2qbSvbDKlLaAMTWXKmwOkgyieP+JzxBD3nyqQFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170693; c=relaxed/simple;
	bh=/Kobb21fdh+4hPgt5lPl3MrVkyMPdNFLGVd4XFoq1vA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NAnckF/e5pjDdpudxEnypXLRFztIzoB/vSZ2BI6l47AO28NwMeXKaMebV+MEpZieFMy1n57DADY7w78OXX8MFRYtTV0Zuv/JxuiEwavDHtzJY4F/fyOKtDPh2S/Pn9o0nAZdEumUhnLS/79FOxj190FgNACFJ3S0DNmaK0/JKy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=bWZ7BNZu; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=bWZ7BNZu; arc=fail smtp.client-ip=40.107.168.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oux5/LNlUqOd83b/hep2m3ab+hSls7R2HapWSlcq8ONRK9/YNXQKA4jbn523HV0kf8Qtb4xS/jhO2oVjRjZ+3wmQaRG1cA8f6+WcRM3aXjfOQXD9IdWxdMpDxsrBCZEVhpP8ykjGfd3MoPW3d3l+VpKPWiGrX+p/QhAzGutFTnAV06GJ0g6vcErZY2bY9oBxoE9jwepMDU35uCzGtBwXrmd9NLZoljd+CfRyrxcbE5eckInnBnz7M3pwEJxTrv9vuvOGFw9mWGsO4xCzy8SJ1tQIwg/o0NU9DlsbOiJHd1hoezWDriEnGxGG2iA/3HOuahTG/4zwo3JkwUAqS8JCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji0FsLzw5JAQhf9FTKdjAAcbjOQ7vUY53FVD3M4q1O8=;
 b=Hy3DY6+1/hhgCkJzeSRH1Lj6Ea9i4Wxv53YNNpcxyD5+Gxwo4fa/y5IzqjALnULUOcUDkkrxKz9PkPynEWQDG5fUaPLrq3xNUPOtQJAc29J8rr55mPG3zcdJlLZPPNKoxSsi1MagNa24nAW4gqrLBcoJj4cCbFfzhNZ+p8cDY6I2cc2cNhpgDVxPu3b6+yd5fiBKPWO3Hvs9HeeE8gVuwabVmcw/R1yyQNqWkc10iEXt+h2ndPzELBUleTByNMPuGBRRZLWyqbGEE6bxSqTnPQx/cy4u18V0eC9yQkrc3j/G3PBufEaOGOsL8YljDLkMt3UTSpAdEhttTK+Xsv568g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=arri.de smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji0FsLzw5JAQhf9FTKdjAAcbjOQ7vUY53FVD3M4q1O8=;
 b=bWZ7BNZusZ16wv2PwWaLA86APR0gB7kPiKs+rwwiFV+i0wSBwlqUGMFfwqSM1xfACvgL+ZwunEHIYyNpOq9PvRfWHbKowIw1/DdV71jlOLoQLzcru3o5JDtCasJvtgPGjgaUk8yPyGMnub372Rirw3VBXExeYo1nwzcyLSXZEek=
Received: from DU7P189CA0012.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::15)
 by GV0P278MB0050.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 13:38:05 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::80) by DU7P189CA0012.outlook.office365.com
 (2603:10a6:10:552::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 13:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.11
 via Frontend Transport; Mon, 6 Jan 2025 13:38:05 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=bWZ7BNZu
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010005.outbound.protection.outlook.com [40.93.85.5])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 9266BFD98F;
	Mon, 06 Jan 2025 14:38:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji0FsLzw5JAQhf9FTKdjAAcbjOQ7vUY53FVD3M4q1O8=;
 b=bWZ7BNZusZ16wv2PwWaLA86APR0gB7kPiKs+rwwiFV+i0wSBwlqUGMFfwqSM1xfACvgL+ZwunEHIYyNpOq9PvRfWHbKowIw1/DdV71jlOLoQLzcru3o5JDtCasJvtgPGjgaUk8yPyGMnub372Rirw3VBXExeYo1nwzcyLSXZEek=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14)
 by ZRAP278MB0770.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 13:38:03 +0000
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8]) by ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 13:38:03 +0000
Message-ID: <3e7264a5-aea7-44f1-8a37-2b8cf48b710c@cern.ch>
Date: Mon, 6 Jan 2025 14:38:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ8795 not detected at start to boot from NFS
To: =?UTF-8?Q?J=C3=B6rg_Sommer?= <joerg@jo-so.de>
Cc: Christian Eggers <ceggers@arri.de>, Jakub Kicinski <kuba@kernel.org>,
 Tristram Ha <tristram.ha@microchip.com>,
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org,
 linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <5708326.ZASKD2KPVS@n9w6sw14>
 <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
 <2675613.fDdHjke4Dd@n9w6sw14>
 <sqsslcr7fsgqi7fvjpy5xnarhlm76atvatczkzwpn37e7gnsu6@tuy7an7t4gdg>
 <cnmv4ahgyblej7aoknhhb3xyvb67j7t24tug7uoxxtl5s4pjy3@wd3copbtdiec>
 <f26f526c-cb43-4170-8dd4-b7cf6c0d1d5d@lunn.ch>
Content-Language: en-US, fr
From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
In-Reply-To: <f26f526c-cb43-4170-8dd4-b7cf6c0d1d5d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::18) To ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4f::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0759:EE_|ZRAP278MB0770:EE_|DU2PEPF00028D12:EE_|GV0P278MB0050:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b253c0-884d-4b93-c69d-08dd2e57599b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?akJzbDh5SlVCaENmODhKUWVBMm5HSllOVGpsdWRsN3UwS204eXhiWERMWkF6?=
 =?utf-8?B?TFZMbTE3RUpzL2xjSEVqS1hRaDlwck5lNXB5ZUd1YjJLOTlYN2s1SjQ4UDB0?=
 =?utf-8?B?QmgxQjBKYnVXWlZLekRUd3FTMVhheGl3bkdoOWFwYzlnSnlxb0JXSHV5a2FH?=
 =?utf-8?B?dWlYUUR0MmJ1WlBSUnZqYUJ5OFZEaTk5cEFOTnMzakVVTTBLaExlNWlZaERa?=
 =?utf-8?B?Z3BvcUVERVhKUStqSEVPWDNPT2VEMzc3YlFRWWpPalQ0WFExaDl5RGhYVUdW?=
 =?utf-8?B?dkcrWHFVK1BPS1NXYmRJWi9qUVZEVEFtbmh1ZjdrQVhCQWt1eUhqRCtKUDVU?=
 =?utf-8?B?MjBFa09INmlpaEhOSDJuZWdvK2hzWFNUSThpZnhqeHZpZUgweGhzTE11MUk2?=
 =?utf-8?B?MmdyTEh3NWtnSTZZZlpLYnNPNnE5aUNaclNNTjRkc21OYkhuYzg4aTdBZ2xJ?=
 =?utf-8?B?TlhWTCtBclJaQjU3SVhQUzBLYngxQmNUZ3JxUWlYVWx5cnlUYXRBYzVvamFn?=
 =?utf-8?B?L2dEWDlqVVZPU00xVkRnTCtKY092dW5FWThSSlI5Z2gxdmV3alBrVldSaHlX?=
 =?utf-8?B?L2hRUzFIQmtWZG1qUUVvamJFUk9jMlR4SUlBUCtuZ1JyRFRSa3A1TUtvR1lz?=
 =?utf-8?B?UFdFMzZuWnkvamxRazE5QVhQaUJJN1c0Wk9aazhOUkx4OUFpdW1jOUlNTSs3?=
 =?utf-8?B?QSt5alZVQVZpM0tEUUY4YVdvSHRaZGh6a3BQNnhzcUFic0V2RXVjOElBZnRX?=
 =?utf-8?B?RWpQcjUwMHg1cDlrUzNmSWdmSkk2OEZpTUJLdTJhb0MyZlA3b0RBa3U0dURI?=
 =?utf-8?B?WjJ1cVViQUJSUkdwMklXRXVTd3lCWGtGcFl6ckQ3MkxXbDFpN0VvWFovSVYr?=
 =?utf-8?B?SmxncFQxWkhxZER2d2k3SVBtQjk2ZUJKZmVSbEpWaExhTDU5cU9NSGNPSjhu?=
 =?utf-8?B?MGFvcVN2Nkc1bi91N1NPQkpaVDBDei94VFNCeCtlblFtQ2dGWHdOc2dETThK?=
 =?utf-8?B?VWtQdHczc0xkVDRvTE1pdm9kMXZGTGF5ZEJnYVZBMkUwL0haaWQ1YnpaR0Iy?=
 =?utf-8?B?bnhuV3kvcmp4WlBJR3JJN0V3dFI0cnppRFY1OVQ4Tm5IYzNFbEFUVlFLZG5N?=
 =?utf-8?B?WG1xV0pFcll1N2RiaEJXZzVVVCs0MzV3M3ZlZlRSQzZIelF1YXFkN2MzamFq?=
 =?utf-8?B?VWZTNndSYXgrRWsranozSFNXTE1SZTAxeXpFTUk1M1NJWC8zWUpJcXJnVFlH?=
 =?utf-8?B?MFhTYy91Wnh1TGVxMTAxVWRBeXB0RndJNVdTM2lvRVlXL2daeWxrakxBTUN3?=
 =?utf-8?B?VXZpL3BBSFJ6dkRZOUF3bU8yYW9ycS9rbGM5WFdMMTNZNkQwVjhKbmRaRnZH?=
 =?utf-8?B?bU9yZzlWQnZpeGtBWTNQWHRCY3BVUGJOQ2ZCWE5nTUlRRkQxUHdXMHF4Y2ND?=
 =?utf-8?B?bXlkTGx6VnpGRzZBTk5EeDZuVk5EdWhZRVF1aTBnWWIySklzNVBDSmVTL2xU?=
 =?utf-8?B?OUoycmdJSEx0VnNzd0tmU3lhM2FYK2REcUhWNUxKaWN3TlFWbk85QVVxQXhl?=
 =?utf-8?B?NlRacldpYUJJZlpBcllleTNic3c3RFpyUDRlTkRiVEkyWFFjYlNISUsxODNN?=
 =?utf-8?B?b2JoTi9MUHM2MlAxbXR6MEhCOWhKRUxlMC9aWUNiSTdaTWYzTDRCUTBwZkZs?=
 =?utf-8?B?b24zZVFvUXJDa0VrY3AvR0hKMy9zNTBYRVlXOEdSQVF4KzVCWXkvbHo0MDlO?=
 =?utf-8?B?bkZ4eTBuOGl0c3dTTU5XTEJDckt5cjcwd215aGZsb0hoTWhHeW1QdXJpT0l2?=
 =?utf-8?B?aDdhTDA0RmlwME01YmVBUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0770
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eac08944-33ef-41c2-502f-08dd2e57581b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|1800799024|36860700013|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUhZVWppOFFsVjFaQUR6MlllVnNaRWtXRXF3cEhnb0g3N0t0VUxycSszQVdv?=
 =?utf-8?B?RWE0OVcxek94Tjl6aEJjajdibGZjU0dWSGpvOGxZZkVvbXFUTzY4S0EvWUQw?=
 =?utf-8?B?a1BmUE5oT1pGL1hrU3hvdHdGaWU1QnM2dEg4WExpZE1scDFIWkZLdDVJSWVu?=
 =?utf-8?B?OTB2Y1VsL0NtYUYrMnFDSkY0a09mY2VYczVZWU1uUlpLYVJVSURON3NXVmZr?=
 =?utf-8?B?L3RwWkVjYzQ3VWp3NWRrK3RQeUV1WExaUVh6Z01nbWxRdGZ2VllHeGltSnU2?=
 =?utf-8?B?YURvc0RSVmw1Q2ZoajR1cU5ZV2ZHck5Vd3dFYjNXV1BUVVFUZGlwb25YSkZV?=
 =?utf-8?B?ZmQ1dFFvb1pNZUY0dVY1azR5eHM0ZzNLWHpwZDFwSGdBbGFvV0hEL3NYQkdX?=
 =?utf-8?B?TnRKK2FHaXVMODVrYzRMYTFoU2JNY2Q5R2RFd1kwYjZFWXJBb2xvZkhDZmVF?=
 =?utf-8?B?Q0E2L3o4QmRZaTMwRFQySEM1NkdaV0JSd01oZU91aFZBZm03eUVPTDFQTVd4?=
 =?utf-8?B?ZjdkTUtoZlBQUHMvaFVsYUJPb0NDS056RFNPNkw3VklDSWhVVUZiY2JCQkJa?=
 =?utf-8?B?VDNPMmU0M0pXWFZkVk4rZFBmcWlJRm54YVBvNzlzWERqeFJ1aldHVUd6OTlY?=
 =?utf-8?B?SWhqN21abVB0MmlxZ3N4b2tCTms4OXBKRVptUWtWaFVVcjdvSmxkNkk2dHhh?=
 =?utf-8?B?Qkc3dzAzS0ladTR0UVVJSHFMbmxJNWlaT3VmR0dmR1U0WlE2L1luV1cwT1A5?=
 =?utf-8?B?KzdGdjJHRWJvUGJPb1pWMkc3ZEdpV2IvcjZMQVN2eVNZY3N4dlRuNFdSWXB3?=
 =?utf-8?B?ZG5FbDFKT0NnR0M1ell5NFlJOEZHZlFEUXkzY1QvQzhpa1Ntb0tJaktKMlY5?=
 =?utf-8?B?U0NFVVBjMzZZMnRFNEppRjFsejVWbjhBWXBCVmV6SVNzZUFEYkY2U2FxMzA1?=
 =?utf-8?B?NEtHL25JcEFwNGpwcFNNUDI5cWRGbkFmdm5mVHBlRkhSa1lDMnV5SU9wNnMr?=
 =?utf-8?B?eEZkcUF5NkdkZFdvZ0c4VXVyUHlJTzF6UFdoSlBDSkFNSlRxa1h3dTRYRE9z?=
 =?utf-8?B?OHJXblVPODIycWZuS3ZNM1l6ajczU3VaaFZKWjRQTmJYeEJjcW5iSm8xR25p?=
 =?utf-8?B?bm5vR2ZFNGxoKzRieDBDZWx2ZzVPVjRRVG9DQXJxSlJ4VDVVWTM5d0F2VmJD?=
 =?utf-8?B?RTNjaFlJYitxb2dpTGUySFI1ZG5paE1jVElOeUl3U1dEZUZvTFh6YzJiUWdo?=
 =?utf-8?B?dGJTcVhQQ1E5ak5JaFNyWllmcHE3eUlrQmZqZmxac1E2TmNWQzJTK0tXV1hm?=
 =?utf-8?B?UE91dmZOSmZYUE1ybk8xYkpEd3d1dTJpOXd1WUl3NTl4aVNtcG8wYVJoZWxs?=
 =?utf-8?B?dVp2STRiS0ZQTUZqeERFSk5uQXlUTEF0eW1WU0VkZDBLSmxpczB1WUFMZVVj?=
 =?utf-8?B?d0FVY2ZkMSt3TGo5N1BUaEFVb2VUdnlxdVFDREJYaHRVWHdqaXV3Umd6SWtQ?=
 =?utf-8?B?anFWZitEMzc5OGRuKzlQRnlLenZYZ1lDYkJrY1pCaGQwK3hsUXZobkUrQ3Ir?=
 =?utf-8?B?dEpEV2tidERIUUtUYmF3ZUJsZGZ0N3JvSGxsM1dXQkIrbnVoR1NiMEk3dEQz?=
 =?utf-8?B?MXhvV0diL0VsNlZZeHVQdThHM1ltMWtWV2xjM2lHb1lONmZYKzRGU3VMdkFp?=
 =?utf-8?B?RFZyQldVTG1paDNKLzdkSHNrNHRFNWt5UER5M21HOGllMENienU4TmFiM3hv?=
 =?utf-8?B?MERwUGdSZnZCUDRqNjVnemZTKy9nNmlLR245VkxwVU13MUdXd3dFTlB5dHEv?=
 =?utf-8?B?VFRKaW5la3piWHl6UXZCalRVdzJ4eGRHUEU4UTZTeDBseEsyTUVjZGEvTmw2?=
 =?utf-8?B?aVF0UU1tTk1wYTJDTkVwMHZZTWpYK1FEV1VhNDA1cm83RDVVOTM0dUZtZ0x5?=
 =?utf-8?Q?JrjFvrfhcRc=3D?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(376014)(1800799024)(36860700013)(82310400026)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 13:38:05.5642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b253c0-884d-4b93-c69d-08dd2e57599b
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0050

Hi Jörg, all,

On 05/01/2025 18:08, Andrew Lunn wrote:
> On Sun, Jan 05, 2025 at 05:33:38PM +0100, Jörg Sommer wrote:
>> Hi everyone,
>>
>> I've added you to the list of recipients, because you where somehow involved
>> in changes of the KSZ-SPI switch code.
>>
>> We are debating the SPI mode setting for the microchip ksz8795 and ksz9477
>> and possibly others. Since the commit
>> 8c4599f49841dd663402ec52325dc2233add1d32 the SPI mode gets fixed to mode 3
>> in the code. But at least my ksz8795 works also with mode 0 and shows better
>> initialization behaviour with mode 0.
>>
>> The big question is: can both (or all ksz) chips work with both modes?
>> Should this setting stay in code or moved to the device tree?
>>
>> The specs are here, but I found no evidence about the supported/recommended
>> SPI modes:
>>
>> https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS00002419D.pdf

 From this KSZ9563 datasheet it is quite clear from Figure 6-9 that it 
requires mode 0, for KSZ8794 (which I have and can test) Figure 7-8 [1] 
also indicates mode 0. Note however that older KSZ8794 datasheets 
(revision DS00002134A from 2016, can upload if needed) rather indicate a 
mode 3, which is a hint to me that indeed both modes were once 
supported. Appendix A from [1] states that in 2021 the SPI Timing images 
and parameters have been updated. No further information there but your 
experience and the datasheet update seem to indicate mode 0 has better 
support.

My SPI peripheral (and KSZ8 driver) is configured for mode 3 I see but 
the frequency is set to 10 MHz while the max is 50 MHz. From experience 
with other SPI devices I know that with higher frequencies the timing 
parameters (setup and hold times, mode) become more important, what 
frequency do you have configured Jörg? I'm asking because I don't 
experience the issue you have.

[1] 
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ8794CNX-Data-Sheet-DS00002134.pdf

> 
> My interpretation of this is that the initial clock priority is low,
> so CPOL=0. The rising edge will be the leading edge, so CPHA=0. So
> that makes the mode = 0.
> 

Cheers, Pieter


