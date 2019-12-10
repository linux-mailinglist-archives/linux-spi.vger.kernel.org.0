Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F033119182
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 21:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLJUHX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 15:07:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44020 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfLJUHX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 15:07:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so14753303lfq.10
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 12:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IVcVWrTqzzoJOExedrP/w3aCQxV5GwfvKkNgJHaUgQY=;
        b=muNxyZVX+j2ePeHGmZ8JuT3kaQ7OHqbg1mVUZHgJU3kcA/u0qsdDaR4cFFP/metLVh
         UYCcgR2D0Dr+DVzcO9ocmf4B1J5rqOBrmJNsfcAI0+GMRmC9Yimt7i/vhqgMfclsjWbp
         PzMoMBCVu7Q9K9s/uIuVB9GjrlC3tZ4Dnl2x74Qas0MWU8AaRFdGiISXZ++PHkUr99li
         pKBeyZERVNJ2WxVWTFgwOh3V+mjAsbNAZ91cwwdPS8fTGS0Hs647lOtWUqMQYFAldCpn
         9mGK7HvPh6FjisA2/sdwfPdV/a7dDqrSa5Xp5CDiV0/M1bkIvKNm5DEj5zaHDSp5qoSJ
         c17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IVcVWrTqzzoJOExedrP/w3aCQxV5GwfvKkNgJHaUgQY=;
        b=Rkqq8CLKCvsx7ITkjZzXST4y1G0gxFTcaXctQX0E9GuLbOC+FriDX2kppv40YpiFZK
         nJ5ZTtUOOqyczpsNzTFSPCmz4oStizKb9hkn1w6NpJ9+AswbG3R6FinN5eNcOwQtOA95
         uuqDOJvGiLOYMNIeWRR3OfaQISMmm9YfaQPbLT/9tlMDBLm8HaPixLfG01xxp18Nyzw8
         bvpBpadxF3MrVSwGMiiunOXmfCLpSBDntAgXUlG4Ru0V7T9DJYX5WGzwnV2XzbmjJT3R
         qtwpVX7uAJBYeAsTnkzHd59XivguTbOJ7KiV9eHp1l/vxwuKZbQ0o1VE/MlhbWz0Qsh0
         c5nA==
X-Gm-Message-State: APjAAAUCoqIYQkev74a0LUFSucPJh0nw3sVzzF1WJpp+2WzC8LhgyFN/
        uxpqsFE0AeKDoS5dJ6aw7Odxvw==
X-Google-Smtp-Source: APXvYqy7jA1CkGtuRr5UKn5k9QWlLPx4dGI/unO0eIDc3ayyv08uFHffOSNGvFma2xOaj8U/PD/aXw==
X-Received: by 2002:a19:760c:: with SMTP id c12mr12867007lff.60.1576008440109;
        Tue, 10 Dec 2019 12:07:20 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:88a:ffe6:e26c:e506:75a0:c93a])
        by smtp.gmail.com with ESMTPSA id j19sm2323761lja.100.2019.12.10.12.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:07:19 -0800 (PST)
Subject: Re: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Brandt <chris.brandt@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-3-chris.brandt@renesas.com>
 <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0cbd8556-cf17-7d6b-5c12-e8d663a39cfa@cogentembedded.com>
Date:   Tue, 10 Dec 2019 23:07:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 12/09/2019 05:09 PM, Geert Uytterhoeven wrote:

>> Document the bindings used by the Renesas SPI bus space controller.
>>
>> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
>> ---
>> v2:
>>  * change to YAML format
>>  * add interrupts property
>>  * Used more terms directly from the hardware manual
> 
> Thanks for the update!
> 
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/renesas,spibsc.yaml
[...]
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - renesas,r7s72100-spibsc     # RZ/A1
>> +              - renesas,r7s9210-spibsc      # RZ/A2
>> +
>> +  reg:
>> +    minItems: 2
>> +    maxItems: 2
>> +    items:
>> +      - description: Registers
>> +      - description: Memory Mapped Address Space
> 
> The second one is not needed, if you would add "ranges" for the
> memory-mapped mode.

   I'm not sure we can do that. The flash bus is accessed via a window
with the high bits in the DREAR reg, even in the direct read mode...

> 
>> +
>> +  interrupts:
>> +    description: Some HW versions do not contain interrupts
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  flash:
>> +    description: |
>> +      (Optional) In order to use the HW for R/W access ("Manual Mode"), a "flash"
>> +      subnode must be present with a "compatible" property that contains
>> +      "jedec,spi-nor". If a spi-nor property is not found, the HW is assumed to be
>> +      already operating in "External Address Space Read Mode".
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - '#address-cells'
>> +  - '#size-cells'
> 
> I would make the flash subnode mandatory.

   Agreed.

>> +
>> +examples:
>> +  - |
>> +    # This example is for "Manual Mode"
>> +    spibsc: spi@1f800000 {
>> +        compatible = "renesas,r7s9210-spibsc";
>> +        reg = <0x1f800000 0x100>, <0x20000000 0x10000000>;
>> +        clocks = <&cpg CPG_MOD 83>;
>> +        power-domains = <&cpg>;
>> +        interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        flash@0 {
>> +            compatible = "jedec,spi-nor";
>> +            reg = <0>;
>> +            spi-max-frequency = <40000000>;
>> +
>> +            partitions {
>> +                compatible = "fixed-partitions";
>> +                #address-cells = <1>;
>> +                #size-cells = <1>;
>> +
>> +                partition@0000000 {
>> +                    label = "u-boot";
>> +                    reg = <0x00000000 0x80000>;
>> +                };
>> +            };
>> +        };
>> +
>> +    # This example is for "External Address Space Read Mode"
>> +    spibsc: spi@1f800000 {
>> +        compatible = "renesas,r7s9210-spibsc";
>> +        reg = <0x1f800000 0x100>, <0x20000000 0x10000000>;
>> +        clocks = <&cpg CPG_MOD 83>;
>> +        power-domains = <&cpg>;
>> +        interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +    };
>> +    flash@20000000 {
> 
> This does not describe the hardware topology: the flash node should be
> a subnode of the spibsc node, as it relies on the spibsc being clocked.

   ACK.

[...]

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergei
