Return-Path: <linux-spi+bounces-7987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A614AAED02
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 22:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FAD1C44B80
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 20:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3E28EA61;
	Wed,  7 May 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bernerfachhochschule.onmicrosoft.com header.i=@bernerfachhochschule.onmicrosoft.com header.b="l09MMxIH"
X-Original-To: linux-spi@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021109.outbound.protection.outlook.com [40.107.167.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D22080C1;
	Wed,  7 May 2025 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649497; cv=fail; b=eHPFloDuYxWl5x94e/Pxpl35BO/Jq5q2KlyYB8XzjTPKDBycrZ0Ab1XUn8/jxZCs3796HAdXFx3vbRz1RhM5bFFFtHvsOBo9kRPlk5Y9uULtX2lBw++w4JnPKB0t7HdK6WJB80UEaPY6czFjgEjOn5hWzwonW+TDbZg9yGbC6HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649497; c=relaxed/simple;
	bh=Ni3vLKqNCHnG8ebGQfIfGvw9vrwstpAEuQejtmuGSH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oafmP35WcoruxWmmk/B5OfyvAQ2im6n93BJX/RbOYzh7V7r2U1T9cBrJv8oeR9yDXP8/63tBmW5kqDrfWuRTNVx59J/wgbgfAeSi0NEfb781tin4diSDQ/zyYDfIIiYlf4hCn2BuAYm1DzIQSph2d+VItzuS82cDKmF1ai+0XtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bfh.ch; spf=pass smtp.mailfrom=bfh.ch; dkim=pass (1024-bit key) header.d=bernerfachhochschule.onmicrosoft.com header.i=@bernerfachhochschule.onmicrosoft.com header.b=l09MMxIH; arc=fail smtp.client-ip=40.107.167.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bfh.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bfh.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wo1jpcUNJ0s19tOugfLbFsME83yKm3b+hXP4yQ1Tn7yyF1wvuHLIR6ycOtSZ7WfgudDYJny0TYA4qamaeXZZLAZUREIzokL/y9i0r5VadO2r5nBBrCnfJYBNm1zt77zwI9lPoOLhz8IuoYrZQk5bfTx2RJRNW2p78w97Qmpq7qXHCqmcsEfdGrJ1mvA1koC77SkdfhQaKZ/YKq2U/z4zm8iPGWxWCs/WLZIaDiL232Gfl8ey7K+fFK0eXdJNNMru3wyktNFCYo5NzkHzHJoXERdxAicWEhpXDly1xpU61zvQ2n1LsA9OC5gpDy58WVHqBZRTzWSJawC/77khseHnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0yV+84c7BOH6vfKHmIUIa+5mU81ADc/FOvGOEeYOQk=;
 b=qR5HPp422j5EuaG1jv8sOlgEmRRwmf/Jbv3MzeU5TMgYiPZE3Igb4SkK72IKiRB+vC7juLfEBznPUZScVHYSDYewHLKmBP05dgMo0LvVLnWL39seJbEoNcIa0jKDgNrvP5R/eVewxAF4PihEIXdhVzvoGc0N7MoHmdMyfiWs/o2tctCtmR/gHziO3KA0axg574v5nv1eLbeA9hX3IC2h0fRHlzZh2pKnO00ou4R0h8sFzh/ZKBI67FZ8hP2uOqgUodoOMGQyNR50GnzEMffb6XfLNXhNn+hF9gO0Qje4kpzTqGZQdpAAJRezwzsPkiJXl+zvNUxmLlDtBOT6IEQ1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bfh.ch; dmarc=pass action=none header.from=bfh.ch; dkim=pass
 header.d=bfh.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bernerfachhochschule.onmicrosoft.com;
 s=selector1-bernerfachhochschule-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0yV+84c7BOH6vfKHmIUIa+5mU81ADc/FOvGOEeYOQk=;
 b=l09MMxIHDvmBDPXmg2rpiFx8NQK4kBD+emYy77YBzSLC3LaKIBiedr5i97uUjFYni92ciCV5QdQc4tSytrAesQtOH0HnPAQc7nX5psJfyj8O8v/i5xLjjuoSZPWry1eUmGXXkadHqs5CYrmUNxDHpVJNzG5B/Qj9A91oxgcB6Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bfh.ch;
Received: from ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:60::5) by
 ZR3P278MB1323.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:70::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.12; Wed, 7 May 2025 20:24:48 +0000
