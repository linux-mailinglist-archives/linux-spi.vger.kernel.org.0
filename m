Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD9B66E007
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jan 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjAQOLB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Jan 2023 09:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjAQOLB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Jan 2023 09:11:01 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB218AB1;
        Tue, 17 Jan 2023 06:10:59 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-15eec491b40so11114066fac.12;
        Tue, 17 Jan 2023 06:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcA0UxpEQhsNDGVufpb8hlNlxp1zJnY7jxSNIv1bkIY=;
        b=UYLo8gp6C3/5bBQlLviYUGYPoj7YsYAtJFvYF2kdB/cOxRANKv5ankgHd0Lz8IuNaD
         zUw1C+E+cvJNSBv09iUmOgoQTjtxczfkESQ9h8eKxZkHPMcELM5JRvY4jzl89j5n3tpF
         vI0aij9VDSwOwRG563fKsfpnBJUY0d0vSqPu5iWoL/CnoMZamTRQLu+Gjay3aihGZBU8
         SYhEWJVujX3C4Y1IjdESbS5u3o6uFZmiHi2MBx3gxlyeg+7RNufZH2YJ5L4xlv8zv8MN
         9l2r2Pzd2pqqBeIQm1EJJmYlXdGVp0MiSRAmOmuwKVqGl+OmnDk64TtliUp3WDaRtpYV
         bJpg==
X-Gm-Message-State: AFqh2krelsl04ws2JkQGsK6/qrHwb6B5W9Sr1C1ZHryZlJZAVpEpfks3
        p0TlyU8LmdccRbM7pxb+fODF/quGxw==
X-Google-Smtp-Source: AMrXdXt+bvYKgG3xG+5Mz5X74tZQdIfCrZc1fE0nhop+gW5dcn2Cy7B9f8ZD7l+5XvfEBNOgETZtWA==
X-Received: by 2002:a05:6870:5d07:b0:15e:d389:c541 with SMTP id fv7-20020a0568705d0700b0015ed389c541mr2011854oab.46.1673964659101;
        Tue, 17 Jan 2023 06:10:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m22-20020a4ac696000000b0049bfbf7c5a8sm14862550ooq.38.2023.01.17.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:10:58 -0800 (PST)
Received: (nullmailer pid 2994880 invoked by uid 1000);
        Tue, 17 Jan 2023 14:10:57 -0000
Date:   Tue, 17 Jan 2023 08:10:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mario Kicherer <dev@kicherer.org>
Cc:     linux-spi@vger.kernel.org, han.xu@nxp.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional
 sampling-delay
Message-ID: <20230117141057.GA2991740-robh@kernel.org>
References: <20230116115050.2983406-1-dev@kicherer.org>
 <20230116115050.2983406-2-dev@kicherer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116115050.2983406-2-dev@kicherer.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 16, 2023 at 12:50:49PM +0100, Mario Kicherer wrote:
> Add optional sampling-delay property to delay the internal sampling point for
> incoming data.
> 
> Signed-off-by: Mario Kicherer <dev@kicherer.org>
> ---
>  Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> index e58644558412..7952a4be938b 100644
> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> @@ -54,6 +54,12 @@ properties:
>        - const: qspi_en
>        - const: qspi
>  
> +  fsl,qspi-sampling-delay:
> +    description: delay sampling of incoming data by this number of half cycles

Use the common rx-sample-delay-ns property.

> +    minimum: 0
> +    maximum: 3
> +    default: 0
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.34.1
> 
