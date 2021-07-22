Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC4A3D2749
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhGVP2u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGVP2t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jul 2021 11:28:49 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56AAC061575;
        Thu, 22 Jul 2021 09:09:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x24so4292271ljm.4;
        Thu, 22 Jul 2021 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yRqbBCi9mqVVJAHkcc9Q+1aaqttB3W44ApCVfrsSG/k=;
        b=Ikbch9lKGGlNqw4PQrTLyJ3wlufI+gErbbLDheUyyM/BYFT6aJHQKl+qHDvdAPiyK6
         utyyNhtTEjal3BLX+qYNLZkLg1vsaptHkI+M/2uLQ3ptUpEzKZSX+k+vaGzpipiAaWEq
         MjKiUlex63TjhbXwipXMzpDwMrEQynmde8aQX+Y92Itg5V7RQXFWlgsqLsWi8E3IuGN/
         S9zq0jnUQra1hMbvW757zULqllkB2wRaes+o8LW73RrWRGdJ0Wod5RhDTVIWiW1vRPYJ
         /T6RgByw8iqEbAgbAtOBZp8f8RqvjiyKx3Ar1tRGcmoUWhQ6PSb+AUQgM2eOMoklaJJC
         SZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yRqbBCi9mqVVJAHkcc9Q+1aaqttB3W44ApCVfrsSG/k=;
        b=X6gjVUaoEPJPObZaeNZ5gdlvvurLgqV8O1POVw4cItettKfA4Y7sdrXxgCJ1nuRH9U
         bAZ/b2V8Efw9qULSHJLFwyyT2gnzDifspRPneJnHbsV1z5v0HQYUj+FcRQhe3Er2C0cR
         TKD2ZB9oJAriyonf6rZ59ueTGdF8lpAJsVIOAW5DJIIAqpWyG0021wfZzUVn/0aMJei1
         VqvLf/UAtRaco4cKKc/znLtABt9TLNEahjKdVqxchX5KQqLsWBmG0VeQKISlRvgkrGls
         QIfi1QZyRlqo3zcx7o9EDfkPM8qUbGvHA0r/I7lvj2CQMr1eNM3/z/hd5lvaCqygewpA
         8AAQ==
X-Gm-Message-State: AOAM53253XA5cVtaOMIYDz1Sw76tJIFviHT+y9AtjvEmdnO4lNYYRjC+
        p4/L49vB8WZ1mGLazZFyOSU=
X-Google-Smtp-Source: ABdhPJym/04iRctZMltsrnksCUHiO7wZtEPkSgYhBLQvcbAy5iJRlCz0VoX5DDb9+aXGa7j2nE3V7g==
X-Received: by 2002:a2e:9010:: with SMTP id h16mr569882ljg.62.1626970162013;
        Thu, 22 Jul 2021 09:09:22 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id y4sm3033284ljc.109.2021.07.22.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:09:21 -0700 (PDT)
Date:   Thu, 22 Jul 2021 19:09:19 +0300
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
Message-ID: <20210722160919.ccjfodb7pbvu7ul5@mobilestation>
References: <20210722053358.29682-1-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722053358.29682-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Nandhini

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

Thanks for the patchset. I'll send you my comments to the
corresponding patches soon.

Regards,
-Sergey

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
