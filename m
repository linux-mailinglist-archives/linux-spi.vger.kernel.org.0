Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB29A4C3B0C
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 02:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiBYBfR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 20:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiBYBfQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:35:16 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC56B2804CF;
        Thu, 24 Feb 2022 17:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVsyDWp8Ll6EvO0/ZDq9UvzPJfoHmqsT1xj9szqMVgFZKtY1Yx1OruQzmoEpt6f+2Dhxp/HePFOtizzXdyGsjBUEXk8Kcd80JRRQ7sYtFNrg/PpeJHh4yQmKcBGtPwKCwOWGeFwoAcQnXti5hJUT9zudUdGM8kLPqcaF1T8HuzphFDGcK7EHxyp815gnfAqJ/OjIdYx+dmpt2IX0PB1ursJMIEe1XzpmYlJ2qEWGXuqnjCmyVc+c84DlKDa+sb4q/atZXNlRVHQYAGOR17QxVU0H1l6vHw28oSxn35yOIK1qZsqFmJzF0KmaG008Uz6Oe4vHPZUQtPdoU3oyH/8K6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HN928UeDDBMDRdQM4ZIPYL8GKfHRkfFJquNYvlIBgE=;
 b=aSSpXv9NPZvpC72h1s4F6ccpj90g9pqPlXYpkK8GbypijQILpAknXwX27taPLiLlSBeACgo7sccufTvmjjThxDNm0TO5f+SUV0KqiHLFZXiR+sTHjFXUr0jI2/KP/yDagHciz9YRVBfAxT8CWkAYVaGK6EsPYRbfRsLgULenGKdTjhI6REKLG94Ih4WBm9X0d0ugP3ixC8agI8k3mXUQ/p9K3Oih2EoruFv77yLC3Kk5RjQSIkgwlIyyWU6e/24uMVfuDf+TTKzmhjNVKnMG+SKjqxuaFH7I8R4P9agly0XNfqbm6EjVCNHK037yOUvXE3RIszplx/f17Qj3ld654w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HN928UeDDBMDRdQM4ZIPYL8GKfHRkfFJquNYvlIBgE=;
 b=J4GkPtCxWIWOoTllQRXIaecAY2rfpSJMfOGwTTlwUmYUNehe4h+4RO5+HP6AwrIYsqfoXF2oF97anciq9KSnjs1mAaszTs1/NyYsl4Ub9YTZD8rdh7ike4PPU5qxxtz2RzQgqPKxjFeYt2ljrtB3J8O33oztjPOV2E+s6UABOHg=
