Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6338200808
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgFSLrO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 07:47:14 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59958 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbgFSLrL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 07:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592567230; x=1624103230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FdXIsNa4by8yUsM1/IoyyWruXeZ88glA39KvNKhaFns=;
  b=nagjPLfO5khsWEYU0sAMtSo6CjY8LzmjdnCXAWya2JNDsiSPcIPMesxP
   X4on+KN50GL9rfEZ8JyaV8cI49/RdwYJNYFwWuWtXZZoJlNFNBUFWvSMY
   TKlLryeeWk/j0h+AWB0GTJLD++NQQ4DCS4UWTKfn1oDJW783M2wr4DsSG
   u/aCRuIp4PwkWJNmT6yGVlLnCEfLzbt2CD4XwqyEaiuPmQPmV/r81oh8a
   oKDyhPMNxUQbkMHNdva2f+xh2s9n+gUUiUmDMRdlsHxDZsXSdPGIncx7i
   lPlVvqDQUsLiXC9f554kuRyksSt0HNIopVFEN7/V0k0PoUb7jpzgfJqij
   A==;
IronPort-SDR: W3ixBXmNdCcrP5dsHkH1tUedMpxay8uQNZxiihezzVHJTLktNMvYzLQXv0Jh9yP8Xgind5MdYI
 JbLCocyofDxmLpr2YWwTTbK5RpTgst7WQie3S2/5inSlLAXeK3I/U6AywUy6OfEFXcT4aS6r3E
 W83SntmXef34QD4aiUbGMo8u3MMtIqWk96ClSrMc+76BGvpNmyzUWlS4CNWh6tFfF5m8+eaBdk
 DgV2G0m3WKQM14r3k1G+3p0d2fN1kWRhzJJoH3MRUmHxo5vbW0ectvmx87okirNa+UBjfo6You
 GNw=
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="84300035"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2020 04:47:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 04:47:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 19 Jun 2020 04:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZHUTpobFOdU4PPe1GAPJXUMLGQYW+in92BV/RAlEG4f42yinDE2ZNZHus48JGEgjXfbBRiN8preoiq07+lFXOfR1Ebchiy0fA3zpAIdaBsWzvgAHLzSE1FmNSU6rjiw4XR7tsMMfYRa3LjVgxIJtPtYD1DRkC9e7Y8AsbI4PuJBikUdo1YRndlpCYguBskLIL5TTMjYbyj/YBEjx0cqkocbuFaEcEHorMAsH+mjLMsI3w2Dk93XFNM/XU/qmUbM1aumoKfg2H2QRN3MTOpBrA/QvwovAvRjWLu1c839xwUufsB6IaZsLPKJ+8TfraOdFJP8dkKbrBSoL/TpNyyHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdXIsNa4by8yUsM1/IoyyWruXeZ88glA39KvNKhaFns=;
 b=iYxvffAmHUtP5NKDcqse+3YXC4qc05SqYzROXK+AhiXRI9APZLFKj5RNKPIcpN4/i15fieeJTQrEzRq6u0Z9E6Xsm3uhqj8G2Qz66ippw+4IevES1Ur44EOw9dDY2dNyz0jV+FRnZLMSfK4EjrU/Evu3tEKTHsJs5sYMclmBk8C4RxhwY8nvZ0UkoHewGRD7Jr0YRB7sCRVsF6Qn+Iv44REATUErUfFapUwsR05+nyleon4ZN2i+KO/7wkb/XHF7svyDOCoVaspA3rpvy8epexGk3zVWxqInq17/1k9OmLKyu52uuC194N2tnd/iUGrch1q7tzrDd85Tj2fjmBcRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdXIsNa4by8yUsM1/IoyyWruXeZ88glA39KvNKhaFns=;
 b=CI4Z7C0vVr3EMRosn+FXQhkuQ9gH/uF80h5yK4TxvfGCbSBxPC2Zp4GoDHvo8Bh2keWiloM73DzSxZxOMKu6VlVq1TDoDjZ1Kt+BrhUXSBDFw+EXQkYOkUL9OTBETAGebnUsXq4jN33DHh33ZWznFpMuESNqcJ57qwhqPQ6Jjl8=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB2966.namprd11.prod.outlook.com (2603:10b6:a03:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Fri, 19 Jun
 2020 11:47:08 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 11:47:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <vigneshr@ti.com>
CC:     <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [RESEND PATCH v3 0/8] mtd: spi-nor: Move cadence-qaudspi to
 spi-mem framework
Thread-Topic: [RESEND PATCH v3 0/8] mtd: spi-nor: Move cadence-qaudspi to
 spi-mem framework
Thread-Index: AQHWRi9bRsHSVVCOu0SkX6Y85WgKZw==
Date:   Fri, 19 Jun 2020 11:47:08 +0000
Message-ID: <0007c019-1ecf-1913-56a7-facffe345b1f@microchip.com>
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200619105701.GD5396@sirena.org.uk>
In-Reply-To: <20200619105701.GD5396@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.120.239.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1fe5b9e-8f6b-404f-b05e-08d814467f30
x-ms-traffictypediagnostic: BYAPR11MB2966:
x-microsoft-antispam-prvs: <BYAPR11MB296615DC7DFC4717C69256F7F0980@BYAPR11MB2966.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQBlWl1gOkZd9AY7kfPYmfuhTg9k3RE8H6MD4RJYxRQQh+5AKMUuSvlozvCf/0W9ON/RNmjCv4zAnJ6K1yQa8VUNTq0uIaEMKGq6DAT0LURYgvuDVB4bYALarNc4CsVRGqfkunUkmgjGtr9F3Qa5OyJZt8mw3+3YTD/crL8DHblnDuG4ZvsB0QZcLyk6WS+wplsCvutIXK0t+CPBRhSoMZhDaL+OelgRqFh8vZmD7EsLLu2gx14VW2EPUbqNJlzua6i/lw4kbfsCvky2eYOIT6QvVokgqPXwplSbYwyj0Y647sXLDO3FmAePQJCb4Tpj4GiJa77e7mSfJn/ZtYIShNAZ+zG5nK/tjfLC/bruFxF1vzsUePPPPp76nYSiVH3H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(376002)(346002)(396003)(366004)(6512007)(6486002)(36756003)(4744005)(478600001)(64756008)(4326008)(66556008)(66476007)(5660300002)(71200400001)(86362001)(110136005)(66946007)(91956017)(66446008)(54906003)(76116006)(31686004)(31696002)(316002)(26005)(53546011)(8936002)(8676002)(7416002)(6506007)(2616005)(2906002)(186003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rx3QrdgKrEc9NVClEyKAtOSV8Yn6iPB7IET30u6vxGgLbJ+dan+Mv4GMNtVXZINK/RXmCs+TH8vZxZZv/E1E7ZXfcjehSom4cYglCppWO6d1C6AqspDgcxbJaI55Dky7765XIejAczXyp7JlqzCT9n17CFZ9YJY6Xkyug8y7HnNvA3lgAYwoqeCHygKdYYJ2qblhR+FVkfvPJO2nmAb1yMuVwJaq23jcJJVL1D/BKrfPqh/gBbysLoWSHOyF48jcNDOO1CV3EWltTLN/S2nFbUg+o71PFMVm9g8u5sEEd0uInJ2LWsROlvDTzyk5CULYvnu/b7+Z+GdTSU67RFRrhaBWTFlgu1mM9KkP4ghtvgra4vVAmNgSYIc5cYVg2h07SHKEKCDWFQwoUrcK4C0tFwhtAzpb7ewvJmmlb/rNK7BLWqUDnq/mfR6AdAC6SPYiUp7qAipMa41yp29JNvRq/M44FEzbLMmbv3NlRBIn0LI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3023B7461FBE2F4D88F6002791B3FD9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fe5b9e-8f6b-404f-b05e-08d814467f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 11:47:08.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNwM3+9mQA+goGeqlCYuz0mwCvrYbjOycti8EXl3/Ujuy9Z33rCwgKParMgjpT+/Cv5QZ0mX//MzyDSrnj8afHtzuAzmbWJPfL9ZvSAnNlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2966
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/19/20 1:57 PM, Mark Brown wrote:
>> This series is a subset of "[PATCH v12 0/4] spi: cadence-quadspi: Add
>> support for the Cadence QSPI controller" by Ramuthevar,Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar@linux.intel.com> that intended to move
>> cadence-quadspi driver to spi-mem framework
> Are people OK with me applying this to the SPI tree?

There's a small conflict on 8/8 when applying on top of v5.8-rc1. With
that addressed:

Acked-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Would you please provide an immutable tag on top of v5.8-rc1 so that I
can merge back in spi-nor/next?

Cheers,
ta
