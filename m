Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3CF3AA787
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jun 2021 01:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhFPXgD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Jun 2021 19:36:03 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:45798 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbhFPXgC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Jun 2021 19:36:02 -0400
Received: by mail-io1-f50.google.com with SMTP id k5so1022808iow.12;
        Wed, 16 Jun 2021 16:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b4wv1UCJ/pkil6d0MqG9zcgCWazTPegu8BlT8bPuDvg=;
        b=aPv8CxW+Azxk2QKzaUT/P+kzF5rcpDxz7gGtCIDOB8/1Y07aXrqymd2hhINEyvRRZj
         gipr152K3atQOicUyvQ9CeA7BXbcyXy7YU4K57twzI8cY1vi3+39/Km5YppvqSc+UrDl
         a3z3L6AE5UCoqJzVZtD4N6e4TBFvPckPsGznJwzzb2KhW/6OzojuBnizl/Q4HFTmhlCA
         cEKdrlE7B/hD8Vei9oiX4nIiRBYbvX3ufnNeHocOIPQ7/yI3dmxvxrrVLaYSxlUn1v4K
         aHlYRc8Vwr3DyudkoolPaXXI5V37VTnSw0JySSsDIAxMsYxJwoPRYDqqyYscnx5n0Oe4
         usTA==
X-Gm-Message-State: AOAM532n8DswDwtTxL4P+uCswr2YV2CqYdJexcamJZDtviv76gJke2tP
        Cpg9BjoosaGdeoT7tUPQ7WfoVU/5Ew==
X-Google-Smtp-Source: ABdhPJwYlUVzijslIeWyQsbyAGnxE8GsLmpDOucog+UdeRKX5R1AmmcQ6Gq0vC1xKc4dYumK4yDAuA==
X-Received: by 2002:a5d:9694:: with SMTP id m20mr1362049ion.185.1623886434236;
        Wed, 16 Jun 2021 16:33:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r2sm1826737ilt.52.2021.06.16.16.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:33:53 -0700 (PDT)
Received: (nullmailer pid 291918 invoked by uid 1000);
        Wed, 16 Jun 2021 23:33:49 -0000
Date:   Wed, 16 Jun 2021 17:33:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, robh+dt@kernel.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: xilinx: convert to yaml
Message-ID: <20210616233349.GA291025@robh.at.kernel.org>
References: <20210605002931.858031-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605002931.858031-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 05 Jun 2021 09:29:31 +0900, Nobuhiro Iwamatsu wrote:
> Convert SPI for Xilinx bindings documentation to YAML schemas.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  v2: Use enum instead of oneOf with const.
>      Add constraints to xlnx,num-ss-bits and xlnx,num-transfer-bits.
> 
>  .../devicetree/bindings/spi/spi-xilinx.txt    | 23 --------
>  .../devicetree/bindings/spi/spi-xilinx.yaml   | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
