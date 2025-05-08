Return-Path: <linux-spi+bounces-7997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC922AAF86D
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 13:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08ED74C5632
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA4AD5E;
	Thu,  8 May 2025 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dhjyRsdU"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA943173;
	Thu,  8 May 2025 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702050; cv=fail; b=raIS+CAm8rz+6nb8FrphkmnR6aLZiOYm/0ZgVEXCzpa7dHWGogJhyvIvrj2eKRcj8zDmLmXxrp8N845ZlR44lAFvhg3Bh6MKocc7FFjbUcZx2Yx5FQbg3QovHpmQy3P7fIj0zLAq4OmfylTfsed1j44OZZcsADeMtqd6EbTBzzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702050; c=relaxed/simple;
	bh=TQhW59yApD95K7fjLoyzVuochq1QhVb6sPXTKwliZiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tSKyrN2x1q1/QGs2l1rX/tgoG7Yt+SFMWTFSMXY/8/YXMUWEy+V0o6bXF6LiG61Q330XFJSGL51rvACP09UaKQTaTqtC/8B2kd+ic3BKiYD8hIdoEjksugwfAqyVTphGpo5ByYAXOGbcFMzNY5xY3wqhQIQtfmqTIFayq9XczZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dhjyRsdU; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrPdoA11IbO6rjioum7y5GHIdIu32qGv787Po5L4KBtDKuh/fYcdaHlS13+jKvdnYC2O0MvQOVli0UL8rqQH8r2FdhA1kfzJMTE3OgenqP8huquDSRmf08GjBNr9g9zZENMssCyqT0sJrplUvmmX55fKCE5CLXJyCSg5V8LWdwWbCKaqBTc9mSurcP+mK+/3Y07uc7bPNbhGKjn0OQ8hLOXaF5NXOyYlCUWMKcQlIXkcCepaf1uRIqMt/ObvH+74ax0HIEui2ZtVgUVKKEVET5t0lIv9vXq7l/9f8rA1kDUtxcgQ1dERW5whZUvTT3h71jaSvr7d10SlI6RbJupFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXkhe38sOAbzCP5HSYyVhNSE6XVDj3d0MtWjlSUuycA=;
 b=QRcKCDfo0RG/4HMWq+3FOktm4e7QORHIBj2JmmLHdYtLSFTGwPak/9hAipSPSWj5dEtiMwUATBQKexpRhu93Es9zV/nbym8cfouf5ogoQVL2WFyCey4Y9pGY6olzzoOdG9SRRuB2Ra6damd5m0dqHThNxLe8zEOOmh8xW2GnIpCIsB6W+4t3jEuD0wYc9Cmieco2uc+nGlMrZn3t8g9ftYhHFlI05hSD5B8uTz05vgeRNzqQTqQpJ1QIcOrJJ3azAuk7KgdG2rn6LcIKB1F11+6nizzcakXq7vadAEL/UyvMg/tnET8ED6F86LGdc6WjmivxU5tGhHTI6WBLLFbruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXkhe38sOAbzCP5HSYyVhNSE6XVDj3d0MtWjlSUuycA=;
 b=dhjyRsdU+ay9QlvEfhUwa6+aa+kMbg3tbzki4RwmM7O6FkGka2ROwTyCGyASxn/dxJ3l0VJ10pvPzlr+PYJn7C1jmaaGxQfFjEcmu5A5n/DIBnD6Q6dXgIxHgqAldyC0jh/MgPdFlX3bmAm+NddbA1yrlXDXPLSM7cslY1mYKimJmPk0gNWumdgOpXYLC0YkC4GvgLbAkCmWFb6zmnHH2eZOdtiNjOQ8eKaJuSNDJkgm7TRMXuZZntxfPAZfh83pINPNXNRt9TdVhMYV99CEE+CcQNVqLt3ubJ7KrINVYGZ4rBLNOjcZi3QiDJ7kKBMI2K1X5TIvrnufGxKAiupRsg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPFCA907ABCA.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 11:00:41 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 11:00:41 +0000
Message-ID:
 <PN3PR01MB95971BCD20A70A29058E27C9B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 8 May 2025 16:30:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] applespi from 6.12 onwards
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: =?UTF-8?Q?Berkel_J=C3=B6rg?= <joerg.berkel@bfh.ch>,
 linux-input@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-spi@vger.kernel.org, lukas@wunner.de,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
 <n73jgymwf62kfexrwrhpz45lrj5pc7e4x7m6otbvypctlowjdl@ztaox436vezk>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <n73jgymwf62kfexrwrhpz45lrj5pc7e4x7m6otbvypctlowjdl@ztaox436vezk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::10) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <f9ca3408-aacf-4f14-acfe-ad4744bece9d@live.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPFCA907ABCA:EE_
