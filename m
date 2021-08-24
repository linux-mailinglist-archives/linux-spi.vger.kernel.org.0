Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752883F641E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbhHXRAx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 13:00:53 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:35622 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbhHXQ7m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 12:59:42 -0400
Received: by mail-oo1-f43.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so6716403ooc.2;
        Tue, 24 Aug 2021 09:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ff9JKUI/YKVZ1f9QB3+ggQG4cbY+edkZDleJXyfV8CI=;
        b=UfRtpKu7f6MWUALctxzeuzf/0SBCRAbsVDELmNyq9HqQMLp5RL0/mmzYMq982AjAYR
         jRiMrWG6+61yLBSnLX0mV5N3T7jgfKX5OLnWoftN/hjE2Im5ExIXK4jLrOLYNYgYs0iO
         uoMChHRsksQ7to3rv/s4d79nql4WmSN062b0wzGqGmmqig3RzmeHTw+wEjLJrPrC4QDN
         CTdVBZjOu5iiToM+BpnfVARlQEk4C4tcEUlZCJ+UpZQzNIoUIQKPYqYBwi8kDXtI5mM+
         nzR9pufH2Fm00mEHjeMJ2rrPfwuEwLCdP43l11WkJo5J85oRLjm8xhEcSmmsLnByXlHS
         WLjA==
X-Gm-Message-State: AOAM532JNuSthYGSOez2k43Ma6MTIc+7EMM3dge8duAn0hQgNG4pAhh1
        85oqnlPAmGVnlRbyKn0LzQ==
X-Google-Smtp-Source: ABdhPJwYumjG9VNceksmJBMvBD1W4nsmUqiq3U/CYXDeBtKUEVseR8qOkTVNr93EahjSAidk1/Uxww==
X-Received: by 2002:a4a:b481:: with SMTP id b1mr30805640ooo.79.1629824337981;
        Tue, 24 Aug 2021 09:58:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l67sm4667332otl.3.2021.08.24.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:58:57 -0700 (PDT)
Received: (nullmailer pid 626496 invoked by uid 1000);
        Tue, 24 Aug 2021 16:58:56 -0000
Date:   Tue, 24 Aug 2021 11:58:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     nandhini.srikandan@intel.com
Cc:     furong.zhou@intel.com, devicetree@vger.kernel.org,
        rashmi.a@intel.com, mgross@linux.intel.com, robh+dt@kernel.org,
        mahesh.r.vaidya@intel.com, broonie@kernel.org,
        mallikarjunappa.sangannavar@intel.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        kenchappa.demakkanavar@intel.com, fancer.lancer@gmail.com,
        kris.pan@intel.com
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add bindings for Intel Thunder
 Bay SoC
Message-ID: <YSUlUDQEB/5sNCRQ@robh.at.kernel.org>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
 <20210824085856.12714-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824085856.12714-2-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 24 Aug 2021 16:58:55 +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add documentation for SPI controller in Intel Thunder Bay SoC.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
