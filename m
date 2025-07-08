Return-Path: <linux-spi+bounces-9071-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC2AFC878
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jul 2025 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F694A46D9
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jul 2025 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF612D8375;
	Tue,  8 Jul 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="oDNIyZwa"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022135.outbound.protection.outlook.com [40.107.75.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD1220F34;
	Tue,  8 Jul 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970862; cv=fail; b=ppg2vJpEui1fzwgf/DO3hAH3P/x+clH/ahTfAN7ufjHyCgPhTx1XBOHMNk8JSlDJ4rtpjDX5IAmnp6FWtRV/7d+f816xbKaHG9nMTZ/H3tjLei/tjn0EmYZEhwLiHHw7JXi/jyI4V5ihBSiM71IhW+207iSM+5XkaEUZeo9dw3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970862; c=relaxed/simple;
	bh=tzOIfzMarao9gI+dxAGeB2xsEndBZf2GacJ8bMS7Mzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVICJCbekituEN6IVCW4LK3ALL1ej2BFP3/dGYA4RoJoFOvpq5LpuNQ86s4DS2b11JAI4DnLK/xptKT1siO7oAk61GHv9o1cEXgmc8vlLX+9RpScA86RPIoRo/CnsNVDrRDtbEmdq9nZN3xcll0wBnXqKk5y7MyDJpi/xhClyyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=oDNIyZwa; arc=fail smtp.client-ip=40.107.75.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUrhO4UljbgWUXxmn35IiHQb4jKDoSnVZ0wYE1UMvyc+XNrEW5ugU62oLLYdOlrupfOJy14FJ+4bP9JEAAR2x5LMqoQDi3G6vsAqC9TzYz+QZe5Opgu2btBPB7nKMtRoHgKNJiEQiWiMF0d3U8TEGY5C7+jJDmYsPpaJofGpNN7BumJ8G8Slnfn0KvMR8kAozW72d3dv0iTDJlDAoNouwVh/7k/7FBrJgDtU+JOa11JCltdeWrWkeXPz+pZIQyQ8MavhDB5FH1oxnG6X9JvLr955Hlg7do2NdTKbqW8YGJSKSjeqeevIwc5HYx2UAfWH4qUMj1Cz+kKTSYBd1UqF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SM1A8BX+aFhBJQIhmnYVKZDrJrW+KtEWhHmyPUFFAQ=;
 b=GsXJEDmatv3FIynu+clMU9XxbtbXoQ/Gaku2t4xICgzZhBmh76EgvZl8+W17HXhrwWiAOkp8NICDpBWeIKMDJ6XuNo2S7ilEaj4JiVY5nxVbcbjTl++BIZM1i2CZaSTOgEJUOWO9HsEOIewCOtq5sRqGT9H08SDN83B2CDAy3sPakufNFtEVKXHlGX+nYtWwknAohWIXWONPeSKulkXfv9+OiFavdBgLThOL/3RFo1jA1lD/vTm9PykFwpO0c5UP0ijZ3AmD0cNnYDBAAitw2XXwLEqYo51fLHlqtrhMkczrxFqwbAX3Ha282MfLnADMz76G/2+TV7jgv5ORsl+TVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SM1A8BX+aFhBJQIhmnYVKZDrJrW+KtEWhHmyPUFFAQ=;
 b=oDNIyZwa7wTsPrej1qLTHjXBdeFlRd353Pw2/2SpxhWixiOHwiulXJPok/4ngOdl+Ypz4x+698YN/TCqRQ1MVo4NCxviZjY6sc2IFXYOTtgrREpK4dv6Zo66gZKJFuyW8Oz9SutVx0m7OMsTGCX+Ly3LL9SPeefzUksIThybHMhYCwIuyz9A0CENz+s0k0FaMqO8DlA5imr31+XcmJpYJMueOq3yeGYdBkFoKvFT2cxQIzDh9K0FKZ9ZS4MsfrSq8GRPGdHB0o0OsXXrDkyaTdK2i3GC11veOOGmYI+wn7vtyBZbeV5HQALYIL8Oy/bZCmFoXxZPdc6t8ryoJR8yJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KUXPR03MB9397.apcprd03.prod.outlook.com (2603:1096:d10:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 10:34:07 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 10:34:06 +0000
Message-ID: <55ecc836-7fed-44d5-aa4b-94bc17894ef0@amlogic.com>
Date: Tue, 8 Jul 2025 18:34:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
 <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
 <3ac88119-9980-42df-9e1c-c0ec30bbaadd@sirena.org.uk>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <3ac88119-9980-42df-9e1c-c0ec30bbaadd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KUXPR03MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e803833-4a0b-40ce-c908-08ddbe0af763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0FYS0xrcTg4em1XRCt5a1Rsanh0c3hQWDQ0cUNPOGh1STNYcWJNMXJhWnRJ?=
 =?utf-8?B?TEFMaFFhT0lreWVyM1VtdEd1SHRRb3Jab0FkN2lHSVJhWWtDMmVWc2RUQ3Bn?=
 =?utf-8?B?MG1UN3RpMGduNE1zd3grOWRIbGY2SEdlaWN4dnNVYTVUMFRBeTNLY2p2d1V5?=
 =?utf-8?B?UHQvaUk1Z1pvMHZTNlNKdXpUQmZGQS9tK0ZLN28vNkUwVXFxc2FVZk45MnI4?=
 =?utf-8?B?R0VTWi9HU21ubUdRT0JGbTVhL3NHSTRWazZad21rWUorQWxTclNncFZybFph?=
 =?utf-8?B?MWkzYVRSeGlIVGdsYTFmSWJjNi9raVlEUmRSaEluU3R3bGpDRmN6TCt2T2x2?=
 =?utf-8?B?b2VWZE5KVU9teUlvZDkrZmVrZHR4ODlXQ3Fnd3J3UXBLUmZHdFV5ajN6cW5R?=
 =?utf-8?B?dGx4NzB3QXdzcEdodE5Na3BOSUM3dUNjcVNRSUhSZm9PZVpkbUFQNEVMbzVn?=
 =?utf-8?B?U0IrMUF3QytMV2pXNXlXdnB4N3R0dnRzNDhWWm5UYndpNlk2YVdXNFVTZ0JR?=
 =?utf-8?B?L3BubjZPWk1Lcnp6b2dIZlZVZDcyd1ZOenYxMTNDOXJIVTNxRlhJR0o3eGda?=
 =?utf-8?B?bjY0Mitjc3c1Vm1rQjU2T3dRakVscFZhMFhsbGRTSmRPempadW1lVXg3VnZY?=
 =?utf-8?B?ZHk0OE1hczNhMzdmS2ROa2RPeDVBcXFYQlRUNm4zQzJsdVVYREc5RFBCVEkz?=
 =?utf-8?B?ZVVONTZXV3hselZma2tlZ0FFTlM2N216Lzh0ejRIY3dQOXIwVzR3amNCR1BU?=
 =?utf-8?B?a25ZSFdpVTRTV0tHSTJ3cWIrZW5yQVRwc1RhUVpNc2c5ODJCek5nb25ucEFv?=
 =?utf-8?B?YjV2UnZNYndJY28wZUt4QXhNTFdVaEdJRmNLcTlxbWcwbjlLb2lXVWF4TnRS?=
 =?utf-8?B?eSsrZ3NTZDZFcmVnT0VNcUF6K0l2UnAzVHNlZnZoNHV1YVlPLzFGNXh5TXRJ?=
 =?utf-8?B?YTNXMU9oVWhuUHg2RENFYjloUWIzNzIzd1Z4cmwwSjQyWTlreitBaVhNU3Bk?=
 =?utf-8?B?Z3JwbmlmaXNZeVJwSVNxbERSc1UwWDJnbU5IOHZySUc2UW1JYUZ0SEdweklp?=
 =?utf-8?B?b1lqSnJGWUFEOGxoL3g3clBkdlRSVW1ENnZmQ2s3blV2Z2t5cTlpM2Q5c0sx?=
 =?utf-8?B?b3E1d2hEYzdMT0RhUnBoRkxwNjBmQjVKZ003SEE4QzZrS014WmZuZjRWT0ZI?=
 =?utf-8?B?Y1hTOUdCaGVuNVlmVFFSQnJ3QVQxaWVnRXdkNzBkU2lOU0JGR1h5SHhaZ3FR?=
 =?utf-8?B?Vi9NSlVKWEt2dlV2YnczbklvV1A2bkxpZi9WQ3RHYWJOYU9iSXRzVFBxT1lp?=
 =?utf-8?B?Qmd3WUtZMjVWL2FEZHFNM282disxU2hWMW8vaGN2enlSSlNncWFGNE9nK051?=
 =?utf-8?B?ZGtTYUIzajZTRXlTRFNHZ2VhS3BrSHFUSTN3aGVMRGJlbXU1azd3Rkhha1VL?=
 =?utf-8?B?eXVDQ3IvbjhLZXc0cmRzdEdIZFdIWGtvdzVVY1ZHV2lGMUtlaWNKelhyWWEv?=
 =?utf-8?B?OE9TSUxxcHBIMms1eERuL0UwdFE5ZERhVmU2MmVjOWxVOFkvbGhOZTdtS0hM?=
 =?utf-8?B?OUxFQWF4VS9pem52eC9CWDdZd0dMU1ZkaFUzV3l0MmYrSWVkVVlBYkk0ZldB?=
 =?utf-8?B?VkJlNVE0QWxrM3hSTkR1V2tMQk91cWxUay9uRDZ5N3hlQUo0eEhuK2JkUWJS?=
 =?utf-8?B?RDlSWVhXR2dGcExpbVNnbC90Uk13NWt0VzVseEdXbVRIa2tYZWhZelFjMmI5?=
 =?utf-8?B?Zm96N21tdVF6cmhFTng4RDU3YU5lOXcvU01xU2tpT21UQ242eGdOQUJhMTVM?=
 =?utf-8?B?ODZLQjdLV0VlcnJPekFTYUEzdnc5NmdIa0M3QitvdUJQUGVEOVMyeURwNElk?=
 =?utf-8?B?aGVhQUlicUF0bmdOSDhvbWg1eTNpQTJBTjNkU0tLVVNwQW5VSEVqd2FadUd4?=
 =?utf-8?Q?HR931RE8IAA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWdPeFVQRERaVkpvWmowVFJQVEFtZ0RHYUlRR0pHMi83dTVlaHNIbVNteEla?=
 =?utf-8?B?UlliK2NkWVFuN3dncWRnYUxMTWQ2UDZCY3FwY0xIYzlFQllpRm84Vm0xRldX?=
 =?utf-8?B?bVZhcFM0M2VxSGVaR28zREtleEJJNkRRTWswWjJsVCtPWWNBTUhmWGQ2U1Q2?=
 =?utf-8?B?SVVuV0hGL3V2YXNJTW9XNWsvVWFWMnNZQm5OdEhnVUJSMEoxNFRQTXR6RkxG?=
 =?utf-8?B?cWVCbUExUXZHM3dKRHc1a1RXejhxRU9hUlhNYkhTaGpKZzZxd0plR0taTTRj?=
 =?utf-8?B?R0ZwUUlIYVdVVm1KMlpBTS9qQ0xRUzFVQkpSNndlZ3VqYjJxUjNxMmtyYjNM?=
 =?utf-8?B?RG5xbEwyN3ltVVA2eHRLSDcwb2NtYkR4RWFCUy9HVTkraFpMbFpOTDhhTXZp?=
 =?utf-8?B?SzlHUUt2Q295SXI5YkhYWm53aWVtYUlCTjhYcnZJZWZYdUVnZ3B2RDI5RWw4?=
 =?utf-8?B?QmpyV05qN0tiV3Z2WDdrOWF4MGZjTW5IRC9KWUt4UU9ZdTNTMnk3SmJWS1ox?=
 =?utf-8?B?eFlRMEQxZVRsN2I4K2kvRE1iOHMwQTVpNTE2S1RNemdKTEVzSG9uYklWajRU?=
 =?utf-8?B?UFNrYm9sSzMxVGlub21PWXVLcDFnU0NERFNIZktYVmhIWlN3bEFET0FBWlZi?=
 =?utf-8?B?K1c0K3EwUjhOTXlTeUpyRk1XRmRPUFI3ajFCZXR4cGEzb3VHUzJyMjZnUk80?=
 =?utf-8?B?c04ySVdoQi9sdWljK3VaekFCRUFSV3hyNm1ndi9od3FVSFVlcmpjNFZ5M0Fm?=
 =?utf-8?B?Q3JScFBGbnNiL1lKK0pIUFlXMkhjQ3pLWkpVQjUvaDc3bitkWVh2dlB4dFg5?=
 =?utf-8?B?bmhsUUZ3eExuLzRybmQzRHg0MFhGTEIwempZeDVFT0daUjlLVlJWR0xITGlC?=
 =?utf-8?B?V3lvK1A4N05vMEkvdUJMM2xUL05mK1E2WFlQTkZzc2VibkcyU2NmRHlBZEVp?=
 =?utf-8?B?RWhRSTljS1VwV1BIdVVieXEyelhab1JXR2NMVG9kMlZLT3FvOWhNRW9DYS9t?=
 =?utf-8?B?WUVMYU1hNjRnTEdMQjJ2cDdoTWgxNDJQbjdGM2YzVVhlMzFUd3VRMTYyNm9p?=
 =?utf-8?B?WkZ0YTZFdHlkY05yRng4OCtRV2VZR0MzWEFnNENtQ3hOKzZNTDFQWWNqMEcw?=
 =?utf-8?B?VUxZYkRGZGl0UEgzekFTalBsOTZUSFR0d1JkYUZYN05iakFYNW1KejhzMjhi?=
 =?utf-8?B?cG1GSU05Q2ZSUGpMTGNaNmZnWm9KUWh4YTlySkloTE5nNmkvazdTQXdWcDlj?=
 =?utf-8?B?TGFva3Aza3RMZU5ETGpkRnlGeExoRzJrZmpCSzdVSlQ0cE5VbGRpVko0Q2pj?=
 =?utf-8?B?Y29GQVJEdHFTTmxJM3M4bXJuR1d1VjNCYnNCZHJTMDBOMmdKSEwrakpJK0d3?=
 =?utf-8?B?L2JjRm9vMlBTYVR4KzFXSnYrdkdiQ05FQUdNNFFlNFFINklSTlVmZ0hmZlNP?=
 =?utf-8?B?dmQ3VWhTblNBN1NQbTlWNUFlMnhGSHdwZzBhT0oxOENNTUFjUTdGRHI1ZDY1?=
 =?utf-8?B?YzI2VmNaOWs5YktDbDhSdVU5LzZmRHhVYysxS1ZPaHBmNkxwaWhEeXg0NlZV?=
 =?utf-8?B?KzN5RXBDQ2F4aTd2YitVYTJlcnUySUVhcVM0UDYvcStWbXBUNmpLS0dlV1py?=
 =?utf-8?B?bWhWS0hOZi82QTAxM0dZV1lHaVdNMUp0cjZPN3NoSlQwM21HSEQ2akJhTjZv?=
 =?utf-8?B?UnEwNGVGVmNmR1VPaG9TU3FQc3hPTVlCT1MyQUdPam9uQi9RQk9zNTNqWWJM?=
 =?utf-8?B?UDNMUzFjc1hUR21EM1h3OVQ4ekFrNCtIemRUbFdGTit3VERRUnJkb0F3c3Q0?=
 =?utf-8?B?d0xqUm9zMkJyWTQ5c2gvSVQvN3VWek93dml1dEZnUXVIQ0h4UW5ESUx3aVRv?=
 =?utf-8?B?MWRIaFVSS0ljZG0rVHJpMWQwR0NsSFcxc1F6QW1uQnptRE9rNTEzNkVqcXBU?=
 =?utf-8?B?dHdxS0g5bVZ2OCtMekdFNngyYUpCYksxeENWeXpKVUZlYy8weXZSeEc2b25m?=
 =?utf-8?B?NEtyME54dXRZQkxNRk84Z2tNQVZzbnpPYmJqS1YyK1hLMVphZ0VlVU1KUTl5?=
 =?utf-8?B?WitLb28ranBMdW9yY29aQlRIVzl2bEo0N0dxTmYra0F4V09TUk9rTjI1V2M5?=
 =?utf-8?B?bGpDOGdyaTk1QjU5YUtKbDhrUDVYcVgrVHRocnlRMEpqNUcwalY2WXdyY2Zj?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e803833-4a0b-40ce-c908-08ddbe0af763
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 10:34:06.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtXDod7hq/b4r25QLL4+EMnxOOGGRIAu8trkKM6AjDyVFlbxbjnspmbjYEfaPVIlr5JvIFuUja8GdMm5OpnVbocDhotCfYp2sUf085sM5Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9397

Hi Mark,
    Thanks for your advice.

On 2025/7/7 21:05, Mark Brown wrote:
> Subject:
> Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
> From:
> Mark Brown <broonie@kernel.org>
> Date:
> 2025/7/7 21:05
> 
> To:
> xianwei.zhao@amlogic.com
> CC:
> Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>, 
> Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley 
> <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
> linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
> linux-kernel@vger.kernel.org
> 
> 
> 
> On Fri, Jul 04, 2025 at 10:59:33AM +0800, Xianwei Zhao via B4 Relay wrote:
> 
>> Introduced support for the new SPI IP (SPISG) driver. The SPISG is
>> a communication-oriented SPI controller from Amlogic,supporting
>> three operation modes: PIO, block DMA, and scatter-gather DMA.
> This looks good, a few small things below but nothing major.
> 
>> +static bool aml_spisg_can_dma(struct spi_controller *ctlr,
>> +			      struct spi_device *spi,
>> +			      struct spi_transfer *xfer)
>> +{
>> +	return true;
>> +}
> Is it worth having a copybreak such that smaller transfers are done
> using PIO?  With a lot of controllers that increases performance due to
> the extra overhead of setting up DMA, talking to the DMA and interrupt
> controllers can be as expensive as directly accessing the FIFOs.
> 

If the data volume of a single transfer (xfer) is small, PIO mode does 
offer some advantages. However, since PIO requires the CPU to wait in a 
busy loop for the transfer to complete, it continuously occupies CPU 
resources. As a result, its advantages are not particularly significant.

If PIO is to be implemented, it can only handle one transfer at a time 
(via transfer_one), and not entire messages (which consist of multiple 
transfers). In contrast, when processing messages, the SPI controller 
can handle the entire sequence in one go, which also provides certain 
benefits.

Taking all factors into account, it may be better not to add PIO support.

>> +static irqreturn_t aml_spisg_irq(int irq, void *data)
>> +{
>> +	struct spisg_device *spisg = (void *)data;
>> +	u32 sts;
>> +
>> +	spisg->status = 0;
>> +	regmap_read(spisg->map, SPISG_REG_IRQ_STS, &sts);
>> +	regmap_write(spisg->map, SPISG_REG_IRQ_STS, sts);
>> +	if (sts & (IRQ_RCH_DESC_INVALID |
>> +		   IRQ_RCH_DESC_RESP |
>> +		   IRQ_RCH_DATA_RESP |
>> +		   IRQ_WCH_DESC_INVALID |
>> +		   IRQ_WCH_DESC_RESP |
>> +		   IRQ_WCH_DATA_RESP |
>> +		   IRQ_DESC_ERR))
>> +		spisg->status = sts;
>> +
>> +	complete(&spisg->completion);
>> +
>> +	return IRQ_HANDLED;
> It'd be better to check if there's an interrupt actually flagged and
> return IRQ_NONE if not, as well as supporting sharing that means that
> the interrupt core can handle any errors that cause the interrupt to
> latch on.
>

Will do,unreasonable values will be returned IRQ_NONE.

>> +	ret = devm_request_irq(&pdev->dev, irq, aml_spisg_irq, 0, NULL, spisg);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "irq request failed\n");
>> +		goto out_controller;
>> +	}
>> +
>> +	ret = aml_spisg_clk_init(spisg, base);
>> +	if (ret)
>> +		goto out_controller;
> Do we need the clocks for register access - if so what happens if the
> interrupt fires as soon as it is registered?  I'd have expected
> requesting the interrupt to be one of the last things done.

Will move irq request of the processing to a bit further back.

