Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051D53E552D
	for <lists+linux-spi@lfdr.de>; Tue, 10 Aug 2021 10:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhHJI3F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 04:29:05 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:58188
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236661AbhHJI3E (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Aug 2021 04:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d13YsrHR++KT3j01iZ1Vl08WfLEEzoFFuRQ27bi4F36JAgH+4sKrNmzEF/jAyANZxR83Kcsj7tyeACygHWReGmpV53iQzPW20npeb2lvf8ioOfbSk0E5R6L13BNEl3DfkuHhl8Ndqgu9fHNiA+DtmzGwQNvosRWKY1XX/etmvqhPwHL9HTyy9f+fcs6LArGd18ZK3581zdZMPXzTXBEVqpOnqBCmaW4kJuVRJ235AeD754HPyz5IyJmFYnnfGeV/NVV9Z8vZiGOOhnUYnJuXZ93J33q2FReQvR6dryyO5HRB5lEPs1nebzgZ//jaJ87oB7UooWiSi5tPaVAGxDm8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMWQNbFItY7wjwHGuTe1imSMIaygFsDNIPdx6g6U2S8=;
 b=iVuL2A8fyYcjJGjxEZ8PFIlMEeOcZBeNAb7Km6aL2FHAf7HaMVd44udNhVco/yJstPO+cQ+DucVltQPqPYrlUuLSXY1vYGjAa56kLXRtkkXpDOh2tXXIOGjzzIho/m2VqjlFAYuaJAzfHKolfRT44hOXF9i/CIfmxghFEE5h1dIT/B3b7xuslozttFDNqSl51NB71XbInQtrcMPzQbmeyYC8sLVAchyVAQICKKhG9gIaor3pp+QOxdZZb1xTGDCXmPshzyzARPwbmdv8kB1mTmgBk8SfoufB+KogFc0uLUeQBOSxU0AOrHJzvRLQFqNA7ca42m8Lzik5qbJwolMmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMWQNbFItY7wjwHGuTe1imSMIaygFsDNIPdx6g6U2S8=;
 b=UJfpfkdP4H7O9Xl6/bnXBP7j43BOPFFIonKMvUut8CXVWR+sjY4Jz3ytVhRkv07rHE96NdkeDSMxsQXL89SjZCebEsVwqJZw4eN1hJj3jbEYx/VjYIYhIUuClAicPETkHtSYSg0QIcK9i9rGcEQHTDYJbOHwiFqdnTCBlf7iz2o=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB5342.eurprd04.prod.outlook.com (2603:10a6:803:46::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 08:28:36 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 08:28:36 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: Fix issue with uninitialized
 dma_slave_config
Thread-Topic: [PATCH 1/2] spi: spi-fsl-dspi: Fix issue with uninitialized
 dma_slave_config
Thread-Index: AQHXjcAtMUeWzYSQr0GyMbPLJtr0H6tsZ+wA
Date:   Tue, 10 Aug 2021 08:28:36 +0000
Message-ID: <20210810082836.7x5bosiwnudhb4dq@skbuf>
References: <20210810081727.19491-1-tony@atomide.com>
In-Reply-To: <20210810081727.19491-1-tony@atomide.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: atomide.com; dkim=none (message not signed)
 header.d=none;atomide.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e88a9d41-2fe6-476e-646c-08d95bd8d95d
x-ms-traffictypediagnostic: VI1PR04MB5342:
x-microsoft-antispam-prvs: <VI1PR04MB5342F6189B0569157FEE97A6E0F79@VI1PR04MB5342.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DrVBvAishczuCE9uavD6jEhmRhLcK9SHmWGrP+PD0ddky/8fW5rHDGAHDGKyKx8Mtm9VFDuYreJ9jpU1OQyRhIeIrERpHTeAuGr0FmsBGGK0l1tEHABU/lsiSiR2uTM9CCmOD7bRAMDOLy1Lr7hi7m5KTsNl7LwOM1r4kPE6MTP+2WLOiEqFygrI4xCAVbAXL/O7AJCaDFpulzgcwbZtcJ+1zEm6BwGzTfiOGIcIyCGHUpTjTDWFyG1JbpIwBkG8ERXYGsJN39ggGrIKPFtttWe1SZc0KIT/15RBsDIYJwxU98jkRxtSH/lq3kdmvRnToW62cEfWCMS6NW2YhCot1TuA3RfP4jHULjjNR6rgXEqsr8RrQV3B/qRXWygqGirLGlesU7U3pHJB2DRD7NP6CpkgBVO6hHZNxi2zZsA/vHYBggOHs38t8gbDXnNUEEwTFRFhWd4sOhZQRejM2CnQVSxFdYY23vPEJ7wHE97dDreijGQJRuHnWh5Pk8rjylKAPTFoacUajDthflXUZi8u7/3+5YpTuF08A+waIdxZhI4o+jfewDFCOJzgnx6Y6Kd0BEupG469x1WCZvs4nVwkp+vA7FOjbiL3BmDxHX0pnnVglbiohiNssfDplndXAbOz3f3V9ieGGcEahsShtaASt81u3jxRZl5FWSTjWt1tlsMNaXt/E3lqXIBdrMyWP+WrtQp19iHugUtC4mmCtyDzeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(346002)(376002)(396003)(136003)(39850400004)(5660300002)(76116006)(6512007)(66946007)(66476007)(66556008)(9686003)(4326008)(6506007)(44832011)(66446008)(64756008)(91956017)(54906003)(6486002)(122000001)(38100700002)(38070700005)(71200400001)(1076003)(316002)(86362001)(8676002)(478600001)(83380400001)(8936002)(26005)(33716001)(186003)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TEgbEE2z9j82Icumw51yqn9NI6NuJRQoUYtKDHWi7Bm0CVHapyL27TcxStwa?=
 =?us-ascii?Q?zkI9o7IU0vZe2uMRCKLaSFux4bK2jxzsywLVKM7DhNm0jnSX9Ury5cpDMbR9?=
 =?us-ascii?Q?OGM7NrnGTQ4JRnL4Gqo9xxcg6x/EZKuQTIFrF2jU5RBxUspg2dPBtlb1E2fO?=
 =?us-ascii?Q?koFR65qRzQVU2NVcMdNoCWdLJ7X7JvgONzo1CJpfr52I6M2wbsK+pzYPyco0?=
 =?us-ascii?Q?Fu3v9LKpxaNnx2NknnY+mgU/OAbRVT8CdpMaZLFAzoGMB3tA5QnSsKwvCgFy?=
 =?us-ascii?Q?id8GuCZx2WIdOldhpvibJ7aNHxrr+3YQSFYORqnqfEYWkSbrvAmY0+o4v4PO?=
 =?us-ascii?Q?aTudfCc+Is1kHAnmHXBo/2vzcX5nnjKUCx0yLYFLSN2jrCPwoU/3U636+gGV?=
 =?us-ascii?Q?QAwTp70CBKOldDGuoCD4RPQHNMo8PKj8IQClNFSEPQxiQE0PTO9k9tGFsimf?=
 =?us-ascii?Q?MO3/2xdFHK3vSH+QRu+u9NL4XXiIkZKMC1LJtK1uxpEckCxRNnzoq0AB2lYp?=
 =?us-ascii?Q?ahUjhZwU8yan8GmeFVvFMkUs+h9Vnw1DDAgk+EyjJfflOkpLpUXHcEron6Kw?=
 =?us-ascii?Q?TLe5VIbt2Ut0PUzCXsuH3cV0GTXkrwnLqgbCC+CqfuwbaXWBsVFxuvEN5Jfj?=
 =?us-ascii?Q?Fk5EVFxoX8uS6EUJi9ZIYlluSIbMTlC9ulUX6fdLc5M94E7/0aIRJ8c6rZMT?=
 =?us-ascii?Q?8fHCkRiFmpkSKChh0cc7+G9x0NH2km7LBmxQez66nShod0Ha0revyqxSqTAB?=
 =?us-ascii?Q?ZaClGq0ewGzx5afNFD84ZeJJFzZ1wfp7Zs2+rzrUIUTXRwvOfqK3q90BJdBc?=
 =?us-ascii?Q?3Yrv/PWECjdnPFSmdp1eGePIGrRrekkHSMgLleds1WysIoPVTG+xZwKurO1E?=
 =?us-ascii?Q?QD98cI7pn8BJnbWFXS8TGGzNqVXRI8nV+u044KiZKg7QLixRIAUvFZKyLjvd?=
 =?us-ascii?Q?J/zVGIdqvilCdSeECyvHdcv6XHw3+HI7DbeVXBm705rT5/T/tc2EOjajnRI6?=
 =?us-ascii?Q?SNTO4vQTKzA1B639yGXvLAaqGPI9tnPNYofmfKiYSKnhMab/2tNoQF7a+T7B?=
 =?us-ascii?Q?vOEViJa0ZurR1VvtxSQfZ+rXZBus2uAcu048R6dHquWgcdajez4VSjoxwH0t?=
 =?us-ascii?Q?sj+LPUugG/GQEihiLrNaZg4ApRNjArUftY7pzd00YfDOA3oGw0bVu9QR0ibW?=
 =?us-ascii?Q?4hUCVZdoMSSZArqABiPlsP84F4G95sHPLQgXW1xqgooytQoeIX5tF1dTp6/c?=
 =?us-ascii?Q?ty4SXO0MrsF+6m0RP5D5ifvynIJorPf9+Mznxz5HafDhm60z65wf8aplLYOI?=
 =?us-ascii?Q?OBmlNIiK2bEvkO51DNrdJz8+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B74AC901201955489B91EC091B7747C2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88a9d41-2fe6-476e-646c-08d95bd8d95d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 08:28:36.6776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sfpLxFqCE8dz4G9VyJS80HNFiQdXeErxy4JS6CVjfyvsyjtFwBXB4pdoPUHkr3oDWu3Yw1Zet0uGMxTJ3HnWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5342
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 10, 2021 at 11:17:26AM +0300, Tony Lindgren wrote:
> Depending on the DMA driver being used, the struct dma_slave_config may
> need to be initialized to zero for the unused data.
>=20
> For example, we have three DMA drivers using src_port_window_size and
> dst_port_window_size. If these are left uninitialized, it can cause DMA
> failures.
>=20
> For spi-fsl-dspi, this is probably not currently an issue but is still
> good to fix though.
>=20
> Fixes: 90ba37033cb9 ("spi: spi-fsl-dspi: Add DMA support for Vybrid")
> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -530,6 +530,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, ph=
ys_addr_t phy_addr)
>  		goto err_rx_dma_buf;
>  	}
> =20
> +	memset(&cfg, 0, sizeof(cfg));
>  	cfg.src_addr =3D phy_addr + SPI_POPR;
>  	cfg.dst_addr =3D phy_addr + SPI_PUSHR;
>  	cfg.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> --=20
> 2.32.0

Does not bother me in the very slightest.

Acked-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
