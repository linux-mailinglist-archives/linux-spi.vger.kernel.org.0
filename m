Return-Path: <linux-spi+bounces-10202-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D00B8FA4B
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 10:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9A47AF68A
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8AB2836B1;
	Mon, 22 Sep 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WRb1M9RE"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19B277CBF;
	Mon, 22 Sep 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530850; cv=fail; b=pbReySF4XjBttMBXccRzbvEISPKd1gcCCBRB2iFzZY8RQX8zp/T7Xi9v2LABlLmsYxczfcvkkv9Wex26wMNrXcxEyXndDuaQ1g2g3i3ChzQQ0oL7GY7xxn3p56Frjpx7QUJ33rU4lN0oExjcArBemdjkSjhe/9trp1tEbyqIA7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530850; c=relaxed/simple;
	bh=TRsZ0ci/aLEW+SaueGeooS2ENkI0lYOVpD1LSUyz5v4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PKn1h2xt47sb17M58jHr79MnxolTd9lrtHAv05FF0AEKajFV8nmHSOffPPERYmX2t2F9/nTD6Zvh8Zzugi3Z9I3s5RyWBbyDgY9ttd4v7cxKPgTpdi9NWV3Qy9LI323MF8V4/OTEb9QpvrTQSUilNHUG80K8a0UIp4XeZfLKdKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WRb1M9RE; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI0BZXGENGzisxxK/uJYmCtlgiTEwSJ98PPlNWdgOvKxu8jjarkiSAt0cOKale0Du+BuwC3GcFpNcKIhpoG8CgYG8pghJ8pknttOCfLYvrB15+pwe1yCAbC4us+/XisDPxhf9NYd2PX6oASJuNIwcsjQttITy/isAW1uoBGrvfR7sVUbfujSKYy69IvCsh2HrXm8j7nzG8WwtX9sKFFTwh37Qre6Fihl/vWMuAL52A3g8PzFtyShINrylkCUJKm+h/iR5Rhh7ZiNCjXjJpsbJef/YzYX3A2xz7X0HcTbL4rVhJVGmWW+dwjzgXnSv/CGODJQr3ODyJ7gmdTR+GzKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg5c2HZGy8CR2JpqaFH/BR4h/i2YzPgs8WST38wgX5Y=;
 b=x1aXW5LkWSi6uQI75bzB7leqs8z7EzEIj7MzozMmsQNCsdQbMSBf1lnv/06Y762hNJaK9mgKIs00clH/3wYlqXaj2LXBSpHB2Zu0ys/z+qAh4Mh1egVPzID0t+YWZ4rubG35Mjk2LehaafMzItAYXcVX5T1sPCn1DgZRs3mdTXoaCsgVNicuT/M62B1ySMYoA9NKreKHVMB/Yt7kT0yIb+gWARIUc7Cjmc0N1EqwwOGzrc5greDuzIZEyc9SA/T1xDo0ZwV5Ak72C6v5mZ+IquwiFv1L3ipWWTRqMdyOG+nurEbynzU8dgI0SDrerECGea+PfRlvl4go6iXDE9AgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg5c2HZGy8CR2JpqaFH/BR4h/i2YzPgs8WST38wgX5Y=;
 b=WRb1M9RE1wECzTYDej6t859NH+qhKpgtgmom33bVwLvHauirJQpVa6pETSRF/uk9bpJXWscoaKv3gGM6k/GC8ZPF2MV6AeNTcAX7CsexFZ4xgkEImKcGAQUCFzy26g9/6uAeTzn+kIcIxk8dapPA7iu2KmdL7cwe23zrOcQYLDbqk4ufnkkpyjIQY+QCk75NPopHc5RGMfsnIqediC8KMR4FFU5foYC6alLR+Ojs8LRAXToXAjFJnuKC1ljgfljm9Dktj53l/mbv3LOwNPWug/5UC9sxQ/i+Ykik4g+y9YORT6PP0YtcQt9mehqohcSB4E/yT+tZ04pqrTbuh5gULQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 08:47:25 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 08:47:25 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 22 Sep 2025 16:47:13 +0800
