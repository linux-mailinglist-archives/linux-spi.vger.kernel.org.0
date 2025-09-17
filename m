Return-Path: <linux-spi+bounces-10060-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C655B7CEE4
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED8D188CCDC
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 07:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7AB2F5A2A;
	Wed, 17 Sep 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aQiTaVdt"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2332BEFEA;
	Wed, 17 Sep 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094061; cv=fail; b=fMRgzi0OGJuvrEhegcROn0i6S1fURSxlWLAlirwYhovbGRxD1F7P8qda72bPE7QDwMitNRcZHixlg88eDeXyPQ2nQWRLb5TwXDR5bmkvkVLdaua+FdAfY6XDAGzLSI3YKkbDgNbEgQeCapqyWhMDyZUAG4Z2wlCLilCqW8Nws3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094061; c=relaxed/simple;
	bh=F4iJMICuKuiFncRZ9uQJVI8kZxkLL8KmEJYLLWTjzzE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DtcxSdAHLzwyh4pQautNiDBvVJrnnWtn+/XFYVyfaJljqoCt/M3cF4OaEGby7OEr9WfPtUPwNysxo0toAeLQrHO83xbLQdIqqb4DnPdQ7ZsOTTawKTqRnKztQJbuW3Hzl2fBsvd3Z7tJJF4S++5WpeyHfbNtapABumvO1kjP4WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aQiTaVdt; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfSZlJ5jN81gnyFgFhwZYg5a04WEpZSBkfQXzSTB2DAxiQzI6hgqKUKAPPaf36DKOuPklVaaWFQM37CoT2EAOSMQlQmrp0wJXj7kegn098XENhftG4PFjrWAhBpZva6AaFrrcscuYJUQl05nGCfg7Lbchd2i75gyB+aDKzk6/hoPnmdB+azJGzs6Z9BqH5cixFmBfB5Jk6vh+JVYDv8nz8LZpZGgeB8+Eyw/lY/NFZKRwAJeDDGU5V8ryjfldFKdXGyxYGlI9oSjAb4dNAtXkN/n8npjzz7l+4T7tlUQN+SC5Hh2Dw5V8fN0r1+CpNRo0Vox7tN1CaJwFi+qoNew8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ/iwTeOaTOxo/au1sUATcdN3B3kh8NhBNrvOPEqkbQ=;
 b=suLwz25t+HAR76ErtdznPtR0GdxIWpXlAJp3Pm/rfIvC/KTosQ1c6N/oJ3FB9jsKWXTKby0rrxPDRixNeLsBQn76ePHvAQtXdNCOxUzxK5DJrRbbrZxSfkPeteLkq+65wGWB6idqnh7Blx4kVf4Poyf7zMvde0sc9TryVrcmIw8AQbVfyrUBJwBZQk34mxqc4LpEMiU9T/6uGWqnlUejxRLcpBr6/TYu9G6mg9vSJxXmxF/BJQg7qVlOHYeNdCPZXHLkT6NWP1+SiYE8WvhRyr24IDPWr2aXNNEWpdEL6k3y2avyaxe/qCPUpVFvNZKOmmxP4SqI/B3Tt9baVGEImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ/iwTeOaTOxo/au1sUATcdN3B3kh8NhBNrvOPEqkbQ=;
 b=aQiTaVdtSFNzs39Qi6StC0kZR0JeROlRWzWWkeP0jphqetDXvDfA7P+9/u2GlTJlbC+uXDKYcBTv17dUNgvTgpvZbj7xPU68roaq0NwSV9NVZEcqexAYgHipoM1UqBcsAtSE4lO5ndjUn7qih19fSTlK3l/jksje2c4doUeB3PSucU7hOfjfcw7+VXz0OF2jXfxCq2VCO7Zk0NZ/OzOtqw7A7EWeNlepurzgIUbgbgPLbQlRBQZ56xbkx0+HGcETTS9x3iHcdV1xalbw4yusKPZVnZs50Mcbq3+HEZfjjAqsSDf3m9zn9/pSMJ43wVqTaopdCoXw5YJzYyB1xB5krA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10800.eurprd04.prod.outlook.com (2603:10a6:150:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:27:35 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 07:27:35 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v2 0/5] spi: spi-nxp-fspi: add DTR mode support
