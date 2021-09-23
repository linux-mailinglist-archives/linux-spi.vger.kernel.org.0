Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68EA415E8C
	for <lists+linux-spi@lfdr.de>; Thu, 23 Sep 2021 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbhIWMmT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Sep 2021 08:42:19 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33433 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241138AbhIWMlj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Sep 2021 08:41:39 -0400
Received: by mail-oi1-f178.google.com with SMTP id 24so9549729oix.0;
        Thu, 23 Sep 2021 05:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WYkrVIwTVfi0B/G+QlIDJ19fU254VtZt4fJs98aiwMk=;
        b=UcCeFH3kukwvGMNgyMbDQXRI/C+hy9obhaVjv5xFtHmBNfo1NyRFeJjOv0N6hyc5ZK
         Q3u+gNtEPECX9fcfy4LAEEKsbHi9RjEaJI3ZaOK49y7eCOgfZ4XJ1lZgV/USzdP8eT9Q
         vKkdJB3Q0BLEkL0M1Z9So89hKwveytwRxZPa+ivlQT4ocYW1VjHK7N+4oYROH174ah8N
         rVi2IPUWgnmML72Wo20UCwNdm90WFoIZ0NGmO0k/PnWb4ezb7P0ALIfdbRPvlaO2WHJU
         aTJPg1Xd/gPePvZVOsh8GkmRp7VKw9tuxGOqUYSWiHuO+boxy8+8nmn1uTSCIbPO2sfE
         c/pA==
X-Gm-Message-State: AOAM530ii/+VMj8SK3eAialicSnskyVapTrc2e+Nv9v4ScX88EY5Rr2F
        2TufGyV9kVTZE1MS2c1gyMgbt5yAQg==
X-Google-Smtp-Source: ABdhPJzCbTvqWS/umEcE/Qmf3EqDkOoOWsc61D+8vG4fpK4P3YOBwib0gVA3vwjTgMEp3J3d8sZwxg==
X-Received: by 2002:a54:4489:: with SMTP id v9mr12255483oiv.148.1632400807398;
        Thu, 23 Sep 2021 05:40:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i25sm1291459otf.31.2021.09.23.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 05:40:06 -0700 (PDT)
Received: (nullmailer pid 2814913 invoked by uid 1000);
        Thu, 23 Sep 2021 12:40:04 -0000
Date:   Thu, 23 Sep 2021 07:40:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     broonie@kernel.org, lukas@wunner.de, linux-spi@vger.kernel.org,
        jpawar@cadence.com, robh+dt@kernel.org,
        Konrad Kociolek <konrad@cadence.com>,
        linux-kernel@vger.kernel.org, mparab@cadence.com, p.yadav@ti.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Message-ID: <YUx1pLA/QZ6VrD0c@robh.at.kernel.org>
References: <1632038668-23756-1-git-send-email-pthombar@cadence.com>
 <1632038705-23805-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632038705-23805-1-git-send-email-pthombar@cadence.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 19 Sep 2021 10:05:05 +0200, Parshuram Thombare wrote:
> Add DT binding for Cadence's XSPI controller driver.
> 
> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
