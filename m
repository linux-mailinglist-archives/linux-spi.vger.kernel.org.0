Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D63A34F3CC
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhC3V4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 17:56:45 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42529 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhC3V4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 17:56:25 -0400
Received: by mail-oi1-f177.google.com with SMTP id n140so17974488oig.9;
        Tue, 30 Mar 2021 14:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7TCGSPgVT7Mab4Tqosi3U77jBZKKIH6kI6DnIKM/fUw=;
        b=p8x55HGSAhuxy008Ri6BW/wJl7x+1vJ3EVrqxwjfTgUqq4s3tVB9BDxRK1ZYjMo8So
         hZVRpeBrd+aBMtz32WQ8+PubRdkZMu7ts95iitK2zNhhQXV8lqDy7wBYzQ9PcALALREb
         J8O50XvIS1dxuW4oiPFvVqGnYSj20MTDa1jkrzA2tS5huMaVuP8F5irYFmUUth4IsCTW
         moYWIlgYAJa1iLxxEbaKTwbetXm9TxLWyBmKrUy8okzmlcX6wWlUx1tTeRGKEes+CEQm
         edgg8Z7VCl80wA09UForFt6oIz/SIuHlnxvXa548ntJs7LEQOj1biVAYjKifgmCo1c60
         eTIA==
X-Gm-Message-State: AOAM533F8CIdsMO0PLFyazqAwU9C+bMnYmLgTgiW6nKDIfHcKSMmRR0G
        Y/iWwP6Ij8EEGWmpElnN0g==
X-Google-Smtp-Source: ABdhPJzEHSxrF0i+GPGvwfLlqVUvzr/exHntFHgp4Aw2tUoHt+uw48RdBbY7ZR7l5oW6DQcjlgHlUw==
X-Received: by 2002:a05:6808:1383:: with SMTP id c3mr64621oiw.42.1617141384325;
        Tue, 30 Mar 2021 14:56:24 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a15sm20877otd.57.2021.03.30.14.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:56:23 -0700 (PDT)
Received: (nullmailer pid 783952 invoked by uid 1000);
        Tue, 30 Mar 2021 21:56:22 -0000
Date:   Tue, 30 Mar 2021 16:56:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     broonie@kernel.org, olof@lixom.net, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        fancer.lancer@gmail.com, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org, arnd@arndb.de, bgolaszewski@baylibre.com
Subject: Re: [PATCH v2 08/13] dt-bindings: Add pensando vendor prefix
Message-ID: <20210330215622.GA783922@robh.at.kernel.org>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-9-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-9-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 28 Mar 2021 18:59:33 -0700, Brad Larson wrote:
> Add vendor prefix for Pensando Systems, Inc.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
