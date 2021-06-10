Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B415B3A3027
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jun 2021 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFJQIh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 12:08:37 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35517 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhFJQIe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Jun 2021 12:08:34 -0400
Received: by mail-ot1-f47.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so216996otg.2;
        Thu, 10 Jun 2021 09:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rxqQk5aKXfH8UaE4CFyDXn1vUL+w5pv/lwdq0F6kEMY=;
        b=g8Rrwz04dP9Fx9kG2epFfQc7ChNqX6ihjVlFZbOhJcLycTFvy8HiiSbxfH8Otk2dmB
         rWX+Mj9We+t2K8OfeObubdFW1tOQHNMqBJvV+IhxyAYJxm4I2i93L9KdA36SfQnR3yPh
         xjxeBi2tCw1y8pcW4Pxy2QZTn9uRFJCFREkDbs1wAfSU8IvrrML5sd8UCEQa7+1MuaBv
         sk3DefnMDIEGX72amC3MT+5sx4qtcz6OnPlBUzu3ZAnzxUz8LR4eUla4WIiURmVBZ/Sr
         ZDGChjnGht3a+oS0/8oADxvLzQDgIF+TmyIt81pWoOsqM4cBkWRgyIdsue2G6p5lvQTk
         J86A==
X-Gm-Message-State: AOAM533KNl4jBDVhjirqneG9iKgGeAzREBNOamL7+x6c/x61W91fpKHY
        USqx0NXs0iB0LtbHbJE4E4EqnZiiAA==
X-Google-Smtp-Source: ABdhPJwov5RI4si9eQhd6XsEeuC32d2dIO1xtzkVyC0dJGyD0zJfZ6epsAiDIboK1+FgpVibfS0Llw==
X-Received: by 2002:a9d:5ccd:: with SMTP id r13mr3027731oti.13.1623341197323;
        Thu, 10 Jun 2021 09:06:37 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id e29sm622376oiy.53.2021.06.10.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:06:36 -0700 (PDT)
Received: (nullmailer pid 1894616 invoked by uid 1000);
        Thu, 10 Jun 2021 16:06:34 -0000
Date:   Thu, 10 Jun 2021 11:06:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: spi: spi-rockchip: add description
 for rv1126
Message-ID: <20210610160634.GA1894512@robh.at.kernel.org>
References: <20210607111837.31074-1-jon.lin@rock-chips.com>
 <20210607111837.31074-2-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607111837.31074-2-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 07 Jun 2021 19:18:32 +0800, Jon Lin wrote:
> The description below will be used for rv1126.dtsi or compatible one in
> the future
> 
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v6:
> - Consider to compatibility, the "rockchip,rk3568-spi" is removed in
>   Series-changes v5, so the commit massage should also remove the
>   corresponding information
> 
> Changes in v5:
> - Change to leave one compatible id rv1126, and rk3568 is compatible
>   with rv1126
> 
> Changes in v4:
> - Adjust the order patches
> - Simply commit massage like redundancy "application" content
> 
> Changes in v3:
> - Fix compile error which is find by Sascha in [v2,2/8]
> 
>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
