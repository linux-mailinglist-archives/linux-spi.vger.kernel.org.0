Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB6154419
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBFMdp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 07:33:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42807 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBFMdp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 07:33:45 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so4385223oih.9;
        Thu, 06 Feb 2020 04:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dwu9+M1njdJBY6aZMkgNZ/xNqYgz8F6CkmlHNEJ8K4=;
        b=ipr8G0oq3/9GkypLx7ETR2h2vzNVDKRs0jKcrjqsQooSJFCdpcbkKGAvXPyl30jPQS
         jEnPimJLDI9GkLtDJ7yq4du+iO/DI29Tjk2ENEtlYBVxy/d6B+AIphk3jO9s/b5HUzDP
         v302eX6e5F60b3czn4g3qbvtfT8IdZkTH8Pdy7Y1RLizf6a2QaUUtpbAJXmbnyltk5i7
         8Z+zWFGMopShPkR4Ro6CkFVwJh3kTtTdJvHOXwczgHZQLUGYj72OS+Ub5lOjARqSSIq1
         iKRAV6VbVA8YdrG3tVIpBCduLzKpIfOcX5+nsfsQowILIoXY/K+FUT3Rs/Ke5eTdT9zd
         29Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dwu9+M1njdJBY6aZMkgNZ/xNqYgz8F6CkmlHNEJ8K4=;
        b=qN++YBNkpDEvYyof62Gw2q2iH0Y3wtrIwA6n+QcjOHbDsZwjWx7OMdPH5TakpcJiUl
         vYETcyThaMRmA5L9eUwovxl1oY7LscnKWldbLCaI/Rdn3Y7XOjdxcZ7kB9DSuHt7B5GI
         fO+1cHxnmp2JAzNRacewl7oF6oJUjeo+W44LLwerOHTd0WwVoutCy25O+Po1SwKGMOJS
         x3XLFwCLZrSv/HOKUjcKe9LEkyfaBJae/yXZ8Nxa3lzD5rEFTuJQf04gu9DCKG+9EF4W
         32LiryiGGcbZ94LIhwfVwhrH5HIDBJhOOXJMPY/p/rjU7Wn7EicugWhwVWjwVsrl8bM3
         BwOA==
X-Gm-Message-State: APjAAAXDcIbOTYAOogEM3yIiQ3fPJrgNbTD4lEKcgl9qAfKFgbAeWSTT
        5ymtWNnnj0FG3E6tTj+7LE3eGHV7XF31u04hp9A=
X-Google-Smtp-Source: APXvYqzuJ5lwxrGf9fe9iJeBq2f98amMywZJD9AQ+A/h3vBiG8YknFVONOkOqjHcW0IqR+iVI1+7GdFaiBKhvkjJ0lA=
X-Received: by 2002:a54:4896:: with SMTP id r22mr6786997oic.30.1580992424102;
 Thu, 06 Feb 2020 04:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20200206084443.209719-1-gch981213@gmail.com> <20200206084443.209719-2-gch981213@gmail.com>
 <20200206113158.GK3897@sirena.org.uk> <CAJsYDVKnOv+4NT8V+9fFy_0KE7QSoeTL0jHTdq31Z=88vBzHgQ@mail.gmail.com>
In-Reply-To: <CAJsYDVKnOv+4NT8V+9fFy_0KE7QSoeTL0jHTdq31Z=88vBzHgQ@mail.gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 6 Feb 2020 20:33:33 +0800
Message-ID: <CAJsYDV+C+-uqurM+yTS3XXXrEDe+G3XFrpYEAaZLvzECLNoF+A@mail.gmail.com>
Subject: Re: [PATCH resend 1/2] spi: add driver for ar934x spi controller
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 6, 2020 at 8:30 PM Chuanhong Guo <gch981213@gmail.com> wrote:
> > It looks like this could just be a transfer_one() operation
> > instead of transfer_one_message() (which is what this is in spite
> > of the name)?  There's nothing custom outside this loop that I
> > can see.
>
> Chipselect is also handled during transfer. Controller asserts
> corresponding chipselect in SHIFT_CTRL register, and if SHIFT_TERM bit
> is set, controller will deassert chipselect after current transfer is
> done. I need to know whether this is the last transfer and set
> SHIFT_TERM accordingly.

Oh, I remembered that I saw transfer_one function name somewhere and
thought maybe I could shorten the function name a bit. I'll correct
this back to ar934x_spi_transfer_one_message in v2.

Regards,
Chuanhong Guo
