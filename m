Return-Path: <linux-spi+bounces-4109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF59429CE
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 10:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE991F21432
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1D11A8BF2;
	Wed, 31 Jul 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="stMKYT+G"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082391A7F87;
	Wed, 31 Jul 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416335; cv=fail; b=r+Uj8bXtfeQ2vtM+vo9YFmrEi8PGLWVnMzRM0cqruVvnj1AWAtsrO5e4sexihBJ2FScfEZyHn9Ea4dapm3gri+6qWbDk+TmzsBzctdDz+2TbrsaIY2bkLVLRAtANQ2yQMUk8A6bCgfPNGyOnkpKYw+umjoaXy98khAP95HbXozA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416335; c=relaxed/simple;
	bh=zx5QL81elKNi3Hk3O7l2BXurVkNfaLTDR0RVBgJkx7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gr+kVNAYlU/HMRZ9PDASuJf4Z6SKK+WcbvUVrLlJlbliU3/HOjjIRTK0PEzBjcJLYBcQkutDmmH0wWVyuqLdcRcHbpnYmS8PbRNqUhO7m+54ZP2T/YevDsx+K6vCgA7FILqyEQm+XAyPsofe8YKuUIOFoR5Qw2oxZk7/n15PlAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=stMKYT+G; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujGgMoufQR7m0NhyfnxznMOQYSJqjW9tHVCefyzuQa8u6pxwtkDYfrWW1c6297NWd9ATxFj49rvt/u3IOLqDsI3VH9DQxAoQpOHn+b6IFQryXaIX/TTtb3fXVUp7JiWnbt3OnF6FzFkda6Di6I8VGYs84tFL+samp9lquW84jDDc3toIToLmLp9tUx36LMHne4h5Lm2Udbx+yNS7iVXlT6ybtHPlZuxPXibsHvxhEMKjk0dJ1AKavjEZpFrqvjAj2Fd3EslJYQ5i78JfAO0MUMfZYP4f7lH7cJbbdrmdE290f+UsqGGtRK7nojkL4zPKZd2YbpXYbWArA2MgPn16NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT44oiJXV3gnb6p7ArHuvR9ad1u96eoBmnFY6VopABA=;
 b=Sir6pwfrD1igm/FmlZIkEAjTfQDGS0azS3HjwkTVBTodMQgojc8w5HYx/ClRMCKi2Qem4aWA+LG60Td8/4D6kjxKmzHb9tVBjyYgKAoG3lbzr9sfQyMPENxv+y09E8PoEQzSlFGAOAJdeKs2Ck3Y1FokvgMQe6ZyGz4RFpCOtrrmhdT8hJhqkxYidOQ7dfDpT8bvhUJLYOMxLWBV5h5d8YTWHMjYE6tr8TfTH1TeptFhhTLw5vsRUdrojGuDCGViHh7UIkQCBap1yry2D8nzV0qV0q1UjSTiANl+rbJVYZ2RWcEfaNUrDqK7O2J8ytfTR08WaOngFbsnJQyiGKVl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT44oiJXV3gnb6p7ArHuvR9ad1u96eoBmnFY6VopABA=;
 b=stMKYT+G8h8nYDL0zXjdJ+GTioquaG6q0bOIYqGwwOCx+J0B6V8PcEAu61ucSAYL6uDvb/oWv8pTPp+gxxQVBu6tWfrsMNgsUKwa15i+U2AzbdZhLW1s3K98jHEhERiU0kQQip9Y6jAacWS4Iq6XLzteoTPB2JVWkHl/VZF5kQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Wed, 31 Jul
 2024 08:58:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:58:50 +0000
