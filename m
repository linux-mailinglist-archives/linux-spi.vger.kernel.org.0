Return-Path: <linux-spi+bounces-9927-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B76EEB482F6
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 05:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BB3189BB94
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 03:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C61DDC15;
	Mon,  8 Sep 2025 03:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4z9GF/eO"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A83126BF7;
	Mon,  8 Sep 2025 03:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757303138; cv=fail; b=lten/pKEhlZjoq5h436HhrfL6T29VFzePsiBOeP4SbbdkcBJg5O416LNGPCdWoUYPkk37W98AAI8+EOUFmNLJCxDBe5n7D7RDL/s6ewzSnfePr+W+KBcPpKYZ7oJGUbWd1VAdO3ruXPepA/mdP+Cxe97D+WxFLhjF3LoXIkAd3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757303138; c=relaxed/simple;
	bh=TY3w6tAv+MilAUD6Gz6h/vPNW6KCrhSeBepQLE4vqFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j3IwLALJVW/sMOrtonFWOOu3CTEXhCh6sO2wEzNhyC5R/OFudj+Q60pKtRgMggOY9G3trqk0tD3YWRErC2rGXxB1GB7NO2Tpiq+JzvRxZFxAjLg6lnKnuT1z5YtH2nO+04hddH5vUghWvc9Ranu+iXvokLWbeyw/AwdrVdJb/hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4z9GF/eO; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1mnPz8Q61ImbRIN5pbcsWc6ZEfzreqpMraJx8AY0gkzTUA7voZetbL+yy2A9sFO47zJJWgALsHL8kV/cJWAM5xBlnv7EOq8wV9z5i/4+go0+tG38bmXme3eEJM22UAr/TYE2ANDvN1Y6gjqq46dmRWVAhycKltFmKVvPd4aKnoiAj9ZHxW+bINb15tcI63F946fPGV35S6pE2P4FnQKspdXAKof66gbz0qYfog5lQBAqi6DvkaqUmdOb/xtMBdN/2S0z5G4TWEnccSs+d47yg9WBDPqA9pC6weMtfLDHUwC2jmGFfBx/9HH0Q99zeujHtb2yy7kjuvJ8Fd0Xk4Bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY3w6tAv+MilAUD6Gz6h/vPNW6KCrhSeBepQLE4vqFo=;
 b=KntjHZNzZZoC/lckyYPcsSOEIZDCtX9gAFrMPrDMrh2l+1sgKz/dpniuRyEctM2c0jtgqEBTRX9Fb83gyFZCbMdy7rDe0bWi3dxLs1aKpwQndQEzbp4/oVZDvypxmyazPBuRupLBtLTklQrC/NyJ2HAOJB04j3bdBpK6SmVasT6K/A06sEkxIyM+b5Yl35w7plo6egP4rfK42Jqj2mnBtgHmsegFSFF2Wx1zQ4NfBXTy8GSxzwAudYJ5U32nY9fhYfuRD2VIN+Vcg815IwsB94sSr3O/1hmMuxoh2bQE+h8wzJ5Or7E/wRh33wZonOa0iKlEn8N79DVOrvHjqXxYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY3w6tAv+MilAUD6Gz6h/vPNW6KCrhSeBepQLE4vqFo=;
 b=4z9GF/eOGopVDaFXRjeBVMiZJ7fphwUbpmDdemM+hcyWfS4g9S+Am2e610FILqIJ5ZyMqbQEi/kgwKnaVZnDz7FABK0EtR10V2xfjT+43y/oxXnerMkKygnlniQaIrPwQ8Ez37kz4cAP/oKPgnmaZUOopCtZMyGYyMqL/93BCqZC5MNNLawBgjzMRBMuszXuHBoYaVWhHdq0UrqsTS8C3a5SRU258g/yxkuTyzsb37QEO7xmThLIf76zO6Fa1Kw1kStgxXNVXR9BbJafX6+QGEg+V2mmpX9V5l+kxUlS4j1TaZprLSop2DSEe0jg6arPzdjrkAR4xatc5cvptysQcw==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by IA3PR11MB9064.namprd11.prod.outlook.com (2603:10b6:208:57f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 03:45:34 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%2]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 03:45:33 +0000
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
Thread-Index: AQHcG83VB9LmjLEhZku8WJRHpUcCBrR/nmKAgAkQEgA=
Date: Mon, 8 Sep 2025 03:45:33 +0000
Message-ID: <7099b01b-2071-4561-b27b-0f1443f5856e@microchip.com>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
 <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>
 <20250902-macho-violet-orangutan-faac78@kuoka>
