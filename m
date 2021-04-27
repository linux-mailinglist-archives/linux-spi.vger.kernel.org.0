Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0B36C102
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbhD0Idy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 04:33:54 -0400
Received: from mail-eopbgr50070.outbound.protection.outlook.com ([40.107.5.70]:11585
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230228AbhD0Idx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:33:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c91W9qalgKFHL9nM4KVzl/tduxAye12jpgEzpPcHbL8rj0kc4KG/eUPao84jnS8Yy9ZMv2JruPvRAnr86Q43+ry2hrOyFXq6BYNeDzzJ/zBXxusRInW15rVdRS+WQBdAtJkYkUiBGeqOtLnZNsufEhk+cY4bMr9TsCkrgVgg2aG6CuYt9jFmaGg2TCwHf6hJ17khJjzLrOHfhdSpFivY4YumJIMNcsPGBUJxDeKTyU+sC/eMta+y/nCV7ximS7Ir47q/kbFmJIbEhFbq7IStosmdwBplTgfC3/EpgtM5BAVx5/hH4N1VF5OGraAoCGFUhGa2li7vyd/nU4fDLhamTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GheXBsg9ZDxzkH5eXnDtuOEkjMJsZ86bfwHPwy8VwPA=;
 b=oIjtg52fMFmFjjPVSZFoHDN4lFmwafvmysO4N9klgbZSoRcaKDOdR1KScqurzim7TYPoqIRZPVOcv+Ys7LkanOVwkiWVTqk0Fw/v2wNLlqt6SjDko0PxFDCVWaU0s/ax6R0pevbtMaeYpxwwtkeSy5iUPcmH0hDDuI80Fu8pMFt3Ungx2eWxRHCD6cBDbRgeB8A/yWjPOpY13cbf81OfwPY2koLlVSsV751AfwB47Pylj2WrVi3ocFUko5P/QCS77pPae3ZMx9hECcxk7s/6aEx102GQzzZV8uRb8kJxWR3XJmPdhkgKjmpq001LbphiqlT74s3/UN6ezRa8HBKD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GheXBsg9ZDxzkH5eXnDtuOEkjMJsZ86bfwHPwy8VwPA=;
 b=T3woexmrfNtb/slBdAOc2KvXjPmnXVs/Xc0uUc9/C/uCxFDgOX3eWoYIqnccc/d+uVfxVFNdl4/fYLt1lhmAZ3Z7PwN2R+E5E1LbEkuDyMakghixhDgQx5CoWLGx8FpnAJ/M2gr6Va5Sn/Vw9EYj9z4gH5pZ2gveVlFsjUbA8AU=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB7576.eurprd04.prod.outlook.com (2603:10a6:20b:29b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 08:33:08 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::e9eb:9619:1265:de3a]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::e9eb:9619:1265:de3a%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 08:33:08 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] spi: imx: add a check for speed_hz before calculating
 the clock
Thread-Topic: Re: [PATCH] spi: imx: add a check for speed_hz before
 calculating the clock
