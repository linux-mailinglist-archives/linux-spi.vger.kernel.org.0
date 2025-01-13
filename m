Return-Path: <linux-spi+bounces-6327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F8A0B05A
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 08:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF613A6784
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FCE231C8C;
	Mon, 13 Jan 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="7jMXLal4"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657222615;
	Mon, 13 Jan 2025 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754779; cv=fail; b=h3ianaAfasZWcsJOCYcXgx+Kr//MU4jxrxAOXft++WNVvlP398O24m0bely688vhew5Lobc/Nvk/Cs94AuOyedd1tYWyDcC9Ifin9KTFe7ObuXBCPcaf+vBw2rDwhCoj4x4R+JYtbt7EpsmzgB6JoZQGltF/MvvOmGzAdtqX6rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754779; c=relaxed/simple;
	bh=nQu8yKRohjDyBUyIMyGqE9iMLUfhyePiqOqLCL5CLp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gc1BzBWOHsXx4CdntRyGgvSPawjU3ka8ZaEKW2OS0ucGhzAtrhfqk+rKo9dJnbLCki+twy034bQIndVNOqDxYiHNABmlfrtWOA0bHl6h8LpVFvIXu96i6qrKik5Ou4DmeTlX4Wj7xQGGlUasgZPZ0c9l2mNzy+zGusu2uo8gwpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=7jMXLal4; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmIq1qEpSOe63/8zsYhlf9d+JdyNwDnGK8sJB5AZRqvsAJAq4JsEF3xrWwKiYX4zYOqFOUOLEL/WdY6BKPbyUgREaF9BLrODSfc0Zcj62uan824L9w57cEgH0GCtQqkXKDmYTI9nh+VTTghwz2xFbihTqyM2eG5y27nkay86aBJHH7JFMSLytcBWmZ+rjmxJHtXL+YHVeIEhFnOkZJGFQ0Gqot+MdbL+GFeB6uwrqdkGsJsA5hfti2fsmKZ4/GCEAQ/a/y7VGhaFgr7akee7f6VfDGTZhyhqzhuigcP0DM84sc2E8shBA8UCdSqmUOeao3PML8CQIYmzBtouMa4SUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQu8yKRohjDyBUyIMyGqE9iMLUfhyePiqOqLCL5CLp8=;
 b=xd4ixK7rQl1T03Vad09vqK11myESL34wWVAbxOxRPIK8rGhElwjSdIdc5ViE1scWTnsySidoM9/5amjGvR5q3F9Q4/u7BU15okQauHuEQFo9UJjdFh3YhwD8Nb1pv9iY+49Am19b+O2SFl6PiaZkIreBNfzBaePYbWXWfVCQJIJus6jD4O/BHeGuSJYMD+1sv6bZA1ctq1jdYWtY9VExlFXoTBqwLNcBb9/9u3sfQvbW+uYtvachYQRaFKB028ZHg/0rWiUU/BYdguUn7qiVt0deFc2FMPhKlzZdN8o+bxgDbG+mjVT34nxlNDyuqox6jCXXpr7+zmO4Jq72SvJoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQu8yKRohjDyBUyIMyGqE9iMLUfhyePiqOqLCL5CLp8=;
 b=7jMXLal4g2u+fV4/i4wvAeiy3Asutv0rXrhbAsgl9s8n/pOPgIwrH0H0pCk95VJyvxKfQUisNhLl+HxEOn0rJJKkzFLfKxZ/z0zGIl+2Pr46mOShC+AMWFD5TWZHNEUqEs3SsrrtMU953V+Jm2P3orzydydtxM64NZ1rC2oyQfOzk1yQM2M3UCdG9wwxa2p3zAWb6D1bGLYU7EXhApLGcgFFlXSBnwXwXQsJg2fFilVokAryJ2c2dm4nN7EtCI4nwJ8YPQ2H3xpYFeUQ7+09/EQ5rPND0iVyK/squN/zvtx7UXZG5/QrgJ7rX8tqN3KTDVLJFJMIcsK7hAlWM1GmDA==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 07:52:53 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%5]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 07:52:53 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>
CC: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: atmel-quadspi: Print the controller version and used
 irq
Thread-Topic: [PATCH] spi: atmel-quadspi: Print the controller version and
 used irq
Thread-Index: AQHbGVy2u0BCId5iQ0CcoUJO6Oi3obMQYTEAgASLPvA=
Date: Mon, 13 Jan 2025 07:52:53 +0000
Message-ID:
 <PH8PR11MB680413D7B32F14B8DB32026F821F2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20241008083226.51163-1-mihai.sain@microchip.com>
 <20250110-reshuffle-thrower-3212ad741403@thorsis.com>
