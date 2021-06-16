Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC453AA78F
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jun 2021 01:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhFPXil (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Jun 2021 19:38:41 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:41647 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhFPXil (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Jun 2021 19:38:41 -0400
Received: by mail-io1-f42.google.com with SMTP id p66so1049737iod.8;
        Wed, 16 Jun 2021 16:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dBgSKzg+OG1fjJdv7NgXh988HzECY/j5M/Ly5wHlw50=;
        b=NOgNjVudBpotjAYKuHYYjYLBLQ0dVENBBB06DA+xRQMFA5PapWrXftInosN+H1mtnK
         3wCDEqOduTLMXHD5B7swk/2CCUAMMNUEijREq8ufeJ45Al/88ytzI+9coHCxrU2kjIWi
         WLaH6dWtx8aMJ5GvzYRPCQZ3U54ZkYb942Hl69URGHL2y2CWSeQiQBGCF/8/wmq8fabR
         7kiE/Jhe3F3R9O+bhTXAfy2LbsFkeruXYJtGIgeSmY3t/VIei3AmgLfP8Y5cR158+XJ8
         yG3kEDASMbLjOpv2O2uB9+MWcO1YPsz4siSj0xEEYJspLd7kdmmj1WB+mZNuANdc5LLS
         +FTw==
X-Gm-Message-State: AOAM532BH1qlJ7j4MD2+rDL5Gwwafnrrzu8MoX9gGgpW94nOVPUjIFk5
        un26/LaZ5uVXkfaQvt//HA==
X-Google-Smtp-Source: ABdhPJzZEgtAl9jMW+KvMkV4aY/u5jKwWcr7UKyE6F4oyV4aZrmD4depkfFOTPMmLam4hNJ/m8LxNg==
X-Received: by 2002:a02:c014:: with SMTP id y20mr1629995jai.107.1623886593845;
        Wed, 16 Jun 2021 16:36:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c22sm1939298ioz.24.2021.06.16.16.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:36:33 -0700 (PDT)
Received: (nullmailer pid 295461 invoked by uid 1000);
        Wed, 16 Jun 2021 23:36:31 -0000
Date:   Wed, 16 Jun 2021 17:36:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     michal.simek@xilinx.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        harinik@xilinx.com, robh+dt@kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: convert Cadence SPI bindings to YAML
Message-ID: <20210616233631.GA295427@robh.at.kernel.org>
References: <20210605003811.858676-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605003811.858676-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 05 Jun 2021 09:38:11 +0900, Nobuhiro Iwamatsu wrote:
> Convert spi for Cadence SPI bindings documentation to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
> 
>  v2: Add ref and enum is-decoded-cs.
>      Add ref to num-cs.
> 
>  .../devicetree/bindings/spi/spi-cadence.txt   | 30 ---------
>  .../devicetree/bindings/spi/spi-cadence.yaml  | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
