Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93002230503
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jul 2020 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgG1ILI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jul 2020 04:11:08 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:54328 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgG1ILH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jul 2020 04:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595923866; x=1627459866;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=4348zSQswPRrH20ua261huy5XthZgYClc7uZbxDiXss=;
  b=BloFnMYMDUNlfRnyraH1QD+B6QqXi8D6yahBhbSmU7Rn6rIygDFoutO6
   u1gubUlWHJP1Nin5KJrdtPf24tUGu5NToQD25fMw054axTMYuZl2kI5pb
   jG+LomAq41K4p9G0e52b5IcxrrgETbmBvnyjZrxu4v7Kh+ZjsnRxb2wDE
   SjorAN/XwUkGjjQlCs4yRK9NFYGjG6VOANWb2UVxq0NFH1v5+WTfUmxnk
   Qg+lvl3vqRSVFZhQ/1bPN/FUYpqs0deGPsE3wPMmkYsj9Tnly3VftLlYE
   3U45BDPl1ZTaSLzdQvm8UrvjMjs0gwcdG3sWupJYIV6ZuDdlI2jeYSJiq
   w==;
IronPort-SDR: u0DQ0eKwBMew6XCiVSZ6TNgz94sf4p5fEp5KHy8R4066+bkamL02aFIDa/PnprqNt7eLr68+0O
 bdwaZdRFNX3d+PZCspEgWoLORjBExQfhW1PLxMGaME/1kwbkmFz8kyYFa9qIp3tufYwjk+pPtN
 yA1WkCcvGJwbSgD2GHiaHUjIV/LjQK2/8u8bNmSJdo3H8SmAWPfolmFlnNV80IoZpcshXAYiPe
 q7Cms7O27/x1xxDD5OZksFJvaZIS2LZWhn70jtDPdXSklcadkY8v3um+VybJnSOzHzkwoVqZR1
 3LQ=
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="83485204"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2020 01:11:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 01:10:19 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 28 Jul 2020 01:11:03 -0700
References: <20200724111404.13293-1-lars.povlsen@microchip.com> <20200724111404.13293-5-lars.povlsen@microchip.com> <20200727203847.GA782308@bogus>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v4 4/6] dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus rx-sample-delay-ns property
In-Reply-To: <20200727203847.GA782308@bogus>
Date:   Tue, 28 Jul 2020 10:11:02 +0200
Message-ID: <87sgdcf4a1.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Rob Herring writes:

> On Fri, Jul 24, 2020 at 01:14:02PM +0200, Lars Povlsen wrote:
>> This has the following changes for the snps,dw-apb-ss DT bindings:
>>
>> - Add "microchip,sparx5-spi" as the compatible for the Sparx5 SoC
>>   controller
>>
>> - Add the property "rx-sample-delay-ns"
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 21 +++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> index c62cbe79f00dd..c0adaad1aa695 100644
>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> @@ -36,6 +36,8 @@ properties:
>>                - mscc,ocelot-spi
>>                - mscc,jaguar2-spi
>>            - const: snps,dw-apb-ssi
>> +      - description: Microchip Sparx5 SoC SPI Controller
>> +        const: microchip,sparx5-spi
>>        - description: Amazon Alpine SPI Controller
>>          const: amazon,alpine-dw-apb-ssi
>>        - description: Renesas RZ/N1 SPI Controller
>> @@ -93,6 +95,12 @@ properties:
>>        - const: tx
>>        - const: rx
>>
>> +  rx-sample-delay-ns:
>> +    description: Default value of the rx-sample-delay-ns property.
>> +      This value will be used if the property is not explicitly defined
>> +      for a SPI slave device. Default value is 0. See below.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Don't need a type for properties with unit suffixes.
>
> Also, add:
>
> 'default: 0'
>

Hi Rob!

Thank you for your input, all duly noted.

---Lars

>> +
>>  patternProperties:
>>    "^.*@[0-9a-f]+$":
>>      type: object
>> @@ -107,6 +115,13 @@ patternProperties:
>>        spi-tx-bus-width:
>>          const: 1
>>
>> +      rx-sample-delay-ns:
>> +        description: SPI Rx sample delay offset, unit is nanoseconds.
>> +          The delay from the default sample time before the actual
>> +          sample of the rxd input signal occurs. The "rx_sample_delay"
>> +          is an optional feature of the designware controller, and the
>> +          upper limit is also subject to controller configuration.
>> +
>>  unevaluatedProperties: false
>>
>>  required:
>> @@ -129,5 +144,11 @@ examples:
>>        num-cs = <2>;
>>        cs-gpios = <&gpio0 13 0>,
>>                   <&gpio0 14 0>;
>> +      rx-sample-delay-ns = <3>;
>> +      spi-flash@1 {
>> +        compatible = "spi-nand";
>> +        reg = <1>;
>> +        rx-sample-delay-ns = <7>;
>> +      };
>>      };
>>  ...
>> --
>> 2.27.0
>>

-- 
Lars Povlsen,
Microchip