In-Reply-To: <20250110-reshuffle-thrower-3212ad741403@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH0PR11MB5782:EE_
x-ms-office365-filtering-correlation-id: cd55d016-6394-4165-b7ca-08dd33a748f9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGFtTzc4ckNhemZJd1B2eFBoa1g3ZktZNTR4NUZEMldsTnlGdGYxVk9McGNG?=
 =?utf-8?B?ZUZLWkdFK2dnR1NKYUhCQ0VQa0owVktFckZHZzlldXVzMkdqbXozMUNLSURl?=
 =?utf-8?B?dGpidkVOOWpnM1VLZkx3VktyYUVCSTZvRWl3dHUvVUJmSHo0YkZUSmliMHdK?=
 =?utf-8?B?MGJEdHpDNHRLK1pGenBvanBMZWtUV3NUNUpHUzRETU5tRGpoSTRFaFMyNDBB?=
 =?utf-8?B?cnp0b2cvNEYrdkY5K1lGUlJUU3V1ejdCYjFYMTdvMERheVd5c01DaWVSR21C?=
 =?utf-8?B?ZXlwZ2lxVVV2bitJUE1jamNFeDhVeVh0dUVwME1lZ1dNQW1IREZVcWVoeUp6?=
 =?utf-8?B?YkRKMmt3NFZUS2tvQmxZMUNEOFVMMnRsbmVSZWVpdXZEZDM4TTZsRHhQVUFr?=
 =?utf-8?B?UXZNSmxvTkhPdFk0MnQ4M3FmeFovR3RZbkpLM1hrQS9JNVJnV1d3bkVWbmds?=
 =?utf-8?B?NGw5eEdDamZpZEkwV296cEtyVWprK1g0VkhzMXFobEZWVE5zM3gwWHR3ZzZK?=
 =?utf-8?B?NTJjNC9vSFJrRnY0enJ6eWpOSFdrcU5HQk1kdTlOTEN3cFZLN2VzUW5wUVF3?=
 =?utf-8?B?NEhUQytGTit6a2JWdHg3a2JNNE1BUk5paEU1RDJuL044SmFFdWt0MDMzdDJo?=
 =?utf-8?B?UlcvUURQVkdad1ZDa05aNGZqWUJsSitWaUk2V1MvUGxRc3lHaEkzVithRXBY?=
 =?utf-8?B?WWdEY2FNYk1PR0Zuak5mOWZMRlVBUW9ZTUFVc0JCdlZjV2FQWGxpODh3Kzlm?=
 =?utf-8?B?S3NFS2lCekZpcVNiRWY2eDlGYk00Qll5alY0MUVCVEc1SklNT29QV2JzallM?=
 =?utf-8?B?clA5NUlsYW9SNW1VaFJsdlV5ZXIxMDl6bTNtdFRaYko5QW54N3BzY0M0Zncv?=
 =?utf-8?B?dWU3bklTSXBzS2I0VlM4UlhWOWdTK25KclZxcWJJNC9taWlHRUtvZldxcW5G?=
 =?utf-8?B?Y3FJQ1FuamgyQmdnbkp6dEZMbUVxUTZod1gvQnNmNjhubDNsVFIxMU5HaDNN?=
 =?utf-8?B?THovSFNGbnU4dlo2TnRhUHBLK05vaFFGL2gxby92NHhUeEUwOS9LTUtMZnky?=
 =?utf-8?B?YU9vOUQ1Ny9hU2Z4N1JCMG4ybUZTWlh0ekdvenFacXZzR1pKZHhZS3RNbXhi?=
 =?utf-8?B?T2JoZXlVYkVzYkF0dnh3ZmliWlovNlpGdmhXdXdKZHAyYjlKa3pIUGthQlUw?=
 =?utf-8?B?ZndaOWt1Yk51NWc5dkorbTZJUEJGN2c1WVBpY2sxcERTRUZubW1EYWtyQ21w?=
 =?utf-8?B?SEVrTjBUSVpmajNYajk2NUlNK2xRUC9FT2tRRmgreUFlQVVydzBaSHY3OEtH?=
 =?utf-8?B?bkNzOXVBZnQ5ZE5JMnJudFNrMm9ReWo3WFoyT1hnL080a0F3bWRhcEJzczY2?=
 =?utf-8?B?MWF4ZGtlRUxFQ1RHMGVrWGhLSkV1VkIxbDlZam5La3l1S0MrQkRjRFFNY3RT?=
 =?utf-8?B?MTB2VDRtdWdqYUVYOFlTZ2pWMUZUNitKaEtvbHNuRldDQ0J0cUlucVJrb01r?=
 =?utf-8?B?YlphcVpCTEFoM09Ba3d5MHJxaC9BVnF6bkxuM212MFZmVGdxdmR6NURuWGZv?=
 =?utf-8?B?ZVo1SDRkbmN4STFtejRjV2ttSDRrZWJJRCt3Rk51SnZMMFZGSEZPQ2I5TExN?=
 =?utf-8?B?TElNdzIxSThUK3RyUFh3cFJlMThBcTFicUxqVGh4NmpEY3Z6ekREaHBiS1h4?=
 =?utf-8?B?aEZodi9nRTQ3YmlNYTR1T3JLN3JiV1dPdk9BUG1nMTN3QUYzZmpqdUppb2Nr?=
 =?utf-8?B?ZTZEN3Q5M20vYWJuWVpwU3NZSnNWRTFxZjhKUSt2SWlSY0FYeFM3RDVXZXVt?=
 =?utf-8?B?V0N3Smo3R3pnQXdPamdZeE91OC9Kd3BJM2MwamYybmpleVNiZGJWanNkZXVy?=
 =?utf-8?B?SnhXaStXWEhHdnhZaVRpNjVLdUtKSmZMMlh2SUtkMEpZdEwwMkZhd3Rxdk5F?=
 =?utf-8?Q?O12x7sdPp4Tb6604u8h3jRo4XDm8izFs?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b29UcHF0bVl4U25nUkF0Mi9JdDVhMWlueVJmKzdMUFJ6Q0JtTXNEMGVHU3hx?=
 =?utf-8?B?dWZMUmExcmNTUExBNngrejJFc2xpL3ZtSTZNS0p2RWhTMDJYTFlGT1RpUTZ3?=
 =?utf-8?B?S203RGZQQ3JvTmVxLzB4bitKdTNNVGZxODR6aHFtdVF0Qlhia1ZORXlkWG5j?=
 =?utf-8?B?WFk5eXJKa1VhMUQycHJndi90M00rR0NISFRRMFQ1aFh4c3hTQ1FEUmNNazlh?=
 =?utf-8?B?QUtZeERMeWxNMlVQNDJMZkcvRWNGQm5aQ2dBQ0p6bjduSnhxTXQvb2FIanlM?=
 =?utf-8?B?SEZ3M3V1V2tkdUZTU1dmS1ZVbGh6Rm5zeGQ4L2t6WlVTbW4xUEdrQ0xiR0dh?=
 =?utf-8?B?MzdhbWVGcTk5VjFNVW9KaTlYMlRSaXFZNHR1V1ptMVdmOUxBN1lSNUdCSitR?=
 =?utf-8?B?ZEJsMlkvVWhrU1dxMUI2MjBhWjI4Q1k4aGczYytJZW9FMmh2VkRjRzZaR2lB?=
 =?utf-8?B?ZjNmQVFUZEJFS05uQzdzeTRkVkkxRlJFcTdqdVErWDJENXRjeVZhbXJ3UUgr?=
 =?utf-8?B?RG5ibWF4Y0FRNjB1Yzd2R2l5TnRlU2tJM0N0M2VnZEduZXZwMG5wOFQySk41?=
 =?utf-8?B?VGRCK0YyaFcxcTk3NFZzQ0hzNzJqSysrVzNSUUVOL1o2ZmRhNzdQckdVZFhv?=
 =?utf-8?B?RHhtZG13VGlqWmFkTnNhNE5vQnZvQ0x2d1pxaEVhQ28zWDlIcmRyWDMxLzZE?=
 =?utf-8?B?dHZGQUVxaDV3Mm1CSTNITXVSR2tvUDhxaVJiSUFDdTl6ZFlRMkRsK1pjVnJT?=
 =?utf-8?B?OU80ZnNPNEVjbGJXVUdjUEI1UVIyWDFzV0lDcUdWY1dCQVUvTGpHTUQ4R2tZ?=
 =?utf-8?B?dzJzS3ZrTk0zT0VpMGI4cEVEQytxMXpYMmdEdjdHbU82SjdmSW9sTENzZVNj?=
 =?utf-8?B?dUhpL0lud1lGWC9idVZadkdDd29YQUROMHpFNHZXeXZXS3U2UytoNGdmUDR4?=
 =?utf-8?B?b3VlUm9lV1pjYzFFR0ZEelYrNEcwazVXYjdBaGlyRzRRa3JCNGgzeDRjTHQ3?=
 =?utf-8?B?M25Jd1RGY0txamVkK0ZSYStUQlJlWXc1dnlvUlJwdXFBbnNUc21YSlBudGNz?=
 =?utf-8?B?S2MvWTB0RnhhUjdiQmxwQ3RqVGtkUDJXRFJXN0ZRYlhBckxRK2pvallFeDNz?=
 =?utf-8?B?d21LNnpYVWZxZWIvRjJ5RnNjbG16bG5OOUE3R0g1RFdYdWNNR0tvSTFFQThX?=
 =?utf-8?B?Vm9RemdXejRWcWJsc3FpaEJFcFNZRW50WElUT3RMODdZS3VBZFFnbzYrdUVJ?=
 =?utf-8?B?elpkSEpoZ0l2WHl6RGtHTW11SVdHYjZwdCthRnRrdmxyTUdZNmQyVzBsNVlv?=
 =?utf-8?B?cmkxei9HdzMyaVdZZ0U4RWsvTXZKVDMvNE9xU1pvc0dWenRBc2trVWRZUzBX?=
 =?utf-8?B?bXhPQS9FS3Y4eDBGZlpkMHpDTkhOMTgwUmszb2FFaFBXTXdFY1czOGFPZ09q?=
 =?utf-8?B?b0RDbEhzOWtGV1oyV2l1TnZ1c3Q5S0hKQ1dhay9pZU5MeDNwYlgwcHlzMXlL?=
 =?utf-8?B?SldzSDZwUElFNkpTYTR6MUFjOXd6WExoN1poWWhsM2t5NTJ1TlNJYlJQbVhr?=
 =?utf-8?B?QVd1Y3hyZXpENVA2MlRwa2orRjAvMHRIdUJkRDNHNGRYOXRXeHU5ei9zV3VV?=
 =?utf-8?B?UnRDYzJCUXBzdi9uS2Z6T0t4TzlJbTE3eDJoSEZFZXY5RkpkeEpQL3pBQlp4?=
 =?utf-8?B?c1d5N1Q3cEtsV3NuNjRHemJJaVJndzNPNWhES2NUY1M5SXpUQUJrWFVDRUNF?=
 =?utf-8?B?N1RWK0dCb21rZEZhSVJlVy90YW1lWHZkYTJLWlB4YkY5QitiWE5IWkFwM3hY?=
 =?utf-8?B?djlxY1R1K2hLQlpyZ3dxZUZCaDQrNlFFeWMwMDdyQmdMdzBpZXR5UkRRbFQ5?=
 =?utf-8?B?MWxWcUhETmx4VjRkQUwzOEI2U2U1bjBUQ2dESU5WMGFGaFJZSExXSlRjbmRX?=
 =?utf-8?B?enlhdGkwUFhBNWxJUlAxSytvYVNkb3FCeVJUZ3I4LytYUGxKRTV4M1YwQ1pF?=
 =?utf-8?B?NFdWb01DQ0RMMTdxRXp3OTZmRFFjYXAzWEdEUTU0dWRHVnZDUytYeVpoRFpl?=
 =?utf-8?B?Q1ZoMWl0ckVPWExoRllMN1JWbmdjdUJDTkpzNVpRRWoyMU03ejYyRWVrV0ts?=
 =?utf-8?Q?NtWWlnzQq5qppNx/EEUUlS81S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd55d016-6394-4165-b7ca-08dd33a748f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 07:52:53.3250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxu1IiMApgrr6j+M8ufks3+eWFm/0qhF13k24b8RBjKYgjtksY8Fvz2PRX4jGRLyQk3zI7cPo7F3yYsMvRc+8qHirRE+ohRfsywK+XnBpE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782

