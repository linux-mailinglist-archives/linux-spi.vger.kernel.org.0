Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A043BB7A1
	for <lists+linux-spi@lfdr.de>; Mon,  5 Jul 2021 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGEHSw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Jul 2021 03:18:52 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:57529
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229925AbhGEHSv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Jul 2021 03:18:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLTBpl4G0cn1CqhyEKcl8rg6WfosV3mLZwybSQW04YyJP+hrHOf+7E4KvcyN5JbXgypDWs++YcvpMcPnSazZxUnTbUK8kfZScXiC+cywtgHVS9j8B96j9n2x39e3CB8PgUGX0ofJWt7hXdfBew2Rg8bHo2Yvs3avY4l+WK6l92yX6Vb3CrnKWxcQBvCSvGTmlWS7NQdxuH4v0zQ1PVEuE3I6ibEwOhRJM5TainH0Ff5dn6IOd7f8ccLsC47IzBMSbJDduhpFlQlHhx4lirU6xP/vj0g+fudjFaPjQk3E/+yhTjyx7Sy4nB5rBUcuKYpu3iJkIzbNMWdkkaW80/qelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lKcQVvBWp1MG6O+L5lCidUglE621TBypauSAiSn24c=;
 b=Ktew2rqMp+9LKp2HvyU0oE3VKHEqdO8NWjv2q0bqtItzoUeHdPK0aGa2oL/vW2OCSiMGJ6iMLo2MNCLPxEWZRhmq4LoSww4MUgXvv1Decd3NyNvl/9GHhSuDERXASRmY6GZLg2VEwQYNUnuypE0CrgjPosxCy7yQP3lR1OA3c6nrxg/tT0qgn45rEUpjjjcPPK3cuSev2Y5acZDEOseo5sJxPm/lNiKB3eipd5elSYv+cy6Y8uoUhzFhwdmaxZdfQGIm7qBtHnWtekx6EKoJdKFrv54RkKsCUTxB/eh6UrKrvjL9Y8UOKil1r/PhcbZ1DGEDKnABN9aHOKzXqX5aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lKcQVvBWp1MG6O+L5lCidUglE621TBypauSAiSn24c=;
 b=hu9BCL5hO3qHWLKrb8DvccNsr0z6n9p1a6mujp/6yUACmQqbvqdlglKHAQdcv5zMcxYWTBREj9kV73Dtufs86KTBKy0lae0k72GvtetXAiEGVDDmsKBOj236pP3aNjbTTkW4EUmBLzr/9zKtzl5DNGqMwmZlURO0KP9Ahg8bkhY=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Mon, 5 Jul
 2021 07:16:12 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 07:16:12 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Adam Ford <aford173@gmail.com>, Peng Fan <peng.fan@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     Charles Stevens <charles.stevens@logicpd.com>
Subject: RE: ECSPI Slave on i.M8M Mini with DMA
Thread-Topic: ECSPI Slave on i.M8M Mini with DMA
Thread-Index: AQHXZGM6jg64sncLkUqQGucBqFiLy6ssXYuAgAemcxA=
Date:   Mon, 5 Jul 2021 07:16:12 +0000
Message-ID: <AM6PR04MB56236E87D8136E50A51F9882F31C9@AM6PR04MB5623.eurprd04.prod.outlook.com>
References: <CAHCN7xJ_Cidr5EiBXNi11St9vLFmm=s=K6jdHGJrvCzeQQpqyQ@mail.gmail.com>
 <DB6PR0402MB27601D0F4FB77F0007EDF0E888019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27601D0F4FB77F0007EDF0E888019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd8dcce5-3b0c-4d89-5695-08d93f84c502
