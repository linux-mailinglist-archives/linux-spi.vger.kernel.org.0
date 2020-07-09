Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646F421AB86
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 01:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGIX0g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 19:26:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42477 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIX0g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jul 2020 19:26:36 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so4137579ioi.9;
        Thu, 09 Jul 2020 16:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qBBiKVAEwV0csR2KHgZP1aEu5doNildOz5brRqIvOE=;
        b=pNS97OGHYffRnd+8s0+166MAwja6y2NdBJGratPyN6wWNoPmRbBiqb/trUV4BwYFZ0
         1nFvQX4bEd+B7ohi+cxX0GIJy5OWk2xYmizVTM6BcZ45HJMD62CYL8lUCWVILbxpEgaj
         8S16uS1c29Jep9IvbmYMiUm13hobtZ21C7yYNdZ/SZy4gneVrCqUMoFbRP3w3TizJd+V
         rBLbarQ+KGlTMMgPkNgwEX/t4etG2ljzKQtICN4Mk8s5G0Xcbuj4MQhcurfwr/V0TGvj
         pPWlbbvtqJPfKo5JEk6jy/fu8AeRDfw7YC4WOIwoyl+WKat9expb1CwXsf8UMTWWzs1R
         BT3A==
X-Gm-Message-State: AOAM533DIU5KT7UKXrlAMRrmBjtXTBLM/KPwvXVPrC7jqmlJy1BrHtmB
        uPVLWRy6GIddEBpQCxAwtg==
X-Google-Smtp-Source: ABdhPJxZ84RtZ9dBJ7PT0YLFvMCuODq/mOXFzn2IHZs4voJJrnOFgJuUsKcK23DdSq/g4j1nI/GzwQ==
X-Received: by 2002:a05:6638:14c5:: with SMTP id l5mr73891024jak.134.1594337195695;
        Thu, 09 Jul 2020 16:26:35 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id u15sm2853758iog.18.2020.07.09.16.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:26:35 -0700 (PDT)
Received: (nullmailer pid 1095549 invoked by uid 1000);
        Thu, 09 Jul 2020 23:26:33 -0000
Date:   Thu, 9 Jul 2020 17:26:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, marex@denx.de, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        festevam@gmail.com, Linux-imx@nxp.com, s.hauer@pengutronix.de,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH V3 2/3] dt-bindings: spi: Convert imx cspi to json-schema
Message-ID: <20200709232633.GA1095495@bogus>
References: <1592281575-32708-1-git-send-email-Anson.Huang@nxp.com>
 <1592281575-32708-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592281575-32708-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Jun 2020 12:26:14 +0800, Anson Huang wrote:
> Convert the i.MX CSPI binding to DT schema format using json-schema,
> update compatible, remove obsolete properties "fsl,spi-num-chipselects"
> and update the example based on latest DT file.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- remove redundant "maxItems" in "clocks" and "clock-names".
> ---
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       | 56 -------------
>  .../devicetree/bindings/spi/fsl-imx-cspi.yaml      | 97 ++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
