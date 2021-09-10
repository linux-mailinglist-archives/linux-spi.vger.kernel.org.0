Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C925407224
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 21:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhIJTyt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 15:54:49 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41762 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhIJTys (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 15:54:48 -0400
Received: by mail-ot1-f50.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso3765586ota.8;
        Fri, 10 Sep 2021 12:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2zuLP9rCHZzIJroCY21Zly5x1eo7edCI8VOBOBfzzN8=;
        b=jN11AwJxfm4iUYsnLV48kLPh29KnsvEn92GyRdfzwrllu9FKjkq9gS8wjG+EsqjrmY
         1t51CV3+YPo5Lu2mRc8NDqYU8xq5x8vMWovP5wtTIbmBrESjbWTW5EwXuGvwCQwjjg6x
         3pyI20DEfK7rv0dxHkwKQi5A6nTkDG++64Fcr+0UQQywdwKVdKq+HkjtvU4GQWwgKk0q
         CngkCWUoGA61O8SnpdTX/2WHDPs828SPV1YdWlc3VF2uFfyMyqfAAeZoBxDCOQBo4hTM
         NYBlQjuJg5V6BI59dyPq+0Xe3QKwas9oYSmoiw4EUl7DwYqs+rdVz+/cpfhgmpXRinA5
         kuww==
X-Gm-Message-State: AOAM530EtAIiGpOP6kxUDK+/7PMYgmKUlakUudDBKfxO7EljVugGaLid
        LPrq4zSA6OjDYOKcVwYtWl6zVwV9tw==
X-Google-Smtp-Source: ABdhPJylT4TvkD1xEZlGY/jpyDULRrDdzmjBjmwGkhAf1yHMdmslZT9nbfWXoElKn60DHB4uNK5mlA==
X-Received: by 2002:a05:6830:2b2c:: with SMTP id l44mr6337585otv.238.1631303616968;
        Fri, 10 Sep 2021 12:53:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v186sm1672939oig.52.2021.09.10.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:53:36 -0700 (PDT)
Received: (nullmailer pid 3167699 invoked by uid 1000);
        Fri, 10 Sep 2021 19:53:35 -0000
Date:   Fri, 10 Sep 2021 14:53:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: dt-bindings: xilinx: Drop type reference on *-bits
 properties
Message-ID: <YTu3vx5FhJRJ5WdV@robh.at.kernel.org>
References: <20210910165945.2852999-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910165945.2852999-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Sep 2021 11:59:45 -0500, Rob Herring wrote:
> Properties with standard unit suffixes such as '-bits' don't need a
> type.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Mark, Please ack and I will send to Linus for rc1. After this, I can
> enable checking these automatically.
> 
>  Documentation/devicetree/bindings/spi/spi-xilinx.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Applied, thanks!
