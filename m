Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19BA43D5FC
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 23:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhJ0Voq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 17:44:46 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:43848 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0Vop (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Oct 2021 17:44:45 -0400
Received: by mail-oo1-f51.google.com with SMTP id x135-20020a4a418d000000b002b961605657so734847ooa.10;
        Wed, 27 Oct 2021 14:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ZN6Gv8dEcW1STN8Y2wfeq1p+xH2xHX+YM1iSvc+i+g=;
        b=pJBl845a8EFQQCI/4ReJyLOs5ki5lAAZr35SvzQskOn2rtmaEdi4Mg8jvkratLh8s9
         ozRCM+5TQRIct2p+nlrfQKZLKBNLas4vL+V2f5+KCroZGDz8knzK1VGhYWRAj64cLWnp
         w31Bwhl+G8AcACq+B2lkmsv0grGGkTQ5xxftSJp976ySI6VA2oy63k23YYG1gTJNWTaP
         zful9bIPCHvI5A6+1pLK+pXp9hOXwLO+qh5cnlyUxcbR/kEmuUweUcGhheKNHJ4xrhD1
         gaCIy1QX5oqLMPcvuH3HQaftjvbZszjg3VrLTO9JAFHEseSSROYF4NbWTCUEiCsZWyWc
         5jnA==
X-Gm-Message-State: AOAM530Wb2HrrufB7bmdoWvB3/MHNYZgBL0xD/Cx3phMWo+kB1AH64ET
        MDyd8CG15T8AvgeM/paccQ==
X-Google-Smtp-Source: ABdhPJy8CB+owYFlIjx4OeQ8acjoEEhZ2gt1lUZamqU0YdKU0HTcA07RQOmqMgTczHc9zBnIQAp4Iw==
X-Received: by 2002:a4a:9204:: with SMTP id f4mr152062ooh.87.1635370939410;
        Wed, 27 Oct 2021 14:42:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v22sm520079ott.80.2021.10.27.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:42:18 -0700 (PDT)
Received: (nullmailer pid 2219669 invoked by uid 1000);
        Wed, 27 Oct 2021 21:42:17 -0000
Date:   Wed, 27 Oct 2021 16:42:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     arnd@arndb.de, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        fancer.lancer@gmail.com
Subject: Re: [PATCH v3 05/11] spi: dw: Add Pensando Elba SoC SPI Controller
 bindings
Message-ID: <YXnHuRi264DkxLML@robh.at.kernel.org>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-6-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-6-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 24 Oct 2021 18:51:50 -0700, Brad Larson wrote:
> The Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
