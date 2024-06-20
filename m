Return-Path: <linux-spi+bounces-3509-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5B910DD0
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD028118F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C31B29DB;
	Thu, 20 Jun 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q+TCBkdr"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69F1B3720;
	Thu, 20 Jun 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902730; cv=fail; b=lfwwU//2UMMS9zWfvPMWG2BuyIfA3sZZQVDg8tJ+IEBjg6mKTgLhYwGewaXuywpuhcChw0VsRy4UmnzGvNGS2ZnYY+IWcbZjBAlos0zuKpiBZEiIeU3xWpQ65YIp70TQ7cyJNnloAoQYbhOdQFankj4ARF3sWs9CYBs3oJUBD5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902730; c=relaxed/simple;
	bh=3Jl5aAnZNhlQmHjIX+NC8ghex8qkEHP6Oc+SrQaoz7k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WUzK6SqBOn5VJz8makjfvNvFRK4q5XdYghdlv8y+X/JHGChKZfbITQmx02ZFl5vcQCXLmHRezXEvLvEDedFxBi/aYEb8vKyAHpXY/SF6Ym/h0mcuSwauZltNFM0paSxHRgd92/GTcCceJ/EcnU3+RCxDyJ8Ji88I41TxtbMde74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q+TCBkdr; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCWs4jJ8tmTqjA8gYgyromezqHSXvvb7nr4u1+dXImO9GJa1C6CaQjFW7Y6qpAQeJ9uDVrORVFQO5IJ2WdbiWwm/JQONsXKieYOEbNYp3e0ypcVCeaeEo0QesN1Ym8swYCExvIR/VwQIYQNmkBdf6NxbJJ++9bEtQpC3Km20NqMzomPYM+JddVfSk6uIwkR1S04W59P8PQQGiMpZmpI0pDL+DyD9XkK92c5f9CxbRJQ9zfVOvQFHx/AOBsMeogGE+uwWRlzMzBiVH19dPD6gRjqRtejJDifbfsVNFAZFF/3d1RQ/zKa3OSP94PsklLONGyh8s9SwRwjZ9rFxxIjpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KDdOaQLnz5ByclRtwTVaEwIY9i9ftXrZkjAwUrgnB8=;
 b=liYgJgJllTZ2A1G1y13jsb/1Xd6fe/lvlqXpI9j0xLEBo52SWaro3eHPlT4/TaMrYKOeiCqojNAZlriYhsZvMgppoCEFQVs0NWL0lNn9mKVyV+e5+xtKfPSLuXySLnAVmmTihbexXdgYc4N6uaQ6NCKtNIzAhCiRPKm/hFyzyObqPaLNodwX0Mbwa0cgC7kaNa3cnhYwltnBVTXA5SIvWzl51I7JAw6aCIxDN1MfYvBLCKvwgmeFjHyViptNDXUF6wEGT2wB/xrVDftVXnJbxuzAv1csrPOks37YPLJ5pbxLmLNxrOUE/uJFqRGDwccln4ruZ4HSV6XThAv3oaOxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KDdOaQLnz5ByclRtwTVaEwIY9i9ftXrZkjAwUrgnB8=;
 b=q+TCBkdr+++KgbsjXV4+wzAHczdaSENpnb7PRI3shHDY0IlEv5cHrw7xm9CMbXc4L7s98deUWtpK9FAMyqlyutmGmzcOHj/Hz5sbVgzqh78M8/myO4M7U2Qet595HsS2xpz0D1aurbZR+bHppT7YcDZE1OBikEHVhhlp+rnumiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7632.eurprd04.prod.outlook.com (2603:10a6:102:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:58:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:58:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/3] spi: fsl-dspi: Convert to yaml format and use
 common SPI property
