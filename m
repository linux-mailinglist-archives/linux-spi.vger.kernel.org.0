Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9377C21EBE6
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 10:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGNIwH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 04:52:07 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:36046 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIwG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jul 2020 04:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594716725; x=1626252725;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=tky6NM7O8/hnmZ6YHCdQVf/2RQnmXE+nhxA5aK0S6a8=;
  b=U80e4I5yPSJrEZsICK9sGoFpO5j6OWsrYKurhz3/SIm65b3SKIAsOhWr
   iza6nKRALzaBkqOZN7Q5gMGJx+Jy/rIcd8JwDvvdFAxgSBi5nAg2jz+40
   h/yJ96x1Tn/2r6HipWtUk9cOAPW6K9FDfP9xoOxO92WIJLUux1nCHR1PZ
   RjZv4Qjba20vAQkhqE4Jj5Dc5Wk0xJlxqLQcwrV8h1VlKICObZKNz0Gf2
   1DJpmmTgio41W2e6i04cegRNd8jHx/XuusT1yCUU1rxh/6ap+N6Vv0nPm
   fAiL2Lc+7lFa+ZBcwX1CYczaRHcNxFhipHV1Yztwggat7fEYrDYdPNbaz
   A==;
IronPort-SDR: fYrEfRCafZ4CxcwW6D3u0SOieHK0rHHRRzQG9Gfh5XnLBXvOpgKBDsMVAAZp1VZ+Q1AK9fuy5N
 VaLBShb30ZgOmiq1RLe6gM2qPqL/XmBd8m1yFKuCrSlVAzZjc69yu8kyh3xr4SJvwZgfRS1HfO
 a6hWpxGlnUnTBW1cbofkn2pqIVsJMvwXoTo1f5xTzF2aXXyx7kj6TCRykJGkn4b6XWRACgcSa/
 Nlxxna2dJQcnM62j9a2uwpSbir7mjn+JNKS/D6ZtPqPOqV4KbcHG3M/VYuYvs11KLC5H/9Ly2R
 Sk4=
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="87506770"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2020 01:52:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 01:51:34 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 14 Jul 2020 01:51:30 -0700
References: <20200702101331.26375-1-lars.povlsen@microchip.com> <20200702101331.26375-7-lars.povlsen@microchip.com> <20200713192902.GA587038@bogus>
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
Subject: Re: [PATCH v3 6/8] dt-bindings: microchip,sparx5-spi-mux: Add Sparx5 SPI mux driver bindings
In-Reply-To: <20200713192902.GA587038@bogus>
Date:   Tue, 14 Jul 2020 10:52:01 +0200
Message-ID: <87y2nmjx72.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Rob Herring writes:

> On Thu, Jul 02, 2020 at 12:13:29PM +0200, Lars Povlsen wrote:
>> The Microchip Sparx5 SPI controller has two bus segments, and use this
>> mux to control the bus interface mapping for any chip selects. This
>> decribes the bindings used to configure the mux driver.
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  .../mux/microchip,sparx5-spi-mux.yaml         | 71 +++++++++++++++++++
>>  1 file changed, 71 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml b/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
>> new file mode 100644
>> index 0000000000000..b0ce3b15a69e5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mux/microchip,sparx5-spi-mux.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip Sparx5 SPI mux
>> +
>> +maintainers:
>> +  - Lars Povlsen <lars.povlsen@microchip.com>
>> +
>> +description: |
>> +  The Microchip Sparx5 SPI controller has two bus segments. In order
>> +  to switch between the appropriate bus for any given SPI slave
>> +  (defined by a chip select), this mux driver is used. The device tree
>> +  node for the mux will define the bus mapping for any chip
>> +  selects. The default bus mapping for any chip select is "0", such
>> +  that only non-default mappings need to be explicitly defined.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - microchip,sparx5-spi-mux
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  '#mux-control-cells':
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +patternProperties:
>> +  "^mux@[0-9a-f]$":
>> +    type: object
>> +
>> +    properties:
>> +      reg:
>> +        description:
>> +          Chip select to define bus mapping for.
>> +        minimum: 0
>> +        maximum: 15
>> +
>> +      microchip,bus-interface:
>> +        description:
>> +          The bus interface to use for this chip select.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 1]
>> +
>> +    required:
>> +      - reg
>> +      - microchip,bus-interface
>> +
>> +examples:
>> +  - |
>> +    mux: mux-controller {
>> +      compatible = "microchip,sparx5-spi-mux";
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      #mux-control-cells = <0>;
>
> How is this mux accessed? You have no control interface defined.
>
>> +      mux@e {
>> +        reg = <14>;
>> +        microchip,bus-interface = <1>;
>
> This looks odd. I take it that there's 2 muxes for this h/w? If so then
> #mux-control-cells should be 1 and the cell value can be whatever you
> want that is meaningful for the mux controller. Could be 0,1 or perhaps
> 0xe if that's more useful.
>

Rob,

The intended use was for the SPI driver to use mux_control_select(mux,
<cs>) and then have the mux driver translate the <cs> to the right bus
interface, according to its configuration. The SPI driver would have a
"mux-controls" property bound to this mux.

Anyway, I am getting pushed in the direction of using the "mux-mmio" and
"spi-mux" combo, so this driver and bindings are being dropped again.

I am currently awaiting the "rx-sample-delay-ns" issue to be clarified
such that I can refresh the series.

Thank you for your comments!

> Rob

-- 
Lars Povlsen,
Microchip
