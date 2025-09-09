Return-Path: <linux-spi+bounces-9951-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9168B4A131
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 07:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FD64E7047
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 05:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF0E2EFD86;
	Tue,  9 Sep 2025 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="E0OxC105"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022113.outbound.protection.outlook.com [40.107.75.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A302E888F;
	Tue,  9 Sep 2025 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394930; cv=fail; b=qLr7HIt0RwhmJb9wGbPBPTdYJNFr3mJfHLyOvR2w1RbW7POuwswR9z3Mj9EeAejwQc07SI+bXjUQSG8Tep+lixpg2QM/gDw0rYf7R1FKXTiQF9RyhGkJ/muVumPolvsEmiZqHzfPmJ+83+kRBbKmiyQchGSH4HBauXNwiPC9Rss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394930; c=relaxed/simple;
	bh=RceYmitKv+zD5i9vQ+IsQ0f6Qz31qTOtkW/MRqC7YWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=icGE16sK6NzLLlDvQKSiGgsocoBv4vSLZtkP/CgYHtjRrRnauj0c2zS1zYQdzk7JfzMGZPo28yui2s+/gTz8I/R5SEVYF+1dcyITBaF5Vrs2UtaERsk/mNhFqypZkdhs46RLd5fjfkXRFx45KS6RlHwFP7L0KlVdG4BR6q8tb9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=E0OxC105; arc=fail smtp.client-ip=40.107.75.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySkKhMwvPgbjFaTcxbEw2CW1lPufsu8EN5eKY9h5zf3qrNxHMOBD6MkhTMCFZeJTjDoWLGV5ErO9iAfVtGdUMbWJ+O4rQcjRfaQKwMhcGCsfxOMxcYgGi/puBS1f33fVJH6PaRZG+s1/36L3v+FKpLorOpZQeiTl+O4s8fNZK5Xbbtyi6sKgtLtXqMvN42mqRLagc8Zga/9mHiNy/yu0u2XwLoBsCw5o0kaO2mIirdcAqI4ot/QbOLMmPoLV4nMf4oEdv8USTJ6+fkEk2CuWSpdBaO5pzE9EaqxHMdtQsVQa7tJ0UcRmlCFcrtV/R6DQtiIyUD9I1SO0CArlVDBuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bClp8kYUsgq5dzFSBVfN3Pq7xzopccdOB1fBeEPPUuc=;
 b=AQIlsa1bq4GIFlJImXmFB7hjiqRPUAh0MvQ478AvfOTZ1npcOTg++8qewGpRFEoozEww4woFsYg9AtAVcJBVTFNIvM+hVXeIfsPXoOYkGilBta3wcG+K4KeQ2HK+GFKMHo4bmm/l62gAsJKfzyC22xOESkTydkImgEESaI9Cg1p2/EELM1Po6HNCzuS8fMPxK/Ql5fu2fp+TNy+I2X3oaCz7tc0MW1WGWfIADiI96AGzadD+U4E6Cs5sJ/eDBXzx+XK15Yn1BNaE9Sq0T47o6GlUDeCA5Ltfnik7aVKv9dJrZNjxgupGtzAqDnJbHyGS8KnCifInEchKQAtROIkj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bClp8kYUsgq5dzFSBVfN3Pq7xzopccdOB1fBeEPPUuc=;
 b=E0OxC105LQBUB8pxh4lvT8uo8a7N0xbMshXHg619LOliPhmqbsNIuID9DW/s5lbGweRdg/uD8jwQBlYGW89DWjuU5qH9r+ZN/WB0bS0aibtSBn3cGcAxLhbefmmbr5K2I85Va49z+PZwRc9uJlOAr1t/L0WBFBUhNhbUl3h7fSpbHgRp/I6JDpZpKjsRoSMJeCMUv4lw0maJM7yungWzWiSgvEC9bsxL00lN80a840ESGpzy5YDy6hFA1BzkmgHE0MyZic//s7GTlNmiWCPVf522TjkhmnOsi8RK724X5PEKqENW4s54k8AtUzo06ZAHdTQ9X2CopXjllDW/BpvDkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB7749.apcprd03.prod.outlook.com (2603:1096:990:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:15:23 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 05:15:22 +0000
Message-ID: <faae99c8-5671-4a80-b977-f0f2c9daa38d@amlogic.com>
Date: Tue, 9 Sep 2025 13:15:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] spi: amlogic: add driver for Amlogic SPI Flash
 Controller
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org
References: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
 <20250829-spifc-v4-2-1e57fd39f584@amlogic.com>
 <e010ff93-574a-45d9-a5dc-0942b3fc90f2@sirena.org.uk>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <e010ff93-574a-45d9-a5dc-0942b3fc90f2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cbf3b7-1723-421e-cacd-08ddef5fe098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGd6L2hqVjBoK3Jlek9jRlk5UmhCaURhenBlYitqSGRtaTBwQzEyeEs2UTFu?=
 =?utf-8?B?OGtaRHBscjJCN1cyckVudHhIcnNSVnFTMDVJV1lYdk9IejRQQit4N3F1OWhF?=
 =?utf-8?B?MnBhNlNyRUkvcEl1eXpEcWw4TkVoVDY2VFkrM1hINHhLc1kwbGtNajN5Tith?=
 =?utf-8?B?Q0JMUGo4S3l1aUh5K0hKcnVFZ1QwMENUVWpnTGF3eHAyOEl2RmFtZ1JDRTJ2?=
 =?utf-8?B?enp3NU1Tb2pYQVhZVjg0cnd0a0lWclJlWThIS25ORmF5TnRFM08yOERiUkE3?=
 =?utf-8?B?ZjFqdk1sZU9mQnp0WWpkcjkrZVRCa1ljMUVnbmtmRmI1SjdZaEtWT2RPNXdV?=
 =?utf-8?B?TUNlaE5LVFNaZmcxelZZczh5eUxJbU5uWjgxSzArcDJZME13aFRQaDBzN1BF?=
 =?utf-8?B?Tm93dmNUK1FjOFBKQjdCZTN0RUErRnpHSk11djl2Z0lSVS9oNzNwRVZSczA2?=
 =?utf-8?B?NGxqZTdMdVd2aWxGU1d0L0hoR3RMVU8wbnZxaE5DOEw2UWJONlljd2xoVGhW?=
 =?utf-8?B?SkxMcThDQ1dFb1dtaGN0QzBDbkR2UWRvK0NoVmwxNlk4RHJuZEN2ZHpXbkQv?=
 =?utf-8?B?TGUvMEVTUWRGK3BkUlNkdEN0U1FvZHozeTlGd1ZURXBiSGxaUUNFbTRmSTRn?=
 =?utf-8?B?MFFVMVZ6N29wWS9hZ1lvdFNNaUUzYUthVVRPTW4xaS9hNEFGTFErdmZCTUVr?=
 =?utf-8?B?a1VwZktUQ3hFZDVCWldjMUNobDBZbnRjQTFGQUswN1phY2ozenIyM29Dd3RR?=
 =?utf-8?B?Qlk3Nkx3SjQ1WEtQQW5aRlpHMThaeDdlN2lTbjJzL0RCVmNBazM3Nk5Wa09L?=
 =?utf-8?B?OVkrTFdQNUNFdEF1UjNMQ3habngzMi9HaTA5R2w3UkZ1amdFaXFBUnNsYmp0?=
 =?utf-8?B?NVJGZjVjbVNvTFFma3k1ZGlwdHFlVmdrMy9VVVZUWkttMEprVzVia1RPU2RK?=
 =?utf-8?B?TjlmWHIyaUU0VWJJZUpHTy84eVEzYzhFSTJMWU9Cb0sxQ3FNNFJvRWN4N0FI?=
 =?utf-8?B?VnJNdFBOS3V2dFU4am93Tmp0TkVIb21GK1ptRkNib1NkTDJhMWVvaFcwdnRo?=
 =?utf-8?B?MEFsZ0IzYlAySHcxMG9LWUNzQmtiMnk5Q2wrbys3dkFXNW43bXI1Z01DWDdP?=
 =?utf-8?B?V3NUUXJGNndhSUdMTTRmYi9HY2c0eTJwNGU0UEYzYkxPK2V4Q3I3Q2VVM3d5?=
 =?utf-8?B?S0lVY3Mvb3B1ODFnejdZMjZnM3hWcWRmTkJ2TFpNMDNJTHdUM2lFbWlLVHVr?=
 =?utf-8?B?dDU1ZmFKclY5dTc3a0s1UTFrYzlONmJURzc1bkdVWmNLRWgyTkRsRE1qcVBw?=
 =?utf-8?B?U2hhTnkxQ2ZvSlFIcURCSGk2Z3RyNmdlTVhGdUtkcWptNHVDSWlNUndqTEsr?=
 =?utf-8?B?NDZjVkI4U2VTYmJ1bWl3enJDYzJmUlVXNWMvb1hEYis5WHVOVW0wNjhUM0Ru?=
 =?utf-8?B?SUNqNjkzK2VtZUI3T04yUFlLbFIrVlFPN01Oalpkd29Ud0lSYVhxWkh0N1ht?=
 =?utf-8?B?KzdoUVF4T21jYTFydkxmUmlOS2NMNnF6aDcraWpINnBiYWdHUUt3OXQyczM4?=
 =?utf-8?B?VjllWlFOV3haNTdiY3pYL2ZaUXMzY09WVm8vbm50cFIxdEVwQTBubkpRMEFM?=
 =?utf-8?B?ODhTY0NvcWRrcXpoMkJRTDVKeDZ0M2hvMlh1SnFxVXhXNGtmc3QvWWNDd1ls?=
 =?utf-8?B?T2JHTjRWK3U3VHhTQkF3OWsybVNQOUxqa2F2Q2p1bGJVR055RHVOYVRTeVRm?=
 =?utf-8?B?MU1BWWZBdE9qRUtaelA3SGNLd2hmZzdZVVJ0WnRBOVlZZXk2VG1pWVJ1TnZ4?=
 =?utf-8?B?LzFsWDN1VHhNTmh4cU5OOW1BY1BicWNhT1JQRTZUQVVsblBTMnRlZGV0SDdq?=
 =?utf-8?B?ejgrR0kwYmx4eW0zRk5UUVJ3NjhRSUtJWktBRnl4SUZIdVFQOHFYaWpiQlFW?=
 =?utf-8?Q?ZgQtUUzcAi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUgvbkVPMDlUK3kvOVRaT3IvWjVxTS92R2FjaDJoWUw3K1A3VzlvcXh5U3Y5?=
 =?utf-8?B?bGRURG5IcGhBQVNpdER1ajBUL29GcnE4LzFwVW1TQmU1U0dvSE11bDNjMDVS?=
 =?utf-8?B?Z0g2QmcrOWhvWVBySHEydjhDOFhhbnVqZERLdk5xV1cvQ3RwSU5QODVabzB0?=
 =?utf-8?B?aENEdWVCc01BZ3BiR05wQlNxL3ZUaDU2N2kwV3BBbGlvSW9xVXovaVIzbS9z?=
 =?utf-8?B?SjZDamJSWEw0ZDhKWnEyb2wxL2Mva2MyQzdBV1JuMERuTzkzZXlkeExLc0F5?=
 =?utf-8?B?cU5iTEhZZmlQNjdLRG1GZGlsMFZCOVU2eFg4eUNRSDFPUVZGUDBqai9ZTW02?=
 =?utf-8?B?OEcxNVhTMkMyTHRqUTRkQWxaR3hBUE9Ybk5UaEhkRzc5UmQ1cUFmRUVvWDMy?=
 =?utf-8?B?cnRWb2IwNE9WOGRnWTRFVU4xaHZJVU9BbUs1V252eGR3dHRaZDdIUzZYRkp3?=
 =?utf-8?B?bHBwNDYwVklzY3NFcjIyZmhhOUh6d3YxZkFyRHoxUDNDaWNHMlI2MUo1Y1Bj?=
 =?utf-8?B?SFdqSE5jcHJmams1N1RNYVQvRkhHd1FvWStYUkJINlo3T3YwU213QlRscXN1?=
 =?utf-8?B?Q1hWQTBPeExaL3JaSkcrcU5yam1zYkNSQjRtSGk2NlprVndkc1hWbzFCNnRB?=
 =?utf-8?B?UFArd2ZVUElhbzhpdktQLzhUQU9hZm5McXRQd3RhdnRyL3BxcFBmbVZhaUZN?=
 =?utf-8?B?MmFRQ2NWdmxRR3QwZ3k5bFhwMjhodnRvWUYrZUh6VThMMGkwL05TdVBtNCt3?=
 =?utf-8?B?ODc4QzZSaG1TSUJWcytWbG1BZGlKWXNyRTVIUFNzQ3dkR2NETUgrSEpVdFg2?=
 =?utf-8?B?K1laRittV01ZNlIzWTZuZnVXQktmRE5vNlJNaHpjZXp4MDUzeEtSZTV3U2Jo?=
 =?utf-8?B?UWZJbHQrL3orSHIraDA5U203LzlodkF3ZkF3Zi9qbkNBK3FqQ3JObHZmVktK?=
 =?utf-8?B?MmRPdFRDOXlQOU9MeXA0Wll6ZEd2eUpXN1dEU29OLy8zNEVMdXV3dEEvUzg0?=
 =?utf-8?B?OWlvcEVCUTBkdDUzbDA1RmxsWVBOVWpWTEhmQnFRZEJxSFlIQ1VzL1RWOVQz?=
 =?utf-8?B?YUN6S2xWeGlmVGRVV0ZZKzY3aVpuQ0E2bU96VHJwb0FtWWQ4MzhUTitTMTYr?=
 =?utf-8?B?ckc2a2dIbnR0QTMzZ2RGYXFXVGd2bU5NRjFnMDhvcU41ZStLRVhNR1JqNCt6?=
 =?utf-8?B?Y0xYa2UzOUJpdHF6RmtUWWlnYjY4WE1rRnF5ZUphSlh0em1XVytDUy9CYXZq?=
 =?utf-8?B?OUVEc0dCUitUS1RMV2JEQkw5b2ZaUGZqWFhaSm9Gc05rNlpPc081K0FtS1JI?=
 =?utf-8?B?Nm1uSUtDRGtWTVJ6U0VTNmNvcHgxdUU1MDRGN2M2ZUl6MDFZeXZaWGZZNkdG?=
 =?utf-8?B?MlJ6UlNsNjl3TmdUbXoyaGpYTy90NHlySmNNb3BRVDF4Sk1DUUNWWU5pNW5n?=
 =?utf-8?B?MklrNDZMU1psRHdTaXQwSlZyVEExcHlwZm50TThhWVh2R2FMb0lYMndqUTVx?=
 =?utf-8?B?b3RjOUdvdlRHdDdmWDQ0U0I3dEJXWm13Rjk5TzhBKzlvdXY0WW9hdkZUUUV3?=
 =?utf-8?B?THdVaEpGc0FPZ2lMQTNVNk9haXoxNG1zVmhiNGZSQkxZd0ZnY0Q1NDRxQUNH?=
 =?utf-8?B?cWd1R2xJOCtUa3hoMzhWdFhmM2xmWVJWc0FxM1lKMnFnRUVqYm9GZ0VJelRa?=
 =?utf-8?B?UGo3UmZVV2QxUElMb1J3OTg0dnM5VWg1YnlPQ1cwalFJUlVseEN0ZWVQdERQ?=
 =?utf-8?B?RWN0MDR3eVJzM3FFUU9NVDdTQlE5bEZZQUI1QzQyZkg5eWlWcHVCRVJPblM0?=
 =?utf-8?B?bG5xZlFMNTk5QTgwOUM4Qm9HQWttN3E1Sks5ZFVCWWlIMEZ3TDlFRnBFdUo0?=
 =?utf-8?B?ZWhleXptdXZURFljUlNkeXExclg0NUdzcWhNQVRQVDJLZUQra0MwSDQxL2pL?=
 =?utf-8?B?blZpRFRUNEkxejh1bFpCem1yQjEyR3NFbFNtaWdOOTRqUU91UVloZFdxY0M5?=
 =?utf-8?B?QXdwckp5UE1jWHRaUVJTcGpXZ1NEaUthSlZDV0VVNkdhcnFYNDNRbjlQUGFZ?=
 =?utf-8?B?blhZVmZjRXZPcHlJSDZRdjR0NFhWSW83c3dPNW91OTREQXBOeHQxd1ZjZVJ0?=
 =?utf-8?B?SUI0NWs4a3FtTDE1ZUVncmgyeUdhR3M4dTArK2s1M3FGdFo3U1E1MHNqSzBt?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cbf3b7-1723-421e-cacd-08ddef5fe098
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:15:22.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fquYx9xajPKo7awEDxj0VzLQvcUlF0LskKw32gzdoZ4ElkA3tEau0mJv2q8CLjar9zrn/Go8GbFIOkr2zN9X1XEjCOTpeznPasudpM8qLRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7749

