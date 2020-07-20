Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87C225655
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 05:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgGTD4E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Jul 2020 23:56:04 -0400
Received: from outbound-ip8b.ess.barracuda.com ([209.222.82.190]:50794 "EHLO
        outbound-ip8b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbgGTD4D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Jul 2020 23:56:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102]) by mx4.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 20 Jul 2020 03:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD5nAqmPrV7yL64umLSgk9pSdTMs8ODF53px7AcemiiOxHcik1f1QDMVIprOEdI8g3k0FOHyVAu15B88wDgnkHeFtw3CyGY1RU43GxfXXNNBlI9+lATq0Vpja/gMUPcn+Jvxssbkn7nbCTTKrmzMq/ZNBewFXL+jNpm2d7euyRizZkt5wGWMDZgp9xJQyMK8bXGkoKLMFyYcwzetUyEyZ4v2iz1bWqxMybEbfAg4qDD2xypIoF2eroCOm5RxlS6tNUa61Ruo92cvO05qcH5oKq7yRRpSUiVGNgnye4faAmi5CFfatoenzZJWg1XXZMVlUH5sVEPJnGEB+OgluAG4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m/hY38WXMFlT1+3eTngf4z3YIPyR3xllmcCMIeWPdg=;
 b=IXyIOxyFwJ8c/hM6CSRSLZpFd1iRubHEcsSu4hWet/DmYgJODAX8QYcrXO1zVINwYTUSfGUSAWhS/4jkpSokc/Hc9xriFx7KuDNnx5PEA6kYaquPnymYzABN5nikXWdJ1W/wNSq1A1L62CSz/nALenwgA96j0ccz6dq+uKk88C86LBHoaQvhS3G5OlJUn4mxJ2oKCnm50qTC6YKNvF0eScLlcEeXtBmDGxAtXOK7N4FpVLTtN3+K2LZTePXv3wTUqN22cF7jF0JpMeXUCNlij3paVJ3jjnWhr0hJXwS/BoUVbSnY5LidlEPJ+ia6YSZBqaCfYCO/DMGPc7v0Ke7dfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m/hY38WXMFlT1+3eTngf4z3YIPyR3xllmcCMIeWPdg=;
 b=B9nHWytWYFFc1pJgb8qHo2Zwbs3t1CcjBYWpz8yOP+fwM4ASsL0X8j91MvKXo6jH0j2KRGqLS+JSnh+vcH3Tf2RNSS+Ri4pMMe6UFWlNX4rCV5WLbWINGDr+UK3G3F+2eJZuwzPNiAYIq2ol4+PT2xl36imsCROb6I9S2h+RoiI=
