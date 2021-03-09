Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0182331EE6
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 06:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIF40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 00:56:26 -0500
Received: from mail-db8eur05on2049.outbound.protection.outlook.com ([40.107.20.49]:45513
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhCIF4J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Mar 2021 00:56:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX34Ry5FKJRHj5yGE+RFQxR1qx2e4ZYkH2v5XJPe8XoqGomJg8j06z8kKCTukoHRM7SfPCfK/pTTJr2fYvh+ZlvATH8HSAIyiBFILuAdY6DqCPygurIpUXM0i17unIxk5bxKDqnYQ+jv1+0uO+FaI356rQlZLg08rbRZKrwu2H1N4yTULxvtf4vvd+Ap1j47AY72xbRuI9jNXVOyWzmEMEK96bWRgENapNIF7d8QdThTIg2c3ElS/dB7Lu9MOke8utdNCVnNjP+A/poKeFA1sOg8AZmxXYKs9uy4DrUci3OYckotAqeEwaLnXW+sAObAP1ov5Njnd8tSxVR/T0kDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HszoRDM0OCgWJSp4gUBpGvTnM8pFGlhZJ4dMTca+7tg=;
 b=DyUsXTXUXCyTkHdOZ9sw4W9bI3hDfVJE0M9ePBozZtCOyn6Bn6jDanYCTSlG/yXrkKSQ8yCb9nOQXq10Qds1M3qe8DNg/EYSDB+uhYChIYQCriLPzZfE0o3ORg/ytaT2kLm80+JjsQlpan9ooMYGK0exBeWgm3PuQO6iIs0+8jcNOp9+59kzV1b/lR0Cy0C9OKTBXtZrBXQ67HrUHWgT+qpojCo9+sc9l5EIj3rVBWgKZuCtYGjh416BEBh8FGXtwRPAmQL0P6G1+wIBiD4crDJX4Xn/VYt/9dH7eZVZkzzwOZBFU4T6/+JbL7/bw/Vauc1ytw04wAIaHWwSuEUxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HszoRDM0OCgWJSp4gUBpGvTnM8pFGlhZJ4dMTca+7tg=;
 b=nu2Q/YaXA76O71MJlyddRGnt/BkG04mGoBcxjuOOcHMxD5No0PeWv3BKBDn6Rtm9QHzb5QAKahOc/B/VaIpDR9PsbNV0c23qbncp1JARRYiaHwn+KwM24wOPuUQ59hUdrAOzXhFCeeUoKAxAqJ9/VklCr0uiSfvz2QtEQxJ6WUQ=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 05:56:06 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 05:56:06 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Heiko Schocher <hs@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 2/4] dt-bindings: spi: add compatible entry for
 imx8mp in FlexSPI controller
Thread-Topic: [EXT] [PATCH v2 2/4] dt-bindings: spi: add compatible entry for
 imx8mp in FlexSPI controller
Thread-Index: AQHXFKW4s58kNKH0jECKpV1fGZtOvap7J56Q
Date:   Tue, 9 Mar 2021 05:56:06 +0000
Message-ID: <DB6PR0402MB275838BF727B891FD6E2A62AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210309053116.1486347-1-hs@denx.de>
 <20210309053116.1486347-3-hs@denx.de>
