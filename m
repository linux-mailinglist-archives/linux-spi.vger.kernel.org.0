Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AAB493846
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbiASKUp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 05:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbiASKUo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 05:20:44 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A1C061574
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 02:20:44 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id n9so1185547vkq.8
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 02:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmVHWOnUtiBgSGHEmeCT15nHc03Hy4faMmC7ZVSjOWU=;
        b=s0WTcZw9W/67pT4Ll1semW0LJhuqEWo88jJGvyGJmZK6ndeGAnvdTnGzQuMaDHrrGw
         L7kbz50eiOuSmst0KIyo0T+FYBh8zO4gH7h6msn9icKJlYTNHLrkCz3k/0sivkG/iXQw
         771Iv74UbzmcnE2g59L58+FfzYm1wtv9YHJVIll2C7vOShY34lxZ1RbWxUHjDPSG4q38
         2ZS7UV2Fx1J40TLlZDVgNkA9qCAdQDn1PatjG7Scxkoz442tDqweRhgPhWrwNT1RuMb+
         erK3pm3qDdzcmRBrarpZkQj9iNK2xEXlb4HvMPKFbWxfSnJ0SFkYQzVbg3kWjjU4KjS+
         UIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmVHWOnUtiBgSGHEmeCT15nHc03Hy4faMmC7ZVSjOWU=;
        b=7kfDygVmDr8TshsYPWvP5CH4KPSPkXVpfRS19MUfShmMhD9Nodp5Byx7/f7lrsi31Q
         h9o6j5reLBfqASk/3GN7AkTayizmgQjTotiSAo83CoeselZUJciyAmTRRbvfaa9/4GfJ
         Gtev53jWAQhb/9YCefEsQfDUFsYN/bD/0nJSDdXj1meCgfc7uW5uwmb3VY8KfHJuBq6F
         QpN3hUwDE0K2P3bcYAzZRqwNGk+NfRc7arl8+zMzoeNRaV248vix3bA9CEjJrH3fnfIK
         1QgB/tDKaCxJKKevN2poeNp0J3mpBTa9uGonVW1yGGaws+zpBkVrgy99X4Pw0lpiaDB3
         Rehg==
X-Gm-Message-State: AOAM532b5VNpnEuDLnzzFh2vA2MvUiynRu2gIO9uZO4MTtq0Pc3Kb7eX
        uika0lk8OzIEAp3dUqsOYrEI+plFyqFZeUzAgR858w==
X-Google-Smtp-Source: ABdhPJz7/UUqwnG/h9JInWVKxiGqIW5MsJRj+siQVr9dNB704Fl7vZjSX1OdQ5acyv53wpMwXLpX8v/fgYfYRBCKOts=
X-Received: by 2002:a05:6122:7d3:: with SMTP id l19mr11505967vkr.35.1642587642669;
 Wed, 19 Jan 2022 02:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20220118230915.157797-1-linus.walleij@linaro.org>
In-Reply-To: <20220118230915.157797-1-linus.walleij@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 19 Jan 2022 12:20:31 +0200
Message-ID: <CAPLW+4=x90Q17GRW9mAapyb376u2sJE2f8UOmNcvMGB1u_ErZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v3] spi: s3c64xx: Delete unused boardfile helpers
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Jan 2022 at 01:11, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The helpers to use SPI host 1 and 2 are unused in the kernel
> and taking up space and maintenance hours. New systems should
> use device tree and not this, so delete the code.
>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - No changes
> ChangeLog v1->v2:
> - Split out to separate patch
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