Date: Thu, 20 Jun 2024 12:58:26 -0400
Message-Id: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJfdGYC/2XMQQrCMBCF4auUWRuJExuLq95Diph2Ygc0jRkpl
 ZK7G7t1+T8e3wpCiUngXK2QaGbhKZQwuwr68RbupHgoDajxqO3BqIdcXxJZuaGnATWhqQnKOyb
 yvGzSpSs9sryn9NngGX/rvzGj0sph03jra3cytg1L3PfTE7qc8xfFVt3fnAAAAA==
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718902721; l=1786;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3Jl5aAnZNhlQmHjIX+NC8ghex8qkEHP6Oc+SrQaoz7k=;
 b=V1FuZdZpRBLW+tXNJWA9rZpu10wk5IT2lUUlkeVUxGlNPHez+TqYmrQ327MjAHAMGs3Cii9+8
 UadUj+aLk+ECWD7T+r1SQjQoYBL3lhiZyVgtAQmffbXc9r883zjpxbg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: d56a9bd8-c9b9-43dc-56e1-08dc914a3e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|366013|52116011|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFBRems0ZGM1YUZZYldwQTNsZFY5ak9LemkwOENjam1ZZE4yMTZpd3VrR3BL?=
 =?utf-8?B?ZG5GSWxEckVhbm1QN2l4RVpCMm1BckwwM0krczEzNitwK3JKRk9SQ2Y1aXJD?=
 =?utf-8?B?UlhaclorR1Bkd0REU1BPak02VEtwcy9CN2gxUnFSTTFoRW1yenhqNGw5NitN?=
 =?utf-8?B?WFl1UGxDeWZhcktlcTFkVHNTMEFBUVRQZGZLWkJYcEpTOXpRUkdwNUhXVXRD?=
 =?utf-8?B?VnZJWUg4RUhJQzVYM2dPZUZDVWg2aENWSmVWckp1Z1cvc090UUhuRjJ0YW83?=
 =?utf-8?B?eFRmRThROXAraTF0MnYxY3RWSXpOMlR3YXpUa3BKOFdBVFYxMkZJeTR0M0U3?=
 =?utf-8?B?RHlhUVM4ZDh1aTFlVXhXQWdoRTBUcU9VUXNOMDUrS3p6Q3BDbFZNSVAxSTEv?=
 =?utf-8?B?Z0pDN21leDR5TzRwcktXZHcxZGRwQ0Zwb3dSazhwSTFjTnc4K2txV2tPNmV0?=
 =?utf-8?B?MlZPamJZNmcyMHcwUDNjNnZiWmFXckdiRHV0MlljbFhIUGFkbUQyMTZ6cHJi?=
 =?utf-8?B?SUQ4T3dIUGoyTnhneld1MUhCSmoxMStaY1pmTmNoTU1iZzR4T1d1TkR2eXd6?=
 =?utf-8?B?RXJnaURRb1ZhYkdma3o4OXM2S0RqdHN1SkY1RlBuSDhnVHcybCtkZjAvbUJm?=
 =?utf-8?B?ZGdlQk5ib244N0QwQW9JbXJEaytNWFpjSkd6Qm5UTnVHTUxORytKanZlSFo4?=
 =?utf-8?B?TXdSZm9WSFBxbmtJNzRxcGxMZTFwRWhaMG83T1R5c3NPTGxMUjIveWtxTys5?=
 =?utf-8?B?VHcvY0M1ZjY3MlNTekZzaGxicWQwK1hBdTJZaVdLckQ2SW1kUURWU3VFMCtP?=
 =?utf-8?B?Sy9mT01lSk0vek50L2FOYzZ5UVZrK05zaVFuNGRueGk1TSs3NzVVUzJyOFdH?=
 =?utf-8?B?QlhqZWFUa2EwOXV2ZXVYK1l1T2twRUZvMTZoS3MwcW1aZlFuK3RTTm5ZWGNl?=
 =?utf-8?B?MjZJSWV0SFEzdVAxN3ZYdUVIelFrazhmQXR4WFByR2lueGdsVWc2OUd2U0Qx?=
 =?utf-8?B?ZHdoN00xSUpEQWoyMzljQmdkRXNNdXhzM2VBcis4ekNUU3JGRmpHdjNBMGRN?=
 =?utf-8?B?UENvN1hxcWwwYU5sVm9BWHFUSENlRE9XNjc1ZytCQkdOV2JCamJRa3prTjlu?=
 =?utf-8?B?bnJveHMvTmlEa1BNTGVSVUh2OVV6UUZlbFA2NHljdUx5aU5jKzN1NEh6dW5Q?=
 =?utf-8?B?NmFyTENobUt0MG5zQWdhYXN0MVZvV3Jyck9ZczhIQS9lbnB0cE5OeHNnblRL?=
 =?utf-8?B?Y3RXTy9HeUY0NzJ0VHVvaUplRkVRUjBodmN3QzAySFB2UmhkbXRHaHVpd3hi?=
 =?utf-8?B?Q0ZyS2RIRWxIQ3RjMHpObnhWZE92NDFSV3d1WVhrT3ZhemhwNFhyeHJwLzE2?=
 =?utf-8?B?RTNjbDFINHo0c09vYWZtSDhkQXp3Wjc0ZmlIdkh4M09VRW1UWTBOS0dUNkVX?=
 =?utf-8?B?U21Xcnh3S3RHNWdBbTZyNDhveDVVWDA3QmdpMmk1VU53NmlXMlZ3ZmRlV2Ry?=
 =?utf-8?B?YThXeEFQSW13RnVpTGV2c0U4bHc3UWRhMmZYc0xYQjErVXBqbjVCTHBHTjZR?=
 =?utf-8?B?ck5tN01Ia1VKeFBRSmNYUE9CRkNlUGZvdTVZSm1VUE4zVnY3RzQzczJ5SXly?=
 =?utf-8?B?T1k4RDV0MER4cTVEckRhOTc5SXk0WDcrR1IzVmlrZ3duS2JtdjM4UHMwOXY1?=
 =?utf-8?B?MDhEVGJtaWdMTVd1eXhOc2JDd3MxUTkvOC9lMER3R05jN2hUcEJUekErOUZP?=
 =?utf-8?Q?shEwXERyw+gB9sH9AgZW2vvq+tXGXsrPMLyorxe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(52116011)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGNqT3lpMUpXbjBRRGtQbmh5bkVsY0M3bmh3cy96bysvNDYrSkEyRWpIUTQ2?=
 =?utf-8?B?YlpiKzJzY0NXRXZYd2ExMGZvRmtQVzRJZU9aTEJUZ04zMzZrdC81N0wyRGY4?=
 =?utf-8?B?aGhtLytyV1AvMDZ1QytwWEhzeTExamhsZmxMRjdpaWFKcURMZUVneHRvSVBX?=
 =?utf-8?B?NkxLS0V2N1RGMGNuWklmUnhndlIyUldjaGl2MmFoUDFTTjN6VG03VXdmVXEx?=
 =?utf-8?B?NkVSZkFYWG0rMDk5bkdCN3VzOVdMZkxTd2dmemVKWU8yWDBEbEdXUkRid1N3?=
 =?utf-8?B?QnFZK3NZM0ErM1hxWHFiY1VBdk9maXlhYm4vT01ydXRpbk5raitKL1p0eUh5?=
 =?utf-8?B?QjNWMzNIa2NPT2NkUWFJL1JRMEtzeS9ja1A5Nm9qcXNnWitwTEVjTXpVL283?=
 =?utf-8?B?S01pUDZtM2xpbnJvSzAzaVdhSWRpQ09kaXlCMWo2N25vRG50OFRIb0t0OG5V?=
 =?utf-8?B?Znl1dUxyZGkrN05rMk5VWmNRZzQ5Mzg0dVBobHVBeVZKMzhjMGxYSGlxOE9T?=
 =?utf-8?B?a2g1a2IzNFJrR3VLeFBqaXlJU201RTJ6cTM4YWM3aGRJZVNWSjlRYmp5R0Q5?=
 =?utf-8?B?d2VEY1FhcUFoU2lubll3Y2RCTUtPL2tkVUFXcUg5QTZTenFWTnM2bGI1ZHU1?=
 =?utf-8?B?WDhDaDBKWlhlZHhYcUl5dWFGeXczQVFKalZ1WlVCRWk4aXZiOGRubnRQd1NJ?=
 =?utf-8?B?UkFidlQ1Y0xjZlZYYzYxcFlpbVErcWpxRWhuREpMa2FQV1lKUVBrZEFzaklH?=
 =?utf-8?B?K1pUMlZsVVd2ZTVWYVptNE5SanFWS0l6OG9yRTZiUGFEaUllbGhJNDI0eGNo?=
 =?utf-8?B?QkI5cDV5bXhyMUZ4cVlvMkZ6VWRuNWpTU2tGL3BYdGc0T1JoclNZOUV5Lysr?=
 =?utf-8?B?dkc0bFBZbkxwdUJ1MnZFQ0RoU2RSbm9VaEpFNlhZMEM1YWxPakV3N1RVNCsv?=
 =?utf-8?B?QUxrZ0dZUkdCYnI2R2t2ZEFMYjlZZ0lYcVNtQXRISUFVMTBDRFZnRVY4b2xH?=
 =?utf-8?B?NzlMUXJSb0w4d2JVUGpIdVloZXpKR25kQ0lYRllNRVRxS1F5M1grL0h5b1hI?=
 =?utf-8?B?VWw0SXRoQjJFa3V1dWtTTWRqVEVNQUxENm9uc1l6TVZlUXJnc001MEFHYXRm?=
 =?utf-8?B?TW83NmZFUjlVUEVnUEpObkhDbHcwVFpKRmFtcXA0K1NpTjJ3SlBPUFZVTU9i?=
 =?utf-8?B?aTdQeVRENTRmTkZIMGFXdkk1MnR1Ujl6dk8xVUNLdDBtc241NmZHeWVOV1V6?=
 =?utf-8?B?S1NpS0VCcndVRmxROVpIcjhpZGMwbWVYMHpRTmYzUW5DTFh0dktNMnlMalVF?=
 =?utf-8?B?bGdTR1BiOTZiUU0vajNiSitwU3FjdUxLNWNBQmhXa3F0RC8rdzRlME9oK283?=
 =?utf-8?B?S042UG9zaUZsN1hJMlR2dUIvZ3VqMGVXekZXeFNLRmUwK3VaWnhvZDhlN1M4?=
 =?utf-8?B?aHc5NWIyY3FVTEUvVE5hSE13cThGcEJyZHd6cC92c0E2SnhrRWZucnVxWUlv?=
 =?utf-8?B?ekhDTTgrZGRuM2I2QkEweW1IRGlSSFF6VFVZb0J2NHZtSk9RRTh3dXNRNE04?=
 =?utf-8?B?b0psclp4cGpNdnZVaFAxaEs0WkZieUN3NGw4MFA1QzYrTnRiN0pRS3AyQytH?=
 =?utf-8?B?YjBVK1BHUjJwWmk5c2JrcjJSbUg5anVVNEZxUXo0SmRJaFI2bkZhblVIaGdp?=
 =?utf-8?B?STFzM2M5cXlXN1gxb0RBeFNvU0NpUVF2NFUvc2VTTndzZ0ljZHdaR3Z4MDFw?=
 =?utf-8?B?SnZicE1kUHhjbDdXNVNuV2M0N053UElPMzY1SHR0SmtENG1NZXpKejBUZ1Ix?=
 =?utf-8?B?YjMyTjF6MkVMWWQvRFJKS1lPYjRvTkpyRUN0NGhnYUVlRWhEUkx6WFJCQXZV?=
 =?utf-8?B?R0drWTA0bjRzLy90TkJIRFRZb1UxU0VHeXJINGtDUXN5TnNvVm5Fc2k4Yzdo?=
 =?utf-8?B?Z1pjWHNJclVWYVpIa1ZhUUk1YjJQa0czUnprbXhYUW84Wmx1U1lLNmNzTi9o?=
 =?utf-8?B?dU5YMTMzVWRMSlZKRXRvWXQ0bnJYcGlHV1c5Rjk2QlNMR0JqeE4zK0Vac2hz?=
 =?utf-8?B?T1BtODZIUm5NbzNxelNMUWQ5UkdTQmJVWjBLam84SVVHMm56aktza00vUVR0?=
 =?utf-8?Q?87XJZIL0YnbqSiFOf/i+YY5Y3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56a9bd8-c9b9-43dc-56e1-08dc914a3e55
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:58:44.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4RPXDWYG4Gw06vBSscqeXinEPW4zTft2m3B7REtf4VTjiGCwWympljYA5K7X906pJkIYADt7bm3ctZtgvB2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7632