Received: from ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b47e:1592:3ea2:2d5a]) by ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b47e:1592:3ea2:2d5a%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 20:24:48 +0000
Message-ID: <9901d5d7-e821-455c-90a4-9c054481b539@bfh.ch>
Date: Wed, 7 May 2025 22:24:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] applespi from 6.12 onwards
Content-Language: de-CH
To: Aditya Garg <gargaditya08@live.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 linux-spi@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, lukas@wunner.de
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597CA6E163DA8D0F358F7AEB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Berkel_J=C3=B6rg?= <joerg.berkel@bfh.ch>
In-Reply-To: <PN3PR01MB9597CA6E163DA8D0F358F7AEB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::13) To ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:60::5)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR2P278MB1033:EE_|ZR3P278MB1323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed83dfa-62dd-439a-61b1-08dd8da536ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUdGc0E4WnRpVThRWDdnb3lUTkZOUGhLYjAzbTJRcStQTEhPR2xjWmJKckVi?=
 =?utf-8?B?Z1Z3ZGQ0bGhtdTUzbjZhMFQ5TU9pbTV1YTBLekF4cjFVQmIxakd2NWVsQ3Iw?=
 =?utf-8?B?MGJFYUFzZXlPQTdpSTJ0Zi9aazI2V3o0L2hHblNVN3NKR0dadmM3eEpDeHhj?=
 =?utf-8?B?L0xBdzcwc0J2RGlBYnZ4TXcwWXBsWEZQMjNZQ3M3a2JCc0dkT24vWEZ5US9M?=
 =?utf-8?B?YU1JdHNCWlR3N1VUbGZzenM5dCs0aXBWbThJZFo0cEtIeEN1YkZaQXFGRzB0?=
 =?utf-8?B?V3NPM3FxZVpxUW5jbk1IdG1kekRuWGY0N092cHpkUnlGODVPeEF2c2doNDlE?=
 =?utf-8?B?TStScnIwdklWQmpUalRRVW96UWgrWHlvNGZSVHZ5YWNSempOa1ZaNEdWcVdr?=
 =?utf-8?B?NmJEcDVERnhjMEQvYXBtOUdiZVgzRDhZZnJFV0FoeXhkdTdWdkg1WEhwak96?=
 =?utf-8?B?dVIzOEJsaDJicHVhRWlSUmJmbS96aU5ma1VhSjlXczZRQy8zdlpoQlZkWGdq?=
 =?utf-8?B?QzBLSzRYSFNBMnY2WElaTkx4SEMzZURFQ2d5bkZrK0pGT2Jid1RBZmo3RGdp?=
 =?utf-8?B?MkM0YXQwWE1VUFpUVXVZZVpLY0xHem5QdFY2YWJPalNGS3MwWC9hcFVINmRu?=
 =?utf-8?B?MDZqU2ZYZklYYTdaUWpUZU9MUUpmVXBXTjRUUmxtanBBc0xvZHk5TFBMYnRI?=
 =?utf-8?B?aGUwaU1UVDd5N0lHUWgwYlZJdWx4T09rZ1k3OS9OL3dlZTZxMi9JQW9SUnhG?=
 =?utf-8?B?SkV4M3NmZ2xZbGdMRURhSXV2MnJ3aFVyUHF3MnVpVHRMWEZjQUdQMTNDb3Jz?=
 =?utf-8?B?Zy8yREY2d3ZYc1RkSWlsOFJmOE1EZTAxQVBUVGpzdFdoeWVlWGdBaUhBTmNW?=
 =?utf-8?B?OWtYNnN6YXIydWpTNytOMkpHZFo5ZVJXc3BYdUZDZ0Z6UEQ4dUFSSkdIT0kz?=
 =?utf-8?B?cmpEcEh1aStYclZrMzlGV3NRVVYyRVJwNm9kRzlESURmQkJsZll5UC9CTkpw?=
 =?utf-8?B?ckZ6Mkh0K0VLdzNweFVSZXBaTi80MUxKOEkrZ0RGMTgzK2ZSTXBSNk9rYzFv?=
 =?utf-8?B?TTBXcWNJR1d2MitlU3FKaE9HM1R2dWlKbXV5d05UL3luVjhyeHVwUU9iSEZr?=
 =?utf-8?B?a2xWUWI2bHhyQlVoN0NGMExEZ0dLK1VVbG95WERtZWY5eUVVak0xaENremNW?=
 =?utf-8?B?VnovM2orV2hzMWt5NWxMdGNueEV0VnhEVFZaWng1Vm0wUDd5d1FNRFJKaStu?=
 =?utf-8?B?L2gxWHJNT0xHV1g5Vyt1ZitmZDlISGpVR2NrUG1WdmwwZTk2MXJkRFgrOVFS?=
 =?utf-8?B?aXg1TGFpekxwRGszYjhRNFpWUGN0ajNJMjJaNlVlWmRwZllHekd3TVExajBG?=
 =?utf-8?B?MS9aU21LS2hsT203VmxhS1BUZk5PQjJOUkI5TG9mYnhZYjhjOStUeW11ZTQ3?=
 =?utf-8?B?Zy84VW5lRmRSUTRQZVZ2V05WRDNKaENwTG1HOWY2UWUwMm9YTkhSQjFHZnhk?=
 =?utf-8?B?QkhOaVVlQmh1TGhBZWlrckRhWjVjbWJKS2o3Mjg0S2lkcmNIT0t2SFV2S1Q2?=
 =?utf-8?B?ZUlkazhjQ1psTDhyMXovVk8yRkF6MjYzTk4zQ1Y0bm9TZGVwak5SQU1ockRZ?=
 =?utf-8?B?Tk1lWTRxWWg2Y3oxMk1DSExNVDY1TFNxWTBpRXlZY1ZmR1RCVFBmaFVoM2dS?=
 =?utf-8?B?alg1UmFQeVFleG90c0tYV3NtVTZWd25INzBlWEowejZOSkg3VCtmd0JLb0Uw?=
 =?utf-8?B?Z2F5MkJ6R2tqM3hVZnBQSEZsenZiWHdEU243QnkwVXRFYlZTMHBNclNBUFc3?=
 =?utf-8?B?bTMxN1E4L0hCekc4ZkVqaWNDYWFQbkZkM0x3RVB1WXV6V3NUQTU0Q0dUVVFx?=
 =?utf-8?B?TFhaSlBobFFCRkZad2tlaDU3S0J1SFR5WWZuUk8vVC96bFMwSEJoalprdFZ1?=
 =?utf-8?Q?+R0l8tnF95E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHMxakM0S25BVG0wQWg4WXU5dndWRVBmQ2l2MTRBTnZSNnR3OHAwY0pYTlhG?=
 =?utf-8?B?WkRuRDJ6bUs3N09iWVdhRnBHRDF5RjNtNGNJZ2hYMm9lckdHckprb3pEeUVM?=
 =?utf-8?B?cFlINk9qNlBKWllHRFhUVWpIVGFhMFYwSlJibjUzbW9neVhWTmFsc3ZKSEJu?=
 =?utf-8?B?WVdzSzhzWGhuU0ZkSjUzSEtnUWJBNnZ5L0diTFR1dGZPNHJ4Y21XV0dRUFRL?=
 =?utf-8?B?Wjc2TFY1a1AwS3dRa2VwaktFNlM5Z1hsNnFZd3NOZUtzQkNIRmVGOFRVNUk5?=
 =?utf-8?B?bkRZQVVjRG54RnFBNEh1R0dhMzNDNXpsQUxmVWlqb3ZUclhVaTl5b3dwZ0t2?=
 =?utf-8?B?MmVhWkJqbGJsRDdTTEgwTjdoUXcwNW1EYzJPUTZEYTJtUVlzV2FzNGQ4aEh0?=
 =?utf-8?B?NytJNDBSTFdLRjZadE9rajNjK3Q2bUdQUFlzeXpJeHpnM3RFbktrdmZMdlhz?=
 =?utf-8?B?dURIOEtsYmY2Q1lreUwyelNvZzIxL0Yxc3ZRbVplTDBYeVpKNklTcUlmZFVt?=
 =?utf-8?B?VEdaRDBXMmY3NDhBRWlMR0VZV0dVQ3ZieUYyNk9tWEk1a3h6empUNFVid1pK?=
 =?utf-8?B?NUlLYUw0c3I4MU1sdkt4TkpsYmhYU2FFYTNDRW5DdXExSEliOUw0UytEWHZ1?=
 =?utf-8?B?Nm5ici8rQXJpdU1qRWhjRUlrVHkwTUFGQ21oZGtDemNDR3JTcFduV0VWNE1t?=
 =?utf-8?B?ZFRJNWlNREQ4cTlNUlJpZ0lHSmNXcHRpMEo2ZVMxOGxRcGVIT0VPSW9uTkFU?=
 =?utf-8?B?eVJkdHdVVFErejdXSjd4QU9GM2ZHc2NXcnd2VzlGcUVsekJjM1RRVEMrYVVH?=
 =?utf-8?B?Q3FtcUxlOEtGVU1OWDlibjV5ODRnN1oxUkFWSDNhMUQ5OXk1QThNazlBcjZt?=
 =?utf-8?B?eC9DSkFrQjBOa1ZtQncvQ3VBUTZKOGtnSkFuMWI5MGduZEZnQllZek5nUjhr?=
 =?utf-8?B?MXRmMHVLdDZEalFJODc1bDk1ZDFJaGpZOFV3SzByRmxYNzI4ZzB2dXJFSHZI?=
 =?utf-8?B?azMyQUMwOWFTQTcyWXdMdnRJQThJZHdaM01mMW5NMitqUFppMndLdHQyQXA3?=
 =?utf-8?B?QzVaUHMrR0hhVnZyNE8vcE5zZ1ZTOWdORDJxc3o5bW9nck5pWTUyejhzVGZX?=
 =?utf-8?B?K3gxWDIvTUpVKzBOclBuZXlFL3JzMWlQdkgvZTlvZThYMS8zTnRnZithS0du?=
 =?utf-8?B?UWlZK0tzQ0t0Z2lZb3FoTkhVMUlYS043ak5Mb0RXaGVQdHE2RHZkYlNHREpx?=
 =?utf-8?B?Z0ViejhUUHBrSG1iWHJGV0d1MDU3OGVEb3NSOEo1Qm5DNS9sYkZJVFRDc0ZP?=
 =?utf-8?B?eHVTQzdRSzd0T3B0akxjZVlQMGhWK2NxVGptNjI0cVMwenhLcGtkNXFxQjA4?=
 =?utf-8?B?L2lzcXk4WFZkWjJlbEU0NDlXZ2JzWFhIRmRuL3RMbFJHZWRNbGt5RVB1NmNT?=
 =?utf-8?B?d3liUmw1ZDVBeWFCMFUrdmQrQjFqZjV5cDE1cmg5eFJwL2V1RUdRTlJyRWtG?=
 =?utf-8?B?bGU0ZnhxeG9kRWxHUVBad2ZKYmMyd3FRa3lJZzR3NXZqNUJYeGN2bFpFOUpF?=
 =?utf-8?B?alJHekxIWmVrRFpiaWg2ZjkxTVpPMFpnU052YzErK3h1Y1lxTTVoM0NqWDlW?=
 =?utf-8?B?MHF6c01JR0JsMzdvUHU4cWJFNlB5S3VIZVZMTXBjS0REeWRzaTc0RzFxTkwz?=
 =?utf-8?B?RU9nMS9XNGdsbHZhSHM0dVBCQXFXTnFDQTArWVgxZ2tYa3hhZWc1ZFhpQTBX?=
 =?utf-8?B?QVBWZVFGaXdoNEFzSEJSSEsxRUN2enNWaGsxTzJ3LzN3TlB4d09OTVBJckt1?=
 =?utf-8?B?L0kzaFJxRDlDMEd3VkVlYnlnZUNhWlJTL2xWdHVPT2paR0JqeFhkak5mZEsw?=
 =?utf-8?B?bVg0eGxuU3JtZThnb05YWnhZVzQzMlYvZWsxZ1NNaWxuUU1JaDNMSVBzWmpZ?=
 =?utf-8?B?R1JKMzBHdHl1ZmQ2d2hNUGNtVjRNT0pRemlXZGN0QjlVdTE1Tks0RDNhZlFk?=
 =?utf-8?B?cGZVNks0a0tiajBwUWlIcnI3QmxVeU80RVZDb21KbGY0bWhUdHRkbk9xNmxT?=
 =?utf-8?B?aU5FKzRjSWlIVkp6bDdIeDRLaGJ6Y3FTNlNsUmRBUkVoR2t5NG9rRi9hTm5i?=
 =?utf-8?B?RjBHLytkeDhIUjhtcVdlcWxFU1ozcmpFbHlsc1c2QkJjT3N3V0lFTzhYWExV?=
 =?utf-8?Q?aK5qtXfJsSpp5prURbahxYs=3D?=
X-OriginatorOrg: bfh.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed83dfa-62dd-439a-61b1-08dd8da536ab
X-MS-Exchange-CrossTenant-AuthSource: ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 20:24:48.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d6a1cf8c-768e-4187-a738-b6e50c4deb4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUvKiFV/48pG0rLDGpv0HBt37fcpwO0FtlBpIpr7vxFG7sGwUg213VOowHDyfIuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1323

Hi Aditya

Am 07.05.25 um 18:31 schrieb Aditya Garg:
> Did you try bisecting the faulty commit? Is is starting from 6.12 or some
> version above it?
Now I did:
Kernel from Ubuntu 6.11.11 is working fine and 6.12.0 is not -- 6.12-rc1 
and following are not working, neither!

Thanks, Jörg

