Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CFE3F79CA
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhHYQGA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 12:06:00 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42982 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbhHYQF6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 12:05:58 -0400
Received: by mail-oi1-f176.google.com with SMTP id t35so8421oiw.9;
        Wed, 25 Aug 2021 09:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IqpEITfkV4Wt3cISCrksmZlI+boyCTVaH8b3BA4buIg=;
        b=cjbUkgkMUI6Bq7zZaUwzWTT+1pucBFioL1BMW4OIBrntzg8UMAfNFFZ8TraWnmMhuQ
         8symo8BszlsafiCoL1lTOMOhb4ZbFV19JirWYOrQmPRYxl1TitUBCQW9kbIelkzpKR+f
         XByTSN6TH2zQiKrsoOlLRJDYSFD7bYpBZzZ6Yhel2ctM+XmTl85j+bK07+sm8vxrvjfz
         1vqChOT+Ucvf0IzcPvH/tyOjjeXcJFvzBsMY4/IDTg13MyHXCRx15rIYjRe59qXdv/qX
         s6xjn0KfQCHuyLsfuDADwFsRNpv+/grNZPpGSaf0XPkYaFGccjKKBiDeLz/NJNPmtZym
         VYpQ==
X-Gm-Message-State: AOAM5305zRnpxJBeTKxQB3wvj1BqfmVEmyeH74GV84RgxYcs4ZX21C40
        nJNh7zQNEgNIO2QAhOueHA==
X-Google-Smtp-Source: ABdhPJzCPpYtm6/iGvl+r1ybnHX0Bv8WDdpUA/RqvixAyG6vfBXb37UAinwFxeulWsgm+g8poW8cog==
X-Received: by 2002:aca:918:: with SMTP id 24mr7613654oij.58.1629907512282;
        Wed, 25 Aug 2021 09:05:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s198sm44906oie.47.2021.08.25.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:05:11 -0700 (PDT)
Received: (nullmailer pid 2870703 invoked by uid 1000);
        Wed, 25 Aug 2021 16:05:10 -0000
Date:   Wed, 25 Aug 2021 11:05:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>, linux-spi@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Luting Guo <luting.guo@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2 2/3] dt-bindings: spi: Convert sprd ADI bindings to
 yaml
Message-ID: <YSZqNsnvtIfhLbOT@robh.at.kernel.org>
References: <20210825065931.2111159-1-zhang.lyra@gmail.com>
 <20210825065931.2111159-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825065931.2111159-3-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 25 Aug 2021 14:59:30 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Convert spi-sprd-adi.txt to yaml.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/spi/spi-sprd-adi.txt  |  63 -----------
>  .../devicetree/bindings/spi/sprd,spi-adi.yaml | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
