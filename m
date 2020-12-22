Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CE2E035B
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 01:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLVAUs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 19:20:48 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:42048 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVAUs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 19:20:48 -0500
Received: by mail-oo1-f51.google.com with SMTP id x203so2601859ooa.9;
        Mon, 21 Dec 2020 16:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yvHHuwyCZoBK0z/SFdvUuZ937X6pkkM/Z3TvGFl0Pcw=;
        b=QeUHckHWxyldxW7MhtTDetUx509fLPeqbL3fYFFKWHF2McB1ZM+lvseNfMDdzlMJz7
         aCPfry8ehsvhR5HJGY151sOX9Z13eTCZlKUeu7J4MENG2AlF/cB37AtRXO7Fl7M3OWUQ
         s1woErQH4CfiR/NO0GM5xn2qfzw7hxz80L8RsIyglZtXtQdqCXealI9lvrHckoGk2q2G
         p4SA/KueuQTPi7RbycnVBlB2v0DqgQb8An4ypsq6+4KFQEE4Ybompz/LpbPaQGllvH/B
         7OSU3WYwxF10NG8ooNdPEWk3/LJ1Qvu7vP68S3Sin7t2J1FF6IzpyTn29K1x6cR+xBex
         yXmA==
X-Gm-Message-State: AOAM530o1kLC6icHnJPajtIoMQrTSxOCaRp4fc5P7Q1AvPP/URxowpOv
        d5x/qJ7jwOdy5/k1u2ZhGQ==
X-Google-Smtp-Source: ABdhPJzxZODTJQpMMnguJogQ/bXU7Igm46uEPvk3jxaVMljTdiRCxz9MwiDkpSqerUUgbZMtmo5zfA==
X-Received: by 2002:a4a:901a:: with SMTP id i26mr13266038oog.42.1608596406891;
        Mon, 21 Dec 2020 16:20:06 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k3sm3988991oof.31.2020.12.21.16.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:20:05 -0800 (PST)
Received: (nullmailer pid 910101 invoked by uid 1000);
        Tue, 22 Dec 2020 00:20:04 -0000
Date:   Mon, 21 Dec 2020 17:20:04 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     p.yadav@ti.com, robh+dt@kernel.org, tudor.ambarus@microchip.com,
        jonathanh@nvidia.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        broonie@kernel.org, lukas@wunner.de, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, bbrezillon@kernel.org
Subject: Re: [PATCH v4 2/9] dt-bindings: spi: Add Tegra Quad SPI device tree
 binding
Message-ID: <20201222002004.GA910018@robh.at.kernel.org>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
 <1608236927-28701-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608236927-28701-3-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 17 Dec 2020 12:28:40 -0800, Sowjanya Komatineni wrote:
> This patch adds YAML based device tree binding document for Tegra
> Quad SPI driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad.yaml         | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
