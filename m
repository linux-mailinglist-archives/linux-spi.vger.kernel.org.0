Return-Path: <linux-spi+bounces-11567-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDBEC889AD
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D83AC91E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE00315D40;
	Wed, 26 Nov 2025 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F1I8PVHC"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3230EF6B;
	Wed, 26 Nov 2025 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145114; cv=fail; b=C9e94uqQfLm55go2EazeowamjD9DRL0vJxL/C91+fbmmBtvf4Wp1eL/bCvDbxJdOtYtDanxKHImbxI4hWKFvi1pqIOEAxoQ/HMpC87lyRhil6rZHkhxALW/A6+x2Xts8vgGctGfKuPfWV+T8lYjmDSCWamOE1mRHy/+GLnhsrzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145114; c=relaxed/simple;
	bh=HSJ9NPUm5ix/2/LPMRVHQNPayvAWiTIkNuJ40ULHRUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VW8zykhv28ViAcV7vUTuG/ZnHoiz2MprF+dLnVvP/yb1ECy0dY9jtn4O+VDbFBpaypkmCg2r737xPQdew+uFT8HcHXMSqMK+XqJFEvu1j29NrI9ifRlHk8ZHU4BN36C2k99QyX43/gvo9nUbthay1tiNYg2yr4Nfar+2SNlcViM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F1I8PVHC; arc=fail smtp.client-ip=52.101.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuyIQgVkVxJi7jPj+rFOnzx2vK9Qd6hESduddRk/LoxvhrHnWNS0ynSyPmzmDJWuqIKflDOHfwxWLH7+BBlotuvqfVTFVnCg1PFOuuppIzjmfE/fbt83mqzwIXQpcEIldh2qM8wUDdpJRvB4Z8gYhqeVwxDuxI72Z5QfZHFMGiLnPiwGiLCVhPHxJs74V21KnbTrs21wxRwJPqlnpzL/TSY7HiYV7aN1s6Gr8zth6L95Vx8wOjdU5Pu0EoL9wCu/rFmNc+0BNQvGXqRiGu6My8jsZZktaEeFuf5HT6X2VQf2aQxtMnjKgaHc4AqHC8yr/uI8ts0NBROqlAO8zsNAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSJ9NPUm5ix/2/LPMRVHQNPayvAWiTIkNuJ40ULHRUM=;
 b=jyHsEDcIfzZE5PPstPrQxkOw7DNYHxjDzW9UYJpz5b22kRRK/SRv7Xuy/NSXz1JlskMhaJSPr0oerzMPAi7m+tH1XFdlLtlw28Lyckl3NtJQ7gjHxeVwx/fS5yfs2HCMyyv0fL15ejwmwkUP7JjtVnfixpw9swx9VQhBC9XWDjCSRoiTfG37MtWP4FI+FfLssE1DbNfXO2LXiEqRXhODeHfOt6dunwtKRt/voUwLO15xKmsxUaOX3W4NrnBQitzHYGJNN/ucJHMuwn34EZha8emn/mtlHAazoik0P3hnUP2PCl3GhHdM5eHpPuyMSZ+OjbhsWjJwa9aHJtPXiwOU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSJ9NPUm5ix/2/LPMRVHQNPayvAWiTIkNuJ40ULHRUM=;
 b=F1I8PVHC92FjBQLJKIM6Diqdj3ND2sfSi8Uh+dbO+hrDFWaL6NvBqugN8dtpuwu3qzmxZg7WdIhEh3wbFaMwj/6o2FcmhfvjqpcPXh7m01/egpFm3GqPnZB+4RcaQYQRK0JWlowkzxKsc2X4gm7sZHItazXm/tJc+Ohn5/PgDSfx9XXxRzLyHwke+vDYlkkuOJlZIHz/lhbtrZSdFl66Gtb9IrKT0FnfphpslL/LUihasGdScXmswqW1Rrjyg1M9ETBmBXWlJU0f2PaEw0BN5wsuim95zIe/6cNMkqqkvb7D43F8lkSP3CvvsekV0c9btiq+E7tKp4HL/QesYKMW9Q==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GV2PR04MB11325.eurprd04.prod.outlook.com
 (2603:10a6:150:2a8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 08:18:29 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 08:18:28 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>,
	"hawnguo@kernel.org" <hawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length for
 ECSPI DMA mode
Thread-Topic: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length for
 ECSPI DMA mode
Thread-Index: AQHcXfNVDK4T0P1c8k+DMajAF1tbjLUEnMIAgAABMoA=
Date: Wed, 26 Nov 2025 08:18:28 +0000
Message-ID:
 <VI2PR04MB11147CB17F1418E3F600AD376E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251126-defiant-swift-of-domination-afa2c9-mkl@pengutronix.de>
In-Reply-To: <20251126-defiant-swift-of-domination-afa2c9-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|GV2PR04MB11325:EE_
x-ms-office365-filtering-correlation-id: 3ac2b9a0-eb00-440e-bba9-08de2cc46115
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWFzNURmRnZHckkyOVhPeW1lYkJYa1A2V1dxYjNFTUo4TldHWkFNYWI5bjVt?=
 =?utf-8?B?cDVGVGVzWUZLZWNqeGNYZTRObEVHdUJUY0R0RUhKK1NSZkFUOHFXcTBmWDdm?=
 =?utf-8?B?ZnA4enA5blNkSy8wMlNrRVpRSnpsMzdqYlgwWDEvQ2MxQ01HaHdRWEFtUGJC?=
 =?utf-8?B?c3BRRWMvL3lYTnVJeHNNVS9DUkl6OXl2M1lDbXlNOE1aZ2V2WWw1TlcvUzhM?=
 =?utf-8?B?Z0VqaVhacWRLT1BkSDF5MGJITmJCQW5NN3Zja0Z5SDQ5bUJNYkl4aXpZUzFi?=
 =?utf-8?B?SjZJQmtlZU90OExJbndKYTJXbys3a2xuVWZQUG1BL2hpWFB3YjVERVh1cVF2?=
 =?utf-8?B?dCtndDJ4eHpTZjN6ZjBERDRYK3M1R2w1T0haaDllQTRJc0JheXJONFNRN2N4?=
 =?utf-8?B?NHVIejdTOEFha1lVNW8yd2wyOVhUeDRmUkt0SkNEWWZBeUxrTzdidmNLQ2s2?=
 =?utf-8?B?bnlwQkE3Q2c0dmhkQTgxNjU2OGlBYnFCMEFUejdYV2taamdJWVg3K2ZaeG1j?=
 =?utf-8?B?QzR3UEN1SzQ4NUc2YlM5SWRtNEFKNnF0YjNUYzdOQTlvUDkzNHR0cEVCUStr?=
 =?utf-8?B?WmdubURrRzJ2YTlvNVpvVURPdFFxZGVSNXlYeXYyK1hPbVU0Z0JCRFZ2Y2tN?=
 =?utf-8?B?TDNhTFlLMFZYeXlKMUdpTjhSeWpGTURpK25xVEczd0lxYkRtdWFsUUpVWXEy?=
 =?utf-8?B?dUlROGJMaVZIdWVwbEZkU2kxU3VGblc3MFF6Z2VIQUFENWNEdUY4RGh0N0R4?=
 =?utf-8?B?aVplTXg2QjJsdzdkYjFyRno0bzZDaFBFSm5VaTRyaE5OSjl2dm9aN0pzVmIr?=
 =?utf-8?B?cStNR0FGNkdmakdTZ0JGcFJLcEdGWGpJcExUa2NxVERGeE1KQjc4Q1VsQnFa?=
 =?utf-8?B?TURnTjhudWxwRXBudlhWL1dxL3VXZjJ3bk9YbW94WWdsTTRLcHBQSFMyY3NI?=
 =?utf-8?B?RDJsVitodWlIZE1aS1NlWGU0YmlGNHRwZU1XdXVtUCt2ekJEYmh1cTFkYjdY?=
 =?utf-8?B?LzRocWw0Y0tOcUw4d2tRNE8vTW1HZjZPbXdNY2VXeU1YR0JScUZNTVJkNFhy?=
 =?utf-8?B?aFdpVko4OHNMaDVwcmFWRXgyUG5XUVJGUWQ3YnhsVGk4citkcmU5QUdzbWJl?=
 =?utf-8?B?NkhaYmxMTGFjUkFFWE9EdEswQnZjbTgxejIxcndyajNoMjdlY2I2OVAzLzZ4?=
 =?utf-8?B?cCsxQTVJU2g0aWtJeVI0ODVBQS91WUFXdk5CVk1hQTVSV3Y1aE9vUXdjazdE?=
 =?utf-8?B?eWNkSTY2c0lMN0ZQYTEwbkxtd2pBUDVUMWpza2ZZbVl4S3Fva1lsT3Y2cFZ2?=
 =?utf-8?B?SWx2aFphd0xsYW1ENnhuazVRSFpDM1hrb25vUWZ1eGlialJGU1lDYWpMTFY4?=
 =?utf-8?B?eFdUMWVvVmxjZHlpU0NBSDJ4WDhCbENyd1dHRmdETXZFREZyTFVXOHNVVmEx?=
 =?utf-8?B?cGZKZEtKOVdGVFdsdmwxT2tuMi9TSVJzQzRIa2dEMGdLaFZaSjEwMVY4OHJq?=
 =?utf-8?B?R2RHRGNNTkk0K2NkUmx6b2xGV1p3cXNRS0R4WEV3MzQzbmpEQnhvSkY1VzA0?=
 =?utf-8?B?K09HSngwK084WHJvczA5WjBxQzllZ0w5OExBei81dlhZUG40eENsZlpKOGpj?=
 =?utf-8?B?aHJQUUh1Z2RkNklVMHNNT3FoMHhKM2x5aW9zM2tyMXYwcmoyZ215NkJGODYw?=
 =?utf-8?B?TUUwZzljT1N2SDV6MkVrMmZ1VThDRlQ5VTJWdTF2SlA0MW0wTDVvN2RrVVNs?=
 =?utf-8?B?MFhFcXFIY1QrUFJtcGVBNkpmUzA1U3M4OGREd0RIQ21JK0cwblJ4SVdmM2Q1?=
 =?utf-8?B?UCtBR3AyZGNESkNLRUdsMXltYVBmTEFpSTF3YkNHSzdnR1IwNURjYUJKanFh?=
 =?utf-8?B?eGxOazRIMEl3WVhkRyt5c0Z4RUhhNzlKOExBWnQ4ZXBPaEE2NC9JL29sNVM4?=
 =?utf-8?B?TjBBYnNCenkzeUhRdFg2K3BwNU42ZkNqdGJ4dGZIUkhSRXA3MTUwUGVKekdj?=
 =?utf-8?B?NEE0S3B2eHBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTBXSXJ1QVdjYWd3QTdkK2FMU01kOXJsS0tKbTVLQUM3N1RCaCtEdndGYXBu?=
 =?utf-8?B?Slp6S2ozWmtFckZXYkl1TmtaL3F3VnpaeUU3M21hTHI5b3FYQm1JeUxmeTcr?=
 =?utf-8?B?cTFrS1VtZGN5a1hHK0IvUDlNSTlyTnJxbG1xOEVUTXhhQkxuV3QyUVBWN1gv?=
 =?utf-8?B?T3NlTDUrNUNNRXdjZENDVmhzME5pVTFQQTFzSXVjWkZsYmdxYy9SMDRidjR0?=
 =?utf-8?B?d2xwVEpNaVBPMFVrK0tpWHZia1VWaVlSaHRyNGtKM3ZKUEJ2WmlySm5iczVG?=
 =?utf-8?B?a0xScGloQld1Q253V1VWNDYybnZWUEVPZ0luOGRxaWoyRVlVWlRJUjFYSXBF?=
 =?utf-8?B?ek0wWVFDOFFzRU9OempsTnY1WGNwb09mUzVOZURuS3FTcnFERlNoZ1FjRmk0?=
 =?utf-8?B?RmplRzdRQ04yUFJOaldON2Q5T1laUHBCUVluZGw2Y2VxQ0NZMXpyVGhoVjdE?=
 =?utf-8?B?SVp0a2IvaE81T25lYmVlQUx1UEo1UmZVaHp4Smp4YTBFd21qUW0rai9qOHM2?=
 =?utf-8?B?NlYraVNJRnFBWHdvWHlGRWw3ZHltZjVuazE0OXA1TE4rT01lcklYWk0wRS9Z?=
 =?utf-8?B?YllPdnZ0Q1MwZGtlWnhDR2xaeG13bG9sbFdmaTQwR3I1WXViQU9WYzZUQXp4?=
 =?utf-8?B?d20vL1VqL3VmTFBzVGt6ajV4OHNxVFZoOVo2ZGJzZS9KaC9rSVUvL2ZLSHFr?=
 =?utf-8?B?OHZKL2x6cWRaUHFDVjRrV0ZnVHlnSElKSkNOMGxCVkFITHc2Q1JON04zYUU0?=
 =?utf-8?B?YXcwN0hKbXIwK09XU2JEZldZeEFHZVVGODNaNzR0aDJoRlE4WjQ4YlJPVk5q?=
 =?utf-8?B?MThBUlBCQ1dtMVc0OUFSMk5uTng5bVJyVjBIUDZXcy92Ukp3Q1lFbmhkcW15?=
 =?utf-8?B?UkEzTWZWVGdPMms3OU9BLzZnYVROTTc2NjJIOHVUZ0VHSHFiS0Jscm9yR1py?=
 =?utf-8?B?VkVwYlYvRnZnOVdVQ2xITndqWWUrN0VEbEFlaVE3d1pGQkphTkJRaTBCc01n?=
 =?utf-8?B?bU5aUTdWa0o2NzlrN1o4VkpPWm1sQnNvZmJvWFpxa1F3QmdwNHRsOXVENWxm?=
 =?utf-8?B?WU9XVFlpZmdRQTdkenNLTUE5azU2bFJMaUJNbEErMk9lcks3SjRBQzhBYWJV?=
 =?utf-8?B?dC80S0x4Zi9PSDNzYUJIN2svRTNqZ1ovYVdxd2dDcEkxMHJCOXJhd0lUR2dR?=
 =?utf-8?B?SHgwRE52eHV5NGNBS3puWWxZYkdYSzFVS0ZwM2tYdVJyMlBBaTFUK1FrR1J5?=
 =?utf-8?B?N3pKTGY5bnNmNmx4NCtjNGZIWkVTZDlMMi9XUTF6UmRhYnB0NnBoT212dm83?=
 =?utf-8?B?K3NOeVpvajZLMk9IUDdENCtFR1Y0TDVlM1h6dS9SMUFKT2EraWYxeFVjR2hH?=
 =?utf-8?B?VU9qM0t1akpKTm90a1JNT2ttcFB5MFYzZHN4dFhFdEF5MnRjaGJSeTI0WElO?=
 =?utf-8?B?MTJyb2lGaUJKV05nMW9oMHB6dXFPTk9lL3QxWm1NQ2RwSDhFZkcveFg0emhO?=
 =?utf-8?B?RVhjTXl3M0lrK2N2VUdQQWN0TFpsUVRvRVpFTFYzeVEreHJKYWxGdldJbXV5?=
 =?utf-8?B?a1IramhTUHBSaFVZcDdwY2R4MENaTWp2d292SEFoQnp0NWVHQk1xcTZkY3BZ?=
 =?utf-8?B?RkxtcllEZFdTY0xuSHkxZHZKMHpoeEEzY3FPODF1anRkOXNsQUVVUWVKOWdD?=
 =?utf-8?B?YXJOTmFxVmY0SmcrczZaY1lod1NQYmU4a0sxQVpSQVZoMmhrdDNLcnZKRXpx?=
 =?utf-8?B?L25QZVlDTWhoV2FKanZSVU1yR1lpWXZqR2lsTzgweWFnVnFQL1VwSnJXUVRT?=
 =?utf-8?B?NGJBMWRFUFp6VmlQQ1pyQmdCbVpISy9JTTBmbG1zK2h4UnZFQXRxWmd6Nnl0?=
 =?utf-8?B?bkJpVSttaUt6UGsycnFYM3doVHk2WFQ2VTNxTUtLRW0yam52S2wyRTVlVkNz?=
 =?utf-8?B?QzFEMHlTanAyZFppWkhyc25pdWZ2UmVRYTFoWElRU0NtUnI5Nml4YWhZeUdj?=
 =?utf-8?B?SWZ0Um9KYTJyY3FyL0s4WWtMWlVrMEhLRGhVRmJDd014ZWlQUXVucEtnVGNK?=
 =?utf-8?B?MG02OGt6NG1WSW02a1RudDdQck5lUDhNbnJTaUtoVlVQaVkwVktZemRkbm1E?=
 =?utf-8?Q?012tqwrDZFHF9Xilp6x09tlFt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac2b9a0-eb00-440e-bba9-08de2cc46115
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 08:18:28.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVYYmtvWAGEOOPJLQtLSpIm3/WBhqYmJGs/aNtAQi7wXVZx3gZcrV73p1ADSvfohld1UA0dGwwbSicCUwteKVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11325

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNiwg
MjAyNSA0OjEyIFBNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCA1LzZdIHNwaTogaW14OiBzdXBwb3J0IGR5bmFtaWMgYnVyc3QgbGVuZ3RoIGZvciBF
Q1NQSQ0KPiBETUEgbW9kZQ0KPiANCj4gT24gMjUuMTEuMjAyNSAxODowNjoxNywgQ2FybG9zIFNv
bmcgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQgc3BpX2lteF9kbWFfdHJhbnNmZXIoc3RydWN0IHNw
aV9pbXhfZGF0YSAqc3BpX2lteCwNCj4gPiArCQkJCXN0cnVjdCBzcGlfdHJhbnNmZXIgKnRyYW5z
ZmVyKQ0KPiA+ICt7DQo+ID4gKwlib29sIHdvcmRfZGVsYXkgPSB0cmFuc2Zlci0+d29yZF9kZWxh
eS52YWx1ZSAhPSAwOw0KPiA+ICsJaW50IHJldDsNCj4gPiArCWludCBpOw0KPiA+ICsNCj4gPiAr
CXJldCA9IHNwaV9pbXhfZG1hX2RhdGFfcHJlcGFyZShzcGlfaW14LCB0cmFuc2Zlciwgd29yZF9k
ZWxheSk7DQo+ID4gKwlpZiAocmV0IDwgMCkgew0KPiA+ICsJCXRyYW5zZmVyLT5lcnJvciB8PSBT
UElfVFJBTlNfRkFJTF9OT19TVEFSVDsNCj4gPiArCQlkZXZfZXJyKHNwaV9pbXgtPmRldiwgIkRN
QSBkYXRhIHByZXBhcmUgZmFpbFxuIik7DQo+ID4gKwkJZ290byBmYWxsYmFja19waW87DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsJc3BpX2lteC0+cnhfb2Zmc2V0ID0gMDsNCj4gPiArDQo+ID4gKwkv
KiBFYWNoIGRtYV9wYWNrYWdlIHBlcmZvcm1zIGEgc2VwYXJhdGUgRE1BIHRyYW5zZmVyIG9uY2Ug
Ki8NCj4gPiArCWZvciAoaSA9IDA7IGkgPCBzcGlfaW14LT5kbWFfcGFja2FnZV9udW07IGkrKykg
ew0KPiA+ICsJCXJldCA9IHNwaV9pbXhfZG1hX21hcChzcGlfaW14LCAmc3BpX2lteC0+ZG1hX2Rh
dGFbaV0pOw0KPiA+ICsJCWlmIChyZXQgPCAwKSB7DQo+ID4gKwkJCXRyYW5zZmVyLT5lcnJvciB8
PSBTUElfVFJBTlNfRkFJTF9OT19TVEFSVDsNCj4gPiArCQkJZGV2X2VycihzcGlfaW14LT5kZXYs
ICJETUEgbWFwIGZhaWxcbiIpOw0KPiA+ICsJCQlicmVhazsNCj4gPiArCQl9DQo+ID4gKw0KPiA+
ICsJCS8qIFVwZGF0ZSB0aGUgQ1RSTCByZWdpc3RlciBCTCBmaWVsZCAqLw0KPiA+ICsJCXdyaXRl
bChzcGlfaW14LT5kbWFfZGF0YVtpXS5jbWRfd29yZCwgc3BpX2lteC0+YmFzZSArDQo+IE1YNTFf
RUNTUElfQ1RSTCk7DQo+ID4gKw0KPiA+ICsJCXJldCA9IHNwaV9pbXhfZG1hX3BhY2thZ2VfdHJh
bnNmZXIoc3BpX2lteCwNCj4gJnNwaV9pbXgtPmRtYV9kYXRhW2ldLA0KPiA+ICsJCQkJCQkgICB0
cmFuc2Zlciwgd29yZF9kZWxheSk7DQo+ID4gKw0KPiA+ICsJCS8qIFdoZXRoZXIgdGhlIGRtYSB0
cmFuc21pc3Npb24gaXMgc3VjY2Vzc2Z1bCBvciBub3QsIGRtYSB1bm1hcCBpcw0KPiBuZWNlc3Nh
cnkgKi8NCj4gPiArCQlzcGlfaW14X2RtYV91bm1hcChzcGlfaW14LCAmc3BpX2lteC0+ZG1hX2Rh
dGFbaV0pOw0KPiA+ICsNCj4gPiArCQlpZiAocmV0IDwgMCkgew0KPiA+ICsJCQlkZXZfZGJnKHNw
aV9pbXgtPmRldiwgIkRNQSAlZCB0cmFuc2ZlciBub3QgcmVhbGx5IGZpbmlzaFxuIiwgaSk7DQo+
ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlmb3IgKGludCBq
ID0gMDsgaiA8IHNwaV9pbXgtPmRtYV9wYWNrYWdlX251bTsgaisrKSB7DQo+ID4gKwkJa2ZyZWUo
c3BpX2lteC0+ZG1hX2RhdGFbal0uZG1hX3R4X2J1Zik7DQo+ID4gKwkJa2ZyZWUoc3BpX2lteC0+
ZG1hX2RhdGFbal0uZG1hX3J4X2J1Zik7DQo+ID4gKwl9DQo+ID4gKwlrZnJlZShzcGlfaW14LT5k
bWFfZGF0YSk7DQo+ID4gKw0KPiA+ICtmYWxsYmFja19waW86DQo+ID4gKwkvKiBJZiBubyBhbnkg
ZG1hIHBhY2thZ2UgZGF0YSBpcyB0cmFuc2ZlcnJlZCwgZmFsbGJhY2sgdG8gUElPIG1vZGUgdHJh
bnNmZXINCj4gKi8NCj4gPiArCWlmICgodHJhbnNmZXItPmVycm9yICYgU1BJX1RSQU5TX0ZBSUxf
Tk9fU1RBUlQpICYmIGkgIT0gMCkNCj4gPiArCQl0cmFuc2Zlci0+ZXJyb3IgJj0gIVNQSV9UUkFO
U19GQUlMX05PX1NUQVJUOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4N
Cj4gdGhpcyBkb2Vzbid0IGxvb2sgY29ycmVjdCwgeW91IHByb2JhYmx5IHdhbnQgdG8gdXNlIGEg
In4iLCByaWdodD8NCj4gDQo+IE1hcmMNCj4gDQoNCk9oaCEgWWVzISB5b3VyIGFyZSB0b3RhbGx5
IHJpZ2h0IQ0KQWxzbyB3aWxsIGZpeCBpdCBpbiBWMn4NCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4
IGUuSy4gICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgfA0KPiBF
bWJlZGRlZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4
LmRlIHwNCj4gVmVydHJldHVuZyBOw7xybmJlcmcgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01
MTIxLTIwNjkxNy0xMjkgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZh
eDogICArNDktNTEyMS0yMDY5MTctOSAgIHwNCg==

