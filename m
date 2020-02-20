Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAEAF165F7D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2020 15:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgBTOLz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Feb 2020 09:11:55 -0500
Received: from mail-am6eur05on2135.outbound.protection.outlook.com ([40.107.22.135]:22081
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728225AbgBTOLz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Feb 2020 09:11:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/tmD4R+K08xtVFz0taQMAe5yRsT8+f/CJPgKsnqYAkrv0Y9uXqmjSrP0ySOs+4XT6YGlqGttwPS+uHqoyho/m7bFjbpQDHK09xGQPOmACgheRYYsUzhqzbNHBX8OTywIzPlNl1i/BAaBJrhOPFScmYT9npKcDVgpTknQsTmnFAI/6tvlDC1wkcuT6M7bQtOtJIWHjShMs+uYyE+SEdc1CmfiUsDI7A34Xdg6KD7B3EX437PAaEQkhRGXtEynx0fmyuyvTWV0+gf0TsLlRSdALdKOoOEZb6lhdmKo2j8Jt/i1qcJb+Ql3bkp53+HLN0Y2gQZ7ts/2KzieFXjOZ7s/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6666zuqZ5ttzCGBnEQHeaMNUcYj2/9XvNHdpDnu3II=;
 b=TkW04KRkrrwCGMMFYORY7Hi1z4pcGu9P4WVAWpgIrfIejUG+L1G8NIJF34fXHNQz0CZ9DemH9FGZIWyx2eVnqZkLTQSQQYWMpbUx2uPj7y8UFEzQIEXYLLd0AFGrmYKOvJqGkWLI3UmszwVbUePIpy6q4gJl/cvVuVA6bhc0nvQG5su8q2jxdG4/n0kRevfvroigxda3335kJRc0Xv9r/3NTiBTfNJ/HZZn4JaD0CTMELbaLy4QBLBaD1fRU7LhnKWnsdVIuifF7eF9omrUnpIQg7DyKdhyVFi6l8p9EKHfdH/Rwd8EX9zd3BytSpcB3VgVK5+mVcYIlkvdaG9M0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6666zuqZ5ttzCGBnEQHeaMNUcYj2/9XvNHdpDnu3II=;
 b=bSUwk8nUilz+9jkVusSFDnHI93/TCh8RrU59vDxpCfLdogWGHmTSKBr2FYKqQkyv9dqiVhRHWgpdoe1AUaB4dWXz9Xmkp7teKgRpFXFhCS9/xHPoK6p3nz2rgu38HTwKsSEoAF1+Zyr5gkjRDDJS/DvajOz7XBRnwBk7Md0hoNI=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB3167.eurprd05.prod.outlook.com (10.170.236.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Thu, 20 Feb 2020 14:11:51 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 14:11:51 +0000
Received: from localhost (194.105.145.90) by PR0P264CA0203.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 14:11:50 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] spi: spidev: fix a max speed setting
Thread-Topic: [PATCH 2/2] spi: spidev: fix a max speed setting
Thread-Index: AQHV5/eyaAawrcInZ0K6xjw9t46TKA==
Date:   Thu, 20 Feb 2020 14:11:51 +0000
Message-ID: <20200220141143.3902922-3-oleksandr.suvorov@toradex.com>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0203.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::23) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df8471fc-c73b-4575-588d-08d7b60ed48f
x-ms-traffictypediagnostic: VI1PR05MB3167:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB3167E563ADC98F91D387066BF9130@VI1PR05MB3167.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39840400004)(136003)(366004)(396003)(199004)(189003)(54906003)(110136005)(316002)(6486002)(4744005)(36756003)(16526019)(66446008)(26005)(66946007)(66556008)(81156014)(81166006)(64756008)(5660300002)(8676002)(66476007)(186003)(2616005)(956004)(71200400001)(1076003)(4326008)(86362001)(52116002)(478600001)(6496006)(2906002)(8936002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB3167;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rk8mHLyo/pp4JMbvivfecBrgMALm0ZttMjtvyhO3Wajp+mZgt2fzlINEMoTC/eaLSOZplIpk5HU+SVsReT61Z3pNSO55cybgY9UCQehz0Aywftyccfa9gIfjvfSW+pEFTPokxHbB/QxnUxuZw+OXyEczE3xraZqNaxYJfQyIFTkqRElU7QzByJUG9sqfmDTqjOlQPoXz9NmPx0zn3PA4++oaaEb2sJEKJp2pPUONe/75ok4G/zKpoIIbAwjIgz/f1qcjhzd6NkQWU+bsm9ITNDScdoi0s9DjwLtDVW4EePMIKLj2XCAoBzd/sMJSW5eszewGv8dK5Ju7NsMv2kKkFFYkkenl64eRLMLDh3cM7wPyf3kCPhzkJrZY1lgp2snJcUxQ43eY5Aor/8kqOJZQNf0hPCZJKEVwdBn3MkxWQdAOAF2D6wAYIdSoosmaOv9k
x-ms-exchange-antispam-messagedata: WkOPdIWuQV3j6u62+pcMtYWdCWKxa5E0gzLEjKrqypatgwkR+7qDAlVchVl2ME6WXbLjVRg+UFqZfim9Nj2qjxIebvcNwc0yMmAN7RiNk+YQ9GoDgv0xqeXEF8xxbrfFJuzM5y57Qg7sbrrF4TEJbg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8471fc-c73b-4575-588d-08d7b60ed48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 14:11:51.2653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfYP3UUigNPx+zf8Vdd2NdJZDTaTkbMPYt55ccWfwwCiRE6VJd9WEZn1chg4ZfSpi8B4nmxvY6RNIzpgUwhEny1KBDQbrHq/bS6jbuEnBmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3167
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI_IOC_WR_MAX_SPEED_HZ command always sets spi->max_speed_hz
to the initial value come from DT.
It leads to set a wrong max speed with IOCTL call.

Fix the logic of a max speed assignment.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 drivers/spi/spidev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 1e217e3e9486..b9b3ac70eb18 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -449,11 +449,13 @@ spidev_ioctl(struct file *filp, unsigned int cmd, uns=
igned long arg)
=20
 			spi->max_speed_hz =3D tmp;
 			retval =3D spi_setup(spi);
-			if (retval >=3D 0)
+			if (retval) {
+				spi->max_speed_hz =3D save;
+			} else {
 				spidev->speed_hz =3D tmp;
-			else
-				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
-			spi->max_speed_hz =3D save;
+				dev_dbg(&spi->dev, "%d Hz (max)\n",
+					spidev->speed_hz);
+			}
 		}
 		break;
=20
--=20
2.24.1

