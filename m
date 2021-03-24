Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E261D347C81
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhCXPY3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 11:24:29 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:36776 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbhCXPYW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 11:24:22 -0400
Received: by mail-io1-f47.google.com with SMTP id f19so21885034ion.3;
        Wed, 24 Mar 2021 08:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJpC2MZwi/VFGACeEB2Ckj+pwrKraPsGvjmxzCvXaRw=;
        b=Xf49N3QmaplgyRfVXbc9NN118pbpL5WrafXRZYxNjETeS04Rz8dY4xjrbLXIzJDaMy
         lpwhRGndiloGuM80VhyRCV6f8L42oLEJSa81kNRIr2kjMoklDYNlCh67p2AxR9DHUvKM
         vTyu8WlqjaWCqUDnIKtTuzIDaMASjPaHVq17+aL1f1lstETb2rDJrbA8aDjbQ9RO7rfX
         F1M4igB7cfWLyUcxdq2vFRYlAYXZuOBBvPxf1F6PxyQJK1E47KNj7jf5e3tmRyvb0YvQ
         yK7Wsf6XLyg2jv98bdToCpWh2zPCXJm9i7R8UfRk/iUn8HtMSt3gWaHfrXoNfowKlnvc
         cmlw==
X-Gm-Message-State: AOAM530VonUk4VO84APAcBumEISeT9AUqX8ueJ1qzA+7XgIeyvRWDAKY
        b9dyauHymlS3mVoUxDxfcR67SOC5Uw==
X-Google-Smtp-Source: ABdhPJwzSuQ0re3pZYfxdtwoCFiNc5BPsomX/MiOOicsyObH/pPuv4FSaIymMN4gfJH5w9DGgAoP2g==
X-Received: by 2002:a6b:103:: with SMTP id 3mr2945697iob.98.1616599462025;
        Wed, 24 Mar 2021 08:24:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u15sm1282919ilb.62.2021.03.24.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:24:21 -0700 (PDT)
Received: (nullmailer pid 3093719 invoked by uid 1000);
        Wed, 24 Mar 2021 15:24:20 -0000
Date:   Wed, 24 Mar 2021 09:24:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale QSPI binding to json
 schema
Message-ID: <20210324152420.GA3093662@robh.at.kernel.org>
References: <20210312054038.3586706-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312054038.3586706-1-kuldeep.singh@nxp.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 12 Mar 2021 11:10:38 +0530, Kuldeep Singh wrote:
> Convert the Freescale QSPI binding to DT schema format using json-schema.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
>  .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 96 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-fsl-qspi.txt  | 66 -------------
>  MAINTAINERS                                   |  1 +
>  3 files changed, 97 insertions(+), 66 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
