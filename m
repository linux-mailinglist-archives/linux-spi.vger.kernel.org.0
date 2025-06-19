Return-Path: <linux-spi+bounces-8668-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDFADFBF7
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 05:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383B13BEA47
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 03:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B177288A8;
	Thu, 19 Jun 2025 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ipDMvvun"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3023AB95;
	Thu, 19 Jun 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750304974; cv=fail; b=qarQsrz8uHkLAhbrpTOtpNz9vVB2nVJC7ZN5l+qJ2BKchqgnmNeyIpvThSOW0YO15unCmy072NSoLkqnnc5B8MimUfGZ81YY6pIjS8AvXPKtQUNjpNogRoLkJTyvmSeVPMX8Z0301WfixB1vquj1/ROB02Cj0H97Let8GyGUqPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750304974; c=relaxed/simple;
	bh=UysbImaiEziIYu2MiNQt6C8M2KXsaUezihiD2Ldm/vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ozZ4WwibZpkH0yyxNwMectxLqpNwdaUDSDPZKc2X5/OyhjI0Pn5WkqUSjpjcAjFNvn7n898z3Ulr9Bi20rYtPTTZbP2TSDtd30YAYuMSfKu2NZStbBarZnceqqOU0NU/CQMQ0pSGIzLUItzbuctLiH4jdPROHOVTkLs20nml3wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ipDMvvun; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdxY7d0XmaZ5bVGuLIwvkAx0bdFZCsPLaftkX+NA7+NgxBj0m308U3Vh5H/aNqNDVFUJZFcPZQFq+KFi6ey0/3yA+JzPtd7OsjqI2H54ycKsNwVgTe+bg0WfeaU/yat5gnceAzNpQsP3xevLwO74ra5PzktZqdiCX7VHgd+f8KmjIYD3r2d9jnRN3e9mqs5mpFRxYPFPIOpFnROWu9pcgvKorp7j87epH1A3mVfXR+QOehoGc4CXKGlfXeWGKnsORLg9khQ2ytKZYJ24oFS4SYl8WOk/xGK3lkIfm7uGwHH9Nz+wyTr2N3XUmN6iX8yHp5OjmpVrLGf54olWgs1yLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UysbImaiEziIYu2MiNQt6C8M2KXsaUezihiD2Ldm/vo=;
 b=GgTBsQHvWsV7ya4/mKyrimP8SzSsfPwEL9aRco5SB1kUm/tggBGtWNTtVgv3Nbuel2ztf9reYo9FyRYHEhBYHN/obZUxBdfLPuuVDgcIxf32eL3n0Y6OdqBkFMbicTBZ1QkALrV0Wp3+nWyXoH64KVRN0sqAELaF3TVGyi/PIaIRT+Ei+J51y10zUVMa467Bkb9Trou+tr6o/sD+CC2/DwdcYHoX6F+1nFoIJiecJLSmYiefTMkCYQYZoapfrm9rPE4mcjsUedJ7yBwTp4lSfrbuZa7oRFgvcyjGhxelqxok4wjkxhslolVK6qYBqNKRx4bbz42EDyYwHQHyCjuAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UysbImaiEziIYu2MiNQt6C8M2KXsaUezihiD2Ldm/vo=;
 b=ipDMvvunxO0C5qZrynZaUSTWed+ZLafQY4HGLNg1GAM+uz8bmRSkH9+J2lg5phD6qLAHc+KtTDb/lrvsryCGIGBbSEVx1X3MQRnBPEA0kQpyI/Pcz62PBgy0orIwabFe1+t4anmwftBUsRmVWBkGuQfwxJ1tyBsPKu/D8KCd417Jh4MXOL7HV/wSTuwGZ7l86afcaP4IljJJ5oDP+KtZJBZKWzQTYhSUx3kaRdNlGyUHlhdwmZQA/3uQyNwPXs2tAlwBD59tbCpKsutLhsXeiucGk+qBf9ibKhrv1m5DF6OQEfpcDyAJ9CVQTeJTOma1kpMzB+T2jkwzEbfNyzTIaA==
