Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB063C6523
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhGLUxm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 16:53:42 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:34710 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhGLUxm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Jul 2021 16:53:42 -0400
Received: by mail-il1-f181.google.com with SMTP id e13so21015069ilc.1;
        Mon, 12 Jul 2021 13:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dyW6AQCD8dT4rLHB87N795/rYHLaBj89s9/CYrVn1Gc=;
        b=cMV7UVvoR/px8L9ZJvO/CokEildd2RZ+Tg5FXFCnzwtfol4+54aC2UVbta5XZVSPnZ
         y4AEEw+HFbooRuNOQURr7a5LyP0hEhSlupXfai48OBkNuKsvo5s+92MfF2Kp/KhNMCdu
         Bkwkv/JNbYe3MLNq74fRrMtFov4PjG9EDuGVqF7L75IyVp7Ud2ib1hEk3sOcDTyC3Uj5
         iSOouLajRSwX5QlcQEF3hLtSRb+NwlYWVEUkFV01dszQNqVtCLy4b4l5VDLqnrVVV0v6
         R3pNm/bblgDGfPNOrSquie2vbAAHMNn7NP+n9vetASt0uIJuuJcFQx4pCQyw2aAp9IA8
         S7jg==
X-Gm-Message-State: AOAM533Um6j3nelVe/TDQcTM34tgUIuLNkr936ZRKWtqvMAnzXME0KQu
        3CYEFpPx6dx56KYzuiwuqQ==
X-Google-Smtp-Source: ABdhPJxpOuOpBRh0sIf6RuIoSvvX/6R6eovpNj7Y7nawoA/C3jsHmDmLufR35alnfbHXaM4z3whCoQ==
X-Received: by 2002:a92:d84a:: with SMTP id h10mr487066ilq.55.1626123052934;
        Mon, 12 Jul 2021 13:50:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w10sm4189956ilo.17.2021.07.12.13.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:50:52 -0700 (PDT)
Received: (nullmailer pid 2469475 invoked by uid 1000);
        Mon, 12 Jul 2021 20:50:49 -0000
Date:   Mon, 12 Jul 2021 14:50:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3] dt-bindings: spi: omap-spi: Convert to json-schema
Message-ID: <20210712205049.GA2469429@robh.at.kernel.org>
References: <20210621092900.951-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621092900.951-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Jun 2021 14:58:58 +0530, Aswath Govindraju wrote:
> Convert omap-spi dt-binding documentation from txt to yaml format.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> changes since v2:
> - added myself as the maintainer
> - added reference to spi-controller.yaml
> - removed properties already defined in spi-controller.yaml
> - removed unused labels in dt example
> - changed additionalProperties to unevaluatedProperties
>   as a reference is used
> 
> changes since v1:
> - split the series according to their respective trees
> 
> link to v1:
> https://lore.kernel.org/patchwork/project/lkml/list/?series=502255
> 
>  .../devicetree/bindings/spi/omap-spi.txt      |  48 -------
>  .../devicetree/bindings/spi/omap-spi.yaml     | 117 ++++++++++++++++++
>  2 files changed, 117 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
