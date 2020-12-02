Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB242CCAC6
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 01:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgLBX6M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 18:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLBX6M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Dec 2020 18:58:12 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B39C0613D6
        for <linux-spi@vger.kernel.org>; Wed,  2 Dec 2020 15:57:31 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id 7so770441ejm.0
        for <linux-spi@vger.kernel.org>; Wed, 02 Dec 2020 15:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fF9r6bCHjkpuD/zxWrIjPCtTP1lKrKsFiIbLq5Fn0w=;
        b=CjstJiAypsjwm4pDEms/SbLgK4irLc5E8GG8Ea6BZl+gALSWlX5PqZ2ueI7NykmwEI
         Uftvtis3Ocx30zuWqzrQXqKr90PRsej/VW6aP54AVdAHzIMa5QLbB/p8oFP8SKYueJku
         ZKrQZmtuT03LxT7DIXusWJcHwN2w0dpRxBOrCWD7T/tYrLa9DDqpRc7ml+Oyf0JbwKi5
         5/2BIwtdKzz3Fwgc7rd8MvOBrKLEr2xdSUxF+35gejWAOGYRe3KQfpCk0PQx0SACOruU
         dnogWhEF7BmQmonexXmyCrrq5duNveaTvXCFySw4riy2bryDXrldDd57Gxz1srn5TZ1Y
         Oh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fF9r6bCHjkpuD/zxWrIjPCtTP1lKrKsFiIbLq5Fn0w=;
        b=Oq+tzC6bdCIg5kunl3w+72GusJW940DRxH6XPjH7wBcMsJUNQIQ7GPcbc+FAfJQZnC
         vrOKPSFdB8Goo1yJc4ENAc4mOL6sU3G9cASpeNRzTvVU3LOVKILivwPnDkNxIzsNEfio
         QtGo+5Lvz9vYv6j4mCBy2quI/aVt8GZuyin5e+X8KIaCjCwAkbdHmkctdLNFDRzTSlWj
         dNDIIoE6sMew6gzqizup6dsscYIK9oQ5y7uOX8cFYV0DJUVj81rfz3N3iS5LE23ia5J2
         4I6gXbSJUBU0+8MYVS42v4BdCX8ZSiGUcxvgTnRb2oTdira+psIzJ/rle9AOz47Eetou
         nGxg==
X-Gm-Message-State: AOAM532FhoLmucXRa+AAm2unqO9F9fGj6wb/XUO++aG7GIevBane9CCo
        fMJfR3NM6/uqlayZUkuJzk8=
X-Google-Smtp-Source: ABdhPJwzyP1N7ty0UENV5doXqbhDnHVbevAKVHgei4R41MB43xWOiPl5DlxALvb8FQMteU/bW7o19w==
X-Received: by 2002:a17:906:40d3:: with SMTP id a19mr241799ejk.98.1606953450414;
        Wed, 02 Dec 2020 15:57:30 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id a15sm195969eds.4.2020.12.02.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:57:29 -0800 (PST)
Date:   Thu, 3 Dec 2020 01:57:28 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Use max_native_cs instead of
 num_chipselect to set SPI_MCR
Message-ID: <20201202235728.jihjacbuo2362f6v@skbuf>
References: <20201202142552.44385-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202142552.44385-1-fido_max@inbox.ru>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 02, 2020 at 05:25:52PM +0300, Maxim Kochetkov wrote:
> If cs-gpios property is used in devicetree then ctlr->num_chipselect value
> may be changed by spi_get_gpio_descs().
> So use ctlr->max_native_cs instead of ctlr->num_chipselect to set SPI_MCR
> 
> Fixes: 4fcc7c2292de (spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR)
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---

In this case, it looks like Mark did really apply it, Maxim, I'm not
sure why you resent:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-5.10&id=2c2b3ad2c4c801bab1eec7264ea6991b1e4e8f2c