Message-ID: <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com>
Date: Wed, 31 Jul 2024 10:58:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
To: Michael Walle <michael@walle.cc>,
 "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 "beanhuo@micron.com" <beanhuo@micron.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
 <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
 <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
 <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com>
 <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
 <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: e725290d-aa98-4d82-a558-08dcb13eff11
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUVvay82cTVWVDltdys1VlhMRUx5L1RzS3NKVkZrbFZSVW9pM2lYTHBNazI1?=
 =?utf-8?B?clB3TFBncUZLckgyeXNwdzZxeElFRDBsQnlQeDFkclFGUmMrRnVaQnpKVUpn?=
 =?utf-8?B?WUZnZ0IzdFZBVEZtcTRla3BCUHVWUUswNFdiT3VOV0VPeHZVWGROUnNaa3Jt?=
 =?utf-8?B?RWp6WDREQ3laMVh3ZlZuZllFdTBJMHVFczJ3WUlrTlcvN2pQWlhkenNRMUUz?=
 =?utf-8?B?V29USkRpcTJTZHg1Wm8wQVJRQUN4Y3pxZmo1cWJaTDZndmZxNXFkL1d5UUU5?=
 =?utf-8?B?bXArZjNiNjlETFZCQXVVelhHbVkweno3dGtEQ1dUMkpNTEFwRW5rM1dCN0dv?=
 =?utf-8?B?a3NVbW0rU2g2cTdCTkZGL3VaVzNMbXhXOHQ3SnVnc1RNa1pMZ1o4dUFFM05p?=
 =?utf-8?B?VkV5d3hsU0U4UlNxQjRiVmtvUG9NemRxZ01zKzA2dEpjckVJVWdSTkpJMGk0?=
 =?utf-8?B?dkdiMzJuSTliQnNIN2ljQWNxUzI1SmJQV2ZiTEdaQVI1T3J1dCtobmFXb1Bn?=
 =?utf-8?B?Q3BieVRpRnBlUWhlcG1BSHJ4RlpJd3hoL0tBb2x1cXhzYlBhVWRLUjVCL2VF?=
 =?utf-8?B?N2R0WnBsb1B4Z0FwSWhBd1Bma0Z2R0ZadlhJK2c2WFhmazRiOUlIWmZ5Ynls?=
 =?utf-8?B?ZHovcUtBdmZaKzBSaEFZMFFQc0w4c2lzYlZ0WHVmUjl5L3JMUHZkc3N5bVhT?=
 =?utf-8?B?VHVPWEIza25jV0tUV0I3OEJPT2k4c0lGdDBaeGx5REhkQkVtcUNFMll3N3h5?=
 =?utf-8?B?Rk1OQlVqbSsvRWttWk0yOHZocGRaS05MbjJrRVdTVGdFblMrdXljN1NmaW1W?=
 =?utf-8?B?ZUdONVZQM0pBUzBIZ2NsNXQ3UTljakRTaE5vd1h2RTI0NjRsMkE2YjNBQ3pU?=
 =?utf-8?B?N0xMVGJOTVIwdDBsQnU1QnUrR0hILzdycStWaFZlV3BRblRVaGcwVTBMUnJG?=
 =?utf-8?B?blQ2dVdMbFVCYmhwNVVQWWV5a2dONDNjT1dyNXFBRGZyOUxBMWJBQ0lpV0p5?=
 =?utf-8?B?VTVwdXZZQzNnRlJDb1hFTzYrdDRsY28vYTRmWGRqaHk2ZWNKUEQzbHNYZVBC?=
 =?utf-8?B?OHNOQVdQbFEySE1qY0Z3dEQxamI0Yk15b00zYlp2TDBxWjZCZGMwQUNRa2Jv?=
 =?utf-8?B?VlNiMnRaTmdaZjgvU0RHU3NvMTBBMFFVcXZJeUtvVWJpVjJJYWluaUhJUFVl?=
 =?utf-8?B?TGpWSVFRMzhZckZZRXRoUTNxOENyYkVaNDNxQjlodk1LYVBCZ1VrNTkyRkt2?=
 =?utf-8?B?SGVXL2hzYklZbHhBR0Q4Q0ZaRm9laDhXdzB6TVdkN2ZpcmxWYjlDbzlSSWwr?=
 =?utf-8?B?MlZRT0lwaWxnc2ZkTkhmRlhHUXBZb2VkUlV0UzRRUjZ6OWphZXl4b2VlcXdQ?=
 =?utf-8?B?eUNEMnlKcTFLZ2pOcFAwQkhJdHdtQk1iVDhXNE5ucXc1TU1EWkZHeTRXczd4?=
 =?utf-8?B?QlV1V1I1Tzg4blRscDRDR3ZEdzBvWXNVbXdYSzYvTnZmOGUyNjJXOWJsaW1v?=
 =?utf-8?B?QTFGTzV2VWxjNk0zeTJVMUR1RFQycjVWd2xSMzFGQStyOVZzMTgrYW1XcWhj?=
 =?utf-8?B?dlZQOC9VWG1MeVQxWGFPWFVrVy9JTWNYOS9Fei9pWkFFcnRtUTl2MXkvcldF?=
 =?utf-8?B?RmYxYnF6RWFwaUxVQU9CMElOUUF6eHFUNVYwc1dpVDJ5ZDIxcDg2ZkY2RFQw?=
 =?utf-8?B?U1JnME81cC9MNGR2bnRxRzNhVTRIUHZWR2pYUWIzcFJHNlIvcWx2NlltTFNq?=
 =?utf-8?B?V0JnRnZmS1NiaU1wRlVmREZTbUFYM00ra1d1MmNEMTM0WW9uRjY5Unl4ZW9U?=
 =?utf-8?B?SHhvMlJSeU5xcE80bUVSZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmdyektYbDVkcmFHUndOTlJoL0FCOEtaRm41Um1OdDhLN0pFSkp0MmNzZzJz?=
 =?utf-8?B?bVVvcDhuZTUvdGNidW4wZDNwSnI3YzVzWTVwZFEyQndSQXF6dkVKeDY4M1JT?=
 =?utf-8?B?NDgrcDRCTVBlUG11RjNuMEtHUDZBR3lwTjVFa3BQckhibGdoSVFpeFVVdVJ3?=
 =?utf-8?B?R0Ivc1FoYnhYVGFoWFdQd3NsQ2ZrUVp1RHRtZlFPdlJFWmFvNUVFaTRmSEQy?=
 =?utf-8?B?bWZ4aUV2WmhGeG5aOGpQaFpic0tvdGhJWS9tMkRmU3hHeUErTHZ2WWZVcjlP?=
 =?utf-8?B?YnphUE8xMFAwNEtkRHl4dGtDTUNyWUEzdC9mZkJqSWIxMzRDK3VyNk5LNXFQ?=
 =?utf-8?B?eCs2QjRnRHJNWnFZQUtJTkJvNVQvZXRwUitvZFRSWHBXVUp6azFiYm9ML3dn?=
 =?utf-8?B?WEdGNWkxR0Y3SHloNWMxa1F2UnZWRXUwSElFNmllVklhdVF3cXBFendjOU1L?=
 =?utf-8?B?cXg1VUtyTTJXOTJGVHd4bEd4TktDUWNFbWtWZmdqd2E0VWVESG1MY01yT3p5?=
 =?utf-8?B?OTNSR3ZxVE9JSStXOVBRbUtKNmRuMDB4LzQ5VG5LNjl5czdzWklhNkx6ZTZy?=
 =?utf-8?B?TGpPMGNRd2ZsZm92cUI5RkNKV3V0V0JtZCtuWndJKzRzOWN4QitWYXRIVTU3?=
 =?utf-8?B?b1pYa0NleFBsMU01WUZtWFhPN3pBb3dDMmFScDVtNnAwN1Z2RGt1dENrM24w?=
 =?utf-8?B?bU9JNzdiUDBWMEYyWkZnZTVIOHFqVGZyTEpzUDVwM251QS9SZFpCK3JsaDlt?=
 =?utf-8?B?NkFha3JZYXdBR2NqTTVGclRpSVpvM1p3M1NOaWxKYThpaHk5dW5hTDNpQmky?=
 =?utf-8?B?OVJ5QS9tOXJpN2N6YUtJS1VOWEVVdGt0NXRQYWo2U1BuTjEvZ1VVdW8zTUkw?=
 =?utf-8?B?WEw2VFBsK0FiZnhVc25XN01qYWlnYjA0UG00Q1JidUJSYklQOTZ6NEFMNzc5?=
 =?utf-8?B?djZyUTZROWlBYndtM1dsMXQrRThSOFg1VmVwVlY4OEVYZEhIMkhPdDdBR1BJ?=
 =?utf-8?B?azRvWVlWZFA1cXRqNzhTaDlWVnpIT1FRdXgvbjZFZ2J3NUJ1dEkyazlkVDFo?=
 =?utf-8?B?bnBUQzc4UCtmUnNyK00yVFdPVEd0SUtoVG4rcDFKemRYZGtwMGc1SDNVRjNk?=
 =?utf-8?B?eFFJcjVGbERKcGZHTzdvcjFsWTRVaTF0WEJkS2dvNXBxY2FEc0cyN0ZLc3kz?=
 =?utf-8?B?eFROazVuWVVyWHhsMkM5NE5DV3c4bmc1d1RlNll4eDh3MFp1MVgzT1pFQ0tS?=
 =?utf-8?B?S1RMMVhjMnNFZ2gzSkU2S25obmM0UERpMGxWVWlWNTNjR2pnc1QvUXRDcTZ1?=
 =?utf-8?B?ZktQeXBzSFBULzhTblBsUDZRMkI1SUQzcHVsNUk3MzVETWZUNFAwTXR4eHlq?=
 =?utf-8?B?KzJ1N3VyQW5UVkJ0eis3TUdSRGkwTjFZdEVjbHQrSmJZMkdkSExqeEJKUlZP?=
 =?utf-8?B?Mzl6dzlvWVh0RDk1aFZCaVA0bDkwdlpaend6ckZ2eFYrV0FBNU1ZQXhDRkI1?=
 =?utf-8?B?T1ZqVHRzOGhWRjNYZ1dNUUlXSDI0UmFMdkN6TzZMU04zOWhEaGplazFXWXRM?=
 =?utf-8?B?MkRDK011OFpsUjVJbit1RElRWDhES2lDODhXamN4elFXelFSNUczZmI1N25w?=
 =?utf-8?B?U1FCalFYZEFmMXZOODZia1JPcFhyRGhYN1AzNDcwT3lSN2tkS05HWW9RdFVM?=
 =?utf-8?B?Y1prdlRpNXczaU5pa2xRRmI5RjJKdTZBYllvSXQyVCtRR1YrUGZZUnhPN3RP?=
 =?utf-8?B?aVNDUW12amMySkJtRWsrSE92RU5YekdaY3pIV3ZwWkloUUV2WVZyUDJkRktr?=
 =?utf-8?B?WFF2WWZ3UjZnUTZBR1JwSGZhdnErL1o4ZHFzcVBYTFFvMzFkb0VsbFAvVTVZ?=
 =?utf-8?B?WHd6UFk5cDRhaHZhR3RyQjhWRmpNWGZrRXNVNDZzWEwyMTRHRkF1a2YvMER1?=
 =?utf-8?B?YkVyQ1lYTTJPYWhaK0llUTlzK21BMytoWEswSnZpOG5NYkpxL2JxclBoUEtM?=
 =?utf-8?B?ZEtFYXB1MDQzZy92ditoWlhTNm03bDlCbDVpL2Y1M0J5UGlKaVRrNTFTc0Nt?=
 =?utf-8?B?a1ZTZkdPY3hDb1loSmtTaHkySmxFNnMxbWk5d3JyelY5eXFVUlFKamNwWXhp?=
 =?utf-8?Q?wywLyW0Qg6Y2FsojwF9hBXcPp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e725290d-aa98-4d82-a558-08dcb13eff11
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:58:50.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwBZvdgy1mZDzKeCz80gewMzQPUmT/Zl3Azl2Qux37KkW4vC1IWXeynDW1pA7QUa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015

