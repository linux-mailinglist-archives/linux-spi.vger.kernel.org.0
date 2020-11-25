Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D1E2C3BD2
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 10:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgKYJRj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 04:17:39 -0500
Received: from mail-vi1eur05on2087.outbound.protection.outlook.com ([40.107.21.87]:37768
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbgKYJRi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Nov 2020 04:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fv3ZFaasT5I30QyTsECHUHVZWbCgO4vJceFZn9AyPU=;
 b=68SXdFthuaM9Xi6CijZWzgIMaO5qW3t6g9zydtBXcCQnQmuCy5LYBeOpOl+JzSzh2hVr3mDl2IiHS966N0jal+lRsOddiritVOi6NzhJDTBfLJmMODPb7Z0Fg02/5rh088KlTiKM4wZCXqBR8ZSolGwXQ3S4wXzKZy1s2v9+spQ=
Received: from AM5PR0201CA0007.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::17) by AS8PR08MB6149.eurprd08.prod.outlook.com
 (2603:10a6:20b:29d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 09:17:33 +0000
Received: from VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::31) by AM5PR0201CA0007.outlook.office365.com
 (2603:10a6:203:3d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Wed, 25 Nov 2020 09:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 63.35.35.123) smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature
 was verified) header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror
 action=none header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT005.mail.protection.outlook.com (10.152.18.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Wed, 25 Nov 2020 09:17:28 +0000
Received: ("Tessian outbound 39167997cde8:v71"); Wed, 25 Nov 2020 09:17:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bf315312d143582e
X-CR-MTA-TID: 64aa7808
Received: from d7d13d944e18.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BD2327DA-EDF3-41E2-B64F-582A8FBB72CC.1;
        Wed, 25 Nov 2020 09:17:22 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d7d13d944e18.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Nov 2020 09:17:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdypKTjHm/YllEyVTJrJN56X16enOK3zDSmxwWwrR2dNzt2B3UpFqDYY3ilsuRvTHnIgYy0mDHEepjnDMnkT0tQexZtkWKB6OkmlYfrsbN5t9eco/sGolxZQW6qrVF446wGsMZAFjDwhWnn1DPIjX9Ahm5ewTvaJmzLIDAnJaVu8MphMaQ6NSMWTPee8suQIVJcP/khFzPoN8eBS34P5c+PetO25CqCkytCFAzCYZuLymKVQov5jfzVm1VxtKyVRRAHTI2v187/j/euKwL9kTCe6OXBKbd4bahLb9n3k4nmvaOVs2sm+hifqNIbaMD1V76tf3H2MgsyGxLi/bmXuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fv3ZFaasT5I30QyTsECHUHVZWbCgO4vJceFZn9AyPU=;
 b=jjVqJcaMG6hzo//6wlO8FyIYBNUTEUe29S0Ak84yRWj1IjZ8PqhrT+q69EEBXaM6t9ofIZUB48ZKAVio4TzoreHwlITOz23j+0IeAydgepk7EJyAuU3tNXN2pCrJqpYp0aFFRqMX4cF2/DX/0eZ1W7NbiBeVGmctoHi1AP5jSyrvhsc6092PseDGRUzirYhSO2t5DQmhubPbYKten6EhocUsiUDZgKYdgaebOwFrvOUcezCD2aX3iuciaqiyFHns4ZcKYrPz9uvszS4TohUh8vq4vN+bDmP+o1lj0bl28wxMBYaUf8m4Y3zGyvbX0pCuxNuCHDxT2gwkuJgNAkYUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fv3ZFaasT5I30QyTsECHUHVZWbCgO4vJceFZn9AyPU=;
 b=68SXdFthuaM9Xi6CijZWzgIMaO5qW3t6g9zydtBXcCQnQmuCy5LYBeOpOl+JzSzh2hVr3mDl2IiHS966N0jal+lRsOddiritVOi6NzhJDTBfLJmMODPb7Z0Fg02/5rh088KlTiKM4wZCXqBR8ZSolGwXQ3S4wXzKZy1s2v9+spQ=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (2603:10a6:10:ab::15)
 by DBAPR08MB5606.eurprd08.prod.outlook.com (2603:10a6:10:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 09:17:20 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::a998:af0e:17cb:9389]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::a998:af0e:17cb:9389%7]) with mapi id 15.20.3589.021; Wed, 25 Nov 2020
 09:17:20 +0000
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO
 descriptors
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201106150706.29089-1-TheSven73@gmail.com>
 <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
 <20201111123327.GB4847@sirena.org.uk>
 <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <30299db4-e149-ea7e-8f30-bb37187909d5@arm.com>
