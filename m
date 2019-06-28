Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1059EC3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2019 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF1PYR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jun 2019 11:24:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:58013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfF1PYR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Jun 2019 11:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561735437;
        bh=nshWUM9Ial/mf04VgQojEVFHvNnxFuhVht1LXxXTMjs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V005/t26iHPy3IYQysg9nJ0s7iRbYBYACP3+SsPbrniz9VehXXgpMHAXX1LEzi5OA
         yyY78BMlRdBJP9fiHd3DpHiHH09RgAO3YZFJCWRwFXxc9P+2PcVsDT0n6BsvR8P89r
         UyyDRHnEhB4jfbTwTX6CWRx+ClcoFlZFwBb6G/Go=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.111]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLNpK-1hgKlT0DeU-000fxr; Fri, 28
 Jun 2019 17:23:57 +0200
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>, broonie@kernel.org,
        eric@anholt.net, Martin Sperl <kernel@martin.sperl.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <20190628123023.4696-1-nuno.sa@analog.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
Date:   Fri, 28 Jun 2019 17:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628123023.4696-1-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:g5PhiWHkkz3XBbA68000ZtOOSFncG6Lh3B7zaH8UEnRmlj9LSu7
 bvwDBwyI0hEnEc1mKxmBfRUfWu4NMRO99rufOyff5Dc3tU/uzCvLZl0yU5GJ0onkdKhaxwK
 QJuHUwZ5UmDRqy28J14hzi+eF2h1Eug2xrdoDjJyWetD9YCPZQp6orzz9UjxcP/Ji6lyozO
 TcrGlRAXcpDq/LoiaH+Cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A0rZTWBd6s8=:ZnhyxFh1FnnJ0ZEpCDPvE5
 qzRz2NSk4OCFxG8VdEBssbVdpjlBuInjlZ14cN9CrAdMlriiPBa09KL5jjXtwXfenqLtdsgtB
 WC48DFzggtufVS6A3BT3hj6RFJqmobsSRU57noFTrhRQg8jOvJS61KFFey6JXZ0l2WTJH3OQf
 mWwcffrfwU16E6Kla5dMYv8ZH6uvnamFVuPpgiPmQshK4S5G+/BYhdQv89krlgsXHvhHkYGLH
 wlv7f/9rHD6T8DhHwjf0vfwc3AnG3sAidHWFHjYtvIX3eu6WdTtA0ScPxXxNlNUKpts7ZfWNi
 H5QVS1vF/8PnY/m2Y5Hz8727SetXYkV9o8HC1yfKQmyBcT+NgZGDGJa95jGdWQHc+9TAKFSij
 Q2q7k/Sbtxsm9utnZ1+4mmilPZZRtrsD2d4e/hup6VuTQE2OdMWwQYAy+FAIyqj8DR1yJzON2
 D523eJKfzUTIt2JZTMOtEUT/pn4JCuHdfvT3UbHsG6vhWvjWmY/qeVOg0Bhp/rDNcfZzz0BYW
 CMfRKQgkXqkjpqDz1l7MApNQGDucLwX8NaLbkU/KBZu934WPp0AKk/4KSkL8ixH/Mi5T0Gdn4
 9EBnvQm7jSTakj5i4JTQez1rGceYVLN/AYfuS0WK9KLE75mcef86acwJILjmoB8ilSu5uqyx2
 GqtynnfaBlJrVkex+vvaYdYtlW+rv7Ti6xq+Jd84H+VYtP3UQSqoUKOaKLWUPAf0v3kobq+we
 C/2NN+5n5TY/OEOygLuQkyfBt9ZoRmJk9MdeDrX7RPhVk5M6SV9FhMvE4xIy8wryS5jQRLKyr
 K7HT3GROuQUbWVhMOh55appdoJYfn7n1d4VX+r5ziOO9+TXTZzij8Tow6VpJZNqnWmyYgFE2N
 /04vJ+cb+LB++ula10ICgxbkHK1r0nqoTVKsmoZrHUCfZM9U0TAX2LvFf5x/B48nWPeGOPCkH
 4iT21LjFFP/q0avGdDvR/mpHme1rh0eLfgm39tl6vFOFp45kcj45iXaM3o046hDWPu6HsMYUO
 q1qzqpyprh8UQ2Je23/YHFuxC2fQELlZA6kMOCW5Bt05iBYgrS0TseNXMKkG+IdD/6UQLEczV
 Mkbi5utSmXKR/4=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Nuno,

Am 28.06.19 um 14:30 schrieb Nuno S=C3=A1:
> As stated in
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/spi/READM=
E.md,
> one of rx or tx buffer's must be null. However, if DMA is enabled, the
> driver sets the SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX on the
> controller flags. Hence, the spi core will provide dummy buffers even if
> one of the buffers was set to null by the device driver. Thus, the
> communication with the 3-wire device fails.
>
> This patch uses the prepare_message callback to look for the device mode
> and sets/clears the SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX on a
> per spi message basis. It also assumes that DMA is not supported on
> half-duplex devices.
>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

i never tested the 3-wire mode. Could you please describe your test setup?

@Martin, @Lukas Are you fine with this patch?