Hi Michael,

On 7/26/24 14:55, Michael Walle wrote:
> Hi,
> 
>> Based on the inputs/suggestions from Tudor, i am planning to add a new
>> layer between the SPI-NOR and MTD layers to support stacked and parallel
>> configurations. This new layer will be part of the spi-nor and located in
>> mtd/spi-nor/
> 
> Will AMD submit to maintain this layer? What happens if the
> maintainer will leave AMD? TBH, personally, I don't like to
> maintain such a niche feature.
> I'd really like to see some use cases and performance reports for
> this, like actual boards (and no evaluation boards don't count). Why
> wouldn't someone just use an octal flash?

AMD/Xilinx is not creating products that's why we don't have data on actual 
boards but I don't really understand why evaluation boards don't count. A lot of 
customers are taking schematics from us and removing parts which they don't need 
and add their custom part.

But one product for parallel configuration which is publicly saying that it is 
using it is for example this SOM.
https://shop.trenz-electronic.de/en/TE0820-05-2AI21MA-MPSoC-Module-with-AMD-Zynq-UltraScale-ZU2CG-1I-2-GByte-DDR4-SDRAM-4-x-5-cm

I am not marketing guy to tell if there is any other which publicly saying we 
are using this feature but we can only develop/support/maintain support for 
these configurations on our evaluation boards because that's what we have access 
to and what we know how it is done.

Also performance numbers from us can be only provided against our evaluation boards.

Thanks,
Michal

