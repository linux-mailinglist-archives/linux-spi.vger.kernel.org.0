Return-Path: <linux-spi+bounces-8686-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141B0AE1778
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 11:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635CB5A3938
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6628368A;
	Fri, 20 Jun 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="O6CtCo2F"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023083.outbound.protection.outlook.com [52.101.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C3283131;
	Fri, 20 Jun 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411654; cv=fail; b=D9+bCWk/tH3c9Nzt2nKFfF33jVZPUs4Y3GnwFnR2WZPGjO+ZhWRlRylygk+Mxg5FthgyxLVgeTw4pDIEVsC1ZipNh0WQVAlidHqcdqTurxy1ypLPVVeAzXOZzK8Jdek4b9VBasFhsfx3ysblHWn76PJ2ybqHWk9mTHHGpvuz/dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411654; c=relaxed/simple;
	bh=uFvUuquxCM6vjwxoyh3Y8LzxLyQ9oKQEgyMjXZ4VGaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aafPOFEXei+oKsA6ojgQqsLFV16yiYASDKzS86y4uhouyZN0++z/hfD0O+k4VUvlbjv3rN8EjQ79y9ZPC5dOOTcZbn0OBdPvozysV9W6gorgro+i4TFAUlMYnj/XV0ZwfxkfRbLTQGffd/L/EbVx8HpWwa4o/MgKwrCilJJ9KBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=O6CtCo2F; arc=fail smtp.client-ip=52.101.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRtIQj7sRdh6khpOYdEdBpVKa973MHrlLqmjUU39iuWfzVh0xxy1IH2ovwlABHzdPQRW2WmyUcfzxvls9ZboQai+SWnUw//PaR9x7tMUi+Lv8wpzHALPVopZQxbJPqjn0fgPpdEUmBHgW+VphvsuwOZMcF679pteHgg2fn+P+RtbLb/+IoketI4qQuNEiIU/JtRf485iwbDRva6tCEoTOQ+Unvz1kfDXGYALzShAIlkXprNJnZ9Yim63bZDZhY+1HxwK1Hi+CdkxqsgYE+GzheqbW9BcDyeU9m8yJHSKIGERnWtrwuFqn1b3wkL+C6jWktvUsRRRJ7zWwaL7OFh7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7FxyIb2Eogl4fFB1m+zVZt1lwuLH7FavzwNZyZDZ4A=;
 b=fdbC81ync+AbtFzjJ2HbnRbc5CDnuQks+BCD8hPumAPuyHDbnNUb/2ABFJvhFSDaE6APtqgxTy/3TB6e3Yr3Qs1fjCEJsfbIKgwKavbO/DkZ/iXQGjb3dZyTI6WvyvBsFRikUTbQMZKgMwR0qtQVeUT53Lue0L+F3cPPhq0PDkJX5TnafeHbWasVMDVgJBrJxyFTQOdzidDb/y1FD7Sr4rDgI2IXnrHos3AcsA6CfucFKMajdyiyuLQjDnlC/EMOrdNKI1zlkQ8pOulqpyoZTVLmanlNMfA/U4sW6NTYfdT+NVhdaNrA5ZrAOFA7ocmaLkX6m0nXDqy27Uf57aWDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7FxyIb2Eogl4fFB1m+zVZt1lwuLH7FavzwNZyZDZ4A=;
 b=O6CtCo2Fs0s/IPBqxeORPIS7Lkj2ar8Th/iAif2SlTy7aeSzTtl5eVfveEBOXJvqfIDi/KmDP15XEf8BegTGbYWNihBDJmUI3SklVwtYQj//EdZZzc/viUiSxLl4+BG40c50BS0tFWdx1d3gsrKDmBfuYN3U9fwoTWGgyCotPauPoAgOjINHrxrL5g1uk2ydUJwIEVlKrDVkTCzFd9kbf9OTFPHjrcxOdv/LNnxQMtf5wq7rnnMBO6eV+4uIva+bf6F2uxILqSKXygMwD/VpRUXldFNFN0Ajkvbs4Dy8Z76d3LfRijX0xTwRw9Ev3M3kuwScuSlUxzhTbeZ1yV1m+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB8130.apcprd03.prod.outlook.com (2603:1096:400:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 09:27:27 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 09:27:27 +0000
Message-ID: <1a8cd442-351d-4ff1-929f-aca61f08261f@amlogic.com>
Date: Fri, 20 Jun 2025 17:27:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: Add Amlogic SPISG driver
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617-spisg-v2-0-51a605a84bd5@amlogic.com>
 <20250617-spisg-v2-2-51a605a84bd5@amlogic.com>
 <a2dcd335-f7cf-468a-ad7f-278ffc8b0894@linaro.org>
Content-Language: en-US
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <a2dcd335-f7cf-468a-ad7f-278ffc8b0894@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ed7090-833f-4853-7f01-08ddafdcabcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU9jcGZubGp5V0JDWE1sblFMWHYxSy9RbE9kaWJkMW5QZjN6ZW42VENIQzVk?=
 =?utf-8?B?a3V6amNtdzZSdXdSUjJqdkUramU4d256a1g1Uzc3RmhhOHMwWkIyUTl5TEN0?=
 =?utf-8?B?TEo2eXFCQ0xsblU0aEx2RG5Ea2ZVd3BpOFkrV1EreFFrcy8xZkUwa2F0Zzg5?=
 =?utf-8?B?dnRSQTNpVmZwZ29PSTBKeTl4Q3MyQ2J5MTQzZ201ckRmZ0s5akhBUmh6VVNW?=
 =?utf-8?B?cVdIcGRmdTRjZzZ4OVhLSXNwUHQvNnpISWZ2T2IyenR0U0lqWVhOQ2pjM0Rm?=
 =?utf-8?B?MWhVd1pRMU5ibjJTWUMyejliVzdoTEZIMkpaVmdkdks3cXYvczJZdUtFZDRH?=
 =?utf-8?B?N0VrTXl6aGdpbVFlZDBmSUFIZ3BzWGFJUGRFV3R5U1N3RDB1dDNzc2RKd2ZQ?=
 =?utf-8?B?RFErckpEclpxdmplb0ZxQWVTYnB6SFllNmQ3YytRelNxRzFERVI2N001L1NF?=
 =?utf-8?B?NnV5SEd1RUVFM25SNkpjbmhDaWJXdTNKamtxQWZqNjJsNVA5RWVxZWdMdElu?=
 =?utf-8?B?ZUgrZWNFQ0FHa0ZyeXJaZVExSkNrV21sZVI1Q0Yrd1JZZTBEMUM0a2VqSVF3?=
 =?utf-8?B?bjM5eVZOQXZ5ODRGY2xvKy9MaU9Ea0lDR28wZU91TUpyV25uN0NBZnJSNmNL?=
 =?utf-8?B?ZnRjSk9wb0hzbXV0bkFjUndVbWZBREVLMVJObTZ2MWVqelgwQi92Y2FVTEVp?=
 =?utf-8?B?M2JNVzExakJJc09yTThVR0t5Rm1EMHFZZkNRbkQ4LzZEczl3T2orOVdNRlRP?=
 =?utf-8?B?V2Z4REpHS3M4N3F3YmNLMk54SG9COHhRMmNVLzY0Yit1MGVkK0c1am9QNi9K?=
 =?utf-8?B?aHVJbE9od1JOWmErZjBkeVBGUDFvZUZGMTNMd3lvSitMUlpsdEZnYlV6TWZX?=
 =?utf-8?B?VW54aCtwMEh0Z2NXMGR2amRuSkVNUFE4aEpYc3R2UWRFckdXRE1COFpBRXMy?=
 =?utf-8?B?TWU3ak9zU1RQa0c3cnQ5VUIzb0JqM3QwNjMvQnF6dVpwMU94a3N5cEdZZjRI?=
 =?utf-8?B?MEZHSkIyS0t0U0xjbUZYbVlGV1VzVzRsS2E3NUFoZmNSMzJyVnJ2RU9VUHpm?=
 =?utf-8?B?MmNHc2krTFdMSHpPZ2pVdmFLSkdNT2d1NVZXa3h1cUgxV0dYT2VxOXN4c0dH?=
 =?utf-8?B?QXpleXdSbmx2Y0VZbmFVS0VPWVZ1dWJvZUJHUUZFQlB4Vk9NVUd0a3F6Mzh2?=
 =?utf-8?B?dWhyUEZnUERwSlpVWVdBcjNNajZMS1BKQmVaWTA5bUY5RkZ1dDc1akp6NDU4?=
 =?utf-8?B?WUFsOXZ2b1cxYmRkblVCc1RjT3k2b1JEcEg1ZVhTMFBaM3V1a0p6TU9iMU5v?=
 =?utf-8?B?WTFxNmhkeUliZzMrY1BZd1p5UVJtaTM4a3pDMUVhYWw4cVZVV3R3Q2ZmRDlH?=
 =?utf-8?B?N3BDSXh5WkoyZGdlWlh2YWZhN3FWdVY3OVNvMW9vWTlmeTl0eWlyTUR1NVVr?=
 =?utf-8?B?Tk1IVVNOMXpzWWdwbHdhMVY2cllVVi9VdllxMitQUmJEVVo3STdwN3lyOE4v?=
 =?utf-8?B?WWFXTnhpN2Y0Y1JLZ0FFZG1UYTErQTV6WXBVSU9yZlVXbjg0eStTek1uM3lT?=
 =?utf-8?B?bVY0NDZvSWhXM1VBU2JwWThXQ3hOa3F5MlhnVWpYYm85aGpiY1JtcVNiNkRN?=
 =?utf-8?B?S3doRDhPUU1tVzUxK0wvL1hVdGZPalZIZGllMElaeGlpNnVaTWxSTldhbnd6?=
 =?utf-8?B?Ty9NRjNaYjJucUFwMERMWUFpQkdSRDhxYkN1MEtMRkI0NGUxMjNFT1pwYUdZ?=
 =?utf-8?B?RnJOSk1zRTlxcktobUw5cGtxS2Fza1ljREdFS1UydmZyN3FUQzJ4Y214S3F0?=
 =?utf-8?B?VUxFREZzR294eHJCVVEwZ2ZwRnpXNjl5QzRIbXM2WS85NytiR0F1TXBXb0l5?=
 =?utf-8?B?M0NYSzEzZnBMWGRoeU1ZWWpnNzVnSUlRL2tHU2xkeGxTQWpKcmQ2QjVQdGdh?=
 =?utf-8?Q?S7go75or5Bw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0J3WUlidE5qaGhEYVh1QXNNK0pOL3JRTDMwVy9YREZSUldudVcwS1dJT1FM?=
 =?utf-8?B?WGNxdUtVbEY4VmtaOU8vRnJlekl6Ylp0MjhFNTkyYXhiYkRIMVVWMDV0VkFR?=
 =?utf-8?B?R2dkMGo5bEhReGsxbThzY01OSEhLSkZib0ZrdEJmcG5VanFQUzc1UWR1QzBP?=
 =?utf-8?B?L2JrYkxpbEtUREVEVWxxM2pwWmV0NzdQbjBkK0pzM3c0TVB5Zzh4eEcyTlpF?=
 =?utf-8?B?Q1BteDlOMDZCSzNCQlBYMnpYeHprckZWTU9LbWgrWEJHTU5Na241Z1ZPamNo?=
 =?utf-8?B?akI2ZGFVTTZrUzZyaVZiQjNwSjlPSkVXcTE1QStHM2NlTTRyWHdiTUxvQ1Y4?=
 =?utf-8?B?RFBaMHIyVm84MEU4TVlKSEdwVlZuWDRFZThBMkNKa3hSdDVES2xEdEZaOVUz?=
 =?utf-8?B?bm5ySzQ0cGhOcUg3S1dUT3p1UGdPcSs1OUV0YzFydGxGemR1L2NJVzVoS3Y3?=
 =?utf-8?B?ZXhGN3Vhemk3SGIxZGo5OEk5RzVFVWRkdXNSY04vL0JNR2RoSHRsdnJTbzRK?=
 =?utf-8?B?allBbFE2MjRjWjkzOGl5bUd1aGZmR0xYU3lib3J5akcxMDhjb0c4UkUyTjNM?=
 =?utf-8?B?MHphdE1qNjlDTEFCTVNSYjhmQjlOZ2VrZUpjc2tPQ2hXeUxUZVQ0MDB6Nkl5?=
 =?utf-8?B?b2UyMldYWjNWYTg4Z2o4MlRlemh0a2ZLRzFCS05uN1JEK3JKTEl1SWxCYWhQ?=
 =?utf-8?B?M20yMDllWTdtU2ViWDB0RUQ3eW9Ebnp4MEU3L1pwZ0ZJVWZGa1BKc1lmVGhv?=
 =?utf-8?B?TjZlTElHbmtGdnZZblBBZG95YThtUkN5a1BWV0hzRDA3K3UzdCtLamxwWFB2?=
 =?utf-8?B?OE9sTk9BVmxKemtOa0g4SmtHUUtVS0RCZzczdDZ6YVZIUWNJRDE0eEZVeHB0?=
 =?utf-8?B?M0hqMmlydTFaWjhQLzlPWUZmVG5leDBrbm9XL0RwblVXNFoxNFZoaE1ET01t?=
 =?utf-8?B?eVI4K2YzRFd1QkgxR3IwWWc3N2ExS0lITTMwUVZIWjNLSGpsbXU3bytrVjZY?=
 =?utf-8?B?ZVpSc3J4UGNwNEt2OFBUNUR1UklnZnZVWnFJWlR3SlRmWS9JbkpvQzF5NFY2?=
 =?utf-8?B?N2VmTWJaSUJhQURjL0o0a2NjUFVxRVdaWXdlang2WkNoZTBOZWVURmo3K2hv?=
 =?utf-8?B?TjVYbENBMy91VmRZOEpUbW1vd011MmI0aFlxbWNXd3Q5a0dZOWVnTmFTOWJo?=
 =?utf-8?B?ZWZRcDlKRmFoRXZDMDdHUEpDVFFoblN3RXJ5bWM2SVI2VXRGRmQwTERMa2R2?=
 =?utf-8?B?WDd0T1dBNFdlb1VLa05ZbjBRR0JVTEUxeU50dG9NdWsrVjRsUlZMUWZNdVEz?=
 =?utf-8?B?SEQ4ZW5ndjJpVFFMbEVaLy9uVUJWZzg1aER4ODMxR0xMYW1EOFVtWVo0bWFv?=
 =?utf-8?B?R0lRYWJmZEd4UUExT1VOdkQ3Ny8xbVJESkZ2c0d2bzVDYkZkZ0FlTTJHbVFt?=
 =?utf-8?B?Z0tFQVovYXhTWFlmdXlsNU00c2ZXb3FnTlBTb24zcFlkT0xURUVWT1Y1WCtW?=
 =?utf-8?B?YVA2czl0aXFDMkRhTGNmR2ZMbTF4bjNEZFIzS25lNWZSaE1GNjMycWNhbld0?=
 =?utf-8?B?amdLeDYyTHVrSkExcjRuSVYxdW5QU1ZraWIvcDJRSVhHVUFmU05UWFZKMFg2?=
 =?utf-8?B?MFBtSmhsTHIyb1o5TmN2b05TenIvRWRaMXJDWEhtWUcvOUxydW9QQjFQYTFU?=
 =?utf-8?B?a1luaFBEWXFrNGw0ZkFKMmtBVjEwOEQ5SnExNlFoV3U2c1ZWSVJMMDVONXZL?=
 =?utf-8?B?VXpKNDR2eCtIdUdXSG9jUUNpR3BNWXRUYjFsLzNXY2ZhWXcweHhRd1RtTlNS?=
 =?utf-8?B?bVpkdm0zN2xJZHRxUEZINmFtZ1NhOCtxb2lCOE1Qc3BZMnVYQmQrL2lSZnc1?=
 =?utf-8?B?b1lyalV6ZTdUNmYzR0FOR1duckk5R0wrWm10U3NPUTdnd1Fmb3kyb282d1Fm?=
 =?utf-8?B?bFprQTNVZE5JVUsyZk9JcnphRnFpT2c1N2kxMmNyRFhWR1pybTFqd2NhRGJM?=
 =?utf-8?B?QkVJQmtBTDdXeHVHNXY1dmJKck5VOEVBUUZBTGxzOExoQzg5NXlHMGZMVUVS?=
 =?utf-8?B?S2VXcGRvRjdPWTZVNTROWS85RFA4aklva0F4R21zallqN3dSWWtRQU1VeFdx?=
 =?utf-8?B?NW9rb0xIVFN2ak1HdmJyR1NEaUMrcDlSaEtDNVR2ZUoyc3ZSZ2hZSzJZbmFo?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ed7090-833f-4853-7f01-08ddafdcabcf
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 09:27:27.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex0uP1bf6YxuxzMexQTmMFXz+fhexul67EWwG15QqDZWavuLzdPtMiS3D7xduGVfUqahEU/6wiKHPDizRd5qrsHc9nXP0iuizuyQGtxUxSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8130

Hi Neil,
    Thanks for your reply.

On 2025/6/18 00:29, neil.armstrong@linaro.org wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 17/06/2025 04:48, Xianwei Zhao via B4 Relay wrote:
>> From: Sunny Luo <sunny.luo@amlogic.com>
>>
>> Introduced support for the new SPI IP (SPISG) driver. The SPISG is
>> a communication-oriented SPI controller from Amlogic,supporting
>> three operation modes: PIO, block DMA, and scatter-gather DMA.
>>
>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/spi/Kconfig             |   9 +
>>   drivers/spi/Makefile            |   1 +
>>   drivers/spi/spi-amlogic-spisg.c | 878 
>> ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 888 insertions(+)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index c51da3fc3604..e11341df2ecf 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -99,6 +99,15 @@ config SPI_AMLOGIC_SPIFC_A1
>>         This enables master mode support for the SPIFC (SPI flash
>>         controller) available in Amlogic A1 (A113L SoC).
>>
>> +config SPI_AMLOGIC_SPISG
>> +     tristate "Amlogic SPISG controller"
>> +     depends on COMMON_CLK
>> +     depends on ARCH_MESON || COMPILE_TEST
>> +     help
>> +       This enables master mode support for the SPISG (SPI 
>> scatter-gather
>> +       communication controller), which is available on platforms 
>> such as
>> +       Amlogic A4 SoCs.
>> +
>>   config SPI_APPLE
>>       tristate "Apple SoC SPI Controller platform driver"
>>       depends on ARCH_APPLE || COMPILE_TEST
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 4ea89f6fc531..b74e3104d71f 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_SPI_ALTERA)            += 
>> spi-altera-platform.o
>>   obj-$(CONFIG_SPI_ALTERA_CORE)               += spi-altera-core.o
>>   obj-$(CONFIG_SPI_ALTERA_DFL)                += spi-altera-dfl.o
>>   obj-$(CONFIG_SPI_AMLOGIC_SPIFC_A1)  += spi-amlogic-spifc-a1.o
>> +obj-$(CONFIG_SPI_AMLOGIC_SPISG)              += spi-amlogic-spisg.o
>>   obj-$(CONFIG_SPI_APPLE)                     += spi-apple.o
>>   obj-$(CONFIG_SPI_AR934X)            += spi-ar934x.o
>>   obj-$(CONFIG_SPI_ARMADA_3700)               += spi-armada-3700.o
>> diff --git a/drivers/spi/spi-amlogic-spisg.c 
>> b/drivers/spi/spi-amlogic-spisg.c
>> new file mode 100644
>> index 000000000000..bf7d9d0aae6c
>> --- /dev/null
>> +++ b/drivers/spi/spi-amlogic-spisg.c
>> @@ -0,0 +1,878 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Driver for Amlogic SPI communication Scatter-Gather Controller
>> + *
>> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
>> + *
>> + * Author: Sunny Luo <sunny.luo@amlogic.com>
>> + * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/types.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/reset.h>
>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/delay.h>
>> +#include <linux/cacheflush.h>
>> +#include <linux/regmap.h>
>> +
>> +/* Register Map */
>> +#define SPISG_REG_CFG_READY          0x00
>> +
>> +#define SPISG_REG_CFG_SPI            0x04
>> +#define FIELD_BUS64_EN               BIT(0)
> 
> Weird FIELD_ define, it could collide with FIELD_PREP/GET, usually
> we prepent the register name like:
> #define CFG_SPI_BUS64_EN                BIT(0)
> 

