Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8DB367F46
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhDVLKA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 07:10:00 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:50367
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229972AbhDVLJ6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 07:09:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3DAPfwjD8kFoyY49x2W2Q1mI0KSqnxCj9p37i+0woTiizOSmSMCYH5e0rxCxtKBZKdpkxlqPsUw1tQnX27Qv8inhjG7jVhuXBV562sSq8MQvVSE+y8v1aZNc4k/OnUIjhMWS1PDjfpgYvYCsKsmYd8t2i/mZW5hHg/5GL24IUazRowH1RUTkjxyV3lqlGtm0zQFimjpl37c84OxmCIkN/avIn0WvmC1jw6Pzy36ymPCwpIFeoeKFOb4OeBgSwYZr459C442j+wLtf/hpXZPvagVZlpd7sVG7LB4gbPxnwGhg8O22rUEjcP7H4tjYz15Kz5xrHcsa0j7zE/9eoKJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4yccrMLo9s+M2IzKE0edhaI55zq2mEOqfpgENbUCWM=;
 b=UOAGv/u2blwAlBufFr3JuiSA/cOAX5s6r34lcc0IBMzTYOqBc1Zs8+X4F9LBLbf6j7vNNQK3/MoGGVK0lG7mTomCTvM0JQ91roeJXm3eswImumW668izCZXUZnXqJCu5fWecSEeX0L+MYyWSa2N2hXY68N0F03OLq4ZB1l4h+OEmewO8L8w9qm7fLDBWEdVH+GI0X2pz/uTISRfweBXHUw7gBkG5ph/fxTDvsPOlJh5UZKMVzrGzilsiiLlq1kfIjD+F2SsFskOJ2HjzUAjNTaeFEkIf2AavXI0JHlE1UPJGkTL8pBBWycD2JO4+6GhGzf9d2nr5N9thSkCT8sSKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4yccrMLo9s+M2IzKE0edhaI55zq2mEOqfpgENbUCWM=;
 b=shW60syNJNsEkzOtJUVunkx6aF+Bd9ew1E56b8o6ZPo1k/RKe5H8PYNaRj43qlAyWA5Zd3/LLui5NzuUC1Bo3B1vIk/cA6mw+o9PlcvuibCLWMs93gOowaslNh1crWxx1iuFy+DYdCzZIa7p+zYDdlNJuUYeDv9bBcUOQPz1RIU=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB6PR0401MB2533.eurprd04.prod.outlook.com (2603:10a6:4:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 11:09:20 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::1cd6:6248:b130:4cb0]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::1cd6:6248:b130:4cb0%4]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 11:09:19 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale QSPI
 binding to json schema
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale QSPI
 binding to json schema
Thread-Index: AQHXFwJILdmYMKqAOUa0zegP/3OXpaqTVYEAgC1EvVA=
Date:   Thu, 22 Apr 2021 11:09:19 +0000
Message-ID: <DB6PR0402MB275836552946D34CBEA47C48E0469@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210312054038.3586706-1-kuldeep.singh@nxp.com>
 <20210324152420.GA3093662@robh.at.kernel.org>