Date: Wed, 17 Sep 2025 15:27:05 +0800
Message-Id: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMliymgC/23MQQ7CIBCF4as0s3YMUFvBlfcwXdQy2EkUCJimp
 uHuYtcu/5e8b4NMiSnDpdkg0cKZg6+hDg1M8+gfhGxrgxKqE0b26J605shobUKnT9K19mxGclA
 fMZHjddduQ+2Z8zukz44v8rf+dxaJAnvTdvre2Un36urXeJzCC4ZSyheg4hkHpAAAAA==
X-Change-ID: 20250916-flexspi-ddr-f841f3d79aef
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758094070; l=2152;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=F4iJMICuKuiFncRZ9uQJVI8kZxkLL8KmEJYLLWTjzzE=;
 b=kky7dohasHNI0cXziHA9xdQgwVTFcOxeOBBD1adMo5YNU+yqO+2+zvw95SRWXoSOg/eL8q/3p
 3YdeQnlJbEDD9UiNPn+hddwzeENAzJLPqlBgEuFcPox9somhF3xN6Xe
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10800:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9e62ab-8be0-4a98-942a-08ddf5bbabc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0FVeC80WmJ5blVxeGs0S2Y4K1Bwdm10d0J6eDRHNkJVNDd2T1JSWXJHbWhK?=
 =?utf-8?B?UklHRVRBK09WVU9GVmM2THRxYVducWVXUUV4L0Vla3NoMkJPMHpmZ1VQTEh5?=
 =?utf-8?B?U3ltQTRucS9HVi9lYUNOU1BWU0lrQ2FsVWVBbElUTTVaNXY1d1hWZFFWK3kx?=
 =?utf-8?B?Nkk0d3phK3RiM1hyR3N4cHlKRDFuaFY1dlVWVGlJN1dsYUdyQURvekwzSFJF?=
 =?utf-8?B?MFZnQVhjNU01bTZrbGFXL2hvVmFwS0UvOWcySVhlOE9qME1kU3V6Qm1XNzdR?=
 =?utf-8?B?THlsNnVNUytxTHd1aFIvWlN6YWI0WHhMNnhrZ0xiRlFEbGhiZkQxWEN1M3FL?=
 =?utf-8?B?cC80aXcveW1qTmo2UUtibnRQMDd3R09UczllN2RRL1dWOE9ud2V3ek5kSnc3?=
 =?utf-8?B?L3o1OHp0YzFlRHo2THF0anVhVTRHbGtDb2ptUTdINnB4blphWUl2TlB3UTAz?=
 =?utf-8?B?K0ZZMEdKc1hHUU9MTDRzcXlZUktSWjJvTXVteWdKK2lybC9jbEdTNENlVk5k?=
 =?utf-8?B?b05aRlMxRUY3WXlVeWNjRDB5OWMrZEpScXRSU2lhSmdNd3BpcXNiV1RKWTZh?=
 =?utf-8?B?SXU2aFllbjgwOC9Od0pOTDR6Sjk0NXVXbWRyckpNUVdES2NDb29GYXppS0VM?=
 =?utf-8?B?Zi9XVG15ZExaazlESEpYNnFoNWIxNU9YSzlzbkEvM0Rlbm0xeURJWlB0NmdK?=
 =?utf-8?B?V1VYajRtN2ZrNjV3VWxZdEZSekNCcnpvWFNxM3BMOEV5TmlxeUo1NlJCdkhB?=
 =?utf-8?B?VlJZYndhT2hkZXdJRVhRalp2Zkg3WGM5b3pUUVcvVHl3RmRDekx1VG9sTUZS?=
 =?utf-8?B?S1NLeStuU2tLQ1AzbWN5cXV2WlpXajRnRzd3U1U3Zno5WnlDd1NLSHZFeTly?=
 =?utf-8?B?aE0vM2M4YWxYODIySTF2c1ZHczBFb0VJeC9lUm1RemNCRlFJWTg2OGFPMDBT?=
 =?utf-8?B?ZlNWT0lNWTBUSEdjbDE1R1k4RmxZUEJ0bmdwb3FxT1EvMkJ1OGlldzR1b2RX?=
 =?utf-8?B?UFh6OWs3QjlnYW5uT25mTkNPVFlKenIrV1FxZlB4QlA4QmtpTUhHdWQxNnMw?=
 =?utf-8?B?VEJWM1c1NVg4eHdQZmxJQm10SGdwQUNEeU9za2NXdTBkY3UyV2ZzUFU5N0lm?=
 =?utf-8?B?dlJRa21sS3VQOE1BTENYUVVrR3E2U0cwSDJ3NmZ3K0ZpNnlHRWxrWmlQaldI?=
 =?utf-8?B?K0krQmFvVUloWndEc01udUlqVUV4UHBQMjJMcm8vOU9WMzJqUW1zZVF6QVdl?=
 =?utf-8?B?WWRwUTh6K0RwT2Ftam0ySmtJcys1QXU1VjNmYkdJNThUbHZINFFzemVXaGxP?=
 =?utf-8?B?ODBmcTFqS1QrQXNtNTlwVkpxRHQ0d2NNVWxuY29DYk0zemJmMlFsL3hmRXpO?=
 =?utf-8?B?SHJVQmpDRkV1M2ZQMEdoYVM4NTc3bjg1VnhZNnJDdXNBQisxd21lcU1WUzVm?=
 =?utf-8?B?VUQvTlB5U2RYY20vWHp0VytXdTAyUy9uMU90Si9JcmxBVXRaRTV6U1pRQjZI?=
 =?utf-8?B?S2wxTWRSU2crV1RFTUJ1N0p5TmJpQnlNcXFuUmI1cExDeHdPZWVscllpbStO?=
 =?utf-8?B?RTEzLzNUU2Y3WThPcXNZNkd1cXNMQm85OEJ5YjNWcnI3dmEzNkFpRE5JV3o3?=
 =?utf-8?B?VS90TXVPMU5TVE5obEpsRk8zS3ZaQTh6SjRReHdFNis0bVFJQzV3QnQ3c3c2?=
 =?utf-8?B?cCtnd3BWeWVYYXg3VTc3SmUwRFBrYkp6cjVBUVpxd1pTZ1U3ZkdIaHdKMnV1?=
 =?utf-8?B?cWdTaTZBTTRsY2orVmZGSXorVCtkT0JWQ0NySGlSWGRRdGFvZkZ1cDVPQWJB?=
 =?utf-8?B?MjJ2NFpqZzkrdWw1RnRYTFQvS2tHSStaWG1JWDcxRzIveFZkMVVGZnBJRGRk?=
 =?utf-8?B?TVpHdHA2M3NFbENxeEtBZFVqQU8rdFJzNXR1SklSQkpibGxDb2xCZ3V1SVMz?=
 =?utf-8?B?SnhmTEZ1RWZyVDU4aWRrZ2hUWWZEZzYzNHVZZDFneHEzejlPaCtLQyszWFFm?=
 =?utf-8?Q?KsVfpsIq0Z/iKGxYfjms9eGSNxenuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVQrN2pweFlpTGU4dHRMYnZoRFRjTnNMakR3TlhreHZZeHgxbWJJbThBR2Uz?=
 =?utf-8?B?UmpvV29lN0cwaEFQckN2c2pacGc5VERhc09QM1BlU1VtTkRpTm9nTnoyWGg2?=
 =?utf-8?B?b2FpMk5oY0ZTamExS1o1UDVLUiswMGMzRWprR2VJUStzUTJUZ2V1ZXovcExn?=
 =?utf-8?B?VGpZLzl3NG1DMVBnUEMrT2dweXZKK1JFK0dQRUQvZW1MdTA4bDZFRDg0M2Y2?=
 =?utf-8?B?eGNKQ0FQOFZ4NHlLa3dTMmh5eHFZR1hjaDdTWnhibjJMZXJlZHVwVzhBNFE5?=
 =?utf-8?B?czlCZHFid1FEaTE1eHh6bXRaS2hXc0hPMEdxVjdhejNjSDF2bU15OHpNb2p4?=
 =?utf-8?B?RUNSSjAwNnBlMVRXcFpmdnp6aU4yVkxPNnNXNUpHRDVMcm85NGtpdHZqeHcw?=
 =?utf-8?B?Z2JpMnkvQ3FoUnhUK0VlUzhGV3lpcnlUbFZ2UzN6djkzc2NVS1p5SXpka1JE?=
 =?utf-8?B?UFZCL01zRFV5anRMZHBPN1Z0SCtZdlJpRG9KZUwxUnVjYWcyL2RZVnkwaCsr?=
 =?utf-8?B?cG5iaHFXNy9xRyt6UVo2bTI1RUZrOUplYmRhWVREaUFibzMyWHhvK0lSMTFm?=
 =?utf-8?B?Yjc3c2dWbGk0eHVTV2dGUVpaUWM3eGh2emJ6Nm1MdnMwM0NpM0JnaHJUWm0y?=
 =?utf-8?B?Q0pwaXNybVYvcmtWK3BBcFAvSjJoUmNERjZwL3huS05MWkNPbXdEQ3o5YUJQ?=
 =?utf-8?B?NjNZTWlMNnA1b2pRZ2tnakJIbzlOMUcyRjhSTmF0NDl4QVpodUVsOGJtL0hw?=
 =?utf-8?B?Q2NkQ2dud3hnKzFUUDk0YVBVUVFVc3JJRXRqUk9JOE1peHdjSnVORTB1Ukd4?=
 =?utf-8?B?eUU5aE1meFpGYm1oRlpyYXJMS2p4M25FMElsdElnVU5COVRUcUFXencvSnZB?=
 =?utf-8?B?QTJ3ZW1kWXRpN0VBcVdYRkhkcjBFZXdZeFprVncyOW9saGRGRzVEM1cxb3cw?=
 =?utf-8?B?VFZuamd5WkN0UkNzSmRmbGRUYmVGbytreTR1QjhHT0J3OXdybit4dTAvZGsv?=
 =?utf-8?B?ZWRNU0tUZExMSEdZb1R3NS9zMUVLemxCSStBMVF3Ykh3SkF6U3gwcEY1T21M?=
 =?utf-8?B?YVhNNHRXOEtXWGpxM25YNXYrNHFjd0xwNjM0YUs5dmlIaUJGYUhwVHBQR0dU?=
 =?utf-8?B?SzBmc3hDeVY3MVZZZWZXTDk5SEx5Zlpob0lyRWR5aDBveE9hZnJiYm1CRUk4?=
 =?utf-8?B?NEh4SUtxZllzazR5L2pBTFY2b1VpSTFBcGF3YW1FWW5QYjZIRWpHZXZUYVNX?=
 =?utf-8?B?N2EvOXFEeGZ2b0ZHSHcvcW15SnZnam85R1gwd1hMVVRsOTZQRitaRjN5amY1?=
 =?utf-8?B?d0VGTnQ0MDlCcStSVXJPNG8rZjV3Uis4eFhrcUs0SEtGK2RON0lVaGxTcmpP?=
 =?utf-8?B?VHRqNHk2WjNiS0lxOWo1VzJOT0kyVjlWcUNGa0hSQnVib3dxaUF6SGNNb2Uw?=
 =?utf-8?B?UkVEcEpVLzdUdGFxcnR5NjRySjdiYlYvUlRuNlV2a1lGT3J4TXc4QzFqT08x?=
 =?utf-8?B?WWlXT01CcHJYOTRnMjZ3TklFcTRHNnpGZUl0dFZDZEY2U1ZrRGlPckRlbVZu?=
 =?utf-8?B?K1o0Ni9ySG5xT1NNeVJQcEd2eHNJK2RMV2hTbHZjVmtGajViN09zZldqNXpo?=
 =?utf-8?B?L3BKYU9nVTYra3ovWG1xVXFraUxNYWpxTk9KUE9KSHEzNk1Ta1J0SFhwWURP?=
 =?utf-8?B?Q3JTUENwMWF3UEE0RWJWQlFnQmtBOFA5N2N4cmM0ZG5KYzZvcWxNQmI2Q1dO?=
 =?utf-8?B?ZEVhUEZPNTlhZFFDb29Gd2lKS2VOYllhOXpKdW9uZWZ0NDh6OUR6TC84TUw0?=
 =?utf-8?B?dysrb0JUdWdNU0FxczQ1WUZwYnZ2RnE0bGdsRnpNeUs5WmllR3dqRzdYUmMw?=
 =?utf-8?B?ekpjWldXOTJUemU4d253YjdPOU5qeDl6ZXBhcWIyaGZ2em13Q0RqMzBreFgv?=
 =?utf-8?B?QzlSMEJhYnBnZk9mZUthR2k2TVR2eFlmem9JSVk5aTRqTzhSZmFhMU5PZkV2?=
 =?utf-8?B?bGNQTHNyN2FidFZLM29RTVRCYUhSaGdQbXh2NGRBOStWTVRFbDVWTmZSRzFm?=
 =?utf-8?B?azdCTENqd0ZxdFl4NGM0TVJtaXZOODRuekc1ZXNnUkkzREFCTDYyVVNaOEtS?=
 =?utf-8?Q?7ThEkwnTmX1Tg/l2FEBPREDbH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9e62ab-8be0-4a98-942a-08ddf5bbabc4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:27:34.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRpeSp2JjWgf9dg7OpePOg6zuqyhmbj0MQqXCu9YtdeYw7//R79p7doRE+MxbtuJJDuaSwtX0S97GFGVHAqd2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10800

