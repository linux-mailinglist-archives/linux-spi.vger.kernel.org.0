Return-Path: <linux-spi+bounces-8120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08186AB74F1
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 21:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BFC27AD091
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0928CF5F;
	Wed, 14 May 2025 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FUv/c+3t"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA928314E;
	Wed, 14 May 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249283; cv=fail; b=XNxN7TbIVGXjh7VjYnzvfVX+2f+gn7wFULjhYFRlx/+TNwbrGQnZsMC0cT2XbXekvRrwNSvuEJaPE55JSnGFK+nobvveUkvsXyltTIO/QVJUvNFQwYh6uuHIpTY89xeltLxwcRP2ATS3x67+B1yrvk5nAHTW5B7vpPz1pfPFrW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249283; c=relaxed/simple;
	bh=mBS2+XMcmufZ90NPEYx73FbCBxz1901alF/Q13QU+6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iJWjWNjQS3rLm1Vex6NIAhpMx0qHHQdD9eTWc7uWDPGctg9xoBjAMgLFJmftk4ply0/0zFiHHTzbZ5zFXcQEpODDFEP3HRtHx0mdgbm2QLq8ReItQapWrVPVDZH0pwKqElBpEllr7qdsQyVngBN9Sj/dzhUGal/Gmu9NG+KSMvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FUv/c+3t; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGmu6fGd4Uq4cw5h1azVe9BEF4YPYpd6Uy3h8+16gwU9s1t8n2B86TX/3L0dUzENt7eLj/kEwNkFWOYKahfjmPx+IzEyzejabimY3eL2XyNxMwmLTX4QvGvZ7VFsJFxJpsGT1FEotmxvLPS5r81zGDEFpSKI6jsapURWyVjwUdY9Rwu+jq0/zjOQMF9QSVXdjUJSIsFNLSRzLm63HYQ4x2gxLdLymgO4HisY9iFe3J15BKa/4xuJozXaKSrFlnCerY7bABrRSsPpQZJXoRaox8yipySIQy5xtXNbCl1+rMbbzeDdJwcms9fqY5S/SeUQsjuSwzgp2/Zba+oX2+kcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKge1YVE9gcjokr+ET/5hpa/JR9YcZmzjN4rvZBxcDc=;
 b=bVBG+IL66NOYDmckarYxkqx+GuBjQF89/gM0zYoCMW/seTkPH3Kk+2R3OBOlVL8PfKPpD8lGaAZnnc3S7KIp+DuFIeHywSRpnEZq8panhevAFQXyjterJtTO9uAwhohBBqR9ZhAXKTDB+u//mv1SvQKogJlrhFyYNz6+CPCeAutVo/7zk0FUvgMTNAjewl63nFxTJkQZRPW5ZDIXdczEKWlb8yyTXCIxwj7ND8aeqDl1ZDt1u0G2jVQGLD+um9G1Ii2Cw0RI5t4ND79q9UzvOXHmRZNVHy1BGvOFA84/Q1ch/E6gqWJ09dOR0yFBckc+Jk3iy2yJ9Dk6Zl9Uqi8eGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKge1YVE9gcjokr+ET/5hpa/JR9YcZmzjN4rvZBxcDc=;
 b=FUv/c+3tRlwpbvmKWI9GltEK5yjjMBs0XllegTTU0EmvYRbtN9CCQzMHub1pOAj3A7X/AFosGM6mOj1DbXsXsxntDfn1oLYsgJy5cUpxjitYvI7n3k8r8EaM/x4bHhgLQeOoGGj1pZx9DHb0MsGcvSfw5xILqrO8Vfn/Zafp64Z9kdg6Ed8iKgBiK/tBuxuNtY8NrjBmwqMKnOtjdHfcfge3pz+3B1njiiIx8fN/hi+yXDSnF4YxAGQ/2VQN0Ix9ZhEG40ZFwTQArf2UYQI6nqQAXcpNlH3NxwQS92qD3phhx5VucZx2ALKvhMtu/bhmRTyNxqyVa2zmd+r1bjt3bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 19:01:19 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 19:01:19 +0000
Message-ID: <6d9a91bb-e3ad-437f-8f2a-1f18496614b9@nvidia.com>
Date: Wed, 14 May 2025 20:01:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] dt-bindings: spi: tegra: Document IOMMU property
 for Tegra234 QSPI
