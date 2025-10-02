Return-Path: <linux-spi+bounces-10430-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C110EBB4383
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC63BB7D0
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71AF76026;
	Thu,  2 Oct 2025 14:55:54 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023074.outbound.protection.outlook.com [40.107.44.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBAC3C1F;
	Thu,  2 Oct 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416954; cv=fail; b=KhMr2p5jCHamyf7Y1vdOl6vMNPJJLbRv4SOGjCMOfmyqNO1NhlGb6whq/9ULio2JjfBRN27dG2GFiceHbmQFr+X1OWo151RIfyDxuAkLU6Gl6spyH5rms4MpBtG9Sl63TVjLxap54EUzHdc5kStk/U8/6wIDTantXeSZCb8Owjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416954; c=relaxed/simple;
	bh=G6IVDvxujK6gPFs4a3gntRWrDZ3fpr3YEiYDAgV59hk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lCsahbpZ3FEujrTRPoJhL6OfYOik+fD5UsfnvHyn8JVA++b+QNF+sa8lxCmrBwqwYE70Rpq4PTsXmNYnnXdb0tbAgvvMN1BajHLL47OpqpcCUlja8WigaRy6npvPOrkDG6hAq/a3GNXCsfTiCLNcuMqFdNKPMVnme0IXaGXv3ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWip7l4D1wW67HaxqBccfAIzW5tthPjXMS4Ucvc9OJEjPx4/0tP/yXLOjD4U+zUFHdNpntIpCCgqH/OqpSNPWV27WHLGM1kb8+22ehS0wNzCNprWHbINxwNXrrS+boEaqniEm4lDcoH0p5FwZQhSSGfvgizd6UUwQUQJ07EdoZwA1GeoCBk8gnwHFDp6YTfmd8RjjAITwL3lssliU8el4FgrxSjkC4uK7AwRXNJw9OeFYQ6BMf9AhfHUbI+pzpKk0jFNTPahpCMSPBaP/KFT4/maf0ju/nee2FR2Z4C/m+KaUnYPU+VaBKYEM6eoEKoe6mfzjgfLwAJnzUC7BZknJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6IVDvxujK6gPFs4a3gntRWrDZ3fpr3YEiYDAgV59hk=;
 b=I0agdirE8TqoGsoHBlK9Gqq7W7HIn5nVID2sMrQKULY/AI0FtII8ske/3I9fMHgqAnItgdgL8C4ytTiGRbUv4n2hrCbSnmNmwpe80n3zxneEFdW6lBk+RLAOF/8V5INIoJmHAvC2OSS7yqAPiuRB1RLYBdeGfOU4vHcEji3vtSA31PtzvJ6Bt7cfyldy8kRisoKBsos3wAEHZlfXPrlwcCJJihw86uy8O7luT2S5TvgwUytz9isEILmFGa19gM5r6R4sip+f3K+4XoWXMHBnKMFnkduY0WmpdaMgD5+Keym42otJGDszCE5BtyvLWN6on0df8yClg49i1qmVXlylcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SI6PR06MB7104.apcprd06.prod.outlook.com (2603:1096:4:247::10)
 by SEYPR06MB8121.apcprd06.prod.outlook.com (2603:1096:101:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 14:55:46 +0000
Received: from SI6PR06MB7104.apcprd06.prod.outlook.com
 ([fe80::dd63:8fb9:b9d8:2887]) by SI6PR06MB7104.apcprd06.prod.outlook.com
 ([fe80::dd63:8fb9:b9d8:2887%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 14:55:46 +0000
From: Jun Guo <Jun.Guo@cixtech.com>
To: Conor Dooley <conor@kernel.org>
CC: Peter Chen <peter.chen@cixtech.com>, Fugang Duan
	<fugang.duan@cixtech.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IHNwaTogc3Bp?=
 =?gb2312?B?LWNhZGVuY2U6IGRvY3VtZW50IG9wdGlvbmFsIGZpZm8td2lkdGggRFQgcHJv?=
 =?gb2312?Q?perty?=
Thread-Topic:
 =?gb2312?B?u9i4tDogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IHNwaTogc3BpLWNhZGVu?=
 =?gb2312?Q?ce:_document_optional_fifo-width_DT_property?=
Thread-Index: AQHcMd/HxJ4R705/TUewPHUL+nQ7pLSsEtIAgAE3OfqAABL1X4AAOtuAgAFVqMQ=
Date: Thu, 2 Oct 2025 14:55:46 +0000
Message-ID:
 <SI6PR06MB7104EE73D71E41A31B53E7F3FFE7A@SI6PR06MB7104.apcprd06.prod.outlook.com>
References: <20250930075644.1665970-1-jun.guo@cixtech.com>
 <20250930075644.1665970-2-jun.guo@cixtech.com>
 <20250930-vocally-closable-136829bc9fed@spud>
 <SI6PR06MB7104F6012ADAFDBC7D553F9AFFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>
 <SI6PR06MB7104AE0345763471E67CD3C0FFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>
 <20251001-simple-conclude-d9cd153cee3c@spud>
In-Reply-To: <20251001-simple-conclude-d9cd153cee3c@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7104:EE_|SEYPR06MB8121:EE_
x-ms-office365-filtering-correlation-id: ad2fc45c-054e-4b5b-b1fc-08de01c3c4e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?azRkWHJEM25JSHFUMVZFaFFuWm93dkdoK3BGN3FKblBZT2QzTjltclVEL2lu?=
 =?gb2312?B?ZVh6L0ZBRWpETHpZekRWZ0lIYTJVSDNYTkNyVjlqWFd5NElDcUwrOXJMRCtt?=
 =?gb2312?B?cU0xL09HZWhpYU5KVnZIQmQ2MFAwODFBc3NtMG5ucHM2cFRUaWRRME9nM3pB?=
 =?gb2312?B?cklrZ0lFeHU4Qm9oOUo5NElHdlQ4Rkh4KzVPYmxWYXhoRjVIbWxIY0djVnNC?=
 =?gb2312?B?UU9GdjJFNEt4c2c4WlFBSXlJWTVsSGhYYnowTXkzcDJaaityN1c3TVVQbWFt?=
 =?gb2312?B?Qzg5RlQrdW5ER2dRN1lET292dXdzcnA4V05ld0w2bmo0UmpjMzBCMnFlek1U?=
 =?gb2312?B?VGlnNEhnb1ZDdTJmUXdhWUsvd1lDTUVHZ3RxamVzbkRTZnJrV3hVMS9Rbm14?=
 =?gb2312?B?MXhNTGhoVmEzMENldFpNejAvK3AzdExlYjBqeEZlVW1BT3lLc0ZsRlN2eHMy?=
 =?gb2312?B?NHFQRDFQUkh5VlVNbFJRL3VIczVTNE0zenRlbW5VbkhSUFJYYTExWXB5aFpq?=
 =?gb2312?B?R1ZHblRIaEIvR3RhSlZPMkRjSDViRGZyZWRjcDQzalNvNG1ZdU9ZM211d0ky?=
 =?gb2312?B?Wkp2eUNpWU1pM2c1VEdSczcxODRRRnJZekdzQjhyZ3UxbHZWaytHeXZ1ekky?=
 =?gb2312?B?Y3d1OEZzTkhVN1F2dmE1aU9qT3hMV05FcXBPOGRGQlVtSTR2b2tDb2Ywek5q?=
 =?gb2312?B?cTlwV3ppb283L0VVcVRZOFpLYmZCREFtUDRTRlNiMlE2WW4wMGhUOWFONWN6?=
 =?gb2312?B?dTFNUVhmY0ZxUnVnQzFGTS9ZWkZMVUgzd3BhbUhTOUZlNXBOTHMvdXRLckdu?=
 =?gb2312?B?WGxMNktBb2ZZalVFSytMWFdxQW1rd0ZWT1VuSzJHc2M5eDd6Skp2eUhETmtH?=
 =?gb2312?B?THR5R1grSkxMVURpY2hiMWlPL01CeUhPM1VoOEVSenkxRjRPUmNiTGNuUGl6?=
 =?gb2312?B?cXB5bTZwbnZnRlNBeGFBUjloSGQ0NzNxUlZUWEpKOXdzbmxPSVJ6ZE1BSXpO?=
 =?gb2312?B?K2RkQnFNUnVVM2VNSlFGNTEyOVU0S3pkcTRtazVqU2VEVitNbUhaZXNEcDIy?=
 =?gb2312?B?bGJjTzgyMUFKbDV0ZGdncTcvWEgzSGVmb2trRHpQWWVZRHlrRVpJcXhwN3JI?=
 =?gb2312?B?SjUxODJmK2FCTldIeWhEZHZ6MFh2bWMxdlJKM3QxSWxYY1dkUHFCeENTQmlq?=
 =?gb2312?B?L1FrbER0Slc5V3hMRE00NEtkSERVQ2lmMDczVXpiT3BiN0w1dTJCQ1I2UUlu?=
 =?gb2312?B?T2xKd1dFM3dUK3EvMkZJbXNkaWpUemd1Vis5bVBLVnhicEdiQXYyT3AvSC9H?=
 =?gb2312?B?aVdFU3NXOU9uRiswK3VQMXdvVTVjQXlrOVZkMDdwSndQdzBWSmZsY0dsNzZu?=
 =?gb2312?B?dWRoeTUyenNwMlVRa2NEaUVFaERDWHdMY0kvcnB2dHVVRjl6SWx1NkxtaDNH?=
 =?gb2312?B?R0d4QTMzSU05VWFBcHN4UGRFaE9wU0tjcnFKUHhFbEpPZ09sZm5LUHZMYzlN?=
 =?gb2312?B?TURTTXRoL0lqMllNcFRDRytObnZlOWxYaGFjcEdNT2k3bitPS1Z4bzBmSnBi?=
 =?gb2312?B?ZHFZL3lab0gxWGw3UTMyWHZrVFR2dTVSN3JnTEZGK0FZSlI2VU55TEN2UExv?=
 =?gb2312?B?SEkyWjdSOWQrdC9vc1h0NC9FZEcvN0ZSUGdNV052M09TMVEzckRrek9LSjkv?=
 =?gb2312?B?Um55T2hSRjVQVi92VTNnSW5GTWZrVkU2REp2alBEQnNyR3RFTnRPUFpmMXMz?=
 =?gb2312?B?a2h4bVg5S3N1dndUWFpjbVpYZUc4UVUyZTR0SnhXRzg5MldqcFRlK3h5Nkkx?=
 =?gb2312?B?TkF0VElXcEJGZlpkb210ejhkeERxbG9rSDY0dlB3WUhSY0pBU2NJTXJHdWZJ?=
 =?gb2312?B?akJ0WDlrSEUwWlR0dUJhV0NGWEpOdGlqUFhsWmtTM0cyTU44RzU4Um40czJI?=
 =?gb2312?B?UE9jbDRUdHREZzVWZ2QrNTBvYmtOTVU3WVFDSVZ3OEFEL2dzancxRVZ4cUxG?=
 =?gb2312?B?MmhJbm9zREtReDFreWxRZXFJWWtKcmRMT0dmZlp0eU9NL0V4YWFYTFVCdnhT?=
 =?gb2312?Q?aU+IC8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR06MB7104.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RTJ2NjVMejdqTnNiaU1tR21XSkwzYzZZZE0yMnZxZWNIbmMva21lMmVRTlov?=
 =?gb2312?B?cGFrZ0Z6eURGOCs5ZG8wdURnRWFUREZYelB2V3dkZGlmUjZUQ1FFQkRWVktx?=
 =?gb2312?B?OXZmKzhFNkQxRHF3UE0vUmNkYnN4YW9jTHRDbjFVUmhKYXVUQThsTnNLQ2s2?=
 =?gb2312?B?V0x1ZmdPSU5nb2dDQVR6eVdMR2t6ODRwSUo1bU5DVXUwa2ViYTF6cHZYVi9q?=
 =?gb2312?B?a0JmRU1sd2h6SjY4aXhYYklqcFUwNUxOeHBuYm80bFFPVFNzNjVQRTl3WUNU?=
 =?gb2312?B?ZExQMnNQV3dZeEVsU052eEtpbk5UUlJrcFd1cFhvNURFVU1jTE41dUlBSzFG?=
 =?gb2312?B?c1hTWStxWWM4UGJrSTd3VXFjMSsyWFl2L2ZLcVVBQ0ZFa2VUaHZMaTJwVTRV?=
 =?gb2312?B?UDFFWFYwMVpoaTdLQUk0aGx3VEZqTm9GVDk2bEJRdE9xTWsveGs0ZW9zQVRz?=
 =?gb2312?B?UTJPOG9TNlg0d3ZScFlxUGt6R3h2UFR1WHVMajcrbmd0V2ZjSmxwclR2dUo2?=
 =?gb2312?B?SGovZEkwVkllZjZVNzAzSHB5bU1xaHJGMjQ5ZFNMRVI3Mk9VVG10Mi9HS2E5?=
 =?gb2312?B?eURWMTdyTkxDTmNMRXlxb3JkNkd5OFJtSDhpMjFIYS9uRmZCRGhjNUM5dnhW?=
 =?gb2312?B?TUNJSE5vQ0RyL0poWWpBMnhYRkw1RU9YeGduM2xUdHl2UVJCZ3I1SUFRTE5T?=
 =?gb2312?B?bTRkMFVhL3RFb2NrWitRbUtJeEFBMEF0anlMRWh0c1ZNYTVIc1hKeXc2WndK?=
 =?gb2312?B?b0tDRVhxR2RYNldBbHhHQ3d5ZDhSSm5aRElNN1N6R3dGS2pRZjVzVmZNMjhi?=
 =?gb2312?B?RG9EM2ZJVnJ3NWpXdm0xcWwzcTk3RkhwdHo4dTRQQ29BeU50OGNuenZ3MmV6?=
 =?gb2312?B?cHNqdlJ0L0Vnc3NPR0hPVVhWUjJXNXdjeTFxQWhOdEpyd2Y5d0xSL3IxK2Y2?=
 =?gb2312?B?VjJDTmNEbDZzNGE4VlhJdFdCQnVzYUhUZGVzVUhidmF2NEFNbVJJRFJuK21z?=
 =?gb2312?B?MDBSYmJlZ284SXhONUF1OHdJK0EvQ2JTWEtKd1NpRnYrenowQjZvQmx2R1Ba?=
 =?gb2312?B?R1B3ZTdFeTlzY2xseU5Mdll1Y2NhQWQzZ3dQUEw5MUxmalU2d1prZ3lFeEJr?=
 =?gb2312?B?bmZJWW1JNmNieGlJK2pPNGxPSWVlMnd0WVMzWUdIMEJ3VDZ1eGJDVXVMNGli?=
 =?gb2312?B?NDlITXlKZTZGUnRzL054NklRTHNIMzcxcnpPdXRNZzU0TEhjK0FZd2I3cGV5?=
 =?gb2312?B?YWVWLytFRUgvTzk4cjhkYkwzK0w3bU9GZFB6Zm9oem1NZHNUT2gydnZPeS9n?=
 =?gb2312?B?ZDdXeVVOM05mY2U2VDZBYnBvSENuc0ZEY2JRR1FLcXJVdXlBaER3Z25JSzhN?=
 =?gb2312?B?cWdQWmpwclB2dUFId0VGYWdsTHkyK2FpcHFydWgwcG8wTDhXeU9IdlhRSzYx?=
 =?gb2312?B?ZkhBbDJ1TGZhUDh1MWNiSEVsVVBmR2kxcVhSOU9WQnN5bUt2Qkx3T2krS09k?=
 =?gb2312?B?UDFqZWFnQ2dqNFc1by9ReXM2ZHgxQU12NiszdGtqT3A5UDg1S3VNRmMzSWtl?=
 =?gb2312?B?RlM3eTdyc2plbE13YmVMRk95bXhuWi96R0VpN1FVeHcvVEJnN3ozYTcyT0M4?=
 =?gb2312?B?SVRwQmtJWGZPeFEyUmc4LzJZdVNwaHpyVUwrNFIxR09DdFZEMTNISXRDL1dZ?=
 =?gb2312?B?MjN4S09BWTVab1U3M090ZEhORU5VVlZqb1Z0bEEvaDBpbTZiYStsZkxsUmxi?=
 =?gb2312?B?dmhWS2JOMjZVZGlKWTdPdHlSaEpNQ2d6aHNnb0RNVHF4VlUrSWZJZmNySDRq?=
 =?gb2312?B?cFJSU1d4cE1oYVRmTklESnYwWmE5Wkd6TXF5WFlwQ09VYnRBZEYzZWVYdzZa?=
 =?gb2312?B?dklrR0dKdDZ2T2Qwa2ErT2JOd0RRaTZUa2M0S1J3dVNQNG5LR2FvZHNEdEwz?=
 =?gb2312?B?UXRxS3k3bHJHMmhXYlZXWUIwdGFCYmRRSWdyVFdnVk5pUGttY3R5K2ZLa2pQ?=
 =?gb2312?B?RGRQeVhBaFVibUtjNHRvb29ZNGkxQTRWQThnVTEwRzRLN1VUeUNEZjM1TUlr?=
 =?gb2312?B?RmcwUUZCT25aRjRYRm0rdmZkc0lFOEZoUURHNmJkTDE3NDIvNVcva1pXck1G?=
 =?gb2312?Q?ba9Q=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7104.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2fc45c-054e-4b5b-b1fc-08de01c3c4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 14:55:46.6301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7L+6przKc88c9u0eisTJf2VCi5vYc2/2TDA7YRBDdTBrFo7vJxXsg4AqkzNCS7GPEdN/jdRD26oKJaO9LCFjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8121

T24gVHVlLCBPY3QgMDIsIDIwMjUgYXQgMDI6MDQ6MDBBTSArMDAwMCwgQ29ub3IgRG9vbGV5IHdy
b3RlOg0KPk9uIFdlZCwgT2N0IDAxLCAyMDI1IGF0IDAyOjM2OjQ0UE0gKzAwMDAsIEp1biBHdW8g
d3JvdGU6DQo+ID4gT24gVHVlLCBPY3QgMDEsIDIwMjUgYXQgMDI6NTI6MDBBTSArMDgwMCwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBTZXAgMzAsIDIwMjUgYXQgMDM6NTY6NDJQ
TSArMDgwMCwgSnVuIEd1byB3cm90ZToNCj4gPiA+ID4gQWRkIGRvY3VtZW50YXRpb24gZm9yIHRo
ZSBvcHRpb25hbCAnZmlmby13aWR0aCcgZGV2aWNlIHRyZWUgcHJvcGVydHkNCj4gPiA+ID4gZm9y
IHRoZSBDYWRlbmNlIFNQSSBjb250cm9sbGVyLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBKdW4gR3VvIDxqdW4uZ3VvQGNpeHRlY2guY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY2FkZW5jZS55YW1sICAgICAgICAgIHwg
MTEgKysrKysrKysrKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL3NwaS1jYWRlbmNlLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL3NwaS1jYWRlbmNlLnlhbWwNCj4gPiA+ID4gaW5kZXggOGRlOTZhYmU5ZGEx
Li5iMmUzZjIxNzQ3M2IgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvc3BpLWNhZGVuY2UueWFtbA0KPiA+ID4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1jYWRlbmNlLnlhbWwNCj4gPiA+ID4g
QEAgLTYyLDYgKzYyLDE3IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgaXRlbXM6DQo+ID4g
PiA+ICAgICAgICAtIGNvbnN0OiBzcGkNCj4gPiA+ID4NCj4gPiA+ID4gKyAgZmlmby13aWR0aDoN
Cj4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ID4gPiArICAgICAgVGhpcyBwcm9wZXJ0
eSBzcGVjaWZpZXMgdGhlIEZJRk8gZGF0YSB3aWR0aCAoaW4gYml0cykgb2YgdGhlIGhhcmR3YXJl
Lg0KPiA+ID4gPiArICAgICAgSXQgbXVzdCBiZSBjb25maWd1cmVkIGFjY29yZGluZyB0byB0aGUg
YWN0dWFsIEZJRk8gd2lkdGggc2V0IGR1cmluZw0KPiA+ID4gPiArICAgICAgdGhlIElQIGRlc2ln
bi4gRm9yIGluc3RhbmNlLCBpZiB0aGUgaGFyZHdhcmUgRklGTyBpcyAzMiBiaXRzIHdpZGUsDQo+
ID4gPiA+ICsgICAgICB0aGlzIHByb3BlcnR5IHNob3VsZCBiZSBzZXQgdG8gMzIuDQo+ID4gPiA+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4g
PiA+ICsgICAgbWluaW11bTogOA0KPiA+ID4gPiArICAgIG1heGltdW06IDMyDQo+ID4gPiA+ICsg
ICAgZGVmYXVsdDogOA0KPiA+ID4NCj4gPiA+IEkgYXNzdW1lIHRoaXMgZGlmZmVycyBmcm9tIGZp
Zm8tZGVwdGggYmVjYXVzZSB0aGlzIGlzIHRoZSBhY3R1YWwgd2lkdGgNCj4gPiA+IG9mIHRoZSBy
ZWdpc3RlcnMgcmF0aGVyIHRoYW4gdGhlIG51bWJlciBvZiBlbGVtZW50cyBvZiB0aGF0IHdpZHRo
IHRoZQ0KPiA+ID4gRklGTyBjYW4gY29udGFpbj8NCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgeW91
ciByZXZpZXcuIFlvdSBhcmUgYWJzb2x1dGVseSBjb3JyZWN0LiBUaGUgYGZpZm8td2lkdGhgDQo+
ID4gaW5kZWVkIHJlZmVycyB0byB0aGUgcGh5c2ljYWwgd2lkdGggb2YgdGhlIEZJRk8gZGF0YSBy
ZWdpc3RlcnMgKGUuZy4sIDgsDQo+ID4gMTYsIG9yIDMyIGJpdHMpLCB3aGVyZWFzIGBmaWZvLWRl
cHRoYCBkZXNjcmliZXMgaG93IG1hbnkgZWxlbWVudHMgb2YNCj4gPiAgdGhhdCB3aWR0aCB0aGUg
RklGTyBjYW4gc3RvcmUuDQo+ID4NCj4gPiA+IEhvd2V2ZXIsIHRoaXMgaXNuJ3Qgc29tZXRoaW5n
IGRlZmluZWQgYXMgY29tbW9uIGluIHNwaS1jb250cm9sbGVyLnlhbWwNCj4gPiA+IHNvIHlvdSds
bCBuZWVkIGEgdmVuZG9yIHByZWZpeCBmb3IgdGhlIHByb3BlcnR5IGlmIHRoZSBwcm9wZXJ0eSBz
dGF5cy4NCj4gPiA+IFRoaXMgZG9lcywgaG93ZXZlciwgc2VlbSBsaWtlIHNvbWV0aGluZyB0aGF0
IGNhbiBqdXN0IGJlIGRldGVybWluZWQgYnkNCj4gPiA+IHRoZSBjb21wYXRpYmxlIGFuZCB0aGF0
IHlvdXIgb21pc3Npb24gb2YgYSBzb2Mtc3BlY2lmaWMgb25lIGlzIHdoYXQncw0KPiA+ID4gbGVh
ZCB5b3UgdG8gaW50cm9kdWNlIHRoaXMgcHJvcGVydHkuIFdoeSBub3QganVzdCB1c2UgYSBza3kx
LXNwZWNpZmljDQo+ID4gPiBjb21wYXRpYmxlIGhlcmU/DQo+ID4NCj4gPiBZb3UgcmFpc2UgYW4g
ZXhjZWxsZW50IHBvaW50LCBhbmQgSSBpbml0aWFsbHkgaGFkIHRoZSBzYW1lIHRob3VnaHQuIEhv
d2V2ZXIsDQo+ID4gYWZ0ZXIgZnVydGhlciBjb25zaWRlcmF0aW9uLCBJIHJlYWxpemVkIHRoYXQg
dGhlIElQIG9mIENhZGVuY2UgU1BJIGFjdHVhbGx5DQo+ID4gc3VwcG9ydHMgY29uZmlndXJhYmxl
IEZJRk8gd2lkdGggYXMgYSBmZWF0dXJlLiBUaGUgY2hvaWNlIG9mIHVzaW5nIDgtYml0LA0KPiA+
IDE2LWJpdCwgb3IgMzItYml0IEZJRk8gd2lkdGggY2FuIGJlIG1hZGUgYnkgdGhlIFNvQyBpbnRl
Z3JhdG9yIGJhc2VkIG9uDQo+ID4gdGhlaXIgc3BlY2lmaWMgcmVxdWlyZW1lbnRzLiBUaGlzIGlz
IHRoZXJlZm9yZSBhIGZlYXR1cmUgb2YgdGhlIENhZGVuY2UgSVANCj4gPiBpdHNlbGYsIHJhdGhl
ciB0aGFuIGEgY2hpcCB2ZW5kb3Itc3BlY2lmaWMgZGVzaWduIGNvbnN0cmFpbnQuDQo+ID4NCj4g
PiBGb3IgdGhpcyByZWFzb24sIEkgYmVsaWV2ZSBkZWZpbmluZyBhIGNvbW1vbiBgZmlmby13aWR0
aGAgcHJvcGVydHkgZm9yDQo+ID4gQ2FkZW5jZSBTUEkgY29udHJvbGxlcnMgaXMgbW9yZSBhcHBy
b3ByaWF0ZSwgYXMgaXQgYWxsb3dzIGFueSBTb0MgdXNpbmcNCj4gPiB0aGlzIElQIHdpdGggZGlm
ZmVyZW50IEZJRk8gd2lkdGggY29uZmlndXJhdGlvbnMgdG8gdXRpbGl6ZSB0aGlzIHByb3BlcnR5
LA0KPiA+IHdpdGhvdXQgbmVlZGluZyB0byBjcmVhdGUgYSBzcGVjaWZpYyBjb21wYXRpYmxlIHN0
cmluZyBmb3IgZWFjaCBTb0MgdmFyaWFudC4NCg0KPkV4Y2VwdCwgeW91IGRvIG5lZWQgdG8gY3Jl
YXRlIGEgc29jLXNwZWNpZmljIGNvbXBhdGlibGUgc3RyaW5nIGZvciBldmVyeQ0KPiBkZXZpY2Us
IHRoZSBmYWN0IHRoYXQgeW91IGRpZG4ndCBhZGQgb25lIGZvciB5b3VyIHNreTEgU29DIHdhcyBh
IG1pc3Rha2UNCj4gdGhhdCB5b3Ugc2hvdWxkIGZpeC4gU29DLXNwZWNpZmljIGNvbXBhdGlibGVz
IGFyZSBhIHJlcXVpcmVtZW50Lg0KPiBUaGUgImNuZHMsc3BpLXIxcDYiIGNvbXBhdGlibGUgc2Vl
bXMgdG8gYmUgdXNlZCBvbiBYaWxpbnggcGxhdGZvcm1zLA0KPiBpbmNsdWRpbmcgYSB6eW5xIHBs
YXRmb3JtIHRoYXQgc2hvdWxkIHByb2JhYmx5IGJlIHVzaW5nIHRoZSB6eW5xDQo+IHNvYy1zcGVj
aWZpYyBjb21wYXRpYmxlLiByMXA2IHNvdW5kcyBsaWtlIHNvbWUgc29ydCBvZiB2ZXJzaW9uIGlu
Zm8sIGlzDQo+IHRoYXQgdGhlIHZlcnNpb24geW91IGFyZSBldmVuIHVzaW5nPw0KDQo+IE9uY2Ug
eW91IGhhdmUgYWRkZWQgYSBjb21wYXRpYmxlIGZvciB0aGUgc2t5MSwgdGhpcyBwcm9wZXJ0eSBp
cyBub3QNCj4gbmVlZGVkLCBzaW5jZSB0aGUgZGVwdGggY2FuIGJlIGRldGVybWluZWQgZnJvbSB0
aGF0LiBBbnkgb3RoZXIgdXNlciB0aGF0DQo+IHdhbnRzIHRvIHVzZSBub24tZGVmYXVsdCBkZXB0
aHMgY2FuIGFsc28gdXNlIHRoZWlyIHNvYy1zcGVjaWZpYw0KPiBjb21wYXRpYmxlcyBmb3IgdGhh
dCBwdXJwb3NlLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBmdXJ0aGVyIGV4cGxhbmF0aW9uIGFuZCBz
dWdnZXN0aW9ucy4gSSBzZWUgeW91cg0KcG9pbnQgbm93LCBhbmQgSSB3aWxsIHJldGhpbmsgdGhl
IGFwcHJvYWNoIGZvciB0aGlzIHBhdGNoLg0KDQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIg
dmFsdWFibGUgdGltZSBhbmQgaW5zaWdodGZ1bCBzdWdnZXN0aW9ucy4gSSBsb29rIGZvcndhcmQg
dG8NCj4gPiB5b3VyIGZ1cnRoZXIgZmVlZGJhY2sgb24gdGhpcyBhcHByb2FjaC4NCg0KQmVzdCB3
aXNoZXMsDQpKdW4gR3VvDQoNCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQq3orz+yMs6IENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4NCreiy83Ksbzk
OiAyMDI1xOoxMNTCMsjVIDI6MDQNCsrVvP7IyzogSnVuIEd1bw0Ks63LzTogUGV0ZXIgQ2hlbjsg
RnVnYW5nIER1YW47IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitk
dEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5v
cmc7IG1pY2hhbC5zaW1la0BhbWQuY29tOyBjaXgta2VybmVsLXVwc3RyZWFtOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBSZTogu9i4tDogW1BBVENIIDEvM10g
ZHQtYmluZGluZ3M6IHNwaTogc3BpLWNhZGVuY2U6IGRvY3VtZW50IG9wdGlvbmFsIGZpZm8td2lk
dGggRFQgcHJvcGVydHkNCg0KRVhURVJOQUwgRU1BSUwNCg==

