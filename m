Return-Path: <linux-spi+bounces-11070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041D7C3A30F
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 11:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894A14604F1
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B530CDB4;
	Thu,  6 Nov 2025 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vbd3HPTj"
X-Original-To: linux-spi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D62405FD;
	Thu,  6 Nov 2025 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423603; cv=fail; b=eI3Z8N4U3QSdB8cuglWIgvkZPdgwccSwVTQQkzrj3xYvB2la0RzD9ADLHUYzVdLcoHQvAf/uy0HeBrr7btXi71qAKlM7Jc71Yc8pxfZ5bXOO+bs+S+97iRCWthH915xJjDu3OMvA/8qYiii8B/6AiwwHN5zX6MYkfPv60uJauis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423603; c=relaxed/simple;
	bh=3ARej5rCsoZ5IjKDpo9lTq8Qmf3+/s0NOCOQ8OTmv50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+FORItnUNhp9Gwg3hK6f2FX6ks/x+nIFip2/fTcST2SSDJ6cvgYQXlHGhnbXKon/QeLoK3g5KjvphhtJNV2ZRdHtFzrD+YE2gj6prFs47qo6Y7A/qvlREkKUjwDKAHX1lUgZqssW7/tq2FwD+511fZqqEm8km3RSSB8IjTXQ3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vbd3HPTj; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQGwo8IQeuXwRm2Tn+DyqC88Xsme3XgHqoQzjnRhc3B3Qm9zY6/cndEcFiffBTAQvF53JQg92aJsu3SBFF9buKLgL1ATv8EI2gb9dtRgC7WoLtXDMMOUelQof4bEPNvHPQYJgB9EWxBXAWkhE31vc0G/nteyq5/sgq3dMGIXvB2U1TLLHE9oYJkpMtA3l2DWgQF1IrLSqzqlzs1lKCszNn4y6TSmYWefhKvT5Vu1IE2Vn3zEgw/QPTpkJ/t0IzEAiqdQsHXYHsRbO9nevg3NUlohNwepsdvHJ+y2jJT2GVMChcD7T8fXgwCFu63A9Oqe/4DLVDeoZy51xyXIlMUr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAZ03X3klJn2rWpSl8DHIRcj5ISPzLPTPqv7W8acibY=;
 b=OaqK8YzsRfublFi7ONl6pPrFo7f8/vYt/QtZYAeFOnHz3dFelrLq47LFuFSJ5kP7A+4mkgoKQtc1uhQSwBa6nFgtLKEUCDBuQx4gubbUZEOcQjnZoOotXnwt0DqBvW7lTfxDbYX9QDpGUtffFyBnh0ugPFLiF4MeBQicP51ExyaSrZdXI0T5aWwGUDZzwYAMM3dYX5SXbjqWzsgLJKaPWG57dIFVWFOI5qlDD9SNoOwXgTztEmUqpMTrea85sAq9Jf+H0WHvnjKe+IR2CqnWVkNs9r82NKGUXS2r65CpCHgFIOSKPja8ArKBSZwYNIK94vTOE6Rett6XRNzQnkq7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAZ03X3klJn2rWpSl8DHIRcj5ISPzLPTPqv7W8acibY=;
 b=Vbd3HPTjnFIGtYMp4sVro9yYzt6ecLoQFjEKA01XjdvLc8EaoOVM3gQ9XDLTRr4gs/7Zkrm/E4dmv12ip4OErcrLA7LrqihghFfzdhR6+o0jcuAVcRIxrDvpPi8ONETaVWuQlS17ja1Ui9imMpuLYfjo8ZrZeObLwq/wmPkfbEoY6FmrTYR/20jT7Sd04ZKsc9lTt/goErRFsTErPcuClC4Dyv7p4S04EnVhK3Zh4PlafqWuzdl4uLNP/tgeGksRs7BQuJsTEZsDf/zzEISatZbQIR+bLB+TZ2pzPf3cCYUWiJI0N9cCsQ9m+0aL9qvOFS/7SVGCwOT9J1t/0QsJBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Thu, 6 Nov 2025 10:06:39 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 10:06:38 +0000
Message-ID: <a861e306-4a46-4f26-a0c2-f6f657571d48@nvidia.com>
Date: Thu, 6 Nov 2025 10:06:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] spi: tegra210-quad: Improve timeout handling under
 high system load
