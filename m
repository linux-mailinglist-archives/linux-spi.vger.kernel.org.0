Return-Path: <linux-spi+bounces-11791-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F13CA7CCB
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 14:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0749A302034F
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6BD32861B;
	Fri,  5 Dec 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IhpFnj3t"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F807219A8D;
	Fri,  5 Dec 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942054; cv=fail; b=VjAf8VVcbIh4aHhHBDrAQfBjzjDPMPaoQ/5RYn9kq/6JegNw0szaOEGDbqzB3tBRCuIkci/UqWn8GXz//nvanCd8TsKOUIp7iNMfCzr4wyx8HWAU4gVOqHDsObQRWYJCXDSEMS+ghm3+1AdyEddIR8vgk90XfhPDzJDuRF5zExE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942054; c=relaxed/simple;
	bh=upGTR770knjPcN4n1FqKirVxSSifdOd0W/D9pE2wkQU=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Aw5kee7P1wJ4z+sjpMw7za4g4U3emdNh/8II8JgSsWKA9JNdlPIwav8DQTi1em1S0YddLih3bi1MQBl7xmx3dGyfRKC4B24mEH6WigDEAdkEh/ApOIP/AJ9RkmAfbqLCnF9hNJ29+isitTJms0SfAGekpldHLJ+qjAOcwMGMfII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IhpFnj3t; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ1Xmza2nfz9y1iHvcoxyu2p9JYq4RtLGM46DDuhgMUFv/Q4tq+8k0f1FXugolaHwJbGLPjWxTSJpIojeNIpIsGKHOIC7YhPGbMw+AkUDURe/VLugbr6lAJyZjPC4hfipdwLw1CWuEJLJrdRVYFrdqIu47aOk8MTNLeJrT5HLF+tZJEs6aljDe68SKXM2Hq08kn0ICQ4btOKAYT0cdvvReTWmdDAGwR45pWSaV/bkbF7Mwd7LrF8TecaChIfvI356Ff1BpH5nLP1QJXUkKO6wBmbKslrJH8IO2etFHkmsCUrpTxkZYREWBsqNtuwYTKFnp9seuA/iqdZ6Zn1raqYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKITeLCDLYjVhXoqynpt2494P1YRRLrCrAM46E3qfsE=;
 b=qeES67L93bq4SnD0JjOtWA8fDlxcR4Cz2ZxvPNaGLVSkIuNHfm4egU15VnquKKUnS1O+OLVrD4IKMv7kZ9HbKFMCwEI9anYroBCSEPGyf+txcj5CDGj+tpODIx2o7r1P/X/zvXAcIf+Q3+08uNksNc4gocNLXp3cTB3QnEvUbVa8JZvpd/sdQcvDlOO8BUFrGcjQQiO3W/Qx6NA9CvCyoi77NS8kuUuX0EHVnaiSnmPx/eUEMgyy7JNpQ0yqENFLwX2C3JNuOl+1jqy4tbPSjdsR7BzQjh59n+cvb5tfZHbzsn6LKu5YWMpuVs010vzjAXoOS1An+vOa2bEatiIO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKITeLCDLYjVhXoqynpt2494P1YRRLrCrAM46E3qfsE=;
 b=IhpFnj3tKAnzVbi4x7dilnaQNH3n48BacvbZrnNZO1QGDtDIYupJSgteMUlmJkEt2xqKbBdnTYotgZJxmYuxbuV8wLFfKnuJ3XCGD+MCqcmqge1HFzn6kUuxOgdq36Dr3Jjk+W1E07YbS1fG+bjPNuuysgVlGRlAXu6UhkalJ00ubI8uZ1qpZipkUK7C734v17LIWK8e5nVqD9C/L3whlZeeINA8grPiB0OzNyDcMSfmoX/H6XEoHofVIk2vXLnxUWswA98sfrjPEOPRQ8UfFYjhv6xJ+MgCtiEucfEeeWFZiq9S/lx9WbeTfAiXs41xMMmFJ0AjVzDJtaNVfeR7xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9261.eurprd04.prod.outlook.com (2603:10a6:20b:4c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 13:40:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 13:40:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Dec 2025 21:40:26 +0800
Subject: [PATCH RFC] spi: virtio: Add [new,delete]_device sysfs interface
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v-spi-v1-1-89713cc6c0b4@nxp.com>
X-B4-Tracking: v=1; b=H4sIAMrgMmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNT3TLd4oJMXVPTRKNEg8RUi+RkSyWg2oKi1LTMCrA50UpBbs5KsbW
 1AJvLQ2VcAAAA
X-Change-ID: 20251205-v-spi-55a2a0ae8cc9
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a759233-3d0c-4b30-bc82-08de3403e42f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmlqbG5Va2xoNi9iU2VXeU9wYzE2MS96ZWlQWHNIMkZWQmJZUnFiT2c5YWhM?=
 =?utf-8?B?OUdxVlQxRVhCWHM2SHFMcUNnVzl5NGk5eFdFSVJ3dDNtNVFrU3Z1MjFCK0hh?=
 =?utf-8?B?QjZuYU5YOTlQOUcwT3R4cVBENUF3QklsTVZqM05lcUh6dEVXcXp4VkJzWUNq?=
 =?utf-8?B?YWl4dGZYdmF1REpHVFVoMUUxajM1NmxoSHVVM1k0L0hSLzNZWUZxVDdCSnRX?=
 =?utf-8?B?dy9rOGM3YVFTK3JyWGVHUTFyNEVJU2RFTGkrclVMRFM5bFhvcWwrWE5aWmx3?=
 =?utf-8?B?RzJOYVNUeTEwZVlveE9EOFhQK1J1ZVNnNzR0KzczU1Q3NjRGS1BSMVBrdjE2?=
 =?utf-8?B?T0dFeUVWRWd1VXptYmlQR1AvRkptdDZ6RVdpd2J4SWQ5bWlCSEJEOWY1U3dt?=
 =?utf-8?B?YXZycWRVUGFEZTE1NnZlc0x6YkYxRmx1RU02b2JMUDIwM1FyVlF6eThmaUta?=
 =?utf-8?B?QXJzcVhJZEpoZDV0dFppRDdFMFdhbTV4dDRJOGNFSkNwQXpMMEVBNU5HS0xD?=
 =?utf-8?B?aGlVTnFFR0s5aHZua2JFM0JrVmpoM3h3dGZpRVU3aER4S0grUWoxVXFoeC82?=
 =?utf-8?B?cUlMMHMvWWwraXRqODVOYjdHMGJHZGU5cFp6OWdmTjNCK0tkelZWUDB4SjJG?=
 =?utf-8?B?Wi95M3V1L3FRdUhaUUhFUEVoT3kyRDVXN0NwVmhiN2QwUG1MZFR2Ykh6VXV4?=
 =?utf-8?B?dnUvUUJVa3A3c25IUHM0NFdBakxZZjVLU3ZqN2o1dkhFUFM4alVuVVQra3dO?=
 =?utf-8?B?b1JYNitPSjFNNXVjdENrelEwd1M0TUxrRWZRamFCa2RBRnJJSkNPL09XMmU1?=
 =?utf-8?B?V2M4Sm1CTElvZDRoTFpVbWtYc1l2T3lJY2Z5SDYzdVVhQ0RtSUwwdWYwUXV5?=
 =?utf-8?B?YXJjSkw0SzhIQ0luWHVKbTFVRTM1WStTcW5PVUQ3RE5WcFg3S1A2ZW9VR1p5?=
 =?utf-8?B?ODFPc2tTMzVlL2NLTjRyUkFVZWY4VVF5RGl4NGg2SmdkNldQVHBCK1BmbmRy?=
 =?utf-8?B?T1d0NXoyYVhabTJIbk5vZ2UyRHQ2OW8rM3RkTU9tRVBtSDFlcFk3aHBYLzlU?=
 =?utf-8?B?c1Q2U0Fwd20zdGVGV1R5Z2hvcEtRcFYwclFRYkxiTUlrR3pVa1VZVUdVbGVC?=
 =?utf-8?B?a2poZmFPejNIcU8zUlQyc2dMS2RuZW1SZlIrZXdBRGtnUjFObFd5N0ZITVZ3?=
 =?utf-8?B?TUlkUDI2cU1LaFJJU1cyLzFBSlJUUWhqV050MHFkd2hsYjhqU2NRZlN5VUJm?=
 =?utf-8?B?RkV6b21jRGloRzdZOGwxdkp1REI4bVF3bkdqVCtuZnAyRDNxanVPT2IzZ2lQ?=
 =?utf-8?B?Y3lySjlHam5ZclprdkFncGpOSFFtMWhlRmdycWV3cHFBMnpWaUltVWFuUjFT?=
 =?utf-8?B?YVU1a0h3NDJCeHlpVWJoNjVYTWdCZFRQRlhEWkNIZlFSeThlb21pVFZGb1h6?=
 =?utf-8?B?blVlclhhem0vT25tUHJyRzNZeHNGY2JYWVBIbmdheWdwczBHQlVlOVdMWlNP?=
 =?utf-8?B?QjhIUVNYd2JNL3RXSWFzQjRpbUcxQnlWa0Z6cjFTT1RrRXZjRE1FNWRPeWpM?=
 =?utf-8?B?eGxhYzlRcGNpaEVwTFZja3BrVHgwN3Fra3N6TkFNRHRPdStqREs0c1lQSkh4?=
 =?utf-8?B?dFVDOGg5YTNsVnAxRExzNWkxYnY5aFNpbmVhQWZuem15T2pkTkwzZ3FLeE1a?=
 =?utf-8?B?a1YyMU5iUDZlMFErbHFlVkpzUVk0dkdxL3M0V1ZoNnVFNEI1YjAzbDczRVlU?=
 =?utf-8?B?YUlFU3NGbjBUbEZEMjVLZ3ZkcWNtK1h0R0p1R3FvYmNDVzBvc09UNUk4Smlr?=
 =?utf-8?B?L1dHWFpwV1Q1Z3l5ajRCTEVXeGJtdjkxVHVZTldxVnp3Rmd1K3JHMEtBc0ZO?=
 =?utf-8?B?eUpxcHVORTh5WHpGS0dqT01zL3RHL0ZGNEJabUYxbjRCQU1FUldoUlN6N0lG?=
 =?utf-8?B?SWZhMVBoRms5N2pjR3dBdXpxUHhxVUExenRSc0F6NlZRNnVZb3JGVzhibXVj?=
 =?utf-8?B?TUc0dU1XcldneFprV0hXL0g1dlU4YittWEkwT3A1ZVluNXpxRnZJRjR1S0x1?=
 =?utf-8?Q?8JuRCY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHYwc2V2TUFUeXp1TGhvYWV1ZWhrdmtrdVhCSVRKZHMwdUF3MDl2Q1RUZzZx?=
 =?utf-8?B?MzdHTkl3ZHdYdUxiVlgxQ0w3WjJWUktUSXM5V0dKTC9nRWMxQTkwaE40Zjdx?=
 =?utf-8?B?cDFEQnJpcWs5bWQ0RnArN1lDcmtneUloUjlXWmsxUFlxaGRRVlBZYkZXRk9L?=
 =?utf-8?B?dTJlQ0FtSStpMXE2dzhjSzBMeFhaRGFFekdYaGFPMDBzdHZNbXpuVXA1OFBk?=
 =?utf-8?B?VXNuWlNxZGFKRFYxbzZaQnhpZC9VL3g0RkhuNDMrWnRrRUkvaHRPVmFWOS9F?=
 =?utf-8?B?dytyY3BNd1VYMFlVTVJlRER4a1lvQWsyNEVrb1pmcVBFQ01taHdtQ0RQNEJv?=
 =?utf-8?B?bVR4dHg0OWtyemVnSEJvbVhhTVBvOWJlSURlL085TU92b2FQL0FZcThNalkz?=
 =?utf-8?B?NmxzNjEyZWp6NFlzdjdHK1Zsa1I3TDM0UmJacVUxRzJYTW90OVhOZHI4cmtl?=
 =?utf-8?B?dUkrMXJIcXppeUM4MXRmSTljQ2V1YjFKNlRScWNxT3pCeituRWk1Um1iMHVk?=
 =?utf-8?B?bjFIczBhYkplTFROUWxmTUo4ZVhDY21HTVNjMWV6SmEwOUlmblR6RkluelFy?=
 =?utf-8?B?UEZ0eENiQXJ3NWRKUWMxaEVIaFRIaU9aQW5ML0pKa2JjTDFDSjhPMWZESnJH?=
 =?utf-8?B?dnlVbG9ZcHFXK1U0YUdLTUVwNnA0NE5aaE9GU2VrVU5PUGZPVk9IU0swSWdE?=
 =?utf-8?B?QTV3cEFIRnZQcTFybVNrVStpT0k3LzVoWmZTenhleWU3RkYveHhUbWpxaWE5?=
 =?utf-8?B?SW1QamQ3bEwzTzFlaU1pZ0RYVnhPK1FTL2ZNYmQ5Y01HNzh6VWhXYU5MYVFT?=
 =?utf-8?B?SzNtL01VRUQ0REhtSll2ZXFnU2NES2ZBdy82U0k1QmErUWpreE4xcDRjbXpS?=
 =?utf-8?B?Q2hVRmM4MXZiOFJVdmhGSzk1UFoyM20xRXVLOWE2N2ZkaW80dHAwSDVBNkJ0?=
 =?utf-8?B?RmhlOGwrbkh2eVlXUkt1eGpyOUoxbzI2Mnl1ZDRkNVczdVVkN0xaVURNNHFM?=
 =?utf-8?B?blJ5czlZVUdIWUhMYzYwTWIrTkk5Uy9hTVQvd21NN05KWVYzemNuSzFkbTBD?=
 =?utf-8?B?VjBxd2k0V3cxS1V1ZXk2SCszcFh5MGcwUnFMbithZmFiTGtjcmRmd2pEWUlp?=
 =?utf-8?B?cXkyTjJRdkJrNHFpYnlKRWxrM0FvYkRSbkZKNFR5aHFBMGljQ1RkRHdlcE90?=
 =?utf-8?B?cVlLeXd5eVNRaTM5aFJGdkM0SlA5OW1FQVlqNXIrRTZSc1d0RXNTU0Z6aVls?=
 =?utf-8?B?S0YvYm5SU2xmZjY1N2NWb3pJUTlheW1VR3NZVS9VNFZxZyt2UUlIRkh1a0th?=
 =?utf-8?B?Uy9IU2lZWGx4UTJFWFovM0QzRml3dkhuSlRJc0p1eW0rVStvSlNYUmE2OE5m?=
 =?utf-8?B?b2xNaVBYTDFDenVjendUaFo3WkZJaGI0Z2YyeUFkMkJ3bmNvUDZjZVNuRXBS?=
 =?utf-8?B?NGRvNThsYUFFSUF1RGYzK1FrS25ITGhiYitkSE1nQ08vVHFiV2tLR1oyZlRW?=
 =?utf-8?B?bjFXR1lSTWlWaGphaDFTSjNXcTg0d2txK3VydStFanBtL3h3L1hwR25jUStn?=
 =?utf-8?B?TzBOM1BiWWZyL25zUy9kR2d3OGUzajNJekFISFhlYTQvQ2J1RXZqcTBzS1Fo?=
 =?utf-8?B?ZjN2MVNWeTdVcUhialN0VSs2NHVSMTRoUlZtWS9vNEZpTkdvK1Y2SjBnMXJP?=
 =?utf-8?B?d1htdnJXdnRJUUJTYUJyNCtqYkpRemZFTkZtc0pkaFhqT08xNE5IeW5YNTM2?=
 =?utf-8?B?Zkl0Y1JnMW1qUVpQQnM4Wi8wVnRRMmRTdWdBUXdDNzY5VGRRc0hpWmxrSll1?=
 =?utf-8?B?cTJ6NFhiTjJSV0xSZGVEWWZCWDgrNkt1MUs0blNsQW9sT1g2RFpxbmN6SUov?=
 =?utf-8?B?K25mVVdacmpia1ZjczByaVVvalgvWTJIMVdyN0dDOUlkMUdiQlp3QVN4dERI?=
 =?utf-8?B?eXlZZXRqYUVuWWVNN2xTNjdGY1Fvc3llaHMwR0hxd2lkM053b0lkZHArWlpj?=
 =?utf-8?B?UVR3Ny9CUVMzeEFXbWRHM2JqWHJLZ1YxS3BXS2szN25hcjl6SGxsMi9qeklo?=
 =?utf-8?B?MTBkNmRCQkFXLzQwNmhERzdHZVdVV0pubW45OFNTYVQ5c3AwbFVTakhzMDRZ?=
 =?utf-8?Q?c0/esofLetMIsWBmzYxelwdEC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a759233-3d0c-4b30-bc82-08de3403e42f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 13:40:45.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWh/RJSZNNWBaPJOrSelml8acpBlw++ZjLC1PwQZ8D7GtcV+y1nTPZapvKxvzljBSdEfZDwTS0DchIbDbRZYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9261

From: Peng Fan <peng.fan@nxp.com>

spi-virtio registers a SPI controller, but we still need to register a
SPI device to initiate the SPI virtio transfer.

To Xen hypervisor, there might be no 'passthrough' node for DomU,
so add a sysfs interface to allow creating/deleting a SPI device.

Usage:
 echo "spidev" > /sys/class/spi_master/spi0/new_device
 echo "spi0.0" > /sys/class/spi_master/spi0/delete_device

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/spi-virtio.c | 171 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 2acb929b2c6907d6b073829c153d1e1d3bb729b5..9014d52da76b0f2e2c3f049605968fbbb790905e 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -5,12 +5,15 @@
  * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/stddef.h>
+#include <linux/string.h>
 #include <linux/virtio.h>
 #include <linux/virtio_ring.h>
 #include <linux/virtio_spi.h>
@@ -330,6 +333,170 @@ static void virtio_spi_del_vq(void *data)
 	vdev->config->del_vqs(vdev);
 }
 
