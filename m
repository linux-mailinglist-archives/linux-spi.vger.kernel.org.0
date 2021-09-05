Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC50400FB3
	for <lists+linux-spi@lfdr.de>; Sun,  5 Sep 2021 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbhIEMxM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 5 Sep 2021 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhIEMxM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 5 Sep 2021 08:53:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA691C061575;
        Sun,  5 Sep 2021 05:52:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y34so7857740lfa.8;
        Sun, 05 Sep 2021 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K/x6K2UeMsD17ixUPAmN0fw2uDHH066qaNdivULg6dk=;
        b=KZpaZxcCSLQ6pU8vgl6kDWFMtdGHaIU2m1vNy7neseUhjPql73SNgfe+z83tYYycd8
         jTVl/acsftUBLIYn4Y1mXjaO9Gj7odgrnq0V7B2PZsRIm1msEYbtTkb1DTMJL6C9aNUf
         yCllo1QeFBy3yxM82pc2Ak+w9gpsr+JNcMDd06zxjJ6gcs5wC/CHs4Ih57HYvnEpMCzq
         cmOQ7ykX2+Cs7XabS+iTBnwsl9cbNWLkp5CRBxP4BA27UmCVPkB6OHr/hKB4M7m95xAx
         yR0/e2G46WmzlZWBhTILwcoU5t9kEgSLlUJNaaw/tbq7aroC9lszMBUhklDaUSm/EvnQ
         qfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K/x6K2UeMsD17ixUPAmN0fw2uDHH066qaNdivULg6dk=;
        b=hyG5m1ccMu2nEgWX+EwtOiTFpFo+YHoGDOctfkc4+3DoCHKZIfsVDLb9m89dLqB7ED
         Wl/iv1jIMiiqq8sR5jVUJB4FBLb9RqoSCOopaDqMkFeJIeuojk1aZOXMYp1kdPQXN9zI
         DmdTl8MiIjaqtBN/NwJ+qhsC6IngMqMDkf+v1wmcV1uHKBP3fFssGrLQZ36nUkL+om2k
         O6+RfcPoaal8kUCTBufASnNqq73dDHVEESlNeUGtcYkGyGQK3iq5LQ6Tkr2hVCx6pQJM
         QyDBWpNKlchsgK/XSAAsc9QE1mcO36CzfNE9EaW2mRmm2FnA0TVnoVa4VpYM6UD9PT59
         /HpQ==
X-Gm-Message-State: AOAM532NGIIW+ULCMHGbX3s+pns4AJMFsqNtuc2x4CVaMgP96xcyEbZS
        73SeklMxcsf+DrXbcn7ypSs=
X-Google-Smtp-Source: ABdhPJxcqBUVkB6J0f+xiYxAXavSXCu6Twpx1JTV92FXJzoEWO5aKWZPI118B7oIzA0umaA62wmq2w==
X-Received: by 2002:ac2:5c41:: with SMTP id s1mr6100369lfp.187.1630846327253;
        Sun, 05 Sep 2021 05:52:07 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id bu25sm479431lfb.103.2021.09.05.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 05:52:06 -0700 (PDT)
Date:   Sun, 5 Sep 2021 15:52:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add bindings for Intel Thunder
 Bay SoC
Message-ID: <20210905125204.cyhz3vfa5brymlez@mobilestation>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
 <20210824085856.12714-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824085856.12714-2-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Nandhini

On Tue, Aug 24, 2021 at 04:58:55PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add documentation for SPI controller in Intel Thunder Bay SoC.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index ca91201a9926..88532bf8ba85 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -61,6 +61,8 @@ properties:
>            - const: snps,dw-apb-ssi
>        - description: Intel Keem Bay SPI Controller
>          const: intel,keembay-ssi
> +      - description: Intel Thunder Bay SPI Controller
> +        const: intel,thunderbay-ssi
>        - description: Baikal-T1 SPI Controller
>          const: baikal,bt1-ssi
>        - description: Baikal-T1 System Boot SPI Controller
> -- 
> 2.17.1
> 
