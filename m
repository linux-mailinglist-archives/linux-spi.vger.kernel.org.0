Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2675A34F3D0
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 23:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhC3V5Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 17:57:16 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45698 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhC3V4p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 17:56:45 -0400
Received: by mail-ot1-f44.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so16993880oty.12;
        Tue, 30 Mar 2021 14:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yiq9zqr2bF1ffZG3y1lOgUUQqwpPi4Zm0SgUG1ke18U=;
        b=uIzlXuMkDA/OfFodXXzBLsB4AmmV0n2LUUHMMA7cQnEq/dj8rCZXqeO4Vo0ofexFpC
         9F5L4T5TFYHS6y6d8SSpn2T4Ng95q8CsN0vOl7psmA9TmQJ6J2OE03NC2X9TELD5qLLB
         LR1uIzBn54wdvpxvENFM9z5s2P5M0Kvd7wYOCC7oMoVHW5744z+tp2qqnF6/AjsvNt97
         msYiXdwk3j/0BAuHfqVWXhHRM7FEMHJ9N1odi6TYGan0fiABdCNwkhU1jQDqX0QSsInO
         mLF7zWgEt0G5DFSxvrcW7vHQzrTPGFZ3Dg3z746Gg0LsAOffpOUmc8RyoglA8Cfbm88r
         5Y+Q==
X-Gm-Message-State: AOAM532uhZ3DqC4V6UCIupAeiUufLQnVBz1qHDm0T69tH/5HBHSPp0PS
        1M9ZuF9iCkiI7kCodslZ4g==
X-Google-Smtp-Source: ABdhPJwNlwYSDo4wS09iYDx0X9S9ybh8fkN2i3UtF95xNCpFkA8/O/K3511GPZe3IXS/6f3B0THymQ==
X-Received: by 2002:a05:6830:1506:: with SMTP id k6mr59564otp.26.1617141404438;
        Tue, 30 Mar 2021 14:56:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 101sm24475otj.44.2021.03.30.14.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:56:44 -0700 (PDT)
Received: (nullmailer pid 784491 invoked by uid 1000);
        Tue, 30 Mar 2021 21:56:42 -0000
Date:   Tue, 30 Mar 2021 16:56:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-spi@vger.kernel.org, bgolaszewski@baylibre.com,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, fancer.lancer@gmail.com, adrian.hunter@intel.com,
        arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 09/13] dt-bindings: mmc: Add Pensando Elba SoC binding
Message-ID: <20210330215642.GA784437@robh.at.kernel.org>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-10-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-10-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 28 Mar 2021 18:59:34 -0700, Brad Larson wrote:
> Pensando Elba ARM 64-bit SoC is integrated with this IP
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
