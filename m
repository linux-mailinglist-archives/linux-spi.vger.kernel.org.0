Return-Path: <linux-spi+bounces-7986-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF52AAE764
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAE03B37D1
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88828C010;
	Wed,  7 May 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="csXHIJbi"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993610F9;
	Wed,  7 May 2025 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637643; cv=fail; b=efpyCqcyfiFbGy9ZN4uBqsVud9lXbjUMgG0/tCvImXiradrT9hIRiBOowI9Kyl56ZD31uxErGdxxoi8c6bbYGGReu5ht9CIhyZttRyg4zxD2GqUrcLH1TzX+/8l+ZoPrpd/ZWkZP3ZzEj6HIKvmsXYecgKEpwi9ZO5e+A694bME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637643; c=relaxed/simple;
	bh=5rtpvuqEaxEqYLuSX1Uu8rUKQkNiPZ+nLBZ3U6Zd6zo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZ/0Nks1ae62V7HwwgFH1Why8X/xvGOST3h/0bgHmS6ft8YHIeG9Zt/tBjlt3EdBJ3apf27yfdZCyy+fzjzZc2MOHcsigMZQsaNMZZLU4yaSwiOOeGDniKzL3bp5zp2vGUeqVDQsQlHyIIywZSaJPJkElghpLKEDLjiSgKuMFhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=csXHIJbi; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW4nihuJTOcCpajWVOX4bNBXMuVRzH8uQEbXJC9fXtzgLGi4FzLavOnVIj+6yR1rq5dmDzBUNPFKOmIiVEEfT2vqrKS/YAMA5h4pNo+vI9IsHFdNCtPydal6LY0CbW3AYBpJNA8K/hYU0Ng2CrEfSn81m9uMuc4155tEC47lYispIhoQpX9UgSARovYuNWVERJkS1zhWCMgbcU+wCBBiEdwpiMJ3NF3k5J+ymRu9BElFBCEDIeb56pun9X7tby/QL+UPV5JL1HgdXoXM9wk8c5+fL+Hf6NKcXwoKFKdhdcenDPIXZs7jh47R9cJcDYtJkkHpQlkb6IB0SHf8vMZgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjSMRWazf2qSh7NkIaKWJh3DRNIIiRNjRDmTdjtxxf0=;
 b=j4lwWxIJumP7MFYBj9p17OIjndtRBP0AyAbyfKaZa3f0GLijRU2DOpcJDFtfpqEe7+a0LngT1uzHaCQvdMhmHdX3liPqn8mRENW5EE5wx/TY3LEI3sahgxgrDdnUDpOv5BekkQc2TAde91NZlYsfAXPfQyAYraec5PsOWFbvjMk58+nt6HiX19Fx3+lrWImi9glxGifDM0hDyyxxgOtaZRnV0ALzEdBU3veLrjLWJ7ghymTa8v3IC0ZpZQObW4S2mjgJTx+Z1wWKIZnVK4W0FLsWi4rOyGlLRSC8HiYtYvD3ocbhaS/pUgWwlDMy7etxcwhFr/Kpl27A9uL2ofYhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjSMRWazf2qSh7NkIaKWJh3DRNIIiRNjRDmTdjtxxf0=;
 b=csXHIJbi8oSB3fhDpJJ5lSentyZXL+JI+1B4Hl+oujq2n+E/CtAnAamDX43a6QhPpwyQQRySEOokfhYwWc9aY6d9z5wqFmJOeHBXEHgn725Yxm7g6r2/pZTSwZkZ58Jw6puuPvXsUFBdcA2auT9NeYUqh7+DX30KzhqAnFBgzKfrbmP7FUzTqigtob1AaqJfr+R7ww9FTsxjVvYSt0dA87xzVQuX/ZutB/r+vQPdRxS0mBCL6uufLxSrVvk+hXy3Jvm6dBYT2Sqd3EQdZ7xLMooePqvelaOUyc+GQZzrGgOqRGvy0ZNVNcaYLRxWrbGttP6mua1xfff6hn90r55QBw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB8902.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 17:07:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Wed, 7 May 2025
 17:07:14 +0000
