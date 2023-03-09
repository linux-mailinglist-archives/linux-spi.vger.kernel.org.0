Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D16B2582
	for <lists+linux-spi@lfdr.de>; Thu,  9 Mar 2023 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCINdq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Mar 2023 08:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCINdi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 08:33:38 -0500
X-Greylist: delayed 3478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 05:33:36 PST
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1186F2C64D;
        Thu,  9 Mar 2023 05:33:33 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9F141D5A;
        Thu,  9 Mar 2023 14:33:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678368811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+iF8CPFFQ1v326vjmVw+Tv1dyEC7GRMOHK3YGspsDI=;
        b=J0YrqMIzlBpt7uBiKWHyMEj0RjMeBRKisoF+bJtSbE+DgLHuVCG1JSmqjTO6UFnIBJnxSb
        nQ01qq/LIwcI2Yoo5NTtY1oBi+yCfCNlKOWcKU8VUu8T4DqZTogWmbHO3szIadAxpNIzu+
        8TmYey/UvirCzVVhtEkqZPpToxOFHhvxIgED6c7aYA0z1FCYSPf/MHPSrXUQNf9M9hJU8d
        ON/4xkZBcabsZx0uj1mHNY0r2S5V0WqTneRJ/0nErU7CuYDJzsqgqdjKZlm4EqpferQXsl
        fVioS0iDADxKBR+HU0OYTGbeYqVopkZuSzFEN5oPMmhXOwjZ6+SZdQavxKC0xg==
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 14:33:31 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>, Sergiu.Moga@microchip.com,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, chin-ting_kuo@aspeedtech.com,
        clg@kaod.org, joel@jms.id.au, andrew@aj.id.au,
        kdasu.kdev@gmail.com, han.xu@nxp.com, john.garry@huawei.com,
        matthias.bgg@gmail.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, haibo.chen@nxp.com,
        yogeshgaur.83@gmail.com, heiko@sntech.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <6c2090bf-d102-a333-3a83-03abe81ff70e@linaro.org>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
 <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
 <f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc>
 <1849e2c8-54f5-9e56-4ed8-8b0e4a826d04@linaro.org>
 <302ecf0421fe4c99fca3eb0ca2f66127@walle.cc>
 <5183a184-c72d-3acd-70cd-6aa1e31533f5@linaro.org>
 <03a9f117316ab81f1b5a18100f771e65@walle.cc>
 <6c2090bf-d102-a333-3a83-03abe81ff70e@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <460ef5ff3846b409b322ca53559e2476@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>>> The controllers that can talk in dummy ncycles don't need the
>>> dummy.{buswidth, dtr} fields.
>>> 
>>> The controllers that can't talk in dummy cycles, but only on a "byte"
>>> boundary need both buswidth and dtr fields. Assume a flash needs 32
>>> dummy cycles for an op on 8D-8D-8D mode. If the controller does not 
>>> have
>>> the buswidth and dtr info, it can't convert the dummy ncycles to 
>>> nbytes.
>>> If he knows only that buswidth is 8, it will convert ncycles to 4 
>>> bytes.
>>> If dtr is also specified it converts ncycles to 2 bytes.
>> 
>> No they don't need it. Lets take your semper flash and assume it needs
>> 12 latency cycles. SPI-NOR will set ncycles to 12 *regardless of the 
>> mode
>> or dtr setting*. The controller then knows we need 12 clock cycles. It 
>> has
>> then to figure out how that can be achieved. E.g. if it can only do 
>> the
>> "old" byte programming and is in quad mode, good for it. It will send 
>> 6
>> dummy bytes, which will result in 12 dummy clock cycles, because 1 
>> byte
>> takes two clock cycles in quad SDR mode. If its in octal mode, send 12
>> bytes. If its in dual mode, send 3 bytes. Obiously, it cannot be in
>> single bit mode, because it cannot send 1.5 bytes..
>> 
> 
> You miss the fact that you can have 1-1-4. What buswidth do you use
> for dummy, the address buswidth or the data buswidth?

Doesn't matter, does it? The driver is free to chose, 1, 4, or anything
else. You don't sample any data during the dummy phase.
To answer your question: single for instruction, single for address,
whatever you choose for dummy as long as there are ncycles space between
address and data, and quad for data.

Depending on the capabilites of the hardware it will likely be 1 or 4.

> What happens if crazy protocols like 1S-1S-8D appear? What buswidth
> and transfer mode are you going to use for dummy?

Also doesn't matter. What matters is how many dummy clock cycles you
do. Again, they don't depent on the mode. You just have to count
the clock cycles between the address and the data phase (and that is
what your ncycle parameter will tell the controller).

> And please don't tell me that "we're going to assume that
> dummy.buswidth = address.buswidth because that's what we currently do
> in SPI NOR", because I'm not convinced that the assumption is correct.

No, it doesn't matter :)

-michael
