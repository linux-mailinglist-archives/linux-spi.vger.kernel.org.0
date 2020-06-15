Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0371F904B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgFOHsZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 15 Jun 2020 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgFOHsY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 03:48:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B4C05BD1E
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2020 00:48:24 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jkjqg-0006Gk-PF; Mon, 15 Jun 2020 09:48:06 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jkjqe-000242-Ti; Mon, 15 Jun 2020 09:48:04 +0200
Message-ID: <c544bcb8ea20dadcea68e22d33c160a713c7fe02.camel@pengutronix.de>
Subject: Re: [PATCH 14/29] dt: Fix broken references to renamed docs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Date:   Mon, 15 Jun 2020 09:48:04 +0200
In-Reply-To: <6866c0d6d10ce36bb151c2d3752a20eb5122c532.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
         <6866c0d6d10ce36bb151c2d3752a20eb5122c532.1592203542.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2020-06-15 at 08:46 +0200, Mauro Carvalho Chehab wrote:
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
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 715047444391..10b8459e49f8 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -47,7 +47,7 @@ Required properties:
>  			  &lsio_mu1 1 2
>  			  &lsio_mu1 1 3
>  			  &lsio_mu1 3 3>;
> -		See Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +		See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
>  		for detailed mailbox binding.
>  
>  Note: Each mu which supports general interrupt should have an alias correctly
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt b/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
> index 5bf77f6dd19d..5a99490c17b9 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
> +++ b/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
> @@ -68,7 +68,7 @@ Required properties:
>    datasheet
>  - clocks : phandle to the PRE axi clock input, as described
>    in Documentation/devicetree/bindings/clock/clock-bindings.txt and
> -  Documentation/devicetree/bindings/clock/imx6q-clock.txt.
> +  Documentation/devicetree/bindings/clock/imx6q-clock.yaml.
>  - clock-names: should be "axi"
>  - interrupts: should contain the PRE interrupt
>  - fsl,iram: phandle pointing to the mmio-sram device node, that should be
> @@ -94,7 +94,7 @@ Required properties:
>    datasheet
>  - clocks : phandles to the PRG ipg and axi clock inputs, as described
>    in Documentation/devicetree/bindings/clock/clock-bindings.txt and
> -  Documentation/devicetree/bindings/clock/imx6q-clock.txt.
> +  Documentation/devicetree/bindings/clock/imx6q-clock.yaml.
>  - clock-names: should be "ipg" and "axi"
>  - fsl,pres: phandles to the PRE units attached to this PRG, with the fixed
>    PRE as the first entry and the muxable PREs following.
> diff --git a/Documentation/devicetree/bindings/display/imx/ldb.txt b/Documentation/devicetree/bindings/display/imx/ldb.txt
> index 38c637fa39dd..8e6e7d797943 100644
> --- a/Documentation/devicetree/bindings/display/imx/ldb.txt
> +++ b/Documentation/devicetree/bindings/display/imx/ldb.txt
> @@ -30,8 +30,8 @@ Required properties:
>                  "di2_sel" - IPU2 DI0 mux
>                  "di3_sel" - IPU2 DI1 mux
>          The needed clock numbers for each are documented in
> -        Documentation/devicetree/bindings/clock/imx5-clock.txt, and in
> -        Documentation/devicetree/bindings/clock/imx6q-clock.txt.
> +        Documentation/devicetree/bindings/clock/imx5-clock.yaml, and in
> +        Documentation/devicetree/bindings/clock/imx6q-clock.yaml.
>  
>  Optional properties:
>   - pinctrl-names : should be "default" on i.MX53, not used on i.MX6q

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
