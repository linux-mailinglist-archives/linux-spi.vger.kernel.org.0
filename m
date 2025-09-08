Return-Path: <linux-spi+bounces-9928-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676DDB48304
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 05:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD1217BD51
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 03:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A89020CCDC;
	Mon,  8 Sep 2025 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cgG7+4Ay"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA83FE5F;
	Mon,  8 Sep 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757303471; cv=fail; b=tpBMu4Zy5n11S3rXNPmf5DP5IFBexpTCLoM7k+Qjzy3VbKlThVdqQDSW4GAUtM4mxZfEmpaLFRd2NJP5z4Spmare8zu3aZTIFYld0MnLz+DkQKQtfPEKC7z0BUzrrcOpo4Spv8ZDALUHRPYyZBCI4GGXOoadw7BbnCKGlsc7Ifw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757303471; c=relaxed/simple;
	bh=Jh+hgj4NBgcN5l2wP3K0nubyfJaGnTA1BzYrKH0g5v4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Knst1AT2E5TG9IL3TiP+8pUzDdu9B0vCBxLxnCorJ18TNsw8xm+hE3kaugdVeNtvA6p9HvAu0zw4Bsz1E+HqFgE5LZTuhQTktgxhgLbA9fFUMB7MYZD3F/BAFZVoHR2Owr+VinHd2IC0I1HzfKdKCAQkrTzECNkEZkGI4CTU5XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cgG7+4Ay; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvPl99Yi8TNo14hy6Q4B0YbLa3xJmIBRex5o1cabL2EzThpNfID/fbblH9DAorOhlvohGgiSdxkAInIz1NBWRA7o7mYJWcKGkkH8cJGz1KI5Y14MaXJsEDn+X8KvfYY3ld47SKXs+qCSmnQQyJqcj8f4NZsuQIT/xSiNH+CGgmUaauxxeXN4ViVZyEqJ8eg/AYJwbc69+cyiJu0T/yfS0ysp2XgVsv+O/eu/iA09vMcMlwWrEPVj1ADKNCJz7RVzXkCqvQ47s54Cxh0jFd/Y2PC5iQyM1FI7FPW6v+4QPFTwQwqKu52zGloyqlywDJlgZ7uJWD5d/XpRfDjdDjW2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh+hgj4NBgcN5l2wP3K0nubyfJaGnTA1BzYrKH0g5v4=;
 b=y9C2YB1Adi2Y5lrK4MGwhHGl9EJMotjBIp2izMroZXf0ZMLnagRSC5vtOhcpx56TTCykZWBpMuGGKWOJ8394P2M7x9iryDyJ6+KPoLhBAgrZyqvslAMSCCgCMGi/AhY+XQ4l41dO0xEZ5AvrrH68RFxNpSMman1WQueH3myAUIc0JAzGUVWDzuc16He+Sa3zEQcmjtCnBs6B35Un+7gVE40BA8ptE3pd8rOP8EZ8GyTHQSgWRXjRYhKR9kKQho4zVUHXyloIXCUEdPOMcjOrjWKH7Ca0oFjJubkG0lwOdPXPALw0FKUBjANOoPeuRVgBim2XJKy2ofrMdY5uqfH+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh+hgj4NBgcN5l2wP3K0nubyfJaGnTA1BzYrKH0g5v4=;
 b=cgG7+4AyA1gpCceNM/5JQfxXkE7e7emZjSR0Tyq/Zgaf11yGy22VlGNn88LCnEpmHkTffo6KI0JLXy5vulN/Tjl/qwldwHLTkAVzuq4y+uTmKiNDMtvSDnEqRuuj0r1f+Sv7OYVUrR2Cm0lQHDimcjGpzS+10tD2zIYIWKkjMdFEFtNWjmPWTEzsrMcT4/zN/GG6eZPZ60nPNLQybRsZm5aTi3gZZlTH9V7Ysadd9/4rueDXu0Uqrd0FWWnctWdq5+FcEMGAdnpsJYShcOkuYXJqoEZuN76/8t+2NzUD0lKvZ+5fPe5pfa5/j0xDU9frmcfZh12KQLWwcOLdmHxtUQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by IA3PR11MB9064.namprd11.prod.outlook.com (2603:10b6:208:57f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 03:51:05 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%2]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 03:51:05 +0000
