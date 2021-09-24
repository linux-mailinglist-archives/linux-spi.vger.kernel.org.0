Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D241724C
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbhIXMrd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 08:47:33 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34791 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbhIXMqh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Sep 2021 08:46:37 -0400
Received: by mail-ot1-f47.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so7269105otb.1;
        Fri, 24 Sep 2021 05:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=qWRR6olfhGyBIP6MfENCx20He3bFcFpbGbZko4baIE4=;
        b=AzjUktlpDAkufHFFtnGUydGpmMGgSSOlMNbFkRnBD2Yt8vPQBItHOVgGxeWeX5lCLP
         b4qj4yztCb03xNamVAZAsUYbqfW0unlfSspl3c85qBRRFUlSt09mN04WFPBsPLrnGoat
         1RcCj9cSvAJo8xxu19ZH/JGo3ZPP9JhYlh7xmvAR17ApQT5Is1dnYKiN7luxkBrpUfMP
         pIbssRaZCqG3/2CqyhaApbBERQk94v0krDzPKwHnBl7B+9KcElVd5H9KmvJqoT1CwxK2
         bVXA/W7tW3usJm4FrSMcg5UO4nmRrHyEwzag/mn9ynJ652dVyscUz6tt9sQLILDINfAe
         xOaQ==
X-Gm-Message-State: AOAM532ov5SY3hZmq2/j8Lc1JW7uLvayIomO1BspQVHg17rnktV+jSiM
        EZAqgzV1p1LwlDSt98jDNw==
X-Google-Smtp-Source: ABdhPJzuzQOPMh0EHvhUTX3zyU25CBBrxWSe3IyNUcob3PgvabF0qljAM3wFwAP/hZs0NdQMMvsiCA==
X-Received: by 2002:a9d:4101:: with SMTP id o1mr3818138ote.377.1632487503944;
        Fri, 24 Sep 2021 05:45:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f13sm2076127oto.49.2021.09.24.05.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:45:03 -0700 (PDT)
Received: (nullmailer pid 1091572 invoked by uid 1000);
        Fri, 24 Sep 2021 12:45:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>,
        saikrishna12468@gmail.com, git@xilinx.com,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <1632478031-12242-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com> <1632478031-12242-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: Re: [PATCH 2/4] dt-bindings: spi: cadence-quadspi: Add support for Xilinx Versal OSPI
Date:   Fri, 24 Sep 2021 07:45:00 -0500
Message-Id: <1632487500.121231.1091571.nullmailer@robh.at.kernel.org>
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

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1532183


spi@ff705000: resets: [[6, 37]] is too short
	arch/arm/boot/dts/socfpga_arria5_socdk.dt.yaml
	arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dt.yaml
	arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dt.yaml
	arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dt.yaml
	arch/arm/boot/dts/socfpga_cyclone5_socdk.dt.yaml
	arch/arm/boot/dts/socfpga_cyclone5_sockit.dt.yaml
	arch/arm/boot/dts/socfpga_cyclone5_socrates.dt.yaml
	arch/arm/boot/dts/socfpga_cyclone5_sodia.dt.yaml
	arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dt.yaml
	arch/arm/boot/dts/socfpga_vt.dt.yaml

