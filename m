Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29D03D2ACD
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhGVQ0d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhGVQ0d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jul 2021 12:26:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068AAC061575;
        Thu, 22 Jul 2021 10:07:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j1so8210030ljo.10;
        Thu, 22 Jul 2021 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mTMaumPRkIaZLa/2lxM5xjyGM2rdgCcCIjsVEWllSbo=;
        b=gOaYBO643OGCAnzVHor6K/I7Sh4j1P/tY241g/QjDF42EE9UIEzdJryXQWAUdKgERr
         AP2JFTDmoU+Ei5T8Vr6TBAXqGukdtiVXwp8N/bF5iXcYzjZ6sDbZgWbQkogWd1e2EXIx
         pXDIf6eRYw4+9QAIiHFGY1b1r/xTL9uSoYgX1ZuSSMxUK06b39YXfT+YL3/2EhTLIj4l
         UEsDfITGaUAQ/SvOXjnJ0CRwy5Mb6rN+/W3NppwRwzeXS22jz0UZweM113QOWw22o7/8
         jXMU1HUgsOm1Pii6XQc4f0v8fVYB+ynxm6nxkZP+IOlT+k3iW0s74N78foAE9PKVWXaz
         Coag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mTMaumPRkIaZLa/2lxM5xjyGM2rdgCcCIjsVEWllSbo=;
        b=SCSg9UnWjZUQwEH3+O2M6POh1b6etmp53xY74j+dxuwKWgqceD/AgCbRA+qHNQcixN
         aOXaZ9o22WlFbYDBOyFvdBJLoJdEBHOzfkw/HMVeEG5zZdQRZg5uDzYnA7iza4VEI4JQ
         ES1BGEY/YrrKdz8ilHDBGArAKb67l4lbdA67qCYAPLJH+BqhFPYPrRQG4BDZisJ3z20D
         y9uj/KgZH1EVp/yZO6jkQoxzF4UFMY9ExFpus2BeG7c34cflb/WWTJ+bNogY3LaMu3y8
         lB3CsiMMJlhEB5uj8+PhMNyCsTnkffVwpQ744iRgZVuooVKax2FPhPmCCvh8KuehbxAv
         uR3g==
X-Gm-Message-State: AOAM532LGRd66rIL51JSmREYGtQEE/HU5362tdJYkUr/1LZXaQYEG8ot
        fff0kldA0bI5hVaf7yM380s=
X-Google-Smtp-Source: ABdhPJwJUTGY5I6rTKsMTrjPyl+3UE0wJTITWZ6PHA8CDZMJKxkwka+8f7LgGy5kgnijyiPv1WGoYA==
X-Received: by 2002:a05:651c:12c5:: with SMTP id 5mr710306lje.478.1626973626369;
        Thu, 22 Jul 2021 10:07:06 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id a16sm2021088lfs.281.2021.07.22.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:07:06 -0700 (PDT)
Date:   Thu, 22 Jul 2021 20:07:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: =?utf-8?B?W+KAnFBBVENI?= =?utf-8?B?4oCd?= 0/2] Add support for
 Intel Thunder Bay SPI
Message-ID: <20210722170703.m377feh3xdya76so@mobilestation>
References: <20210722053358.29682-1-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210722053358.29682-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

BTW it's a first time I've met quotes around the PATCH word in the
subject:
[“PATCH” 0/2] Add support for Intel Thunder Bay SPI
 ^     ^

could you drop them?

Regards,
-Serge

On Thu, Jul 22, 2021 at 01:33:56PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Hi,
> 
> This patch set enables the support for Designware SPI on the Intel Thunder Bay SoC.
> 
> Patch 1: SPI DT bindings for Intel Thunder Bay SoC
> Patch 2: Adds support for Designware SPI on Intel Thunderbay SoC
> 
> Please help to review this patch set.
> 
> Thanks & Regards,
> Nandhini
> 
> Nandhini Srikandan (2):
>   dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
>   spi: dw: Add support for Intel Thunder Bay SPI
> 
>  .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 ++
>  drivers/spi/spi-dw-core.c                     |  6 ++++++
>  drivers/spi/spi-dw-mmio.c                     | 20 +++++++++++++++++++
>  drivers/spi/spi-dw.h                          | 15 ++++++++++++++
>  4 files changed, 43 insertions(+)
> 
> -- 
> 2.17.1
> 
