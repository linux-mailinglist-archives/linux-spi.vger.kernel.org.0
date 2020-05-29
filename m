Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DBE1E8366
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE2QRj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 12:17:39 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38043 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2QRi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 12:17:38 -0400
Received: by mail-il1-f193.google.com with SMTP id q18so3044195ilm.5;
        Fri, 29 May 2020 09:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1WA+w4gWKVFAKdOjyjOP/tEtWPocATjUQITVK+3DOw8=;
        b=PDY+zC261G1ze5ju591N9UrtXa3empNkOHi/d6aSVDxgN1Nty79WfF68uWvE6OvPd3
         6KjVsuHnHZ5l+WeShXbBux6sAI1SzOUdyLyko/06X8jXUiJf+MsEnxIO4RmJz0GZstSA
         p4hel2i10k519xHSGNdCc+CZ2KMstaolJMaytNUe/NP0Ex50v+6Mn0kf2zPWwFE9U2NH
         PT4NV9n0gaIc7uW+WeoPdm91L8GUQB8IoEr27oF+BX2X8WMqjOtF8mANaRDzcZv65tTO
         ANQyaB4BEtjGXZP/yDzLeAaOIpYmFDaKP7smGZhZfol/6n2Lbu/ZI848LnWdHNn0YEY9
         DtnA==
X-Gm-Message-State: AOAM5322RZm09Iwx18hoiEXZ4aY962uhLi2+HVcJtIUukOuM/xqqFNQ6
        NuJ9eJi/3TQlnWs/TqKGAg==
X-Google-Smtp-Source: ABdhPJzaiMsri3Ce6ct811n/Nx3VT+C3nOOEcWn2ikVVXzQHkkLZAWZnsnOcN0C90jGOSCtG3QTx+Q==
X-Received: by 2002:a92:9142:: with SMTP id t63mr6838165ild.191.1590769056769;
        Fri, 29 May 2020 09:17:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j63sm1083926ilg.50.2020.05.29.09.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 09:17:35 -0700 (PDT)
Received: (nullmailer pid 2494095 invoked by uid 1000);
        Fri, 29 May 2020 16:17:32 -0000
Date:   Fri, 29 May 2020 10:17:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     robh+dt@kernel.org, alexandre.torgue@st.com, dillonhua@gmail.com,
        daniel@ffwll.ch, linux-spi@vger.kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        sam@ravnborg.org, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com,
        sboyd@kernel.org, broonie@kernel.org, noralf@tronnes.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v6 4/9] dt-bindings: display: panel: Add ilitek ili9341
 panel bindings
Message-ID: <20200529161732.GA2493963@bogus>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
 <1590564453-24499-5-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590564453-24499-5-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 27 May 2020 15:27:28 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Add documentation for "ilitek,ili9341" panel.
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  .../bindings/display/panel/ilitek,ili9341.yaml     | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
