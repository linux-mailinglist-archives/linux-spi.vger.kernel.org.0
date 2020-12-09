Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D192D4B5A
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 21:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgLIUO3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 15:14:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36044 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388057AbgLIUO3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 15:14:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id y24so2662831otk.3;
        Wed, 09 Dec 2020 12:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tr1wnuWkr1kEK0BeklAqTvYCywa0cpJviFB1nYAAXw4=;
        b=K6oio8Do7NdYv5M85vpAVf5Y/5M4Ox+43SqGektY9e11PkhVKcP6YlXMMQw9fu5/6V
         qXY6PVgc9NErL/p8+jdnUJ9nrejDlXEx0GTA3YjHQ7fQh7K+uRFkbHcyos9UTCLg9120
         lSGzyqbTdJN7XEtadmOOzK0Bn6hD6DRPilYDsBTvNjq/Ov/YUZRWZMllBjwsn1Yr4crO
         sVO26ewQU/dOABdpfeAa17J8oc2fFhRzXv5CsGhuha81tirUQom2XB+v0dU+6kq6HerQ
         RSujcDJ0ITj+2JdMNLf3+EZL4pOYeRt0tPywXFo6ZLIV++zGAKj9vP5EWhPvfQxV++gI
         3zOg==
X-Gm-Message-State: AOAM532ZjQaO8s0Gd8464mXCswT/VDNQsonAtccuJLfLcvgJ5oQWWunb
        zIGWX7Y3FWugcoFmnoay1A==
X-Google-Smtp-Source: ABdhPJxnDz4wRwnwq3knASKWzlRporePEGU5RjdCltVVGjhD92MnyR/SQ92Gdh7ihHG6kJXGIQaYZw==
X-Received: by 2002:a9d:744a:: with SMTP id p10mr3278819otk.203.1607544827815;
        Wed, 09 Dec 2020 12:13:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 59sm588847oti.69.2020.12.09.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:13:46 -0800 (PST)
Received: (nullmailer pid 864990 invoked by uid 1000);
        Wed, 09 Dec 2020 20:13:45 -0000
Date:   Wed, 9 Dec 2020 14:13:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        dragos.bogdan@analog.com
Subject: Re: [PATCH v4 3/3] spi: dt-bindings: document zero value for
 spi-{rx,tx}-bus-width properties
Message-ID: <20201209201345.GA864933@robh.at.kernel.org>
References: <20201203140531.74470-1-alexandru.ardelean@analog.com>
 <20201203140531.74470-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203140531.74470-3-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 03 Dec 2020 16:05:31 +0200, Alexandru Ardelean wrote:
> Following a change to the SPI framework, providing a value of zero for
> 'spi-rx-bus-width' and 'spi-tx-bus-width' is now possible and will
> essentially mean that no RX or TX is allowed.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v3 -> v4:
> * https://lore.kernel.org/linux-spi/20201127130834.136348-3-alexandru.ardelean@analog.com/
> * fix typos
> 
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