Received: from IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 19 Jun
 2025 03:49:27 +0000
Received: from IA1PR11MB8804.namprd11.prod.outlook.com
 ([fe80::fa56:fac3:2d22:311f]) by IA1PR11MB8804.namprd11.prod.outlook.com
 ([fe80::fa56:fac3:2d22:311f%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 03:49:27 +0000
From: <Thangaraj.S@microchip.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 for-next] spi: spi_pci1xxxx: Add support for
 per-instance DMA interrupt vectors
Thread-Topic: [PATCH v1 for-next] spi: spi_pci1xxxx: Add support for
 per-instance DMA interrupt vectors
Thread-Index: AQHb3AwMejTLLxmd8Ua3KbDzul2kgrQA8KUAgAjwfIA=
Date: Thu, 19 Jun 2025 03:49:26 +0000
Message-ID: <dc4c30cdc9a679c9b54d2cb7536727e2c7ecdf51.camel@microchip.com>
References: <20250613023236.126770-1-thangaraj.s@microchip.com>
	 <4dfcea41-2bfe-4f4a-91fb-94d9b636add7@sirena.org.uk>
In-Reply-To: <4dfcea41-2bfe-4f4a-91fb-94d9b636add7@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB8804:EE_|PH7PR11MB7429:EE_
x-ms-office365-filtering-correlation-id: ef621f1e-348c-4aee-79ed-08ddaee449ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTRXN3FxOTJBVjZkZGovc0IvUEY1TmVYQXJhUlpwUTZtZFczV0NHa0VTUnJo?=
 =?utf-8?B?SVZndW1aQmE5anVEMXpjL2p2K2tRTmltSVdFK2Z0elVoQ1lyQzBEOUlralZW?=
 =?utf-8?B?UUdieS9penZSYVVvSkpVUDFvWHFsZEVVVWhjWkZHMzZITE5qbnRTN2xhZWVR?=
 =?utf-8?B?dFAvYTROck51Y2kycldNNy9JSGoxaERsNGd5WjkrVzRSUmsxbjBDaFRTRUp0?=
 =?utf-8?B?MWIzTVBpSXlKTnVndlQ1cXhoL2h4NHpNSU8vWWlNakhXWlFaZ1hQRFp4eE9O?=
 =?utf-8?B?SDFMcW5XczRCVEhWbExiNDQ5V2tqd2hwby8xSEtnaURXcExwRExmWmJWT1Rl?=
 =?utf-8?B?ajlaYnFiY3dlT3BnRWd2b2NVMkM5WittOUNtM2FTQVZlQW1pNXpCbi9BQ1dh?=
 =?utf-8?B?NGxsQjRINFRxbkR3ZURFQ0c0MnN1bi9NZHNhTjNHNUc2THRsOU1yWnFCSVFW?=
 =?utf-8?B?QkFUSXhQelVCSXRpQnEyYit4SDVaUk12NXc1cTZYYjJOZldEb1RGQmRoRGN4?=
 =?utf-8?B?d25qTUdZVmlNVWFWdTJCVU5rTjJmNWptMkZtMjlGcHViY3NPd0dnbDBMYzA5?=
 =?utf-8?B?Uk1LTk1qd3FtL0c2SEJiMU5wZUJBSDNCSitjR1dXUUZOVEU1VlVaWVExQmRt?=
 =?utf-8?B?OXdmVytTQXV1WDNFY29yNkRsT1l0aU5peU9FbzVJcUU1aFhYTjlZbWo3a3VV?=
 =?utf-8?B?S1EzSElYa3k2QlBzQTU1V01pRmZpN1c4Z1VjdnJyMm03ZFpoclgyTHVhTGJr?=
 =?utf-8?B?T2djTk9wc1JCdXRPNGRIUGpjSmd1N3BRZUVCa3JNR2tGUWc0L0t2Y0NSWmkz?=
 =?utf-8?B?cWYwUTBPOXJ3dWFIVnNiOGZoeGZoRGxtbVNmcHFTSCtycjVLcFo4Qjl2Ykhh?=
 =?utf-8?B?UVVPM21pQkNvRFR1ck9nd29rU2t2ckxselJlS3NZaGs2ZEhkUjhwVUFmMHQw?=
 =?utf-8?B?c2duRURybUxtOFBmMElxQ1BxWVZTNm1EVVRoMnNGa3dTbUF5NnVlZWtONVRi?=
 =?utf-8?B?SHlmM29rUHpCWU5vZUs4QjZ2OG01WlR2UVVTV1hxUEFLeUYwS0RzdWhNMmF1?=
 =?utf-8?B?Nk1XWnd5MS8reVVXaEhlUTVkMG5nTk5XSkJ0VUFxbVZKNG9TODIrMFQxclVU?=
 =?utf-8?B?Rk0rZmpxalRlWGw1MnpnYnZqMTBtRlBjL3hXZW16RVEvcE0wNkd6bE9adG56?=
 =?utf-8?B?b1NyQUs1UzlhMmNVajJ4ZGVYZnZNN1gzSUQ2R1pGQXorYkFSTWZ2TUhISGdU?=
 =?utf-8?B?TFJmTXIzcnIzVFd1WTMrRDJyWXdxeW5Qa1o0MU5MUGs5RVh2TlF5bDVFNmZx?=
 =?utf-8?B?UmsydHN4NU4yVmJYRVJFNjR4bnhDc3V1bDdYQWlEZFVybm1nVGxHc1NCWnZz?=
 =?utf-8?B?ditnSkpIR1BLNzBwT2cxMW53RlE2eEFHYk5KUHJjRkl5cEphRnQ3eWdRWCtz?=
 =?utf-8?B?SFp5WFo3NDc1aWIxZ1g3Z2p5amRJYUcxbFdkS244M29peWNGazNRVS9sZEYw?=
 =?utf-8?B?RzBBbDFiek9nNEVkS0Z5QldsYzhjM2QyQ3QxVmJaWEJIcURXYnkvdjg0UXlX?=
 =?utf-8?B?S21hQmhnb0ZXazlSbjRTVU1NZUw5S0pLQ3FyQ05RTmpkS1BPNTJCVzE3dER1?=
 =?utf-8?B?Z0R2Tk5JTUJvMXAvYjIwa1Bhb0pzTU9tV1d6cUl0N2ErMWV0NVh3MFNTNVRa?=
 =?utf-8?B?b01HZkhpeXpSSW13RnVLOXdwa1ZoakRtQ0JpLzJKZHAyeEhOS2Qvai90T0dQ?=
 =?utf-8?B?UlRTYUZJVGpicGs1bVFjMGFwVUxldDJGK0hoTEJyd0luUm00NG55ZDhPaUNQ?=
 =?utf-8?B?dXZyRzVuekE4NmFOd3doNCswaW5yaGxSMC82WnNuZWoxdDR6cXJJZzFlRFFq?=
 =?utf-8?B?VG40ak1oU3MrVndERlpBZEl0TE1JdWJSeWp3YW9yc0h6S1ZoOTFKcHF6Q2VV?=
 =?utf-8?B?TmpYbXZ1MXV3T2lBVlZKazRjSTBpSS9QVFRVNnhDT29XTkNydHRqNVdYK3R4?=
 =?utf-8?B?TTh6SnNNd3VnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXlSRjV1NzllOHVKNEZhVU9DOUNwTzFUZUwySFR1NVB5MUNaK1ZVRTUwcVJO?=
 =?utf-8?B?S3N0b3ErLytvWTR2eEpGdHZiRGFWMHZWeGt0Z3lhMTI2QzJKUjMvVVh4Tngw?=
 =?utf-8?B?SjhVOHBHUTZGMkRFTTRVNFN6dzRZeXhTOVNvaVdUVVNrdU40V2FVdUo1SUZF?=
 =?utf-8?B?Y1FsS0E0VW54Q3hWVi9SamE4WHJ1WGJ3bU8yTkNMbkh4bTRHL3hmblcyS1Zz?=
 =?utf-8?B?RXZWcFlSS3UrbjVmMlNnS1pnaDVqZExjRzJWSjlhK3MwV2k3YUpvVy9hT0hI?=
 =?utf-8?B?bVJ4cW1qRXhjcHpmMWw4aDg1dGJtdHlOdFJ4aSs2RDZkU05PRUs3SDFaUzdz?=
 =?utf-8?B?UUdWUVZab1ZPMTZKaVduMlpIenpyQnhVTC9oZ25NZUVBa3YzVGh3a2VCUkRz?=
 =?utf-8?B?WVZ6V3RkK1pKcm54ZFJPbHYyQ0phVWZTM2srQkhSTU4wdncvL0ltTk5HT25M?=
 =?utf-8?B?WnhoUVlpUWpEVzhVWmZML1hYT0FoRXpGc0lWNWhMN1o4V1ZMbVhVaFlvK3ly?=
 =?utf-8?B?TU9qa2wya2F6eGcxUThGQnpFUFBZMFNCZmRIbDRjcmhpeGw2V0Ixc081RjE3?=
 =?utf-8?B?dWw2QU93cWVCTFZlRXQwZjc0ZDdQT081b2FSdkw3cFVQMXQ5T0RWUUdMN0xx?=
 =?utf-8?B?U3BDYnQ3c0doVVJueFdpU3Z1UzMvQlpiT0h5Y0xOZWRuWStUMERTN0lzaG5E?=
 =?utf-8?B?TkQyUThKL0FJOHNUdDVCSk1kWUJtcGFod2JyYVRrdWx3SmNoMzBVY0JNOHpS?=
 =?utf-8?B?VFBUeVMrSy9oeFF4OSt5UTVTOFNMT1ZpbC9DSk9PVG1Fb1hpalVYRmNDUUs3?=
 =?utf-8?B?d3o4bXBlQVA3WHlZdEdvdVppaGUzb3A5bkV1aVkvOTI3UHU3SjJITk9ZQ2ZH?=
 =?utf-8?B?SGJ6c3dPU05DS1FPWld1YWNUSDFnRjh2cGlXSjJVbXBZNVdqcUV0anhzcUxq?=
 =?utf-8?B?ZytYT3FHeXlia0VrK2JhUlBHT1BlMG1LQmlEazlraGNUTGhTaUI3OVd3WEs5?=
 =?utf-8?B?aFBiRDNnZE5LaVBmdmhCR2Naakd1OTUwUzhEZmliTVd3a1JnWGZhdERQWU43?=
 =?utf-8?B?RFhvcjRHYjBmUllpVG1Zc2VuZDdsTWppeHp3OGlrandwV2RJam52UWV3Szhw?=
 =?utf-8?B?VjVBWEpJNnVSYTNta28zeW1peU11amd2cGtWRHpaWS80U2JkYlE5dHBMZ2hR?=
 =?utf-8?B?NUIwbEN3N3dSV1l3bGUwZ0pzNk42dmErL1FlUjkvbTZEUDArRXZMRE95SGNG?=
 =?utf-8?B?TTVtUzZacUtTb0lVY0RXY0YvMmZ0aHZWc0hRY1pFYWpqL0t3aU5WVVljQjVE?=
 =?utf-8?B?MGZNODJ1NXpRdE5iZzJ6Z2ZndHg4UHhCeXEvZzBkcFR0V3l6cHlOYkJYK3Rm?=
 =?utf-8?B?a0l2SExNdldjcUliZWlxTmdwdElGYUlOK3ByY1IrNWpMK05NTlQ5b3lJcWNy?=
 =?utf-8?B?bzZzZ3MzZzhNbTJueW1YczNSenBTc01QZjZwNnRySWlMamw4R0FYNjZHV1Fh?=
 =?utf-8?B?cHg4OFZpSjZ2MDZpZVNZS2hHd0hBQ3lhVk41dzg4Q1dJZko0YURhU0dPbmlk?=
 =?utf-8?B?V1lLMFZwalUwTVVHUEVrcFZIc0R6TjFCS0pRYUtpOHFuNk1GVUV1QlVPRGFU?=
 =?utf-8?B?QkRXcWRmUFVyUDlzOXhnTVB0TGxFSU4vVjJ5MCtIeFFZbFBSNzhaUUtYVmJB?=
 =?utf-8?B?OEtkNE1PYnJuMzBoU0tJTXJuZVhKS1BBWVRGQW4wK0NuRkpSdkladW9vV0h1?=
 =?utf-8?B?WFJuWFZjUXk3Tm1RVkNNbFVrVk0ydE9ud0JzUzl1Q3YvNlgxdUVHNVR0bUZ4?=
 =?utf-8?B?TjdwVzUxa1lpOSt0MjFsMzJVeFJEVUZyVFZhSVl6L1NSQkM2dmVSWlQ5TzRY?=
 =?utf-8?B?ZHZ6NWNzcE1OSklOcHZGelp6YlU4cElZd290MWJWZlFscXdxOXlFNytta3Y4?=
 =?utf-8?B?QlNrVDFDckczSWdIQVB6ejF6YVllVlpMTDNFaysvR0VrUGpZRWtuMVM3SU9a?=
 =?utf-8?B?c1RwYXdtUXRGcnFlRzBWcE8rd1ZFSnh5OUhQQ0NESGUzTC9sVkNzQlhqV0x0?=
 =?utf-8?B?UGNXbElyQXh0eWxGUmFNZ3RjWUY1SFlGYzNMNmFGR1Faak5abzgwdjk1eEx1?=
 =?utf-8?B?YVZKSHR4Nmh6TThaUVJSUVZ6NGdjL3M5SnNzUnpOREFTcUtaaU1CU01iRzZ5?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D04D1A34C63874391A7C986ACB7B8DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef621f1e-348c-4aee-79ed-08ddaee449ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 03:49:27.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfTfVqNowrSgrvXRsQA9+wzx0Kt8rHY/YN4dB/2yqfyI8E6bXOQYxD/BoFTClfiY9D1OPsV4r5AzA+cx7lOXmesWwwJtCeOyeLGvN5cMU3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429

SGkgTWFyaywNCk9uIEZyaSwgMjAyNS0wNi0xMyBhdCAxMjoxNCArMDEwMCwgTWFyayBCcm93biB3
cm90ZToNCj4gT24gRnJpLCBKdW4gMTMsIDIwMjUgYXQgMDg6MDI6MzZBTSArMDUzMCwgVGhhbmdh
cmFqIFNhbXluYXRoYW4gd3JvdGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIGRlZGljYXRlZCBETUEg
aW50ZXJydXB0IHZlY3RvcnMgZm9yIGVhY2ggU1BJDQo+ID4gaGFyZHdhcmUNCj4gPiBpbnN0YW5j
ZSBpbiB0aGUgcGNpMXh4eHggZHJpdmVyLiBUaGlzIGltcHJvdmVzIHNjYWxhYmlsaXR5IGFuZA0K
PiA+IGludGVycnVwdA0KPiA+IGhhbmRsaW5nIGZvciBzeXN0ZW1zIHVzaW5nIG11bHRpcGxlIFNQ
SSBpbnN0YW5jZXMgd2l0aCBETUEuDQo+IA0KPiBUaGlzIGRvZXNuJ3QgYXBwbHkgYWdhaW5zdCBj
dXJyZW50IGNvZGUsIHBsZWFzZSBjaGVjayBhbmQgcmVzZW5kLg0KDQpTdXJlLCB3aWxsIHNlbmQg
djIgb2YgdGhlIHBhdGNoIHNvb24uDQoNClRoYW5rcywNClRoYW5nYXJhaiBTYW15bmF0aGFuDQo=

