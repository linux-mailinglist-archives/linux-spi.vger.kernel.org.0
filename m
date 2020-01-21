Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C765A1443DD
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2020 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgAUSCB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jan 2020 13:02:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34423 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSCA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jan 2020 13:02:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so3452526oig.1;
        Tue, 21 Jan 2020 10:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6/QK3q9NCXm+bnCLIspTgs5FXLWf1OX2s+9532Imp1Q=;
        b=lNEhaJ0iu0GREHNynfcbm6/n1jXIdrdYOXjKlG9A7bWAf31fpW4r8Zu2q/lFgoRDG3
         IeBGz68x5tlbfXsZWO7jb7BOZTiwlpkCIqz9ixX6B8vJeAwjDz7Ff/5UBeYw7UtVBodw
         a0mrp1YD4B++wbWF4CQLrgTUHyO6o38aVjesZLzwBLr9eVB/dNdYaht1Kb12CGTJhLqm
         u67cRGAbLGxzgAzs/bTTFUXd0f4I7ynDG/pxD6//rp7bBg3LwRIf2asObf4BnxCz7SjD
         Et+amYMZGUDhARIO04zUsazAQ6ly61s7odLSJTLAS80Vwn9lMYyv/XWfE/+BFLspYJij
         5AmQ==
X-Gm-Message-State: APjAAAW7xRFEQv7tiS4GooPu+lRhaPio+y6RI9nwNsDiWFYnn3kXeVHr
        28LIKbVRZ2C2SMJhkCIs0w==
X-Google-Smtp-Source: APXvYqxDXrKf5Kwy/DOlvRO4xmWfgKDz7oKWNV+bJKDYSK9C+HDRXw27pcPVs5UUIatIALYzQ2/QyQ==
X-Received: by 2002:aca:3cd7:: with SMTP id j206mr2460188oia.142.1579629719880;
        Tue, 21 Jan 2020 10:01:59 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y13sm13663899otk.40.2020.01.21.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:01:59 -0800 (PST)
Received: (nullmailer pid 3058 invoked by uid 1000);
        Tue, 21 Jan 2020 18:01:58 -0000
Date:   Tue, 21 Jan 2020 12:01:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Kociolek <konrad@cadence.com>
Cc:     Konrad Kociolek <konrad@cadence.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: Add dt-bindings schema for Cadence XSPI
 controller driver
Message-ID: <20200121180158.GA2461@bogus>
References: <20200120125443.9523-1-konrad@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120125443.9523-1-konrad@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 20 Jan 2020 13:54:31 +0100, Konrad Kociolek wrote:
> Add dt-bindings documentation for Cadence XSPI controller to support
> SPI based flash memories.
> 
> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 164 +++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/spi/cdns,xspi.yaml: $id: path/filename 'spi/cadence,xspi.yaml' doesn't match actual filename
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/spi/cdns,xspi.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/spi/cdns,xspi.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1225933
Please check and re-submit.
