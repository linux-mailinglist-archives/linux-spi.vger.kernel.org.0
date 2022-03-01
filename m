Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FC4C8A7B
	for <lists+linux-spi@lfdr.de>; Tue,  1 Mar 2022 12:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiCALSK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Mar 2022 06:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiCALSJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Mar 2022 06:18:09 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7A888F7
        for <linux-spi@vger.kernel.org>; Tue,  1 Mar 2022 03:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646133444; x=1677669444;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=XvkH18tuhRvXQu8jCR84STB70VWAFlYXls5PecMiRnc=;
  b=dsEU5kQd3M7/WpPwrEdS1O1wzgM91msR5R6A9rVINLVsDZEW0SAhKU/v
   kXok+OrbzBDyzcV8ynChCjl/UI8ZTmlBGbtIr8ksMdFAPl49K5H5fRJ6J
   mS25s+6zitd2/wII1tS45eLzVonweHtNig/w8xFFjoAhbFcxuq7tiL8gQ
   yN4Btubzm2Ht2ZLkbUuSMkzXPuGIqg02K3nherEMVyYZyuv0AKSVqefLN
   VRvpRmBB8+61B5z9ZFhyhgHlks9SQuQsgT2wQo6vxUwfmeMHXOxLgC2Qb
   J4b4oRPdzdKvbzJzIs2havcI8cl8HcmZcngSDC4RW9eKbffvIkzfmehEA
   A==;
X-IronPort-AV: E=Sophos;i="5.90,145,1643644800"; 
   d="scan'208";a="193118635"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2022 19:17:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1sGePaa/bt58wKNCtutl7LLK+4AANMV1ia3xo4PWERtuo8FFBXD8g9yZFz1v9EALg6Tc42b9zKnXiyTVDQyYIIjFmsAkjawhTZfyrA9rTuQgPDYvH4SMyjQHasZGM2a0oRzlVGa5og1eycDz4bZ/MY8sKXLpPTZ1stsmtbuEvDYcwGNyxtbHtciG79EP7z4KU+R4vhDgQOnGuov5BjUj8n0pMsoi5l1gB6E2aYh3ynXK7BvTYOBd88XifjQUzs/0wjgNv0BwdGBfh4hgxrceq/12pRhRbFFo0APt11i9r5dhfDPsr+mJjMPe9rp7WDOMNUBo2asupdq1FH+n8wkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n5tlhZynwLAssqz3Y7OjmSywHVdBf+aY64amMner7s=;
 b=j2SoEFRCbqFwxw+jZEwK8volu5h6Re8hkqNya6M9y0ZUWqrQ7wQ8T51sjeiSvYcy8K7w1RHdmd+GJIV8Ev9PazJT9xbu+5KfFDieiy0u6fkzO7Ta8X9mGmkqYrdqt2nJbuUmMHDIpT3tCqYEnUKfoQBNaX4CJnCO+bEISa/0dPvwY4lrmZ48SrL9+T5UejpFwvHXSZzk1nErAv3Lx+tKRq4EnWXt3ooFHXQYtVJDlAFbq0pAt7R1+ABPOZ3LCtxUu9/6MrWr1krrAILD6wLuYVgKwt0aqVt5VR+jaCDYvmU20cRtU502QGsguFU7+f0NXVm67/s0Xog+lqAp9QIJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n5tlhZynwLAssqz3Y7OjmSywHVdBf+aY64amMner7s=;
 b=tQ2Nq3gPbZpyBgtbUapcCO7lyau/Px3qR4tj9VQ2PYCZdkCD7rhO6h4QEUnAj5cOJmyrfQAVBtpfAcRY83lDOImgutozlNzfxi8OAY8PgnSn/jsM7Rd84VkzBdSfnrLNy5iVvMyqogUM0P0V2XHLAz75EBPMhz/SjrocGcfSVcI=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by BN7PR04MB4177.namprd04.prod.outlook.com (2603:10b6:406:f2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 11:17:21 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::f025:4f23:8e46:b2ed]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::f025:4f23:8e46:b2ed%2]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 11:17:21 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: dw: assert reset before deasserting reset
