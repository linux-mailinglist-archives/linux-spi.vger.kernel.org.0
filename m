Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9092D7688
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 14:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405620AbgLKN2I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 08:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393478AbgLKN1k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 08:27:40 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32FAC0613D6;
        Fri, 11 Dec 2020 05:26:59 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id w18so4744647vsk.12;
        Fri, 11 Dec 2020 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1/RspAKjZgyPjqvePnfLw/JLs7QZEV6y3qM4NdpChZ8=;
        b=WqK4tQVyHKPUX2vS1/6FjQxh3lZUX+ammHgyCkeObQqzs74XsIxyvcMgrtCPiUbhM7
         ZYixP4rVFjL7xNKHYpp8IKrxJW7QtwxCRI8IUuXwPlxqiAzjalM+6s4mwyhD4stcG6oy
         N5ZkTqIAyqX1Wby2/WD01NvuI7xCQVWVaBZ4LP+2dDh5AizDM4+VElLHTN/TEDi14oOt
         bLXtZQ5VLyWmgHRZLp9gE330Y/Z6TPUpXgUmgxTmt88+hlgVbHtjNGHDPX0J5bjEm1L6
         YLjYWUlMG0c7OFCcPsWV8fnD0/4ycAMQ0mP7PmgW5j6fERHrQKsxjjvqBA+hrQgNY1y4
         R60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1/RspAKjZgyPjqvePnfLw/JLs7QZEV6y3qM4NdpChZ8=;
        b=H4Pm6eLLqy4SF1rVGDh0ognC5MxB+/VOtpES2TLkbFRt56GoTmBn3Q3w1EVIadREr3
         k59SgEnmPAUmr4Fsa9aZFlUH/dikAMpVmKviEMDtpriEnDmlqteFjFUTg2SVV7z4wRcg
         tybBKgchT2KDK6b6xNFeyeQfGHWIWVPD9qTutF+3qQwXUl+e+m3/y8Jul9o0q/VfDeWj
         c2VRnCb1ujzgSL3yrGBvThsnX4Yqhs+B+qfFAaY7HkrRRr8PXZuiNh49tp5DmIqmlott
         HRAUYII0SrHKhQIjQ88XusOH0LWfcKJw4t7SM3pl9vXmHAPG1ZZiiZFjAbpc5o2S1TsA
         sTZA==
X-Gm-Message-State: AOAM531AgmBI04e9IRJ1dSpk9X0OjFJusJKmYDzXvTZNj7YubWCdkEnh
        /Uue7azW8rATGuQbKUUdEPHrmRJk4q/i8jRyIQIuh3rxAMM=
X-Google-Smtp-Source: ABdhPJwG/LTrHfT2E3+VpuHwgiyea0jypRuNZsUmI2noUo2EC6Jjo9106ePLKYBEIJh1Q2Lfrfrik5hiZtp17Y74Wi0=
X-Received: by 2002:a67:d319:: with SMTP id a25mr12316519vsj.57.1607693218640;
 Fri, 11 Dec 2020 05:26:58 -0800 (PST)
MIME-Version: 1.0
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
 <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com> <20201211131810.GB4929@sirena.org.uk>
In-Reply-To: <20201211131810.GB4929@sirena.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 11 Dec 2020 08:26:46 -0500
Message-ID: <CAGngYiXOkbQNgPcw9dk33VJiTe4jEjBUEC83vwVds+2Gd_O5Hg@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and
 gpio descriptors
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 11, 2020 at 8:18 AM Mark Brown <broonie@kernel.org> wrote:
>
> Yeah, it'd definitely be easier to read and clearer what people should
> actually do.

I think it would be beneficial if this consisted of two very clearly
separated parts:

1. the actual recommended binding - so people writing new
devicetrees know what to do

2. the legacy bindings which "also work", which is important
to know when working with legacy devicetrees

At least, that's what I would want if I put myself in a user's
shoes.
