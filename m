Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD40463F99
	for <lists+linux-spi@lfdr.de>; Tue, 30 Nov 2021 22:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbhK3VE4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Nov 2021 16:04:56 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37650 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbhK3VEm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Nov 2021 16:04:42 -0500
Received: by mail-ot1-f42.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so32048915otg.4;
        Tue, 30 Nov 2021 13:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SRjxVKyNAvOQXbJboiRV08IA97eYn+tJ4Fsr3G8clFM=;
        b=xmk7O8ZcQIh+so1BPWxT4ohhMLW99bbjk34dNWVhASRuncGe2j5TWLBsHZbXE3r4bj
         Ep/8VguTUD5faEJr4L6q6YHyOlfaWf1ICznv088/O/gI9P514CEXJLBHEBM5esz56R8d
         8P2WIuIS+xTxH3TCzZb/pjYHrdlzsujStQK8V6/acDPFdYDetQabmr22blYYLn2F/mBL
         QCGGr6yOuujR32U1jW/7XzJ9Tqx4oJbn6I6xFfAyIjiD9GyQkMVRGOo+ngFITREkaRUS
         LEpBRGWUrX1kDu/BOO+i7Kg+AjdnzffDRM9478MMrXPSl/L/R5mHlHUNKneR3MX84dJs
         IQcw==
X-Gm-Message-State: AOAM533Q118X0VklFJEv+Dkhicg9VFLlI5HdLxi94OtVFe8zT/9kmfau
        24+I1QC4Bl52RhqTs7ZHL+492r4sug==
X-Google-Smtp-Source: ABdhPJyCU+YF9tEaZU3CbA7VIrF20PVRW3jtLGF6JxIofWv0yTZwgz2BpgcQx/TMn1lYIi+SzSN5cA==
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr1595358otj.304.1638306082196;
        Tue, 30 Nov 2021 13:01:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t14sm3374158oth.81.2021.11.30.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:01:21 -0800 (PST)
Received: (nullmailer pid 3005520 invoked by uid 1000);
        Tue, 30 Nov 2021 21:01:20 -0000
Date:   Tue, 30 Nov 2021 15:01:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: spi: cadence-quadspi: document
 "intel,socfpga-qspi"
Message-ID: <YaaRIDT+a5yQDvLk@robh.at.kernel.org>
References: <20211122160427.2808342-1-dinguyen@kernel.org>
 <20211122160427.2808342-2-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122160427.2808342-2-dinguyen@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 22, 2021 at 10:04:27AM -0600, Dinh Nguyen wrote:
> The QSPI controller on Intel's SoCFPGA platform does not implement the
> CQSPI_REG_WR_COMPLETION_CTRL register, thus a write to this register
> results in a crash.
> 
> Introduce the dts binding "intel,socfpga-qspi" to differentiate the
> hardware.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index ca155abbda7a..037f41f58503 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -29,6 +29,7 @@ properties:
>                - ti,am654-ospi
>                - intel,lgm-qspi
>                - xlnx,versal-ospi-1.0
> +              - intel,socfpga-qspi
>            - const: cdns,qspi-nor

Doesn't match what you changed in the dts files.

Please run schema validation so YOU find this issue and typos instead of 
me.

Rob
