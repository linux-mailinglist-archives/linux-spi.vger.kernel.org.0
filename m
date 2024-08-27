Return-Path: <linux-spi+bounces-4335-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB929605A0
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 11:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF063B235E9
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 09:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0719D886;
	Tue, 27 Aug 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hcCRTpZD"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF419D08C;
	Tue, 27 Aug 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751035; cv=fail; b=BKH+5xHt+PGAtf+SVJG9OqNvAh8lKwsInMBcHdeqgqjBy1wSnO8sy1tqR8ISlFUKQ2O/xJPZHFZywxg3m8rmWdRrn8Y30vPLD66GUdCY6LSaYQtAYMEfkEnizXx5iteVCYqhKUNtebZqB4WYOceK13nKZsGIPFJM1RiM17U0zms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751035; c=relaxed/simple;
	bh=FJGpbQOb+W30ZietIQcZCoYWsxkg1iOHdn/53CPI1SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UxvyWlJO+FIvfoKMPO9foUiuG+o93/oIuQxrdzolV8rMomy/HsPCW1t6LMzV9Z3STrLq1cLZIhQRNJ28W0RI7ZqCKo4tCVy5LPFFRm6XDhjFPyk7Ji9V5x3yyhYFvvzNf9AvUwQ38rNbrkBCPhFjoVGb+fQDDlO2qrVjHy79XAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hcCRTpZD; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGgyk57saBpddsFT0t/t7GhR93Y6/2p04dxc1tsRzNXku6cHEB0pmqRHjDxDW58buQbF318U7N4CeZuKBssFL1/JnrCnvrSPtVaUwhFCJ5UCLvHaV8/fwpBun3026TniEKqklohAMpKIaD1LUaJhn09wwrTZPb2e9Hc+nbXPdrGDquWPdMuasWok1hLXkv0CdJ9FxbGowHCUqOJeLph4byvYevruxEcASBOqPj4nPD3Lfk2nvJGt+bF2y/73xMPIDp+Q54o7TGRnQkm2LMpR+y0oXO0KRaanGMaIn+6zrx8vvQD+8p1hlaBOkqqzIqXVx/m+GS6+HTMeO934ubb7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJGpbQOb+W30ZietIQcZCoYWsxkg1iOHdn/53CPI1SM=;
 b=xKaU/44uo4absa5HBE+Ule1LIcCdTpVlW6qwPSb6bFp1BhPxJpaV8dnoduN7XXdcrIV/YNG3bOAV2vzAzILFxQPbDT3JYi4F30SxduTd2H00kuJIPxE2I+T3+wQBo6rm6pylafYQZDziakpdaoxfEKz/0BB2ABej/JaqlQNWm1A3naRfuZ0TyHWx0X8Wb6R97GUGEbrrMyZYIs6cPsMbR2jMpV7cpNSBG0uvetI1yh30Fd/0Vn9zpK8ZY40i12pLpdbfIqCwLx+9ADZT3pgcuGu3VjP67kE9hSX5U+zai2IoUer/1UrWcgeov3bohBbQH8Yw2LwUWCrOUq/e4IBOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGpbQOb+W30ZietIQcZCoYWsxkg1iOHdn/53CPI1SM=;
 b=hcCRTpZDsmN0/oq71pBIRKj+abnb+XYJsc9CHNHCgumHqzDEeilo36PS/6wP5In6lcy0fm03SYoVFk9G5TNGesQ2dzd+IWwJK/duPA82RmAUATyCCKQCeySYSd1M/teI38IdcR51V2GOJWlBk/pYeUMOjULqwEnlcrjVACRiTYHFb5BIsNgG7ueDLBH1E+ZIQWF6Es140wyN72WdsXjgLfi4bHvuHJur9Fc3iiKBA5CWqZCkjf9LgbJYA4Tj2gWDseY55E7usHgXv9AEckzT8/lXZqyNZH0ZC9nMshTtKTfPIUpHl9/3zNGdcYdzJqkB8j0q0rkPGlzm9y0pBYKUmw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7756.eurprd04.prod.outlook.com (2603:10a6:10:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:30:25 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:30:25 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Yan Zhen <yanzhen@vivo.com>, Han Xu <han.xu@nxp.com>, "broonie@kernel.org"
	<broonie@kernel.org>
CC: "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v1] spi: nxp-fspi: Use min macro
Thread-Topic: [PATCH v1] spi: nxp-fspi: Use min macro
Thread-Index: AQHa+F8+GZHR/+DoTEe2ylII0zTewLI61lqQ
Date: Tue, 27 Aug 2024 09:30:25 +0000
Message-ID:
 <DU0PR04MB9496C6F0C4EA217BE99914B690942@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240827085739.3817877-1-yanzhen@vivo.com>
In-Reply-To: <20240827085739.3817877-1-yanzhen@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DBBPR04MB7756:EE_
x-ms-office365-filtering-correlation-id: 689ccbcf-b86a-4db3-3eac-08dcc67ae18a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?NU5JRXF1R3dOYWRaMElQZW1rcDdudCtqTXVSKzBWZ1pwTFhwSFRtZnJYOUJO?=
 =?gb2312?B?Yi9SR2d2aElVZnRjUTNxWENYSGpubUpSTXdhdFRjdXhwWmd0QmQ2VWxRTzll?=
 =?gb2312?B?Q2dVeU0vZ2ZNc2I3UWpySVZqYkQ2dFVpODZLSEEvS1M3dnBlMktseFlKUW4z?=
 =?gb2312?B?ODlvK0M0bUIyQTQ4UHBoWnYzRk81RFQ0WW9iOXlVZUVKNGhwRXlMTFFGcnpK?=
 =?gb2312?B?eG5DV081VFdkK2dxQUt4NUxNWU5zaTEySHRrRjA4bm1GWkc0Qmo1dUxnc211?=
 =?gb2312?B?ayt2YUlmY1hkbnlBd3dIMS9ZL0hrM0dOTGxEY1NtTGYrU3JuVWgySzVUaEZu?=
 =?gb2312?B?SWF2VUpaVWdJMTZBYlc5MWxSaWJrQ2xndFNDWUQ0NytSeHZCUDZhTWNJQkhy?=
 =?gb2312?B?SU0rdG1MejgzV2RIYnlMeWVuMXJ0WkU1eEpSVFUxQjlvcDFodE00aFVTRkpB?=
 =?gb2312?B?czRCbE9RRFc5bHZJSnYyQ2FiaWJnUHRmc2F1Y1BQbS9ySCtYbTlWK3hLTFcy?=
 =?gb2312?B?WmpJZHJuc3pPNzhRQkI1UjgxY1lJL2JpYWxCa0h6MzlKSXV0TUZEUVpabTlF?=
 =?gb2312?B?OEZpUlZENEE5enUvTHlZUkREUm14TzFkR3FzU0wvVUVUa1JnYTM4ZWtQOFRo?=
 =?gb2312?B?V2ZXVEw4Tjd2QWE4QXJ5eXRNaTVpR3g1ZDBad1B6Uk9tUnlrVnRVSlV2d09z?=
 =?gb2312?B?TWl1Wm51a0lwOStNQWpEenRBK3hsY1VtZDc0OEVKK1RLN2Zjb1VEcEs2USty?=
 =?gb2312?B?OWxKWmlISFFQNk84V2ZuSlpBakJKdVVOZVN2dUF6cmVUQUd2UTFsUFRCQ3dB?=
 =?gb2312?B?ZnZ5c3J1eGpnYWpWVmZsN1VjcnZGS3Y2L1NkQVFPdWJNV3BsSFc5bEl4bG9a?=
 =?gb2312?B?aE54RW0wSW9BRkxCcUVvWDgwTDkyRnRKQ0prYlV0L1dmbXJ1NG5GbEVxTFJN?=
 =?gb2312?B?c3VZdHZWMjJMaU9SQkNUSzY0NUNOV05HbVhuZTJCM3ZET1RMNHZJRHBMY1Fp?=
 =?gb2312?B?YUhzNkNsd3B1RGJOVEd6Z2dtcEdlcHZ2SkV0TGM0OU9oQVRHaVFrd21WNVpi?=
 =?gb2312?B?TG9VS1pxcGFjRmNCVmNkcE9tSnA0d2IySWgzNDFCdG9TbUhJZ1lKdFdlZitQ?=
 =?gb2312?B?dEViL2NLYTRFR0d4ZEFQSXVLejRXTERkWkVPempUNjNvakFqVkVvRkhBZlFJ?=
 =?gb2312?B?YlJqL2JxUXczZ0pSK2dMQzF1dHYrWkRCcDNDZVJ5WXp3S25QZmJXK3dyQ2NC?=
 =?gb2312?B?akIwRTJKdG53NjVnRDhvQmhmZGNwVXhzRnFGYmFGL0htMVFscWxzNkJOTEZR?=
 =?gb2312?B?OTBLZnN3eVJ6aktaaWxHMVY5TkVNOGxyU1ZFNkEvZ3VXZ1RDOWVMMkl1NTZL?=
 =?gb2312?B?QzJOeEFZdXNpYVVlWXZnVTk0WFBxclA3ZTFPNVk3bDdWU0M0WWJuK2pUV3Ru?=
 =?gb2312?B?T1dJZVV6V3IvWTJ6WXBSV3Q3SnJWY01rSzNXVmtPQWcwQVBic2FTUEdRZ0I1?=
 =?gb2312?B?VW9tR05tZ1UyT1U2eGo5bzQrSTA1VFBuTFh4SnJ1QXdYK0hIaVNpTHVpMG1S?=
 =?gb2312?B?MVBDbkxLVHg3OTBoWXE5Wk9kZFc3Mk51OUVNbFBETXlxR0cxQ2szSzRaRGtx?=
 =?gb2312?B?RWwvdXNjRFFjbzVtejhTTnkvTm9VR1ExNUtZeWQrTTJjNVZYcnJMSUtLeUx0?=
 =?gb2312?B?a1MzMDNqYWtVN1dYUnh4TE1FZUV6bDFWdEpLVEFFZWRWWUhsNTEyWU5ycVNT?=
 =?gb2312?B?aGZ2MlpncWVqMDdaTms5S2QrQ2Y4QU5lRkFreDNJSFc3MTdnb25TNGdLYmZZ?=
 =?gb2312?B?YnRJclFvbUh0VWdJdjFwYUcrS3ZTZ1V2c2xkNjlIL1ZiWitXWjBwTm9jd1pL?=
 =?gb2312?B?ZTB0MDI0dGZmMUxiVjIvdE92VUExc0NaeXdqYUZvam9MQ2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OFh1VlhEMUN0ZnVZQ0xTRDVjdVdTUTJFZWE4OXlGQmZMZWVDb1l1L2dENWpx?=
 =?gb2312?B?aHArUkVteWlvS0xTT2loOFV1M1l6MFZRd1F4alQ5NlBHQ28zUHJVblh4cXhP?=
 =?gb2312?B?UGRkK01KNFhuUk1rMHVsOHRNUHRodjVvRytNbnFWTmMwUGVhSlQxQnl0Z0dj?=
 =?gb2312?B?M2VqRVdFbENzZ2JxMU5vN1Z6cU01UFBpcmc4Tm5PTW5QWThZVG1KMVk0SkNa?=
 =?gb2312?B?NFFMRmgwYVlYTVMvY1dZVkN1VVVYUGhXYlV4MkwzSGVkZVpYNlZxbGhQSzhM?=
 =?gb2312?B?eGhnZmxxR2VkQjNjWDc0Ym9nUU1wV3FCcnYzTGV4eU1nR1I5ajVZRlhUelJR?=
 =?gb2312?B?d1hXekRZMzdMbGZMa0M0ejRQMEJ5ODhaUmpjbmtsU3o4Z2JoUGZ1dFBYRkF3?=
 =?gb2312?B?dGVSdjQzVk1YOHRCMEJWN1NFK1Z6bEFQMFJ0MDRsNmgzbFFmdnl4UU1OSkwr?=
 =?gb2312?B?T0lkUEJBQ2Q1aU10eFp4bWt2SzBjMi83TzI3YmlkQzRVN2JNTHk3dU5jcFZq?=
 =?gb2312?B?T2hKMDJ2d3k5cm9zZ1E5SDhqN3RBNVJidnZFbG80Q3VSQjhMSDlWK0htdXUy?=
 =?gb2312?B?ZXNmY2NzeWpuRDNhVHNlbEdjTzBwY2p3NGJlbjVxK1BCb0EvQTNKOFFhOXQ5?=
 =?gb2312?B?OWljWkdrTTN3cjZ0bVArWDlzM095QW5nMjVSMmRtdnVWRkFTWjRycVFkSG5a?=
 =?gb2312?B?ZG45U2xoOFNqVGlXdnBjWE9KbFJUMG9uQ2NiVHNnYlRqcWEwMWpaS2Z2c0Fw?=
 =?gb2312?B?N0dNQ2s1UUJxQU1zTE83U0dEVWV3VzlwN0ljdXVxM3UxQzVXc2h4WmJkZXhr?=
 =?gb2312?B?d0tuUGRRK1hXVmg1Qm5lZWF5dURzekd6V08vZzIraWN3bkRBamZjeHdnZVQ1?=
 =?gb2312?B?VFVXTEsyMmxDcGMrMHlzcXM5enhtK1psempYa3pMTGJ1VHZnanE3QXlmMGpS?=
 =?gb2312?B?T0ZPVTFZaHNhU3hCV296QUo0eU11T2hkU0ZVUkdSWDFUOVp1VXEzU0QxSWI2?=
 =?gb2312?B?YVNuZDBLSGloM3JINE95NExRUi9DZ05DbjRGcndKTWRmeGcrN0hiSE9Sam9G?=
 =?gb2312?B?QUdpeC9UOG1ieGZDeHVmb3RCemRtekxCUDdPZ1RiYjAwMTFjZGNKVXJmbWdE?=
 =?gb2312?B?RW8xQmFBWGhJQjZQYWQ4N0YrTk91RVFIMkxvN1o3MVk3N3NSQm9BYi9HdVR3?=
 =?gb2312?B?K2ZwS3lqM3RrRGJvdXgzU0NwR0JUeEUza3FkUm15NmFuZHlLc25zTE5mcmJv?=
 =?gb2312?B?b24zVCtQUWtRWENuOTczZVJBUy81R3ZDd3BGaXZoREJ1UkYvRVY4M3p4dmE5?=
 =?gb2312?B?N3dTSE1mbFo5RmQ2QjdGV2V0bnVkNjNtU1N0SVE4M3ErY25ndVJBcmZpSkdS?=
 =?gb2312?B?aDVidlNKUEFIbFRobDh6QlA0VUVTNmY1SXFlVGRUR3Y3SC8vaHJZOG82c0VC?=
 =?gb2312?B?ZWVCcHl4UDF3TEdNY2t5WWw3T0pBK2tMTXEvbFdHL21MQTYrMG9USHBXMXdX?=
 =?gb2312?B?Q0tXNGVCSE5nYStBY0ZXdjF3dVFYeUlJd0dnNDVhWmlQK2ZJaFh0WEJSbS9C?=
 =?gb2312?B?U2paNG5YR0hWSW9YRUhLS1JaLzBiQ1QyTWw1dnNGSWUwaWk2MFZESTNwcE1k?=
 =?gb2312?B?bnU4TVJJbnRxQzBEak1DMmRldFgvRVNWUHdQMjFUU0tsbGpOTEZQUU1DY0Nr?=
 =?gb2312?B?UTQwckdrSERiR0poVDEzOEYxcXk4VHBGaENnUUg4a3diMU1yNmVVL2lRZ0N2?=
 =?gb2312?B?KzdTV3NGUXZHOHNtajVNVGJmbE9tSG10TlE2N3VJRzQyL0NrbXV1RUhjalBZ?=
 =?gb2312?B?bVF2OTh4OHNIYXlWZ1pGeVRIbGtBRVFVU2xYbC9xZzBOY2dxRGZtRDd3ZmtG?=
 =?gb2312?B?WE9zdHhRZ2RkbGRBaGFsM1VKTW5BSGpiRmNOV1JNVlo2Um0wcDlPQ0E4RVdS?=
 =?gb2312?B?ZGZ5NGFucUZEakcvakxPMy9pSFFsK3hIZ2prUEN6aDFqVUVNMGlnd1BKc1lQ?=
 =?gb2312?B?L1Z5TnR5RGVSUzlUb2U4dW1tT2RFbk1CaUxhTFlCeHBPL2t3SHkvMXRYV210?=
 =?gb2312?B?RHlob00vNFlNOUpVWW4waStjVURlTDBrYlpiOCtxL0w1ZlZjdmZhNUVyckNT?=
 =?gb2312?Q?ueJ4=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 689ccbcf-b86a-4db3-3eac-08dcc67ae18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 09:30:25.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGBBOMAU/wUlDMbC0ypfS4EB0a/agGw9b+/3psra5FVXSzWZNUSwguMTamFCuBaH14e4UbkCacOt4dhUM4ayzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7756

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZYW4gWmhlbiA8eWFuemhlbkB2
aXZvLmNvbT4NCj4gU2VudDogMjAyNMTqONTCMjfI1SAxNjo1OA0KPiBUbzogSGFuIFh1IDxoYW4u
eHVAbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47DQo+IGJyb29uaWVA
a2VybmVsLm9yZw0KPiBDYzogeW9nZXNoZ2F1ci44M0BnbWFpbC5jb207IGxpbnV4LXNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG9wZW5zb3VyY2Uu
a2VybmVsQHZpdm8uY29tOyBZYW4gWmhlbg0KPiA8eWFuemhlbkB2aXZvLmNvbT4NCj4gU3ViamVj
dDogW1BBVENIIHYxXSBzcGk6IG54cC1mc3BpOiBVc2UgbWluIG1hY3JvDQo+IA0KPiBXaGVuIHRo
ZSBvcmlnaW5hbCBmaWxlIGlzIGd1YXJhbnRlZWQgdG8gY29udGFpbiB0aGUgbWlubWF4LmggaGVh
ZGVyIGZpbGUgYW5kDQo+IGNvbXBpbGUgY29ycmVjdGx5LCB1c2luZyB0aGUgcmVhbCBtYWNybyBp
cyB1c3VhbGx5IG1vcmUgaW50dWl0aXZlIGFuZCByZWFkYWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFlhbiBaaGVuIDx5YW56aGVuQHZpdm8uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3Nw
aS1ueHAtZnNwaS5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbnhwLWZz
cGkuYyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jIGluZGV4DQo+IDg4Mzk3ZjcxMmEzYi4u
ZmRhOTAyYWE1ODE1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYw0K
PiArKysgYi9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYw0KPiBAQCAtNzU2LDggKzc1Niw3IEBA
IHN0YXRpYyBpbnQgbnhwX2ZzcGlfcmVhZF9haGIoc3RydWN0IG54cF9mc3BpICpmLCBjb25zdA0K
PiBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ICAJCQlpb3VubWFwKGYtPmFoYl9hZGRyKTsNCj4g
DQo+ICAJCWYtPm1lbW1hcF9zdGFydCA9IHN0YXJ0Ow0KPiAtCQlmLT5tZW1tYXBfbGVuID0gbGVu
ID4gTlhQX0ZTUElfTUlOX0lPTUFQID8NCj4gLQkJCQlsZW4gOiBOWFBfRlNQSV9NSU5fSU9NQVA7
DQo+ICsJCWYtPm1lbW1hcF9sZW4gPSBtYXgobGVuLCBOWFBfRlNQSV9NSU5fSU9NQVApOw0KDQpS
ZXZpZXdlZC1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KDQpUaGFua3MhDQpI
YWlibyBDaGVuDQo+IA0KPiAgCQlmLT5haGJfYWRkciA9IGlvcmVtYXAoZi0+bWVtbWFwX3BoeSAr
IGYtPm1lbW1hcF9zdGFydCwNCj4gIAkJCQkJIGYtPm1lbW1hcF9sZW4pOw0KPiAtLQ0KPiAyLjM0
LjENCg0K