Received: from LV2PR21MB3181.namprd21.prod.outlook.com (2603:10b6:408:175::9)
 by DM4PR21MB3083.namprd21.prod.outlook.com (2603:10b6:8:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.7; Fri, 25 Feb
 2022 01:34:43 +0000
Received: from LV2PR21MB3181.namprd21.prod.outlook.com
 ([fe80::bca6:7ca2:7138:f083]) by LV2PR21MB3181.namprd21.prod.outlook.com
 ([fe80::bca6:7ca2:7138:f083%6]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 01:34:43 +0000
From:   Dmitry Antipov <dmanti@microsoft.com>
To:     Rob Herring <robh@kernel.org>, Dmitry Antipov <daantipov@gmail.com>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3 3/5] Documentation: DT bindings for HID
 over SPI.
Thread-Topic: [EXTERNAL] Re: [PATCH v3 3/5] Documentation: DT bindings for HID
 over SPI.
Thread-Index: AQHYDjlFf3+MjPaN20Whx84M1w3pFayjsMmg
Date:   Fri, 25 Feb 2022 01:34:43 +0000
Message-ID: <LV2PR21MB3181C74C6FB79DB5F80F3DCBDA3E9@LV2PR21MB3181.namprd21.prod.outlook.com>
References: <20220115023135.234667-1-dmanti@microsoft.com>
 <20220115023135.234667-4-dmanti@microsoft.com>
 <YenA1ZxT0/ZHw+RH@robh.at.kernel.org>
In-Reply-To: <YenA1ZxT0/ZHw+RH@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94e10799-ce84-4b1e-902b-87975df3e84e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-25T01:25:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f739d5ce-0298-4fb1-5fd0-08d9f7feffb2
x-ms-traffictypediagnostic: DM4PR21MB3083:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM4PR21MB30836F72659EFC34CF2BA9E7DA3E9@DM4PR21MB3083.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKeoUypY2gf5B0iVMKBZdKEhFQsEigBK7smnCG0+cREOVcqjyH5yzsaf3Xq+1L08JObjC0tQsU8SWD6REBUgu8Sj+NbpZ4vIEGr7qvqjxJKfkqGu9QWpVaYsx9KhR9Q5gq+LwsUuAeyOcVsLgTjvykKD8/zDVFnaJyxwcu+e00zlagfKUlWSHdfPrw6uwvbuH8iJK02Do5wEjBTouYlZcSCxWE6/MwtkHRGuyP41ePvHLDrudcs6XcE1efLM/daLLfo5SANT03dw1OMt/PLI5y74LOPCeECjaNha4C4BjSOeEKZsIt8jq3qZVKB67G1yT4+j+OuCm8KYieQi4/9W6cukA5peomHpMq1B+fG+RZO4A4uY7gIeXbSIkMsddXNOEYNceHKVnqHTVqx0Z49GL6YDTIjqQlMTUjp14iSQxHmKY6BjgxkL194t1WVxiNm5zO3yQfMXIj/36xanHrwTTGVYfC2hs+FonlpyOc2x4+dMikzEwrSWd+VOSC9BaaFgvE46VOxp99qKg+XJ5+Wez8z4f5v4EspRj1U2TQSTq7HvJe0RWziVncSKsMZOkULJFaQTBysnjJ17ISb1PZxcQscFcxV0wP/CR91YtuIVfa8gQodN33zTHM2xT1D2TEJNEf/lEErN+AmaHdkkhyYmL+zCK0O4AL2+2voIyqigxEbOcRHtbCLbPA9mvyDHUWn67wWAjbLBaP0OMUxMRdeESWJnuAfl1YVqfFumRkPfonl0t1jlQh3v+wM2PHcWT+EYncA5Mdj/wvo1UwQgK6OKYSe6uqoK8hJEUBn8rTc8dVI/KLeBmWmlzxJnlLD0mdGo0JRNnpMXdXgmE3r5rN9O9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3181.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(8990500004)(110136005)(54906003)(83380400001)(66556008)(66446008)(966005)(7696005)(8936002)(316002)(82950400001)(82960400001)(6506007)(71200400001)(5660300002)(66946007)(10290500003)(186003)(53546011)(9686003)(7416002)(64756008)(55016003)(38070700005)(86362001)(122000001)(38100700002)(4326008)(76116006)(8676002)(2906002)(508600001)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FOOHNTqvX8WH6foCf94S8GhIwOPFfG0krwHMvNyL/DwhKA/cG+x9vk/gMT7g?=
 =?us-ascii?Q?oDuFIl02/yJuyGBG+dwSZBoE6B5DlApL3ud8MG6UcgdEnplI7tVpMQkzwyZT?=
 =?us-ascii?Q?YSt4FcDOLJ/tXXbaY2vB/KP1d4BmwfVN/lQCVDg0n3+rmfyGSqyKVi/cR7wI?=
 =?us-ascii?Q?vYDgLKRliSdytT8XCT+NA98aHOqd2MuvnIrRVHSDCaIe0BOkn1gp1oRZLZ1x?=
 =?us-ascii?Q?JsjzJqQQh9ltfnEmCTU9t9z8rxWd3nmj6Bhl6bGXUzSB9qZckMOUrnid7htI?=
 =?us-ascii?Q?rUYJa83ARv5pjP4ZTotHVgifZolKIv8+eK2mHpvskZ7FAmNSJWPXuRiCRSfi?=
 =?us-ascii?Q?esEsVQws5FMEfrdo6EFBnDyfdbqmMPPJUJKa6VpaEOvYLqa/kniyJDgt1qE8?=
 =?us-ascii?Q?9xx0q+E78R44nLjaOGME2W0Cl4+xhhY4OB0soAzsnSKg7Ln4XWqKEEKgEov3?=
 =?us-ascii?Q?aISTLgCeywZcBz8+5kOmJKy0GXkkgiz4/lLMfMPqPlOlhRaSUSiyxnGf0tNS?=
 =?us-ascii?Q?ndSGknNQPhjE0SOnuXMPuJ4FWy/STaOJfBIuPdHAf3nTsSVK0tau/p+4Hv/r?=
 =?us-ascii?Q?x4Q2X2/qYdSo4PX4Ir7QdGHuo4lubxEQnncBWY8qJZujsff1ynVWxSCsRDVN?=
 =?us-ascii?Q?ZR5AI/Z4z6rPZ+5zPybTG2qXCb4ADomBwQ7SSq+1zKYjwtVB6ZXzxM2p36MV?=
 =?us-ascii?Q?WWlrsT4Wkqo9VQ4QLJJel5gsJLaVIW5HSpbm5BlcU1/8k7JS80CnsSqE7V98?=
 =?us-ascii?Q?Axh8QF7t8Myey98RDP9f4shleb7R9+IAUY/ksXB+gqCTqnvir3fDDhClqLZF?=
 =?us-ascii?Q?es4S2p2t7LnYUEYkL+7q6WD8GVVUnrGmgTa3PWTI8qEsMH5tQ6VtnwuLg7vN?=
 =?us-ascii?Q?20lfLXw9eW1vQJQq5mNJ1khiHVXATx3hZ6Xns9GDq/5mUz85PiNWuPeTDiGT?=
 =?us-ascii?Q?hjhISfszanN/GorO5MSnzSaUK2vyeqyzwbJZ7Nf/0y8boNx7yXhrHNbuSKUV?=
 =?us-ascii?Q?763qwKEa9RpbQ7FG9BE5Q8Ayc7g9w2UYAMdWiWqg8NeS1HGMvdRHTFUOHOyI?=
 =?us-ascii?Q?1KosdIhrMUW8jbgC+iZzRN/ixzcz9ERtYQZZqVp94TLhUFQRBEitCZ2ae5qn?=
 =?us-ascii?Q?LXAnQYCcehlsUAIYDk7ps8EdNxihoOjd3llSXkuh38Z+RsiH1HEaS1E1mv1o?=
 =?us-ascii?Q?g2lsaQV+Zbrm4SVPH7QXuobkSB8p+J1ht7Evbe4syAkxU98Iodrg6+uimVk3?=
 =?us-ascii?Q?sSAgX+TXP/8HU3CFRUjShxk6d/nsSCHIwyhADNh7O4Iem9Ld6rSfyCaqbsAS?=
 =?us-ascii?Q?4j9OC83gY+cLcGa/GBUVUJfabL2KUvNeORTRPGvGLcfMxpQe9gkR+OnUaMlO?=
 =?us-ascii?Q?Pub2Qo5eSzwmVdJavNh4DjP/85ayneiOSRiRsxac3BPntnqnjI5icko2bigL?=
 =?us-ascii?Q?IRc03MDTPlur6iyuIbRRlXVXD8pIJ0ZgLeZLy5+Sqo/G338tN0snlCZFpIE9?=
 =?us-ascii?Q?ZopdMT7M6iqLyJhWk1DrejsRKbeAIFbTAiAdjSP/MyOegDPoFqZGhsj3HkZ+?=
 =?us-ascii?Q?chA1q1OeF1O9zcdyb9LwE24WvaGJZkXmK817Wy11OSNbFs21AalhKtxalxni?=
 =?us-ascii?Q?e6Z/CnyZSGcKpp+2OXoloAZa2BGN0/iaVrC41EkdNRf0xEfRtqAla69g9V54?=
 =?us-ascii?Q?aCiskw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3181.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f739d5ce-0298-4fb1-5fd0-08d9f7feffb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 01:34:43.2369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aw/c2uKB9cM2eOTMibTcoDREgQTf2QSKAFagjx6wCWN7oixSJibwntjiuNkEIGVmSIDBKVTRhTHkIpZVcHFX3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3083
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Rob,

I just submitted patch v4 that addresses most of your feedback.

On Thu, Jan 20, 2022 at 12:07 PM,Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> On Fri, Jan 14, 2022 at 06:31:33PM -0800, Dmitry Antipov wrote:
> > From: Dmitry Antipov <dmanti@microsoft.com>
> >
> > Added documentation describes the required properties for implementing
> > Device Tree for a device supporting HID over SPI and also provides an
> > example.
>=20
> Bindings are in DT schema format now.
>=20
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > ---
> >  .../bindings/input/hid-over-spi.txt           | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100755
> > Documentation/devicetree/bindings/input/hid-over-spi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.txt
> > b/Documentation/devicetree/bindings/input/hid-over-spi.txt
> > new file mode 100755
> > index 000000000000..5eba95b5724e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.txt
> > @@ -0,0 +1,43 @@
> > +* HID over SPI Device-Tree bindings
> > +
> > +HID over SPI provides support for Human Interface Devices over the
> > +SPI bus. HID Over SPI Protocol Specification 1.0 was written by
> > +Microsoft and is available at
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.m
> icrosoft.com%2Fen-
> us%2Fdownload%2Fdetails.aspx%3Fid%3D103325&amp;data=3D04%7C01%7Cd
> manti%40microsoft.com%7Cb0b84680fa2c45bc2f3a08d9dc5063f6%7C72f988
> bf86f141af91ab2d7cd011db47%7C1%7C0%7C637783060144589082%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DbWGZDRYtVovy3XYlpDsZ8xR2AL
> be5YoP0iSZ8xORSyA%3D&amp;reserved=3D0.
> > +
> > +If this binding is used, the kernel module spi-hid will handle the
> > +communication
>=20
> What's a kernel module? ;) Bindings are OS independent (or supposed to be=
), so
> kernel details do not belong here.
>=20
> > +with the device and the generic hid core layer will handle the protoco=
l.
> > +
> > +Required properties:
> > +- compatible: must be "hid-over-spi"
>=20
> Bindings describe devices, not protocols. There is no such 'hid-over-spi'=
 device.
