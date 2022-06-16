Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B154E931
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jun 2022 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiFPSOV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jun 2022 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiFPSOU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jun 2022 14:14:20 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7D84D681;
        Thu, 16 Jun 2022 11:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRzoGqHa1RatnudG7Ahj3IBrN/dVmzMfoUMBDRwTYHg6Re8waE7UFVsAM3pfomS/1Vq6JV78BcdAB8Gp1nxJF9pNfYTYwEk9QHNjWG6I7E/CpsmaSAiEN/rKiIJ0GJPs/M/sp8S0R6RuMyLor0+zYQpGFUknP3JhJSbmu4C3HIo3iYVExoWj0NLXsWtX/cqsuWS6S9gJjQQmq9r2EhGDTPzvIFXQ+fdN99YOcDhSy+rEbiunqb62sz1v3SQQTYEM1BNQTHXSs0E2LuCDbFNDJ7UfN/Xu/oYrtuVIiXcK4WBWc1DuJevIKi7j+hKnojNDdSyCjsTar1Ggh2MeQ1tu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwp7isa2yEobdbGrn/Xo7F09wiq6EfXJUPlbVvmli3I=;
 b=QSwtiDF957NWGbFzUNbCkzhf4g7qOmAeXHmGiU9Yffv4PIDoWvlLu7gs10gOV0SloVcg1/4PZVFI/MXrlurcvAtPy3fVnuyyD8xRN80gV7DHplU9f0kKpleILfR3MOVrYdMwKRlgyr8jnEbUFBr08bQ2KV+Wryp/y2e3lD9Wyi97bc93nQb8Ie1fvHVkK/0aNBHQJKIdpI70A+/JD8NepK3aNYw1iHEOcT7fu6FoOW+n4x4Sn9C6++ODISRJBx0Aezv6UZx5F5iG0M79+Rxo7GFER8cM8DZ1l+MapS+zsVuOvzIXwzu3CBOJo8Ndkz/RfZeZfzFB/5SCsVmRwI4myw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwp7isa2yEobdbGrn/Xo7F09wiq6EfXJUPlbVvmli3I=;
 b=T8IzERZcTABANlUndCYLsaAAvNh2eLXdWRLRA+/YB5qTZP+nw33Cr3nGq/9v2GQrnHYJCL9iEZBcvMBEmHdPOhpaVkIiIqr68DOaUbf2DwA2d1q+aXmCb7lQXuyfJv05GfDVngCSY+8CLXCYXmJlduJ+aNfeRuYF60lALMjMExE=
