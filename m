Return-Path: <linux-spi+bounces-3336-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E9C8FFD01
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 09:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC69D1C203E2
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 07:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DF01552F0;
	Fri,  7 Jun 2024 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YRVQIK4Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB44154C14;
	Fri,  7 Jun 2024 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744769; cv=fail; b=tSLC/JIxNw4Bkh+bRgU6my0WCut3QU+zzs3thpH1BVvcQy1xrQvhq9BWt59CDyrBNcjr4k/+h5oKhd6IleZLpX7kOuTw+chUtJYWkGh2SCil0ki2HtoUCoT24kxLsQmiLxXryZPa730M3eLP867T986IkFn7uJM4C6HtwQ51gUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744769; c=relaxed/simple;
	bh=BzTknB916gK8guUyhBR9cvo8VRxiWAqYr7lV5KfB65o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=COMlYxH5nuvqdczgFIV9dfd0YDLaBSaG5D+A3TbfcoqCVLcTMHPTMaUv9cQIdKK8p4379LLhJkBAGqluZUum/xs6j0+slkk7KxaMU9hqRJkO5SOInD4l6wJtZqwN930pJT4afUyroa1jUIeOXFFdj2SBnY+l+XcqFc8Tyk0ixMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YRVQIK4Q; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2irsle2n207ri44pIZD4TAEWiMqDQzgp1UNkHcQHBjkkVNaLsj6WUyjkoa1U0y6zogmsitfJlSBxfsZrZq1Ehzrtr+jAwhTqHbJOOAahy5x5PAjELN+MI3IUJ24j81I66FxDVx7Pchx5SY89ym3MUSQb9H4XGkhNTyIWePQB0UJ5c26AousfJugu88uiGAsUDKs5kbDeKkYIp4jDun/Mgn3M15T1Do6NqKxAXJav9QxK1Cb+GgjFjIB3Sob/4Y8R+GJHwz1BaDfB4un8V426AP4HWWKXbQ6qtgrVic4rACHiL+AiJj+PgRa2oTWgdIG2EeWIQNy00A0SH4jK129Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfjdUGKNUWiqSgvlJj84a17FCFX87jFYhVfRaBaYgso=;
 b=REldYpzsvI65HF4NlqDNxKf3vj1h3TcFvf4jLpQaW+NleGXKP5zRJWzLA+biFhEODFVam+siVkpkQV4HOpFhXBNNhwAtc8gNl8+Oba/a9+HOwo/OF8njIoZofMmGw86uTdyz+NntxQVH8DSjwH2DF6buby1CqdZAJH8/dmo4e6SBQkdIZ5kLMJBbdKBvly5Nh07884A49eFoF4oc1GUl3+wYwwVMDr/JHqBSFqVjMz90sVVio4hJmEFIu5yS4GlairQThtXANTWVtt3cgN1xBeRRpJaw2+rSaz6uM6gup2n8gYzeUxnnv/CXYv728pGMXudteI4/Kwct3jD43kDpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfjdUGKNUWiqSgvlJj84a17FCFX87jFYhVfRaBaYgso=;
 b=YRVQIK4QRTRfYJ4bDGF9mQ7vXfCC2P/F1ZlYPpliljmq4CmCfvnd72lF69DElTOTCHxEwn83GaeHtUgD7iBty3vlooyetLdcEezgWN7X3gCCxgNq8P2nkuTzfWP0o4RRYhvCRFmd2r1QiIRlWOPtGNv2WpGy9nwpzqT/yYlUvNc=
