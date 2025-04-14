Return-Path: <linux-spi+bounces-7563-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DEFA8761D
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 05:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C3018901BC
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 03:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACD42077;
	Mon, 14 Apr 2025 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="q6vxKgEp"
X-Original-To: linux-spi@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021075.outbound.protection.outlook.com [52.101.129.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8E28EB;
	Mon, 14 Apr 2025 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600309; cv=fail; b=u/4ggb/XE+++e1Xchq/qKGE7E73Amd0oE1Jv3NBsTXDCnEUkgnC3LT2uP+ID2QFNSZIXvaquoupdNHepaZdco9viN8ivcav/PVucwD02JgDWP43vmg1bdhELejIOHmm3Q4Bo0bx93lx+P9stdITVaWzR5rDjEzqsQWZR8Eo+zz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600309; c=relaxed/simple;
	bh=shA0nY3/HZCbJD39YwM1Y2pfjz2AAH/E2ZAVTKYytXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HyJg8APNI0ctDeuB6ZkFQsXCeCK6WcO1nSq8G6ZOKwOO0D/75wnH1h5DaHjrQRL1yMO0gjesO6KxW4egvOFeholnmtbhPT/qWLUmhX0D2SkWAiXPnV/nv4vXHfb7QQ3BEJY2G8R254zIKrtBACVX1Rtz9c50DNjc4EdpG+gqr60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=q6vxKgEp; arc=fail smtp.client-ip=52.101.129.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfjbXpfNLjDS+HwOFAH71ltl3hrW2o7flLsyp4UvLE7/kzYT8z+hTdNaJXZ2dBFAu5xGKxTaIWlwqUOQuR6OqnARFZbsZ0UIh9yL3Vk/B9DRODGgoUcFnkrNQvT6HS97fflgT88uPinphvTTabfjksBV6aZyF/Gux6Vt7yEGe2zREfNXO4jS7ArbuKUgDoDAruvYUBUY4gl6QKJWpD0Z4eKhzB6h8qxnfTLUBGrvyEtLguFcj6gUAjVQnEch85SariKd36kY+ZGFTEcWHwKp9wbwFPQHl1KuA+rxDOkk3HrFDbWGeOJAv+mNM9V/pPECVhVqvy9C16UyFL0BggVuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr76jyA2u211F1uyXN9juyYgjGvDDo2F/Nml+y9sbQU=;
 b=HbZm3E7xOZDxF5aUCpfMHt6+qPyPmGieCRHkd4WFtczt1Ts2XD2SDgLoTj5gg0AYEfaZQemSBnZj1jdIjpG1eYANLLkL2Ru4P+UVrU5oTNopVT2apuGahJXjQlziSobSYCJiLXxYwgJxxPPzP4Kpag4WMYAxeruPCXQ7QD9CfoGwDBWSSfp0SMEF2JMm0PYv6sRfmrjphrCbJVUFzbL1v3OIWcerffw2TCcfdLDQulpLtjvI2DNVTnxcipmjTuzAzB4sHiqA66U7yFWBjrPeM0bA0NdnRXIzR0qA5ySPdd6CNMXYERtLgcyNajiVxJJHwzDhg06lC6k8/TYOQQyMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr76jyA2u211F1uyXN9juyYgjGvDDo2F/Nml+y9sbQU=;
 b=q6vxKgEpbkcsw+qoKQL3d2Ez6MExZFQxWUuGkacl+lsW7cotJWOZW9uVjaarJDLK1nQ5W0EW4smPb7s3yciVYiwBhXkGSlLcEm5cYU3s2zgeyZbF11TlcocUeQeVJddej4Yx9MgDEOAdWAnjmojpV4uNFbRWlDiapR6pkQI8VUzppawluwVizQ3tjpdomGZ9g0mpBICwsUjYIPFXkd0YNA3fRJli5Rn9BjyP0Vp+/o1SUwp3k+D20Ua1jRcO/ok4+kPU78Y2xVfJIzpVJMyO9z0zfQsbIbeCK7w1+e/S21NKJW81TZbikdaGz7CHvQonLwOEC4XpJ3lZGg6Fk0z0SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7825.apcprd03.prod.outlook.com (2603:1096:820:ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 03:11:40 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%5]) with mapi id 15.20.8606.027; Mon, 14 Apr 2025
 03:11:40 +0000
