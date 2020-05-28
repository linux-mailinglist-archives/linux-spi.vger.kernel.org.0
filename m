Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8036C1E5E8C
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbgE1Ll4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 07:41:56 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:59765 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388441AbgE1Llz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 07:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590666115; x=1622202115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JUbfJ/grhJxrmxMI/oPm120rZDkN7Hmpw01cYXHJ9dY=;
  b=kHBw8hU4AGXsn8eFYbwF238euhJ2wQss3l+oogo+GSFVA7m/7vnSa4kl
   w5AIKHFFKLmRTdC0AeBZbc6U3U2jbcONgYMjlLDAvL5yojkXuZx/Qo3Qf
   pRFb/HO4IzZLjVAOTxVSV4ZCEX5fhVVJ+sOqKzScACvonI317oAgjUMxA
   d7bBejUwYX4k066nxiUHtGvgtoTsLo6d0ADoW3Bj3J6ahHpJ+Vaq8pYip
   IxTa+IT2VF7kUyjBm4mYV1MMlt/EepcAWaTJ3ILWeXCLmwrE5EDyNaGI3
   J2iGumI4n2G3CCBTOxC9d1Mei7AkLgg7/3dstfxwkpYg70J/Cz9n1xKNh
   w==;
IronPort-SDR: a7pGp6+oj069KOC7r5VWT1Htpwy8sY0tMJV6RYrQoWE1/BjWXs++i3N2cMbUndK9A9eay6XVMU
 L/54xWWPEs655iKicgb2+d3bT8RcAH5uBnDFVq/dST40szQBHzbllKaoYcj6ct0vCJhRnlQL1U
 2xwYvg/o3MsknkyluVGzL8s1j4ouunefDBIfuVJdfygBG+oJpditYWpNEuqZmfucw3y6qUFFjy
 FrGqMydsvE8yFaWPjb6rqXdKx/sC57OLSdixCYOzIclJPobtNMhJE20oZ82fUe5n6GYD1jBoy0
 z3w=
X-IronPort-AV: E=Sophos;i="5.73,444,1583218800"; 
   d="scan'208";a="76630723"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2020 04:41:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 May 2020 04:41:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 28 May 2020 04:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oftR6w/RzFrsGudlG2dnkuTW1NHPfHwa0tvNSfuJuFrpV9lQvU6uviIZJBmrwidSBk0jZvR04bQZkLpkKZdg0vTAJFJYL5pwqjWP7YZss1VHM3IcywbtH6ZHA/nocjmparBJXqSWscGVUSyUcKrOYEc8bh3maIG2ImDRgBb2IaHSsihQFDbvV8v0VIhBYboidlSAHEdpTdpUB8CRxNk9RZ56FIkJk/Elts2vdkmAYJ5G0E6FgubS/Xs8TZyqJoETqxhscABlMVc18FxQPl1CNYFUyy1FvsVFfibgeZmWDsW1wZ0uIK7JnbBwjuZMFeh05u0HvZQMCxTyDfEY2/Qq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeTYXWsxjySzl0PIFbR/C1JOTy3mq7Z/MvfNUykkXco=;
 b=gwrTB7I4C6JqfG7/g8e8GL91JJANBEzxJj4ud0x13BZC8xFO/9LsyeavZG/8RYp0AmiOO/bxLnpcx0PnOSfVwUVMn2skcGwCb/EBt08th1PP1PpreZ763YkLOiJrIdJNOcQEwZnLgGF48lgRMumA0RhZ5OAYt50svgzKPcyLKKcS3nHgQaPisXjJ5reNSbD8bb6Rfr7XjNEOfcnS6qkRDrQ3z5nuktEQSbzLnJN1IqtxqTKwxlsBs7JejvfRdRDdQj5KCRNlKlFyb4URpttWvaQmWP/n0gLf39MLg1l5jXdlI4pQsWpiSnA8cCs+IvemNSspXpN725A12j4uGrM0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeTYXWsxjySzl0PIFbR/C1JOTy3mq7Z/MvfNUykkXco=;
 b=iLHhQKjsmQLo83MhYUDwPtsl7Q9mDQWa1SReGHKBZDB7tLY0VNdq7TAkBbG0z9y1jOH1HrlhhA4oHekLLwbbeBmfsCb7rFtF5kOfBIjnXNiiuWX5ffMmABUvZm9gMvoYd/JOL+ohR5E+IYdTnwQcRgYHmGGOijlyqHnmWL15iiM=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB3991.namprd11.prod.outlook.com (2603:10b6:a03:186::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 11:41:52 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 11:41:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>
CC:     <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 1/6] mtd: spi-nor: cadence-quadspi: Make driver
 independent of flash geometry
