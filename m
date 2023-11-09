Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168097E68AA
	for <lists+linux-spi@lfdr.de>; Thu,  9 Nov 2023 11:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjKIKsX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Nov 2023 05:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjKIKsW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Nov 2023 05:48:22 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7782F199E;
        Thu,  9 Nov 2023 02:48:20 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 5D8263D5;
        Thu,  9 Nov 2023 11:48:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699526894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrmoCN7TimdoNlWRyDTs2xB2cMOCnHfEIZq+DdKYscA=;
        b=UspXMR3MhLulpzb30ACHVrua+V7fvmaaS8we4LZ/luOUeDaF8lN2yhi3ldXACZZBKP1mBd
        RTzPJ/b4LM7noTHX4C+AXfcZxexjZrhZ+K6dIpzahe2f55zA8u52f8Z4YrxqDqoY+xURik
        9dWz+WUYz5Z3Xq4zhavW9+bCQL9YXf+ITjBuWmCroljik8zGHt05GtD65XgJhgyxxgj2iN
        DVNyoi8bH+nuFyokvcHmLJO9L57NJKpxsExCX9M2h92h7AHDy0ZxS9M8g1JL5o9mjo7cKP
        g1ggA4xroZMFt9yHD45AsNCCCuul9GYQwV+e3KH0I86iCenHQR7lLyPzfapElg==
MIME-Version: 1.0
Date:   Thu, 09 Nov 2023 11:48:14 +0100
From:   Michael Walle <michael@walle.cc>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "biju.das.au" <biju.das.au@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] Add set_iofv() callback
In-Reply-To: <TYVPR01MB11279E535835F2998335F770A86AFA@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20231108171149.258656-1-biju.das.jz@bp.renesas.com>
 <877590a5e3f8c32ec0a032385049a563@walle.cc>
 <TYVPR01MB11279E535835F2998335F770A86AFA@TYVPR01MB11279.jpnprd01.prod.outlook.com>
Message-ID: <b9831be88008b9f9960d1d79cd0e5a3a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

>> > As per section 8.14 on the AT25QL128A hardware manual[1],
>> > IO0..IO3 must be set to Hi-Z state for this flash for fast read quad
>> > IO.
>> > Snippet from HW manual section 8.14:
>> > The upper nibble of the Mode(M7-4) controls the length of the next
>> > FAST Read Quad IO instruction through the inclusion or exclusion of
>> > the first byte instruction code. The lower nibble bits of the
>> > Mode(M3-0) are don't care. However, the IO pins must be high-impedance
>> > before the falling edge of the first data out clock.
>> 
>> I'm still not sure what you are trying to fix here. For any quad I/O 
>> mode,
>> the pins of the controller must be in hiZ during the data phase on a 
>> read
>> operation. Otherwise the flash couldn't send any data, there would be 
>> two
>> drivers for one signal. So being in hiZ state should be the default 
>> and
>> shouldn't depend on any connected flash.
> 
> OK, I will make hiZ state as the default.

I still think this iofv setting is the wrong approach, though. Do you
have a link to the spi controller datasheet where I can look up what
the controller is doing.

This seem to be a general problem with what we are sending during the
command phase and I'm curious why there wasn't more reports on non
working micron flashes for now.

>> You've mentioned the micron flash which needs a '1' on its hold/reset 
>> pin.
>> I would have expected a fixup for this flash, not for the flash which
>> behaves normal.
> 
> I will drop fixup for Renesas AT25QL128A  and will add fixup for micron 
> flash.

btw, what will happen if you always use the {3,3,3,1} setting? I guess
the atmel flash will also work? because HiZ should mean "don't care" 
from
the point of view of the flash.

> 
> With iofv settings {3,3,3,3} (all pins on Hi-Z state) with Micron flash
> -----------------------------------------------------------------------
> 
> ./rpcif_t_001.sh
> [   37.950986] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff 
> ff ff

As mentioned earlier, I suspect that HiZ on IO3 means low and the flash
will be in reset. Could you perhaps verify that by probing IO3?
I know that other flashes will *either* support RESET#/HOLD# or quad 
mode.
Thus I was saying, that we probably wont support that and the easiest
fix should be to disable this behavior for the atmel flash (there was
nv setting).

I guess, the correct fix would be to somehow add support to control
IO1-IO3 during the (single bit) command phase.

-michael

> 
> EXIT|FAIL|rpcif_t_001.sh|[00:00:01] Failed to detect mt25qu512a 
> flash!||
> 
> 
> With iofv settings {3,3,3,1} with Micron falsh
> ---------------------------------------------
> root@smarc-rzg2l:/cip-test-scripts# ./rpcif_t_001.sh
> [   26.500035] spi-nor spi1.0: mt25qu512a (65536 Kbytes)
> [   26.533995] 2 fixed-partitions partitions found on MTD device spi1.0
> [   26.540410] Creating 2 MTD partitions on "spi1.0":
> [   26.545239] 0x000000000000-0x000002000000 : "boot"
> [   26.554381] 0x000002000000-0x000004000000 : "user"
> 
> EXIT|PASS|rpcif_t_001.sh|[00:03:01] ||
> 
> Cheers,
> Biju
