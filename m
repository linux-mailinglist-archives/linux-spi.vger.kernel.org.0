Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE1173C8C
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 17:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgB1QHr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 11:07:47 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:42878 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1QHr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Feb 2020 11:07:47 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bFDFnB1+RRIPd111dezx3ksRvgCXz5G/hkdyhMzcwzFeR5r4TO3LPYF6evA1SWwPr2BckeM3kz
 piFCVU7xb+j3MwusQC0FoPrBjEuYlwGLrKmDdTLX6p5h6s2iZa01c7cbCv38pHNG73uIhxF4bq
 Fz05HQuCWA5dx149iW/CZGUdDHbdsRtfmobX4GIKWrzjMFh8pGLqTpVp4JqYF4ZFNIcD1vyqhl
 PfjRQ4hFVQKUsoV1QgSqtgGdl8IiwDTW4dfoEfD0Nzje23/7aD0CPKoXasHdX+lgCF0NFX6nsa
 ztU=
X-IronPort-AV: E=Sophos;i="5.70,496,1574146800"; 
   d="scan'208";a="3955071"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2020 09:07:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Feb 2020 09:07:59 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Feb 2020 09:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdLrhjndxaVhXCjBuMJPyXmTwaZBicTYLies6VYRDg7Wi7ax+VNcenFI4RsyWQY4CSXBSIgx+/3CPiTdLEytQu8007CSjTg41BueGwd+ZaIhhlBvg4WyMICpl+gMmA26bNXebQ8nAC4KqJNU0oM7kUpam3qF1E1ghAZZcFlMF8G2SZQfFCilCsb6VJEYyDh9/M2jn4hbX7iiPxR8O9ILVdUfABvnfXWYPAIWX9NhkFNtaFgpqjjbDLoLgWRePwaanT8JY8I0+Q0o5m09heKbhJQT01RnAqgmpCXrD/qwEzMVmBRFMLt/vdueyYlyddZ6KCMUMZZLSmuFrtpXrh4a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9WsFoDCaFkqmr7QyDSKf6KDy9bly2jYCMjk39xkZG8=;
 b=MowfWHemecJCO2dwbqGjeQeibst4tVXEUsMzNivojdzOlG1MVqHd3K0ucaXkNUsE7z5fWry/MNfTMUKug7hnb3rRYVygjw3mEkavAkqMZrKrlUHt6cwLhh1ZOnnirZ8OyCBrZkYZuqF7N/dD5YWZGqHDbldT6QB8uY8M5UsLj/pQewJ73R0joG7NnlXWdBdSEHL06JompzYdza7399OGdJrJzwIWZB95wEzUUykYjrV5yMpfz0ogJEQEsTs6VZlluDBYMLsmV9xwkWEuPtBKvbvLQ/9NudFM7HdyLt9YpG8kGwUV81ESHh0vOujH7VxYxeRHWfxdvK+urDMXq0zM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9WsFoDCaFkqmr7QyDSKf6KDy9bly2jYCMjk39xkZG8=;
 b=hhvZidgYVWau121eSEeoEAsteCAbPxI8789FIn+zz4Z5M0IWmxL7YYUY/wRuMgCxAZcur/GeUnL8O4BvYgV2GHmevUPqKDcQHKXKvr7nyQNxmjSRjkEXh6vrFtywf4ZMl8LfctGCO0y0woHmpL2TP06BFlUTwHPYm53Dg56y5nw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 16:07:44 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 16:07:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH] spi: spi-mem: Compute length only when needed
Thread-Topic: [PATCH] spi: spi-mem: Compute length only when needed
Thread-Index: AQHV7lE2rH2ZqAFcUUyXHJbyG4WKZA==
Date:   Fri, 28 Feb 2020 16:07:44 +0000
Message-ID: <20200228160735.1565047-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18db37df-0dae-49ff-65b1-08d7bc6858d7
x-ms-traffictypediagnostic: MN2PR11MB4584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB458478415E676AFFDA7630ADF0E80@MN2PR11MB4584.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(136003)(376002)(199004)(189003)(6506007)(8936002)(4744005)(86362001)(110136005)(6512007)(2616005)(478600001)(8676002)(36756003)(6486002)(66556008)(66446008)(81166006)(81156014)(316002)(66476007)(64756008)(26005)(2906002)(4326008)(1076003)(186003)(76116006)(91956017)(5660300002)(107886003)(71200400001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4584;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vq7MCKv+HjN6IuqxKBvqei5lIGIXzxbFvt0wds8rdLpkjNkJgdfEZlkGGVHhii2lcPLoO3nQPwdsBGfuO9079x91HyL/UW3+34yVb4d0KP4urk17hYlpgwonN6X4uNBvx1hTLpTkf8CfzoFVuZ+jQjIGiGkPRoVsRSedToV8fGva4IcIntMZTBSUhECb17h4hdEoXYLKVKyQcd6D4PRanPH+mL2506Ivg82V7dOCef5HHOLGA/zIbTzi2FM/JDHFfAKzTrFNjqp7B+/6hzalZPC9064P8sNg5lX3dLI4zPGxXuqNXkY3zwf1MSFJEKI2ogPWWBAMgZngrpku3/NJPevTLLAt1KphM0Bk4FCb1i9cCKsyZGlUm2BWtT/CwODAJOVuupY9EtPK82QyW+gdrc7WUb5krbeYsVYsy94/ZCFrT7HOePRAC2t14MWwOPvP
x-ms-exchange-antispam-messagedata: VUvFflF33PmB/x6j5F6IQJAyYqTFba5O5J/65WtbimalF0QOY0d2nY+XSjUjvelR+KjSga9UQAkiRevGKe5OyHd0IcXw4X3f0GYCaniYnfbpO2YheYh05Gm7c1pTaLCdiBpPKHsTBh+4Adqhmee6cA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 18db37df-0dae-49ff-65b1-08d7bc6858d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 16:07:44.7827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6CsmchpJUlz7ACE8tqIMpLgK7dDtkKconTIe4XrC3QjeuDUN3ivGUhNURRVy1frVL8T90+69Xi00m5ZY+BUahREearppHRByfW5C+o/MUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

When adjust_op_size is defined, len is never used. Move the len
computation where it's actually used.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3c46747bacb1..adaa0c49f966 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -418,12 +418,13 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struc=
t spi_mem_op *op)
 	struct spi_controller *ctlr =3D mem->spi->controller;
 	size_t len;
=20
-	len =3D sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
-
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
=20
 	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
+		      op->dummy.nbytes;
+
 		if (len > spi_max_transfer_size(mem->spi))
 			return -EINVAL;
=20
--=20
2.23.0