Thread-Topic: [PATCH v2 1/6] mtd: spi-nor: cadence-quadspi: Make driver
 independent of flash geometry
Thread-Index: AQHWM0FZFb5dBCwkWUGeiULRbnlz0Ki9Y2+A
Date:   Thu, 28 May 2020 11:41:52 +0000
Message-ID: <1873244.LXWL5g5pfh@192.168.0.120>
References: <20200526093604.11846-1-vigneshr@ti.com>
 <20200526093604.11846-2-vigneshr@ti.com>
In-Reply-To: <20200526093604.11846-2-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af228cdd-6b87-4a99-beac-08d802fc1d6c
x-ms-traffictypediagnostic: BY5PR11MB3991:
x-microsoft-antispam-prvs: <BY5PR11MB3991AD97A483D63F91E9A6A2F08E0@BY5PR11MB3991.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZR1qZS2xvDLpofo0BT8Wd6U24hLeeVt2O5Lh2cgFr5RsPslq2uAhgQOXrDFP7pZTJYnSm2Hz31hN8b+FjXD7mFNcJS6+nSq8zd8OLcoUvTjf6dqRJBNtVyB8p1xelS/LeT7qMq7mO7R1a6vJzvem9t19EakNhlPr0XYpZDlIrXPEp9LOYzy3NBV+ntdC+CdLg1kyrpTwfmyE1cnmoXcEzfc4FXPdD769SyDteHh1DryxXC7cW1lbGktedW+TpwMddLwi8EItQJB2SufhxU0d2qTihKVyKoLEHDN3q0loKKWUFD2pxWxU7xpAjXU4DpHxJE+QW53kZWGfEO2lpQMz6/8IBQVlHsk9tuRXncqIyIk014MhIsknw3lruhuWtWh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(6486002)(86362001)(4744005)(14286002)(8676002)(316002)(2906002)(9686003)(6512007)(54906003)(478600001)(26005)(66446008)(71200400001)(83380400001)(64756008)(66946007)(76116006)(66556008)(6916009)(53546011)(6506007)(66476007)(8936002)(5660300002)(186003)(4326008)(7416002)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZMyCWGbfSI2PhMmllIabsxWuaAodLIsWULrXHLgCDqEjFn3iovKqFtrZ/46oW/jtTKDb5V91FeKXkI2pIGzOp9+5AfYcfKv227iaF9bKvj+hC6FSbrMu1o3qu1iDZ6yVSdLQkdMBnZYOzMhVD/MjIIsicxKe7gbJqJKZDNahkxR6QxlEEYqYupI7llFqUNj7q/k70RQJkoslbsnLt5FNp6EDr0Tu/xciPuhyqx1UdUGoi+oyZoGmJ95T+U0PmOI+pA8AOnzJr4t8WUGQV7WAXZAq0ikJnDQ2JdfnEtzlRtlIZYr6Q7j1MqMCtw+SoQ+ykrJOb1e5ww0Ypfo5MlM8LJFQrrdmbdA5RasGHLrlBq3rRptM9MxiRn9qw1s+pxwEM9KEXIqc78wskQJV+tVkXUP80RTiQs0R8QSnh4Z9RIjt4Qp07ts0Sp4t1OdiWzXv4LoOJlplZBFuuCDKFEsRuw4b0FrTR4aKjx7GcEA/oSY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <107AB70B0512164CAB04DCFA413C114A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af228cdd-6b87-4a99-beac-08d802fc1d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 11:41:52.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AGHmC4EdhSFHRJyacN3NRT1uGk4BQTn5eyg1onQAar6Vtnr3nesLGCpICdvnbi71S4U8R74g4cD5p+KU71ImM3rwmTimFkrAGQwVdFIuAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3991
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tuesday, May 26, 2020 12:35:59 PM EEST Vignesh Raghavendra wrote:
> Drop configuration of Flash size, erase size and page size
> configuration. Flash size is needed only if using AHB decoder (BIT 23 of
> CONFIG_REG) which is not used by the driver.
> Erase size and page size are needed if IP is configured to send WREN
> automatically. But since SPI NOR layer takes care of sending WREN, there
> is no need to configure these fields either.
>=20
> Therefore drop these in preparation to move the driver to spi-mem
> framework where flash geometry is not visible to controller driver.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../mtd/spi-nor/controllers/cadence-quadspi.c | 36 +------------------
>  1 file changed, 1 insertion(+), 35 deletions(-)

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

