Return-Path: <linux-spi+bounces-9633-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398CBB328EE
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 15:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA05A1C81BC9
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE31C6FE1;
	Sat, 23 Aug 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="aF5+4LAw"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021080.outbound.protection.outlook.com [52.101.70.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86751393DFC;
	Sat, 23 Aug 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957274; cv=fail; b=Zkl4kWZDSXdV5IBAENaZEYxswY8zMWPNouViOjRu88Qn/JzG4YhuzDxeTRMCXyuFKt2KNZd51o4Y28aCcgTUpG4GyJQmv6mEtjqTi2Z2iBW1IRtKhMc8I+NIngVSCgCnfXgD4+ftkqwVwOmMOtHys/InCAWqfWYemwrvT1Fh9iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957274; c=relaxed/simple;
	bh=0QG1oCt+yQXozTEPvOQGXQzQYMCF1xK1n67EwXHe8vA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYy4WZTlo4esgRmXLavYOc9IEFaLLtZqwRPBENa5rGlQlH4EGw4WsSwR+F6H539cJcBgPA6PGEu/WO12D4LlriZWcGVTecXUSjk7MuMB4KRQZHpF35soiAbm2ZXOicbcIjFLuBaZKide30Zg72dDBzwELUpf4u1PNBmOvWe249A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=aF5+4LAw; arc=fail smtp.client-ip=52.101.70.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHxfcVkpxFBcF12ugyZnB+1YaqJGjgyy8BOa9wZzp8c7CujBWZKWdHSb0M948Q1stJjXELWdSI4/KWRhK7JjIpOZmXtMSBxz5JizUDuZfhvDTbNelVEtOzZX8Cb9L8jStVw+prKGyxL+fdjScu92viyujtcgVKtImwR+JDqtWfnHZaKWh4gL1xHFUPATlA7xZvk9xqq3tNO1g4v+IB+AnlvMjEOh9PVUEX8xa7zDQ5QRAlv/qHuExSm8fy0mgrP7NI8DFKyO2DJbsWYoJrxI0qa4AxYBUulMz72gGXFLs6CLaFYxYZfBe1Pma2P7muyW9Rv4tPVX3hNpBh+LCXvMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFyHytACELyW66MRMfidmLJ3YMVyCY28ip/UKFh8DsY=;
 b=FYdUmerL32xqLYaNmlv5HtHN+yCJZRI7e3uaj1KA13xMmG2a9IoOtYd1o8ewJxWx7Gd7H38s6SJjJp7HsTAGrlP/09wTL62h7VMw9YMEseMK7riD7JzghE2LWaYIxLklFyzf7ieZy92pr3KpweAu0qruIZ9FgbXQhGZIVMeQZjRahfVSpOmW5bcBIC9Fj1WHmiheeIWAFe9mjUZ5LCDf0ci6JNuvbefKgNfI1Z6kAJAdvSzt4q6zUmDk1C8tpLg+B8yDZe3KfBMwDCoc+IDTg2tiTCT7DLvdphIwmsd8doFNWY+eNz21yxBL6xUuSH/w+OeU5/rliiOKJJtvXDaG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFyHytACELyW66MRMfidmLJ3YMVyCY28ip/UKFh8DsY=;
 b=aF5+4LAwBIJFyINeudAreKdob1wI03KiCPKOxWekFMP9FJoQi0NEFxyUJQuluhmllo8X757j4aGjjn98cNmglzJydFrvHewKPwSaJ0BBAg5TK6zR3RngYE9+m6DNCRaUrtXZaMGevNdV8I0VPxaeQZk9BfhhlRe3qM3DohBu9x8f8W32icDnOvqNR6+XZrIgL8IVhJooFbSJ9aWpUjJ0asekXKruuW/1FLT45KLz37En+8CGHVSPqbptHNo71dZbjV4hTPh1JN+a1YwL+pz1Dj4ift7wtzMQFNjbopZYK5S9ZazKAXebQRXM8KX3NG8DFO/btuZeDHq/1XT5+PeifA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7904.eurprd08.prod.outlook.com (2603:10a6:20b:51f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 13:54:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 13:54:29 +0000
Message-ID: <68130d82-edbe-4e23-9538-733f9c52123c@iopsys.eu>
Date: Sat, 23 Aug 2025 16:54:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] spi: airoha: add support of dual/quad wires spi
 modes
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823001626.3641935-4-mikhail.kshevetskiy@iopsys.eu>
 <aKl43hTJJVqRE3Rt@lore-rh-laptop>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aKl43hTJJVqRE3Rt@lore-rh-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0001A052.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::4a1) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a762d-6418-4a56-9220-08dde24c9464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2p4alI4c2hLSjQ0bDNqUG00QklmN2x4bG9DRFAvQXVJZHRGTEYwc3pEcFJE?=
 =?utf-8?B?THRTRnhoczlmYXU1aXpteU94OHJpbDlLVXVReklGVFk3UlpqcWNyck9qNVN1?=
 =?utf-8?B?OGNQMXZJWEJNbGdiU2VSelA4MnJ5ckRIY1lxV3lqMVFwcElpR1Z2NWVQV2ds?=
 =?utf-8?B?Z0FTOTY5YmNoM0xvRThjWDM4V0dKd2dSZVdETFlKc01JczJ6a1d0dkpMWkxi?=
 =?utf-8?B?RFJoU0VLRXBJRE4vbDRWMXFCeHg3SHJTSTlYYSs4UGJpaUdtbXdYVng5SGZn?=
 =?utf-8?B?d3RLWFVyS2ZXRFYyN2pMdTdwSytNb3NXOFV0T2t4c1hkTkNuaHQzM2FSR3lu?=
 =?utf-8?B?U2xmT1RIUG9qb2ZXcGo1azRNTCt4em00VTBHOTlub3NYeGJkMjcyZFhBU01a?=
 =?utf-8?B?cDRCbEoxdllEZ25JVmVtck5pRVRTWUpnTkwvSXEzYlJYOGttVnFvNjhJNVRn?=
 =?utf-8?B?VVVBc1hVaVROMWRyVXVQR3NHOHQ3L0FxL3NScTRaaElMME1wTnlyNFNUTXR3?=
 =?utf-8?B?S2VRZkZtU0FiWkMwS0gzZEU5a0dzNE1zcmNGVHViMk5KZk1WOVVJaDc1WGMx?=
 =?utf-8?B?Y2swbzZuVFEyNjE1OEdZYy9jVExQOHVJeThYWkxLZXI5cWF4U1pFbDBPSHM0?=
 =?utf-8?B?K0J1b3cvMURiWXVvMUwzSTMxZzdOTkhXQzlvaURjazJ3aVZ0b3Qzc2VyYU42?=
 =?utf-8?B?UnJiakcrU1EyMURMRWk2WDFuWXMzckhkeFJOMCtYYWxxRlc0dmt0YTdEaFRa?=
 =?utf-8?B?UTk5azRhcXBJTUZGTGNZTCtOSC9vZ3VHUlUrblhRS3ppZmpPOGF3TXkxQi9o?=
 =?utf-8?B?Z3RvNjYyNDdZd21XOEE2WUdJTUdNQ0p2VHVwYzI3R1VuSGRzYy8ydXA4bE1u?=
 =?utf-8?B?NGdlcm1hSDJSRkVZMEhURnVIZW5KNUFXOXFMc0Vsc1FBTXZzR01IMHR2dENL?=
 =?utf-8?B?c2tVaERXYnVQelA0QndWUWR3T0p4bXRxNnYvUE02ck85cGNGTnNEMnFreSt1?=
 =?utf-8?B?UHZCdzdIMVVCR0gzNzNQV1RmTUVVOFJ4elJqVE1sT2EyYnBSdGNhaUM2UVAw?=
 =?utf-8?B?dWN6dVI4OEE0bEhYUlM4RVJaMDNoQmMwN1FnekFDMG9LWkxCa0pqZmhtcG5r?=
 =?utf-8?B?TU9jMzVRZEZ5OENDemR6SlEwa3A5ekQvVVZYM25Zd0ZNRFBRTGhiaEx5N1VC?=
 =?utf-8?B?VWVJcTR1bzhiWEtrUFlrbVd5ZDlCQ0JHcUhtNlZCTkt4dWZzRTExSVRLN0x0?=
 =?utf-8?B?R0p4dzhEaGo5QlM0b3BtenNkRnBFL0lRZlFBS3U0WElTdTlyMW44bnUySlpD?=
 =?utf-8?B?ZVNRVnJjenFwNmNSRUFrdWtORTNUdG5TNzlGRlp2VkZuaW1JNy9rSjdiNXRQ?=
 =?utf-8?B?Rmw0dDZ6MEpDRUtkakEydm5CNmVaME51czluUVNwMUVkTHhtdmxnVlkvZFlL?=
 =?utf-8?B?elZ3amhyd2RURXYzUDE1b2Eyb011YmR2bEcyakNCRytYOWk0aW45NWNxY2tl?=
 =?utf-8?B?d0tWcmxDaElETlcxNHpBVytkaURyNTdRYVB0d1dBSjlPeWJ2emNEWjYxMElT?=
 =?utf-8?B?b3ZDTmNUYlcxQ1I5UmJleXcwcXV4QzhReklZVFBldGJyM0JhN0JTdCt5UU4z?=
 =?utf-8?B?bHB5bkdxWTVMNlFjL0FJNWFRYTZNZGpQKzBoeXRyVUYvVFdhTFFBSEEvQkNM?=
 =?utf-8?B?MkZoRTFLbHNCMHloRFBodFYzQkZLcnNleEg1am1xV29aSlgzRzhlMFdPM0RI?=
 =?utf-8?B?TEZoZ0E3QXhna0ZJUTErRlRxaE11L2hRT01xaGYrcytaZ3ZzWGdyT0xnRnI0?=
 =?utf-8?B?eVBYdXNUaDJkV1poYkc5WENjd0Y2WkViSGtrWEIvNlpsY01kUExURHVLS0lp?=
 =?utf-8?B?ZXYrRmZ5WlAwcThqeTdGVDRrM1Y1bFJoaWZFQzVKNGpKZUhMaU1aaURVc1E4?=
 =?utf-8?Q?S3ECuJ6r6JQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2E4RnJ4WGlzZXM5Q09vMjVIZ3pVajRvQVlKTnc1bVB1VURJUDd5ODZERTZM?=
 =?utf-8?B?cm9aaHUwclBtTDVUTytrbTl4L0FXRUtDNG4wMGZlQ3J1Y2lrV0dpSTVjTFlR?=
 =?utf-8?B?ODQ1dUhuUVZHQnc4bGpqR1QzRXp6ektjOWZFN1orc0RJa0NoSjZwZVBzcFN3?=
 =?utf-8?B?TFprVktuR2lLMVF2ZUtYbjZMZUZ6bU5qWVkwYXhRRnN1bVkxSzJCdFBqbUY0?=
 =?utf-8?B?RHhxK0x2NkVQWUloTUh3MkR3MGlib3lRbHl4TElLTks4S3oxeEFmTCtEZzJ3?=
 =?utf-8?B?RE9xbmRPY1BPRVMva0VjVXVaekZXUHdvbFk4RGNQQ2hmbk5icEE3MklBeTV1?=
 =?utf-8?B?cnpRWDBnaUNDNkJydFd2bWl1dHhvRTFOMkhNY2c3dTdxWHlLRjQ4WE9CdjV6?=
 =?utf-8?B?Q2R1dmFFdzFINGZIMjREUVB0NEJJeE9UR095T0lvU21iUEZPQUFJUjJsOEpM?=
 =?utf-8?B?OU50OHBaWnY1U0lTdUpuc3ZuQmh0ZlFYRWxvUytCcUxLdHhJMmlYUEVHOHl0?=
 =?utf-8?B?VHV0K0MxTjI3bVAzaFZiTDNJeHllZTU3dWY0dkRGRzFMVXpvT1ZCNGsrZm1a?=
 =?utf-8?B?M0g5UGJJakJQR1dFZ0NNZUlhR2luY1lSNEhWdExKVHNMY3VncGhUZk85YTdr?=
 =?utf-8?B?djJSWitaekF3SFFwYjVZTk0zZVdob0N2ZlgxMzArSGJtbjN4UitORW5TVGNs?=
 =?utf-8?B?Ui84SVdGaW9lTmdSYkVsc0toSFpmUHFhYmpkQkFUdHhjUXo2RmU0QVpnVFRK?=
 =?utf-8?B?ckIxWVJBRExURFh5UGk5ejYyUmVlcHZwbFRlRGdTcDljUEtEeXhwQmVSdjJE?=
 =?utf-8?B?aVBhblN2L2ZyKzBGQXN5cGh6d1doMm94a0lIR0V6UDV3YllLRkdxaWx3azBn?=
 =?utf-8?B?ZTNEZlBGeDV3TnhEVURSbXMvM3gyWXZRWlNuaFNweW1zMWdJT3hMY0lnMjUv?=
 =?utf-8?B?TndIT3B0bGM3anZXdEEweEQwWU1vOE1ncEdwY01WRkgweEtPMlhLRWxzMlZT?=
 =?utf-8?B?clN1WVUzbDNhczd6cnE1aUZzWjZPQ3RCdU1mdWl5bC9zQzcyMkowbnBNbFAw?=
 =?utf-8?B?blczeHM0VUJxdTlwUjYvYXB5dW80OFE5WkVJMnNVbDZXZWFEdmZiUEVNdWlY?=
 =?utf-8?B?b0lOb2xWNmVHOVpNNjRsN2VDSm9zVkg4cldqc1FMYURYN0s5cmlDQkJyOUVN?=
 =?utf-8?B?ZVFiazNvZER6RmVWVEdpaFUwR0ZHd1hzcnFpV3dJUTFFbE16QzVoWDFSeG5w?=
 =?utf-8?B?ZkM3d1JPVG5MTjN4SGF5dWszOVFQNHpTMEU1YlhNR3lIWC80a0VYUERiSjFm?=
 =?utf-8?B?N1NHVmNMclc1ellmbEJzSzFrdEhHTXZpblZLZ1NDZ0hQaVpKRFZKSEo5bVBE?=
 =?utf-8?B?aGtYQ2k1NEJsQVlPd1FVR2ZUZDNiT2FHVHJsMTRmdjRPT0dnYXh4d1ZwelJx?=
 =?utf-8?B?NkVpM3pSOXJkbUVPbFl2a1FHNzV1V0UwOWtFcmZkT0o1VzAveGhmdGlkbDho?=
 =?utf-8?B?enBMRTh5Ri9tb0JWQ3lNK21nOGpDeWk4aW5lNytPbDU2V0NjOUozS25zTzZJ?=
 =?utf-8?B?dHpNT1BnVTFNVjhUYnV3czBKNUY4MlhrblE0N1hNK202RmJRekVkSG5jUU4z?=
 =?utf-8?B?allYSU5PL25MSEd0V2MxaUZPWEVIMkxlaGRMMDhPcEQ4N1k1UjFSOVgyWHJI?=
 =?utf-8?B?alNUK0d4Y25UckRVMHExS0kxcXQ2WUxOeC9FVTM0VHZnQVRDdExTYUF6M0lu?=
 =?utf-8?B?blM2cWFOMGl4RzhFelNoODUxZ0o4VFNiNWc1OXRIT1lkTnQwdm1ReEtnL1BY?=
 =?utf-8?B?N2lIdm4vWDlveUk3NVdHUzRvd3BIT2dkclY0eCt0a2R0Zm01VzJNUmxDR1Bp?=
 =?utf-8?B?NjNHNEpwUkxsNWc5UU5mZ2JUWXlSK2RkUzBhUW9DT1JuVll1Y1E4ZGIwWnlG?=
 =?utf-8?B?enJuNytTTjBaVXBTZ2FjcGZvLzlzN2tWcVNGWE5hN2RrZGE5TCt5aWU5V1Ba?=
 =?utf-8?B?UUhoeDlFQytRSzYxM082c3NLL2JRY1duUzI2M3lvbStOMDliRnVTYjVPOFI3?=
 =?utf-8?B?T0RXM3czcHBuSnF2akhVc1dpeDF0QjBrK0t3VWZjbnZINmNFRzJITnhUYllj?=
 =?utf-8?B?bGtnNGlXRW1IeVZ5d1FxMDFQbFFDVTlHSzd6Qi9hTHp5VjE5UTJpWVBseGkw?=
 =?utf-8?Q?w1WTQdqmQnKRgsNaZg7KQKQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a762d-6418-4a56-9220-08dde24c9464
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 13:54:29.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEGslcy0cp9tUOnjsGpqjfMf1wOFUIJ8tOSDqeDss5X3AqxEJTYQT+s7o1qtycWk1WY1JeJMmCcXuKswxypDntK7oH06BulN8jy+r8BQWQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7904