From: <Dharma.B@microchip.com>
To: <krzk@kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<tudor.ambarus@linaro.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] spi: atmel,quadspi: Document sam9x7 QSPI
Thread-Topic: [PATCH 1/5] spi: atmel,quadspi: Document sam9x7 QSPI
Thread-Index: AQHcG83VB9LmjLEhZku8WJRHpUcCBrR/noIAgAkRfQA=
Date: Mon, 8 Sep 2025 03:51:05 +0000
Message-ID: <a9968230-33af-432a-a5da-3d40b6f5d85a@microchip.com>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
 <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>
 <20250902-bulky-chachalaca-of-superiority-d5caaf@kuoka>
In-Reply-To: <20250902-bulky-chachalaca-of-superiority-d5caaf@kuoka>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|IA3PR11MB9064:EE_
x-ms-office365-filtering-correlation-id: 2ae0b359-26e5-45b4-22e2-08ddee8aefe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkZ1Wng0R0FBMk9ZS1RqTjU0QTQwVy80MGtTbmNmd3NSMlBOOE04bG9KeHVN?=
 =?utf-8?B?Ny9jSjJJUEduejU4aXM5T1ZONU9DNEtmem5CTkowMFV4dVIvV01XMkNieUxn?=
 =?utf-8?B?YjZoTEplSm9BOTlPUkxCT1cySWpsaTJNTi8xTVlvczJZMzgrRVorK3VDWEF0?=
 =?utf-8?B?ZnlIZnBxMTVNL1ZjUDRnMmRnOVAvdXdSNW1JNkZseEpvaXFFRFFJcXdKWlla?=
 =?utf-8?B?TVhmeTJvOE9FN0l6cEV5ZHBDZ1ZpRit1ellYOTdUa2NFNTREUlJvbEltelQy?=
 =?utf-8?B?ZkhhYURzTU9ONmNnajlEQUdPK20rMDJ5R3NxRmVQRk9FNDBzREV5bjdnc05s?=
 =?utf-8?B?cEFXRWRHQ2tkRTBPMkpTdmZteGVkRGRJa3FuUkZ2VGJYakpwd24rcFlTVkhO?=
 =?utf-8?B?OVIzTWwzSGl4SlR4Rk8rbjFmc1Vya1ptRW8xcnh6ME9mbG5nWHd1d29BaEhS?=
 =?utf-8?B?R3I0amRaYXYwOFppTjJKbmo3Q3BvMThGb2NOUUg4N1U1cTl4cXNLMUhPdTlB?=
 =?utf-8?B?R0Nvc0QvMUhJc1BXZVorT0xVbkVycVRacU5weWtzQXh4RXMrd3J5dzlSOS9y?=
 =?utf-8?B?b0JmSjVHSmllblR3aUtkOWQrbGtmUzlGb0VWdzFEd1hRMFh2QkIwWWtTZHVx?=
 =?utf-8?B?R04zUG9RQzZseXpyQ2REMmk3UVA4UVdZclk0bkpZRUNhbHhKeURVUmNYOHF0?=
 =?utf-8?B?NFNXVlFFczJOVnhYUjYwR2ZmQUZoaGgxODFjaUYxK2RkTWpvWmVlekRNYVRN?=
 =?utf-8?B?ZnNyM2RHV0xPMVlLL0puMCtBY1VPM0s3am5qKzNuVlpIeGx2dnNic0ZHaWdK?=
 =?utf-8?B?MjVzU0hlc2t3R25qMWU5N3Z6anZtcVg2cjFYR0R0V0FCcnRiWkNqSlNlcVZz?=
 =?utf-8?B?WGp4eUdiM1ZJUVpaeEZSMEpWYm91UVpwSjhpSEZnNjV0UlhIaUdJa0grUlk5?=
 =?utf-8?B?QndJNm9URGZGVm1rME13RDZNUXo5ck5zb0ZqdVVJcE04YWRMV2IyTndvOHRw?=
 =?utf-8?B?TGk2aytYdTJTaU9zS3dqZHAzdzVjVFZUSHBDY1BKNXhSODZST3RsYm9YMkZo?=
 =?utf-8?B?ZG85aTBtLytWbDdRK2M4dWl5MDBCRXhiS1Q5YUpQVS9iNjJkVUNrRTdON3RN?=
 =?utf-8?B?NjVrV2FNMEZzcDdtVDNZOUJLU213VmNFUE43Z3FkcCtVaVkwa21NZVcyM1JZ?=
 =?utf-8?B?djludU9KVDQzNzVoNWk5TDI0TXJCU2lwVnIxUzc5YWRuaDNiNFZ4cjJjV1Vl?=
 =?utf-8?B?RDdMcllPM2xhbFpXS0FVQnZ3MS80c1IzRTlkWnIrN1dTRDJzNzdJYjN5QXV6?=
 =?utf-8?B?am0rZHZpbElmWlJlaFJRaS84Q3FrOWgxSHJHdER4dUhIMXZvcXdFWFduUGY4?=
 =?utf-8?B?TVp5YWNURHJNUnZpV2FRNjhyU0NCRE9XVHc4NlcxcHVSTDROT1BMRVZTNUti?=
 =?utf-8?B?TVcyRmZyVGgyYmxUOTVVWnJreXFicG9oZjU4T3RwYmZnZjhETFd3L1VqS0V5?=
 =?utf-8?B?RzliN0pOZCtiUDRDYVhhZStBWisrZDNNcU84bDZ6aVozWk9XMjFaMHozN0VO?=
 =?utf-8?B?RlJDVFdaRDRJcG5rY2VSZDhacUFiWEZHbEcvMjBXdUsyR2FtTjNLNEMyd29p?=
 =?utf-8?B?NGg0UEU1dmpGUGNiNU5kaVBodjMvbEIzRnplSlU3a3BMdW5qaUMxYXlZRzE5?=
 =?utf-8?B?ZUd1TGtFNEZmSHVUTTc3RThFVjQ4NEg5Q1hKaFRSVm4rOXh3ZlM4RmFpMmFy?=
 =?utf-8?B?V09icHF0M3pmaE8rSmRodkorS3lJQ3BnMERValEwbk4zQjB0c3oyV21HQWY1?=
 =?utf-8?B?OVRJN1RBTzZ6SDBsQXVIUjBVbTFNTkVDVGhPTGg0RnB5djJUdTRMcUpsd3JF?=
 =?utf-8?B?U2VMRms2UmswTEhNdXJUeVFsK0MwTGZMNlNOTmNWaE5FWGFFcS9Nb2h6Q015?=
 =?utf-8?B?Y2ZZWVNldXUwTysxSUlBR2tTQXJuTTYrL3RtWkJTdXVVQm03Snl2K29RNmlC?=
 =?utf-8?Q?QHqFJQY1KYap83ppjlaLwLuRHNqZTo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlpPeDFVMzNUL2lGOVdQVlFkWjVlbjB6WjJSdWRvendhczZaT3NpcnJ1dVhF?=
 =?utf-8?B?cm1Vak5ISnFBeGh6NmltRDZEdE9mb3FWdDhxbmFSejJKV1NWMUp0M1VOdjBi?=
 =?utf-8?B?ZkdRSERwc01oT1dSWDJyZ295Mk8ra1hkVml6cTZPQXBSQ0QzQ3l4SHc1SG81?=
 =?utf-8?B?c1REY0l3WGpyUmFYbDE1dVZlUUJuVytYaFY1T2tGb3NDRjlEenhKZlk2Y0hI?=
 =?utf-8?B?OGxxOTkzbU9QNUZNbm9JaGViUGVuVDBHdUNTK3ZaUzEyeENHT2dram5WUE5E?=
 =?utf-8?B?WEwzMjgrdkhJckJBOWxQNnlBdVg3SWIzcEcvOHFMVHFQckNEM1FMdUo4aE9P?=
 =?utf-8?B?L290ZDVQOExQYVRYUmV4aEtsUFhadkJyclBPV210YXk2WnpQS1Z5K2duWmpO?=
 =?utf-8?B?NVRtVDRzdUZ3WFBYdlVxUUNlUm9QQzNDNmtNaFhFU0lwUWFPaUdMS3R4TzNE?=
 =?utf-8?B?aXZHbnVLdVdHajlpY2dtVmw4cUVDWmxDaDY5RGZ0OVFmVEQ0N0hpYnRKRC9M?=
 =?utf-8?B?MFZpZlhuTG9ManZwMVo0TGZRak0yakVYZEIvN3c3VWNpcWEzMVBNYk5OT3RY?=
 =?utf-8?B?bkRzTzVJL0k3YzNyZHJvQ0lqamxlSldrWjJWT3pqR0ZIa01PQ2tCZHAxZ0lS?=
 =?utf-8?B?T2dBZnBzSmJPSWRTTGthTW9UeVdkQTZvaHpXM05pYWJxNmtRVFk4b0ZYeGNI?=
 =?utf-8?B?T0cxR25nNnVMU0tZRFdEME9vZXByYkx5WUpjNUluaVFuNVpHRi84YjlQQUdp?=
 =?utf-8?B?d1l0T01zUXRZN0VQUmJwbURETUViMHU4SW05Wm1TNnhWSHpQSWYxQ2xwVEox?=
 =?utf-8?B?MVBBVVF6bnNCV1dESEU1SGlwd2EyMGVja2tRSjNnSUphS1dSL3BUVC9mMUN0?=
 =?utf-8?B?WWhFQlU5MFZwaytmM1lMaHhDTXU0ci9WL2ZQT1d0Um03SUlsVGlxc2dOOVdV?=
 =?utf-8?B?T2syL0w0b1daYlVtVTYvcDEzbFVDbDYxTEpIRmlZeVRldlNGSEZDZGFuUlVU?=
 =?utf-8?B?TzNDMFE1ODNJUW10MVRVZDhqOFBHd3hnUzNlQlVaK0tQUUtJa1VTalcreWFT?=
 =?utf-8?B?NVFmeG9GWGdkTmtrMzBiSVFDTjV2WGRUSzlMZ3pES2taZlZ0dXpQQmVSbDN5?=
 =?utf-8?B?NlhuTlNLZkNaeEpiOGFhVm5VUDArSW9mWDlDSDBkdkJpZVlFVnRxV215ek5i?=
 =?utf-8?B?N1g0L2I4aktWOHhoY29mdnJhaEE1eXhZS0I5a1ZtM013RjY4QXRzMUN2ZkF0?=
 =?utf-8?B?N2Q3VlcxNkFZdjBlNnNOVnh6Mk9sdmdDVnh4QXhNSEluU2FPR29oMXk2NGZv?=
 =?utf-8?B?NXlQalhad2R6azAyeFNmelQwRmpxQ2RFTzE5NkhpaS8yZ3daMFNxMjVqRjN4?=
 =?utf-8?B?Z3VyVmRPdnBYbmo2eUtNLzZic2x5TDR5VGp6K2VvZkpwS0hKMzNuUFkwTUhL?=
 =?utf-8?B?UFJvZ3JQeld1ZlBDUzFyMC9DaTlKMXZkU2lHZzN1QzNlYjB2M0JTSk5IUTZa?=
 =?utf-8?B?UnUvc3pSZElsZCtMaGcvUlhVVGlraDNSYm16bkl4czZ1OVNUenl1VkhaNWcy?=
 =?utf-8?B?VmF6MlBITWgvQk5sRTdNbjhiWnBKL0xoWFU4RFpsZnUwSllNSzJMZXJOdU9p?=
 =?utf-8?B?MFp6b1lyamsrWTZWdW1jTUJuakZITlUrNDV1RjFPQzh5S3BqRGdMeUk5bE1S?=
 =?utf-8?B?UkMwVEZjYXp6ZTFUT2lQcDAreGxPSzhHTEV2K1QzVGpQVHVNV3VlU2t4a1Nh?=
 =?utf-8?B?MmxLNE5CWGt5OEtaRnhLWExPeXU1TC80eEpVdHprcVdHQnlncnM0aVlpZCty?=
 =?utf-8?B?TkxwWkxKQktCVDRudTB5TVZTQ2tpVzNoS1ZqS08ycEU4dXZBZHlJMUs3K2FT?=
 =?utf-8?B?RVlyMlk0YW9aRW4xL2lEcHFPSm96N0ZDTnprcFpZWG1hcStPZmdhR2oyZEVX?=
 =?utf-8?B?OHVMVC9Idk9KbUlEd2JWMnFyYis5U0lZZkVZNi83QXN0T01OUmNtTndCWXZI?=
 =?utf-8?B?Y1ZZSG55YnF5Y2l5TlRvNlRHcHBFS0xQVnlVR0tWMVhGcysvcmpNUklFZTV3?=
 =?utf-8?B?d1dmNElGY2hGUDAzS08yYnhYbFc5Z0lRUmZ3ZDd6RzEvOUJvUTE0WDVadE5U?=
 =?utf-8?Q?YaTc/rv1C2YBPe3OVoBm9URa8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81626E3D9C3EED40B4BCAED3FDA3C8DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae0b359-26e5-45b4-22e2-08ddee8aefe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 03:51:05.4007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmkyVvH9PNWGpeVPdpSD6RZaCwCtQo2CqrulSNAI9z/jVGOaGFN1TWXGb+OpnHhKSIxoY38w2mdBPfEXOA9rJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9064