Received: from BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:19:25 +0000
Received: from BN9PR12MB5228.namprd12.prod.outlook.com
 ([fe80::9eb6:6233:fa7e:f904]) by BN9PR12MB5228.namprd12.prod.outlook.com
 ([fe80::9eb6:6233:fa7e:f904%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 07:19:25 +0000
From: "Thangavel, Karthik" <karthik.thangavel@amd.com>
To: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>
CC: "Gaddipati, Naveen" <naveen.gaddipati@amd.com>, "Narra, Bharath Kumar"
	<BharathKumar.Narra@amd.com>
Subject: IMA Reports No TPM Device
Thread-Topic: IMA Reports No TPM Device
Thread-Index: Adq4qE45KxXVKDnZQr2Y5S02DshRfA==
Date: Fri, 7 Jun 2024 07:19:24 +0000
Message-ID:
 <BN9PR12MB5228AB9BF8A3951983B39EBEFFFB2@BN9PR12MB5228.namprd12.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5228:EE_|MW4PR12MB7334:EE_
x-ms-office365-filtering-correlation-id: 976ecad8-4633-4f24-5c67-08dc86c22913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oa3cbfNmk9WYWUZilIqth87xaDCWYkFQ3sPTzjVomf6Ji9gRuPRIU4IUiQbd?=
 =?us-ascii?Q?w2PD+7PbkEIfFb6hbnxsYWQ76USL2sYNYdOIxY5tKUZfxFujXdsGg5nKyZQT?=
 =?us-ascii?Q?VnZDCQcbzq5fUc1QDRsc+pqpzSC0S0NOk284/YAHPPBZ1ukhr62EDQLDe2GR?=
 =?us-ascii?Q?RzUv6XYu9IHt1EqRTl/MyVKmg1kXamrmTq4win9PtPQWnumgbEdxhQBtec/J?=
 =?us-ascii?Q?oXSlptfdGx5yEWQaUmENiBPYsx0/PWk+fPX2QTTdFr3HYxuG7O3Ebzn1WEiS?=
 =?us-ascii?Q?ft5qsXsowL/MOhwaA2P3WzR99eRs58j4LaAGTz3UbnV1xFqfvCX6ZQUD7mFa?=
 =?us-ascii?Q?7KSv5gBIZk3zrvkldi/jMnJSTX6LSqL5xdoEQFbRPETwN0XTFHIiMx6gV2Rr?=
 =?us-ascii?Q?+Vgby14sTX8Rp0Hfntc/XvC4d8NbMZBN+asJJdSxen7LADij1QV5GLutvLq2?=
 =?us-ascii?Q?+cbGlDW29iwjWlOI6Lxbsmul8lU9TrySO75n/epemC6LWRoZez4c5SDdOgRO?=
 =?us-ascii?Q?X+wxiDkvs0mU72+LQNPuTQkXOhSLj7rlERJQKeVlDr6ludNi7g2hBPdd6uf8?=
 =?us-ascii?Q?0WtOGjZ36XU55SqCtnsZ1Hjcv6CGsmipyg3a5qwtqFxm5vhp1LGkQ+P5eQBU?=
 =?us-ascii?Q?cJB9wqAqvVYfBRJPSk1KVS9nLu/p82foKdX6Esso/vVqpKzseOkFKpFpac5P?=
 =?us-ascii?Q?b+LRBpC4yn0B/nyDhxuTVyE9+8j4sSkdZ67dYtlnP46/Z4SC4orm0/8KL1rN?=
 =?us-ascii?Q?bjfZ0rIhBiwD+Jd3ZhnaSh1ky9kOc6b7vjw8yRO4xeKCBK1wyBF31Onw7cfk?=
 =?us-ascii?Q?jt9bZgJWGrUI3Gq/DcAgVoP2+oRRYN8LSNCDY6s+9am57uSYlxe7cD9IkBjw?=
 =?us-ascii?Q?4uqccSKjrf2VAIu84J0ftn8mTIw0+LBHo2X0TcADfTKnU10Nq2RXQKuJ/FxJ?=
 =?us-ascii?Q?lK6QJ1aGGiq/VTRbciLwbuN7s6pndEzUFHNxAFdNqmm7g3SXdQ9cl+L+OEeZ?=
 =?us-ascii?Q?GDqrVxJUiMgXYMormzYv5mvTL0XIVbSURf5dRbXCLTJ0suLJm/6nHOeNvtGW?=
 =?us-ascii?Q?Ex+VKyDnlYaQr+m1LxWb76wawkC0Zq3yGTALIbBO+tv9OSGsmFiBaLV7+JRI?=
 =?us-ascii?Q?4PcQW0t82XuCk1CLeC5BYpF9kCg3DaGtYTWAQmiLKOQsETUkjilpdOsVQ2eh?=
 =?us-ascii?Q?+dDxhQsdsDsOuCSrRvGq+JmpifXHE376MkHJiijUVeWiuTsJKsh0bXn+MydB?=
 =?us-ascii?Q?6kQoUzyPf8K3D9AcOhuqbMxXRjAlLBAWld2oa6zqKuQgqNmrcYSLIGFdoD+y?=
 =?us-ascii?Q?h+PdLIS+kqAnNQPD9BUmcSoGV9oNKPLNe6ergOTh+t2WBEiyM32uqWYC75aR?=
 =?us-ascii?Q?x2SeeDA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TyJ8806blNEz540Ud9cEuAsjDp0h4bWsgJ9MpFfFTH/+md442d3jBbJEm23b?=
 =?us-ascii?Q?pkj+GaBc4tGxnmH5/bol2EWsD1dJ7J9sCvv5W/GGy9hS7UN+R+ryiLYABsYH?=
 =?us-ascii?Q?qJF0n+8guDg2ZnWXnsG34IaczWJieMVXNernvlUHXN+uM9MHnFj288lqhjpq?=
 =?us-ascii?Q?74sw3jRa467x8Dg/lcD4kD+c5pccsLMGomaLYWWHn0wgK+njtIUKSlDIs9Kt?=
 =?us-ascii?Q?eOd2xSQY0DSt6e2eOlsWicP+S+sZAzpa1o3dzwJGRpJ6Qe7pbpq9YS4PRqs2?=
 =?us-ascii?Q?Tyj5Go3lDjtNYSNTSYsSIFVlvkKELZswofSHZfDJ6voClOvzw/3DhX54ItAh?=
 =?us-ascii?Q?Qb0OY/df8wm7gIUwZdX3TS8OsQM76WCKKMTaqQpHhJ+71e5uGyFT7dmvTVWT?=
 =?us-ascii?Q?B0TLQM18oLdz1l3+5AA7hYI95zySKP/2JGUG7yMNvFp7wl//PtESLZgLgsR6?=
 =?us-ascii?Q?mMSI5ICrA82u4yqHJT+Y8uALQy0vlyVmssxkZhwfQWVNIjKcLMIfyE04G/cW?=
 =?us-ascii?Q?RoSxF7R/ZEs9xviZSa4LwTp2kSnfQil4sj5zAzpFnjUMEookXS7Gng9MQKxQ?=
 =?us-ascii?Q?ekQmsyJPqohLCObCfQPkhTQvp/QBaLTOTNwX1jAL8tkOz/3n5YDiGVfUSFAo?=
 =?us-ascii?Q?NsJhNXQu+O+RsJEMojvBYayFKA9RpmmzpgSgAU1INOBeILo7NpTBNE50TRIE?=
 =?us-ascii?Q?MCpSmNIl8pRRQIhRE4VFu8Lb0kJhFv1DWUrxoR+vMBUFv7TM/0N3pzRaXGZm?=
 =?us-ascii?Q?6yDMm67cZGaWk0CpDzJboYatCCrzYVVmS0zJc/dJp7aJrHrTxSzatJTkeOdl?=
 =?us-ascii?Q?iZNaHP7fFCEF2M9iiYOYK7h4zP8chsrrJvSoa6WfE6Khco8djV+2OJYM3iYV?=
 =?us-ascii?Q?HMQgP2FU8b+4f/CLztgsRVRM7p43BiIhKTaGTEbyZ8R/vlc3/CCtdSPg+0/C?=
 =?us-ascii?Q?IncrpJ555+/jOXVkVeSbELGyJWi833k6Q3Fn2jcLEK3euJ+KxHvCRh7BOvV6?=
 =?us-ascii?Q?5YHCf3xD9Qbeh2re97/AWxCuvq74CHckyB6z4zxxWoZYWfQdg00DMp8VCHnO?=
 =?us-ascii?Q?XQkZvysSY6ywKOwMpR+zBomOSReXxvn57GHvQeRBIEtvlQb5Fabip6GWaK2u?=
 =?us-ascii?Q?ahItYAnhnGxoNZVXRIbiQY4cd4ENgTAzWSflP2n6Cf8NI9IrXkL//QhFH601?=
 =?us-ascii?Q?rhjYD4vWcuE7oYj6Q7cXtcooAZMHe5TtKtJzPMFaOaMZnlVFKibwiJ+irb40?=
 =?us-ascii?Q?J+taMKUC0gACb+mZODNpvF7jM9Scryfu7LaFEIEDBhjWA2iZHy0Qp/dgBgzW?=
 =?us-ascii?Q?9eKIzv7Z9XqUBoQcvleQQ4452fFvyao+34GpMjTW3sZQcdrlOIhIcsgnTWZn?=
 =?us-ascii?Q?dc85umf9bluMXDUu17CI4JPidnca3sY7PPUibZwSW8EkAdA3U+v0sKAvqOTq?=
 =?us-ascii?Q?uBIkumXIu0bLw9Nw1LfGHpL8ba6znUi1Wqm0wuN6lhjmJFaHtDeL2UkHX1ei?=
 =?us-ascii?Q?bsAzaUTWOgerwz3C5yFOaZscP9nRyEFpQbnW/xeXhUPZBoEXWErA2vOeVFxi?=
 =?us-ascii?Q?qTUClNjk7IRbkxbUIfQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976ecad8-4633-4f24-5c67-08dc86c22913
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 07:19:25.0391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGioQmz0UKerTvMrctt+0qcMhlhZBAhIB72iHjPt0CspoS8VBsqGgj4po5sR6MBSkinXJ8dxYtOHJHmPoXyGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334

Hi,

We are booting linux v6.1.30 on Xilinx ZynqMP SoC which is using ARM-A53.
We want to run IMA on TPM device connected over SPI interface.
During booting found that IMA reports "No TPM chip found".

Please find the below logs which shows IMA subsystem init=20
called before TPM device.


[    0.000000] Linux version 6.1.30-xilinx-v2023.2 (oe-user@oe-host) (aarch=
64-xilinx-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39.0.20220819) #1=
 SMP Fri Sep 22 10:41:01 UTC 2023
[    0.000000] Machine model: xlnx,zynqmp
...
[    2.561405] ima: No TPM chip found, activating TPM-bypass!
[    2.567199] ima: Allocated hash algorithm: sha256
...
[    3.727105] tpm_tis_spi spi1.0: 2.0 TPM (device-id 0x1B, rev-id 22)
[    3.764152] tpm tpm0: starting up the TPM manually
...

In security/integrity/ima/ima_main.c=20
late_initcall(init_ima);	/* Start IMA after the TPM is available */

As per above comment line IMA should start after TPM is available.
But we are observing the opposite behavior.=20
Please let us know how to fix this issue.

-Karthik