Will do.

>> +#define FIELD_SLAVE_EN               BIT(1)
>> +#define FIELD_SLAVE_SELECT   GENMASK(3, 2)
>> +#define FIELD_SFLASH_WP              BIT(4)
>> +#define FIELD_SFLASH_HD              BIT(5)
>> +/* start on vsync rising */
>> +#define FIELD_HW_POS         BIT(6)
>> +/* start on vsync falling */
>> +#define FIELD_HW_NEG         BIT(7)
>> +
>> +#define SPISG_REG_CFG_START          0x08
>> +#define FIELD_BUS64_EN               BIT(0)
>> +#define FIELD_BLOCK_NUM              GENMASK(19, 0)
>> +#define FIELD_BLOCK_SIZE     GENMASK(22, 20)
>> +#define FIELD_DATA_COMMAND   BIT(23)
>> +#define FIELD_OP_MODE                GENMASK(25, 24)
>> +#define FIELD_RXD_MODE               GENMASK(27, 26)
>> +#define FIELD_TXD_MODE               GENMASK(29, 28)
>> +#define FIELD_EOC            BIT(30)
>> +#define FIELD_PEND           BIT(31)
>> +
>> +#define SPISG_REG_CFG_BUS            0x0C
>> +#define FIELD_CLK_DIV                GENMASK(7, 0)
>> +#define CLK_DIV_WIDTH                        8
>> +#define FIELD_RX_TUNING              GENMASK(11, 8)
>> +#define FIELD_TX_TUNING              GENMASK(15, 12)
>> +#define FIELD_CS_SETUP               GENMASK(19, 16)
>> +#define FIELD_LANE           GENMASK(21, 20)
>> +#define FIELD_HALF_DUPLEX    BIT(22)
>> +#define FIELD_B_L_ENDIAN     BIT(23)
>> +#define FIELD_DC_MODE                BIT(24)
>> +#define FIELD_NULL_CTL               BIT(25)
>> +#define FIELD_DUMMY_CTL              BIT(26)
>> +#define FIELD_READ_TURN              GENMASK(28, 27)
>> +#define FIELD_KEEP_SS                BIT(29)
>> +#define FIELD_CPHA           BIT(30)
>> +#define FIELD_CPOL           BIT(31)
>> +
>> +#define SPISG_REG_PIO_TX_DATA_L              0x10
>> +#define SPISG_REG_PIO_TX_DATA_H              0x14
>> +#define SPISG_REG_PIO_RX_DATA_L              0x18
>> +#define SPISG_REG_PIO_RX_DATA_H              0x1C
>> +#define SPISG_REG_MEM_TX_ADDR_L              0x10
>> +#define SPISG_REG_MEM_TX_ADDR_H              0x14
>> +#define SPISG_REG_MEM_RX_ADDR_L              0x18
>> +#define SPISG_REG_MEM_RX_ADDR_H              0x1C
>> +#define SPISG_REG_DESC_LIST_L                0x20
>> +#define SPISG_REG_DESC_LIST_H                0x24
>> +#define FIELD_DESC_PENDING           BIT(31)
>> +#define SPISG_REG_DESC_CURRENT_L     0x28
>> +#define SPISG_REG_DESC_CURRENT_H     0x2c
>> +#define SPISG_REG_IRQ_STS            0x30
>> +#define SPISG_REG_IRQ_ENABLE         0x34
>> +#define FIELD_RCH_DESC_EOC           BIT(0)
>> +#define FIELD_RCH_DESC_INVALID               BIT(1)
>> +#define FIELD_RCH_DESC_RESP          BIT(2)
>> +#define FIELD_RCH_DATA_RESP          BIT(3)
>> +#define FIELD_WCH_DESC_EOC           BIT(4)
>> +#define FIELD_WCH_DESC_INVALID               BIT(5)
>> +#define FIELD_WCH_DESC_RESP          BIT(6)
>> +#define FIELD_WCH_DATA_RESP          BIT(7)
>> +#define FIELD_DESC_ERR                       BIT(8)
>> +#define FIELD_SPI_READY                      BIT(9)
>> +#define FIELD_DESC_DONE                      BIT(10)
>> +#define FIELD_DESC_CHAIN_DONE                BIT(11)
>> +
>> +#define SPISG_MAX_REG                        0x40
>> +
>> +#define SPISG_BLOCK_MAX                      0x100000
>> +
>> +#define SPISG_OP_MODE_WRITE_CMD              0
>> +#define SPISG_OP_MODE_READ_STS               1
>> +#define SPISG_OP_MODE_WRITE          2
>> +#define SPISG_OP_MODE_READ           3
>> +
>> +#define SPISG_DATA_MODE_NONE         0
>> +#define SPISG_DATA_MODE_PIO          1
>> +#define SPISG_DATA_MODE_MEM          2
>> +#define SPISG_DATA_MODE_SG           3
>> +
>> +#define SPISG_CLK_DIV_MAX            256
>> +/* recommended by specification */
>> +#define SPISG_CLK_DIV_MIN            4
>> +#define DIV_NUM (SPISG_CLK_DIV_MAX - SPISG_CLK_DIV_MIN + 1)
>> +
>> +#define SPISG_PCLK_RATE_MIN          24000000
>> +
>> +#define SPISG_SINGLE_SPI             0
>> +#define SPISG_DUAL_SPI                       1
>> +#define SPISG_QUAD_SPI                       2
>> +
>> +struct spisg_sg_link {
>> +#define FIELD_ADDR_VALID     BIT(0)
>> +#define FIELD_ADDR_EOC               BIT(1)
>> +#define FIELD_ADDR_IRQ               BIT(2)
>> +#define FIELD_ADDR_ACT               GENMASK(5, 3)
>> +#define FIELD_ADDR_RING              BIT(6)
>> +#define FIELD_ADDR_LEN               GENMASK(31, 8)
>> +     u32                     addr;
>> +     u32                     addr1;
>> +};
>> +
>> +struct spisg_descriptor {
>> +     u32                             cfg_start;
>> +     u32                             cfg_bus;
>> +     u64                             tx_paddr;
>> +     u64                             rx_paddr;
>> +};
>> +
>> +struct spisg_descriptor_extra {
>> +     struct spisg_sg_link            *tx_ccsg;
>> +     struct spisg_sg_link            *rx_ccsg;
>> +     int                             tx_ccsg_len;
>> +     int                             rx_ccsg_len;
>> +};
>> +
>> +struct spisg_device {
>> +     struct spi_controller           *controller;
>> +     struct platform_device          *pdev;
>> +     struct regmap                   *map;
>> +     struct clk                      *core;
>> +     struct clk                      *pclk;
>> +     struct clk                      *sclk;
>> +     struct clk_div_table            *tbl;
>> +     struct completion               completion;
>> +     u32                             status;
>> +     u32                             speed_hz;
>> +     u32                             effective_speed_hz;
>> +     u32                             bytes_per_word;
>> +     u32                             cfg_spi;
>> +     u32                             cfg_start;
>> +     u32                             cfg_bus;
>> +};
>> +
>> +static int spi_delay_to_sclk(u32 slck_speed_hz, struct spi_delay *delay)
>> +{
>> +     u32 ns;
>> +
>> +     if (!delay)
>> +             return 0;
>> +
>> +     if (delay->unit == SPI_DELAY_UNIT_SCK)
>> +             return delay->value;
>> +
>> +     ns = spi_delay_to_ns(delay, NULL);
>> +     if (ns < 0)
>> +             return 0;
>> +
>> +     return DIV_ROUND_UP_ULL(slck_speed_hz * ns, NSEC_PER_SEC);
>> +}
>> +
>> +static inline u32 aml_spisg_sem_down_read(struct spisg_device *spisg)
>> +{
>> +     u32 ret;
>> +
>> +     regmap_read(spisg->map, SPISG_REG_CFG_READY, &ret);
>> +     if (ret)
>> +             regmap_write(spisg->map, SPISG_REG_CFG_READY, 0);
>> +
>> +     return ret;
>> +}
>> +
>> +static inline void aml_spisg_sem_up_write(struct spisg_device *spisg)
>> +{
>> +     regmap_write(spisg->map, SPISG_REG_CFG_READY, 1);
>> +}
>> +
>> +static int aml_spisg_set_speed(struct spisg_device *spisg, uint 
>> speed_hz)
>> +{
>> +     u32 cfg_bus;
>> +
>> +     if (!speed_hz || speed_hz == spisg->speed_hz)
>> +             return 0;
>> +
>> +     spisg->speed_hz = speed_hz;
>> +     clk_set_rate(spisg->sclk, speed_hz);
> 
> You should check clk_set_rate(), and it seems you just never 
> prepare_enable this clock...
> 

Indeed, Will fix it.

>> +     /* Store the div for the descriptor mode */
>> +     regmap_read(spisg->map, SPISG_REG_CFG_BUS, &cfg_bus);
>> +     spisg->cfg_bus &= ~FIELD_CLK_DIV;
>> +     spisg->cfg_bus |= cfg_bus & FIELD_CLK_DIV;
>> +     spisg->effective_speed_hz = clk_get_rate(spisg->sclk);
>> +     dev_dbg(&spisg->pdev->dev,
>> +             "desired speed %dHz, effective speed %dHz\n",
>> +             speed_hz, spisg->effective_speed_hz);
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_spisg_setup_device(struct spisg_device *spisg,
>> +                               struct spi_device *spi)
>> +{
>> +     if (!spi->bits_per_word || spi->bits_per_word % 8) {
>> +             dev_err(&spisg->pdev->dev, "invalid wordlen %d\n", 
>> spi->bits_per_word);
>> +             return -EINVAL;
>> +     }
>> +
>> +     spisg->bytes_per_word = spi->bits_per_word >> 3;
>> +
>> +     spisg->cfg_spi &= ~FIELD_SLAVE_SELECT;
>> +     spisg->cfg_spi |= FIELD_PREP(FIELD_SLAVE_SELECT, 
>> spi_get_chipselect(spi, 0));
>> +
>> +     spisg->cfg_bus &= ~(FIELD_CPOL | FIELD_CPHA | FIELD_B_L_ENDIAN | 
>> FIELD_HALF_DUPLEX);
>> +     spisg->cfg_bus |= FIELD_PREP(FIELD_CPOL, !!(spi->mode & 
>> SPI_CPOL)) |
>> +                       FIELD_PREP(FIELD_CPHA, !!(spi->mode & 
>> SPI_CPHA)) |
>> +                       FIELD_PREP(FIELD_B_L_ENDIAN, !!(spi->mode & 
>> SPI_LSB_FIRST)) |
>> +                       FIELD_PREP(FIELD_HALF_DUPLEX, !!(spi->mode & 
>> SPI_3WIRE));
>> +
>> +     return 0;
>> +}
>> +
>> +static bool aml_spisg_can_dma(struct spi_controller *ctlr,
>> +                           struct spi_device *spi,
>> +                           struct spi_transfer *xfer)
>> +{
>> +     return true;
>> +}
>> +
>> +static void aml_spisg_sg_xlate(struct sg_table *sgt, struct 
>> spisg_sg_link *ccsg)
>> +{
>> +     struct scatterlist *sg;
>> +     int i;
>> +
>> +     for_each_sg(sgt->sgl, sg, sgt->nents, i) {
>> +             ccsg->addr = FIELD_PREP(FIELD_ADDR_VALID, 1) |
>> +                          FIELD_PREP(FIELD_ADDR_RING, 0) |
>> +                          FIELD_PREP(FIELD_ADDR_EOC, sg_is_last(sg)) |
>> +                          FIELD_PREP(FIELD_ADDR_LEN, sg_dma_len(sg));
>> +             ccsg->addr1 = (u32)sg_dma_address(sg);
>> +             ccsg++;
>> +     }
>> +}
>> +
>> +static int nbits_to_lane[] = {
>> +     SPISG_SINGLE_SPI,
>> +     SPISG_SINGLE_SPI,
>> +     SPISG_DUAL_SPI,
>> +     -EINVAL,
>> +     SPISG_QUAD_SPI
>> +};
>> +
>> +static int aml_spisg_setup_transfer(struct spisg_device *spisg,
>> +                                 struct spi_transfer *xfer,
>> +                                 struct spisg_descriptor *desc,
>> +                                 struct spisg_descriptor_extra *exdesc)
>> +{
>> +     int block_size, blocks;
>> +     struct device *dev = &spisg->pdev->dev;
>> +     struct spisg_sg_link *ccsg;
>> +     int ccsg_len;
>> +     dma_addr_t paddr;
>> +     int ret;
>> +
>> +     memset(desc, 0, sizeof(*desc));
>> +     if (exdesc)
>> +             memset(exdesc, 0, sizeof(*exdesc));
>> +     aml_spisg_set_speed(spisg, xfer->speed_hz);
>> +     xfer->effective_speed_hz = spisg->effective_speed_hz;
>> +
>> +     desc->cfg_start = spisg->cfg_start;
>> +     desc->cfg_bus = spisg->cfg_bus;
>> +
>> +     block_size = xfer->bits_per_word >> 3;
>> +     blocks = xfer->len / block_size;
>> +
>> +     desc->cfg_start |= FIELD_PREP(FIELD_EOC, 0);
>> +     desc->cfg_bus |= FIELD_PREP(FIELD_KEEP_SS, !xfer->cs_change);
>> +     desc->cfg_bus |= FIELD_PREP(FIELD_NULL_CTL, 0);
>> +
>> +     if (xfer->tx_buf || xfer->tx_dma) {
>> +             desc->cfg_bus |= FIELD_PREP(FIELD_LANE, 
>> nbits_to_lane[xfer->tx_nbits]);
>> +             desc->cfg_start |= FIELD_PREP(FIELD_OP_MODE, 
>> SPISG_OP_MODE_WRITE);
>> +     }
>> +     if (xfer->rx_buf || xfer->rx_dma) {
>> +             desc->cfg_bus |= FIELD_PREP(FIELD_LANE, 
>> nbits_to_lane[xfer->rx_nbits]);
>> +             desc->cfg_start |= FIELD_PREP(FIELD_OP_MODE, 
>> SPISG_OP_MODE_READ);
>> +     }
>> +
>> +     if (FIELD_GET(FIELD_OP_MODE, desc->cfg_start) == 
>> SPISG_OP_MODE_READ_STS) {
>> +             desc->cfg_start |= FIELD_PREP(FIELD_BLOCK_SIZE, blocks) |
>> +                                FIELD_PREP(FIELD_BLOCK_NUM, 1);
>> +     } else {
>> +             blocks = min_t(int, blocks, SPISG_BLOCK_MAX);
>> +             desc->cfg_start |= FIELD_PREP(FIELD_BLOCK_SIZE, 
>> block_size & 0x7) |
>> +                                FIELD_PREP(FIELD_BLOCK_NUM, blocks);
>> +     }
>> +
>> +     if (xfer->tx_sg.nents && xfer->tx_sg.sgl) {
>> +             ccsg_len = xfer->tx_sg.nents * sizeof(struct 
>> spisg_sg_link);
>> +             ccsg = kzalloc(ccsg_len, GFP_KERNEL | GFP_DMA);
>> +             if (!ccsg) {
>> +                     dev_err(dev, "alloc tx_ccsg failed\n");
>> +                     return -ENOMEM;
>> +             }
>> +
>> +             aml_spisg_sg_xlate(&xfer->tx_sg, ccsg);
>> +             paddr = dma_map_single(dev, (void *)ccsg,
>> +                                    ccsg_len, DMA_TO_DEVICE);
>> +             ret = dma_mapping_error(dev, paddr);
>> +             if (ret) {
>> +                     kfree(ccsg);
>> +                     dev_err(dev, "tx ccsg map failed\n");
>> +                     return ret;
>> +             }
>> +
>> +             desc->tx_paddr = paddr;
>> +             desc->cfg_start |= FIELD_PREP(FIELD_TXD_MODE, 
>> SPISG_DATA_MODE_SG);
>> +             exdesc->tx_ccsg = ccsg;
>> +             exdesc->tx_ccsg_len = ccsg_len;
>> +             
>> dma_sync_sgtable_for_device(spisg->controller->cur_tx_dma_dev,
>> +                                         &xfer->tx_sg, DMA_TO_DEVICE);
>> +     } else if (xfer->tx_buf || xfer->tx_dma) {
>> +             paddr = xfer->tx_dma;
>> +             if (!paddr) {
>> +                     paddr = dma_map_single(dev, (void *)xfer->tx_buf,
>> +                                            xfer->len, DMA_TO_DEVICE);
>> +                     ret = dma_mapping_error(dev, paddr);
>> +                     if (ret) {
>> +                             dev_err(dev, "tx buf map failed\n");
>> +                             return ret;
>> +                     }
>> +             }
>> +             desc->tx_paddr = paddr;
>> +             desc->cfg_start |= FIELD_PREP(FIELD_TXD_MODE, 
>> SPISG_DATA_MODE_MEM);
>> +     }
>> +
>> +     if (xfer->rx_sg.nents && xfer->rx_sg.sgl) {
>> +             ccsg_len = xfer->rx_sg.nents * sizeof(struct 
>> spisg_sg_link);
>> +             ccsg = kzalloc(ccsg_len, GFP_KERNEL | GFP_DMA);
>> +             if (!ccsg) {
>> +                     dev_err(dev, "alloc rx_ccsg failed\n");
>> +                     return -ENOMEM;
>> +             }
>> +
>> +             aml_spisg_sg_xlate(&xfer->rx_sg, ccsg);
>> +             paddr = dma_map_single(dev, (void *)ccsg,
>> +                                    ccsg_len, DMA_TO_DEVICE);
>> +             ret = dma_mapping_error(dev, paddr);
>> +             if (ret) {
>> +                     kfree(ccsg);
>> +                     dev_err(dev, "rx ccsg map failed\n");
>> +                     return ret;
>> +             }
>> +
>> +             desc->rx_paddr = paddr;
>> +             desc->cfg_start |= FIELD_PREP(FIELD_RXD_MODE, 
>> SPISG_DATA_MODE_SG);
>> +             exdesc->rx_ccsg = ccsg;
>> +             exdesc->rx_ccsg_len = ccsg_len;
>> +             
>> dma_sync_sgtable_for_device(spisg->controller->cur_rx_dma_dev,
>> +                                         &xfer->rx_sg, DMA_FROM_DEVICE);
>> +     } else if (xfer->rx_buf || xfer->rx_dma) {
>> +             paddr = xfer->rx_dma;
>> +             if (!paddr) {
>> +                     paddr = dma_map_single(dev, xfer->rx_buf,
>> +                                            xfer->len, DMA_FROM_DEVICE);
>> +                     ret = dma_mapping_error(dev, paddr);
>> +                     if (ret) {
>> +                             dev_err(dev, "rx buf map failed\n");
>> +                             return ret;
>> +                     }
>> +             }
>> +
>> +             desc->rx_paddr = paddr;
>> +             desc->cfg_start |= FIELD_PREP(FIELD_RXD_MODE, 
>> SPISG_DATA_MODE_MEM);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void aml_spisg_cleanup_transfer(struct spisg_device *spisg,
>> +                                    struct spi_transfer *xfer,
>> +                                    struct spisg_descriptor *desc,
>> +                                    struct spisg_descriptor_extra 
>> *exdesc)
>> +{
>> +     struct device *dev = &spisg->pdev->dev;
>> +
>> +     if (desc->tx_paddr) {
>> +             if (FIELD_GET(FIELD_TXD_MODE, desc->cfg_start) == 
>> SPISG_DATA_MODE_SG) {
>> +                     dma_unmap_single(dev, (dma_addr_t)desc->tx_paddr,
>> +                                      exdesc->tx_ccsg_len, 
>> DMA_TO_DEVICE);
>> +                     kfree(exdesc->tx_ccsg);
>> +                     
>> dma_sync_sgtable_for_cpu(spisg->controller->cur_tx_dma_dev,
>> +                                              &xfer->tx_sg, 
>> DMA_TO_DEVICE);
>> +             } else if (!xfer->tx_dma) {
>> +                     dma_unmap_single(dev, (dma_addr_t)desc->tx_paddr,
>> +                                      xfer->len, DMA_TO_DEVICE);
>> +             }
>> +     }
>> +
>> +     if (desc->rx_paddr) {
>> +             if (FIELD_GET(FIELD_RXD_MODE, desc->cfg_start) == 
>> SPISG_DATA_MODE_SG) {
>> +                     dma_unmap_single(dev, (dma_addr_t)desc->rx_paddr,
>> +                                      exdesc->rx_ccsg_len, 
>> DMA_TO_DEVICE);
>> +                     kfree(exdesc->rx_ccsg);
>> +                     
>> dma_sync_sgtable_for_cpu(spisg->controller->cur_rx_dma_dev,
>> +                                              &xfer->rx_sg, 
>> DMA_FROM_DEVICE);
>> +             } else if (!xfer->rx_dma) {
>> +                     dma_unmap_single(dev, (dma_addr_t)desc->rx_paddr,
>> +                                      xfer->len, DMA_FROM_DEVICE);
>> +             }
>> +     }
>> +}
>> +
>> +static void aml_spisg_setup_null_desc(struct spisg_device *spisg,
>> +                                   struct spisg_descriptor *desc,
>> +                                   u32 n_sclk)
>> +{
>> +     /* unit is the last xfer sclk */
>> +     desc->cfg_start = spisg->cfg_start;
>> +     desc->cfg_bus = spisg->cfg_bus;
>> +
>> +     desc->cfg_start |= FIELD_PREP(FIELD_OP_MODE, SPISG_OP_MODE_WRITE) |
>> +                        FIELD_PREP(FIELD_BLOCK_SIZE, 1) |
>> +                        FIELD_PREP(FIELD_BLOCK_NUM, 
>> DIV_ROUND_UP(n_sclk, 8));
>> +
>> +     desc->cfg_bus |= FIELD_PREP(FIELD_NULL_CTL, 1);
>> +}
>> +
>> +static void aml_spisg_pending(struct spisg_device *spisg,
>> +                           dma_addr_t desc_paddr,
>> +                           bool trig,
>> +                           bool irq_en)
>> +{
>> +     u32 desc_l, desc_h, cfg_spi;
>> +
>> +#ifdef       CONFIG_ARCH_DMA_ADDR_T_64BIT
>> +     desc_l = (u64)desc_paddr & 0xffffffff;
>> +     desc_h = (u64)desc_paddr >> 32;
>> +#else
>> +     desc_l = desc_paddr & 0xffffffff;
>> +     desc_h = 0;
>> +#endif
>> +
>> +     cfg_spi = spisg->cfg_spi;
>> +     if (trig)
>> +             cfg_spi |= FIELD_HW_POS;
>> +     else
>> +             desc_h |= FIELD_DESC_PENDING;
>> +
>> +     regmap_write(spisg->map, SPISG_REG_IRQ_ENABLE, irq_en ? 
>> FIELD_DESC_CHAIN_DONE : 0);
>> +     regmap_write(spisg->map, SPISG_REG_CFG_SPI, cfg_spi);
>> +     regmap_write(spisg->map, SPISG_REG_DESC_LIST_L, desc_l);
>> +     regmap_write(spisg->map, SPISG_REG_DESC_LIST_H, desc_h);
>> +}
>> +
>> +static irqreturn_t aml_spisg_irq(int irq, void *data)
>> +{
>> +     struct spisg_device *spisg = (void *)data;
>> +     u32 sts;
>> +
>> +     spisg->status = 0;
>> +     regmap_read(spisg->map, SPISG_REG_IRQ_STS, &sts);
>> +     regmap_write(spisg->map, SPISG_REG_IRQ_STS, sts);
>> +     if (sts & (FIELD_RCH_DESC_INVALID |
>> +                FIELD_RCH_DESC_RESP |
>> +                FIELD_RCH_DATA_RESP |
>> +                FIELD_WCH_DESC_INVALID |
>> +                FIELD_WCH_DESC_RESP |
>> +                FIELD_WCH_DATA_RESP |
>> +                FIELD_DESC_ERR)) {
>> +             spisg->status = sts;
>> +     }
> 
> You can drop the {}
> 

Will do.

>> +
>> +     complete(&spisg->completion);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int aml_spisg_transfer_one_message(struct spi_controller *ctlr,
>> +                                       struct spi_message *msg)
>> +{
>> +     struct spisg_device *spisg = spi_controller_get_devdata(ctlr);
>> +     struct device *dev = &spisg->pdev->dev;
>> +     unsigned long long ms = 0;
>> +     struct spi_transfer *xfer;
>> +     struct spisg_descriptor *descs, *desc;
>> +     struct spisg_descriptor_extra *exdescs, *exdesc;
>> +     dma_addr_t descs_paddr;
>> +     int desc_num = 1, descs_len;
>> +     u32 cs_hold_in_sclk = 0;
>> +     int ret = -EIO;
>> +
>> +     if (!aml_spisg_sem_down_read(spisg)) {
>> +             spi_finalize_current_message(ctlr);
>> +             dev_err(dev, "controller busy\n");
>> +             return -EBUSY;
>> +     }
>> +
>> +     /* calculate the desc num for all xfer */
>> +     list_for_each_entry(xfer, &msg->transfers, transfer_list)
>> +             desc_num++;
>> +
>> +     /* alloc descriptor/extra-descriptor table */
>> +     descs = kcalloc(desc_num, sizeof(*desc) + sizeof(*exdesc),
>> +                     GFP_KERNEL | GFP_DMA);
>> +     if (!descs) {
>> +             spi_finalize_current_message(ctlr);
>> +             aml_spisg_sem_up_write(spisg);
>> +             return -ENOMEM;
>> +     }
>> +     descs_len = sizeof(*desc) * desc_num;
>> +     exdescs = (struct spisg_descriptor_extra *)(descs + desc_num);
>> +
>> +     /* config descriptor for each xfer */
>> +     desc = descs;
>> +     exdesc = exdescs;
>> +     list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>> +             ret = aml_spisg_setup_transfer(spisg, xfer, desc, exdesc);
>> +             if (ret) {
>> +                     dev_err(dev, "config descriptor failed\n");
>> +                     goto end;
>> +             }
>> +
>> +             /* calculate cs-setup delay with the first xfer speed */
>> +             if (list_is_first(&xfer->transfer_list, &msg->transfers))
>> +                     desc->cfg_bus |= FIELD_PREP(FIELD_CS_SETUP,
>> +                             
>> spi_delay_to_sclk(xfer->effective_speed_hz, &msg->spi->cs_setup));
>> +
>> +             /* calculate cs-hold delay with the last xfer speed */
>> +             if (list_is_last(&xfer->transfer_list, &msg->transfers))
>> +                     cs_hold_in_sclk =
>> +                             
>> spi_delay_to_sclk(xfer->effective_speed_hz, &msg->spi->cs_hold);
>> +
>> +             desc++;
>> +             exdesc++;
>> +             ms += DIV_ROUND_UP_ULL(8LL * MSEC_PER_SEC * xfer->len,
>> +                                    xfer->effective_speed_hz);
>> +     }
>> +
>> +     if (cs_hold_in_sclk)
>> +             /* additional null-descriptor to achieve the cs-hold 
>> delay */
>> +             aml_spisg_setup_null_desc(spisg, desc, cs_hold_in_sclk);
>> +     else
>> +             desc--;
>> +
>> +     desc->cfg_bus |= FIELD_PREP(FIELD_KEEP_SS, 0);
>> +     desc->cfg_start |= FIELD_PREP(FIELD_EOC, 1);
>> +
>> +     /* some tolerances */
>> +     ms += ms + 20;
>> +     if (ms > UINT_MAX)
>> +             ms = UINT_MAX;
>> +
>> +     descs_paddr = dma_map_single(dev, (void *)descs,
>> +                                  descs_len, DMA_TO_DEVICE);
>> +     ret = dma_mapping_error(dev, descs_paddr);
>> +     if (ret) {
>> +             dev_err(dev, "desc table map failed\n");
>> +             goto end;
>> +     }
>> +
>> +     reinit_completion(&spisg->completion);
>> +     aml_spisg_pending(spisg, descs_paddr, false, true);
>> +     if (wait_for_completion_timeout(&spisg->completion,
>> +                                     
>> spi_controller_is_target(spisg->controller) ?
>> +                                     MAX_SCHEDULE_TIMEOUT : 
>> msecs_to_jiffies(ms)))
>> +             ret = spisg->status ? -EIO : 0;
>> +     else
>> +             ret = -ETIMEDOUT;
>> +
>> +     dma_unmap_single(dev, descs_paddr, descs_len, DMA_TO_DEVICE);
>> +end:
>> +     desc = descs;
>> +     exdesc = exdescs;
>> +     list_for_each_entry(xfer, &msg->transfers, transfer_list)
>> +             aml_spisg_cleanup_transfer(spisg, xfer, desc++, exdesc++);
>> +     kfree(descs);
>> +
>> +     if (!ret)
>> +             msg->actual_length = msg->frame_length;
>> +     msg->status = ret;
>> +     spi_finalize_current_message(ctlr);
>> +     aml_spisg_sem_up_write(spisg);
>> +
>> +     return ret;
>> +}
>> +
>> +static int aml_spisg_prepare_message(struct spi_controller *ctlr,
>> +                                  struct spi_message *message)
>> +{
>> +     struct spisg_device *spisg = spi_controller_get_devdata(ctlr);
>> +
>> +     return aml_spisg_setup_device(spisg, message->spi);
> 
> Why add a separate function here ? just move the aml_spisg_setup_device()
> content here, or rename aml_spisg_setup_device() to 
> aml_spisg_prepare_message()
> 

Will do.

>> +}
>> +
>> +static int aml_spisg_setup(struct spi_device *spi)
>> +{
>> +     if (!spi->controller_state)
>> +             spi->controller_state = 
>> spi_controller_get_devdata(spi->controller);
>> +
>> +     return 0;
>> +}
>> +
>> +static void aml_spisg_cleanup(struct spi_device *spi)
>> +{
>> +     spi->controller_state = NULL;
>> +}
>> +
>> +static int aml_spisg_target_abort(struct spi_controller *ctlr)
>> +{
>> +     struct spisg_device *spisg = spi_controller_get_devdata(ctlr);
>> +
>> +     spisg->status = 0;
>> +     regmap_write(spisg->map, SPISG_REG_DESC_LIST_H, 0);
>> +     complete(&spisg->completion);
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_spisg_clk_init(struct spisg_device *spisg, void 
>> __iomem *base)
>> +{
>> +     struct device *dev = &spisg->pdev->dev;
>> +     struct clk_init_data init;
>> +     struct clk_divider *div;
>> +     struct clk_div_table *tbl;
>> +     const char *parent_names[1];
>> +     char name[32];
>> +     int i;
>> +
>> +     spisg->core = devm_clk_get_enabled(dev, "core");
>> +     if (IS_ERR_OR_NULL(spisg->core))
>> +             dev_warn(dev, "core clock request failed\n");
> 
> Warn ? isn't the clock mandatory ?
> 

This clock is necessary. I will return error if get failed.

>> +
>> +     spisg->pclk = devm_clk_get_enabled(dev, "pclk");
>> +     if (IS_ERR_OR_NULL(spisg->pclk)) {
>> +             dev_err(dev, "pclk clock request failed\n");
>> +             return PTR_ERR(spisg->pclk);
>> +     }
>> +     clk_set_min_rate(spisg->pclk, SPISG_PCLK_RATE_MIN);
>> +
>> +     tbl = devm_kzalloc(dev, sizeof(struct clk_div_table) * (DIV_NUM 
>> + 1), GFP_KERNEL);
>> +     if (!tbl)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < DIV_NUM; i++) {
>> +             tbl[i].val = i + SPISG_CLK_DIV_MIN - 1;
>> +             tbl[i].div = i + SPISG_CLK_DIV_MIN;
>> +     }
>> +     spisg->tbl = tbl;
>> +
>> +     div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
>> +     if (!div)
>> +             return -ENOMEM;
>> +
>> +     div->flags = CLK_DIVIDER_ROUND_CLOSEST;
>> +     div->reg = base + SPISG_REG_CFG_BUS;
>> +     div->shift = __bf_shf(FIELD_CLK_DIV);
>> +     div->width = CLK_DIV_WIDTH;
>> +     div->table = tbl;
>> +
>> +     /* Register value should not be outside of the table */
>> +     regmap_update_bits(spisg->map, SPISG_REG_CFG_BUS, FIELD_CLK_DIV,
>> +                        FIELD_PREP(FIELD_CLK_DIV, SPISG_CLK_DIV_MIN - 
>> 1));
>> +
>> +     /* Register clk-divider */
>> +     parent_names[0] = __clk_get_name(spisg->pclk);
>> +     snprintf(name, sizeof(name), "%s_div", dev_name(dev));
>> +     init.name = name;
>> +     init.ops = &clk_divider_ops;
>> +     init.flags = CLK_SET_RATE_PARENT;
>> +     init.parent_names = parent_names;
>> +     init.num_parents = 1;
>> +     div->hw.init = &init;
>> +
>> +     spisg->sclk = devm_clk_register(dev, &div->hw);
>> +     if (IS_ERR_OR_NULL(spisg->sclk)) {
>> +             dev_err(dev, "clock registration failed\n");
>> +             return PTR_ERR(spisg->sclk);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_spisg_probe(struct platform_device *pdev)
>> +{
>> +     struct spi_controller *ctlr;
>> +     struct spisg_device *spisg;
>> +     struct device *dev = &pdev->dev;
>> +     void __iomem *base;
>> +     int ret, irq;
>> +
>> +     const struct regmap_config aml_regmap_config = {
>> +             .reg_bits = 32,
>> +             .val_bits = 32,
>> +             .reg_stride = 4,
>> +             .max_register = SPISG_MAX_REG,
>> +     };
>> +
>> +     if (of_property_read_bool(dev->of_node, "slave"))
>> +             ctlr = spi_alloc_target(dev, sizeof(*spisg));
>> +     else
>> +             ctlr = spi_alloc_host(dev, sizeof(*spisg));
>> +     if (!ctlr)
>> +             return dev_err_probe(dev, -ENOMEM, "controller 
>> allocation failed\n");
>> +
>> +     spisg = spi_controller_get_devdata(ctlr);
>> +     spisg->controller = ctlr;
>> +
>> +     spisg->pdev = pdev;
>> +     platform_set_drvdata(pdev, spisg);
>> +
>> +     base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(base))
>> +             return dev_err_probe(dev, PTR_ERR(base), "resource 
>> ioremap failed\n");
>> +
>> +     spisg->map = devm_regmap_init_mmio(dev, base, &aml_regmap_config);
>> +     if (IS_ERR(spisg->map))
>> +             return dev_err_probe(dev, PTR_ERR(spisg->map), "regmap 
>> init failed\n");
>> +
>> +     irq = platform_get_irq(pdev, 0);
>> +     if (irq < 0) {
>> +             ret = irq;
>> +             goto out_controller;
>> +     }
>> +
>> +     ret = devm_request_irq(&pdev->dev, irq, aml_spisg_irq,
>> +                            IRQF_TRIGGER_RISING, NULL, spisg);
> 
> The rising flag should be taken from DT, pass the right flasg in DT and 
> pass 0 here.
> 

Will do.

>> +     if (ret) {
>> +             dev_err(&pdev->dev, "irq request failed\n");
>> +             goto out_controller;
>> +     }
>> +
>> +     ret = aml_spisg_clk_init(spisg, base);
>> +     if (ret)
>> +             goto out_controller;
>> +
>> +     spisg->cfg_spi = 0;
>> +     spisg->cfg_start = 0;
>> +     spisg->cfg_bus = 0;
>> +
>> +     spisg->cfg_spi = FIELD_PREP(FIELD_SFLASH_WP, 1) |
>> +                      FIELD_PREP(FIELD_SFLASH_HD, 1);
>> +     if (spi_controller_is_target(ctlr)) {
>> +             spisg->cfg_spi |= FIELD_PREP(FIELD_SLAVE_EN, 1);
>> +             spisg->cfg_bus = FIELD_PREP(FIELD_TX_TUNING, 0xf);
>> +     }
>> +     /* default pending */
>> +     spisg->cfg_start = FIELD_PREP(FIELD_PEND, 1);
>> +
>> +     device_reset_optional(dev);
>> +     ctlr->num_chipselect = 4;
>> +     ctlr->dev.of_node = pdev->dev.of_node;
>> +     ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST |
>> +                       SPI_3WIRE | SPI_TX_QUAD | SPI_RX_QUAD;
>> +     ctlr->max_speed_hz = 1000 * 1000 * 100;
>> +     ctlr->min_speed_hz = 1000 * 10;
>> +     ctlr->setup = aml_spisg_setup;
>> +     ctlr->cleanup = aml_spisg_cleanup;
>> +     ctlr->prepare_message = aml_spisg_prepare_message;
>> +     ctlr->transfer_one_message = aml_spisg_transfer_one_message;
>> +     ctlr->target_abort = aml_spisg_target_abort;
>> +     ctlr->can_dma = aml_spisg_can_dma;
>> +     ctlr->max_dma_len = SPISG_BLOCK_MAX;
>> +     dma_set_max_seg_size(&pdev->dev, SPISG_BLOCK_MAX);
>> +     ret = devm_spi_register_controller(dev, ctlr);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "spi controller registration 
>> failed\n");
>> +             goto out_clk;
>> +     }
>> +
>> +     init_completion(&spisg->completion);
>> +
>> +     return 0;
>> +
>> +out_clk:
>> +     if (spisg->core)
>> +             clk_disable_unprepare(spisg->core);
>> +     clk_disable_unprepare(spisg->pclk);
>> +out_controller:
>> +     spi_controller_put(ctlr);
>> +
>> +     return ret;
>> +}
>> +
>> +static void aml_spisg_remove(struct platform_device *pdev)
>> +{
>> +     struct spisg_device *spisg = platform_get_drvdata(pdev);
>> +
>> +     if (spisg->core)
>> +             clk_disable_unprepare(spisg->core);
>> +     clk_disable_unprepare(spisg->pclk);
>> +}
>> +
>> +static int spisg_suspend_runtime(struct device *dev)
>> +{
>> +     struct spisg_device *spisg = dev_get_drvdata(dev);
>> +     int ret;
>> +
>> +     ret = spi_controller_suspend(spisg->controller);
>> +     if (ret)
>> +             return ret;
>> +
>> +     pinctrl_pm_select_sleep_state(&spisg->pdev->dev);
>> +     clk_disable_unprepare(spisg->pclk);
>> +     if (spisg->core)
>> +             clk_disable_unprepare(spisg->core);
>> +
>> +     return ret;
>> +}
>> +
>> +static int spisg_resume_runtime(struct device *dev)
>> +{
>> +     struct spisg_device *spisg = dev_get_drvdata(dev);
>> +     int ret;
>> +
>> +     if (spisg->core)
>> +             clk_prepare_enable(spisg->core);
>> +     clk_prepare_enable(spisg->pclk);
> 
> Why ? Those are parents on sclk, so disabling sclk would mechanically
> disable core/pclk.
> 

Pclk is parent on sclk. But core clock is need enable/disable separatly.
Will enable/disable sclk and core.

>> +     pinctrl_pm_select_default_state(&spisg->pdev->dev);
>> +
>> +     ret = spi_controller_resume(spisg->controller);
>> +
>> +     return ret;
>> +}
> 
> Right, but those are obviously useless since you neither set runtime pm,
> not call any runtime pm functions to wake the device for a transaction.
> 
> So I don't think you even tested those.
> 

I will test runtime suspend in next version.

> Thanks,
> Neil
> >> +
>> +static const struct dev_pm_ops amlogic_spisg_pm_ops = {
>> +     .runtime_suspend        = spisg_suspend_runtime,
>> +     .runtime_resume         = spisg_resume_runtime,
>> +};
>> +
>> +static const struct of_device_id amlogic_spisg_of_match[] = {
>> +     {
>> +             .compatible = "amlogic,a4-spisg",
>> +     },
>> +
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, amlogic_spisg_of_match);
>> +
>> +static struct platform_driver amlogic_spisg_driver = {
>> +     .probe = aml_spisg_probe,
>> +     .remove = aml_spisg_remove,
>> +     .driver  = {
>> +             .name = "amlogic-spisg",
>> +             .of_match_table = of_match_ptr(amlogic_spisg_of_match),
>> +             .pm = &amlogic_spisg_pm_ops,
>> +     },
>> +};
>> +
>> +module_platform_driver(amlogic_spisg_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic SPI Scatter-Gather Controller driver");
>> +MODULE_AUTHOR("Sunny Luo <sunny.luo@amlogic.com>");
>> +MODULE_LICENSE("GPL");
>>
> 

