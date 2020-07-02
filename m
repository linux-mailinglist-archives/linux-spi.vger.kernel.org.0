Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83110212833
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgGBPmX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbgGBPmU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 11:42:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513D5C08C5E0
        for <linux-spi@vger.kernel.org>; Thu,  2 Jul 2020 08:42:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so12698165pjf.1
        for <linux-spi@vger.kernel.org>; Thu, 02 Jul 2020 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kybd0zpVtDTcpe4L/HEboaUKNNgAnXPFcQy8ZwcEJuI=;
        b=MwGxMiEp5/dtTA3ogef34O3PctcdhAV3Nj892QYS7iq/+bdlneIKDksIISF88MZTJs
         551vB7jwtgzZZvtq6shJNSIVEPChNMunEoUB8LbEsFmwqHkuUWtxgcXHKQhYMgExY7+k
         RjFrm4VGnLlBn/66+5Gz+fn0C9B0GHrDhf0l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kybd0zpVtDTcpe4L/HEboaUKNNgAnXPFcQy8ZwcEJuI=;
        b=lmDNM6lJlGscIy3Ue0k5Gq1nFmnoMVR8S7N7Wrrj5i6DbRqqOqNd9IJBhTJgB2pOEQ
         ae8Yv0KBygx9Rym7zZhzc04B7BWGQFzEhx8Ez852eCjpbKwA1fUSBkwLkGGzOdQ6Cmlj
         EiZO3qZhKT5CQcGoEVOE5d3xtsMIgImxjrvt5JMRcQkeETnmS6qJO6/54WN5rfbRRUmU
         M16v6MJ2i/YFe7G/W1dMapSB1gNliPvFtSNfUMikpHCyxOjnOiWymjgJOkswa9CGikaH
         2giW0EfYMlyrKNbcHTvJNXDr5KAwif03q5ESZVJYDc4VeQCRZ9NiKnH7XcNs8Dmbf6rv
         O16g==
X-Gm-Message-State: AOAM531aSI2D4rAjZq8cdhaXBsK8cK3sK37D6FZ0XJBt8kg2pdCdEWQc
        Tw0IGxJ+p1nG9hidrhX+92Kg7A==
X-Google-Smtp-Source: ABdhPJx/V021h2YOrPd2qoUZY3+ajz3Yf7zbLlvvx3ojyPgvvotTbq49bzs576UQiATe81OrpVMgog==
X-Received: by 2002:a17:90a:7785:: with SMTP id v5mr35048412pjk.31.1593704539711;
        Thu, 02 Jul 2020 08:42:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l191sm9749876pfd.149.2020.07.02.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:42:18 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:42:17 -0700
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
Message-ID: <202007020839.545A571CA4@keescook>
References: <20200620033007.1444705-1-keescook@chromium.org>
 <20200620033007.1444705-9-keescook@chromium.org>
 <20200701203920.GC3776@sirena.org.uk>
 <202007020819.318824DA@keescook>
 <20200702152335.GJ4483@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702152335.GJ4483@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 02, 2020 at 04:23:35PM +0100, Mark Brown wrote:
> On Thu, Jul 02, 2020 at 08:21:40AM -0700, Kees Cook wrote:
> > On Wed, Jul 01, 2020 at 09:39:20PM +0100, Mark Brown wrote:
> 
> > > Please copy maintainers on patches :(
> 
> > Hi! Sorry about that; the CC list was giant, so I had opted for using
> > subsystem mailing lists where possible.
> 
> If you're going to err in a direction there I'd err in the direction of
> CCing the people not the list - I only saw this since I was looking for
> something else, I don't normally see stuff in the mailing list folder.

Yeah, I've gotten conflicting feedback on treewide changes:
- please CC me on only the one patch, I don't want to see everything else
- please CC me on the whole series, I want the full context for the change

I opted toward "CC me on this series", but then I get stuck when the CC
is giant. I think I may switch back to individual CCs for specific
patches, and point people to lore if they want greater context. (lore
didn't exist before...)

Thanks for the poke to make me reconsider this workflow. :)

-- 
Kees Cook
