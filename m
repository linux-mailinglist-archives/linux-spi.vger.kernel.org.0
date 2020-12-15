Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86F2DB0E7
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 17:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgLOQEe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Dec 2020 11:04:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34689 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbgLOQE0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Dec 2020 11:04:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id a109so19831680otc.1;
        Tue, 15 Dec 2020 08:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u7qXHHThS02dtHu7Aqjjc7PXT9NNzijUXUlDQiFdYE0=;
        b=TxqLSx7KNpjlBF7o9H8PcWs9jl6glD8iOpFCtpqWgXgM+5KuKpOPJauCwANP+KOVdV
         l/zJJ53VeevNpFYNAuzGps19FNDv4IFnOckkYnROwdDn+f/VjCXZLfidTRIBHA5yH9Wd
         65jmPWHQ1Jh8Rdyi2UsmdYzOdXy4EePgJyNljtTW31jF/8erdmpdbZJyZilWP/ajnDP3
         FRShF/PZWnMn6G9RctXqyz++iKCs95eWKUlbHN4V7SBw7J3iJNLK5KSOHVWcdY2xiMvN
         ewdT4CNwOE22+TQs6cRMYFR2NJCgB5LG35p2E4Rx4bNIk00699+vFCpuTebVrgk7K2+N
         6ciA==
X-Gm-Message-State: AOAM532JF5EeYXV1E/s9Lj49K8w3lHR6fZjnwiMnJYsyRZYVJJ48XHo5
        r2/YgQebgqm6l/uQ+oBZMQ==
X-Google-Smtp-Source: ABdhPJzvunpT4lRbwVf22tk3XB9+TSjrJTGmOiOe5GkF3U6lZNFl7GE1uhuIaZcMJmZxLaCxtXpEog==
X-Received: by 2002:a05:6830:18f7:: with SMTP id d23mr22238041otf.191.1608048225440;
        Tue, 15 Dec 2020 08:03:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o6sm4767421oon.7.2020.12.15.08.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:03:44 -0800 (PST)
Received: (nullmailer pid 3935079 invoked by uid 1000);
        Tue, 15 Dec 2020 16:03:43 -0000
Date:   Tue, 15 Dec 2020 10:03:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com, robh+dt@kernel.org,
        bbrezillon@kernel.org, linux-spi@vger.kernel.org, lukas@wunner.de,
        broonie@kernel.org, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: clock: tegra: Add clock ID
 TEGRA210_CLK_QSPI_PM
Message-ID: <20201215160343.GA3935026@robh.at.kernel.org>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
 <1607721363-8879-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607721363-8879-2-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 11 Dec 2020 13:15:55 -0800, Sowjanya Komatineni wrote:
> Tegra210 QSPI clock output has divider DIV2_SEL which will be enabled
> when using DDR interface mode.
> 
> This patch adds clock ID for this to dt-binding.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra210-car.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