> Please see the existing hid-over-i2c binding.
> It's fine to have this compatible, but only as a fallback compatible.

In the v4 patch the yaml file expects the device-specific compatible
string, but also 'hid-over-spi'.

>=20
> > +- interrupts: interrupt line
> > +- vdd-supply: phandle of the regulator that provides the supply
> > +voltage
>=20
> What happens when the device has 2 supplies? And there's some timing
> requirement between them?

I am not sure if there is a way to account for all possible scenarios.
Our device only has one power regulator and the binding is now
device-specific.

>=20
> > +- reset_gpio-gpios: gpio wired to the device reset line
>=20
> 'reset-gpios' is the standard name.
>=20
> > +- post-power-on-delay-ms: time required by the device after enabling
> > +its regulators or powering it on, before it is ready for
> > +communication
> > +- minimal-reset-delay-ms: minimum amount of time that device needs to
> > +be in reset state for the reset to take effect
>=20
> These properties are what happens when we try to do generic bindings.
> It's a never-ending addition of more properties to try to describe
> (poorly) the power sequencing requirements.

I have made these optional in the v4 patch.

>=20
> > +- input-report-header-address: this property and the rest are
> > +described in HID Over SPI Protocol Spec 1.0
> > +- input-report-body-address
> > +- output-report-address
> > +- read-opcode
> > +- write-opcode
> > +- flags
>=20
> A bit too generic. We generally want to avoid having a property name with=
 2
> different types/meaning. It's not something we check for yet, but I plan =
to at
> some point.

I've made "flags" more specific in the v4 patch.

>=20
> > +
> > +Example:
> > +	spi-hid-dev0 {
> > +		compatible =3D "hid-over-spi";
> > +		reg =3D <0>;
> > +		interrupts-extended =3D <&tlmm 42 IRQ_TYPE_EDGE_FALLING>;
> > +		vdd-supply =3D <&pm8350c_l3>;
> > +		input-report-header-address =3D <0x1000>;
> > +		input-report-body-address =3D <0x1004>;
> > +		output-report-address =3D <0x2000>;
> > +		read-opcode =3D <0x0b>;
> > +		write-opcode =3D <0x02>;
> > +		flags =3D <0x00>;
> > +		reset_gpio-gpios =3D <&tlmm 25 GPIO_ACTIVE_LOW>;
> > +		post-power-on-delay-ms =3D <5>;
> > +		minimal-reset-delay-ms =3D <5>;
> > +
> > +	};
> > --
> > 2.25.1
> >
> >
