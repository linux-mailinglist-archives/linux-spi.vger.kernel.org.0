Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2038D8B449
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2019 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHMJgZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Aug 2019 05:36:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfHMJgZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Aug 2019 05:36:25 -0400
Received: from [192.168.178.60] ([109.104.47.130]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5gAG-1hukSx14nq-007FT2; Tue, 13 Aug 2019 11:36:17 +0200
Subject: Re: [PATCH v4] spi: bcm2835: Convert to use CS GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lukas Wunner <lukas@wunner.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Chris Boot <bootc@bootc.net>
References: <20190804003852.1312-1-linus.walleij@linaro.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <d4df1cdd-604b-89bd-27da-ed455f170b00@i2se.com>
Date:   Tue, 13 Aug 2019 11:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190804003852.1312-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:jCoBHsGzrqvGdA03wROJa4FubZzr0bFm8xCEVDDmuFqFwFOdJN4
 Rx+dIIKRYx+4DqV7/PtIa2Y7q3cIAWDm5etyKmuFGveGCKq4HpUNEud8irkcdax1xINgRit
 dMVWtJzAUlD7xKcRNg61Z/3cXi1GU8OnjH/WJUli/ews8MUuMhxHPGfdNR9oSn2YQP2kQS1
 RRk2gV7EfnRBvaPpaQdog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uUABwUqmInI=:Ji8rCBQBBOxDVgq4U3KlIP
 KqbEQdg5IqgWL6Nf78WESRbqYtInqOSrPTmZVc5FCsBAHxFfu+HykknX/+lFX6mXcaqUfUj8i
 tULnac9w/eiN23/Ew43G1t+X3Wf4r8XHCcLaCK7D/PZBoqhO7vSX0LZG3h+g+EWFgAE8kCAgs
 ONgMqZwh1NjVJcqlXQ3cJeGlSM3Obli72B17ipyWBJrwL3oZ6Bd3yyZ35n2Ujdee3Jx/Fw3kG
 aOkkAhg3CC4yKbJW3QlIFMYmnIazTVi37AQtfi1tKaSLkfYLAKFrZ14WOsaz6LM/Vh7VRlaCd
 yuUIs9d1nkah8etZAAhKmKs1WDfjrkiLWf3yEKOUmcmMkepfP7QgcJrsF36xMBd7mmX7Y/hA0
 ifETm+T9isMScJBwGuWLsYEBsNlOVDWoBS2KqbkysvybnxjUK9CRPKoO9DzqJDMXfzFsu5IIy
 0hjwnn6YLMP6qpj7Co/1PS9ejhpIRrARiL7AIS97pM/DAj+t7JTo+xhqr+3otqo6UA5kkg69H
 PHr877NfagmzC+NhX97qj/2pvfvAHk1UqGMVShxkc03J2OKYX7zjHnYN6jONrYVrfbJW1FCwa
 MP7WUk9BdFlGupO433M0OkJGOnz8k8OUpk9Zn4mNhFTTYbNFUYUbjnltLA7A2p5gdFBnwsmvZ
 q8WAAF2EczVebhvnadGcevTbVT5XOWvEwCMzEf/nHVxmdVsBxFpy8OT04d3uXTgoB52EEoZC2
 Q+FLM3wp1uC6CAhInFZ38oCr+iIhQm18aZjcsgOOhFBLh/0MiTlk0FKg/AA=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Linus,

On 04.08.19 02:38, Linus Walleij wrote:
> This converts the BCM2835 SPI master driver to use GPIO
> descriptors for chip select handling.
>
> The BCM2835 driver was relying on the core to drive the
> CS high/low so very small changes were needed for this
> part. If it managed to request the CS from the device tree
> node, all is pretty straight forward.
>
> However for native GPIOs this driver has a quite unorthodox
> loopback to request some GPIOs from the SoC GPIO chip by
> looking it up from the device tree using gpiochip_find()
> and then offseting hard into its numberspace. This has
> been augmented a bit by using gpiochip_request_own_desc()
> but this code really needs to be verified. If "native CS"
> is actually an SoC GPIO, why is it even done this way?
> Should this GPIO not just be defined in the device tree
> like any other CS GPIO? I'm confused.
>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Martin Sperl <kernel@martin.sperl.org>
> Cc: Chris Boot <bootc@bootc.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Fix the offset of the chipselect line to be 8 - CS
>   as in the original code.
> - Use the modified gpiochip_request_own_desc() to set up
>   line inversion semantics if need be. Look at the OF
>   node of the SPI device for flags.
> ChangeLog v2->v3:
> - Fix unused variable "err" compile-time message.
> ChangeLog RFT->v2:
> - Rebased on v5.1-rc1
>
> I would very much appreciate if someone took this for
> a ride on top of linux-next (there are some fixes in
> the -rcs you need) and see if all still works as expected.

sorry for my late reply, but i was on vacation.

Thanks for your efforts on this, but currently i don't have a setup to
test this :-(

