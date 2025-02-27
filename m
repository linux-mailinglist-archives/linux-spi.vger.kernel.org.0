Return-Path: <linux-spi+bounces-6963-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D19A47BC1
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 12:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E4167711
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAEA22D78C;
	Thu, 27 Feb 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TgG47Ksu"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC722A1E2;
	Thu, 27 Feb 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654846; cv=fail; b=cI3RjwvPweMBx/5dUeuVMYSlVc9MG27gXRFB9kXii5TtfMO6LD8cNDEGrBKtpvWq1Qw6fDiWgP5dXAI0+MXUGvbAsVGaQMYqwVRcE3Nl5PYC/yv3FSthgdmxj5C0+xgCVq4bN5Ch6C09cxBNjMbs7Ub+l6pXjPeqCBv3XPf5/cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654846; c=relaxed/simple;
	bh=WXNl9jPdquKcFjCxaRbv6s5so+Ka9Map/4nlJduu4lQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UKZFsaL383oyLAAz0EJIoSVwsqkBvH5ruBS4PCH5ssfQTOmiq7fUQTJTLbrkOg8NboBOIOZeCH9nlz4lpG934qfQNDYClAP5EGT/1b1Myi1YO9dMYYQYVtYWc0ts82DFZc51pPGZ7yoNCJ22LQLUEn2VIM2fD5C81OTzPThrcno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TgG47Ksu; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3J1yNy8qA7jiWF2Sj8C7v7lh4RcvoULetHybPw4j4gC61FYiWhInZtMguVX8o/oQQr0Xg7kjiIwgaX5wm0poafmm9lgFZ6M88iXWy+Ibyz+FLEzzoiS45+xi1H7QS1N4AQKQGdaiBW0RzJ1/ozcXWSwkbgbyzVhm+PAp3Iq1zHGlUpqmShhU5hnTm39upiDS5bWvuUFlyxnSr8wRSj+96BvGozbjDmKlLxShQmhocPgu7+LEJ3KPV7+ZIfvcBEdALXObMf5/gqUPYy5XGu37ln7mLj2jxZr8rS9lBarR0qD9oDgeSRJTCbZ2ohSc8e3ZL8EgLrQuNzwpHQMWxd6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ohffOC921KUMcstyEUHXdnCFQ/MFZYvmivd1hArT+0=;
 b=YDk8oHAIRnZXdHVpzZSiVaa3ff28ZjnM5XLW60s0WYRu46lZfEwyKp8TJfh8quUQPXkgdq4l6ugrudjN7fsPYQ3DUDsMpp1ET3UHX3+jmbiJni2DqTu1xybinaqARzLhgi6meF8+7Y9ZYmVXVv4HHvja+KxLaMCR6WpCgfd7H07aNmhojAmMqaOEVBg6CwOsu7xJl2GyOe2IKO/q0BewgeZ57EstSNfprR1vz2T5nAQX7NorC4yjPpvwAQLRlB5mSdKK1SLDYDGn+0mauXKru8V2xoR0AapT7/dnDT8v4jsERKKo8BWrsrxb0nkQ4h5vRqrxeFvSXB0sdlNZWTQVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ohffOC921KUMcstyEUHXdnCFQ/MFZYvmivd1hArT+0=;
 b=TgG47KsuAA84EvVfsveCse1jCWn1gDQp36MkCTDdmZFCQD7HqyiDIqJg4bfcmKsbYxdtHKThttwd5qQe4mkVJSkCSVXQMQdVZ6UkS7GSD5UeFpC2WDmcMbaUYxe0K29QhupHjPrhTQ2ago9ryIRcmq1JvS7K/aLALJ3rtGPUb0Y30kaB1m5ewI0LUSrVhQVuuqyQGVHC2Iot2nLfV8G0RUl3eCgCDdj/HoGLRvZv/krXhcaFyYYjSCCSuI7hmj/0uA4H2GTWBia4cK6DDqZYWsoUS/1O6FyWPKwBv3Ra1KvFPmn7EF9kzlADdEJA9BhndzlwQFpRlbbTup8MqTRGtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 11:14:02 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 11:14:02 +0000
