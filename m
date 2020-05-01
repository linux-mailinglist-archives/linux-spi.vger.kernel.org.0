Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69801C1F7D
	for <lists+linux-spi@lfdr.de>; Fri,  1 May 2020 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEAVTt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 May 2020 17:19:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34813 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVTs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 May 2020 17:19:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id x10so935064oie.1;
        Fri, 01 May 2020 14:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=crzBmsIsSrF0UoLH+UgR+Of2XRbChFVf5iuJUQuRNxo=;
        b=lW8fkphGMQ69a5LS+tZtsC51TzmXNJ3PR+usexkdsTfH8xHxVAsprUlJPGQQQZEMWh
         LaiFw/5jopSjT+f639Isi2x5HE+256GHALJYAR5fs3lykr4sBOuwLeu0r8/jX7OEqVN0
         SPMF2cr4QKYDXswP+ukgE8unxmncy+r4/dVNflc1c5zcqRHZ50DwjXQsE//RnsLK2M81
         pRV83kiaaKIc4jZINhCYKV0r8wV+6N3adv552BraWGLlS/Vvr2s8EehWR+gX8kQV/mox
         8+sM4XU5+ZY1f2i4/DZGxS2mGFzsxDRdwxC26o11V5R7+3MwA8kcM5q/0HAUDHS8SaiT
         H6Ig==
X-Gm-Message-State: AGi0PuZ0lFTn9PgorqvuVDBjf+kzTIZTwG2UwdBXyU1I1XuUtPIJTky9
        adrMiyBjlbmj1upp927sDw==
X-Google-Smtp-Source: APiQypJyxKTCOC0q+T2e+uyYjq0smnGrUDFPHMmNnjCSHqy03XQsqFpyN9Wp7gNlZ9Mv+SorNjjJFA==
X-Received: by 2002:aca:b8c5:: with SMTP id i188mr1187592oif.2.1588367986405;
        Fri, 01 May 2020 14:19:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z75sm260692oia.22.2020.05.01.14.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:19:45 -0700 (PDT)
Received: (nullmailer pid 15593 invoked by uid 1000);
        Fri, 01 May 2020 21:19:45 -0000
Date:   Fri, 1 May 2020 16:19:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: document Renesas RPC-IF
 bindings
Message-ID: <20200501211945.GA15294@bogus>
References: <812e6e58-d13f-3f44-5f55-22266b690c57@cogentembedded.com>
 <116683d1-d402-4d7f-3357-1c8cde807076@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116683d1-d402-4d7f-3357-1c8cde807076@cogentembedded.com>
Content-Language: en-MW
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 30 Apr 2020 23:47:25 +0300, Sergei Shtylyov wrote:
> Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
> HyperFlash connected to the SoC to be accessed via the external address
> space read mode or the manual mode.
> 
> Document the device tree bindings for the Renesas RPC-IF found in the R-Car
> gen3 SoCs.
> 
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> Changes in version 2:
> - rewrote the bindings in YAML.
> 
>  Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml |   88 ++++++++++
>  1 file changed, 88 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml:  while scanning a simple key
  in "<unicode string>", line 29, column 9
could not find expected ':'
  in "<unicode string>", line 30, column 1
Documentation/devicetree/bindings/Makefile:11: recipe for target 'Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml: ignoring, error parsing file
warning: no schema found in file: Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml: ignoring, error parsing file
warning: no schema found in file: Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1280942

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