On 23.08.2025 11:16, Lorenzo Bianconi wrote:
> [...]
>> -static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
>> -				   const u8 *data, int len)
>> +static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
>> +				   const u8 *data, int len, int buswidth)
>>  {
>>  	int i, data_len;
>> +	u8 cmd;
>> +
>> +	switch (buswidth) {
>> +	case 0:
>> +	case 1:
>> +		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
>> +		break;
>> +	case 2:
>> +		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
>> +		break;
>> +	case 4:
>> +		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> Since this is used in airoha_snand_write_data() and in airoha_snand_read_data()
> I guess you can define a routine for it.

It's not the same. It looks similar, but different constants are used
for rx and tx cases.

>
>>  
>>  	for (i = 0; i < len; i += data_len) {
>>  		int err;
>> @@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
>>  	return 0;
>>  }
>>  
>> -static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
>> -				  int len)
>> +static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
>> +				  u8 *data, int len, int buswidth)
>>  {
>>  	int i, data_len;
>> +	u8 cmd;
>> +
>> +	switch (buswidth) {
>> +	case 0:
>> +	case 1:
>> +		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
>> +		break;
>> +	case 2:
>> +		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
>> +		break;
>> +	case 4:
>> +		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>>  
>>  	for (i = 0; i < len; i += data_len) {
>>  		int err;
>>  
>>  		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
>> -		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
>> +		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
>>  		if (err)
>>  			return err;
>>  
>> @@ -895,12 +935,27 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
>>  static int airoha_snand_exec_op(struct spi_mem *mem,
>>  				const struct spi_mem_op *op)
>>  {
>> -	u8 data[8], cmd, opcode = op->cmd.opcode;
>>  	struct airoha_snand_ctrl *as_ctrl;
>> -	int i, err;
>> +	char buf[20], *data;
>> +	int i, err, op_len, addr_len, dummy_len;
> nit: can you please respect the 'reverse christmas tree' here?
will fix
>
>>  
>>  	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
>>  
>> +	op_len = op->cmd.nbytes;
>> +	addr_len = op->addr.nbytes;
>> +	dummy_len = op->dummy.nbytes;
>> +
>> +	if (op_len + dummy_len + addr_len > sizeof(buf))
>> +		return -EIO;
>> +
>> +	data = buf;
>> +	for (i = 0; i < op_len; i++)
>> +		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
>> +	for (i = 0; i < addr_len; i++)
>> +		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
>> +	for (i = 0; i < dummy_len; i++)
>> +		*data++ = 0xff;
>> +
>>  	/* switch to manual mode */
>>  	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
>>  	if (err < 0)
>> @@ -911,40 +966,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
>>  		return err;
>>  
>>  	/* opcode */
>> -	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
>> +	data = buf;
>> +	err = airoha_snand_write_data(as_ctrl, data, op_len,
>> +				      op->cmd.buswidth);
>>  	if (err)
>>  		return err;
>>  
>>  	/* addr part */
>> -	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
>> -	put_unaligned_be64(op->addr.val, data);
>> -
>> -	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
>> -	     i < ARRAY_SIZE(data); i++) {
>> -		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
>> -					      sizeof(data[0]));
>> +	data += op_len;
>> +	if (addr_len) {
>> +		err = airoha_snand_write_data(as_ctrl, data, addr_len,
>> +					      op->addr.buswidth);
>>  		if (err)
>>  			return err;
>>  	}
>>  
>>  	/* dummy */
>> -	data[0] = 0xff;
>> -	for (i = 0; i < op->dummy.nbytes; i++) {
>> -		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
>> -					      sizeof(data[0]));
>> +	data += addr_len;
>> +	if (dummy_len) {
>> +		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
>> +					      op->dummy.buswidth);
>>  		if (err)
>>  			return err;
>>  	}
>>  
>>  	/* data */
>> -	if (op->data.dir == SPI_MEM_DATA_IN) {
>> -		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
>> -					     op->data.nbytes);
>> -		if (err)
>> -			return err;
>> -	} else {
>> -		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
>> -					      op->data.nbytes);
>> +	if (op->data.nbytes) {
>> +		if (op->data.dir == SPI_MEM_DATA_IN)
>> +			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
>> +						     op->data.nbytes,
>> +						     op->data.buswidth);
>> +		else
>> +			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
>> +						      op->data.nbytes,
>> +						      op->data.buswidth);
>>  		if (err)
>>  			return err;
>>  	}
>> -- 
>> 2.50.1
>>

