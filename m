Return-Path: <linux-spi+bounces-3521-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E72491180C
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 03:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB801C20FF2
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D8535D4;
	Fri, 21 Jun 2024 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VePo3TZ+"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC263C2F;
	Fri, 21 Jun 2024 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718933314; cv=fail; b=rr2ZM1Kpp2jb03nZUzmxvlwN4wxvbsneSznirEaRXHW8683VtY1WVCAmIlI4Mw6pCnZXiHDd6Gw2Lok4gh0r+fFTaoXd082w2MBAVb38VRLi4dLlCvmdzQMuhxadm+Vd3/XP4fs8hfwQqBgaI6J9I8nQ8pf2bj4TCZTnxrbeYW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718933314; c=relaxed/simple;
	bh=6dt/NalY0Rvg8YisI8YZXKUbd8ZxskweDxI1kinoJ/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9B4+G+GRxKc7r/ra0K8GjFZ86L8N42IG3Spb/4IChoz6zxCKxsgUtwJHjQv5YZ1SfLaG3x2ReaaN6CpMGOCH70qypnNNfaWklomjH5PgYHZxTeLCt6a2kbFluDMtMdU/3oUHZx22GFJCsQhWu8r9K2R+iv8vIGdueqzYKgdug4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VePo3TZ+; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR5maj0qJWKdgOxy9TNq+6Rq3WuBHVx3TX8ZgFpodxDdjuHEZBLZk0X+E1QRdz/04/drb3n1Uu2O2WpCw2dXqlovm1F1kHXRT11zYRQ6Y65l/7aV/n60UfC7xNbmLVjM+fq/FQchyhYGXDzYHG43AiddQ66L/NesUjzMREkk01EekkEyvmruRzXt3Zhc1f5aUvTVppUgsQacr6rtT6kQvrydm6komjodKJVTdbqkIz7s3mSO8r2Fbh10JAOCxZ0Q3AaRB/fLGCIaWmuni0B3pBhc6m1IycaPOtVFrbxdFbyJy+zdlHjZvW4I4F5wQFOMmy76tnlSM43WFTAJqFP7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dt/NalY0Rvg8YisI8YZXKUbd8ZxskweDxI1kinoJ/U=;
 b=ZBzPi9SIK6Fm4CZmaDwzyu0B4nExOQOeijrJqDbadKgw8v6Gz6UAMdecOWE9SIPYDC4zexqBycNJA/N1Dc+/bw7cPnhJ6RaAXIMFiGiAYORETek0nnIhBR5Kg6U6BHFTJ1Og2Xuox1DfLotccCXyAlcVvKNQM/Kp2IlnhkvpsPCchMaraynKztkboohdZyv+nzgkFC0PdZlXyg6RFAOXKdC0+tOIVlh4ILr4aUBsX2X/AOQDUOrwgwUlC+JToWI2B7DHzXmWrZqymTEI/casDx/5WX1wMHyTdLXjUtZ3LzJinKJzPWrC8+QdoQwkuWMMa0QAEZeUPk/eUseTSlPgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dt/NalY0Rvg8YisI8YZXKUbd8ZxskweDxI1kinoJ/U=;
 b=VePo3TZ+x44R/o0dRuDkR3ZT5w5NRI8De7zHzxnoc2WjOMrM2gjSLIvsX7jNiUqtf7xYn2bgSZZzphcmmoFceaesIv7e1DL1/+7OBW7jQq27dk6oSFuMq0hcLWfaS1J8b3B9707SjYYnHVUpkq251qN4PzPdsjAP205vlo5U9qA=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI2PR04MB10833.eurprd04.prod.outlook.com (2603:10a6:800:27a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 01:28:28 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 01:28:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Vladimir Oltean <olteanv@gmail.com>, Mark
 Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v3 1/3] spi: fsl-dspi: use common proptery
 'spi-cs-setup(hold)-delay-ns'
Thread-Topic: [PATCH v3 1/3] spi: fsl-dspi: use common proptery
 'spi-cs-setup(hold)-delay-ns'
Thread-Index: AQHawzMoqaVPJiJ3sUy64JyWGD+5ALHRbdwg
Date: Fri, 21 Jun 2024 01:28:28 +0000
Message-ID:
 <AM6PR04MB5941CD3048D65DABD19256A488C92@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-1-1a2afcf417e4@nxp.com>
