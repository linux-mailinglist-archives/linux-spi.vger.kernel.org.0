Return-Path: <linux-spi+bounces-8074-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7167AB31C9
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 10:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C6216B6C4
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEAF2561A9;
	Mon, 12 May 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LnDdWHlt"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714528382;
	Mon, 12 May 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038832; cv=fail; b=d/n5Vu0UlTaVxnpfhKNu56cl1NXqm7L11XQD7B7XpCYRsmal28N6GhHGR7zBUjHZj4+kAb0g32xRV1RS5WYndDwJLh3OOBHSJGolmmbAiBJ3d5y4TfZp7V9uVGyw4wjVWL4j1DN2oS+CAATIIERCkU3vCfSFBgTZxE46ba/Y8NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038832; c=relaxed/simple;
	bh=IZ9wJXhK2aaRzir6I/kfiSob+d/9+9su1cNOo/I3lPE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDixLdyyll1RR52ePredobpIwtWSg1AO8w3uiRRWtc7s4K7IZEVOmEP4eVNUuvTtPvoc5z89rJBblpE1bSCUFss34VUSTRY8K7JfgA4kPAdfTUgW6wNxeieMrrpwZCL/4qZKb8UrhfYdB/y7YEjKXVlJFiJZwKnvgPkrDaGEiYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LnDdWHlt; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmtXF4TUh9fnrBE1cCaA15cRHWqZ24Ww6LDhAcH2M5WnBSYufLg6s6Wq0MJVCBu22lYOkYYDTYrBX+ScjFPbqaSnwSL7DtVrAyBi/Jg267nEA4pLBwG3n+Cpqem7FDoi1BiEDAY/uW/AdZ+k5w8m1+441L8ElWrTDOX9FgRZ1mh98H1PVvlAuObUspNbKbbGMlShVHvaABYqtgaaqlOx82UWK5LfkcUu1cIrYG/vEQDC4txp4Y2sGiQHzqAdyc9AquzwqLtLR+tEGx1Tt8as2TI3y9fQmHdpP26pImO9DhI3rNHuLZCOP7r0ULu/3JKnyZvBLzezs/WqHC2IHB30EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ9wJXhK2aaRzir6I/kfiSob+d/9+9su1cNOo/I3lPE=;
 b=d/pxxFXDn5W9OKTi+tSOWltJVE7FzmkdZ5RDNh9U7w7lG8VARMl/YVLdLy8UY+N2WyijlQYEftfJntjfz66/MS1eZJYwNTHmwhzBJll9E/hzFAzJrqLvGUTWkYx7nUl4iJjv3qoCbwbP1umw6VDY6UYh1qtdI9ExDRETkAPvU6p0DB4qneqUupnCX5vgS4eaYxAuy4g/BbkOac+bMVB3FCzndyfbECneGosyr+ltyeuq2zJVPyNSKdDbqvKrSWgNHKA5RpOuELbtJOce9qK0wek8r1/TvQJKX/niRGyl3Wbp8BwPD36ALA+WLkuuYbE5cw7WJmxQgh4HNLFXsoJnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ9wJXhK2aaRzir6I/kfiSob+d/9+9su1cNOo/I3lPE=;
 b=LnDdWHltFXtpnNUEOQsggvc7SZceWuuNs+o6igkAwH1QPFUcKcmPWoPk0UakVoy+ROlUhM6G1Zqmt/kuuYF7z46LbVqMpqCobf2ijfxlw92JM3sHat3zRrhhklvjQJJ3bzGtWpn3oe/D1HRq5mSxAEDxmeR16dK6/dTGdyVgb+07mIROan2tyASduUCdLSUHRSS9p3ePs1ojfuNdPZH/p2DP0DuRWveSYkHSYv0y4k7Pm8jU4+aoFmNRJ8xjE8M4Rm2dcryomVycrxwg1D+uic0r9DNCeo+Mge9jbg2D22CjY4FtqssrijtpsBlaL+mtnOewriejY0dh7YiXeBXmfw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB9860.eurprd04.prod.outlook.com (2603:10a6:800:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 08:33:46 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 08:33:46 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Pratyush Yadav
	<pratyush@kernel.org>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, Luke Wang
	<ziniu.wang_1@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "michael@walle.cc"
	<michael@walle.cc>, "p.yadav@ti.com" <p.yadav@ti.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>, Han Xu
	<han.xu@nxp.com>
Subject: RE: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
Thread-Topic: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
Thread-Index: AQHbuOhFdXcNiHAEPkKtP9IZKZSLZbPG9ySAgAe+FJCAAAX7AA==
Date: Mon, 12 May 2025 08:33:46 +0000
Message-ID:
 <DU0PR04MB9496CB86FFAA35002A9B6B3D9097A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References:
 <DU2PR04MB85678048FE8B475B1E323E0AED802@DU2PR04MB8567.eurprd04.prod.outlook.com>
	<10b40148-b949-442d-9d43-0db09517269a@linaro.org>
	<mafs0zffo3gea.fsf@kernel.org> <87cycep8go.fsf@bootlin.com>
In-Reply-To: <87cycep8go.fsf@bootlin.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|VI1PR04MB9860:EE_
x-ms-office365-filtering-correlation-id: 05a8f847-27c6-4507-fec1-08dd912fb61b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTFDZ1pWdlRIWGFKWG1NWGhUZ2NQa3lxL0tjT3dLbUhqSEFkVkY0UTBkbUsr?=
 =?utf-8?B?MmNTOHFmeWZnNnJYNXNrSVo2S2VvWERKZ1lEemJ6MW96d25wbWdEVHU1N0VD?=
 =?utf-8?B?bW82amdZYzZrUi94Um91YW1Dbkl5d1ovaEVpWGdtUlFpZlozdEZ4T2tVTVZB?=
 =?utf-8?B?Y05uSDN4eVA4T29YeU05Q2ZRWER5bHRJMUg4d25KUTlMemJKSTNaZWhJZFdn?=
 =?utf-8?B?aXRzRGhlRyswYnE5NDdocTAvdHhTNnBLNFp3aElGMHp6V3c3QVpueit4NjJs?=
 =?utf-8?B?VnV2cVcrTGFDb0FFcktWM2Nzbk0waWExM3gyU2p3SFpvSXV6dTZFMzZ3OTh3?=
 =?utf-8?B?Umc0RThmOUF4YjVHSlg0U01FeW1LOTdwWTJiZnpmb1dJM3BwYittaWRqdGF0?=
 =?utf-8?B?ME9GN2hTTi8wdjBtN3ptNFIrVWVYblJlSk1PcE40NElzU09QZk1iNU94engy?=
 =?utf-8?B?SXJqWEc5ckYrMUlLZkRUaFlYYzl1NmJ1UGZUOU9sWlFsNnczaUUxM0hhdnJ1?=
 =?utf-8?B?aUhJVTZVR1JuVkZOYTJjTlp2akxkK3BoRnJmeGJpYmVKdjFsQTl3TSsweU9W?=
 =?utf-8?B?Y2J6eEhKZTMwZkR0eHJCWngxWEhyQkdZU3hZYno1dG4rL3g2ZS9WUDRFc1ps?=
 =?utf-8?B?UVNUL1E2VFZkc2lrY0haQ0FjbDY4aTA2eW1MVzdmbzNFYzgrNXJYY0g1cXdW?=
 =?utf-8?B?SHVmN3BlY2JnOXVjNExkNU9kMVRlM1RWTVRwYUZra0hOMXF5S0FVZFdnOWo1?=
 =?utf-8?B?bEYyblJ1Y3FUK3EzSGZySFpJUER3YUxWWTViODBxS0loZ0k2UnJCUitEMWhv?=
 =?utf-8?B?Yk8rVkl2RHJYR09QMElSREZVTStPQm9NUFJuSHkrUVZNb1ZrOVdLQWFTVGNt?=
 =?utf-8?B?MDZJbWVKOGdhdVV6NkdZZS92TWRBZzZRWWlGalhCRnQyODRlL3ZYeW1iT3R4?=
 =?utf-8?B?cyt5NGFRWHR3Q2RWbE04d3dGNWRqeFh4ME1rSmUrVTlYUytqSTVXOGFGUUhV?=
 =?utf-8?B?U3hZalI0S1NtazVXU3JpSTdtRVNTT2Y4dnJIUTlET0YwNTdEMVlPdjNOdjFV?=
 =?utf-8?B?OU9qMVV0dDdHdmR6ZHk5UTNLeVF2MWtjcVA1M3dEQjExNlNMWVlRUWhnN1B6?=
 =?utf-8?B?ZUw1aUE3MDBQajRvQlB3ZHhSWXgrdzhBT0hzZ1VGTUlYczFMb2luV3JqNDcr?=
 =?utf-8?B?aUZRbzkyUjBPVDE4QzZvdktTQ1lkNE9PbVdqYVlSd3YyQXdFRkdRNVorVXZQ?=
 =?utf-8?B?YUlvUGNmejBnbUh3ckxlZWVaWk0rTWI5OStsODc5bmJtNVkvNkFYUXRLU1Ra?=
 =?utf-8?B?Mjc5aUVicnpXbjlvNjQ2SW1xcU9QV3pBSkczVHB4MUZkcXhQRHhDQVJUbkpO?=
 =?utf-8?B?V01VWDYvTmhUYTY1bzZJZ0JuY09HWFU1Q0FpSVVVdFBVL1lUdnQ0TXNMRFAz?=
 =?utf-8?B?ZmYxTzBmeHVZUlBsRm1PbVNSY0dKSTU2cnRYUnJmR1MyMHhFOFVxQTBMT0J1?=
 =?utf-8?B?bmp2NkpFWFlLTWtJU2dTN0lQVVhBSWlZd2lKeS9wK0tUaHBlaW5Wb2lWNXVL?=
 =?utf-8?B?WGE2YVhIYm1nUG0vNkdXOEd5OVhib1dlR0YwOUNKWFE2SnJFS1BDa3dpTEp2?=
 =?utf-8?B?WFE4YnF2UzhoK0ZtWjZ3eTA2NWt0UGNGUW8xdUEwbno2U0E0UTNlVkVaR3lu?=
 =?utf-8?B?RXdMb1dIZ2pZWndoQkRBLzJWMnNSUzNaeGRWMTJlTjAxUzhyVmpUVHZlM3ho?=
 =?utf-8?B?T0VwUHFMRlpGRmF1aWNYdHZkSC9RWUFSSXAzeUgrdHNwaENzSkxJdzFUMVRG?=
 =?utf-8?B?Wnd4RmhVckcrMERyNHhsQ1I5Zm1qWlFWOElaRzF1RTR3M0grVU52QmxsSXdh?=
 =?utf-8?B?MkU0T1pKNmFoQm0ySy9jcW9oNjdDcFVVMDNPZzF6ZmdtOHQ5VnlKNHIvVW11?=
 =?utf-8?B?M2tMMnAyY1dFNWlLQVJtQUpNZHNZM1dsSVVSbHdOdmN5L0FIaDU1T0R0VE5u?=
 =?utf-8?Q?yOC1EiBDOlv86FmML/KGN/AJX5TQCI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MldKaklKK3lmcWprTnBOaU1YTldoT2R5NFF0b1g1RytDQmFyY1R1NFhsaWdh?=
 =?utf-8?B?TEt5SGlXcEt3QnRpTlZndnZaelRIR2ZSbVRMNWttT0dCM1VuK204eFhraHhr?=
 =?utf-8?B?b1lXSXQrNzVxbHByRmRRSjdYc3BnZkdhZXgycDRURGFRUkxFUjB6UUtyU1Q0?=
 =?utf-8?B?VGxRM0dHeEVqTnZHQzF5dkNnS1JFS3RlTmtBZnRia21Zbk95TWlGL0R5TCtF?=
 =?utf-8?B?RzBuNmZSdGM3YldGK3lmTlVzQXY4cmlkb2dPbUp0K2Z5QXhIcTVzWVF6VXZh?=
 =?utf-8?B?NFQzNnF0bXIvTzVUZXNRenphOFZCRmtVTXZXOVl5MjVEQkpuZmZCenJtQWow?=
 =?utf-8?B?V2RuWHFNdzE3ajVvWVdwc1IzUWU2TVV1cDVzbnErK2FTeWhuTjFiT0c3R3Fa?=
 =?utf-8?B?NHZIeWJZaDAvVW8vU1R3S2JDdGhLNTdYL2lqNndEWFU4SWRtSGdrelgwMW9S?=
 =?utf-8?B?amk4c0w1cWNGSEFCMFFsWjFKZldkbFhXT1d1Mm0vbnlyU0FFUFJMNFF2aTR6?=
 =?utf-8?B?SFZXRm9rOWdkRHZmNlFRTTJhWjBkSHdwNHh3R0FKelpsOEc4WTFJRGpDRGJH?=
 =?utf-8?B?c01DZ09aRzh6YnI3UzR2OTJxbjRhRkpFbVNGajRUMDdrRzBpemFGVVhoNHcy?=
 =?utf-8?B?aGppaVA5ZFp1MG5Wd2RxTFdOU0o4WVhhd0s2UzFHTXJwQVYySS9ESzFYMWZR?=
 =?utf-8?B?cjU4M3Rjc2hoRG5IUWFmQUtYS0xTd244eGlZQjVUVW5BSTZ4bWdNVU1pY1dP?=
 =?utf-8?B?a09acmZZZ0VGMkJSbjkydFNjREU1NVMwb2Jxa3FaU013NEk1VHIrUkJ1Sml6?=
 =?utf-8?B?dUpyVGpFeEJ5TkhnMGpjQXZnL09nZmJHanZqcnp2ZHVDeFU0czUvR1ZRQmta?=
 =?utf-8?B?Vk56bVhvUUVmcTBxbTYxeWRHS3ViMlg4emdlTUpLWHNud1VId3lmbytIb1J6?=
 =?utf-8?B?c3IzMGpnK28zTWdaRnJuQnJNWFRPMXhzWUlyMUNnVEtGMmxlaXVDd1c5MXlG?=
 =?utf-8?B?b1dIUzZreERrTmtPaTVFU0ExRFo3MEhXNEZnaENUNmZBVzk1S2JWdjc1VlVk?=
 =?utf-8?B?TUc5VzgxMjM0RitmUFY1UnI0WkFQeWFEQjVkMjFSOXUvZDlFWHBtU0xlZ1ZC?=
 =?utf-8?B?N0pUTHVWUythSVRtNE45Y05PdHA3SGdUazhCS2tJaHl6TkNaSXFmVEVXcTVR?=
 =?utf-8?B?a0N4NHowOVh0WlNYYllZdXYvTHRZZmZ5WE02eS9HK0J1cFkzYXJOcVVhUXlm?=
 =?utf-8?B?NVlJNG5pd2M1ZGYwb1BmTC8zUWZCNHc2aFFiallwVTl2cUUvZzhKU043N2t3?=
 =?utf-8?B?LzJmYmNBTHMvUG13NTZuMGNwM1BLKy9ZejJhbHFOOVVreGVuMEcvN1VITDNw?=
 =?utf-8?B?aTVmOWFNdlFxcFdWbXVFNjR2aE41c1h1ZnNqN29VejhOT0NIeUtmKzc1elpJ?=
 =?utf-8?B?NnBUUGRvNTZSZmV1djNhSzBwY2VZTXo2WnphMXRieGNZYy9lbXpjODNuSnh4?=
 =?utf-8?B?MUFGVitDd1ZONkwwRDZZNk9USFRobW9NQzg2aE5KUjREaG45M0t3REEyNjB4?=
 =?utf-8?B?dXRkSU5FYnlSWTFmekdsaTBHZnoxaHA2c2NwbEgvazUvLy9yUTBCMEk2bzNm?=
 =?utf-8?B?U0xTSDlCZmJXR2NrbkU4SE4xNWd2Y2NqY1hzeVBOeE5PdFlWTnZOVk91ek1O?=
 =?utf-8?B?alBoSW5lL3dNVTNFZ2JsWW9tVWtEUjNObXdXbFdwbitEelExTGx5T3labW80?=
 =?utf-8?B?cDdaTHFBNFl6WmNhNVJ2Q3gxeEFrTWpYMlhEVHptcHd3eGV1UGRWVzZkSTcw?=
 =?utf-8?B?ZlFYckliYzZJQzNvR1NydmtjcUhQazdMUXJhSEFXUm4raDBqUDhjeTlpYVAw?=
 =?utf-8?B?b1FKZ1JiTGE1QTJEUVEzN042aTFyOSsxNVV3WGlRbjBjRWcySVdoNnJuV2RM?=
 =?utf-8?B?MGptZ09rSFYxVytIajhybmFhek4vQXc5T3B3c3lWTGNjTzNtTE1ySkU5K3Jk?=
 =?utf-8?B?cGxtMHA1WVlyWUdhNEhtemprVjYvQ09NQ1JmTVBiVys0T3gzdno2WTdhNUVV?=
 =?utf-8?B?dVN1NlFmYVFzWUwzZzFVZ1dLR2Z6OGlJRHRqMXRKeGl1TkJrNUdGZXA4Z1E3?=
 =?utf-8?Q?wGRo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a8f847-27c6-4507-fec1-08dd912fb61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 08:33:46.1083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4jhoLzxVH8CrMfUpW42aTIwna0A1H+AWMyjG+Hzbogeej4XsNNWfPx/7rl1L6V5iOtZ6hp6MpwdPM6LaxV9QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9860

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTZW50OiAyMDI15bm0NeaciDEy5pelIDE1OjU3DQo+
IFRvOiBQcmF0eXVzaCBZYWRhdiA8cHJhdHl1c2hAa2VybmVsLm9yZz4NCj4gQ2M6IFR1ZG9yIEFt
YmFydXMgPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz47IEx1a2UgV2FuZw0KPiA8emluaXUud2Fu
Z18xQG54cC5jb20+OyBicm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1zcGlAdmdlci5r
ZXJuZWwub3JnOyBtaWNoYWVsQHdhbGxlLmNjOw0KPiBwLnlhZGF2QHRpLmNvbTsgcmljaGFyZEBu
b2QuYXQ7IHZpZ25lc2hyQHRpLmNvbTsgQm91Z2ggQ2hlbg0KPiA8aGFpYm8uY2hlbkBueHAuY29t
PjsgSGFuIFh1IDxoYW4ueHVAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA2LzZd
IG10ZDogc3BpLW5vcjogY29yZTogYXZvaWQgb2RkIGxlbmd0aC9hZGRyZXNzIHdyaXRlcw0KPiBp
biA4RC04RC04RCBtb2RlDQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIDA3LzA1LzIwMjUgYXQgMDk6
NDM6MjUgR01ULCBQcmF0eXVzaCBZYWRhdiA8cHJhdHl1c2hAa2VybmVsLm9yZz4NCj4gd3JvdGU6
DQo+IA0KPiA+IEhpIEx1a2UsDQo+ID4NCj4gPiBPbiBUdWUsIEFwciAyOSAyMDI1LCBUdWRvciBB
bWJhcnVzIHdyb3RlOg0KPiA+DQo+ID4+IE9uIDQvMjkvMjUgMTA6MDMgQU0sIEx1a2UgV2FuZyB3
cm90ZToNCj4gPj4+IEhpIFByYXR5dXNoLA0KPiA+Pj4NCj4gPj4+IEknbSBmb2xsb3dpbmcgdXAg
b24gdGhpcyBwYXRjaCBzZXJpZXMgWzFdIEF2b2lkIG9kZCBsZW5ndGgvYWRkcmVzcw0KPiA+Pj4g
cmVhZC8gd3JpdGVzIGluIDhELThELThEIG1vZGUuIFdoaWxlIHNvbWUgb2YgdGhlIHNlcmllcyBo
YXMgYmVlbg0KPiA+Pj4gbWVyZ2VkLCB0aGUgcGF0Y2ggNC02IHJlbWFpbnMgdW5tZXJnZWQuDQo+
ID4+Pg0KPiA+Pj4gSW4gZmFjdCwgd2UgYWxzbyBlbmNvdW50ZXJlZCBzaW1pbGFyIHJlYWQvd3Jp
dGUgaXNzdWUgb2Ygb2RkDQo+ID4+PiBhZGRyZXNzLyBsZW5ndGggd2l0aCBOWFAgRlNQSSBjb250
cm9sbGVyIChzcGktbnhwLWZzcGkuYykuDQo+ID4+PiBDdXJyZW50bHksIHdlIGhhbmRsZWQgdGhl
IG9kZCBhZGRyZXNzL2xlbmd0aCBpbiB0aGUgY29udHJvbGxlcg0KPiA+Pj4gZHJpdmVyLCBidXQg
SSB0aGluayB0aGlzIHNob3VsZCBiZSBhIGNvbW1vbiBpc3N1ZSBpbiB0aGUgb2N0YWwgZHRyDQo+
ID4+PiBtb2RlLiBXYXMgdGhlcmUgYSB0ZWNobmljYWwgcmVhc29uIGZvciBub3QgbWVyZ2luZyB0
aGUgY29yZSBsYXllcg0KPiBzb2x1dGlvbj8NCj4gPj4NCj4gPj4gSSBndWVzcyBJIHN0dW1ibGVk
IG9uIHRob3NlIHNtYWxsIGNvbW1lbnRzIGFuZCBkaWQgbm90IGNvbnNpZGVyIHRoZQ0KPiA+PiBn
cmVhdGVyIGJlbmVmaXQgb2YgdGFraW5nIHRoZSBwYXRjaGVzLiBObyBvbmUgY2FyZWQgYW5kIHdl
IGZvcmdvdA0KPiA+PiBhYm91dCBpdC4gUGxlYXNlIGFkZHJlc3MgdGhlIGNvbW1lbnRzIGFuZCBy
ZXN1Ym1pdC4NCj4gPg0KPiA+IFllcywgaXQgc2hvdWxkIGhhdmUgYmVlbiBhIHNpbXBsZSBuZXh0
IHJldmlzaW9uIGZyb20gbWUgYnV0IGFwcGFyZW50bHkNCj4gPiBpdCBmZWxsIHRocm91Z2ggdGhl
IGNyYWNrcy4gSSBkbyBzdHJvbmdseSBhZ3JlZSB0aGF0IHRoaXMgc2hvdWxkIGJlDQo+ID4gZG9u
ZSBpbiBTUEkgTk9SLCBhbmQgbm90IGluIGNvbnRyb2xsZXIgZHJpdmVycy4gU28gaXQgd291bGQg
YmUgZ3JlYXQNCj4gPiBpZiB5b3UgY2FuIHJlc3BpbiB0aGUgcmVtYWluaW5nIHBhdGNoZXMgb2Yg
dGhlIHNlcmllcy4NCj4gDQo+IFRoZSBmYWN0IGlzIHRoYXQgd2Ugd2lsbCBoYXZlIG9jdGFsIERU
UiBzdXBwb3J0IGluIFNQSSBOQU5EIGFzIHdlbGwgYXQgc29tZQ0KPiBwb2ludCwgaGVuY2UgYSBj
b21tb24gc29sdXRpb24gd291bGQgYmUgd2VsY29tZSBhcyB3ZSB3aWxsIGxpa2VseSBmYWNlIHNp
bWlsYXINCj4gcHJvYmxlbXMgd2hlbiBwZXJmb3JtaW5nIHRoZXNlIHVuYWxpZ25lZCBhY2Nlc3Nl
cy4gSSBkb24ndCBrbm93IGhvdyBmZWFzaWJsZQ0KPiBpdCBpcyB5ZXQsIGJ1dCBpZiB3ZSBoYXZl
IGEgZml4IGZvciBTUEkgTk9SLCB3ZSB3aWxsIG5lZWQgc29tZXRoaW5nIHNpbWlsYXIgZm9yIFNQ
SQ0KPiBOQU5ELg0KDQpDdXJyZW50bHkgZm9yIG9jdGFsIERUUiBTUEkgTkFORCwgc2VlbXMgZG8g
bm90IHN1cHBvcnQgOEQtOEQtOEQsIEkgY2hlY2sgd2luYm9uZCwgb25seSBzdXBwb3J0IDFTLTFE
LThEIG1vZGUuIFNQSSBOQU5EIGFuZCBTUEkgTk9SIHNoYXJlIHNwaS1tZW0uYywgYW5kIGluIHNw
aS1tZW0uYywgc3BpX21lbV9kZWZhdWx0X3N1cHBvcnRzX29wKCksIGZvciBEVFIgbW9kZSwgdGhl
IGNvbW1hbmQgbXVzdCBiZSBEVFIsIHNvIGRvIG5vdCBzdXBwb3J0IDFTLTFELThEIG1vZGUuIFRo
aXMgaXMgdGhlIHByb2JsZW0gSSBjYW4gc2VlLg0KDQpXZSBoYXZlIGxvY2FsIHBhdGNoIHRvIGhh
bmRsZSB0aGUgb2RkL2V2ZW4gbGVuZ3RoL2FkZHJlc3MgaW4gZmxleHNwaSBkcml2ZXIsIEkgd2ls
bCBwcmVwYXJlIHRvIG1vdmUgdGhlc2UgdG8gc3BpLW5vciBjb3JlIGFuZCBzZW5kIG91dCBmb3Ig
cmV2aWV3IGZpcnN0LCBidXQgZm9yIFNQSS1OQU5EIERUUiBtb2RlLCBtYXkgbmVlZCBmdXJ0aGVy
IGVmZm9ydHMuDQoNClJlZ2FyZHMNCkhhaWJvIENoZW4gDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXD
qGwNCg==

