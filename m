Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012C54F8A08
	for <lists+linux-spi@lfdr.de>; Fri,  8 Apr 2022 00:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiDGVF3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 17:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiDGVF2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 17:05:28 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC98170099;
        Thu,  7 Apr 2022 14:03:27 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E9F1F80209;
        Thu,  7 Apr 2022 23:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649365406;
        bh=DFldO1xQANEedL9KLEQH7/3oHSrNuTxg/a7RicxjUkw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ds36vfm+tOD8CksRyi7Sx9ES6A1ls7aAU0Jh0g1EqEfqOv+6HecvDCuFrav6lA+HZ
         FHOg63vJsvPzyvJIm+2HfCeXFjIeOnNRWvXJziSxvwJ8LmMmZQPO702aIw6kawKK8P
         //aL3uA8TpipWJiirA8P8r3dzdfGDCVgqt199zT7hLoLiAaTOsD6bUI4z5B3HgL+H5
         ywCzj/Ufy3EcZZMMLE53GDPRiEt4dLZpBFhyFOg/GW1mMP3ydk9lG+T/piLpbwBgSe
         hltflTlONeQZLF+ZNgXA2DQUgLGQb0tCWSu289+Q+opwC+7kScp/HNcOeQ4TyyVhEk
         JVM6FnbTJkXsA==
Message-ID: <e4080a52-bf2f-0643-ec55-fe410daa1574@denx.de>
Date:   Thu, 7 Apr 2022 23:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: spi: Add YAML DT binding document for
 trivial devices
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
References: <20220407194936.223041-1-marex@denx.de>
 <CAL_JsqKRMrCdz4L6c2CyR1y+Wj7LG0NB4r9dm72gktmV08whyg@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAL_JsqKRMrCdz4L6c2CyR1y+Wj7LG0NB4r9dm72gktmV08whyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 4/7/22 22:35, Rob Herring wrote:

[...]

>> +$id: http://devicetree.org/schemas/spi/trivial.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Trivial SPI device DT bindings
>> +
> 
> Add 'description' and describe what devices do and don't qualify as
> trivial. (And you can't say 'spidev' :)).

I got as far as here and then realized all the devices I need to 
document do fit the trivial-devices.yaml ... so, patches are out, please 
drop this patch for now.

>> +maintainers:
>> +  - Marek Vasut <marex@denx.de>
>> +  - Mark Brown <broonie@kernel.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - cisco,spi-petra
>> +      - dh,dhcom-board
>> +      - lineartechnology,ltc2488
>> +      - lwn,bk4
> 
> This one is a *board*!. Wait, and a device... I suppose that's
> possible if the board can be a device in another system. Except both
> are used in the same dts file. That should create some nice warnings,
> but I'm not sure anyone is paying attention to fsl.yaml warnings.
> 
> In any case, we're left with
> Documentation/devicetree/bindings/misc/lwn-bk4.txt. That and any other
> cases need to be deleted.

+CC Lukasz.
