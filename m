Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94DA3FD0CB
	for <lists+linux-spi@lfdr.de>; Wed,  1 Sep 2021 03:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbhIABhu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 31 Aug 2021 21:37:50 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46635 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbhIABhu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 31 Aug 2021 21:37:50 -0400
Received: by mail-ot1-f49.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso1556464ott.13;
        Tue, 31 Aug 2021 18:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6Q92rldbSEVMRIxqN9wyFbHcFqx2uWROVuhDKiImNI=;
        b=aox9msOcxz7vh2cTmw3xyofig49MKk4OiJnAJF4gXVbYgJiGavr1+BysTILlGa/Vyi
         J6wW+lc0hRtEPOMSZtzpmt3cBHvQQ6krH9DSqA5V8TN7eTIwyNj01O2P3xtyWTnisTgd
         YjAWlcLv+WuddAp9cMQAxrHksVUevlGKZMNHwjAK9EX5q0HMITcnwlZWAQqnf1D7G/WC
         VJihJJIsLfnliPlY07t/ZtDR/m2j4xHII1ZZb8UmgtBWOHGKN2RpS+fgt7KswFy31mDI
         XrkyA8vyFx4yqXe00qlbBKOFnxPzWFCVD4qUDyIyEoc0rOjeApsyF7NUzePBZYNitWkq
         inQQ==
X-Gm-Message-State: AOAM530aUnZEMX6RhmJqqkoY55NuWbsW/trTNbGRnRFcPXHSy9d/H7J6
        SxFcYHqQlQCLEu57tkI1IQ==
X-Google-Smtp-Source: ABdhPJyXYPxgNfEtS8lvgZghZ1WHpfQt5+K4269OgEWzqSpa5vCopRUcY6fthLYutxJZP9v2JujLIQ==
X-Received: by 2002:a05:6830:1c69:: with SMTP id s9mr27667730otg.132.1630460213686;
        Tue, 31 Aug 2021 18:36:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e11sm3998691oiw.18.2021.08.31.18.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 18:36:53 -0700 (PDT)
Received: (nullmailer pid 1006825 invoked by uid 1000);
        Wed, 01 Sep 2021 01:36:52 -0000
Date:   Tue, 31 Aug 2021 20:36:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Mark Brown <broonie@kernel.org>, Pavel Nadein <pasha-net@narod.ru>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Pavel Nadein <pavelnadein@gmail.com>
Subject: Re: [5.16][PATCH 1/3] dt-bindings: spi: Document Ingenic SPI
 controller bindings
Message-ID: <YS7ZNCHz2FC/X7QS@robh.at.kernel.org>
References: <20210830230139.21476-1-contact@artur-rojek.eu>
 <20210830230139.21476-2-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830230139.21476-2-contact@artur-rojek.eu>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 31 Aug 2021 01:01:37 +0200, Artur Rojek wrote:
> From: Paul Cercueil <paul@crapouillou.net>
> 
> Add a documentation file to describe the Device Tree bindings for the
> SPI controller found in Ingenic SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/spi/ingenic,spi.yaml  | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/ingenic,spi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