Message-ID:
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 7 May 2025 22:37:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] applespi from 6.12 onwards
To: =?UTF-8?Q?Berkel_J=C3=B6rg?= <joerg.berkel@bfh.ch>,
 linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-spi@vger.kernel.org, lukas@wunner.de,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <817302ad-1f79-4bac-87b3-7006ff9c0ade@live.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f7b116-9823-4a8d-ff2e-08dd8d899d38
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQlVobdhjoRt/HQUSkoYJhJh8nllm098J3h7Cgpl5qLB6ZNCTXqbUowPML5V05mgX8t8WZpD3z3Jrz8Sff8f5MK7i4vmF1hL2j0nxcCC6Up449lqj65vPnfJ+A6OImby+5T6NG6+kMgnFYxlfDkdH3t1b905wMNsEP6esmbDJ5riZffxMbwqavyE5Bcop7DOcTwYkSijQt770G09rfB+5nNowLbWWpPW2EaMZnozN+oOQdZIAfbdOxnGicb0aU+EYGXmlYNJ9EUyO66yZetCkDVHeipn9szYS8Q6lbg/l5v7zJw8nFE4W5VJimSkf5EXrKgOBq6JbeYtKi9W2/r8+CcKBpVnQ/5BFi3JxSldde+LVL2d7EIJlcf6L9bAr85unRYWwYyh6ORT8V3J6kkqpUq+1R4L/G1vnje/14hrz5ayul5R64t5UVbEdjMMX1zVqkJ+Gj7cqRlqzHUUspKg+5a9EeD3Xt38e07LBIvI6SEfc7Or1DdO6omj83QOh+WNtd6x+KNI1OggqFIdIrEsiVAv6OnDbc1ouHIXb+S1zibmYs4A7qiv32mNL9xxx8N7czFbM5ppsyTgsmGlpfG3jtL7QEpR+65PTdw4erD7JLxcro3wYweAmyJwzvYU6Yd9NrjiMXGR83NG+tJ9uMhrZkjvsbLmLZzV2QqvEuximpwwPqwvkk9fvGVsrj7c28wErhNOJGbfFj156JaIvwWy2IaDYoQ7kv4IInk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799009|8060799009|7092599006|19110799006|461199028|5072599009|10035399007|440099028|3412199025|34005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjFiWDFTM2svZnF2eEtLbU5Ka1o0VUplaTB3azJTREt4bTZEWmt6RVFFTVhl?=
 =?utf-8?B?Z0c2T3lEUnJEdnMzTEgzdVphR2wyUUR3Q1RLVURDNk90TG5UQldpQ25PdFA4?=
 =?utf-8?B?QUtSS1pFeEFjRHhJQk01b2d0VE5hQnAyT1RIK05Jb0ZpQnNPYnVpZjJoRURa?=
 =?utf-8?B?NnlCVHFYN1FEb1NjaE1pSXBKN0t3N21wYUZud0NaNmRSUVhDZnJvL3dNWGRu?=
 =?utf-8?B?dTRaTjMvcDdNNFFMZ29jY1JuV0Voanl6MVpFMHdJZjFXNnpmeDh5YzhJYy9P?=
 =?utf-8?B?WC84ZlN0MlZ5UG1YY25kazR3amEveGtqamtFZlA5YW96bGdiTUZQNU5qREVs?=
 =?utf-8?B?MWxQc0xLZTlPQ2lQdkZXeGFBTWRYNUIwdmdCdnd6bmhtU2lKaitqaEtVVUpL?=
 =?utf-8?B?UHY5cWFNbExHZ2M1OWJGeWRiVjFHYUNGWjcxT1YrbHhFM3RMQWtVRHpoOXJR?=
 =?utf-8?B?bnpxY3c0eGhZNnJBd1ljdDhXOTN6cUdSak5yNjN5cFQrVVRlUzF4NG1BTDJW?=
 =?utf-8?B?cE41Ly8wcnE3SGFyUnNGdWFOZ3RsMVE2bkZpUVQ3NUNNYldDOVdvVjYvNGZ2?=
 =?utf-8?B?c2kwRnhGdlArVS91Q0k3aWdIaEt4OTZhQUJBaEdNRkp6WCticWpFTmkyTHhX?=
 =?utf-8?B?NmJZRjM2UHE3cWt2dEdpUHVYRjFlY1J2RWVjdlhGT0ZXVjZUS1V1STRXYnoz?=
 =?utf-8?B?S2Yxei9sK0VRdXVvN21hVCtaVGsyaTlDcHRYUXdsejkwNFQrT2kxblVTbm5s?=
 =?utf-8?B?TnNDZEJrMjBGSVhEdUVqaS9QRWNGY1V5cUtnbHE3OFVWaDVGckFHVmFhb21p?=
 =?utf-8?B?b3JoUW1UK1BLTzJ5WG50NGZxTUkycnBGUGEvamd4ODV5TFBGK3VCYWlOUC9Y?=
 =?utf-8?B?cXZZV1h4bHJaQU5kTWwwbnVJeDBxcVRTYkZadGJ4QU8vcE1xV3NaeDZRL2lh?=
 =?utf-8?B?QWtZd3p4R2ZiM1BhK1JOZ1VKYnJwODU2T20wWTBPYkg4TVAwdUdwMVN0elE1?=
 =?utf-8?B?d3lRN2FKREJLY29hUitxMXArdFdsRnBnZVlHQlpNaTF1c21jUWdweDMvQW5o?=
 =?utf-8?B?bVp0THFhZ2l2dTdoalJUVVlmWjhoQjNEak04SU1NWVJuWGkzVVlMTExXMXNQ?=
 =?utf-8?B?T3lhNnFkb3NhS2c4bEJuYm13NDlSMXhGUXhFQVdlVVNtUkpBbmRPZGgwOEx4?=
 =?utf-8?B?WnErdTNXTnlKa0VxMzR5NnRtZlU0TmdzMUs3amtRZEJHWnBMWlhBK3RkbVBU?=
 =?utf-8?B?UjRBUWpKNVYvZmp5b25QSUZKSFBhMCtxSENLYVFQaUJnZ0lnMVlCdFJ2b3N3?=
 =?utf-8?B?bWlzUFdndm84ZWZ2V3MxVnZwYk5vdUl1QW5uN3FTY0YvM0ZjRzEwNjRwQURO?=
 =?utf-8?B?ZmxsMmc2Wkh0TGVqcTdiQU4wYWoxR1ZzMkNXRHZKNnB1dytwSUt5cHhuWUZR?=
 =?utf-8?B?MnA4QmsybjlpeDZCUUZVRmU2RTZBZC9RK3FxRksvcjFhYjdPTXRhN05wbSt6?=
 =?utf-8?B?U3dveFNXTDdlTjFIWTN4ek9EaFQraDhrZ2o0TkVoSUphSUZGa2FOelo4MFhw?=
 =?utf-8?B?YnFPd3g5Ny9uV1QxRkN0R2JOQkRFRGtyVnhBRnRsWnJVQTc0dEhqWkdYbm9a?=
 =?utf-8?B?OFRKaTRiZVc4Z1hhTksycFNUUkh1V2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRVbGJ5c0JOcXRTVG1rZWI2YnFhZGhKOWpmQmNDQ0Z6cytQaElma0x1MVV4?=
 =?utf-8?B?TUllWkFLaC9jLzhydERrWEQ3NFdVS1hxbmNEZHA4TTVlM3FoamQ0SjZ6dXB5?=
 =?utf-8?B?QndjNE93VE5JNDJLb3Axc0FLWXY0cWtKQ05qdjVxN3c5dzQ0Q0RvZGl2TkE1?=
 =?utf-8?B?akt2MVR4S3J4VjJQRFlPaFE0QzZXa2RucjBQSkY0SVQ5SmwrekVuMTRBcStU?=
 =?utf-8?B?NHZHZ2lZRmY4dm9WR2ZYTWMyWHBsNTRiU1pvSkkrczgwVXNVeENqd2RSb2No?=
 =?utf-8?B?Mkx6US9Sa1ZPcTdJdURSdXZXS2tYY1F5c3YzcmtHeEFnMmVSbG9jRFJYei9V?=
 =?utf-8?B?R2FJSTNoYzJjNzA1K0ovTXBDTWxsRGpaRDVPNUJDTmxtQTMyY2YvdE9PSlJX?=
 =?utf-8?B?OVI3VmFYcjY5Yk8zRXBmaGlWY0szSWFEaXVFbnhINXZmZUZXbnJGWUNPbTdW?=
 =?utf-8?B?ZTgwWVMyc1dvZGd1MXVLbGRLWG5TTmRJcy9vaHFYdm5TWmlMK3h3ZUw0U21n?=
 =?utf-8?B?TUZlUjdHcjZaY0YrTGdJbWc0RnZEVW5wMTdEOExHR3ozTXQwakRWa2NLaVRR?=
 =?utf-8?B?TGpqa1RWUHRUelVFaEtzZEdNekNvM25CS2RmcncwdDNUY0Y4QmEwRzlrUU5i?=
 =?utf-8?B?MzF5RkRLeDZSZ01EZlVQeFJBaHRwU29zd04zVE5tMEVETFZZdHBmUHdmYjls?=
 =?utf-8?B?SzMxSkN5NnRqYlJmZlNaOWlaRmZ1Qlh4a01iY3JXUktoQkZTQVI1S2Y4QnBB?=
 =?utf-8?B?UjJWekw1QUZHWS9iUThBcHJSTWgvcVdJblNJSDNHS0RyVTdFWXBYVkxYNTJP?=
 =?utf-8?B?ZGJVVEoxQ0FxVzFLRnBGTXVSUlRZNTB4UzJvaWg4SEl3WE44c0lGSmZLNmE0?=
 =?utf-8?B?eStFeUM5VHRYN3pIWFJtK1Y5UlJ6dVFOVnZNcVFHM0lhQTNqaW4xTG1SSVF6?=
 =?utf-8?B?Z3hId2V6Q0s2b05uMkl2emRYY01pRTJsbkdOcjIxUk10M1VpUEFCSXFXdUtF?=
 =?utf-8?B?ejRzWGIxQ2Nnc2ZhcmtuaWNldlhhU0ZhS1dNK1FMZDRITnF6RjJ2bm9aRGQx?=
 =?utf-8?B?OVZ5SENMVUNhVEs1N2h6NDRLRGM3Sm5TeUZDNEdQTE9SVWwxZ256M1AxTTJV?=
 =?utf-8?B?ZGJva2NaVVdiS3IyODBtSTE0VE1aaElWWXA0NHFnazFYMlU1MFExaGtIaXF4?=
 =?utf-8?B?cnZvcXdwMVZFUkRNanJ2eXhRRUFBWEhpTzBGVWFjaW1YaDd1dUZnWUNsVGNl?=
 =?utf-8?B?VVpXb2ZSdHBDUXpUUStvZEpFaGo1S3ozMldJc1hXeHA2NnNnbkpMc1ZNeFdh?=
 =?utf-8?B?RzlnRzRwYitocFRYdm15Vjk1MWw3a3FiRUNWOUgrMTJSYy9sSlh1ckpOeSto?=
 =?utf-8?B?dzB3TS8vTWVCTlU5MVplR1pCNmkvVU04RExZejMvVEQ4QTd6dzUrRUE3c1Ey?=
 =?utf-8?B?U2YybWpIOGVlMkJMSzNuVEZndWdud2lvNTVNdEQraTZWendtMHg5UjFNQ1Az?=
 =?utf-8?B?SnBqNWRPencvM2dHaitCTzR3WFhvcmlFSFhzSloyNkVoYWE4WGFMMFJGMk04?=
 =?utf-8?B?TUgyYkNSVXZYZUd5Qy9vMGpxRWdnbVY5UUxMajl2bFVrOWx2YmVudDZpRmhq?=
 =?utf-8?B?M0xMREYyWjJDeVhGMHNZbXdoa3VzYm5rWGs2OS9XQ05ESTliWTd6UXZTc0FE?=
 =?utf-8?B?a3B2c1AwY1BEazRmUy81Q0tlN1d1WDFXbXZKTDQzaHFDOTd5MGNycVZYMG5q?=
 =?utf-8?Q?cGnQncjaZRKmy6Far8JLw93opmEPDjI4ndoVKsV?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f7b116-9823-4a8d-ff2e-08dd8d899d38
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 17:07:14.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8902



> Keyboard and touchpad stopped working on several Apple Macbooks from the year 2017 using kernel 6.12.xx . Until now I could only find this discussion affirming the bug on Debian and Fedora: https://github.com/Dunedan/mbp-2016-linux/issues/202
> 
> On siduction I also tried the more recent kernels 6.14.5 and mainline 6.15-rc4 (from Ubuntu) and the issue persisted with my testdevice MacBookPro14,1 -- see the relevant output:
> 
> kernel: platform pxa2xx-spi.3: Adding to iommu group 20
> kernel: input: Apple SPI Keyboard as /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/input/input0
> kernel: DMAR: DRHD: handling fault status reg 3
> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> kernel: DMAR: DRHD: handling fault status reg 3
> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
> kernel: DMAR: DRHD: handling fault status reg 3
> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> kernel: DMAR: DRHD: handling fault status reg 3
> kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
> 
> Many thanks,
> 
> Jörg Berkel

Ccing Lukas and IOMMU devs