In-Reply-To: <20240620-ls_qspi-v3-1-1a2afcf417e4@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI2PR04MB10833:EE_
x-ms-office365-filtering-correlation-id: 9a7e7de7-ed3d-437c-cb6c-08dc91917408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?eE9wUXliT2ljRWoyNXRWMVQxSGtINm14NnVaMXVTWlBpL0tKUzBHRlFkdnNO?=
 =?utf-8?B?SWlia3RBV2R6WWZUekgxQ3A0dmhZRlpZOWdZTTlGRC9KZlRxa1ordVkvbEtI?=
 =?utf-8?B?d2daTlFRT3VlUW96VU81UmZKS1hXVXZBTGJyL2FwWXlDSUl4YnA4NUlWaTRm?=
 =?utf-8?B?VjVDUGJ4ZTRnbnJDS3JPTGZiUHdkZTBqMkpWTmNFMWpIbDE4YXJIMkcwWVJX?=
 =?utf-8?B?OWpDTVpvUThCMmdlcFRzUjk4dTMyVXk3cFhJWkcvN2dvVTVzT3lLVnp6QXgr?=
 =?utf-8?B?ZTlpRTA5L3VoUGRoeUxVUE56Y1lXRFVzZmhWbVRta3ZZTDVOcDEwK21nelpG?=
 =?utf-8?B?SjAzRmlTNkNjRTk2YTUxZEtwWGl0ZDhLMk1Dc3g5b1E1bGJiMkhIcEZIbnRR?=
 =?utf-8?B?a3BVdWpBa2FmWGYxR1QyRzM4QVdSWU5mc1lRck8rNkJTeEZzSXM3SVJpd1ZM?=
 =?utf-8?B?ekQ0a0lVYUF6TlBVMEpUNVpkdUpnOU9IV0FkeTRtSFhGUlZUNytxV0RkL0ZW?=
 =?utf-8?B?dW1nZ0htUHVOSURDdVVSMG15ZWlpUm9qV1FWQ016OUNaNHNkLytvU29VdGZY?=
 =?utf-8?B?UWc5YWxCRmRVYW52YTA5bDNKMHU5dERRLzZDOWlqZy9jdjRHYXVJQUlVVFhK?=
 =?utf-8?B?Q09Db01VWWhnR3pKWXhFemU5emlnT3M3V2FVYjZhLzhCdTFzS1dYSU9vSlVZ?=
 =?utf-8?B?bWxrWm1JaWNqT3NxU3RVMHJrdnJLU1h4U0U4c21QOTcwYnIvdkxCbmV4Sk41?=
 =?utf-8?B?eFl2TnQramkwbm1wRDhzbGVLS29CdlEvUWdTQnZQMmJKdTJrdmVxdE0zdEs1?=
 =?utf-8?B?SmM5blExVVBucVYrT2FsNU5qWXpSTnZJYkJXczNxYnpqMC9uU2h2bjBBY3FG?=
 =?utf-8?B?SjNiZ1R3aWRTVnE0UHUza2d5Q1padGhlbXRKOHJrV0NpYm1UTUt4emxLUnZo?=
 =?utf-8?B?M1NtU2N6WW9TWlNPWmtqUDJTN0wzWXgvR05XRWJVRUdXalNza2R3QzRoV1Rm?=
 =?utf-8?B?Z1BYb1ZXS3NvZnovcDB1d24vcnFaYWVJanluVElhS2h2VkFOSEJuWkEwMi9a?=
 =?utf-8?B?NWZvQUV6c3lOV29DQTUwU3ArTjJHbzBNdGdxWlB5ZkQrby9TM09WOHV1Nmd2?=
 =?utf-8?B?S1BYTUpYUk0rdWhRT1pNeHBsQzk4NHNMcEIxMnd6ZHB1UloxZXV2RElkSmZh?=
 =?utf-8?B?VkdUN1k2VlZlbzR0Q0Q5UWUrd2xjYmEwNlQ1U1NoM3RkOHBhemo0cFdvVVFN?=
 =?utf-8?B?NDd2aTAzVjhmVGVMZVJURms0dHBqWEdpblZjYkZOc0VGWkxqY3AwNHpSMXp1?=
 =?utf-8?B?Ulpma0g4RnpZT2lWVE5qZTVpakdEUFdFd0V3RUZYVzZnbU1VKzMrWDFaZnhx?=
 =?utf-8?B?MDZhb1VyOHh0d0lkL3FSU2FuMENOY2c5SFlQZEZZL2dGZUhrNktUekJockNY?=
 =?utf-8?B?dFRVVEMzVU95eGMrR2xWVE92QzVUWGtqQko1TXBMWXN5aXJFY2paY1dGWjVt?=
 =?utf-8?B?elkwYjR6V3ZOc0JKaWJLZzRxRG5VNGVMclVDb0lwSFJRaFZ6Y3hIZitYMXlK?=
 =?utf-8?B?alVvR0tHcnBOcjB1TnZFb0JFSE9Kd3Q5bkVtK3UzSDVjSWp5Nmo0dTBVcU5T?=
 =?utf-8?B?WjRHMzZPQWRNdmt4WWpLa1ZGSE51dC82U1ZEMEQ1RkRycWNhTjdjV2RvWDNt?=
 =?utf-8?B?Tm0vYUdZNmszWVZrUHJhQjBMdVVqZXVaV2dYa1F2L0NDWHVBdm1pc0VpaG1N?=
 =?utf-8?B?S0NKa3pFZUtmYm9DOUxSUVNZQW5JSkV0T2x0c2tOQmdxd2Y4a1RISVJGVkxv?=
 =?utf-8?Q?kJ11pOHrUcXOXreqgqFEhO0dCni3b368rr5Eo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2duNTIrcUtIbGtpT2NMVDNzZkpsM1ZDRitNYkt4T0NncVdhVXlsbkgvU0w1?=
 =?utf-8?B?N2Y1ekFnRkF2Tm9CR05veEpReE1SN0tLY2puNEJTZEcvV1loK1JXWUo0Q2dV?=
 =?utf-8?B?V0pmMm1UYVlBQm83MzNaaDZYOU5ibXduM1NkMFVhUGJ5bHcxaFJra3UzNFhN?=
 =?utf-8?B?cmVreFB4UmFsTXBZd2paanVlOUhCOGxNWWhCd2JPd3c2a3JLUG1rU3hxNjhS?=
 =?utf-8?B?d1FDZ2w1dldQTTBlN1lnK2o0Y3huNmFQTVJXRFNjUmFWY3dCOU1reENMQk5X?=
 =?utf-8?B?MmprTUpXYUVlQ1FCRVlGRWxYUUliblhYYzRhMnJyeGRITUQ1UWx3Y25WSXNl?=
 =?utf-8?B?WUdCWW9xczdnbDhUNEZ1cUdoSHhQUFlLMnlkZk9jS1ZDS0tGQXdWaEtGZGdM?=
 =?utf-8?B?a2ZuUTU1T1dRMVBJaFBPSEtKR05EV3Q0bUZ5dVdSMVVqNjJmamFZeVN6OUlK?=
 =?utf-8?B?QWtkMkVSdG9YS1dQSTdSVEV0ZXlSZnY1V1Jvb3E2QUcrTEFFOVoxWEFkd1FC?=
 =?utf-8?B?WEcwbWNJaDZsS0ZjdFRGc25zaTQxRUNJKzFIOUIxb1BJMGV6TDduLzI2NDAv?=
 =?utf-8?B?YVV4OHJoS01uM2JOQmVheVcvQUpCK3FiUzloQ3lMRXN0bG9nbUtwakc2UHZV?=
 =?utf-8?B?b3ltaXJ3aDczdGk5ZDdwVU16aUtMVGlWRWJyNG1JblN2YVJ3c1VXRmUycTdK?=
 =?utf-8?B?dEhIT2lVUjN2WXVZZlJHdURsWlNhZlk3NjNIdm5uUXdqSGQ4L3YyT3VQd1Nu?=
 =?utf-8?B?b1pacGpqaC9vTkZva1NwL2tGQU9rbkplWVVTeHJsUWxYZXVldnduMGZxd01y?=
 =?utf-8?B?d3FkdzZ1WDR4UVlJckhHZHlwYXRTdjY3dStHYSs2VmxHV3kwbzFETm5IVlZ6?=
 =?utf-8?B?MXRnbkdhZTlZNktlNW5yTm5XeGcyeXY5UzRnbFoxQTRlTXJsZTlwcXpETFBj?=
 =?utf-8?B?VEZUbm5tY0hKTGhzWkJsS1Bkb3AwVlJETUZFK25WVzVhRkh5cWlRdjM5RUkx?=
 =?utf-8?B?aVN1UVB0QXlwa2E1aWgvZm9RMnNKYlh0S0ppRklRbHdWVDJ5M3IzYkFnUXhU?=
 =?utf-8?B?eUtuOUo2MVQwd3FDU0ZabnpTYk03aGtUU2gzWXZJbGN3Y1RFZGp6YXVJV0xD?=
 =?utf-8?B?d2d3OXd2emQwODRuVlkySE80MHpSbkN1anY2ZVFEcFhhSnBNYUM4UlJJazZB?=
 =?utf-8?B?V3lzS3U2Z2pUSGxrT2Y1WU9wQ3kyZExGdmtPZjAvQ2tYdHUyUzU3bjFFU1lz?=
 =?utf-8?B?Y1ZwTGY3VXo2bmtQUFJZRkoxaUVnWkxMVmtKNmd2WExyYUFlWjBXZ05TZGs4?=
 =?utf-8?B?cE5TbzA2QkR3SlU1dzhKM2E0UEdVd0FKclVXTWJyVFNyZENhOHdGU2RMSmxN?=
 =?utf-8?B?WFhncE5najAxNVV2VWZJQUxqVmY5UXI2eTFlSk5ndE9FR1Q1Y2Q0Ym1obFlx?=
 =?utf-8?B?VTg5aXI2T0pHRG5kMlZDUHk3V2dqb0tpSEZUREx4b3VTbjVuM1orNW45eFpM?=
 =?utf-8?B?c0k0OURaSm9TTU83VWl1QlkxMEtQSWdLaFhuV2RPdU9mc0NsRlhnREp3REw5?=
 =?utf-8?B?RHBxYk80VkFjQXBXdWNPZ0dmc3oweEtwRE1mck95SUJuRXFyNlMrZGl5LzdU?=
 =?utf-8?B?b3ozY3dZNlRTeDhSRTE2ZXBYZnJUTWp5MjlhdjIwRzJMTkp4OTRXenFvN0Ry?=
 =?utf-8?B?bk1sY0I3ZkNnUlNsNmNPWWRJQkU5Q1hiUWYybVpUUXpTbnl0aUhtR1dJejVW?=
 =?utf-8?B?M0Mrd1B1dWlZay9rdjZlSnhteHR4ei9lbC91OGhGdHRQb0VqQUFBRDZkU1F2?=
 =?utf-8?B?UVUrTVV2R3N4NThtaFFlbUQxN3dzbGd3aVVxYnBiaHZ5N2lnK2VvYWQ0cFJE?=
 =?utf-8?B?Y044L1NhVHZWVDhFRDhKckRDSE02bitCbHVOU2tEdHZHMi8xQ0VKUklLQVh5?=
 =?utf-8?B?ZWo0SW03bm5sNjBrYmEyM2JqVnNmL1BkcXhRd3A4Nm13YituK1F5T0ZjaWlL?=
 =?utf-8?B?Mk5FL0l3YzBsSCs3TGN4cXRybzdoV0tVbzgxYXJPVVBFUm9wN0lOWmVPdWl5?=
 =?utf-8?B?ZENjRHJ2NFNZQXBKa3BnZ0JHbHk1SUpmTHVxd2xZYmU3QnpCVFl2ZjlaTXF1?=
 =?utf-8?Q?8RCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7e7de7-ed3d-437c-cb6c-08dc91917408
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 01:28:28.2683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06jEtnkox7JKIx0FqXmH1fY4tbUszhBlRkKxsXGClhE9FObkbaMGuo80lnrD797KqXIbwfdHHbp9UGLwRc+RcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10833

PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMS8zXSBzcGk6IGZzbC1kc3BpOiB1c2UgY29tbW9uIHByb3B0
ZXJ5ICdzcGktY3MtDQo+IHNldHVwKGhvbGQpLWRlbGF5LW5zJw0KPiANCj4gVXNlIFNQSSBjb21t
b24gRFQgYmluZGluZyBwcm9wZXJ0aWVzICdzcGktY3Mtc2V0dXAtZGVsYXktbnMnIGFuZCAnc3Bp
LQ0KPiBjcy1ob2xkLWRlbGF5LW5zJy4gSWYgdGhlc2UgcHJvcGVydGllcyBkbyBub3QgZXhpc3Qs
IGZhbGwgYmFjayB0byBsZWdhY3kNCj4gJ2ZzbCxzcGktY3Mtc2NrLWRlbGF5JyBhbmQgJ2ZzbCxz
cGktc2NrLWNzLWRlbGF5Jy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5M
aUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1mc2wtZHNwaS5jIHwgMTQgKysr
KysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWZzbC1kc3BpLmMgYi9k
cml2ZXJzL3NwaS9zcGktZnNsLWRzcGkuYyBpbmRleA0KPiAwYTI3MzBjZDA3YzZhLi43YzFmOGFm
OWQyMTVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktZnNsLWRzcGkuYw0KPiArKysg
Yi9kcml2ZXJzL3NwaS9zcGktZnNsLWRzcGkuYw0KPiBAQCAtMTAxOCwxMSArMTAxOCwxNSBAQCBz
dGF0aWMgaW50IGRzcGlfc2V0dXAoc3RydWN0IHNwaV9kZXZpY2UNCj4gKnNwaSkNCj4gIAlwZGF0
YSA9IGRldl9nZXRfcGxhdGRhdGEoJmRzcGktPnBkZXYtPmRldik7DQo+IA0KPiAgCWlmICghcGRh
dGEpIHsNCj4gLQkJb2ZfcHJvcGVydHlfcmVhZF91MzIoc3BpLT5kZXYub2Zfbm9kZSwgImZzbCxz
cGktY3MtDQo+IHNjay1kZWxheSIsDQo+IC0JCQkJICAgICAmY3Nfc2NrX2RlbGF5KTsNCj4gLQ0K
PiAtCQlvZl9wcm9wZXJ0eV9yZWFkX3UzMihzcGktPmRldi5vZl9ub2RlLCAiZnNsLHNwaS1zY2st
DQo+IGNzLWRlbGF5IiwNCj4gLQkJCQkgICAgICZzY2tfY3NfZGVsYXkpOw0KPiArCQljc19zY2tf
ZGVsYXkgPSBzcGlfZGVsYXlfdG9fbnMoJnNwaS0+Y3Nfc2V0dXAsIE5VTEwpOw0KPiArCQlpZiAo
IWNzX3Nja19kZWxheSkNCg0KYGlmIChjc19zY2tfZGVsYXkgPD0gMClgID8NCg0KPiArCQkJb2Zf
cHJvcGVydHlfcmVhZF91MzIoc3BpLT5kZXYub2Zfbm9kZSwNCj4gImZzbCxzcGktY3Mtc2NrLWRl
bGF5IiwNCj4gKwkJCQkJICAgICAmY3Nfc2NrX2RlbGF5KTsNCj4gKw0KPiArCQlzY2tfY3NfZGVs
YXkgPSBzcGlfZGVsYXlfdG9fbnMoJnNwaS0+Y3NfaG9sZCwgTlVMTCk7DQo+ICsJCWlmICghc2Nr
X2NzX2RlbGF5KQ0KDQpgIGlmIChzY2tfY3NfZGVsYXkgPD0gMClgPw0KDQpSZWdhcmRzLA0KUGVu
Zy4NCg0KPiArCQkJb2ZfcHJvcGVydHlfcmVhZF91MzIoc3BpLT5kZXYub2Zfbm9kZSwNCj4gImZz
bCxzcGktc2NrLWNzLWRlbGF5IiwNCj4gKwkJCQkJICAgICAmc2NrX2NzX2RlbGF5KTsNCj4gIAl9
IGVsc2Ugew0KPiAgCQljc19zY2tfZGVsYXkgPSBwZGF0YS0+Y3Nfc2NrX2RlbGF5Ow0KPiAgCQlz
Y2tfY3NfZGVsYXkgPSBwZGF0YS0+c2NrX2NzX2RlbGF5Ow0KPiANCj4gLS0NCj4gMi4zNC4xDQo+
IA0KDQo=