Date:   Wed, 25 Nov 2020 09:17:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [94.196.85.203]
X-ClientProxiedBy: LO2P265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::23) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.178] (94.196.85.203) by LO2P265CA0083.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 09:17:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39576611-ef59-4834-18a9-08d89122ef3b
X-MS-TrafficTypeDiagnostic: DBAPR08MB5606:|AS8PR08MB6149:
X-Microsoft-Antispam-PRVS: <AS8PR08MB614949ABE591F2C740C3262A95FA0@AS8PR08MB6149.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tX9L2TDSP/QRn05kmxDoDCDZyU2CkT9JkYRNt6XzULtlpRxLQfKGlL3+Q7CRLPv1Xrihs4pzwSu4RVjagshOKeqKJw3h17baht7mEhBnxHlwR1bpNx9aLbOSAJv81LJMzIu+RUc2/8gsCNsjcvCEGr8GQynBWYquTfU11oJfiLo2+Wn1tsyjyEBo4IQSyHep48qREpiFlq9oE1jtdEDnoyIJWdQnh9R1vf+ZRnwucxUYSQ2i+wz2pmFEXfpCUU8oELwnQVyt6CwvI2i+Lt/8p7etZNR/DgfeARWl1fK3A9YcKnb6h+K/Qtt4jokbDX4dvpFD8Tx3HdGxCkDwfTydes5jXSq4bsvv3UIxbKgHUbxbGeUt/Q5EXLau1ImVdY8g
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB4010.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39850400004)(396003)(366004)(186003)(52116002)(44832011)(83380400001)(86362001)(54906003)(2616005)(4326008)(956004)(16526019)(26005)(31686004)(316002)(110136005)(2906002)(55236004)(16576012)(6486002)(66476007)(478600001)(8676002)(5660300002)(53546011)(36756003)(66946007)(8936002)(31696002)(66556008)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: b1AbUmuqM0Zh4lHLqK6cxIKBlHTIKIqIxvtHJMkdkwVKQ1X3aWsCxyselpILbJwSNbHJ1uYxaonkNKsE1MYKWEKwW+tbPOVMC63O7WWMihvIrTQqgqtkoWpu/fKfzLHLc+r/l8Gu53jAyrRGyS5qS0w/a/Jgo7AI8IDHFscWJtR+etYp+T4NKzAugsgKZl6BXaPlwoisz8ur6Uvmzn6utDw7t8qSkNp+/S/WwTxpg9KXnkK9g5OpSSPQ6H+SCu+jiYYSiLLdN7m9GbpX8HNx3YBN2kh7EFAtHOYfW7lcRRPvVSdMJcufygosffy1ix+7bRJU60w78IwOG4CYdMDFqNLVwIvfgyJbl92IBbswlMjVQ7DyukqoWudd/D8OTM8zNY3Hd0S6k/H73o8h4IkqXi0bhRiumSOF1Rw/ZK7+mKwxHHjrNswfYJ6Z12AJilcE9mZYeHfWQzu0YYd5vzuljWFVOdwjajg02gYmq8KsVr54uyi39ZFNgzGJEQ5HehIx/UPRACgJjOEuD16CYPm26fZLVo5KpnS8/aEpzr9VLjOCEbnrBL64Lq58PbBy2Vp9F6zkvd5jA+bn+iBjbVI5k4TZ7URe+mUZXPLoMhvBhS/oppMm2N18pFl48HG3K1+fWpSyPgPQTTBv3+dlJ3abZ2KydW16+n/LLNbHogGmK0nY5/mEVGD7hh1FdkEH9KlYCRGH8rwcaA3QxuGQReeSndMg2npquK+UAPSgw7EqQ6+IhlZyEgv+m3NcCy+7pvwT6A/IXQz0gnYsu+tRgwOoD9lXMdZHuXh/TuYJRzH72JVHrzu71t+mZzScaPVVuhQmlG6QJF6RHDFHnChoB2l4Smq0/uq2rHWaJgqjDEUQZMh+po86CR7RJEqARnp706XgIUS+pmPqVgTyoMtsF3j3gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5606
Original-Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0acc0161-0387-4c41-a503-08d89122e94d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnVVtUi/dz54GjHpuKTeR+8V+ZMUq0PzWHwqnNJXSXEVeVFMnLweCoLjabwHXrl2e2i2TzE19amPXyu7Gi75xMAtoc8PBfrIDQv3iAeCYeK0hVORURvOqMOhjtURtvR5A85WFhXp/3K4HKs2Cp4mBDEOmMp5Oc9Te71eO40V+ZkEPghgpEqRenzbLjCb3YqDn60JnM4uSZ4Z8Hg0sjA9tk2EK/D2beebhBB+LLY+Y9wfLVvDENFP493orW0gDc0GbPQizoCSWe8hRMelrrIjZfAMkDY27N6bWXfD1oHsuhtYuSEJVKSaeAOgyeNrVajPGpygP/pP9APpE2kH1vc1x7vb65hTGHlWhNUvCT4ClPEnosKRhD3rz6sBDzpeqecE7RhUA6lj0Hl5/PBXQJzB/D0ieU4dcp2vm+szH3uakVKJju44H6tOWuDArmBpGUzA
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(316002)(31686004)(83380400001)(4326008)(16576012)(16526019)(53546011)(6486002)(26005)(356005)(336012)(47076004)(186003)(54906003)(478600001)(55236004)(110136005)(82740400003)(44832011)(8676002)(956004)(63370400001)(2906002)(81166007)(36756003)(8936002)(31696002)(2616005)(70206006)(450100002)(86362001)(5660300002)(70586007)(63350400001)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 09:17:28.3117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39576611-ef59-4834-18a9-08d89122ef3b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6149
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 11/11/2020 13:36, Linus Walleij wrote:
> On Wed, Nov 11, 2020 at 1:33 PM Mark Brown <broonie@kernel.org> wrote:
>> On Wed, Nov 11, 2020 at 02:05:19AM +0100, Linus Walleij wrote:
>
>>> I would say that anything that has:
>>
>>> spi->mode =3D ...
>>
>>> is essentially broken.
>>
>> This is not clear to me, most of these settings are things that are
>> constant for the device so it's not clear that they should be being set
>> by the device tree in the first place.
>
> This was added initially with some two properties
> in drivers/of/of_spi.c in 2008:
> commit 284b01897340974000bcc84de87a4e1becc8a83d
> "spi: Add OF binding support for SPI busses"
>
> This was around the time ARM was first starting to migrate
> to device tree, so I suppose it made sense to them/us back
> then.
>
> Some properties were the accumulated over time.
>
> commit d57a4282d04810417c4ed2a49cbbeda8b3569b18
> "spi/devicetree: Move devicetree support code into spi directory"
> made this part of the SPI subsystem.
>
> This seems as simple as nobody was there to push back and
> say "wait the devices can specify that with code, don't put it
> as properties in device tree". To be honest we have kind of
> moved back and forward on that topic over time. :/
>
>> The idea that the chip select
>> might be being inverted like it is by this whole gpiolib/DT/new binding
>> thing is breaking expectations too.
>
> OK I think you're right, then this patch probably brings the behaviour
> back to expectations and it's how I should have done it in the first
> place. My bad code :/
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
>>> The core sets up vital things in .mode from e.g. device tree in
>>> of_spi_parse_dt():
>>
>>>          /* Mode (clock phase/polarity/etc.) */
>>>          if (of_property_read_bool(nc, "spi-cpha"))
>>>                  spi->mode |=3D SPI_CPHA;
>>>          if (of_property_read_bool(nc, "spi-cpol"))
>>>                  spi->mode |=3D SPI_CPOL;
>>>          if (of_property_read_bool(nc, "spi-3wire"))
>>>                  spi->mode |=3D SPI_3WIRE;
>>>          if (of_property_read_bool(nc, "spi-lsb-first"))
>>>                  spi->mode |=3D SPI_LSB_FIRST;
>>>          if (of_property_read_bool(nc, "spi-cs-high"))
>>>                  spi->mode |=3D SPI_CS_HIGH;
>>
>>> All this gets overwritten and ignored when a client just assigns mode
>>> like that. Not just SPI_CS_HIGH. I doubt things are different
>>> with ACPI.
>>
>> OTOH most of these are things the device driver should just get right
>> without needing any input from DT, there's a few where there's plausible
>> options (eg, you can imagine pin strap configuration for 3 wire mode)
>
> Yes I actually ran into a case where the same Samsung display support
> both 4 and 3-wire mode so that needs to be configured in the device
> tree depending on the layout of the electronics. Arguably we should have
> just standardized the device tree bindings and let the individual SPI
> drivers parse that themselves in such cases.
>
>> so generally it's not clear how many of these make sense for anything
>> other than spidev.  This binding all predates my involvement so I don't
>> know the thought process here.
>
> I dug out some details, let's see if Grant has some historical anecdotes
> to add. The usage document from back then doesn't really say what
> device properties should be encoded in the device tree and what
> should just be assigned by code and e.g. determined from the
> compatible-string. It was later that especially Rob pointed out that
> random properties on device nodes was overused and that simply
> knowing the compatible is often enough.

I think your analysis is correct. When this was done we were still
figuring stuff out and the abstraction between device and bus in SPI
isn't exactly clean. I don't have anything to add.

g.

>
> I don't know if we ever formalized it, there is nowadays a rule akin to
>
> "if a property can be determined from the compatible-string, and if the
>   compatible-string is identifying the variant of the electronic componen=
t,
>   then do not add this property to the device tree description. Just
>   deduce it from the compatible-string, assign it with code to the device
>   model of the operating system and handle it inside the operating system=
."
>
> I think this, while clear and intuitive, wasn't at all clear and intuitiv=
e in
> the recent past.
>
> Yours,
> Linus Walleij
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
