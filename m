Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C54345009
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 20:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhCVTil (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Mar 2021 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhCVTiU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Mar 2021 15:38:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3EAC061756;
        Mon, 22 Mar 2021 12:38:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f10so2284149pgl.9;
        Mon, 22 Mar 2021 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UmylCooiO0FY0gD1VBuaPpMX4uX4JIruNT0RggphLD0=;
        b=Brh5JugJp6hqBfFECLtJTjn4r46TPjcn9pSfTTnMx8/mDAzgdUeOzdum0r0CY0DF4/
         PfvoP5+ceuUzZmAQsxkw5ByIAQ1KyUxCpbNW831vhxESFOIGVCbBnNthoGw6AfWIxehq
         SkHvpZiFzTCjQNNW/5UIVK1HXhExMyjg1m03Py4YaQzzavHksoml8ZBqOIjCLkJ+NBeC
         jIAqxfXJGdidya0l2UqWa9xtc12Ie5XOu3qLaXe7Ic2WMNzeV5rDcHv1CyYIWkYuGjyR
         y6dhskUW7sbbyQb89mTaP9YsyEh0ekt4L6CsYXhlgOKz4nC7V6uGdVZ9fpLdHp2UjqmJ
         fHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UmylCooiO0FY0gD1VBuaPpMX4uX4JIruNT0RggphLD0=;
        b=Nbm53RAnOnu4Pdo/PwnsD0L1K7scQDwBuxPKo88ZYWE/v+x0B5AyILMBl5v3Bx8J9Z
         4uDsL+wAScxFxqYR8aEZlvzFycAf4Qh2dtgZ8hr6+kCd/SD7mzQiTMTC/cA7YxXrOmon
         Dg4KkBcVVyxzl1aLLYsGEQ86FmlOhEAzGg/0gaXYgEYA+bJDGqbVUAx/LPio/dFlDetp
         L++2NhrBbz7tEiLNuKbHojAANakodHKRMlEflMS89RjKp09A+wxO80nZQy1HcEdHnvyc
         Qbw7TNnEzVsCrUK5hVolxPdCBmW3KFgr1YW1K9TDPTxccuUzK7zzWGXihi6l6DJ3/nOz
         G4iQ==
X-Gm-Message-State: AOAM533VZckTxPViyfUlyodCXQiCgvKlCpO4HsV/nMkkLmkpyh75Fw+5
        t2ScRpOjoaQHGFIp3E4pbqU=
X-Google-Smtp-Source: ABdhPJy5TGoMd6KmEhCjbhCpzBBMUIVSKnTyFbEhxlGnJk92WGw1MC433yPuVLTbTXPMX5KqQ3sQ8w==
X-Received: by 2002:a17:902:26c:b029:e6:648f:2668 with SMTP id 99-20020a170902026cb02900e6648f2668mr1153472plc.66.1616441898801;
        Mon, 22 Mar 2021 12:38:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:499f:7361:582b:fd05])
        by smtp.gmail.com with ESMTPSA id t125sm10514566pgt.71.2021.03.22.12.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:38:17 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:38:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <YFjyJycuAXdTX42D@google.com>
References: <YFf2RD931nq3RudJ@google.com>
 <20210322123707.GB4681@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322123707.GB4681@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 22, 2021 at 12:37:07PM +0000, Mark Brown wrote:
> On Sun, Mar 21, 2021 at 06:43:32PM -0700, Dmitry Torokhov wrote:
> 
> > Note that this is not SPI-specific issue. I already send a similar
> > patch for I2C and will be sending more.
> 
> This feels like it might make sense to push up to the driver core level
> then rather than doing in individual buses?

That is exactly the issue: we can't. Driver core already releases all
resources when a device is being unbound but that happens after bus
"remove" code is executed and therefore is too late. The device might
already be powered down, but various devm release() callbacks will be
trying to access it.

devm only works when you do not mix manual resources with managed ones,
and when bus code allocates resources themselves (attaching a device to
a power domain can be viewed as resource acquisition) we violate this
principle. We could, of course, to make SPI bus' probe() use
devm_add_action_or_reset() to work in removal of the device from the
power domain into the stream of devm resources, but that still requires
changes at bus code, and I believe will complicate matters if we need to
extend SPI bus code to allocate more resources in probe(). So I opted
for opening a devm group to separate resources allocated before and
after probe() to be able to release them in the right order.

Thanks.

-- 
Dmitry
