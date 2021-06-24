Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6911C3B3810
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jun 2021 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhFXUqc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Jun 2021 16:46:32 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:40576 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhFXUqc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Jun 2021 16:46:32 -0400
Received: by mail-io1-f53.google.com with SMTP id r12so9926084ioa.7;
        Thu, 24 Jun 2021 13:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jb61FtgXv62RyoPttvhABXLLkGLociNax0eiMMTdeoE=;
        b=V1sfiGoyavLl05DN8KYhJW/XqQpLqHebVkabWwxEWQx3Bn67XpKXtI1/SXBZlBE9uE
         DcdwZFuHyJB5l0YgydEWtUSs+u/YA8aT2KCXGp0LfHkh3aI7kBUw2iSus7LS8QvlrQNw
         xiaHsqdHSUrjY+LWy28oajCWROc5roPACVj8QORKRQDsus+AYMyTAbycavKJ6D9BeL2/
         jNc2Ka3YD3j9F9Eh+P0bTnHUnbnESp7L22/cJfi1TzPd2XAQ/x2uVOBApJ04KPBC2RJT
         F3AyGBE5L4uGiLEEgV9NoJ3W9KdSWQYuUyB6kMjnl4w6FlWWNiWP7pjRMN8THrA1vjP2
         meDw==
X-Gm-Message-State: AOAM532AmHtnnMKFitW/o+/Qx6+W03NRHyNvL6+9t6DXB94OTUmOaY4q
        M3pk15oYgGC01adZbR5G2w==
X-Google-Smtp-Source: ABdhPJwDbvlT7rWgdyoBcZio9FNtPl/yvT7KQ36PlsskLaNPsJwYVXasDTbSOux0xym+jdlTH05d5Q==
X-Received: by 2002:a02:8246:: with SMTP id q6mr6390809jag.130.1624567451624;
        Thu, 24 Jun 2021 13:44:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j18sm2014229ila.9.2021.06.24.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:44:10 -0700 (PDT)
Received: (nullmailer pid 1957082 invoked by uid 1000);
        Thu, 24 Jun 2021 20:44:05 -0000
Date:   Thu, 24 Jun 2021 14:44:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>
Cc:     wsd_upstream@mediatek.com,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        hanks.chen@mediatek.com, linux-kernel@vger.kernel.org,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
Message-ID: <20210624204405.GA1956999@robh.at.kernel.org>
References: <1623721803.24597.9.camel@mbjsdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623721803.24597.9.camel@mbjsdccf07>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 15 Jun 2021 09:50:03 +0800, Mason Zhang wrote:
> 
> this patch update spi document for MT6779 SOC.
> 
> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
