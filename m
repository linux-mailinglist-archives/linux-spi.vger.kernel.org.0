Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B879759EE3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2019 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF1Pag (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jun 2019 11:30:36 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62730 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF1Pag (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jun 2019 11:30:36 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="36285100"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2019 08:30:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Jun 2019 08:30:34 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Jun 2019 08:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=EC8k0lUnTLehK+k/YyL8WqMQedvOmO3yq6hwpbPxdcy2h4FVnp3fs8Wd4/ZxpWS4anX6+PYiVzeVyAXlsHnywrzyzQyux8WG0tmri+fWuutQ9D1AQvgI6wElkq9dT2fGp5aeGuBGfLyrwkUEIBqdm9Nv3w3a9Nx9X6C450gBPos=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qmSOSQ5fQZ7TiPqF8JQXTQSiLHk8NPxReU4fFQSJdQ=;
 b=Nhs9ziQlWCklm7L2mX87uvtlopD3Xl9tW4XKljDllQpszJwzw3/2g/iMB6IvZQNKIRVjap9GXikdk/EubcrstpiToKHYLibNbSPU89FW+vR6MRKd9KJxIhl2G6ghAwrTD8yOiY+sN6cYQOyfWP/+NVch2Zh2uA8AnqQXf4o8cxY=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qmSOSQ5fQZ7TiPqF8JQXTQSiLHk8NPxReU4fFQSJdQ=;
 b=s7snoz6uGX0rFIyNydA7yqBlkrYY/kvXonm/DtryrHvbaW3EYvIqcC63a/LwO5bNsQM/Xs0n3sTi56DM9fx/StPV35ouJ0liE37lnvvpnY4zx3uW96aNEX06Ncp2wAa9WkKQpFWlOQMtTMLuycT1qygZBJ3gYVDOvNWlmJ0hcCs=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1729.namprd11.prod.outlook.com (10.175.98.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 15:30:31 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::ed4c:cf24:e5c0:43ab]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::ed4c:cf24:e5c0:43ab%2]) with mapi id 15.20.2032.019; Fri, 28 Jun 2019
 15:30:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <mdeneen@gmail.com>
CC:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/2] spi: atmel-quadspi: fix resume call
Thread-Topic: [PATCH 0/2] spi: atmel-quadspi: fix resume call
Thread-Index: AQHVLcZrfPZRLapyRkmdyStCV+dYwA==
Date:   Fri, 28 Jun 2019 15:30:30 +0000
Message-ID: <20190628153009.7571-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0601CA0042.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::52) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3425dbf-b718-42ac-8380-08d6fbdd8db8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1729;
x-ms-traffictypediagnostic: BN6PR11MB1729:
x-microsoft-antispam-prvs: <BN6PR11MB1729C33DF400F10BCE2F1F1BF0FC0@BN6PR11MB1729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(256004)(86362001)(14454004)(81156014)(6486002)(6512007)(25786009)(8936002)(6436002)(5660300002)(66066001)(107886003)(4744005)(4326008)(478600001)(14444005)(54906003)(1076003)(71200400001)(305945005)(7736002)(81166006)(72206003)(71190400001)(6506007)(2616005)(386003)(486006)(316002)(8676002)(110136005)(2501003)(476003)(6116002)(26005)(186003)(2906002)(53936002)(68736007)(36756003)(66556008)(73956011)(66446008)(66476007)(64756008)(66946007)(3846002)(50226002)(99286004)(52116002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1729;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HUwWTA6wHS6miNxnmnnSmEOn2ORHpN1r7Edj3N1RXR/M6d/GgOyrWdH93QVmertOfDq+HVOJQckyHScpeMqy2u8BFEvmsJR18wkkaOtS3rvFbUz0bu/K+TYwQL00vWp99HiKXUklvHY4tUeMNn9jteQ4rRQoyIqj6P1b79oW+CZGox/45Wq0SsB/ctvrwFVgIJr+sODLJkCIr9cJ5O/exqqfnY14PNDdObCMra0o4EhZ6CdzFX9CJBw4gf8TOytdE2wZiGDDQzxSGbfkIJaqdXZCYeogxPQ6cwzSbFqch476MhOFst9Pryi2X9dCNy84IvuJ1QvQvGzzv2qFBz0qVtfgzkaQJJbMzxBWGrPO0zdtfi0fM41SPtfjbUnD3jLx19D7cFr5uYivFBgO+8UaEgm2avdse45xzolTGnKrX2M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f3425dbf-b718-42ac-8380-08d6fbdd8db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 15:30:30.7381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1729
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpXaGVu
IHdha2luZyB1cCBmcm9tIHRoZSBTdXNwZW5kLXRvLVJBTSBzdGF0ZSwgdGhlIGZvbGxvd2luZyBl
cnJvcg0Kd2FzIHNlZW46DQoNCm0yNXA4MCBzcGkyLjA6IGZsYXNoIG9wZXJhdGlvbiB0aW1lZCBv
dXQNCg0KVGhlIGZsYXNoIHJlbWFpbmVkIGluIGFuIHVuZGVmaW5lZCBzdGF0ZSwgcmV0dXJuaW5n
IDB4RkZzLg0KRml4IGl0IGJ5IHNldHRpbmcgdGhlIFNlcmlhbCBDbG9jayBCYXVkIFJhdGUsIGFz
IGl0IHdhcyBzZXQNCmJlZm9yZSB0aGUgY29udmVyc2lvbiB0byBTUElNRU0uDQoNClRlc3RlZCB3
aXRoIHNhbWE1ZDJfeHBsYWluZWQgYW5kIG14MjVsMjU2NzNnIHNwaS1ub3IgaW4NCkJhY2t1cCAr
IFNlbGYtUmVmcmVzaCBhbmQgU3VzcGVuZCBtb2Rlcy4NCg0KVHVkb3IgQW1iYXJ1cyAoMik6DQog
IHNwaTogYXRtZWwtcXVhZHNwaTogdm9pZCByZXR1cm4gdHlwZSBmb3IgYXRtZWxfcXNwaV9pbml0
KCkNCiAgc3BpOiBhdG1lbC1xdWFkc3BpOiBmaXggcmVzdW1lIGNhbGwNCg0KIGRyaXZlcnMvc3Bp
L2F0bWVsLXF1YWRzcGkuYyB8IDIxICsrKysrKysrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjkuNQ0KDQo=
