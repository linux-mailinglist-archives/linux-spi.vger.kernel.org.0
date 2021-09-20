Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBF4127DE
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 23:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhITVWf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 17:22:35 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37504 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbhITVUe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 17:20:34 -0400
Received: by mail-ot1-f44.google.com with SMTP id w64-20020a9d3646000000b0054716b40005so4434209otb.4;
        Mon, 20 Sep 2021 14:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aDwWZhZ+JqLWINJ9PBWjjprFme0I94GN+ZK2QmZSREg=;
        b=zY+jxVQsFlRYt55w4A89s9UlZMo4iFyXuM4rIrj8XtXx5LsaV6uvF6+7Rt0BiJmgLu
         XgW6q/f02ooN97NuMjdw6njHb/hbYV39G4/sl95Xb3ZvHAeGSZAJpceT2kJFg89u+ci2
         X5Stg3NBYZijF3xnbzGY9LMUsy2k6ZPmYPtF1lQOIoHcRyhL59tOII4QuzQsNqwVRfEe
         m8lPjFlGB7AoBoo3/qsW/FPfd3GPb2PBWioF4DxwTzxc6Dl0YFF/g0HZRsSPdLYF5aJZ
         Ze+uIiP9r7o+VaJve/VoORGYZNJdAfvZGKhTeBAOJufClyrjOr1TWjCp77omCGpugm0k
         erDA==
X-Gm-Message-State: AOAM5327i1cgj97L00pPJy+LWlV/PxFNC++4CfUMGpVX+Pm0QEY31PLH
        14uO1uuP7SJllDhswy0CQQ==
X-Google-Smtp-Source: ABdhPJx3f4YFLCskuwGNYhf8vPy8jZ1Sjzlx0HNyVZO5/+wLIc/kmVv7xC42KpluZANdMdzendDhWg==
X-Received: by 2002:a05:6830:43a0:: with SMTP id s32mr22937285otv.284.1632172746595;
        Mon, 20 Sep 2021 14:19:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j17sm3737710ots.10.2021.09.20.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 14:19:06 -0700 (PDT)
Received: (nullmailer pid 785129 invoked by uid 1000);
        Mon, 20 Sep 2021 21:19:05 -0000
Date:   Mon, 20 Sep 2021 16:19:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, michael@walle.cc
Subject: Re: [PATCH v2 2/2] dt-bindings: snps,dw-apb-ssi: Use 'flash' node
 name instead of 'spi-flash' in example
Message-ID: <YUj6yUBx0xCY9QGj@robh.at.kernel.org>
References: <20210920142713.129295-1-a-nandan@ti.com>
 <20210920142713.129295-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920142713.129295-3-a-nandan@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 07:57:13PM +0530, Apurva Nandan wrote:
> Change the nodename in the example with spi-nand from 'spi-flash@1'
> to 'flash@1' to make the schema uniform with both spi-nand and spi-nor
> flashes. jedec,spi-nor.yaml uses 'flash@' nodename for spi-nor flashes,
> so make the spi-nand examples in dt-bindings use it too for uniformity.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes should come first. Maybe Mark can apply this before you respin.

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index ca91201a9926..d7e08b03e204 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -171,7 +171,7 @@ examples:
>        cs-gpios = <&gpio0 13 0>,
>                   <&gpio0 14 0>;
>        rx-sample-delay-ns = <3>;
> -      spi-flash@1 {
> +      flash@1 {
>          compatible = "spi-nand";
>          reg = <1>;
>          rx-sample-delay-ns = <7>;
> -- 
> 2.25.1
> 
> 
