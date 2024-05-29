Return-Path: <linux-spi+bounces-3112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33198D2E80
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 09:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D111C22488
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD6167DB3;
	Wed, 29 May 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wmak424Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4060167D94;
	Wed, 29 May 2024 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968425; cv=fail; b=MVGALCB/Gx7vT0c7s5h0z1Z9Xx57+8RoVM0OvjM+GbG3lICWT0h/nQW6fQf1hyU44h0pJuHPadOgl7pQQb2L98ANKmyh2zsgegG98kV1v/WKYlVl9sftanBGvL2eDLEWFLAE66lr0mCHyP7y4vvEvhIiqfdBrifi6R7pkVGFrUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968425; c=relaxed/simple;
	bh=Oop0EfjnTzM1hCMLmbH5CXglQ8ONzBpHIP37CwpqXv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nnJKQeLn7O0hR30BaqSRVaSL475fFZa2A4kTOnE6v1/y03LqLDyLBrz7il4Z0GtuoffvSMEUxy8w63S9fQozDF1Zd+zwo0lFJG52xw9J+bhffsad2fG6uH24NzPjzti62Tr/sLV0Tj3Yy980Y+ugvSUJabtSdgHRzF3K7PGpAuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wmak424Y; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T43nFx007551;
	Wed, 29 May 2024 00:40:08 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yddnvc785-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 00:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE8dV4qP4m6InA+I7GK3pSXBrjOlByWd+IrjPluDSG1XAWYGfjEj4qjKxxE3htwi1TvUqCiZudUaVQUEemy/MQGqwFIk09OTJ88ObXoFZjW4a0HP+7tIcXYT+fkGWwJqzi91VRxBrrzH+8uCMtAoTfNqKB2QJrhT5NclvPRV2B81/0nEgQ0zj/nq+9ddel2gc1jy6LuwwMsc4zilkfA+1QBd1uHZSbVUibgfkVOXyQRYPJspZzLbOw1jq0iPvvJJGSVE5jg1PAMaLs/hxD5ftTIsHLzcgk7M4DVOi27WtrcFBPlMxOdzie3OG4Mpq9xoiXrmUe/whoq/+G/sv5jCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oop0EfjnTzM1hCMLmbH5CXglQ8ONzBpHIP37CwpqXv4=;
 b=NNpQeshz9OlXfUvNwkmfRtDwMS6RI0rdvvly6nOkoiD3HjuUtq+Qe1RlXl+V5rIwWj6uzPTAiFdPhDgvBWBdocYgsg6C8hL6FrvgRgtmqKNzVOqEmCLl16x/abWlSHCezv1iDQNrbFLrUNJPAID3Qem2yiPj5Y6vEFRs7Gc2QrsYgDZB9PRPbc3RZSa8SPWd0bbbaOxijWKLCT+SICjYXozwYpt3ccJouQvgeEuo1rm0OiA6KuTHxuNExuHwqxm7qvw7rP5MNyGztPNaGORQNtiDq6pO8v1+FPTp6qDnd39lzV0DmIqI4GgniBPsGYFpdevdk+mFDlGJNszgbDgz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oop0EfjnTzM1hCMLmbH5CXglQ8ONzBpHIP37CwpqXv4=;
 b=Wmak424YRTcR9Npu9Ie8yPPYObidXtDNLVdXxJroBk9L1ovbkJGfK8hdgAixSDBG5gn8ebjdrIfKWlP1rpUL0qhFNaEXzXmLVJyLrk6ua3+v4jQ27rYFGIxf8Q8bi6KrJlVQZGfCpJb3Gz6zj3QTckw2Q7IdNc63Z2bJ7wcNl+A=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 BN9PR18MB4377.namprd18.prod.outlook.com (2603:10b6:408:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 07:40:05 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 07:40:05 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 2/5] spi: dt-bindings: cadence: Add
 Marvell overlay bindings documentation for Cadence XSPI
Thread-Topic: [EXTERNAL] Re: [PATCH v5 2/5] spi: dt-bindings: cadence: Add
 Marvell overlay bindings documentation for Cadence XSPI
Thread-Index: AQHasBHNsfBlIHHrBUeX4krWY65Xm7GsOC8AgAGeNzA=
Date: Wed, 29 May 2024 07:40:05 +0000
Message-ID: 
 <CO6PR18MB409880684E039B34FC6E3C4AB0F22@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240527084216.667380-1-wsadowski@marvell.com>
 <20240527084216.667380-4-wsadowski@marvell.com>
 <a9902865-afcb-4d58-934d-05d62a9e995d@linaro.org>