Thread-Index: Adc7Pt8FR/3XKgt3T2CR1YFSMHq4WQ==
Date:   Tue, 27 Apr 2021 08:33:06 +0000
Message-ID: <AM6PR04MB56233BE0FFF7E5D80527B54CF3419@AM6PR04MB5623.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5dd624d-19a9-4a3d-1e1e-08d9095715e7
x-ms-traffictypediagnostic: AS8PR04MB7576:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB7576F6BDD9A821D91480B5F3F3419@AS8PR04MB7576.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vpZTiInlErcIuk5BBvwlVUggu4Kg4GpulLctsJJhakcrauxFqCqt8k/cDKcZX3BkuB8niDDhqRBlZTiIX2+r/7BAX0TeShaf46fM4MfPs1ZyBCHnHhRJ4cfdSa+EjWBGBmZvUcTnUb7olYCEYqWhdYP9sui6/jMBeBfYHl2wJrOqqQxg+3gSX/5f2Pk7d4v3lVU0OWGfDcsGHU8oKap8m0FLwYDJn07R2CSSD/UzNjqDY7EahPWtRLIIDTwTH4XSo+7cS8BW/TcCdNuubANLLHBhp/8MRtz6pFb9kpFaU7IZvxpkQQpbkmEBsHVpY2X/7yC7kc6BpL+mT1YEIpk7eFQnpK9OrgFRtQHCZeW7UVRGX6s1+bfdzSt0if79ZCYSmn0DMPyInUIvn1zED/geEqkFisFmWgv39hE7Vnp56iHJR8xZf6nt88pnoaFy+sJxfXS0lR9bx2Mg5aXotXjF0Vzsc7cC5WNKArrO8w/HZpDJPdZuSMRZjinf1++MYZzNOXiPLzUvIlr5eRzzzbbGWRsqh606djFRt7GqCn1Xp8hCUmJjTyjALocZyVmLr88JuMK5sXR7y2DpIvImykzYaOLRu+S/6Mi1wEpvOix6j0o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(66446008)(76116006)(66616009)(66556008)(64756008)(2906002)(9686003)(122000001)(7696005)(498600001)(8676002)(86362001)(53546011)(83380400001)(71200400001)(5660300002)(6506007)(52536014)(38100700002)(54906003)(8936002)(4326008)(99936003)(6916009)(55016002)(186003)(33656002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?//J6e4caZEBCcQeSGcnOFMIyQQ5A/wd3advVlA2sO2Vpe3/FEg+LTrys1Wbg?=
 =?us-ascii?Q?Dn4Vt2o5/Ri1H8KYGgDVrx0yeY5W2Unx28mhJBBV7b2Ew/cUpsLj6TQIH5H9?=
 =?us-ascii?Q?tMpIa73tWZ97BpqfH4TaIDowW9KXIX2M5plXGqTXPUL9qR6H980jfyCYtOIg?=
 =?us-ascii?Q?+lgmmUvsV6s0u9uZQ7IpdBnbJPb+wSYW+1EMCB/RB0t3nzzVbIkFYg4kKNNs?=
 =?us-ascii?Q?GuVbwdJ8rlAD/JrYLucDrORm2pvejoni1QrEZCVyY7FpmSi+qbTedg8bVLgx?=
 =?us-ascii?Q?TLCRHRCFSGreqmr1igRQ09VfOvnP4kgrbh8nZ6eyoKWKfsNVpiC52ph7EO+g?=
 =?us-ascii?Q?0vgeCoOnt0KVoRnP12D8Atp6L3nkEnHNhQuDJE0GINXb+gYToPEWRAU4TNYN?=
 =?us-ascii?Q?d6/kBN8RqMFgycczNyO9+YF33XCnlaW7+j6vNEnA3tvwbCn0XHpdyAlEX0v/?=
 =?us-ascii?Q?2jT8aWiibzRgDKMZ7IguAhPw21Rmq5s/kmL1XNZEP7I57FPPZfVSPAyuH8AB?=
 =?us-ascii?Q?sziKyCqE+A2KmrX0egdY6VwTJTVm2+lJquucP48ssYbtDWPrjJDNgIcKThz1?=
 =?us-ascii?Q?ccPlExzL16Iqf1N6SO+Rm8viXiAWNsXimSJZAgxnPvUIHXwIqa6adYxosRrK?=
 =?us-ascii?Q?6NDZeYL2ozG5WNd0BPA3xquYVVmggmcYDh4AW/fVoz1HSFk6ILStt/QKp+c9?=
 =?us-ascii?Q?l4ckX1+8vJFU2sedc88qMPl6bwre+oUeIzEyh/koqnLzI3dTNtdxY8aSODq2?=
 =?us-ascii?Q?rnZwwichC2DvTBnyB9ysLOWwTWN3lfemFKvvGeyPWq8sOPMBg58Md5LWeMM6?=
 =?us-ascii?Q?8rNbI/IEoFfa2RANkqXeWmM6T39KA7gqfq91O4HUizbfuYi65FDGhIySG7fp?=
 =?us-ascii?Q?mUQpNePdWKLBPqfXqgi7PSCiFsNLuA4+Z2Bk+xMy58rIgJ1CyLNCpJWNvqmC?=
 =?us-ascii?Q?tL9l7utRHKXFcqtwZ7TzNo7UwJL/IWPQwFaVd7lOGugkIg3GndxIjom+S1gD?=
 =?us-ascii?Q?4ZOQZVr1Bvlp8Y5PITyRaAVCFBz1t4Qz5zBwrrx+DqmLR8N2r684ScaX5bqQ?=
 =?us-ascii?Q?A8IO6JDXjUqJM3sQ8U7iuCllESF+ylUgzRx79X/f5KH9Zzua77/D90TwUHxW?=
 =?us-ascii?Q?GoVczqBD0kSr1OfCUOZYSy0XOop7z7bYPz6GY7WvvZH77Xf1L3PeG/h03o+b?=
 =?us-ascii?Q?upweWDrfSQNrtiMDKt58MCFq8Tyt0Vdr42sZjZlt6V5l07gmU0Gn4sUZrsje?=
 =?us-ascii?Q?iRtwcBzqlMxOZdY+R/WNw76s7kizT8ROnc9dzYn2a6Cqi8jBP2tR1bg2nhVS?=
 =?us-ascii?Q?R3SC/SK03kooymE/udw4kLf5?=
Content-Type: multipart/signed;
        micalg=2.16.840.1.101.3.4.2.1;
        protocol="application/x-pkcs7-signature";
        boundary="----=_NextPart_000_02D6_01D73B82.FC78A030"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dd624d-19a9-4a3d-1e1e-08d9095715e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 08:33:07.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r87SSHtct8o5SBXMbPTRY8K1YjucDEnid4PbYLEzDt7KENNjRSlutw9R58bVZyIjyhFd98ZJHxNl6RYnxYaFbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7576
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

------=_NextPart_000_02D6_01D73B82.FC78A030
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, April 8, 2021 21:44
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>; linux-
> spi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] spi: imx: add a check for speed_hz before
calculating
> the clock
> 
> On Thu, Apr 08, 2021 at 06:33:47PM +0800, Clark Wang wrote:
> > When some drivers use spi to send data, spi_transfer->speed_hz is not
> > assigned. If spidev->max_speed_hz is not assigned as well, it will
> > cause an error in configuring the clock.
> 
> > Add a check for these two values before configuring the clock. An
> > error will be returned when they are not assigned.
> 
> For the case where the transfer speed is not set __spi_validate() will
take the
> controller's maximum speed so the controller should just be able to
> unconditionally use the transfer's speed.  Your issue is therefore that
the
> controllers are sometimes not setting a maximum speed which this doesn't
seem
> to fix AFAICT?  I'd expect the driver to be able to work one out based on
the
> input clock.

