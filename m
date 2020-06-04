Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36B11EEB62
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgFDT43 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgFDT4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 15:56:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77025C08C5C3
        for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2020 12:56:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so3979390pgv.8
        for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2020 12:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JchjGYZl0wqUOrU5YQvGeZV5DROtdtYOgYQQhEiIskY=;
        b=qPGYj+Fa3kUn8rqUio1Dqo/wmmdxLTwJv3dkdlE3ClgOnCxbEa6OJED06WKQ9xZ/S5
         drxLk5d97vcv5eQ6d4d6pUs5J9MwW0FbQj4r4wLXcZG5wYgEinukAsqpd6SbNEpGTiIL
         ybbjkH30SzUTY9QY0bM3t5oBYgf/gdFtcqSjGZ4Vd93wXluzmD0tkk2N1s4+IczoK5T8
         73LFTDcT2N2adp5wR2Mlu3UFct0QurWe1qbINXwuT+3G9C5se3K/oYDgtwvOmb8nMB81
         9/qgL3YapcLXLfnBA8fVq9DtyGqYOQK0MGNYMtExoxZdmGcyOrFvw2budA/p7MR7MkMh
         dTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JchjGYZl0wqUOrU5YQvGeZV5DROtdtYOgYQQhEiIskY=;
        b=PmTl5M5veYNdWkS6mUo8BzICKcdBEAAwGfs3A6iqM/gd8oIOfEWn7tBc+gr83hqyIf
         Ykekcg2lanzAwMWFurngvxBxkY9KBdDlvdnq/GnGgF6yfIOBAhjIrvID1T5ouBJu1XEi
         WAd+My8jNQfAEgryXjb3f0mTtffsrsazu3As7gVG6lzp0e9e1cxcxv08uWDLkl8a5Dfc
         mdhIjCACPvSnKPyZG6tJwWsrXSZFkawD4OfFIyiQE0RJ79u0g/irFQmVRJUK9PfbdHMk
         RQSdk8Lp86TvnIUQcrINZ5ejf5alxp3NY7P0qM8eR4eLAkktN0ck3hRGmt/5vAMQwEO+
         d19A==
X-Gm-Message-State: AOAM5302Vg+qTNv7WhhVxnyPGVGmq2dI042tODYBP3keUgstz1EgNmrO
        sU9PB+13qtN9RJJJJ12SyvLClzT/5c0woXXjepgHNg==
X-Google-Smtp-Source: ABdhPJy7InXrusPAFFTJ9/oFSaSF0Eic2jn49VfP7aR0w5k1vGP4KYsGIQVm0HirYrhRu0SFvISfn3kdwUp620gXyHY=
X-Received: by 2002:a63:f00d:: with SMTP id k13mr6167247pgh.263.1591300583418;
 Thu, 04 Jun 2020 12:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org> <20200603233203.1695403-3-keescook@chromium.org>
In-Reply-To: <20200603233203.1695403-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Jun 2020 12:56:11 -0700
Message-ID: <CAKwvOdmfOSGAZiuapXOaiU74AQVMDgimrnCiRDjzw4p4oh1vaw@mail.gmail.com>
Subject: Re: [PATCH 02/10] drbd: Remove uninitialized_var() usage
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 3, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
>
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just initialize this variable to NULL.
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes: a29728463b25 ("drbd: Backport the "events2" command")

> ---
>  drivers/block/drbd/drbd_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index eeaa3b49b264..0067d328f0b5 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -1604,7 +1604,7 @@ static void broadcast_state_change(struct drbd_state_change *state_change)
>         unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
>         void (*last_func)(struct sk_buff *, unsigned int, void *,
>                           enum drbd_notification_type) = NULL;
> -       void *uninitialized_var(last_arg);
> +       void *last_arg = NULL;
>
>  #define HAS_CHANGED(state) ((state)[OLD] != (state)[NEW])
>  #define FINAL_STATE_CHANGE(type) \
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200603233203.1695403-3-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
