Return-Path: <linux-spi+bounces-10043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB49B59104
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 10:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8A82A038B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185F28C006;
	Tue, 16 Sep 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="vJLadk0g"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2122.outbound.protection.outlook.com [40.107.101.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34018289E21;
	Tue, 16 Sep 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012097; cv=fail; b=txFSBqKbyYu3ArDCS+3Sp6tJIvZmBZ/PCTXDObJUVKNiWhIj5uZLxOzHGq0bUIMMf0+aFNqvyMYfMxuEaEp4pxF7tpYe5wO5sborFtpRe2WRGM0KZUJeN6cMbMOH4pfZktUGRnxMGfGyPzVn9gSndYb9cUznMkTPEaO2NfZ7Ic0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012097; c=relaxed/simple;
	bh=ilggOEzJ/ITquf9sybIKMzgZzLleXOLJfKJGRpPQp9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a+leeB0CxZV6/vY4uETXypCCHI68hUyJjns1pT2qMr7bbALhJbIszMq86ja9G6/n4DoCB8uNTNq8dKgRn+E02RWcGoU/1xthx73BcD+kkiJVIopx05pskNsU5W8DN6N9ao54vOAhThT0c8Odf/Kx4gjLPrqPRgPKP82RK8ZBtcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=vJLadk0g; arc=fail smtp.client-ip=40.107.101.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEYfn4F66woPEAeF+h7l0q+30gmwoa2yhFtsBg5309VNNI/rSTNok8YRnh8J8Fi6jWQZ++vw1MoqFjgnrBFgFJ8Sn6UKBirJ1qbbfF+PwHmgS3KvTIKtDlFX5GnKAQLdOfxhHKNwErBIa5ImblP+4dR1b95eTrKX++ZigrrTolxxN+furVuewHIQHwJ9q71v+OHudovVPi/fluWn0lt1pe5GetNuLU9CAMpYIxg7TK9LVumzg8GEFB6sXURJk177PKPtfoQnjb+NciBrpTbETdySo+HVfX78SXGPqimo8MSMTi33QaO+OHmvQfQ9JxnL2Xa1Bgtct5p+VMrHUulplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne/7lknQG0D1TlPAnqktL6m02gvzVfh2W71LK5pi+jw=;
 b=nTl1KkUYmq7vaC2nrSRuIm75tZ0WEU7GwHTIhP5bHTMCMYpo6DRSor8jQkwhIQDrq35khhSP3ClIsdtQ07kBtyte0k/xyeMffu+rtO3MMXylkLL168YwbbGuw9mwtPgPmAGPY4Pd1lJOoFDaCCnCq21vYAkL/ytk4emyLbJP8dNNpkYcCjky0auv7Pg4XZsGXuEcsbZ4bY6weM9ixp7h+QHYsrhowOH6pVLyymJUCUcCFldPEhyU1NXrb2omo2MKh4DQ2iEL6ZZ9t74MNQo85cyHGwtytjydVm1yfw4ezQEUO8AdsYoGa/l8hTgtKsyZuoUhLFlr/Vcjhr1rHyUItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne/7lknQG0D1TlPAnqktL6m02gvzVfh2W71LK5pi+jw=;
 b=vJLadk0gmrdtIj9luZaQTw8BmDC1rzSPSxDXLr9la2T85at/cl6phsbS2WetS9WVcNkdlLYz3xgPB7H/iwJ2qhHUHdZ4On0yMsDQJiQvKuEav3bS5DDR9bceNf4Hr194CxREpECKasiHSAkYUsiPynrJi/pRz/I7DHt7Sg5KG9ezxi5KXtBr6fD24EL1eTq1VILZJM+Xr9JqRMY+EiAfOMB/gn2vXebw+uWRJClZ53yz/yYXLK2tLF/rUtD1S9BqoA+hG/5+/T4iMLUa84NjAPb9SQsi1svI34jIfWS1C7sUHHmQB7RwymvSCvyspHA065ZfVruLy8LhPo1Wb19Gpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by DM3PPF26AFCB99E.namprd18.prod.outlook.com (2603:10b6:f:fc00::696) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 08:41:34 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 08:41:33 +0000
Message-ID: <4a10ebbc-d109-4180-a104-bce87c53eacc@axiado.com>
Date: Tue, 16 Sep 2025 16:41:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Add entries for the Axiado SPI DB
 controller
To: Vladimir Moravcevic <vmoravcevic@axiado.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Axiado Reviewers <linux-maintainer@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-0-814a1fa2a83e@axiado.com>
 <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-3-814a1fa2a83e@axiado.com>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-3-814a1fa2a83e@axiado.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::12) To PH0PR18MB4558.namprd18.prod.outlook.com
 (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|DM3PPF26AFCB99E:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e72c356-642f-42bb-4c33-08ddf4fcd737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|42112799006|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkNYTTdZNTYyTGJnTHpvRWlsdllqS1VPSXBpTU5UZnVzak5ySHQ1N0RZejZX?=
 =?utf-8?B?dmsyeitBcGNQVXNNaWloOXQ2Tm5WQ0k1WUxWbzFacHpBRzRJaVZPMFFSQnBK?=
 =?utf-8?B?eVhFN1NvcDliMTFwUHFaWjVWNFVvWm1VK3VzWG1NZWk1MkxOQ1JxU2VwcTJu?=
 =?utf-8?B?L1FUMjk3Vmw5SmFZWk5leUFGY2V6NWd5MHczR0NqdU5wRnZjT2R0Unc1dTN4?=
 =?utf-8?B?SVBHdU5GWDJMN1RXamRmcGRrT3kxTkhaZEozUVZWWkxwTVUvejFnbmtVd0F1?=
 =?utf-8?B?ZStka21BdTVzSERNY0JTQ3Q4VUx6QmRpRmJ6ZTNXSlk3SnNyUzVibmd0SXhW?=
 =?utf-8?B?aGs2Y2JlemlLT3ZOSHl1S2pCbDRsTnlJVmd5T1I5NFlFTk5SaW5UQ200NElR?=
 =?utf-8?B?N1puMkt3SHg1MVl0ajJSMFNBaXQ4RzFUSnlkdHh3UFNPNzVybVVRMXJVT0d1?=
 =?utf-8?B?Y0t4ZkFrUzVyZzdjdVkxcFpVUXozdUY1b1RnSUZtYmlSeXQyMFFmWHJKQzhL?=
 =?utf-8?B?VmVYTnk0M1RrYXdxdlVJZUs2ZG0zT01XZUEvelA2S1k4TVBhZGVHUHBhcmJi?=
 =?utf-8?B?MnZRNWR2WkpxaGVrYzJxVVhZNFE0Qnh3M2RlNElCNWdwUGdnTDV0aTRNYW40?=
 =?utf-8?B?SkVEN1N1WFU3dUR0QXUvTnhxc2xoT2t0MkNMTmE0cVRiM1h5WEhzckRRSjNv?=
 =?utf-8?B?MDNZNHR0R2tYb00wWDFzV3N6SjluYnJ6ekdxRVlwVHRQejRObTZOdmlIejdI?=
 =?utf-8?B?RHdqRkVocTNPNzBkWDJuOXg0bnFLWk81MmhJeXdvWC9LVWNoZUZ1VitreGtS?=
 =?utf-8?B?N3ZjRFZZTDlXT3piV2hIUkVVZGdnTzVDdUl1SVRZV1U3VTM5cnpTU3pTbVVJ?=
 =?utf-8?B?c0dNWHc3bUtxend0MWVISjZGblIxd0xRRjloaXVlbndydGJmb2dvMzJMcnFL?=
 =?utf-8?B?NWg2d04zc0w1YnBOajlDVklWallGNVEwR1I5SmtGNWVFQmpkbDhWaE84Njli?=
 =?utf-8?B?ZklwQWtZTnp4UG0ycjgrNEFYTkhTUG1HMm9pZFYwNy9CcjVQN2JKcW95WWp3?=
 =?utf-8?B?Z0FjM1YvUC9BMHl2TXFTUEcxU2wwSG5kTzdIUFN4eURhNU5Hcmo5cHlYbzhp?=
 =?utf-8?B?MEwwTjQrY3NGUFdSakswaHFVcmNLeXpLVHZhYkVJaXFNY0crMlppTURpMUhm?=
 =?utf-8?B?b05RR2F1eGNESWZkNkMxV0E3N2F5OTRxbmI4N0toTWZubG9NWktiQzhGakNI?=
 =?utf-8?B?c3JOdEhOYkdtblZHTTZodDdlQUJ6ZWwyS0NTUlBlanBzTEdJRVo0azBFdUJ3?=
 =?utf-8?B?dVk4R0doY0NER21uY1BVY2JKblZuMUdyYy9oWjlDT1RHNk5HUlBpY1l3REk5?=
 =?utf-8?B?VnNZYU9xclhkclRyNHc3aC8zY0NOZmhoVHkvWE9rbi9XWitiLzBIZVludzJh?=
 =?utf-8?B?UmJHc3AyNWxLMlVyczlDdDhkb2JTbnVwYllvbHhUUDJWYlYvVnJXckI2akFU?=
 =?utf-8?B?amY3V3h2VFp5WE9nNlA5RHZ5WXA5cFNwd1FDUHVGUFl3RHpRTWcvMDVwNjBs?=
 =?utf-8?B?MzkvTW12ZGhoV2sxWVdXOGVSMEpmZzUzZnNoT2JUNC9ZY3pMaDNxU1VDRmRt?=
 =?utf-8?B?RC8xb1BQc2ZUc3p2Rm94elJ0R1hSL3NpemQwMWtyak9hRCtxME1XbWc1blp5?=
 =?utf-8?B?ekdVSFhYdm5uVXN4SVBRYWN1N1hRTTkySlZqcFprQkhVL2U1UHdnenJmTjMv?=
 =?utf-8?B?YWdkLzVrY295bWl4TEtya1hqaFIxbmRNeUZ4eS9QemRhL3BsdEVxSytvSTJx?=
 =?utf-8?B?N2Z1c0kzSzVmM0RIVjkyVHkxSFBROXVCTStMZU02ZGFoMWxpUmlrYXRVcXcv?=
 =?utf-8?B?SjFrd2tKZGRMNUh0ZnFhTy9wMkVLemluTVFhZUNwOEs2K0ZiRS85ZnFjR3Q4?=
 =?utf-8?Q?Q2uJMwyen5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVF0ZlZLREU2TmVnRG44TEtZMWxJeVk3MG5oby9rK01VMzM2d0g0SU1CN1FI?=
 =?utf-8?B?K2VFYlcrcHdqOTc2MFZsSVM5WVNkbGxZejNFNGR4eE11ZGpBeExCVHM2eHF2?=
 =?utf-8?B?bUszWEYzbTJvTWljT2g2c2p3ZEwxRHlWMU9aYUZhZitXVS9RSm9iYkZkSG5w?=
 =?utf-8?B?M2VpWG1ZQTlGU2tuT3MzY05NOTFWbUFjTlkvYm5TMzlXcWpwU2RtMUxWOTgx?=
 =?utf-8?B?RHdBR1ZjUHYwTnlXRzB1cGt2ajhZK3RYcGdtd2VqS2Q3WVJJUE4wOGVyNDNS?=
 =?utf-8?B?dTZtTEhHSkhpWXZBQ2Q0VmpyZXdMaVRwRWQxdTFCTHdVZDNQM2dKdm9vWmYr?=
 =?utf-8?B?RGVyMi92UWthYXRMaE9nQlVFNG80QjYySUZIRXZqZThKT25rSDhpeVJzQUF1?=
 =?utf-8?B?TDlpQk1DeDR0MEErYng5VFVjRTdtM1Y3Q1krb29rVEdVaC9VZzhwZnJVZ1NT?=
 =?utf-8?B?ekt6bXoyaXgxaG9Qa1ZXTEFRckg5STJHampYaytIU0Z3bTlSZkowZTgxYk9y?=
 =?utf-8?B?b2NIZkxwSGtaU1VKUmQ3WHp5NEp0dE12S3dDZnpHNVdhbzhybnZNOW4yNWlR?=
 =?utf-8?B?Z1k0WjRKMno3blFjanpnaGVuZ0hEcy9oMkZrL25DSkdBZUxlRi9MN3Iwai9v?=
 =?utf-8?B?b2xkaTkrZmF2UjViOEZYYjRuRzdhd3dlVmJUWFRQa3c2T0ZBUEN1MHlrOWR1?=
 =?utf-8?B?YzVNT21lSmpSNlV6N1FKNGRZUG01Rzl1L1hDWG1BTUwrUldWZ0R1c3dDQktz?=
 =?utf-8?B?RytSa0djZG9QOEwvZHNwUDFiWVhmTG9GakRZME9vVDI0MTdCRWtTT0hZbHg2?=
 =?utf-8?B?b2NPTGpxTVBrTCs0UkJwaDdYblJlN1haK04vSFhpQitGUGhaN1ZUQmV4ZWg5?=
 =?utf-8?B?NUxZd2hCSlNjaWk0VE9JdEZTZjc4QURhRURZRnM0U1BlL09mUzlsd2V6NG50?=
 =?utf-8?B?YmtrTnMxQjF4OGVKK0pKMTdPd1E3MDFLaC9ZTkE3bTFGSWIrOGFjZWlVQnk4?=
 =?utf-8?B?czVPUk9CbE5XclRtN2UzTW9kL1FIY2JLcUFnODhoeUp6S0RMelo4YTR4VUE0?=
 =?utf-8?B?UklHTmZzb3NiWUVGVklrZXQrVFNVOU1ldFd1Q3FYaUxrcS8wYWc3T3pyT3Jl?=
 =?utf-8?B?a2xJb3YyZVhmUzdHTFhSTmRqQVdsdVBqNkxEWW45SjF0Q0pkUFljUllUU0U3?=
 =?utf-8?B?TW93R2hVOEo4Q01kZDYwaXBPd1Fyai9vRHExdXRuU0JvaTJDQ1RSdWgrVWVS?=
 =?utf-8?B?M0cxek4zcDFuMnVPN0hONVB5YzdUbTUyTzFTbldwSUQ2b2cwOXdPK0pWVXpl?=
 =?utf-8?B?RXlUS08zVWlMeWZDWTh2dU5YUm9rQTZXVWZJT3E5VEUxUzBDSno4QlBnZ1RC?=
 =?utf-8?B?VUJwMU44RVY2Y0w3RExSb3dsSE1IcXZsWkhtdlBkYitRenVvSkx3YW5KK1Fl?=
 =?utf-8?B?MnJUOWZTWHNBUE1aR3BMKzdUK3U5cE0zRGFiNGt3NVlyTnBaT3VnVnE4UnVB?=
 =?utf-8?B?elVyYVl3T1lOS3ljbHY1WVA1by9QcDU1Skp1MGdUclVjeFNwM2NrdC9GZTBy?=
 =?utf-8?B?TEdXOXU5OEtGT2pEMjZZUTFsNG53L2s0NWRSNXZGVzdkdGFUNHJVMlk5Ry9i?=
 =?utf-8?B?WG1ZeTluMHNEbE9RbW9aZUY2U2xVVFZJM0NNRUVPMVYzQ0NndnYwZVNtWUhM?=
 =?utf-8?B?U2x6am9rUGVSQVBSNmp1bEZXQWgvL1dnODNSZ3ZkU2J0dklCMnRzdG9JNjlS?=
 =?utf-8?B?cmxocnRvYUFtSlFNMXl2OWtKZ1oza1ljckk4SFZHQ0twZ2hjQ1VHajUrKzN5?=
 =?utf-8?B?TWV4dXdSNENzcGExemNwQlVKUkpHRUZsdXAybDNNaldPZ1hmNkoyYUZYRGts?=
 =?utf-8?B?S1JUNEhiR2RCV1N0ZUVOL0pheXRJMUxFbGFTYWdmOEhrdDVZNDBKNXpGTUVI?=
 =?utf-8?B?djNQTlViOGtRbFUwWStVNE9aLzZyejBnWnQrcjVXUk5PdkExOWt4elI4Qnd2?=
 =?utf-8?B?WXQyTlMwS0F0TkxkbnltSU51QXRsbkFXYWR4L1V1dHlwK0h6T1BzNEJVVDM0?=
 =?utf-8?B?STNCRTEyMzZWaG9jVW1ZZXBCcEFEQTVxYWtxRXRXTFl6czFiTGdVazRRYnRk?=
 =?utf-8?Q?UmPTIO8KT4FNDBb6L7bHE/e5S?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e72c356-642f-42bb-4c33-08ddf4fcd737
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:41:33.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3QYVYwz1wO9VgUW0+fhiYRdN9YoSpdcEpHXn92WT3qrw6yPTKyGC65iFG2oY0Sn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF26AFCB99E

On 9/15/2025 9:11 PM, Vladimir Moravcevic wrote:
> +AXIADO SPI DB DRIVER
> +M:	Vladimir Moravcevic <vmoravcevic@axiado.com>
> +M:	Tzu-Hao Wei <twei@axiado.com>
> +R:	Axiado Reviewers <linux-maintainer@axiado.com>
> +L:	linux-spi@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
> +F:	drivers/spi/spi-axiado.c
> +F:	drivers/spi/spi-axiado.h

Acked-by: Tzu-Hao Wei <twei@axiado.com>