Convert fsl-dspi binding to to yaml format.
Using common SPI property spi-cs-setup-delay-ns and spi-cs-hold-delay-ns.
Update driver and ls1043 dts file.

To: Vladimir Oltean <olteanv@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: olteanv@gmail.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- using Vladimir Oltean's https://lore.kernel.org/imx/20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com/T/#t
  for fsl periphal part to keep compatiblity.

- Add common property and depericated fsl private property.
- Link to v2: https://lore.kernel.org/r/20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com

---
Frank Li (3):
      spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
      spi: dt-bindings: fsl-dspi: Convert to yaml format
      arm64: dts: fsl-ls1043a-rdb: use common spi-cs-setup(hold)-delay-ns

 .../devicetree/bindings/spi/fsl,dspi.yaml          | 115 +++++++++++++++++++++
 .../spi/fsl,spi-dspi-peripheral-props.yaml         |  28 +++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 ------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  15 +++
 drivers/spi/spi-fsl-dspi.c                         |  14 ++-
 6 files changed, 168 insertions(+), 70 deletions(-)
---
base-commit: 03d44168cbd7fc57d5de56a3730427db758fc7f6
change-id: 20240613-ls_qspi-bdced20e235e

Best regards,
---
Frank Li <Frank.Li@nxp.com>


