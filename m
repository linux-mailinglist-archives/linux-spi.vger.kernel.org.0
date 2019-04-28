Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE17ABE14
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2019 00:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfD1W2U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Apr 2019 18:28:20 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58384 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfD1W2U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Apr 2019 18:28:20 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 29C09886BF;
        Mon, 29 Apr 2019 10:28:17 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1556490497;
        bh=4iokib0fRDF2m/1Fgu1A0tChgO+NPNw/3qRG80iWq+s=;
        h=From:To:CC:Subject:Date:References;
        b=Old51YfaBnDb/nulFECSf+8tOhUc0z8UKq8LBWdX4n3muwCF9zc4Wm4zO++DZveHm
         izNYHvPjsA9LQXpXgxmgoVtEhlE4b70R83Ji8aEQffA3BzNAj6zdSajay7xs1qOeXy
         VVANesRjVp7BQSJ0gUVPos499Sax5G7zl9onNISXcTwC2ojWBCzOQqYEnDJ+/9ziMj
         4LPMATCfTK8h/r6OVfQNKCeVy3QHCQNQqBW46xC8GNZcBgBHRLmU2ZGnfOkcHFDVYb
         jz9YunKIXzE0L7+Ltny4StYygazp25nR1Y96RIDwfEsX/6drUPa+r/82XPYuLsyBNH
         CFf5FGKP2cJiQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cc629000001>; Mon, 29 Apr 2019 10:28:16 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 29 Apr 2019 10:28:16 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 29 Apr 2019 10:28:16 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Mark Brown <broonie@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tthayer@opensource.altera.com" <tthayer@opensource.altera.com>
Subject: Re: [PATCH 0/3] spi: SPI bus multiplexer
Thread-Topic: [PATCH 0/3] spi: SPI bus multiplexer
Thread-Index: AQHU8Ozv195ROsCjnk63k3UuR7SGLg==
Date:   Sun, 28 Apr 2019 22:28:16 +0000
Message-ID: <d91ab2261a1f4069bc48e090bd4ec702@svr-chch-ex1.atlnz.lc>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
 <20190412082913.GA6909@sirena.org.uk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/04/19 8:29 PM, Mark Brown wrote:=0A=
> On Fri, Apr 12, 2019 at 05:02:10PM +1200, Chris Packham wrote:=0A=
> =0A=
>> Unfortunately recent changes have stopped my hacks from working. I've=0A=
>> tried adapting cs-gpios to work with my particular hardware but I came=
=0A=
>> to the realisation that the current cs-gpios support assumes a 1:1=0A=
>> mapping of gpio to SPI device whereas my hardware used the state of the=
=0A=
>> gpio selecting the device i.e. a 1:2 mapping.=0A=
> =0A=
>> This is my attempt to implement a driver to deal with this. One nice=0A=
>> property is that it is pretty much self contained. The only change to=0A=
>> the core SPI infrastructure is exposing a function I needed to lookup=0A=
>> the spi_controller instance.=0A=
> =0A=
> Why not implement the device that demuxes the GPIOs you're using for=0A=
> chip select as a GPIO controller?  Presumably it might get used for=0A=
> things other than chip selects.=0A=
> =0A=
=0A=
Hmm a gpio-gpio driver. Interesting.=0A=
=0A=
One other problem that I encounter is the interaction between cs-gpio =0A=
and SPI_MASTER_GPIO_SS. Having cs-gpio automatically sets SPI_CS_HIGH =0A=
which has the undesired side-effect that now my real chip select is =0A=
inverted. I actually wonder if this change breaks commit 8eee6b9dd30d =0A=
("spi: Add Flag to Enable Slave Select with GPIO Chip Select.") since =0A=
now there is an extra inversion on the CS enable.=0A=
