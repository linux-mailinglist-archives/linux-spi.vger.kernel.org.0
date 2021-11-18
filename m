Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D9F45658B
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 23:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhKRW0X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 17:26:23 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44636 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhKRW0X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Nov 2021 17:26:23 -0500
Received: by mail-oi1-f170.google.com with SMTP id be32so17444063oib.11;
        Thu, 18 Nov 2021 14:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OsaV9L6ypm1eFtYxy97Ih2+Ie2rmYMcatbNwYzIQHN8=;
        b=SveFt6O2rDkSpFtfDeYeJL7zuKq/U4RMcoPX+tVsOgREaZo/ZIg4odKlNkxY3SLGpx
         Mk1XFvuc0qnlh91osM2hjrZDWebVs2j59I0VikboN+w5DQrgy7vOXXTV8bnrCgMh1LZf
         3IcqgeZ7vSNtOZgJbJTSSUBOof2ylsEzQF6luhOw6tWUx3hBDSc/V/RLgWC1DItv6qVU
         qvPfqCP0RxPaDAMgdG8vjpgocOo49AWJHXeakS8Dj35II9rlAeIQOKDfk8PrvB3pfPKs
         DcCk3srCp4et5ynkAUXHU19MHilEqPB71LXtMPQNYiVorGpjHrL2uPzUH8kA337S/Dfc
         UZbg==
X-Gm-Message-State: AOAM530UVg65CxBasEC056sEsWQTy4YeU6DEV++TjvotsoMty+MzXwug
        zZFKGXSVEkLwI5tpliL4lw==
X-Google-Smtp-Source: ABdhPJwQaIQluWZ/UijkBOhentEr+irUw5GrTqdmEFrli8Wr1pQp9SGbS6LlABDbK/j6nU86G/VHdw==
X-Received: by 2002:a05:6808:9ae:: with SMTP id e14mr445604oig.68.1637274201868;
        Thu, 18 Nov 2021 14:23:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n23sm244380oic.26.2021.11.18.14.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:23:21 -0800 (PST)
Received: (nullmailer pid 1864118 invoked by uid 1000);
        Thu, 18 Nov 2021 22:23:20 -0000
Date:   Thu, 18 Nov 2021 16:23:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: add schema listing
 peripheral-specific properties
Message-ID: <YZbSWA5kSfORSzky@robh.at.kernel.org>
References: <20211109181911.2251-1-p.yadav@ti.com>
 <20211109181911.2251-2-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109181911.2251-2-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 09, 2021 at 11:49:09PM +0530, Pratyush Yadav wrote:
> Many SPI controllers need to add properties to peripheral devices. This
> could be the delay in clock or data lines, etc. These properties are
> controller specific but need to be defined in the peripheral node
> because they are per-peripheral and there can be multiple peripherals
> attached to a controller.
> 
> If these properties are not added to the peripheral binding, then the
> dtbs check emits a warning. But these properties do not make much sense
> in the peripheral binding because they are controller-specific and they
> will just pollute every peripheral binding. So this binding is added to
> collect all such properties from all such controllers. Peripheral
> bindings should simply refer to this binding and they should be rid of
> the warnings.
> 
> There are some limitations with this approach. Firstly, there is no way
> to specify required properties. The schema contains properties for all
> controllers and there is no way to know which controller is being used.
> Secondly, there is no way to restrict additional properties. Since this
> schema will be used with an allOf operator, additionalProperties needs
> to be true. In addition, the peripheral schema will have to set
> unevaluatedProperties: false.
> 
> Despite these limitations, this appears to be the best solution to this
> problem that doesn't involve modifying existing tools or schema specs.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v3:
> - s/slave/peripheral/g
> - Drop the | on description.
> - Drop the compatible property.
> 
> Changes in v2:
> - Move other subnode properties listed in spi-controller.yaml to
>   spi-slave-props.yaml
> - Move the Cadence controller-specific properties out of
>   spi-slave-props.yaml. They will be added in a separate file.
> - Add a reference to spi-slave-props.yaml in spi-controller.yaml.
> - Update description.
> 
>  .../bindings/spi/spi-controller.yaml          | 69 +--------------
>  .../bindings/spi/spi-peripheral-props.yaml    | 87 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
