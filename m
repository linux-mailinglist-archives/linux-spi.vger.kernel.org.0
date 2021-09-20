Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E779C412BAD
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 04:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348623AbhIUCX4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 22:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhIUBvJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 21:51:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00191C08C5CD
        for <linux-spi@vger.kernel.org>; Mon, 20 Sep 2021 15:25:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so73710176lfu.5
        for <linux-spi@vger.kernel.org>; Mon, 20 Sep 2021 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cUu9VGMYIviHDNWMaTxRPftrEu1m5ny0sN1YPzgobHQ=;
        b=PHlOnMK4h+zWE9JtbKEGLgb0bKwd52eH9oG5WEiTQnvqfHnkIl0XWwCwlk73+boP53
         w19A4bqTnRug92cETmx1GqXXoxpR9rjGNNWqi5Jm9ws7e8OwcDCxfkid6KhaTPKyyKTG
         UhBm4KcEePhVtbbiuECkqP5KgfPqR2BJWvNEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cUu9VGMYIviHDNWMaTxRPftrEu1m5ny0sN1YPzgobHQ=;
        b=vHcEc+jFcZhuGUK5hANd4O57Fai95haPtmV9FXcSVME5wkStyOshXSglAXEEn+3kaV
         MT/WmvUJkgoWVzSf86akyx7PJo8QWPSZJl2MOksnxpmwCNU7cAMBOzycApF0qm3V/M0H
         fIp1Ysfya7PtS/hYK/D83BLbokExV1wf3Xp12vqS9z7WqO9jESlqgCTAP4npbKanJbfk
         akKccYAfZZ/7Y1A1EMaXIkLGEiGRPgk1CQNvXuP5ePw3EPaZf0c2IO7spMutL+Ehb+3q
         vvARUY/LRSNkgqXLf+nkBR8bGmVhA9/x+mFuXQNnyhhHCsgXsWlxRyTGmBDvwnwqvLco
         xLiw==
X-Gm-Message-State: AOAM5338PP7+3pUI/Fu/851R6NZxZLOd5NXKt+u7aGJQBvYqlWDRjeIr
        9Tbre+VdwQ5Yw0/BaF3ITyimiHtilJvRl27WNrA=
X-Google-Smtp-Source: ABdhPJxUsYERS1I3f9JetZPvbH+85jECX2Y5JmVgq+o+w64u+HqlxSE24Upm8/0mUM0HWwS0YfN8+A==
X-Received: by 2002:a2e:99d3:: with SMTP id l19mr12829051ljj.184.1632176739736;
        Mon, 20 Sep 2021 15:25:39 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id v1sm1901727lja.134.2021.09.20.15.25.38
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 15:25:38 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id b20so15048052lfv.3
        for <linux-spi@vger.kernel.org>; Mon, 20 Sep 2021 15:25:38 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr17078215ljb.95.1632176737881;
 Mon, 20 Sep 2021 15:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk> <871r5j6nlw.fsf@igel.home>
 <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk> <87wnna6hdc.fsf@igel.home>
In-Reply-To: <87wnna6hdc.fsf@igel.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 15:25:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7DB2SJ-wngVvsJ7Ak2cM556Q8437sOXo4EJt2BWPdEg@mail.gmail.com>
Message-ID: <CAHk-=wi7DB2SJ-wngVvsJ7Ak2cM556Q8437sOXo4EJt2BWPdEg@mail.gmail.com>
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
To:     Andreas Schwab <schwab@suse.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 2:56 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Sep 20 2021, Russell King (Oracle) wrote:
> >
> > Module autoloading worked before.
>
> Nope.

It clearly did, Andreas. At least on Macchiatobin.

Maybe it didn't work for some other cases, but the point of
regressions is that they are things that broke that _used_ to work.

Other cases - that never worked - are not regressions if they continue
to not work.

And the thing that makes regressions special is that back when I
wasn't so strict about these things, we'd end up in endless "seesaw
situations" where somebody would fix something, it would break
something else, then that something else would break, and it would
never actually converge on anything reliable at all.

That is why the regression rule exists. It is NOT ACCEPTABLE to fix
one thing, and break another. That's not a fix at all. That's a
regression, and no amount of "but but but it fixes something else" is
valid.

So don't make completely garbage arguments. Russell reported a
regression. Denying regressions is not an option.

Yes, we have situations where even regressions don't matter - like
major security issues that simply cannot be fixed other ways, because
the regression _was_ the security hole.

(Or, actually, more commonly, the "nobody noticed" hole: a regression
is a bit like Schr=C3=B6dinger's cat - if nobody is around to notice it and
it doesn't actually affect any real workload, then you can treat the
regression as if it doesn't exist),

            Linus
