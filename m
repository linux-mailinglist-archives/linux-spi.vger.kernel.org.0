Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7C3CB8BD
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhGPOgJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 10:36:09 -0400
Received: from mail-eopbgr1400087.outbound.protection.outlook.com ([40.107.140.87]:40662
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232988AbhGPOgJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 10:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYAgx3avoHvpMe/xO6ts7g16rJvDhNDEAQYNSgsniapdGNpaBV5POv/6qwreBR4VsbmsMccG7i93Z1jRXvvufEmmwUVRUXOvbWHjs04wyV8gdu2Eni4W3JtDXSuTP3RuWtg7dvqd8QbhPyhi6uDQq/nWmk8P9jIzl3KTCOOYj2FJLh09RHE1bOWZPbBPbtPfipEAKYBkHXHZGPuxK91jrPnLZakB94F13/SNiXAWwo/pGI2bc0wVmPy91i9TaxxQ2JR+hnCfTUykM0IcEo7hLGIzRCJkjOoww+vkczM+zqusOLBfOlY9e8/dNNUbvHt+wZAKDQnAcAgCpIy9JSC+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrqjxWwkfDwJ8whKfagaYu8Cp1eh7vkiW7WJF8hIjg4=;
 b=lwBuXJkhGjq9JxQbZeJGWoro7L/iT5sowjA2IBQcNjxd1VqqGlxj7+iLiCFy5kFWWPgzS3H+NL3gOqs1eh1pqYIYvb223xj84neh4uZcwqhsHhn3rFxKr/VJzpfea8YMfMnrAsibIInDzztNOKHUgM4F+Aip3picJgnb2kO7Zxmf0ZyqkgzSDZuZ4cvr5ENnhw7FTEhnlMaQrgXW1evYoHMgbTo/cc4qXPpKzRNiK1mnkrOHGBjslk66idOYPOir9DQoXzC785+IJ2HpxAzjCM6aLcmvufM/wHuc6Nri3KedF6WUZ/xuJ2ggGDx3VJ1MBaJGql6GM9vLXSjEU4OkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrqjxWwkfDwJ8whKfagaYu8Cp1eh7vkiW7WJF8hIjg4=;
 b=Tl3Aa04b+3XPPK8luJtrnP062m22ZPL/Zwtwoxv4HglDIELffuv6BMjGyRnYF58JbefycHK81sV6xaRM9dYs5dpo7D1uNZsF14TkEVl7rbsgFO65HMesbHDwij0YXMFs+jFimN5kvORwaaW5To4BJxWwQegTcRziOajmaoDQ+bI=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSBPR01MB4278.jpnprd01.prod.outlook.com (2603:1096:604:76::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 14:33:12 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 14:33:12 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH v5 1/2] spi: spi-cadence-quadspi: Revert "Fix division by zero
 warning"
Thread-Topic: [PATCH v5 1/2] spi: spi-cadence-quadspi: Revert "Fix division by
 zero warning"
Thread-Index: AQHXek+BBlohqeZEwEyahAOjis8lOg==
Date:   Fri, 16 Jul 2021 14:33:12 +0000
Message-ID: <bd30bdb4-07c4-f713-5648-01c898d51f1b@nskint.co.jp>
References: <bd921311-5896-b228-ea6c-20e11dfe62e3@nskint.co.jp>
In-Reply-To: <bd921311-5896-b228-ea6c-20e11dfe62e3@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: nskint.co.jp; dkim=none (message not signed)
 header.d=none;nskint.co.jp; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a08c444f-f5cd-4c73-7737-08d94866a40d
x-ms-traffictypediagnostic: OSBPR01MB4278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB427800B49E6FD6B2747B06288B119@OSBPR01MB4278.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:93;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlZRIJx3p8lIRrAMAUG8f9Ut+wpUB8dZano5WXImBel0Y4usZ8rFoBpcOb0Q86rHruL4cnUD/atWkraBwpH1VbkymODK1HM39p9k1j8l0qojNXpGBbOW8b8ip+DMWE1/GKb3+O5Nj5lgRyXjsHpVBCZ/KNhdMtSk03Qc0wiL0JPFVQ0QRhdNSoDzHsgX6hFmkHDzYiOsJhxK9dRMLDiciPxZBNlA2m3f6Gp8kKlUyY86gfv0Sk59FrUh+Ufp8pMcVTCE3vomMaKLbgoIepOhhsfrjw/qM8QyE5ZrzbgBuTp36IOpdpwicAK361E0xJUKMzUd4Ld51umDfu9kykyA/WlY0D5G3JcDTkGGhWFrCsLVqFeQlbrBTZ9TyDxCH58ZiuFxkngq0H1RcYUFPJDeLZ4jYhDvAWWGjzqb6g8cMpqIHJgZqnhvoWOKPi1in+nQzI2glWi9Ukvjj6Xv15YfYmwltDy+By6VV19a6w5B94+mpymi7zFw0z5/tHRaU0fZ9BmeSHBS1RqC//+snBBJ3gsOS02ss8F7QyrFg5Qr87XGR2AgSBHSFIyY9l9dRUnSQ+dbZb+jfkwoSjbfcOS4kw2e7r8P0H6fdlY7/drwQFyWkjBvNPcs6YnWJMfZ/VeAqKy3M8VqQyqQcE4UZS63g7tNgPzCsr1G6GactXub4dzgdl6Fw1icXPYMO4uJI7lye+FFU9+6qJ+EFvOLBuEYTHooJ5to+8qQ/7XV11CXzCU7q13zItf0PG1kQtrS1UhYvwMvsrmPQc79+2Qe6FbHUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39840400004)(136003)(366004)(376002)(122000001)(38100700002)(6512007)(83380400001)(6506007)(6916009)(54906003)(31686004)(36756003)(31696002)(107886003)(8676002)(86362001)(8936002)(2616005)(26005)(2906002)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(6486002)(316002)(4326008)(186003)(478600001)(71200400001)(4744005)(5660300002)(43740500002)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aWNRaDBhdzdwVXJRUkJ5TVRSQ3lSckNtd3VvMTZ4andoem9ZWnNHN0VZ?=
 =?iso-2022-jp?B?VGluMDI4NDJWbnQ4MmQ0NkJUaHZpcjE5VFIrZVdkczBWbFJrSVd0NDFy?=
 =?iso-2022-jp?B?RWxLVEVXSmJuK3lzcnpYaHFxUkxYSi9YVHVvS1piUEdpVk9NNlp2YmRm?=
 =?iso-2022-jp?B?U2doUk1uR0g3NEE2S2dsUEJVbTBjc1phMHNvaHRrcHhvTEVJMWtYbnI5?=
 =?iso-2022-jp?B?UWpnRmVJTFcrNUpFSXIraWN3Z0VXSHF2Q1VzNjNhVFVmMXpHR1ZVeUNl?=
 =?iso-2022-jp?B?Vm16Z1dqVitHdU1QNFRVbnRwRkNlQzFmcVZ1UTNNV1ZoYys4V3ZhVkc2?=
 =?iso-2022-jp?B?TmxPeEUxSEY0R1hneDBjSFBOVExSZ0w5di9BSlBQUmxyQWVKYk5MdGIr?=
 =?iso-2022-jp?B?Y1lteURoWHJpZ1BKQWhTL05hVzBSbTcwa1hWdXpzS1EwUWlEOW1sdDFT?=
 =?iso-2022-jp?B?VkYxOG53cWkwSTMrSzFLMXdKODRMSURid1pOZytSb1h6K3VzbElSRG5H?=
 =?iso-2022-jp?B?dnNlTWpLSHpDNzZyTXJaV2xGcUlJREt1NjFnNDhaYUNXWWpMQ0NVbE42?=
 =?iso-2022-jp?B?V1VPVjRKa0FKNHZub3dkUVRpOFRzTld5amxncnhSKzVVSHdYaFAzY0x0?=
 =?iso-2022-jp?B?QXpTRHRVRGFIWnJ5ckt2eUx2MnBSUkI4SHp4Y01vdEl5UElVMlFETmxI?=
 =?iso-2022-jp?B?NzJ4bWpvdGRBc1JWcGRUc2JDTzlYUUVvVmN0UmpKSkpKQzE3ai9YbVh6?=
 =?iso-2022-jp?B?TEVmSWRHMjBmQzhLaTMvTG1CbXpIUHRLZkpHSVJxUGJpblhDK3U3cjNx?=
 =?iso-2022-jp?B?TnNUVnEvM1VOSXpPdDFkSFJ5dW14czBYYW5FSEo1Uk91MWlpalpOcStD?=
 =?iso-2022-jp?B?OUY4SzQ1ZnQvb3N4NzFOU2ViMndObjJzdnowSTFoa243R3hrNDd1SlE2?=
 =?iso-2022-jp?B?KzIzVU9XbjBBMGF3TzI1eldNd3FIUEJNSTMyVzNzZ1VmZnFTSDQrbFJE?=
 =?iso-2022-jp?B?RUk2YUNmai9XOHl4eGpMZC9FVWtXYU5UTFZrcUR0RC8yVHZVbU84TEFO?=
 =?iso-2022-jp?B?eEh0aXFzelVTYXdxUmwyZWVxdXVocXNGdkJoWDhLY0RMOUplWlBrWU5Q?=
 =?iso-2022-jp?B?UzZPYy9ONEovamNxVHhvUzMrRzFrbWQweWhkMklERm5KWU1jK1prZXFV?=
 =?iso-2022-jp?B?QWgvOVZuNWVRWWFZS3Z1TDVEUEhnNEpSRFR5b1FQNXA1cncyNFhyVGNa?=
 =?iso-2022-jp?B?RThwblZtWURJdStyREhyaGU2S253ZGptUUJnU1VNeFZzd0VUK1dxTVBX?=
 =?iso-2022-jp?B?YjhpT2ZRcG4rV3Fxb3c3N3JDWG1hRkhtSjRKQkJjUDlCanp6ajFBVmZa?=
 =?iso-2022-jp?B?NTIvY3NsMjRJVkM3a0hwNm1JQkQ5M0NGRUEreWVRZFVHMXNsRmIyZkww?=
 =?iso-2022-jp?B?d3RzczM0SDAxQmtTaityNWtrUFpoTVc3T21vT0pnV2cydVVrVFdqWWhT?=
 =?iso-2022-jp?B?SGVuWHVTMDJXNlN6WHY1Vk5PNlliOThCdXB0TjVNZWwzeEU5OCtOS0lp?=
 =?iso-2022-jp?B?cUYyUnVFTTJBV2RhcEdqL0tjc0xsRHBRVExYamtNNk5YS2V4c054eHFP?=
 =?iso-2022-jp?B?WkdVWnMzWjRLVlVjdmlQbnpDUXozazV1T1BlcnZEWkZuVFRYOXdsMXUw?=
 =?iso-2022-jp?B?SEg0alU1ZEJzRjJPcDR0RmJidFU2K2dkUWoyOExpOWF2NU11M1ZnNGZH?=
 =?iso-2022-jp?B?ekRXOWJjeUtQNnMxRmg4aWpzNGcrK213Z202bmNPaTZ2b09YdmNHQUlo?=
 =?iso-2022-jp?B?RERYS1lyakYyNVBNekgwYUJxSFdJampNM0lmanNsNFNRV1Z3VWk0cEVx?=
 =?iso-2022-jp?B?cll5V29EWjgrQXNpMkMwSmpjdFA4RzRFeG42YVhzeXViKzlHeFd6N3VS?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BB88FCD915DA1D4482535821C80C2A4A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08c444f-f5cd-4c73-7737-08d94866a40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 14:33:12.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VHzAFDj5e1yX14c3G9iHonxKk+gSmQiizVpagXxTyDWbcysS8dtg+QRrZxEzHrD7I68ZKMJQ+vFqB1A24T3Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4278
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Revert to change to a better code.

This reverts commit 55cef88bbf12f3bfbe5c2379a8868a034707e755.

Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>
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