Message-ID: <c9f0ca5f-17c4-474f-8370-fc0c83ac9093@amlogic.com>
Date: Mon, 14 Apr 2025 11:11:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: meson-spicc: add DMA support
Content-Language: en-US
To: neil.armstrong@linaro.org, Mark Brown <broonie@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sunny Luo <sunny.luo@amlogic.com>
References: <20250408-spi-dma-v1-1-3c38be62c09c@amlogic.com>
 <c29a8c28-996c-4e94-b0a1-0e4a37f0bebb@linaro.org>
 <aebccc51-14a2-40be-8d9e-20a55ce94459@amlogic.com>
 <d9d81cb4-12b4-4db3-becb-4578548986b2@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <d9d81cb4-12b4-4db3-becb-4578548986b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: bd31cd36-58b5-4a18-3aaf-08dd7b02133e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFdEdzlxay9SU1dyN21USVBSWFNLUVEvSTQvSDdOdjFPV2hxUVNhYTNHR2NS?=
 =?utf-8?B?V3dnMjllWWp6eVl4azJkS0hsdDVZL25rbjNYejkxUGlXMk1CYysyL2NCR2p5?=
 =?utf-8?B?ckdyZEJpcFFOQ1AvbXAyVHZlSnVld3k2dXRNdnJpYTdTeEpiMzVjVjBDU3Za?=
 =?utf-8?B?Y2hVdkp0S2huZ0tTZFdHUG5sc1hDT3doL3JiWFRrUDFsN1FoWitFTUpicVdS?=
 =?utf-8?B?VWQ1QmtLNjliSkN0cXFFd1F3cUx6MWZkUDZCTTFhNlRBUnkzWGpqdk51ZmlR?=
 =?utf-8?B?NmcrSjUzd243S3NHTHdmRmU1eGZ2ZmVmS0JuMUJ6RGp3eGFtSVZvT1pHenZp?=
 =?utf-8?B?MkxYMjZjcHAxUlpoUDQwWDFLd3VadXNGaUxSblVZMHh1TFhPY1FDR1VMaHR6?=
 =?utf-8?B?M2ZHamRVcVhMNk1LZVpVNSs4REE0bDJZSTBMRjc2ajB1ZVVOY3dITUk4WjBv?=
 =?utf-8?B?M0ZNR0FLUE1NSmxLazNXKzZiR1VnV1ZJdk9EdHZGVEhVaXZBWVNTOVVLbWww?=
 =?utf-8?B?WktWem8yOUhRNUlSTzBYaHFQaFYzaDQwL3JYQXUwblJ0a0Iyc3ZZOU1vVXc2?=
 =?utf-8?B?bzlmeDNOTkluZTFBdy9iTkFZT0syRmwyWUVUTGxkMUx3a2VMc0lRemtCNDBT?=
 =?utf-8?B?NENpQjAzd2txdW4zRFAzWVR6Z1lRUmNsTEEwendJdWlUSmh4bUozMjQ2R29k?=
 =?utf-8?B?aFFmaFUrM3c0MkhMQnJGbW5ReGxQejR4SldpLzZHZy83U29JbE15aFFETm1y?=
 =?utf-8?B?QTRXKzZIZjZQbWpjT0Zsa0htZWFnb2xWVytwaGlVTzZxNkNsc3dNaGkvRWZO?=
 =?utf-8?B?T1F1dUtVWjdma0dtNTBuN3NManJrVmhxRUVvVEgvZXhvOFFyZDhYUkpFN3FI?=
 =?utf-8?B?a3V2bW9NcTEzM1FzeS9ZcXhLelhYMm53Vmh3cnlFUVpaOHVwdW9KNXdWanVL?=
 =?utf-8?B?ZG53QldYc2dHQllPcnhjNlZpOVJqbUkyVGU4clJZV1lpMUF5Smp0a0N1eFBM?=
 =?utf-8?B?cXlDem5EVW14ZnJqVTU3TzVuSy82Z0hSZXV0OXVhL3hFNVRlQ01ST3ZjOGhu?=
 =?utf-8?B?UHZDaXBsa3hjcjdueFkzT2pGOW43SHhLQ2owaGprd3JQWm1XYTFDd1dHbXMx?=
 =?utf-8?B?SmtubG5YenVsWmVveVdrakpRS0tWUUlGYThRL0lML3dIc2haZUdWMGtUUjV2?=
 =?utf-8?B?aEJDNUtKbzBWeFowM0dRUmtralZyZHNXeGlpeWM2TGdqNVRRSlVEMUROeVpv?=
 =?utf-8?B?OUkzTXh1VjZHSDBoM3RUTjlHVHczY0ZlR3lFRmIvZFV1VCtpUU83WUFpdEtM?=
 =?utf-8?B?VWovbTgyZXJFamMwTnE3K0tyamdOeDNiajVvVG1yR3U0VmFvdHBaNS9sNFhs?=
 =?utf-8?B?ZTVBZWFjc1NNQ0hHQTJudW5UcW9pN3RMMnNrK2dNbHJRaHoxc3BYYmtoWXVI?=
 =?utf-8?B?bnBFVGlRYVdCOGtNMm5aWDdDNkUyMFRxUnMybWpoMWNKQUFDWCs4RHlIWkxL?=
 =?utf-8?B?ZWNVTVhGM05tN1d0aG5GZHBzVVZEak1ZYWtuQVFMTXNqc2c2QjF1Wkh3UkNq?=
 =?utf-8?B?SDBKL0w5RHhVTjQ3VXZBK2J1ZXEvZUtkN2tVQmRON213NmpZeld0cXF2Q3dK?=
 =?utf-8?B?MXV1RFNpcytVRC9Qd2YybUNQcUV6bTZlTTVxS2xWdGNleVF0L3BEdCtvYmZN?=
 =?utf-8?B?NUYrZjNhTFp3UjNyb3ZHc3dlQVR1YnhzQ2RiekVzeDkvbEdiUnlmOFZiYlpS?=
 =?utf-8?B?elplY2xuRkI3dFZWcGlCRndORlZYMDlNNVAzTnQ4NndlYkdlZVEweHNsWVZS?=
 =?utf-8?B?SlMrSFo4Uk5aNkw2L3ZmalpIRHNWeDQrbDJCdXNwL1lFQnpJRFZYbEZTSldJ?=
 =?utf-8?B?UFBqYzNxaktXcVplUlFCNXRQb3dSVlBCZkJqTkM1ZWN1WWdXRmhzUWhtNW5M?=
 =?utf-8?Q?mmSkFSSNNxI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXlvcVpDMmFDMDN4T2ZpYWZGTmRsUXlrUitXdlFjTU94cXhOWWJyb3BHclRC?=
 =?utf-8?B?SHBMU0pYUnkzK2lyclRUYmN2Nzk5c3RNNGZqd0w1MEthSlg3eE9iVmdXNFoy?=
 =?utf-8?B?QjdlZURmS1E1MDNwYXJ5a3NmMlRrSkFUdzIzYnVPbElTUS9tNDFYeHpqZVFv?=
 =?utf-8?B?SHk4Q1RpZU1RVHNuV3FKK01rQW5EWFlEY01IWTlqOUZZNjdLWGh2QUc2N2xl?=
 =?utf-8?B?eHo2SDhZK2ErcEZrRXlIRlhsTU5rRVVGcUo3RFNyaENUZ0Q1eVRTNnNWTzFy?=
 =?utf-8?B?cWZ2ZEtDZUlNaTdjWUtHQXlRQ2QrSHJsM1V6MGF0R0pCS1pqd2RPRUcvbDJK?=
 =?utf-8?B?SDI0bEZML0Y3cy9RZkRINUwwcGFabnhwdHAzQWlmN1UzckNMMHducnBnYml6?=
 =?utf-8?B?aWtzTFIwdnZOVWYzZElORTJTTVMxUVVSUldVZGZaNGMxbFZzalU0ZW1LUFpq?=
 =?utf-8?B?eEhBd25Pc3J6TUVGOGppaFFKTjB2YTBIc2FHa2pqaGJENWNETU1TT0JhcFcr?=
 =?utf-8?B?ZFJmd21Ud2IvS1BkRHdhcFpLVFZEREYwMHBOV2dxd0JaeWdSaEtHZU5oQVRt?=
 =?utf-8?B?bUJxNHJ1akRFWGZpQ2FacFlxRDdybndDK3p4TWwzeTZtNWxVUVBJQllpeitB?=
 =?utf-8?B?YzZ4NTRmcjJ1WWFpNkVFVXp5U2lOdTQzOVJzbzFEVUluMnJYZDdxa2FGTkly?=
 =?utf-8?B?a1RZVTE0K2h0aHJBbkxacEw3dlZLVlY0NUdDR0IvYmFONjJoU0hIeDhKc2Vq?=
 =?utf-8?B?cm1oOGZYeElhOUk5dSt5K1JLNzlGQ3FkalVhT0U1NTJpSkJ3WkpGN3prTlpH?=
 =?utf-8?B?WEFxWTE4SlhkL2twMDlIM0tNSjEvTWE3dEJOdExKbUNUUndMYi9sWlF5c3p0?=
 =?utf-8?B?Sy9QQ0Z1QkVtdmJiZFhTTHRrWUFsVEhDVk1xWTRSVmRnYnBxdzdFSnNReGNx?=
 =?utf-8?B?cUkvYWhka2w3YVhXQkVvaWNsRzhHUkVXcXlOMDhuUzVkRUs3MlR4QzluVUov?=
 =?utf-8?B?MERjbFdhd0ZRNE9sOHJqRWJFMm5Ud3c4aHNjT2QyblhDNGV2QWQrc2dBTUp5?=
 =?utf-8?B?MVNtSmVVVDdMUlQwM2pBbGlUZklEQjBuRUloOHlaY3lyU25MR3dwVDZiTFFa?=
 =?utf-8?B?ZkxVSUR6T2x6Rm4rem83YXZRbTRMQ2lsN2xzM1ZsL2RCczVUQWtoZGYwc0Vr?=
 =?utf-8?B?NXlEcXBZcUxDRGI4OTU4WmlOZGFHZi9Wbzd3em4zT011cmNNQlk5ZFAvaVNk?=
 =?utf-8?B?TGE0L0lZdy81bmFwOWY5bXdJR0tyZkFIYjVMUWJGbWtTR0pVVXd0ZU9CUmFB?=
 =?utf-8?B?UHFLQUJpZDhSam1WdkpaMUJnUy9WSWZBZGQvbDd1Zk9QdFhBSGk3OFNBS0E5?=
 =?utf-8?B?ckllN1NKQTV1U0xydFZKWWcyNzhqNmlMOW9ybFBmeWxIKzZTemN5VFlkQWNZ?=
 =?utf-8?B?VG5NdytPa2NtaGlHMU5tZ0drSTRKSVBFV0RDcWtSR2xpak1iWVpjTGh6SVZS?=
 =?utf-8?B?U1JDMklOdzlONm56eUFUZFBaUVFTYXVDOVFEdVAwOE5lQXJsTnVOUVg1Z0Iv?=
 =?utf-8?B?Um00cjJHWm9HRFowMnQwNXcrUWtPV3dHREF3emo4N2hEMjJiT3dBSU1LS3p5?=
 =?utf-8?B?RUFld2ZWMXpmNUlSb2k2YTVySENYNUZwaTUxMHFjY21kQWJxWVVveitPMDVr?=
 =?utf-8?B?WXliY0dwaXBQU0F3WVVHWGRuUUtHbGczRmJXV0x5YW5aVkRHVmUybTdYMjgz?=
 =?utf-8?B?M1hiQzRMZUJJR29VMzVlaTdzS3JsU2IrSzc1M2Q5WTVndlhjMlZLUFhtN0F6?=
 =?utf-8?B?dzlOUTJnWkE5clU3UjN6UTdxZXJuYlVUanBSQ1RCdlp2dTdnQ0cvQzVrZkV1?=
 =?utf-8?B?TlJxcTVkOFV3cGZaaERVbkVjb05uWEx1K2dBSTNVcDNtTVhuMzR1NmpyT2JE?=
 =?utf-8?B?TGdodzVlUVFwWVJtRHlxU1hWVTN6dFkzM0Y0UzJmdEp3citPSGlGUDdveWY2?=
 =?utf-8?B?L3RHa2VOaVcvU3hscTB4d2NtYmx5V3JNMW9VbGYxTkU3T1pPaklhL3ExRFcz?=
 =?utf-8?B?N1RKM2JiUFNXTkRmYVE4YnlqWEorREgyT0JPWk1MdkRiV1hlQ0hyWE1BZ2tJ?=
 =?utf-8?B?bW1PSVpNd2dQZ2dNaUoxWHFxR3FDaCtlaVdKMHYrYjFnNGlISmtBRjNBNjM1?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd31cd36-58b5-4a18-3aaf-08dd7b02133e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 03:11:40.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+GjxSQFj00CVSWFWWAPB6ae9shj9s2s6nNVMOdDii+NJ6niswnNMtuy/wrnrXnMF3uRpMYC87ypVFu5IcCrZTuzGG4srRisrJjQEbam5mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7825

