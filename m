Return-Path: <linux-spi+bounces-8926-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A006AEEB53
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 02:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD16189BE66
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 00:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316D145B16;
	Tue,  1 Jul 2025 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="AI1BsmGf"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDBA22094;
	Tue,  1 Jul 2025 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751330368; cv=fail; b=etxXCPp/J0B+2F2j32efIr6bXZorq/XPutW2fqgGPGnnxNRTyDCctsPR1aFph4cItkTQYFxdndgKe64msqigd6WSvw/OGTMd87PGBFbvRtnOhmYhPpRrcG58qUkWXg8gpwHSttBCDJ0f5VSCRutyKgL+pD/0CabNqD5frqRPWMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751330368; c=relaxed/simple;
	bh=NZLUZ8GU7j66HcUA3L7nuCSjfdiEQO6Lnhovm2PqhSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p6OLKSRXU9maCquEYzQ9i74CyN8cDDsrygEZ4y2vT4AE7aIZWeam8MrPVM/+d8knByo2vWqfP2+VRFWQFxtWxVNW2jlDMs/8MRp3dDKRKJRjubEMlijoj2ScN3TMRFrioJfT6SQlRutzamX4PlwNWREL/Cf6eIS0jsLdsgNy2Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=AI1BsmGf; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH44Tz/xApdDptV5EVWRvRjM49X6RA2UotUDOurHCTYZc2AIS6LBDHGIDYZa82Sx4eS5QQ0XArzDBH2E9PBQfKKk1txaF/aC0Nd0gOyBEVMwkPJc6yEw1S4jDf/NQ4knPpbmslSL66wVVQD/B5RY+VgAIzCz/et/96jKPX2FZuigIOmDlMczmWqPr+86JXgdhSIDqpEX2NjhVJbwKAGjE+JB+8PTxm4pmWUSl3wy4G+Z/bxQ3pNSkrb3XAwy5WjCm8eXP0YKiy3dlnFPMmeJJZhix1YxI9BeHc8qWNlr8HIzO38GALBPCtGdyq+CZ6xccqsdhweL/afoJvef3Ur4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNwJFBRjM3A7KZBcSqSx7DuAu6rJ+Ex139fSG0To/G8=;
 b=T5ojR6sGa73tblYN4ecjI4Em1rFHJGyZ6i33ED2rg2nEdP4Epj4Y/j8sRdkdbxbNYBmssUlEAqFStWQD+E9Asdrpeb6I1r9fFyhZoeJYnyr3Ogs/MIaznEpXuhZRODQFjgYXTcxbkABcQHuO0LhqJA3UrP9hhSa0Xeccyv6RvDHyd+OUmTA/gRoBpT6pmWxsZZmpcKjELWnBtixRamhWCxgbVG63ZRp5t/jxfDfryPuLA7Y/mxfULKeF4bCcxzXlhztuLirVc50Y1qwy2zFKjf/BViXaA7kOX6KZJij4yICq36qpAWsL9iBggzm/0SOiDrP0/J3MdNzbVADgRgiFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNwJFBRjM3A7KZBcSqSx7DuAu6rJ+Ex139fSG0To/G8=;
 b=AI1BsmGfZ5HkbYNb0gQcetRikxJypoOV4vpVc9q7IBr75Etjr5uHurOItg1ZiKPwLWrOwaFEvbeJXwRxWN3vFuoBt3pS29VYewH+kvVEYXJ0V59JHnftL1Dkb48gXfKbYB+G7rn6jwY/ZIxQ/lVbFxWuwlLrzntODkTtnJEyy99P49KM6qqAjNZzw5a4upbAPIK5OFmhJ+mvzp4O1fxxiIm9ehO+F9LBLbJpaYQPY2jK6x+iFXGrxOfxWSrwkQMNtMiyrnBZ7bxLdRm7oSedModv3MPe/KePDGBnpTVsAITII0VJW8AzdvFEHGXssnyrDQ1/mnhg0qHnBA9Ywy0wSg==
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by SJ0PR03MB6582.namprd03.prod.outlook.com (2603:10b6:a03:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 00:39:24 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 00:39:24 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mark Brown <broonie@kernel.org>, "open list:SPI SUBSYSTEM"
	<linux-spi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"Gerlach, Matthew" <matthew.gerlach@altera.com>
Subject: RE: [PATCH 1/1] spi: cadence-quadspi: fix cleanup of rx_chan on
 failure paths
Thread-Topic: [PATCH 1/1] spi: cadence-quadspi: fix cleanup of rx_chan on
 failure paths
Thread-Index: AQHb6Z8JiQISVlGUXkWOkCeuCrM6UrQb/mKAgABu6oA=
Date: Tue, 1 Jul 2025 00:39:24 +0000
Message-ID:
 <DM6PR03MB5017D9C650820B9A5C63C6ACC641A@DM6PR03MB5017.namprd03.prod.outlook.com>
References: <cover.1751274389.git.khairul.anuar.romli@altera.com>
 <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>
 <9f26f205-756e-4fcd-912e-bf73167be21d@suswa.mountain>
In-Reply-To: <9f26f205-756e-4fcd-912e-bf73167be21d@suswa.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB5017:EE_|SJ0PR03MB6582:EE_
x-ms-office365-filtering-correlation-id: 23e121ca-8c5d-4eb2-d354-08ddb837ba3e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Oid4V+rJW21JaySOTHneos49zyQq0R72evYNO20q+9/U6Eu2iMHeX7N5quRm?=
 =?us-ascii?Q?J6Cccept2hoJMcmbP66wHmRXTWOp9Y7NbkEOVLOFKLmiAnTWZmH3d1ceVPJ+?=
 =?us-ascii?Q?GZ4mQxxKrsaMmVo9xVt9gg/8IZyfC7xx8Rw3p19+wDxJ0NcaaP1YJszV7iNg?=
 =?us-ascii?Q?Uj1iD+euCoASMnWOTmNUTFXfdFCA5RiwoHooyclQ9aaxUuSIoVtfJpFHQJ6t?=
 =?us-ascii?Q?BAzlXkoJKCk7MrBteS+JAEPXoaxgiY4z/C2sKNKcDbHvXbbRHzb9oMkMlbIA?=
 =?us-ascii?Q?ZlglBYq83ND46fJ1JQdre1eI/bxxuzrOT0CqDV7YSOL0nIiPmLKRKt2beWCV?=
 =?us-ascii?Q?BmV4zcwSTVfmbpezrAukRgdUkaZAKdFWYcrh4TAnyrG4B0bCvhr02SGLEJn0?=
 =?us-ascii?Q?xh4iUm5FhkeJm7cXTCFxFAsRlOa8tiLN+7kIRtc+iUFpo1S5xWn37GsB5GVn?=
 =?us-ascii?Q?calMBDdLmPrVBLVkFuSpq3KW8NIGWhpcDQwHDz3MbpeUz1bjX69uF+N+INJo?=
 =?us-ascii?Q?cSNKtub6BaZJBuwNbL0I8U43e5tspCzexBNs1inIs+qSJbdXpvtcUOEOYIZ5?=
 =?us-ascii?Q?XzxGhSorxMpHQuPiMh2WcNMtpOY/V5nDJvjl/KNA+5Bi5Mr1a4ewVC3StAeU?=
 =?us-ascii?Q?BMQz0clwIfppLFcP36rtABTNPHZ52WZ6sqhDiWuC50bj59tdZXWjYhyYXJ9p?=
 =?us-ascii?Q?B/ROneI/S2V5Q/2PyO7fWBw0SuUniq6oxGV6eosLAO1j7iqGTsE/62bSLgSQ?=
 =?us-ascii?Q?i06A+nSGcRgzFXPKxGlRuKBF/LCJi05ylEE87wEwFPzx4BJ522dfMer56OxG?=
 =?us-ascii?Q?Jli1f+ve2no5rytAKrVSrSe5tE3F3yxqnjbMIDxciuQzzPI9soD4hGdHQhkk?=
 =?us-ascii?Q?qbhV8n0V5FOfzNQJ6mUjwIAzDbjbJnRXdrkBGKJbHy4YbiDMQHCyds7Uo2L8?=
 =?us-ascii?Q?59oaM6VEm8NldySt2p1MnBTHFQEPJgxUiXUpRtq08DiIv/Wo4Rfi4gpVpZvr?=
 =?us-ascii?Q?YAtOdONizCnA3DyQ4nRqjcjtBYS7BnqPl1RR9G/KmDt5iVzQmFC1Pez4Wmcs?=
 =?us-ascii?Q?mlBxFS88A2BF4dk5wAFUPHnwKL2cO4bZjwIrdUxc12LMdSVsJpfxaZKWYDMr?=
 =?us-ascii?Q?6LTQUMVst3dJt0rWF7ck4iXl1Y6qQpvZiOKBhurN/JhZ9GiaqSCK1sXZIXaT?=
 =?us-ascii?Q?yjBAiPl2AFoWLfosMcnpQ4jSyjeK8Z5ZCu2EVKBXOYujj2WfrkqqvdTJ3JdB?=
 =?us-ascii?Q?fkGIrI2HtKLfaEH2Ja31tN2AYPqXBhlteSk84oWeE6zSvDxK16lshkf5/EAA?=
 =?us-ascii?Q?/DS7fLf6s0hIoDHpgiZ3VBNWyreCjXwpRx+IrHNg85OpURd5hk+0sd1yEJHf?=
 =?us-ascii?Q?FOlxK6j61PtIqSgSrwr8hsKnWnPqH6uVxihn4qUFC0sLDyj5+V7yRevczE7F?=
 =?us-ascii?Q?vb0f5keixoIHYA7yZ5cQbdnKyD6nxKB8k8QIURi7zcyoMFWTivZ+hQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q5vQ42oIzpfBbHFfXeDbUNjlMNbAW2zb4IGMuPYTyZFs/ZwjOlUBvh0VuE5x?=
 =?us-ascii?Q?iwXerEO0ki8n1TR3l9MvHDnBKK9WltVxcXeUE3uTGfdT5Qh5Pj8pBqx0m0zj?=
 =?us-ascii?Q?2T0LrCBsHpzXFl2Jhd0JbZQw09Q2UDWmUx9BY7wjW7yYvOrFzSUGrxI34zoV?=
 =?us-ascii?Q?Lz7/1IuwBGLXweapWxpQVAe+/TI8Oy+gK48WEcQtwmyqf8nB5DYh+S/QZYUs?=
 =?us-ascii?Q?757aMjF1YdTW2ddaV85ViC4+Z7TMd9TMHVrLKYBbch53uoAn1t1jv2eLPWo3?=
 =?us-ascii?Q?iI2q3+lvHk/d5bm7UYahqUc7rSWDpsTSVinMbCIkmkU7eHei+YYedpC361gC?=
 =?us-ascii?Q?Fh3GHAsXiK49u2nvOvN7YZ1ND+RQQ+oOrSzFEMxXWbGZn8XaLfdTdMICTYkT?=
 =?us-ascii?Q?Jrsizab+EiZVBJitlePKQ8ViVYJoWk2Z8FVsXUN7fhUbhk7uVsTB7tbqzcvs?=
 =?us-ascii?Q?D1x1xgNxI1gbuQAABjPpGKb5//6SkYWUuj13+Ky94emr3mlOgRM7fPk2G8NF?=
 =?us-ascii?Q?Z54Wi1eyN6wQIm0u4mw4S+IYasOQcgK7cUiitohY9JEkDLV7nFLkFnyW0buN?=
 =?us-ascii?Q?4niwUz6ZbgxieY+0idhW0HOKvxoZU+CARjNqpAa68likLL97y0It55Xfki/n?=
 =?us-ascii?Q?kiOrfEg2noxmVfF+H2Cd5wwvSsiFo+EKEKbyRB0/blESvrrioEQQ0q83UzDr?=
 =?us-ascii?Q?TC5nJaY71YBjekxOqQb+ilkzc/qq59ApTFUI69GGNOe5I1fEXBObGveUH4kn?=
 =?us-ascii?Q?qaitGU7HwWRTFher5RpGyJ+ZF0mecv0b6AASIAiYGqyR6ZRG7s5ABldwcGjN?=
 =?us-ascii?Q?GXE2RQ3uF0nInHTJGZAEIuklGaPaQh8X77ULvmpZGJE5WMQU5EhoT5s+060+?=
 =?us-ascii?Q?2BWKNwtPD8Gp9CUuX7idvRfkCWlQwHEitsewFn063ewqKllesb9THVWJVmi8?=
 =?us-ascii?Q?WkkL0annhP3qSNQcwNfcZKje9xF+jp7Ee6dGfZdIHjxMZMI1BDxbUDKXhJ8N?=
 =?us-ascii?Q?89BQWTz8u++LYah39hICMePe7AMXwWRcsq6AQ0KO+FEy6Dt6BOMtWkEX9lDH?=
 =?us-ascii?Q?vmEJ08dC0jw4+ELizPdvDfb45dQFt5yXu5uLoeov2urm5Yi9w9hyYLKcX+PU?=
 =?us-ascii?Q?Qj7hNRFP8RMsDgNmAW6iKLlwkVMnqCdLCPsZOymAEjKrt8AAk9Ft0PceUNkn?=
 =?us-ascii?Q?I2CrFwb0R4RyYEaghr2AWq/alMjOuhqHIGRMDBMxrOapCSRxIWEZUCAEG2Rc?=
 =?us-ascii?Q?Lm2OsKI7RfLHeXA20HLB2D14DCM/OY0nBeHVJXgy+/V3r7tEB3vU1mDpTtUJ?=
 =?us-ascii?Q?f9r637rYSuCGLoyXV72DtDtKPrfa55g6s/zRv/rgTrreUC6Vekn/FI0Af+SH?=
 =?us-ascii?Q?U0rcT40ZCFN6DhU6zzMsj0LcIfabxpSiTSsVszLRtXqKqzQWrAVo7Q9qHNB4?=
 =?us-ascii?Q?DqavU3/jhwT7kDwnA71FXvz7tDY0HxPKjrvtb+YUUBBZ6GGBvfTNEhgpoT9N?=
 =?us-ascii?Q?/Yzoqo0AtwTpX7rWwoKAIsZ14aaOLcE48dvqLvO01fBxLRYyDONNwD/SphV1?=
 =?us-ascii?Q?3Owgnk6R/LHvzU2lOl1UjrpMgh/+qBfUmOxdRsAf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e121ca-8c5d-4eb2-d354-08ddb837ba3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 00:39:24.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFszrSAT3qE67znwTWgIjx2EuTtxgKXSDv7+fbZMCQjhuMsCdlNqyFr7gX+9TkCfFu1wJ/gneJyZEffwlxWPZ19LcrbKPiFj+HeLmEl02vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6582

> On Mon, Jun 30, 2025 at 05:11:56PM +0800,
> khairul.anuar.romli@altera.com wrote:
> > From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> >
> > Remove incorrect checks on cqspi->rx_chan that cause driver breakage
> > during failure cleanup. Ensure proper resource freeing on the success
> > path when operating in cqspi->use_direct_mode, preventing leaks and
> > improving stability.
> >
> > Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
>=20
> Thanks.
>=20
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>=20
> Mark asked me to fix this and I wrote a fix but apparently I didn't hit s=
end
> because it's still in my outbox.  Sorry about that.  :(
>=20
> regards,
> dan carpenter

Sorry for sending the fix on your behalf.=20


