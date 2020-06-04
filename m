Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1141C1EE6A7
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgFDO1u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgFDO1r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 10:27:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E8CC08C5C1
        for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2020 07:27:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so1201321pju.3
        for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2020 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ELp8NKpDU/b4oaZzGkEuk3yIxekW0FfVsfMh0kEq3DQ=;
        b=e7eITrZAAG4SVhaatsNGEFfKSAV4mgFFeMordqmQufFe6/vzeagmQ484X5shPhREQO
         NcIW+cQNizrMWNfglE0Jh5V6uWSzvceN4EXsYppzfKNVQcK2K6MGcm3eAbNC9iODqDY1
         7i/uriuA9VGz8WZ62VSr78LapWZNk/5N3ydBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ELp8NKpDU/b4oaZzGkEuk3yIxekW0FfVsfMh0kEq3DQ=;
        b=GJtYz79+RA9TaIwlnwlPoKMapdMQHyXKP//Msqyb2rf61+IAPVqinA681cqXhEyehK
         BlbVX4phx8H9oUYnYjRCD44A/GYIe3mnXlB/pfcSEMquB06SZJZrON9PdVWQqNxeGRbw
         JGzVlXl+vmmmlONo4E+MouQlfKzp32ivXdDid1AyHktbk7nSoALTFws/zpMl++Lb8xcw
         I1Q2NdSOPkzCC+hkjJvjqhJjGR4ldJ2FK6ElOPONZAg35EyyIo1ekZpiAMMXb1PfpR3i
         GYMrC7DayXb+wWpYeHoXDZfKv5JrfaJCK9aJHG/oVovzVxVTeOfc0iMFu829YW4OmBQV
         vdeg==
X-Gm-Message-State: AOAM532GcMmjhTavGfoM9zxEZoupZNQH4JCgDliMtJB7kqjjxtNR5Gch
        Jf6sYNqVkkr5nQMiOe6hJ0IkPQ==
X-Google-Smtp-Source: ABdhPJyh46iXXKU9Sh1DXTFOzkFXYm4paCXLSWoWqbxFRDWCjy8xbqFVrhjjddGEPZlvsY+JnIndAg==
X-Received: by 2002:a17:90b:188d:: with SMTP id mn13mr6391960pjb.84.1591280865425;
        Thu, 04 Jun 2020 07:27:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j15sm5944936pjj.12.2020.06.04.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 07:27:44 -0700 (PDT)
Date:   Thu, 4 Jun 2020 07:27:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 00/10] Remove uninitialized_var() macro
Message-ID: <202006040727.265B0E586@keescook>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200604033347.GA3962068@ubuntu-n2-xlarge-x86>
 <CA+icZUU4Re5g3rRJ=WF3_KiCEc3CUmbH_PibTunuK_E1QskEjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUU4Re5g3rRJ=WF3_KiCEc3CUmbH_PibTunuK_E1QskEjQ@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 09:26:58AM +0200, Sedat Dilek wrote:
> On Thu, Jun 4, 2020 at 5:33 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Jun 03, 2020 at 04:31:53PM -0700, Kees Cook wrote:
> > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > (or can in the future), and suppresses unrelated compiler warnings
> > > (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> > > either simply initialize the variable or make compiler changes.
> > >
> > > As recommended[2] by[3] Linus[4], remove the macro.
> > [...]
> > For the series, consider it:
> >
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com> [build]
> [...]
> 
> I tried with updated version (checkpatch) of your tree and see no
> (new) warnings in my build-log.
> 
> Feel free to add my...
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Awesome! Thank you both! :)

-- 
Kees Cook