Subject: [PATCH 1/3] spi: spi-nxp-fspi: re-config the clock rate when
 operation require new clock rate
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-fspi-fix-v1-1-ff4315359d31@nxp.com>
References: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
In-Reply-To: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758530860; l=1955;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=TRsZ0ci/aLEW+SaueGeooS2ENkI0lYOVpD1LSUyz5v4=;
 b=E5EvkzBcJcupcPszoL7S8G2dD9FAaIZDPjoqIoS9kIdQiru/p4UpFgjl6GfY1CZvdgJzk7FwH
 bwjQyRth9RoC/owF/WUrrcgAZIbNrKy3clxO/Y076C9kv5ixta8wHrd
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cabfbc-a464-4efc-a688-08ddf9b4a715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFRrcUtkUlV1WWl4WGVDQU8xQnRMQXZXOUpHNjNGQ01kUzVidGppY1hEWUs1?=
 =?utf-8?B?OUFjMm8zeStlQ1BHM2JleDdHSWR6cFRiVHE1ellqSURudnZyMFFEdkhMMkd2?=
 =?utf-8?B?dXgwVWZuakZuSGlRV2xjVW1NUFdIQ2ExbDZOYlFDMHhzazQ0WDZwZGE4Nnl2?=
 =?utf-8?B?Skg3N3NoS0xucUljME5rNmJOOHRZa2d0blVyRC9nL1hvcFFuZllTK2dMSVUr?=
 =?utf-8?B?MHk4VDBtbk1oRmx0M0JmN1AwY0t0NmpnYmZVTGZYam1pdmRPaHhuQ2RrcVF3?=
 =?utf-8?B?Z2NoVkY1YWJiN21kcGsxZmdMVTJwUHhzRDByTUpYaGEwTVhDSVFtRitxSmtQ?=
 =?utf-8?B?RVZ3VkVXandJL2kyZW42cXRuditxUGRrOU9ZUTNrWUdDVUJUaUxKYjd3aFlX?=
 =?utf-8?B?UlRFTFd6ZklRa2UwdVRXbVI4NXFVSWZ5RGtldG5iVWh1TXFMSmlXWEhucFJN?=
 =?utf-8?B?MGpHWmFyMGRpOHJkZXZUYmcvUjZwU252NHQvenI0ZHh4R0t5Q2NKTkNZRUdF?=
 =?utf-8?B?VW92RW5JTTlEU1ZySE01eFVDYmlMNi9IRVFTME9pUFV5U1lDU0ZhdGNKSWpk?=
 =?utf-8?B?R1JFbDg2ZlRHbkJPTktvK3o2OWw1MERySWFzU2VwcnhNYXNqOFpYOUZibXdw?=
 =?utf-8?B?QTV5WHVMRFRqb2JCTkFSV09jTGVINFVtaWY1WlNNMWRtUnBzRTh1U1ZoMjdr?=
 =?utf-8?B?UUxENHVsdC9UZGd2eVR5ZmVOL0VpaEQzRFlocThKalBNVzZEQmo0QWNoa3M3?=
 =?utf-8?B?RWZMeGg2WHJ2U1A3Q21CNVNvRjloaytqYTRJSnJKUzNwcUcyYStBSGRTbGZH?=
 =?utf-8?B?bFVjVU1mZmdIODhQaFhXL2hRY0lWeVM1MEc5ekdsV3dtUUFpNVdsWGtYRk9V?=
 =?utf-8?B?N1ZzTGNkb0s0eXNSSjhEWWhaa0NQQXhqeGE4VGxJSDRsTzBwS1BiWEQ5S240?=
 =?utf-8?B?b29wbmVzQlBzQnJ5THFrY0dwUndGMlo2UHlRTlFrNGJkeGZXMGtmS2JST2U2?=
 =?utf-8?B?U0R6cTU4Sno0aU1LQ09peTZmbzc0S1p0Vy9keDhHZkVzQ290b3NyRzJib20v?=
 =?utf-8?B?aE5Na0lRWHhpTWNBb3FGNG9JWjBsaFM5NWw2b0lyVnBkNzBKV3F0dWpkUUZU?=
 =?utf-8?B?eXZNczMzMy8vSWFadzBjOG05dHVaMjZpVk9SbW52Q2xvYSsxd1ZqbGhxZXMx?=
 =?utf-8?B?U282WURBMGVhRWc2UjVNeHdqQmNpRzNDcEZxbFFUa2N4cWh4eklOTkFBQVB0?=
 =?utf-8?B?ekNla3hhTTEvRkVGaDFUZFNWMjIydDkyemJrbjNTZWc4WXd3MUxDam14a0Jj?=
 =?utf-8?B?djNiU0kvNFJrTkdscDRCaUJhYW04SHovc1QzWDdsYVVJTzgvaWdrTlJkZW9n?=
 =?utf-8?B?cGVCdjlEbE9QZmMyVlJSN2VmMlZybXZGYTlQRXNyUW1UU25DR3NhcTVHZU5y?=
 =?utf-8?B?TFgzUzd2dExzU0RpbXdSRG9PajNLRVRZNmd1TDVKa3BhejBHdUNLaGVyU2VU?=
 =?utf-8?B?S0R1NGhjYWxkVjltZndoZkRTME9Uc2RRNGdOeERnUWNaQTFBTERGTGYxNWM1?=
 =?utf-8?B?UXJ5UTFlL1Z2Q2dIWDAveXgySXRvS21SQ3R5b2s5bmZabVJLa0F1bUE0dmQx?=
 =?utf-8?B?K2x0TTdXS0hKT3ZPUkRRT3lpbVJ0NUNWcm9SSlhLeFNVaU9WNjFYK0lzMEN2?=
 =?utf-8?B?cGJIZmlObFdnZmhoWVE1aE94YWxEMzBLZ2hNZ0V4OS9YZ0RZWXplMlVSa01X?=
 =?utf-8?B?N2xSblNrYWhrVHRURXZjZmRncCtYaXNXWC93eTBkNGpPWmdDVVcwcFc5eTlF?=
 =?utf-8?B?NEpUT1Z1dGFVcjBPeFErbHJZVVJMQmJ5LzlLRGJEWW10SmF4dDZpcHcyMTQv?=
 =?utf-8?B?RHIxZEJ6VDRHTXlGSER3VFRKWERsMng0VkZtaGdhK2RadWdUaTNuZVUyRmZG?=
 =?utf-8?B?Ulk2ckFKYVhjNWIvZVFUYW1vUnhPcitJcVdINDhmZGFVN0dCZ2xyTVVvUE00?=
 =?utf-8?Q?OprIaogP7ASGCE69M5iFrOWN9h6qtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2lySWtoZnB5RktNRFROVWx4cE9zamtNWUVXaGpLcTFKNFBFdlV4Wk9udm9K?=
 =?utf-8?B?aWxLeU1lT2RTQlRaM1RLZE9ubFVvTFZHSzF4UHJPTFFwSkdpbmpEaHZ6TUMw?=
 =?utf-8?B?UXk1eFF6MjdqNkI2enRhNmJTOTBENWlXL1g4TndvRmhubTVpQ3FteUtxVXlY?=
 =?utf-8?B?dEIrTERRalY1L1o0SGVTVm14a25ZT1NGMWVsSURFWUtQTElWSnVlRi9qL3dv?=
 =?utf-8?B?QTZ0QUgzdXNRSWgzbHc4OGE2RnJBYlRESlc5TjlNNkoxdHJld0szcWw4VHBS?=
 =?utf-8?B?cUJWQUFHdHVvUS9xTEQzSjhidnhpQ2hVWWNaZFhXcFNhTlhwYzBHbjBHSEVU?=
 =?utf-8?B?YUVEV1I1VGFpZ25sakprc2ViNnNjYWFya2ZWcVFpNUJCRlFZc3F0YjJHV0Vu?=
 =?utf-8?B?dnZoTUZmQ3Rrc3RlcFFpMkdYMTZFMWticnNqWCt6RzU3aVo1QjJTdVFiYjc2?=
 =?utf-8?B?RTZsRkhVeGplTU9hdytRVmlHZ1pGSzUzWW1LUmxEMDI0RUZDTVB5bFQ2L0hv?=
 =?utf-8?B?NXdXRUt4Z3YzNDkzK1NvbldqVSt0R0lqNTZLQmhPbHhacXMyVmtaZ3pXT1Nv?=
 =?utf-8?B?TFBqelNLUEpCbWpsakRYL1JCTHY1amZnUk9lS2cwS2w2TkdIMkhDVEZ3ZU5l?=
 =?utf-8?B?Z09vWHNvbi8yd0ZUdlFMckN0czJLck4zQ3dBYlg5MHdUeUE2R1FMUzQyUXpC?=
 =?utf-8?B?Y1ZqRzJ2WEF4YWpUVml1K2JmYW5sTUhPV1FBWWRoU2xIeEdSVHdtRmhzRnBu?=
 =?utf-8?B?aTl1MXQ4bFVNUEF0ZGxQQ3dndWZSK1I2RW5VM0tKd3RBQTYyK1U2ak55b2pq?=
 =?utf-8?B?d3dUTkF3YnpvUWI2SHNPZ29CS0VCQW50d0dCdHJpYmViSGtXaXV3VERzaFlC?=
 =?utf-8?B?QjZjYWhCc3F6RDFOTXRGS0RtZlNNcW1Ka3dITnBqTkJsanRZNlBXN1dsOVNZ?=
 =?utf-8?B?UG8rQXNQekxKLzRYbUk0ZGJSVVRMMXkwZ2tmcUpEcHBUR3AzdTZUdmtzZGpQ?=
 =?utf-8?B?R1ZSSk93S0RmQm1nRlFWNWNxYmcxSUZ0S3pvbXFGUldqb1ZJay9QMGFpQUpl?=
 =?utf-8?B?cVM3Z0dHSXlZV3dQd0ZiNmJlYlVoNmhBblRjU0NVZlZEWC91K2hqbDk2MHQz?=
 =?utf-8?B?K1RPTE1aM3dmY1lxaXJHeFduRXd6ZXZWVG0ydlRVeTdySExERTV4OXNTQURo?=
 =?utf-8?B?SFg1bzJSSGlNdjVldnBEQ3p6VERzdnBncFFCYnROM21IM0kySWtaeDNaT3I1?=
 =?utf-8?B?SUwyMERQMzgzNkFSd3RXeU9IRjJoOW03Ym15U1FteWpTSHNmOGVUZHRJUFFk?=
 =?utf-8?B?WUpPYk01T3hKY1VDOWEvMEJ4WU5QamlDaGgrVnY1ZTBoZFlZcDNoNWdqY3l2?=
 =?utf-8?B?VngyVllJNndqNldKYkxiby9GbW9iVjBpN0FkQWpSWHFTMUtobEc5K2x0ZHlQ?=
 =?utf-8?B?bUFadjNHWmZ0OTREMlBtMkQzV1VCRExBM2dEZ3JZWEhtUUNJNlhJZnp6TWdx?=
 =?utf-8?B?VXovQjBCbGVxN2hBUStGOHdqMWMrcHJTRlE2dzZ5UExGdElGcEJvTlVIRFln?=
 =?utf-8?B?SmYxRVlZMHBrTUlGSGkxUkhydytYczRzWkVjMlhGMkh2WlVXS2pjb3ZsSHNE?=
 =?utf-8?B?Q1JCUWwwdDBpOEUwRFdqMHIwMi93M3FzUTJaY3gzNmRtVHVEL0YvaDFkeloy?=
 =?utf-8?B?a29sK3ozNCtuejJYT3VWNzdmbjQzNWNBVDlpaThxQ2NXZ0YzS2JYZ2wwZCtp?=
 =?utf-8?B?SVp2NmYwdUpYUmFTQm9JMXNtQ3FRUG1TYUQ1NnlLMnFDMmRLUXFJSEpNaG9n?=
 =?utf-8?B?eVk0NkFEcnphVld1Rlh0ZlpRUnA2TDE1ZVc1aTBGMVQrZ3pVRWJDVmd0NGcw?=
 =?utf-8?B?YnhSUTBpeEZ0UktiUXl1c29RbjlTQmpqSWUxVDhzazBoOXpHY3FJL0U1T3My?=
 =?utf-8?B?WHV1Y1RTK3k4R1dyeklYZlNobmZLaVc2ejE3ai8rY1FOa2RXUzkvbmJmSEVr?=
 =?utf-8?B?dURveFo4S2tEWldnaVZ0M2lSQWN3a1dTb1N6cXE0emVnTG9YTDM0bDE1RUIr?=
 =?utf-8?B?ZkZPTWU3azNkM1AvM2JyM0xpVi8wY3Q3eG1mQ3h2WmhJTW9MbGJMZGt2UXFh?=
 =?utf-8?Q?axPqIGLwwAdBQB8Z9hv70+XDf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cabfbc-a464-4efc-a688-08ddf9b4a715
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:47:25.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss3e92NV8YeATIkKtSa1ktZUFXJt3usaKPLDaJcblR/yD1F+o3xyBSFfvnU3oIKe0GN2YX6icaG03asua1NiEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828

