Return-Path: <linux-spi+bounces-10203-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA06B8FA57
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 10:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CC2175B47
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A557286D45;
	Mon, 22 Sep 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z9rSaEAG"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A31284669;
	Mon, 22 Sep 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530853; cv=fail; b=BCBIUl8R5rnfAekGXFpNuNyn1t+ZvXFO13svCiKTJuGWcQWqTHhYqDmoR/VPwA64W1bhphqD5vytDwzBaJgs9FBdbIcvgtUOSA8jRu2STWDyVyACzIPv95783xp4eXR2N86CjXEVTJ4vKij5mKVUHGe+v8IcgJ3lQBOOTGLOc/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530853; c=relaxed/simple;
	bh=cV01PCBLglDUgIt2whYobzU93+IEDeJaYvWzffy2QR8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HSGCl+TFZ0I9tNpiHFhjIKQEW3sSypCnws0HzV2RndRzksJpWi4fR4nCJEDc6JuFVsloQyksH3ETPFyPAPOikxWrwBH6YCokx3R+BkTMXY0hLxPQwmclrH+rMbBmmv95YGywf7QiUQDLgm++HocrtHdnEyYK8jvIGrlFg2wa4sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z9rSaEAG; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPZSy9/LfJ97i6kikB1eAoi8Y4ZkVYAaSX6arzsp0FfmsBAUFHofqPjghbhdGN6XNTBQz9RAQQtH94Jp17gI7zSNN98G31ZYKfoBEbBx5Uy9ziJ124nN2Gf3fRb6uLh/00j4Lubgq+vye45VMdmtTmJQRqIPf2n66+hicDSUETi2nwglGCiWp3D2970tBpxdL0RE9WbjRfUTLK9sSsh1ly3eZvIlI9pn4aJIjDPe5XrXSGXqYx/qEiLoi89kCY2WVoqAEMhnx89eMFgDjZK320dk/lQxy3rtQDBYYT/zz3fqA6SqHhKqS093Y7/fulUiQNN9Sp8dw1cQO4mhAvNFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQvRpHF8Z77UvRS8rkg4DvTI8kTcPCougfCGkKr8bZo=;
 b=PoMLSTIU/2tu1NIsuiGn0kLwXUMUcv9q9sjlIVHII09oWE5nDEpzI28J4yGl+4xQbYKYuUMx82PcVaEu/4ZE+5upQn0Bdz1TccBu3PRZPnFzeKHvszprKnqL+ELmJm/BBC1q2bcHbO/sjj8eUTdIMt8KcE+KTs12sHi+NIn1ZDvF6vsy/e6HvwUw8yomAetwH5A6EuXyh0Hibk5+wAr+ggp8D+p6QGTPb58qzY430pOYqjP9rfU0Sq+DFkFM2miocTpVYv4vXLu3tBFpNOZqE7LXNorvTVXlyX+dI4tA6fZ5vOcVGgq0fNz1wu340yHRs8MXdIWM/0fg2sG/8CdHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQvRpHF8Z77UvRS8rkg4DvTI8kTcPCougfCGkKr8bZo=;
 b=Z9rSaEAGi1Tw/tdz+EM4NHRVsUfwQ/pWDO99emIjJsZrsFc7RqTUYyUaTSl8rNSQ6Xx2n+veLVsJpMWmxxFGZ4ZBC4To3DkRb2OaIFXrQ3Gep7x2qjGk/C1n7D1uCCU0q3ABBlslFOye3rwpBWXxNB2SJ7HHHfinB8Px2GBjuI69xIN6SRpVP7ROOYoBVvfOqBQKAqzTp0JSQoVkk90/05ipVfU1lkr2hidF+02KcytK+GOTP/Ku+lJJOLBidcWFsmFSes6q0AihPk8muxzOv3LpdJJwe4Tdw5nt9yhxQ8otihhDX5eJrEJzqbMeiyDGceLShWGCivwtu8WiISSuMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 08:47:28 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 08:47:28 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 22 Sep 2025 16:47:14 +0800
