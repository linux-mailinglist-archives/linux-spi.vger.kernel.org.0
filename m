Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4491FF9E5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 19:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFRRHA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 13:07:00 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33257 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgFRRHA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 13:07:00 -0400
Received: by mail-il1-f195.google.com with SMTP id z2so6517112ilq.0;
        Thu, 18 Jun 2020 10:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ifwduw78OWeOcpzj0vaqe6BciVp2voLLjsFlxgZqSlI=;
        b=JHUT5IuTFXlykRmFf993LPpHeY84f9UfxnycAL5sweTuCkNh98U36/T0sO+dQ/T1yR
         SrBmzZK5rIGec74gvDq9q8btyX5u8JaSTfisHCZI+MweXev/H9L35JTQqnVZG4pT9GMA
         FpLvqAXGXVZIl5BVExL7sZJh1Wy5Uix6uxdZ2vtZmXHCzVlX0vhMzOuzOXPIZgy6r+Kv
         dDl3UzV9wgkpox/pST18rz4nXS1NQj2IGRG9Pc5O/l007LEsDvPUuqPBMKl6G1L1YxHo
         cxNCp42rI7jFxydLPGpsbSEkNRIJOOr3xrYC50ABXnHP5loHKT4RIMBFOL+NAuJqjxkO
         JLjA==
X-Gm-Message-State: AOAM530/GGuU9f+AJpM+1iJsgz3KiBI3HO8aT7lihLzYYsWt2QC3RASj
        05CEt9wOB8OQ817Mhw8nlg==
X-Google-Smtp-Source: ABdhPJw81b3DAZIj3aCC5G7vPDZFbqJcRdJgtLBQ9xQ+fmU3vdQcz/N22q4w5tMZcBkmXm4va6tTMA==
X-Received: by 2002:a92:35dd:: with SMTP id c90mr5272835ilf.103.1592500019001;
        Thu, 18 Jun 2020 10:06:59 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x18sm1732593ilq.46.2020.06.18.10.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:06:58 -0700 (PDT)
Received: (nullmailer pid 539747 invoked by uid 1000);
        Thu, 18 Jun 2020 17:06:56 -0000
Date:   Thu, 18 Jun 2020 11:06:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-spi@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 14/29] dt: Fix broken references to renamed docs
Message-ID: <20200618170656.GA539608@bogus>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <6866c0d6d10ce36bb151c2d3752a20eb5122c532.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6866c0d6d10ce36bb151c2d3752a20eb5122c532.1592203542.git.mchehab+huawei@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 15 Jun 2020 08:46:53 +0200, Mauro Carvalho Chehab wrote:
> Some files got renamed. Those were all fixed automatically by
> 
> 	./scripts/documentation-file-ref-check --fix
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt   | 2 +-
>  Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt | 4 ++--
>  Documentation/devicetree/bindings/display/imx/ldb.txt         | 4 ++--
>  Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt  | 2 +-
>  MAINTAINERS                                                   | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 

Applied, thanks!
