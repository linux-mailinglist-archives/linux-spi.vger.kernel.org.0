Return-Path: <linux-spi+bounces-4108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579C942876
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A943F1C219DE
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3B1A76A3;
	Wed, 31 Jul 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="DOuxZtvW"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010014.outbound.protection.outlook.com [52.101.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7F450E2;
	Wed, 31 Jul 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412645; cv=fail; b=sSALoreKX6krOI17T7T/LR3pHTnED5QtTHc8XXGliR9IUpK17Jf9gXbvRaFszjf65macWBiZ75l/tMX4gSfSqIBFgs5kNtQDT/tnoHGiy9ex8XMHznrb9aQAkM+wVBV5tij7/BYtwse3g4eAWyOLFSvruG4ip4DacXqKbH7C4g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412645; c=relaxed/simple;
	bh=JDhbDV2ETQh7MvS+DOh3sm31l7WWNbEM8bi7wkyC7/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U1YS9C+eahs3M8WDBdlFKEkPUqp7QajtQmZeAgLztxZUmOrFtD55J2a+xvRWS0IN3hBwqB/mOYs1asruGX7SPHE3fLMD0pZ7Yt2ZAz2VLaHvat7Y1J5Z4O5jv47jzx2e/MLN38VnRYd2jiGu0GRhZ4nGB1b9nVnhl0n1rZqKWAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=DOuxZtvW; arc=fail smtp.client-ip=52.101.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFDpPeW8diPWMAbIdmDzPQH/zShHJgCOUADwepiQ9I8ZcIM2XLc30PTaG6lKfgBWJ1mgoC6UzAUyr489hRO5LpttmCz22ZKiVfif2Myz8+JsgnCxI6O/EaVW4iUpI15mhqWi+RrMFtPY/76KUmjkg3jcKcsT8EaEqk2YouL2ZXZpIPUAmGWPZ00AT5Oe2GNDmOotYi+bTXBw+V4H/M2feZLlEkhksRtAV/64DC6X4+tON8w6cxV1yEGADUteeMqV4AuyxFO4EoDsEt6Z5oXhsPmIG8dyLEMO9ywc3aEu8wvIE48iIfqUXd9BdLrUakMFAwRzoBM0D68qlOAsL/JvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDhbDV2ETQh7MvS+DOh3sm31l7WWNbEM8bi7wkyC7/E=;
 b=Nl+Dpv3wRRPB4NbyPHiB/nTKwDv2ZugVBFo79dm1zkksj9WwLPL/au1FKpmv/GEOMhWcPC7C8Z+XN2kKhAjRWQgEKhxRh97R9CMCXiIr/AM8YK4idf2876xbN9Q8+tjGp4DDxvbihiXbyAKjiXaJMOSXgqMpIz/BdiO+70K2dtFtjN6rtsYfsT0xlb/2b2ppZxDGw3JKpW17OMfiN0IYda/46CCJUQAAeCdDm4U14/WcyjRSrrM35/x8zZweWgQVWQmHEq6eXZlyDZ790EI/73Cl1UT4U/0DnAIk31OCbnsdHfiEo/6saylLolvIPiQQtzbn2NH0581CD+Y7u57r7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDhbDV2ETQh7MvS+DOh3sm31l7WWNbEM8bi7wkyC7/E=;
 b=DOuxZtvWJ9wlQ7GfJHg45Wpu/xpktgvLIqXyD7WBt3V/MOsyRaCL3EmwI4CCurI42EEcXGvEbJBL4wmuPA2u6CVXABc0tmT7P20sOUGLavkRb+RG+q72bM+5ugdMGPS+D9FiWxg/9EC/GcvQMZTagvo1FSkQWPmiNguBigtn+b4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB10301.jpnprd01.prod.outlook.com (2603:1096:400:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 07:57:18 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 07:57:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Mark Brown <broonie@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: RE: [PATCH] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
Thread-Topic: [PATCH] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
Thread-Index: AQHa4xt0EnK9lxDjQUmMbVqbEYz1TbIQdPoAgAACzgA=
Date: Wed, 31 Jul 2024 07:57:18 +0000
Message-ID:
 <TY3PR01MB11346B093976934667F06A85D86B12@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240731072955.224125-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXOZQqHWBXUVJzGfaaLgAnuBxbzp361obS6kRZi7kF3iQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXOZQqHWBXUVJzGfaaLgAnuBxbzp361obS6kRZi7kF3iQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB10301:EE_
x-ms-office365-filtering-correlation-id: a6d87a5a-f192-41b1-3cbb-08dcb1366693
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SE92R0h4TW9QaFNLQlppejFRRnJpQk9nUEd5cFNwNW9zMDhmRXhGSFFDMndO?=
 =?utf-8?B?RC8xQnFvMG9jV2F5a0FmMFpsSmVqemRHeGJXR3Q0SDFXWklZTmpCSkg3bmdn?=
 =?utf-8?B?SjhWRVAzSlpaR1oyVWRDbjlnUUJmdW9lTTU5dE9VM3RPZUFOT3dJcVA2VXdq?=
 =?utf-8?B?SVp3MlhiNEtUZmRRMWZlWU5uQm9rcTNIalg3V0xRdHBOTS9kdTU1QlFKOEN5?=
 =?utf-8?B?R0hEOWFnQnV0R201TTExRFcxSHVraEh1dHJXd1dJdzlNaXEra2dibHBiTjJN?=
 =?utf-8?B?eE53cjlaZ3B5ajVSU2k3QlVodUN2bmNYdlFxaVNicEtraUw5WFpwWG1aV3kv?=
 =?utf-8?B?eUlia1QxZmxZN3gwMk9tSitoeDloWEErbjIwQXJhWERWMC9RblVUUjR5WEtH?=
 =?utf-8?B?d0lXanZXMXYxbzJOQlJqSjhUMEdPY0lUOWt0bk81VDJPa1Fza256UENadXpa?=
 =?utf-8?B?ODVVNGVZbEN0b1ZyUEFnVWd4M1JpdjJVL3hZNjdTUnRKWGZpUitIZWZ3R25z?=
 =?utf-8?B?R3dXcExrdlhDV0NHNnI0a0dOamdLTmxTTUZvekgrNysyZCtjVU5uZEVwdkty?=
 =?utf-8?B?d3JoM0lHZVE1aFN3VUdCRGw3OW1QWWFVVGFPU3ZrL1M1WVVWNlErSzV4V3RX?=
 =?utf-8?B?UE5UUzgyVHB3cFBHREp2VER2cmR0dEI5bFd3TEF2bFArbzhXOEh6SlZCR3Rx?=
 =?utf-8?B?TXlEYldXSHN3RzUrenI2K0thQmNlb1dZQXlLcTNETTNjb3g5Nk92OVBhVEs0?=
 =?utf-8?B?M2k1WU5ZamVEaDA0ZkFHTTlUK3h0R2owaFVLUzN3WnFhcjhXMExmOTdTRHZV?=
 =?utf-8?B?N0N5QkVXc0N4TXNPM2Fhd2RjRFhqdHJqY29qRnYwcGdEUEZNcnZhakR1UWEw?=
 =?utf-8?B?aWw4SU1TWEUxYzBvT3JxamxGaFBZdXNwTmMzczUyaDMybmI1N3YwdkNGV1dN?=
 =?utf-8?B?SlkzVmJ4YzJqbW9wb0w5Rkxxc2dLc1FFYmUrbWl3K1R1VTdHdUF3Z3dYODdU?=
 =?utf-8?B?enNFSTd1ZC9jUWZsS2RLWTVPOTUrNFJvREMwUzBUWVFZcGxhT2NLcG1EN0xX?=
 =?utf-8?B?aTBOMmxmemVuN2NRT0MxYmN2QW9VbXVIWFp5QzA2Z2wzTXJOK29ydEx2S1ZC?=
 =?utf-8?B?aXpnNm10Q1gwRXlETjRNSkUxYVNpWEVWWFBkNDdtY2hDOUt3WjBWdnVPdlN2?=
 =?utf-8?B?emgrQnVrOUNVOWkvV2p5ZmhYU045Und5TmhlaE8yS0tRckpQeFBiYzRiNkJH?=
 =?utf-8?B?RG5kSHp1S1hPdWZqN0ZWcmJieXh5cEpzVEtmQ3M3RDJJdGM4Qmh1QWtwTmJk?=
 =?utf-8?B?VVNabWQvZGE4S0J5RWhESjcwMVZVMEVWQ3JFSzVEZU01b1o3MWlkYmpVQmhx?=
 =?utf-8?B?MFl1NjNrWm1mSlFyaUd4MWRhNzlNVlE0MnFYeWVBNUtMbHgxSkFZYi9nY2Yr?=
 =?utf-8?B?U2xoUzlUeFBpQnppcjNiSHRQS1BBWWluVWdyN29FYVFZa2NHb1JlYVVYWE5n?=
 =?utf-8?B?blBZTStzR3JLZXJ2UEVzbkZNajN4MmcwRTRXWGo2ZGkvUTUwTk5CdEdtaG5D?=
 =?utf-8?B?SDViby9aanRvMUpsOGtpSEVzWVg4dTA5YVMxRU1FTFp6bkU5U2dnay8vQlZo?=
 =?utf-8?B?MVdjUWptZHpVTHpLZzc3ZmxLSmNTL1hySHdmUHorNC82N3ZiS1UxT2VSZDlj?=
 =?utf-8?B?RHFjbm81TTJ3N2pxR3BjbktBREg5RFM2RnM3TVEwMFhvK0ZkK0YxMmoyY0FD?=
 =?utf-8?B?TzB6WTZocVdRU0toS2c3NzVnSThoYVZxSXRaQittd3pNUlJJTnRnNWVleEU3?=
 =?utf-8?B?cEZtZnhnSEd4d1h4RFJhQWtkWDRRNHFscWt0NVVsdEx1NjdjWHkwQ2cwMm9l?=
 =?utf-8?B?b0Nla2t3WU9ZTmN0OWFoN2Jhb2N3TkNxcDhKNWxhc0tzbVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnRPTTYyT0JSYi9kUmN0a2ZERy9vcGNTZDJnZnBsR0FFblVMZ0FqckN5ZVpZ?=
 =?utf-8?B?ZWdEOG16TTNla0RTVlpBZW1xOTI1NnBlV0lkUXdMVEdvNzI3MVRYdzVyNldp?=
 =?utf-8?B?OWdZUDdIb0ZqRjhMeG96UjU3a3BUTmErNlpjR0pCajYrMjBqMkU0OVloa2Vi?=
 =?utf-8?B?WHJtM2xOQ3lzUFR5eFVJd3JYL0NMYytTdHpMQzM4NkFuSXZLN0lpZ0lDdnQ0?=
 =?utf-8?B?cXo5UG11OVJBSUtNTlZPbm5qRkNpL3dyQUFMK1FGMVBQNkZiTUhkTjVkR0VD?=
 =?utf-8?B?QjBDcUQ5Z1R2Zk42OHpidGtUMVo1YkliTyswUVl2SVI0Nkpjd2ZlYTVBeDRS?=
 =?utf-8?B?VStERXZGaUFFL1JTVzJEdFA3amYwWmJXOWJ2aGdZSjArUUxrTUlVQzEzb290?=
 =?utf-8?B?a0RiUFljNUVmQ2xEQU5Hc0pyNHpFTmx6bzNiMlJKOStQbm83T2hqdjBsbnBm?=
 =?utf-8?B?QXVPS0hSV2FRdVBZTXlEbkdBd1pJQ2ZRQkZiYWxuQmxycHhNZStDM2RKUWhP?=
 =?utf-8?B?a0ZYbGJXcVVSL1RCWkVMMGo2VjdIbGNNMStPQzc1Wm9nUGZ2US82TjdFZW85?=
 =?utf-8?B?am5PU0RkYk4vamYvbEkyd2xRajUrQjgyY3NpQ2Z1TEk1ZEVKN2VubDFxQjRi?=
 =?utf-8?B?T1Z5K0pMVjg5V2JPQTQ2d1BsU3REMGNHbWlXdjlpU2QrSmFxckxvZkhlTG1y?=
 =?utf-8?B?UDAyQlBONUVCT1didmhIbnNHNURsOHYwRkpCZkM3OXZYUWp6YjlQdUlUU05L?=
 =?utf-8?B?RmR0Zlo0QXdId3pGOEdxU0tkdUJrNk40RDd4MEREeEVYNncxUmhiWDF4b1Yz?=
 =?utf-8?B?ZnBNaXlOay85UWdhdTd4MlNWWGxBRlBXckJWbHdRNC9OQmdVeHF4a1Z1Y2Js?=
 =?utf-8?B?R3UyVk5DVFJJTXpxbWkrVENCaHJraXl1U1R2VWtGeng2aHFNYnFtMXg2QXNj?=
 =?utf-8?B?QjUxTkZNM0Q1ZjNVOFY0TVBLWUhCeGMvK3RkZ0JQcTRUdTY1Q3VRSGZZeWIy?=
 =?utf-8?B?Q0RtMjVOTm9PTEhmeDFWMS8wdEErWm5GTGJDWUg2cmJ1Wm1vKzBsZFUvZldL?=
 =?utf-8?B?U252dktMSmgrelgrNlJ1dlNGTkVFeC9XYlpRbVFGbFV4bkZJeGRYR3N6eWtx?=
 =?utf-8?B?L3FIL0RMNDNINmllOW0wOFVzKzA0WkcyQStodlpLM3V1aWVoU3p0UFozSVpp?=
 =?utf-8?B?cjlmZ2prQXJ5TkJ0Qkw4SDlLUTczQlN3V3N2TXZ5YXdNNGFHMmlWZEIzVFcv?=
 =?utf-8?B?UW9xamRPTm9uVFFteHIwLzQ4bE1TUjZMVzJ4aEhOU29PQXpvZFNRUW5CZGdn?=
 =?utf-8?B?YWJ0cDY1c2FhSnFERkphZnd4bFlPQ2c0dXNiQ3NSTnhjOXJPdlZkWXJHd0ds?=
 =?utf-8?B?VXBwM0ZTNUJtSmZwRWkrUDB3U3VrWkU4bGM4c2h2UUtvZGhwMHVmZkZsWiti?=
 =?utf-8?B?ZnZKUGhlUmpTQ1REa3lYTjNYeGFENzMrVEtlUW1wNDlJUzVlWlR1YVVieVFW?=
 =?utf-8?B?OWhxQiswS3VQcUU0aDlzYzNJN3I2ZmlhR0NXMTVOTEFrc3dQOTFkQzRhaG1D?=
 =?utf-8?B?NDFUS0Jjb0tKTmkxdGFkT0NUODNBNVp0amVBQ1pCclVMWlg1NDFxRUJab3FX?=
 =?utf-8?B?cGpXWnc0dGxCRVhwalljYWJvT2ppVlptYldtVWRsMzlWZFcybGFxOTcrNlFM?=
 =?utf-8?B?WjA4bGRvei84bUtEUEdpd1h3bmY1U2MwZk1qVlY1bU5qV2tkN0h0N3BXN3Jn?=
 =?utf-8?B?YmhDYmp4U2kxMzZDdUhPZUIzSldoSXM3T1lNT3k0RU5BRVN3NGZoZnFCVFVV?=
 =?utf-8?B?NkVkSWdiRS8zU1N6Ulp6aFNKVG9wVGRCenZ4b3BLR2RsSDdXV0VGeTZ3dlUv?=
 =?utf-8?B?a3V6eW1PZjhjdXNCditxdXUvTnpWVCtWRVhLQUJnUnhnRlByVnhSdHZKLzNB?=
 =?utf-8?B?QjRhOW5GNE1QMGRFQVNFcURQMm0reVBnNUw4TFFMb2I2MjZtU2d0dmtRa2pY?=
 =?utf-8?B?VmZxSGlQZkpyQXFIRmI2Zm91Vmw1TFU3a3BkRDkwKytSV0JkR1hRWWp3bW42?=
 =?utf-8?B?ZlM4TC9oN2ZQeFM2ME9IZjM3SlgrSjlMalVHSTgyN1BmRElOcUttM3JtRDFi?=
 =?utf-8?Q?IQjcyjnIjBqvXaVkzJpu2K8M4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d87a5a-f192-41b1-3cbb-08dcb1366693
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 07:57:18.6513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9XfznWbY6n41Z7MDwIvQnuq162Fx9VJaekh5QIRZfMDtO8NubusoD1qfb/qwUKxD4KtZchK/PFuzs8ABK24EjE1B3PbXRsD08xKaKmBJ1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10301

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAzMSwgMjAyNCA4OjQ1IEFNDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHNwaTogcnBjLWlmOiBBZGQgbWlzc2luZyBNT0RVTEVfREVWSUNFX1RB
QkxFDQo+IA0KPiBPbiBXZWQsIEp1bCAzMSwgMjAyNCBhdCA5OjMw4oCvQU0gQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBBZGQgbWlzc2luZyBNT0RVTEVf
REVWSUNFX1RBQkxFIGRlZmluaXRpb24gZm9yIGF1dG9tYXRpYyBsb2FkaW5nIG9mDQo+ID4gdGhl
IGRyaXZlciB3aGVuIGl0IGlzIGJ1aWx0IGFzIGEgbW9kdWxlLg0KPiA+DQo+ID4gRml4ZXM6IGVi
OGQ2ZDQ2NGEyNyAoInNwaTogYWRkIFJlbmVzYXMgUlBDLUlGIGRyaXZlciIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiANCj4gUmV2
aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+
IA0KPiBJIGd1ZXNzIHdlIG5lZWQgYSBzaW1pbGFyIGZpeCBmb3IgZHJpdmVycy9tdGQvaHlwZXJi
dXMvcnBjLWlmLmM/DQoNClllcywgYXMgcnBjLWlmLWh5cGVyZmxhc2ggY2FuIGJlIGNvbXBpbGVk
IGFzIGEgbW9kdWxlIGFuZCBpdCB3aWxsIG5ldmVyIGF1dG8gbG9hZC4NCg0KSSB3aWxsIHNlbmQg
c2VwYXJhdGUgcGF0Y2ggZm9yIGZpeGluZyB0aGF0IGRyaXZlciBhcyB3ZWxsLg0KDQpDaGVlcnMs
DQpCaWp1DQo=

