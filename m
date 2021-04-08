Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720D3357DB2
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 09:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhDHH4m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHH4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Apr 2021 03:56:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68A7C061761
        for <linux-spi@vger.kernel.org>; Thu,  8 Apr 2021 00:56:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t140so811400pgb.13
        for <linux-spi@vger.kernel.org>; Thu, 08 Apr 2021 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSK2w9BVJvJYDrd5UzN4wEBAv/GM73hHz2rbX7pLLqI=;
        b=Q9bfFEb70FfiLCpkb9T3eXrMDKOvuk06KTRvnxK1OiZzrlECSDErbl08YC2algNRir
         vu0NmpD6LoyTbTarS906C3q4Rb0nj9YiOlIdKaxWE5WLuiZwGo7NfOn68tetazVJ1N5t
         7jzv9abpNNovEUf5ZG90nyg+0RS7kkrBtNSz5yX5Jqn4c0x2DxXEaiMi5uHqKiDQ1t9n
         PGeMhSip82kKLHngwdE8N14QrrOshqv1Fh8n7BaqWSdZa8zHTUeTswqf4yybgRJYEmyL
         QJmb0LEHR8neoS06IxyHBsAxP9fatqbpP+ebs94BkJ4eNRNAP7MkTnZT/cxUL1rs72kH
         O8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSK2w9BVJvJYDrd5UzN4wEBAv/GM73hHz2rbX7pLLqI=;
        b=itvvgh38/ZvfkLhUInwAQ3B9cDLzwN4qgnZnRLi/ru0eKzsvqDmlm9x5ZOogPP3Z+U
         Im2XLetCSRpFvlY8rej1i8D5A6Vb9cbuPxlp90CBXm0t2W8Vi8c0gdVSvn8gmMemdzW5
         U50Sf1p2OZdXkB9CqyOphsqZg78Ubq7inopIYWE8HHU+ZbFL7YiCjsilcotwwTg3qJzd
         dYXFtwK86aB57R8iOG+ClofvM1SqEQalA9qoiAgyeYMzKghGFc7hVENSXqTsx+AXrRP3
         CkxfqHFvxhOCYpcO9TGrdtAFjpgTLhvTCQcAw0U6SN4Axn9HzWzyz95TovYt5HewoKLO
         DRDA==
X-Gm-Message-State: AOAM532TVHcNd/bxk0O+mrEqHzB0NYPqAZIHufWNEwiSsbt8I97dFXij
        qtjPmV50R+nSvFfezQcFstgRjQ==
X-Google-Smtp-Source: ABdhPJx74eqYozeBr+SBdkHjbAEzrINil3AnraPtpdCwe5uU1Uyln1gu9H2wDrpw0dOIFzNflgVOpA==
X-Received: by 2002:a63:e5d:: with SMTP id 29mr6824327pgo.450.1617868589409;
        Thu, 08 Apr 2021 00:56:29 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id k69sm11252936pga.45.2021.04.08.00.56.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Apr 2021 00:56:28 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:26:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM/spi: spear: Drop PL022 num_chipselect
Message-ID: <20210408075626.gkbbs3wd3bme3vgd@vireshk-i7>
References: <20210408075045.3435046-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408075045.3435046-1-linus.walleij@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08-04-21, 09:50, Linus Walleij wrote:
> A previous refactoring moved the chip select number handling
> to the SPI core and we missed a leftover platform data user
> in the ST spear platform. The spear is not using this
> chipselect or PL022 for anything and should be using device
> tree like the rest of the platform so just delete the
> offending platform data.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mark: please apply this as a fix to the SPI tree unless there
> are protests.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
