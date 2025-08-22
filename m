Return-Path: <linux-spi+bounces-9589-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08623B30C97
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 05:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A980F5E119D
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 03:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAA26B0A9;
	Fri, 22 Aug 2025 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Gk63N034"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021137.outbound.protection.outlook.com [52.101.70.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A0280337;
	Fri, 22 Aug 2025 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833473; cv=fail; b=L/oX53oJZ72EhPPcCwDWP+w6MV6WH4az3zy4CMgzSKI5rw/XKTMBPtGxYPwHbsnxk3OWkRXeNhgYOqOoUKrG0CqY8Amf7GrSndfsLSwkqH/3QIR+K60Od5HLIdFzbWzZiEzZrUzHFRhgEN1TuZm2HT5o/gTwWtOkXROG7wwOiww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833473; c=relaxed/simple;
	bh=XfnUU4/HEW4BfGLRmsxO1rC7LuCDXS03wdJcg4A7ixk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nAag2mGI/uG7U3PLjY2SXP6sAlF8d0la1sMuCXrErTkcn+dYZTnRnovgFHXZJAd2XK/FsDLxIpCg+CHJX9F3Zg8aC4qgRr93CToN2HdNk8+z6BJ/SRXAEpYhOZn3bDnS1piEwN4zJmOK3RyybNOCNQgRxAAzNX8Qb1s7rqydwSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Gk63N034; arc=fail smtp.client-ip=52.101.70.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCZhhfrLJxaYYE3ygwV0nvPK3PHKqlimIApbEeoEgC65JcOUyIa5112nvZ91tWYaKGKlVwfJdpWLN+mNOgOdJpOVgFvCLKxkPUBBd1gjg4v9E1GmnnfCd0jyUJqytB+BqQVGGgUgrmNUSVNWrB0D5PyPmmguA/GlVXb7Qx4lljY91qlermDaIye8Lobfs4hvIDVrAJj+15GSq2ThiFyVx8k6xyDyNXuYP4QMKuyZL+hI2nGrQOD2Wvuv/Gn68GG0zRu1cmRYEBUdKplw+qsE+ri/XhfGqT3lfX9ndPIyCU4RjtW1n/z2ptESzDtwhbsSnrtb2KpU69yLGLqZYF4ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7xOSwJphIMsw3CKAft/PT9jaALDWq3FdRhmlz0wJRc=;
 b=iW2crTGCLQbh1NNp6cam32cZqD2Jd/SX3K3rAUKnnOlL6vu+F+rsqz5PEGZ4/8KirrxA599z7m1vxYZf5udYj/1Bga3f+ho9fP03dRqN5mspdifXOoIT80Xgcjgji3dWJJGDbLPwQgvsCq1d8twzSVvUDAOUtQcD2F2Mz6o1wpg4FegQTREV8Pf4FJKnOFXw0kFW5SXCP8iUbSbN7WO1SSlieqnKQ+nxFiPrJNUWG1eAJEzIM+HXbP4TgpaQj7WBCSs5VO1wbwnO1yMFZFSJE3WfxordmaDno75pYTUI+ArBT3kyVA7ILryWNIt4oNjdyG45HQIkYO4CjRVgp0w7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7xOSwJphIMsw3CKAft/PT9jaALDWq3FdRhmlz0wJRc=;
 b=Gk63N034hpGmVyFl+e30mmyxGYM2fLPMEEQLVAMcqWy5RfmybgERk8US2twSQga3aOjhIK/OQvOCqmhNKQmlXJU78zzToCjY5TpCTSo9U1y8TM4E066OAKSsX0mrONJZi9R4W+Vzz2KfoR7UMqw4gVR0oz8paHwkAibricxzhYOIdiaVr3IS4XPnNUIDobgMQZDIEEAly0St6QHLq00bnG/9HetxgAb4Z9BzNvLgCq1/JJBwW2k1pYmDQbrLArXpF4+L/aB9P1nL4TwEbwqk5lmsY09JIjTZ5LIf0nyL5sA3//IiTmAxBUqIJycv9asjlSISSfspIk6yLUhs5mgzjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7399.eurprd08.prod.outlook.com (2603:10a6:10:371::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 03:31:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 22 Aug 2025
 03:31:06 +0000