T24gMDIvMDkvMjUgMjo1MiBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIFNlcCAwMiwgMjAyNSBh
dCAxMToyMjoxOEFNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6DQo+PiBEb2N1
bWVudCB0aGUgc2FtOXg3NSBxdWFkIHNwaSB0aGF0IHN1cHBvcnRzIGludGVyZmFjZSB0byBzZXJp
YWwgbWVtb3JpZXMNCj4+IG9wZXJhdGluZyBpbg0KPj4NCj4+IC0gU2luZ2xlLWJpdCBTUEksIER1
YWwgU1BJLCBRdWFkIFNQSSBhbmQgT2N0YWwgU1BJDQo+PiAtIFNpbmdsZSBEYXRhIFJhdGUgb3Ig
RG91YmxlIERhdGEgUmF0ZSBtb2Rlcw0KPiANCj4gQW5kIEkgZm9yZ290IC0gd3Jvbmcgc3ViamVj
dCBwcmVmaXhlcy4NCj4gDQo+IFBsZWFzZSB1c2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRjaGluZyB0
aGUgc3Vic3lzdGVtLiBZb3UgY2FuIGdldCB0aGVtIGZvcg0KPiBleGFtcGxlIHdpdGggJ2dpdCBs
b2cgLS1vbmVsaW5lIC0tIERJUkVDVE9SWV9PUl9GSUxFJyBvbiB0aGUgZGlyZWN0b3J5DQo+IHlv
dXIgcGF0Y2ggaXMgdG91Y2hpbmcuIEZvciBiaW5kaW5ncywgdGhlIHByZWZlcnJlZCBzdWJqZWN0
cyBhcmUNCj4gZXhwbGFpbmVkIGhlcmU6DQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0
bWwvbGF0ZXN0L2RldmljZXRyZWUvYmluZGluZ3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjaS1m
b3ItcGF0Y2gtc3VibWl0dGVycw0KDQpJIGRvIGV4YWN0bHkgdGhlIHNhbWUNCg0KJCBnaXQgbG9n
IC0tb25lbGluZSAtLSANCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRt
ZWwscXVhZHNwaS55YW1sDQoNCmMwZjdhZTI3NTM5ZiBNQUlOVEFJTkVSUzogVXBkYXRlIGVtYWls
IG9mIFR1ZG9yIEFtYmFydXMNCjc3ODUwYmRhMzYwZCBzcGk6IGF0bWVsLHF1YWRzcGk6IERlZmlu
ZSBzYW1hN2c1IFFTUEkNCjAwMWE0MWQyYTcwNiBzcGk6IGF0bWVsLHF1YWRzcGk6IENvbnZlcnQg
dG8ganNvbi1zY2hlbWENCg0KSSB0aGluayB0aGUgbWFpbnRhaW5lciB0aGF0IG1lcmdlZCB0aGVz
ZSBjb21taXRzIG1pc3NlZCByZXZpZXdpbmcgDQpzdWJqZWN0IHByZWZpeC4NCg0KYW5kIEkgc2Vl
IGEgbWl4IG9mDQoNCnNwaTogZHQtYmluZGluZ3M6DQpkdC1iaW5kaW5nczogc3BpOg0KZHQtYmlu
ZGluZ3M6DQoNCnByZWZpeGVzIGZvciB0aGlzIGRpci4NCg0KSSB3aWxsIHVzZSAiZHQtYmluZGlu
Z3M6IHNwaToiLg0KDQpUaGFua3MuPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiAN
Cg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIuDQo=

