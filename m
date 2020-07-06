Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89816215A53
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgGFPKh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 11:10:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37340 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgGFPKh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 11:10:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id 12so25755671oir.4;
        Mon, 06 Jul 2020 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbVQnKX9cGHjz5cAqDI171HAdzuSj/vrkGLAeogFPdQ=;
        b=mzOQaE6QuADLaN/1JCSS4SsZCDB5RlwOl1q2Pa+KPUGP3l1JjwMo60l8RY+JjmJK1g
         aGhwNG2tqRbhp8tLvfIrZ9aA1vblkLxTwD3gNeUj6A+O8/OT4ZwRYMwqPih1YEE/yq/+
         tqoRe703KXTK0S6w+4XgfB3EqbPBIdMmDzy32MbTOSZbefO5plRgtVNAwhKeMBTaz5l7
         IXvdK3yZxyyInFUBKGU/RrsQQ+iAz2b6YA5d1LTorM6Yi78/8BJ5qel/UFUep/vCroRY
         wEosdjbkJlUY9NjHjmozi+opsI+GdZeXvPZK0+Dn1VilrpM1vFgAhjuBp5T8Vqiy7sx5
         1zcA==
X-Gm-Message-State: AOAM530Uro99IF6zhq4ZBSnwii8M5KIjU3Utxbh8bTUCZxre1IW2A1+L
        rq5JsFVod96ztkzZkgw5ThLnQjGCS1adBDL4k4jvk9xG
X-Google-Smtp-Source: ABdhPJy3nPe01DMLHZsnb1XBpPIo+qosBy1RuitQMetKS4QMG/wf/U2JNl6ordfgRwOD6N6B6SRPadNF4BR4bh5oWkk=
X-Received: by 2002:aca:ac10:: with SMTP id v16mr16991186oie.153.1594048236359;
 Mon, 06 Jul 2020 08:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <202007040833.xIqR5rAw%lkp@intel.com> <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706092247.20740-2-adrian.fiergolski@fastree3d.com>
In-Reply-To: <20200706092247.20740-2-adrian.fiergolski@fastree3d.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Jul 2020 17:10:25 +0200
Message-ID: <CAMuHMdW_aTKtrUnGqf3DB=fr0ZxTsjoEjMmwSpPqhwjs-Tz7ig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Add documentation for SPI daisy chain driver.
To:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Adrian,

On Mon, Jul 6, 2020 at 11:23 AM Adrian Fiergolski
<adrian.fiergolski@fastree3d.com> wrote:
> Add documentation for SPI daisy chain driver.
>
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@fastree3d.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt
> @@ -0,0 +1,56 @@
> +spi-daisy_chain : The driver handling SPI daisy chains.
> +-----------------------------------------------------------
> +
> +Required properties:
> +- compatible           : Should be "spi,daisy_chain"
> +- reg                  : Chip select assigned to the chain
> +
> +  For the SPI devices on a common SPI chain - nodes of daisy_chain):
> +- spi-daisy-chain-len  : Length (in bytes) of the SPI transfer,
> +                        when the SPI device is part of a device chain.
> +- spi-daisy-chain-noop : Byte string of no-operation command which should
> +                        be send when device is not addressed during the
> +                        given SPI transfer

The above two properties are device-specific, and the same for all
devices of the same type, thus leading to duplication.
Hence I think this should not be specified in DT, but instead handled
by the driver.  I.e. for Linux, you would retrieve this from struct
spi_device, as filled in by the slave driver.

> +
> +Optional properties:
> +  (for the SPI devices on a common SPI chain (nodes of daisy_chain):
> +- spi-daisy-chain-bits_per_word : no-operation transfers involve
> +                                  one or more words; word sizes like
> +                                 eight or 12 bits are common.
> +                                 In-memory wordsizes are powers of two
> +                                 bytes (e.g. 20 bit samples use 32 bits).
> +                                 If not defined, it is assumed to be 8.

Same here.

> +Example:
> +
> +       daisy_chain0: daisy_chain@0 {
> +               compatible = "spi,daisy_chain";
> +               spi-max-frequency = <10000000>;
> +               reg = <0>;
> +
> +               dac0: ltc2632@0 {
> +                     compatible = "lltc,ltc2634-l12";
> +                     spi-daisy-chain-len = <4>;
> +                     spi-daisy-chain-noop = [00 F0 00 00];
> +               };
> +               dac1: ltc2632@1 {
> +                     compatible = "lltc,ltc2634-l12";
> +                     spi-daisy-chain-len = <4>;
> +                     spi-daisy-chain-noop = [00 F0 00 00];
> +               };
> +               dac2: ltc2632@2 {
> +                     compatible = "lltc,ltc2634-l12";
> +                     spi-daisy-chain-len = <4>;
> +                     spi-daisy-chain-noop = [00 F0 00 00];
> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
