Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A59C44D84C
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 15:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhKKOeI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhKKOeC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Nov 2021 09:34:02 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506D5C061203;
        Thu, 11 Nov 2021 06:31:13 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y26so14561863lfa.11;
        Thu, 11 Nov 2021 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AW42d9vntwUuzupFqiI2Bns0JY8PI9k2Wa9xi//eMBI=;
        b=bZcJGgUdY6Fm+ERsHGGETjEBIe2GcRXutGt0DvLcjhRrR+msAten9K+hdlRLSOkwCy
         KeFhENCzEHXYKdEnsB2K0GH6gg1y+bs/G++RLOazwViRyFBP+m05FC0j0+RHkyAjJUut
         9LNyovEUU4Y0HD1T1naArSIumvgw6w1ZkhZSxtwOPoK8PLz0zpA12lyLbXC4klqxZR7e
         fjIiBFRRG8nHNRLIgdtSlR+hrkUfcYo0RHnKJuxj/dUeldz7NZ0+uIj3lKo2BNaRhXo0
         GNdeZ73I1DiElIrE9gAyoOlTM4srIupr7RRck7tLD8uva8mU8e9rWjQuNF63DFb9kI49
         hTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AW42d9vntwUuzupFqiI2Bns0JY8PI9k2Wa9xi//eMBI=;
        b=HorAPTpUyKdaZp716bgz+LMj1NFfEHcZLofMQiHqptzNHfavJYFweAH57e2QXSsxJS
         j3yLQTCtBri7GGB1n099OySpbk3HQjWA3TU+MqJvuY5PbQIdfY7XAKXFcvya0Fstcq18
         4JbR+AFTom9vsoOZjeMwxdYAY78/taic7Lq0/oTj98/n3u8Jyjlh2PJ/KbLPlBwWfJKl
         3Rh5wGMQW1zY5pE/K2Et0cghAokGFaR0D6f7wFXZgDCl8Jec7jMPoSAC85PYVtINXezA
         qlyY/ZtnIQJiVQ3gK4vOCpo+b3a4KgyAdpMRDyhzY4LzmmYUTzsiVHI/Ymk0qnY9oO6v
         WNmw==
X-Gm-Message-State: AOAM531rTCFxpdrMMUYi818mqolxmRQ0ho25Xm+RobsCfBJwKNXjqlG8
        k+BwB16XcZKPDX0lvNpMotM=
X-Google-Smtp-Source: ABdhPJysT58YQnIwuZnJm2iCHkbs1ihbTuzjlyHQPA2hitYk/yoV+g3qEojPDClg20dYVPQGTMdh2A==
X-Received: by 2002:a05:6512:31d:: with SMTP id t29mr6992891lfp.331.1636641071586;
        Thu, 11 Nov 2021 06:31:11 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id a18sm298011lfj.191.2021.11.11.06.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:31:11 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:31:08 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com, broonie@kernel.org
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v3 1/5] dt-bindings: spi: Add SSTE support for DWC SSI
 controller
Message-ID: <20211111143108.pxovseqvm2ywmoc2@mobilestation>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111065201.10249-2-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Nandhini, Mark

On Thu, Nov 11, 2021 at 02:51:57PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 

> Add Slave Select Toggle Enable(SSTE) support for DWC SSI controller.

Nandhini, as Mark said this is no need in this new property since that
feature is supposed to be enabled by the client drivers by means of
setting the SPI_CS_WORD flag in the spi_device->mode field. (See its
usage for reference.)

BTW Mark, why not to have a generic DT-property which would set that
flag automatically by the SPI-core subsystem seeing it's indeed a
client device-property? For instance there can be some property like
"spi-cs-toggle" DT-property which when specified for the particular
SPI-client DT-node will make the SPI-core subsystem to set the
SPI_CS_WORD flag of the device mode? Like it has already been done for
"spi-cs-high"/"spi-lsb-first"/etc.
In this case Nandhini would need to just convert this patch a bit so
to be fixing the Documentation/devicetree/bindings/spi/spi-controller.yaml
bindings instead.

-Sergey

> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index ca91201a9926..866416d01e94 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -149,6 +149,12 @@ patternProperties:
>            is an optional feature of the designware controller, and the
>            upper limit is also subject to controller configuration.
>  
> +      snps,sste:
> +        description: Slave select line will toggle between consecutive
> +          data frames, with the serial clock being held to its default
> +          value while slave select line is high.
> +        type: boolean
> +
>  unevaluatedProperties: false
>  
>  required:
> -- 
> 2.17.1
> 