In-Reply-To: <20250902-macho-violet-orangutan-faac78@kuoka>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|IA3PR11MB9064:EE_
x-ms-office365-filtering-correlation-id: 6db4693b-17fb-4a9c-b663-08ddee8a2a40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDRVS0xQQ0lyRE5ncFFIZHFsVTBUd2FFZmxocjJTL3BhVWlXMmUyTmY2Rzlq?=
 =?utf-8?B?cDZUOUNtdmlkRXlCQzk0dWZBVG5meHI1c3ZIZmFKYzk3RWdYUE1CcTA4U0lw?=
 =?utf-8?B?a0R6NzEwZkxnb3U2bldoeGU5ZjlaNHBsUytNcHZ1ZkgvV0svdlMvLzFHTjE1?=
 =?utf-8?B?U3phcXhVL1k4clB0OEozVVFtRkNRT0tKU0hZSmpNMjRhampZN0QxOURFQ1d0?=
 =?utf-8?B?WEI2dkNGWlNnc0lSRHZhaEd6VDhmUmJJaGZjVVVLeCtvdC9tT0VhNDZvN3RH?=
 =?utf-8?B?OTBBSE02UWVKUHFpK2VGZHJLSlpDYVdMbmN0TUt6N2RGdVBxOUJrdCtsTHlI?=
 =?utf-8?B?dzdQR2duTWF4UWwvTTAydVllRFNTTW5LL0xSMHVLcE9UeTg2TWRCVzh4ZHBj?=
 =?utf-8?B?MzRNejNsSE0yMEpzR1pYYnBmNkhFdEl3cFJEUndnOXdSQ3dKWXlKQ045ZGZQ?=
 =?utf-8?B?OXJ4SndIY3kxZC9aZS9sczVqMnRweTd0RlBxRDE4QVhISTlBL2pkK050SHlw?=
 =?utf-8?B?T0FDcFhpUEptY0RTY2NnVGVLUnVlQjI2RFN5VUswZGlUQmRmTk1IbUF4L1dO?=
 =?utf-8?B?MFZ4aE9taEJxZk5ZSWppdXp3QlFISWMxZ1UxdHJrVWpNeTNmVXlFQnFERmtP?=
 =?utf-8?B?M1ZwV0xaYjYwNVVPc0wwUnE1eDJxYU5kVFBZUW5MS0tnZ3FGSG5JVE95L3JP?=
 =?utf-8?B?bXZoVlFPSndOR29kRHhFZ2lnQ2JUcTFjc2h3ZERsa0JBU3VTdFArL0dHd2RW?=
 =?utf-8?B?c0dwYWZ5STdIamx3a3J5RlpySUtZaDlSc3V6dWloWHd4SEIyZkVzaG9sanN0?=
 =?utf-8?B?N1NHYXZVcWZDcit5TkNxQXlQLzlaSlNQUzBrOTRwQ2Nsb2I2MlNMK09RRjZX?=
 =?utf-8?B?eVJhbVFXNkRaVGpLOURZTlF5Tzl4U3hzNlRFNm5XanRUN0h5Z0dteCtwZWR2?=
 =?utf-8?B?ckdGUGoyT0EvVUxKUmJBMUorVXI5NmFsT2pwSGFHeXMySVlQbHJzZWtBMzdQ?=
 =?utf-8?B?bitEWVh6NGtwLzUyQlNpb1N1VmsyVTBpa0hLZHNaSysxMDE4dTQ2MVlTS0gx?=
 =?utf-8?B?YkVkVE84a2s0V2QrWmtrYnluZjM3RW55STFHK0FLM1lNTFFnZGRIbThYVlRr?=
 =?utf-8?B?R3M5VExhZGk1cDA3Qyt5RGpKTTZ0NHI4SE4wTnNFWXhMVVh1cnJMWjNBR1I2?=
 =?utf-8?B?bVNrTG5CbzhuU0FtZzZSaGxrNkNrQWJEQy9ZL2x3aC8wUHVMK243TTZWc1hX?=
 =?utf-8?B?eXIzQ280VlNyaHp4bWl4a3ZFbVBUSE1SdnlxRE9ScFJXRDByZTVqNWZieUFX?=
 =?utf-8?B?MzlXTVpQOHprSTNpQjdsTmRqc0JtN3ZIbGo4clZFM2JObGFsS2tYYmRPL3hS?=
 =?utf-8?B?dm9SV2NpL1IzYjNOa1d1a3J4a0R2WUZQWjl2bEdxZDBzSnNsWE9MN1lCc3hW?=
 =?utf-8?B?Sndja1p0cjBxaEllaVpNK2djTjkrYmxuK0U3L0ppNnNpUDJJVG1PYWhRSWtK?=
 =?utf-8?B?bEV3QUtEcVBaa09lZjU1eVdJMjNoTy96NzFPTS9nNHZOd3VhMWNvZ0pDVEhM?=
 =?utf-8?B?NlMzNzdzZ2RpNXZabFhSZDgxNHBacjJjUEo1WEFMcEhFRzJVaEJiQXFNQkFa?=
 =?utf-8?B?c1JhSmJYaHRZcVoraHNXVlA3eUoyZjVidXNRSmxPdGN4ZDB6cEg1MlI4WUxT?=
 =?utf-8?B?dDlRdmlmTi90dmlUN2tqTTdyY3NkRzBlRnNIQy9GNStxNGd3UmdKZVNJZVlj?=
 =?utf-8?B?YVd0Y0dzYjRySDBKM1FMd3lMa1Nvc2YrV2Y2NEpXUkFrc1RmN1pNSWNSZlpa?=
 =?utf-8?B?bHJhMFUyTlJDUzRMNGFhRVU5SFZQaXJ0SHdkNnVvdzFGblVpOHhWRUZDaTF0?=
 =?utf-8?B?YnEwaUJTbXh1clcrNFZSQWtwK2lUTWZRTTl4TURRdCtIenhhRXZ4SmFKVWpU?=
 =?utf-8?B?elNkajIzNVI3ajNHS3dRUlZwQTFKNklLZjNocEV2T3dXdkgvSVYwNGg5QWhE?=
 =?utf-8?B?K2dBQnNFU3p3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTNsWmxGWHRhazFROVA0Tm5vREtWRVJkT0l4VTBHYmlBTmFyeUFodmVXTGc5?=
 =?utf-8?B?N2QxWHFyNkcwRnNuQlo1eFdGMkorN2ljVGZvMnQrMi9EUEdUMzV4MHFtcHhI?=
 =?utf-8?B?VGYyTHhlZCt3aXYrelZVbmFaOHJKdVNnVEE4YlpLdDlLUDNCOFhrbGRobDdt?=
 =?utf-8?B?VVhydEY3Y1ZZVnh1c3BGVmZoQWRIWnZQQmxCSHhOTWhwejZwaUxsSHRhTTFP?=
 =?utf-8?B?c0x0Y2tENEhWTEM1WDB5QkUydnpOOTJJcjlSN091Rmxxa3hqSENUMWxrTXpT?=
 =?utf-8?B?anpnTnB4QzVGRXdialZHNTQ0eUZvb3M1akRjQkNEa1NrWWR5UDVrSU5YTFRY?=
 =?utf-8?B?M1pyTVdoVFhISldDcVdjSWNnOEg0SWVOam1aODR1SDhRUUVnaFlReUk2NWlm?=
 =?utf-8?B?alQ4TFBDQ0RBN1pvamxrYVhrRktDbVRTTG16VlBSSzkwQ1I2LzE3QVVBZlZI?=
 =?utf-8?B?Rm5JenNtbWVQTnNtK2srK1Y2MXB1L3dKOXNtRzZ1U1pKNllRbmdBTUU3Mm9G?=
 =?utf-8?B?UlV0bkoxZjdoUDU1aGhneWRIUnVFYVluKzJaOFFUR0hVcEphM2l5QlVxcC9j?=
 =?utf-8?B?MG5LYWo3V1ljczNJbE5acHdHaUo3TjFhM2JpNW1BaGNBQmt1M3BZU0J1eDdM?=
 =?utf-8?B?dXhDa3NkS1JBektidmxneGJtS1grUldvZVg1MU14Tmk1UnhoRVF3TTV1Z2dI?=
 =?utf-8?B?bDdFN2s3VU0zTXZtOWtYU3ZHUUJRdVo3NlQ5YmpNZnBoejhsYnVLdXE5azRP?=
 =?utf-8?B?N3BkblV1Q2hVZXloV0Zhci9iNzV2YnFhSzR1eUd0SVlUUXF0QUYvRkRsZnRO?=
 =?utf-8?B?MVkyMUJxZXNjWEZmbUxKRXN3SlB0NGtEMzhNeWxpYXZSSFJaSC80YWhWQ1Qy?=
 =?utf-8?B?TlYxRkQzcjhPeFFON2loN3FzTlJTUTg5aVExN1lVWFE2S3MxZWN2Q1gxaW9o?=
 =?utf-8?B?MnBLRThuOVJhWWVpTlNLNjRZNVg4eENpbnVNaWJGSjlIZzlLbmU0VXYyWnl4?=
 =?utf-8?B?Zm92MThsQUIybVlQZHFnVi9kVWhJZnZzUmlFWGtpVG9jWTdiWE4vcmp6MDAz?=
 =?utf-8?B?NEdGY1dWdXJSa2NjcVBaRjk5YzFuWlIvTFdBUU9POEw4b1JxSDh6N0FWcHg5?=
 =?utf-8?B?MTB4a2syam5oelFOV0dsdkw5Y2NwNnVPOUdDeTV1cEM5Ni9CSDN3UWNQd2FH?=
 =?utf-8?B?ZEZTbC9YcnpNUDFkenNpUjRleFpzOVdPbVJXUnNuZUVoKzQvVVRxbzJoSC8y?=
 =?utf-8?B?d01DQmkySVY4cEVYSWhndTV1RFUwNlZxUlE5RldaV1pJbUc5R0lBaWgzVjVY?=
 =?utf-8?B?WTQ4cEpRQmx3OUVrTmw1TVIvdWQzQ2RNSTlFUnloVlZzenozSnhFVjJxaC9T?=
 =?utf-8?B?MXhPVitlSVdyTTlnTkk4a3pHRldXcFlGVU9ESmp4eVQzQXMzQlMxM3dEbFRw?=
 =?utf-8?B?eUFCRFNBSFQyc1ppbHdqaWliQmhOcGFIZU9hczFONE1jRWNxTndCVjRjOFNR?=
 =?utf-8?B?MExSdFg1OVNkaUl2K054L1hMNUdvRFBBMkxqcEdmM1pJQVZjaERLbzlmNkNx?=
 =?utf-8?B?ZlBHNFBHK1lkdW9IcksveHVRaGZVSy9ycVNoSkw0YmMvaFBoY0lGNDBtZ2FZ?=
 =?utf-8?B?Y29NdjFPakpSbndBUitsbUlaSzZub2dnUkNsRDJhZ1FYVmxMRzVXTy8vYXZN?=
 =?utf-8?B?c1pRUXlVY20wZGRGdUVvb3FtUG5jWkdnK2xUWCtQQ1U3eUpKYlpOZW1tbjdw?=
 =?utf-8?B?YVhrZDB3VE8zanlWQnNwemthN3M2djZDOHZWdHlhYVU3TUg0c0dwUTdmQlJj?=
 =?utf-8?B?ZWt1Z0Q4Mm1zMGhqV2JzVG9xZW1zL3pIRkVtVTdaNlYvem9VYjFkUEExRXd4?=
 =?utf-8?B?VHNERGQxaDgxUUd1U2RNazdIRmtlalhJZm1vVHdtUDQwYzdOK09VakUyZ1BF?=
 =?utf-8?B?VXBobHlRZ3ZqTElPN0NYRjBGNmZOdlVCa0ZIUU1YWDN5cjk2a3VjYlZNdTFJ?=
 =?utf-8?B?TTlOUm1mdy9hS1lZNTdhQVNVVVpOVGtyZERaVDVDRFQrSVBKQ3A0eDVPRy9X?=
 =?utf-8?B?TjZLYU56R2pRMDlIeE1CVmI4SytJM1JPcEJxamdxOVpTbXZNZW50a2crWnp2?=
 =?utf-8?Q?VLyjNZ5Nl1ZuVftW85vmZQZmM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E929A6C2D1A874599B56DB2D6BBFC0B@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db4693b-17fb-4a9c-b663-08ddee8a2a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 03:45:33.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFBqKIq0OCZJKNBoBxxp6GMtw1ER3lRomtq50+IzsuPiflOlLREosnOUT+EEUVIkTDf7SsUOUoAYKIfLGupkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9064