To: Vishwaroop A <va@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com,
 kyarlagadda@nvidia.com
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028155703.4151791-1-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251028155703.4151791-1-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0298.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: e7eb06a5-80b5-4eeb-2431-08de1d1c2d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG5TZm9uZXI0azBXeStUK2FuVGNLL1AvdytWRDltcnNDZ2tvQmcybkV0QkZN?=
 =?utf-8?B?UlI0Ui9VR2FwU2gwbHRJeWJPWW1nSWNzWUVpQllhSmRLbzVHNlNMdS9HbUR6?=
 =?utf-8?B?bmFQb3hQSG8xMklTVEgyK3BKSUpoaVF6SVBIMGJwQ1I1YlUybGJJQnNNL2JW?=
 =?utf-8?B?UzdKT09vU2xpQkxJV1I2NXN2MjQ4RytTd3dKVWV4LzEwd1hBR3E4MW1NbXc2?=
 =?utf-8?B?UXRtR2FMbm02c0UwWVpRTFVqdWxxQ3dIS2d4Zytqb1FvT0htclZEaWtPRVpj?=
 =?utf-8?B?Y1JSQm9TVzVNMm94UjlJMGxnMFdtUlE1ektRajFpd1dhcUxnWEZnek9aUzBs?=
 =?utf-8?B?R2VQNHh0Q1dxTi8vbmU5eHdZZmFpL0h3M0ZpVkhDUEd3WmxDcnJQekFBSldh?=
 =?utf-8?B?VUNKckdvbHQvNnpDQ0wzN2EzZW5YbmdYbFhILzlqOVhMNTR5bW1uWk5scGNn?=
 =?utf-8?B?NE85NHFtZExYdDJVUVMxS1Z3TGhzVjg2QTJyZWtTeWZvSHJsZXlTVjZ3YUtr?=
 =?utf-8?B?MkNMZnR5WTZ1dVc5Ry94VHozUFBqNXFKLzJDZWdVcldLUVJ6OUI3OWxZZ3Fx?=
 =?utf-8?B?bkgrRzVqTm5rMGNoTmxPSWtqQXBuYk0rcEEwZ2w1V1NyZzNXTC9yMTlncktD?=
 =?utf-8?B?VEhoMXIySTY1Y1NkQ2lyV05VQTQ2VG5SOWgzSi9CNW1UM0Jzem0zS0t6Y1po?=
 =?utf-8?B?N1l4Ukx4cVpSVzhoclJlZHNhYTZLZkZ0SE16cElBOWh1OUVURC93cytyalJv?=
 =?utf-8?B?Y1psd1JWMjBZMjdOZklaQjhSb1doeTJRMXhuRStYY255czBaWmZOQXdxamt3?=
 =?utf-8?B?Z2NUQWpHajZsNm56UTk3M255V2JyVzF2bVk3Y0dnTGNLRC9TZkRGOGVyZVp5?=
 =?utf-8?B?WDludDVHYkw5WGlsRnNLSnZqcGlvU250TEZtUUc2bE95ZkIwVmpEeXBIWFh0?=
 =?utf-8?B?MWdLZDIwYkVyVWtURzVsK3FmSnRaSHFYWU1IK3pKWUJOTnFaMVZmWTdxdUtG?=
 =?utf-8?B?Y0NsQmdJTThDbWx3MWQrZFMxTktXMHE2YktDWXBzU0xkYlRGZndpRlh4Z08v?=
 =?utf-8?B?V0JvVkF0S2VNYTNtQjRJc0RMRDRBelU5ZjUyUTlVMDhxWG5FRk5UdGFkV3p6?=
 =?utf-8?B?SVFySGRFV1ZGZzgveUJRem8vemU4R3VIUm82YzBMM3dHUTNIcWZDSnZ6ZVJh?=
 =?utf-8?B?WEdCVHNNcG9XZ0pjQXpxMHVVSHIrL3lta1dMVVlJSmVyU0U5NGhRbVgwandn?=
 =?utf-8?B?dG14UlJCU1pPaEt4cDV6bGkwb2xVcmVuMVVEQmNhdUl2dk95RFJTSUhERUIr?=
 =?utf-8?B?L2dpdWFoSnRQK2lzMVlQZnBWRjJuL0gyM0cxdzMvMmRGWEk0bTdYeCt0SzJt?=
 =?utf-8?B?RGJhOU45TGJGaW1DcHc4MjJpWEJLWmVoZi9WcGlNbit0MG1jejFaKzhZcjQ3?=
 =?utf-8?B?VWNNWk5PQlZCRngvTW5nWDZIN2U5Sy9KeFFGMEx0UkRjSFlyUk1YWWlMbkY5?=
 =?utf-8?B?RjlXNzEwdU8weWZRZEYwOUN2UFZHcmNNN2VudEtPMlo3STJhVG5TbkRKUXg1?=
 =?utf-8?B?SGM1LzNzUU5lemw0NEs2STRjYUJjbjEvM2ZtWUVTWDc1TnQ3YXFNQ2I4Tkc3?=
 =?utf-8?B?Q0JkVnQ2aWFraTEyQngwdXlVd2RpTE9Jd0FrT0VJVkRjVGRvUTgzSy9CZ0V6?=
 =?utf-8?B?V3NFVjc3RkoyS1NHMWFDc1lhL1dwc2tMMjY0cUo5U2x0NkY2blQxZXF2UEQv?=
 =?utf-8?B?bmJ6V0NaZWRKamNwZS9Rb0QxWitrRW5ZUzc0Rjg0NEx3V2xTQXltN0ZwSENY?=
 =?utf-8?B?cmxtWG5xSnFzVjJwUWNseWZMRVBYY1U0OC9EcE40THQ1VzdxckFxaU54dnZO?=
 =?utf-8?B?Ni9hVWJGcldhc0N3YzJPN0dsQmdrMFZBMzFwNlpRQU5yc081YXFTSnF6b2la?=
 =?utf-8?Q?0shQ81LEzpCbqKn6Qg3KTO22h39qqGMl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3JhLy9xMHA2dG96R1dGNGNGeDNpRUVyeUtoUHF3dXRIdzlqM3FyRXRqNFFG?=
 =?utf-8?B?ZkVGOU0zQWNPQWZoRFpBd0Fsc3I0aVRvZjBTT3NzamtQallMc3BuZUpEb2Jw?=
 =?utf-8?B?MmVvWXh2NWt2cHRZdFJFa1VnK0VXUUVGWGd6Y0RjRFU3TGp4MktSSXNrVnhO?=
 =?utf-8?B?TlB4ZFRDbVhFeVk3bFZuRXdaODRLeFdnQy9nQjRXVlpuK0xFOUZuczQweDhH?=
 =?utf-8?B?NFR1VGtiNzV5T09DRjlBZGVXbjFRS0thbUdlMnRrMnU2K0tHMS83enhNVzFD?=
 =?utf-8?B?bjEweSttdXNzL1hLd0NPaFVkNU03MDNLUHlSMTc4cUZCODlqZnZ5M2YwUFpK?=
 =?utf-8?B?djdHcE9KU2hXdnJVOTJZdk4yZUdqbzJHVkRjdHRDeG15Z1l2VDlyeDZjMGVP?=
 =?utf-8?B?YkROYWNCeklFaHZ0STdJV0RIRktyQkJvZkVMSlNtSlZMV2hvVUVPbHQ2Z2kr?=
 =?utf-8?B?eFEvbDhlc0p1cS9Pd1JwRWN2WThIVTlGM3FsT0ZVWFVnY0NqSSt5c21EUDRs?=
 =?utf-8?B?UHkrSURkVFErR1IwZWc0NytVcU1XYmYzMFBwM0M3WHlJVmptRUpnR2IxcHhE?=
 =?utf-8?B?RlFJWUlrbmxFdksyZEw5MSs1RE1IRWRmc2k3dWVkVVZNQWx4WWwzS01HWk54?=
 =?utf-8?B?OVBvNHFsYVFYUWphZ0tkTWxJS2JkU2pBOTlRTlcxMlRiSS9SR1FGY1oxU2xm?=
 =?utf-8?B?OHljTEZPeUdiTkovMVByNlRZcnlLSmxVdEg0UVdvVnM5bG8wdkY3c3pmL3dt?=
 =?utf-8?B?YVZhRzV6ZTlmcHp2MC9lcFMxL1UwYnBHVzBlOWZqNlRWcG1OVXR3bUpSL0FW?=
 =?utf-8?B?MXVFYzdSU29sTlZpamhDOU9YTlpuWGFBS3VVNlc1dkpvRTVUajN0THdhNDBB?=
 =?utf-8?B?dmViblVJZFdNQjdUV3ljUVFIODRDcDUxbUZ4OE1KOUVjL0dYbkRvaHU2ZVBY?=
 =?utf-8?B?aUNNVmdiSVdROW5jY2pYZDdPTjA0Um5UMFRreGlGdjQvdVpNY3FMMXFycXUw?=
 =?utf-8?B?L1N4Sy92MFErd3FyaTVBUTdNbG9tdzd6NnI4aEdZREpIanZOaU1Id2FRK1F6?=
 =?utf-8?B?KzRrd3IyV3kzQjdxVzJFOFQvMEJxV3RBSkIwUTVTVExhR0RJN21iT0l3VWkv?=
 =?utf-8?B?YzV6bUNPM1lzYWcwclhCeUpFSi94UE9rL2xmamt5T3hNblk1ZTA2NVRrRkFr?=
 =?utf-8?B?QXVOYVZMT1RwTFRaTG1naDhWb29WY0U1QkUwVFNnN3FzcnFUSGVrYXZhLzVG?=
 =?utf-8?B?ZnI2eVN5N1ZxdTh1VFhBa0tHczVXVHRiT0c5WHlqRkVsNUJaRENtWGRUTElN?=
 =?utf-8?B?TnVQK3lHSHVGbTV3VUg4bW5zZEFIZHZsUnd0UjJDQU5QTEtOZ0R0Y2pmRkVC?=
 =?utf-8?B?L3J1bndwZ3hJaWNWeElLbDdDckdSc2d2U2RraFVTMzNwUDBqb3lBa1BidXYw?=
 =?utf-8?B?Wk8rVSt3RDVZdCtodmxEVXN0VWZaenRGVUFTZG1Kcm95NWV0WmZKZ2VPVEsr?=
 =?utf-8?B?TldhQ3BqUzI3a2xvaU5qRDU2VWp0b2JnYlE2MGVrMXBlc1lHY0JUZzZ6WWlC?=
 =?utf-8?B?U0d3UVlBTGNZSVI0bzlUTFp4aGQzRVpYdkU1OGR0SzJIOEJFZ0dNaXBkdHNL?=
 =?utf-8?B?S1RTSVBwTS9jMkxMVm9QVWx3RUVnL0dNL09Id1lPdjdGdEtyQ2VwdzFwWWZj?=
 =?utf-8?B?V205YmdET2FnODBiU1RNTk9mMk5rOW5vdGpXdUxrSUhWMjRYZk5ZRVM2SUZs?=
 =?utf-8?B?SnVydVkwK1hkT2FsdnJNTm9xejlFQ21qaXpCS0kwRkR4TXlETnVyM08vajZX?=
 =?utf-8?B?MTNnS09DZFBFZmxIRTZGVnlLL0FZQXJtRE5rKzJQN3NhWlRXektEQVR1N0Ix?=
 =?utf-8?B?eWRGcC8vSmErVUxrRHJVMFRwYWZSaFNMSldRNm83d05uNnJjRXRqZTVZL25R?=
 =?utf-8?B?TGptenA1NXZKL0lNWEtmYWFtbXA5cVRXbUk5d3ZvY25iZ1BIbStsR0FGeC81?=
 =?utf-8?B?dXQwVUdBejAvU3BsWi9COEdYenp1UDhsbTJOWE5Rb09wczhEbHFrcUs5cTRs?=
 =?utf-8?B?eW5BRXpmSUhhejVSc24wL29aNERuWVVlV3FoSUdMT2U1ODZoTGc0K2c4KzFl?=
 =?utf-8?B?TU1KMWVSdFZJbEt5Q00zU1BTQ2xGeEw1RDlzVVN3UmxTWHpIQmluRE1lSWRX?=
 =?utf-8?B?Q2dwS2tFT3hhWjVYVzFmWUdLdTZyU2VpbFdUbTV0Qi9sZnBtTW5wUVBUeURi?=
 =?utf-8?B?Mm9DRkNsbHdKVVk0M3NxMEwxNjlnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eb06a5-80b5-4eeb-2431-08de1d1c2d14
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:06:38.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agTmqiEWVrPt5/391fTcQXeQqv97HAIq8m2/bl409t/mrgCceKzMdWMUZV790ZdfDmkUbsgtsnlZ27NaohRGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862


