Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7263C93
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2019 22:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfGIUMU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jul 2019 16:12:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33892 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfGIUMU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Jul 2019 16:12:20 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so731921iot.1;
        Tue, 09 Jul 2019 13:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+kBe5+VPORj1fROpbe98ZEAclu7jCMNvUYfwW7HOV6I=;
        b=kptYTOhG8PlODg66m5v7sgG3/HLtWjZnSY6vBHKBQSlK+BlkRzv2i2rdSEntHpkZvo
         8T2ONgzYqcSp+epQWeAoouvV3V48WBPUssEKfjfNSCJ6FFW/lC3ESG3AdkWQ5lhkKxok
         fu9z9wFqs1Tgitz5tQOvb5ikqf0AI3DXtg8kvlcDVxyg8ehOOvZkIuo/26RB7hv4/dEa
         kSF9zQiOrZTc2u5GlzmWC68/KF2kjJK4ynnwzWHm1fvVkOccoBI2NvGrQdhTHGebB14S
         JAP+bFbbZ2cRG0EvkcwqRQKUhogmJQ5zBKKRnChdUfQbo8o4LX5gsxBFexkVH2xLbVAd
         5CXg==
X-Gm-Message-State: APjAAAUvu2Nv+wchvK1ispisKKJ0qan28tpIFeYY/YvGfXkF8lk4tneW
        kc8XcFzsXD73TescYnUfGQ==
X-Google-Smtp-Source: APXvYqz5atshfJXU2iELOC6XAJhSDZlBwNvldUwzJSzmS5affSJTTbxJpSg9yCpv+SRh4lxyXr5rxw==
X-Received: by 2002:a02:3f1d:: with SMTP id d29mr31737503jaa.116.1562703139276;
        Tue, 09 Jul 2019 13:12:19 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n7sm16599737ioo.79.2019.07.09.13.12.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:12:18 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:12:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>,
        Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com
Subject: Re: [PATCH v14 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Message-ID: <20190709201217.GA14681@bogus>
References: <1561023046-20886-1-git-send-email-masonccyang@mxic.com.tw>
 <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 20 Jun 2019 17:30:46 +0800, Mason Yang wrote:
> Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
