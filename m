Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B120B21EB65
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGNIa4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 04:30:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33756 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNIa4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jul 2020 04:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594715455; x=1626251455;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=iwME0Emw2+J43pHMb9qYdnILvBRF1cOmxeCbkgwHHWI=;
  b=usyuXKN+KCwL4nBDIstjpgPvjiNq2A+Wp7eJ3bE8Z104DiEmMl816w30
   kQP6l8kW7LZ1HZyYpy1AOkVnAGLtvjjdpa6sbvIpbZGON15TanIpIw3IC
   1OV4SxKa+hlT1BqbgDIVKvpdhKhdctiIF/ORSNTWKiZ4ptOlzMKo8AeCM
   gq8JLL7DBseA4m6UbO5Or0+SHAc+G5rntmpbtz7LSfH2mzPRSk+D7N84Z
   4S/mH5m8ei3t76AH8uELMrIrv+vsfbjcntFuxBcmH9Ll6XfwIG12S5ilM
   ZQjKFufh/MbFGrh82bu2ZNI35gHxc+gnAUnUMIUzKqcChztxpvSxsvyUH
   w==;
IronPort-SDR: rDCm3eZA3Wna9AO+bK/EoLvsiUHMNsKMDHn3nfTK+yrolAsyVlBnVSS1verBpraJXN83kMw8i8
 R0nwofBCha3cvA79LOIo5b8kNGzwuiST9NpBr6An6U5v6hPEEMu6t448RPxcYtREMfCViZNZEB
 JF7Ed4bGIIR34VfHP/943RyhAj/6MQoJxxmThFf4p2CwZysnM8IXuBpNyhwWuzc8ODnKgh2bah
 pH8DdvW4lFzsp+rORr5YIX3twSt19kuTp7CulOfVd2V91QKNYPItKglCEf9q1UkDXb3K4gYi5S
 23U=
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="87503354"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2020 01:30:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 01:30:54 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 14 Jul 2020 01:30:52 -0700
References: <20200702101331.26375-1-lars.povlsen@microchip.com> <20200702101331.26375-6-lars.povlsen@microchip.com> <20200713192259.GA553903@bogus> <20200713195219.xfvqknioqw7yyr74@mobilestation>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        "Lars Povlsen" <lars.povlsen@microchip.com>,
        Peter Rosin <peda@axentia.se>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/8] dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus snps,rx-sample-delay-ns property
In-Reply-To: <20200713195219.xfvqknioqw7yyr74@mobilestation>
Date:   Tue, 14 Jul 2020 10:30:51 +0200
Message-ID: <87zh82jy6c.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Serge Semin writes:

> On Mon, Jul 13, 2020 at 01:22:59PM -0600, Rob Herring wrote:
>> On Thu, Jul 02, 2020 at 12:13:28PM +0200, Lars Povlsen wrote:
> ...
>>
>> > +
>> >  patternProperties:
>> >    "^.*@[0-9a-f]+$":
>> >      type: object
>> > @@ -107,6 +122,14 @@ patternProperties:
>> >        spi-tx-bus-width:
>> >          const: 1
>> >
>> > +      snps,rx-sample-delay-ns:
>>
>
>> We already have 'rx-sample-delay-ns' from Rockchip SPI, so use that. But
>> note that it applies to the SPI node. Does this need to be per SPI
>> child?
>
> It was me, who suggested to Lars to have that parameter moved to the SPI
> sub-nodes. As I see it the property is highly dependent on the SPI slave device
> the controller is communicating to. Some of the them may need the delay some
> may not. It's not always the capacitance thing, but also depends on how good
> the MISO signal a particular slave generates. So IMO the Rockchip SPI driver
> developer should have moved that property to the sub-nodes too.
>

In the case with sparx5, having two bus interfaces, spi slaves may be on
different busses - making it obvious why you may need different settings.

But I guess even on the same bus the physical length of SPI connections
and device response delay to each device could play in as well.

Nevertheless, it *does* make sense to be able to specify per slave, but
a default could make the DT more terse. Should I add this to my patch?

I will remove the "snps," prefix now that the property is globally
established.

---Lars

> On the other hand if the Rx errors are caused by the MISO lane capacitance,
> then it will be cumbersome to have the same property duplicated for each
> sub-node. Then what about having the property supported by both the SPI
> controller and the SPI-child nodes? For instance the SPI-controller
> "rx-sample-delay-ns" will provide a default sample delay for each sub-node
> instead of zero by default, while the individual sub-node "rx-sample-delay-ns"
> property can be used to override the default value.
>
> -Sergey
>
>>
>> BTW, the Rockchip controller appears to be a version of the DW
>> controller.
>>
>> > +        description: SPI Rx sample delay offset, unit is nanoseconds.
>> > +          The delay from the default sample time before the actual
>> > +          sample of the rxd input signal occurs. The "rx_sample_delay"
>> > +          is an optional feature of the designware controller, and the
>> > +          upper limit is also subject to controller configuration.
>> > +        $ref: /schemas/types.yaml#/definitions/uint32
>> > +
>> >  unevaluatedProperties: false
>> >
>> >  required:
>> > @@ -129,5 +152,10 @@ examples:
>> >        num-cs = <2>;
>> >        cs-gpios = <&gpio0 13 0>,
>> >                   <&gpio0 14 0>;
>> > +      spi-flash@1 {
>> > +        compatible = "spi-nand";
>> > +        reg = <1>;
>> > +        snps,rx-sample-delay-ns = <7>;
>> > +      };
>> >      };
>> >  ...
>> > --
>> > 2.27.0

-- 
Lars Povlsen,
Microchip
