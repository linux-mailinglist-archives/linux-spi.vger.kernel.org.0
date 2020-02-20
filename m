Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD493165F7B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2020 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBTOLx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Feb 2020 09:11:53 -0500
Received: from mail-am6eur05on2135.outbound.protection.outlook.com ([40.107.22.135]:22081
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728129AbgBTOLw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Feb 2020 09:11:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1Sj7iK9Fr1AxRw8QkO8zlk9xFVusPvBwOGhYNy48Xn6hgHedo1hgAeGLoempbHEdiSRHnNvoWxvnz92JuUzrp+6ymfIKe/rtCHZdpFaYFjKad0W/rG9/JH5KVfZsjOqY0RnfOkl7xCaQz0UgyLnZZAeOrmbS2AY1RnDEbm8UkZqj4nGD9JQewuGZgdSMZ0pHcgwHhjFCcupa5QrBb7WkzoTIyEIn9ks09sA8uod/yy0XhdUjYEHWlcZhfwXCWeWYv6BmEw8p4FD/dYA00s6/SryVdY/dRZy4nBOUy4XTPedRA+ixF4YIWYAOWj0hZj7IPQzIWRt5wsv5iPnkEgUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0HzKmSU25apdq1DtcQ2R5UycoFDC5VowhBS3rlYUiE=;
 b=AKtlouAWHevWmuaDhCtvKE+FgQQJC4RPvfVEMdmd97TQqC7mL8rCY2DgQdbB9w9o+ZwAJ1D65bMwGfFhDtW7n8S568/YGhYD5uSGG1qJV85JczywCk7IoODWlqDQwnCSudIG84W5EqC11K60wE//qzuqFObM8u5Lsu/gPPQ1ucFFl9dl70Jye2+zUp5giLV7VJkVwBtef1Q3YuCR+rFKgzlUzQj1daUEDe8S5zIlMNnMI//LWjFJML7FR5pBahf97k1G6IVjVJNuXrzwLTe5G0lQ5T3pWqdM5njaNpKMbKSkJmGubv13NTC3wgBDJpqIY5hh7tICJZeQyrelbAUjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0HzKmSU25apdq1DtcQ2R5UycoFDC5VowhBS3rlYUiE=;
 b=V2UZ10xJREIxEQa/GRjY/FM4GPxbjHOpZFg4n0UWF2GTxli5lHAU6n+a6/9kzV1PLaIwhgzH+xSl1LKsS6OPkL+DlPhfNOYkTRu1hCrzUUFmPITAL2rYFaiGyjZG0Wb8/mDawDwZE+2rL/gWUu44nD3H97pxLDf7v1ZcOwPEihQ=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB3167.eurprd05.prod.outlook.com (10.170.236.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Thu, 20 Feb 2020 14:11:49 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 14:11:48 +0000
Received: from localhost (194.105.145.90) by PR0P264CA0102.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 14:11:48 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] spi: fsl-lpspi: remove unneeded array
Thread-Topic: [PATCH 1/2] spi: fsl-lpspi: remove unneeded array
Thread-Index: AQHV5/ewtAUeujGfm0+kV+RK4rZ10g==
Date:   Thu, 20 Feb 2020 14:11:48 +0000
Message-ID: <20200220141143.3902922-2-oleksandr.suvorov@toradex.com>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0102.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::18) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54cd37fe-360a-4f86-c938-08d7b60ed335
x-ms-traffictypediagnostic: VI1PR05MB3167:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB3167F5B588D12A2433B4C1B3F9130@VI1PR05MB3167.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39840400004)(136003)(366004)(396003)(199004)(189003)(54906003)(110136005)(316002)(6486002)(36756003)(16526019)(66446008)(26005)(66946007)(66556008)(81156014)(81166006)(64756008)(5660300002)(8676002)(66476007)(186003)(2616005)(956004)(71200400001)(1076003)(4326008)(86362001)(52116002)(478600001)(6496006)(2906002)(8936002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB3167;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0e/5JYTsM7W67KWQvCwjGqeFGWNuPBkLtph2JDdVIkKNpiKnSzNRkdf3Ag2JJ5SBCOXlxRdpzJWnWfLwrmL4En0ebflNZ+soBan+VZvrKVWGkx8FwfMa0FkL9+VgBHjoFVFstScVCzeUlfpj9OcyeCBLVMWuXDV6kkXce8T9P0hAV3zgSlB5K1MtPT2qGakCAG5/lAVaYfZh4Oq/dezhwn4TYCawhWULwHwqwUpkkbMSWk208IBLSEEpIaGzjZDRVt8s02RI48vAgDpeoyVwmD60DPS1Zm3Zu6SCuwFAb4/HrV+JwKfNsTZP/VR/8vR+L5sWDdPcVNBK4gko47u7loryWZe1hJBjUXaQiCkCNSACYr0/5UFBkX3uOsG9Nx6uZ4SZDLsK+MJdqCxrBo4ioFWAvf/iXcG+JGTF/SCwLNRd8lhEaCVb2JlBRffP5eQk
x-ms-exchange-antispam-messagedata: 43I0Y+REefJW5wivuigy5qGJzN0J0nzp1SRSqaBtWtdr+h7Lk6OHstyChmfL1PM34RLmdQeucRjXB6JH7/QV+Z4jiSl5SMIPQqaXzX7tkWzxZ03e+F14uhfcEw/1rVBweHkysBa0FbX9eDp+SZlWpg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd37fe-360a-4f86-c938-08d7b60ed335
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 14:11:48.8667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfFoo565mBXRwD5HJNkJrUrKGr2QMGcDxwwMmS669TAjOE8DvjuoilizMjD1uJOEn03mJm1DO8sLX5+//1+Za3+ghiJWIxBjqzA48F/iTaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3167
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

- replace the array with the shift operation
- remove the extra comparing operation.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 drivers/spi/spi-fsl-lpspi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d0b8cc741a24..298329b781d2 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -86,8 +86,6 @@
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
=20
-static int clkdivs[] =3D {1, 2, 4, 8, 16, 32, 64, 128};
-
 struct lpspi_config {
 	u8 bpw;
 	u8 chip_select;
@@ -331,15 +329,14 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_dat=
a *fsl_lpspi)
 	}
=20
 	for (prescale =3D 0; prescale < 8; prescale++) {
-		scldiv =3D perclk_rate /
-			 (clkdivs[prescale] * config.speed_hz) - 2;
+		scldiv =3D perclk_rate / config.speed_hz / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale =3D prescale;
 			break;
 		}
 	}
=20
-	if (prescale =3D=3D 8 && scldiv >=3D 256)
+	if (scldiv >=3D 256)
 		return -EINVAL;
=20
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
--=20
2.24.1

