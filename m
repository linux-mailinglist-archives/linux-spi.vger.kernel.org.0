Return-Path: <linux-spi+bounces-7549-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9306A85262
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 06:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED253B98EA
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 04:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BC8279342;
	Fri, 11 Apr 2025 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BsaXbMT3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kVH1YAoR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873CEC2;
	Fri, 11 Apr 2025 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744344429; cv=fail; b=E49OJIduN5qLazyLiXrtCGciKZM5h1QQEDcopyrkjDKUVwwNDhWk8ieGcO0Cq69K+YR6XAB1CN7QAFkOhFVkZkxclTc/4KBctFm5UI5Nu05Nd+7dtP/S/25bJxMQwWb16IQxVbo/0aFeMBEdYV9f/80mDtDCMNIzjjPPYAnSsSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744344429; c=relaxed/simple;
	bh=reJzgj9ziZlVEw+dn8i94ny64GzP8NYQxsk2bS+aMDY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rj8ZAckUhmoPuL3XYO+g5n1BHcoN09aBcLXmthL+KvAfCu/nzU/zdaKL4WIzhQWEi4bljL+ugkpz3EmJqa/PRdl9wnqc7cMh1RnWvzppBpAQx2UXUxKPoryjKxNmF86fy5GVuFTdXy7jNG8ufW8FPTryF4iEWZRhpj29vETAE24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BsaXbMT3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kVH1YAoR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B3udGW007987;
	Fri, 11 Apr 2025 04:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kOk1t56Rhe4BhLVju3TmkwqtoHN/d+b5FqLl6V9Ql+E=; b=
	BsaXbMT3i+7YZxfLyWHRuOZLCmcqKD9a2QCwjTz0RjRD39IrCjBGVfm/8R1TrydD
	RlvoZhyz0pzcbJDxd77C32ckEd6LiIGcMcIhXVKNaC0DssGgG2U2jj/4saIEoKiI
	GWgw1CoaXzdcjc3B+enTiFzZfJGGN0YFdYFgK/jHBqfNU9Lk4Kx82WIO1LcUJoF7
	EKL9LgFTHR3ug7N1g3acmTz6nTcu6J6YhVA7q/3xsxBaZIEKHoA2jL1ypf5bjsZa
	1X1tsEtD4G77Ev0Peq/U3HGUymePlGuBdMND2vKlsiCKMdHqZkr1pHUs7/gGx0Ao
	sF82jpnaSWOB1+yVyAyr2Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xum180b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 04:06:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53B1Lghu001384;
	Fri, 11 Apr 2025 04:06:46 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyd4rdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 04:06:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6NjKrhe4vHg+/xvFsMtLLWuueWRonnS4AfJ8iclK0jvQ40tFoLOj3ncLooMwjCgV85Ee7MGd1o9uZkVOKgLu57OsGF3GHreYWqon36NSo/19irHeRgcswWFbqpvnNuKEanJYnInmKtNA1e6NIQ7u0XZloTTYdri1p+0VU1FSfDRg7dVJvKGVB62cWyUrQj3zhWOgVJjPLllolmAEErXlFNvgUrwrnC7AQ9NCNHLMJcWH48UyUzwK6RS94z41Zy6+wzr7PPPV8Od95A2UAXr7XlZOKjtSUIttjTUmAdI2GfqMD9lx7hn454rMpYDm1vF/GUtj3QpY9AtnU1UG6kr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOk1t56Rhe4BhLVju3TmkwqtoHN/d+b5FqLl6V9Ql+E=;
 b=yAKcLk2PtrWm4/0QsSaiaTfSqtaOWw1UmzJXrbkmp1VXDBmWo+V+SKVW0kz2SLFvyAXbqS8sa+jaLdPWuAw7ePrcFxnHg8+w0L2lYTxR2eIL0QTjdzbE2DfFiPEPF6Zh94x5ku6XJDO5PyqdiPGDUhGG8x+IH1tF6O2fx8OzYWEVAdttFB2Dm1DLn/3Pb6fFG3NogroJpNBWak01c4H6+mdsX4Y8APJyTgFGX2qSMsL5F8paGaoMzi0ZZXegq9CYXdw7HFqqSTZvFiNMqq5Nan0+glYtGmKMKNpU5K9uaLlnvt2mUKBXPJI3TAxe7wJoVShPddXjRg1Uv7s6is7pRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOk1t56Rhe4BhLVju3TmkwqtoHN/d+b5FqLl6V9Ql+E=;
 b=kVH1YAoRcJDyWmeAZzR1iNvscglFt4wxYAI5kJhRatBiGyiRq8RRHWjjlRIf+29vJRIyqkPRdePuhtIYkjV9P74pAUPDm02iyFzjPPq83yW8vobuU/k+xDmh8pqE5uK0v17aOexR1X9HEyoLiMfekVUsyTnD/3+hK4ZXTGHN9Mg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by LV8PR10MB7800.namprd10.prod.outlook.com (2603:10b6:408:1f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Fri, 11 Apr
 2025 04:06:43 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 04:06:43 +0000
Message-ID: <6c859c19-6df3-4663-a655-fa338d08dcea@oracle.com>
Date: Fri, 11 Apr 2025 09:36:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] ASoC: renesas: add MSIOF sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
 <878qo7h5l2.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <878qo7h5l2.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|LV8PR10MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5269a8de-f065-4eaa-a9ed-08dd78ae4494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU5ZMGpSVDVQMmFjRmd3SzdDRGJkaVYvTHExT0FsZWl6OG1LMlNUT05uUU5Z?=
 =?utf-8?B?NEtUcVl6YXpiZUJQZjUwdkd6L1pLTGpiajBiUC93YjZ6NzVqZHJCLzBRVEtu?=
 =?utf-8?B?S1NXVjY0N2RpaEhnR0pubHRCMkRmRW41S0U1eFhtSUJiTWpSZ1g1eEdOUGdy?=
 =?utf-8?B?cGNOMFF0bHJaYXc4ejhZNGVLYWE2NXZVeUdqczdRZStDaHEvZ2pKR0RqZnNK?=
 =?utf-8?B?NDlFa0JyWjRvbW1lMFJDeFhySFFjTUZ4c2RNSThSSkVNaTg5a1hOSWF6SVpz?=
 =?utf-8?B?dk5HMklBN3k3STRETldCejhDaGhLTUpXcEJSWGM3TitpSmdxU1JyQlRQMnNa?=
 =?utf-8?B?V0s3Wm4xS1VGa1dMN0Y5YlhxSy9UQlQyeVBNVFUwQ1RQVU54RUl1ajZ1eDJB?=
 =?utf-8?B?U0RtUkFBUVA1YnZmTGpZaGxid0hMODJDc1JQODFoQS9EY0lQbTFrTWtZb1di?=
 =?utf-8?B?Z1NTN3BieEhIcVVmazEvVGU2Y0o1REFRdUxkalFKbWhsdU84Ulg1U0N4U0po?=
 =?utf-8?B?dWsrTTdvS09zdU0raEsyWnJvQjNBR203cklPbWpPelJQeFQrbEN2b3pXQVgy?=
 =?utf-8?B?MUFwZ3c5NmVmcXhTamVnbG0vTWN6SVBPSEdEWG9hRTNIaE51Mk94ZnBhZlVB?=
 =?utf-8?B?OU93TVNhb04zY2FvYmJqU0Y1QUdkaFRjZkdUTHlYTGZvd3l0djVjQytxN05U?=
 =?utf-8?B?WXpOd2pKUXQxVHhpMzlXRDhLbGQwd1VRWXQyb0xLN1ExR0wwaVVkcWhQVWo3?=
 =?utf-8?B?WTFiQVVHTFl2cUpCUU9QeTdsMnRyTGE3MWhxekMxeGRaZ2U3VGU4eS9NbU9U?=
 =?utf-8?B?YUlDRVFhUVJycVBDZVp2Yk5Ib2ZTaWlFUEpqWldNOExvYkdzSXBCcmpXejN4?=
 =?utf-8?B?VVRsQWpYOWE2VDFYWHNHa1I4L2JobCtrTEpTTmR6WjNYWEExeURjMkRpL1dr?=
 =?utf-8?B?YWQvekpNdFZJakVOaW9tRm1UeTBSQVFCSGEzQVlIWFN0MFR0MzY5MDFrWXQy?=
 =?utf-8?B?M3FUMUJzWjRPQmlQMFZ6ZC9BL2tuMmRITVZsbGVtN1l4ZExiV3llYmQwYXFy?=
 =?utf-8?B?bUF5eFI0UXIyQUU4REpPc2NsZitkQjFveGNHY1ZpeWxUemV2Qjl0NGRNNXJt?=
 =?utf-8?B?SFBtSjRQem9OS0l6VkQ2R2phdTNldXhqUENlZWlib3RFZDM0b0Erc05kMExO?=
 =?utf-8?B?czVyZjF2ejZ1aTVVNmNHbm5ZcEVlWklpT0tEbEVHU3NOZ1BMeTFWNEgvNXEw?=
 =?utf-8?B?WWc5c0l1amR4d1VYR2U5THUzRDJubjdFYU5uWTA3bjZMMHhHeUNqeHdxVFNU?=
 =?utf-8?B?UStHZDZrQWY4VzhxeGdqV2llQzE1Zk9aYkhuanZUU0VuVEFWaEtaYXZkNlhv?=
 =?utf-8?B?aGIwYW1QTVpndzdVZGc0RGU5aXNVaE1FOVA5SFl5MDNCUlo4OXZEaTJUOXZv?=
 =?utf-8?B?Umt2cjh6eEY2WWFGSVlTSGdHUTAwOWRRa0FsM2VDaVlldnAySTUxRUN4eFBW?=
 =?utf-8?B?WGpIQ3VvclpWeEowM2NDS3NmYm5uNXFxcDdIanJBLzZCbkdXZVBONW1IOWxw?=
 =?utf-8?B?WFNOK2dnZkZXODdWMkI2RGhSMmdNeitCM3QwbENNa0NPbWg0aXdnR2lBc01a?=
 =?utf-8?B?VkJ1amtqUmtMRTBpMGRJUjVnNG1aS3U5dTEzZWcrUHRLSFY1TEcxMFk2bzFn?=
 =?utf-8?B?RzJUbnJuVkNLVEozMlpINjlxaGRwcG0vMWE1blh3cmZhSWJ3MjdtT2tiMmxt?=
 =?utf-8?B?aE96RGhkQmc4Rmk4dVVZM29DcVg2YzFnVURKMzB3NzNhNmxtQSswYzNGRVBP?=
 =?utf-8?B?Zm1sT3lTandDbHlDZUVQUDNaYTV5OElTTnEwcXlIR1hQcjFZMnR4NnJ6Vlh4?=
 =?utf-8?B?aHZQZ0k0YTQvZkduWHVPaDR0dkNEU1hpYkZZcGN3Vi81ZU83Zml3NjNwNUlH?=
 =?utf-8?B?ekxSLzlvbnVlMkVWNFNIUktyRVBXZXl6ZkNEZ0ZJNmk4UUgxd0FCS0VKR0c0?=
 =?utf-8?B?bWRnMVFOdUhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWo5VFdOUDJKNGxQVEhnSXcvaEpvMU92WUIrVUk5YWJkWmcrbThVZGt5bjNz?=
 =?utf-8?B?N0RvWWVTZUI0M3NkS1pHTFgrMG83N0pkS3pMQlFTL2lsNzBZcHMwSDEzZDZO?=
 =?utf-8?B?U3U5N1dQU1cxcVNVbGFZRGJ4eTJ3ZjB5R3RhSEY1NXB1T3dKZHBWR1p6d25D?=
 =?utf-8?B?clBYUkNCRmtDU3dQbkN5dVowcUx4bjJ4aUR4R0NnaElTZ2xLQlB3SW5YRlVi?=
 =?utf-8?B?bkd2TXBwc2tOekhsdE5MTUZYTjBJRUJ1M3NKajF3eXhybCtWKzJubDJQMFdq?=
 =?utf-8?B?YXYraU9sTjhOTE5yTTM1MEZLcVNaamp4cnUvVHE0YUtoM3VQTnlsTmJSN2d4?=
 =?utf-8?B?Q0hCRHFUVnRKem1xZjgxQ01GK3h0REk2Rnd6SDBHUWhQbVRFMDlTZys3bzkv?=
 =?utf-8?B?cUZ3UUV2WGQ2cXBhNnE5UDRGNStPOW9nVEIyMFBrTVJNOTRsS05hUndzdG5q?=
 =?utf-8?B?T1k5a3A3RFh3Vnh5ZHRwcEMxbXpHY1hpK1RGejBwcEpMVFVxTEcxRkVHMFlk?=
 =?utf-8?B?bmlVdWRFdll2NkhhcTNvUWtCV01jRGNSM3kvUFJ1R3RtM2QvYW4zTi9sMTYy?=
 =?utf-8?B?VEdJWG9lTjIrYjY0dzRIOFkxRndSMWN2cXl0WHpGTjZmMTVndXRJc0hldVhV?=
 =?utf-8?B?dFJIR0k2WFplTk1NOVpwYlprZ2ZOMmMrVXBjMjlJOW14Z2RXRVpmQVBRZ3ZM?=
 =?utf-8?B?N0RKNHRWSWZUR3NJbHZPKzZXenE5Um5vakNXSzBrWmhWV2M0RDBYTEhvN1RH?=
 =?utf-8?B?TjRORk9QVjhibTd1TWFuNmIyVjk2dUM2bnNJcFJKNE5MZFlYWmFSSnZrT3dI?=
 =?utf-8?B?aGUyQlg2elFsQWxvWDBuQzB2RnZwZytZSHRrZy9EQWptTURKRFgxQ2pJUi8z?=
 =?utf-8?B?Zys5Vk1rUThkYTZVL1JMQ2I1L1p3d2puWHcvemc3Nk9MeVVYUHpPWDZ6MFJj?=
 =?utf-8?B?bEVVWmgrVzJVbVRKWmNhQzBtbzRSR0dXU0ZYcTE3bnRRa1ZRZTg1cTFCRTg2?=
 =?utf-8?B?YWlFdXhLYzAyVDFUeDI4OTBibWFsYVRodG5PUkl3ODYyemNFdWNjUTZhbWdG?=
 =?utf-8?B?WkwrM1dHVElNR092THo2VmoxcWJWdkZsQkZ0QnczUXNjbzViczl6cWZhL09P?=
 =?utf-8?B?M2c2RXdLSzRPSjJaQWhQc3BkZEJjNGRCaVBGN3Y0dXNUK29aRVpMNTJvSkdU?=
 =?utf-8?B?bjlnOStBR0Zjak9KeHErMEd5UFFmQ2NGWlQ3Qllua1ZzVG5NeTRZSVhpTGxa?=
 =?utf-8?B?RFJFcmRzeVlCRHJlOUVHUlQ2bG53V3Rydjd1bWJVU09GZE16Z2NxNXhUMXlu?=
 =?utf-8?B?U1paajlNZjhvMWZCSzdXSHdReVVrelhBQU1KZ2c0MFovOWE5dSswVVd4WXJN?=
 =?utf-8?B?ZmFQSDB1UGM3RUQrSEJyQ0JrYU5PV0o1OXFlZm1yOHQ5aStNUnU1L1FKMTFv?=
 =?utf-8?B?THFxM1JMMEFkTjVCejh4S1l2ZkxoTkw0K2xjekVwKzYwL2UvMFRWYmlldEEv?=
 =?utf-8?B?czEvazdJZWV3RlVGMVhsUjVaK2hKL28yMmtxM0MrNWNXcFQ1NEhsQjdZZzEw?=
 =?utf-8?B?dUlpa25ZNng2VjMwRVZlYVYweFEvNTNsOENXU2x6ZFBuODNHSUdHYVpZdG1N?=
 =?utf-8?B?UDZ2a3VPQjFqR0ljRlBSSWs4Y1FCamFHeW4zYzJveDE4Q3RrNjZBeUdKbXFL?=
 =?utf-8?B?WWpMaEdQOTRyQU52L1RYNWJHRmhDc1R5SS9CSlhaTk93SEkwYVRsMzN1T1g2?=
 =?utf-8?B?SmRqTys3cmxJck80UWo5OXhhVGM4SjVLaHkyeFQzWVdVUzNKbUdGZmp0aVJE?=
 =?utf-8?B?SlFuTmJXcGJobUdvcFU1U1RBdnBKNnNUVTY2cko1RytBY0g2MGhUZ3Q1VkVu?=
 =?utf-8?B?di9TakN6NklwVkg4d0tHWHpJU3gwaE5zRFY5MWZsMlg2eEoyRm9LSDdkRFcv?=
 =?utf-8?B?SWJtK2hBUU1hbmFtVGRka0lWdU01TWxzN3VKNXZBeXc4SEUzT3MrUEtDYm9X?=
 =?utf-8?B?QkhKTnZIUzZYOHlVOENTd0luSXZMNTY4LzBkRlVyUE8zdjlHbEJpWS8vM0xu?=
 =?utf-8?B?STNJZ3pvU2c5dHNZaURsQitWZmlsdjd1TUJOYklJWHJLcUhudWVXVUtacXdZ?=
 =?utf-8?B?MEF4U1ZpSENaQnBiamw5OTdsMjErQnRkNldUSDhZY1VSVUlsbjgxQlg5TFZt?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nd8c+WNsuU0Pm/1iQfTobcybYg9WU/mKup+JiuvvcDvh1kYG0Bu+VAt7mmGXbCkt6IzLSddhVxzmR5eBOM78xCpdAiqXi5obF2Hz0Xhvca1O/kIPx/TyP9hsfA3g6Sc1rO0FdNzOH1/dLXz9XzEvOVztMKQGEt0aqxrt9zubBjb6lb0ADaa6xXHazWp0CeKk6rjzkVN6f6+JFe1A2SHio44JZvYBxQ4qD4YD3+RmMfLeifXoXV3PxBRvlDVEQlU51/5snOjWPQ1peywmuNhPTYOmWK+JYLlOTZVcDejxEC2yYQMaZ6mr90Nvu9gwth60rmtmcBo8r+p1Bt58XeGAQP/2dR6XR14jkpt/IeyuTdoMZSteiDfwlOY9uOw9vKYGfbs1D0D5NRDKG1wED9JOthEriY9e7ZeJ8727/kyHUFscPgB40h0StA9vIf96r/1Q9w6eg7leTM4GrHNn19VE/aqdga2flJbKKe1rAQv9RanF+qkCu1/gOmmCss5JepIs9UZxhqCkLJ8VhbQOhdMgIVD2W+MxQUwccB99CjaPrZF2vFN7p3crd7+duozH2OqmOJF8ZrQ3ZH84kIhNVEQE2JWErmo6wAwbPxdUARMucEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5269a8de-f065-4eaa-a9ed-08dd78ae4494
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 04:06:43.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eipXUaR0NoWdeaj1emvYiNckjzmxkC4gHA2nn+GX3Ynh/NkRsqTSw1hNYGQZIzVjcyDnbs/nlo63QiUckWsXb9fAsqVuHiVH6HI5bUiAZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=877
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110028
X-Proofpoint-ORIG-GUID: 7Qg28vEQGl2WIADQAm24eGTVSbKlxc9_
X-Proofpoint-GUID: 7Qg28vEQGl2WIADQAm24eGTVSbKlxc9_



On 11-04-2025 06:33, Kuninori Morimoto wrote:
> +/*
> + * The data on memory in 24bit case is located at <rigth> side

typo rigth -> right

> + *	[  xxxxxx]
> + *	[  xxxxxx]
> + *	[  xxxxxx]
> + *
> + * HW assuming signal in 24bit case is located at <left> side
> + *	---+        +--------+
> + *	   +--------+        +--------+...
> + *	   [xxxxx  ][xxxxx  ][xxxxx  ]

Thanks,
Alok

