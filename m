Return-Path: <linux-spi+bounces-12379-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AAED221A2
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 03:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BCC930131F4
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 02:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084126B0B7;
	Thu, 15 Jan 2026 02:14:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023109.outbound.protection.outlook.com [52.101.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091C2741AC;
	Thu, 15 Jan 2026 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768443296; cv=fail; b=WqU7+EOxT8qswSYkZLhMMeS8C3ckhwD0XlzXMPiSfZ41E20YUCrjRXbSPRpO9WS5qNk1oWdKnCZLf1Ae8mP68KXSMM3RGZvXrYozmpQXVR3hr2xHMen981gFMg1gUM3L6NhD8yjZxc53x/62+pwtp/KM0uI8lxRiI2QNRIK6HuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768443296; c=relaxed/simple;
	bh=x5t6Uws/Gfre+LWH3Ftxd39xzt0FtaKMHHiMM1cHC+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOaWVYkjmpxystulWEGYtX/OcfBgLgWmUeNFUwoNZ0YcR81Ht3fSLAQxDz7sc93GpAzNUeJAXhu6ZyDXYI3Hyy9OPJTJW1YF1yAaVvCidjqdIYhNes+Z8fNnfbnDRgcwaH/xOPPlXiiMsF3uaczfHwS2rI50IWLFNEwnX2e24eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVWJp4eqJ8DReAyNYgGnlgeXxEcxwzwm0NtRHW3nbBSuawl5rrOLScQFELCUdVSRGRfezdn2zgU3SiDF0STw/AMZimOLodhRSekGsTxBPLk/HBZO5oP7rFho9ObRR/k7v1wW9NdTlByMb7/3l7h/OaVb+iijXNErYYKV1u1kV5USz5FGTGCdWkmsYtYkeGc2rRwTJ/dTElce3bzs3iWN3pFpRwFVczx+fBh1B2O6S3mcja/rmdPbK1eIUulzvc2hXkUrVHk0T2jeQMaipKaKK42chu3p/oHcS99/68uqIt0CrpSU110w+5wL36Ge5sPrghh8hhZjuYL/zJN6ck2Z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBd/uOr7Tfjqx2ZFIk1KhV0s5KsOum1wlt8qSseZ4Yg=;
 b=nIP1RgefJd6AN5/40q/SMVvl0O7W9PULmUyipZXJYO8kcyIBC0InAWi7FC9LjNu7C/T5UOxFkJdYBqtjEJBqMhLAmVl8dTGM6sV1slCuulqbaTmwcWTgmPX30nOzcyxR54F/aMtYVUWmRnzy2mLz8TKyrMhTSaWDvDu2G1ShE/GC42c28AaLponWC4vuQwkWfgGW2LXcul4cK/QnMBt66OW4Umd196QwvzTrv7NSmmXEGsJ7hdJgfqsEtyM7kZwni3MnicjCIKpXNX02OBy4Q4hxMrigpFir9juoLYTbcRQadl0ITWaJw/3VzfEB4odm2vOFWmHFHOhcB1/25Srkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0082.apcprd02.prod.outlook.com (2603:1096:300:5c::22)
 by PUZPR06MB5538.apcprd06.prod.outlook.com (2603:1096:301:ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 02:14:50 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::7b) by PS2PR02CA0082.outlook.office365.com
 (2603:1096:300:5c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 02:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 02:14:50 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CBDF14160CA0;
	Thu, 15 Jan 2026 10:14:48 +0800 (CST)
Message-ID: <896a47be-20cc-405c-9a4a-c4112b30d4cb@cixtech.com>
Date: Thu, 15 Jan 2026 10:14:48 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] spi: spi-cadence: supports transmission with
 bits_per_word of 16 and 32
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-spi@vger.kernel.org,
 michal.simek@amd.com, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251031073003.3289573-1-jun.guo@cixtech.com>
 <20251031073003.3289573-3-jun.guo@cixtech.com>
 <fu4ujdxwlhyhuwjtsiebje5pyc32rfs52vo2gyy7nay2krkxeh@wpls44xdfgy4>
 <0dbf3a5b-6a60-46d8-a358-61b8d527a8da@sirena.org.uk>
 <lbijvnnwsnddonmm5pveqzap6iibxhl4maneq43x4j6w64dev6@u75qhm5cwiob>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <lbijvnnwsnddonmm5pveqzap6iibxhl4maneq43x4j6w64dev6@u75qhm5cwiob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|PUZPR06MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: cb72f6c4-2bdd-41fd-29ee-08de53dbdce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWlhSkhlWElZNHZJd3pSaFVpNVVSZndrMk52anNVTWZkakVaamJrTEhWZWc1?=
 =?utf-8?B?NU9XOXFPQ2lOeVJTbzZucnRoMlB5N2YzaU84NGYydi91cFFlU09ydm5DUVJ1?=
 =?utf-8?B?cGN4WklXekN3SGQ1WXhFSmJsUzZJUm5paXFIaXBYSmo3MmRuR1RoU2h0azNa?=
 =?utf-8?B?QythRnFRYldMY0VQZ29CQkczamdNeGdNTmxKYmoyWkFTZURJaU1mTVl1aTcx?=
 =?utf-8?B?ZW1LdzgyZEd3bW5kSDlhWnBOSUZKMmFDdlMzd0Y4bjkxYmxRYUsvaUNsUVRR?=
 =?utf-8?B?OUh2Z2MzWExwYWhXL05DOWtCcHlHNCtjQ0wxRVcxd0tnKzhwYms0WTBKVGxQ?=
 =?utf-8?B?aStYRWg0a3l2ZUpEcVZ0VmdGWDRuSG5QVnVNVDJaRXIveEZOL1JWQnVKRU13?=
 =?utf-8?B?SW5RNFl6Qi94ZkhnMW9SYUtsb29CcVJORUdWUlFPM1E4dG53bWx2V1YrejNM?=
 =?utf-8?B?eG5aeGdaSXFzdU9TK0ROcnVrcWQ1ZG5qMEJ6cWdtb09Bb3d5YVBVeFFrd3Zw?=
 =?utf-8?B?UUplbW9CRkcwaGlZZ014RUh4Z1FhdDJxeXFiVFpmbm44b3hoUWgzOThZOFRY?=
 =?utf-8?B?a0lTWTFHcDQ0dHVUeWpCODBiaWdjVFo2Sm9SQ2JYcmtZZ3VpaHBUK3REdjFL?=
 =?utf-8?B?RE9pQ2N3TDgzWFRlMTRLbzI3OFhVcTV1R05WNG5TNEFXVE93V3NOTERGVVo3?=
 =?utf-8?B?aGdXWHZ4TE1jbDdaSjdEcVVvSndMbVlnOXg3K3o5THovNzNJKzdmVk9PejI1?=
 =?utf-8?B?VUF4WDR1cmpJWVdSUUpoa0pIbktXZlA3TjRIclRTM2JsUmdGRmpwcnBJOXM3?=
 =?utf-8?B?dHViaXlsNkt4NmZRV2sxLzdTbFk2VWtzSTZBVTNvdFNWNTdnMCtOSnlEZzRn?=
 =?utf-8?B?bHp5dytxeXZiUE9ZM3c1OFNlSHprZENZU085aDU4L05pWnk3SHU5L21Mc1l4?=
 =?utf-8?B?aDJmZWo5WW9QVFZXN1huc1QvWmhuQ1FTK2Zoc3JyL0dudlo1WjZwYk5BVUFU?=
 =?utf-8?B?MVd1RDMxU1NXc1FlSGplMHdHVm10LzN5K20wVDh6QUlPdmpyMCt2amZVS3hF?=
 =?utf-8?B?a3c5eTk3eWJiV1hVbnU2YzdPV2psVzhTQjArVC9HQXo2WU5TRmMrQ0lzdHd4?=
 =?utf-8?B?WGRybWI1T2pIVUEvTWhvWHpRYU1wei9ManEvelgwdFFPU1orMnVRdTNRazE4?=
 =?utf-8?B?bnM0TVlvMWhhUUMwUkNQRXJwdUx6dExKTVhoTHBoYVAwQ21vWVVwV3ZsV0Ju?=
 =?utf-8?B?VFlnM1hzaDY5UHAvM1ZWelZ3YUxKQzVWRUtYenJBMk5tZ0o0cXVEN29vVGli?=
 =?utf-8?B?WVM5OG5ZaUExeW9oTGd6N1M5VFgxdmZ3dEpNdEExRUQ2MnFmcVFORy9yYWkv?=
 =?utf-8?B?QzQ3T2ZPUU8xOUprVThxYnUrWFpPK21Lenp4VURHbzRVR0srdElqYkhKTlB1?=
 =?utf-8?B?YTYzR0VrMzdOWnMwVkJUSG96OXh3TlNXKzluQyt3TUJYMWZjZFg2V0IzVnlH?=
 =?utf-8?B?L215bWxENkR4eXJycE5kYVFKSXFqcG5TaS9PWkZzNWJ3bUNJdVJkeE81VHRQ?=
 =?utf-8?B?eUFuZmZ6UEI5ZW9ZQlFKMTF1R3VyN3ZyV3E2SVhHT2p1N3VtNmMvT2VSQTda?=
 =?utf-8?B?THhMMml0L2NYOVdsMG9jS1loVjlkOHBycllaQUk5YTBaMWx6ZTlqa1ZQM3Iv?=
 =?utf-8?B?WVh3aWtYNCt4QWZ6NGZ6U2wrVjhFUVRRSGtDbm92dmFJL3hnMjd2MUloWmJG?=
 =?utf-8?B?UmVYZ3IrUTRiM01TU01NQk5TdEJYblNKd25MQlRGYnplT0Juc0ViclMvUFZw?=
 =?utf-8?B?QTZuSWNvUm9zZThHbFlESTJhS1plVTFKd3FhdGhUWkJlbzhDcjFEV3UwTktE?=
 =?utf-8?B?MytMb2ZIYkdWYjVGTnY1NnpRMkJtWU9xNllFdExVb2tGbGhGR3JSZXJOQ085?=
 =?utf-8?B?Ty8wejdLcVh6TXVpdG9zYXZVNlVWVENORGdNN3cvMkNYMGVraDFWMFlwckRa?=
 =?utf-8?B?eVhra0JUM2pLaHJPMk1zNUR6ekFwTjVRWlRnWFR4UkFtZmgzdldhbG13dXIx?=
 =?utf-8?B?WE9rOFpkUVJ1ZE9vSklHbnFMWDZlWXRnT1htU2NtYURjcmUydit2b3hwRk9C?=
 =?utf-8?B?aGdBSThHT0VXcHJDZG5NNmlLQ1UxRlMzUmFjOEgvWFVZSVFnZ0FxRmo4TEVN?=
 =?utf-8?B?ODJ2cDdFRzVtdzNxVFhWaHltU1Y3THRkdmtzM1BWZFZJcUN6alIzNGw2UDRS?=
 =?utf-8?B?UFRjWTZLNWtaS2hKU3ZjdDBaWTBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 02:14:50.0063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb72f6c4-2bdd-41fd-29ee-08de53dbdce5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5538

hi Rodrigo,

   I'm very sorry for introducing this issue. Thank you for your 
reminder. I will immediately submit a patch to add 
SPI_CONTROLLER_MUST_TX to the flags during probe to resolve this problem.

On 1/15/2026 12:09 AM, Rodrigo Alencar wrote:
> [You don't often get email from 455.rodrigo.alencar@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On 26/01/14 02:16PM, Mark Brown wrote:
>> On Wed, Jan 14, 2026 at 02:14:35PM +0000, Rodrigo Alencar wrote:
>>> On 25/10/31 03:30PM, Jun Guo wrote:
>>
>>>> + if (xspi->txbuf) {
>>>> +         switch (xspi->n_bytes) {
>>>> +         case CDNS_SPI_N_BYTES_U8:
>>>> +                 txw = *(u8 *)xspi->txbuf;
>>>> +                 break;
>>
>>>> +         cdns_spi_write(xspi, CDNS_SPI_TXD, txw);
>>>> +         xspi->txbuf = (u8 *)xspi->txbuf + xspi->n_bytes;
>>>> + }
>>
>>> cdns_spi_write(xspi, CDNS_SPI_TXD, txw) needs to be called regardless of xspi->txbuf.
>>> Otherwise, there will be no clock for the read operation to work.
>>> This is a bug I am seeing on a Zedboard running on 6.19
>>
>> So the device needs to be flagged as SPI_CONTROLLER_MUST_TX?
> 
> yes, It works if
> 
> ctlr->flags = SPI_CONTROLLER_MUST_TX;
> 
> is added to the probe function. At least for my case handling with "xlnx,zynq-spi-r1p6"
> 
> kind regards,
> 
> Rodrigo Alencar
> 


