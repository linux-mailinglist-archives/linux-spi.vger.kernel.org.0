Return-Path: <linux-spi+bounces-9495-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C19B2A140
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 14:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0595D18877E7
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ACE326D60;
	Mon, 18 Aug 2025 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="BVtMOFgL"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021096.outbound.protection.outlook.com [52.101.70.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17319D08F;
	Mon, 18 Aug 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518720; cv=fail; b=Yb76SwO2QRLxEicU9OKKT7j8lgdmAecCJyWco+s56XELlKnjmSsnR+7fGEvveIA8XVYAkHoN7CA5A5zQJCCU5rTQgwgRzas3oFqdYRZ5fbsMn9LPlm05vZpj8xY0Sv86p9lolizdidf5YxnqDQyatr+cOLQT2J4M0NeqWeqemJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518720; c=relaxed/simple;
	bh=mKDXtF79OOMwWIni02uR8UDskDAzijSRqB57Kx/TH4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FfmpZMxR6kQdz4UaYqimQqtU0JMf83CmCHEdBuSHXj5NIrJwnNV2PCo70zw8TSDfK4nbob3ibRXgr4ApITXlh/t1imUYKQ1xpLVpk9slruRukZso4XNwe8xSw8uXFF3nTAqfk0ujmo05lyQb8+qEYpWdtXfxYuJgLsOxsxbqNas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=BVtMOFgL; arc=fail smtp.client-ip=52.101.70.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzWP15AsvCt/pPzUNvUiiwyAGclaGONSVJdCPi7itP7gUfY0n7/GbS+uZQaAAgSiXL9SKohSmMYAkylIL/d+bLy5xuh7eQPAeU4OyCD/uQIcCoPLf3qc467QfsfoPpP4EzIRZ0+LgP6akZBEIg62H8w+uITPbGSmqsi7HB1OIF8e7oaIpbyOQhbOzMg8Zw//GJDFAjeScJzy/B8JykU7jSw6zoUESE28NXSJ9hqL9yOVJdFF6DBqraYroNmQEWKuAv5mmtJ6XmQGHneHn+GJjT5JhJNVVcilP0M8K3KUhcUfE+FpIdQ6fxr66jIIkB71YZR4CoVilG1CA/7cQWCLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTmFJhPF+oiw+va1PTaiJPshwT3PYmI+a4u0mhlr+pw=;
 b=sIs9buqktnZEzh19FdQIxLleVmLOtrpFPV7CYCyOCvonv4VCJ5KVkTi8Mtm6MDnNfgV2DQVanW1y3phJQ0qQoEqz+uAhMnfNra4zlJSVCZg4NWC+NXC9RjXXGYQR+YrffKca4OqpjQWJ7X8MK0OuBlStmlQAo+aoGhONh+E9ghpH/FUlIdTIvzgjQGYyCZARB7hIDRl69V1DH7uRT+48dUOSKt+8ZkwXZj8C0Hlsy9Bmqld+dTQdcRonkq1OstLXIyFNmGtAnHX+sXy1QGNu/zksxLq3Ah5mZVKaU/YtsgLToYrLJFURiztTT2aBubknzSP70ic3qotjcBuocaPM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTmFJhPF+oiw+va1PTaiJPshwT3PYmI+a4u0mhlr+pw=;
 b=BVtMOFgLBgHOnclNPtfzNK//VyYFnwi/mute/0Ua+g6z+GyYtpnetCXP2hsn8zrSZzrTe5y1qLclXKQcFyBLdTA4nv0b3JwOwdbxmSe/SUpgMKlWEur+3qkpTQYpgztCVW6o4CaeNWDZHBZeP+mSgqpiobmOw5oePponKzM6FOAXFXja3DVBlCMcX80053SwiGrvTflAicFqqMM90GPU66raJLvI9JTtsBQU5YVgkv/V6AWWijh6x0NgmMZxIruP1kqRb7a8ci/3mfgf88fxmDKEjBPOSZPL20dtUOzZLj1ahF1rKZUK6Ih/8A9FZKz59J4M1a+zkkvLC9R5dvoG0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB5988.eurprd08.prod.outlook.com (2603:10a6:20b:283::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:05:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 12:05:14 +0000
Message-ID: <e01d40c2-cf1d-42f3-8589-da998b23901f@iopsys.eu>
Date: Mon, 18 Aug 2025 15:05:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drivers: mtd: spi-nand: repeat reading in regular
 mode if continuous reading fails
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
 <20250804192132.1406387-4-mikhail.kshevetskiy@iopsys.eu>
 <875xf1hjb8.fsf@bootlin.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <875xf1hjb8.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00014AFA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f827c82-7180-4cd6-a28a-08ddde4f7cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDZwSFZRMFB6ZmFkVmNPY0FzRFdTc1lsYkxmRnlHdGpTbDYvSldNQUgrT1RZ?=
 =?utf-8?B?c1ZSN1VCdGZyUG15SkVuQitRdWZFaktvVjlOL0JhZnRKN1B6ajUwNWZRY3VM?=
 =?utf-8?B?V1cvM1B1YzZ6eTVoOUtoOGYvdnFveHdJRXBWWGxWc3VPeVhFeWlESDZVdlIw?=
 =?utf-8?B?cHFJbmE4NHJFNW1jbmp4ampFY1AycU1GRjB5QUFlalVrWUE0T2U4N3pZYjRT?=
 =?utf-8?B?VlVaZXVxSlRBNDQ1T3g1RlZLeVBzTXkzNUFNSUpzczBVUzlzMzJIUG9QSUk4?=
 =?utf-8?B?WDM5RW1aU2tPVnZ6NGNCOEJlMWtLU3JSd3hWVnpScTlPdVVZL3dtMTU3K0Rh?=
 =?utf-8?B?MXI2ZmZCeUtBc1lSUWJjYmxJeFQvUGVES0xmazNNb3Y2REwyem5IQlhiWVF6?=
 =?utf-8?B?aGIyQnZ2b1dMbStKTzAyM2VaYVJmRTM5UEMrVi9EUGpFb3UwREtDQmpZZUhp?=
 =?utf-8?B?UnVRMDB5RGlxYUJzYlZWQ05YMW90QU5uYngwazRKblZJTjJNaUxhelpCeDNZ?=
 =?utf-8?B?WVJUUWVvbU1SSWl6WEhmUXRJOVFHOGFLVlNvYkp0bjYvamdNaU9ZYVZxSytp?=
 =?utf-8?B?SlFBNUpwL0NFMXNoVjQwR1U4aU5DekhvME5tb1NvbmZ3VU1oSVY0MWZndHM2?=
 =?utf-8?B?SEZ2U09OeFc4OTI4NHFFTEk1WDVYRE5KS2NBYWp2aWNxVUplT2JhdURHQ3dX?=
 =?utf-8?B?TTFBd3N5Q3NUbFZUaFE1YUFJTFNOMWNMeUxrUnpod1FtQjBrZVZmMW5sT1lN?=
 =?utf-8?B?a3doZWZtaEowcE90Q2VlOFhCczN3NXBaRUdnRzlvREFtOWdDU3pMc21tdGp2?=
 =?utf-8?B?M1VlZEtPbXJmOWl1TVF0cWtXRjhnTzRYL1lveVlRVm81Q3dVODFUMUNTM09v?=
 =?utf-8?B?cU11WDVrTTE4UFhQbDl6cEY3c09zKytiekRzdFRyRzRtSklyd3FBOFZxRVNL?=
 =?utf-8?B?T3kzMkhnclFUdVN2SmpiaUJTeXMrVWlqVGRPeFpjcXNsWGtvbjViL2pFSnB1?=
 =?utf-8?B?NVFxcStuMysrS2ZMSGFkVjVIWDc1N2ZMVTVCSmF3OHBTSjRMcmlvTW5UYVk3?=
 =?utf-8?B?S1pYOTZqMVB1R0JML2RZdDkySHdVRXVpU0V5endsTWFvblgxSWNsMm1kUkNU?=
 =?utf-8?B?bWxLRzdRM2xRd2VSc2o5ek5MZk12QWNESEpFeE5xQTBFN3VlWG5rYWd2OHlS?=
 =?utf-8?B?NUdmeEo2b29yWUdMbzcwc1Uvczd3REIxeUVneCtRVzROTzBIT25Ja290KzVq?=
 =?utf-8?B?RXBPZXJHS2U0a29EUTloNjFXS05ZOFowL252TVZuckRsSXphNjVZeWlmeWJU?=
 =?utf-8?B?SVJJdE00L2xvSzl2VHhtY0src0x6R0RFaVhJeGlUNEJsR2lsTlBPeHY3WHVn?=
 =?utf-8?B?M2hya0JsampGbmd4TjhuZXFURmszYXl3N283V3V6Tk51MFlzdWRhb1JjUDJq?=
 =?utf-8?B?WmgweDhkL1U5S3Y0RkdSTVZ0ejJoQTBYVkl2Nm5YTGtnc01BZzB6clJWWU9R?=
 =?utf-8?B?KzJMVU1EZVg2K2xnbWxmdVg0cFhOMm1acmllL0lBdWI2REU4ZGhnTzFxSWhy?=
 =?utf-8?B?NkxyeHh1cDZYdU1TK0IwWlhnYndYNlV6aGd4SjRXN0hIbExTOGF2OW1JMkRB?=
 =?utf-8?B?Q1luOVI2aFRpb2JxaWljTUR5VmhuTU1RU0NwMjRpVisrZjRIY3dRMldvdllo?=
 =?utf-8?B?RkZKdWRzNU9MRk5FM3c2NElheFQrbm90SGNBZlRlYURqVVd0bDY5MHZIOTRD?=
 =?utf-8?B?eDJBOUpBdWp5T00rZ2d1R0Jsd0lYZVc4UENsU1RQYkFvRm0wNUZDZHN0bHR2?=
 =?utf-8?B?OU9WTWlNbE9NM2N5dS9JWVFkczkwdEVnQUR0WEFMY0dEcUZlVzdyay9QQ0ZF?=
 =?utf-8?B?ZHZ0dkN3YjJTTkdxM1VXLy9GQjJPbi9mLzZMUDVkTktDNzFRN012OUE5SUJN?=
 =?utf-8?Q?QCleQA3Xxo4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWpGY0tVVUV6Z1NNejdaRWowdmd2NGJoZzBVTWRlTmw5VW55V1hHUUNUcWl6?=
 =?utf-8?B?K2lEZTRzOXhJVEZEOG5qc2h3YzRCdlFKc1BBd1JudFVXckRENlhadmM2RXZI?=
 =?utf-8?B?ejExTm9ZL0xzR1J3TG5jMkpweEwreEo3eWIwcXBtTGZkMXJLS0d6TnRFajJm?=
 =?utf-8?B?b2VkOFMxd1lqZnM2U0FHcVNmek93cWJsdFR4cUFhb3BVVGkrblZVRlNTWlJw?=
 =?utf-8?B?dTMyNHBSbjBYRHJVdnFQMGZ6WDdkOHlISjlUZlIrQVgzRmQ3aUtIMnBrU0x3?=
 =?utf-8?B?RFlPeXpYOVRERmF2VEo5YU5nNlYvaWlVeWRRaEdvdHY2dUNrRUpicEhjaGxy?=
 =?utf-8?B?bC9NSFUxUXhHUGNmamdDY0dldVVEaFFFbmRseXlRT0c4Zm9mV0o5QUYzbmpN?=
 =?utf-8?B?NWFnMEk4QVp6WWF3OW9YeGJVK2s5KzREUHZCRy93cVRvY2svSW1QcTBrK3gw?=
 =?utf-8?B?VWgzRDZSS2x0SVpKelZpeXF6U1J6S2VWYXRHc3JNYXlaa1hlK3ZRcEtSTWgx?=
 =?utf-8?B?bTBTMjJta25ySkpKbzFxMXQ4dWYrYXBDL3o5U0JFdjdvdlVhcjB0ZzEvSDlW?=
 =?utf-8?B?cnJDbi9meTVYbE5uaXdjQkRwS3QzWnNaVzhkZXl6c29uN2NVa0t2V0JpZXdK?=
 =?utf-8?B?OXFhMWNSTnNqa0YrQ3JkdS8xMjRDMlJ4K21odjNCYXI3THJ6TFY5S1FtZ1F2?=
 =?utf-8?B?S2doaGIrdzM1N3RJSWxTRjQ0Qnh3QzlvWkdMaXFIbUV3VG9iVVpNVmxXL1VJ?=
 =?utf-8?B?TGZkWDdwRXlWaSs4cnBoM2x1T2txVGpUZkRlenNDa3dnYk5PS2lSU0dNY2pa?=
 =?utf-8?B?cytka3c4b2VtWWFjbEEvczBzUTR5Q29acDUvMmUvUU5XQXA1bytqdy96bmgv?=
 =?utf-8?B?VUZXYllqMGZ2a3UxRU9LaWNuNVNjYndJejJ1QjRFVVF5V1FGNXR1cDFGWnpN?=
 =?utf-8?B?K0VaTEJIZitxaG5FWG9uRHROOVc1SWUxcTE5bDBtQWZZajBHbTVUalpZN25v?=
 =?utf-8?B?a28vTXFVcFREQzdocXZOZld4L3VLZ2hTaXRydHQ0YkZCbG5BRDhPajMyeFBF?=
 =?utf-8?B?Y21VaXUvYnFmc0xqaFVJeEhtZmFpNWtaQ3JXR0dVcDF1a2IyZVNXeFJiYWFq?=
 =?utf-8?B?OWZyd0MzRHdwUWViZkdNeVFDdy9mVTlrM1dFUHlITVFPc0hYUUtmb3kyclRT?=
 =?utf-8?B?RXRZdkgvNEh0eDM1Tm1FSTBkMUdBL3kvNkdmVS9aa29pL2U4ODl2eGE5VzlE?=
 =?utf-8?B?TTY0alo2OGhJSnlQMHZZZnJZeHVNL1RhMjdiVTVNNHVSZjB1WEhRNk91VXNt?=
 =?utf-8?B?TTVuUDlOYW5ZeVJlNTNINDFaY2RYL0RqOThxNm1Bdk1BSWtiVkhUa3UwL2o5?=
 =?utf-8?B?NDU0MERmdWltdkoveFdUT3lReGN2Y2hMcThoYWw0dys5eW45cDh5cTZyOGlt?=
 =?utf-8?B?NWVJejNmYXB4UWp1SXRKSktpSC9jb0VIVzVlMXYvVDd2a3BEa2E2MWpUT25Z?=
 =?utf-8?B?cUNsVGRmN3RpZCtWVDlYcXEyZ1VsSUN6VDNFc04xcFpFcDUwZGpFeFNycmM3?=
 =?utf-8?B?UlAyRUQybm5pWTlzT2lLYkwrRDY5c0RZeHQ1d25DYzZRVW9hNlUrYVM4STMr?=
 =?utf-8?B?dWVsRXdoQ2UzWndNZ2FrYm1XZzh3ODVmU0tBeTdSUjZzQnRJWE5rZGpJV1FS?=
 =?utf-8?B?NmNwQ2NZdHYrbkdROXpobUptdlZZMWxWaDJLVkFnTzkrY1VJVjZORXFvWHVw?=
 =?utf-8?B?ejVCQjFsd09TcERuZUwwSmo2dnNYZlo0S05mT2wzeVN1UzFpdVk4a1lTYkpW?=
 =?utf-8?B?VFRqTFJtUEZVM25iWHNyd3B5ZlhiM1k4VG9KOHZWTW1qZ0VvbVVoNW5QcHFl?=
 =?utf-8?B?Mi9WZDNReEVvcm9KckZWMDdWdnZFTjAzMEtDVk1iVVZ5NXlWeDQ0WU9SL09T?=
 =?utf-8?B?Y2FHT2NpRlVZWEVlSCtrVnZ6d3JxNEtEbXhHNWFqdVRTQlZud1ZHQ2FDcVNZ?=
 =?utf-8?B?WHdlSnZFMEN1WktGclMyOHVzNXd3VUd4b1ZabnBWeWZ3VXBhSnp0T0pDSFlx?=
 =?utf-8?B?VDRzdGtwWlM3YUJkeDhScGFGWlhnZEhmZWZZaHRCZ2s0ZlNWMU1EdHY2dzM5?=
 =?utf-8?B?WEc5RWl5T1pGZk8ydGZrMjNrYjZRamozT25SeVlrSGV2a0I3T1dCOVp3MGNN?=
 =?utf-8?Q?xzsI/iyQ0qel27b4X2rjXUk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f827c82-7180-4cd6-a28a-08ddde4f7cf7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:05:13.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omtVsF8l9s1iL7SaaNiyPUPw/BOrR1idRX6ZK0tIIe/R/b3vsvVhOXPL16OUj3c0k/c23t7BxVY1KpbbtVPKrfOv2tCLEXNjuYDTZRst+wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5988

Hello Miquèl, is there any comments to my v2 series? Mikhail

On 05.08.2025 18:36, Miquel Raynal wrote:
> On 04/08/2025 at 22:21:31 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> wrote:
>
>> Continuous reading may result in multiple flash pages reading in one
>> operation. Unfortunately, not all spi-nand controllers support such
>> large reading. They will read less data. Unfortunately, the operation
>> can't be continued.
>>
>> In this case:
>>  * disable continuous reading on this (not good enough) spi controller
>>  * repeat reading in regular mode.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/mtd/nand/spi/core.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index ff6a1e2fcfdc..88e4c00cccc4 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -431,7 +431,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
>>  		 * Toggling the CS during a continuous read is forbidden.
>>  		 */
>>  		if (nbytes && req->continuous)
>> -			return -EIO;
>> +			return -E2BIG;
>>  	}
>>  
>>  	if (req->datalen)
>> @@ -893,15 +893,26 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>>  	struct spinand_device *spinand = mtd_to_spinand(mtd);
>>  	struct mtd_ecc_stats old_stats;
>>  	unsigned int max_bitflips = 0;
>> -	int ret;
>> +	int ret = -E2BIG;
>>  
>>  	mutex_lock(&spinand->lock);
>>  
>>  	old_stats = mtd->ecc_stats;
>>  
>> -	if (spinand_use_cont_read(mtd, from, ops))
>> +	if (spinand_use_cont_read(mtd, from, ops)) {
>>  		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
>> -	else
>> +		if (ret == -E2BIG) {
>> +			/*
>> +			 * Some spi controllers may not support reading up to
>> +			 * erase block size. They will read less data than
>> +			 * expected. If this happen disable continuous mode
>                                              happens,
>
>> +			 * and repeat reading in normal mode.
>> +			 */
>> +			spinand->cont_read_possible = false;
>> +		}
>> +	}
>> +
>> +	if (ret == -E2BIG)
> While I agree with the overall logic, I find pretty unreadable to
> perform the regular read upon a return value that is an error code set
> in the init sequence. Can you please propose an alternate implementation?
>
>>  		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
>>  
>>  	if (ops->stats) {
> Thanks!
> Miquèl

