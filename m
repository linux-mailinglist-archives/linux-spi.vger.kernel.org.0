Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC71276252
	for <lists+linux-spi@lfdr.de>; Wed, 23 Sep 2020 22:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgIWUmU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Sep 2020 16:42:20 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36659 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWUmU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Sep 2020 16:42:20 -0400
Received: by mail-il1-f195.google.com with SMTP id t12so959164ilh.3;
        Wed, 23 Sep 2020 13:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fS6oQh2hrP6bIAjUY49Vx0h9Xj6F6+mhuU4YtCGAcxA=;
        b=NUNMPKkAgrvSjHJEM52OguqsssOK5r3d6prgfUXOnOtWZ7tAkbRpDIqr9y2vMPwQIW
         pJ9g33OCY48mUEwtTeBGlx/X45GaqEr24IH8D2cDgIjDiNC3EJa6OiRtMLGfpiV0rkHR
         WnwX2KPRHqH6IZrBXGmxrXQhhKF5b2U3kpnUIlxB8eAXJ0ym9AV4zj6d19SPQwiFGH3P
         SYuTbWK9vbeQOSllWG0P7n/n0ft/eCOQJUT7edPbQkMRZNwCmRK7KejFbjlAH66gy2n8
         DZtpothlcprRWVGYT5FCvWdjAzxG0HA7BKNrZCoA+SG2TJsqYLlv3L1cdwQJ4AGjWvy/
         W4NA==
X-Gm-Message-State: AOAM531CzQNtgKOBOki5rPsLFUZ/P9DkWHUrMvpX/ep514jNwADzQgAR
        t4HUTZHyqlOxBjpWuGHXtw==
X-Google-Smtp-Source: ABdhPJyqTnaRXnDMPUpPR6Jh9uxMucw+SSn9Nb8IY7jUVy+XQm0dh3Alxg5sLL+gSWhdC7dFeM+uzA==
X-Received: by 2002:a05:6e02:787:: with SMTP id q7mr1321057ils.298.1600893739786;
        Wed, 23 Sep 2020 13:42:19 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a11sm392698ilk.19.2020.09.23.13.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:42:19 -0700 (PDT)
Received: (nullmailer pid 1270392 invoked by uid 1000);
        Wed, 23 Sep 2020 20:42:16 -0000
Date:   Wed, 23 Sep 2020 14:42:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Bayi Cheng <bayi.cheng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: spi: add mt8192-nor compatible string
Message-ID: <20200923204216.GA1270362@bogus>
References: <20200918083124.3921207-1-ikjn@chromium.org>
 <20200918162834.v2.1.I4cd089ef1fe576535c6b6e4f1778eaab1c4441cf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918162834.v2.1.I4cd089ef1fe576535c6b6e4f1778eaab1c4441cf@changeid>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 18 Sep 2020 16:31:19 +0800, Ikjoon Jang wrote:
> Add compatible string for mt8192 SoC.
> 
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