this patch set add DTR mode support for flexspi.
For DTR mode, flexspi only support 8D-8D-8D mode.

Patch 1~2 extract nxp_fspi_dll_override(), prepare for adding the DTR mode.
        in nor suspend, it will disable DTR mode, and enable DTR mode back
	in nor resume. this require the flexspi driver has the ability to 
	set back to dll override mode in STR mode when clock rate < 100MHz.
Patch 3 Add the DDR LUT command support. flexspi use LUT command to handle
	the dtr/str mode.
Patch 4 add the logic of sample clock source selection for STR/DTR mode
	STR use the default mode 0, sample based on the internal dummy pad.
	DTR use the mode 3, sample based on the external DQS pad, so this
	board and device connect the DQS pad.
	adjust the clock rate for DTR mode, when detect the DDR LUT command,
	flexspi will automatically div 2 of the root clock and output to device.
Patch 5 finally add the DTR support in default after the upper 4 patches's
	prepareation. Since lx2160a do not implement DQS pad, so can't support
	this DTR mode.
	

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v2:
- split the original PATCH 1 into two patches.
- PATCH 3 put the ?: in one line and add Frank Li's reviewed tag.
- combine the original PATCH3 and PATCH4, and simplify the code logic according to Frank's suggestion.
- rename nxp_fspi_mem_caps_quirks to nxp_fspi_mem_caps_disable_dtr.
- Link to v1: https://lore.kernel.org/r/20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com

---
Haibo Chen (5):
      spi: spi-nxp-fspi: extract function nxp_fspi_dll_override()
      spi: spi-nxp-fspi: set back to dll override mode when clock rate < 100MHz
      spi: spi-nxp-fspi: Add the DDR LUT command support
      spi: spi-nxp-fspi: add the support for sample data from DQS pad
      spi: spi-nxp-fspi: Add OCT-DTR mode support

 drivers/spi/spi-nxp-fspi.c | 115 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 98 insertions(+), 17 deletions(-)
---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250916-flexspi-ddr-f841f3d79aef

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


