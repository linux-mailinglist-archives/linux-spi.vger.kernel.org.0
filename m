Return-Path: <linux-spi+bounces-11513-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1DEC8560C
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 15:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD48C4EBA0E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847E3246F0;
	Tue, 25 Nov 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="OD2Zdw4t"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021096.outbound.protection.outlook.com [40.107.130.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE0E32571B;
	Tue, 25 Nov 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080455; cv=fail; b=VCRsZfjIWuJtazCpBbdOgAUzlu8KY9qXKMbZgxuQWkOl6wTEMDuYpSetOU/dqKuPMG/1jZpp1DHyKPvuCXHiZHTPAonrr8XOyEs298hViez6e77Qi8SuGGUgNo3rAICzE4HOjKVik7AciOw/zgatks9/TQnJ5FBljXoV34gjHn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080455; c=relaxed/simple;
	bh=QaDBgwA/TPTYwqt2HOFPdAMAwHBuGrNUizbJ34A4BbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SJ40g14F6N10HRhmLC8aUO4tzXdzRPpLUieTqTykijutwHJOgoKjts1fWGDmbltMN1vW8cZ/6MiCfxbbPCkPbAdy0DF2hMK7pgrja4/aki3fmCnw90O1+3eaP4+YN+1jhknlahutHU4lOjzn6sUhoJsZWHNVdy7xd3l/1haZYUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=OD2Zdw4t; arc=fail smtp.client-ip=40.107.130.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bbfhn0V/REFdTkmFCGs6AaWMXNxY8WrKNMeRdSA9QNFngoKF2FtyHfLsPLjeqv+7jeD3S3GDRmNJGf+ZMVYK3Q1xXj4ZVCCzhO2LgINnhJ97VaGsSf9JA/BWgrAwhmxqFazY5RNMHONApq+AwKLeRN68TaORDPvDHCijytRxGJwFJN4sE4/8WQpd0+SsQmJPBN+zPe4RXTX4xf2yksghERTnqg46tt6IZWDIDZrrZnuGzzyQBVl2oGuUiYeFeg4+9BztFCOao4S5hw8F8PSXSWFXrUbtPjuozmB/KZMhnsDCbbgbXDXhlaW6pYKVjhH7oqIMTFygrwkPbqyga58+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuwfMRHiRWaNwURAS2rli+12fHBtN8W6Bo97HL3J+aY=;
 b=HXHw2QTDQ8VXm4/ir9hex54o/KkJTuoAG3lAEWFH7nVmi4Cd2LWYnPjVjBkuEOnVLPoYelSjws3qXOv/A8lqtK2rWyOsHRCMZGzHFgUj7w95wkYY//Ty0LPfhyC+vnfiFJdwReUZmeZXEiXJ0JYuVb2MUWv2QbuzVlD9bD9Rcuo69Cduocz9mHt9SWok5iBv/1QX3dcLaTABZyg1uzVsSDQ4UircUFTDDxwbtBtmDl3eJFs93FvRk6VE0id+PwoHo2HhwVWmlTMFPQNGfktk0TKyTrrsNwkQk2v6VkI631AdPfkwiXjoscH+NrnK2rBRTerIedzZicEIedpdCGi5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuwfMRHiRWaNwURAS2rli+12fHBtN8W6Bo97HL3J+aY=;
 b=OD2Zdw4tzekkd8YukJJl3sfgE02hP0STKDM2nVWR1fdDS/pWaVax0an0J8ZqFt6YkVHRde1xofAhB53eDOfcAw52eLpkchvpaW7JYfwgP3/LrW1ySXI8zjPm69RLf/7eipBzKDAGFhFMXXtT5rh35cpNMTWw4CrVedel+zXMuZt7LZRu0dk0qx9ENnTMFC4MrNk2aSPdoJ8UtB2Tp4UzKrEZmqjNCenZy/il4mgUcq/OCtrPZvdCA4ChD162+ARZ4QtozpnmEWCh6gf4yURmGiVdjObz0iCLL2qgnLecEn+OHgChILtRPoiOdwTuwkA3/N3U50E5rH/HGx9WnrmTZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9404.eurprd08.prod.outlook.com (2603:10a6:102:30f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 14:20:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 14:20:46 +0000
Message-ID: <13321124-6b45-479c-a73d-1d9ec9e96f05@iopsys.eu>
Date: Tue, 25 Nov 2025 17:20:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] spi: airoha-snfi: en7523: workaround flash
 damaging if UART_TXD was short to GND
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
 <20251125021051.857159-2-mikhail.kshevetskiy@iopsys.eu>
 <aSVYShXLirW--bYe@smile.fi.intel.com>
 <83a15a9d-8dfa-4949-b483-020bbcf0847a@iopsys.eu>
 <aSWBacH8N5NWO8oV@smile.fi.intel.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aSWBacH8N5NWO8oV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR08CA0055.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::26) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ba4399-b2a3-4812-2f77-08de2c2dd339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDJVcjBCUmt1Z1hBRnErWHJ6RWw3MGdvQm5TTHRvUFFKY3BsUVdaMnJhdGg3?=
 =?utf-8?B?QzUzSkpsOWtSS3hhQVRsTzlDaWE0ODh4ZldyNnp5WHRSUWdGMGdQSkI2OEl5?=
 =?utf-8?B?b2NWOFJOT2xRRWZrc3EyTEdtMjN2bk1SMVJxSjRwL3lIa0ZlR0lIK0d0WkFV?=
 =?utf-8?B?V2tKL1RNaXhKY2tULzd1Vzd5a1g5SDBPZDRVOVdWaGxTVXRmTk95d1hoQWV1?=
 =?utf-8?B?VFhEdUFpcEpRay9QVjRzRWFYdTN3WjE0eTV4RHI1MVM3TGFHSWJyWHdwNE9a?=
 =?utf-8?B?ZTlzYi9mWjI5UTQrYmxROXV2amZISjFBK1BNYTdxRytETG5mV2ttQ0tHdjlP?=
 =?utf-8?B?RlRwV2xObmdLSUpvU05PYVdJY28vK0ZxRFhNL1dlalc0a1g0L1o4ZDhQdjVr?=
 =?utf-8?B?Q2krZGtzcldKTmx4cVYwWlN1WFdXaUt0WFRKMXgzU1ZWV1l3K2RBbVVvdHNo?=
 =?utf-8?B?bXAwNDYrNjhEZ3hiTzVBZmNzYnNOR1hDRnBpOXZjellIRlUrSVJzWWtPK1Qr?=
 =?utf-8?B?djl5M2VoaHZseXRkREwxNjlrYi8rc3h2SUN0VHFsODRZUWxEcEZFOUFqMVFv?=
 =?utf-8?B?ZklNdmRzalRhejE2MC9Edk1LWExhTTZlcUxzM25WQTB4UFBTUEpZbW11Zk1s?=
 =?utf-8?B?T3VhQmY3R21LVWVoQno2UEJHaFRuQ0RiYzlxbldhMXRTa0xONFJkbHVxeFFF?=
 =?utf-8?B?U0l5MzlYcEN5L05PMHpLM1FBY084MnUwTDNLc2VXczZYVlkvczRFS25tTVQr?=
 =?utf-8?B?eUorbkNLdUhESHJWNUVBQ2s5QitudEgwSmM3QUVZWjl5UnQzU2g5MTBIS1da?=
 =?utf-8?B?TFFuVDQxeVNXdURJYytOcnhwTzRyY3lYejJwVVg5eEFNbUswVDh3NkhQYWsw?=
 =?utf-8?B?TWZZYWVhVStaanoxNWtWajNvb2FUQ2ZUQTlXR3IveXdaSTQwSUlKY3BLZkxO?=
 =?utf-8?B?WXhHSjJtSi81NWt5ejUrZnA5akFTU0Urc0YyS1JnYXk0V3hRYmZBM0Vnam1x?=
 =?utf-8?B?OS9YSEdyUytQZDIwVmlXcGRreFZRK2VNUklqWTBEcU53V2EzL1Qxd0FYN2Y1?=
 =?utf-8?B?dm9CMkM2b1VvQTQxZWZLTFJPSVQzTVdEbUN0Q1Q4VnN0eU5QQ1h3TFlPN0tX?=
 =?utf-8?B?S2pVZHBLSTQ5M1NoWjBCSWVWdXB2TEM2VWdrWVQrUmsvTkk0Zm9rUUtwUmkw?=
 =?utf-8?B?SDVPSnhjaGs2aHk3eWNJTWJSOU9YNWg2MjBzZmJHamd6Z05oa2t1d1Bac3Zv?=
 =?utf-8?B?eW5jZHZndEhBai81ZnZwUnB4bGtHdjE3eWVwYnZua05qQTBKUFhYM3l6eXY2?=
 =?utf-8?B?VHdTanVCSStzV3hqS1QyVThyV3FjWWp3SHZPVUNuUEg3cEdobS9WaHp2Y3pu?=
 =?utf-8?B?aFdVZ3RjWGJScGV6RVZmb0s4RkIyd2JXRUVkSW0wSkQ1RHMyQ0o5cEhnaXRH?=
 =?utf-8?B?clM2SGdGbDZMV3dtUmk2ZGFPRGJsUFNHaCs3ZForNDBsY1hLOXQ0Mjc3bHVo?=
 =?utf-8?B?RFE1amYrdWt4NHZDWVZ6S04yckEyV3M4dWdxTEo5V3A3NVoxY2dYZ2w2TXF6?=
 =?utf-8?B?ZVJpN01Yc3V4cXU3cjBoelpqYXJSb1NBdXYrTHJlS2hoUEtiVWQ3eE9mS0d1?=
 =?utf-8?B?REIrWXlXVmYvU2MyUDc0dTd5bkRPZmNrUzdXMzgyekN6K0NDTDJmM1NHMWpT?=
 =?utf-8?B?aTZyZW95U1FsdzZrWURHbjZkZmpWcldyZHhwViswaFRDQVdLaE56czN4QWJT?=
 =?utf-8?B?ZVdRQmtNYXNUN1NGTU5YZDEyOFM0eVNCS3ZrWDVxcjdiS09mTE5qcUp6L1E1?=
 =?utf-8?B?bm1objB3YkR2VDhKemZYZ2pwb2U0YkxQM1FpOTlkaEthWUgrNzdvdCtLVVRv?=
 =?utf-8?B?RTg4ZzVqR3Z6OUNGeWh5WEdFZWFqRjB1NTZRcjVVTUJ0RHBOU3hhSElMdGs4?=
 =?utf-8?Q?kGn4Aie0VZxoA+lsfjIDiG6tHaQdAcOu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekdjZHBFd1dqZnhCTG9pdU90M2dZcDBjVGZuN2hRNC9nOUpCM05FNTFBNC8y?=
 =?utf-8?B?ZzlNODBEa3FiMkR0VEJZQnpSYk1SYW1KeDM2R2k4UWVrSXFlN3VVTXpjSkVU?=
 =?utf-8?B?UEc0N1ZOeGVTN3V1MFJYeVk4bkNYVEhFZVJMSUtiZzY2QU1YeEVaM3dxTlUr?=
 =?utf-8?B?NzJYNzBCZ084MDJLRFNIdmFXZGtWZ2RVL0dFRjlhYUlvQzRHOXRnSlRRbmpq?=
 =?utf-8?B?RXp3Y1BlUndySDF4WFVMWWFSWTRWeG96cXJMc2xJdHJ0N01FWjJqNUdYYXRl?=
 =?utf-8?B?SVZxNGZUMHN3T0pqekplSDlxWHpiTlhyQ0FnaHJsSEF1UVhZbVZ5eVRGSWVB?=
 =?utf-8?B?UFBKbGFabWVzY2Q5MUFOdW5peG1aTUtDZnNHVW9kMTloUWpmQVNEWXdKVGNV?=
 =?utf-8?B?WGg1MnM2dXFqdXV3U2ZRWnBTdTRFYTdvQVZLTCt4MFFTK1g3V1QxemtwdDJq?=
 =?utf-8?B?K3JnUWs0VkJtSnAvUFZQN1JMVUh3VUpiRmdjNWdtem1KbHRuSFBkOENtS2FO?=
 =?utf-8?B?V3dlLzFrZG5CR2QyYlplbi9YMjNITS9MOG1aMm1GR2xOUW1OQkRIcnZtTzlR?=
 =?utf-8?B?aHRYN0g0TWxWSlJuUTJRcFl6a3d6WldZMUtNQ01sK21yc2pUc3pBUDdldTdq?=
 =?utf-8?B?MUJzNG9pTHZtNE5YQ29BUXk3b2dqdHNJMDA2b0h6SDQwbTBjRTZ6eno5QnZz?=
 =?utf-8?B?UVhkZ3dTSzhNaWpleG5KaVl3WVRYRGRtTGdFN3RMQmJLR1Zlc2JTYk5TV2d3?=
 =?utf-8?B?RFB0M2xldTB0ck9jUWk1aTZTeGFCaHhOdzcySEZuc3hndmlPYktxL09TNVEv?=
 =?utf-8?B?aDdweGQ0UzFqUFA5S2YrVWJidEF2bFlWcFE0VFNYaTQ5aTNnalltanpOeXcy?=
 =?utf-8?B?VmdIY0MrZGJqM3NUb1NaT2RPMzZUUHNSemN1aTI2NUVqaERpdTN0cDdEV3JW?=
 =?utf-8?B?T1h6ekwzYVcwZ1ZqcmRVZ1Z0ZTVIRTNZcGFrSkgyNDVsKy9FNGxXQ095aEIz?=
 =?utf-8?B?WEt1TWtMTEZqYnE0REFOdS8vcGdZeVJoeFV5MENqYlFZQWNMVmdXZ2dLMHpF?=
 =?utf-8?B?dVFFRk9MQWJnK3JMUkVEamZiSkJBcWw5MXdsb3JxaW9qdXBtWm9EdEJab0Rr?=
 =?utf-8?B?dHNOdFhERTFqeHU4QUdLYkNNU3BtWWtUcTh6U0IxTHFwRHdkKzUzSlIvc243?=
 =?utf-8?B?MUtVWTdybkVQMStvS0dWVWhZOUgveFo0Q2hKU0JLZVRocVJvc3hTejBuU3hK?=
 =?utf-8?B?bzJjYWpRTlVNSk55VnpQVUswd0xCZUlNMHZEc2daZ0hndXlyNzI1VnZiaWpP?=
 =?utf-8?B?VjBhZVZubHVUQ2NVT1kySGZ3VmRwU1dOTDkyZ245cHRJUU83bWttRFF4Ym1t?=
 =?utf-8?B?RUZiYmljeHBuKzFQQ2hYSWRwKzNlckNSbmhJRlQ5ZVc0aE05RURnMEhtYW9s?=
 =?utf-8?B?MlNoQzgrSzVvV1JFczVTenltOG1QajFkUWRqanVIZjgrUDJQcldDQi9GYTJW?=
 =?utf-8?B?WVFOWlJ4LzJCOERNMEtrZWtqVXdBY0JiY3l5cEQrZmtkWmtKZU1QeGFhZVZm?=
 =?utf-8?B?SVlnSytzc2I2dVc5VkpRampGRlh2dmVIUDBpRW9scW1SeVdmUXZKZ0dQcHVy?=
 =?utf-8?B?SWJvcUIzSTBDUEFMMU5yc3kxa1Q4SjFscVZwY21UdUxTa1ZFZUdnc3pGRkJh?=
 =?utf-8?B?U3pVR2RCQ3c0NUhVbEUydkFiN3MybHEyVitpSG1XbGE0SlBxMnQ1azJBc0hl?=
 =?utf-8?B?UTRBVWZ4WUQrRkc5ZDRoSUZGdGpNWVRIbUdvTkgxeTU2LzdVVGVxdzFtbHhK?=
 =?utf-8?B?T2NsYzBOcEpoZEpxMjZza2RqODRYMHRVekY2UG9vNVVLYVVuYlFBbWdyMkxH?=
 =?utf-8?B?dWhqNHRKSGpmL3ExOTdGNFVjNXBmMS9uR0ZzRzVwMytTZnh4NkwyY3V1b3Bq?=
 =?utf-8?B?Nk8zYUk0RkFUTVJUeGNlU3YrOGVQMWJsWVd4V1oxODcrSVV3QnBwcGFGV0RV?=
 =?utf-8?B?T2k2cnFaSEtsUHFuUTlnbi9INXhGeFMyUDJpNVRVWXU0b0lWYk5lZGVOUnda?=
 =?utf-8?B?aVBpMFpzeS9DUGVVMndHOWhGYnhNTXVmN255OVlUeElQbU04SnROZStUbitH?=
 =?utf-8?B?dWt1T2hrMStYYkdTM1pjdW5RK3ZMelNaMm00d1RPRnQ3OGY2dHlRWmxTTTdn?=
 =?utf-8?Q?ls+6YbmGz1vlOG7Cj0e7jFA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ba4399-b2a3-4812-2f77-08de2c2dd339
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:20:46.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeIv7qQJP0aXf0bAD5Yk2BtOjOuWU4rYZNWYa3R5epNWex76O1/Gxna/iR3uHOIH/D5jYjOk7ub/Q6SkeuJt98MA7yVPMNW8yPbhzTHsWdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9404


