Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8B400A94
	for <lists+linux-spi@lfdr.de>; Sat,  4 Sep 2021 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhIDJPr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 4 Sep 2021 05:15:47 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:42289
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234371AbhIDJPr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 4 Sep 2021 05:15:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhAgI406v4oC/vrR4+9PwLcjADyWsa/Qj7U9UTTrP6B4wsoTb4kdxmkdbnfyF0XCXpRuEeQThKed71KkfxB0lhKDoIW16z8EO/mYNjCy5et1vMb15rnyUvQ4cfqMJCu1Hn1ZnhyoKbvnUmi7FVqMfhC0Oz8lxTes3nwpyD1K75l1KVEhI2FrPcpy9vZuwhLZv98epJh41BW9s5j/rJQbPOgCh1/pSIFCDpp3aUSgWfLs/FoHBi11olJ6j9ysvWPRdr2PGJLnTNJDxY7XKxyIAXFvyWuFoLzb+UqqQCgtN9A6zBRi3hu5kKtU+Pezy/i0fbzLz9+lA7wE7PBkrZJggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=I1fuoApU0YNW0FT+NmthcOP4zdVYu4xr4dt9YmXjxEg=;
 b=EpqT4rpIg9Ypyk3pLfskJpElh76JZOMdwclpR4ykgpOm7PJaDfLRmTReSq0IRDtZpYaOWoKD7gojjlRYHEvEKzzMiDEXKTJ3nkVgUl5Ugs4jHOmthVrlh0zHBC3ijsX3cBrI/BoCRK89JFOglB2+G/B9V5cICese34tZ1l3RZ8mpnv5bzuNouJp79NtcX4Wkolc7XlrFiLFr9jWsOjVrfW/UnLmNF2z5qk/5BvZUZUX3hQozz6RSYif+Yuu+FFCgILQDWMYy6dvkIl/J6JYSHaCXVi0K6JBiIoNKA+ctnQEWq+RQBadNxtkErHNgXzrinfAL93l/c0aU/DZC9tuKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1fuoApU0YNW0FT+NmthcOP4zdVYu4xr4dt9YmXjxEg=;
 b=I+xmMzi4A2XvgBHRUee+pPMaLLs+W3FdDiNV+OPTPjJm9b+0zXUQKVOe23+1NZ98bkrV4T4h5cUaI7fz+W74ju6o2Cb/I9XYOuzOaJTW+rU385YscIKvAK6HVNSJaFjZto8XFjWb9phaxX7pzbtWYjOUKUtxIyDW6OtEZZ8Y/Ks=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0401MB2304.eurprd04.prod.outlook.com (2603:10a6:800:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Sat, 4 Sep
 2021 09:14:42 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4478.022; Sat, 4 Sep 2021
 09:14:42 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Thread-Topic: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Thread-Index: AQHXoSyiRmcZ5NzHVUqOJbJI+inHIauTmDyA
Date:   Sat, 4 Sep 2021 09:14:42 +0000
Message-ID: <20210904091441.43jqpnbicb5kee3s@skbuf>
References: <20210904013140.2377609-1-kuba@kernel.org>
In-Reply-To: <20210904013140.2377609-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9122003d-06b4-4310-0929-08d96f846e05
x-ms-traffictypediagnostic: VI1PR0401MB2304:
x-microsoft-antispam-prvs: <VI1PR0401MB23040A9AF0F6DFA979D5165CE0D09@VI1PR0401MB2304.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+eVZtRyJ/51OQ+pI3vzeLxii4cqbBY2sYX+JT0zs7LtrKK9DPWaMGp4xtb2d6zTzTBTUKokC6EUMBJ/FrzmRU1k6cwcKybToynjSMRXFQ6D+4jVb0BG23Z9RLmJUFvzbWcKTEo9HJR0oyUpmREuc7HciIg0UcvbwMeOefv1OMxT299stiNYL0sD+7MJDDfSro60JFfQ2qKw/l1bt7S0/vCCY7+oOFJuWeOPyEk+NG5oNKLJ0oL7QZKDwDy5GCf2f1yPS5QRiz9LhqSK3cQdR9jRlLH2rgYLEWbrWGq17QIT6DT0efCqiAdbUIgV7tpmgyLL5tefCTtaD8aPyhTgFcITEMFY7/UQZbJOlbtyRvYZMy708Oe2UzUL8kX5tUyVUMQLvhmDwLPppgAXz0yUhdOrkT5mZSOVzg3vHXwQYr3R1Wxth/MGiLn4yrZ6I/CMSHF2B5TZzA+FFG4+q+Mz/3F0UbJeH3Gna5hhK5urP0R2H3DFawlm2wW7Q2Y733qaUTy5UjPkEZxPdlzIhXABqG8mdVu4sNZ+HmrCl7pdHC043eBFLkMchgl4RkyzlNou9T0plnqtjqS0WFR0nssf86299BYNYTMNsKrBUms5kjj6Ixd2uoK6MrDXLTdlcwBq4HVeQmF2NiveYx2fON7sawhgTQYqHDaug0Snrm5jjf5gJLh3UoKztjOftloRJu0meLn5I4BSC6JFUqO3OWlweA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(136003)(39860400002)(346002)(396003)(376002)(6506007)(86362001)(8676002)(316002)(33716001)(76116006)(54906003)(44832011)(122000001)(2906002)(38100700002)(4744005)(6916009)(4326008)(38070700005)(26005)(66446008)(64756008)(9686003)(66476007)(71200400001)(5660300002)(186003)(66556008)(6512007)(6486002)(8936002)(478600001)(66946007)(83380400001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VaVWlnuHbKg9PgRupXOa3201S508NKNRn/VjVcDXu1SpJ0lq/+4AJGUOYHJY?=
 =?us-ascii?Q?l4WifcDTe3JMhLagL6E20c81PmIVe6WRjwpXTO1rJXTsTTrHn3N/3vfe5o1q?=
 =?us-ascii?Q?znuovhUKUFgO4r/931uU5cPdeGOu9zma5KyoKQX+wpgeF7ZokRtJg4/P6Vaq?=
 =?us-ascii?Q?SEQwz0sai4XE1SRZ2JJXoIy+EDXnaQEMniVn+EAJaIUlBgbdCbkKeIMYJF4V?=
 =?us-ascii?Q?c35MSJqgu0PGKC3sYEW7od1iTzzLkByntvImrhTgV2HCNGa//sR4qyEQaN6u?=
 =?us-ascii?Q?QC/QW7K6gYsk+cJrFASHIZGfp/zqR1WQ94XVMNmHZ31sFX98+KG2x3iiVQrN?=
 =?us-ascii?Q?K2X4H4o7+Rtdx+DHSJx4F53OEluogv+4VLVWbKj7tQktoWPcq9q/B1B9SAc4?=
 =?us-ascii?Q?G7FPJEakEEocdmAskfFBjah0666+9oez3R1bNJwN27/jwXmLjFpBMNV8FD7y?=
 =?us-ascii?Q?gu028VTiShAkcj//DhMpFjysoayhTrKdNCPAp7HccXh812da+4c/OvbUd8jg?=
 =?us-ascii?Q?7cBiIV7Rvql3Clpq6RV4GMIToY+vx41gFSROLKq+qR30fQzYgJBDlBGk5oOC?=
 =?us-ascii?Q?/m8Q2OZOBN/8242grNiDfjxyAlexkcOa9xl1I/EPaRTGCHV/95GyUUYpr+yJ?=
 =?us-ascii?Q?4504R5TstC0R9FlZhV2+eJhyvojW4rzaX/JEG13FfUajV9AiOl5Is4C5MfTJ?=
 =?us-ascii?Q?EQnXIhQZT8vBhH8/ybBCYwtJocjAF08mlsiPnBqsh2rsHR8Xqv5hVmlIDTPh?=
 =?us-ascii?Q?8lmTRBKLcRLNB56c41Kw/3DKDWPm1smlTGTVfYp/7NGPmxHsw3k6PqHCGVyE?=
 =?us-ascii?Q?U502nlDrTT/TOaeigkO3IhFi5TrRCLVxSffC+FkY+jsDLKTTJB1ilGRErEbB?=
 =?us-ascii?Q?DGL1FJwlgwqgw9ToShrgtP6ksZMBxseghQOwDEXlfhPhPWPs9YcskqYAMsYM?=
 =?us-ascii?Q?aU56HPWXSKT4YkCDYXFhj6BkBcjTBCLnN3raMZI8zeimS891qPDxpOyLw8Rm?=
 =?us-ascii?Q?29h965IW7Fik4vSkhXwYwgS32BlbBGbH7240+tuB4oXMlrs5u/tfGVdcv3p4?=
 =?us-ascii?Q?ar75+JIbhIkdkXRtLDYWXjUHTb+6+3dH4eba6HDXBALmbq+rZjDS0XpN+vH7?=
 =?us-ascii?Q?LsUedZoyFFcDJu04x8ldFpYDdGRcP0c0ye1FCDHtuzOB0mkQMAv1huRSV4Nr?=
 =?us-ascii?Q?D65tL8bk8V2sSRed7aKHQJkn8JDFxT6ZvsT5UihP9aAw1Q0P7141cwNWdMUG?=
 =?us-ascii?Q?OzFvNUv6hrjDBcX1gLKAIBWWa79AodwlEJbYLckUVb/b/y0dbzY2w7m4MEZp?=
 =?us-ascii?Q?if7pAqclNGVIDJskngkOERFq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBB67A7D9BF78E4FB48584F4DE12EC92@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9122003d-06b4-4310-0929-08d96f846e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2021 09:14:42.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWpOMu/UB87CVXNv+9yTdgrCOEa553gpjcgWEMdf1vjko1TFaRxvg6OixZmXDur9ESV8Az0LLjsLfXsiKRHjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2304
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 03, 2021 at 06:31:40PM -0700, Jakub Kicinski wrote:
> Commit b42faeee718c ("spi: Add a PTP system timestamp
> to the transfer structure") added an include of ptp_clock_kernel.h
> to spi.h for struct ptp_system_timestamp but a forward declaration
> is enough. Let's use that to limit the number of objects we have
> to rebuild every time we touch networking headers.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
