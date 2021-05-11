Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329AF37B013
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhEKUbp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 16:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUbo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 16:31:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB2CC061574;
        Tue, 11 May 2021 13:30:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q2so16866276pfh.13;
        Tue, 11 May 2021 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PE0hBBCsTSQSvfTQ721B04IeihNT2na4KBLVRKgcCLI=;
        b=WFFym+04S4Z0uF0S3cDzq5Q6YA5rIStWQUyrAFQ/I5IlARlHEnD4CJTwLaj4uuRLg5
         Gfrqxc2mvE4oRUF/yv/4QGwgga5FVNhHH7alaIqqtDr5VopLApJ2MzvXsdkzYUSbzzli
         fqilQjJdc/xAN7IEJIYtUsfIeEu9AMXwV/DP3lpNCwnM5lvraW4h38YKgPJGr6ubuaXs
         qGVO0YVV6acLiW4uFYhGs1AwEWqnsbPgI87N1cMbx/JOx4s3nrBC2FXkuFLTwZnOPhgp
         mN64cPSovn3vH5C04kmqOeVesv6Xlv7YmQElNwSzINDnFVj/gXSrbn8tU9yXnkjJvcI4
         w9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PE0hBBCsTSQSvfTQ721B04IeihNT2na4KBLVRKgcCLI=;
        b=pSZV+ICRle3mwr41Mi9z4/tISXFEP14XIaNBZYeTdTfevzkZBRlfaw2QELx8zJWnKB
         SUPS3vdjekTn6fIZfwbl9irY+WN7+rlNwTTRhaICMdEcJH7s7ZOtlfH/teTsk/yAMxcD
         5TJxAd+mgZSr6sMdCKgtGAsN3E6VmGfPFdGOX+K01dvMlPntO9EPtwjHexbpmXmVTmqC
         frNPMQieawv6I+xNbZRVhUXkQjxVu2XVNtuNtxLYEMq7xnUo+mJZ5kmLvkC4H7jGGP9e
         JYOB/HZrAIWPIw/CJ5QG8HFznMJsCHWNn5PYSaDgedgvU3GIbTXD9qIm5GtqEiT7svAt
         EWNw==
X-Gm-Message-State: AOAM531Hz5AtcjjArSAGH/e367uMglAQOoKnJcBRL4TYeFQVoo8REdz3
        9qvcj/qcM7VfDPoi2JNmN06EdGZIWVl+Tpd0KRA=
X-Google-Smtp-Source: ABdhPJwC9UcaPeugGzfuAkqp1gC2UZLZfooxjBhAlcCJJQAdGkEiXR8MaCcybAct9gGJazxIk0X76A9WiblbtUdmJi8=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr31508886pfb.7.1620765035680; Tue, 11
 May 2021 13:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210505164734.175546-1-saravanak@google.com> <CAHp75VeDzOZ_j30v=rgec2d9f6pPXHXE8BqJN1ARoYkfGL=d6g@mail.gmail.com>
 <20210511155726.GN4496@sirena.org.uk>
In-Reply-To: <20210511155726.GN4496@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 May 2021 23:30:19 +0300
Message-ID: <CAHp75VcttCbC2Ete7NvTt7_w_DxcRFNJm-Y-zSU5wzCw85DL3g@mail.gmail.com>
Subject: Re: [PATCH v2] spi: Don't have controller clean up spi device before
 driver unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 11, 2021 at 6:58 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 05, 2021 at 08:53:14PM +0300, Andy Shevchenko wrote:
> > On Wed, May 5, 2021 at 8:26 PM Saravana Kannan <saravanak@google.com> wrote:
>
> > > Can you test this one your end to make sure you don't have issues
> > > anymore?
>
> > Do you need a test on my setup?
>
> It wouldn't hurt.

Okay, I have reverted first the "spi: Fix spi device unregister flow"
to be sure I can reproduce the lockdep warning, indeed, it's there.

After applying the above mentioned patch it's gone.

On top I applied this ("spi: Don't have controller clean up spi device
before driver unbind") patch to see if there is any changes,
nope, seems everything is fine.

FWIW,
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>


-- 
With Best Regards,
Andy Shevchenko
