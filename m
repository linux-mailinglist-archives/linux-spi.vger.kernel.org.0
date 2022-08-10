Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF07E58EE93
	for <lists+linux-spi@lfdr.de>; Wed, 10 Aug 2022 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiHJOka (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Aug 2022 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiHJOkO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Aug 2022 10:40:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB3C61B32
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 07:40:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p10so17970381wru.8
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=3zoT29l2qJ9aTsY+6ZgozKW8nBr9jlEDg3mjpflKN7U=;
        b=6f9vtUxhe784fp23lP6rOYryqTkvlaJq070gQ0cOXntG1rnOXeY/inEjE390LYUM3V
         F+7CYWBxIYPpFNbxy4jkhJall3nyuk54rGCN4Jaj2eqeTOg1PXi9J4mEEnMM9McBZ/nO
         x0lhPSg/BYcswX3mt7uqqasP8X5Y/0UTUyZI8pt4egjDlp9IacEsVHRezzTk4S26xLfH
         pyXN0lxFHUV37u0DVoFu3jUErUjSQHgud2CH6U7OIp90FQDzON+PLbPffezOiBiHqRBq
         TWeemrp6GMr4Pihqgyn9TRjcz/eI4KbscdSt5VSYnSTtOuHOKY2ZCyZ0brZggfJXbZgn
         6I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3zoT29l2qJ9aTsY+6ZgozKW8nBr9jlEDg3mjpflKN7U=;
        b=TPCYdLVqS0ZHkkl0jI+SAc6PW4Yu5XcxLnqbjr8tjSap315oi/kV0KyTaryoGuu0Mp
         edG6ZHEzKbWx7iogX1msYm7JcO3tTXf0GwiH1aYkRjsfk4zy7RvuRfK6bvXEfC6G64Ar
         9vPZz36i1zk3LMV1jhsmLsOOIsYtO4+k04ket9BaiEmzYXKzm85O9mamhulA7h0X7WOk
         sPi2UbXUFSmfCOuY+qfJDroo13T18HN2yVJGAopk4T7DENqbu0mJZQlexQL7ft61lBRm
         XNO2zuaWx/cVc68f8QWGksWDgNT3b63/H4A7/ovttLSlanI1zsthhNLLY/OqKSSHasbw
         V8Yg==
X-Gm-Message-State: ACgBeo2R3Nfl1oLh6hTwM9Yo5U8SBhNpUqEdKGRuS8CAY3YMf+/jqcjt
        GtVxSBTjCoNMEz+4qPjer27IwF6WNSgZ+A==
X-Google-Smtp-Source: AA6agR4vOEiO9UfNGfLbBT7KPPyGdUzwnaj707ZIWzWUwHvF23mK2tcUvXiNy5X4xG/E27w8ShcnIQ==
X-Received: by 2002:a05:6000:1011:b0:220:5a7d:9cd6 with SMTP id a17-20020a056000101100b002205a7d9cd6mr16331099wrx.504.1660142406033;
        Wed, 10 Aug 2022 07:40:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bbf0:b69d:fecb:8006? ([2a01:e0a:982:cbb0:bbf0:b69d:fecb:8006])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d6dc2000000b002235eb9d200sm6018414wrz.10.2022.08.10.07.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 07:40:05 -0700 (PDT)
Message-ID: <9dabe979-f6b5-329d-f017-a8f0c00adeca@baylibre.com>
Date:   Wed, 10 Aug 2022 16:40:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
References: <20220809152019.461741-1-narmstrong@baylibre.com>
 <YvJ84qkuXdvVgXRm@sirena.org.uk>
 <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
 <YvOmnDJA+ov49chC@sirena.org.uk>
 <518f22f4-1582-924c-9eaa-28ebbe53a632@baylibre.com>
 <YvPBX7zJ72RXnrpk@sirena.org.uk>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <YvPBX7zJ72RXnrpk@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/08/2022 16:31, Mark Brown wrote:
> On Wed, Aug 10, 2022 at 04:01:33PM +0200, Neil Armstrong wrote:
>> On 10/08/2022 14:37, Mark Brown wrote:
> 
>>> Sure, but that doesn't really address the concern - is this something
>>> that the clk driver programmed or is this the driver forgetting to
>>> restore a register that it programmed itself?  The commit message sounds
>>> like the former which is a much bigger problem.
> 
>> It's what is programmed by the Clock Framework yes, it was designed as-is
>> so the Clock Framework takes the most accurate clock path but the reset case
>> wasn't taken in account.
> 
> This seems like a bad idea, we shouldn't have two different drivers
> managing the same register without explicit and visible coordination
> with each other, this is at best asking for trouble as you've found
> here.  I've not looked in detail but I think if you want to use the
> clock framework here then this driver should register a clock provider
> for the clock hardware in the IP block.

I totally understand, this wasn't explicit until I found the bug.

I don't think it's worth adding so much code for this since we already
had an open-coded function which perfectly worked before.

> 
> How does this work with runtime PM, what happens if the clock driver
> decides to change something while the device is powered down?

There's no runtime PM implemented, and yes it would be an issue.


I'm perfectly OK to remove the CCF driver for the legacy clock path
and return back to the old open coded calculation since it perfectly
worked and stop using the legacy clock path for new SoCs since it would
never be selected anyway...
... but GX SoCs are broken so it would need an intermediate fix until
I push the refactoring to cleanup all this.

Neil

