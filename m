Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB831BB7D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBOO4T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 09:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBOO4P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Feb 2021 09:56:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE50C061756;
        Mon, 15 Feb 2021 06:55:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gb24so3870446pjb.4;
        Mon, 15 Feb 2021 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=crMLEXxlV/fSKAwiZ26UATqiqjpkjoYP4iHWFZruEcQ=;
        b=QNLoXIxG6kM73gPVUafR/x123vFdPakFYSkdJEj1X2WMUU8ryyVKIiW3IWrzt2bJQA
         6SUookPfcqobIcLsQRFI0+wzUozFCkl419hAeUkKYC2XpCiSgsQj+uL4YU+r8znDKBfD
         UB6GsQlMINQLE3UVlvLHxrM592pbteidmBCzxhsgp1/dgxbik8as8wwBjKY8mzsF5Qk5
         zbeZYg2xgz7jojSYQcHO35pQs9vfSrESDyq+7aT+YiKHIcFndLJ4Uf7ECaMNqTkqF/35
         J+d1p7FForY9IXkMKVNvqgLU+Ric64qfTQkme42eVTc7BWgWNCI/wSiotzge4gFuaUlK
         2ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crMLEXxlV/fSKAwiZ26UATqiqjpkjoYP4iHWFZruEcQ=;
        b=ramsHMgrpNuDugT2XhhqQG20kac5J9/Nv5cils8P84AKQ1r7V0oByrY3JCyXXTnebs
         udtotMOVWr6Z/G+EaK3J2kReENxXIssJPvbpAbyqawPS+8pBThg+LO+7FzZbO1tPus3y
         zuYAB+Te9NfOPBlm9C7rLIVBGbguc0PgC1bcipSa9N/OO7lRpsiU3caQYeELhV3qSdlG
         oDPL2+cFqPwjfHsP6r6jBF/NuTuqLe3MXCK4LBtQHcMfOcSwnkJhsnj3r/FIA8R57LN4
         ptFwnmlH3N5YvfAdhryA4Xi9HG/d6cc6Z8g7XF/ShzbljgaTM+f062fagUPq87XVOeod
         eSWQ==
X-Gm-Message-State: AOAM531HowqP98pT0vJUk2elZ3ufrJgt5bMk+OtgojPJzlFCX7zUrqBT
        jA2KKZIBqUv6Adr2IoRiU8sjGrDxukUpSQ==
X-Google-Smtp-Source: ABdhPJzNdEUOjzPdDG7/Gx8FQQnKh86ys1iBfdVIVan0+e4BhTWTUWcJFkjfBEFLLP/vl0Qi/GxovA==
X-Received: by 2002:a17:90b:368f:: with SMTP id mj15mr6362177pjb.139.1613400934486;
        Mon, 15 Feb 2021 06:55:34 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id 6sm18165460pgv.70.2021.02.15.06.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 06:55:34 -0800 (PST)
Date:   Mon, 15 Feb 2021 22:55:32 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org, jan.kiszka@siemens.com,
        jarkko.nikula@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: pca2xx-pci: Fix an issue about missing call to
 'pci_free_irq_vectors()'
Message-ID: <20210215145532.GA620097@nuc8i5>
References: <20210214145746.602770-1-zhengdejin5@gmail.com>
 <YCp1nh2ZEBvvB+lC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCp1nh2ZEBvvB+lC@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Feb 15, 2021 at 03:22:38PM +0200, Andy Shevchenko wrote:
> On Sun, Feb 14, 2021 at 10:57:46PM +0800, Dejin Zheng wrote:
> > Call to 'pci_free_irq_vectors()' are missing both in the error handling
> > path of the probe function, and in the remove function. So add them.
> 
> I'm wondering if you noticed that it's done by pcim_* API.
> Perhaps you can introduce pcim_alloc_irq_vectors() or so and do not add these
> calls at all?
Andy, Thanks for your reminder, You mean introduce
pcim_alloc_irq_vectors() as like pcim_set_mwi() and free irq vectors by
pcim_release()?

> 
> > Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
> 
> No, it doesn't fix anything.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