On 11/25/25 13:14, Andy Shevchenko wrote:
> On Tue, Nov 25, 2025 at 01:04:12PM +0300, Mikhail Kshevetskiy wrote:
>> On 11/25/25 10:18, Andy Shevchenko wrote:
>>> On Tue, Nov 25, 2025 at 05:10:49AM +0300, Mikhail Kshevetskiy wrote:
>>>> Airoha EN7523 specific bug
>>>> --------------------------
>>>> We found that some serial console may pull TX line to GROUND during board
>>>> boot time. Airoha uses TX line as one of it's BOOT pins.
>>> I know the term bootstrap, what does BOOT mean?
>> yes, it's bootstrap pin
> Then use that term.
>
>>>> On the EN7523 SoC this may lead to booting in RESERVED boot mode.
>>>>
>>>> It was found that some flashes operates incorrectly in RESERVED mode.
>>>> Micron and Skyhigh flashes are definitely affected by the issue,
>>>> Winbond flashes are NOT affected.
>>> NOT --> not
>> will fix
>>>> Details:
>>>> --------
>>>> DMA reading of odd pages on affected flashes operates incorrectly. Page
>>>> reading offset (start of the page) on hardware level is replaced by 0x10.
>>>> Thus results in incorrect data reading. As result OS loading becomes
>>>> impossible.
>>>>
>>>> Usage of UBI make things even worse. On attaching, UBI will detects
>>>> corruptions (because of wrong reading of odd pages) and will try to
>>>> recover. For recovering UBI will erase and write 'damaged' blocks with
>>>> a valid information. This will destroy all UBI data.
>>>>
>>>> Non-DMA reading is OK.
>>>>
>>>> This patch detects booting in reserved mode, turn off DMA and print big
>>>> fat warning.
> ...

could you clarify what's wrong here?


>
>>>> -	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
>>>> -	if (err)
>>>> -		return err;
>>>> +	if (dma_enable) {
>>>> +		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
>>>> +		if (err)
>>>> +			return err;
>>>> +	}
>>> Why do you need this to be conditional? The settings of DMA mask should not
>>> affect the (in)ability of the device to perform DMA. I.o.w. it should not
>>> influence PIO mode. Can you confirm this?
>>>
>> no any particular reason, just see no sense to set mask if dma will not
>> be used
> So, this is an unneeded churn in the patch. Device is [still] capable of DMA?
> Yes. Set the mask. The DMA/PIO choice is done on the upper layer (as you do it
> via ops).
>