On 28/10/2025 15:57, Vishwaroop A wrote:
> Hi,
> 
> This patch series addresses timeout handling issues in the Tegra QSPI driver
> that occur under high system load conditions. We've observed that when CPUs
> are saturated (due to error injection, RAS firmware activity, or general CPU
> contention), QSPI interrupt handlers can be delayed, causing spurious transfer
> failures even though the hardware completed the operation successfully.
> 
> Patch 1 fixes a stale pointer issue by ensuring curr_xfer is cleared on timeout
> and checked when the IRQ thread finally runs. It also ensures interrupts are
> properly cleared on failure paths.
> 
> Patch 2 refactors the timeout cleanup code into dedicated helper functions
> (tegra_qspi_reset, tegra_qspi_dma_stop, tegra_qspi_pio_stop) to improve code
> readability and maintainability. This is purely a code reorganization with no
> functional changes.
> 
> Patch 3 adds hardware status checking on timeout. Before failing a transfer,
> the driver now reads QSPI_TRANS_STATUS to verify if the hardware actually
> completed the operation. If so, it manually invokes the completion handler
> instead of failing the transfer. This distinguishes genuine hardware timeouts
> from delayed/lost interrupts.
> 
> These changes have been tested in production environments under various high
> load scenarios including RAS testing and CPU saturation workloads.


For the series ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