In-Reply-To: <20210324152420.GA3093662@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.180.198.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 942d6e0b-e07e-43c6-7063-08d9057f13b0
x-ms-traffictypediagnostic: DB6PR0401MB2533:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2533FCB3C1A5BDE78804CA71E0469@DB6PR0401MB2533.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /O2J0G30UX2YoC//4orJQtcLfNfke9YRkhQ/MNJhvvKcTB57UiUfsTgHlebwxclC8c12CUdY9QDfzrryfZotB9GBurHgNNyyQCAeh5PVx32XCj+b3MeSPbVJI/DvkyLXIEkJrJB5klJh8fvzSDNfN94AWtUbJ69rHtfE6vYgnpYMtpz8S0ex0IokPN6KGhSjO4xEJqOHCO8GDkm6gRssyn02gXzv2r91llpr81IqVyiX1diUwfm1lzaamNHkc9Sy3LQL8YDWRERzHqnU76dZqzsp9YvQRb32JuAWyqn+/b5XNRMRTgi7dtLQ5WdANtwlvcBV6YX9Yk/mM7vNyU0AxSf/wHRQS37J89aV6FtNVqI1kKI7rck7hwXIE0uCrqdE8eKf27NUbOKqU+HVDy/PuBZruqVPqTAuouuNxnbY1Yfc81UB2be6EIxO/F+WsS2NhGU/5mgiOP2D4Ld/fSC0jv0An4BbognL9ymXMYtzEIYZcwYz0UFrqUjqcAZ7F9ZOx0WVTIVQEqbUKfQmYmfwHxhjhW+vLYib4oPfBkmfv3iLKxG9axeN3HO5Lfb4qTSNg38m+Zc+bj+TNo8fejKVJygCbtVTVgL83vlI3T3m6zk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(38100700002)(186003)(55016002)(9686003)(26005)(8936002)(4326008)(86362001)(44832011)(122000001)(478600001)(6506007)(7696005)(8676002)(53546011)(6916009)(76116006)(54906003)(2906002)(33656002)(316002)(66556008)(64756008)(83380400001)(5660300002)(66946007)(66446008)(66476007)(52536014)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8IJtRQm5LfymJTeMjtK+4P1eGXeM50vEbCByUbmvgY6Cjvwd47+VEOZqxZ1w?=
 =?us-ascii?Q?T27+xhAGqwox8Ap9B3BHSHJ26znsfhemDMAft83+9BzBRHXl0O1EOVbj4BmV?=
 =?us-ascii?Q?/zKvcdopgsoCgXCwcFbG9Vv1a1xfVC7bcm6/FW0tbuOKs0C+Uyapn1mtzy+E?=
 =?us-ascii?Q?v38RyztVQYevCGX8Y+oF1doflCzypy+vOSaRgTxaclvb60xNOpxLjvrvI5xT?=
 =?us-ascii?Q?75x1a5+rUllV63dMUeLJ8a6kUqNhBLm5L3HdZhxWKAZ0LDQ42EHH2CpYqC82?=
 =?us-ascii?Q?B4bs+/g6OoNNa2IV9yik/E6VWq452ltllZftd0O29GALATMJEpFGUY9iV7lH?=
 =?us-ascii?Q?y2hlZqOenMrE6xBQjML22XBz2PDpSK2ek1X0Jq+2YK06CFHlFTOoH57KN2xZ?=
 =?us-ascii?Q?imJmyQqtpulVIeg2m5hAjK69Otw59+AQVbAUctZPG3H63agDwQgJ0J8Fpz/w?=
 =?us-ascii?Q?HNGGblSdfnLJn9YavWu27Ofgq5GVT9So5sVTyK90jo5RFdHdG4gyYJrrjuSb?=
 =?us-ascii?Q?BVrz7iyVNIBHdNiHchDU63tJwlFYy3uSFSPJj9kLoG7KMckEtK6lqJCqoeUn?=
 =?us-ascii?Q?GlUSjf5JetCXucnkcYyTYD5qcdFwnaNISMpvVPeaqbwDcW40lHH9a14mTTsI?=
 =?us-ascii?Q?PVCQcuh0ecJKvUusH3lq2T9NaqT0jxH1NQAQB/Aj4QAv84yOEQw1x/rU6Z7V?=
 =?us-ascii?Q?Kf7fF7o5wTnfZkiXcNeXMQSonEeD//Rcl/P+O1Zo9Vt90Qm6H6BNq6UpwR6w?=
 =?us-ascii?Q?6ULEWafi2RjsZyDonubuT1hQT+4IngyGrs9yy1E7p1PtMcH9DvVqcSx3OE76?=
 =?us-ascii?Q?oNLV5r+mETrOpQQyX9x8sQUPK5Bu5ehRA1ZtCzMzOuR8Tzqq3VzerfYgH9w2?=
 =?us-ascii?Q?2jS3wZtOL0ejriLr3vWPMqnUDn4jTXX+c8P73Lf0vr5KU5ouW6QP5NItjp9O?=
 =?us-ascii?Q?XgpYYt470BmX8lGfI6wKgpHAMXM/7PVtVl1eP0fMMj5ybhOK8AjKHfU7Ncgz?=
 =?us-ascii?Q?ca48qtu7/x7LB+Y6pxpqE448a2Kou4gWgjYkJAYwgU4AMZl0l7d+9x7MbxDY?=
 =?us-ascii?Q?S+VIQL+gmWAjokOv2y+V0ldNfvTNyPlKnciDqL7KfeqQXVAXT2cervO5mqz0?=
 =?us-ascii?Q?ac/PvHMFWoxAvCEisQS8KvGNucQ/+4vzd/WibLjujmwF17k6Tj1YGbX9QVY+?=
 =?us-ascii?Q?3C6yitwl2KZsxwPkifQeJxDPwDAhtkG1eGTP7bVa0Ct8GMXYy+KJGj1cLRJ3?=
 =?us-ascii?Q?m4tK9iBdjTRANFp5NUADrYefITTGwbUxl2lPWBiTl6w6LSRXn+z90ufP1571?=
 =?us-ascii?Q?x+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942d6e0b-e07e-43c6-7063-08d9057f13b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 11:09:19.7022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INqYkdu4u1NgRbAfL3Vl2SYYqdDRHHcwJ5dqDR7opIjpnFcg09zv7S8AWkP8lNtGKxZMBWYO5w/ttBp/D46vjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2533
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, March 24, 2021 8:54 PM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: Han Xu <han.xu@nxp.com>; Mark Brown <broonie@kernel.org>; Rob
> Herring <robh+dt@kernel.org>; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org
> Subject: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale QSPI bindi=
ng to
> json schema
>=20
> Caution: EXT Email
>=20
> On Fri, 12 Mar 2021 11:10:38 +0530, Kuldeep Singh wrote:
> > Convert the Freescale QSPI binding to DT schema format using json-schem=
a.
> >
> > Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> > ---
> >  .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 96 +++++++++++++++++++
> >  .../devicetree/bindings/spi/spi-fsl-qspi.txt  | 66 -------------
> >  MAINTAINERS                                   |  1 +
> >  3 files changed, 97 insertions(+), 66 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> >  delete mode 100644
> > Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> >
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Apologies for content free pings.
This patch has already been reviewed by Rob and can be accepted if no furth=
er changes required.

Regards
Kuldeep
