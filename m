Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE734E42
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfFDRC4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 13:02:56 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:41281 "EHLO rs224.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfFDRCz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 4 Jun 2019 13:02:55 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 13:02:53 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.mjt.me.uk; q=dns/txt;
 s=pic; t=1559667773; h=Content-Type: To: Subject: Message-ID: Date:
 From: MIME-Version: Sender;
 bh=0j/8F2kGIW8C7lK3dd//5daAU2Hj/15k+KDHBHF9KUA=; b=Gkpd/z2VSXuEWXAXjbymQwa9QEYPR7uaBYMyobgkXgNCSJhhe7EWaE5dvI7630NERe3rAaCF
 +wcsJt5GufMPXfF+oNEeSucgCNaZ2TwNFRhnkNhvkhGq0LgryrvIbvGLz5gXfE9j4QxWBl+8
 y2GR5WN3HHmDnnB0eFdrbiyqm4A=
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJkZTFjYSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgIjU2NjRhZSJd
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mxa.mailgun.org with ESMTP id 5cf6a30c.7f0121122830-smtp-out-n03;
 Tue, 04 Jun 2019 16:57:48 -0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id r10so20242856otd.4
        for <linux-spi@vger.kernel.org>; Tue, 04 Jun 2019 09:57:48 -0700 (PDT)
X-Gm-Message-State: APjAAAXKg6iDoamU0uEVQy15IfrUQB6KN7BmsRrB1+oU5mle1SoEJA9b
        Th5AFJhK1CPoWAiyppQTXeFHqkrBcDvDGej+x6A=
X-Google-Smtp-Source: APXvYqwwjAb2mYuaHGGZpzskzbdks14RcsmQpeRNWCXwpviltmCYjJTH+pe8nMXh+YE18R3JONa/4cXXvPz48N1i2F8=
X-Received: by 2002:a9d:67d8:: with SMTP id c24mr4631477otn.190.1559667468246;
 Tue, 04 Jun 2019 09:57:48 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Tandy <lkml@mjt.me.uk>
Date:   Tue, 4 Jun 2019 17:57:37 +0100
X-Gmail-Original-Message-ID: <CAHGSkqiO8uC499-34OES5+ws6oohZnsm2uOb2ecL7ocGkjPoHA@mail.gmail.com>
Message-ID: <CAHGSkqiO8uC499-34OES5+ws6oohZnsm2uOb2ecL7ocGkjPoHA@mail.gmail.com>
Subject: Diolan DLN2 Linux SPI driver usage
To:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi all,

I have a Diolan DLN2 [1] USB-to-SPI adapter. When I connect it to my
(x86_64) PC, it is recognised, the dln2-spi driver loads successfully,
and /sys/class/spi_master/spi0/ appears. GPIO pins also appear, which
I have successfully interfaced with.

However, I'm at a loss as to what to do next in order to instantiate
an spidev device so I can start sending and receiving data.

Obviously, the normal way to set up spidev would be a devicetree, but
all the articles I can find about that are for embedded processors
like the Raspberry Pi and Beaglebone which have built-in SPI
peripherals, whereas I'm on x86_64. And as the Diolan is a USB device,
it could be plugged into any port. If devicetree can be used in this
situation, I can't find advice saying how to make it work :)

I found an article covering the Diolan's I2C feature [2], involving
boot-time configuration via a new_device file, but spi_master doesn't
seem to have an equivalent file.

I also read about manual driver binding [3] and tried echoing things
like echoing things like "spi0 and "dln2-spi.3.auto" into
/sys/bus/spi/drivers/spidev/bind without success.

I also tried reaching out to the three Diolan driver authors who work
for Intel; unfortunately none of them appear to work there any longer.

I also consulted the mailing list archives [4] and found a question
posted Gaston Gonzalez, unfortunately without a conclusive response.

Can anyone advise me on how to make my diolan device appear as an spidev?

Thanks very much!

[1] https://diolan.com/dln-2
[2] https://kernelsense.wordpress.com/2016/01/22/achievement-unlocked-first-iio-driver/
[3] https://lwn.net/Articles/143397/
[4] https://marc.info/?l=linux-spi&w=2&r=1&s=diolan&q=b
