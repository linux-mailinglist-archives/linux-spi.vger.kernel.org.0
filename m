Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0D3F79CF
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhHYQGJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 12:06:09 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45732 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbhHYQGI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 12:06:08 -0400
Received: by mail-ot1-f45.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso23770769otv.12;
        Wed, 25 Aug 2021 09:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23tuXCnrXm28TiY2x5woHKXy7wqyajMKFQqBCk4bLyw=;
        b=Bn0s04P+IjTbP+EJ3ZW+bY1qVvVVS/ZKay8H9ETCsSG/mbx2epRoD2wiHdlU5PTket
         MHKguMwf67WbjXquo/IKSmFttJu+vHYn/IS5bV3do8rVwFUCkfBjX600gZ8g2839xrtA
         bKdVMIA0Dlihf+mnyEJj145mcO1JbC7V3AiUHja3yagDUn02Jzm/+Y2pJfCLj+EI3yVh
         wnXdw4Vi46iwNxV+gaexjTTeC8ebRx8OddO+Uf+tm9CCUceE0eYRY6zeOJ4UkpVc/Qa0
         ECglNNorwLBC9Z9j9KSXwaIy/RkMdhBkksHWQ8K2+dWzeil15EElaRqCsKKz2y23TA9z
         KvMQ==
X-Gm-Message-State: AOAM532rNRLKcP+p/I45ORK3zTVJly0aKWZuYHB4zcNqauaPMyTIBjX8
        CX6E/eMtVx/cMA6ij/brxtHG9/3Hbw==
X-Google-Smtp-Source: ABdhPJyxNQAVYxnpQdtzNvsQFCTQpy7pDkpvIqO95m/5JpC8845G/LT4dKW2+Rai47BHDMVraVdLpA==
X-Received: by 2002:a9d:ea5:: with SMTP id 34mr9175744otj.258.1629907521464;
        Wed, 25 Aug 2021 09:05:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i27sm47316ots.12.2021.08.25.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:05:20 -0700 (PDT)
Received: (nullmailer pid 2871006 invoked by uid 1000);
        Wed, 25 Aug 2021 16:05:19 -0000
Date:   Wed, 25 Aug 2021 11:05:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        linux-spi@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Luting Guo <luting.guo@unisoc.com>, devicetree@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH V2 3/3] dt-bindings: spi: add sprd ADI for sc9863 and
 ums512
Message-ID: <YSZqP9WfijcVeJ3Y@robh.at.kernel.org>
References: <20210825065931.2111159-1-zhang.lyra@gmail.com>
 <20210825065931.2111159-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825065931.2111159-4-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 25 Aug 2021 14:59:31 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This patch adds support for sc9863 and ums512.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
