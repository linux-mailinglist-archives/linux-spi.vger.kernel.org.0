Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944DE1E699A
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391371AbgE1Sma (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 14:42:30 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:49085 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbgE1Sm3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 14:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590691348; x=1622227348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B9JMsZylPEFohmiIJJMRjMEjwsnjlbXsALYniIgt93g=;
  b=R7yF6s3WoNDb+WudlIVa2cBRSgOV/OZHM8EZAFD6EGNXLTlwg4UhjTIw
   HED2vEfO+AurSN94T9uZDf8cX5OuUgtkxU2cNEvpy8XwfxelZVKNtLS0e
   LO8pfKBxWyO6L7bRlrgU9KzqS3jsS6QipigFWqRNe2DXSWbz42Yw0IGEq
   6VEc3FIh1BwEf+xJLhNKXxwraIK+XJtsPCYjrtVNv5ErF3alo9uIdcMEC
   lAuQiqoqnyn98vjKB5puocUKRZiJVd5sFmzeAuL/NbLppKyt5Tb7Jot5h
   Xm6gl2c/kgUY8ElfpW+RsPVfvJ4dF4uht53ok2K5HYf8FUIv7uBbgIkVr
   Q==;
IronPort-SDR: YvKIDzg349lYQmGfPcdNGotYYf7W+fk+CV3uoToRpw2OwNqHoZDCRjBdNBSMZtz5Y0hHR++ayL
 CJNbjJLPtchDKQcIWtGIpzCPIAfJ4kvDZysZJagYdcuoWIUjywbE1SWoJfg5BlNPsA5cwt//ab
 An71C3JwHkdulkwgJhimfklWZzgSr8Yo2qwY7aGJ/d62ltw2fMq02rC4ehRbU8WXcGYK7qKKzt
 XeT7z7pPaLeLCAwozRSMD8lrJ97/ckbe2BI+vprLxQ4uQE4LKsAHQEy9U6WmgLupfrr2Dj8HjF
 7m0=
X-IronPort-AV: E=Sophos;i="5.73,445,1583218800"; 
   d="scan'208";a="13825038"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2020 11:42:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 May 2020 11:42:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 28 May 2020 11:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJeHo8QrG9WOjchgGAGYxITDmmt5dDgshTCSGwz1OiWwAHiFJ8atqNaK6HOj0IAG3uw4UGclOihOsioBqJG6bSHgOeb8H4tTceqWsm3B4FfPtIif9H9KbLQAuTePkhbX2hKY931zoamVYE/PfDtlgwP5cKmTJNWLaGvo131SGAWIm8rz3X3MpFbza21DcnTo5SmXn5t1Xs6bMjbZA/djJ41eQONlaZTEkwhcYiM8fMbsXFPeG4ppduNFW5xGvJ5bojh7HfSGbB4T+xBU8iUYx6ZrWilEeENoMGeumk/sfQtUUN0COm+rFs1MlLCN1T5Ibw7h2ZAIMc1++zP49maa8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umFAE7JILaoaA8H04SvL0ZYUS1l3T73adxcY3iQzq44=;
 b=ASFKguiMYO0N09RN6815nmhJuwNG1Vryz5/WHCf1fBwDGXoD0QW9UdPUV6WwlnmTI46R9Yg0FTHBPkbNh+OT5O04cvWlXUM8Izkf9DUwoE0zcyZWugRZOK61l0ZdcUARJnDQlnsyhUmrUaD9eic287++c4P4tj4Us3CSeXRdBMSmFFPbwLSRCVaPDkVRMktYdfq2L3eoR5MaUrDqXM5nlJH7ko2ngaNSUMkQc675rSgNh/7ZhpdvN7Nv9iBfCumN+kYucMYyw0PEJbxFlQDvIkHb7VVJRSMnqhN3ich13opsun8HpL0g3NClATDJzeKT52WWsM023uMqcmSmsNyXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umFAE7JILaoaA8H04SvL0ZYUS1l3T73adxcY3iQzq44=;
 b=lTKipPnGi7CGWWD7B2uygjfPc/PQc7zXLXV1jKzrrFWwFyc/lw4m1lcj2565teXAqT2Ey8uz342dXSkyp3KMN2ykpFARTv/raVIIQAvpuw8K3eyQRP/dJP/7sRe9zGpGVIJe4luDzQwkLm33a3h2Zj8gqelTAfJUIpRS5ZBAu4o=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4498.namprd11.prod.outlook.com (2603:10b6:a03:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 18:42:25 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 18:42:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>
CC:     <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 3/6] mtd: spi-nor: cadence-quadspi: Don't initialize
 rx_dma_complete on failure
Thread-Topic: [PATCH v2 3/6] mtd: spi-nor: cadence-quadspi: Don't initialize
 rx_dma_complete on failure
Thread-Index: AQHWM0FckzWSr68KdEWbg3txzf1/QKi92PEA
Date:   Thu, 28 May 2020 18:42:25 +0000
Message-ID: <11478827.xOqK0cN8QE@192.168.0.120>
References: <20200526093604.11846-1-vigneshr@ti.com>
 <20200526093604.11846-4-vigneshr@ti.com>
In-Reply-To: <20200526093604.11846-4-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 752cf617-8d02-41c8-dc53-08d80336dde3
x-ms-traffictypediagnostic: BY5PR11MB4498:
x-microsoft-antispam-prvs: <BY5PR11MB44988AB094D2ED7A985143C6F08E0@BY5PR11MB4498.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfDP18ANdXoMI3Df3NGcllUXrnfCh+XB1WNZfY98U4IPZwtNSeiYvZoIZ6LM58fdpSnEjOzy4ihK1R/ff7Wp/ZTLYzT3gkcaACn0vRZ8QscQVvxc6K3uO6C9JeiPSkXxhY2hCFTMQg4kpnO+B1mrK1cQt83l94/xfZA/8+QhhQ/DMgfOdV5nfv5QYvs1DBu9BYQNsiNuFLYMAe5ladOlkAI/FjQq/PSgMU7ka/sdpRUtCLI3S3XytzWaYbhT+X2PabLZEb8Z+18vl6tA6Ofbl3g5X66jlooOyB11uRFAuSBQGqv9tXMxFTpZs00QEq7f7Ty8kz7KYqGd+uAjRN9rDJGMECoCHEA3E79POqX0tI7Z4ATrnLJohrD31afxBVks
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(76116006)(91956017)(66946007)(5660300002)(66556008)(8936002)(316002)(7416002)(66476007)(71200400001)(54906003)(2906002)(4326008)(9686003)(6916009)(6512007)(186003)(14286002)(6486002)(86362001)(8676002)(26005)(478600001)(6506007)(66446008)(53546011)(64756008)(4744005)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SQMs3uNW+g8wKO3/L7Zel3FIewN7LQhbfjJNaspM6pv2mY3QkGOD0FVDLBX6bp509g7RZLaS6jEzauFu3PEyOB2/jn6PDOa69e2H2Q+W7RGzbMQSuts/S59WYc2qJ3fdiWcUzXyyJ8KlJIvkbQlYmVbyvKJWETJRnj1S3yEJ7tJWAzDjPG2k5+Pxch3m2UlZlcKrwmgb/ciTr9hS94l43Fr3bOfY0u5d1LsquTzg1aW11MsJKT89XyfkWpsgyy7BAFjC/zFzkt+z/8U3IevTFIcu9QiEpCPU/LYaUXWOuoHx9rooKHlMTx1yDad14bBhGFN1IYzUhdgbH5Lq1sZWC+94gbg11o7qCoiGqEksOKFB9krK/Za9GM0akgXhSZRrQsnQ9r1PHG9Ce+O/FQ/kPsgN4Nm1lhVpGGs14ZGKSW1hmGujVhyUZ8zZFNot1lSN+u9bJAoEXhIW03wqytRRODy2L6PKLWGg7A9aLAgJkYw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA10AF2404108E4AB9B5ED3DF17AF8ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 752cf617-8d02-41c8-dc53-08d80336dde3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 18:42:25.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lceioGQiIpsGo6YV+wSAj+/NFaRDFHfKRfoPjD6Z5f+O7jveY5yKI83g7eJDcRoTLUIRBpDlSiLiB2wTmSQSzOkgefHoovV3c3J+DvwsAwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4498
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tuesday, May 26, 2020 12:36:01 PM EEST Vignesh Raghavendra wrote:
> If driver fails to acquire DMA channel then don't initialize
> rx_dma_complete struct as it won't be used.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/controllers/cadence-quadspi.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

