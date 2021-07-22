Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF513D2AF5
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhGVQbV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhGVQbV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jul 2021 12:31:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30C6C061575;
        Thu, 22 Jul 2021 10:11:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b16so7003360ljq.9;
        Thu, 22 Jul 2021 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kW0eXva7xVNT5G9+x5mEsNAXW41r17zcwLN4lzd0IxQ=;
        b=Vm6PLOPVETZO6N0X9Ba7B3KUZ7fxh0X83imeI35Xv/IdXsZIxFBMUHvgjbbLkFn2pC
         vaD2gg+JavZWm28ryNIAwFRunEiCjdFjenIvEGbkdCjk+mU5UZvPM6omIEEJQnHY3MmR
         ig1+495y4kS3cxP/D4MnopnK9t6z1PvLy2rjjkoKDIVzE24OIw4DIHhN4coRCEN14Xri
         5YOleXTNLlWSMhJ+GdKjG+bEXHeOZhLgQ2LOLqdatADW8qfDMA9H/s8DaI3Y+91Ei2gS
         Prj2NshJJ5AIdW6aqykduhEe7Frlb6ua1BQCiK+O1NlC3DjYEw8a7Rd49UmE/uaBTV4n
         Xk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kW0eXva7xVNT5G9+x5mEsNAXW41r17zcwLN4lzd0IxQ=;
        b=Mcm9lBx/grEE77Ob9xFCWBWvyJypd7ZGfpIZH9RaDRWLVJ3jt8HdwSWqPaEvOu1myd
         46/J5sGAhzzVX+TnAKLkn7juWTHe0c20CZPOTUAad6s+kc+kf+8+zlUundAn2azvKrXD
         6zvyvKQsXfAPL3EIB3ikba+IGzSP1p+5CyjTYAz9kmZgHgCyurgVvqZbINDJosZjxDhB
         f4diD9L7dNcijkUggiyb2ytY9IV/3An7TRBkXGsfakE3Tm1lbDJ1LLDs+8+7F8K5ZmvW
         DLSTbDqIi49VWxA9xCwlyF5v9BFZkY7G8wCsezldYuZEcILuVHgCoZOJrBse3q28Blng
         BryQ==
X-Gm-Message-State: AOAM532YPhxUA2sVtBzr5rRVn7d3LaEmW7pQ1fwpdJ9lLZvDTGvQO3fx
        xcMUQ4QvHzDeyH0rxke5mYc=
X-Google-Smtp-Source: ABdhPJy87VsWPSRFkTl8PqSOtY3yxklXiYjLxBBJDaptvPUR/kvJ/ObPLSC1877ss4SnHSGbKv0WKg==
X-Received: by 2002:a2e:9794:: with SMTP id y20mr645880lji.417.1626973909136;
        Thu, 22 Jul 2021 10:11:49 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id j26sm1386101lfh.71.2021.07.22.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:11:48 -0700 (PDT)
Date:   Thu, 22 Jul 2021 20:11:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: =?utf-8?B?W+KAnFBBVENI4oCdIDEvMg==?= =?utf-8?Q?=5D?=
 dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
Message-ID: <20210722171146.fux2nkoz3gz5ck2p@mobilestation>
References: <20210722053358.29682-1-nandhini.srikandan@intel.com>
 <20210722053358.29682-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722053358.29682-2-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 22, 2021 at 01:33:57PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 

> Add documentation for SPI controller in Intel Thunder Bay SoC.

In the driver-part of the patchset you said that the reset control
is required for this controller. Then the bindings file needs to be
accordingly altered. See the way it's done in the "allOf:" block here.

If it isn't required then this part looks ok to me.

Regards,
-Sergey

> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
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