In-Reply-To: <a9902865-afcb-4d58-934d-05d62a9e995d@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|BN9PR18MB4377:EE_
x-ms-office365-filtering-correlation-id: c9826e92-bc44-4df6-dfec-08dc7fb28e78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YTBMbzl5OVliVmVoelQ1anIxL2pJSE9ERVVYRHFnam5tSzkzNXlWN1ptQXdQ?=
 =?utf-8?B?Y0Fwa3ZVeXNOSVBxL1lJeWZpekNXR0tGaWREeUw4RDY5RzZPeWZiQWtVQzhp?=
 =?utf-8?B?R1ZaV01KRVRNNkRBeTNqbVkvL01pem5sR0VUTm56dHlFS0VLUW1PVCs2bGlw?=
 =?utf-8?B?dmJCc25ubURPZDZQZUZDSFB2K1B2RTVHTU9BQlFNMExDeEExRXIzWGs0YWQ3?=
 =?utf-8?B?eThiamY1T1RqbW1tSGdSQ0Y1SFMydlJlSS92ZFVldGt2ZHIyeFNtSkFEZStH?=
 =?utf-8?B?bWYvL2xibUZON0NBR3lSYk1uL1FuZVhOOE5yMlQ2Qkp2Yzk1YTZLeVBrR0NC?=
 =?utf-8?B?R0V2L3l6ZmZ6RFh0YmJJc0E0cUJkbTRqTHVCTEdzbmp2RkN2NWNKTEU4cit6?=
 =?utf-8?B?Q1VYNkwyV0c5RzNFOWVwS1BEK1QwT1ppaTYydUJ3T0hZWlN0K2VsN0pRYVRI?=
 =?utf-8?B?alVleURaN0QvUktUN21SMnZxaVJHQ0RoSEJQMm5TQ0J3VTI5RU15LzM3Mkgz?=
 =?utf-8?B?a3JwNkN1eTFwV0M1enNCM1FjSHVxUndOYVRpcnlHN3JjbFl3N3E3TEtpNXRM?=
 =?utf-8?B?bURkZTFHM0FURkwxeGV3VXRoQTVYV2hUb3R2ZUN5WVdUOUUzSU02Ry80dXM2?=
 =?utf-8?B?MUFUTGZydnRpQjQvVDJ5ZXF5TXBXODBMWGJpKy83Q1ZPSVFtUXNXUEszVHY4?=
 =?utf-8?B?NlRPMkY0ZEc1WWxxczcyV2NYQzVNN2N2aDFmNjJJSDN2NlJ3UUZUME41UGdF?=
 =?utf-8?B?cUVxaS9ZbXhHV0RQTVpCTHVRajBoTk5FckY4L05ieGl1UlVnZVQzTXJZamJp?=
 =?utf-8?B?a0VrUWRiQmRMS0ZmV2M2UFNFb3RBV0NBZDdUbWEzVXVBNVVlalNLaHc4dFI1?=
 =?utf-8?B?SVlVeHZOU2VMQnJlN1N0cDVuSjJVT1ZXSThSZGxwV0pnZGh5a1lKVjA1NkdG?=
 =?utf-8?B?bjhFc2xxRFZTU3VZMnVqc3MwNC9DSFVBYTU5TmEzeENIODVSOXIwVTM2eEox?=
 =?utf-8?B?UWdJM1hrcTFzTFROalZaSzdjd3dwMzFkamZUZk5hUHBZS0RzWjkzSnF6S2p1?=
 =?utf-8?B?R3oyYjVkV1dwR1d6bFNNekRTR3B1VWpRSUFvb1NEcnd4emlITUVtUTVKQjBx?=
 =?utf-8?B?dlRsK0x0NE03S0dacWQxY2w4VVRDaUlMV292Zmo3SnpodlJ3R0ZPZ21DNkhM?=
 =?utf-8?B?by9vSjJGWFBXcUJZWWtWUk42VGI4d0pVTVZkbjR3QytLSm02MEVJZm1rSDlP?=
 =?utf-8?B?cjE1blJ4V0ltUk5JVUNaRVdlSnZLSFpQM0MzdE5NRDBlZ3FVb3RibXZzZ0U3?=
 =?utf-8?B?UGl2MHpUVzM2Qm80K1E2RjdPOFIrdVFtektXRTU0VzZNUytBSlR3ak9ybXFT?=
 =?utf-8?B?YnRMOGkzQUM3aWRCNG5VdWMrRGowL0t5dCt6TXFSeEZkSDB0OFdNekN6Yzgy?=
 =?utf-8?B?V2JGUFFOTGhlSmkvUndjRW42SlQvT1l1bnJBUS9TUHhrRXRiTnBueXl5MUhK?=
 =?utf-8?B?TXROcmZrcEN2aWJ3c0toL0lCSHAza0lHakFxWXZoTUdpNzA3bU1RVE5tT3FK?=
 =?utf-8?B?N21COTJlTFRGM01ZaUk2bVUrL2hUUDUyRU0rcEFEdU02WVo5SG85NTZtelI4?=
 =?utf-8?B?Q3RjcmlkV3dwOENaWEdxYWR2WUZqTzlTZFFucTNoeFBzTlpHZE4vQk1DUFdi?=
 =?utf-8?B?SHdoL1RyTmlHcWxWb0pjVkVNdDF3aC9rQ1pnK2cxaHBKd3JPc0dnU0dMQ3RY?=
 =?utf-8?B?UXB3LzVJZTlUZzZXSnN5L0s1cTJPbHZBOFh5MmNwdzlkUHJud0tRMmZwTmlI?=
 =?utf-8?B?eG9DNFNXUWtJOUxlRk0wUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bU1NNlJVMHE3RHovcU5wZFpRa0RlNVBXdVBwcmw4WWlGem5UbDJwMW1VKzdi?=
 =?utf-8?B?VktiU3dGYkRYdHEwb2NmeEtzbDdBSkMrV09KQTBNMlFQYjA0ZjN5QUUvVmdk?=
 =?utf-8?B?N00wUDFxQVZWeisxemx6RS9pZGJPcEZaalJOZWwzWnEzQ3p6OHZPZ3JjOHdw?=
 =?utf-8?B?akRTNWFkNlluOFMyZGRJeGt0bmFTYUdzaUR6S2tONjd0cWFnSzBQQmpXMjRN?=
 =?utf-8?B?ZnV1UW5kVmU1MlBaRVJWejBFQWw3K0dRdGFSMGVoMlZKdlRxL1RIRjZ2RlJi?=
 =?utf-8?B?aVpsaWx5TlFaWDdjTkNZSEFBQTRNWVQ1N1FBcFJGek83bUljUkRDZjFlQjdt?=
 =?utf-8?B?RjNFZ1B1YkpnTlQyUTlkVTQzam1zWVJ0ZG1hbjJZSUVsTE5wclF3eXZaV1l5?=
 =?utf-8?B?TlpnSjU4K1lQcXU2eUxZQkJlQXF5eE1VQjNkTENrWGNhanBhYlhidWhnSUVv?=
 =?utf-8?B?Y3pTUUlGVnIybHlKNFAzT1hjZFUxaUFla2EyQ3FUQnpyc1NYdEpMc3dHd0RX?=
 =?utf-8?B?YVhWcTM3YmtKT3kvSTA2c01JVWFOQXlXM0x4N1cwQVNxRGJnSVZWTy96eG9Y?=
 =?utf-8?B?Z1JnZlRlMnpPemFwRFQvbDY4MmthUnA1a2FRYUZtblVsa3loM1h3OUZmV25C?=
 =?utf-8?B?dVhJTS9ORFlSQXJOS21uVXRLanRkaFBvM0FKeUZFMGVJTzhtTnNYNk5PUTJC?=
 =?utf-8?B?Y1ZvOUoveWNoWmlEajVnMXJoY21sc2s5cHhXZzgrNTQ3SnhYUFhOWnl4clY0?=
 =?utf-8?B?a3BJM1AyRU0rQkN2SC90UDJZR2hOczE3aVczUzRkbDhlQ0o4RmNVcVFyUWxW?=
 =?utf-8?B?ckswTVRmU3Y5TlMwbHBxSmVQMkVRbU1tRi83Z2p3aGtvOENXTFIrcUV6N0hl?=
 =?utf-8?B?RzFkUXM3U0FkaTJuNE1NMllBMDJHSnJSQ3h1T2U2cVZsTFF1YkJOcWlBbUpn?=
 =?utf-8?B?YWptZmNhdTlMK3FzQkNlY0NtZXQ3NmpsM2xvb1k5R2dpOGwreitPVkg0YXZm?=
 =?utf-8?B?VDRRTEtJd2ZhZVZkUzVZT2Nkc0JsUzY0N1MzM01rNXRPdy84N05IRUFXYWxs?=
 =?utf-8?B?bWNnWXdaaHJuNFB0b0ZpWmpOaW01ZWVoc0FyclZJMzNGcnZyeUt2RmpyR2dX?=
 =?utf-8?B?UEJRNjFXQ1RxcGVNczFNbTlxYjZvbWhFbVI2Njd5UEFTQ3FYSUppT0dCV1Ro?=
 =?utf-8?B?a2plaE9qcURtVlpjSjgwVmlWRlY2bFplU2tZdklnbGo3bEZNVit1cm9EMVhM?=
 =?utf-8?B?enpxUFl1ZWJoNnVoWGEvVU9rcFpnQ2QxNk9JK003Mnl4bGRDUmtiZjV5UDhM?=
 =?utf-8?B?OXA2REFvMFozZitOdnJrZ3VNZzZQZitzd1dkNkVKMGhIQXovR1lZNzNNN0Fr?=
 =?utf-8?B?RlRFaWQ1dzZDN3hEQ1ZSUkUwRWpNVkV0SFRTQWJXcHVISDg1OTJRZkxLdWlR?=
 =?utf-8?B?dHVodmZMaWRkQVBzbFJiVlpEZkZjNE5NUE9mOEFCcW1ZS2RlWUJQZ1dBT1Nt?=
 =?utf-8?B?dEcza1c2OXlNZUYzcUlsVTFxclNzdzNEdGpHbkt4Ky9pYUJoSUZTeUZqblZr?=
 =?utf-8?B?UERzbllXNXdBTEVrS25wTTNMU3duSkFhTkhWWStvbmxybHdTSEFGSjdjdFhv?=
 =?utf-8?B?SW04akFkd0U5YVFKUklRR2MyejQxY0M5U0ZHQk5DR3lsaWtma1BJVTNRa2t6?=
 =?utf-8?B?MWpuTWx2eVhCQlJCWmh3akpaL0FYRHh3THpNSFlTRVZNeWdlM3RaTVhGREJX?=
 =?utf-8?B?cFBsSFBRWitlWHY2L0tGenU1a3ZiVExrM2QyOUltY29Ld1R3MFZKMU1URGlW?=
 =?utf-8?B?NUp6c2dsRE1WSEFpRVo2NFZkWkJ3aldNTitiVGRpMWw4QW9zWTd5TGdHUzRm?=
 =?utf-8?B?KytQeXpCZng3cjBZc2JPYlBLMW9MQlh1cXZETU53VHhzUjRRYUlBdlNpb2Iz?=
 =?utf-8?B?VGhOTHZoNldJcFQzeE1LNzRTNTNGZi80NGF0UWhoQnNTa1BsS1dNTTJ5S0Rn?=
 =?utf-8?B?RXpHN2RTTmllMFI2eEJFTkVZMjdXRnRsMW5leWw4REtVUlU0eHBpcHp6bjkr?=
 =?utf-8?B?MEIrS0NGRE96YWVzNW5mQ25WcERCalMxZnlMZXN4NGEyVXNTb1E0UFl4bmxJ?=
 =?utf-8?Q?lelvmJfKmEuSjr2gmAXBWGp2E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9826e92-bc44-4df6-dfec-08dc7fb28e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 07:40:05.0425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZxliwScC2Te6F9lS/1nT6Fr2zI2OeWkTswf1dNdTIqMMvjLu5pk7YdGU3mHTsmK1yLiJ5/yWJFlkLBZUT9OpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4377