To: Conor Dooley <conor@kernel.org>, Vishwaroop A <va@nvidia.com>
Cc: krzk@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, skomatineni@nvidia.com,
 ldewangan@nvidia.com, kyarlagadda@nvidia.com, smangipudi@nvidia.com,
 bgriffis@nvidia.com, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250513200043.608292-1-va@nvidia.com>
 <20250514-shrimp-ranged-14b4529eb997@spud>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250514-shrimp-ranged-14b4529eb997@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0123.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f62ac1a-bc82-43d1-ae33-08dd9319b5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1dPRGFTMlVFbHdLMEpKakU2a0MwZzE3UElobVNUZ25GajdQOEVYZTg1OVVN?=
 =?utf-8?B?TFV1Qlh0NWl3UE9qNCs0aFpzU0FzSkRSMXd0MU9XTlJkWG5vb2ZEYXVlTHFR?=
 =?utf-8?B?OXhDSHpkOHIzMW4rNUcvMlZMRkFtK3JXVUd0UkRkRW0veTIvZ0NZMHd1Risv?=
 =?utf-8?B?VFBOaUk0T293a2tNalZ3U3ovRHQ0MTZ0TTB5c0E1MHNnK09wejBHeU9VU043?=
 =?utf-8?B?S3dCaDZPOG54clovNjhpRlplOForYXAzOGJKVDhqUWU1aWRoSzFxamRwZFJ5?=
 =?utf-8?B?SFRhOXB0dXNxWW91STZFbFVCUWFKVDVUUVhsUnY2ZFVoZnI1TjdRQVliU0xn?=
 =?utf-8?B?dzR3SlVRODZpMUl2Tk5vWG00V2tuZUFMUS95ckNpdDJGOTFRSlVEblpZc09U?=
 =?utf-8?B?WUgzdzdBeUd2L3dacHRXR2Y5UCt6YVhaMERDNkQvQ0FrTmhlZ09reXhrTWZC?=
 =?utf-8?B?bHVETFZBZjFxdUdkN2x3bk5YOURkVWRSRGMweEJHY1ovcmVIVnhidG1haHNB?=
 =?utf-8?B?RVJCWnBnck9qd2RIckptSnJndUNQQ3pHRHlGeWJmNVB6UDB3d0VHNktabTZS?=
 =?utf-8?B?TDZSRC9BQTRVa3RhZzVCYTZTNCs3bUR6dlVIS1lLQTZReGIwU29YZnVOb3A3?=
 =?utf-8?B?S3FJMjNOSndTb3R0bHZYNDRNQXRtWWQxZ0ZTTE8yRGJFVVFHSzJzYjRoR3kv?=
 =?utf-8?B?UFQydjlEQ0ZVOElRcnJ5SFI2MWxKRmR0dlN2NUVoSzZEK2R1NDRDWUxaTWxY?=
 =?utf-8?B?L1kzekIvOG9mYkFIdVVrTEh0cThXVTJONVdWVFZVQmlrWXdWQWJkL1FKSVJs?=
 =?utf-8?B?SDg1bC9OeXc5RkMwdlRwK21nTDJ0NGJXOUZoSWl0MU1JeVVuR2xCeHJreFh6?=
 =?utf-8?B?U2QzZGJxd2MwQlJKL3RFelJRUnB0TGlGT1FMTk5LdC9ldjZUYm85elA2NmRP?=
 =?utf-8?B?eE5ISFJIMjJqamhqU3ZYMHdOd2k5OWNnTG5YYkU5T0VJVzgybmZDRlZNZnFz?=
 =?utf-8?B?OW9vZmxDOFhaRUN5RllLdU85UVFBTVpJU2dMK2NISm9PUyswMC80TmZYNjY3?=
 =?utf-8?B?YzdQbjN2K3NtOEs0SnlBWVRnUGl3aUVxVWw2RUsvVnE5bnVESjZxY3ZwTVlw?=
 =?utf-8?B?T3ZPb0VJbGVKZlB0ZktuR0psdFcrOVFOVEp1Y1YwVi9xZHRsSlJ3WExrWGdM?=
 =?utf-8?B?WHNhVVlDTTBFR1BQZXpyY0dGV05TWWVkWXRTclQ4TUM4ODhIZGd1c0NVTEw3?=
 =?utf-8?B?a21HczNTZk9yckdIUU12dFY1ZE9VTS85QzBWTzByU1NUVUhKb05jTmV0Um84?=
 =?utf-8?B?YjM2WlgrdzdhdmZKT1JKMGJGTDYzdm9nZVJ0b1NVUVVzMlNVSVZIRGJOcCsr?=
 =?utf-8?B?WHpVQnQzQ3Y5VnFyUVRGNnkrbEoyelZneVJnNS8rcmtTanFmQUxFMXNwbm9F?=
 =?utf-8?B?VTJGUWsrMXZCVWNpQUhkSkhWTjFmVU5lZWo3NisxWUIyR3Q0Z0J3WFJFN3pu?=
 =?utf-8?B?N3MvaXBuekFKeG94bnQvYXpITW8rUDRrTDdrVHVEbVR2QWtXOFVzYTI3b2F2?=
 =?utf-8?B?allDOElCSWtXTWVYUmpsTkZWSWdGeXFwc083dEUwcEl3LzFjYXM0WDJiVFZB?=
 =?utf-8?B?aUpDcDVNYzdrZGYxckduU042MjFDWnNmdUxBdkt5SGlxL2hKc1dFTnM4alkw?=
 =?utf-8?B?KzJBSGl6RDBobHNROUo1Vk15UExwTXoyOGJUZTRFRlhEdUtlSlR0K0JwdWpa?=
 =?utf-8?B?clhSZ2t0REhsOUVnMUs2RER2SW9SeVFaR3hRQVd0bG9KbjBkQzFQNXVCN04r?=
 =?utf-8?B?bFduNTE0Y1ZXb1BPbGZrZXMwZFJxTGlScFV1T1ZualBNTzlEOWVpKzBXSWNL?=
 =?utf-8?B?K0JPSHNmSHc5Qm1jeFJ6YlgrZjV6Zyt3Z1VZN0FPaFY4amRpMWFEdmFoMndt?=
 =?utf-8?Q?MF01LL850+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0paYzEzVERsZTBtcC92V1RFN29PcElLandVQXJ6UUMxKy9qT3Qvckl4LzdP?=
 =?utf-8?B?dEtGNENRMG5EVXlaUHo4aVdjRXZkODdpRmV6aTJnR0xuQXFIcWVRK0JtNEgr?=
 =?utf-8?B?WXNDNk9xQnRVQml4VXBKWER6ZlNyZEsxWkR2MTV0eFRGUXVBTTFWV0V1ZDUr?=
 =?utf-8?B?OGNKZUQ3MUxHdis5WWVWZGJEVkM1OW4wVG9oMzAxZmY3UTVYRXFlNXNyclFL?=
 =?utf-8?B?WjNsczFqRUdOWmkrQ2dpMWxoLzRNVVc1S001a1pnQ1FGTzJ4UVpKUWVNNGha?=
 =?utf-8?B?YXl6TlQ1TlhWRHR4MzdmUEY0Wm84SVBGT050YTliUVArOVJYV1M3QVZldHNj?=
 =?utf-8?B?ZGc4eHNvSll1WVVFODhrWlNoK21JMXJ4S09ReVFFZUtIc05aSGNpOTcyeFJ3?=
 =?utf-8?B?Ti9xbFN0RXg1T0sycmlWajRyTWxOZUlSNThRaU93Y3cycXhIUm1ScWRLRHQz?=
 =?utf-8?B?ZWFRV0R2NzdpUlhSaGgzK09sWXZSR1NqN3dMWGlBaE5LWnd1L2NWK1BOV2c1?=
 =?utf-8?B?N251TU5sOEtRcWZydkwwMVVSaENiaHU0NWRpOVZQVWJhL3N6VXpIWERMbXk3?=
 =?utf-8?B?SFJ0bDg1VUFmazVKQlN4RUpWZGlFRHd5OXNzTWJ4VEhJaTlGcFNaa1pNYjkr?=
 =?utf-8?B?SXpYOGNUYW5SL3ZpZ3ZtTEZUY21tVEgvOFFWNlFrVnpYVmVqQ3EzUHA1ams4?=
 =?utf-8?B?akNUa00wQmhVdWt3SEJpTXE3aldjeWdkeGtnNHdobHIyK1FwV1psSmdNeVgv?=
 =?utf-8?B?dzRpaHlHS2NuQWI5b01hWGZRa0RtQ0FFK1ZrOUt1UElDQ201bVBoWGpZR2cv?=
 =?utf-8?B?R3QyTmJhOGJxbDluWjNKcks3VmZzelRCY1dnd1k3dEFIZlVua0h4eDRwVUhm?=
 =?utf-8?B?YmlEbnV1OHZuVWs4MWJWWjMzY1g3R1JXQmRPM1VQbFVDQy9mRm9mYVpZNXZ0?=
 =?utf-8?B?cUpQTHJLYVhRcVNSWURYVmcwSDFEbXh6dS9ENFVEL0FhWHZNMFFiZlZPV0pM?=
 =?utf-8?B?dnREZkhqZ0RpYWZGamtkakJZODd3TjM5M0Nqa1o5ZWQ1NW53VHdkaklYVTdq?=
 =?utf-8?B?VG5oZVgrcXN3K1FYUDNVZllUTmJVZS9ma2tpS3dXZ1gwWmdnK25rNUl1UHBK?=
 =?utf-8?B?N2IxN1lHelVzTE5QelczWEdLY2hSNTdxd3JuSnZDNVV4V25HQU00aWk1Qnhl?=
 =?utf-8?B?LzRlSy9BVnVCWjZ5bGl4YWRnSXk2Y05QOUtPYWJ5UFNySzZNRkozbjY4QlA4?=
 =?utf-8?B?alQ1TTFqR0ZlbTVTUFg3MzRZNzlXeXZvU2ZKOUo5ZW1URVJESVE0UzBHTmRj?=
 =?utf-8?B?ZW5HMjZPTWNDRWc1SWdWWnQvaVBCaHkxaWRTREVudlUxWnU0Mmh6N0dZQzRO?=
 =?utf-8?B?d1cyci9zNmRwZXVBUWF2NXpCSnFlaU15VEh5QndDd3pub0pSOWd3bEZxOVMr?=
 =?utf-8?B?eDg2WitteURMWDdYT1RxOUM5VzdKWFhvWC9uVG5vOWcyN2xiMUtXVCt4ZFZJ?=
 =?utf-8?B?OGFtNUpROTlPRlh5aktYZ3FMT3U3anVjRnAzREFPeWg1d3R2K25yeEtRd0NR?=
 =?utf-8?B?T0IrTDM5LzRRc1RWVWpuVzJxYW5jSW5CdS84QXNhWDBNTGZFYVczOC9BSGxH?=
 =?utf-8?B?ak5CZStWUHQrMVZ1aUpJN0lIUm1JekVpYnZObDgvSHVpOFF1UEVFZmNweWJN?=
 =?utf-8?B?c3Z3aldGVVIwTnkvMGJsTnJJclEyc0RwVWZqVnhJeEE4QkcyellTTWkwWkFn?=
 =?utf-8?B?Snhna3BkblR4dEhwbjJGTU5NODd1WjFMS1I5OXJsV3VMMU1UdWpGZTNRdWRR?=
 =?utf-8?B?djVSdnplbFFKeG9mVGp2OERsR25aMEhqVGdNS2Q4czVyS216c0c0SEkxVzlq?=
 =?utf-8?B?andCZWFFUzdTQ0ZKMjZiYm9Vc2NUcDVrc3RxaHhlbTB5Zm5JQmk2WUhnOWJL?=
 =?utf-8?B?bks3dlRRSE0raEtrMStvSE9tWEhQbDBtZVhpTHV0ZndJUzhHUEdqdmRWaUEw?=
 =?utf-8?B?Y09jOGxvS2NmRHNKcjlOQk1FdVpKVEVjaDlCSnc2bVd5OTk1QTlFZUVTZ0I0?=
 =?utf-8?B?TVVqSEpUY0cyL3E2ZHhuLzFCT1VxdUVyR1ptNVNLNElTcEF3ZUxMcmxhZkhl?=
 =?utf-8?B?Zmtxb1pCTml1Ky81cTFGeUI5cGEzUTkvS1JJRU03OXRSbFhvMGZSekdwWjJU?=
 =?utf-8?B?ODNCeU0xaDlDbTZ3S216SkNHK2VHaGJMeDhBbkdmaVNxMDNqZTkyVi9RNnJL?=
 =?utf-8?B?NzRFSWxhM3FXQVBmRFJwUWpnWTZBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f62ac1a-bc82-43d1-ae33-08dd9319b5ca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:01:19.3143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cl2rVYIcWKG6YG/IJ0CtH2HtGieNLPdH04iiVQ3b55p0hPRucetfpELbOjAUrg9PaPtzOXC0MliLRPHmp8OiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199


On 14/05/2025 17:25, Conor Dooley wrote:
> On Tue, May 13, 2025 at 08:00:42PM +0000, Vishwaroop A wrote:
>> Add the 'iommus' property to the Tegra QSPI device tree binding.
>> The property is needed for Tegra234 when using the internal DMA
>> controller, and is not supported on other Tegra chips, as DMA is
>> handled by an external controller.
>>
>> Signed-off-by: Vishwaroop A <va@nvidia.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


