Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB03CB0F5
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 05:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGPDKS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 23:10:18 -0400
Received: from mail-eopbgr1410048.outbound.protection.outlook.com ([40.107.141.48]:25719
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231230AbhGPDKR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 23:10:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8BKl14bHJU7H0I+MS5QCnNBg7ezWCtcukGf4eoLfJjxC56MPVnc09BRkHComVgOYZH9wsR/ZDaJpanN8V3DLg9kY5pHdcPxJSXMQEjgZOcGvCRqDd3cviKuCxwYD2g1yZy1YteaterxeFSV/i/9d9VuNTgGmDusNG8Zl92+6+hhC4J8IIcWikyH1fKS4mhzu46St1VbvhHanBjAxfZd8hDFHoGhuHxz1JoS9IMfOHXlUnsdatmT3z7i0AxF1LohrSHVilab9NUpYqBQ/jv1trJUwIQ6wZs5reH6/9Yp1+oXRu30AAdr56id8EvEZjtK0Hs77S529jjABN8Ek59LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgSiu36PgsIp0YAC9EG8h5qSRgZDaJ8JQX9ApzUk9OA=;
 b=b6wjlRTsyg47xXmAtvCqRntVsACQoBEgahQtMY2IntuMXdr7HVduib20EQmNwndG7OdVp0ECEvU0OPeZaKQ0vpESehK74tPBT9uUDS8OYJmD0ptcFpAuc59MEcweTaViDop0kdldJvLgVYnaeVIx5+rkLClODy5PzG6/ooL62B/BUwBJpkMZu/HUbrfeQYo6HH/Tk3ExCrSEPAp9VlN8wKalUfI2qBL69Z7ukJKm3AjdYOGDJO4K/zvG5rnJZdVhVEnLkXlF864w95SJ3smnD9hpjEqDwNyushXlITCNrwI302NryiFO7AhweeXtY3C/Is+qwc5vkAjhP0pMKYIgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgSiu36PgsIp0YAC9EG8h5qSRgZDaJ8JQX9ApzUk9OA=;
 b=ALD/satzhb0EDhUlAzeOj3Rl5XrmzsBM+5fyc4TqiKt/8gvDPnoGKE2lNx7Yvzxu4tixEtKPVIxHNiFwGyUIKiEA9Pdh8pk1kVPQNoUVo6Jn4QqLJdwSy83nKR0UHFXq6kukCL+mE1tPBbGCGmxYrMbZlriENVcEWZc39RYTZV0=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSBPR01MB3397.jpnprd01.prod.outlook.com (2603:1096:604:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 03:07:21 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 03:07:21 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH v4 1/2] spi: spi-cadence-quadspi: Revert "Fix division by zero
 warning"
Thread-Topic: [PATCH v4 1/2] spi: spi-cadence-quadspi: Revert "Fix division by
 zero warning"
Thread-Index: AQHXee+x3FoA8gJXskOlTO0d6TpkOw==
Date:   Fri, 16 Jul 2021 03:07:21 +0000
Message-ID: <760be709-74d1-14cc-fecf-433786e123aa@nskint.co.jp>
References: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
In-Reply-To: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef3e76e6-0399-43a1-d07e-08d94806d3fc
x-ms-traffictypediagnostic: OSBPR01MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB339735571FA3A017E59FCE308B119@OSBPR01MB3397.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:215;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vmid/59tpIlZan12fsUxvCH4v1XSZYjGK344AkzDj7tlN40UpimBTG62MGcs1qFk+40i1WFPggST081/gtr/toN9zISrb0zLAJo58N3gDu7aes788BlBOM4feOwq7lh8ArmrYfuRK+qJkIWC5I+8ncPQsl/PmfMoE8I2eOq+CqHoBNMJTPYsAkVGW9rZrHAN+LPOF3zkzWHo2ILFCaTqw/etApanHZLwbB7pQWmKr+habxOcKVmqZmwaeLBkq5ty4QmH7zpTHTChNafnNRX/tad/0Bw+S4aW5iK4UhCo86bsC3yVDuDiX9Qu/Fg0uE8KlrFESH8HBdiRjSWwBiv5nLLBA3Ggs9UII0LPzGR94kD0OsLi+kxb1464XcHeTM9Ci7WI2cCCBS5KwWrjGAdTl95hyURdFKGVjtEQUj4UlmHOCDpJddGJIdeUWDtYVUwGrosHAPoj4sRvzv+Y2jOlYXuZuo5/hbx0VgDOgeYeOUNJ2IwpW5skbcp0/VevLgu3PSTTcS6HxdhD32hZK2gB68Svx+E5fEU6eVrZ2+Pu3gO64qlQ42M5mifKHKJRM/2oWw5pMPGyWcNIvsaQa3Ww2SvgJLWDmPbED5X9gR2sLgdYkyg2YnVL4TksMfNtbN1/vkWgukYiV+zgUOUImoHqdufOufs+28bQ+zd9vdqMKb+LJgV82675i5PSz2wg0/ZvERFFbv3iJ2La65DBEGE3MTH6S9eH0mlAl85Y78G6w5S7qc5cIVsyNO7b5fuJVoYEo8UfDPjDNU0ty1tvoz4xnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39830400003)(346002)(376002)(31696002)(86362001)(26005)(83380400001)(54906003)(6916009)(107886003)(76116006)(6486002)(64756008)(4326008)(6506007)(6512007)(66556008)(66446008)(4744005)(36756003)(8676002)(316002)(66476007)(2906002)(31686004)(186003)(2616005)(8936002)(478600001)(66946007)(71200400001)(122000001)(38100700002)(5660300002)(45980500001)(43740500002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RUxIT21ZT0FMdlVXdzZLSndLSU1nVXBOaHQ5QVdLNy8wRFZaUWtINDBi?=
 =?iso-2022-jp?B?dWFuMHlFdFpvL0ZPR20rYlZlVk9hV0plVS9ucGNZS3VLUFhabTBMRHFY?=
 =?iso-2022-jp?B?OHViMWNGZDkyNE9waTFjc2dKSzFlNzEvKzMwM01BOGw4a2RyVGFuREN4?=
 =?iso-2022-jp?B?YlVXVkJIbnlhT2ZBYytGYTUrVXlPdkhyUlo1Lzg4SXdaYTVYNzlJYkZH?=
 =?iso-2022-jp?B?SU5jb3RYY0lOMVMyeDJxanRvRWdpV0doQjFDa2orc2VOalp6UHRyWVVz?=
 =?iso-2022-jp?B?ajB4UXNlQ0NIR1ZUNllocW5FTmtWekVsWHdCbFlKeVNiNGNMUUsvZWVU?=
 =?iso-2022-jp?B?bXphbG9tRWdRbEpNZ01HTXpPLzNLd1ZrbXZDbmt6K2hFVVIrK0dXWlRj?=
 =?iso-2022-jp?B?Y01DdGZGYVl4eFJ4Q1plL2FHQmM2S3dQU3IvejFqK2ZIRWltMS9CblRk?=
 =?iso-2022-jp?B?TC9CSVpERTYvSDBPUDZBdG1FczM3Tm5LVUJoaUVRc2x4L254djNtVlBn?=
 =?iso-2022-jp?B?Zzg2QXFyMytsbjRYK1NOSTNqN0ZWSWZUNEJRamttUm5YNTlZb3lMQVdq?=
 =?iso-2022-jp?B?eXdVbllyWHFac3hlT0k2VjkraVRYeUplZ0ZVanVtb0FZSzV2anYwSTF6?=
 =?iso-2022-jp?B?WTdJRHV4cVlHb1RwN3BXQzFMWkYzbTJFNHFqQ2FvREVwL3o5aUd3MkNN?=
 =?iso-2022-jp?B?YTBDY3VPMWNCdnNUY24ySm84Ui9NakVJTVFRWlNjZGFkakp3SmJxdUVN?=
 =?iso-2022-jp?B?YkxwdnAyN2RvdHNRMzFqNEdUeTlwM2J5NUprWVRjMnJYTHVZcnBiZkUz?=
 =?iso-2022-jp?B?S0U0S3h6WGc4Qk4yZEltdzFjRHM1djNGR0ZzWXlFQmZaci9KbGZ0S1Vj?=
 =?iso-2022-jp?B?WUtob2JvcS9uN3B4STI3a1JQNUljL3FiUm90ekJvTE9ML2xFcWlzMHA2?=
 =?iso-2022-jp?B?eW5rSHNXeGF0KzJXZGpNL3lVcWlJL3AycUkyKzNUM0t5NzgrK2kwSFQ3?=
 =?iso-2022-jp?B?U0puNDlGNVYrekFESjJlc0NzZzE3RGJKT09kSTRhcXVtYkhoR1J3UVNl?=
 =?iso-2022-jp?B?S0V0Mk1IeEJaRVVQUmQ3VW1OMVI4TDZsT3VJdUgwb3ZiWXU3SkZxbmc5?=
 =?iso-2022-jp?B?Mmoya1c2ZUFLV1RyMG9EUkN2VlU2U0tQNjVSZWpJYUZ6V0FuOFdGeTFP?=
 =?iso-2022-jp?B?V1lKaXV4d3NZcFFxZlhHMnZzc29yblJpNHRjTTg2SnBxdUUzSVJsdUNQ?=
 =?iso-2022-jp?B?YXk1Z1lkZjhPemxUWllsU05BcWJHZUdlYUdUcjcybDAzVnp4b1FrT2Vj?=
 =?iso-2022-jp?B?QVF1ai9wVkswMUpsSnZ6OWNCRlEwblhlekV5Y3NlM29CTmdIOWJIVHRC?=
 =?iso-2022-jp?B?bFNMV282M0F1TEs3OThNczgwWjhkaGJ4UU1RcVF0QVVYTExsU3dNTFpY?=
 =?iso-2022-jp?B?cjRIdFlIUE54NE1XUXFBZTJ0VEZPYnBNTDJqUW84OERvQlZVSWdZRkdj?=
 =?iso-2022-jp?B?Q29Iekk1V1BhUG5ZLzlteXlJM0ZKNFpaUFNkY1hvQ0NxcjhRazlGeUFR?=
 =?iso-2022-jp?B?RmVqK2ZodEFmalNVMUhOTDRGVStwRDRZSHJJTW5iTDluTFc5N3lYTGQw?=
 =?iso-2022-jp?B?cFF1R0dOeUdENytKdXplcVdXY204bk1vNC8rZVRIb0w1M1R0dXRWMlZW?=
 =?iso-2022-jp?B?alVZRWo4L0tseitsYzNLTWQ2Z29qMDYwbmRnWGFNUTZkcFBkZGF0N2FD?=
 =?iso-2022-jp?B?RnZ4QnZZUTIrQWdlTnZpaUx6WXVRN1NoNWNFZ2xOdU5rZFlSQmFOR0xp?=
 =?iso-2022-jp?B?cG16T3pZSFdzakV5cGpIQUF2aTZ6SlFQNEVhTG1EY0NkMmI0RE5IZlZo?=
 =?iso-2022-jp?B?VnhEQlh2ekR4a3VQZEpyaHBLZ21HZDR5K2hyUXhXSTVyWHlMNzJzWFVI?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <17FC440D3275D9408C0087AB075BFBAC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3e76e6-0399-43a1-d07e-08d94806d3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 03:07:21.2762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJ7aOFuxuKSyQ3d5EmUJzZYyptMMwtapakOJdi4DhuWN15YFXJJKlydm1k3D1THICQM3loIKjI2ac195fsnHiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3397
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Revert to change to a better code.

This reverts commit 55cef88bbf12f3bfbe5c2379a8868a034707e755.
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index 13d1f0ce618e..7a00346ff9b9 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -307,13 +307,11 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_fla=
sh_pdata *f_pdata)
=20
 static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr=
)
 {
-	unsigned int dummy_clk =3D 0;
+	unsigned int dummy_clk;
=20
-	if (op->dummy.buswidth && op->dummy.nbytes) {
-		dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
-		if (dtr)
-			dummy_clk /=3D 2;
-	}
+	dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
+	if (dtr)
+		dummy_clk /=3D 2;
=20
 	return dummy_clk;
 }
--=20
2.32.0
