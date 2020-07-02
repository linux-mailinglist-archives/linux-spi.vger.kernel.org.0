Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8482127A4
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGBPVn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgGBPVm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 11:21:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D36C08C5DF
        for <linux-spi@vger.kernel.org>; Thu,  2 Jul 2020 08:21:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so10545844plm.10
        for <linux-spi@vger.kernel.org>; Thu, 02 Jul 2020 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=85NgcoW6jBNBGz0tQzl+oqewL1I9o/iwYquf90s0iyI=;
        b=fz3Jh9EbW2QNq/2MyLiNywl+Bw+HpwfpGyCppJTlFpNOcSFS1TexJkrkG1UxqufMgU
         DTnt8qDgoR6kpc5Uov/N8ZFtF9gBkglTu3rbJlgEgXDnMffWLDd4jgcOStrGlPxU6l/S
         kAv+vOh2+5LMMHeltnDKRB/tSSiTCWUefTVYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=85NgcoW6jBNBGz0tQzl+oqewL1I9o/iwYquf90s0iyI=;
        b=dQw2va2i9Cp0/vjnUYsm1aAuxX3vEAHcKWnMANUu3zJdu1UiNa5WR5OBueKMKIaefJ
         91Zf1gHw5VxTLlQreDHixArBEI9q0ACApWDWrQYroVcaw1/C6RSifCIaiLNrftlSWF0W
         gRRfNFeof2kdGIGCJzJqQw9aSaW6puZf6paWP/pOrNqoJFaUQzZxD+F6NfnKMRipecW0
         Pcrv6PYej2cCCOdGfoWNCPz29u/1pn3yxrQic+cDB64kb+mXRn5yFDM2fL2TFSabJoFa
         AqBuoFosn2+yddsjm2aE2aj5LldfnrFhOAm60JvbT0D36xw7IzpFg3S3UfwKD2ffenMy
         CWsQ==
X-Gm-Message-State: AOAM532AtiKLPCpwB+tgNjlvqDZxRrKzOkaRlWZZ0YVitB+ZzaauPnu6
        EfGDnMbKh275TX3K3tUwDDch9A==
X-Google-Smtp-Source: ABdhPJyPnF33faJF3QEw2ElnpTvwp44zuiTBz6WWqS/hEjfBUUANHOACCnQyGoZR2gBcK7ir4/OsKg==
X-Received: by 2002:a17:90a:cb0e:: with SMTP id z14mr31267430pjt.140.1593703302136;
        Thu, 02 Jul 2020 08:21:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c19sm8151174pjs.11.2020.07.02.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:21:41 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:21:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2 08/16] spi: davinci: Remove uninitialized_var() usage
Message-ID: <202007020819.318824DA@keescook>
References: <20200620033007.1444705-1-keescook@chromium.org>
 <20200620033007.1444705-9-keescook@chromium.org>
 <20200701203920.GC3776@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701203920.GC3776@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jul 01, 2020 at 09:39:20PM +0100, Mark Brown wrote:
> On Fri, Jun 19, 2020 at 08:29:59PM -0700, Kees Cook wrote:
> > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > (or can in the future), and suppresses unrelated compiler warnings (e.g.
> > "unused variable"). If the compiler thinks it is uninitialized, either
> > simply initialize the variable or make compiler changes. As a precursor
> > to removing[2] this[3] macro[4], just remove this variable since it was
> > actually unused:
> 
> Please copy maintainers on patches :(

Hi! Sorry about that; the CC list was giant, so I had opted for using
subsystem mailing lists where possible.

> Acked-by: Mark Brown <broonie@kernel.org>

Thanks!

-- 
Kees Cook
