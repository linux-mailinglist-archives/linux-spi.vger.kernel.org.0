Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8207A0390
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjINMRS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjINMRR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 08:17:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540731BE8;
        Thu, 14 Sep 2023 05:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4KY3+29hu/rFyIrNEIFjREQw/X7tloCA0ZDoA0/yeAStklBUmDHgKhO9kwbDB5C2nwZGtwfNv5Sn0hqheK/kqoHgpub1Ix85JXH+dSvMs9r0mf2vIN091QTI1Yg2kKJ+GYFeA1KSVlHdPFftBRaFK6EQrGBXcRZV9xm2AGklLZZzegbvdR3XsJGXywx4+EzltCLXUUupgHxw0SOTMsRq9OwO7lml1VFmPlNIyDaNo4vKxHqc0a4exJ8YVfbxLR4SJ30dnlukq2mJSLfM20PxX5mGN+08jdTu+Ey2M0bRQB0abGeKL6AB8FtirkiHwNqBup6ngmYxVDyKPlrCVRf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iika/iZlkOoyiIlTHMhLk4jE+t4Eum+52RhcK2fMRk8=;
 b=IpsqcEqFWXQRpMSrVRqL0nT3GSGMr94C7HrX8qtRU4ewIY4zt/esZOuxv2aGozQaY+4iYlePFp/sdBtTsyz0f0zgFA689IIY+hZ+rdBiRzCIpZJMBqcz0SinZx2dnTdBIcSc9+NAKNg4d425wxUdMhO2gp/9M1RHIUvGkqoTzAm4vnJllfVcj5p5jujD4tQ7gkFynSK67th9zFowRIeIxUNZ3Y4ZgJ53qXkBHDVTvdDQdbUKIaLHJyRAIxiHibUAImJ0xsG8dir698uR4Ry3qedfEHFlu972+xBGpdTerwSYEMaeY5jTaxgOSHx46q5wOjw4TykAXcy4LtLoKn+XaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iika/iZlkOoyiIlTHMhLk4jE+t4Eum+52RhcK2fMRk8=;
 b=EuSMhXpq4tA/KnjkGu39EaA4jqFAxpUzBcHGK5KRzGQMO8RaCzgK8qTpZ0XQAFFQpl0ko/uuEifSKBO3HFpGNDaANV1zbeZ7uUUN7gx5jDzb+QUmzoLLYtqXIEYFjvQ9SA5qXIhlpBLw8RO0rHHtjlX3KkROqPOFgGl0vVn07KE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5600.jpnprd01.prod.outlook.com (2603:1096:400:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 12:17:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.021; Thu, 14 Sep 2023
 12:17:08 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Walle <michael@walle.cc>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Thread-Topic: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Thread-Index: AQHZ21J3se5Zb26g9EyYNYpYnGOcfLAC8SaAgAAAdzCAFx0SAIAAB1IAgAAG7YCAAAE7gIAAAjsAgAADP4CAAAIPYIAABtiAgAAZoYCAAAzWMA==
Date:   Thu, 14 Sep 2023 12:17:08 +0000
Message-ID: <OS0PR01MB5922A4F16DE8923373AA5DD886F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
 <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
 <20230914105937.4af00bf2@xps-13>
 <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
 <20230914111200.6e6832ca@xps-13>
 <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
 <OS0PR01MB5922B4BF11D1954DFBE2976F86F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUA23VxkK-8CebyqiF=Oe81QZgpEmWmMrMGVd_+BXfsLA@mail.gmail.com>
 <737c6865703b8e294601d86a911691da@walle.cc>
In-Reply-To: <737c6865703b8e294601d86a911691da@walle.cc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5600:EE_
x-ms-office365-filtering-correlation-id: c52acf47-182f-4cbd-cfaf-08dbb51c8432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWEIrq99vj5cigXo9mWaL+cp6SqFW/j4s4na5ks2TcGnsk1eGnL49TKq5aKT7GQXrt4ZP3zb1E2ZNqv60ptNAjukulh7I7FGy21XLkLJAs4iklE3gXR+NKYoPca5FuvL4jy43O9GzEofIwIfJgJ2CNbHfjBZifBIOdjgdVQHtazUfEPGrdd5OVlcdjFKz2uNX208ICv9BKtcQoIhjyETI8Nb1wo29VUJzWCswPu1pMQKl4qJHv2KlmjWSDI42Lpuo6T5Eyk1QXWI2gPXqiBixyKh9+OmO09OAXwr6KiYPuxZU7+GuU+T/psc3LjHRLA21luh/fykLGZPvlUOf79DFh9X4tXVQ2v5tk51gW6Kb3VQgLnyPRxAq22XtwOVhcR/GYUZzRkVrZyeoZosj4npln98nzGjSs8FGnf1BQLz7kp0Ae4Js5TmpMNRAhJ1nlAfe9flYrthA0By4TJoITCyTLj/vwww54/qfcw2OleZcSE3/E5w+TfGZWCdF6HyMd0wcFTD3XbQWzyhjVbWV0BA4+hb2DzVhVzzaHcCmOVYeuIuURPfsl+TqvYxdyRZUg1+vHvuVQKGIPDKiZ41VvwEQQtNM3qHyJ9bsSnJXOjhe4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(186009)(451199024)(1800799009)(26005)(9686003)(41300700001)(71200400001)(83380400001)(478600001)(966005)(110136005)(54906003)(64756008)(66556008)(8936002)(8676002)(66446008)(66476007)(316002)(66946007)(5660300002)(52536014)(4326008)(2906002)(86362001)(7416002)(38100700002)(38070700005)(122000001)(76116006)(7696005)(6506007)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6aUfpXLoQFMdqO8WlqhULxelaGda/bgBpH9X8MIDiLBY33TzjQUmcCvZIjMK?=
 =?us-ascii?Q?mAU3/1he/fm/6Ouc7JrKeSRH24O/5AXTF42W+uuubG4NIhangXrBhc6P8YYy?=
 =?us-ascii?Q?hJJ/AVLOjrwE17hpspIxZ0pqydLb0srsNMZGs6g8HPgfDktEWTSjyHdumy6o?=
 =?us-ascii?Q?6DdpHoHBmzgMvK1K6prq07OpC+nVP0Hd4Oyzs7UTc2py5asjbWH8os9L0gPd?=
 =?us-ascii?Q?cDTiacGOkXnUxpK00VVMA8IGc4VaDypU9hgTGZ4ETgvLdlUo47TlObVUPVP9?=
 =?us-ascii?Q?bXf7Q4qRV0hPL79dCaPNW9pl9Qq/QtxJZh1EK1PjepwKVyLvUbCPxmyt0G3i?=
 =?us-ascii?Q?b7wDpZYApWSian22wpxfLt7oyfIYpVAY4XVzqlMb5GUmVeVo7q5LO1HMncX8?=
 =?us-ascii?Q?FPidf2XXRZryJd1Xy/MmFnhZ9MmnZ5nSzi5V1/GShI7YyTFjiumes3ApsQ89?=
 =?us-ascii?Q?yQ+TPffmkJ7x0wWGOFhuF8+c4OInYANWvQRLXoIBBbXLZB8LdGTX1iPx935W?=
 =?us-ascii?Q?m/ssP1X9hIFYHqPnvF2xmHCF4AUTzsI0U5qyOOdQ7PPC9yDCSVdpilTyKY/9?=
 =?us-ascii?Q?7qJiIuHjmOXelV0fVDWjJLNPaNzbBz7V45rN4Q54DL8uODhTMKO/2WozVs/W?=
 =?us-ascii?Q?h83P0+xMkR4K4tYBzVvkAuu0Taq0kdVp5PwQrqvlug3wxSDeOi3+4WH1Ckas?=
 =?us-ascii?Q?53eGzPpgapG49Xjacru8ikQBCZNrJRcFXBpoje3pn9+nxNsl2dKBIXPRctgv?=
 =?us-ascii?Q?Hl8TZz5yv7gxmZm+md9DfpECEtUejCA1BeNmMIpiz5uIGfUvICBKwN31ArvX?=
 =?us-ascii?Q?/aFr5KGAHa6K553t18IYGoh6VQeLz0OexmbiULUGnCF2o4mqUmDBu1FRJm9s?=
 =?us-ascii?Q?fAiLePDyqXsTRVH+bPBb9kDxf4theNujwxr/zEfvYSUh9aXcpwYpDPqIFrBx?=
 =?us-ascii?Q?bZnHtOakm/HQWCLNxYGng/jWbpNttI3xTq0jo4UxqrVI6u8hVfwhKFWxO1Wg?=
 =?us-ascii?Q?Z9JV61/nn+9YdgGQPnm8Hzrm7KUn94anQdRhGf8NInBPInbAX+Qsr/2wIb5e?=
 =?us-ascii?Q?eDz394Gx14m9eZ9mfQIXDRfaMzYBat3Nymqz76PsnqlqQ8Atr66oeAur7Gzy?=
 =?us-ascii?Q?WFUE16SJbTFZ01m/S/o4ZIA6DYib+scGuUQKOlnHuJGin2OIv/Tlkm4yqQDq?=
 =?us-ascii?Q?TswrHCXR6bB4VzHQWFhlQiejVxL9VKc0+MfaflbgX5oU/gPTNO29TI0ZF9Pc?=
 =?us-ascii?Q?oS0C/Ae2SBcLnPEZKboiEmApsUgHzbOYROzSt4aVe868Bl0xcRpkgHvyC51o?=
 =?us-ascii?Q?ia7DTLLc/Nqg0JHQ/BlYFUcVstS3gSF4cLOZpw0vscebeqoBrE0oEuJVk+Uy?=
 =?us-ascii?Q?MZiEoFbSMgGAAfOBn7JZVXyeb7vHFFXcQHWeciPoDpyMUY0MRYrBDIQ4RErx?=
 =?us-ascii?Q?XKReOE43D4iHZR3kpLd2QZLyqecRbGZ1qgvfVRt1q2lPaFTutM+uVM2izq35?=
 =?us-ascii?Q?N5PZGnMBekFQDj+rIFlnIlepnXtmV8XL4ycYRYJBpaqAo0qcSxBD96EZ2j8N?=
 =?us-ascii?Q?117W0AyQJzsMlgCaaSGYG7QsrZv6V5foP87fRX2X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52acf47-182f-4cbd-cfaf-08dbb51c8432
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 12:17:08.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPpB5X3n0FuQuo6w3kt+Mno4a+MEKVEVqauG6m8eKg0oHbYMHliG0V11l56+rbSEkTWAX7HnsfJIeiZyG1ulL4jfUED7KAjXjrpG/5UKuQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5600
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Michael Walle,

> Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash
> type
>=20
> Hi,
>=20
> >> > I'm not sure we can do that, as this code is part of the hardware
> >> > initialization during probing.
> >> > Biju: is this needed that early, or can it be done later, after the
> >> > connected device has been identified?
> >>
> >> I need to check that.
> >>
> >> You mean patch drivers/spi/spi-rpc-if.c to identify the flash type
> >> from sfdp info and pass as a parameter to rpcif_hw_init??
> >
> > Something like that.
> >
> > That configuration should be saved somewhere, as rpcif_hw_init() is
> > also called from rpcif_resume(), and when recovering from an error in
> > rpcif_manual_xfer().
>=20
> I'm not sure I follow everything here, but apparently you want to set the
> mode of the I/O pins of the controller, right? Shouldn't that depend on t=
he
> spi-mem mode, i.e. the buswidth? Certainly not on the type of flash which
> is connected to the spi controller.


How do you handle the IO states sections mentioned in the HW manual[1] and =
[2]?=20

Without this setting flash detection/ read/write failing with tx in 4-bit m=
ode.

 [1] Figure 20: QUAD INPUT/OUTPUT FAST READ - EBh/ECh
 https://media-www.micron.com/-/media/client/global/documents/products/data=
-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qlks_u_512_aba_0.pdf?rev=
=3D3e5b2a574f7b4790b6e58dacf4c889b2

 [2] section 8.14

https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=3D1608586

Cheers,
Biju


> What about dual mode?
>=20
> -michael
