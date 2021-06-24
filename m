Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E099A3B2EFB
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jun 2021 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFXMd5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Jun 2021 08:33:57 -0400
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:28142
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231661AbhFXMdm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Jun 2021 08:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+5ApNAbIYadtFAb9yVDb2i8CFayM6W3Ht7OayhKByNgkv7OK/Fu9FkjattLpU0XktE2yGHZmE4JVulMID9S4H10eVbHVwmLS7VEzC4KIrUXupABPoYvJeNzuiUmKtjiaFAfDFKGIa2tx0qnZbMYN9qPYR2BrGing689FlDKN8NTnj8el2JmxbJaZYwF+TCJqN/w3NmmSXVxSvBfyUcsf/eCt2OhbJQ9CT9HPDmEfA+MaWWxmZAxgpQSzPAg/kSehV8QMAdnK06YVxBjQ5mYnPkgl3cksmRTUIB68F+FU9+YNwI4TUr/pTbrI7YqD39BWEP/g1LL9HxG/Hcuou5QNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pUcqg8V5nK5KIj5K/aLyHANWK+VnC4wkMjT44er05Q=;
 b=Ac/XeEL3fJqVdwxj7KfmHTqGRBoQvtmrlWDvLrcY0fWY9LdrhANYkw2O7nECBE3rrC2BFNiuK9hpTJTGc+saHSE065XkofJzPy+Jq1/zjm1jXb2XqIMdxqE/PhaWwWUDOjBWXDXPccrJ/jL6Uyd1flSqsD1o6Py0VdAMM2oHCw7Tl78yItZnqORM1ArW2sYXMsJqir2daRAk1fpHQiws+5TUvt9EQCkLIT3EC311FM8bzyQZEasEdb3HS4nYVkTCAluFcQlhEI3CDdKts6ZqmKD2jbe8BEWwXa2ffGabEQkDNP1AHKrWAfgTZMF9Bnu/7VqFt/blY4cyKByqfScbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pUcqg8V5nK5KIj5K/aLyHANWK+VnC4wkMjT44er05Q=;
 b=fSPL+mmolJrFJjPkmWuCT0iYs6BlCYuGSBY+Vzak+G8zXap3KkoF1bL0QZqwYwxX4XpObZncdPxgtjkvSs60TzHN4VlcLH3RI3eofAhATb10d32/HtSPMyyKFEMfGx18rb7Ffh0/y2AnyoTZIxX/PrsSm+ADatCrem97J0EXvqU=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB6PR0401MB2534.eurprd04.prod.outlook.com (2603:10a6:4:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 12:31:19 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::a08f:6c6a:cecc:163d]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::a08f:6c6a:cecc:163d%7]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 12:31:19 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND] dt-bindings: spi: Convert NXP flexspi to json schema
