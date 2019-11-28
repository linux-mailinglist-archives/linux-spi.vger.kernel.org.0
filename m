Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EF10C54D
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 09:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfK1IkU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 03:40:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35428 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfK1IkU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Nov 2019 03:40:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id r15so16457598lff.2
        for <linux-spi@vger.kernel.org>; Thu, 28 Nov 2019 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JqMG1d/lOL1srD0/KuAfIZSpr9D48XI4hlM2DvA188=;
        b=bZEuPxznYkkUMn6qZgpnuvM4gNag52WWCk/RUTwcK007r3a7ezGpkJ+hXLG8VnipQe
         tbqFGhp2tyCkXFj1Pc4BF0pO+lQGc6wCc9gWTYbSBR2qvBv0i0wuv5FMBkVuA79+Hawi
         Czl2kNrVhM7xEMRkSFc81ooawACro7k2n2UQ9WJWwY9UD/2G0s78VvjqKXtCUXSCIZ3+
         GYcFYDf5b/9VDnpfUz0w2lj14wRRLGGbkcnb32aAXQdgNww0u+ALp9B7mlDguNXxtU41
         pEZnCG7TjEIE32fOOYuqPLkxo4JrV9w+FakvpbwfTFutOZFAgRyS9fDItvfyWCrtnmKo
         pw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JqMG1d/lOL1srD0/KuAfIZSpr9D48XI4hlM2DvA188=;
        b=K+rmACR5euWISndTeJtp6wWrMbEwW2ytNEJIFDMYOBU6uFWTAMgWpjlVoW89MaFBEE
         uWi75e8ig4lKwtAvfzEwqZibg+QGUVW+59KDGJjI0CHYT+sOr6zR7u5eZrcwBA9Vg44d
         v3+CNLFLeUA8fMeXqo9vc2BvfBl9u312Oy4YZO9/+68R2C2ccBOoBifQjBhapKyMhGeF
         qtkALWsS2etx9QCyU63WzgfCoivRriNvHPQefnEwGY2+6LGqYlAEaYRcjiJgznvS8unB
         XhlmSKumtRh/t+YPczzRkKJofqk6h5oRLI9uhVbHIHVx9Ao96Pmortce5JpRdbMDwqBF
         UF5g==
X-Gm-Message-State: APjAAAX2ZFA5V7/P0N9LAM8N1BOmcus2lq0VgQb0JYXzcureYo5UHDCF
        +pPptq9T+v3n+EUJX3hJsO1se9YJ0h2GlrhzuF7uUQ==
X-Google-Smtp-Source: APXvYqxtG/gdvoyr7WyQ5q4Y0yE5V49M3E8UCbzdSLCahQX17AzyxDGbF9OSSPKMuehEM57zKAoKWOxxW5wSb1klq2c=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr4280450lfi.135.1574930415765;
 Thu, 28 Nov 2019 00:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20191127153936.29719-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20191127153936.29719-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 09:40:04 +0100
Message-ID: <CACRpkdbSmk0iDBbfCWpsT6FnU6mzynCknfJ8K95VNRqK6=_XyQ@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: Correct handling of native chipselect
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 4:39 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> This patch reverts commit 6e0a32d6f376 ("spi: dw: Fix default polarity
> of native chipselect").
>
> The SPI framework always called the set_cs callback with the logic
> level it desired on the chip select line, which is what the drivers
> original handling supported. commit f3186dd87669 ("spi: Optionally
> use GPIO descriptors for CS GPIOs") changed these symantics, but only
> in the case of drivers that also support GPIO chip selects, to true
> meaning apply slave select rather than logic high. This left things in
> an odd state where a driver that only supports hardware chip selects,
> the core would handle polarity but if the driver supported GPIOs as
> well the driver should handle polarity.  At this point the reverted
> change was applied to change the logic in the driver to match new
> system.
>
> This was then broken by commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
> setting when using native and GPIO CS") which reverted the core back
> to consistently calling set_cs with a logic level.
>
> This fix reverts the driver code back to its original state to match
> the current core code. This is probably a better fix as a) the set_cs
> callback is always called with consistent symantics and b) the
> inversion for SPI_CS_HIGH can be handled in the core and doesn't need
> to be coded in each driver supporting it.
>
> Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks for looking into this Charles!!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think we should have all regressions covered with
these two patches.

Yours,
Linus Walleij
