Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD4421498
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 18:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhJDRAw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 13:00:52 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:40628 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhJDRAv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 13:00:51 -0400
Received: by mail-oi1-f171.google.com with SMTP id t189so22478888oie.7;
        Mon, 04 Oct 2021 09:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRf9lN7m1MizaBDjO+s0Zs9JPX2oF3ct0IyAmro4cV4=;
        b=HPrRTxD1qH0ShvcufMfigeqCQOXh/8HmGDENa12A15iyz/D0SdYNEE0brn58TnIdah
         b3a5f3jFfby9F/dL2hehq1uh30vcQdoy80p0RnRyiegQJyfqHSWSW+1SLYunV5SdGvFu
         Ui2Rswf+PZmLiFyHNjlhi6gSXSn2OH0mPlPLMCKXf/8zsaXlLvVNp5/+h3y6PqPiA/95
         itn/kAmIIH+v/g/FLOTru8BVdXfXs41kZWHFEyapuXxQbhIGI45OdZ2053nwuRyBaAiM
         v9JJ3Qj3LH4wFUEdKW+Bs2I7dLA60Yultch6KPfRVDuhFSDUf4jcs2Ch9/54NMx5GhOQ
         YG0g==
X-Gm-Message-State: AOAM532F0iRb3GNZ7DWcRDMLbu82bTL0i4h/Ky8nv+FE1dB1fwb7QH/t
        ui+y5Q+rLUiCDWId07MljQ==
X-Google-Smtp-Source: ABdhPJwrCKcWqempDcsfwdO1FFwForuRwHNTpP4MIA5D5QoMquSYfypKArc2H4qE5ppmW9mk+abT1g==
X-Received: by 2002:a54:4d9e:: with SMTP id y30mr14090591oix.50.1633366742052;
        Mon, 04 Oct 2021 09:59:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id be7sm2844535oib.15.2021.10.04.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:59:01 -0700 (PDT)
Received: (nullmailer pid 1472190 invoked by uid 1000);
        Mon, 04 Oct 2021 16:59:00 -0000
Date:   Mon, 4 Oct 2021 11:59:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        saikrishna12468@gmail.com, Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, git@xilinx.com,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: spi: cadence-quadspi: Add support for
 Xilinx Versal OSPI
Message-ID: <YVsy1Fyyu1CzcusH@robh.at.kernel.org>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1632478031-12242-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632478031-12242-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 24 Sep 2021 15:37:09 +0530, Sai Krishna Potthuri wrote:
> Add new compatible to support Cadence Octal SPI(OSPI) controller on
> Xilinx Versal SoCs, also add power-domains property to the properties
> list and marked as required for Xilinx Versal OSPI compatible.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
