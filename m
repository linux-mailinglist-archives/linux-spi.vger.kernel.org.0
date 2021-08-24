Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65953F696C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhHXTCq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 15:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhHXTCn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 15:02:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0630C0613D9;
        Tue, 24 Aug 2021 12:01:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so12741895lfg.9;
        Tue, 24 Aug 2021 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C+vFyNR/1OJe5NmRgGHzvjWmVVpiLWeRk5VXwkNwTqw=;
        b=V/wCt0DFLylUr9ZPvdE2XKZ9h4ERCiKlsgv4WtIjOPkVI7qFAypR3OJghkrRChvnaS
         FquS9aoLz7fuYJuQfOUgXVabeccoVYEdIWqHQCFRvOfpwLdNL2hIJD4b8TJK5I0moRHf
         bWc9z8BC/dD5NaKvDKUCoTzw9EqtNqnB8WijHTCL19FDbdTV/gize12qJlCs9fqT6kKD
         MM0CbPorSI051t3w+zyRfQ8oz3TBmZPkSxyR2Xyp3Dw7nXQXgkktSIj0pX4T5BsgI3QG
         3aT5I5H0iV+89krwA8FsFkrV54BrCMWqGpYwRcP2OzxHa5QphdjqcBSkLc5OfmeEgodj
         Futw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C+vFyNR/1OJe5NmRgGHzvjWmVVpiLWeRk5VXwkNwTqw=;
        b=XvRZbTKhLMXV0WeW8otExyWpm+PGEUH5Xa/YiWtYwm8zkU4kfRJ1AdsMVeVUMfkafU
         +uTiUYu/Pr4FJGqMUiXuqjkgw2GkfyH124bmoTp0mKxXNCdOYphHrBFCZw8Ka2r3VwmU
         ZZT2kTDAqY2GLOyjMRq3ZUbGyFtmUgwEcSwMMTM9UQc502mXYrQeiJJDzYaZZscf7N8l
         OeREkPPLrgEhEkd2HVmKI9M3ucwmdTSJfRN4lrjEE9PG/T2a/LnZIxMM3rhyK3bht+Pz
         xFDsyKuLiaNcfDy/GNBzRM7vHCC6IPARqeq3KwHH620gES3MG38erfYOyr19bjsrb1yl
         Fnsw==
X-Gm-Message-State: AOAM533dCRpr9PEWkJMbAgAm30rX10zzxUzcXQMsTE44YVtcXaA4OtU5
        nDyotNVCZdgwtz5b+YTzwXM=
X-Google-Smtp-Source: ABdhPJwXaKZXB/bWN0z2ppWaZDJEZ+/xduLV2hKgJ/OJMHxrWIf5W70gcp4NK16ucMTnVESwmSChUw==
X-Received: by 2002:ac2:434f:: with SMTP id o15mr29455145lfl.124.1629831716325;
        Tue, 24 Aug 2021 12:01:56 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id y4sm1829677lfl.38.2021.08.24.12.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 12:01:55 -0700 (PDT)
Date:   Tue, 24 Aug 2021 22:01:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v2 0/2] Add support for Intel Thunder Bay SPI
Message-ID: <20210824190153.nscabdjuk4num3ly@mobilestation>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824085856.12714-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Nandhini

On Tue, Aug 24, 2021 at 04:58:54PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Hi,
> 
> This patch set enables support for Designware SPI on the Intel Thunder Bay SoC.
> 
> Patch 1: SPI DT bindings for Intel Thunder Bay SoC.
> Patch 2: Adds support for Designware SPI on Intel Thunderbay SoC.
> 
> The driver is tested on Keem Bay and Thunder Bay evaluation board
> 
> Changes from v1:
> 1) Designware CR0 specific macros are named in a generic way.
> 2) SPI CAP macros are named in generic way rather than naming project specific.
> 3) SPI KEEM BAY specific macros are replaced by generic macros.
> 4) Resued the existing SPI deassert API instead of adding another reset

Thanks for the update. I'll have a look at the series on the next
week.

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
>  drivers/spi/spi-dw-core.c                     |  7 +++++--
>  drivers/spi/spi-dw-mmio.c                     | 20 ++++++++++++++++++-
>  drivers/spi/spi-dw.h                          | 12 ++++++++---
>  4 files changed, 35 insertions(+), 6 deletions(-)
> 
> -- 
> 2.17.1
> 
