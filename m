Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B87165F79
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2020 15:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBTOLu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Feb 2020 09:11:50 -0500
Received: from mail-am6eur05on2135.outbound.protection.outlook.com ([40.107.22.135]:22081
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbgBTOLt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Feb 2020 09:11:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr15fp6p5UhCgwb54k9QJdnAAbzwlyQDRi890lyB8pOvRsfkfcPghGPzcXdzt6uikY1axpiSgVuEVWvMz1K6hIhy6vjzIJgVNbpDRObMbJjyFGb/M60wkiU9sX/mq2OOKqwiVf8YwZRZkj+iHMA9dzmkCBJhmIXcfDYs332H7+ShigyyalygxCpMmoFOQcKNoEqaBPVjObGnV2joxara282me/oRsN42UUsvjW5RZ39Qj8QvgEMCWMol5bK+kJT7tghfkqMlBYlPGYlwous/u6fjNqqcpIKtOY/OuMaE3lV3aETjoq12o4DtSuEcYp79oNH2UUVACeN3LoNbFiAO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDH/hw0Vv7EIKHSsfkPwAAtzbTpt99tTgrjpbFfvww8=;
 b=KHAAfXCxdPye7ShaWubYZSw1T0pQXbGizRpMu2DNYIreAaPzLFMSYv4HZrkL/FdQnKAv1mX/ETGf2XtWaLXGjTj7tNHa29QA0ugcYJIyJvlrOe/tGwEXRCcuhKkat2K3Dxp3WXBXMmif0mRtrZxKQTozcRMF3pAgjIvu9IrftwQvg1CiZwrITo0I4gOjmah81CItKxNtzZgGhN/y1eqsUlNLPI0GGeBH5RgVdUBgad5U30QIW2L8zkRsLMguzS1dSgMfC9Gn2CXtpv4Zg2mpwJIGqszvlsWKB82MMrnizRZi6P2kUv11rwB24juFFNXcPq1E1H8z4md2Tq4BzxFq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDH/hw0Vv7EIKHSsfkPwAAtzbTpt99tTgrjpbFfvww8=;
 b=UPvdRxU50XIS88Vksem1+HjEhNZvVtG/QTqZ6FWIn9QF4VlyzAqji4fcdZluHGncGqVDsy4Nhe/lT7B4bXEqCsGEFJpKuxpVPzztVaQEDN0ZsU+RNOxeEaSRyBlgCkmW6qFH4Y6FjFiY9ds5pJwBla+4bBNosUFm7NJadhIw/u4=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB3167.eurprd05.prod.outlook.com (10.170.236.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Thu, 20 Feb 2020 14:11:47 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 14:11:46 +0000
Received: from localhost (194.105.145.90) by PR3P193CA0060.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 20 Feb 2020 14:11:45 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] trivial fixes for fsl-spi and spidev
Thread-Topic: [PATCH 0/2] trivial fixes for fsl-spi and spidev
Thread-Index: AQHV5/evyIrhTup9ikK2ghbCvu9ccw==
Date:   Thu, 20 Feb 2020 14:11:46 +0000
Message-ID: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR3P193CA0060.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::35) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37dab45a-8141-420e-9b4a-08d7b60ed1c2
x-ms-traffictypediagnostic: VI1PR05MB3167:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB3167FA8B7997E85546265F6FF9130@VI1PR05MB3167.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39840400004)(136003)(366004)(396003)(199004)(189003)(54906003)(110136005)(316002)(6486002)(4744005)(36756003)(16526019)(66446008)(26005)(66946007)(66556008)(81156014)(81166006)(64756008)(5660300002)(8676002)(66476007)(186003)(2616005)(956004)(71200400001)(1076003)(4326008)(86362001)(52116002)(478600001)(6496006)(2906002)(8936002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB3167;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fW+KK8zHRUSbHvWv4L0Dp/t24fqTrXszoayww+gILX5gR0BTzTb8+HZr3yvZL/xBLxrBsujDU6NdhfA+E2WcQ46h9mO7g3y+JvoXj+g9o15o0U0fEvWUwdwcOMGdOtURmmhUR9rDsB36JK9QMapehpuGOYTpPSnpLgzYAk8EuphziKXIR/u/z254nKUbzpt7Ksb6amJRYp4sMmzcHD0oH79co3EbW8TnG1EZ6FfY983RoycwNZI3SrT67NZvwLsFPo0iVlo/UDIdBbSXhIHr7locrBQn+6zhi/Q9ZyuxcoWrETo8n0OZw0G3QdMJy6a9NJ2bse/x5dbBZRWvafg58jnZ9lPrZJ5kJuZmXkc6YDRCtIeb5rZ/md11KQgIpwwXHUfmk8RjDTR+nmx3vX0EC9D80tjQ0Iu0Ypt5C/+InkoXu4W7XRPo1G+BclyUX8q
x-ms-exchange-antispam-messagedata: 7qbptshx7nNvO9sk26Y1Akjxk0C/mmbw+oQQELOyHDXIvOKF9QjvCnWplpfWe3rcZvJmJu1GnK8HZ/cgppfWrYFXjurLHgPriE6Dda2FchKEAIgIZFSOMrk7pW653viUi7u6lVVhbxXC/uk6WG6hRA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dab45a-8141-420e-9b4a-08d7b60ed1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 14:11:46.8369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odMLg/pTJfz9xyTA26GeAB2J4Al4l6L3sD3k5NCbIbtc5k5b78v6LXrbprNQdLeTRqm0wExr0R59sOC74GZVEh0m9KjmxIEU1bgYz9rabQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3167
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


- the memory optimization in fsl-spi
- the fix of the max speed setting bug in spidev


Oleksandr Suvorov (2):
  spi: fsl-lpspi: remove unneeded array
  spi: spidev: fix a max speed setting

 drivers/spi/spi-fsl-lpspi.c |  7 ++-----
 drivers/spi/spidev.c        | 10 ++++++----
 2 files changed, 8 insertions(+), 9 deletions(-)

--=20
2.24.1

