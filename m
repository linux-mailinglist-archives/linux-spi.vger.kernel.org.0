Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A395131739F
	for <lists+linux-spi@lfdr.de>; Wed, 10 Feb 2021 23:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhBJWqm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Feb 2021 17:46:42 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33643 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBJWql (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Feb 2021 17:46:41 -0500
Received: by mail-ot1-f51.google.com with SMTP id c16so3468464otp.0;
        Wed, 10 Feb 2021 14:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rt+gwj5IL0E6ocrhypHF62IUtRKF/oja1ySIwkJmpx0=;
        b=uFHBkWTYnZDzWdJX4uIu8cxFDRuvSAVbQEFzBI4bfe7YlThAtIQiuXkNo9qyVE0iFp
         RokikZu+iqRGn5Gxd3+BRjmgeyrLOFyFQg3cU4Ghxi9gFFQsvsBO41+QXmS7UEWmrJMB
         47tbntk5m/qasEBUL+mEiR8G1OQR9roKm9gEViRszxoFHQhRuFKpooybx/p2pRGzV0oV
         UOZ7M8ipbpF32cQteAzzj7++Q6az7tdnWBmOK1z+TiUtTP56NL+ygFYbTpxo0vhW2vkQ
         Qg3UZG7ZKLAQCPU3u+ygmh5ScucXYE1yhWABjuP5BwBOOVdZNnxbAyK7vrpd8yBTfWKG
         dSKA==
X-Gm-Message-State: AOAM531mt9g9AoBY7ZmwMMpBuCCXX0wSw/L9vsK1NshAiBX+0WlszlW6
        j4n3zHHWoqvZKCy0ROAkHQ==
X-Google-Smtp-Source: ABdhPJwtpPcGW6T86iIO2MMcIJ1Zb0FpZxrT3asYjxFDY4ULaEzsendz5b5H6D4IorEe/V5Emt2KgQ==
X-Received: by 2002:a9d:4e2:: with SMTP id 89mr3838108otm.140.1612997160165;
        Wed, 10 Feb 2021 14:46:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k23sm754137oik.4.2021.02.10.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:45:59 -0800 (PST)
Received: (nullmailer pid 2953009 invoked by uid 1000);
        Wed, 10 Feb 2021 22:45:58 -0000
Date:   Wed, 10 Feb 2021 16:45:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        monstr@monstr.eu, git@xilinx.com, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: spi: zynq: Convert Zynq QSPI binding to
 yaml
Message-ID: <20210210224558.GA2952953@robh.at.kernel.org>
References: <4ece21a7e9691ed1e775fd6b0b4046b1562e44bd.1612951821.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ece21a7e9691ed1e775fd6b0b4046b1562e44bd.1612951821.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 10 Feb 2021 11:10:25 +0100, Michal Simek wrote:
> Convert spi-zynq-qspi.txt to yaml.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - s/additionalProperties: true/unevaluatedProperties: false/
> 
>  .../devicetree/bindings/spi/spi-zynq-qspi.txt | 25 --------
>  .../bindings/spi/xlnx,zynq-qspi.yaml          | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 60 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