Hi Neil,
    Thanks for your reply.

On 2025/4/9 20:35, neil.armstrong@linaro.org wrote:
> 
> Hi,
> 
> On 09/04/2025 03:49, Xianwei Zhao wrote:
>> Hi Neil,
>>     Thanks for your reply.
>>
>> On 2025/4/8 15:41, Neil Armstrong wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi,
>>>
>>> On 08/04/2025 09:04, Xianwei Zhao via B4 Relay wrote:
>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>
>>>> Add DMA support for spicc driver.
>>>>
>>>> DMA works if the transfer meets the following conditions:
>>>> 1. 64 bits per word;
>>>> 2. The transfer length must be multiples of the dma_burst_len,
>>>>     and the dma_burst_len should be one of 8,7...2,
>>>>     otherwise, it will be split into several SPI bursts.
>>>>
>>>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> ---
>>>>   drivers/spi/spi-meson-spicc.c | 243 
>>>> ++++++++++++++++++++++++++++++++++++++++--
>>>>   1 file changed, 232 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/spi/spi-meson-spicc.c 
>>>> b/drivers/spi/spi-meson-spicc.c
>>>> index df74ad5060f8..81e263bceba9 100644
>>>> --- a/drivers/spi/spi-meson-spicc.c
>>>> +++ b/drivers/spi/spi-meson-spicc.c
>>>> @@ -21,6 +21,7 @@
>>>>   #include <linux/interrupt.h>
>>>>   #include <linux/reset.h>
>>>>   #include <linux/pinctrl/consumer.h>
>>>> +#include <linux/dma-mapping.h>
>>>>
>>>>   /*
>>>>    * The Meson SPICC controller could support DMA based transfers, 
>>>> but is not
>>>> @@ -33,6 +34,20 @@
>>>>    * - CS management is dumb, and goes UP between every burst, so is 
>>>> really a
>>>>    *   "Data Valid" signal than a Chip Select, GPIO link should be 
>>>> used instead
>>>>    *   to have a CS go down over the full transfer
>>>> + *
>>>> + * DMA achieves a transfer with one or more SPI bursts, each SPI 
>>>> burst is made
>>>> + * up of one or more DMA bursts. The DMA burst implementation 
>>>> mechanism is,
>>>> + * For TX, when the number of words in TXFIFO is less than the preset
>>>> + * reading threshold, SPICC starts a reading DMA burst, which reads 
>>>> the preset
>>>> + * number of words from TX buffer, then writes them into TXFIFO.
>>>> + * For RX, when the number of words in RXFIFO is greater than the 
>>>> preset
>>>> + * writing threshold, SPICC starts a writing request burst, which 
>>>> reads the
>>>> + * preset number of words from RXFIFO, then write them into RX buffer.
>>>> + * DMA works if the transfer meets the following conditions,
>>>> + * - 64 bits per word
>>>> + * - The transfer length in word must be multiples of the 
>>>> dma_burst_len, and
>>>> + *   the dma_burst_len should be one of 8,7...2, otherwise, it will 
>>>> be split
>>>> + *   into several SPI bursts by this driver
>>>
>>> Fine, but then also rephrase the previous paragraph since you're 
>>> adding DMA.
>>>
>> Will do.
>>
>>> Could you precise on which platform you tested the DMA ?
>>>
>>
>> aq222(S4)
> 
> Will you be able to test on other platforms ?
>

I tested it on other platforms over the last few days. G12A and C3 and 
T7(T7 CLOCK use local source).

My board SPI does not connect peripherals and is tested through a 
hardware loop.
cmd:
spi_test -D /dev/spidev0.0 -v -s 5000000 -b 64 -l

>>
>>>>    */
>>>>
>>>>   #define SPICC_MAX_BURST     128
>>>> @@ -128,6 +143,29 @@
>>>>
>>>>   #define SPICC_DWADDR        0x24    /* Write Address of DMA */
>>>>
>>>> +#define SPICC_LD_CNTL0       0x28
>>>> +#define VSYNC_IRQ_SRC_SELECT         BIT(0)
>>>> +#define DMA_EN_SET_BY_VSYNC          BIT(2)
>>>> +#define XCH_EN_SET_BY_VSYNC          BIT(3)
>>>> +#define DMA_READ_COUNTER_EN          BIT(4)
>>>> +#define DMA_WRITE_COUNTER_EN         BIT(5)
>>>> +#define DMA_RADDR_LOAD_BY_VSYNC              BIT(6)
>>>> +#define DMA_WADDR_LOAD_BY_VSYNC              BIT(7)
>>>> +#define DMA_ADDR_LOAD_FROM_LD_ADDR   BIT(8)
>>>> +
>>>> +#define SPICC_LD_CNTL1       0x2c
>>>> +#define DMA_READ_COUNTER             GENMASK(15, 0)
>>>> +#define DMA_WRITE_COUNTER            GENMASK(31, 16)
>>>> +#define DMA_BURST_LEN_DEFAULT                8
>>>> +#define DMA_BURST_COUNT_MAX          0xffff
>>>> +#define SPI_BURST_LEN_MAX    (DMA_BURST_LEN_DEFAULT * 
>>>> DMA_BURST_COUNT_MAX)
>>>> +
>>>> +enum {
>>>> +     DMA_TRIG_NORMAL = 0,
>>>> +     DMA_TRIG_VSYNC,
>>>> +     DMA_TRIG_LINE_N,
>>>
>>> You're only using DMA_TRIG_NORMAL, what the other 2 values for ?
>>>
>>
>> DMA_TRIG_VSYNC and DMA_TRIG_LINE_N are used by VOUT modules in certain 
>> partial TV SoCs. These DMA triggering methods rely on special signal 
>> lines, and are not supported in this context. I will delete the 
>> corresponding information.
>>
>>>
>>>> +
>>>>   #define SPICC_ENH_CTL0      0x38    /* Enhanced Feature */
>>>>   #define SPICC_ENH_CLK_CS_DELAY_MASK GENMASK(15, 0)
>>>>   #define SPICC_ENH_DATARATE_MASK             GENMASK(23, 16)
>>>> @@ -171,6 +209,9 @@ struct meson_spicc_device {
>>>>       struct pinctrl                  *pinctrl;
>>>>       struct pinctrl_state            *pins_idle_high;
>>>>       struct pinctrl_state            *pins_idle_low;
>>>> +     dma_addr_t                      tx_dma;
>>>> +     dma_addr_t                      rx_dma;
>>>> +     bool                            using_dma;
>>>>   };
>>>>
>>>>   #define pow2_clk_to_spicc(_div) container_of(_div, struct 
>>>> meson_spicc_device, pow2_div)
>>>> @@ -202,6 +243,155 @@ static void meson_spicc_oen_enable(struct 
>>>> meson_spicc_device *spicc)
>>>>       writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
>>>>   }
>>>>
>>>> +static int meson_spicc_dma_map(struct meson_spicc_device *spicc,
>>>> +                            struct spi_transfer *t)
>>>> +{
>>>> +     struct device *dev = spicc->host->dev.parent;
>>>> +
>>>> +     if (!(t->tx_buf && t->rx_buf))
>>>> +             return -EINVAL;
>>>> +
>>>> +     t->tx_dma = dma_map_single(dev, (void *)t->tx_buf, t->len, 
>>>> DMA_TO_DEVICE);
>>>> +     if (dma_mapping_error(dev, t->tx_dma))
>>>> +             return -ENOMEM;
>>>> +
>>>> +     t->rx_dma = dma_map_single(dev, t->rx_buf, t->len, 
>>>> DMA_FROM_DEVICE);
>>>> +     if (dma_mapping_error(dev, t->rx_dma))
>>>> +             return -ENOMEM;
>>>> +
>>>> +     spicc->tx_dma = t->tx_dma;
>>>> +     spicc->rx_dma = t->rx_dma;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void meson_spicc_dma_unmap(struct meson_spicc_device *spicc,
>>>> +                               struct spi_transfer *t)
>>>> +{
>>>> +     struct device *dev = spicc->host->dev.parent;
>>>> +
>>>> +     if (t->tx_dma)
>>>> +             dma_unmap_single(dev, t->tx_dma, t->len, DMA_TO_DEVICE);
>>>> +     if (t->rx_dma)
>>>> +             dma_unmap_single(dev, t->rx_dma, t->len, 
>>>> DMA_FROM_DEVICE);
>>>> +}
>>>> +
>>>> +/*
>>>> + * According to the remain words length, calculate a suitable spi 
>>>> burst length
>>>> + * and a dma burst length for current spi burst
>>>> + */
>>>> +static u32 meson_spicc_calc_dma_len(struct meson_spicc_device *spicc,
>>>> +                                 u32 len, u32 *dma_burst_len)
>>>> +{
>>>> +     u32 i;
>>>> +
>>>> +     if (len <= spicc->data->fifo_size) {
>>>> +             *dma_burst_len = len;
>>>> +             return len;
>>>> +     }
>>>> +
>>>> +     *dma_burst_len = DMA_BURST_LEN_DEFAULT;
>>>> +
>>>> +     if (len == (SPI_BURST_LEN_MAX + 1))
>>>> +             return SPI_BURST_LEN_MAX - DMA_BURST_LEN_DEFAULT;
>>>> +
>>>> +     if (len >= SPI_BURST_LEN_MAX)
>>>> +             return SPI_BURST_LEN_MAX;
>>>> +
>>>> +     for (i = DMA_BURST_LEN_DEFAULT; i > 1; i--)
>>>> +             if ((len % i) == 0) {
>>>> +                     *dma_burst_len = i;
>>>> +                     return len;
>>>> +             }
>>>> +
>>>> +     i = len % DMA_BURST_LEN_DEFAULT;
>>>> +     len -= i;
>>>> +
>>>> +     if (i == 1)
>>>> +             len -= DMA_BURST_LEN_DEFAULT;
>>>> +
>>>> +     return len;
>>>> +}
>>>> +
>>>> +static void meson_spicc_setup_dma(struct meson_spicc_device *spicc, 
>>>> u8 trig)
>>>> +{
>>>> +     unsigned int len;
>>>> +     unsigned int dma_burst_len, dma_burst_count;
>>>> +     unsigned int count_en = 0;
>>>> +     unsigned int txfifo_thres = 0;
>>>> +     unsigned int read_req = 0;
>>>> +     unsigned int rxfifo_thres = 31;
>>>> +     unsigned int write_req = 0;
>>>> +     unsigned int ld_ctr1 = 0;
>>>> +
>>>> +     writel_relaxed(spicc->tx_dma, spicc->base + SPICC_DRADDR);
>>>> +     writel_relaxed(spicc->rx_dma, spicc->base + SPICC_DWADDR);
>>>> +
>>>> +     /* Set the max burst length to support a transmission with 
>>>> length of
>>>> +      * no more than 1024 bytes(128 words), which must use the CS 
>>>> management
>>>> +      * because of some strict timing requirements
>>>> +      */
>>>> +     writel_bits_relaxed(SPICC_BURSTLENGTH_MASK, 
>>>> SPICC_BURSTLENGTH_MASK,
>>>> +                         spicc->base + SPICC_CONREG);
>>>> +
>>>> +     len = meson_spicc_calc_dma_len(spicc, spicc->xfer_remain,
>>>> +                                    &dma_burst_len);
>>>> +     spicc->xfer_remain -= len;
>>>> +     dma_burst_count = DIV_ROUND_UP(len, dma_burst_len);
>>>> +     dma_burst_len--;
>>>> +
>>>> +     if (trig == DMA_TRIG_LINE_N)
>>>> +             count_en |= VSYNC_IRQ_SRC_SELECT;
>>>
>>> Is this the VPU VSYNC irq ? is this a tested and valid usecase ?
>>>
>>
>> Yes, it is VPU VSYNC irq, This part of the code is not completely. NO 
>> tested about it. I will delete it.
> 
> Thx
> 
>>
>>>> +
>>>> +     if (spicc->tx_dma) {
>>>> +             spicc->tx_dma += len;
>>>> +             count_en |= DMA_READ_COUNTER_EN;
>>>> +             if (trig == DMA_TRIG_VSYNC || trig == DMA_TRIG_LINE_N)
>>>> +                     count_en |= DMA_RADDR_LOAD_BY_VSYNC
>>>> +                                 | DMA_ADDR_LOAD_FROM_LD_ADDR;
>>>> +             txfifo_thres = spicc->data->fifo_size - dma_burst_len;
>>>> +             read_req = dma_burst_len;
>>>> +             ld_ctr1 |= FIELD_PREP(DMA_READ_COUNTER, dma_burst_count);
>>>> +     }
>>>> +
>>>> +     if (spicc->rx_dma) {
>>>> +             spicc->rx_dma += len;
>>>> +             count_en |= DMA_WRITE_COUNTER_EN;
>>>> +             if (trig == DMA_TRIG_VSYNC || trig == DMA_TRIG_LINE_N)
>>>> +                     count_en |= DMA_WADDR_LOAD_BY_VSYNC
>>>> +                                 | DMA_ADDR_LOAD_FROM_LD_ADDR;
>>>> +             rxfifo_thres = dma_burst_len;
>>>> +             write_req = dma_burst_len;
>>>> +             ld_ctr1 |= FIELD_PREP(DMA_WRITE_COUNTER, 
>>>> dma_burst_count);
>>>> +     }
>>>> +
>>>> +     writel_relaxed(count_en, spicc->base + SPICC_LD_CNTL0);
>>>> +     writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
>>>> +     writel_relaxed(((trig == DMA_TRIG_NORMAL) ? SPICC_DMA_ENABLE : 0)
>>>> +                 | SPICC_DMA_URGENT
>>>> +                 | FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK, 
>>>> txfifo_thres)
>>>> +                 | FIELD_PREP(SPICC_READ_BURST_MASK, read_req)
>>>> +                 | FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK, 
>>>> rxfifo_thres)
>>>> +                 | FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
>>>> +                 spicc->base + SPICC_DMAREG);
>>>> +}
>>>> +
>>>> +static void meson_spicc_dma_irq(struct meson_spicc_device *spicc)
>>>> +{
>>>> +     if (readl_relaxed(spicc->base + SPICC_DMAREG) & SPICC_DMA_ENABLE)
>>>> +             return;
>>>> +
>>>> +     if (spicc->xfer_remain) {
>>>> +             meson_spicc_setup_dma(spicc, DMA_TRIG_NORMAL);
>>>> +     } else {
>>>> +             writel_bits_relaxed(SPICC_SMC, 0, spicc->base + 
>>>> SPICC_CONREG);
>>>> +             writel_relaxed(0, spicc->base + SPICC_INTREG);
>>>> +             writel_relaxed(0, spicc->base + SPICC_DMAREG);
>>>> +             meson_spicc_dma_unmap(spicc, spicc->xfer);
>>>> +             complete(&spicc->done);
>>>> +     }
>>>> +}
>>>> +
>>>>   static inline bool meson_spicc_txfull(struct meson_spicc_device 
>>>> *spicc)
>>>>   {
>>>>       return !!FIELD_GET(SPICC_TF,
>>>> @@ -293,6 +483,11 @@ static irqreturn_t meson_spicc_irq(int irq, 
>>>> void *data)
>>>>
>>>>       writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + 
>>>> SPICC_STATREG);
>>>>
>>>> +     if (spicc->using_dma) {
>>>> +             meson_spicc_dma_irq(spicc);
>>>> +             return IRQ_HANDLED;
>>>> +     }
>>>
>>> Make meson_spicc_dma_irq() return irqreturn_t and return IRQ_HANDLED.
>>>
>>
>> Will do.
>>
>>>> +
>>>>       /* Empty RX FIFO */
>>>>       meson_spicc_rx(spicc);
>>>>
>>>> @@ -426,9 +621,6 @@ static int meson_spicc_transfer_one(struct 
>>>> spi_controller *host,
>>>>
>>>>       meson_spicc_reset_fifo(spicc);
>>>>
>>>> -     /* Setup burst */
>>>> -     meson_spicc_setup_burst(spicc);
>>>> -
>>>>       /* Setup wait for completion */
>>>>       reinit_completion(&spicc->done);
>>>>
>>>> @@ -442,11 +634,40 @@ static int meson_spicc_transfer_one(struct 
>>>> spi_controller *host,
>>>>       /* Increase it twice and add 200 ms tolerance */
>>>>       timeout += timeout + 200;
>>>>
>>>> -     /* Start burst */
>>>> -     writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + 
>>>> SPICC_CONREG);
>>>> +     if (xfer->bits_per_word == 64) {
>>>> +             int ret;
>>>>
>>>> -     /* Enable interrupts */
>>>> -     writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
>>>> +             /* must tx */
>>>> +             if (!xfer->tx_buf)
>>>> +                     return -EINVAL;
>>>> +
>>>> +             /* dma_burst_len 1 can't trigger a dma burst */
>>>> +             if (xfer->len < 16)
>>>> +                     return -EINVAL;
>>>
>>> Those 2 checks should be done to enable the DMA mode, you should 
>>> fallback to FIFO mode
>>> instead of returning EINVAL, except if 64 bits_per_word is only valid 
>>> in DMA mode ?
>>>
>>
>> I only support DMA when bits_per_word equals 64, because the register 
>> operation is more complicated if use PIO module. The register is 32 
>> bits wide, a word needs to be written twice to the register.
> 
> OK then leave it as-is
> 
>>
>>>> +
>>>> +             ret = meson_spicc_dma_map(spicc, xfer);
>>>> +             if (ret) {
>>>> +                     meson_spicc_dma_unmap(spicc, xfer);
>>>> +                     dev_err(host->dev.parent, "dma map failed\n");
>>>> +                     return ret;
>>>> +             }
>>>> +
>>>> +             spicc->using_dma = true;
>>>> +             spicc->xfer_remain = DIV_ROUND_UP(xfer->len, 
>>>> spicc->bytes_per_word);
>>>> +             meson_spicc_setup_dma(spicc, DMA_TRIG_NORMAL);
>>>> +             writel_relaxed(SPICC_TE_EN, spicc->base + SPICC_INTREG);
>>>> +             writel_bits_relaxed(SPICC_SMC, SPICC_SMC, spicc->base 
>>>> + SPICC_CONREG);
>>>> +     } else {
>>>> +             spicc->using_dma = false;
>>>> +             /* Setup burst */
>>>> +             meson_spicc_setup_burst(spicc);
>>>> +
>>>> +             /* Start burst */
>>>> +             writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base 
>>>> + SPICC_CONREG);
>>>> +
>>>> +             /* Enable interrupts */
>>>> +             writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
>>>> +     }
>>>>
>>>>       if (!wait_for_completion_timeout(&spicc->done, 
>>>> msecs_to_jiffies(timeout)))
>>>>               return -ETIMEDOUT;
>>>> @@ -853,10 +1074,10 @@ static int meson_spicc_probe(struct 
>>>> platform_device *pdev)
>>>>       host->num_chipselect = 4;
>>>>       host->dev.of_node = pdev->dev.of_node;
>>>>       host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LOOP;
>>>> -     host->bits_per_word_mask = SPI_BPW_MASK(32) |
>>>> -                                SPI_BPW_MASK(24) |
>>>> -                                SPI_BPW_MASK(16) |
>>>> -                                SPI_BPW_MASK(8);
>>>> +     /* DMA works at 64 bits, but it is invalidated by the spi core,
>>>> +      * clr the mask to avoid the spi core validation check
>>>> +      */
>>>> +     host->bits_per_word_mask = 0;
>>>
>>> Fine, instead please add a check in meson_spicc_setup() to make sure
>>> we operate only in 8, 16, 24, 32 & 64 bits_per_word.
>>>
>>> So not need to clear it, the host buffer was allocated with 
>>> spi_alloc_host() which
>>> allocates with kzalloc(), already zeroing the allocated memory.
>>>
>>
>> Will drop this line, and check bits_per_word in meson_spicc_setup.
> 
> Thanks,
> Neil
> 
>>
>>> Neil
>>>
>>>>       host->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX);
>>>>       host->min_speed_hz = spicc->data->min_speed_hz;
>>>>       host->max_speed_hz = spicc->data->max_speed_hz;
>>>>
>>>> ---
>>>> base-commit: 49807ed87851916ef655f72e9562f96355183090
>>>> change-id: 20250408-spi-dma-c499f560d295
>>>>
>>>> Best regards,
>>>
>>> With those fixed, the path is clear & clean, thanks !
>>>
>>> Neil
> 