Thread-Topic: [RESEND] dt-bindings: spi: Convert NXP flexspi to json schema
Thread-Index: AQHXPBi2J26elm2p0kSaum8RYUZZ1asjcDjw
Date:   Thu, 24 Jun 2021 12:31:19 +0000
Message-ID: <DB6PR0402MB275878B7DE63625FC5E05DDEE0079@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210428102417.1936520-1-kuldeep.singh@nxp.com>
In-Reply-To: <20210428102417.1936520-1-kuldeep.singh@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [171.79.6.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1311807d-4d7f-4b29-3255-08d9370bf80a
x-ms-traffictypediagnostic: DB6PR0401MB2534:
x-microsoft-antispam-prvs: <DB6PR0401MB25348B61C59534717C6283D4E0079@DB6PR0401MB2534.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54zH2XuXO6cjSYv2CXOUADn3ZPsm78lWzFOTF+XcjrwaSAFaaGznxeXmM77x5gRcAwxo3/v34viOF8U3pArxvrFedPrQKnCWeG6rknD1CJfUJXNDNQeCqqU6jDnUJSJ0g3x34zRkZoApwtTkxstxbdg7IsNLyJTmmHF78UL2qiQqbWQ9qX9bQJZ8AjApD2A3q1ucClCLvP6yp3vUp9WWuS9ys0HCs/CpG7a4XfNu4JXubAdhyOsBRpevCaVP05nCaj570IN5KUSYJflUgirwaMKNG2LpHQDa+PfTME3iC2BYn2PolEHzYtKTnPIuC3vJBCISiYDWo+jo82AEjO3trjIin4t/c2ExOZul7N8QIOeHriVkzAisDfXzLz5izLAkcwiGkeJlCpwu4DKkYqYKJr5gKxHZultFOP4yn7DbVVmk4dntodl4QZLKw6U9J3jmfcJSYoTuNqxIX8Jz5xjX+OVsoAyCzqhsNc97bOt/Wh9pvfLRyQSkYKbcJTj4Px6VYjm6kJlxT/fTa2v9evlaI9ic5Ljer3tyTFdCB2AwFw8owEtXmubBxaYdUWlsiNJ7/kTFdN5Wu4UTbpGNPV6YolAmqWZRNyx3mnE3GqsTflETuyFlxwHFFdFdZhttTfJiBBX0Vr6f9j6YzGZhjOoL2ArQaDOe0UlnedhMOtyqez/HMWmxkXJsDxgUi8klo64+/HLyolLuffM7RXdAlpsjcoo2BvRlWgQHXw/iRlanlExiYiVtL1UuFw5F1SfAp23oUyjaA0iLF+Cx//VupbB7WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(122000001)(55016002)(478600001)(44832011)(83380400001)(5660300002)(966005)(26005)(186003)(2906002)(7696005)(71200400001)(38100700002)(6506007)(4744005)(76116006)(66556008)(66946007)(9686003)(64756008)(66476007)(66446008)(53546011)(52536014)(86362001)(6916009)(4326008)(54906003)(33656002)(8676002)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5a/Jv19StgiiJdAvt8r3JXShLxS6J4/D8YS5QVHJG7iT8Ma9uZqifprhAXun?=
 =?us-ascii?Q?imj9GXGyStNHh9EhRY//UL+XNdyHkh7TrAeSlSME0J7InxgdttkDLmzrBNNq?=
 =?us-ascii?Q?vYMkhPktaM3RI5gvZHuh0dBvCtNlY5eU0KUB6nCSUsUrLUYgr5JWv4XcRES8?=
 =?us-ascii?Q?P7m8Jf26bQMaXJaEAhPmtF9n66WpPUr7VY4nZ0tj2gVUGtv6H+gjvYwtu94w?=
 =?us-ascii?Q?qKFWy2N0FC78+yd//o82PULP7L0X6nAoZODoif5jfvKL32XxCWOYoPsNQgQG?=
 =?us-ascii?Q?xD1dNwoqOWt3x+y0cifD+sdv3pcFaizyfbN1y7h2B5y8n7IXeBoD9RUvm5Rw?=
 =?us-ascii?Q?+1MQEGp/s0P8E0qcAeQqEyxdu+9LlMzl+r2bDkhVEeGJgUwh7gVaoImttHAb?=
 =?us-ascii?Q?/UV1ghtVKndIUxY6kPAegiGzkSk7nVZsIPNENxByJH3poZdubjtbXdMJFYnQ?=
 =?us-ascii?Q?isvudIQYrtqaocBB5O1ZTxIahf730+mcNWDgFFCx9GcXrQEpPUMlih/mYzRQ?=
 =?us-ascii?Q?XsaEDz4VT8RSFY2vQRVDA8FEUHLfkkmTlNZVorDAqxF5IvCFDyqFpVXx3Owj?=
 =?us-ascii?Q?/lbiy8Zk6cRz7UNEQE6/vw7LkQE+XlMKcYeg4YAfh4O9tJ4CriLr1thFQMRZ?=
 =?us-ascii?Q?CbB+mZgESoU+REIcZtixJQQPlYaje7kM2BWWog9e7TOPGsOhkQ2YxURGdcr8?=
 =?us-ascii?Q?kej314wFKViR+PVIRrdQwA0Qw0N3EcPmqw0VEQcyrTw9eKe4kMQz8TIUc8tH?=
 =?us-ascii?Q?gMl3VXYhJDAM4VBcQ5hxUfAv7t81ADRgaEtdvj6yH8npfkUP9HnkK72v4p6c?=
 =?us-ascii?Q?zkb9ta3GR2j01XgYtu1lfUeL5kjVspHTILNfEXow3gEYiJPaVcHMFlCpouyt?=
 =?us-ascii?Q?96PXLLuE9jUgA03/aunxcQDCRUBzV5CJcdG68OXibAKhmW9/9HZM/R2n0ryV?=
 =?us-ascii?Q?ZbSIIGEk9Wy9Bz+H2tUdESl6bhJPv6Gqy2OXb1/6YyeUBvqeD8o6fGrQzI8L?=
 =?us-ascii?Q?qeaUYjKMIDJDXXbfgShp3k1n5G457q7YVtlA65GNLOy/8Jyi4bgO4tVLppq0?=
 =?us-ascii?Q?TRCaGjjYHfwTDtSc6Y86tFGtavqCRdai2cPx5tctjP2oGVE43rPAnLB6NH61?=
 =?us-ascii?Q?mvxQkoV9yU+GfHXzlgYuM3z9JCxw/l2YTVfHCmyI3fBUv5H2IoABPOW5uh+v?=
 =?us-ascii?Q?fGF7823TSLU4bxSSCDi8TA4v622q7FZrTW+oEniwXLV9COtkV9jfnsx6bdjl?=
 =?us-ascii?Q?+s/ZeuEw0CeNwVBGKwYSxIb+6q9CzoJcmoaq/hgWqEGPp41qCMI1DHkY56Em?=
 =?us-ascii?Q?IpE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1311807d-4d7f-4b29-3255-08d9370bf80a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 12:31:19.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlT19jyqKe4ZKDIJ5mwuME/xMx/G2twAnf+islsyPPMgIfflblp6pD72JZxUoVKPx/fL+urq3avdT5kzYghgNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2534
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Kuldeep Singh <kuldeep.singh@nxp.com>
> Sent: Wednesday, April 28, 2021 3:54 PM
> To: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Kuldeep Singh <kuldeep.singh@nxp.com>; Rob Herring <robh@kernel.org>
> Subject: [RESEND] dt-bindings: spi: Convert NXP flexspi to json schema
>=20
> Convert the NXP FlexSPI binding to DT schema format using json-schema.
>=20
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

This patch has been in queue for a long time. Could you please help in pick=
ing this up.
Please note, this is a resend version and previous version[1] was already r=
eviewed by Rob.

Regards
Kuldeep
[1] https://patchwork.kernel.org/project/spi-devel-general/patch/2021031016=
5200.3560970-1-kuldeep.singh@nxp.com/