Received: from MN2PR17MB2974.namprd17.prod.outlook.com (2603:10b6:208:dc::30)
 by MN2PR17MB3774.namprd17.prod.outlook.com (2603:10b6:208:203::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 03:55:56 +0000
Received: from MN2PR17MB2974.namprd17.prod.outlook.com
 ([fe80::917e:95f1:fd23:39ac]) by MN2PR17MB2974.namprd17.prod.outlook.com
 ([fe80::917e:95f1:fd23:39ac%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 03:55:56 +0000
From:   Shreyas Joshi <Shreyas.Joshi@biamp.com>
To:     Shreyas Joshi <Shreyas.Joshi@biamp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: spi-cadence: add support for chip select high
Thread-Topic: [PATCH] spi: spi-cadence: add support for chip select high
Thread-Index: AQHWVnXjIZ8I7rtqmEm/hkQ/IY2X3akBUfSAgA6UWOA=
Date:   Mon, 20 Jul 2020 03:55:55 +0000
Message-ID: <MN2PR17MB29743B1AE9419961F152EC73FC7B0@MN2PR17MB2974.namprd17.prod.outlook.com>
References: <20200710045140.458-1-shreyas.joshi@biamp.com>
 <20200710211655.1564-1-shreyas.joshi@biamp.com>
In-Reply-To: <20200710211655.1564-1-shreyas.joshi@biamp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: biamp.com; dkim=none (message not signed)
 header.d=none;biamp.com; dmarc=none action=none header.from=biamp.com;
x-originating-ip: [203.54.172.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5935cbc-e3b2-411f-4e4a-08d82c60ce40
x-ms-traffictypediagnostic: MN2PR17MB3774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR17MB3774B6D7E5AF95A48785F472FC7B0@MN2PR17MB3774.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11fCbGvC5W29z4SIfw0rDVSWI5ONg+zLHb9n+9o2GSSXv5xMtZwrtlN5amS6H9jo7YK9NxNR67VWv0lLMzSHnjC+Ss7hsq2Ki91r3zFHL9HGrolTUPRt+IT9cTCvVKQryGXtre+iyABOApdvcy5aQmRpSORoC891IrceXmx21QYhKZuo3MycK/NYVi2P7E6afQRtpThiOPAqkW6G+IvTSiR7Oou+/ZPLA6eeo4qYaj3YUtcCpo132w4BsD2fDVvuNWOJwX/ToJ8ecH6CjePOkTh//SXbVnlt+sfYOCMgKVUzxNMPMt5Rl5DZCK8j1nlwQMZHOrWjObaGE3cjQk2YDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR17MB2974.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39840400004)(136003)(76116006)(55016002)(83380400001)(66446008)(64756008)(66476007)(66946007)(66556008)(9686003)(5660300002)(52536014)(26005)(8936002)(33656002)(6506007)(71200400001)(7696005)(53546011)(478600001)(186003)(86362001)(110136005)(4326008)(316002)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QHMyHBzhibYnLTXJc9gjswPCyxP5IykWPVP8i2Vrueck40FReJFygKW4Qsw5w+GTkYeFVknH8zOGK+yls68GNVJyxPEqjP58/p7eK/yipvKRiKEJScUExhwqyo9+LhILds6hv83FMmD/sx3hXeugZ7152hBNxmBpjFSGFtLw0MLgorDlGlIwnenZU+0A9TfQbnuvVzm5OGjWr42F/axmfSwquvqcli+3FGyJaUKGS7jomFUyo7bQutpXPP7wZNhCA6MNlsP0KszV7wx8thwXXIU7XLptse59ZVpvzwGj1Z63fwmScfO+Ckt2RVFJZOmyuDoufsMny6duUXf6351Ny5MRyKfB4wCodFemLnXGj09cD2V73+zSmJ6aYOdL52b2eke8sytoX6wjy6GSg+cwMUEgzFDEtFCmEEj+IjCW+28qf3stSdjn3UIvjMhu06/uq2+35SfV1xoB7AY6/Q1mgrEVuyXwHDdnbtVLKZIHDkY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB2974.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5935cbc-e3b2-411f-4e4a-08d82c60ce40
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 03:55:56.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VrW7RD51r2DwBckfqcYy9x6M8ZfoILVI05ZM8Rew/6CHjpxxdvk5jPXLoTlOL9qtrnYBGilP8Fbdj4NAGW0oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3774
X-BESS-ID: 1595217359-893007-23819-404840-1
X-BESS-VER: 2019.1_20200714.1757
X-BESS-Apparent-Source-IP: 104.47.58.102
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.225590 [from 
        cloudscan21-226.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.50 BSF_SC0_SA_TO_FROM_ADDR_MATCH META: Sender Address Matches Recipient Address  
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_ADDR_MATCH
X-BESS-BRTS-Status: 1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Were you able to patch my driver successfully?

-----Original Message-----
From: Shreyas Joshi <shreyas.joshi@biamp.com>=20
Sent: Saturday, 11 July 2020 7:17 AM
To: broonie@kernel.org; linux-spi@vger.kernel.org; shreyasjoshi15@gmail.com
Cc: linux-kernel@vger.kernel.org; Shreyas Joshi <Shreyas.Joshi@biamp.com>
Subject: [PATCH] spi: spi-cadence: add support for chip select high

The spi cadence driver should support spi-cs-high in mode bits so that the =
peripherals that needs the chip select to be high active can use it. Add th=
e SPI-CS-HIGH flag in the supported mode bits.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---
 drivers/spi/spi-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c index 82=
a0ee09cbe1..2b6b9c1ad9d0 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -556,7 +556,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware =3D cdns_unprepare_transfer_hardware;
 	master->set_cs =3D cdns_spi_chipselect;
 	master->auto_runtime_pm =3D true;
-	master->mode_bits =3D SPI_CPOL | SPI_CPHA;
+	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
=20
 	/* Set to default valid value */
 	master->max_speed_hz =3D clk_get_rate(xspi->ref_clk) / 4;
--
2.20.1

