Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D913C9BAC
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbhGOJ2f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 05:28:35 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:29315
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241067AbhGOJ2d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 05:28:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT2zgCU3rFFoEho+9B6mHzk4XCErWYnvBxRzIrwNVHY0ZjsarszcZLnHUyBzby5q4d5UlEiBFwMOtiizUNLvQNS9nlymPWWVACdPb7lEusgUx6QzswxDi4n+uU6obO+/2o2+6mYTWD/j+SBhK00vSRj1ZENPrH/eMm7yhikf84J7YKLOr/1iYhhVi+pgvyJPLsdSJ7UPfyATCqT1aLfG62TOka++pCENR5NVNTcVx0If4BcyuJlVSMzB7SqyseVPkb/w45h2BLl7Vgfo/2WPo5vtHu/T2dyqbP853EtcgNnWUUF4kVk2USox/+U8aQsENFrCQG2xHKMVoT4PGL6jfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lao7rcKqjo6lQIEUK2HR+NagMlNy1563XItcVGG0bU0=;
 b=lSzSt26h/KmDP7d2f/E2w8jZ9HsUIwgTnXR4zcGbeQEfkkG3KOG2dCcAB7yM1Hnzgm6PCxbO3iW9s+yjcHZ68SmGxrQCgRCQYwzdsJ8dvhSwvIo+dCBRnSLdlf0vtQnRFpArxhgtgmbsTq/BgBfw6AUC7yWoBF/GGPFA5xUOVqA0a1lSc67hLq0l2sypCoS7wSsnn2+UJG38sdjP+gh76Ik0WpP3TqCQOXb0D7SXEu4esUKoQ2h14+7UV3R7Lj+LzD4rRd3UMF/lQolaBjRHIgVLxN6TXCsZ/y7DvmVVYWiZpVvvZ0BvN5BLTOQQjZ/zZhi/Gs/pooHiH6vH/wDr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lao7rcKqjo6lQIEUK2HR+NagMlNy1563XItcVGG0bU0=;
 b=ItqF0TG77aW/sXO+veXs+WRAWbj1Ovnv+4SBiZEMeUzuw8UJg4vjpMC7Hr4NTRubExIHyz9WR7vr16g7l7ktSdL8lysFuTplXNfCD9j73DUUHNv9/L5BECyjj4C9ZXi3nNkdkQHeLDS/S+++LaxbMqE9Qd0gLR/uii+rbsuGsTU=
Received: from AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7)
 by AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 09:25:38 +0000