X-MS-Office365-Filtering-Correlation-Id: e28f6e5a-abbc-4aa2-1f54-08dd8e1f9284
X-MS-Exchange-SLBlob-MailProps:
	gMiuAN0LASIScjX/aS/OnauL17RJFM5JQZxjzVuW90hdDedmPSGotppVr1DVB/d0KL6c53Sino28Z2IU4jrsB7GXFevnbKvjLP3ILzNWKZwhnfGiax+DaFyNhKDOCUoPE5RX+VsvBFi7ApTzzzMfhTo05k/NYZBnIC7BUdvLUwtdNq+d7cv+86U0ckiiWUJfC9lBhIROgOq0qmBjivq70zdwcCDG408IK29tHmDOAv1P3B9j8Tgxr8tBsxsQ8QRnhJyoP5kCtFqaoEX+0OQNujeccQ90JB3Uta9UWJdS8fCHNhhHvoen1Q0dCrc4nllif8to9/uAQmszo092QWkHUvoZIKwKh0UUHT7SGkWQw+Q7Wimgf+RSni743D0kXcDy8e4CWClDJE5BjoQEywQBkyU8RkjCeYeQ9M0e4ifvkkRp5bVqHlfKx3KuZ9Nv2u2c5l6u+kUrOz2g8klgQFfhqrjAML+QZ/dQkzjBzlW3GkzOhMPpv3tpLWBdtBZ7g4YurBJTLq81B13NozSFkSqz/dcJCITJk4U2u/yPDZqM1PBj5sR+tXW0SveNTZ+EJrlE8Ja6oczqeKhmhcbU88kDg6uaqrfCiyLgH+a+tQSoiWeCw2f6qE2uME8f5i+Q3jsu2Jj4BAZ1so/tMx4QjHCpcxX4IwgbPtw5MVuMSv7hw9fvFojTqGvcEJvSb9hhX2Olzvp1kN3CdCCz0d8qfNRQGw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|12121999007|19110799006|41001999006|15080799009|7092599006|8060799009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXZuVVZDaVJsS3gxR1VEcnpIWTY5RDJ6NnB2VXl6ZTJRd01jSWluYmF1WDJ0?=
 =?utf-8?B?SHlqZW5rbk9TNnlpY2xVQWVBQ2xoTTRqOVhUdExKci9EckVZZEtuVWkrc1Ry?=
 =?utf-8?B?T3pDWGlWZTdtRG0xMmhHWTFlVzF5S0ZyRTVpUWFBZjhtVzNWZ0pLelhWb0hX?=
 =?utf-8?B?L3dyOVBZU0JjWDZJU3NPNHVxZEYycThhMlFnU1N6UWpkS0VFYnZwclFiZStP?=
 =?utf-8?B?elEzVWJkUGMzWi9ZeFJPczBRQnRuOFdFd05rbS9uTFI4MGxHYVJtU1lWZm9C?=
 =?utf-8?B?VHlDZUo1WkdrWStsbEp4U1lyMG10MWtkR0pqR2JxN1JUUmxsSERNQ01QNXow?=
 =?utf-8?B?UjhhZHpXanpCQWk5NVFzejJOVDI2bTE0WTRGcVZWZGJMUjdXNU01QThnSXFa?=
 =?utf-8?B?dUtVbDczMGNxcU5qdUROYlMwemZaaTJmTG9wS0NRTDV0VU04d2FNT2cyU1pj?=
 =?utf-8?B?dTREc3h0VWZjSGl0SjNwb3pzeDhMZ3Q2WE50UGVNSW9WOTdSbEkvbVFybUIx?=
 =?utf-8?B?MTYxMnRYTmdmM0doL0I5ZEswRGJObk1UNTRJVDB5L29RV1NoRDR1MWo4RE5W?=
 =?utf-8?B?OGM0Y3dLK21nVHYzY0taQXRvSGtlTkRKNTRZSTdLZ2J5bVJrRGtFVkI2NFZ6?=
 =?utf-8?B?ZFNvUTFKRDhUdUhoRXh1VGVxVnRYaUcxWlVObDBLbnlTN3BOZTJlOGJUdVp0?=
 =?utf-8?B?SEVWNGdneUpSemFuUmphcEw1NVBsWVF4ZzVyS3FLRlBhT1NqbzZwVjBHS0sy?=
 =?utf-8?B?RldQNytOdFhQTS9ielo0TlJ0R1gwVCt0RXBwUDBvRTRhZkw1ejFIUUx5clNn?=
 =?utf-8?B?Y01xTHRiOW1zaHlrNms5Tko1dWFXdkFWNEtOSnZBZk40TTVlRi9nUTQvMS8w?=
 =?utf-8?B?cVcwTjFHaUZoS2hlNzlrbmRJbU5wZHpqeVBqM2Z0cXhuRHZyejlDOVhBQUdJ?=
 =?utf-8?B?VlpLdHFhOFpRK1BTNUJWSTNyUGNGenh0ejQ4WTUvV2xlY3c5R3krSXIwc0g3?=
 =?utf-8?B?NEhmck5hb05xdHpUaHJPU0xvbE4rdHlvVkJCK01GZkMzdXNnaUUyU3Brdzhx?=
 =?utf-8?B?Nkp3VXVBSXBBR0VqMWJhRjZaeVdkVWJTT01wRk9JOGxsWFBrRHk3M20wTXBm?=
 =?utf-8?B?NVB2eDRnOFlsQVh3am40OCtJRzVhRXNpNUJDTUR1YWJUbEJjektvbnVWVkFS?=
 =?utf-8?B?enVQcUpORDhPNmNvWkNhbVBOQXI2a3Y5TytGdU80TlAwY3hsRzlaeStvWHdO?=
 =?utf-8?B?WG1wTERPZ01TTnRwdVJlcnkzeGgxQ3RFWTEyZ2xrckd1eTViMHJRdGtmODhI?=
 =?utf-8?B?ZEZsSDZmYXBzek9YcjJRTlg4bW85NEpqd1A0aVVxWnBmRUlhSkhLSkZpR004?=
 =?utf-8?B?NmNhZzc0MWxkV3UwZTFSanJ0eU4yMWZ5NUtnRzlrNnRkZWNrUGwxcXpYR2VE?=
 =?utf-8?B?Sk5MY1VyU1NQUHlka1BSR05wa0VLazA0VlFRczB2Wmg2VEVaMXdMTnVGZGdl?=
 =?utf-8?B?bWo1R1A1VnNLMTBjeVdGTnJKcEZ4L0hibmtrb1d6RlNEUStZTkRVL3M5RVRW?=
 =?utf-8?B?MlhtZi9qa01PS25McDUyOG1xTmF4ZnkzZkVBQUcyMW9wNWNVQUwvdEd2SWpr?=
 =?utf-8?B?TEIydWRZdm9oa1NyNU5JVi9FWE04Y1E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RS9uLytmeUI2cWh0aUwvY3c4cnlDUGtZazl0azQrTSs4STBMTzBnWUwva3VY?=
 =?utf-8?B?QWgwR3RvS2ZpM3ZYS3FjOTdMZVo5emRZZkV4R0RUUkM3TlI2WCt0T0kyckNZ?=
 =?utf-8?B?NDFVZy9ITUxJelR3UzFxNThFOUdqTUlCOWFIQmV6QVV3UURnQzB2Ymlza3Nj?=
 =?utf-8?B?UEk5b0h2cnQ5ZGlvOSs2UitJZ0RpRHIxazV6U0c0WFlqRC9hTk9rL3NDZ2Zy?=
 =?utf-8?B?TStLVEdaUUJXOG1ESE9NeE1HcUp5eHlSSmtHbCtIWjU4ZklLSnJrdXEvSUE5?=
 =?utf-8?B?WjFRdFpkQjBhU1grQkFrR0pLeDI5dWtYR3BLVmNURjg3djBtS3ZUWndTaFpY?=
 =?utf-8?B?Ym4zeVprMmtnUjNoOVZHUHhmeE55K0NBUlFLZk1DZkJEVFh5Y1ZRSVp3cmlB?=
 =?utf-8?B?Z29wTFdYQVRIbUtFaTJvdTN6UW5LeWs0ZjJEUjdDQ2hveFNCZ2FTQkJVcEVx?=
 =?utf-8?B?MHY4WUxDQUdMS0VVb3RXRk9DbXpyYTNNSjhlRCtaWlIyQmpXSEIwZzNacWd4?=
 =?utf-8?B?b1I3ajNjVVZJRlNzTFZvWEVrbzVMZ3ozMXJudXZURXljVWM0UndlNkF4YS9j?=
 =?utf-8?B?WktKS2R2eGVaUE92aU92ajFMd0VYcDU5Qm40ZTFXaWFWQll1a2lReThDMmkx?=
 =?utf-8?B?U05CU1hzZ21Hd3RLUC95YkpZQ1dzK0o3YUphUFdqMDRJbE5xSGJMY2NrYWFt?=
 =?utf-8?B?TlRSVDR3c0VUUzcreURuVVlyaHUrT1ozblE4S0gyNG0yVnlsRThObE11QU9u?=
 =?utf-8?B?UlhYZ1lLclRaV2JBbHRDRHg0WVUxSWVDODdNbTUxK3RIdEFkOWQ1TXpQSGxq?=
 =?utf-8?B?MFhxem94UnV1Q0VZMFFaM3B4Z0NVNUF2aEJIMVpyWkFWR3dpeWU5MVpOcWpD?=
 =?utf-8?B?UkRQOFFkMTJ1ZWE2ekw5a01SVHBYOUVOSUcwRksvWTE4YWNvNndadnVpL1dH?=
 =?utf-8?B?eWhsZW9SVXdieTFtTUdkdlpmSGt5cHZjb0tWVXY5VnRQcmNkR1hzeGlPR1p4?=
 =?utf-8?B?Y3VUN1NLQXpGNkI0NEh1cElhY1AwamR0TTd3eUtqQ3J3L2NVcStMWGlzNytE?=
 =?utf-8?B?ZXRMVEtVc1BCSVVKUEdNQVNsTGExQ3FXVUo1dTBYblRmNXBnQnNyYkNSYU1G?=
 =?utf-8?B?RUdJN3U2K09KNllUemJXYlJLQ0RocVdlMzdidkxwb2xDQlBKNkxqNERoM21h?=
 =?utf-8?B?U3pRMzVFQWppYlEyL1hxNitMNVQ2QWdBSi9SQUdVMXVRUjhtUW1tZmRBYzVH?=
 =?utf-8?B?bDdUWmRCdGMwRlVpSitwM2pOWWV4VTVTbVhtT3RmQVRXSHBhZzZma1pEMjdB?=
 =?utf-8?B?K1lCUno0YTNMTGhHaFZYRjBYeWozdE1ZNXY4MnUwWG1kK0p5ZDFwSXpJY1Vl?=
 =?utf-8?B?SXJoSTZQWmdETDVBUEpEQXdiRlpqM0J4WmhJZUdaeFlVSXJ1NGJlNm9LZWhJ?=
 =?utf-8?B?SzdTNjduN0ZhWkNTYlBZbEZ3bXN0dHB0ZUFBRHBkczlmKzZhWXJ5dncvbXJY?=
 =?utf-8?B?NHR0c2pjT1NoaXNPVjZaZnVkRy95bjNWTWdnUll0alNLTWc4VlFqditnWGxE?=
 =?utf-8?B?QjFGczFLVHF6d2pTc2wzUXpKU2h2YVhmQk9qNTRTVXhLYzJjOXY4UlRpSCtK?=
 =?utf-8?B?OGxmUFhJeE5ST1gra05ZdWJZYmRoUko4d3BDK0ZmbFgzeGs5RG9HMmcvcE1u?=
 =?utf-8?B?b3QvRTFhem9zWnJZZXJiQlZTcElRVk1VZjZyRlVZUU5kUW83UXo1b2N1VG9J?=
 =?utf-8?Q?PNiJxuwVc3UKG8RjKfDDCPl4OLUjGgNxlj6A7xh?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e28f6e5a-abbc-4aa2-1f54-08dd8e1f9284
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:00:41.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFCA907ABCA

>> It appears that all DMA faults are related to a fixed address,
>> 0xffffa000. Is this address something special?
>>
>> Also what does below message mean from a SPI driver's perspective?
>>
>> "applespispi-APP000D:00: Error writing to device: 01 0e 00 00"
>>
>> I am asking this because the IOMMU fault messages are about DMA Reads
>> (device raised memory read), while above message complains failing to
>> write to device.
> 
> When sending a command to the peripheral device applespi expects it to
> acknowledge successful transfer with
> 
> 	static u8 status_ok[] = { 0xac, 0x27, 0x68, 0xd5 };
> 
> but we are getting "01 0e 00 00" instead.
> 
> See applespi_check_write_status() in drivers/input/Keyboard/applespi.c
> 
> Thanks.
> 

Since its working with `iommu.passthrough=1`, probably disable iommu for this hardware (if possible)?

Although there must be some other fix since it was working without passthrough before.