Thread-Topic: [PATCH] spi: dw: assert reset before deasserting reset
Thread-Index: AQHYLV3rnbk35M1FUEuh/urYvKkCbw==
Date:   Tue, 1 Mar 2022 11:17:20 +0000
Message-ID: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a971816-9f24-42c5-854e-08d9fb750de0
x-ms-traffictypediagnostic: BN7PR04MB4177:EE_
x-microsoft-antispam-prvs: <BN7PR04MB417791E7BF9F0DD904584BEBF2029@BN7PR04MB4177.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVusvOsONHdJYXoZ+IvXyWsW04saPiloppmz9ewLY/TPVYq+prn+ofYwz6EmmysV/6LPA+0Zizn9I1MJdSmI8A2hdIZXf+JN2Z8VDl/2LvHLFdm8A4fGWn5nR2A7nkfcw1pniGC2jiUx1NMAhPWydygNZ/NSCBUHorKBq29ei5SlgEIhh3lWHtiFfex6Hw2WGZeq/484V+AcZpUet0Tofec2W4qX49IjIIh9iu2arNo6rcei1Ikuq9Y3ihNw4yAqvp/Ioj+sO2linGC0fySRTqN4Br65RPgw/go+u450/dMN5j1AH6uNEMqvKyZZz8GGhbbmYAf6wuWGSzs+TVND3idsu2qkvZFDdRIfS7H8LxV7SWUy/KJqxP8tbZ+A9HXGv64gbT1uDvRO5OrCzQSkEnaKZ+uxxFV6DJ5A4ecTlFH2jwp/AiAUwvBTcltGfDo5ZjlKnm2An1Ow27pOvry32Q7P8O6aUS3CIUig8bzGJuGmFjbrghSTrVuj9pmqzOsXlrq7GEg5FyrS+PNXGrdwJsH4jx5/V2ihHmPFEui21PrTZAMnIl1SNetRLuU8Wstpw1CU4r65gjNreq6PK57p6+rH8+ie16PQKx+U3kd0+RYMfjJr11CMtiMoacZl5hM3EXXAYlLmhLatmc2EIM1DUbQp5gHI6iQYWzN/Ptq0Qq1INj2Y5isFd5BplGGrA57OMnI31d5mc/xECeNnQagbOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(54906003)(508600001)(316002)(110136005)(6486002)(122000001)(8936002)(38070700005)(6506007)(2616005)(5660300002)(36756003)(38100700002)(4744005)(82960400001)(91956017)(66946007)(66446008)(6512007)(66476007)(66556008)(8676002)(64756008)(4326008)(76116006)(186003)(26005)(86362001)(71200400001)(83380400001)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rMkWo6z8sc1EIufBr2nxduo9UKW4LuwuvN7/CB1kZc1JVLTG3PMti32WV4?=
 =?iso-8859-1?Q?pXJN7N8QDpaaj6UHw76UuugUAQe9SPs+TjlJ0JfhthARTbHR1AYFypAaJ1?=
 =?iso-8859-1?Q?iDt1W/XLPq/WqOwzUT0SsRiCQelgDd53NRdu20+ZuJW4uRw6dLwh5v3XYc?=
 =?iso-8859-1?Q?FMOtuY23T/O48NJvnaC7oK762zDroe1W7iYsFmQDMmXfeTAyqLQQuCKrb6?=
 =?iso-8859-1?Q?zN1MbokS/FS3NM5GqvTkmm28as6br8VyotWr3tlHJGQaBjRHNPje7kADRa?=
 =?iso-8859-1?Q?72m6MiHMLsHQpRGA6LUyQL7FVvqg0CNs9y/9K5OoAks1uGaVkoNF6PEehe?=
 =?iso-8859-1?Q?kwm/QFlZ+H/K+xIk6EN3o1hvfHPhx+kWk1bO3g0fIT3mLgBL8E0qAZW5nR?=
 =?iso-8859-1?Q?uM3ngW7FMfACh2Lg0UilxUrDvNFVKiyfeUHjwna+c3kjkGkHokPn48vDv9?=
 =?iso-8859-1?Q?SZzLjBQ7B7bA66gxveNpDdwBq6cCcYhOsqM+zsCinfcPar//Mjri9v8Ryk?=
 =?iso-8859-1?Q?s3E7O4WRGc0TVQx23BOnGGQj6XJEhllHqnIJRTcxOGl1V8QLnFYz4W3GTu?=
 =?iso-8859-1?Q?9YaeLX9Iw5MN1l0rqb8wkvbjBDft67ddcqt+zJ8nDBa/onXeD5hy7+LrER?=
 =?iso-8859-1?Q?j0gSLcfUA3lgpXLaE+3GSx9KrjFGyqFUnVfociO0avwc59SWr/4vW+YBit?=
 =?iso-8859-1?Q?M72Q4Pz4eeUBBbE+leVbNytgxmtEjFZlTxWfvJ4FJ2zP84YPZxLGb9gk3P?=
 =?iso-8859-1?Q?9DlNiSnihiX2oYb6K3czNIss2vWvtUBxfaSpnPthxqLsjgfYtI2aGTnxzA?=
 =?iso-8859-1?Q?erxoTTSNKxOonld+5JAk+8GQEmaJC5ZCAZWoYy57lOnpvjPBUJsfPYDaaX?=
 =?iso-8859-1?Q?hL3rVkH7Gt2R8xvRoMrpscelN3NdV/wi3qyz6YZJ4W/87426on3f82M/TL?=
 =?iso-8859-1?Q?AWavxIUPTnRHOymLOeakNwjrIP2RF0DfU0IpOSZBn7vj1ENNbziIFPS9Q5?=
 =?iso-8859-1?Q?Qu+1snSrga8sbt4vewsqZd5TDfDjd24YztijmLA7VIWUfBiN3WJiDDg+Hz?=
 =?iso-8859-1?Q?LsMmNvlx4hFVgP2U85RA8h1Fh23FtWX04CF+nyDpFZTwVH48c9qDHIoKAj?=
 =?iso-8859-1?Q?eQbEDuEb7goGxOq3eOR0Y639fsGU3afHBp832dm5aDentFcV2zDVkXWxS9?=
 =?iso-8859-1?Q?n/T+D+d6a6Bdarr8x/fIrNsSy5Bl6LdvLOPDrf+8n0hdkeuxVzhN6Jb7hp?=
 =?iso-8859-1?Q?4mmNOpE4MaR/JLGcamXFM9v0AFf4tKFu7h+WXAsczuLpWpUK/y2mHdzX/8?=
 =?iso-8859-1?Q?r0CfHclpPJjh7UuhW++psLtRIx7SbOViKl55XQ1vUbbwLJ0eGCkeoSkcoH?=
 =?iso-8859-1?Q?zVlcPh39UhaySB268BoN8XvhStT+2YVpzHsEi/eeAvR8+Dpvhuyb0NY35a?=
 =?iso-8859-1?Q?vO9ZtgwBuzvrdxxD5AHAdTPfPcE+Y363DRJsfc5XymbntVbgJZxg0NgNxY?=
 =?iso-8859-1?Q?p9bnEfSQ1fjLfr4MEyMoy/7KNwlM116fyd4vUfWqd15hFDu1RMTgvRFygb?=
 =?iso-8859-1?Q?k4MEq4JxkZg8gF2b0czw9/H2sXugMxR/aJGR/i99ND19T2mF4narJVS9+c?=
 =?iso-8859-1?Q?2R3SRy+ISzhGwVzaXd9uWHLq/IKrFI/pYkch8z/u4eXaDJnWXjxElUJnOh?=
 =?iso-8859-1?Q?Nc20uoMPOY4xNxYDWZBSHKDbyyg8KXh5n9QQuXYm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a971816-9f24-42c5-854e-08d9fb750de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 11:17:20.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7dpjKg3ziefZAiS8Lg66M6Tx1wMtTcK37PL8eTY9539l4lMbjk4ZmaTjl6lcoCBnSvFTS2Le4CIJrax1fnHjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4177
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Simply deasserting reset just ensures that the hardware is taken out of
reset, if it was booted with the hardware reset asserted.

In order actually reset the SPI controller, we need to assert reset before
deasserting.

By doing this, we ensure that the hardware is not in some bad state, and we
ensure that the hardware registers get set to their reset default, clearing
any setting set by e.g. a bootloader.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/spi/spi-dw-mmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 5101c4c6017b..eb1dacb45ca2 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -289,6 +289,8 @@ static int dw_spi_mmio_probe(struct platform_device *pd=
ev)
 		ret =3D PTR_ERR(dwsmmio->rstc);
 		goto out_clk;
 	}
+	reset_control_assert(dwsmmio->rstc);
+	udelay(2);
 	reset_control_deassert(dwsmmio->rstc);
=20
 	dws->bus_num =3D pdev->id;
--=20
2.35.1
