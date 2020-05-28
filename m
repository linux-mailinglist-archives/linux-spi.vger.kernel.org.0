Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC011E6997
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405877AbgE1Slk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 14:41:40 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38383 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405873AbgE1Slj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 14:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590691298; x=1622227298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DJNy/U6JZQBTLNlcaasLEMF3o/nqkAzJOUQEQBZLZ/k=;
  b=b/NA67tV3qpOkG1F8WJ+uF1bN4OoJ5tUE4mDMpjHedcX/wAYiHu0A5me
   sS5TG4f15fajX1EBhh3cYcbritLYzabHcwU+zhmx9JAd7NnFSS8Xb5m+s
   SrdtJrs4HBimrpODCc52JCOjT/BzM6UeDEK/xEoe1/nY13QAXBgQFUuIS
   XgvStZe0VoLMEjguzy+qyw+rqupMMCO7fnbmvCTifMLD1j5578HIe4O7N
   D7/ZqwOuGsejiPmlAELcVgCt5QGyZO6kXvwRfUXJUIb8Zb62ni8HRrHGb
   Gq38vWp/HKZRBfaoVYYE2iEplBWM0h5fpaTCGozA5vEBimRqc3Z1N88I6
   A==;
IronPort-SDR: LZTKUfnsSoZqEh8fLx8Ayv4VvU6Wvu5vMXnTXXVPEZnQy7o2Trn1KBjCuzvYLhcY8Ruq5uEeGF
 EOHjzCvsVU+o+yRGav+GYSoimgLT2rMBG9WCg9WVrlFSswUl/rqUJ8OV6rAnmBmQhtl618JMd2
 CakuJSczc49vCaqvUAzFvMTH3BC5gto8N/IDFFv7n6Ri8NXntTcG028aNo7GFeJ0F9c4trGcPV
 G1ZXL0edk5w11qhXzO9PhHuov/qCTFXZu++qb7qxhOoKHtwuKdDq4xCPs/eHeBaHx7YQAfsqLT
 rFI=
X-IronPort-AV: E=Sophos;i="5.73,445,1583218800"; 
   d="scan'208";a="74798972"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2020 11:41:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 May 2020 11:41:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 28 May 2020 11:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFBgfX6w/OqIQ0eO0NDcMdNTW/B3CoOKYUCIyKaNsHqS83rr2g6xtPcBL9Z3BxLzI7DBwOxVODbv3zC6YaisZOl5DZBYGOX6+rlRhb7Mvyze0mvoVZwD+H5Egy17qFWXeF9MjmhOczpok5BPzlrYFpWXNJZvUWnF/MkZOVIvNgEz3XrTU+bcyjDHTP997h4J7OMnMSsxhXu+VdmRqaDQW/5DF/pAqFetNd2b4dONQX3KvkiktwkAQ2cTUvDD3Iwp8fU+xSSLlcIuzWECNK4qopfZWKdaL63PdCuINCzJ/YYHr/1kQuTE9Q5iR6NACBAfmrsgU26bBIWvnggXq2mFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnMraFO11CWmJMKesD4z3qcQtm/Ev8BM0olQa9kzbws=;
 b=VPwoor397b7sNOuwmTehsyD8+EtvcpymXLZJN+occ3Y4ZCWSI4Xift76w88LvDR7pF4QG8s5QAfTuLq4ZbVFPgCHEq406HQ63gs+AzQB/aDuZY5SNRb2TIMk/wgVrU2sS1MMzK5YwgeIh671PncTR2nMm2bvI/sYeBlXmIJFD7i+vgsRkziT1MQ5HunmYNXt/ajHdc4BApJcEDcRmFUZwHg4eycI7rEIjtJGNdE7gov3oQVYyAPiNUCRZ/BSkrkfNscu71Jy54aF2EJZSLw4y/vWBrmKaVMWULj3yto8VQWVQpEke30nYc6T2fBpCt/RU4RnZkBgPWxM8RDOLYuzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnMraFO11CWmJMKesD4z3qcQtm/Ev8BM0olQa9kzbws=;
 b=IyXanwmidHgbwufYj4OzKF4nxPgjS2rm43yaDNIXzvu9bYRRAdS9DGfrrqU0gtlz2lHGDFCudio/4+trHUuNplc1tOlAX/AWFc3CcO56/NOK6shB/+Bi1R1oy1i66ToFQzm0gI3PU6JIqnzmwlg1HwdyJ/MYeMBa8kwYSeQTMqA=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4085.namprd11.prod.outlook.com (2603:10b6:a03:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 18:41:35 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 18:41:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>
CC:     <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 2/6] mtd: spi-nor: cadence-quadspi: Provide a way to
 disable DAC mode
