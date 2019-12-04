Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209CC112DB5
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 15:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfLDOrK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 09:47:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38165 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfLDOrK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 09:47:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so8417203ljh.5
        for <linux-spi@vger.kernel.org>; Wed, 04 Dec 2019 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dd6qtsyIVCGRGuNUcTToh40zKwEE5g2OPPazq4Ye+jI=;
        b=QW5Uv+xmXK7EKs1Hmc4gLmSIEGeVGQaX6SsgtRCJRLpXZO6wVv3HDNDIlJR4rAa0TW
         82CrvLBQDugHsGI0v6m/2bDoIrp/2evwczV9YCS7B6Mtmrn1YeO+NepDqwK7V4OyjREo
         5V4yD40wWg/GJkxV5ib63Anz4gEkNx+mIJzNemJ6aOnVy8VUiriZr7eJZDULQ+90W5R+
         m5J+ZTwjze0VcJ/+bX00pLJjD008mYxBT2q/GoK22c0KRoRYe+3IYIG1LHFeeawoVzJX
         d9n35JXolwdfdYG1nSIUpvTYR0spU9XGzh7wtbiMpjjcya2y4LR164HGbDKz2vYpfC1g
         ccKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dd6qtsyIVCGRGuNUcTToh40zKwEE5g2OPPazq4Ye+jI=;
        b=f5NLuLRbQ8fDnwl3IaFXGt4OAJBZAVExFwMU3k4iIbrWNs+iBk4zGA2bAWXLkv8kPy
         eYIf6Idks4MKbPJosoM2xeECqkcqXZDtfljeJ92neAJZ947aXjNAMqNK0EayBcz3150j
         JJLvbeAdIuROdqGGKYQvgoziPI3jDxHOz6u+J/V2m6uzvxJjjx0OfcBs1iYuthmY61ha
         TnEZkj6+3IRKkx1ACQDORgG7+B0hl7ma9JpnZRryU7WzRv9zL9c1PmuQs35CU6nVVSPB
         oUbS6GxXBkVN4t4cztmRzbnPUDd2vBPSK4AIkjl/f0Ko1SqJHIoaNjakgRfZxosN9Z+n
         p+1A==
X-Gm-Message-State: APjAAAV52d+C/784CaAiRmpXL1E2Q8QU2GHwJ8JAvP+5xrvk7IPSga4p
        OV7nU3nCw5rA2VsbzK0IAuLpasED+wRM0hWeRzQcAQ==
X-Google-Smtp-Source: APXvYqyFDHM4spp1vtK8S3nBLuw8l0xIF7nvdqtjdaw5r0wgAjBn9x3MGzNL95Y/Zp3eNll4jqNkKnJAqendK3TWS7E=
X-Received: by 2002:a2e:9587:: with SMTP id w7mr2186691ljh.42.1575470828107;
 Wed, 04 Dec 2019 06:47:08 -0800 (PST)
MIME-Version: 1.0
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk> <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
 <20191203163521.GM1998@sirena.org.uk>
In-Reply-To: <20191203163521.GM1998@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Dec 2019 15:46:56 +0100
Message-ID: <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
Subject: Re: Side effect of SPI GPIO descriptor usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Phil Elwell <phil@raspberrypi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 3, 2019 at 5:35 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Dec 02, 2019 at 02:11:51PM +0000, Phil Elwell wrote:

> > Applications using spidev to implement user-space drivers need to be able to
> > set SPI mode, CS polarity etc. at run time. I agree that there
>
> I'm nervous of spidev user doing stuff like that with the chip
> selects, with DT even spidev devices should be registered
> normally, you will get a complaint if you register a raw spidev.
> There's no free pass for "oh, spidev can do anything we don't
> care" here - the DT should describe the hardware, if some of the
> hardware happens to be implemented by spidev then fine.

I agree with this. In 99 cases out of 100 it turns out that the
userspace driver is a substandard version of a driver that should
actually be in a place such as drivers/iio and what we end up
supporting is offended userspace driver authors who are acting
against the interests of the kernel community.

I have come to accept the usecase of userspace GPIO for things
like industrial automation one-offs, random hackerspace projects,
and prototypes all highly custom, and with such high friction with
kernel internals and pain to carry forward should be expected.

With devices on SPI and I2C I get really sceptic. What are those
hardware devices, and what makes them so fantastic that they
cannot use a kernel driver like everyone else?

> That said we do have other in kernel users that do change modes
> at runtime, though I'm not convinced many of them have GPIO chip
> selects.  Linus?

I looked it over and most are devices like board files and RTC
clocks that enforce SPI_CS_HIGH. They seem to be native
chip selects so it will work as expected but I will look it over so
I haven't broken any of them.

and I can find one more outlier:

drivers/mmc/host/mmc_spi.c, function mmc_spi_initsequence()

This very clearly want the inverse polarity of whatever was the default,
but the code assumes that SPI_CS_HIGH implies that this is the
actual physical level and forces it high, then low. I will send
a patch for this: what they want to achieve is the inverse of
whatever was configured.

The driver drivers/net/wireless/ti/wlcore/spi.c does exactly
this already.

I am a bit sorry about the semantics of "HIGH" here when the right
word should rather be "asserted": it's named like this for historical
reasons.

An alternative would be to let SPI use gpiod_set_raw_value()
to steamroll all the inversion semantics in the GPIO library,
and SPI_CS_HIGH would literally mean to drive the physical
line high.

This may seem like an intuitively correct solution but
it has implications for everything using device tree to define
SPI clients: spi-cs-high in a device tree means that the
CS is active high, which gpiolib currently detects and
handles by way of disabling internal inversion (the default
for SPI devices is active low). Previously the SPI core would
set SPI_CS_HIGH and we would then just double-assign
that in the SPI core and then again in some drivers, it doesn't
seem much better to me.

So I will look these over, but if people (and especially the SPI
maintainer) prefer the semantic that SPI_CS_HIGH does not
mean "asserted" but takes direct control of the physical
level of the CS line, I can do that instead.

I could also additionally patch the whole kernel to rename
SPI_CS_HIGH into SPI_CS_ASSERTED if this makes things
better. (Would be a two-step patch rocket adding the additional
define and switching everyone over before deleting the
SPI_CS_HIGH.)

Yours,
Linus Walleij