In-Reply-To: <20210309053116.1486347-3-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [27.58.231.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b037b13-8a5d-4d4a-8ec6-08d8e2c00801
x-ms-traffictypediagnostic: DBAPR04MB7285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB7285D56A7DC34A3B97362801E0929@DBAPR04MB7285.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1q3wDfJXnBFnRu3/Nrx1MyxVsfB1AFNgOLWMGGo17oNaRdAh/453nlenIkKa6n4rlo8QhnoWIP7rSv5izMvL58Pz9AS1ofzFqy9QpiW8Ifd2P+PGmiuOL63WWkI2Skk+pApFjhu+84oL1U2g1X4aTM/cTmU/xhX/FQa+/ZtzYVVSqsa7hlyJ14psjMU8GzTcd0DBkybsjG0LYgYengmM8gEz3ZKp78UJNwEEtwub2c39jtGTyJ2kABUu5eJE2b78ReYbqZYMppHSN00gayXBe56a15klco8kmCmaeYvLz334/SPAxRmpPyV5p/pI/QaDpTqWbWvq4NL81MlgEzFgYA4/AHycs4up1OxFzHDWJdrWHdJeBOZpaqZ9FRKRaudm6zmiQqo5mmvOdwoyMGcDthBPDc8TJMjUl+i40b1X3w6xmPPHC1FKqAlBD8dHsqdg11nLQEPd/re1vO6kTHUNFF8hexzBB1JM5HEDkNCKa6hAx7vNqWbFiJkkv3MO/i0yO4k3kyZ16lF4CjlPUr7qxwKRTTSGajERUdGrvR3T5N6auIfnK2I4krrFaVbtOtpgGgCnn06C/k/ExTZ1DDboBYDjnyXjWK0hysWCN35lMDV4vaVjnynw45IClS+c4rbaBiyYJiY7eopqpBXAaiQ2Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(26005)(66446008)(316002)(186003)(83380400001)(33656002)(8936002)(2906002)(64756008)(5660300002)(76116006)(7696005)(9686003)(53546011)(6506007)(4326008)(86362001)(52536014)(8676002)(54906003)(966005)(55016002)(71200400001)(478600001)(66556008)(44832011)(66946007)(110136005)(66476007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1hSFG270sRAQrEPNrQxWLen3UznUgecPGglT/Put6h/sI7abf3q0sfcHaF4A?=
 =?us-ascii?Q?wy8wBroMhV+LrcZPxW4iYdBr3x583LSMwR5DZ5ITwEzWIK2uUml5LRI0VETK?=
 =?us-ascii?Q?WcD5CdaPk1/Q38BLWvqmUS3kacw1xfxdPz+zHcxQD9vJBMrHHQdd4vX96ekr?=
 =?us-ascii?Q?lvtIEwkyBn5xdH6sGijZ+iK7s2FT9F9xOwImOOt5Np9luyTBbk0DRUmNmRFX?=
 =?us-ascii?Q?gCUAIRIDKndw3mC8eKsw309NHgGTQrBKC6L0tMB2937BL3gPVen9U56T1YHl?=
 =?us-ascii?Q?lktI3IYDg8cR4Z7DZDUQiFT8O6oc4HO1lm7utxDVUWkzbLb0z4F6MhgnBQ+5?=
 =?us-ascii?Q?bvikNh8jyiQNvyGyZjgCrnpugrLF4Ih9Xyv0YMJMoeD0Rm9fYb2l4YBdQ7LT?=
 =?us-ascii?Q?KL0moeyAao8wB1dLigKRmNYswD8aN2UtwgH7cs9TjjSvlZG5/sP25PPSOmb6?=
 =?us-ascii?Q?117H7n5Rwuehb7VFPZeqGC/VbSXv2DMl1fHKjB5GzWTjq8KkF+8gVshdqwyY?=
 =?us-ascii?Q?L/7Ev09oH82+Q2HqoucT/79TixKLoB4LJD5xbTXfquB9nbZ/5ue2rbSuyHti?=
 =?us-ascii?Q?pasLGXs7mjqkaDm1+2Q918goAPPoHyefHYIH12QIZCTaVlsVR+NpYmddFHLx?=
 =?us-ascii?Q?9ZlELKCuk3Jybn5fgZxfsn4e+zl6JXVsC4U9kZ4K7CDFhFgMcFwHmtEcbbn8?=
 =?us-ascii?Q?/oEHSiJ31YIdibK6Uefgqug4Vm2plHzCwx/AhOhncApdfTydQ+qNX/ztauMP?=
 =?us-ascii?Q?PN5HqiclXbiF0mG8h3igcs/+mpAQVt/66bmcDb2hEQ4+mToKdZBm/19pFsQQ?=
 =?us-ascii?Q?EJoWuRv+VafK78TpMkZJXKIi9nV6XC6nG6I0G0w7be78O+0HZVuHIRIdF3/f?=
 =?us-ascii?Q?rqE8pNMAWXGEdxTzV9EP5ykcvHu2zRgUHyaCh5+e0dZjPTVwx2OFwGtgTYhi?=
 =?us-ascii?Q?aP7zm7gWLGwX4HrPGfEQQvtQfoGH5KC8BN6Ivvv2xie+9kHiKWmQQY9SVH7F?=
 =?us-ascii?Q?L6ySoSHkInu8t31ehqoyQVavUJRe0e5fa3iiFD9DBLDXlpDKj+z7dQ0GW7ba?=
 =?us-ascii?Q?8xRO1De6K0KyD1krWim6FU2iYIC/9OO6Fsnd4ASPiT8eu01BZP3bBv53pzm4?=
 =?us-ascii?Q?OkpONDyOwrZXyR9HqA+S17QMjEpFyYqjaB5jwyaSp51ZmwgHSMOzy3JOSf50?=
 =?us-ascii?Q?auTvAut0LkwleScEyKXzXJl/oNkSJ2NseluRlK5+y3Y67l7OVznfHVfDJsZH?=
 =?us-ascii?Q?uk0REX4IGpBQUFJOB/bk1uMlqTi3linQ0zP+a1ljmKaoYk/2FQCvwvyhVEzE?=
 =?us-ascii?Q?hh8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b037b13-8a5d-4d4a-8ec6-08d8e2c00801
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 05:56:06.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18PWVtG+keAbPC1N1QG+GWJ8eSY6dy4HLyYKWCEce0UfHEFQuUYtYhDxshyglkVkb0xUCoCDadnsx9woIqe2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Heiko,

> -----Original Message-----
> From: Heiko Schocher <hs@denx.de>
> Sent: Tuesday, March 9, 2021 11:01 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Heiko Schocher <hs@denx.de>; Ashish Kumar <ashish.kumar@nxp.com>;
> Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>; Yogesh
> Gaur <yogeshgaur.83@gmail.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-spi@vger.kernel.org
> Subject: [EXT] [PATCH v2 2/4] dt-bindings: spi: add compatible entry for =
imx8mp in
> FlexSPI controller
>=20
> Caution: EXT Email
>=20
> add compatible entry "nxp,imx8mp-fspi" in NXP FlexSPI controller
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>=20
> (no changes since v1)
>=20
>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> index 7ac60d9fe3571..fd5f081f6d91b 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -4,6 +4,7 @@ Required properties:
>    - compatible : Should be "nxp,lx2160a-fspi"
>                             "nxp,imx8qxp-fspi"
>                             "nxp,imx8mm-fspi"
> +                           "nxp,imx8mp-fspi"

It seems the changes are not on top of tree. Please see[1] for latest chang=
es including imx8dxl entry.
Snippet below:

Required properties:
  - compatible : Should be "nxp,lx2160a-fspi"
			    "nxp,imx8qxp-fspi"
			    "nxp,imx8mm-fspi"
			    "nxp,imx8dxl-fspi"

Thanks
Kuldeep
[1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/tree/Do=
cumentation/devicetree/bindings/spi/spi-nxp-fspi.txt
