Return-Path: <linux-spi+bounces-10563-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC53BCE88F
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95E5E3459CB
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F4304980;
	Fri, 10 Oct 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="4zYAF1li"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022128.outbound.protection.outlook.com [52.101.66.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9B302CAB;
	Fri, 10 Oct 2025 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129137; cv=fail; b=P0mBQ8SKYSuZ7Vg3QpNWQ8uLkTCrEQkPYQrXxdo7e2NUF7vCTOqsbG5kUgP6ZyePHuBj9w1yh4qV1T34aqdkCvzk2w9qrn0yQuaT7TLCnPiMHatcvPb3F9il8RyzA1gepuxT8UvsWZLSZd372iPAEF1LPdabofvK0plzr65SEt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129137; c=relaxed/simple;
	bh=RiKbo/qwhlU6jP31RsuFL9gEwPwjUa/P/53eg/G8Wy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXc+FqXgdUKNQ9QFELzx9ttek9hMWgzg3uT7qZRYg0PJwrCB0REJbIn9L+6uZ1rCj9Zn/lrGPEvgZHOOZcsUfhiVr7v50rMePMvOf98Im4UxpWRkmZXezm+S16bQNtVU5RNZ6GYLuUDe0YkQz+wb0qw3vBQBZRss3UW6zy722Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=4zYAF1li; arc=fail smtp.client-ip=52.101.66.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnkDI/Wl5Tq1sb/1QO7nIzd/ooOT2R0nvaONS9puTANAWY90xJHq6fCa2dMwljsvjXfDmZtKaX5Sm6Xp8+egW7YepDYLn3QHgzHU8KJgC7IVRGM50NMjvRJWZN6jnXgHCAA7Z4IV+er1Mun6RhbWqUhJe1EAV1jE+cr1ttkiWYMnYGgy2BBlCArGoFAu9nTQkEK0NiBYeUzsXML103RAcb+TkzpwA5YHf20McqZyzlHkafEoS9HyIrCLWkY0TpT9xZGjB7v2DMnJPxM5v/4/OUTbqqTGsqbFFyJfa/8UbVnDIlM2htv5b/7W1YUje0WoNfqYNAdSi/vCgHqFm5UeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=EgqMbc1Kh7JHBAEiIKT3kkDljxUJgMxS0xIXKa4L6WwRglet1gQy4FIbbqEkoQog06lPwpwfiE2SIwG9l8+EsvXiLIWVMFwrEWjulFQ/n9QE9HgQruhnG5w3sN429f1ArhLZTOeCpKe0M9njtyZk5PW0fHsSMv7FlsPSG0Atqbb38PzbSEDlfOPgTKa3QO3LaULRs1oiAOiGEdrPk7ZjAsV3fV9G5oM5/FXcs7cre74MdIbuqU2sd5X5v8nfBdzCeVHPRxKws3WgriTlfrk6x0cQQhfPzTyvEqrm7O+XZEq9f/OwHndF3jLCaflwNyG5/Pu/43oODiy+2u/d/xL+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=4zYAF1liPmxi1Holz4rusjBTqBW3UPsUmJCBmzEtsXH8W73b/oTzUPkhnor8i4AZqXFwTQ0Az5fnJIaf3sNxH8uke13kzVn2HiUCxyTwvwZTRn0yz5FACQu1B3EZgQhSMUj1Le+13hjhdzZOskGQbax8gR5N0yoY97LWPoNDaBSnpPsPY/OUai+b1CUSOxvH5GM1AVUFlP+T1g5gZmioRrk21XfMZNYqF5BTLLuJm58dH51yEDY48p87WptGUN74mDVRGVw0Vx93QgMe6v4WHtYsSlDRoBdcLDVHR80nr9b8SzexXR3spOOlphMFzL3EHWpFegQiQsR/+XUE3mhgNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB8619.eurprd08.prod.outlook.com (2603:10a6:150:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v9 11/15] spi: airoha: set custom sector size equal to flash page size
Date: Fri, 10 Oct 2025 23:44:56 +0300
Message-ID: <20251010204500.1625215-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B51.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f515850-955f-4a9e-46ff-08de083df039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ngh5Bf11Y4MFz5q+PTES/Cgz+uTE6YA95ihw8o5pViY1VIz+xkdTlvIo08Rp?=
 =?us-ascii?Q?FQZy5nasNEbkLX2ePCks7O+Y90P8IS2Rc3iG9w7+yomziqhzhtHAiw3Uud2Q?=
 =?us-ascii?Q?RFan2WEkOddpybp9toJrih8WUXtcnW2wV69t9qiL5JTMAjpmQNz7cQNQV8y1?=
 =?us-ascii?Q?vD4vPLnc5VgmKaBlpnX1x+5p9/SLMnSYKxs1XRY2ztFp5RTWLJYH+LsbqqTx?=
 =?us-ascii?Q?vR+t2eBYplkLwHQQ15rhuNpIjbOTGSJlZA0C4Y1Ay58e0evuh2vhInFk7gT7?=
 =?us-ascii?Q?hP3I47UQsK/NpPpwi4v3YPxaEoVEq1nDKeWct/teFmh6k9OqjgOEt6p6JD0r?=
 =?us-ascii?Q?Eo8TILN5KayvFd9o82kZW1EC6hZgPOqLA+0VnIyMAs82D+YvgLqpFcIHyey1?=
 =?us-ascii?Q?tENk8npQGZrAen/B9YxX8vSgW8MFsJmmhLRpmt0jMtBGSZ5KygW5IOSjTohk?=
 =?us-ascii?Q?V3UCL1w4BOFr/wEsW6UDLIbgYQYaiM33Vg57NqPTrhOLJp4/NUFIvdDPGvdz?=
 =?us-ascii?Q?56B01pN6zYS0Z9mzKL7vU+chJV1i05OE1O4aKupRczlGx3ZDUOs70PC1YScm?=
 =?us-ascii?Q?hMYG9O33MDtHkC3ZJzydJsJZ7s2crIdLNEarVprzGqD178HU+gdTSf1aYIZr?=
 =?us-ascii?Q?HN0tBNTYqrIBLEmnc9zrr7Mj1PDnRzbrerb6CODjy8LBgnMlyqYyKTdOM0hX?=
 =?us-ascii?Q?NUJ6SZbnhGB4EXTbY+6nUqCywFlGPH1eA8NTqp5l71NClth+1T/Vdb0d/J7m?=
 =?us-ascii?Q?xrNy/7ZGKokt8UORcOFNSX0Hk+pSO8elCFbPHTwBanuOJwpGKZW4zeMj+j88?=
 =?us-ascii?Q?qD1NIyOnM1VqqWeyH+VUJmEsevU1wdD2mvZI3sIt5hNGv4iCfTF1SePKCgBa?=
 =?us-ascii?Q?j9qQzRCqImZz5Lwlzry40un8WQ27W79bYnOhkLkPxf5YmdZvmHgWGuXptpIE?=
 =?us-ascii?Q?KYXor/bb48wfblL4nPYlNuy1bfPQgJfJmVhxDr6XQK69XaFdNbg//CTAWzCr?=
 =?us-ascii?Q?s6QA/qNvqjJY8DvU+Y1m/z0hLhbFArZIdPOLeLQ7Zurz5syBZ/DBnefQYTrj?=
 =?us-ascii?Q?lksjGNq0zzmUDtyfkROTu9/yf3F7DWJxnY4+hDstDS43OoR59MGKEJFdYSKK?=
 =?us-ascii?Q?4b0V4psckABoYn1wgz7GnbS3thWWnhoBcgSuAk0aO0M7vMKxnNXz6WzakA8M?=
 =?us-ascii?Q?lp0P86O50IOdZ7QS448lPKRmq4PbmxJGdCcA1A73xO4ZcUMMIfpMuc+TKKXV?=
 =?us-ascii?Q?5+hSAj+UuntyiY9+So3a/wb8yg92ZGcgqY7OcogGOq32RfI6lXKbRp2LFrMl?=
 =?us-ascii?Q?Kw2VPLssScb0g9e+05S28jzSCixPHPuvVYG8TgkU7DFC4vnzOIfz9d4db+rQ?=
 =?us-ascii?Q?D5HY+UbKD+V5R6LJgwwRM33zxKn9T2WzBE9/sjTLjdCPuS8cdxsyeTctcY16?=
 =?us-ascii?Q?v0qjGvjJuE3aRUQyRajR2FlikaHbwY0F6fouWAjL725wTwHQJ3e5X5FbuqhJ?=
 =?us-ascii?Q?yRzVb8tESFUrUYl1ud1VTI96wpEyDN7bHSJTimXbDsRMUTLZpGusZ5IshA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6NTYuppwEUUVDx+NyKb6tDzDj172a0kOVfzHsK8uaRgfU9luu7+pCEfzRVdh?=
 =?us-ascii?Q?DQxMEV3o3xa5aBCWKyAN6ubDNrX4gabf6mKu30sLet8dPe9QktgI0L44tlCy?=
 =?us-ascii?Q?GMvs9W8C6J3d1sCPTxJRIrhEhU0/+HBtFSr2n5ZMj5SeStvWxs60QYKGCbY1?=
 =?us-ascii?Q?l8NpaB70rxP5vnJgt86/qxAXfm4slBIbYCIPYZWuwa0oPjXRYxHiB9O5ey/l?=
 =?us-ascii?Q?zcQHsRcQ7ShhKwBd1ayRYqnzitqGoBzvoeOkmrpgeFQtwz+oSlfEFCDVFwU4?=
 =?us-ascii?Q?p4f7/jAt8Rmj1+0n79Bua9Iv+hds3j1b415wdREYKIOa+pSOSOHtbHqyLfNi?=
 =?us-ascii?Q?G1lFxb2NoCWErl1QtMR+lcWohCMf4AG+aTgQOMLvtDnh5JfgZtkZuCl7RsYv?=
 =?us-ascii?Q?0qm79FgcUd5DQFD/A8JNfxLk+9W9+cvBpzQAG3r7Ak71OGXqxho/ZdoSwjXc?=
 =?us-ascii?Q?iFnMjIsYDY8TxZuSlsbvPKUeLQNXZfcQoBlLMZu58CoD74EQF3kFNyF+ifFq?=
 =?us-ascii?Q?29ih/bfJHrwv2bBEsm42gAyfRw1mB0MhdSG6ZNAIL23KCDosZxC6aOTUXqRl?=
 =?us-ascii?Q?u0wT8/I0FxAXVeGzG6JFCAZeOR4aZdHkgrQqT986bgEjp7EUAQT5amVvTqqR?=
 =?us-ascii?Q?sjfoSIOzpLN0rU5aRjRG6o8l5+HyhM/aFeHlshPM+g586z3JOu+G5FB/wqEk?=
 =?us-ascii?Q?gK/1mcnmNFO+Szr/JtnkipgWTdzkScy68V35a6WJLeVLXCqaeXjsasl9xWVl?=
 =?us-ascii?Q?HQ0qP3RY/k2A445zNkBGxBPLrF2iAHq/BPeqol1umQpwSnXQZJTP47RakAhD?=
 =?us-ascii?Q?ty+k/8og+KR3+R83tXMDupfX3Vl1PugZ19Z+sD+ECQmMuoBs87FV02agZLck?=
 =?us-ascii?Q?tOIrnZ12VlFoBZA3Hrh9H8OhLSZD2845RV15DqxZnw9tFygvxN5QJY5+43tn?=
 =?us-ascii?Q?8fWYB30BH1K/V/sTje3dus4enzizT3B9V3SoRSAGgDzHDeOARJ+fvZHyROhN?=
 =?us-ascii?Q?gG2JsrGbcLO0Lc0zo4S9sVUK/pmkUDforQG93GZbAAZHVgupe6sERTXorDxk?=
 =?us-ascii?Q?wZZ0LhgZ5zICWxDzsGhkzYVjlJhzSJsSodQqgFuCwWf/6NbKm7aqpK8USvcP?=
 =?us-ascii?Q?UvGyxkoxqgdiKJ78YZgb3AhkOKBiJlJdJH2EvoadVwgiSNtLY/0G/nvHomw3?=
 =?us-ascii?Q?D8Z0EllGdyA6gxCwtpcVuCZHVxmFp1yDkn21SRVxS8WbyH9oTHGkqbDWrnDf?=
 =?us-ascii?Q?E90A8wXuiT2srvUC16hxKY16kk41S5UERaMXSUknrZRFjiIceu+LSg1srcuI?=
 =?us-ascii?Q?qdCwg+AuW2BJWfQSksNhS17YGx5TvIh+W2b8eREfbsbP25GZ1XAO/N9qHJP/?=
 =?us-ascii?Q?IJMssGUVLV+TKPbcs4R3UZ/8wFle1flWRRXAhq9a02XihQaMc8HR6ctLivcl?=
 =?us-ascii?Q?KF3yifYP+EzFCn83hZGZEVLBXLZqmfa6Xxu84Tx7JtryosD56xNjhmGU9KNt?=
 =?us-ascii?Q?oNTfa2kiepaEh/LoJFZGMF1E/6YU76R7ZwgOal/KixRbP9UHYVqem5EzR5kI?=
 =?us-ascii?Q?SwKVQhAq9SuzavbSN5D1L5YFZwDM33//1//PYpIIPScAniEJBBkFFDAdaTnm?=
 =?us-ascii?Q?8BF6DZPM6DqAUiM5XfcUYDU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f515850-955f-4a9e-46ff-08de083df039
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:25.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOGdVvWUKSZ5tuXzj4RXrfQviPeaJPgTNooy6DvCQZaXGvAP9f/+vmxlwS0AhmFINUQBEG6rypmFeRw/VQjMEUfV+WccL8D5nCHALQ61Gok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8619

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 3fb76e2dd5e3..babf7b958dc3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -519,7 +519,7 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				 SPI_NFI_SEC_NUM, val);
 	if (err)
@@ -532,7 +532,8 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, as_ctrl->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
 	return regmap_update_bits(as_ctrl->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -635,10 +636,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -697,18 +701,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -733,11 +736,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -826,10 +828,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -880,18 +885,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -916,11 +920,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0