Received: from LV2PR21MB3181.namprd21.prod.outlook.com (2603:10b6:408:175::9)
 by PH0PR21MB1957.namprd21.prod.outlook.com (2603:10b6:510:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.6; Thu, 16 Jun
 2022 18:14:17 +0000
Received: from LV2PR21MB3181.namprd21.prod.outlook.com
 ([fe80::1c8b:6d6f:8077:567b]) by LV2PR21MB3181.namprd21.prod.outlook.com
 ([fe80::1c8b:6d6f:8077:567b%4]) with mapi id 15.20.5373.008; Thu, 16 Jun 2022
 18:14:17 +0000
From:   Dmitry Antipov <dmanti@microsoft.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT bindings for Microsoft G6 Touch
 Digitizer
Thread-Topic: [PATCH v4 3/6] Documentation: DT bindings for Microsoft G6 Touch
 Digitizer
Thread-Index: AdiBrKCQFP3cr4VwTgS53R+WbPa+hw==
Date:   Thu, 16 Jun 2022 18:14:17 +0000
Message-ID: <LV2PR21MB3181B3206FE3F4C1940FC4D2DAAC9@LV2PR21MB3181.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=763b0a7a-ffda-4686-953a-a240c56f6009;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-16T18:10:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06cd4ebe-addd-4e5e-056e-08da4fc406d0
x-ms-traffictypediagnostic: PH0PR21MB1957:EE_
x-microsoft-antispam-prvs: <PH0PR21MB1957F6099A3CE619324F039CDAAC9@PH0PR21MB1957.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRpMNN5Xud4L0C00j02bHeQnos20clqUhVTahfCHKYpllnVDNQsCoGYZ96sGPm2WNkOyXNwrbYspohK/gDYu1RuKHDHwoXQNSLr5WSUJw6f5jCbGO+7R61Yo3MGdKKdE3pJ+L30YvPCwhIa5afpHxDaASONV2CfrCvvc7Z/ULJbS50phU4p2hBuWvuVMxeDmeh5UCGuVZTz6GBDyxVEUibZmK80JfndZlPXxFNaQE3pnNgoDoxA9njleIt/Du1f6Td+DpKM+B+VJUPlzSFnBWC/7v2t2RmQgy+afC0lnML5GHeVSEFezt8zsXaoFIoETuJcSBFN1LV/LIApb2/IQXuHy0F/AeysuBr+xDXZCENdgB9vnSCowy4WOfo2YyQoUHeVVee8VcEMTxkyj5PVGWo6An2VgeGhx4eXY4j1ogxMKcov6wrHpdwQAgwdtqrqghS/nMoAglI6GV1R2GfZgkr+fiWvrrYzn/AhPEu2L0ws4i5BLSYHNnQG0Nw3usif7ckqVGO7wQQCBz80RjPLVdOLn8mmR4sypaTY+gA4HFRZMwtWZHBszyG+5+XE6ymub2n+557mftUZfCP/xLU4Mml8mlpprklOhMrmRvjtyw321OIzJUEbZpGo1lu83ZvWaMZlHgzIyCB7w9uOa4ETJI3Tpdp0dT2/1udsW2ynJm3YfWCpogY1tGXX/Kw2Yw6NOu0mXVqEuUN4/5LJp1uKPMLlMtDSPaJkWh+H3QHTgAL0V98DgLS0gXKPk5LBfZd1o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3181.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(47530400004)(451199009)(107886003)(6506007)(7696005)(66556008)(71200400001)(186003)(26005)(76116006)(82950400001)(66476007)(9686003)(82960400001)(66946007)(38100700002)(122000001)(66446008)(54906003)(52536014)(8676002)(4326008)(86362001)(55016003)(38070700005)(10290500003)(8936002)(5660300002)(498600001)(64756008)(8990500004)(316002)(6916009)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5hRVrPnejDkaA1Id2VISyOtgUHNDEMioXrUXWVjf1THqmFVyCQrG6pzDiU15?=
 =?us-ascii?Q?mIRvaTYSr/BpPSUbh8u+fwlQ/pDDwLPaawlNUpiEyn+++CMeoZlu2zzNGHfL?=
 =?us-ascii?Q?IyeQFjgX8Eh59jbRsixM4UY4Trkk2XhDS4TGcbqiP/PXueFNd5zIyeDmlSNx?=
 =?us-ascii?Q?p75eXTTT+OmdQI+b0UMRpTu7p2x5LErEKwL765hNnnQ66YGV1jJOk9QLLplx?=
 =?us-ascii?Q?vvQeaVJYpWx+K7wKMJbk3HDJvdTLNP7sV9cbH8I95R+YtVbCEbv5wgSHpiu3?=
 =?us-ascii?Q?BffYqQgWJZKDeTxuTIqJ3G7dYzBm1/T9YNqy5W+kkTHbsAxB4vmZ6YFGDN+z?=
 =?us-ascii?Q?Y7Cr0JpIudrD8c/9GtsHcW+0OT4g3GS+ljywWXlweO34sFCBxI/K3zGZgijz?=
 =?us-ascii?Q?BVjMrpv0ZR8u2mS/q6iksN8BhitpL8pSqRmakwbqNYtcL3/ASyiFbIqYQKsI?=
 =?us-ascii?Q?q2IbgQ5csdJecdQoAYNxdDlaa6JKzD/zqmpLd81d7l23NAX7Skzh9SdU6sn5?=
 =?us-ascii?Q?iDaUUDyWDbTE2It8rosvqcyt7+huqmKQWAsIgfZ+9R+LoH4IdPoUzUt5ZM4M?=
 =?us-ascii?Q?NRy2NSAFxI1CijhilUhO0Lt9mZrqpfDssmyC9MA7A9RzAEB6QvR3XP+QM7at?=
 =?us-ascii?Q?aw7dT2QELCDOfQ2xx2023bIhjUzjoU0+9qccqY9MyJ0p7ASwKQKYhbBVignf?=
 =?us-ascii?Q?Un64iWHH1GXRIVRp4l/0WNurzRMupNyOqVU+MiyhkexCuYmPuk7IervOqnsn?=
 =?us-ascii?Q?6iYSyqLoZ7gXWIcwGlhMgHgWiLQjhcfAvQcxkZ8Jfty61XkHRO0AEn7uWGVK?=
 =?us-ascii?Q?P9JSEtsbUm/qftHZxGFzBbCg0F2rF4M0SkFFIyQ91LsUX8hSrr3JT98qyHnX?=
 =?us-ascii?Q?Ym3tu2uctSjzkoS/TGvATeOl6EkmV1mrQBZHk4LkgLA3+l6Q08Bhh2YWp0yu?=
 =?us-ascii?Q?sQoYCm8fQ6U4W/StN9RqK0km/TT5KjUabv3eeVo7XQZtjrb/2ZEuy8nGVqcV?=
 =?us-ascii?Q?XVGlc3thgffkSREiqOGfr/Y5HRDbGPfNQnvUIAF+1WSI49xmIege7MWL4CfU?=
 =?us-ascii?Q?3cDbY6+4dCL+gPVmkCTnIuojx5Qcbp1XQxLEbsbReczqCS8IJ0OT+OO1gJJH?=
 =?us-ascii?Q?kd73r3BIu1KfD3hh6EVlxHva/S5FbkAKK16bUumVP+DFeD7G+il5EhAmQkgU?=
 =?us-ascii?Q?X0oJ9a3uXRYV0h2s+AEiAqio0Ldn8RfpdfOqUNf3/xJSX+UZudMPwz9bBJ32?=
 =?us-ascii?Q?tip3Lz8HfGsXDTRXaHzqc11ZgYEyzqy0CNufMS3SugGY6IFvh+sKSF5QmRGG?=
 =?us-ascii?Q?m4TG8+BbPVCCBkVVG8CT3DjWsk26Xq3fzWS4dD+Tym0n7Clatd67Z6dLScKZ?=
 =?us-ascii?Q?JV3EMDuOJD9lxs44eqLzHWaOWV2+L8Nvd6AXi81KJjaB+/E1Avr6G5WtwonB?=
 =?us-ascii?Q?8C7kdFMT4wV2VME8k+eS8mga9sofkKD+BbDgUGRtntjz502Q4CaOcYbuEsTZ?=
 =?us-ascii?Q?XI3JvrJSs5+ijBaQtnnWcdsAGGeek5OLYMwzDAMQBXF6IIrdZlV4Ieb1ZvMN?=
 =?us-ascii?Q?UINPeBmqzdjSbFr/dQhRP1ptQfrJIA9c4F1VrZCdWbwug/QwgP4sqwz13Srn?=
 =?us-ascii?Q?ZU0sEYcJm4IXfy5Er2MssFWcW2nJbTisiVsb3/L46hw9pDgYQTc6AQUb5B9G?=
 =?us-ascii?Q?I1RF7W3Y10GryvFyHcSIJj0bnJSYCE0IsMWgn8eUH45oWq2TINZdSjEWuxR+?=
 =?us-ascii?Q?DTQNApp3LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3181.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cd4ebe-addd-4e5e-056e-08da4fc406d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 18:14:17.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+8I0bbMwpm0Qkf7D3Tj0aKSMaE0miN+Sdqlb33yAkYkvct+p5sKhWeMa56FiQcIuJN0gY5U4qz/AcEQ3qzMSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1957
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 25, 2022 at 06:59AM, Rob Herring wrote:
>=20
> On Thu, Feb 24, 2022 at 04:59:33PM -0800, Dmitry Antipov wrote:
> > From: Dmitry Antipov <dmanti@microsoft.com>
>=20
> Please follow the conventions of the subsystem for the subject:
>=20
> dt-bindings: input: ...

Will do, thank you.

>=20
> >
> > Documentation describes the required and optional properties for=20
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that=20
> > supports HID over SPI Protocol 1.0 specification.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > ---
> >  .../input/microsoft,g6-touch-digitizer.yaml   | 105 ++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer
> > .y
> > aml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitiz
> > er
> > .yaml
> > b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitiz
> > er
> > .yaml
> > new file mode 100644
> > index 000000000000..e516717527e9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/microsoft,g6-touch-dig
> > +++ it
> > +++ izer.yaml
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: microsoft,g6-touch-digitizer
> > +      - items:
> > +        - const: microsoft,g6-touch-digitizer
> > +        - const: hid-over-spi
>=20
> Why are both cases needed?
>=20
> Assuming you keep the 2nd case, you will need a custom 'select' to=20
> avoid applying this schema to another binding using 'hid-over-spi':
>=20
> select:
>   properties:
>     compatible:
>       contains:
> 	const: microsoft,g6-touch-digitizer
>=20
>   required:
>     - compatible
>=20

We decided to make the driver compatible with "microsoft,g6-touch-digitizer=
" as
well as "hid-over-spi", so the next revision of the patch will list
"microsoft,g6-touch-digitizer" as the only compatible value.

>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO specifier for the digitizer's reset pin (active low). The l=
ine must
> > +      be flagged with GPIO_ACTIVE_LOW.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Regulator for the VDD supply voltage.
> > +
> > +  input-report-header-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      This property and the rest are described in HID Over SPI=20
> > + Protocol Spec 1.0
>=20
> Each property needs a description and a more specific spec location.
>=20
> No constraints on the values? 0 - 2^32 is valid?
>=20

Thank you. Will provide description for each property and will specify the =
bit
length of each address if outlined by the spec.

> > +
> > +  input-report-body-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  output-report-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  read-opcode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  write-opcode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  hid-over-spi-flags:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
>=20
> > +  post-power-on-delay-ms:
> > +    description:
> > +      Optional time in ms required by the device after enabling its re=
gulators
> > +      or powering it on, before it is ready for communication.
> > +
> > +  minimal-reset-delay-ms:
> > +    description:
> > +      Optional minimum amount of time in ms that device needs to be=20
> > + in
> reset
> > +      state for the reset to take effect.
>=20
> These should be implied by the compatible string.

If I'm understanding you correctly here, you are asking for the driver to h=
ave
the heuristics to apply specific delays based on which compatible string is
published in the device tree. However, the same touch digitizer but on diff=
erent
boards may have different delay requirements based on the voltage regulator=
 used
or line capacitance. Therefore, I would argue it is better to have this del=
ay
information provided by the device tree.

>=20
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reset-gpios
>=20
> It's not allowed to have reset under h/w control?

No, the spec requires a discrete reset line.

>=20
> > +  - vdd-supply
> > +  - input-report-header-address
> > +  - input-report-body-address
> > +  - output-report-address
> > +  - read-opcode
> > +  - write-opcode
> > +  - hid-over-spi-flags
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi-hid-dev0 {
>=20
> hid@0
>=20
> And you'll need to define a spi bus.

Thank you, will address in the next patch.

>=20
> > +      compatible =3D "microsoft,g6-touch-digitizer", "hid-over-spi";
> > +      reg =3D <0>;
> > +      interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +      reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +      vdd-supply =3D <&pm8350c_l3>;
> > +      pinctrl-names =3D "default";
> > +      pinctrl-0 =3D <&ts_d6_reset_assert &ts_d6_int_bias>;
> > +      input-report-header-address =3D <0x1000>;
> > +      input-report-body-address =3D <0x1004>;
> > +      output-report-address =3D <0x2000>;
> > +      read-opcode =3D <0x0b>;
> > +      write-opcode =3D <0x02>;
> > +      hid-over-spi-flags =3D <0x00>;
> > +      post-power-on-delay-ms =3D <5>;
> > +      minimal-reset-delay-ms =3D <5>;
> > +    };
> > --
> > 2.25.1
> >
> >