Current operation contain the max_freq, so new coming operation may use
new clock rate, need to re-config the clock rate to match the requirement.

Fixes: 26851cf65ffc ("spi: nxp-fspi: Support per spi-mem operation frequency switches")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index f9371f98a65bdc7e5eaa612c0770a6228bdda364..4e82f9e900acb91c6de46559efd265f07cf4437d 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -404,6 +404,8 @@ struct nxp_fspi {
 #define FSPI_NEED_INIT		BIT(0)
 #define FSPI_DTR_MODE		BIT(1)
 	int flags;
+	/* save the previous operation clock rate */
+	unsigned long pre_op_rate;
 };
 
 static inline int needs_ip_only(struct nxp_fspi *f)
@@ -780,11 +782,17 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	uint64_t size_kb;
 
 	/*
-	 * Return, if previously selected target device is same as current
-	 * requested target device. Also the DTR or STR mode do not change.
+	 * Return when following condition all meet,
+	 * 1, if previously selected target device is same as current
+	 *    requested target device.
+	 * 2, the DTR or STR mode do not change.
+	 * 3, previous operation max rate equals current one.
+	 *
+	 * For other case, need to re-config.
 	 */
 	if ((f->selected == spi_get_chipselect(spi, 0)) &&
-	    (!!(f->flags & FSPI_DTR_MODE) == op_is_dtr))
+	    (!!(f->flags & FSPI_DTR_MODE) == op_is_dtr) &&
+	    (f->pre_op_rate == op->max_freq))
 		return;
 
 	/* Reset FLSHxxCR0 registers */
@@ -832,6 +840,8 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	else
 		nxp_fspi_dll_override(f);
 
+	f->pre_op_rate = op->max_freq;
+
 	f->selected = spi_get_chipselect(spi, 0);
 }
 

-- 
2.34.1


