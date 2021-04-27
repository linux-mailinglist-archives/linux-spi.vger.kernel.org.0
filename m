Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55FA36C839
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhD0PDw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhD0PDv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Apr 2021 11:03:51 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AB0C061756
        for <linux-spi@vger.kernel.org>; Tue, 27 Apr 2021 08:03:08 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g38so69707739ybi.12
        for <linux-spi@vger.kernel.org>; Tue, 27 Apr 2021 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H92+N+prJ9eTKHDD8/4/0qtkC/Zf8dyWoXvBvNJ5DRs=;
        b=vVnbqNgEIZtU8E6xziLFqgV85Oogu5BdWdOwAm8qGkxtx8wOzu2YOwHj0PL+AeyZ3L
         gn6Z6WCH9gNaa4YXZQTO5JKTg5DIU0h3cmOb6FFTd6wA/FWn2rg4Ek20OWCvorx8FeyS
         9O2Aj/5AdZ+B3GzAT2s9SijS23+QuVx/txBZtx/ASgzer3VcF4uDZvq5xp9j1pHX9Nq+
         aHtF1mEcNRY0gBtzX5DoV2uxc41XAp8y4d5RoyGCRGsqSv3Oalq+7U6yAvPWoL3HGL6p
         sqaB2fcO07rHwkMcuoZl9qONd2Vbf9Y+X8AGNQBtuLgVOjvXRAJeT/9bBkOhaYE5HBH/
         MQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H92+N+prJ9eTKHDD8/4/0qtkC/Zf8dyWoXvBvNJ5DRs=;
        b=JfxlfvIAtq4RnwXP4UtU3R7CooVXVbkmWGS3X8E12aDkDdxJgt3ORa6wOGGVojR/QF
         1ekLfszFcQLSJvoMjj4j0vlTumEEDDEqSJvcx79VGXcqoI/S+swVAIHlE9y0Zn4Nu2Ws
         KFJ5eAvEN5VocY7lJubZHyUJDMl8NItUEimvMm6xE3hlEfcvKH7rzecLO1PbiBESc7BD
         x1Lu12F/vYTGH+0waE3G6CmKAzXjjd9z7X1Y9ULRvU4iWrefZRIvRgeXFVvgcGbyGZDH
         ZSZ/nnxSory6UWqDseTALqmP3u3O8ec/IiNzHMxPixdnOby9ZoUWwwMNJ2NHChW3HSUJ
         wGsg==
X-Gm-Message-State: AOAM533PiQY/561TFcE3gTC8wSUe3dJO4n+HdfjL5b1KdJki7O6w0iWp
        5MG/V1+KHVyX7+KOETJ2SeUIAgFMYbNNp1As9U47JSHqCFY=
X-Google-Smtp-Source: ABdhPJyIROyxKNvuE/+7uO/JoiIaM5ehPc0h5Yl/Gl73ZhnszNHmoiHXSxaVLScqh1Osu64hDmC7ufhvQ+tJc3ceBkA=
X-Received: by 2002:a25:6003:: with SMTP id u3mr35067710ybb.96.1619535787277;
 Tue, 27 Apr 2021 08:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210426235638.1285530-1-saravanak@google.com>
 <CAHp75VeNZ4-TgkevNF5tgmB1eU9E77RNsPWRABp6PvC6eGpQrQ@mail.gmail.com>
 <20210427104851.GC4605@sirena.org.uk> <CAHp75VdpC687cHezCy5nP6BRYo-dS8COYvBBvu02f6W_dS6JEg@mail.gmail.com>
 <YIf6WeFCJaj404xT@kroah.com>
In-Reply-To: <YIf6WeFCJaj404xT@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 27 Apr 2021 08:02:30 -0700
Message-ID: <CAGETcx-eyP4vLn+qMN4nxMJg_0uAjP1YJqko86CivizSEf817Q@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 27, 2021 at 4:49 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 27, 2021 at 02:42:19PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 27, 2021 at 1:49 PM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > On Tue, Apr 27, 2021 at 09:52:48AM +0300, Andy Shevchenko wrote:
> > > > +Cc Lukas
> > >
> > > The cleanup callback has been in release() since the framework was
> > > merged AFAICT.
> >
> > Yep.
> >
> > Personally it feels to me wrong to require device_release() being
> > atomic. It might be that I missed something in documentation or
> > somewhere else that suggests the opposite.
> > But let's wait for other comments if any.
>
> There is no requirement from the driver core to have the release
> callback be "atomic", you should be able to sleep just fine in there.
>
> If not, something is wrong and has changed...

This patch is not just about the atomic thing though. I can drop that
from the commit text and I think this still fixes a real issue.
Calling code from another driver (not even the device's own driver)
during a device's release is not guaranteed to work at all (what if
the module gets unloaded?). And this patch also fixes some mismatched
setup/cleanup calls. Using device release for the cleanup() isn't
necessary and we can avoid this bug. This patch tries to fix that too.

As for the atomic thing, that seems to be a generic device link SRCU
implementation issue. It does a put_device() in an atomic context. I'm
not too familiar with the SRCU implementation or why it was needed.
Rafael would have a better idea on that. I can drop that part from the
commit text and move the atomic discussion back to Andy's "atomic
context" thread[1].

-Saravana