Subject: [PATCH 2/3] spi: spi-nxp-fspi: add extra delay after dll locked
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-fspi-fix-v1-2-ff4315359d31@nxp.com>
References: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
In-Reply-To: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758530860; l=1107;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=8sysKbFlTgXB0LPW3VBSstIyaNx0kMlQU9m6Xqxp2UE=;
 b=/jI9aeHSa7tShoUd2oP7JV2ANfDCEUBD7LLjFi8Y5slGMfwPLh3xQ0Q28S7yfo1lHYEpc6J7x
 mu9gX0Air6zDtVdQuhs8ku9l8DfPLG1RfC8G2NH6ROOHE7LGF94rQ/Q
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
X-MS-Office365-Filtering-Correlation-Id: a15fe9aa-6a86-4040-7d09-08ddf9b4a929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OSt3MmlhSVB2OVBrdjhzYmZMOE0xNExGTVkreEZMOW1nWEcrRHYzUG1mZFk2?=
 =?utf-8?B?Mk9KaDN5dExkZENxZHgwSGQvN1ZXWmg4QVN4Z3gvdm03NFlNTG11TmVKTER0?=
 =?utf-8?B?c3g0OExidzl4eURxN0xFT3dmOGM3aUhCQjVlNk5kTGxkRnZtYXdJd3lsczIz?=
 =?utf-8?B?V1dmRkRnNEhXQjhwUWFYRUFyTDlPS1FYUTNjK25YTlVzZHhNOHBIaStsb2Qr?=
 =?utf-8?B?QXRPSGw4T3RBcU11ZDBDN0NySGl1S1lRNlo2VWNkVTljSzlWOFJETFU1d3dY?=
 =?utf-8?B?U2t1b2dNb09kM1dlSGszV1FxV283aWZHOWhDMFRjOXJtZlNzOXF6eGtaYmc5?=
 =?utf-8?B?OXZKSU41clJYQ3VsK2RYZWJmUGxHR1NQMmVHZFk5THFBM0N0a0UxdkhJWEIr?=
 =?utf-8?B?NitsQXFDN0VScGwvRGxzRTFMNzd2SW50MFJhN0dhbXZXSWcyMTVoMnoxMWtR?=
 =?utf-8?B?ZmhseTRBKzdXazBsSzFPbVF2RW5DNmZQbHRvRWRDakpnUzQ3VVU4blUwYkt2?=
 =?utf-8?B?RWY5RWp1STI0a2Q5K1RaeTJxWk5sUGpCblBpMDJWbkNxSVhFT1BvRmZoTWQ2?=
 =?utf-8?B?eUNsekduWXpXTDVtK0V6WUNBZnNPeFBIUjh3ejdUem1qaEw3NElobWdoNHlz?=
 =?utf-8?B?UXBhQVd4enBZQTErN1JzeFordndWQzIrRUZlL20xOWtmTXNBL25xYmJmRWhN?=
 =?utf-8?B?V1ZLTktaUzgwSTZNRUxKTWY3VWFpdGxyeENiUlFwSHdQdzk0b25ZSnRsbFR3?=
 =?utf-8?B?SUlOMS9FSXJ0S3JXa29KaHd6eERxbkpjNnM1YURBMEZnd0pyT3NTVCtjaUNp?=
 =?utf-8?B?NEZabkJaUkFqR0tYbEhRRG5iUGd4T01uUytpTXlkWTd5eUw1TkljeDl6LzFY?=
 =?utf-8?B?RmhCVUROZERoalkxa2FCT1lQYTZzZFdJWkVwaUFmK2FIMzE5TFRINTNuN2lT?=
 =?utf-8?B?V2JYRjRjNTJXcU50anRqaytrWjE3UnBiclpib0xLVVpEcGxMS2NkNDkxV05r?=
 =?utf-8?B?enRJREJwaXBhZEE5cy9UUWU4S1FEYUhGRmxBZkZjOTdpQUtndmNMTXBBS1FE?=
 =?utf-8?B?UDdmNzNDUDdzeXRLTS9PSll2LzdxblhVQnM0QnQ3eitxWXA3WkFqNDRjSjdI?=
 =?utf-8?B?TzNhNUxUSEplYkd4MStjUXloTlJ6UE5pd2RsNnRnd0NhNDY0Ly9BVVVPalI0?=
 =?utf-8?B?WWpkZ094Zm96bXdOZXlPbEJFL2h3NDY2TWJuVGRBdk5FdEVxc3RuZ1JZUURi?=
 =?utf-8?B?dzFBU3lSQWw5akFpSGZBQ1RValdJM3FnNzJzbWVleUozdjVPVVVNMDlYZ1h0?=
 =?utf-8?B?WFVNWHZoMUJldFJHZzN2SEVjYlRmY3JFYmozMVo2eDFvRk5iQkY4UExEMGUv?=
 =?utf-8?B?dDR3d0U5ZUF0b3MxNy9RMUNleHJmVGxUcEQ5RldyUWNUQytzTjdIM2FreDdG?=
 =?utf-8?B?V01EcWtMTHhoTzY3a2NjaUw4Y1BCUXZUYWlCY2t2Q3h0N0FQeHhEMFAxRDV0?=
 =?utf-8?B?U1R2d0h5YUFRalI0T3dScHNOTWxrRzRYVjU5clNOUEZUZ1RBc1dNVlNYUUc5?=
 =?utf-8?B?TTg0a2RSTGNqcXlZU1ZuUVUveWlZRWkzME15TVFLTUpzYWtJUldzT1k2NGhp?=
 =?utf-8?B?ZnR6L3hHSS9maWVUTFkwQXBwcDRvTVl1Z3BRajdDMCs1RDZiYXhKVHkwaWRR?=
 =?utf-8?B?TXBLWmJrRC81UVhqV3A2Nzc3UjA2aEx0SnZJdWJmTnQyeHBQcy9IVklQaUNh?=
 =?utf-8?B?NU1WS08vbFpEdnV6cGZNTCtPbTljRVB3OEZhNmlpVFluMUVOajRJaUttS2h2?=
 =?utf-8?B?bU9uS1NaTXdsTll3UkZTN3owOWVnR0pMTWtzaUpoTStaQXpYZ0xLekdhbHNF?=
 =?utf-8?B?UGc5MGFubjJGSEhEa2RtQWVuWk4wVkdHZzVlZi9hUk9OaFRUWnJhMzNGc2Mz?=
 =?utf-8?Q?tv8xLZkcl0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmRCbmVjT0JtUEVHeVFXVkQ0ZXpRWGRVQy9NM3oyWENqQU44a3RPZWtSRVNW?=
 =?utf-8?B?MUU2a3lnVmN2UkhwdHpmcW5xYlo1SklHc1lpRE5Mc0dDbnhkYnB5a3FkWVc5?=
 =?utf-8?B?SWdhVTF0U0dlN0RuRkhkWEZiWDVIVmxQNEZ3OWk2aDlDdmt6Tm9BOE9ZRVBL?=
 =?utf-8?B?NXM1NzN0dzFVYndvVjRBcFkwVU12Mld0VVNpYVQzSXl6eVZmYXRXRjl6VUc5?=
 =?utf-8?B?eUFLY1BmcFNCMVRSeWwzZXFSbUNlL0QzUTJtUCtmdDlEb082UkNzS29WRzJu?=
 =?utf-8?B?d3lDdktYd3RCZ0N3ZzlXT1M1YU0zZXYxdit6YVVma0JzSHpUMjI0NVZEWEF1?=
 =?utf-8?B?QktCcy83ZG0vYi9ibGRtdVY5cElIMGlyQTFlVnVxeE1jNTU1Zzl2WXpIdzdE?=
 =?utf-8?B?dDhiYlMzd1E2MXVtcWg4YXdOT01ESXJweG5YdW11SDlsODNvNTZpMmd0VlpM?=
 =?utf-8?B?bFY0Y3EwTlg5akcxRWVONituU0RSZkdkd2UyYXF1dXlWbzV1ZFdFUlFJRmRq?=
 =?utf-8?B?NWQ5UzNJcGtqWGVteCtJU0cyZ1VKSFIwZm53QUxDQk1XUG82VlZySUQrVkVr?=
 =?utf-8?B?VzNSWlkyR050eHdob1JvSW1QOEhLZ1Y5OWg4T0dTSlFVQUJ2dlcyeDYySjhj?=
 =?utf-8?B?ZGRuUk9oekZ6ak9Lazh5REdLanFwK2hxR3d0eXBSU3gvaVRaZSt1MW5UNWFO?=
 =?utf-8?B?MmthUnJIZ0RPOWE2eXYrVjFVZFE4Nmxoa1lYVUFsVnQ1N09QV1NlZjhSUEt0?=
 =?utf-8?B?T0llZnJNUEVENGQ5aC8veGxGb0RCdzRnOEtNMTNNVnRCMlNKZTVIS0JJa1pm?=
 =?utf-8?B?alhBV3VoRW1OMVFnV0I1MU1rdm1qQUtFUlFKU3NEQ0c5d0Q0ejFLa0RBTVdS?=
 =?utf-8?B?ajNIZzhlMjIvTk5ITFJFNlJPb2hROUFTSlppZHh4eTZSK3I3Y3lnYlhHOG0w?=
 =?utf-8?B?TDFvSll4R2ZMbXNVblJ1M21NT0ZldndONVdQb0w1eGxka3J4SmViWktXT2lL?=
 =?utf-8?B?cFNtdzM4aGEyd3hLeGpHS3NvUllUVmdldGdDbnZ4cDdCZUdJWDN5cXlyNDBx?=
 =?utf-8?B?U2dlRW1HS0JtclB2bXNpcVdFcnExa2NwQlY5UWZWZ2h6RFpXeWNKY3UwdzdW?=
 =?utf-8?B?czMrUnhHblZnU1hNWjFpOWZ5Ylpqd0M5NEh1c2VDTFIxWlNjWFc3d0lScUhT?=
 =?utf-8?B?QURRaVJITG5vdTQ4Q0wwNThrLzRFL0xhOW1hRkRlWUlNbHFxRE9UYi9VcEhC?=
 =?utf-8?B?WVVHSkZROWpLTitleUhVdWNpa0VLc2ZKZ2xZUm5CK0tQa0ZjYVkvSU8vc3c4?=
 =?utf-8?B?S2NUY0pRVk5OQkh2UmFyWXFrQ3cxYWhYMW04QmlsOHd3aHEwbHJNNnR0MDdu?=
 =?utf-8?B?ZE1oSnljSXRJVUJsRFlnaU4ya3ozREpTWk5SVjRxVTZqbVZwNEl2Y1BPRTlu?=
 =?utf-8?B?bHpveXFoelMzM2VKeW42WVNxczhpMHkrenpwVmIyOEx0ZE9KdG9RRlJlUUd0?=
 =?utf-8?B?QXhOdXZMZXJxaWZVT3M4ZzdLbGgwZjlJUnlESHVNWWFDNmY3RTZNQ2VrWkg5?=
 =?utf-8?B?OEFVTE1XUXRHbnRMWFlHa0MySHlXSUtLQTVNcnFBL0hNUXRvN0Q4SjN5WkhP?=
 =?utf-8?B?UjZ6YzVla0hzMTBMcFF4ejliVGFaYytKa1FUZWR4c3FWdFRGVjJYeXBjWVNN?=
 =?utf-8?B?UGVCT2R2U3lRMmNmZjE5bnVhczk1cGo3VnNYbFF0UHU5TjF0S3B3VlQvVEox?=
 =?utf-8?B?d0ZUNDdIVUhPM2tlcXV4OVNkSlIrbG15Q2U1bnZ3U1RnVXBHRVd3eWUramln?=
 =?utf-8?B?RDFERlRYaEQraXJsdTkzYUlnWDFvM282Nk1FK1hyL3A0cXh2NVpmRmZEKzVq?=
 =?utf-8?B?Qi8wTVZCbTMranlQc0dsdTU0S1ZXTzdYeGJnTVhoMXBWb2huUU9RMG5oazdT?=
 =?utf-8?B?a1JHMU81K1Z2Y3JFQ3JyVFBZL2w2Y1Q0Vlk4QkpES3h1TUVEU2xuM1NENEdC?=
 =?utf-8?B?cjBKa0pTMHp6ZVE1V3p4V0FSbHY0TDU4RlZFd2F4QmNRZmMzLzBjaFlWcjRx?=
 =?utf-8?B?SGgraGpRYXQ4SGlmeGJhVmNxNWdtZnV5czBQODF5SUpxekFOYzd2QnA5YXhs?=
 =?utf-8?Q?7EsEy/gQUBJvPnThe4xcqlTLZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15fe9aa-6a86-4040-7d09-08ddf9b4a929
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:47:28.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpzRi1bhwfmSzKUNpTUe1y5k1rxAdKJip49W2X/ogOXmceKxNiHsH4c8b/yioEUwsicdAkHhUxlQKzfCGJhbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828

From: Han Xu <han.xu@nxp.com>

Due to the erratum ERR050272, the DLL lock status register STS2
[xREFLOCK, xSLVLOCK] bit may indicate DLL is locked before DLL is
actually locked. Add an extra 4us delay as a workaround.

refer to ERR050272, on Page 20.
https://www.nxp.com/docs/en/errata/IMX8_1N94W.pdf

Fixes: 99d822b3adc4 ("spi: spi-nxp-fspi: use DLL calibration when clock rate > 100MHz")
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 4e82f9e900acb91c6de46559efd265f07cf4437d..96b3654b45abcaf53266ce9acac8d6578a19458a 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -721,6 +721,12 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 				   0, POLL_TOUT, true);
 	if (ret)
 		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
+
+	/*
+	 * For ERR050272, DLL lock status bit is not accurate,
+	 * wait for 4us more as a workaround.
+	 */
+	udelay(4);
 }
 
 /*

-- 
2.34.1


