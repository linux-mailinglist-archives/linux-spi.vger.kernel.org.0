Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC74530F7
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 12:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhKPLks (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 06:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbhKPLj6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 06:39:58 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFCEC06122C;
        Tue, 16 Nov 2021 03:35:39 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e11so42494452ljo.13;
        Tue, 16 Nov 2021 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nuAKFfZrhphSU5MOec8wBgqrQsEuj7SXWSyVWKXSMUk=;
        b=VF6ymiIgQHloa5CW6ayQFt0EfOvH0Fr+a++yaQgmdN5j78r0UBHl5G6K+Qe5/2hvrT
         +XqjJ3Gx0R/8IwdnssTvkz+lbSyzqwobX5VtvZo6zpvXqlzRjqFP0CYbfpSzS41nrQgX
         MGifl6vuGuSnUC6INWn0rXa0MS2OO2dF8Pa1AXvTzy6szOGc4GmBMulcQ+OzyCGRz1Sf
         K/EccARbvlqKELQ8xWb2J1ZNlkHnCFPEGJxZGSHXghvz8YCjeDMoc85J4ttSuWINKDwv
         6/SUMWhgYwOenAp/Z+KbMBIR6lNVyeAabPN9QqttszfZZI78ehNbeBHZ2Q1TSYsToEao
         Y8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nuAKFfZrhphSU5MOec8wBgqrQsEuj7SXWSyVWKXSMUk=;
        b=wVKCxsTwmLYCnPFgkoecVL9ZXB0uEHW25fRW8ryPvnwP8HMC2/ZGCXZYbPHTXpwL5q
         bCV7hGv35a9TdSVjIIaMvAZnzqbllKy+rfnyA7kkj0HHHClIGT8WW8k4ugRtTxtrXye4
         emPUmrUh8ZjhC2Q5r1e9OLwcKBQ8LowkxbsHp9/HslevD+rxj8PEYx/+GaQ+NHRPAx9y
         EwyvSL2GRszqMIgOA/wehFY5cJONPGhJFOrBLPQN1lGHaME1VELlr6/GWVu2W0GGUZrU
         k5NPQnu/cq9KziLSVqZ8Ge2BUGG+w5z8Y1okNqKjkKR+zsbspFTCg2CBZIzjqa5eTKtY
         OfgQ==
X-Gm-Message-State: AOAM532u3m6OupHfTf0fELJULMKS7y2q4BzUQ08+vcPWpbNXkrJNlIMl
        3n7rDIqt7usUHDCZQ6rCRDk=
X-Google-Smtp-Source: ABdhPJzTXaBqwrCJlIK25CaD0Lpgt6kwiUFA/WLwVWR1bY9X4oYZOABam3vZ8dMIpXjU+EZkyUvzBA==
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr6485691ljm.16.1637062537846;
        Tue, 16 Nov 2021 03:35:37 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id a29sm393498lfi.302.2021.11.16.03.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:35:37 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:35:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] spi: dw: Cleanup macros/funcs naming and add
 IP-core version support
Message-ID: <20211116113535.fe26cna3mkl6er5m@mobilestation>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Mark,

I think Andy is done with reviewing this patchset. If you are ok with
what is introduced here please consider merging the series in.

-Sergey

On Mon, Nov 15, 2021 at 09:19:10PM +0300, Serge Semin wrote:
> I was going to submit a cleanup patchset for the DW SSI driver for a
> long time, but due to lack of free time couldn't make it so far.
> Nandhini's series [1] made me to proceed with this task so mate would
> finally have his patchset accepted and merged into the mainline kernel.
> 
> There are four cleanup patches here and three feature patches. In the
> framework of the former patches we convert the DW SPI driver to using
> module namespaces and provide a better code organization. In particular
> the second part concerns the methods and macros naming unification (using
> a unified prefixes of the code object names) and the CSR fields macro
> implementation using the bitfield helpers available in the kernel. The
> later patches introduce the DW SSI IP-core versions interface so it
> could be used for a version-specific features implementation. Nandhini
> will be mostly interested in the later patches in the framework of his
> series [1].
> 
> Nandhini, could you please test the patchset out on your DWC SSI hardware?
> After it's merged into the spi/for-next branch of the Mark' repository you
> will be able to rebase your series on top of it and use the last IP-core
> version interface for your benefit.
> 
> Andy, I have added your tag to all the patches except the last one since
> it's new (though suggested by you).
> 
> [1] https://lore.kernel.org/linux-spi/20211111065201.10249-4-nandhini.srikandan@intel.com
> 
> Link: https://lore.kernel.org/linux-spi/20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru
> Changelog v2:
> - Replace "assi" suffixes with "pssi" in the spi-dw-mmio.c methods.
>   (Thanks Andy for noticing this pity mistake)
> - Add new patches:
>   [PATCH v2 6/6] spi: dw: Replace DWC_HSSI capability with IP-core version checker
>   [PATCH v2 1/6] spi: dw: Add symbol namespaces for the core and DMA modules
> - Replace the ASCII-to-integer conversion with a unified IP-core versioning
>   interface (Suggested by Andy).
> 
> Link: https://lore.kernel.org/linux-spi/20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru
> Changelog v3:
> - Discard the symbols importing from the spi-dw-dma object since it's
>   linked into the spi-dw-core module anyway thus having the same symbols
>   namespace.
> - Move the DW_SPI_CAP_DFS32 capability flag position fix to a separate
>   patch.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (7):
>   spi: dw: Add a symbols namespace for the core module
>   spi: dw: Discard redundant DW SSI Frame Formats enumeration
>   spi: dw: Put the driver entities naming in order
>   spi: dw: Convert to using the Bitfield access macros
>   spi: dw: Introduce Synopsys IP-core versions interface
>   spi: dw: Replace DWC_HSSI capability with IP-core version checker
>   spi: dw: Define the capabilities in a continuous bit-flags set
> 
>  drivers/spi/spi-dw-bt1.c  |   9 +-
>  drivers/spi/spi-dw-core.c | 175 ++++++++++++++++++++----------------
>  drivers/spi/spi-dw-dma.c  |  55 ++++++------
>  drivers/spi/spi-dw-mmio.c |  22 ++---
>  drivers/spi/spi-dw-pci.c  |  60 ++++++-------
>  drivers/spi/spi-dw.h      | 182 ++++++++++++++++++++------------------
>  6 files changed, 271 insertions(+), 232 deletions(-)
> 
> -- 
> 2.33.0
> 