Message-ID: <eaea681a-cda8-4066-a58b-61a35e2b8b55@iopsys.eu>
Date: Fri, 22 Aug 2025 06:31:03 +0300
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
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aKcEYn_hX0ZIusne@lore-rh-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d02e80-025b-474b-5465-08dde12c5429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnN0b25GWWtlL0M3b2NWcmswckp4TjhiRmUzc1NBSnE3US9ycmJqYWV4a0da?=
 =?utf-8?B?d3paWnFOa3F0Njc5ek1HZEJHQ04vblBTNjgybEQxUWFBUmlCeU9MbzloQnpl?=
 =?utf-8?B?VGc1VGJnWlNwajRtejlPOHF0OWp6dTZpSzdtUWpDVHllbE5LR2tZeG8wdkVY?=
 =?utf-8?B?QXZNa2hSTTdlMjVtdnVQanFUcEVwR2gxUXhydExDQ1pWSmVqdERtbTVmMWly?=
 =?utf-8?B?NXJKY1V2ZWVEbmFQblltNlBGY3hzaGZSeXlFdkliM3hzN3BTOC9Pck5QekpN?=
 =?utf-8?B?SDI5WWorVGpZT2ZlWjdrYkdVbWttVHFRSmJGcnNFY2hyRFpEVHBSdXQ3YlVp?=
 =?utf-8?B?MkxycEFQT21XclN1NkNnaDI2WEgrdjB1YjI0emo2S0FpaWRJV3Fzb09WQUY5?=
 =?utf-8?B?WkloRmhIOFN6NFF2QUhZNVgzLy9DcDluREppcUJLWHdVcHFUZzlBTFZCQ3F1?=
 =?utf-8?B?dys3MysySzhhRDQzemZJSnM2Z0xKclZDVFA2c0p3Z3J6Z29QTTh1aDBwek51?=
 =?utf-8?B?dExEZ3ZtaHNjVkJFVmhrMjB6UUNNVUYvVjhPYTQyZkM5Z0RDUk5UWktsbEgz?=
 =?utf-8?B?R1ZzQ3hJMHNKZ2hSdEhHZnpwT0k0WVc1NUpiU2dhSnREeWhzNno1RVB1YkxT?=
 =?utf-8?B?YlAwckVIeFJvNkt2OU94OURDR3lCUDdyamJPaFlhMkhITlNmU3ZsVE1sSGt5?=
 =?utf-8?B?NHVBamZ2T1N6VmtKV09lN3VHK2xFT0tXQ2ZhUUtoT1ZVbXlZbHBjUCtYdkE1?=
 =?utf-8?B?aGFjUzBadGdlM0FlN1V2OHg0b3VCdTJzanFSNGVHanlmc2p4NmNvRm9vYjlU?=
 =?utf-8?B?N2dnZ1B0RmJHaHVZNlpHOFRCOUZCSEZOcTVlZmxUUEYrV2QzMXFycklLWC9W?=
 =?utf-8?B?Q01DSGJYTjVKN2lVNTJJSktlOE1pUkMydEZ1azVJdWRGZkVzZkQrNWNXNW93?=
 =?utf-8?B?amxQeE5Lblp1SXVyTWNQODl4R0o0bHdtSnBidk1NUnVYVWs1WUpGVUJHREp6?=
 =?utf-8?B?OVJZL21pc1M0NFVHaDg3YVhvSFJadkZWZGdkak9lWUNZaE9GK3Zlenc0YmRx?=
 =?utf-8?B?Z01CTmNmZWVWYTIrNlJYK280NnQwNFFvMmgrUDdETFNOQVVpZjFPbXpQMTRH?=
 =?utf-8?B?NEgzb00wM2hRMEFQbldLOVdQQlFSL01lVWVmaDI4RVgzZ0tET2JoMFM2YWNq?=
 =?utf-8?B?R3BzdWl4WWdSU0liRnFab3JTT3hIaEFTSE4yTUFuSGpwZmpwTGI5alR1aU9u?=
 =?utf-8?B?N1BmalVVKzNoVEt2TWhEczgyNzIrMW1XeHlhUllaTlFwQlVXLzNYWUpqWGlM?=
 =?utf-8?B?WmxiTXVCT3hVRmpwWEF6YnRDcno0UVdweWVSQjhCdzJNdE1oaURYNWFQYTVx?=
 =?utf-8?B?bFk1M0tuc0ROcWZ6UWlwaXNUeEJteDF2MlgyWW1HRlVuUTNaZ0xBVHI4bzlu?=
 =?utf-8?B?VkZRazByUXlVWlhOYkc2WU01VDl0R2RlWWpFZGhiZ0RMMXI0YWNVRjVZQWZW?=
 =?utf-8?B?TlI4bkcrenljelFuYk40ZnptR3ZWbkU0YW5DRmx6OXFwWjlRTWpVeU9GMHhl?=
 =?utf-8?B?eUY4cDcwRE1KMkZiVnAzZnNUZmdSVW9SNlNpbDB4RXc3UjRCUVZiV3EvcDVL?=
 =?utf-8?B?SlNJSjhzTzJXaE9oSlJYdkNhUVRJK1FWdmc1R3JtSG4vYUVOcVc1b3dEMUNu?=
 =?utf-8?B?M0JuZC9VNWlqbkJxT0lYZ2J6bklHV3U1cm5JVU1FS2d4cnBuOW8wanRvUm5K?=
 =?utf-8?B?cy9ualFtSC92OWJsZHJBRDVDa09IajgxbmJSWDFSUmJxQzBmaUVhQ2ZrTTdR?=
 =?utf-8?B?ZzdZR1YxZThqS2lMT21zZlY2T0ZmOTNwNXVGeUh2YlIyRFRhNjF0NmJQVnNM?=
 =?utf-8?B?OVpVQUFDdVJqcXg1YVNOSkxCc29wZGdtZzVOTlV1Rk41ajUzdnFzd08xdmZU?=
 =?utf-8?Q?2Hb606zltYI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WExMbXpqNXp2WkNyZ2tEaFRlL3JwMGhhQ2lEOXRKdTJrTk5aTFpETDlpRTNl?=
 =?utf-8?B?YTkvQ1R0M2YvNW4xQkR0RGJObit6aGVuc3JxTVZabEpTc20vanZUSFdhczQ0?=
 =?utf-8?B?Q0JQSStpQmFlOTNGN2l4c1VLVEFZczBBN2JZNkhCQUwzOS8vbVJDUkg2YnBE?=
 =?utf-8?B?ZlBvV3ZyOUxGOVoxS3ptMnhBOGJMWmw1Ky9pSktxT2F3SzBiRzJhK2p0VXBT?=
 =?utf-8?B?WXdyTWl3K2ZGOE5lb0lkRGxmTWR3ZlN0ZCtRbGZNL0RlYzUxWnRrQzdNMHl2?=
 =?utf-8?B?UWtkMXhuM2J6em5Dekhia1ZkY1IrYzRXdWhENlQyaFIzbSsrMG44TUorOUVI?=
 =?utf-8?B?N3MrRE50K0kxN2k4d0dCTiswR1JuTEFvaU1CbmhqTCtHYVZCaWxDTHhXK09M?=
 =?utf-8?B?ODN0djVtTkorL2FLYnNocGNLcVRLdnpOUXVkOUx0bTVLRDVVZTFWcUEyNXVN?=
 =?utf-8?B?a0pjVDZTdjhrNCtyYXNBUm1XWWtHNGczY0ExN1hoS1pwTldOTGNUMG4yUytO?=
 =?utf-8?B?WTZUaE9IZ2JRQURWVHdVYWttNzVvV1gvWXhhd0RCdUVHTDd2d05ybjVIZU1M?=
 =?utf-8?B?WjQ0M1dMUm56ZEZTWHFPaXQ2YUt4MEdRWWRmblBUMnpCcHd0REEvM2Y0Y3BF?=
 =?utf-8?B?MlVzdkNtL29SaHVuMUJxMGVoU3pYSFZCV2grNFVtbmxodE1BL0JJMnpjaFlT?=
 =?utf-8?B?ajJqMkdoV01Ibk51bDUyN05mMTFwY3UrTUpxbmNwejBFdlJzd3hFaGo0eVFs?=
 =?utf-8?B?UldxVm9jRFVnc1lrbHVPS0ZiSFA5U2laNUhzc0pydjFaRVdSSkNEK0tZcmlh?=
 =?utf-8?B?MXlydmp0NWk0Rkd5RjJMdU12U1B3QlFtbTk5bTF1REJjT0Y5d3E5a1VGUUNs?=
 =?utf-8?B?c2d0SFEzM0NmTUZtZXl1amplb2h2TkRia1djaE1vbHN3TWs5N1QxZ2VUTTk2?=
 =?utf-8?B?YUUzcTBTVko5aHNtdWxhWmtLT0hjMkRDQnZaOXRSNmxQYnJBSWtQT1R3NjIv?=
 =?utf-8?B?UC9UWUJDWitXUUl6T2lMbTNZTm9ld1UyampveWY3WWZ6QzJDWERKekZQMitn?=
 =?utf-8?B?WG1RclQvNDUwM3pWeml3UmhmUWZjNVg0cUNkUGs4L2dSMFo5dU1PMjkydlJ6?=
 =?utf-8?B?bjVQZWtJdVQ1Y09PL0FUbEdqaGduL3d2ZzBORFNYK0ZnRFN1UXNOemdPMzU3?=
 =?utf-8?B?bEw1eXBObGp2SXcvQTZjdE9aTDhleURUL25DamFsM2N6S1hoWTY0emgxck4x?=
 =?utf-8?B?UGp1ditjVkI0NStXUkxyU05Ob1h5dFJZbEtJSTUyZ3l0Z0s0ZSsxNGRKUTdL?=
 =?utf-8?B?Y2ZCZjVTckxEbWZ1Qm1PZURlRG1SMG1MdGs3R3U3RGprZHhvMVI4eUZzdUJW?=
 =?utf-8?B?UjBGczk1dFY1RFhDTW85em9uSnhIdTFWMm1qdDYrUFc0K2VLMXNTN09XZUhF?=
 =?utf-8?B?NzRtdm1qcjBaR1l3MkVjRGtlVThXbzV1MmwyK0w1eUhDSVpTY0Z4WldoeUE3?=
 =?utf-8?B?aHpBUUZHNVM4RzNuZkJIVHNTVXVDcFR6Z050bCt2WnlWNjJza2pIQVRDSk95?=
 =?utf-8?B?M2p1T3p1YUFQdUg2Z25USHAwdHNYdjZDYzhSenprNzlMYUk1SGRjQ1F2cXF3?=
 =?utf-8?B?TFptMkR6VTVGd2lqQmdiaDN6NzZRcVZZdytUWUVLSkI5SXVWYVA4L1A1T2FI?=
 =?utf-8?B?Z1o3cnJySS9HK1hmRUpSVTExSmZqQ21EUGZWUmNCaHpFYmtGTUIyRS9VWHg1?=
 =?utf-8?B?NTBWb0dZbUlOVWlYWThFaG9QR05ZT0xQYkJ5eG5KRHBPY3ZnUEt4T3NOTmdj?=
 =?utf-8?B?MFdPRlFVOXpxS1podStoRUNCQWZrcTJ6TUc2SmZSZTNRYVMrTUllcU4xN1Nr?=
 =?utf-8?B?bFF0bTdMVEY1OTlsSzFaS2MzNCt2VGd1UncxZHFVWHlZSUlRYnNlcXQ5TFhT?=
 =?utf-8?B?RjlTR0FrajhzMXI4aUVLNzdua3JEMG9wRjJWSVpCdi9jL3k3NXhoRXZsd1FH?=
 =?utf-8?B?RjJNZzJTaThsWGV1TjRBKy96WHFCZ2syaUZlU2dqOWdndEM0a0wzWG9VK2VQ?=
 =?utf-8?B?UnlRaGo1Q091Yi8zbkR0U3UvVDVNbGdGNHV1WVdCcnBybnJHVnQyQlNFMmZw?=
 =?utf-8?B?ZUFsbFBRZ0V6RS9TUjloVFpTMFNsZEw3WlFwQnljVGlYeHlBTVl0d0lvcmFq?=
 =?utf-8?Q?aKF1Guj75YRAUi0R8M5TQA4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d02e80-025b-474b-5465-08dde12c5429
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:31:06.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g07MksaZQZfQskSiBTYglKSBIKYNYyuJ/NhwRcEjzFzGIpBK7aXRMpdAoqOTDxxlXMzo7zDBwILeFqpJj8cJP3ZjaqArm/Mo9baGPXHZQak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7399


