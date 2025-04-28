Return-Path: <linux-spi+bounces-7781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC6A9ED7E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 12:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC473B1924
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F926200138;
	Mon, 28 Apr 2025 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YbWWHP0h"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAB25F996;
	Mon, 28 Apr 2025 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834713; cv=fail; b=bh7HPiacELGHB0EylWJoeboraeVRXUX6meBNYfXRcQ4lUpxrahBNjR+oYE29hqLW7wF46fFPUQZMiKjULm9mM0BCGvJ5qeeJA18nUx+qSAj5JmmLV3fD0gGJ+Zc7cjq7ta4AcQJSyMIAy3+6azN4kO6rB5Kw9AVy5DuXMPis+wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834713; c=relaxed/simple;
	bh=EHGi95nTlhRjlYTPcmNSAMw5IUnu/bcxt4hNUpvsWzM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Gm4fIi5pvHnb+K9r6jjHOFsLnWHbYe6DRqc4Ar/8BfQhpcV3ZqA8DBciFsjH38oQtinQOPgOkw00RZ2ZQ4oqUb+bXiot5kl9rGE8QSllBPpxWo6ExsCI6ru4ffT3awmEEZad36J6aAJWV8PaUMjXGCf0leKARrG8B41SDXQMPrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YbWWHP0h; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiQxbB+o5fEQyXIid6A2kExeK4EfDrOXcxoXVVh+B3Mk6x778FNCpoU1+WZDkggTNMiSb4nSrtGoiGnvjqzhTP2WsdwXfUepZnpQ1zPrMic3T/aE/WtmPCQ7//X+HoRy+nfZ3+h2EufA3HcGKj93z6ZA6zWNly0U60d7kzgKhROdslHic34x6AIn5EWlL5Ej6kjbk6Bx5FVxsuQiprIIlOobuIgczaDqvMBjebw26bup1MdhXkyUV7xijprHRvhg0FKmBzJ1D1MKIjQzEpM1Q11GzHiGaBshjg79ZWDJPZesv2ZX5hqE5O75Gk/1CWUBzO9bSsou7qOEzBffzLbH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk5U3cUoUE0U+f3XcRp5iwBviiPiPHmZexOFQhIIl6w=;
 b=Z0IMX2U8Rw+h0SAq81AtDOItMWk5VUg5MfoRJDQkuiiDhYxDfYZ9rH914pJ6DRqby9h0ao6Kb6O4WF9b74noh7aHZlfWGCRwCHBZTHogv+UXAXtzpn0usp6gBctvZe7u71T3ux9iqhoPg/y/G3koPxl2d/Sp0/jQp0OWLXAWWIGBUBbdcxy8FHhVbf/RIuWjDju5+HTsNzDanHtOxcb0sv/PU+xbYaHSptXLEQOmNE/qI2sdEMtLdTPxA1ToJPxGtZMHMROF5AcmSweQzQzpHSfzPEYJ00VlXYSmmMU2CCfoo72/nc+0N45CfOMqOwAGfKN0NQHdAebr1KECmlpSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk5U3cUoUE0U+f3XcRp5iwBviiPiPHmZexOFQhIIl6w=;
 b=YbWWHP0hVhEzjjLi5AmlhgEpmUIhFn86WfspP4yX0u2q1yJ4cC+I7sdCj56TPt1GP4Z2pa+D+7mOt43bqmJbOjG8+k89aY0XHgoi5QdajOeHnomPO0tUgrCsVOM08m4A9l9eRE1KL4/MYX1fUwKIG0qIcqRgvkOVzPz4uOX2Xo7aradK7huPtkmhw68zk/sbBUAWuGgFwfZOUCIoHj+b9GQBcBno9bNUy2ZdrnlICu0EquljTYcUY0MmsVerztDAtZevivNUjXtNa77nc2E0P6d38L1xatPiG6e0jEyUwK3DAVg/YNCRBCV+VZPh8TILGUPEQx4L7muH5Dir/uPdgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:05:08 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 10:05:08 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 28 Apr 2025 18:06:44 +0800