+static ssize_t new_device_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller, dev);
+	char *cs_str = NULL, *max_hz_str = NULL, *mode_str = NULL;
+	u32 mode = SPI_MODE_0, max_hz = 500000, cs = 0; /* MODE_0, 500KHz */
+	char *tok, *save;
+	struct spi_board_info bi = { };
+	struct spi_device *spi;
+	char *modalias = NULL;
+	int err;
+
+	char *kbuf __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	/*
+	 * Parse: "<modalias> <cs> [max_hz] [mode]"
+	 * Example: "spidev 0 5000000 0"
+	 */
+	tok = strim(strsep(&kbuf, "\n"));
+	if (!tok || !*tok)
+		return -EINVAL;
+
+	save = tok;
+
+	/* Extract all tokens first */
+	modalias = strsep(&save, " \t");
+	if (save && *save)
+		cs_str = strsep(&save, " \t");
+	if (save && *save)
+		max_hz_str = strsep(&save, " \t");
+	if (save && *save)
+		mode_str = strsep(&save, " \t");
+
+	/* Validate required parameters */
+	if (!modalias || !*modalias) {
+		dev_err(dev, "Missing modalias\n");
+		return -EINVAL;
+	}
+
+	if (cs_str && *cs_str) {
+		/* Parse chip_select (optional) */
+		err = kstrtou32(cs_str, 0, &cs);
+		if (err) {
+			dev_err(dev, "Invalid chip_select: %s\n", cs_str);
+			return -EINVAL;
+		}
+
+		if (cs >= ctlr->num_chipselect) {
+			dev_err(dev, "chip_select %u out of range (max %u)\n",
+				cs, ctlr->num_chipselect - 1);
+			return -EINVAL;
+		}
+	}
+
+	/* Parse max_speed_hz (optional) */
+	if (max_hz_str && *max_hz_str) {
+		err = kstrtou32(max_hz_str, 0, &max_hz);
+		if (err) {
+			dev_err(dev, "Invalid max_speed_hz: %s\n", max_hz_str);
+			return -EINVAL;
+		}
+
+		if (max_hz == 0 || max_hz > ctlr->max_speed_hz) {
+			dev_err(dev, "max_speed_hz %u out of range (1-%u)\n",
+				max_hz, ctlr->max_speed_hz);
+			return -EINVAL;
+		}
+	}
+
+	/* Parse mode (optional) */
+	if (mode_str && *mode_str) {
+		err = kstrtouint(mode_str, 0, &mode);
+		if (err) {
+			dev_err(dev, "Invalid mode: %s\n", mode_str);
+			return -EINVAL;
+		}
+	}
+
+	/* Check for extra unexpected parameters */
+	if (save && *save)
+		dev_warn(dev, "Ignoring extra parameters: %s\n", save);
+
+	/* Populate board info */
+	strscpy(bi.modalias, modalias, sizeof(bi.modalias));
+	bi.chip_select	= cs;
+	bi.max_speed_hz	= max_hz;
+	bi.mode		= mode;
+
+	/* Serialize against controller add/remove paths */
+	mutex_lock(&ctlr->bus_lock_mutex);
+	spi = spi_new_device(ctlr, &bi);
+	mutex_unlock(&ctlr->bus_lock_mutex);
+
+	if (!spi) {
+		dev_err(dev, "Failed to create SPI device %s (cs=%u, mode=0x%x)\n",
+			modalias, cs, mode);
+		return -ENODEV;
+	}
+
+	dev_info(dev, "Created SPI device %s: cs=%u, max_hz=%u, mode=0x%x\n",
+		 modalias, cs, max_hz, mode);
+
+	/*
+	 * generic "spidev" may NOT auto-bind. force-bind from userspace via:
+	 * echo spidev > /sys/bus/spi/devices/spiB.C/driver_override
+	 * echo spiB.C > /sys/bus/spi/drivers/spidev/bind
+	 */
+
+	return count;
+}
+
+static ssize_t delete_device_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller, dev);
+	struct spi_device *spi;
+	struct device *child;
+	char *device_name;
+
+	char *kbuf __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	device_name = strim(kbuf);
+	if (!device_name || !*device_name) {
+		dev_err(dev, "Empty device name\n");
+		return -EINVAL;
+	}
+
+	guard(mutex)(&ctlr->bus_lock_mutex);
+
+	/* Find and remove device with matching name */
+	child = device_find_child_by_name(&ctlr->dev, device_name);
+	if (!child) {
+		dev_err(dev, "SPI device '%s' not found\n", device_name);
+		return -ENODEV;
+	}
+
+	spi = to_spi_device(child);
+	dev_info(dev, "Removing SPI device %s (cs=%u, modalias=%s)\n",
+		 dev_name(&spi->dev), spi_get_chipselect(spi, 0),
+		 spi->modalias);
+
+	spi_unregister_device(spi);
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(new_device);
+static DEVICE_ATTR_WO(delete_device);
+
+static struct attribute *virtio_spi_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL,
+};
+
+static const struct attribute_group virtio_spi_attr_group = {
+	.attrs = virtio_spi_attrs,
+};
+
 static int virtio_spi_probe(struct virtio_device *vdev)
 {
 	struct virtio_spi_priv *priv;
@@ -366,6 +533,10 @@ static int virtio_spi_probe(struct virtio_device *vdev)
 	if (ret)
 		return dev_err_probe(&vdev->dev, ret, "Cannot register controller\n");
 
+	ret = devm_device_add_group(&ctrl->dev, &virtio_spi_attr_group);
+	if (ret)
+		return dev_err_probe(&ctrl->dev, ret, "Cannot add virtio_spi_attr_group\n");
+
 	return 0;
 }
 

---
base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
change-id: 20251205-v-spi-55a2a0ae8cc9

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