x-ms-traffictypediagnostic: AM7PR04MB7064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB70643D4AB11E2D466FFB5B59F31C9@AM7PR04MB7064.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoP2LoKP8a9fjoDv6j9+6X/xRKmpT9+b4tXd5OfeahOBp9S5y3uxoU6x6+aTR7MAdzcYSXieTnFSwIF7yI6/8sPvVqGTgZIQ60tUhQUhfN12FzWXY/2JEm+Agw3skLfooHgISoEetlx18qkh/F7FGwH1yol/9JStiEUcitrcv8v5I3w9pfhergsiHcxVnzeR0xbYTAUCDOk6JxudPbg6FJQHQ1aV1iK2p6r+fhckH4ey/bj6oScIeSC1WI0fP1GXywp94QCfkxuWdAk52cy3UrcFjmfK2Vl647DQPA7DDrjhQZ7l3dlh5QdPhNBeuPbjyIgmiB6a24G7+8DgdHV4nhx7DJ07DqJgCcD5OcI89+2prMLAcmNLLhGMl1HJNg1voaNfkGGK3ji7W7koAKn7UqZIFc9KbhDDuQknFOfGGIt4i7nU4u+fCMIydFd1MZTnfHhrlrvsikAEdc0H1ZbklPBJLE/avsfYxBoYH6v5/+Oyd59Tv4wMHjyVHRabhyjB+eIlVNKwLU7alJYQSerGUb/gHZ6AC02r7RfmhbqhOvcNyUV8fWq3zXeXsACwib3qtDQTLvYqizteXhe2/BanVeR7YCmNDSsMTJ/Pcuv9kAUoHEaCHBGLLj8VeaFKIlCPjKk5rcItndpjqhwJOOLscZMS2wec3rMJ1Q0ZOW1W/Hc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39850400004)(376002)(346002)(83380400001)(99936003)(76116006)(33656002)(38100700002)(122000001)(86362001)(478600001)(66946007)(66476007)(66446008)(186003)(7696005)(6636002)(316002)(2906002)(6506007)(55016002)(4326008)(26005)(8676002)(71200400001)(8936002)(53546011)(9686003)(66616009)(64756008)(110136005)(52536014)(5660300002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXZSZUxBV1IwMENJZjhZOEtybFJidHYrTjAvWWlDS1k5dkc0NnNGZGFURmN0?=
 =?utf-8?B?SVlaYXNrU1haVkpMNWNZZjlRZ0NFUXRvTWc1SVp6anlqUFhQeHNIZ05kcmZP?=
 =?utf-8?B?YjdZZ09NVldiV2Z5RzFlQXJETDlEbEdGcW9RY3ZxOGtkN0s3VWRwbXRySjZi?=
 =?utf-8?B?R0w1NHV2ajFuVDlha1hBQkgxeFV5cjQycWdwM3EvNmNrYzN1L3NmT0UxNk5P?=
 =?utf-8?B?U0VlY3NmL042bVpqcGlYbm52TkNVcUhETDB1THFhTEhmVHJrYit0QTZ2SkhK?=
 =?utf-8?B?V1dsV0VaL0FXUGV2OGtEWGxjaFdQZkxYOXczK0Y3TXJtZGFaVlB2N3o1cm5y?=
 =?utf-8?B?RFcrOGZMYnpla0RoOVNMcmROMXZ5dS93akNiZWRFZUxBQTdYL2xWTkR1cVN5?=
 =?utf-8?B?Vzh1K1VBTERjRUF5Y3VrZzQxMTVWTmtHSDFMR3p4dnRYYzVNRkdYcGgrTDR1?=
 =?utf-8?B?N3IwM1lPK01qWC9GK2NadXhGaU02WFJLdXZVVVBRMFUzTEd0NzdwSjRTZ2FC?=
 =?utf-8?B?R0FrSm5XVzdNK0hxWUdZNENBZ2FvOVpmcGE3SzF1ZStRRDZrZVIvWGlhcVc4?=
 =?utf-8?B?dUdrK2tXR3RucXZDTGhWKzBZVngyWjhMcEM3OXFZOVRkd0lrK0psZEh0eENF?=
 =?utf-8?B?eHZ4TGxrayt4UExPUG1UaUo1SzMvd05uYTIzNmEyclJWeUF1MVo1aWZ5VS96?=
 =?utf-8?B?NWRlcWJrUlVTZVFJaTFxcFU4OFpra0VxUEZ4SGpIdktWWktuTHN5Vmp6NWt4?=
 =?utf-8?B?ZzA2MDRkZjFMTzVzc1hJcGg4TE5rZUh4b0ZJWGtpRG8ySWpTay9SblVIUEYy?=
 =?utf-8?B?L3h4c0MxbTVIMTMvbjM4d2w0Ym0yYnF2bXFQWEFMUVJoZ0Y2RmYwdXpHY0hG?=
 =?utf-8?B?N0RUL1F1Qit1ZnJaN05CMFcybExNYzNMZDFYUjhXTHc2M1dwUzIrTmV1cFFH?=
 =?utf-8?B?M20wOG1pNHRHVDZPeXV6bDQyc1hjY3R4QXJCYk5UZEhkV0l2TjVHVXJnTURR?=
 =?utf-8?B?NEJKMzBxT0JYbTNmaDIyMW9kekZzOHdUTW1OUEN0cDdaMkVQblJUNXpKdDdr?=
 =?utf-8?B?YnBxaVBaaThsME5tbnN0MUtlVk9sQml4L1JyaUhJbmp0NTVVQmJvVDdweHB3?=
 =?utf-8?B?Zjd3RndZM1ZoQkJ1NEZmb01XcVYwUmhTSkxWRncwRXFuMko2amczU3pHVEZY?=
 =?utf-8?B?MlAxU0thVHNyaVc4L21JZ3J2TEh4OE4vZVJ6eTZ5eStGVFpsa1Q3UkxPbW5T?=
 =?utf-8?B?Zm5EZG1UQkRZVVlSdElKRmpPMWFsakh2aWZlcGZiYTBGQmNveXNQc2l2M0Fj?=
 =?utf-8?B?V3QwWjFLUnRJL0xsMWxxT0RoNW9OTVRUTFBlakVGOTcreUZua1V1dWZYVEx5?=
 =?utf-8?B?V2tXQ0IvbU5Dc3RMaUhHZUpoemR6ZmhGVHNoQjF3WXBqbTVLcUhlV0pZc3VY?=
 =?utf-8?B?ZHNXQWZMNDBZMFNBMFdxRElxV1JZcmZjRVNIMGg3ajc5NmppTjZIcGRrU2hU?=
 =?utf-8?B?R3c4aXpPbWpFb09UZjYvNW5wZTIzNHkvMnVseFRwQnlQZGk5bjB3QnQzQkJR?=
 =?utf-8?B?ZzdOWWRURERHUmI0UDFKbStPS1c2M1NJLzYwMVpRVHFzcDFET2lpU3RaNWUw?=
 =?utf-8?B?NmZZU3RyVndFa3gvL29pbWZWNmNrakFMN1ZiU01YV3k1VlFTUzZoUU42YkV3?=
 =?utf-8?B?ejYxd2VOZHBMUjkzOGRvSC9GakdUSmp3anlyNFltazZjSkV5K3o0a3Ryd2I2?=
 =?utf-8?Q?ix5CA2v1h6bbJhVRJUQ4rgl5qu9/QCKxRNXAN7A?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_001E_01D771B0.AF24B440"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8dcce5-3b0c-4d89-5695-08d93f84c502
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 07:16:12.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SenVp9vvmEHJDQULv9s9GpwseH7xcOK2g5ohagHAK9wKtB6yzoIeeEh6ydI04/OylVvPzxw+1PT2Sn/pEH0y0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

------=_NextPart_000_001E_01D771B0.AF24B440
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Adam,

Sorry for the late response.

Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip Select (SS) 
signal in Slave mode is not functional" burst size must be set exactly to the 
size of the transfer.
This leads us to send data only through the 4bytes per word (bpw) mode. If you 
want to send data with mode of 1 or 2bpw, it has high risk. Because:
1. The order of each word needs to be swapped before sending and after 
receiving.
2. When dealing with the last unaligned byte, data may be lost.

At the same time, after sending more than 512 bytes continuously, we observed 
that the slave sent a word of 0 data.
Therefore, the current eCSPI slave data transmission and reception in one 
burst is limited to 512 bytes.

The DMA mode leads to 4bpw limitation, while the data swap and the limitation 
of up to 512 bytes of data in one frame make DMA mode inefficient.
Based on the above limitations, we do not support the eCSPI slave DMA mode.

Best Regards,
Clark Wang

> -----Original Message-----
> From: Peng Fan <peng.fan@nxp.com>
> Sent: Wednesday, June 30, 2021 17:35
> To: Adam Ford <aford173@gmail.com>; linux-spi <linux-
> spi@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>; Clark Wang
> <xiaoning.wang@nxp.com>
> Cc: Charles Stevens <charles.stevens@logicpd.com>
> Subject: RE: ECSPI Slave on i.M8M Mini with DMA
>
> > Subject: ECSPI Slave on i.M8M Mini with DMA
>
> Clark may help on this.
>
> Regards,
> Peng.
>
> >
> > To the NXP team,
> >
> > I noticed the spi-imx driver has a function called spi_imx_can_dma()
> > which returns false if the SPI is configured as a slave, so the dma
> > cannot be used in slave mode.
> >
> > Section 10.1.2.7 "DMA" of the The 8MM Ref manual, Rev 3, shows there
> > are a few conditions that can trigger the DMA.  Of them, two are
> > RXFIFO data request and RXFIFO full.  The block diagram in that
> > section shows it can retrieve data with DMA
> >
> > However, in section 10.1.4 "Applications" of the same document, it
> > shows the optional DMA configurations are only in the SPI master
> > configuration and not the SPI slave configuration.
> >
> > The ECSPIx_DMAREG documentation (section 10.1.5.6) states "The ECSPI
> > sends out DMA requests when the appropriate FIFO conditions are
> matched."
> > Unfortunately it doesn't explicitly state whether that's only for
> > master or available in either master or slave mode.
> >
> > Can someone tell me if DMA is available when SPI is configured as a slave?
> >
> > thank you,
> >
> > adam

------=_NextPart_000_001E_01D771B0.AF24B440
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA3MDUwNzE2MDlaMC8GCSqGSIb3DQEJBDEi
BCCs/wy8PXTusuKKe1jnlG187nGyQVXiANuWArI0b2WZJDCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
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
zdosMAwAAAAAWXwwDQYJKoZIhvcNAQEBBQAEggEAJ9zhhQ6ZgNOKqk/KpMgoWPBjM5cjM1zQ9rA4
Kq0XF+nm5JgFxChtg3aI4HXFsRQphOOaAmvpjzFM13zzs7BhvSaoly21gG8H0+5P1fzgF1uffIff
rkqf4DDxg73sVQZRVeSKVtIcyA0bkjn+0RKp5cJHWy1NXTXwDgXAuHtg2u6DXfEX8whcnDJ6xDQj
FCmu+z/sszehE415ZOWlcchSikIpKkcU4ykNGBk2swKiCO4Uzq3VC31qvHVghV++nsrG2c8MCGOc
i3qXSO/ueGBdYYcWdjWMepVbLkZS6SPgKB18qUBTdnEDj/rplJF5hAGH9mcom3xzf3De51aN9rl2
/QAAAAAAAA==

------=_NextPart_000_001E_01D771B0.AF24B440--
