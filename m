Return-Path: <linux-spi+bounces-11767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9476CA4A42
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 18:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BECD30572EF
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44AD2D5950;
	Thu,  4 Dec 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O7kjGltJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EA2D4816;
	Thu,  4 Dec 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867293; cv=fail; b=QL3tCLe6SBTenjE/xOX9wOTVdHpukoP+BmGqG15o6XVQrAEhQ2/ALrl2lSYjMpO5HHIj0lhVVsj+OBOgUfOgpvssNdDjydZADVX5j1wu4C6PoNQr4xREIow4IUcLSen7MIw2DAV1MPxodMZgtca1Zn+GBCeBz1zY6H+1maXmroE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867293; c=relaxed/simple;
	bh=p8tlHw0W4437Ef+ps0fhYw35xjzW4NCLf58KykE/+O8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgyphpytOoJkMTtZwGHUh5T4t31XEXqTyLMuosHwiWayTt9tyIiOKO3yhdTXJUeQFXP3/zhOLa6oDEHiwo6q7NWO/cZrov7HG3b+xmWEa5WbxlDCehRLFk3da0ogcwp78T/SWtxTACGW4bE4mpAjUcRFBhyUN381GV/B/UK8MsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O7kjGltJ; arc=fail smtp.client-ip=52.101.193.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ4P5UI7hfZQUGXrYlqaxGtAmJvFp4motHdAZBL1W6Exr/IdTuiluWS2H+17jKoXtf8LhqRDXSQ0uvrMorri8y2FQYW965cCBE3HOVDknQdc42yIkDpWDgiJLP1KsYIYHhDwik8b4ggo0Ink4M9zoIHVw5WCukiUS87POYPnLT6ksnTxF1WEegiVFc1LXUqzitBAGtZorMYu2jvd6BEIk/oCJti6hlevw3qvvkKMBktN0ZT8BNoyZ5+NBiw26aXx2LiRI0xOpNwULk6SDrm+oVRdv8LykCtCfJZADtqiBXD58QCL7DLkrRDTxhAiA2NguAA8PV/HPhoGeNRT6kB4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8tlHw0W4437Ef+ps0fhYw35xjzW4NCLf58KykE/+O8=;
 b=q5hP3v1752J+g0+aDFtqheeVX77JRTqddQajKE2IuryDmccH+kFJLiLPAKWW0lN4X+M7QTyJskFSEszTccfLddrv0OPiJz/sPcp3A02RKW0tHrBl9kVYclG22RIRJj71uUBqMNOxL8Pb2zl4vEi/brb/8YKX0CZP+pqaxW7osOHns8ENo1MzLWXbdEeZtMMNmd2DRPN/Q2eIM0wORvu3OZfubZYgE0474abTo1r/7K/C8MbXtPdRw1+BjfTzPkz34BvjnEXHSbipwtDgvD5WGfhwThunPM2yPlaDANsjdRcbOJTJDvw9HvlfLvXKDFMlter9tXLlUxEXi7NozHjYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8tlHw0W4437Ef+ps0fhYw35xjzW4NCLf58KykE/+O8=;
 b=O7kjGltJyBsXhmsBkWgaxe5OKt6cc07cQd+xxwAgPIZV9Dt/Kk1B5tyZWAmrzliHe6D8Fd824Vsjycmza+eTihhbtgmNLgTzVMZXbyEss9tCJqvMVwQTq9R2g2TIYU783nynDA05IAWOxSnhEC8pDi1keNMTYX4rUjHajn0b5lY=
Received: from BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 16:54:45 +0000
Received: from BN3PR12MB9570.namprd12.prod.outlook.com
 ([fe80::c06a:bf3e:9f41:39ed]) by BN3PR12MB9570.namprd12.prod.outlook.com
 ([fe80::c06a:bf3e:9f41:39ed%7]) with mapi id 15.20.9388.011; Thu, 4 Dec 2025
 16:54:44 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Santhosh Kumar K <s-k6@ti.com>, Pratyush Yadav <pratyush@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
	"mwalle@kernel.org" <mwalle@kernel.org>, "p-mantena@ti.com"
	<p-mantena@ti.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"a-dutta@ti.com" <a-dutta@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"praneeth@ti.com" <praneeth@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
Thread-Topic: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
Thread-Index: AQHcWJIfPZy0jZDLrEq3TNUR3/CsibUPpRkAgAIimiA=
Date: Thu, 4 Dec 2025 16:54:44 +0000
Message-ID:
 <BN3PR12MB95702234F0F9840C70E42C61DCA6A@BN3PR12MB9570.namprd12.prod.outlook.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <mafs0ikf74fja.fsf@kernel.org>
 <fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
