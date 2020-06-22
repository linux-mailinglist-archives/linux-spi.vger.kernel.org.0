Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB529203DD9
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jun 2020 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgFVR1j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jun 2020 13:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbgFVR1i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Jun 2020 13:27:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A8C061796
        for <linux-spi@vger.kernel.org>; Mon, 22 Jun 2020 10:27:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k6so7831554pll.9
        for <linux-spi@vger.kernel.org>; Mon, 22 Jun 2020 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qKZonIXzYkaE7j6NEmUZDll/lqh82KFC5lIzFFAexA=;
        b=Sj/LDxGlqLLpaYA2HKS0ir72xSJDRvaawqW+y795XoJdbq1kchLvUQjgrJjOWfC+JH
         gMsIKbShjnjcr2+KurZsh+8EWYtYNU6dksMeefHdh4+cSoDABbcpnRo4yMlqaxI1JeEd
         5qoKcloOnFj249PSJkejK7fhAoJHjyymcZD75f7CrBTO9t5sVpKl4/w+l4aq3WNsnfUb
         TRIDN1c/Dh1iY2rXYeGbxfUZ5LId9P8gQ9pTJRcf4rlFnODdx/9TAPxwlPJJIL5rw7gS
         qkWxI0tT2V94QPHexmwPKfAygvTNhIxMLj1Lstg8dOiTztKRbwGZVv2oVu9k5+oOpdUQ
         n93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qKZonIXzYkaE7j6NEmUZDll/lqh82KFC5lIzFFAexA=;
        b=H1EbXu09rdGU1zxU4A4r+DGastuyZfYWCt+8XxFWmeUKuQmn+nG4uzHBf2N5w23k7x
         tDEP13nsZAvcGbInYU5vppk+abijnm7fl7qQcy2vie+vYtWl8itfEAqHoyGcA4rmeD/o
         6BOY+CaAS7Cg2gvtXoH5IBDhzhgcAkYHDVXtLI3I1ESmg4FuoMI6O051ul6GHboQwnCt
         QzuDHAzWZJAKj1/GCOyW0Afl8gNZ5evEbXwJ2vgp55f7KnpTBxd9BpgqE1XMT+OKIgau
         hk9gjv/G/zj6/IOSxtjWBUSyQkdfanXoypNXgDdfohr3hBljPF9b9VEFuuEsWTDo5TXE
         P6mg==
X-Gm-Message-State: AOAM531hkZ0qZkrlJzaHfCY/Key9s6Tplixmt4xIj8S1bkxHMbgiSHwo
        nt27rSqgwwrYcu+U8qaFCHrlG7LK7l5GVYSeslh3hQ==
X-Google-Smtp-Source: ABdhPJwAJxd3TbD1t00Y40e3G8EKfLPlkBmqQvCE355+9C0tlqa2OCw7GjEjFlFvPeiUto0aRyH3uyXx9jYG3D/uAag=
X-Received: by 2002:a17:902:b698:: with SMTP id c24mr20096772pls.223.1592846858031;
 Mon, 22 Jun 2020 10:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200620033007.1444705-1-keescook@chromium.org> <20200620033007.1444705-17-keescook@chromium.org>
In-Reply-To: <20200620033007.1444705-17-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jun 2020 10:27:26 -0700
Message-ID: <CAKwvOdmzYXGL2NVZqBkzyMzc-fLm_UgVCsB3aHW2GmFi3zyf9Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] mm/debug_vm_pgtable: Remove uninitialized_var() usage
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
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

On Fri, Jun 19, 2020 at 8:30 PM Kees Cook <keescook@chromium.org> wrote:
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
> Fixes: 399145f9eb6c ("mm/debug: add tests validating architecture page table helpers")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/debug_vm_pgtable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index e45623016aea..83c9e88a052a 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -307,7 +307,7 @@ static int __init debug_vm_pgtable(void)
>         phys_addr_t paddr;
>         unsigned long vaddr, pte_aligned, pmd_aligned;
>         unsigned long pud_aligned, p4d_aligned, pgd_aligned;
> -       spinlock_t *uninitialized_var(ptl);
> +       spinlock_t *ptl = NULL;

It looks like the address of ptl is passed to pte_alloc_map_lock.  It
looks like pte_offset_map_lock unconditionally assigns through that
pointer before reading.  So this could be left uninitialized, but
initializing it doesn't hurt.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>         pr_info("Validating architecture page table helpers\n");
>         prot = vm_get_page_prot(VMFLAGS);
> --

-- 
Thanks,
~Nick Desaulniers
