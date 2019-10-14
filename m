Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA6D6A64
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2019 21:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfJNTyx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Oct 2019 15:54:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45014 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfJNTyx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Oct 2019 15:54:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id w6so14723009oie.11;
        Mon, 14 Oct 2019 12:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XhCUwO3XcoZWA0lhfOAn10hxUA8j/Rc+tU2JUBRZEKU=;
        b=tvYZw0/lkF64Ipy5K1yVlyJvZuKF/yhAqiiBFEyXdoZNDztEljli5UiMsxrUdkzKpC
         wmzd8xueC642KrWXouyXRe8JLB2ACennDARQMhDaYmP3HcWhgRmmU5gGPDzZWN0yk9uz
         WtIYKC+jAQUhfU2iXfNvDYohu95ORkE6XyoKhME4Eq980iL6cGqu/Y1rcMyW1BQeFuds
         1bJ3FqAc/dsZQHSncWPLay1OyNzTzkipIPnFh+y/4jY+BIvuowBYX6QSWmXDNGy8fG5Q
         YjSEaofEFAn7nfJrzZjDsGFg/sa5Q2se8S70AhdyLNW3b1mxXV1552yyPfeiXPI63DIe
         NgPw==
X-Gm-Message-State: APjAAAXNFgNQxh3lkOhPiYyawCOceauSdj2Zg1PEH3Pjqj+FxOGKzsT1
        zf2TK+0OwaEHZO1u8Kg9ofalTn0=
X-Google-Smtp-Source: APXvYqy7yioDgEjsKi7M+Drs+tKhyYVoxvGwwlK2NnsmyJlGPTvC1ZoVjbk4nW2xEVfwkPG5JYzE0w==
X-Received: by 2002:aca:eac2:: with SMTP id i185mr26462013oih.9.1571082892264;
        Mon, 14 Oct 2019 12:54:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b31sm6014243otc.70.2019.10.14.12.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 12:54:51 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:54:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>,
        "hange-folder>?" <toggle-mailboxes@bogus>
Subject: Re: [PATCH] dt-bindings: spi: sh-msiof: Convert bindings to
 json-schema
Message-ID: <20191014195451.GA22084@bogus>
References: <20190926102533.17829-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926102533.17829-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 26 Sep 2019 12:25:33 +0200, Simon Horman wrote:
> Convert Renesas HSPI bindings documentation to json-schema.
> Also name bindings documentation file according to the compat string
> being documented.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on v5.3
> Tested using:
>   ARCH=arm   make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
>   ARCH=arm64 make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> ---
>  .../devicetree/bindings/spi/renesas,sh-msiof.yaml  | 158 +++++++++++++++++++++
>  Documentation/devicetree/bindings/spi/sh-msiof.txt | 105 --------------
>  2 files changed, 158 insertions(+), 105 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/sh-msiof.txt
> 

Applied, thanks.

Rob