Subject: [PATCH v3 2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-flexspipatch-v3-2-61d5e8f591bc@nxp.com>
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
In-Reply-To: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745834827; l=5964;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=EHGi95nTlhRjlYTPcmNSAMw5IUnu/bcxt4hNUpvsWzM=;
 b=2pD/NN5i0GmoG7Qt0ascRpOI89qKmY15/OI8CGLemTOLUUcdypNyPH4WcAeM0qN3RSEoRV6cP
 KvA4P5k/VJxAWDCp3G51djKW0BVpzMsttGTLLlhh+J0q639jaL67clb
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAWPR04MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae302d8-5c99-4089-3a1c-08dd863c27ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZpenJIVWU5bWpmY0JycjJUREZIV09JU1dIT1FSZnBteGE2UGpJY1pPdmJj?=
 =?utf-8?B?ZVQ2TVp4emFVZGNDSGJPU1FZaG1hMlp1bk56TzBWNHFGb1JvN0tPcEwva2pt?=
 =?utf-8?B?VTF2QzZTV2dmZ0JmVDF5bUtYOWpGTGxqNzdiSVNkWm14d2ZwM3ZZcHM2NWs4?=
 =?utf-8?B?dkZrUzNKd1VWWXJiRlVJc1RtbWRzSE1PWmVtc2FJSGRXUWtKOStXR25kQUxz?=
 =?utf-8?B?TFMxbEkzbjhyUEpVRk9rZFNYZm93Q0hoQUlmOHIrdGVZR2VIbGVUZnVxVllm?=
 =?utf-8?B?dE9ZWExXZTJmd3o0dTU3VGFnM254ZkJhaEJiSlEvYVU3eXFsdXpkbGI5Zlhh?=
 =?utf-8?B?RzFqYVlscnI0b2w4cE9wMVV1SjJ1NmhxbzJnM3NVamxHcXViOXh6ZGgvSXkv?=
 =?utf-8?B?RzI1Zk9wd1FYeHlnamNIZ0pNQmNJVGwzN1pRUHFva0xwdmRFVHlTcGRhakla?=
 =?utf-8?B?SUxmblVZN1BydEptaFZqOWVrSnJmMWx6bVdieDBVR2k0bXRKZ1piNDh6ckYr?=
 =?utf-8?B?R0lWRmpzeEUyQmorS2NKTG50b3QrVVIzNWNKLy9ZMkdUM0FXd2FNTldrZ3Ry?=
 =?utf-8?B?WEszVDdaL3pYWlRvcUh3RC9VendYUWE4MXp6MnFjUmoxUWMwTitnQ3JjQ281?=
 =?utf-8?B?YXpNUHhJalVQdkdlQU5xbHNiMU4yZ1o2d0xUeHRHcmxDV0h5TWNwdkVKZzZk?=
 =?utf-8?B?RG0vOUFyeDN0Y1ltZkFZbld1ZllVc0JPbGJLbXpkL2tLT21DMW81Q0pzeFUx?=
 =?utf-8?B?dzdzOXFwd1VYTUFoTDRZcmxVbHkrekJtWU1qS1JxaFQ1RzF1R05XajNrd09n?=
 =?utf-8?B?ZzJNWUM5c0xDT2d3bHJlNEdaVlVqNTErYmt2cXNzQzZiRkF3bWRIdGsxT1ZI?=
 =?utf-8?B?RURSOGJibjVZMitSN1d5eVIwbnFiMzRSUkJtdU1yd0FwNU9IMjhvM0NWOEFj?=
 =?utf-8?B?RmtSZzU0cndtVU5oOUl4a1dPNEVHd1VJOGd6dHJ5L1NKeWhjNEl3Snc2b1Y1?=
 =?utf-8?B?b2ZxcVZwOEFQRmZob3hxcW84STJkVno0cTVuYzNxcXZDS1pTQVN6K2k3MFkw?=
 =?utf-8?B?eThPNC9xbHM4UTZQYzJqVXVCU1VDRXdyTXVCTE5XVGdFb2ZlNklGOW40NFBN?=
 =?utf-8?B?MUdSaUsrZG1IdmN5Wk1wZmV1S1ZuY1JHVmgrWWFFbmVLYTl1enFheVMzWmEr?=
 =?utf-8?B?VXlMcGlUSHJ6Sk5zZ3FnK2prd3BNb1p0YSswWWJOR2NFWm1jVlU4LzlyQVJ6?=
 =?utf-8?B?TW54RmRoSVNoQ1QxTWVtaHFsdERiR3JMdFZZY3ZxMXFQb3JDMWxpZEV2ODU2?=
 =?utf-8?B?ODlMR1ErSzJaLzN5SHlITG5pSTJUd0pVNW1SNmpYZTBIMEhsY3NWUkplVVpX?=
 =?utf-8?B?YURLSGNwSGthcnI4TExZUEU5cjkwRmN4R3hVR2RxSlh0djMxWlpMMzl5bkxm?=
 =?utf-8?B?Q0RMR3N5SmhBMEhvNm1WWlRoanZzcjRMWGdsZExqYjZ4NE1VNi9WaU5GZ3Yr?=
 =?utf-8?B?dUx5R0lRdUFyY3FGRDFjczU0dDVaQ0xwNEV2L1A2TWErT0tXd1Y2dEtmRlpq?=
 =?utf-8?B?ZWxNSFdlNVdIQ2pnODdCdVYxWmJ1eGh6WGlOVHEyeUZmSnd0YzlIN2t6cVVI?=
 =?utf-8?B?STVmR0g1b0NzN0kycC9pMUNOdUw5NkF6T1NiQ1h6Vi95TGx2Nml3NUtjZmVo?=
 =?utf-8?B?TTZjeW1JR2RnUEljYUhCREk5NUhWOVhNenJxY2NZbk83QU1qSVB4ZmxlTGpG?=
 =?utf-8?B?V0NiU3A3NXlXdC9PNWNSUDR1R3lqVWVlcXRHRmF0T0FZTHVLYVlwRkl6eW1B?=
 =?utf-8?B?aXovdVdhOEdSNnYxM0cva21teGkwdW1NOTlnWVBiLy9DOWJWZjlTVE15bmpq?=
 =?utf-8?B?ZFBTZmxadHU0RUJaYVAzQm0xckxVUkNCZGVtaUdyRmo4NWl2SXBITm5BdEN2?=
 =?utf-8?B?d3lHL3VNVDN3WHdkU3ExWmVSZHptNDZIdVRRczZOcjhZWEVqUEV1WXNJbXd0?=
 =?utf-8?B?TTlxeDhlUnV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDVHME5WYmw3R0NZMG5aQVZXWGZHOGRsYllCZGFYdWdPOWptZGV4MlplRERh?=
 =?utf-8?B?M1k1QzRQR3JjMGRPWi9BUVpUSVpjdUJtK3UrdGpLZCthbVFoYVdHYlBnMEox?=
 =?utf-8?B?eFNUNkZHVU1DY0N2Mk1MUTIwU2RLdnJoZ09ObDU5WEpCWUtLbXp0L005Rm9y?=
 =?utf-8?B?YzNhaHJ1MWE1QWN4YVQzem5YZHFxWDVyV0d2NFVQbStJVFpJMmhxMlpPWERo?=
 =?utf-8?B?aHhqa0hHM2NqdHhlb24rRnNXQmVKbEFubDVvTW9mdjloQWl5RFVaMmoyczQy?=
 =?utf-8?B?RjRyMUFjREFFeFVWcitNaDJEVk00cmhNNE1LVXVCVWxtM3hoSlBySHQvUUk2?=
 =?utf-8?B?eDU2dkhkT1lXK1Z3ZG45M3ZBQW5qajhlVXM2Vmx5dzFlalRtU1BMaTErTE8z?=
 =?utf-8?B?cHJjT2FuYnBvZTV5N2dPeCtwalYxdm9ZUlA0T3M1eXRBT1pLKzFKRHZaQ3J2?=
 =?utf-8?B?N0RlaDluK1RsQm1ESWx6aVA5b0laZzJUeGM2cDluVWtzd2p6N05NemVPWjFx?=
 =?utf-8?B?R0dUQmdMenZUVUhnWUdDUGNzb3FLUVlGVVN3VmR5bnNLSkU3NHNwNzBFaUE3?=
 =?utf-8?B?bUc0NWxHUE91UVM1Mjh1TzNGWmtmcGpMT2tKZmpOWHBxUVB2OHFGS1BKTTFh?=
 =?utf-8?B?cmJMQ2pQWXNEZmd4T2hqS0ZkSEtQZXU3Sm9IcVpnWmV1ZHZ1TE5MbE1OVWtD?=
 =?utf-8?B?UlUza2tGMHhMQk9tWGR6TGNsd1p2djU5MHFiK3hveXltcVVQZ3NkUXk2SmNG?=
 =?utf-8?B?SFhOcnBMcVcwVGlkdVU5V0YwYXFEWjcxVUY5cklHdXFHVmV1ZXpUM1BQMktr?=
 =?utf-8?B?aDE3MXZZRnB4dHNGcmRmM1UxRUFweW40aWY0VXliMG9lc01YZmFUNis3YWxF?=
 =?utf-8?B?QURLR3RYY3Q1V0xLWXlRSStCUk9lckF0WGI5bFlFUkZaM1BBRGtjZnlHT1dU?=
 =?utf-8?B?dUVxc05KTFd3cUE0YlZxWEF4RDRRdTAwRk4vRnlJbWFVeHhsM3pHWmZna2pa?=
 =?utf-8?B?WjFJS0Y5MGJWT2F0Lyt5V210Z0crbS9Kb01xT21XbUdQa3o0NmZHaXd4SFVI?=
 =?utf-8?B?TE4yUjdJc3RpUVZOVDlCVzd1d3piQllmSE0zcDltV3VaeTFLMzkydzFpMEJW?=
 =?utf-8?B?K2xEYkNSbjNOck9wSzFrTmxLR2pNUllxUkJYMDYyQ2x6bzNvdko4SFJUZ29J?=
 =?utf-8?B?dmlaYkpSaTFuYk5PU28vRmRTOC9GbFE3K080WGh3eW9LWEY0YmdFMWRDRHR0?=
 =?utf-8?B?L1lFaVZVZ1NHVGJSWUNDYXVHalhaOHF6NlJLakVjT01hQy9RdWdIbzZCcWFD?=
 =?utf-8?B?Rnh6blJ1NWRXR2FvYmt4cGZQN3lsRTZSWU0veUhLQmVJOXZ6WUw3MXdZMlZV?=
 =?utf-8?B?REpKU1Z1cmVORU4vSnozWU0vTVpwSkRxRDNSRFZ1clVMeDI5dW9EemkvTGpl?=
 =?utf-8?B?bFZZeldqMVYreWdJdWY1TE1yWS9rcTBKZW5tN05iSERoTWNYQUpOeC84OVgy?=
 =?utf-8?B?NE9SdlRjdDJDZzE2ZXFwTm5ZTlVYSXZJYWxvRDZSYS9maU1RVm5oOWt1dEZS?=
 =?utf-8?B?Y3FuOVBKcGFxZFdUTEZWM0RPN3dEWVhLSzRlUDB4S3poZjQ4Q2s3WUlxV29a?=
 =?utf-8?B?Wm1NV29mUDJscXlGWlV0ZlpiblBaVnVXYW5QMlBRaVQ1VHlUaE5XRDJYMGtl?=
 =?utf-8?B?QmY2Y2RZdGVRMXhucEhUWXpVQlVrY2NmUjFxZXZGR3FZS29XdjB3MFJSdVda?=
 =?utf-8?B?RTFEZ2hZdm8wSk83czJvQ2djOFVzSDFOSVoxZDFreG0zOU00WmUwaEM2VU5x?=
 =?utf-8?B?SGZpeUVaVGo3MzlzeVdkZjlSSXVlVkJCR1RFTzBvaE42bW1hVFJ6TENUMTVD?=
 =?utf-8?B?Y0YyMnJENWx1bDFOcjhKTkovTWtmN1VFRnRlcHQ3emxhdUpoamlnWUIzVWFW?=
 =?utf-8?B?UWtSeTZKV1BDeDMyVDVYLzluSzlMeGZLd1RXUmkzUjI3Qm44dkQvb0hCajlV?=
 =?utf-8?B?VlI0cmxrSzU1QW02SEpGam9zQXBreUZqaDRlNG9jNk5xalRSNUlNWDk1QmRu?=
 =?utf-8?B?VzdBK0NrY2pzbjdrTlpFbGVVQ3NuWXpDL3hsdlBPV245Tjd5UUJaakFVenpl?=
 =?utf-8?Q?++QHGCypXI8LmV7mvpmQXR2Oh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae302d8-5c99-4089-3a1c-08dd863c27ba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:05:08.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojwgNYDPm9on6awbVM59bTvd8xO70MVrFr4hCFUXMsax+DxdKh6KXQt4jfZYR8Z24h7ProB/nqetEz2h+pG9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862

Enable the runtime PM in fspi driver.
Also for system PM, On some board like i.MX8ULP-EVK board,
after system suspend, IOMUX module will lost power, so all
the pinctrl setting will lost when system resume back, need
driver to save/restore the pinctrl setting.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 93 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 00da184be88a026bf562c9808e18e2335a0959e9..f7c3330a19009223cbffae8673d264246418e561 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -48,6 +48,8 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/regmap.h>
 #include <linux/sizes.h>
@@ -57,6 +59,9 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+/* runtime pm timeout */
+#define FSPI_RPM_TIMEOUT 50	/* 50ms */
+
 /* Registers used by the driver */
 #define FSPI_MCR0			0x00
 #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
@@ -394,6 +399,8 @@ struct nxp_fspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
+#define FSPI_NEED_INIT		(1 << 0)
+	int flags;
 };
 
 static inline int needs_ip_only(struct nxp_fspi *f)