Message-ID: <68dcdefe-0c16-4f0a-820e-d697b862615c@nvidia.com>
Date: Thu, 27 Feb 2025 11:13:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64: tegra: Configure QSPI clocks and add DMA
To: Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
 skomatineni@nvidia.com, ldewangan@nvidia.com, broonie@kernel.org,
 linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
 <20250212144651.2433086-2-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250212144651.2433086-2-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0016.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 04abb2b3-d073-4edd-09c9-08dd571fd730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0w1VERXc0NZRnhlN2ZMdlRBOFlWNkc3NjZjVDNwY2hmQ05uOWR4U0cxdWVs?=
 =?utf-8?B?dkN5V2VGRlpvTUUyTU1MU0ljSWt6OG4yOTlYTm1HL0hJQzNSOFhORDVwR0lj?=
 =?utf-8?B?UVpSdjJwVzZRbTVrWTN5SkI1bHM2YThOaHo1b2dQQS94TGZJSDZwZk95aVhr?=
 =?utf-8?B?Nmx3ZHU2RkUvMnpFVnZ6Z3lrbS94TjN3ajFjQ2NDM2JnbFo5dkd6V2JhaEdp?=
 =?utf-8?B?QU9CaGtOVFAreWVlOGw1U3FKd0FHT3hidjFhRnpCVHhuVlBjcktGT2RVMHh2?=
 =?utf-8?B?Yjc4VU4xc2k2T0dWdmtRWjdEMmQzaEoyUUh5dnQ4QTI5YzN1Z21RMDlXRmYz?=
 =?utf-8?B?cmJFZlVoZStEYmNoRjFDUHB4K3FRUm5GZmNNNFdHa0JJT2JGWVp5Y2xQbnVR?=
 =?utf-8?B?cHhWUVhBUTJBV3hza01IaUVvS1U1SGV4elI4Vjl1V0tYSHZKUVhxaDFyQjF1?=
 =?utf-8?B?RWFsSnVocHJLaVZ1NmFINTlwZ0xtZkZ1K0dLZXF2dmdrQVFTWGdnVGJRa2tr?=
 =?utf-8?B?U3RzeWFBMjA2ZXE5RGpDczcwbUVIam05bFFEYW9URk52RXg1NHBSeTEwamJv?=
 =?utf-8?B?KzJFMEdxbktGSkhYUmhuNXlLZVIwS0hKbk1qUEsrMi9MVWVTY2xETmt1WjdN?=
 =?utf-8?B?UEo3a3BJalUyTWxZeC9PTTZHL0lUUVFNZzRQbkQzU1E3bkZ5bUxRVExzWk1S?=
 =?utf-8?B?dnAyb0NjSHphUWNlVWxHL011ZGZQR0lpdmpWL3ZOQnRPM2JQdXIxeHg4K0Ny?=
 =?utf-8?B?blBOT3dIRGFzWmwxVXo5REhaUEhPbTJIR3V0MDI0Zk5XcFJUZ3VrSUN0ODlp?=
 =?utf-8?B?UldtdVhxOWdOOUdGTGJLOGFXbTF1VU9LY2FweXg0MGMrQ2l4ZTBHTjgvd1ZO?=
 =?utf-8?B?bTREZVRnNFVGRGg2OHdBZEVuZEVNZUc2VUNVVDBrK1RvWmZrcHVwOWQrVTh5?=
 =?utf-8?B?Y0hvb0VNUlJORjZWRHJyamhzcjdja3BaMXpTa3M4N3lFSHBaWXNYOHpDQ2ZY?=
 =?utf-8?B?UWdrYWtabEdIYjVSK0NMTXNtVWl3cnE5TXVoVXNmcWx2MlVFOEpWRkExSXRN?=
 =?utf-8?B?RjU0a0VIcXNtamswaTJRZ3k3bC8wQ1c0K0JNNDFJZHVwM21PQVZlWFIwZWNh?=
 =?utf-8?B?SElFbDRZYWdrL0xHcjJWdmhJSUNNR0lDU1U1RitBd1JNT3RsVUtZMnhwK1pQ?=
 =?utf-8?B?NThHVGNqOWFNOE03TnZvMDRaa2pPV2tmK2hGVkpHR0ZnWHNpd21kSjhUWDRW?=
 =?utf-8?B?WjJjcXkvOVRieUVTVytDTldNTVJmTjkxbWRiTnBXdm5JMUx3SG9hSkI3THc1?=
 =?utf-8?B?b2sxNDllTTY5RlFkNlV1eHN5YjlSWE0xUkZxcEpUbjJCREtrOE1QRjhlbGQr?=
 =?utf-8?B?TWFaSEZlUnMvNjVBY1lWclZjK2FzZi9lZklvNlZHU3dISlp5bnBRY0xCVEpY?=
 =?utf-8?B?cVBGZ2RGd24vMWYwRmp1Z1EvdXdkeGpaVHNsZnpNWWs2ZHZKaWFyMlVocjJW?=
 =?utf-8?B?cEhJbFRqK083TDhseEx2aFVIblFoMFJLYTNBOTFqU0Z3NGV4WTc1TVV2eTJp?=
 =?utf-8?B?ZEV5UW9FaHYxeC9XN0RFV3M0VUtBWVI1SVZFOE1FK1luMi90Z0xsQnd6aWVz?=
 =?utf-8?B?Z01tZmNKREJNZXlwdncyZlBjQS9tOWJwYno4NVJMUUo0V0lqSTM0M3diTG9z?=
 =?utf-8?B?TjFobnJwbjg0TUFBOVlmWFBvaXdvMGg2azh6eW52dENaU01hNXIzYXg3d3hV?=
 =?utf-8?B?dHVXZXlOQ29JNU01YXIyOGErbXBHTm14eXRiQ2pFcnhicU9sVGk2Nlc3bmN4?=
 =?utf-8?B?SFMrSThMQjhxYTE2bkNHY1lITGJVL25LdmRacll0cU1GMUluakEyNVpZQWd1?=
 =?utf-8?B?YUdSY3VyMGhzcVc3MTl1aUVQOGhVOEVicHAzME9aTTRxYzZRbHc4M0RFU0Vp?=
 =?utf-8?Q?ppb/1IWD548=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTBzR0N4RnhhRnFGWmovQWt2MFpCZ2NEbFp2YVJ5NEZWSURDbk9LSDJDcGdj?=
 =?utf-8?B?d1hqNnBNOVoxTmVON3p5aXNsTFFvQXJSbVdpS2FtUDR1TDZDd1FVeW5oOWM5?=
 =?utf-8?B?TCtLUnBRMHVZWW1Ta0s3U1htWElFZ0VqNnFzK251MEVBeXJWenBWNlB2enh0?=
 =?utf-8?B?K2pVQTFNM3NMb1pESmUzdkJTZFRvdm9LajF1cFFEQ1ltMm02VzBNQ0V6UmRO?=
 =?utf-8?B?Tm8rQVFBMGhuUXd0a2hsWEFJNkVVNFdLK1FrakNGWXE2ZkM1K2NNanhpcS9D?=
 =?utf-8?B?d2J5UzFrWHZ0NHFIVEt1S2crdHo3SDZiUC9BZnJUaDNvdUkvVW1TdE9FMjZv?=
 =?utf-8?B?VXRqSDY3V1hiVEVZdEpyUGhrNE81NmJWMUdxMTVCTFRTcGR3YWhmci9HaWtj?=
 =?utf-8?B?a1VSRXZkdVV3RjRpUTNBdDlFdzJWNi9xRGpBVGtvOFdDb0FYdko2KzQ2TUtW?=
 =?utf-8?B?QlY0V0xTSHN5THN2Umk3MHdzTnU2QWN6ZnZiL1FUd0k5OFFVRTZnMHJwQ00y?=
 =?utf-8?B?QjVjR281ZjJqaU5jODRxSnVpeUUwWkhUQlVFWTM4RE5BZEk2eGxwYWxURGtP?=
 =?utf-8?B?bG9odXNibms0LzA3cythanRsdkxLcmF1V3R4NVJ3QkZWSS81ZnhvV3c3Zlpp?=
 =?utf-8?B?WHpUVTNzamtnRFJxRkUvczdJQzN1aWdmY3QxR0hiQnphWlM5UlFSM3cyNDJ4?=
 =?utf-8?B?MjRwN0pIb0pkb01CNHNoZWJmV3FDdE5leTdBTDg0R29jenhVUzVqQVFNZ3Ex?=
 =?utf-8?B?TUlTTXVjdG4yT0cyd1ZzN3lrTlpjTDhuamVtRCttYVV2TkdyN3gyVzdYQUlR?=
 =?utf-8?B?dEVjTnBtQi92UTZ6UkN6MG51ZlJBckI0NWNRTUE0NGtCVGIrZjlNNXgwbFRN?=
 =?utf-8?B?WlMwNmlrbXZLcDBNZXBJamlBeG83Y3FpQUpjZ2ZaWEJYRVZOZDBjc3NWZDRm?=
 =?utf-8?B?L1RwZnJyZU5ZQUVVRmxKQ1NtekpSWVdOMk5wU3dVM2UwUWpuemRqMEJ0SXRY?=
 =?utf-8?B?MXRzVzdRWXpyUG95cXFxdkZxVW04S3gxUm8yWmNmdWVFdDQzdy9sWk44VHdC?=
 =?utf-8?B?LzUzUVVCbWNXMUlyYVZhaWY3clJnSS9ocDN0WXNZNzQ3MGxEdUZXMGp3TTNy?=
 =?utf-8?B?T0s4OEE1U0VsS0ZhYWNxMU5jYWQxNXllS1FSOHJNUmdrcUkva1BQaEZ6RExo?=
 =?utf-8?B?ZnhEYWlJOG5pS1NMNXp5SUZYNVFDL3p3bDVMU0V2TVcrQzhycmRmOHRiMXho?=
 =?utf-8?B?ZFdleXkrL2lvNlp4RnY2amdxeGtpRzkrOFlMK0dFTnllMExSMVlQOC9TNjlU?=
 =?utf-8?B?Mld4N0dvNGpzUFVYR2U2TlkxNnlydXVCMUsrMDVURzNvdzBBN3RMVk5pRFNM?=
 =?utf-8?B?djVPUk1VVm5YY0dwMWtkeHJqQUcvM0NnMlBlNDk1UzdSSDlGT3JJNTlSU1RM?=
 =?utf-8?B?eXVzeVJhM0pMNGFzUEdXdU1Ed3BjclZUbWhOUnc3K0lQVUFhY2JBNFlXYkF4?=
 =?utf-8?B?V3k1a3kvblJaRW1lSForRjE4OFQyS2hPZ3psc1pnaktkRS83S0hTak55NnJG?=
 =?utf-8?B?UzBsNEp2Vmd1bTdaVlFJWDVkbTdSeVNuaEtuVHpkSTJYSEFwaGg2bVBWNDk2?=
 =?utf-8?B?S1pCem9KRVVvZlBWZVVUelhRL0FZTS9xUU1OZGlNaDFOaGRSc0h2NXplaUlr?=
 =?utf-8?B?cC9PeDdZOThYcGZzdm9kMmZ0ZEEzbEFlZVlKTzd2bUdCVGlkU1l5Q0Vub2lM?=
 =?utf-8?B?aFhpTERZakFBb0M1dytrRVFoT0FDcTJSVTBydFBNNnBRMjlmNUVmRFRCeTF5?=
 =?utf-8?B?THNXZlhUSC9Tc2g4LzdITTQyejNWcVEyMzFnci85WVd6TVpSMmxUb1pYbVU3?=
 =?utf-8?B?TXNJUUpuc0R2TVU0RHZqTmkyL2tJQ0Vudjc1Vm1BclEyRjl2ZVFEeHFUdWZG?=
 =?utf-8?B?TVpZNE5sbm1JQ3hIZml3ZW4xMjJSbHB0VmFIL1l0MEpsYmFDMGJCU0QrN2xQ?=
 =?utf-8?B?VUcwdm9iYWdsbFlVNzk3M1k5Z3QyVFRFNk9CL01GZmhaaUpBL3prdFRBYnJR?=
 =?utf-8?B?dFZSWER2cHV6WVI4R3MwZWhpYlJtSzJQNUtQZmRqMWZjMXlUdndoSW1QV1o5?=
 =?utf-8?Q?5Cm2uij8r8saiK8vpCWkcttME?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04abb2b3-d073-4edd-09c9-08dd571fd730
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:14:02.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vfbox7pg+q81XGc4n1QU+9OVuisLqHpAsVPcpDUks1klXXT4efkUWWypxQBvxQVSIbtVzmes8HKJu23FGgjUyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372