On 21.08.2025 14:34, Lorenzo Bianconi wrote:
>> On 21.08.2025 09:58, Lorenzo Bianconi wrote:
>>>> This patch series greatly improve airoha snfi driver and fix a
>>>> number of serious bug.
>>>>
>>>> Fixed bugs:
>>>>  * Fix reading/writing of flashes with more than one plane per lun
>>>>  * Fix inability to read/write oob area
>>>>  * Fill the buffer with 0xff before writing
>>>>  * Fix reading of flashes supporting continuous reading mode
>>>>  * Fix error paths
>>>>
>>>> Improvements:
>>>>  * Add support of dual/quad wires spi modes in exec_op().
>>>>  * Support of dualio/quadio flash reading commands
>>>>  * Remove dirty hack that reads flash page settings from SNFI registers
>>>>    during driver startup
>>>>
>>>> Unfortunately I am unable to test the driver with linux at the moment,
>>>> so only the following testing was done:
>>> It seems to me this is quite an important rework of the driver. I would prefer
>>> to have some test results for this series. Are you able to run mtd_test kernel
>>> module for testing?
>> I'll try to build latest openwrt with this patches  and mtd_test kernel
>> module and try it on one of our boards.
> what board are you using for testing? If it is based on Airoha-7581 you could
> use the following repo for testing.
>
> https://github.com/Ansuel/openwrt/tree/openwrt-24.10-airoha-an7581-stable
>
> Regards,
> Lorenzo
What tests do you suggest to run?
I have a single flash I boot from. It have only 2 mtd partitions:

[    2.980849] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986102] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size:
2048, OOB size: 128
[    2.994493] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.000856] Creating 2 MTD partitions on "spi0.0":
[    3.005651] 0x000000000000-0x000000020000 : "bl2"
[    3.011247] 0x000000020000-0x000010000000 : "ubi"

Most of tests are destructive. So If I use "bl2" or "ubi" partition for
test, next time I will be unable to boot :-(
Do you suggest to patch u-boot & linux to have more mtd partitions?

This is the results of the only read-only test I found.

root@OpenWrt:/lib/modules/6.6.79# insmod mtd_test.ko
root@OpenWrt:/lib/modules/6.6.79# insmod mtd_readtest.ko dev=1
[  159.121706]
[  159.123220] =================================================
[  159.129053] mtd_readtest: MTD device: 1
[  159.132898] mtd_readtest: MTD device size 268304384, eraseblock size
131072, page size 2048, count of eraseblocks 2047, pages per eraseblock
64, OOB size 128
[  159.147008] mtd_test: scanning for bad eraseblocks
[  159.152141] mtd_test: scanned 2047 eraseblocks, 0 are bad
[  159.157549] mtd_readtest: testing page read

Mikhail

>> Actually patches can be divided on to parts:
>> * fixes of current driver (patches 1-10)
>> * change of behavior to avoid reading flash page settings from SNFI
>> registers during driver startup (patches 11-14)
>>
>> The changes are based on the code we are using for more than 3 years. I
>> adapt it to latest linux/u-boot code.
>>
>> Up to now the only known issue appears on en7523 chips only. Here a
>> corresponding patch description (not added to this series)
>> ====================================================== spi: airoha:
>> en7523: workaround flash damaging if UART_TXD was short to GND We found
>> that some serial console may pull TX line to GROUND during board boot
>> time. Airoha uses TX line as one of it's BOOT pins. This will lead to
>> booting in RESERVED boot mode. It was found that some flashes operates
>> incorrectly in RESERVED mode. Micron and Skyhigh flashes are definitely
>> affected by the issue, Winbond flashes are NOT affected. Details:
>> -------- DMA reading of odd pages on affected flashes operates
>> incorrectly. Page reading offset (start of the page) on hardware level
>> is replaced by 0x10. Thus results in incorrect data reading. Usage of
>> UBI make things even worse. Any attempt to access UBI leads to ubi
>> damaging. As result OS loading becomes impossible. Non-DMA reading is
>> OK. =======================================================
>>
>> Regards,
>> Mikhail
>>
>>
>>> Regards,
>>> Lorenzo
>>>
>>>>  * Driver compiles without error.
>>>>  * All changes were tested with corresponding u-boot driver. U-Boot
>>>>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
>>>>    additional fixes for continuous mode.
>>>>
>>>> Changes v2:
>>>>  * minor fix
>>>>  * add comments to code
>>>>
>>>> Changes v3:
>>>>  * add patch to prevent continuous reading
>>>>
>>>> Mikhail Kshevetskiy (14):
>>>>   spi: airoha: return an error for continuous mode dirmap creation cases
>>>>   spi: airoha: remove unnecessary restriction length
>>>>   spi: airoha: add support of dual/quad wires spi modes
>>>>   spi: airoha: remove unnecessary switch to non-dma mode
>>>>   spi: airoha: unify dirmap read/write code
>>>>   spi: airoha: switch back to non-dma mode in the case of error
>>>>   spi: airoha: fix reading/writing of flashes with more than one plane
>>>>     per lun
>>>>   spi: airoha: support of dualio/quadio flash reading commands
>>>>   spi: airoha: allow reading/writing of oob area
>>>>   spi: airoha: buffer must be 0xff-ed before writing
>>>>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>>>>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>>>>     REG_SPI_NFI_SECCUS_SIZE registers
>>>>   spi: airoha: set custom sector size equal to flash page size
>>>>   spi: airoha: avoid reading flash page settings from SNFI registers
>>>>     during driver startup
>>>>
>>>>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
>>>>  1 file changed, 260 insertions(+), 248 deletions(-)
>>>>
>>>> -- 
>>>> 2.50.1
>>>>

