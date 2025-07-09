Return-Path: <linux-spi+bounces-9077-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BEEAFE0B6
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 09:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CCD1C27419
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD6026CE21;
	Wed,  9 Jul 2025 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="HmSAv+KD"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023110.outbound.protection.outlook.com [52.101.127.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB4267B89;
	Wed,  9 Jul 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044552; cv=fail; b=f36dyZ79N5sfNknoRRG+mtVPY8dfHPah28DGdeF9IWW8E8/sj5+uYgYBXlruQGTrffwb2UTsTr10AuvuOrdtLddgQ3LBP6M2WVDIioPhtNlKnvukP7mznB3h4XcAmegyBxiUL/tVwiW8SuB1vqeLROJkacMhk4Zwno3mKTobEgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044552; c=relaxed/simple;
	bh=i6l6NfqBFLdvDqNyTh1xoXgF85FgAJuzfIb9DxyPigU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SmEc5XcJi9FYMyl416/JtVziNAaXYaToGvzUye2RptM3G7whmKevYk82dD9H7nl3uwsbdpmYaRnbo2RBwIFKWC3JTs4zY5B5K6gU9ko8waP3ihRdJOoF18/qzscSnUHZL/dUh2btvrAlGhr2rNOszR1GgjnYggFDculsxnMecz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=HmSAv+KD; arc=fail smtp.client-ip=52.101.127.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2ACFfhF7lCCI36TDBNjgWxudY2rOOuHIJ5ug/ORqwKUeTYqcLP02svQ2hk7cHM7FwegbN6sEIdqmbXjrUv04WvdIZ3sOmKN7GD6HF+wxcR+uRZclsp17sAyTc8P/906niDIITKDnLanHlqbgM/J4G3CbL/4V94poVMlNvh98lpSEWdJNBE3Pf1qirbk7QgIAsiOwKBW8YCOPEX8UYgadLxD6wIRTXWgWuHF4cbbTyU1mCrjhYAU8SekzDps+xGuKTd8SGV2HMYmj3Ls1Y4ABBNjKQcsJdYye2TUe6zvFS3kT9rhDaTZOaab/Pz2fpaAxIT23xSLDb5qHY26ycUaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uIVdcNtHVLyebUjc1O9z4mEvpHLHK9lXBQPF+sYWs4=;
 b=xrlR2pUj1jOk5v293MfSp4eDmKkMQkds+0GRClfK7buLPLM1QjkSMkb1E4z2lyV2suciJU0TGzVnqxASyfLFdwC8t2zvupj6z9lA+FbYZchBmMolmqHuEYJMCwYSq9Heq9RXi47/+TZRQdjpkCFHVmVBGGNAyLypPYfbMk1CZcF/p5b60TdRCCW3Mg3y54CcS8tXhj/4uJhIwmLHQ5LS7ojcT6UpfnXu753ZrnYlkYhCzWLhQYBaaNwNW2MsWLYlZGrdvO0HmNCeLhHHU3STViuW2liT+oEbfSwRzKR2GFoq5juXY3N4Y/eJE21zZ0pHK5E6FJpyzXXzx3B64RYaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uIVdcNtHVLyebUjc1O9z4mEvpHLHK9lXBQPF+sYWs4=;
 b=HmSAv+KDcu8vol9cVoyl//S9t6YHNcLCryGwEHCYcWUPTM2RLyv8WioBayw7yZueSGh1kUxk22sosRIlxiSH0dxd9b4Umt8UuUVaiufOvd04Jd5hJci3GV9jgajh+YRNdX+sqxA5Y5XjQYX5VydLQb/0b1UhbVse5Z8JxFYUmSjwwyxqZCdbf+bMG5SrzZ5Ai3JCk/QHLdqyqyx/87rIUaMWLUbtbChugfebx9jXZNM6c4xAoZ6hnoui9qtal8mP226i+ETRVV+A+GCRLLYCxZofAM3hItYgqxTvRkPs+Vq0ovfX+UTc+nOeNzcVPzYpAPEyBCuBcWQirYfPNhgBTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY0PR03MB8176.apcprd03.prod.outlook.com (2603:1096:405:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 07:02:27 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:02:27 +0000
Message-ID: <03b7abe4-95d5-44f4-96ec-989c736e58b0@amlogic.com>
Date: Wed, 9 Jul 2025 15:02:22 +0800
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
 <55ecc836-7fed-44d5-aa4b-94bc17894ef0@amlogic.com>
 <aG0hU5nbjLjTWS6p@finisterre.sirena.org.uk>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <aG0hU5nbjLjTWS6p@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY0PR03MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c9d82a-e886-49c8-56e3-08ddbeb6904a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzJJYXpaNFBhbGhFc3E3WnVTUXpNYU9zMVRBZU9FZUJ6c0dCb0VGbE5kTTJL?=
 =?utf-8?B?WElsRUxOZEpLSlZackcyd3VScDZMRmNkNzllWTJZeHFMSmhmOVE1cEY3R0Ez?=
 =?utf-8?B?cUpDOVlLOHRYTU55eE8xNkJjaGdNS25Pand2c3A4WUNCMWt3ZERpS01ldVlG?=
 =?utf-8?B?bTdXajNETGdIYUpFUjJNckwra1p5c2FsVDJEbllaTjhNeVZueFdCYUErd09s?=
 =?utf-8?B?cFNMZmtXOHFHajV1ckUrSjVuVE1tbUNhZFFsSk9FM3pSV0xNNFRQWEd4NUZX?=
 =?utf-8?B?SGM5TWRmei9GYUllQjk3QnhoNDR6dEZsVzZqZk9WMC9BWExqb0tMQ1c3NlU4?=
 =?utf-8?B?ZXhWK21teDhlYXBybG5XT1JVUU5XcjFlcUt6aHB2empBamdLYWN6bE44YlVG?=
 =?utf-8?B?Q0hvOTRwb0pyVkk4bkxWSGRUM3MwUS9JYTJZT0dyUGhxa2NNNVFhenNRNmV0?=
 =?utf-8?B?ampER0hFbEVPM1k2ckduc1BSelNMZW1wWGN2VzBOS2dNdW9QUk5SRzBySkFs?=
 =?utf-8?B?UG5uRzh5ODBZRDhlRWNocldjR09TQnM4VEgvNGhyOE01UVdSUFVQVG5ERVhh?=
 =?utf-8?B?dG9TVUppamtUZFluS3NGdWdGOUVVQ2N3WXl6VmR6MG1zdG15ODZWT3V4MDM0?=
 =?utf-8?B?WWs2eTJFSXBrUUx4TVEyaGRhZ3FtNnBSYVlKMnJPbFUwNk05dm51aE9PSk1l?=
 =?utf-8?B?Q1E4dzVqeCt6dGYvL0E1UXVXVWcxcURWazJ5YWJYNEhaMHZWZE95ZnVLeVRC?=
 =?utf-8?B?dlY5SWc3azZQajJEMWt2c201UE5JSmRNdUYvM2pSWWZ0U1BaMWQ4Q2dCL2lC?=
 =?utf-8?B?TTFEN2ZZRWFmYVBOcng5S1ZneE0zWjBBSVUxd3VpanpMUFhGZ253aDAzcEVJ?=
 =?utf-8?B?b0Y5ZEo5UXVyRTJEMW1JK3hIWkNINXVnOGM4MzdXZzl2ZjY4eGRmUFhiN2gw?=
 =?utf-8?B?ZnVWUG9odTJlbFNhTlpvNFFnK3FNRitBQTFvb20reksxYjlnN2FDKzFadDk3?=
 =?utf-8?B?ejRWRUROUHNrQ3pOYjZjYnNFTW91Y1U4aFl4WEc1REkrYkwwandzZzNKM0ZP?=
 =?utf-8?B?WVZ5d2ZMOEZiZmFPOEpqcnBhTXBoVXNBZ2hYT2llUUdjT3dxcGhJR1MwdnVn?=
 =?utf-8?B?L1pyTmNDaVhMNmJLSXFDVHV3Mm1wdk1KbU5aNmdRRUFUVHEvS0NpTHlsVkIx?=
 =?utf-8?B?WmxyTkxFMWwzSjRmbTB4Z2Evc0tmb2xvL1BmaVV3eVdkYzN1NlpHaTZWek55?=
 =?utf-8?B?UlE3dU9CenBDRmZJYld0TjAxSkI0di9jd0Y1U3ZsNjlKTU1IbndpOS9ObktE?=
 =?utf-8?B?KzJJQUJHSjNOcFVkQ1MrVEtxdktWT1EzSkZ2MkJtVlF1RzVoY3pHeFdsNWRl?=
 =?utf-8?B?Z3VwZkFiSlN1OXk2aG5HdGFTV0Zqdk5MRDZwTzZyYkFyaDNMTW9SMVVFWlh5?=
 =?utf-8?B?UlZGbVBUR1gwMWZEbkprdEFLVnROWlVnZ05EVHd5SklkYmRkaWdaUFQycHRI?=
 =?utf-8?B?UkdvQzdpVURkemxoWHpVWll5RzJ5MnZxVjBSR1l5RFVmMmROeFBRTEY4MkI0?=
 =?utf-8?B?OG92MFFlRGFKZmRmYzdGNzdEZVJaUm9obVV6NENob2x3M0dNOExxVDZkQ3kr?=
 =?utf-8?B?Q0p3N0haSEVYcUxxb1VpMXJ0MW9qbHlLcHhYVFg5eHUvcXk2Wmgzc0Z6MUE0?=
 =?utf-8?B?aFhJL3Y5RTNXY0lsZHlGQ2lUdEdRY3BPUjA4b0d5ZmdrUmYybXJmOHYwMi9V?=
 =?utf-8?B?UmhjdGozWTh3L0ZnZ0lCb0NiTXdYdzhhYmxSV0VCdWVYS3prS2pHZmFnbTRZ?=
 =?utf-8?B?bSt6Zm1JaERLMStFUE43NzdBTkxaRlJHSVl3a3BHR0JpOXlzSmtsS0RONHo1?=
 =?utf-8?B?SmFYc0xTRFE2ZWc4eENFOVJLQ3duS0I2VXBLdmZyRFI4SEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUUxRHN3aUxpcWpqNFMrbFFuZXk1MDcvMi82VmlJSkZlejJZRVI0bVAxWWZm?=
 =?utf-8?B?YlFPUnFwTFcxeFA4RzhveGhmSytlT1VMVlkzQjd3dTVzdWxLY2ZmTjYvcHRS?=
 =?utf-8?B?TTNmYTZyZDI5NGlveG5MR0d0TXRSYkVDMFNaV09xc0czd2VUUktMVEhJZ2dN?=
 =?utf-8?B?ZldoRys0THZZclJ2RlZFcVA4U3RIbjE0YkVzeWxPbmpNMzJTMlRiWko4VVdV?=
 =?utf-8?B?K1k0UCtNODhsaXplOElBZzZPc0NkOXpUOFBmcTdzanoxdnVyK3EwbEpGZGtG?=
 =?utf-8?B?dTFISkxPYXp0N2c4QnYvZ1R3aTdSS3BlY2t5MG5NL3N4SVNmZGUxNWZ0dEs5?=
 =?utf-8?B?dTBsSS93d1A0NU5Kdm5LdE9rcEhWRnhPTlk2M2RtM1RvVHI3bHg5akJTblJs?=
 =?utf-8?B?cnNXL2NncGFhMCtWcTRLU2JmNG84d1dLYjlXL21zWnEzSWdsNHRtdWo1azRr?=
 =?utf-8?B?OWlRU1RpOXJUODVLZWlGeEtaN05uMjdnM3VPMDlGaWp2VjdTRi8zOVhJb05F?=
 =?utf-8?B?cXV2aStmb1QzcTB1dzU4R1BrTW5HSERWN29jZ3dGNkttZVhyS00vV1FFRE1s?=
 =?utf-8?B?NkhmcS85RVkvYTFpSTIxNnR4aXlOeWlWSDM4bkQvUjhUWVFicjhKaGE4R0py?=
 =?utf-8?B?SytRTHR6UjdwQWd1N01yeFRIdEl1c0puSXI2aDhPYmFZcnFrU1hPcWVRb0th?=
 =?utf-8?B?dFVpZyszbmI0czBnc2ZXbDZWeTBLcnFsUTR4WDNkb2I3cUZZaGo1QmZKVTAw?=
 =?utf-8?B?VHQrRmJ4N21kdnVUT09TcndjaCtoM0tyTVNaSHBTRXluRXZIZHlIeWNFMkd4?=
 =?utf-8?B?WFBMZkJxZWtNMWpRNkFRT0NaVVQrTTlKY3BxZEUzSTFKTnJWM2tHSzdJNkN6?=
 =?utf-8?B?bHZQS01sMzFkaS9BR3lXZTR4TG1xY2pKOHBOSUJEcU54QllTL0tQSFJhUS96?=
 =?utf-8?B?UUVsbVR1SDEvTHE1K1JKTHZ3VmJKZ3VKbmc0K3pSajJocGtybXpjWHlaT0hP?=
 =?utf-8?B?ejlsWDZTVE9yZkU3UUlaSzl6MTF0Q3ZKcVJmb3FxNEw2STIvb1F6QTM0VDB0?=
 =?utf-8?B?elNQV0ZtUmc1ZE9hdnAvY09wOWJKSVZFK0QxTXJoYWYrbnBXMGMyY0JzUk5n?=
 =?utf-8?B?ZUhNZWxsZUI2a0lMZThjSDZhbGNKbXA2Z3NDSEU5UDJCb1dyVUEvT1FjM1Zz?=
 =?utf-8?B?cUpRZVMxMXVESmpmQmZTZkU4bnYzeVBIR0FsUVdCMytqc2l1cnNOTXBMUC9X?=
 =?utf-8?B?czFEajVwd1pocVNqY01RVURmVzlkS2pxQmZXaThFYk56Y2ZqYVcxN0t2cE9Z?=
 =?utf-8?B?MWVkdzQyckswZ29hakV5bHM4KzRaS3ZzbG9JQ0tsNEZNOTRKN0wxbXZqdHNS?=
 =?utf-8?B?RExvNXg2YkZlWnMvRlIxc1Zpd3diNnJOMDgyb1FXQllCeWtJcmkydmZIL2oy?=
 =?utf-8?B?dG5CTStkNWM4MkxpNEt0SHRzeHN3cWQ1ZEFZdDRqNHRsUUFBaVlRNWJFR1Ey?=
 =?utf-8?B?dzNmd0xWY0N4NnJJenBoWDBUNmQ1VlBKL2UreVlzdSthNnZ0VHMrOXRIblZ3?=
 =?utf-8?B?eWtJTUg0R3I3N0VwUXcrNi81OW5OeEZoNEZhZWZoRTI3c0xkV01XaVd4M3cy?=
 =?utf-8?B?RU5SYy82L0twR2ZLQjh0NWNRMDNvVXYxSGUycWgya1lLbmw2eHR2S2J0UG15?=
 =?utf-8?B?K25lQ0lGd2hMd29WbUh4UTJjcmhxcWp1ekhILzdIZjZ4MXQ0QUtCKzEzMElH?=
 =?utf-8?B?QkVBMnIwU1BvbmN6SExNb0VGT0RDakNGV1BJVU1LaEJ0RG9ZbC9RSERYVkkz?=
 =?utf-8?B?V0k3SHRmQU5zZnFDaUtxTFZTWGhqYUlibUxaS2tvWlJFSVVYeU9QRzU5RjRU?=
 =?utf-8?B?RlBrQmVxRzRRYTB5OVhxVWUyVGxYazJ6bmNRNEFYaVVKRW1NVUhpb2FpSlRr?=
 =?utf-8?B?TXZYZ0xvMnVqL3dmQ0xBckV5TnZPbzAwazY0SGxPNGVFSEtMYlJ2REwreVdE?=
 =?utf-8?B?S0sxQ3k5S09SMGZ5S2VTaldpZHVmOU56d0s0Y2t0ZGNaYVh5RVNSR0g2aWFz?=
 =?utf-8?B?K2VTWnlhQ1FVaFh3aGN5Yngvc3pIemtTRjlxSUNxUzBMUk0zUFRoTVVSNUtF?=
 =?utf-8?B?L3hXZXlMTnVvUVhSZ2hLdmJDeVEycytxeWMyRDl1V2haTGZVbFc3a01hZ2Ex?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c9d82a-e886-49c8-56e3-08ddbeb6904a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 07:02:27.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdFpgKOD+hZxH3zs6yCWpQ5UifFq0E5cZl88ay5C3fguLQZTcjEquzG96fjdh6PHUbrG07eoYx6wONUGc9u7uSW0admSx5rPUkgorlczflY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8176

Hi Mark,
    Thanks for your advice.

On 2025/7/8 21:50, Mark Brown wrote:
> Subject:
> Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
> From:
> Mark Brown <broonie@kernel.org>
> Date:
> 2025/7/8 21:50
> 
> To:
> Xianwei Zhao <xianwei.zhao@amlogic.com>
> CC:
> Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>, 
> Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley 
> <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
> linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
> linux-kernel@vger.kernel.org
> 
> 
> 
> On Tue, Jul 08, 2025 at 06:34:02PM +0800, Xianwei Zhao wrote:
>> On 2025/7/7 21:05, Mark Brown wrote:
>>> Is it worth having a copybreak such that smaller transfers are done
>>> using PIO?  With a lot of controllers that increases performance due to
>>> the extra overhead of setting up DMA, talking to the DMA and interrupt
>>> controllers can be as expensive as directly accessing the FIFOs.
>> If the data volume of a single transfer (xfer) is small, PIO mode does offer
>> some advantages. However, since PIO requires the CPU to wait in a busy loop
>> for the transfer to complete, it continuously occupies CPU resources. As a
>> result, its advantages are not particularly significant.
> The CPU overhead tends to be higher (you can avoid some of it with a
> dead reckoning sleep), but the latency vastly improved which for many
> applications is a worthwhile advantage.  It tends to be things like
> accesses to one or two registers on a device with registers where this
> wins, 16 bytes or lower would be a common number off the top of my head.
>
>> If PIO is to be implemented, it can only handle one transfer at a time (via
>> transfer_one), and not entire messages (which consist of multiple
>> transfers). In contrast, when processing messages, the SPI controller can
>> handle the entire sequence in one go, which also provides certain benefits.
> It's probably worth adding something to the framework to be able to take
> a decision at the message level, for writes this tends to all fall out
> naturally since the write will tend to be a single transfer anyway.

I will try to add new API message_can_dma for framework, and implement 
PIO for message.


