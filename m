Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0913C816
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOPk0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 10:40:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33029 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAOPk0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 10:40:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so934350oig.0
        for <linux-spi@vger.kernel.org>; Wed, 15 Jan 2020 07:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h8tviBIGxzG0M2SWVlzB/ZX7WYO/ibSFmw3TBS+98tw=;
        b=Pab/oORkOYemY0tItaEP+j8UmHVoBlQZu4Nza8rrECieQNvAbGWo46HI58adIeqx1t
         mIGPOtdCRl5Qqz8Q9zFLoyxt+5c43TfwQ9QNrpiEbXTGXBW7zDM9J4MVoeCgQcF/+nsd
         MSe6eR+LJmawFzAvUzKHRnNOR5Neh/N+kWmfsKubm2rANmhc3GxsjeaQw6Srqffkqmzc
         XHZyQRFFpZdJpBvMdvjA8GRD58QhLh3I02GRHuB1zcmiqNMcq6OqJf+w7PwB3JZvvOpv
         RzxH3O1H4uwOWCU5S6mwD4i9msHbaEauwRKnPBlxwSf4XuW3k10Eq1v2Z83Mpaca8DSf
         9T9w==
X-Gm-Message-State: APjAAAUQ1g58Kiz7XU441rFHaGCEKrx0p3gLdyuMqbi6SIEoRjMTaRjP
        z5a6Nn/3RO5NXF/A2h4PLTkWldU=
X-Google-Smtp-Source: APXvYqwH0lWXRq2d0At7D4JWvZaokKJ2CRAPTl01aSpF0wKRUJ+1EOXOT14wkKqkTz2/xZ7GiIXxag==
X-Received: by 2002:aca:b7c5:: with SMTP id h188mr306386oif.100.1579102825516;
        Wed, 15 Jan 2020 07:40:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r63sm5699369oib.56.2020.01.15.07.40.23
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:40:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:40:22 -0600
Date:   Wed, 15 Jan 2020 09:40:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/7] dt-bindings: fsl-imx-sdma: Add
 i.MX8MM/i.MX8MN/i.MX8MP compatible string
Message-ID: <20200115154022.GA10946@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 13 Jan 2020 13:33:16 +0800, Anson Huang wrote:
> Add imx8mm/imx8mn/imx8mp sdma support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