T24gMDIvMDkvMjUgMjo1MSBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIFNlcCAwMiwgMjAyNSBh
dCAxMToyMjoxOEFNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6DQo+PiBEb2N1
bWVudCB0aGUgc2FtOXg3NSBxdWFkIHNwaSB0aGF0IHN1cHBvcnRzIGludGVyZmFjZSB0byBzZXJp
YWwgbWVtb3JpZXMNCj4gDQo+IDl4NzUgaGVyZS4uLg0KPiANCj4+IG9wZXJhdGluZyBpbg0KPj4N
Cj4+IC0gU2luZ2xlLWJpdCBTUEksIER1YWwgU1BJLCBRdWFkIFNQSSBhbmQgT2N0YWwgU1BJDQo+
PiAtIFNpbmdsZSBEYXRhIFJhdGUgb3IgRG91YmxlIERhdGEgUmF0ZSBtb2Rlcw0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IERoYXJtYSBCYWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNv
bT4NCj4+IC0tLQ0KPj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0
bWVsLHF1YWRzcGkueWFtbCB8IDEgKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NwaS9hdG1lbCxxdWFkc3BpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc3BpL2F0bWVsLHF1YWRzcGkueWFtbA0KPj4gaW5kZXggYjBkOTliYzEwNTM1Li5jMTcxMTQx
MjMwMzQgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c3BpL2F0bWVsLHF1YWRzcGkueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9hdG1lbCxxdWFkc3BpLnlhbWwNCj4+IEBAIC0xNyw2ICsxNyw3IEBAIHBy
b3BlcnRpZXM6DQo+PiAgICAgICBlbnVtOg0KPj4gICAgICAgICAtIGF0bWVsLHNhbWE1ZDItcXNw
aQ0KPj4gICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLXFzcGkNCj4+ICsgICAgICAtIG1pY3Jv
Y2hpcCxzYW05eDctb3NwaQ0KPiANCj4gLi4uIGJ1dCA5eDcgaGVyZS4gQ29uZnVzaW5nLg0KDQpJ
dCBzaG91bGQgYmUgOXg3IG9ubHkgKHFzcGkgaXMgY29tbW9uIGZvciBzYW05eDd4KSwgSSB3aWxs
IGNoYW5nZSBpdC4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg0K
LS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K