On 12/02/2025 14:46, Vishwaroop A wrote:
> Set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to 99.99 MHz using
> PLLC as the parent clock. These frequencies allow Quad IO DT
> reads up to 99.99 MHz, which is the fastest that can be
> achieved considering various PLL and clock divider constraints.
> 
> Populate the DMA and IOMMU properties for the Tegra234 QSPI devices to
> enable DMA support.
> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index 2601b43b2d8c..0ac2d3aba930 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -2948,6 +2948,13 @@
>   				 <&bpmp TEGRA234_CLK_QSPI0_PM>;
>   			clock-names = "qspi", "qspi_out";
>   			resets = <&bpmp TEGRA234_RESET_QSPI0>;
> +			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI0_2X_PM>,
> +					  <&bpmp TEGRA234_CLK_QSPI0_PM>;
> +			assigned-clock-rates = <199999999 99999999>;
> +			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
> +			dma-names = "rx", "tx";
> +			dma-coherent;
> +			iommus = <&smmu_niso1 TEGRA234_SID_QSPI0>;
>   			status = "disabled";
>   		};
>   
> @@ -3031,6 +3038,13 @@
>   				 <&bpmp TEGRA234_CLK_QSPI1_PM>;
>   			clock-names = "qspi", "qspi_out";
>   			resets = <&bpmp TEGRA234_RESET_QSPI1>;
> +			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
> +					  <&bpmp TEGRA234_CLK_QSPI1_PM>;
> +			assigned-clock-rates = <199999999 99999999>;
> +			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
> +			dma-names = "rx", "tx";
> +			dma-coherent;
> +			iommus = <&smmu_niso1 TEGRA234_SID_QSPI1>;
>   			status = "disabled";
>   		};
>   


Make sure you CC the DT mailing list on this.

With this change I am seeing the following warnings ...

arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
   DTC [C] arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0008.dtb
arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0008.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
   DTC [C] arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dtb
arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
   DTC [C] arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dtb
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0000.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
   DTC [C] arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dtb
arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767-0005.dtb: spi@3270000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#

Jon

-- 
nvpublic