Hi Mark,

Yes, you are right. If the t->speed_hz is not provided, it will use
spi->max_speed_hz.
This patch is not needed.
The issue I met is that t->speed_hz is not provided in slave mode. But this
is normal in slave mode.
The problem is spi-imx should not config the clock divider in slave mode. I
will send a new patch to disable the clock configuration in slave mode
later.

However, I notice that you have applied this patch to the next branch?
Will you revert this patch?
I think you may want to apply this patch I sent before.

Author: Clark Wang <xiaoning.wang@nxp.com>
Date:   Mon Dec 14 17:05:04 2020 +0800

    spi: imx: add 16/32 bits per word support for slave mode
    
    Enable 16/32 bits per word support for spi-imx slave mode.
    It only support 8 bits per word in slave mode before.
    
    Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
    Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Thank you very much! :)

Best Regards,
Clark Wang

> 
> >  struct spi_imx_devtype_data {
> >  	void (*intctrl)(struct spi_imx_data *, int);
> >  	int (*prepare_message)(struct spi_imx_data *, struct spi_message *);
> > -	int (*prepare_transfer)(struct spi_imx_data *, struct spi_device *,
> > -				struct spi_transfer *);
> > +	int (*prepare_transfer)(struct spi_imx_data *, struct spi_device *);
> >  	void (*trigger)(struct spi_imx_data *);
> >  	int (*rx_available)(struct spi_imx_data *);
> >  	void (*reset)(struct spi_imx_data *);
> 
> This seems to be a fairly big and surprising refactoring for the described
change.
> It's quite hard to tie the change to the changelog.

------=_NextPart_000_02D6_01D73B82.FC78A030
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNv
bT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0
aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Js
hi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsG
AQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2Ul
MjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29i
amVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDBHBgNVHREEQDA+oCUGCisG
AQQBgjcUAgOgFwwVeGlhb25pbmcud2FuZ0BueHAuY29tgRV4aWFvbmluZy53YW5nQG54cC5jb20w
DQYJKoZIhvcNAQELBQADggEBAK4JPoIkTbfuhwLtQ9Fm320K9JnOD+UvIk7UY5A58pq540ABcjCz
LggHvY+pE9m6IdsLfPL0lj4rrK660DRFM7k6XQEoJXjOBlZ+FGi7oTGL+VVi4+TYQzwPUMr8Ukg1
EBMzKb84Kh3oA96THluC3OFR3DbU/3NJsMYI6hIpvL4G+MQS0NZiEOf0CW73kreekaWUzCcnDbjr
9c8a1dI966lFSHr+2MAjj1iiNou1MXi3YA0jTy2qW78wdbtk/UbWkFIp11SyqA6Va6i96c7WgohG
zzxofRhw1yf5mb0SSjrbcFvLWRyx5iVZIhapdbztkYGYJiroxzI+ndpbztisjkYwggfxMIIG2aAD
AgECAhMtAABZfNGGA83aLDAMAAAAAFl8MA0GCSqGSIb3DQEBCwUAMIG2MRwwGgYDVQQDDBNOWFAg
RW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcM
CUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTET
MBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwHhcN
MTkxMDI5MTM1MDU4WhcNMjExMDI4MTM1MDU4WjCBmjETMBEGCgmSJomT8ixkARkWA2NvbTETMBEG
CgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEMMAoGA1UECxMDTlhQMQswCQYD
VQQLEwJDTjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UECxMKRGV2ZWxvcGVyczERMA8G
A1UEAxMIbnhmNDc3NDkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCZY70u6L2tkQw7
9PyXIwnCQZGWP+8gSezFvuegmg10bDVMZux1jQKY48+p9oQeUBOfM9652qP5o4VTqDCR4MBxbtB7
CXxyjzKOdVxraRqx+xibX12lcs4LmCtz3JeEduJkKJ7W+QJtTbqtF6okCUCQRT/vF/BqUyfNyVs6
Mexrp1Lj4Yv841rbsVKC6k3jdt1pqi/0YZscxs7rqP5VsvFcK1der8zrQ/98AbMMjoagsu+nq64x
xPly7BcBfjUMTlw2PsL5viDocyLeVtW22VInObVN2bvFKdtkQEliZtoBKVwevOx1UMYis/yAbqhE
x+7g2Z/59jqDaZSy7SOxigvhAgMBAAGjggQQMIIEDDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3
FQiFgsB+gY70VYbthTiC65lLmpJWP4Xmim6EteF+AgFkAgE6MBMGA1UdJQQMMAoGCCsGAQUFBwME
MA4GA1UdDwEB/wQEAwIFIDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUH
AwQwgZQGCSqGSIb3DQEJDwSBhjCBgzALBglghkgBZQMEASowCwYJYIZIAWUDBAEtMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEARkwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAKBggqhkiG9w0DBzAH
BgUrDgMCBzAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgIAMB0GA1UdDgQWBBSZJY1p6Y56
X4YAWIozHW4aGPBzZDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDBHBgNVHREEQDA+oCUGCisGAQQBgjcUAgOgFwwVeGlh
b25pbmcud2FuZ0BueHAuY29tgRV4aWFvbmluZy53YW5nQG54cC5jb20wDQYJKoZIhvcNAQELBQAD
ggEBAEH+a5BarGYCUuH4P4sFJkrA7Y1U1aWb2nxNOPDARJLTwdEyMP6pPY0Bm7AyypW60HlI3Z4I
eP6NiMibW55/xz5EEcHxOrbYFmPyLY9twXLluCHnpZYT3NrDCD9dbOhUeZbDB1FXG93zfMJ8zzL4
9njRn5J6mcLiHkUpVRacp9susO1zN3uzp8TXCHy/y483CE6g1qUijUyiTPlAT9gz7xvyxAhTmrhH
8Fue00PWfK0B7zzjd1b0Da2nWFZXk4IsYJeyt+RTWC07VscWFiJ3avbgN0kaCswkvB1f6DVOqDRx
r5hHoNADBEcsMNdQNRVu2ospazEVq8wtXPTB7Ihf564xggTDMIIEvwIBATCBzjCBtjEcMBoGA1UE
AwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIw
EAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZ
FgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYT
Ak5MAhMtAABZfUBCujlfjY1jAAAAAFl9MA0GCWCGSAFlAwQCAQUAoIICxTAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA0MjcwODMyNTlaMC8GCSqGSIb3DQEJBDEi
BCBWYGe5eX1Z29IX17LiwNeMGQpQmyt4OeFoQaT0cO46sjCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFl
AwQCAjAHBgUrDgMCGjCB3wYJKwYBBAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAFl80YYD
zdosMAwAAAAAWXwwgeEGCyqGSIb3DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAFl80YYD
zdosMAwAAAAAWXwwDQYJKoZIhvcNAQEBBQAEggEAgHLTxZbl/47ZzQ///MWfJ5JF5ZkXgpFpBdAZ
Fa7RKPSmLgV/ExViUwTQT9UVHrsukMiZXaKJdiCmR5BmPiiCWGkSnWHG+y13rPFITWT+IhFWEiQH
uBvnGLrVMaX5ifya4Bzv8txiain7R9hiEiXNbKyEuy/TzhkcEjMsrBdDP5vc6bQnIcihcu7r3byJ
BF7/kqbk+18JLl/ZS6BQv7j9p5VTBXcUa5917BWmOiLJnYjGhixhtvwlD6TQ4suiWiCOh/bllyhX
5EJQpOlSr3Zr5MX6wTq+pA073etNxyjTdEEymzmYZ1naj27Fe8av4Y4buzWR3K6eJqTSQS6nTyKq
zQAAAAAAAA==

------=_NextPart_000_02D6_01D73B82.FC78A030--