Hi Mark,
    Thanks.

On 2025/9/9 00:55, Mark Brown wrote:
> Subject:
> Re: [PATCH v4 2/3] spi: amlogic: add driver for Amlogic SPI Flash Controller
> From:
> Mark Brown <broonie@kernel.org>
> Date:
> 2025/9/9 00:55
> 
> To:
> Xianwei Zhao <xianwei.zhao@amlogic.com>
> CC:
> Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
> Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
> Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org, 
> devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
> linux-amlogic@lists.infradead.org
> 
> 
> On Fri, Aug 29, 2025 at 01:16:14PM +0800, Xianwei Zhao wrote:
>> From: Feng Chen<feng.chen@amlogic.com>
>>
>> This driver provides support for the SPI mode of the Amlogic
>> Flash Controller. It supports both SPI NOR flash and SPI NAND
>> flash. For SPI NAND, the Host ECC hardware engine can be enabled.
> This breaks an x86 allmodconfig build with clang-19 for me:
> 
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:592:7: error: variable 'is
> _datain' is used uninitialized whenever 'if' condition is false [-Werror,-Wsomet
> imes-uninitialized]
>    592 |                 if (!buf) {
>        |                     ^~~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:601:12: note: uninitialize
> d use occurs here
>    601 |                                        is_datain ? sfc->info_buf : NULL,
>        |                                        ^~~~~~~~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:592:3: note: remove the 'i
> f' if its condition is always true
>    592 |                 if (!buf) {
>        |                 ^~~~~~~~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:590:13: error: variable 'is_datain' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>    590 |         } else if (op->data.dir == SPI_MEM_DATA_OUT) {
>        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:601:12: note: uninitialized use occurs here
>    601 |                                        is_datain ? sfc->info_buf : NULL,
>        |                                        ^~~~~~~~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:590:9: note: remove the 'if' if its condition is always true
>    590 |         } else if (op->data.dir == SPI_MEM_DATA_OUT) {
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:568:16: note: initialize the variable 'is_datain' to silence this warning
>    568 |         bool is_datain;
>        |                       ^
>        |                        = 0
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:590:13: error: variable 'buf' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>    590 |         } else if (op->data.dir == SPI_MEM_DATA_OUT) {
>        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:600:38: note: uninitialized use occurs here
>    600 |         ret = aml_sfc_dma_buffer_setup(sfc, buf, op->data.nbytes,
>        |                                             ^~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:590:9: note: remove the 'if' if its condition is always true
>    590 |         } else if (op->data.dir == SPI_MEM_DATA_OUT) {
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-amlogic-spifc-a4.c:566:11: note: initialize the variable 'buf' to silence this warning
>    566 |         void *buf;
>        |                  ^
>        |                   = NULL
> 3 errors generated.

I will fix it.