PiBIZWxsbyBNaWhhaSwNCg0KSGkgQWxleGFuZGVyLA0KDQo+IA0KPiBqdXN0IHNhdyBJIG1hZGUg
YSBzaW1pbGFyIHBhdGNoIGZvciBteXNlbGYgbGF0ZWx5LCBzbyByZWdhcmRpbmcgdGhlIGRpc2N1
c3Npb24NCj4gb2YgdGhlIG5lZWQgb2Ygc3VjaCBhIHBhdGNoLCBJIHdvdWxkIG9wdCBmb3IgaXQu
ICBIb3dldmVyLCBzZWUgYmVsb3cg4oCmDQo+IA0KPiBBbSBUdWUsIE9jdCAwOCwgMjAyNCBhdCAx
MTozMjoyNkFNICswMzAwIHNjaHJpZWIgTWloYWkgU2FpbjoNCj4gPiBBZGQgc3VwcG9ydCB0byBw
cmludCB0aGUgY29udHJvbGxlciB2ZXJzaW9uIGFuZCB1c2VkIGlycSBzaW1pbGFyIHRvDQo+ID4g
b3RoZXIgYXQ5MSBkcml2ZXJzIChzcGksIHR3aSwgdXNhcnQpLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWloYWkgU2FpbiA8bWloYWkuc2FpbkBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9hdG1l
bC1xdWFkc3BpLmMgYi9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4gPiBpbmRleCA5NWNk
ZmMyODM2MWUuLjc1N2YwNzEzMjU4NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9hdG1l
bC1xdWFkc3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4gPiBA
QCAtNjg3LDYgKzY4Nyw4IEBAIHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgIHBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3ko
JnBkZXYtPmRldik7DQo+ID4gICAgICAgcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoJnBkZXYt
PmRldik7DQo+ID4NCj4gPiArICAgICBkZXZfaW5mbygmcGRldi0+ZGV2LCAiQVQ5MSBRU1BJIENv
bnRyb2xsZXIgdmVyc2lvbiAlI3ggKGlycSAlZClcbiIsDQo+ID4gKyAgICAgICAgICAgICAgYXRt
ZWxfcXNwaV9yZWFkKGFxLCBRU1BJX1ZFUlNJT04pLCBpcnEpOw0KPiA+ICAgICAgIHJldHVybiAw
Ow0KPiANCj4gSSB0aGluayB0aGlzIHNob3VsZCBnbyBhYm92ZSBwbV9ydW50aW1lIGZ1bmN0aW9u
cywgYmVjYXVzZSBpdCBkb2VzIGkvbyBvbiBhDQo+IHJlZ2lzdGVyLiAgVGhpcyBpcyBob3cgbXkg
ZGlmZiBsb29rcyBsaWtlOg0KDQpZZXMsIHlvdSdyZSByaWdodCDwn5iKDQpJIGFsc28gdGhpbmsg
dGhhdCB0aGlzIHByaW50IHNob3VsZCBiZSBkb25lIHVzaW5nIGRldl9kYmcoKS4NCg0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyBiL2RyaXZlcnMvc3BpL2F0
bWVsLXF1YWRzcGkuYyBpbmRleA0KPiAzZDk1Yjg4NzIzNWU2Li43NDA1YjY2ZTE0YjMwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4gKysrIGIvZHJpdmVycy9z
cGkvYXRtZWwtcXVhZHNwaS5jDQo+IEBAIC0xMzU2LDYgKzEzNTYsNyBAQCBzdGF0aWMgaW50IGF0
bWVsX3FzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICAg
c3RydWN0IGF0bWVsX3FzcGkgKmFxOw0KPiAgICAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsN
Cj4gICAgICAgICAgaW50IGlycSwgZXJyID0gMDsNCj4gKyAgICAgICAgdTMyIHZlcnNpb247DQo+
IA0KPiAgICAgICAgICBjdHJsID0gZGV2bV9zcGlfYWxsb2NfaG9zdCgmcGRldi0+ZGV2LCBzaXpl
b2YoKmFxKSk7DQo+ICAgICAgICAgIGlmICghY3RybCkNCj4gQEAgLTE0NzAsNiArMTQ3MSwxMiBA
QCBzdGF0aWMgaW50IGF0bWVsX3FzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAq
cGRldikNCj4gICAgICAgICAgICAgICAgICBwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9zdXNwZW5k
KCZwZGV2LT5kZXYpOw0KPiAgICAgICAgICAgICAgICAgIGdvdG8gZG1hX3JlbGVhc2U7DQo+ICAg
ICAgICAgIH0NCj4gKw0KPiArICAgICAgICB2ZXJzaW9uID0gYXRtZWxfcXNwaV9yZWFkKGFxLCBR
U1BJX1ZFUlNJT04pICYgMHgwMDAwMGZmZjsNCj4gKyAgICAgICAgZGV2X2luZm8oJnBkZXYtPmRl
diwNCj4gKyAgICAgICAgICAgICAgICAgIkF0bWVsIFFTUEkgQ29udHJvbGxlciB2ZXJzaW9uIDB4
JXggYXQgJXBSIChpcnEgJWQpXG4iLA0KPiArICAgICAgICAgICAgICAgICB2ZXJzaW9uLCBwZGV2
LT5yZXNvdXJjZSwgaXJxKTsNCj4gKw0KPiAgICAgICAgICBwbV9ydW50aW1lX21hcmtfbGFzdF9i
dXN5KCZwZGV2LT5kZXYpOw0KPiAgICAgICAgICBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZCgm
cGRldi0+ZGV2KTsNCj4gDQo+IEdyZWV0cw0KPiBBbGV4DQoNClJlZ2FyZHMsDQpNaWhhaQ0K