X-Proofpoint-GUID: qZeP6Bq8IHqcur-hyuaIm7ulrouDvDFg
X-Proofpoint-ORIG-GUID: qZeP6Bq8IHqcur-hyuaIm7ulrouDvDFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01

DQoNCj4gT24gMjcvMDUvMjAyNCAxMDo0MiwgV2l0b2xkIFNhZG93c2tpIHdyb3RlOg0KPiA+IEFk
ZCBuZXcgYmluZGluZ3MgZm9yIHRoZSB2MiBNYXJ2ZWxsIHhTUEkgb3ZlcmxheToNCj4gPiBtYXJ2
ZWxsLGNuMTAteHNwaS1ub3IgY29tcGF0aWJsZSBzdHJpbmcuIFRoaXMgbmV3IGNvbXBhdGlibGUg
c3RyaW5nDQo+ID4gZGlzdGluZ3Vpc2hlcyBiZXR3ZWVuIHRoZSBvcmlnaW5hbCBhbmQgbW9kaWZp
ZWQgeFNQSSBibG9jay4NCj4gPg0KPiA+IEFsc28gYWRkIGFuIG9wdGlvbmFsIGJhc2UgZm9yIHRo
ZSB4ZmVyIHJlZ2lzdGVyIHNldCB3aXRoIGFuIGFkZGl0aW9uYWwNCj4gPiByZWcgZmllbGQgdG8g
YWxsb2NhdGUgdGhlIHhTUEkgTWFydmVsbCBvdmVybGF5IFhGRVIgYmxvY2suDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBXaXRvbGQgU2Fkb3dza2kgPHdzYWRvd3NraUBtYXJ2ZWxsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2NkbnMseHNwaS55YW1sICAg
IHwgMzggKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2NkbnMseHNwaS55YW1sDQo+ID4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2NkbnMseHNwaS55YW1sDQo+ID4gaW5kZXgg
ZWIwZjkyNDY4MTg1Li5kNmI4YjJhMmVjZjUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9jZG5zLHhzcGkueWFtbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvY2Rucyx4c3BpLnlhbWwNCj4gPiBAQCAt
MTUsMzMgKzE1LDU3IEBAIGRlc2NyaXB0aW9uOiB8DQo+ID4gICAgc2luZ2xlLCBkdWFsLCBxdWFk
IG9yIG9jdGFsIHdpcmUgdHJhbnNtaXNzaW9uIG1vZGVzIGZvcg0KPiA+ICAgIHJlYWQvd3JpdGUg
YWNjZXNzIHRvIHNsYXZlcyBzdWNoIGFzIFNQSS1OT1IgZmxhc2guDQo+ID4NCj4gPiAtYWxsT2Y6
DQo+ID4gLSAgLSAkcmVmOiBzcGktY29udHJvbGxlci55YW1sIw0KPiA+IC0NCj4gPiAgcHJvcGVy
dGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+IC0gICAgY29uc3Q6IGNkbnMseHNwaS1ub3IN
Cj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gY2Rucyx4c3BpLW5vcg0KPiA+ICsgICAgICAt
IG1hcnZlbGwsY24xMC14c3BpLW5vcg0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gDQo+IEl0ZW1zIGdvdCByZS1vcmRlcmVkLiBLZWVwIHByZXZpb3Vz
IG9yZGVyIHdoaWNoIG1hdGNoZXMgZXhwZWN0ZWQgc3R5bGUNCj4gKHNlZSBhbHNvIERUUyBjb2Rp
bmcgc3R5bGUpLg0KDQpPay4NCg0KPiANCj4gPg0KPiA+ICAgIHJlZzoNCj4gPiAgICAgIGl0ZW1z
Og0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIGNv
bnRyb2xsZXIgcmVnaXN0ZXIgc2V0DQo+ID4gICAgICAgIC0gZGVzY3JpcHRpb246IGFkZHJlc3Mg
YW5kIGxlbmd0aCBvZiB0aGUgU2xhdmUgRE1BIGRhdGEgcG9ydA0KPiA+ICAgICAgICAtIGRlc2Ny
aXB0aW9uOiBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIGF1eGlsaWFyeSByZWdpc3RlcnMNCj4g
PiArICAgICAgLSBkZXNjcmlwdGlvbjogYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSB4ZmVyIHJl
Z2lzdGVycw0KPiA+ICsgICAgbWluSXRlbXM6IDMNCj4gPg0KPiA+ICAgIHJlZy1uYW1lczoNCj4g
PiAgICAgIGl0ZW1zOg0KPiA+ICAgICAgICAtIGNvbnN0OiBpbw0KPiA+ICAgICAgICAtIGNvbnN0
OiBzZG1hDQo+ID4gICAgICAgIC0gY29uc3Q6IGF1eA0KPiA+IC0NCj4gPiAtICBpbnRlcnJ1cHRz
Og0KPiA+IC0gICAgbWF4SXRlbXM6IDENCj4gPiArICAgICAgLSBjb25zdDogeGZlcmJhc2UNCj4g
PiArICAgIG1pbkl0ZW1zOiAzDQo+ID4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQpSZWdhcmRzDQpXaXRlaw0KDQo=