In-Reply-To: <fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-04T16:38:29.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN3PR12MB9570:EE_|DS0PR12MB8344:EE_
x-ms-office365-filtering-correlation-id: b00e6a3f-0fb2-4d7a-58ad-08de3355d396
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ckxiaEkwZTVGZFJzSzcxeU1uTXFuVC9IRkRnMkQ4UU1weDEzK2l2SjFkbTlz?=
 =?utf-8?B?RVJCajdMZ3VrZ1EycllZYWZLR3FXMS9SSU9DakMzSkh5N29FM3pkYWtUZElC?=
 =?utf-8?B?a2tPWVdsam5CMDN4cUtYRmJsc210b3I4amRTWkJYWDcyaVpwUFJhVVhMNXhE?=
 =?utf-8?B?WUFWNFFYRXhnQmEvRnhKd0MxYlNkb1BpbVNITGdLSFRPWWVlc2ZPR2lrMVpr?=
 =?utf-8?B?eG8wU2RXY0JvR3lZenMrem9NNDNoVkhzUGl0S05mVFkrS1UzWGMyTTdQNDEv?=
 =?utf-8?B?bDlFKzRzSWkzN1V1WVlsM1FpSGZYK3prVzFRZEQxMy9mTDZoMmY1RVdwNEJr?=
 =?utf-8?B?aUxLdFpKbWRERzUxUWVvblQzdmk0Yms3bWIvZzJvQzNQbGN2K25rcnMybitM?=
 =?utf-8?B?V21pV1BKWkpPZ0VIRXZtQkNxZVhlbUJNM1BqQWJndUpPakdPd3J0cWx1bWJk?=
 =?utf-8?B?Z25mYU1id05DTlhRK001SlRSbDVIWm5QdjFCZG0wOVNESjR1cFBEazdWTWww?=
 =?utf-8?B?QjZtS0J4NU5BZVpqR0MwRytwbUp1UjBETHp1ajBsRWtSUUtKNEdGVkVnWDJQ?=
 =?utf-8?B?N05ocFFvRHEyUnRBdEtHVENVUTZmU0N3dWk5aXpza1ZVNnVpbllGWld5Ylhm?=
 =?utf-8?B?cUwvVTUvUkhnejNsMlRNRk45U09GeUtUa3FCalUzUkpuT3JJb0ZkbHljdmQ3?=
 =?utf-8?B?aE1KUGQwVGRQNXREYlg1ODNvRnVtN3hZczJoWFNiSHJWNmg5ZDJIMkFCakJU?=
 =?utf-8?B?NW5ObE93MG1HVDV2Q1dmUnJSU0VyM2Z4OGl6WU01c2hxeHpia29BTWQ0UHFS?=
 =?utf-8?B?R2REOU9YWUFCRHJpNVl6dHpYRHZrcnpsMWY5SnNwT0lBSnJZQVJ6SnFXOWVP?=
 =?utf-8?B?a0RtWVRSd0d3dFN1N0kyT2ZNdzFyZW1mQ09mRnh5a3oyYmRTKzBtd1hKZld0?=
 =?utf-8?B?MVg3ZzVBN1Z4aS95QnE2U2V2Y2N5NEROSHJhejI5a1owWE9BVktkaGhuYzlD?=
 =?utf-8?B?Z3BzVXcwWml6ZTkvMCtIbjcxbEJZbHNhaVlHcXc5NWRDQ0RPeHo0MTlMRFZr?=
 =?utf-8?B?MFV4c1oyN0h1STRYQ28zYmVNdnFjbnhRNytid3VFeGVlenhoL0Y4bWpvVzZW?=
 =?utf-8?B?L21YV3BERW1Wa25EN3h2dG44YjBrK2VnU3VTZjZnamh4OXBFSmsrcTRsenF0?=
 =?utf-8?B?WUh6b0RkRkxkWUdJVjY2YkcwRld1TkFHSHBES1Y2Yi91K2JLOTZybjZLUndV?=
 =?utf-8?B?L2NVSlltVXJDVjlzd1hjdWdIemlMUVpObUdkcEltUTRraDZTTzBFK0dDcm9t?=
 =?utf-8?B?aytCK3pWM1B4SUIyUDMxOStEYkVkMWdMYWpNV0Q2LzdHd2g4STdVMTJUOXhi?=
 =?utf-8?B?RFN4cWZ4QUpTTXpPb1lJVFVBTi8rczdiYVRiMUtONDRUNkVFUDhLVFZkdGVF?=
 =?utf-8?B?em9ERHJ2a3luVlN4WVhHZHE3ejV6S1FmOGdEQ2g2UXlweGpmMFZaUUZoYS9S?=
 =?utf-8?B?R1VQeFI0NDlPWGIzT2lWN25IMXZ6S21VWWZ3Z0dzNmlaTFpacHp4K3BheVk5?=
 =?utf-8?B?U2E0ZmlGNzlJVGdGbE9DMEhndEYweUpiVE1yZXQxcFM2MHlXcXo3ckNpTGJV?=
 =?utf-8?B?dGRmSlVndnZ3Zk52Z0t1VUtMbTc1eHYxUFVNRmZiQkNyN1ZVQVk4SUE4SktJ?=
 =?utf-8?B?bFZwQ1VoT3kzYmcycitYZW1RQW1JMFRBRlRRRXh2MlozUmVDd3hGMmovQUNF?=
 =?utf-8?B?b1M1WDNBRDVIQ3dJSE9kdGpFUk5qbjdnT2VNTGZlYmlCSEN1SFB1WTNSVzBO?=
 =?utf-8?B?cjV2V2lKbzNCQWh6WmpUN0t3ZCtMWTAxQ2t6ZVV3MkVYeGNiZ2lLTmpCWEYy?=
 =?utf-8?B?TFJCeE4xMldsQTFES0tOTlBWVFdLRG1CWVZ2R1M3TUdUb2V2dVZOc2V2bVFG?=
 =?utf-8?B?SWFZNm5TaWRYcEJtbklZbWY0ZW5qcmN0bit2bytodm9SK3IvOEpLZVROV3BB?=
 =?utf-8?B?YjVnc3V4R2hyV2ZOWFovZkYwT3N5MmpUYVdCaEFhRmVjeFFvWlZJQjh5MTRO?=
 =?utf-8?Q?sn9q5F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR12MB9570.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDArMFpOSitFL0RYN1VFU00vck9SVGpXSmtKVmdYMFJtN1UwWVN5U2ZhcU9n?=
 =?utf-8?B?Mk80TGgvL0VzdFF5Nk0rK3V4UnJoQUhaeExzdnFrVDJybFY1ZDdVcUgydWNw?=
 =?utf-8?B?NE1LTXF0cjNRK1dWK3UvWitqYmZndEJXNExsUE5FaW1Yay9nZE1vVDdqSndQ?=
 =?utf-8?B?VlBnZldtcXg2UGt5ZzAwSGpraTZrWUNtbUZXV0szVkQvbW81b3l5Yzd6MXdE?=
 =?utf-8?B?OWY4LzcxR0p2cFE2VjZZZXFJajJHK2MwU3VaQmlJMEt2dHI5SEc0QnJXUUh4?=
 =?utf-8?B?UEN2TnFnUzFCeFpVVkpoUUVqblRmc1FOUlNTOXFPV0hUN2s0dHhOUlRYN2Vk?=
 =?utf-8?B?aS9wQ0tlSTN1Ym4rWURtVUxBbmNjdXgyU3Q2YWVSNnZSQmdBVXdTbmtpbW5p?=
 =?utf-8?B?TVlmck9FbXBNOC9SSlI1Uk9FTmdqNU84K0NBZ3UwRjNOS0tlczZFTy9ZR3Ar?=
 =?utf-8?B?KzhMUDBvM1pQdTB4cjVxaFhCajBOTlROM3AxVnRBZml3ZVM4YnVjbjM5K1Ni?=
 =?utf-8?B?bmtkM2ZSYzlFODdmWDNjT3MwWGk0dDVHL0s2SEVueFdVeS9SRno2a3hhN3RL?=
 =?utf-8?B?SGNENEMrZ3Q5cytkZUlPQ1VNdGpPRDJDMmM1US82Ukg3Y2lvTE42T3FsRFM3?=
 =?utf-8?B?ekduY3ovdDFOdmY3amh5a2JDQVZnajczSDlZZUxFbzUyVUdyZ0hmSlJnSm5Y?=
 =?utf-8?B?REtsVUpoWTBYbjVRSk1RZi9UN0VGUmlaUlFnQTF5MTRreDV4UEJOdTFTc0ha?=
 =?utf-8?B?T2xpZi9paktOMHVuaEo3OXpjSmU0OEMzWVNGSVpHRlZkODlzeTBqRkZZOGl1?=
 =?utf-8?B?WkVrYU1KUk1OK0hjUnRiV1JuWkp4M2YrU2IvRXR6MnZFbmg5QldEd09KTGMx?=
 =?utf-8?B?MzBrb0tES1Q3bGFUNmgrM2JsSjZxTDZiWjNKZ0FnVHJiR24xUWRzWlZJVnpp?=
 =?utf-8?B?ZHhndkY3TmZDWTBYTDJYeHorZlJ5Mk5xNk1xQ053Yy9PVHVkREhva0JzazQ5?=
 =?utf-8?B?eVlSZDdXeFA5Z0JteVVDd0hRbEp6bk0zb1JrdWJSYnVLUWh5WHdlRjMvWk9I?=
 =?utf-8?B?WmtzWGwrcHhrVGxXc0RYVkJOdWZyY2NRYzcxdlA0ckt6dFpqMVpQZEVDcEk1?=
 =?utf-8?B?MXdPVXJ3V296eENadDNhOHIrem0xaFNNTWhzRGtxOU9mNUp1MUJLUmVTRitU?=
 =?utf-8?B?eDBodXZIWm1PYi8xbitjclpMbTluVVdjNTZvVWlPQTJFQUE5S2loMmJsbysw?=
 =?utf-8?B?Ukx3dlpIZFFMOUpQQkRoY0NoUktFamF6WmtQVjhEY3pzVVdMRWNNNTZHYTF2?=
 =?utf-8?B?VkZ4RVkxQkYwN01kajNIZUlTVU04dkoyd1VHMytQUmZQa1plTzdSWHhKSGFX?=
 =?utf-8?B?Y0hiYm1zelVWTm8xTEU1by94WU93OVFWM0hESE5wZjU5Wk1jbzBSRVVWaVNt?=
 =?utf-8?B?U2dUZ21nSUg3K1gydWhoRUh5S2c2Ykl2dE52L2JjdjBwazFGdU1lVjR6Q2Ro?=
 =?utf-8?B?OVJnWWJKQkY4RWx3aHNueVdNTUFIRkphUGtab2I1WG56bVlVdU84eXNQejhN?=
 =?utf-8?B?bDRnN0FRU2QwQnhzZ3ZYRzRSdHVjVlFJUzlrMTh6STdYZWtqR3cyWTAvNnZG?=
 =?utf-8?B?N1kyakxONktaV2w2WG9zNU94Y1BlZ0QxU0gzZ1pTUmVRYzNwbEhma21uTGxN?=
 =?utf-8?B?bS93RjlnL2JobXI1UEVabGxtOEo2Z25nbkdBSTh6MXRDYnVSTXJJUVpNOU5v?=
 =?utf-8?B?WkpFY1JTb3FNQVBjS0Y3bll0RjJIRmRhQ0pFMXlzenNlakF4UG5uZ2lVR3VC?=
 =?utf-8?B?RFJFWnI4ZElxN3ZjRkV5MHVJRUVBeGdlMVN4ekZjSlFtTFdrc0dMT2gxOThu?=
 =?utf-8?B?YlNrZ1VEVGNkYXU3YjQ3cW1YUVltejJrUDZSTUtzV1NvTWNMQnhpQnJFRGpv?=
 =?utf-8?B?MXFna2U1TGVXMFhmVWdEVGd5VGZsVXVoQUIrUGt3U0t3Y3grR1UzdENYM01W?=
 =?utf-8?B?aWIySzBzZkdTL3BMTE1RZFpJNU44dDdGUEdQWHBISmJFem83SG8zK1p1N21t?=
 =?utf-8?B?cWk0TWt5NFNOWHkwTDN0Sjl1NTBtTnFqdGtsZkpleG40cUNXekgwZHVmaXdS?=
 =?utf-8?Q?9qHU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN3PR12MB9570.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00e6a3f-0fb2-4d7a-58ad-08de3355d396
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 16:54:44.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYbMfCcIH4Z0lBAEhIPqZKVsrSrxbeHNYRHYbZxcaJ1x3B1nO7n4g9VQUkCgVADV0xkHaW5QDotRnI68Dtq/Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGVsbG8gU2FudG9zaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBTYW50aG9zaCBLdW1hciBLIDxzLWs2QHRpLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNl
bWJlciAzLCAyMDI1IDE6MzIgUE0NCj4gVG86IFByYXR5dXNoIFlhZGF2IDxwcmF0eXVzaEBrZXJu
ZWwub3JnPg0KPiBDYzogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47
IHJpY2hhcmRAbm9kLmF0OyB2aWduZXNockB0aS5jb207DQo+IGJyb29uaWVAa2VybmVsLm9yZzsg
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnOyBtd2FsbGVAa2VybmVsLm9yZzsgcC0NCj4gbWFudGVu
YUB0aS5jb207IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW10ZEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgYS1kdXR0YUB0aS5j
b207IHUta3VtYXIxQHRpLmNvbTsgcHJhbmVldGhAdGkuY29tOyBzLQ0KPiBrNkB0aS5jb20NCj4g
U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDEvMTBdIHNwaTogc3BpLW1lbTogSW50cm9kdWNlIHN1
cHBvcnQgZm9yIHR1bmluZw0KPiBjb250cm9sbGVyDQo+DQo+IEhlbGxvIFByYXR5dXNoLA0KPg0K
PiBPbiAxOC8xMS8yNSAxOToxOSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+ID4gT24gU2F0LCBT
ZXAgMjAgMjAyNSwgU2FudGhvc2ggS3VtYXIgSyB3cm90ZToNCj4gPg0KPiA+IFsuLi5dDQo+ID4+
PiBUaGlzIGlzIGFjdHVhbGx5IHdyb25nLiBUdW5pbmcgaXMgd2F5IG1vcmUgZ2VuZXJpYyB0aGFu
IHRoYXQgOikgSWYNCj4gPj4+IHNvbWVvbmUgd2FudHMgdG8gdXNlIGEgY2hpcCBhdCBhIGhpZ2gg
ZnJlcXVlbmN5ICg1ME1IeiBpbiB5b3VyIGNhc2UsDQo+ID4+PiBidXQgd2hhdGV2ZXIsIHRoZXJl
IGlzIGEgdGhyZXNob2xkIGFib3ZlIHdoaWNoIGFkZGl0aW9uYWwgY2FyZSBtdXN0DQo+ID4+PiBi
ZSB0YWtlbiksIGl0IG11c3QgZ28gdGhyb3VnaCB0aGUgY2FsaWJyYXRpb24gc3RlcC4gSXQgZG9l
cyBub3QNCj4gPj4+IG1hdHRlciBpbiB3aGljaCBtb2RlIHlvdSBhcmUuIENhbGlicmF0aW9uIHdv
dWxkIHN0aWxsIGJlIHJlbGV2YW50IGluDQo+ID4+PiBzaW5nbGUgU0RSIG1vZGUuDQo+ID4+PiBU
aGlzIDUwTUh6IGJvdGhlcmVkIE1hcmsgYmVjYXVzZSBpdCBpcyB0b28gQ2FkZW5jZSBzcGVjaWZp
Yy4gTWF5YmUNCj4gPj4+IHRoaXMgc2hvdWxkIGJlIGEgY29udHJvbGxlciBwYXJhbWV0ZXI/IElm
IHRoZSBzcGktbWVtIGNvcmUgKG9yIGV2ZW4NCj4gPj4+IHRoZSBzcGkgY29yZSwgYnkgZXh0ZW5z
aW5vKSBzZWVzIHRoYXQgdGhlIGRlc2lnbiBhbGxvd3MgcnVubmluZyBhdA0KPiA+Pj4gWE1IeiAo
ZHVlIHRvIHRoZSBTUEkgcGVyaXBoZXJhbCBwcm9wZXJ0aWVzIG9yIHNpbXBseSB0aGUgYWJzZW5j
ZSBvZg0KPiA+Pj4gYW55IGxpbWl0YXRpb24pLCBhbmQgaWYgdGhlIGNvbnRyb2xsZXIgc3RhdGVz
IHRoYXQgaXQgcmVxdWlyZXMgYW4NCj4gPj4+IGV4dHJhIHR1bmluZyBzdGVwIGFib3ZlIFlNSHog
KGFuZCBYID4gWSksIHRoZW4gaXQgbGF1bmNoZXMgdGhlIGNhbGlicmF0aW9uLg0KPiA+Pj4gICBG
cm9tIGEgY29yZSBwZXJzcGVjdGl2ZSwgSSB3b3VsZCBsaWtlIHRoZSBjYWxpYnJhdGlvbiBob29r
IHRvIGJlDQo+ID4+PiBhcyBzaW1wbGUgYXMgcG9zc2libGUsIGJlY2F1c2Ugd2hhdCAiY2FsaWJy
YXRpb24iIG1lYW5zIGlzIGhpZ2hseQ0KPiA+Pj4gY29udHJvbGxlciBhbmQgY2hpcCBzcGVjaWZp
Yy4NCj4gPj4NCj4gPj4gSSB1bmRlcnN0YW5kIHRoZSBjb25jZXJuIGhlcmUuDQo+ID4+DQo+ID4+
IExldCBtZSBwb2ludCBvdXQgdGhlIG9wdGlvbnMgZm9yIGxhdW5jaGluZyB0aGUgdHVuaW5nIHBy
b2NlZHVyZSwNCj4gPj4gYWxvbmcgd2l0aCB0aGUgaXNzdWVzIGluIGVhY2ggYXBwcm9hY2guDQo+
ID4+DQo+ID4+IE9wdGlvbiAxOiBMYXVuY2ggdHVuaW5nIGFzIHBhcnQgb2Ygc3BpX21lbV9leGVj
X29wKCkNCj4gPj4gICAgIC0gQWZ0ZXIgc3BpX21lbV9hY2Nlc3Nfc3RhcnQoKSwgaW50cm9kdWNl
IGENCj4gPj4gc3BpX21lbV9uZWVkc190dW5pbmcoKSBjaGVjayAoYSBuZXcgY2FsbGJhY2sgdG8g
U1BJIE1FTSBjb250cm9sbGVyKQ0KPiA+PiB0byBjaGVjayB3aGV0aGVyIHRoZSBjdXJyZW50IG9w
IHJlcXVpcmVzIHR1bmluZw0KPiA+PiAgICAgLSBJZiB5ZXMsIHdlIGNhbGwgc3BpX21lbV9leGVj
dXRlX3R1bmluZygpDQo+ID4+ICAgICAgICAgIC0gb24gc3VjY2VzcywgbWFyayB0dW5pbmcgY29t
cGxldGUgaW4gYSBmbGFnIHdpdGhpbiBTUEkgTUVNDQo+ID4+IENvbnRyb2xsZXIgcHJpdmF0ZSBk
YXRhDQo+ID4+ICAgICAgICAgIC0gb24gZmFpbHVyZSwgd2UgYXR0ZW1wdCBhIGZhbGxiYWNrIGJ5
IGNhbGxpbmcNCj4gPj4gc3BpX21lbV9hZGp1c3Rfb3BfZnJlcSgpIGFuZCBkcm9wIHRvIGEgbG93
ZXIgc3VwcG9ydGVkIGZyZXF1ZW5jeQ0KPiA+Pg0KPiA+PiBPcHRpb24gMjogTGF1bmNoIHR1bmlu
ZyB3aXRoaW4gc3BpX2NvbnRyb2xsZXItPmV4ZWNfb3AoKSBpbXBsZW1lbnRhdGlvbg0KPiA+PiAg
ICAgLSBWZXJ5IHNpbWlsYXIgdG8gb3B0aW9uIDEsIGV4Y2VwdCB0aGF0IHRoZQ0KPiA+PiBzcGlf
bWVtX2V4ZWN1dGVfdHVuaW5nKCkgaXMgdHJpZ2dlcmVkIGZyb20gd2l0aGluIHRoZSBjb250cm9s
bGVyJ3MNCj4gPj4gZXhlY19vcCgpIGltcGxlbWVudGF0aW9uIChubyBuZWVkIGZvciBzcGlfbWVt
X25lZWRzX3R1bmluZygpKQ0KPiA+Pg0KPiA+PiBEcmF3YmFja3MgaW4gb3B0aW9uIDEgYW5kIDI6
DQo+ID4+ICAgICAtIFR1bmluZyByZXF1aXJlcyBtdWx0aXBsZSByZWFkcyBvZiBhIGtub3duIHBh
dHRlcm4sIGJ1dCB0aGUNCj4gPj4gZmxhc2ggbWF5IG5vdCBhbHdheXMgYmUgaW4gYSBzdGF0ZSB0
byBhbGxvdyByZWFkIGNvbW1hbmRzDQo+ID4+ICAgICAtIE5vIGZhbGxiYWNrIG9uIGZhaWx1cmVz
LCBjYW4ndCBtYWtlIGZsYXNoLXNwZWNpZmljIGFkanVzdG1lbnRzDQo+ID4+IGluIGNhc2Ugb2Yg
YSB0dW5pbmcgZmFpbHVyZQ0KPiA+PiAgICAgLSBObyBhY2Nlc3MgdG8gd3JpdGVfb3AoKSB0byB3
cml0ZSBrbm93biBwYXR0ZXJuIHRlbXBvcmFyaWx5IHRvDQo+ID4+IGFuIG9uLWRpZSBjYWNoZS4g
UGF0dGVybiBuZWVkcyB0byBiZSBhbHdheXMgYnVybnQgaW50byB0aGUgZmxhc2gNCj4gPj4NCj4g
Pj4gICAgIC0gUGx1cywgaW4gb3B0aW9uIDIgLSB3ZSBjYW4ndCBjYWxsIHNwaV9tZW1fYWRqdXN0
X29wX2ZyZXEoKQ0KPiA+Pg0KPiA+PiBXaGlsZSB0aGUgbmVlZCBmb3IgdHVuaW5nIGlzIGRpY3Rh
dGVkIGJ5IENvbnRyb2xsZXIgc3BlY2lmaWMNCj4gPj4gY2hhcmFjdGVyaXN0aWNzIHRoZSBvcHMg
KGFuZCBzdGF0ZSBvZiB0aGUgY2hpcCkgcmVxdWlyZWQgdG8gY29tcGxldGUNCj4gPj4gdHVuaW5n
IGlzIHVuZGVyIHRoZSBjb250cm9sIG9mIHNwaS1tZW0gdXNlcnMgKHNwaS1uYW5kL3NwaS1ub3Ip
Lg0KPiA+PiBTbywgaXQncyBpbXBvc3NpYmxlIHRvIGFjaGlldmUgdHVuaW5nIHdpdGhvdXQgdGhl
IGhlbHAgb2Ygc3BpLW1lbSB1c2Vycy4NCj4gPj4NCj4gPj4gU28sIE9wdGlvbiAzOiBMYXVuY2gg
ZnJvbSBTUEkgTUVNIGNsaWVudHMNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgKG10
ZC9uYW5kL3NwaSBvciBtdGQvc3BpLW5vciwgZXRjLiwpDQo+ID4+ICAgICAtIE9uY2UgdGhlIHNw
aS1tZW0gY2hpcCBpcyBjb21wbGV0ZWx5IGVudW1lcmF0ZWQgYW5kIGJlc3QgcmVhZA0KPiA+PiBh
bmQgd3JpdGUgb3BzIGFyZSBjaG9zZW4gY2FsbCBzcGlfbWVtX25lZWRzX3R1bmluZyhyZWFkX29w
LCB3cml0ZV9vcCkNCj4gPj4gYXMgYSBwYXJ0IG9mIC5wcm9iZSgpDQo+ID4+ICAgICAtIElmIHR1
bmluZyBpcyByZXF1aXJlZCwgY2FsbA0KPiA+PiBzcGlfbWVtX2V4ZWN1dGVfdHVuaW5nKHJlYWRf
b3AsIHdyaXRlX29wKQ0KPiA+PiAgICAgICAgICAtIElmIG9ubHkgcmVhZF9vcCBpcyBwcm92aWRl
ZCwgaXQgaW1wbGllcyB0aGUgdHVuaW5nIHBhdHRlcm4NCj4gPj4gaXMgcHJlLWZsYXNoZWQgdG8g
dGhlIHBhcnRpdGlvbg0KPiA+PiAgICAgLSBPbiB0dW5pbmcgZmFpbHVyZSwgcmV0cnkgYnkgcmUt
cnVubmluZyBzcGlfbWVtX25lZWRzX3R1bmluZygpDQo+ID4+IHdpdGggdGhlIHNlY29uZCBiZXN0
IHNldCBvZiBvcHMgKG1heCB0aHJvdWdocHV0IC0gMSkNCj4gPj4NCj4gPj4gV2l0aCBvcHRpb24g
Mywgc3BpX21lbSB1c2VycyBhcmUgbGltaXRlZCB0byBjYWxsaW5nDQo+ID4+IHNwaV9tZW1fbmVl
ZHNfdHVuaW5nKCkgYW5kIHNwaV9tZW1fZXhlY3V0ZV90dW5pbmcoKS4gUmVzdCBpcyBoaWRkZW4N
Cj4gPj4gd2l0aGluIHRoZSBjb250cm9sbGVyIGRyaXZlcnMuIElmIHNwaS1tZW0gdXNlcnMgY2hh
bmdlIHJlYWQvd3JpdGUNCj4gPj4gb3BzLCB0aGUgYWJvdmUgc2VxdWVuY2UgY2FuIGJlIHJlLWlz
c3VlZC4NCj4gPj4NCj4gPj4gVGhlIGNvbnRyb2xsZXIgY2FuIHN0b3JlIHRoZSByZWFkX29wIGFu
ZCB3cml0ZV9vcCBpbiBjYXNlIG9mIGEgdHVuaW5nDQo+ID4+IHN1Y2Nlc3MgYW5kIHBlcmlvZGlj
YWxseSByZS1ydW4gdHVuaW5nLCBlbnN1cmluZyB3ZSBhbHdheXMgaGF2ZSB2YWxpZA0KPiA+PiB0
dW5pbmcgcGFyYW1ldGVycy4NCj4gPj4NCj4gPj4gT25lIGNvbmNlcm4gd2l0aCBvcHRpb24gMyBp
cyB0aGF0IHdlIG1heSBub3QgYmUgYWJsZSB0byBtYWtlIHVzZSBvZg0KPiA+PiBzdGF0aWMgZGF0
YSBvbiBjZXJ0YWluIGZsYXNoIGFzIHR1bmluZyBwYXR0ZXJucyAobGlrZSByZWFkaW5nDQo+ID4+
IHBhcmFtZXRlciBwYWdlIG9yIFNGRFAgdGFibGUgZm9yIHR1bmluZyBpbnN0ZWFkIG9mIGNvbnRy
b2xsZXINCj4gPj4gc3BlY2lmaWMgYXR0YWNrIHBhdHRlcm5zKS4NCj4gPg0KPiA+IFdoeSBub3Q/
IEhvdyBlbHNlIHdvdWxkIHR1bmluZyB3b3JrPyBEbyB5b3UgZXhwZWN0IGNvbnRyb2xsZXJzIHRv
DQo+ID4gZmlyc3QgZmxhc2ggdGhlIHR1bmluZyBwYXR0ZXJuIGFuZCB0aGVuIHR1bmUgdGhlIHJl
YWRzPyBUaGF0IGlzIGEgaGFyZA0KPiA+IG5vIEkgdGhpbmssIHNpbmNlIHlvdSBkb24ndCB3YW50
IHRvIG92ZXItd3JpdGUgdXNlciBkYXRhIGFuZCBJIGRvbid0DQo+ID4gdGhpbmsgd2Ugd2lsbCBl
dmVyIGhhdmUgYW55IGFyZWEgb2YgbWVtb3J5IHdlIGNhbiByZWxpYWJseSBvdmVyLXdyaXRlDQo+
ID4gd2l0aG91dCByaXNraW5nIHRoYXQuDQo+ID4NCj4gPiBJIHRoaW5rIHdlIHNob3VsZCBzdGFy
dCB3aXRoIHRoZSByZXF1aXJlbWVudCB0byBoYXZlIHRoZSBwYXR0ZXJuDQo+ID4gZmxhc2hlZCBh
bHJlYWR5IGFuZCBmaWd1cmUgb3V0IGhvdyBTUEkgTk9SIG9yIFNQSSBOQU5EIGNhbiBkaXNjb3Zl
cg0KPiA+IHRoYXQgKHBlcmhhcHMgdmlhIE5WTUVNPykuDQo+DQo+IEkgYWdyZWUgLSBoYXZpbmcg
dGhlIGNvbnRyb2xsZXIgb3ZlcndyaXRlIHVzZXIgZGF0YSBpcyBhIGhhcmQgbm8hDQo+DQo+IEZv
ciBTUEkgTkFORCwgYSBwcm9ncmFtIG9wZXJhdGlvbiBoYXBwZW5zIGluIHR3byBzdGVwczogZGF0
YSBpcyBmaXJzdCBjb3BpZWQgaW50bw0KPiB0aGUgaW50ZXJuYWwgY2FjaGUsIGFuZCBvbmx5IHRo
ZW4gd3JpdHRlbiB0byB0aGUgZmxhc2ggZHVyaW5nIHRoZSBwcm9ncmFtLWV4ZWN1dGUNCj4gcGhh
c2UuIFRoaXMgaXMgd2h5IHRoZSB0dW5pbmcgZmxvdyB3cml0ZXMgdGhlIHBhdHRlcm4gb25seSB0
byB0aGUgZGV2aWNlJ3MgaW50ZXJuYWwNCj4gY2FjaGUgYW5kIHJlYWRzIGl0IGJhY2sgaXQgZnJv
bSB0aGVyZS4gVGhpcyBhdm9pZHMgdG91Y2hpbmcgYW55IHVzZXIgZGF0YSBvbiB0aGUNCj4gZmxh
c2ggYW5kIGlzIGFscmVhZHkgaW1wbGVtZW50ZWQgaW4gdjIgKHdoaWNoIEknbGwgcG9zdCBzaG9y
dGx5KS4NCj4NCj4gRm9yIFNQSSBOT1IsIHdlIGRvIG5vdCBoYXZlIGFuIGVxdWl2YWxlbnQgIndy
aXRlLXRvLWNhY2hlIiBwb3NzaWJsZSwgc28gd2Ugc3RpbGwNCj4gcmVxdWlyZSBhIHByZS1mbGFz
aGVkIHBhdHRlcm4gcmVnaW9uLiBBdCB0aGUgbW9tZW50IHRoaXMgaXMgcHJvdmlkZWQgdmlhIGEg
ZGVkaWNhdGVkDQo+ICJwaHlwYXR0ZXJuIiBwYXJ0aXRpb24sIGFuZCBpdHMgb2Zmc2V0IGlzIG9i
dGFpbmVkIHRocm91Z2ggdGhlIG9mX2dldF8qIEFQSXMuDQoNCkkgd2FzIHdvbmRlcmluZywgZm9y
IFNQSS1OT1IgZGV2aWNlcywgd2h5IGNhbuKAmXQgd2UgdXNlIHRoZSAicGh5cGF0dGVybiINCnBh
cnRpdGlvbiB0byB3cml0ZSB0aGUgcGF0dGVybiBhbmQgdGhlbiByZWFkIGl0IGJhY2sgZHVyaW5n
IHR1bmluZz8gU2luY2UgdGhlIHVzZXINCndvdWxkIG5lZWQgdG8gZGVmaW5lIGEgc3BlY2lmaWMg
cGFydGl0aW9uIG5hbWUgKGkuZS4sIHBoeXBhdHRlcm4pIHRvIGluaXRpYXRlIHR1bmluZywNCnRo
YXQgcGFydGl0aW9uIGNvdWxkIGFsc28gYmUgcmVzZXJ2ZWQgZm9yIHR1bmluZyBwdXJwb3Nlcy4g
UGxlYXNlIGxldCBtZSBrbm93DQp5b3VyIHRob3VnaHRzIG9uIHRoaXMuDQoNClJlZ2FyZHMsDQpB
bWl0DQo+DQo+IFJlZ2FyZGluZyB3YXlzIHRvIGxvY2F0ZSB0aGUgcGFydGl0aW9uOg0KPg0KPiAx
LiBVc2luZyBOVk1FTToNCj4gICAgIGEuIEV4cG9zaW5nIHRoZSBwaHlwYXR0ZXJuIHBhcnRpdGlv
biBhcyBhbiBOVk1FTSBjZWxsIGFuZCBpc3N1aW5nIGFuDQo+ICAgICAgICBOVk1FTSByZWFkIGR1
cmluZyB0dW5pbmcgZG9lcyBub3Qgd29yayByZWxpYWJseSwgYmVjYXVzZSBOVk1FTQ0KPiAgICAg
ICAgZW5kcyB1cCBjYWxsaW5nIGludG8gdGhlIE1URCByZWFkIHBhdGggYW5kIHdlIGNhbm5vdCBj
b250cm9sIHdoaWNoDQo+ICAgICAgICByZWFkX29wIHZhcmlhbnQgaXMgdXNlZCBmb3IgdGhlIHJl
YWQuDQo+DQo+ICAgICBiLiBBZHZlcnRpc2luZyB0aGUgcGFydGl0aW9uIGFzIGFuIE5WTUVNIGNl
bGwgYW5kIHVzaW5nIE5WTUVNIG9ubHkNCj4gICAgICAgIHRvIGZldGNoIHRoZSBvZmZzZXQgaXMg
bm90IHBvc3NpYmxlIGVpdGhlci4gTlZNRU0gYWJzdHJhY3RzIHRoZQ0KPiAgICAgICAgcHJpdmF0
ZSBkYXRhLCBpbmNsdWRpbmcgcGFydGl0aW9uIG9mZnNldHMsIHNvIHdlIGNhbid0IHJldHJpZXZl
DQo+ICAgICAgICB0aGUgb2Zmc2V0IGFzIHdlbGwuDQo+DQo+IDIuIFVzaW5nIG9mX2dldF8qIEFQ
SXM6DQo+ICAgICAgICBVc2luZyB0aGUgc3RhbmRhcmQgT0YgaGVscGVycyB0byBsb2NhdGUgdGhl
IHBoeXBhdHRlcm4gcGFydGl0aW9uDQo+ICAgICAgICBhbmQgcmV0cmlldmUgaXRzIG9mZnNldCBp
cyBib3RoIHJlbGlhYmxlIGFuZCBzdHJhaWdoZm9yd2FyZCwgYW5kDQo+ICAgICAgICBpcyB0aGUg
YXBwcm9hY2ggY3VycmVudGx5IGltcGxlbWVudGVkIGluIHYyLg0KPg0KPiA+DQo+ID4gSSB0aGlu
ayBTRkRQIGlzIHF1aXRlIG5pY2UgZm9yIHRoaXMsIGJ1dCBJSVJDIGZvcg0KPiA+IHNwaS1jYW5k
ZW5jZS1xdWFkc3BpLCB0aGF0IHdhcyBub3QgYSB2aWFibGUgb3B0aW9uIGR1ZSB0byBzb21lDQo+
ID4gcmVhc29ucy4gSWYgeW91IGNhbiBub3cgbWFrZSBpdCB3b3JrIHdpdGggU0ZEUCwgdGhlbiB0
aGF0IHdvdWxkIGJlDQo+ID4gZXZlbiBiZXR0ZXIsIHNpbmNlIHdlIGRvbid0IGhhdmUgdG8gZGVh
bCB3aXRoIHRoZSBwYWluIG9mIHByZS1mbGFzaGluZy4NCj4NCj4gVGhlIGN1cnJlbnQgdHVuaW5n
IGZsb3cgcmVxdWlyZXMgYSBzcGVjaWZpYyBzdHJlc3MgcGF0dGVybiB0byBlbnN1cmUgcm9idXN0
bmVzcywgYW5kDQo+IHRoZSBTRkRQIGRhdGEgYXJlbid0IGdvb2QgZW5vdWdoIGZvciBpdC4NCj4N
Cj4gPg0KPiA+IE92ZXJhbGwsIEkgdGhpbmsgb3B0aW9uIDMgaXMgdGhlIG1vc3QgcHJvbWlzaW5n
LiBPcHRpb25zIDEgYW5kIDIgd2lsbA0KPiA+IGxpa2VseSBhZGQgc28gbXVjaCBvdmVyaGVhZCB0
aGV5IHdpbGwgZW5kIHVwIGJlaW5nIHNsb3dlciB0aGFuIG5vbi1QSFkNCj4gPiByZWFkcywgc2lu
Y2UgdHVuaW5nIGlzIHVzdWFsbHkgcXVpdGUgZXhwZW5zaXZlLg0KPg0KPiBUaGFua3MsDQo+IFNh
bnRob3NoLg0KPg0KPiA+DQo+ID4+DQo+ID4+IFBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHRob3Vn
aHRzIG9uIHdoaWNoIG9mIHRoZXNlIGRpcmVjdGlvbnMgbWFrZXMNCj4gPj4gdGhlIG1vc3Qgc2Vu
c2UuDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4gU2FudGhvc2guDQo+ID4+DQo+ID4NCj4NCg0K

