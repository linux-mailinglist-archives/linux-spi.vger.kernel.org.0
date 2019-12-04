Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE89112D49
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 15:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfLDOOQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 09:14:16 -0500
Received: from mail-eopbgr50135.outbound.protection.outlook.com ([40.107.5.135]:47938
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727792AbfLDOOQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Dec 2019 09:14:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edS9cMkwP000cuieK1BS0/zOfc1mzDjQtZn9PwfdMdV6iN5XM5QPlaDX63LqMpIr5pRhEHb3GXkAjWI28dgnZYmEUt0LR/LoksdtUC1fP6Nku/Jm0fiqeWgmp+Q0Igvoh2+etB9i7PR1bIIk1vXy/nYv4yVhDuEyAG2K2uKzOkj7RrG6TM1V3xSz39YAM0+pUmHHNs9dle8XdYsXDM9K2nrXcKqmnPoc5/NyWHl72/a+2zkjL+Fu5geXzjS2o4XYmvackvuBg6uyNKUJWlLTIrgKg+6Zz35SEum7mK3z4bGpzrENpHKF9bXxI+9xZ7iucvMjJYm8bbK31QrKrDYSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKatfycn8kFcMaxcJmJFD+gdkxGNMujVjoUu8W3HaBg=;
 b=RfCGmFCgI/suu9QCqkSuPyL4enq22zyUTYKf/Ar5Ip3lgzaUYQexNmU8mM+slBjzAsWb4MlX168aUQFp9u9prjg4hpAM9oGHO8MSEaSVNAmtHYx7Yh72TNXj5LInbku8mRL/8TmTO3WKk4ZTdpQk61NrfoqojFCzDKT+CjGRG7imGJjNz+JdebcO64XzKhUa15c9+8Igey/5YOamucZrHGc11DAxtHGyPLquuAMyUHuiBh5t3jLl0ZGBDngjBAfBBCaHGqMoyCufu7607MDTG3fhBKylH9fbKa5THTYc7TCoAVlt1hrOZeMDWUeQIDf0nwk0pJgQjFTaV+WlyAzaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKatfycn8kFcMaxcJmJFD+gdkxGNMujVjoUu8W3HaBg=;
 b=i++zUqCMln1fE5XsRBGTka9c788pmV/ehFn4QBKQ52gaBP7kip1kQuxC+Shane7/HYttALzE2mbkz9jmI7i7vDAce6aGo4e4fc/uUJaNdbgevrXefXsjb+1Qw2jsNF2Ep8LBYp7OTx5LMS/pmCemzpas+rKtWubhcvxzSBTDgfM=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB3902.eurprd05.prod.outlook.com (52.134.4.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 14:13:33 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::e5f9:4b15:8e72:1ae9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::e5f9:4b15:8e72:1ae9%6]) with mapi id 15.20.2516.013; Wed, 4 Dec 2019
 14:13:33 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH] spi: fsl-lpspi: fix only one cs-gpio working
Thread-Topic: [PATCH] spi: fsl-lpspi: fix only one cs-gpio working
Thread-Index: AQHVqq0CSRsyKaIE6UakTAYaVfL3DA==
Date:   Wed, 4 Dec 2019 14:13:33 +0000
Message-ID: <20191204141312.1411251-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZR0P278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::28) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:26::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.0
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18fc6534-9f57-41a5-8f07-08d778c4252d
x-ms-traffictypediagnostic: VI1PR0502MB3902:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB39022C00FF4A227D986DE0A5F45D0@VI1PR0502MB3902.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(376002)(136003)(39850400004)(189003)(199004)(186003)(1076003)(2501003)(110136005)(6116002)(478600001)(6506007)(25786009)(26005)(102836004)(14454004)(99286004)(4326008)(66446008)(64756008)(50226002)(66946007)(54906003)(86362001)(66556008)(66476007)(107886003)(2616005)(81156014)(81166006)(44832011)(5660300002)(8676002)(8936002)(6512007)(71200400001)(6486002)(3846002)(316002)(36756003)(7736002)(71190400001)(6436002)(52116002)(305945005)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3902;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MWObIHroWBQAFwg4qFOPp+FBz0ZJwrP6zuLk9rYfmtm4CuQPuRDiefq0/RJilTACxF3EWBNrG71oPqQavhOjL/ViIEGQ6JMAmlD4s6zkrecm488+TrflslE2SoE97wcRf4HO6dduSz3wNBDy+2YO2AzKw5fGSctsvg8HmV/FtApbZHQO0EzIypxD7uhR1vijxF3/1sPVgfM3eu8IAKAuIYE4TlIQQ+subMJic8qUPk+BZDKTgj8gTzYmetOM89rGiBV1cOtA3wSbsvt4ZLZP2Nb1rBMeWKxaQ+qimPAEiLg15T6J2Z5cPJiLmbP+l/Sgb7W8suOqEsBC79O/yHYr82oW0IZrz5VTl24tVNxBVjiSQj/AXcpz2Kw2lASj7AikzmRW7uWPT2CDsMqHsUjiZUTFddZequ+iV0/hEl77n1ChNwMHnpMp2HTeOAZniQgk
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fc6534-9f57-41a5-8f07-08d778c4252d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 14:13:33.0547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RtSpCMRa9syAIdMh8cosACgLOnKQK4LKKx9UUvfxlrGz5Klnueki3ug+xINyN0dhSq17PovqzoBvjQ8sEdGgnYHbBwGSfCkULUtg32G4No=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3902
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Why it does not work at the moment:
- num_chipselect sets the number of cs-gpios that are in the DT.
  This comes from drivers/spi/spi.c
- num_chipselect gets set with devm_spi_register_controller, that is
  called in drivers/spi/spi.c
- devm_spi_register_controller got called after num_chipselect has
  been used.

How this commit fixes the issue:
- devm_spi_register_controller gets called before num_chipselect is
  being used.

Fixes: c7a402599504 ("spi: lpspi: use the core way to implement cs-gpio fun=
ction")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 drivers/spi/spi-fsl-lpspi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2cc0ddb4a988..1375bdfc587b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -862,6 +862,22 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->dev =3D &pdev->dev;
 	fsl_lpspi->is_slave =3D is_slave;
=20
+	controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(8, 32);
+	controller->transfer_one =3D fsl_lpspi_transfer_one;
+	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
+	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node =3D pdev->dev.of_node;
+	controller->bus_num =3D pdev->id;
+	controller->slave_abort =3D fsl_lpspi_slave_abort;
+
+	ret =3D devm_spi_register_controller(&pdev->dev, controller);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		goto out_controller_put;
+	}
+
 	if (!fsl_lpspi->is_slave) {
 		for (i =3D 0; i < controller->num_chipselect; i++) {
 			int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
@@ -885,16 +901,6 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 		controller->prepare_message =3D fsl_lpspi_prepare_message;
 	}
=20
-	controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(8, 32);
-	controller->transfer_one =3D fsl_lpspi_transfer_one;
-	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
-	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
-	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	controller->dev.of_node =3D pdev->dev.of_node;
-	controller->bus_num =3D pdev->id;
-	controller->slave_abort =3D fsl_lpspi_slave_abort;
-
 	init_completion(&fsl_lpspi->xfer_done);
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -952,12 +958,6 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
=20
-	ret =3D devm_spi_register_controller(&pdev->dev, controller);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_controller error.\n");
-		goto out_controller_put;
-	}
-
 	return 0;
=20
 out_controller_put:
--=20
2.24.0