@@ -927,6 +934,13 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	mutex_lock(&f->lock);
 
+	err = pm_runtime_get_sync(f->dev);
+	if (err < 0) {
+		mutex_unlock(&f->lock);
+		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
+		return err;
+	}
+
 	/* Wait for controller being ready. */
 	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
 				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
@@ -955,8 +969,10 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Invalidate the data in the AHB buffer. */
 	nxp_fspi_invalid(f);
 
-	mutex_unlock(&f->lock);
+	pm_runtime_mark_last_busy(f->dev);
+	pm_runtime_put_autosuspend(f->dev);
 
+	mutex_unlock(&f->lock);
 	return err;
 }
 
@@ -1216,9 +1232,14 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "Failed to get irq source");
 
-	ret = nxp_fspi_clk_prep_enable(f);
-	if (ret)
-		return dev_err_probe(dev, ret, "Can't enable the clock\n");
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FSPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+
+	/* enable clock */
+	ret = pm_runtime_get_sync(f->dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable clock");
 
 	/* Clear potential interrupts */
 	reg = fspi_readl(f, f->iobase + FSPI_INTR);
@@ -1227,12 +1248,14 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	nxp_fspi_default_setup(f);
 
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to disable clock");
+
 	ret = devm_request_irq(dev, irq,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
-	if (ret) {
-		nxp_fspi_clk_disable_unprep(f);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request irq\n");
-	}
 
 	devm_mutex_init(dev, &f->lock);
 
@@ -1249,29 +1272,70 @@ static void nxp_fspi_remove(struct platform_device *pdev)
 {
 	struct nxp_fspi *f = platform_get_drvdata(pdev);
 
+	/* enable clock first since there is reigster access */
+	pm_runtime_get_sync(f->dev);
+
 	/* disable the hardware */
 	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
 
+	pm_runtime_disable(f->dev);
+	pm_runtime_put_noidle(f->dev);
 	nxp_fspi_clk_disable_unprep(f);
 
 	if (f->ahb_addr)
 		iounmap(f->ahb_addr);
 }
 
-static int nxp_fspi_suspend(struct device *dev)
+static int nxp_fspi_runtime_suspend(struct device *dev)
 {
+	struct nxp_fspi *f = dev_get_drvdata(dev);
+
+	nxp_fspi_clk_disable_unprep(f);
+
 	return 0;
 }
 
-static int nxp_fspi_resume(struct device *dev)
+static int nxp_fspi_runtime_resume(struct device *dev)
 {
 	struct nxp_fspi *f = dev_get_drvdata(dev);
+	int ret;
 
-	nxp_fspi_default_setup(f);
+	ret = nxp_fspi_clk_prep_enable(f);
+	if (ret)
+		return ret;
 
-	return 0;
+	if (f->flags & FSPI_NEED_INIT) {
+		nxp_fspi_default_setup(f);
+		ret = pinctrl_pm_select_default_state(dev);
+		if (ret)
+			dev_err(dev, "select flexspi default pinctrl failed!\n");
+		f->flags &= ~FSPI_NEED_INIT;
+	}
+
+	return ret;
 }
 
+static int nxp_fspi_suspend(struct device *dev)
+{
+	struct nxp_fspi *f = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret) {
+		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
+		return ret;
+	}
+
+	f->flags |= FSPI_NEED_INIT;
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static const struct dev_pm_ops nxp_fspi_pm_ops = {
+	RUNTIME_PM_OPS(nxp_fspi_runtime_suspend, nxp_fspi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(nxp_fspi_suspend, pm_runtime_force_resume)
+};
+
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
@@ -1291,17 +1355,12 @@ static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids);
 #endif
 
-static const struct dev_pm_ops nxp_fspi_pm_ops = {
-	.suspend	= nxp_fspi_suspend,
-	.resume		= nxp_fspi_resume,
-};
-
 static struct platform_driver nxp_fspi_driver = {
 	.driver = {
 		.name	= "nxp-fspi",
 		.of_match_table = nxp_fspi_dt_ids,
 		.acpi_match_table = ACPI_PTR(nxp_fspi_acpi_ids),
-		.pm =   &nxp_fspi_pm_ops,
+		.pm = pm_ptr(&nxp_fspi_pm_ops),
 	},
 	.probe          = nxp_fspi_probe,
 	.remove		= nxp_fspi_remove,

-- 
2.34.1


