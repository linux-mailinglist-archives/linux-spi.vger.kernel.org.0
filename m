Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE94F1606BF
	for <lists+linux-spi@lfdr.de>; Sun, 16 Feb 2020 22:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBPVkZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 16 Feb 2020 16:40:25 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:43565 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgBPVkY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 16 Feb 2020 16:40:24 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: HwJsLreoM3GJOJsKKE8ZNlAdFmJHtmBLtM/Pa5baj1Q38pHGnjttInKReV34FxSbqjNxxMZ9Fg
 FkiBwiYqgEpOkvC9ArEopSvJpkwcvkvY36H6dB764BJX+we1C2MKC3b8/oW1+vDvAitWFAITe+
 62QKw/eZZK7QzoTMd0Jaz4VRRhsajBEkCFJlXXdQCPLjECrEttZDA0oXXKKuuQ3XMWUoW4fMhh
 h29U4zfWeBmkK38kK9JXOyvK3n2Jb0c7FInWuYmEyo4jFHB8es0J58pgmMguRwagPNqXQQPkPR
 10Y=
X-IronPort-AV: E=Sophos;i="5.70,450,1574146800"; 
   d="scan'208";a="66075685"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2020 14:40:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 16 Feb 2020 14:40:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 16 Feb 2020 14:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGHHZOULJRc3dS9+8pO5JNvhU5wjREzu2Ov72LHkK9WI1Uqx5ZvZQ/ZJ5RXJrd/agSfgIk5gKZZopQA1nAKA919fwleJtoA1pdyc5EF79hU7COxVY1EAJOtYPAyIUBv2WqGCcQJll5B04pQh4ta9A/xyjXiTk3XsfWDp1mKtKeActJDWFrEap0H/GtHxmzuD3r8/sRwdiC2VAUPyQIwZ8FCdVUoc95bKt6wfjxEcJsrTp4bG3OaXYKMvsvTbPR6BmF4x9eJLlbu3rT2H5K3d3Mo7UzK8CS5bMmxZbXRR6a82w1+sTnWJXYKDAyJkuCRS6ZV12qXGClpjMMHRGhBZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNqC3PjT7KdICI6GIvvUjpLNt7PlCCj5RuJm8lbo33o=;
 b=VKNF1JQDY9X8wGvKcOrspfQaHzEiCFKVrTtHAtcJo2b99q2l7pftgol1vvHNBTGVqbvskydOO1ichIWlel5Uw9G+tOrCM4mQHNA0vSQklnBtXqPyZu/SMZUej2iBtBGjVvrv4NVXhxV7uKM235wBvBQV4Khdr1AjkOheUwYlC6qjoI5fRV0c9p+cwrGSxc8H3XPfTLJ7NCKk/1da//7aVCNQ2KbL2utOzBxTlsglXfWt8QIwQcbFbvrKdaxP6EsblN4XEKAnI4Q7NTlpxXg08+LESDjTxYsxJa9j8em4yuNmFgjD5cscOCNo1UY6SCyboA9uje422pdwzVw+PMFA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNqC3PjT7KdICI6GIvvUjpLNt7PlCCj5RuJm8lbo33o=;
 b=fLb15wCmNUW5oprYvd/B5FJhxq0N3ThBRiQo+W9VUXU0GDmFLfLT7wZiLksG1zSxUdimll2XBa/EcWdQ+wlDO8ae8QpYZuxS9nbJi+ovqRH8fAgL77vcaIiUy1ckw+FZ6kCWT4fhPc73HsWUg6Y7x6DYhudtSETypsJD4qrOfmM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4397.namprd11.prod.outlook.com (52.135.38.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Sun, 16 Feb 2020 21:40:18 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2729.031; Sun, 16 Feb 2020
 21:40:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH trivial] spi: spi-mem: Fix typo, s/fallback/falls back
Thread-Topic: [PATCH trivial] spi: spi-mem: Fix typo, s/fallback/falls back
Thread-Index: AQHV5RGuUkBRwIGtrEiFoJhzWraU4w==
Date:   Sun, 16 Feb 2020 21:40:17 +0000
Message-ID: <20200216214012.1106658-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8f4f487-16bf-4851-c27f-08d7b328d12d
x-ms-traffictypediagnostic: MN2PR11MB4397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43977C76FCB012D2A5893A8BF0170@MN2PR11MB4397.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03152A99FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39850400004)(346002)(136003)(199004)(189003)(54906003)(2906002)(6486002)(26005)(6506007)(478600001)(1076003)(107886003)(2616005)(36756003)(316002)(81156014)(8936002)(76116006)(64756008)(5660300002)(86362001)(71200400001)(6916009)(186003)(4326008)(66556008)(91956017)(66476007)(66946007)(6512007)(81166006)(8676002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4397;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0O1zZ/11XhZC8+W6LHaSQFOBrJACQJezSqgmzHNsRi4G8B2xngH0aNPhqLhCmTK1vnqCPKRFXZU08dKdC+kMIz5nBglp4/vmUpgWOi3maUFUcsqgXHajnistOdkUjFx6N2/9W+TzTlmPvqtF5pu9ajp00eSuiUmsjfcVGUmvyyhvFSVqIvRMTwOexC4DxIV5nosPCY8R/cSSOGnsN14R/GTGdj3UOFle5Qgmoi1iwoB6GRhfO2lH89mceoOFxj3a531y6meude2vZhgF/h2b2Kt2xTAPNCOpzFUq5YFU9w7DJ9OGV6y5NEOM2J1Hjj3eFDpx2PD+EPFvymdre9Y2fDHkt3co0aXD3rD4HWtP4gICa4CZ6b+PatfFCM0oaMb1vlemFQYHyyNE0DwZtpzrjlACAq6Hcx8byKrLmmB2Un16yoP05IyhlEsF+6ug4LdY
x-ms-exchange-antispam-messagedata: WHpoZFzf8tk4Zhx3g4lnVD7TMzeXQ0TV1UIQxGPayJ+b+rnYGXhhSVzALayq9kLgnTnHcSbD3AiS2KyJheP0nrCAAA7CtZaxet5tbEbNo7irafYiZKfDJaG78ZBg9OUXXBqig5Hb7ujUNa1Ms55lJw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f4f487-16bf-4851-c27f-08d7b328d12d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2020 21:40:18.2587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PshbvJICZ/5sAJfM7gyVpw5wWY4R2i2bqxF9WHdpAkbRdvGWiBcgBs/UeOB6T/VoO1Us8ZbLBBGRRyDi9U5Ujey7rv9Qt+bYJyDWQcKkorg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4397
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

"Fallback" in one word is a noun. "Fall back" is two separate words,
a verb and an adverb. Use the latter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e5a46f0eb93b..3c46747bacb1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -487,7 +487,7 @@ static ssize_t spi_mem_no_dirmap_write(struct spi_mem_d=
irmap_desc *desc,
  * This function is creating a direct mapping descriptor which can then be=
 used
  * to access the memory using spi_mem_dirmap_read() or spi_mem_dirmap_writ=
e().
  * If the SPI controller driver does not support direct mapping, this func=
tion
- * fallback to an implementation using spi_mem_exec_op(), so that the call=
er
+ * falls back to an implementation using spi_mem_exec_op(), so that the ca=
ller
  * doesn't have to bother implementing a fallback on his own.
  *
  * Return: a valid pointer in case of success, and ERR_PTR() otherwise.
--=20
2.23.0
