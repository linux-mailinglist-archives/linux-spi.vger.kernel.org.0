Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52D3747C1
	for <lists+linux-spi@lfdr.de>; Wed,  5 May 2021 20:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhEESFN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 May 2021 14:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbhEESEF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 14:04:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D2C05BD00;
        Wed,  5 May 2021 10:53:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k19so2569395pfu.5;
        Wed, 05 May 2021 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDKg4mIUMZnE/JrC7X2e+MMaJ9CLRzlBqkqPHaqh1LM=;
        b=Qo07t3RpkYdK03HWPIe1I9P33+dljf12eNDzCuI2GWRL0veBA54NVwyH0iapY//I+l
         kmz74snJiSPv2nDcO+XEsfY2z6I1sSjKi+A8pob8VNgedtJHSwX7ZXCV6ywTOx4wbreH
         GQy0Bz4tegVs5mrxDmww9wxwpmHDNg/0yzd4NtexH2u/xSv9v+c7UO+Xd1H7MWP60PjJ
         fZ30LmFKDgauh3wNmTsTDh6G6JvR4JcLt4qL8o0AfIEpiQFBtSYNi86ww74R+qltMoDr
         mky9VSotYeQeq4kt8BChHvTDPGnXnvv/n+Po6Kwb52S6tnLYDQbiw9i+/dKogQXrPHQl
         nmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDKg4mIUMZnE/JrC7X2e+MMaJ9CLRzlBqkqPHaqh1LM=;
        b=nHxOm0+V1nCewEYZmtXm9Y+pBkQN5zDjs8cIQ1ywc6rdwKBHo/RB/6zctWensLHWbC
         VQ2KyaG+c2ZoWwiXP9U3apEW7wLl2gekSscQmubYglUFVHc/UbC5Yk6zlylKwlStQBkw
         fRemZ+d+Y4uwtmR7AvEGSTB1Z1oiQtTQvpAdzZJFTmE0jxOk8QX9gtJxBmgpaPFUQo/M
         KAsNEmAfF973q14gcxJ9yVCOVbBVSThAAh60dIgFOkgbiB6Fy6JodfIOmpa8AP7KtT/U
         FBcjZGNTdBBK33opi5Xa9CyFZ2L2Lq+LPAaoVAgKLFp3YQEe3ZAq7CFSc8MNPIDIj/dG
         aB+w==
X-Gm-Message-State: AOAM531a0wEJvCCQh8ftrABTL7nUrEripq2BlnJrlTnLPKA2p7XWJv2I
        nt9Zt1pPivNcKKkLOF/FrVdsdc/5yai+zGEVY2/Gx9osUuA=
X-Google-Smtp-Source: ABdhPJx6hBieKqvSvFkRilID+i2xYAXr3nVhf/5Pn/Xth4HCHb+XtnN2WS1AMaIkE5G0V4Tqdc+XRrD1Xze3e1c1wbM=
X-Received: by 2002:aa7:8e85:0:b029:28f:2620:957e with SMTP id
 a5-20020aa78e850000b029028f2620957emr23865pfr.40.1620237210545; Wed, 05 May
 2021 10:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210505164734.175546-1-saravanak@google.com>
In-Reply-To: <20210505164734.175546-1-saravanak@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 May 2021 20:53:14 +0300
Message-ID: <CAHp75VeDzOZ_j30v=rgec2d9f6pPXHXE8BqJN1ARoYkfGL=d6g@mail.gmail.com>
Subject: Re: [PATCH v2] spi: Don't have controller clean up spi device before
 driver unbind
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 5, 2021 at 8:26 PM Saravana Kannan <saravanak@google.com> wrote:
>
> When a spi device is unregistered and triggers a driver unbind, the
> driver might need to access the spi device. So, don't have the
> controller clean up the spi device before the driver is unbound. Clean
> up the spi device after the driver is unbound.
>
> Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
> Reported-by: Lukas Wunner <lukas@wunner.de>

And
Suggested-by: Lukas ...

> Signed-off-by: Saravana Kannan <saravanak@google.com>

...

> Can you test this one your end to make sure you don't have issues
> anymore?

Do you need a test on my setup?

...

> +       device_del(&spi->dev);
> +       spi_cleanup(spi);
> +       put_device(&spi->dev);

This block deserves a comment in the code.

-- 
With Best Regards,
Andy Shevchenko