Received: from AS8PR04MB8466.eurprd04.prod.outlook.com
 ([fe80::e07e:69b8:c0c4:1869]) by AS8PR04MB8466.eurprd04.prod.outlook.com
 ([fe80::e07e:69b8:c0c4:1869%4]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 09:25:38 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [EXT] [PATCH 2/7] dt-bindings: spi: flexspi: convert to json
 schema
Thread-Topic: [EXT] [PATCH 2/7] dt-bindings: spi: flexspi: convert to json
 schema
Thread-Index: AQHXeVMjCoF9a3gIB0+Xrz/ToJrdpKtDvllg
Date:   Thu, 15 Jul 2021 09:25:37 +0000
Message-ID: <AS8PR04MB8466DF30C1AE4F9CEA8574B8E0129@AS8PR04MB8466.eurprd04.prod.outlook.com>
References: <20210715082536.1882077-1-aisheng.dong@nxp.com>
 <20210715082536.1882077-3-aisheng.dong@nxp.com>
In-Reply-To: <20210715082536.1882077-3-aisheng.dong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d94e448-beff-4cda-eeb3-08d9477281df
x-ms-traffictypediagnostic: AS8PR04MB8833:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB88331633EF217214F78A42E7E0129@AS8PR04MB8833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: os+DLS5BaYJnZOV7+pQi/VamTfrzxBEtH3IDwOLlH2g1MjBVBxBupc+52126Co8XHqTRsNniCuyJC46r695kk/EhNSelaMREEGSiRThNHw09oeNaj4DoYyRK0ASmrI3nV/zd9brALSmn3CmOW5Cd+D+8iyoY0ehmYUROvVF0r9A1Z7FCiPFq7G23CrbjCSEkpEgqBPOzppdBAQ8AmprhSO/yIecui01pGuPn5oExqCe/Sdogd1WRRD5BmhtiVQw/vmVsJ2umNMcLvkzL6TSJuo1qYF774PTLF6FYZGSl+TKe0ujOwnQ4djCuWsuFAxzxt6zQEMYFn5Fv1taZW+UOh+iuulR1pQ370AWrqqUDydF85c+qBaSBVuME6aY8MPpMaDe0eCJ8UjeRo0ew8x25ivh/m6tjGpryz0d7f38ZGLzAgytHFEm0/wZhhDswa98+n5n4td/nolVHzTMHXtgRdXoUPNsHtcDmqT8cYKQKLTRHqpY1hRixe63quk2aF5Hyd3zqNfCMoL4smHrvsY9Ho63tX9oNP/ihXfwXE/YmlGm4/2tWfGzugXssRWbjNUYVLsoK7G60tTnFc+Gduge6QlUTaY+5PGv+jSDGoRjpHlxohYglI5RSuo0vVkqkrblpw9GnruvrX15+EoF6n8rF66249sj5CABirEz/uzMk23Wli2ZuBl64IjEuXqX7KAcpJtg+wdAcIY83Y0aqA1g8EMob6f428OU4v8huKQDttM/NCVuGX1WMfLSp0mRONa2Z7aCzprUvmV6moUW4e7U+/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(66446008)(66946007)(66556008)(966005)(64756008)(55016002)(66476007)(478600001)(5660300002)(26005)(71200400001)(186003)(83380400001)(110136005)(52536014)(54906003)(86362001)(8936002)(316002)(9686003)(33656002)(55236004)(4326008)(122000001)(38100700002)(76116006)(44832011)(8676002)(7696005)(53546011)(6506007)(2906002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+QCKW5lniOPJivdmduSLxEr2vkDU1G6RlH8IQTBJpx1IUK5E0uIzicHvXFyE?=
 =?us-ascii?Q?prjuLTjW7OCJlHdD0zYZyEAdxt8K97geLrO7F2NnkijMymb9HtQDkQB7O9EQ?=
 =?us-ascii?Q?Y6wMgMIJJRZGwiHYjnK8qlKjyZbRX4MKAt2XqKg/OgRRzZ4ZVH/142BxSol6?=
 =?us-ascii?Q?K3XO1f09V+dOkNVRf+wKwIpX66bJ6eIJPQF5cUd/xtISyI8jUq+ypSs4t1Fq?=
 =?us-ascii?Q?06izyZEXmI685frsj7Xr4a7dEtHBiidXwm3Tg0MWC2tcCgmhtezvS6I+gwlY?=
 =?us-ascii?Q?OmYx0+nrehRr2FjdX/u9MctYA5NU/EhXTnd5HMcjnJe+pAKHKoYEH3pbqvm7?=
 =?us-ascii?Q?uCDYo9Ns1dzbCLpalmCXG05S87uhPnJqwj062HjxNEPdDgfFLkgvfw8fM/GI?=
 =?us-ascii?Q?MmnybtfNPY5KJ+R7jaBNXaOEfkd20hIDqC35dWyk06z8ZG5LhQ5SdXJjFK9e?=
 =?us-ascii?Q?KKo7tPzHG87meH7TS3RbCFZNdLy787nrejSYFSYgDO+pwU8AbtwjcM0SjuoU?=
 =?us-ascii?Q?jcDNObNwFeB21eCnzOvwpPZnCQ+iu/CxfQIRZLZ09EsoFPsOuEua+lcCDk+S?=
 =?us-ascii?Q?lHBucTzH6iEsef53Z+yL+6g3LgV6D1tOxB5KzElncnkpFRmkJ//5RNMpATZ7?=
 =?us-ascii?Q?NaUsQmOstuiNhG32Yy+3oA0/X9QjL4B1j3JI8K1O6hPUHsMNlNlm4yje9HZH?=
 =?us-ascii?Q?OrujXiXqKjaJwvv6IpJl/fmQKInrecTDNxiErcTVDolUg3ofM7P8Zpi6ZyyL?=
 =?us-ascii?Q?IqF972qipNBOangFEB8bDKnuE+hkGnbT8M6VgZPFdJNlGZoc7BIZGKyZiLJf?=
 =?us-ascii?Q?3rRROJDMtLOFgOZCPrdsEGaeCIxWx4QlBmEx5cIRqJYpg/4vkG+9vXcByUQh?=
 =?us-ascii?Q?e48dCzT3h4uI0L3UdYpGTAwp7NjfQf7XBHxS6FW0Q0Q3f/zNs/7qF1Ux8phB?=
 =?us-ascii?Q?LO0+ZIJAxsvMZBiQUE5SI9dHKtukBB57QN5urhtCfOs0olLkT4guXE/NNnoo?=
 =?us-ascii?Q?jx0i3NiaTji6ytnKbKxqd/8oP67nHzvIxwvv3LtLM4yxFWXehISLfrIey7oF?=
 =?us-ascii?Q?p5L6RlTIvsfjtvLZW3sWDTsKhI25KdtR+9Rhh1v/mYVaNJAXTQQJ3RSklzQ7?=
 =?us-ascii?Q?nGDISA62MwYZ2OGDO4JToOI7FFS6bH0wi/MZaAagLcAfcyThN/6T3OuvMpkD?=
 =?us-ascii?Q?5FZyrkn/BZEkWT6I4Amyvd8kaHK5dNRye1l3J6VUVfHB0JaGihi4vefstT2B?=
 =?us-ascii?Q?oq8WH0qq3oEW74pahXcdnHiqLA8Csu1xeFzfQy5Om8pTELRv31RVi9lUFcIx?=
 =?us-ascii?Q?d0c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d94e448-beff-4cda-eeb3-08d9477281df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 09:25:37.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tW+dv2sNN6aE2KE1vhUh1XSY9s19kRV+YrKwnuyt6Pr+Nd+z+vaGXf7HT+AelEBcw9MXWQenmiEgT5F8wlHsxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8833
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Aisheng,

> -----Original Message-----
> From: Dong Aisheng <aisheng.dong@nxp.com>
> Sent: Thursday, July 15, 2021 1:56 PM
> To: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com=
>;
> kernel@pengutronix.de; Aisheng Dong <aisheng.dong@nxp.com>;
> dongas86@gmail.com; robh+dt@kernel.org; shawnguo@kernel.org; Ashish
> Kumar <ashish.kumar@nxp.com>; Yogesh Gaur <yogeshgaur.83@gmail.com>;
> Mark Brown <broonie@kernel.org>; linux-spi@vger.kernel.org
> Subject: [EXT] [PATCH 2/7] dt-bindings: spi: flexspi: convert to json sch=
ema
>=20
> Caution: EXT Email
>=20
> Besides the conversion work, also added the missing clock property in the
> original binding doc according to the current dts and driver implementati=
on.
> Otherwise, make dtbs_check will fail.
> Also fixed example according to new jason schema.
>=20
> Cc: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

There's already a similar patch sent upstream for conversion to yaml format=
. Please see[1].

Regards
Kuldeep
[1] https://patchwork.kernel.org/project/spi-devel-general/patch/2021042810=
2417.1936520-1-kuldeep.singh@nxp.com/
