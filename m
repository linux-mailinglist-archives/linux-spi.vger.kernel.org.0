Return-Path: <linux-spi+bounces-9610-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8019B32357
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 22:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5265217264B
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21A2D12F5;
	Fri, 22 Aug 2025 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="BbsI30N7"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023136.outbound.protection.outlook.com [52.101.83.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF52D7DF4;
	Fri, 22 Aug 2025 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892866; cv=fail; b=H82rAbbxAbbv5MTTjc1tUZvDtqnAe1IK6EIkLQIq6Vs+wpQGI22ApgXYxujTXB0d29fSpf0Qx1yGkxgDahWNqr+eyhNVtQG5EEwUVyg5N9vyb1z8clEJ9TjF/PbrUnRXcpjZZVb6kJMKJydTH0YXejUdn9WuQ26f4qqlxJx3NuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892866; c=relaxed/simple;
	bh=doaw/EkYfsMSXt9PbAzjd2XXh/xHglzEAHWE4Afl52g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEDtvZQerKc9190bQhnqsbwHPN0gzJsyjbT5LVm8zvxxhg3Nbrdik7SdINYlHocCURV5HTnW36B0hjgk9C324lGnwZW7s7osgSfC/nizS3rTfrlRSt3NjRBJVDfiGa+PYDQax3STV+txUK6oE1EvAtPiFNCpN2EKzV3/r4iRQlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=BbsI30N7; arc=fail smtp.client-ip=52.101.83.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R001cSQqGcYNP+sH2D0JoMmrpPM+clRRUiyfImRg93gm4T9fO+MIpLH77cT06nTgwONwmWUK8jwKNR0zkpDcx7gUxTK20Su50H7aCcncVWDwe6rKt3f5IUdgl5tvxfK3iWnp8F4ZCxqKnzccQZ+pcGddZiJfpkfTi2VgMF52M7NIXvCWdqaFnf4OLu+WQbSxFJFxu/hikiRCpFbtQPC0FGYFEsptH/FARhdW9nnkLzNcGwghZybGpNxmOysFFR780tzsIH6z4TH5QEmIZsLlddbOXeLDeQiYfSESVJ/pI5UP6aXVoesNgGV5GuwvY66GcSSbFQ7GRZbRnLGRemN+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuafhKkU4Fs1aGW8xoqs6Yf+975XHmOPTE1/sKVulnY=;
 b=lbzRZGVO+g89x/X8B8mj2De5Q7GHG/zuxsS0cITr7rqiZPzcUIriT5pDCnMmdKuPLa9KsrpBK4XjTTRNS7rg8cDdKA3fn6xxkd2ontnJ4fJa5ZdnLRIA4rhShFR78Zwy+Xx8RaVJIK4H4CgTV2OM9pc2LlWaSoqY6VRoPoifmNptvOqWQeGpzB9QxJOA8NOfhHnefg+H5TMDGUP/Yzi2gOC4DK6CGOfxuzOjzfixMwWW1S5G+DAPuPtXtmbd30DegUukNi6c4mZdHYcRc9Pi30MxkMAIMSZxVU2/9alhOllaQhbYi8/iEYZtEfaOHR/5ODPuYr+aYb6dait0uLwcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuafhKkU4Fs1aGW8xoqs6Yf+975XHmOPTE1/sKVulnY=;
 b=BbsI30N71BAIhudtuQfpXeSnRPRbxo4/ArgVORnOUDMuf98diIuXmQw1Sy71MxfutSF+1VKMi11rySXczX5KTpSPoE17HJhqVXCdzPl+4XaGffOeVqB0cSi66VMFMUzwQNsh72q3vbB22YniIMhWU+xNgHBAQNRT4QH3dq35/xiibND3XfIHJrR2+A7c9KsZd7NYHAudGRNCBIX2TKiUkxwBR6kJjWwCLyHT0NvHIh8I1629oUgFLinLTQXCdeBGjPsGE95fquvPh8z4if1OXIpPz5XAUH367pvJf5VJ+oix1kNS9o4XdEK+vO0rG/EjwvU1TdE5xkglrv2QSiAxTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB9829.eurprd08.prod.outlook.com (2603:10a6:102:2e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 20:00:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 22 Aug 2025
 20:00:59 +0000
Message-ID: <29d6503d-9e34-4d64-aacb-32f36152ce9c@iopsys.eu>
Date: Fri, 22 Aug 2025 23:00:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
 <aKbDjIZhJuWo3yFu@lore-rh-laptop>
 <7bca8089-09ad-4550-93d1-35a365bcd167@iopsys.eu>
 <aKcEYn_hX0ZIusne@lore-rh-laptop>
 <eaea681a-cda8-4066-a58b-61a35e2b8b55@iopsys.eu>
 <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <1d053317-24a6-4bba-aa30-ad42460ec19b@iopsys.eu>
 <aKhtP1G7as9b2c4f@lore-rh-laptop>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aKhtP1G7as9b2c4f@lore-rh-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f533de6-102a-489d-c449-08dde1b69d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmlwZEMvN0dUeXJodjVKanFUbU51QWlIUmtHRDBRUHFGeDFrK2RIT1RPVDVZ?=
 =?utf-8?B?Y2p2MkxNZE8zcDdjMlZ4YnVZM3VwckttZVFiWGpwMDV6LzMrSXVMazZiQjJW?=
 =?utf-8?B?UjBBME9KaGtCU3pBL0ZEN3B2UFBkZmJ3aEdlTWxsVjNodi9SWmhyWStVWUxC?=
 =?utf-8?B?R1NaeWYwQjJzdERhL2x6TTlRM1VpRmNaSzRTTVJJS2ZRVlg1S2gzQTh1R1hZ?=
 =?utf-8?B?ZklsdEtMOEZVNzl4WGxEa3JVUnIzMHUxQXlnTDFrNUJDdEh0M1VDdloyQXlD?=
 =?utf-8?B?TVppcG5iay9qRjlDUHVWb0h2VWJrdUs4VHN0QkloVmRIbm1iM2xJOTVCajFj?=
 =?utf-8?B?Qk8rczdLT1JmRFdPTXBNWm15L25ZQjdmTWV2OGE5dlI5T0dMbWI5S2svV1Nx?=
 =?utf-8?B?SkVhUElmbFdoRnNoTnF2L3U4MHZROG1yQnBFc3lXRDJGTysvT0FiV3VsYzRw?=
 =?utf-8?B?OEVuTHpkLzB2dlVBc3MzczBzUHdMQ0tJNEZHdHU0dGo1R0VOOWpWa09veVNK?=
 =?utf-8?B?aGl2Q1VXdWdOMFVsR2IrUFdjbnQzTDc0M1J6REMveGlCa0ZZZTErUmdRaVRX?=
 =?utf-8?B?NDlrUzBCa1BWbkN0NUc4Nng1MDYweVNoUDFEWFJJbllkOFM3dytSNE9oTmRp?=
 =?utf-8?B?akxZem9mR0pxMFNQMWFTdnllbDREMTVWZUt6NE4xUGVadThoRDJOdDhmajd5?=
 =?utf-8?B?VlNQNVMrVU1JaFU4YnV1RXdKTlpiWThhVGsvQ0s3L1JjWWlFckprczdHTWRK?=
 =?utf-8?B?YlNtc1crdkJJdU5jWHZ2Z3R3SThVS0lQTms2SW84R3QwUXR4ZUZxcWZoMVNN?=
 =?utf-8?B?SUhKN2EvTVdvZHRCQ2hXUndSMlBsbkwzQ1JBN3BvaDJVSCtPNTM3a1NuSVJ3?=
 =?utf-8?B?NkgySEFkcVdhaUVlNzJlbXZpVkMySDllUVJ6L2oxQkp4Q2ZaM0d6M3RMdXZ2?=
 =?utf-8?B?L3lNM2p0dXdVSU83dE1lQ2FadTN3eTJvbDNraHFXbTFaT0MyTVFpR1B6b1Rq?=
 =?utf-8?B?WnFma0Y3TjZld1lXTDkvTElVRWExOXdvNVpJQml2a1NOWFJDckhidE81aEgr?=
 =?utf-8?B?MWIzb3hGTzQ2OXovNW5pWk9BQ2xjN1lad3ZRSFdvQTZBVlVHL3lGM3FzaUky?=
 =?utf-8?B?eE1CMnpBeU1xYkczU0NhcDdEQ2QyZmRDZnpSSTJHNkdNeEVzRlFLcFhZeDNx?=
 =?utf-8?B?T3gyQk1pcDJCMjRBa1FyVVZxSGNxNXhEdUFyT2YrcTBXellXd2hyZWdhSGk1?=
 =?utf-8?B?RE11YzJxd3dFb1JsM2ZiYjFsY09pMVRXUHc0U1czaE0vYm0zbU00TFkzZVlp?=
 =?utf-8?B?OVkyS0NGbU5jZlRRM0VKc0lQblNXWVEvNVFsNEtpckVrMkJ3d1lqc3d4eTNw?=
 =?utf-8?B?djFQTzAwa2R5RFJ5dUtxbGp0KzRwYkpOOFdsbG50VEhtanUydjQ5c2xXWWJu?=
 =?utf-8?B?WG9ud293VEJkTDlCUE4wdkxqRVQyK25zckpXUXFWdk9BSzI4N0liOEdvTEVw?=
 =?utf-8?B?TnlPejlQaUNEZHdxUHNVSFlyRC9BZFF1dGIycjVicXJPSlFxZG15T1ZPR3R0?=
 =?utf-8?B?eGVHY05kR0N6Y0xaOURsS05Wc1IwbjJnaVRaSGVLdFFQZExFRFZWTG1WRXgy?=
 =?utf-8?B?RmxHYnBVUWRTVHVqSFJBL2s3dHNMWCtOcEtzRFpRa3pyYzdQNFM3T3R5aTVH?=
 =?utf-8?B?c3oveExINGVCWllGL1o5YU9GRTkzb3RXWlpwSHlTYThhME8xcXdkdVAzZXJo?=
 =?utf-8?B?MnY3R2VVbyt5Z3U5STdhU25QcERkVXJrNXpEODc5dWRPNnEzdDlyZDBrV3Q2?=
 =?utf-8?B?YzJ5US9LNjJGVUlWRjByRWdyZHlqdVlKbnFTQy9EWitaU2hMZU10V2RZVzVj?=
 =?utf-8?B?L1kwckNHN29keUtwYk41VFRmTGhnMkprdXFlR1NjYTgwRzhidlpFS251d3ow?=
 =?utf-8?Q?2zsq4962EUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjM5U0REMnhwUHZsQkhHUnNkRzcwV2RmL3FtbG5xVDNheE1YRW1DTDdJYXdk?=
 =?utf-8?B?ZXZMeWVJaStxa2pnWHludEJMRkhYQkJ3UGd4dnZVNkpka3FjL2p1a0IweW5p?=
 =?utf-8?B?dlNnNjJNY3dGWEJVLzZUTk1qb0VmTTJvdC9lYVNjWnRiR2VkU1lFeEdFOWRN?=
 =?utf-8?B?d3pST1ZoWHJyYWpOblA1cFozT3d4a1RPZXh5R0RRUmFrSEZMN0t3R1cvamxN?=
 =?utf-8?B?Y1hmT0VudnJuM0pzTVppVWxkamtaMDR4MVF2d0FLYUxjM3MvbDVSNGk3RXJy?=
 =?utf-8?B?aDVnK3VXN3FjUEhITzVNclpURFRUd29kNDlqRTVQS0N3cHJjQ1ZjblFka1Iy?=
 =?utf-8?B?UHFvMjNxQm9lU0ttYTczWW9XdHVGTzBLY2pGcTJuYXlQWmZSVlBXUmw5amdx?=
 =?utf-8?B?SEF6eG5HVi9VMzVvV0U1NlBsVmdNcCtQaGRtZnVmbXFQeWtqd3N6Mk9kVll4?=
 =?utf-8?B?K09mZ3ltTm51eGtnR3dlNVFxbUh6RXlGYXdSMThhTVNUZEtzaDhCeTY5ZUI3?=
 =?utf-8?B?WHBlZ0RMcjgyT0hzZnpnYktYVGk1TmRreS9pZnBQSHRSYk42dnd6K2RIMXl2?=
 =?utf-8?B?d05OQWx4b2puTmd2d2ZoRHlGRlMvWTg0UTFpY2gydjl0S0xLdkVBcng4RTdh?=
 =?utf-8?B?OUFBeitGSHBQRFZvVWRZeGxhTlZaNy9hQ3NKL1VtTktyblFIQ2V5VExJMFJW?=
 =?utf-8?B?Tm41a1JDR1IycllYME5EMWV5SDQ0SVVtWlhpdDJOV2d5aU4xMVFjT2xmRUgv?=
 =?utf-8?B?TTVONCs0aWY2b2dralFrSDMzU0o5UElraHUvRlltZ3djS2tBdW5lRm9QMklK?=
 =?utf-8?B?bndvSG9LMDNsWGovODc3WmRmUkJqcDk1STNaYnNLM2FldTZxZXFKMURMcS9s?=
 =?utf-8?B?dnNyRTllQUZwK0MwaWJqVlkxV0Y5NktpaWV5bVdPRTR5dmFaRFdZRUZ4OVpv?=
 =?utf-8?B?RE5PSXhnczZUOFVwUTQ5aWp1VEg2dDdlZVFVa0xlRG8xUTJTQWxFUzN3V2ZM?=
 =?utf-8?B?RlhUVTAxYWdKYXZCYURvZVZKcTEvVzlybVUxMmFSMTFJMFIvY203VFJxSHox?=
 =?utf-8?B?MHVUQitObWhWMzk3UHJtR2QwWjJPU0RiL2Y5cUpxbExJMHlVOEh3NTh0ckZM?=
 =?utf-8?B?Ny9BSU9nMXBnc05OVlliS3lnSm9qaDhOU2s1ayt4YkxBbVZhUXBYYkEzbFlQ?=
 =?utf-8?B?c0dVVDE2WllOT1ZqQzdOM1JtZkxCNkNWY2RxeGhwdEFYbjZlRDB4NHZnL2Mz?=
 =?utf-8?B?S2h5YjRSdmJTejFSeGdLRTRPVC9ET2xNVTFobW9XeHFhU3JQMmRKcFVVTk5w?=
 =?utf-8?B?azRwcDNGeHNld0FqNEJ3L0lyS1pkZTYydlUvcjZhMk5FODIrMkZjWkhxVktx?=
 =?utf-8?B?UWxxSXIxZmRCSm1lLzg5WHNDYjBXSCtjKzBEQnFIR25IZUpYaFp0OHdBT1Nv?=
 =?utf-8?B?Z3J4cno1QjZ2S0NjVkhYN1E4Z1hnSUxmT0lZVjU4TzdkVGR0NFFMOVlwNCtM?=
 =?utf-8?B?ZmJ5NEx3OGdRM3NRRUx3N1dBNUlxdTBZOHEzTTZKS3hVRkM0ZEdoeTBZOXVW?=
 =?utf-8?B?UWwyKzdlSU0xUVZDNEpRMU1MMkZ2Lzk2cU5OWitjbHVSazQyOFlxRkgzYWdN?=
 =?utf-8?B?aG1mNElZQ1o3Y0srQ2dyREFrcmxBRUhmUzArVUtsdU9zdXJFWlZkSkIzUkFZ?=
 =?utf-8?B?dHF2SzdJV0QwNGxrdVhpc3JhUTZiSERNQ1lWVGh4alNUVGVqVjNaRDdiazFJ?=
 =?utf-8?B?VEVPUytoM2w4dGtjaG1LRCs5UWJLSTBQYnFqd0JLV3ZROFYvQnBKT3djUkZq?=
 =?utf-8?B?Zzc5K0F1YmdSM2c1bHNxTEJNakcrOVZGQjVTNlB1OFVjKys3ZnJKMDFwTkJy?=
 =?utf-8?B?OFVlMXk5azh0UGJIZ1hJRk1XUGlOS3B1aXM0YjZjVXRjU21xalNsaHBHSSs5?=
 =?utf-8?B?dDduTUF6TU9YZ2lHTmt3WGUrZFZUNWY0amptc3h1UnNRWVR5SUF6WGdQbWJ6?=
 =?utf-8?B?OUgzR1FDazZtVnFyV0M3bmtvY1VnM1dqWEg2K3c5MWt6WXJLdGROQzJIMDBJ?=
 =?utf-8?B?N3VldkdSdnpGd29DZWVWOWd2aXBTSjFDR0xpSHk1Y204M09aRXNObUVuTThD?=
 =?utf-8?B?WmpjTEVRUW8zdzhZWTJ2ZjRRbGYxaTV0eVY1R3BaYjYyMWJuR1JGaWhBQXBT?=
 =?utf-8?Q?zRh9w6YTve7eZhVwib553wA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f533de6-102a-489d-c449-08dde1b69d08
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 20:00:59.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWhxuns8oLgSGngHrK8l2fpcn7hSkqdCjvt5z6O+7KBBXcH1ft0SkAjsxmGQNGax8at3OcW0CxFAvhZT/5ju6jIGGfGUDLT4F41Vj7mg8/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9829

patch 3 (spi: airoha: add support of dual/quad wires spi modes) is
necessary for non-dma reading. This can happen if dirmap creation fails
by some reason. In this case the kernel uses exec_op() handler to
execute dirmap requests.

According to dtb the device supports dualwire operations, so dualwire
commands issued for cache reading. Unfortunately  exec_op() handler does
not supports dual/quad operations, so flash reading fails. Here is the
corresponding boot log
-----------------------------------------------------
[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size:
2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was
not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1,
error -22
[   13.356897] UBI error: cannot attach mtd1
-------------------------------------------------------

If dma=off, but patch-3 is applied -- everything works (but slowly).

Here is a patch to disable DMA operations:

 --- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,7 @@ static int airoha_snand_dirmap_create(struct
spi_mem_dirmap_desc *desc)
        if (desc->info.offset + desc->info.length > U32_MAX)
                return -EINVAL;
 
+       return -E2BIG;

        if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
                return -EOPNOTSUPP;



On 22.08.2025 16:14, Lorenzo Bianconi wrote:
>> On 22.08.2025 09:46, Lorenzo Bianconi wrote:
>>>> On 21.08.2025 14:34, Lorenzo Bianconi wrote:
>>>>>> On 21.08.2025 09:58, Lorenzo Bianconi wrote:
>>>>>>>> This patch series greatly improve airoha snfi driver and fix a
>>>>>>>> number of serious bug.
>>>>>>>>
>>>>>>>> Fixed bugs:
>>>>>>>>  * Fix reading/writing of flashes with more than one plane per lun
>>>>>>>>  * Fix inability to read/write oob area
>>>>>>>>  * Fill the buffer with 0xff before writing
>>>>>>>>  * Fix reading of flashes supporting continuous reading mode
>>>>>>>>  * Fix error paths
>>>>>>>>
>>>>>>>> Improvements:
>>>>>>>>  * Add support of dual/quad wires spi modes in exec_op().
>>>>>>>>  * Support of dualio/quadio flash reading commands
>>>>>>>>  * Remove dirty hack that reads flash page settings from SNFI registers
>>>>>>>>    during driver startup
>>>>>>>>
>>>>>>>> Unfortunately I am unable to test the driver with linux at the moment,
>>>>>>>> so only the following testing was done:
>>>>>>> It seems to me this is quite an important rework of the driver. I would prefer
>>>>>>> to have some test results for this series. Are you able to run mtd_test kernel
>>>>>>> module for testing?
>>>>>> I'll try to build latest openwrt with this patches  and mtd_test kernel
>>>>>> module and try it on one of our boards.
>>>>> what board are you using for testing? If it is based on Airoha-7581 you could
>>>>> use the following repo for testing.
>>>>>
>>>>> https://github.com/Ansuel/openwrt/tree/openwrt-24.10-airoha-an7581-stable
>>>>>
>>>>> Regards,
>>>>> Lorenzo
>>>> What tests do you suggest to run?
>>> IIRC I run all of them. Can you please report even if there are some
>>> improvements (or penalties) in read/write speed
>> Do you mean to run it twice? with patches and without?
> I mean I would suggest to check if there are any difference in read/write
> speed (so yes, you need a baseline).
>
> Regards,
> Lorenzo
>
>>>> I have a single flash I boot from. It have only 2 mtd partitions:
>>>>
>>>> [    2.980849] spi-nand spi0.0: Micron SPI NAND was found.
>>>> [    2.986102] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size:
>>>> 2048, OOB size: 128
>>>> [    2.994493] 2 fixed-partitions partitions found on MTD device spi0.0
>>>> [    3.000856] Creating 2 MTD partitions on "spi0.0":
>>>> [    3.005651] 0x000000000000-0x000000020000 : "bl2"
>>>> [    3.011247] 0x000000020000-0x000010000000 : "ubi"
>>>>
>>>> Most of tests are destructive. So If I use "bl2" or "ubi" partition for
>>>> test, next time I will be unable to boot :-(
>>> yes, I flashed the device after carrying out the test.
>>>
>>> Regards,
>>> Lorenzo
>>>
>>>> Do you suggest to patch u-boot & linux to have more mtd partitions?
>>>>
>>>> This is the results of the only read-only test I found.
>>>>
>>>> root@OpenWrt:/lib/modules/6.6.79# insmod mtd_test.ko
>>>> root@OpenWrt:/lib/modules/6.6.79# insmod mtd_readtest.ko dev=1
>>>> [  159.121706]
>>>> [  159.123220] =================================================
>>>> [  159.129053] mtd_readtest: MTD device: 1
>>>> [  159.132898] mtd_readtest: MTD device size 268304384, eraseblock size
>>>> 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock
>>>> 64, OOB size 128
>>>> [  159.147008] mtd_test: scanning for bad eraseblocks
>>>> [  159.152141] mtd_test: scanned 2047 eraseblocks, 0 are bad
>>>> [  159.157549] mtd_readtest: testing page read
>>>>
>>>> Mikhail
>>>>
>>>>>> Actually patches can be divided on to parts:
>>>>>> * fixes of current driver (patches 1-10)
>>>>>> * change of behavior to avoid reading flash page settings from SNFI
>>>>>> registers during driver startup (patches 11-14)
>>>>>>
>>>>>> The changes are based on the code we are using for more than 3 years. I
>>>>>> adapt it to latest linux/u-boot code.
>>>>>>
>>>>>> Up to now the only known issue appears on en7523 chips only. Here a
>>>>>> corresponding patch description (not added to this series)
>>>>>> ====================================================== spi: airoha:
>>>>>> en7523: workaround flash damaging if UART_TXD was short to GND We found
>>>>>> that some serial console may pull TX line to GROUND during board boot
>>>>>> time. Airoha uses TX line as one of it's BOOT pins. This will lead to
>>>>>> booting in RESERVED boot mode. It was found that some flashes operates
>>>>>> incorrectly in RESERVED mode. Micron and Skyhigh flashes are definitely
>>>>>> affected by the issue, Winbond flashes are NOT affected. Details:
>>>>>> -------- DMA reading of odd pages on affected flashes operates
>>>>>> incorrectly. Page reading offset (start of the page) on hardware level
>>>>>> is replaced by 0x10. Thus results in incorrect data reading. Usage of
>>>>>> UBI make things even worse. Any attempt to access UBI leads to ubi
>>>>>> damaging. As result OS loading becomes impossible. Non-DMA reading is
>>>>>> OK. =======================================================
>>>>>>
>>>>>> Regards,
>>>>>> Mikhail
>>>>>>
>>>>>>
>>>>>>> Regards,
>>>>>>> Lorenzo
>>>>>>>
>>>>>>>>  * Driver compiles without error.
>>>>>>>>  * All changes were tested with corresponding u-boot driver. U-Boot
>>>>>>>>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
>>>>>>>>    additional fixes for continuous mode.
>>>>>>>>
>>>>>>>> Changes v2:
>>>>>>>>  * minor fix
>>>>>>>>  * add comments to code
>>>>>>>>
>>>>>>>> Changes v3:
>>>>>>>>  * add patch to prevent continuous reading
>>>>>>>>
>>>>>>>> Mikhail Kshevetskiy (14):
>>>>>>>>   spi: airoha: return an error for continuous mode dirmap creation cases
>>>>>>>>   spi: airoha: remove unnecessary restriction length
>>>>>>>>   spi: airoha: add support of dual/quad wires spi modes
>>>>>>>>   spi: airoha: remove unnecessary switch to non-dma mode
>>>>>>>>   spi: airoha: unify dirmap read/write code
>>>>>>>>   spi: airoha: switch back to non-dma mode in the case of error
>>>>>>>>   spi: airoha: fix reading/writing of flashes with more than one plane
>>>>>>>>     per lun
>>>>>>>>   spi: airoha: support of dualio/quadio flash reading commands
>>>>>>>>   spi: airoha: allow reading/writing of oob area
>>>>>>>>   spi: airoha: buffer must be 0xff-ed before writing
>>>>>>>>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>>>>>>>>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>>>>>>>>     REG_SPI_NFI_SECCUS_SIZE registers
>>>>>>>>   spi: airoha: set custom sector size equal to flash page size
>>>>>>>>   spi: airoha: avoid reading flash page settings from SNFI registers
>>>>>>>>     during driver startup
>>>>>>>>
>>>>>>>>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
>>>>>>>>  1 file changed, 260 insertions(+), 248 deletions(-)
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> 2.50.1
>>>>>>>>