Thread-Topic: [PATCH v2 2/6] mtd: spi-nor: cadence-quadspi: Provide a way to
 disable DAC mode
Thread-Index: AQHWM0FZdMrQfpcZVUCj9p3WoPBZUqi92LYA
Date:   Thu, 28 May 2020 18:41:35 +0000
Message-ID: <2690575.R1takI9ffF@192.168.0.120>
References: <20200526093604.11846-1-vigneshr@ti.com>
 <20200526093604.11846-3-vigneshr@ti.com>
In-Reply-To: <20200526093604.11846-3-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72ea0703-6349-44d3-7181-08d80336bff4
x-ms-traffictypediagnostic: BY5PR11MB4085:
x-microsoft-antispam-prvs: <BY5PR11MB408562ADB4D68EA5CF59D7CDF08E0@BY5PR11MB4085.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AqHxYGDaJd24vpiiJaAJdUU+hcdv+6aP7mp5d3a/bUqsnZSh+kM7bL0AYY9CjFLZeMNrZQnvqmlhOnkpyst/ROFn+JwAi1soG0htu+b6Ch9Rf/XwCaxfDWVNDtY/Xfsfxws0/4R49US23quobZjxTfbHQKVSYxg+QrUX0sVpjsWrl7retX/o2rOsLoqLtHut10itlqPFeWEth4pTvBx6NDxWlwA12dAGRNoqLtAP373tT5tTbWLQtm3xY+Ft+h4sZNud9ZfOMAmHGqqZlhbgCOJ+lV9gCrHinp6ay3eEdFST04JfcKcdwlzday9y5fhC8utQGnm1ALJG6za3j1vepPoTAcEp4z/DX+noUTH8Kmw4IZZn56IuUVaVUZqFT3zPEFZ6rhz3YU/02Rj03PkfEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(39860400002)(346002)(136003)(316002)(66446008)(64756008)(66556008)(66476007)(2906002)(186003)(4326008)(86362001)(4744005)(8936002)(8676002)(6506007)(6916009)(53546011)(76116006)(91956017)(6486002)(66946007)(5660300002)(9686003)(14286002)(54906003)(83380400001)(6512007)(7416002)(71200400001)(478600001)(26005)(39026012)(43043002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6qW/yydW2lhYyOaF7z9vE56Wfw55c4biR0Cc0DhkTTl3xX8z4VA9R+INjW6N3ti/PMg2b5395+r8EG3ugx0cHTK8WdeLuSjW0cVhqoKczHNd79Ac1mTmkiSeVFY604TWMtLLo7wDf21T8IWDPp+lKwfj52/et03lPUI5y9xcu1/kjqETPkCxmvGz2wDuM1r+fNHGO5XCSTi118/88w3yt5V1RqmznV98FpX3CuWXBHNOdFZRErSdXqaKZ+6i2+YNfHtLPrcQNRHr9AwRq2JoQgtMBE3m8w5KxoxhX7zE4NAiDMUVYhkNAZNxRuuS/4y348t5qoh4KfB+tC67Ivth6EEJrdlH/kajbhqDJl6PeYBwC4niH/b1joB9b1TJvJm8L1E9oOb5hq8hIH8IBAJO4W2rVnjblN4eozdab/Nrs5evXUMvw3UGh2aOhBGG3bQ7G/gVuuAfYNvtkCJqN3Z0MLd3m/ONORiDbSUh3ON5qoA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47753298B8923749A91118FADD2111CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ea0703-6349-44d3-7181-08d80336bff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 18:41:35.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qL4LOsX0QbJOVz6EbLx24FbaQHvOkpcVKLKdLCtoiQcoFMDdlWqIscvYOdfseR1yzZ643ffwhbzCmhaadqdlY2D0xO99c57pevYfaXL9HKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4085
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tuesday, May 26, 2020 12:36:00 PM EEST Vignesh Raghavendra wrote:
> Currently direct access mode is used on platforms that have AHB window
> (memory mapped window) larger than flash size. This feature is limited
> to TI platforms as non TI platforms have < 1MB of AHB window.
> Therefore introduce a driver quirk to disable DAC mode and set it for
> non TI compatibles. This is in preparation to move to spi-mem framework
> where flash geometry cannot be known.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/controllers/cadence-quadspi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

