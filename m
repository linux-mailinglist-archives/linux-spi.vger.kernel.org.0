Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90401E1E00
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgEZJJa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgEZJJa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 05:09:30 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8B3C03E97E;
        Tue, 26 May 2020 02:09:30 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u23so8053913iot.12;
        Tue, 26 May 2020 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65DH7Yx0+fRXnGfTN5n2O+g3E3WvwmCcWicmHyQ3lkw=;
        b=FCv7xAIGa3GDtpOxxLydbMoT+Iw41+0kjN35MW95QkVD8PAPGZ1TxmVabCgrmY78yz
         YECjqBhJyS3zolx/8xJBac4XU6h6cR1XZeg4CU6PHNTd2M9LqK+5kG/wEL7WsNC0nwh2
         gpV6e5BVy/uEF4hB82amE9VWBObm/w9rtxMNYLCy9RJ2jehRXjw+lDnYVC8orvZjHDMT
         rL1IDBgV7Kaq4tgq+ETv5CEvY8otenJzY1txlxblMAVo2Q6SsJnSDaWGL8pbVwNfm6XY
         8lo7KDJvjfz2uLhMVx5UTVNw3KpZA0aLli0XNP1vDH7YD/+aT6hJGg+YsCdtPHB995O1
         j2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65DH7Yx0+fRXnGfTN5n2O+g3E3WvwmCcWicmHyQ3lkw=;
        b=qKNc1yX1g8245qyiSG5cAnktwmY69g4PjNmk4npfXv01WIdrjJganwbsMVy2gFozTX
         6aOb9jmg5YigNJCa8qFGrA2YNQaiPqUvPA26Z4AXepOuX2aNf7+UMsqtZhp2OG0vUojZ
         +u6S1PjLCxsFKunCCuJ13rOa2gp85Ht+PVTz7O3d0abmy+Qdh1bH1Du010OpLWC/j3/2
         3vbP2vbjTzs619OSaFZo2prp9lIntnp5ULtRUaZmryPUtlqo10Z+vJkEs9Z/N9ZYA4PS
         ysTrjMb99/1ccL7flc/SFg7mAGgwnonqllHvRpZW+OsVMwNZLkQ/3oiUZTvsl7Va4U5O
         APwQ==
X-Gm-Message-State: AOAM533+PN3YntCHmeCKfp2gbixEHmTVKIrmDRqfzRwkyTToNds8WJux
        xHBb7nh/MR96aAD9uZeyz+jPBgUnQvo9H3ELeNk=
X-Google-Smtp-Source: ABdhPJx+ZPvWfEF3Pa4JXfWwedh02p2n1SzhlABrsxCC4DunBcpjHogzclvpkhogi3xaE3bp5rzPidO7NY54+A2lD6E=
X-Received: by 2002:a5e:a80e:: with SMTP id c14mr16354378ioa.3.1590484169175;
 Tue, 26 May 2020 02:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
 <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com> <CAHp75VebSZa6mwAETnM0t42RQCp4iM6_SNjmy3TB48ixsGKV8g@mail.gmail.com>
In-Reply-To: <CAHp75VebSZa6mwAETnM0t42RQCp4iM6_SNjmy3TB48ixsGKV8g@mail.gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Tue, 26 May 2020 17:08:53 +0800
Message-ID: <CAL9mu0+jmcivC6zAXxK0-oXy3n44pAU1QGD7BDq=CT2D7twROQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] drm/panel: Add ilitek ili9341 panel driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

Thanks for input.

On Tue, May 26, 2020 at 3:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, May 25, 2020 at 6:46 AM <dillon.minfei@gmail.com> wrote:
> >
> > From: dillon min <dillon.minfei@gmail.com>
> >
> >     This driver combine tiny/ili9341.c mipi_dbi_interface driver
> >     with mipi_dpi_interface driver, can support ili9341 with serial
> >     mode or parallel rgb interface mode by register configuration.
>
> Noralf told once that this driver should be unified with mi0283qt.c.
>
> So, what should we do here?
>
> --
> With Best Regards,
> Andy Shevchenko

from sam's suggestion, we can't setup two drivers to support one panel
in the tree. so, i copy the mipi dbi part from tiny/ili9341.c. to this driver
from register settings and dts binding is keep the same to tiny/ili9341.c.

so, in my opinion if tiny/ili9341.c is unified with mi0283qt.c, this
driver should be
too.

thanks.

best regards,

Dillon,
