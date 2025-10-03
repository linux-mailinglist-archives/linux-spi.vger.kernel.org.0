Return-Path: <linux-spi+bounces-10434-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ED7BB742B
	for <lists+linux-spi@lfdr.de>; Fri, 03 Oct 2025 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6570E4E444D
	for <lists+linux-spi@lfdr.de>; Fri,  3 Oct 2025 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8CA28136E;
	Fri,  3 Oct 2025 14:58:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023092.outbound.protection.outlook.com [40.107.44.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F8347DD;
	Fri,  3 Oct 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503536; cv=fail; b=B+2x79n2bqZsMmTXC0tu03Q/0xoz78o5pDMs/bx5lB2LXyknMtoLgHJO2I8ZC0rKV/ifY+MPah517bxBuW8+XGBWt1ikdjr2wXW6b8hbm7NCvXcwu42dHt/XAbO77TtxjTVp3WlJ+D+I6xEyYNv+wN5TWuyJ4Ema23nQlBzeRl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503536; c=relaxed/simple;
	bh=X+LmB7Dm8sSM0ZXs3hIsOa31/tXiUcXI6jhtMQ7MP8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nv7DPdj9z+2bvkMHxFxsY4n6K/oWda1HI8UvvwfdG37+upcl4aweNgkUUWIqFfPbtsPkCTnfFk1qvjH6OwHI7ED2aFSF1gf/OvssMhWria+JyYlwd5WESbLC/059WfCgs56MID0j0w+ClZb0SPWGsqNB4wBbBVj3zYpJoZUESwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vacnGvYGdpUvomTwiEl/FIyN1trWS34cfwpyAbaZ/qAkpmY0nGi979YxQZBsoEKgsRLa4dJpjlxHxvkMArSSH5TD4z1Z87HQrzC2bll4SGGgSuQ7ZACVgOSCZBpmqFftCrSpsYQn7n+R5U8zBVqsXx1Pbt0FFBBqli9N0KjZPUICcBneJReoMfxf2MkV+LQtJilTwX8xSQC1MiNVRdIG1Y+v1CllU/ER3ABni0hNsrsQ9/yfIoGSiBmkdBIDvmoOqMgfMbsJBXXj6Dn6rEr8zB11D2pwUNDPreTGCicwgv4HnU7AzAKonYgbmkWufZY4DR14Nru5CBEyI7fepm6+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+LmB7Dm8sSM0ZXs3hIsOa31/tXiUcXI6jhtMQ7MP8o=;
 b=AQBRbsLQYqt3LM5/xEqzm8ZNCmjJdyPcHovb2ddOXYVjt/iJEZaTFdEpUimEScs6bEYGFWOrAv1poEh9FtMsktq4ggj10KeCUAIF+T2+A7joXGEexE1wjIOYSulfdUAOgAJeuTXM+Gk9+E7n+9xd/oRdDCv3B5OXTA0wle5sAhLFcDMC+hyFx4Kd6+o1WCzAYDpIKc9ZW44ebbfc/12jWUzXaucyczB5C+7KrcZKs7hvieCHuF9bBSRHLlAUEm8Ret8aae+3vYvcrCfO6tppxb8KtSP4ydANLQu6Iqjk+cSEpnA/rexcGDLr/OqAyXeQKITdrzL+/sL20mQPyMEB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SI6PR06MB7104.apcprd06.prod.outlook.com (2603:1096:4:247::10)
 by OSQPR06MB7973.apcprd06.prod.outlook.com (2603:1096:604:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 14:58:45 +0000
Received: from SI6PR06MB7104.apcprd06.prod.outlook.com
 ([fe80::dd63:8fb9:b9d8:2887]) by SI6PR06MB7104.apcprd06.prod.outlook.com
 ([fe80::dd63:8fb9:b9d8:2887%7]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 14:58:45 +0000
From: Jun Guo <Jun.Guo@cixtech.com>
To: Conor Dooley <conor@kernel.org>
CC: Peter Chen <peter.chen@cixtech.com>, Fugang Duan
	<fugang.duan@cixtech.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IHNwaTogc3Bp?=
 =?gb2312?B?LWNhZGVuY2U6IGRvY3VtZW50IG9wdGlvbmFsIGZpZm8td2lkdGggRFQgcHJv?=
 =?gb2312?Q?perty?=
Thread-Topic:
 =?gb2312?B?u9i4tDogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IHNwaTogc3BpLWNhZGVu?=
 =?gb2312?Q?ce:_document_optional_fifo-width_DT_property?=
Thread-Index: AQHcMd/HxJ4R705/TUewPHUL+nQ7pLSsEtIAgAE3OfqAABL1X4AAOtuAgALsUDo=
Date: Fri, 3 Oct 2025 14:58:45 +0000
Message-ID:
 <SI6PR06MB710489F8394133B846744D4BFFE4A@SI6PR06MB7104.apcprd06.prod.outlook.com>
References: <20250930075644.1665970-1-jun.guo@cixtech.com>
 <20250930075644.1665970-2-jun.guo@cixtech.com>
 <20250930-vocally-closable-136829bc9fed@spud>
 <SI6PR06MB7104F6012ADAFDBC7D553F9AFFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>
 <SI6PR06MB7104AE0345763471E67CD3C0FFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>
 <20251001-simple-conclude-d9cd153cee3c@spud>
In-Reply-To: <20251001-simple-conclude-d9cd153cee3c@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7104:EE_|OSQPR06MB7973:EE_
x-ms-office365-filtering-correlation-id: 258d8218-f0ec-43f4-8baa-08de028d59b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?c0luVmVFVHRMZkdRbGV2Rm1weDRvcENxOVZRSDRjaWZaZ2xwTGFnSEdxSnRK?=
 =?gb2312?B?UlMrbDQ1Y1Erai9hUCs5MFBOdStZNVA2c2RsQjRkVU5CYldBWXJnN01XVWR0?=
 =?gb2312?B?N2haQ3FBcW5KUjJMbmFzOFFocVQxRTFXMHJPcW5GYzA4QXZqUXFOeDlXeDVk?=
 =?gb2312?B?aTA3cml1SEkxeDM5S1NnWVJ0V0UzNUhMQm5LMHEvWklZV1NIMmdFc3FNeFMw?=
 =?gb2312?B?c3VJdkQ0Y0phTEVZV2FlMm1USW56Y0NRQ3IvV0NBVWVSaFcrc0VucHBGSmVO?=
 =?gb2312?B?amM5V1ZSRUNjVWMwbXJobUl3UWxlbjdtZzhJRUl5STJrRjBzTlhscjUvandi?=
 =?gb2312?B?Tk5PMng4eVM0WVJ5NjZrbWVtMGRiajdwTTdEaXhOTng5UFVOTDFzRW93UDZ3?=
 =?gb2312?B?U3hjQ2NiUVpDQkJSQmxodSs2UGE1NVVmekJrNEJiU3N4MUN3OCtndk5keUJx?=
 =?gb2312?B?MVZNSUUxOVpmQ3k1ZXRpTER3c1BVK0xHK1JYYzAzeVluNFMxTndLQXZWalIx?=
 =?gb2312?B?QXc1U2MwcFFoRVhNbWhOOTBsSUJLQjNJRDloMjIvcGw4Z2p6dk5rWjdWZDU2?=
 =?gb2312?B?Y2lyN2ErZDU3ckNrK2VkS0NaODh3QUFzeVloellEeVZZQ3hjR1JzME1Vam4x?=
 =?gb2312?B?OGVSeTFmS1R1VFJiQ0pwcVFaeUdGdDhtcFo4S01zT0hYYkJwMlpIQlJ3YTRz?=
 =?gb2312?B?UDd4U0lwUkpBSVp1bTFjSm1xYXFMSjZmenRoalkraXpMd0w0empYVE8wazF6?=
 =?gb2312?B?SWpkb0ZFUHBvbTJPcS93QWpyOFJuTlJaalVtVmJxd2lCbzJvS2Zpbms0ZXdJ?=
 =?gb2312?B?L1Q2a21ocWpmdndQcHgrcVE2TXJ3VUxGenJScFlvcW8vUGltcXhxd0lFWWFj?=
 =?gb2312?B?UDdGM0pNaDlVZlZjVkdvNkVYSFhJVWtSVjN6RzNScDNjVjBqVktqTldub2kr?=
 =?gb2312?B?NDFnL0NiTi9QUzZzMGYxVjl2dSt3ZjlnZjNqcTZBUjZMcy9WK1hJTnlVOWtx?=
 =?gb2312?B?ZjQyZTBUcGtJMUxzdS9mcXpxL0FqcUxCcHgzSTdXM0VudnpGV2JZRFQzaG9T?=
 =?gb2312?B?SE5neDhuay9EZ1A2STlaOGJIUkl2NDRNbVUxb0pDbFA1Qlh2dC9DV3JFT3Np?=
 =?gb2312?B?OS94enova1ZKV3F3UExyalduTHZ1a21rUXgrcDRzZmpXb250WWg0ZE9UZFhB?=
 =?gb2312?B?aUxVTkVHZjBCWjFRdzhRc3hYZEJ2WXp3WnNkQ2JRTkJPV1F6WC9IUmhyQU1n?=
 =?gb2312?B?ekJDRVdld0czWENEcXpESnNqQVFybFhuZ1F1Mytyb2x5ZjFqK005MXNEaUFI?=
 =?gb2312?B?eHdMRFhLOEExZEVJM0VSSEltUm83TThFK3VYbWZTUW5RRFgrVlI1b21KUEJ4?=
 =?gb2312?B?WGZFUHBmU1pPY2VQT3JMNU53SVJRdWRNTU5oRDZkbWxOVjFMNUdPZHJJVTE1?=
 =?gb2312?B?Z3VhWDVOOGs1SS9zYXNXSTk0WDBUUFoxNXVDN0pudUlPWDBQME5pR2FDc1lB?=
 =?gb2312?B?N0oyKzQ1ZmtmVmVkSTFBb3BIclpWRENoOE1HOXRMeHlBM1EvY2xzcTJnRU1W?=
 =?gb2312?B?OEpuT2dpdnRkZ3hmNW5RTTBOSXhMNWppSEt6QWRoNW5pQTZKTU4zTDNCS3lQ?=
 =?gb2312?B?MmpTRnRwRjVzN0VnU25qY3RRa3FEZEhQZ1BIQmlocTUvb20xTFJNOXpuNXlo?=
 =?gb2312?B?VmhkZ1dHMkZFcFEvVlJSeHNMNXRWNzJpTTcwUDg0dUZPbDZFYlk2VkdPdzdQ?=
 =?gb2312?B?Q0grRWU4SkUvMnNiRTVyd1lsWlNyWTM2UVFYcXlMcHRyWk1LU05FdTB0MjBY?=
 =?gb2312?B?ZXVLako0Q0FzcFkxRUI3Njd3SnQ0ZGZPS0l5VDAzQXNvWlgrWmt1NmFveFRL?=
 =?gb2312?B?NEd3SE4ydStOSHFpdWd4TGJ5aFgyeWJ3ODViUXFqQlpTcnlDUWhzS2dMeHBr?=
 =?gb2312?B?WGk0S3NweGo4L05ZL1JIZXEycHBXVDdnRDlsMldHQlluT2dMQit2NUw1aS9I?=
 =?gb2312?B?Tk03VWp6MHZlQ1V4eFVPWlRpbDZWVG9qazhSME10N3RKT3NqYVZRenNwUEh3?=
 =?gb2312?Q?lbO5X8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR06MB7104.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RHNFcFpGK1pFamU3Vit3b1RrdTVzU3R2WkJtNWFtUlFNSEtCZ01JY0J1aGtp?=
 =?gb2312?B?LzVrU2hyaG1jakI5cXQ5QVc5TzBjRTB3a2hsZlFXSkhuRlJhM1NjNmpQTzlY?=
 =?gb2312?B?ZE83bnpPSDJXZ3k0ZXJVWW01OGlRaXRvVVlQb2pGMFoza1M3QkltWnBEUWxk?=
 =?gb2312?B?NzdDKys3UEEzN29SMUtMQUpxa2ZuYlFnd0hXbXM1YS95UkhuQmZuNFFCZVlB?=
 =?gb2312?B?MFFGcmo5L0QvRjdwK0hCY25mWnlqM0x6eFFWYW0xdU1MT25rcUVTdFFockdM?=
 =?gb2312?B?bjlXMjV0YWZUZGpJQUxHT1J5ZG5vK3l3QldqSFQwVDlyakYyaWRvQlFtdlR0?=
 =?gb2312?B?ZHhDN2FlOVdKWll3V2pqUkpCZmNOZmJHaFRjeEVxcVNhLzI3UnM1MmUxZVhZ?=
 =?gb2312?B?K0g3RFRWWGpibCszcWF0blFidlR2dkJnV1BHTVJlTzFwN1liQ2FBMzVZNjlv?=
 =?gb2312?B?WHFSMGxOemo2T3ptT0tRM3JDaW8xNkwvUUg5L3NRbUVZNWVKQ2oyOTBqRXF3?=
 =?gb2312?B?dndSc1E0L1RGcjlHNDZJY1lsUkYrcXlNaUFvaVEyWTNMTWNWYXNxeEZIUnEw?=
 =?gb2312?B?SFBKbjVFWGhMUnNKSmM2bWdLQm1JSTJhakJsZkVJNG5VS0s0UGt5VTB2bjRD?=
 =?gb2312?B?VGRTWXVOQisxbkRYZ2hQczR0b09mRXpvT1Z0UzhBbzgvVGU4Rm85eUdTNFZW?=
 =?gb2312?B?cW5hMlUyV3EzSkorenNQL0hGV2Y4NlVoYTJ5YkFDeFVYckg3aHlEeHpGeUVG?=
 =?gb2312?B?RG5vdUMydGVHOG15UXFUNktMYTdNTEd6ZjJjZGgxb1c5aFJhbEEyWjBPSGpy?=
 =?gb2312?B?K2l4SW5LWEVrbWpLNVVkdXhvaTJMbWkyamlvTzhWRHZUYUY2alNRRWdkcUUx?=
 =?gb2312?B?MHVYMWpRQkN0ckxwd2h0NUNlYkpPeFdsOFFSYlJpYUd4MElDMk0vVlloQVRm?=
 =?gb2312?B?amViS0NwN1NLVnFWWUhNNStESDg1aHd3UzJYZjRLODdTTzl5dFVnNXBRMDJM?=
 =?gb2312?B?azZwS25ERHd5VmdvSlZwMXpWUDFJY0VmbmZ2Q1I4K081VDEvTkluakZjaE5q?=
 =?gb2312?B?bCt5K1p3QzJYZkl2N1NGbEsycU1jTDVia1E2djJjYmlCc0s4enBPNmRSbmRI?=
 =?gb2312?B?UjBSd0ZjRmRWc0ExMzRONXQxbm5aN1I3emRZUmV3ZWwxYnpyN2hDdmorbkJH?=
 =?gb2312?B?bWtpb3Rnd3A0bEtZL1ltN0NmRXhiVDhHQ005UFlxWXd2QktwL2JJcC9ob0p3?=
 =?gb2312?B?dDhkRSt6V2h6S3NPNFRZM2x2Z2NRTHBQODljNlhuOXpaN1FsMlZiWWMrelZX?=
 =?gb2312?B?dG1RS29vRCtuQS9ybnErTUNVaWpEODdUaWRUWDVENlhnVk84dzA3RlZHZzNZ?=
 =?gb2312?B?cVk0ZFdQWFZKZExkVWN3bXJvZTZwNXlNWTloQVM0NnN6ODNuOXFTYmtiMU8z?=
 =?gb2312?B?V0tlT3RoWGw3bUpXOUxSTW11NWlBZ2dGMnYrSlkzcVMxemxEL0NqL1o0Qytp?=
 =?gb2312?B?Q2JybHE3L2lyc2tuT0lnNE9LaFcvU2dWS3hMWnM4Q3pDUTFBYW0zbnpDWWxk?=
 =?gb2312?B?bElMNW1zb21tbGF4WWU0aDllZGc2T3NOTnFXQ1FzMnVKRE1VM28vSzhZaGUr?=
 =?gb2312?B?ZTBtNk5IV201OXhRa3NDc3A2Vm9oMjh4MmpFVkcxbm9LZnAycnlyU2xBOHNP?=
 =?gb2312?B?c2FmWFJ6K1RwdHJ2aUdrRHVkc2M4ZjliK1FiQXpKN2o1d3dsRG9TeUwxM2hP?=
 =?gb2312?B?dUozY3V6UlZPYzc2bDZsQXVpUEFYRlJmSVMrdTI5RjIraHUyUC9ValRNcGxx?=
 =?gb2312?B?d3YyQ3RZUUhscGNvTGNJdWNRZ21vam4vY3hDVFY4K3Jwbno2eUYxeWRpVmlN?=
 =?gb2312?B?ZjFGTnRjNHl0S3NxT3ZrVkU0dUEvQjRLY3ZVMjhwdUF3Y3hSTUE3US9FMmJn?=
 =?gb2312?B?amRSQVRLMkZTYkFqb1JoVWZDclBuNnBnRWZiNWFUQUZoYmUwTDFSck40Qm5P?=
 =?gb2312?B?djlYbWFwZjNKYUFpbjRKTXlUYVlwRmxEWE53WklHMEhjc29pVDNPUHgzWUtt?=
 =?gb2312?B?WFdzbUJFU1lVSmxsUmRpNUg0SC9CMXBpVEFzQ1Y3d0JLRDhJY0YzSmtYUkp5?=
 =?gb2312?Q?bMEo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7104.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258d8218-f0ec-43f4-8baa-08de028d59b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 14:58:45.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFuZK6HZvK5Nc8v6fR1xBvV+GIncyLuZDsU1IUYX7IyTIMgPSAGNtuM3ehgxzdnHBxlGwJKsSIIZQrrs4sUgFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7973

T24gVHVlLCBPY3QgMDIsIDIwMjUgYXQgMDI6MDQ6MDBBTSArMDAwMCwgQ29ub3IgRG9vbGV5IHdy
b3RlOg0KPiBPbiBXZWQsIE9jdCAwMSwgMjAyNSBhdCAwMjozNjo0NFBNICswMDAwLCBKdW4gR3Vv
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgT2N0IDAxLCAyMDI1IGF0IDAyOjUyOjAwQU0gKzA4MDAsIENv
bm9yIERvb2xleSB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgU2VwIDMwLCAyMDI1IGF0IDAzOjU2OjQy
UE0gKzA4MDAsIEp1biBHdW8gd3JvdGU6DQo+ID4gPiA+IEFkZCBkb2N1bWVudGF0aW9uIGZvciB0
aGUgb3B0aW9uYWwgJ2ZpZm8td2lkdGgnIGRldmljZSB0cmVlIHByb3BlcnR5DQo+ID4gPiA+IGZv
ciB0aGUgQ2FkZW5jZSBTUEkgY29udHJvbGxlci4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSnVuIEd1byA8anVuLmd1b0BjaXh0ZWNoLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNhZGVuY2UueWFtbCAgICAgICAgICB8
IDExICsrKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9zcGktY2FkZW5jZS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9zcGktY2FkZW5jZS55YW1sDQo+ID4gPiA+IGluZGV4IDhkZTk2YWJlOWRh
MS4uYjJlM2YyMTc0NzNiIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1jYWRlbmNlLnlhbWwNCj4gPiA+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY2FkZW5jZS55YW1sDQo+ID4gPiA+
IEBAIC02Miw2ICs2MiwxNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAgICAgIGl0ZW1zOg0KPiA+
ID4gPiAgICAgICAgLSBjb25zdDogc3BpDQo+ID4gPiA+DQo+ID4gPiA+ICsgIGZpZm8td2lkdGg6
DQo+ID4gPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiA+ID4gKyAgICAgIFRoaXMgcHJvcGVy
dHkgc3BlY2lmaWVzIHRoZSBGSUZPIGRhdGEgd2lkdGggKGluIGJpdHMpIG9mIHRoZSBoYXJkd2Fy
ZS4NCj4gPiA+ID4gKyAgICAgIEl0IG11c3QgYmUgY29uZmlndXJlZCBhY2NvcmRpbmcgdG8gdGhl
IGFjdHVhbCBGSUZPIHdpZHRoIHNldCBkdXJpbmcNCj4gPiA+ID4gKyAgICAgIHRoZSBJUCBkZXNp
Z24uIEZvciBpbnN0YW5jZSwgaWYgdGhlIGhhcmR3YXJlIEZJRk8gaXMgMzIgYml0cyB3aWRlLA0K
PiA+ID4gPiArICAgICAgdGhpcyBwcm9wZXJ0eSBzaG91bGQgYmUgc2V0IHRvIDMyLg0KPiA+ID4g
PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+
ID4gPiArICAgIG1pbmltdW06IDgNCj4gPiA+ID4gKyAgICBtYXhpbXVtOiAzMg0KPiA+ID4gPiAr
ICAgIGRlZmF1bHQ6IDgNCj4gPiA+DQo+ID4gPiBJIGFzc3VtZSB0aGlzIGRpZmZlcnMgZnJvbSBm
aWZvLWRlcHRoIGJlY2F1c2UgdGhpcyBpcyB0aGUgYWN0dWFsIHdpZHRoDQo+ID4gPiBvZiB0aGUg
cmVnaXN0ZXJzIHJhdGhlciB0aGFuIHRoZSBudW1iZXIgb2YgZWxlbWVudHMgb2YgdGhhdCB3aWR0
aCB0aGUNCj4gPiA+IEZJRk8gY2FuIGNvbnRhaW4/DQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlv
dXIgcmV2aWV3LiBZb3UgYXJlIGFic29sdXRlbHkgY29ycmVjdC4gVGhlIGBmaWZvLXdpZHRoYA0K
PiA+IGluZGVlZCByZWZlcnMgdG8gdGhlIHBoeXNpY2FsIHdpZHRoIG9mIHRoZSBGSUZPIGRhdGEg
cmVnaXN0ZXJzIChlLmcuLCA4LA0KPiA+IDE2LCBvciAzMiBiaXRzKSwgd2hlcmVhcyBgZmlmby1k
ZXB0aGAgZGVzY3JpYmVzIGhvdyBtYW55IGVsZW1lbnRzIG9mDQo+ID4gIHRoYXQgd2lkdGggdGhl
IEZJRk8gY2FuIHN0b3JlLg0KPiA+DQo+ID4gPiBIb3dldmVyLCB0aGlzIGlzbid0IHNvbWV0aGlu
ZyBkZWZpbmVkIGFzIGNvbW1vbiBpbiBzcGktY29udHJvbGxlci55YW1sDQo+ID4gPiBzbyB5b3Un
bGwgbmVlZCBhIHZlbmRvciBwcmVmaXggZm9yIHRoZSBwcm9wZXJ0eSBpZiB0aGUgcHJvcGVydHkg
c3RheXMuDQo+ID4gPiBUaGlzIGRvZXMsIGhvd2V2ZXIsIHNlZW0gbGlrZSBzb21ldGhpbmcgdGhh
dCBjYW4ganVzdCBiZSBkZXRlcm1pbmVkIGJ5DQo+ID4gPiB0aGUgY29tcGF0aWJsZSBhbmQgdGhh
dCB5b3VyIG9taXNzaW9uIG9mIGEgc29jLXNwZWNpZmljIG9uZSBpcyB3aGF0J3MNCj4gPiA+IGxl
YWQgeW91IHRvIGludHJvZHVjZSB0aGlzIHByb3BlcnR5LiBXaHkgbm90IGp1c3QgdXNlIGEgc2t5
MS1zcGVjaWZpYw0KPiA+ID4gY29tcGF0aWJsZSBoZXJlPw0KPiA+DQo+ID4gWW91IHJhaXNlIGFu
IGV4Y2VsbGVudCBwb2ludCwgYW5kIEkgaW5pdGlhbGx5IGhhZCB0aGUgc2FtZSB0aG91Z2h0LiBI
b3dldmVyLA0KPiA+IGFmdGVyIGZ1cnRoZXIgY29uc2lkZXJhdGlvbiwgSSByZWFsaXplZCB0aGF0
IHRoZSBJUCBvZiBDYWRlbmNlIFNQSSBhY3R1YWxseQ0KPiA+IHN1cHBvcnRzIGNvbmZpZ3VyYWJs
ZSBGSUZPIHdpZHRoIGFzIGEgZmVhdHVyZS4gVGhlIGNob2ljZSBvZiB1c2luZyA4LWJpdCwNCj4g
PiAxNi1iaXQsIG9yIDMyLWJpdCBGSUZPIHdpZHRoIGNhbiBiZSBtYWRlIGJ5IHRoZSBTb0MgaW50
ZWdyYXRvciBiYXNlZCBvbg0KPiA+IHRoZWlyIHNwZWNpZmljIHJlcXVpcmVtZW50cy4gVGhpcyBp
cyB0aGVyZWZvcmUgYSBmZWF0dXJlIG9mIHRoZSBDYWRlbmNlIElQDQo+ID4gaXRzZWxmLCByYXRo
ZXIgdGhhbiBhIGNoaXAgdmVuZG9yLXNwZWNpZmljIGRlc2lnbiBjb25zdHJhaW50Lg0KPiA+DQo+
ID4gRm9yIHRoaXMgcmVhc29uLCBJIGJlbGlldmUgZGVmaW5pbmcgYSBjb21tb24gYGZpZm8td2lk
dGhgIHByb3BlcnR5IGZvcg0KPiA+IENhZGVuY2UgU1BJIGNvbnRyb2xsZXJzIGlzIG1vcmUgYXBw
cm9wcmlhdGUsIGFzIGl0IGFsbG93cyBhbnkgU29DIHVzaW5nDQo+ID4gdGhpcyBJUCB3aXRoIGRp
ZmZlcmVudCBGSUZPIHdpZHRoIGNvbmZpZ3VyYXRpb25zIHRvIHV0aWxpemUgdGhpcyBwcm9wZXJ0
eSwNCj4gPiB3aXRob3V0IG5lZWRpbmcgdG8gY3JlYXRlIGEgc3BlY2lmaWMgY29tcGF0aWJsZSBz
dHJpbmcgZm9yIGVhY2ggU29DIHZhcmlhbnQuDQoNCj4gRXhjZXB0LCB5b3UgZG8gbmVlZCB0byBj
cmVhdGUgYSBzb2Mtc3BlY2lmaWMgY29tcGF0aWJsZSBzdHJpbmcgZm9yIGV2ZXJ5DQo+IGRldmlj
ZSwgdGhlIGZhY3QgdGhhdCB5b3UgZGlkbid0IGFkZCBvbmUgZm9yIHlvdXIgc2t5MSBTb0Mgd2Fz
IGEgbWlzdGFrZQ0KPiB0aGF0IHlvdSBzaG91bGQgZml4LiBTb0Mtc3BlY2lmaWMgY29tcGF0aWJs
ZXMgYXJlIGEgcmVxdWlyZW1lbnQuDQo+IFRoZSAiY25kcyxzcGktcjFwNiIgY29tcGF0aWJsZSBz
ZWVtcyB0byBiZSB1c2VkIG9uIFhpbGlueCBwbGF0Zm9ybXMsDQo+IGluY2x1ZGluZyBhIHp5bnEg
cGxhdGZvcm0gdGhhdCBzaG91bGQgcHJvYmFibHkgYmUgdXNpbmcgdGhlIHp5bnENCj4gc29jLXNw
ZWNpZmljIGNvbXBhdGlibGUuIHIxcDYgc291bmRzIGxpa2Ugc29tZSBzb3J0IG9mIHZlcnNpb24g
aW5mbywgaXMNCj4gdGhhdCB0aGUgdmVyc2lvbiB5b3UgYXJlIGV2ZW4gdXNpbmc/DQoNCj4gT25j
ZSB5b3UgaGF2ZSBhZGRlZCBhIGNvbXBhdGlibGUgZm9yIHRoZSBza3kxLCB0aGlzIHByb3BlcnR5
IGlzIG5vdA0KPiBuZWVkZWQsIHNpbmNlIHRoZSBkZXB0aCBjYW4gYmUgZGV0ZXJtaW5lZCBmcm9t
IHRoYXQuIEFueSBvdGhlciB1c2VyIHRoYXQNCj4gd2FudHMgdG8gdXNlIG5vbi1kZWZhdWx0IGRl
cHRocyBjYW4gYWxzbyB1c2UgdGhlaXIgc29jLXNwZWNpZmljDQo+IGNvbXBhdGlibGVzIGZvciB0
aGF0IHB1cnBvc2UuDQoNCkFmdGVyIGZ1cnRoZXIgY29uc2lkZXJhdGlvbiBhbmQgcmV2aWV3aW5n
IGhvdyBzaW1pbGFyIGNhc2VzIHdlcmUgcmVzb2x2ZWQNCmZvciBvdGhlciBJUHMsIEkgbm93IGJl
bGlldmUgeW91ciBhcHByb2FjaCBpcyBjb3JyZWN0LCBXZSBzaG91bGQgaW5kZWVkIGFkZA0KYSBj
aXgsc2t5MS14eHggY29tcGF0aWJsZSBzdHJpbmcgdG8gdGhpcyBZQU1MIGZpbGUgdG8gaW5kaWNh
dGUgdGhhdCBvdXIgU29DDQpzdXBwb3J0cyB0aGlzIElQLiBIb3dldmVyLCB0aGUgImZpZm8td2lk
dGgiIGlzIGluZGVlZCBhIGNvbmZpZ3VyYWJsZSBwcm9wZXJ0eQ0Kb2YgdGhlIElQIGl0c2VsZi4g
QnkgdXNpbmcgdGhlIERUU0kgYW5kIHRoZSBiaW5kaW5nIGRvY3VtZW50LCBvbmUgY2FuIHVuZGVy
c3RhbmQNCndoaWNoICJmaWZvLXdpZHRoIiB0aGUgU29DIHBsYXRmb3JtIHN1cHBvcnRzIHdpdGhv
dXQgbmVlZGluZyB0byBkZWx2ZSBpbnRvIHRoZQ0KY29kZS4gVGhpcyBpbXBsZW1lbnRhdGlvbiBp
cyBzaW1pbGFyIHRvIGV4aXN0aW5nIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBleGFtcGxlcw0KbGlr
ZSByZWctaW8td2lkdGgNCihEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFs
L3BsMDExLnlhbWwpDQphbmQNCnNucHMsaW5jci1idXJzdC10eXBlLWFkanVzdG1lbnQNCihEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy1jb21tb24ueWFtbCku
DQoNCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciB2YWx1YWJsZSB0aW1lIGFuZCBpbnNpZ2h0
ZnVsIHN1Z2dlc3Rpb25zLiBJIGxvb2sgZm9yd2FyZCB0bw0KPiA+IHlvdXIgZnVydGhlciBmZWVk
YmFjayBvbiB0aGlzIGFwcHJvYWNoLg0KDQpCZXN0IHdpc2hlcywNCkp1biBHdW8NCg0KDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogQ29ub3IgRG9v
bGV5IDxjb25vckBrZXJuZWwub3JnPg0Kt6LLzcqxvOQ6IDIwMjXE6jEw1MIyyNUgMjowNA0KytW8
/sjLOiBKdW4gR3VvDQqzrcvNOiBQZXRlciBDaGVuOyBGdWdhbmcgRHVhbjsgcm9iaEBrZXJuZWwu
b3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGJyb29uaWVAa2Vy
bmVsLm9yZzsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgbWljaGFsLnNpbWVrQGFtZC5jb207
IGNpeC1rZXJuZWwtdXBzdHJlYW07IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCtb3zOI6IFJlOiC72Li0OiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogc3BpOiBzcGktY2Fk
ZW5jZTogZG9jdW1lbnQgb3B0aW9uYWwgZmlmby13aWR0aCBEVCBwcm9wZXJ0eQ0KDQpFWFRFUk5B
TCBFTUFJTA0K

